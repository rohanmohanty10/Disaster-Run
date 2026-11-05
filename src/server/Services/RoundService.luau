--!strict
-- Multi-round elimination matches (GAME_PLAN.md Section 1, FRAMEWORK_PLAN.md Section 3).
--   Intermission -> RoleSelection -> [ MapGeneration -> Preparation -> ActiveRun -> RoundEnd ]* -> MatchEnd
-- Runners who die (or don't reach the Sanctuary in time) become Gods from the next round on,
-- until one Runner is left (the winner) or none are (Gods win).
--
-- Course: workspace.Course (parts "StartSpawn" and "Sanctuary") — built by MapService, or your own.
-- Without one, it falls back to two markers on the baseplate.
--
-- Replicated on ReplicatedStorage: RoundState, RoundEndsAt (server time), RoundNumber, MatchActive.
-- Replicated on players: Role ("Runner"/"God"), InRound, Progress (0-1), Finished, Eliminated.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local RoundConfig = require(ReplicatedStorage.Shared.Config.RoundConfig)
local RoundState = require(ReplicatedStorage.Shared.Enums.RoundState)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local Signal = require(ReplicatedStorage.Shared.Util.Signal)

local DataService = require(script.Parent.DataService)
local CombatService = require(script.Parent.CombatService)
local StatusEffectService = require(script.Parent.StatusEffectService)
local AbilityService = require(script.Parent.AbilityService)
local MapService = require(script.Parent.MapService)

type MatchStats = {
	Player: Player,
	UserId: number,
	Name: string,
	RoundsSurvived: number,
	TimeSurvived: number,
	Kills: number,
	Assists: number,
	Damage: number,
	Dodges: number,
	BecameGodRound: number?,
	Cash: number,
	Winner: boolean,
	Left: boolean,
}

local RoundService = {}

RoundService.StateChanged = Signal.new() -- (state)

local course = {
	Start = CFrame.new(RoundConfig.DefaultCourse.Start),
	Sanctuary = CFrame.new(RoundConfig.DefaultCourse.Sanctuary),
	SanctuarySize = RoundConfig.DefaultCourse.SanctuarySize,
}

local matchStats: { [number]: MatchStats } = {}
local roles: { [Player]: string } = {}
local roundRunners: { [Player]: { Alive: boolean, Finished: boolean, MidPoint: boolean } } = {}
local roundNumber = 0
local forceStart = false
local forceEnd = false

-- ------------------------------------------------------------------ helpers
local function setState(state: RoundState.RoundState, duration: number?)
	ReplicatedStorage:SetAttribute("RoundState", state)
	ReplicatedStorage:SetAttribute("RoundEndsAt", if duration then workspace:GetServerTimeNow() + duration else nil)
	RoundService.StateChanged:Fire(state)
end

local function event(info: { [string]: any })
	Remotes.Event("RoundEvent"):FireAllClients(info)
end

local function banner(text: string, sub: string?, color: Color3?)
	event({ Kind = "Banner", Text = text, Sub = sub, Color = color })
end

local function minPlayers(): number
	return if RunService:IsStudio() then 1 else RoundConfig.MinPlayers
end

-- Waits `seconds`, stopping early if `stop()` returns true.
local function waitFor(seconds: number, stop: (() -> boolean)?)
	local started = os.clock()
	while os.clock() - started < seconds do
		if forceEnd or (stop and stop()) then
			return
		end
		task.wait(0.1)
	end
end

local function payCash(player: Player, amount: number, reason: string)
	local stats = matchStats[player.UserId]
	if stats then
		stats.Cash += amount
	end
	local data = DataService.Get(player)
	if data then
		data.Cash += amount
		DataService.Changed(player)
	end
	Remotes.Event("Notify"):FireClient(player, `+${amount} {reason}`, Color3.fromRGB(255, 215, 90))
end

local function statsFor(player: Player): MatchStats?
	return matchStats[player.UserId]
end

-- ------------------------------------------------------------------ course
local function setupCourse()
	local model = workspace:FindFirstChild("Course")
	local start = model and model:FindFirstChild("StartSpawn")
	local sanctuary = model and model:FindFirstChild("Sanctuary")
	if start and start:IsA("BasePart") and sanctuary and sanctuary:IsA("BasePart") then
		course.Start = start.CFrame
		course.Sanctuary = sanctuary.CFrame
		course.SanctuarySize = sanctuary.Size
		return
	end
	-- No course model: just two markers on the baseplate (no map is built).
	local folder = Instance.new("Folder")
	folder.Name = "CourseMarkers"
	local startPart = Instance.new("Part")
	startPart.Name = "StartSpawn"
	startPart.Anchored = true
	startPart.CanCollide = false
	startPart.CanQuery = false
	startPart.Transparency = 1
	startPart.Size = Vector3.new(20, 1, 20)
	startPart.CFrame = course.Start
	startPart.Parent = folder
	local finish = Instance.new("Part")
	finish.Name = "Sanctuary"
	finish.Anchored = true
	finish.CanCollide = false
	finish.CanQuery = false
	finish.Material = Enum.Material.ForceField
	finish.Color = Color3.fromRGB(80, 255, 140)
	finish.Transparency = 0.5
	finish.Size = course.SanctuarySize
	finish.CFrame = course.Sanctuary
	finish.Parent = folder
	folder.Parent = workspace
end

local function insideSanctuary(position: Vector3): boolean
	local localPoint = course.Sanctuary:PointToObjectSpace(position)
	local half = course.SanctuarySize / 2
	return math.abs(localPoint.X) <= half.X and math.abs(localPoint.Y) <= half.Y + 6 and math.abs(localPoint.Z) <= half.Z
end

local function progressOf(position: Vector3): number
	local startPos = course.Start.Position
	local track = course.Sanctuary.Position - startPos
	local length = track.Magnitude
	if length < 1 then
		return 0
	end
	return math.clamp((position - startPos):Dot(track.Unit) / length, 0, 1)
end

-- ------------------------------------------------------------------ spawning
local function freshCharacter(player: Player): Model?
	player:LoadCharacter()
	local character = player.Character or player.CharacterAdded:Wait()
	character:WaitForChild("HumanoidRootPart", 10)
	return character
end

local function placeRunner(player: Player, index: number, count: number)
	local character = freshCharacter(player)
	if not character then
		return
	end
	local spread = (index - (count + 1) / 2) * 4
	local cf = course.Start * CFrame.new(spread, 3, 0)
	character:PivotTo(cf)
	StatusEffectService.Apply(character, "Rooted", RoundConfig.PreparationTime, { Force = true })
end

local function placeGod(player: Player, index: number)
	local character = freshCharacter(player)
	if not character then
		return
	end
	local root = Characters.GetRoot(character)
	if not root then
		return
	end
	local position = course.Start.Position + Vector3.new(index * 8, RoundConfig.GodPlatformHeight, 0)
	character:PivotTo(CFrame.new(position))
	root.Anchored = true
	-- God bodies don't take part in the crossing.
	for _, d in character:GetDescendants() do
		if d:IsA("BasePart") then
			d.CanCollide = false
			d.CanQuery = false
		end
	end
end

local function setRole(player: Player, role: string?)
	roles[player] = role
	player:SetAttribute("Role", role)
	AbilityService.Prepare(player)
end

-- ------------------------------------------------------------------ match flow
local function participants(): { Player }
	local list = {}
	for player in roles do
		if player.Parent == Players then
			table.insert(list, player)
		end
	end
	return list
end

local function runnersInMatch(): { Player }
	local list = {}
	for player, role in roles do
		if role == "Runner" and player.Parent == Players then
			table.insert(list, player)
		end
	end
	return list
end

local function startMatch()
	table.clear(matchStats)
	table.clear(roles)
	roundNumber = 0
	ReplicatedStorage:SetAttribute("MatchActive", true)

	local players = Players:GetPlayers()
	setState(RoundState.RoleSelection, 3)
	local godCount = 0
	local forced = ReplicatedStorage:GetAttribute("ForceSoloRole")
	if #players == 1 then
		godCount = if forced == "God" then 1 else 0
	else
		godCount = math.max(1, math.floor(#players / RoundConfig.PlayersPerStartingGod))
		godCount = math.min(godCount, #players - 1)
	end
	-- Shuffle, then the first godCount players are the starting Gods. (God Pass priority goes here.)
	local shuffled = table.clone(players)
	local rng = Random.new()
	for i = #shuffled, 2, -1 do
		local j = rng:NextInteger(1, i)
		shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
	end
	for i, player in shuffled do
		matchStats[player.UserId] = {
			Player = player,
			UserId = player.UserId,
			Name = player.DisplayName,
			RoundsSurvived = 0,
			TimeSurvived = 0,
			Kills = 0,
			Assists = 0,
			Damage = 0,
			Dodges = 0,
			BecameGodRound = if i <= godCount then 0 else nil,
			Cash = 0,
			Winner = false,
			Left = false,
		}
		setRole(player, if i <= godCount then "God" else "Runner")
		player:SetAttribute("InRound", true)
		player:SetAttribute("Eliminated", nil)
		player:SetAttribute("Finished", nil)
		player:SetAttribute("Progress", 0)
	end
	local godNames = {}
	for player, role in roles do
		if role == "God" then
			table.insert(godNames, player.DisplayName)
		end
	end
	banner("THE MATCH BEGINS", if #godNames > 0 then `Gods: {table.concat(godNames, ", ")}` else "No Gods this time — race to the Sanctuary!")
	task.wait(3)
end

-- Plays one round. Returns the runners that survived it.
local function playRound(): { Player }
	roundNumber += 1
	ReplicatedStorage:SetAttribute("RoundNumber", roundNumber)
	local runners = runnersInMatch()
	table.clear(roundRunners)

	setState(RoundState.MapGeneration, 1)
	MapService.Generate(roundNumber * 7919 + os.time())
	MapService.SetBarrier(false)
	task.wait(1)

	-- Preparation: everyone respawns into position.
	setState(RoundState.Preparation, RoundConfig.PreparationTime)
	if #runners == 2 then
		event({ Kind = "FinalRun" })
	else
		banner(`ROUND {roundNumber}`, `{#runners} Runners remain`)
	end
	local spawning = 0
	local godIndex = 0
	for index, player in runners do
		roundRunners[player] = { Alive = true, Finished = false, MidPoint = false }
		player:SetAttribute("Finished", nil)
		player:SetAttribute("Progress", 0)
		spawning += 1
		task.spawn(function()
			placeRunner(player, index, #runners)
			spawning -= 1
		end)
	end
	for player, role in roles do
		if role == "God" and player.Parent == Players then
			godIndex += 1
			spawning += 1
			local myIndex = godIndex
			task.spawn(function()
				placeGod(player, myIndex)
				AbilityService.Prepare(player)
				spawning -= 1
			end)
		end
	end
	local waited = 0
	while spawning > 0 and waited < 10 do
		task.wait(0.1)
		waited += 0.1
	end

	-- Watch Runner deaths for this round.
	local connections: { RBXScriptConnection } = {}
	for player, info in roundRunners do
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			table.insert(connections, humanoid.Died:Connect(function()
				if info.Alive and not info.Finished then
					info.Alive = false
					player:SetAttribute("Eliminated", true)
					event({ Kind = "Eliminated", Name = player.DisplayName })
				end
			end))
		end
	end
	waitFor(RoundConfig.PreparationTime)

	-- The crossing.
	setState(RoundState.ActiveRun, RoundConfig.RoundTime)
	MapService.SetBarrier(true)
	banner("RUN!", "Reach the Sanctuary", Color3.fromRGB(120, 255, 160))
	local started = os.clock()
	local hadRunners = next(roundRunners) ~= nil
	local function inPlay(): number
		local count = 0
		for player, info in roundRunners do
			if info.Alive and not info.Finished and player.Parent == Players then
				count += 1
			end
		end
		return count
	end
	local tracker = RunService.Heartbeat:Connect(function(dt)
		for player, info in roundRunners do
			if player.Parent ~= Players then
				info.Alive = false
			elseif info.Alive and not info.Finished then
				local stats = statsFor(player)
				if stats then
					stats.TimeSurvived += dt
				end
				local character = player.Character
				local root = character and Characters.GetRoot(character)
				if root then
					local progress = progressOf(root.Position)
					player:SetAttribute("Progress", progress)
					if progress >= 0.5 and not info.MidPoint then
						info.MidPoint = true
						task.spawn(payCash, player, RoundConfig.Rewards.MidPoint, "Mid-point")
					end
					if insideSanctuary(root.Position) then
						info.Finished = true
						player:SetAttribute("Finished", true)
						player:SetAttribute("Progress", 1)
						event({ Kind = "Finished", Name = player.DisplayName })
						if character then
							StatusEffectService.Apply(character, "Invulnerable", RoundConfig.RoundTime, { Force = true })
						end
					end
				end
			end
		end
	end)
	waitFor(RoundConfig.RoundTime, function()
		return hadRunners and inPlay() == 0
	end)
	tracker:Disconnect()
	for _, connection in connections do
		connection:Disconnect()
	end
	local _ = started

	-- Round end: anyone still out on the course when time runs out is eliminated.
	local survivors: { Player } = {}
	for player, info in roundRunners do
		if player.Parent == Players then
			if info.Finished then
				table.insert(survivors, player)
			elseif info.Alive then
				info.Alive = false
				player:SetAttribute("Eliminated", true)
				local character = player.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					humanoid.Health = 0
				end
			end
		end
	end
	setState(RoundState.RoundEnd, RoundConfig.RoundEndTime)

	for _, player in survivors do
		local stats = statsFor(player)
		if stats then
			stats.RoundsSurvived += 1
		end
		payCash(player, RoundConfig.Rewards.Survived + RoundConfig.Rewards.SurvivedPerRound * roundNumber, "Survived the round")
	end
	if #survivors == 0 and hadRunners then
		local gods = {}
		for player, role in roles do
			if role == "God" and player.Parent == Players then
				table.insert(gods, player)
			end
		end
		for _, god in gods do
			payCash(god, math.floor(RoundConfig.Rewards.GodWipeBounty / #gods), "God wipeout bounty")
		end
	end

	-- Eliminated Runners join the Gods.
	for player, info in roundRunners do
		if not info.Finished and player.Parent == Players then
			setRole(player, "God")
			local stats = statsFor(player)
			if stats then
				stats.BecameGodRound = roundNumber
			end
		end
	end
	banner(`{#survivors} SURVIVED`, if #survivors >= 2 then "The fallen join the Gods..." else nil)
	waitFor(RoundConfig.RoundEndTime)
	return survivors
end

local function mvpScore(stats: MatchStats): number
	local w = RoundConfig.MVPScore
	return stats.RoundsSurvived * w.RoundsSurvived
		+ stats.TimeSurvived * w.TimeSurvived
		+ stats.Kills * w.Kills
		+ stats.Assists * w.Assists
		+ stats.Damage * w.DamageDealt
		+ stats.Dodges * w.Dodges
		+ (if stats.Winner then w.MatchWinner else 0)
end

local function endMatch(winner: Player?)
	setState(RoundState.MatchEnd, RoundConfig.MatchEndTime)
	if winner then
		local stats = statsFor(winner)
		if stats then
			stats.Winner = true
		end
		payCash(winner, RoundConfig.Rewards.MatchWinner, "Match winner")
	end

	-- Awards (GAME_PLAN.md Section 6C).
	local list: { MatchStats } = {}
	for _, stats in matchStats do
		table.insert(list, stats)
	end
	local function best(field: (MatchStats) -> number): MatchStats?
		local top: MatchStats? = nil
		local topValue = 0
		for _, stats in list do
			local value = field(stats)
			if value > topValue then
				topValue = value
				top = stats
			end
		end
		return top
	end
	local awards = {}
	local function award(key: string, title: string, stats: MatchStats?, value: string?)
		if stats then
			table.insert(awards, { Key = key, Title = title, UserId = stats.UserId, Name = stats.Name, Value = value })
			if stats.Player.Parent == Players then
				payCash(stats.Player, RoundConfig.Rewards.MVPAward, title)
			end
		end
	end
	if winner then
		local stats = statsFor(winner)
		if stats then
			table.insert(awards, { Key = "Survivor", Title = "Survivor", UserId = stats.UserId, Name = stats.Name })
		end
	end
	local mvp = best(mvpScore)
	award("MVP", "Match MVP", mvp, if mvp then `{math.floor(mvpScore(mvp))} pts` else nil)
	local survival = best(function(s)
		return s.TimeSurvived
	end)
	award("Survival", "Longest Survival", survival, if survival then `{math.floor(survival.TimeSurvived)}s` else nil)
	local killer = best(function(s)
		return s.Kills
	end)
	award("Kills", "Most Kills", killer, if killer then `{killer.Kills}` else nil)
	local damager = best(function(s)
		return s.Damage
	end)
	award("Damage", "Most Damage", damager, if damager then `{math.floor(damager.Damage)}` else nil)
	local dodger = best(function(s)
		return s.Dodges
	end)
	award("Untouchable", "Untouchable", dodger, if dodger then `{dodger.Dodges} dodges` else nil)

	-- Participation, lifetime stats.
	local rows = {}
	for _, stats in list do
		local player = stats.Player
		if player.Parent == Players then
			payCash(player, RoundConfig.Rewards.Participation, "Participation")
			local data = DataService.Get(player)
			if data then
				data.Stats.MatchesPlayed += 1
				data.Stats.RoundsSurvived += stats.RoundsSurvived
				data.Stats.Kills += stats.Kills
				data.Stats.DamageDealt += math.floor(stats.Damage)
				if stats.Winner then
					data.Stats.MatchWins += 1
				end
				if mvp == stats then
					data.Stats.MVPs += 1
				end
				DataService.Changed(player)
			end
		end
		table.insert(rows, {
			UserId = stats.UserId,
			Name = stats.Name,
			RoundsSurvived = stats.RoundsSurvived,
			TimeSurvived = math.floor(stats.TimeSurvived),
			Kills = stats.Kills,
			Damage = math.floor(stats.Damage),
			Score = math.floor(mvpScore(stats)),
			Cash = stats.Cash,
			Winner = stats.Winner,
			BecameGodRound = stats.BecameGodRound,
		})
	end
	table.sort(rows, function(a, b)
		return a.Score > b.Score
	end)
	event({ Kind = "Results", Winner = if winner then winner.DisplayName else nil, Awards = awards, Rows = rows })
	waitFor(RoundConfig.MatchEndTime)

	-- Back to the lobby.
	for _, player in Players:GetPlayers() do
		setRole(player, nil)
		player:SetAttribute("InRound", nil)
		player:SetAttribute("Eliminated", nil)
		player:SetAttribute("Finished", nil)
		player:SetAttribute("Progress", nil)
		task.spawn(function()
			player:LoadCharacter()
		end)
	end
	table.clear(roles)
	ReplicatedStorage:SetAttribute("MatchActive", nil)
	ReplicatedStorage:SetAttribute("RoundNumber", nil)
end

local function runMatch()
	startMatch()
	local winner: Player? = nil
	while true do
		forceEnd = false
		local survivors = playRound()
		local remaining = runnersInMatch()
		if forceEnd then
			break
		end
		if #survivors == 1 and #participants() > 1 then
			winner = survivors[1]
			break
		elseif #survivors == 0 or #remaining == 0 then
			break
		elseif #participants() <= 1 then
			-- Solo test: one round is enough.
			winner = survivors[1]
			break
		end
	end
	forceEnd = false
	endMatch(winner)
end

local function loop()
	while true do
		if #Players:GetPlayers() < minPlayers() then
			setState(RoundState.Waiting)
			repeat
				task.wait(1)
			until #Players:GetPlayers() >= minPlayers()
		end
		setState(RoundState.Intermission, RoundConfig.IntermissionTime)
		forceStart = false
		local started = os.clock()
		while os.clock() - started < RoundConfig.IntermissionTime and not forceStart do
			task.wait(0.25)
			if #Players:GetPlayers() < minPlayers() then
				break
			end
		end
		if #Players:GetPlayers() >= minPlayers() then
			local ok, err = pcall(runMatch)
			if not ok then
				warn(`[RoundService] Match crashed: {err}`)
				ReplicatedStorage:SetAttribute("MatchActive", nil)
				for _, player in Players:GetPlayers() do
					setRole(player, nil)
					player:SetAttribute("InRound", nil)
				end
				table.clear(roles)
			end
		end
	end
end

-- ------------------------------------------------------------------ test hooks
function RoundService.ForceStart()
	forceStart = true
end

function RoundService.ForceEnd()
	forceEnd = true
end

function RoundService.Init()
	ReplicatedStorage:SetAttribute("RoundState", RoundState.Waiting)

	CombatService.Damaged:Connect(function(_, attacker: Player?, amount: number)
		if attacker and roles[attacker] == "God" then
			local stats = statsFor(attacker)
			if stats then
				stats.Damage += amount
			end
		end
	end)
	CombatService.Killed:Connect(function(_, killer: Player?, assists: { Player })
		if not ReplicatedStorage:GetAttribute("MatchActive") then
			return
		end
		if killer and roles[killer] == "God" then
			local stats = statsFor(killer)
			if stats then
				stats.Kills += 1
			end
			payCash(killer, RoundConfig.Rewards.Kill, "Kill")
		end
		for _, helper in assists do
			if roles[helper] == "God" then
				local stats = statsFor(helper)
				if stats then
					stats.Assists += 1
				end
				payCash(helper, RoundConfig.Rewards.Assist, "Assist")
			end
		end
	end)
	CombatService.Dodged:Connect(function(victim: Model)
		local player = Players:GetPlayerFromCharacter(victim)
		local stats = player and statsFor(player)
		if stats then
			stats.Dodges += 1
		end
	end)
end

function RoundService.Start()
	setupCourse()
	Players.PlayerRemoving:Connect(function(player)
		local stats = statsFor(player)
		if stats then
			stats.Left = true
		end
		roles[player] = nil
	end)
	task.spawn(loop)
end

return RoundService
