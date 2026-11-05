-- Runs one 1v1 / 2v2 match in the Arena place. Only ever required when PlaceRole.IsArena(),
-- so none of this runs in Demon Fruits. Started by ServerScriptService.Arena.ArenaServer.
--
-- Phases (workspace attribute ArenaPhase):
--   Loading   -> wait for the Lobby's match record and for every player to load (LoadTimeout)
--   Select    -> frozen at spawns, pick a character from the Characters menu (SelectSeconds)
--   Countdown -> 3, 2, 1
--   Fight     -> 3 lives each, respawn after RespawnDelay, last team with lives wins
--   Results   -> rating + gold paid, results screen, everyone teleported back to the Lobby
--   Cancelled -> someone never arrived or left before the fight; nobody gains or loses rating
--
-- Hooks called by existing scripts (all guarded by `if ArenaMatch then`):
--   DamageHandler:TakeDamage  -> ArenaMatch.CanDamage / ArenaMatch.OnDamage
--   NewCombatSystem ChooseCharacter -> ArenaMatch.CanChooseCharacter / ArenaMatch.BeforeCharacterSwap
--   DataInit PlayerRemoving   -> ArenaMatch.OnPlayerRemoving (before the profile session ends)
--
-- Match record the Lobby must write (MemoryStore hash map Config.MatchStore, key = the reserved
-- server's PrivateServerId, expiry ~10 minutes):
--   { MatchId = "<guid>", Queue = "Ranked1v1" | "Casual1v1" | "Ranked2v2" | "Casual2v2",
--     Friendly = false, Teams = { { userId, ... }, { userId, ... } } }

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MemoryStoreService = game:GetService("MemoryStoreService")
local DataStoreService = game:GetService("DataStoreService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

local Ranked = ReplicatedStorage:WaitForChild("Ranked")
local Config = require(Ranked.Config)
local Season = require(Ranked.Season)
local Elo = require(Ranked.Elo)
local PlaceRole = require(Ranked.PlaceRole)
local DataManager = require(ServerScriptService.Data.DataManager)
local MapLoader = require(script.Parent.ArenaMapLoader)

local A = Config.Arena
local R = Config.Rewards
local IsStudio = RunService:IsStudio()
local MatchState: RemoteEvent = Ranked.Remotes.MatchState
local Notify: RemoteEvent = ReplicatedStorage.Remotes.Comunicator.Set

local ArenaMatch = {}
ArenaMatch.Phase = "Loading"

local Record = nil -- the match record (see top)
local Size = "1v1" -- "1v1" | "2v2"
local IsRanked = false
local Participants = {} -- [userId] = participant (see newParticipant)
local FightStartedAt = 0
local Finished = false -- Results or Cancelled reached
local ShuttingDown = false
local EndCheckScheduled = false
local Started = false

------------------------------------------------------------------------
-- Helpers
------------------------------------------------------------------------

local function now(): number
	return os.clock()
end

local function notify(player: Player?, text: string, seconds: number?)
	if player and player.Parent then
		Notify:FireClient(player, "SendNotification", { Title = "ARENA", Text = text, Time = seconds or 4 })
	end
end

local function notifyAll(text: string, seconds: number?)
	for _, p in Participants do
		notify(p.Player, text, seconds)
	end
end

local function newParticipant(userId: number, team: number, slot: number)
	return {
		UserId = userId,
		Name = "Player",
		Team = team,
		Slot = slot,
		Player = nil :: Player?,
		Lives = A.Lives,
		Kills = 0,
		Deaths = 0,
		Damage = 0,
		KillGold = 0, -- earned during the fight, paid at the end
		PaidKills = 0,
		RatingBefore = Config.StartRating,
		Loaded = false,
		Gone = false,
		LeaveReason = nil :: string?, -- "Left" | "AFK"
		Result = nil, -- filled once this player is settled
		LastDamager = nil :: number?,
		LastDamagedAt = -math.huge,
		LastActive = now(),
		LastPos = nil :: Vector3?,
		AfkWarned = false,
		ProtectedUntil = 0,
	}
end

local function teamMembers(team: number)
	local list = {}
	for _, p in Participants do
		if p.Team == team then
			table.insert(list, p)
		end
	end
	table.sort(list, function(a, b)
		return a.Slot < b.Slot
	end)
	return list
end

local function teamCanFight(team: number): boolean
	for _, p in teamMembers(team) do
		if not p.Gone and p.Lives > 0 then
			return true
		end
	end
	return false
end

local function teamPresent(team: number): boolean
	for _, p in teamMembers(team) do
		if not p.Gone and p.Player and p.Player.Parent then
			return true
		end
	end
	return false
end

local function teamAverage(team: number): number
	local members = teamMembers(team)
	if #members == 0 then
		return Config.StartRating
	end
	local total = 0
	for _, p in members do
		total += p.RatingBefore
	end
	return total / #members
end

local function setPhase(phase: string, seconds: number?)
	ArenaMatch.Phase = phase
	workspace:SetAttribute("ArenaPhase", phase)
	workspace:SetAttribute("ArenaPhaseEnds", if seconds then workspace:GetServerTimeNow() + seconds else 0)
end

-- Everything the HUD needs, as one replicated attribute (no join-order races).
local function publishRoster()
	local list = {}
	for _, p in Participants do
		table.insert(list, {
			UserId = p.UserId,
			Name = p.Name,
			Team = p.Team,
			Slot = p.Slot,
			Lives = p.Lives,
			Kills = p.Kills,
			Deaths = p.Deaths,
			Gone = p.Gone,
			Loaded = p.Loaded,
		})
	end
	workspace:SetAttribute("ArenaRoster", HttpService:JSONEncode(list))
end

local function arenaFolder(): Instance?
	local world = workspace:FindFirstChild("World")
	return world and world:FindFirstChild("Arena")
end

local function spawnCFrame(p): CFrame
	local arena = arenaFolder()
	local spawns = arena and arena:FindFirstChild("Spawns")
	local part = spawns
		and (spawns:FindFirstChild(("Team%d_%d"):format(p.Team, p.Slot)) or spawns:FindFirstChild(("Team%d_1"):format(p.Team)))
	local position = if part then part.Position else Vector3.new(0, 12, p.Team == 1 and 80 or -80)
	position += Vector3.new(0, 3, 0)
	return CFrame.lookAt(position, Vector3.new(0, position.Y, 0))
end

local function rootOf(player: Player?): BasePart?
	local character = player and player.Character
	return character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
end

local function humanoidOf(player: Player?): Humanoid?
	local character = player and player.Character
	return character and character:FindFirstChildOfClass("Humanoid")
end

local function setFrozen(player: Player?, frozen: boolean)
	local root = rootOf(player)
	if root then
		root.Anchored = frozen
	end
end

local function setShield(player: Player?, on: boolean)
	local character = player and player.Character
	if not character then
		return
	end
	local shield = character:FindFirstChild("ArenaShield")
	if on and not shield then
		shield = Instance.new("ForceField")
		shield.Name = "ArenaShield"
		shield.Visible = false
		shield.Parent = character
	elseif not on and shield then
		shield:Destroy()
	end
end

local function protect(p, seconds: number)
	p.ProtectedUntil = now() + seconds
	setShield(p.Player, true)
	local untilTime = p.ProtectedUntil
	task.delay(seconds, function()
		if p.ProtectedUntil == untilTime and ArenaMatch.Phase == "Fight" then
			setShield(p.Player, false)
		end
	end)
end

local function isAdminCharacter(name: any): boolean
	local characters = ServerScriptService:FindFirstChild("Systems")
	characters = characters and characters:FindFirstChild("Characters")
	local module = characters and type(name) == "string" and characters:FindFirstChild(name)
	if not module then
		return false
	end
	local ok, info = pcall(require, module)
	return ok and type(info) == "table" and info.IsAdmin == true
end

local function hasVip(profile): boolean
	local passes = profile and profile.Data.Gamepasses
	local pass = passes and passes[Config.VipGamepassId]
	return pass ~= nil and pass.owned == true
end

------------------------------------------------------------------------
-- Teleporting back
------------------------------------------------------------------------

local TeleportTries = {}

local function sendToLobby(list: { Player })
	list = table.clone(list)
	for i = #list, 1, -1 do
		if not list[i].Parent then
			table.remove(list, i)
		end
	end
	if #list == 0 then
		return
	end
	if IsStudio then
		local names = {}
		for _, player in list do
			table.insert(names, player.Name)
		end
		print("[Arena] (Studio) would teleport to the Lobby:", table.concat(names, ", "))
		return
	end
	for attempt = 1, 3 do
		local ok, err = pcall(function()
			TeleportService:TeleportAsync(Config.PlaceIds.Lobby, list)
		end)
		if ok then
			return
		end
		warn("[Arena] Teleport to Lobby failed:", err)
		task.wait(2 * attempt)
	end
	for _, player in list do
		if player.Parent then
			player:Kick("Couldn't send you back to the Lobby. Please rejoin.")
		end
	end
end

TeleportService.TeleportInitFailed:Connect(function(player: Player, result, message)
	if not Finished then
		return
	end
	TeleportTries[player] = (TeleportTries[player] or 0) + 1
	if TeleportTries[player] > 3 then
		player:Kick("Couldn't send you back to the Lobby. Please rejoin.")
		return
	end
	warn("[Arena] Teleport failed for", player.Name, result, message)
	task.wait(2)
	sendToLobby({ player })
end)

local function sendEveryoneToLobby()
	sendToLobby(Players:GetPlayers())
	-- anyone still here after 30 s gets kicked so the reserved server can close
	if not IsStudio then
		task.delay(30, function()
			for _, player in Players:GetPlayers() do
				player:Kick("The match is over. Rejoin to play again.")
			end
		end)
	end
end

------------------------------------------------------------------------
-- Rating and rewards
------------------------------------------------------------------------

local function leaderboardStore()
	local name = Config.LeaderboardStores[Size]
	return DataStoreService:GetOrderedDataStore(name .. (if IsStudio then "_Test" else ""))
end

local function kFactor(ranked): number
	local season = ranked["Played" .. Size] or 0
	local lifetime = Season.LifetimePlayed(ranked, Size)
	if lifetime < A.PlacementLifetimeMatches or season < A.PlacementSeasonMatches then
		return A.PlacementKFactor
	end
	return A.KFactor
end

local function writeRating(player: Player, ranked)
	local rating = ranked["Rating" .. Size]
	player:SetAttribute("Rating" .. Size, rating)
	player:SetAttribute("Tier" .. Size, Config.GetTier(rating))
	task.spawn(function()
		local ok, err = pcall(function()
			leaderboardStore():SetAsync(tostring(player.UserId), rating)
		end)
		if not ok then
			warn("[Arena] Leaderboard write failed:", err)
		end
	end)
end

-- Opponents key for the "same opponents" limit, e.g. "123-456".
local function opponentsKey(p): string
	local ids = {}
	for _, other in teamMembers(3 - p.Team) do
		table.insert(ids, other.UserId)
	end
	table.sort(ids)
	return table.concat(ids, "-")
end

-- Returns gold paid and the reasons for anything held back.
local function payGold(p, player: Player, profile, won: boolean)
	local notes = {}
	local ranked = profile.Data.Ranked

	if p.LeaveReason then
		return 0, { if p.LeaveReason == "AFK" then "Removed for being AFK: no gold" else "Left the match: no gold" }
	end
	local multiplier = if Record.Friendly then R.FriendlyMultiplier elseif IsRanked then 1 else R.CasualMultiplier
	if multiplier <= 0 then
		return 0, { "Friend duels pay no gold" }
	end
	if p.Damage < R.MinDamageForGold then
		return 0, { ("Deal at least %d damage to earn gold"):format(R.MinDamageForGold) }
	end

	-- same opponents more than SameOpponentsPerHour times in an hour pays nothing
	ranked.ArenaOpponents = ranked.ArenaOpponents or {}
	local key = opponentsKey(p)
	local stamp = os.time()
	local recent = {}
	for _, t in ranked.ArenaOpponents[key] or {} do
		if stamp - t < 3600 then
			table.insert(recent, t)
		end
	end
	for otherKey, list in ranked.ArenaOpponents do -- drop old entries so the table stays small
		local fresh = false
		for _, t in list do
			if stamp - t < 3600 then
				fresh = true
			end
		end
		if not fresh then
			ranked.ArenaOpponents[otherKey] = nil
		end
	end
	if #recent >= R.SameOpponentsPerHour then
		ranked.ArenaOpponents[key] = recent
		return 0, { "Same opponents too often this hour: no gold" }
	end
	table.insert(recent, stamp)
	ranked.ArenaOpponents[key] = recent

	local gold = p.KillGold
	if won then
		if now() - FightStartedAt >= R.MinFightSecondsForWinGold then
			gold += R.WinGold
		else
			table.insert(notes, "Fight too short for win gold")
		end
	else
		gold += R.LossGold
	end
	gold = math.floor(gold * multiplier)

	local today = os.date("!%Y-%m-%d")
	if ranked.ArenaGoldDay ~= today then
		ranked.ArenaGoldDay = today
		ranked.ArenaGoldToday = 0
	end
	local room = math.max(0, R.DailyCap - (ranked.ArenaGoldToday or 0))
	if gold > room then
		gold = room
		table.insert(notes, "Daily arena gold limit reached")
	end
	ranked.ArenaGoldToday = (ranked.ArenaGoldToday or 0) + gold

	if gold > 0 then
		DataManager.addGold(player, gold)
	end

	-- kills only count when the match was eligible for gold (same anti-farm rules)
	if p.PaidKills > 0 then
		if A.CountTotalKills then
			DataManager.addTotalKill(player, p.PaidKills)
		end
		if A.CountMonthlyKills then
			DataManager.addMonthlyKill(player, p.PaidKills)
		end
	end

	return gold, notes
end

-- Applies one player's result exactly once. Never yields (it runs inside PlayerRemoving).
local function settle(p, won: boolean)
	if p.Result then
		return p.Result
	end
	local result = {
		Won = won,
		EloBefore = p.RatingBefore,
		EloAfter = p.RatingBefore,
		EloDelta = 0,
		Gold = 0,
		Notes = {},
	}
	p.Result = result

	local player = p.Player
	local profile = player and DataManager.Profiles[player]
	if not profile or not profile.Data.Ranked then
		table.insert(result.Notes, "Your data wasn't loaded; nothing was saved")
		return result
	end
	local ranked = profile.Data.Ranked
	Season.Apply(ranked)

	if IsRanked and ranked.LastMatchId ~= Record.MatchId then
		local delta = Elo.Delta(teamAverage(p.Team), teamAverage(3 - p.Team), if won then 1 else 0, kFactor(ranked))
		local before = ranked["Rating" .. Size]
		local after = math.max(0, before + delta)
		ranked["Rating" .. Size] = after
		ranked["Peak" .. Size] = math.max(ranked["Peak" .. Size] or after, after)
		ranked["Played" .. Size] += 1
		if won then
			ranked["Wins" .. Size] += 1
		end
		ranked.LastMatchId = Record.MatchId
		result.EloBefore, result.EloAfter, result.EloDelta = before, after, after - before
		writeRating(player, ranked)
	end

	local gold, notes = payGold(p, player, profile, won)
	result.Gold = gold
	for _, note in notes do
		table.insert(result.Notes, note)
	end
	return result
end

-- Ranked only: leaving before the fight starts costs DodgePenalty and nothing else.
local function dodge(p)
	if not IsRanked or p.Result then
		return
	end
	p.Result = { Won = false, EloBefore = p.RatingBefore, EloAfter = p.RatingBefore, EloDelta = 0, Gold = 0, Notes = { "Dodged" } }
	local player = p.Player
	local profile = player and DataManager.Profiles[player]
	if not profile or not profile.Data.Ranked then
		return
	end
	local ranked = profile.Data.Ranked
	Season.Apply(ranked)
	if ranked.LastMatchId == Record.MatchId then
		return
	end
	local before = ranked["Rating" .. Size]
	ranked["Rating" .. Size] = math.max(0, before - A.DodgePenalty)
	ranked.LastMatchId = Record.MatchId
	p.Result.EloBefore, p.Result.EloAfter, p.Result.EloDelta = before, ranked["Rating" .. Size], -A.DodgePenalty
	writeRating(player, ranked)
end

------------------------------------------------------------------------
-- Ending
------------------------------------------------------------------------

local function removeRecord()
	if Record and not Record.Studio then
		task.spawn(function()
			pcall(function()
				MemoryStoreService:GetHashMap(Config.MatchStore):RemoveAsync(game.PrivateServerId)
			end)
		end)
	end
end

local function freezeEveryone()
	for _, p in Participants do
		if p.Player and p.Player.Parent then
			setShield(p.Player, true)
			setFrozen(p.Player, true)
		end
	end
end

local function cancel(reason: string)
	if Finished then
		return
	end
	Finished = true
	setPhase("Cancelled", 5)
	workspace:SetAttribute("ArenaCancelReason", reason)
	freezeEveryone()
	MatchState:FireAllClients("Cancelled", { Reason = reason })
	removeRecord()
	task.wait(5)
	sendEveryoneToLobby()
end

local function finish(winner: number, reason: string)
	if Finished then
		return
	end
	Finished = true
	setPhase("Results", A.ResultsSeconds)
	freezeEveryone()

	local rows = {}
	for _, p in Participants do
		local result = p.Result or settle(p, p.Team == winner)
		table.insert(rows, {
			UserId = p.UserId,
			Name = p.Name,
			Team = p.Team,
			Kills = p.Kills,
			Deaths = p.Deaths,
			Damage = math.floor(p.Damage),
			Won = p.Team == winner,
			Left = p.LeaveReason,
			EloBefore = result.EloBefore,
			EloAfter = result.EloAfter,
			EloDelta = result.EloDelta,
			Gold = result.Gold,
			Notes = result.Notes,
		})
	end
	publishRoster()
	MatchState:FireAllClients("Results", {
		Winner = winner,
		Reason = reason,
		Ranked = IsRanked,
		Queue = Record.Queue,
		Size = Size,
		FightSeconds = math.floor(now() - FightStartedAt),
		Players = rows,
	})
	removeRecord()
	task.wait(A.ResultsSeconds)
	sendEveryoneToLobby()
end

local respawn -- forward declaration

-- Called whenever someone may have run out of lives. Waits SuddenDeathWindow so two
-- last deaths in the same instant become sudden death instead of a coin flip.
local function checkForEnd()
	if Finished or ArenaMatch.Phase ~= "Fight" or EndCheckScheduled then
		return
	end
	local oneDown = not teamCanFight(1) or (not Record.Solo and not teamCanFight(2))
	if not oneDown then
		return
	end
	EndCheckScheduled = true
	task.delay(A.SuddenDeathWindow, function()
		EndCheckScheduled = false
		if Finished then
			return
		end
		local alive1 = teamCanFight(1)
		local alive2 = Record.Solo or teamCanFight(2)
		if alive1 and alive2 then
			return
		end
		if not alive1 and not alive2 then
			-- both teams lost their last life together: sudden death, one life each
			if teamPresent(1) and teamPresent(2) then
				notifyAll("SUDDEN DEATH! One life each.", 4)
				for _, p in Participants do
					if not p.Gone then
						p.Lives = 1
						task.delay(A.RespawnDelay, respawn, p)
					end
				end
				publishRoster()
			else
				local winner = if teamPresent(1) then 1 elseif teamPresent(2) then 2 else 0
				if winner == 0 then
					cancel("Everyone left")
				else
					finish(winner, "Opponents left")
				end
			end
			return
		end
		local winner = if alive1 then 1 else 2
		finish(winner, if teamPresent(3 - winner) then "Out of lives" else "Opponents left")
	end)
end

------------------------------------------------------------------------
-- Characters, deaths and respawns
------------------------------------------------------------------------

local function onDeath(p, character: Model)
	if Finished then
		return
	end
	local phase = ArenaMatch.Phase
	if phase ~= "Fight" then
		-- character swap or reset before the fight: not a life, just put them back
		if phase == "Loading" or phase == "Select" or phase == "Countdown" then
			task.delay(A.SelectRespawnDelay, respawn, p)
		end
		return
	end

	p.Deaths += 1
	p.Lives = math.max(0, p.Lives - 1)

	local killer = p.LastDamager and Participants[p.LastDamager]
	if killer and killer.Team ~= p.Team and now() - p.LastDamagedAt <= A.KillCreditWindow then
		killer.Kills += 1
		local idle = now() - p.LastActive
		if idle >= R.IdleVictimSeconds then
			notify(killer.Player, "Kill on an idle player: no kill gold.")
		else
			local profile = killer.Player and DataManager.Profiles[killer.Player]
			killer.KillGold += if hasVip(profile) then R.KillGoldVIP else R.KillGold
			killer.PaidKills += 1
		end
		MatchState:FireAllClients("Kill", { Killer = killer.UserId, Victim = p.UserId })
	else
		MatchState:FireAllClients("Kill", { Victim = p.UserId })
	end
	p.LastDamager = nil
	publishRoster()

	if p.Lives > 0 then
		task.delay(A.RespawnDelay, respawn, p)
	else
		notify(p.Player, "Out of lives.")
		checkForEnd()
	end
end

local function onCharacterAdded(p, character: Model)
	local humanoid = character:WaitForChild("Humanoid", 10) :: Humanoid?
	local root = character:WaitForChild("HumanoidRootPart", 10) :: BasePart?
	if not humanoid or not root or character.Parent == nil then
		return
	end
	task.wait() -- let DataInit move the character into World.Live.Players first
	character:PivotTo(spawnCFrame(p))
	p.LastActive = now()
	p.LastPos = nil
	p.AfkWarned = false

	if ArenaMatch.Phase == "Fight" then
		protect(p, A.SpawnProtection)
	else
		setShield(p.Player, true)
		root.Anchored = true
	end

	local counted = false
	local function died()
		if counted then
			return
		end
		counted = true
		onDeath(p, character)
	end
	humanoid.HealthChanged:Connect(function(health)
		if health <= 0 then
			died()
		end
	end)
	humanoid.Died:Connect(died)
end

respawn = function(p)
	if Finished or p.Gone or p.Lives <= 0 then
		return
	end
	local player = p.Player
	if not player or not player.Parent then
		return
	end
	local humanoid = humanoidOf(player)
	if humanoid and humanoid.Health > 0 then
		return -- already alive (e.g. sudden death respawn racing a select respawn)
	end
	local ok, err = pcall(player.LoadCharacterAsync, player)
	if not ok then
		warn("[Arena] Respawn failed for", player.Name, err)
	end
end

local function spawnFirstTime(p)
	local player = p.Player
	if not player or not player.Parent then
		return
	end
	-- wait for DataInit to finish loading this player's data (character, moveset, cosmetics)
	local deadline = now() + A.LoadTimeout
	while player.Parent and not player:GetAttribute("Loaded") and now() < deadline do
		task.wait(0.2)
	end
	if not player.Parent or not player:GetAttribute("Loaded") then
		return
	end
	if isAdminCharacter(player:GetAttribute("Character")) then
		player:SetAttribute("Character", "Sanji")
		player:SetAttribute("Moveset", "Sanji")
		local config = player:FindFirstChild("Configuration")
		local moveset = config and config:FindFirstChild("Moveset")
		if moveset then
			moveset.Value = "Sanji"
		end
	end
	local awakening = player:FindFirstChild("AwakeningProgress")
	if awakening then
		awakening.Value = 0
	end
	local profile = DataManager.Profiles[player]
	if profile and profile.Data.Ranked then
		Season.Apply(profile.Data.Ranked)
		p.RatingBefore = profile.Data.Ranked["Rating" .. Size] or Config.StartRating
	end
	if Finished or p.Gone then
		return
	end
	if ArenaMatch.Phase == "Fight" and p.Lives <= 0 then
		return
	end
	local ok, err = pcall(player.LoadCharacterAsync, player)
	if not ok then
		warn("[Arena] Spawn failed for", player.Name, err)
		return
	end
	p.Loaded = true
	publishRoster()
end

local function attach(player: Player)
	if not Record then
		return -- picked up once the record arrives
	end
	local p = Participants[player.UserId]
	if not p and Record.Studio and not Finished and ArenaMatch.Phase == "Loading" then
		-- Studio test match: fill seats in join order (team 1, team 2, team 1, team 2)
		local counts = { #teamMembers(1), #teamMembers(2) }
		local team = if counts[1] <= counts[2] then 1 else 2
		if Record.Solo then
			team = 1
		end
		if counts[team] < Record.TeamSize then
			p = newParticipant(player.UserId, team, counts[team] + 1)
			Participants[player.UserId] = p
			table.insert(Record.Teams[team], player.UserId)
		end
	end
	if not p or p.Gone or p.Result then
		notify(player, "You're not part of this match.")
		task.delay(2, sendToLobby, { player })
		return
	end
	if p.Player == player then
		return
	end
	p.Player = player
	p.Name = player.DisplayName
	player:SetAttribute("ArenaTeam", p.Team)
	player.CharacterAdded:Connect(function(character)
		onCharacterAdded(p, character)
	end)
	publishRoster()
	task.spawn(spawnFirstTime, p)
end

------------------------------------------------------------------------
-- Record
------------------------------------------------------------------------

local function studioRecord()
	local teamSize = math.clamp(tonumber(Ranked:GetAttribute("StudioTestTeamSize")) or 1, 1, 2)
	local ranked = Ranked:GetAttribute("StudioTestRanked") ~= false
	return {
		MatchId = "studio-" .. HttpService:GenerateGUID(false),
		Queue = (if ranked then "Ranked" else "Casual") .. teamSize .. "v" .. teamSize,
		Friendly = false,
		Teams = { {}, {} },
		Studio = true,
		Solo = Ranked:GetAttribute("StudioTestSolo") == true,
	}
end

local function fetchRecord()
	if IsStudio then
		return studioRecord()
	end
	if game.PrivateServerId == "" or game.PrivateServerOwnerId ~= 0 then
		return nil -- someone joined the Arena place directly, not through the Lobby
	end
	local map = MemoryStoreService:GetHashMap(Config.MatchStore)
	local deadline = now() + A.RecordTimeout
	repeat
		local ok, value = pcall(function()
			return map:GetAsync(game.PrivateServerId)
		end)
		if ok and type(value) == "table" then
			return value
		end
		task.wait(1)
	until now() > deadline
	return nil
end

-- Fills in Size/TeamSize from the queue id and checks the teams look right.
local function validRecord(record): boolean
	if type(record) ~= "table" or type(record.Queue) ~= "string" or type(record.Teams) ~= "table" then
		return false
	end
	local queue = Config.Queues[record.Queue]
	if not queue then
		return false
	end
	record.TeamSize = queue.TeamSize
	record.Ranked = queue.Ranked
	record.MatchId = tostring(record.MatchId or game.JobId)
	record.Friendly = record.Friendly == true
	if record.Studio then
		return true
	end
	for team = 1, 2 do
		local ids = record.Teams[team]
		if type(ids) ~= "table" or #ids ~= queue.TeamSize then
			return false
		end
	end
	return true
end

------------------------------------------------------------------------
-- Hooks for existing scripts
------------------------------------------------------------------------

-- DamageHandler:TakeDamage, before anything happens. false = the hit does nothing.
function ArenaMatch.CanDamage(damager: Model, damaged: Model): boolean
	if ArenaMatch.Phase ~= "Fight" or Finished then
		return false
	end
	local attacker = Players:GetPlayerFromCharacter(damager)
	local victim = Players:GetPlayerFromCharacter(damaged)
	local ap = attacker and Participants[attacker.UserId]
	if victim then
		local vp = Participants[victim.UserId]
		if not vp or now() < vp.ProtectedUntil then
			return false
		end
		if attacker and attacker ~= victim and (not ap or ap.Team == vp.Team) then
			return false -- no friendly fire
		end
	end
	if ap then
		ap.LastActive = now()
		if ap.ProtectedUntil > now() then
			ap.ProtectedUntil = 0 -- attacking ends your own spawn protection
			setShield(attacker, false)
		end
	end
	return true
end

-- DamageHandler, after damage was applied.
function ArenaMatch.OnDamage(damager: Model, damaged: Model, amount: number)
	if ArenaMatch.Phase ~= "Fight" or type(amount) ~= "number" or amount ~= amount or amount <= 0 then
		return
	end
	local attacker = Players:GetPlayerFromCharacter(damager)
	local victim = Players:GetPlayerFromCharacter(damaged)
	local ap = attacker and Participants[attacker.UserId]
	local vp = victim and Participants[victim.UserId]
	if not ap or not vp or ap.Team == vp.Team then
		return
	end
	local humanoid = damaged:FindFirstChildOfClass("Humanoid")
	ap.Damage += math.min(amount, if humanoid then humanoid.MaxHealth else amount)
	ap.LastActive = now()
	vp.LastDamager = ap.UserId
	vp.LastDamagedAt = now()
end

-- NewCombatSystem ChooseCharacter, before any other check.
function ArenaMatch.CanChooseCharacter(player: Player, characterName: any): (boolean, string?)
	local phase = ArenaMatch.Phase
	if phase ~= "Select" and phase ~= "Loading" then
		return false, "YOU CAN ONLY CHANGE CHARACTERS DURING CHARACTER SELECT."
	end
	if isAdminCharacter(characterName) then
		return false, "ADMIN CHARACTERS CAN'T BE USED IN THE ARENA."
	end
	return true
end

-- NewCombatSystem ChooseCharacter, right before it sets Health to 0 to swap the moveset.
-- The death handler calls SetNetworkOwner, which errors on an anchored root part.
function ArenaMatch.BeforeCharacterSwap(player: Player)
	setFrozen(player, false)
end

-- DataInit PlayerRemoving, before profile:EndSession(). Must not yield.
function ArenaMatch.OnPlayerRemoving(player: Player)
	TeleportTries[player] = nil
	if ShuttingDown or Finished then
		return
	end
	local p = Participants[player.UserId]
	if not p or p.Gone or p.Player ~= player then
		return
	end
	local phase = ArenaMatch.Phase
	if phase == "Fight" then
		p.LeaveReason = p.LeaveReason or "Left"
		settle(p, false)
		p.Gone = true
		p.Lives = 0
		p.Player = nil
		publishRoster()
		notifyAll(p.Name .. " left the match.")
		checkForEnd()
	else
		if p.Loaded or phase ~= "Loading" then
			dodge(p)
		end
		p.Gone = true
		p.Player = nil
		publishRoster()
		task.spawn(cancel, p.Name .. " left before the fight started")
	end
end

------------------------------------------------------------------------
-- Per-frame checks: falling out, AFK
------------------------------------------------------------------------

local lastAfkCheck = 0

local function removeForAfk(p)
	local player = p.Player
	if not player then
		return
	end
	p.LeaveReason = "AFK"
	notify(player, "You were removed from the match for being AFK.", 6)
	local humanoid = humanoidOf(player)
	-- settle as a loss now (OnPlayerRemoving would do the same when they leave)
	settle(p, false)
	p.Lives = 0
	if humanoid then
		humanoid.Health = 0
	end
	publishRoster()
	checkForEnd()
	task.delay(2, sendToLobby, { player })
end

local function step()
	if ArenaMatch.Phase ~= "Fight" or Finished then
		return
	end
	local t = now()
	local checkAfk = t - lastAfkCheck >= 1
	if checkAfk then
		lastAfkCheck = t
	end
	for _, p in Participants do
		local player = p.Player
		if p.Gone or not player or p.LeaveReason then
			continue
		end
		local humanoid = humanoidOf(player)
		local root = rootOf(player)
		if not humanoid or not root or humanoid.Health <= 0 then
			p.LastActive = t -- dead time doesn't count as AFK
			continue
		end
		if root.Position.Y < A.FallY then
			humanoid.Health = 0 -- fell through a crater; credit goes to whoever hit them last
			continue
		end
		if checkAfk then
			if p.LastPos and (root.Position - p.LastPos).Magnitude > 1.5 then
				p.LastActive = t
			end
			p.LastPos = root.Position
			local idle = t - p.LastActive
			if idle >= A.AfkKickSeconds then
				removeForAfk(p)
			elseif idle >= A.AfkWarnSeconds then
				if not p.AfkWarned then
					p.AfkWarned = true
					MatchState:FireClient(player, "AfkWarning", { Seconds = math.ceil(A.AfkKickSeconds - idle) })
				end
			else
				p.AfkWarned = false
			end
		end
	end
end

------------------------------------------------------------------------
-- Main flow
------------------------------------------------------------------------

local function forceArenaSettings()
	-- whatever test values Demon Fruits was published with, the arena plays on defaults
	local config = workspace:FindFirstChild("Configuration")
	if not config then
		return
	end
	for _, value in config:GetChildren() do
		if value:IsA("BoolValue") then
			value.Value = false
		elseif value:IsA("NumberValue") or value:IsA("IntValue") then
			if value.Name:find("Mult") then
				value.Value = 1
			end
		end
	end
end

local function waitFor(seconds: number, condition: (() -> boolean)?)
	local deadline = now() + seconds
	while now() < deadline and not Finished do
		if condition and condition() then
			return true
		end
		task.wait(0.1)
	end
	return condition ~= nil and condition()
end

local function everyoneLoaded(): boolean
	for _, p in Participants do
		if not p.Loaded then
			return false
		end
	end
	if Record.Studio then
		local needed = if Record.Solo then 1 else Record.TeamSize * 2
		local count = 0
		for _ in Participants do
			count += 1
		end
		return count >= needed
	end
	return true
end

function ArenaMatch.Start()
	if Started then
		return
	end
	Started = true

	MapLoader.Load()
	forceArenaSettings()
	Players.CharacterAutoLoads = false
	setPhase("Loading", A.RecordTimeout + A.LoadTimeout)
	publishRoster()
	game:BindToClose(function()
		ShuttingDown = true
	end)
	RunService.Heartbeat:Connect(step)
	Players.PlayerAdded:Connect(attach)

	-- 1. the match record
	local record = fetchRecord()
	if not validRecord(record) then
		warn("[Arena] No valid match record for this server")
		Record = { MatchId = game.JobId, Queue = "Casual1v1", Teams = { {}, {} }, Studio = IsStudio }
		cancel("No match found for this server")
		return
	end
	Record = record
	Size = Config.Queues[Record.Queue].Size
	IsRanked = Record.Ranked and not Record.Friendly
	workspace:SetAttribute("ArenaQueue", Record.Queue)
	workspace:SetAttribute("ArenaRanked", IsRanked)
	workspace:SetAttribute("ArenaSize", Size)
	if not Record.Studio then
		for team = 1, 2 do
			for slot, userId in Record.Teams[team] do
				local id = tonumber(userId)
				if id then
					Participants[id] = newParticipant(id, team, slot)
				end
			end
		end
	end
	publishRoster()
	for _, player in Players:GetPlayers() do
		task.spawn(attach, player)
	end

	-- 2. everyone arrives and loads
	setPhase("Loading", A.LoadTimeout)
	waitFor(A.LoadTimeout, everyoneLoaded)
	if Finished then
		return
	end
	if not everyoneLoaded() or not teamPresent(1) or (not Record.Solo and not teamPresent(2)) then
		cancel("Not every player arrived")
		return
	end

	-- 3. character select
	local arena = arenaFolder()
	local cameraPart = arena and arena:FindFirstChild("CameraSelect")
	workspace:SetAttribute("ArenaCamera", if cameraPart then cameraPart.CFrame else nil)
	setPhase("Select", A.SelectSeconds)
	notifyAll("Pick your character from the Characters menu.", 5)
	waitFor(A.SelectSeconds)
	if Finished then
		return
	end

	-- 4. countdown (character swaps are closed from here)
	setPhase("Countdown", A.CountdownSeconds)
	waitFor(A.CountdownSeconds)
	if Finished then
		return
	end

	-- 5. fight
	setPhase("Fight")
	FightStartedAt = now()
	for _, p in Participants do
		p.LastActive = now()
		p.LastPos = nil
		if p.Player and p.Player.Parent then
			local humanoid = humanoidOf(p.Player)
			if humanoid and humanoid.Health > 0 then
				setFrozen(p.Player, false)
				protect(p, A.SpawnProtection)
			else
				task.spawn(respawn, p) -- died during the countdown
			end
		end
	end
	publishRoster()
	checkForEnd()
end

return ArenaMatch
