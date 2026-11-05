-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserService = game:GetService("UserService")
local CollectionService = game:GetService("CollectionService")



-- Arena (1v1 / 2v2): nil in Demon Fruits, so nothing below changes there.
local PlaceRole = require(ReplicatedStorage:WaitForChild("Ranked"):WaitForChild("PlaceRole"))
local IsArena = PlaceRole.IsArena()
local ArenaMatch = if IsArena then require(ServerScriptService:WaitForChild("Arena"):WaitForChild("ArenaMatch")) else nil



-- Modules 
local AnimationService = require(ServerStorage.SBGModules.AnimationService)
local MovesetHandler = require(ServerStorage.SBGModules.MovesetHandler)
local RagdollHandler = require(ServerStorage.SBGModules.RagdollHandler)
local NewKnockback = require(ServerStorage.SBGModules.BodymoverService)
local StunHandler = require(ServerStorage.SBGModules.StunHandler)
local Trove = require(ReplicatedStorage.Modules.Trove)
local SvModules = ServerStorage.SBGModules
local SoundsModule = require(SvModules.SoundsModule)
local Leaderboards = require(ServerScriptService.Data.Leaderboards)

local CharacterEquipment = require(script.Modules.CharacterEquipment)
local CharacterAppearance = require(script.Modules.CharacterAppearance)
local SpawnProtection = require(script.Modules.SpawnProtection)

local spawnProtection = SpawnProtection.new(ArenaMatch)
local CoverUntilDressed = spawnProtection.CoverUntilDressed
local SpawnGlow = spawnProtection.SpawnGlow



-- Remotes
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ComunicatorComms = Remotes.Comunicator

local ComSet = ComunicatorComms.Set
local ComGet = ComunicatorComms.Get

local Replication = Remotes.Replicate

local ReplicateSet = Replication.Set
local ReplicateGet = Replication.Get

--Assets
local Assets = ReplicatedStorage.Assets
local Animations = ServerStorage.Assets.Animations
local Sounds = Assets.Sounds
local EmotesFolder = ReplicatedStorage.Assets.Animations.Emotes

local AnimationsTable = {}
for _, Animation in ServerStorage.Assets.Animations:GetDescendants() do
	if Animation:IsA('Animation') then
		table.insert(AnimationsTable, Animation.AnimationId)
	end
end




-- ProfileStore
local ProfileStore = require(ServerScriptService.Libraries.ProfileStore)

local function GetStoreName()
	return RunService:IsStudio() and "Test" or "Live"
end

local Template = require(ServerScriptService.Data.Template)
local DataManager = require(ServerScriptService.Data.DataManager)

local GamepassManager = require(ServerScriptService.Data.GamepassManager)
local ProductManager = require(ServerScriptService.Data.ProductManager) --Make sures this initalizes and runs.

local VIP_PASS = tostring(require(ReplicatedStorage.Info).Passes.VIP)

-- Access profile store
local PlayerStore = ProfileStore.New(GetStoreName(), Template) --Currently 2 types of Data Stores, 1 for studio and another for the actual game.
DataManager.PlayerStore = PlayerStore -- used by DataManager.queueGift to send gift messages

local Owners = {
	397697010, -- Mantisking12
	396527659, -- LegendaryPeep12
}

local function isOwner(player: Player)
	for _, OwnersID in ipairs(Owners) do
		if player.UserId == OwnersID then
			return true
		end
	end
	return false
end




local function GetEmoteAnim(emoteName)
	for _, descendant in EmotesFolder:GetDescendants() do
		if descendant:IsA("Animation") and descendant.Name == emoteName then
			return descendant
		end
	end
	return nil
end

local function setupCharacter(player: Player, profile: typeof(PlayerStore)) 
	local character = player.Character
	character.Parent = game.Workspace.World.Live.Players

	task.spawn(function()
		local ok, err = pcall(CharacterAppearance.Apply, player, character)
		if not ok then
			warn("AddAppareance failed:", err)
		end
		SpawnGlow(character)
	end)
	--workspace.Camera.Parent = game.Workspace.World.Live.Players

	local Humanoid: Humanoid = character:WaitForChild("Humanoid")
	local HumanoidRootPart: Part = character:WaitForChild("HumanoidRootPart")
	local Torso: BasePart = character:WaitForChild("Torso")

	local cosFolder = player:WaitForChild("Cosmetics")
	local accFolder = cosFolder:WaitForChild("Accessories")
	local aurFolder = cosFolder:WaitForChild("Auras")

	-- Short delay to let the Character assemble
	--task.wait(0.1)

	for i,v in pairs(character:GetDescendants()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("UnionOperation") or v:IsA("Part") then --or v:IsA("MeshPart") or v:IsA("UnionOperation") or v:IsA("Part") then
			v.CollisionGroup = "Players"
		end
	end



	--character:SetAttribute("iFrames", 0)
	----character:SetAttribute("IFrame", true) -- should be false no?
	--character:SetAttribute("InCombat", false)
	----character:SetAttribute("Combo",0)
	--character:SetAttribute("Attacking", false)
	--character:SetAttribute("Punch", false)
	--character:SetAttribute("Ragdolled", false)
	----character:SetAttribute("RagdollTime", 0)
	----character:SetAttribute("RagdollTick", 0)
	--character:SetAttribute("db", false)
	--character:SetAttribute("lowIFrame", false)
	--character:SetAttribute("Counter", false)
	--character:SetAttribute("CounterType", "Gojo")
	--character:SetAttribute("Rolling", false)
	--character:SetAttribute("Stunned", false)
	--character:SetAttribute("Var", "None")
	--character:SetAttribute("Attacked", false)
	--character:SetAttribute("Blocking", false)
	--character:SetAttribute("BlockBroken", false)
	--character:SetAttribute("Ulted", false)
	--character:SetAttribute("UltimateTime", 60)
	--character:SetAttribute("Emote", false)
	--character:SetAttribute("Emote2", false)
	--character:SetAttribute("StartWallCombo", false)
	--character:SetAttribute("Infinity", false)

	--Movement Attributes
	--character:SetAttribute("Dashing", false)
	--character:SetAttribute("SideDash", false)
	--character:SetAttribute("DashDoubleCoolDown", false)
	--character:SetAttribute("DashCoolDown", false)
	--character:SetAttribute("Sprinting", false)
	----character:SetAttribute("CustomSpeed", 25)
	--character:SetAttribute("NoSprint", false)
	--character:SetAttribute("NoMove", false)
	--character:SetAttribute("NoJump", false)


	character:SetAttribute("DefaultRunSpeed", 25)
	character:SetAttribute("DefaultWalkSpeed", 16)
	character:SetAttribute("DefaultJumpPower", 50)
	character:SetAttribute("Running", false)


	--Skillset Attributes
	player:SetAttribute("AbilityOneCooldown", false)
	player:SetAttribute("AbilityTwoCooldown", false)
	player:SetAttribute("AbilityThreeCooldown", false)
	player:SetAttribute("AbilityFourCooldown", false)

	player:SetAttribute("ModeAbilityOneCooldown", false)
	player:SetAttribute("ModeAbilityTwoCooldown", false)
	player:SetAttribute("ModeAbilityThreeCooldown", false)
	player:SetAttribute("ModeAbilityFourCooldown", false)

	character:SetAttribute("Awakened", nil)
	character:SetAttribute("AwakeningAura", false)

	player:SetAttribute("Blood", true)

	--for _, itemName in pairs(profile.Data.Cosmetics.OwnedAccessories) do
	--	local accessory = ServerStorage.Assets.Models.Cosmetics.Accessories:FindFirstChild(itemName)
	--	if accessory then
	--		local Value = Instance.new('StringValue')
	--		Value.Name = accessory.Name
	--		Value.Parent = player.Cosmetics.Accessories
	--	end
	--end

	--for _, auraName in pairs(profile.Data.Cosmetics.OwnedAuras) do
	--	local aura = ServerStorage.Assets.Models.Cosmetics.Auras:FindFirstChild(auraName)
	--	if aura then
	--		local Value = Instance.new('StringValue')
	--		Value.Name = aura.Name
	--		Value.Parent = player.Cosmetics.Auras
	--	end
	--end

	accFolder:ClearAllChildren()
	aurFolder:ClearAllChildren()


	for _, itemName in pairs(profile.Data.Cosmetics.EquippedAccessories) do
		local accessory = ServerStorage.Assets.Models.Cosmetics.Accessories:FindFirstChild(itemName)
		if accessory then
			local Value = Instance.new('StringValue')
			Value.Name = accessory.Name
			Value.Parent = player.Cosmetics.Accessories

			ServerStorage.Bindables.Cosmetics:Fire(player, {
				Type = "Accessories",
				Name = itemName,
				State = "Equip"
			})
		end
	end

	if profile.Data.Cosmetics.EquippedAuras ~= "" then
		local aura = ServerStorage.Assets.Models.Cosmetics.Auras:FindFirstChild(profile.Data.Cosmetics.EquippedAuras)
		if aura then
			local Value = Instance.new('StringValue')
			Value.Name = aura.Name
			Value.Parent = player.Cosmetics.Auras

			ServerStorage.Bindables.Cosmetics:Fire(player, {
				Type = "Auras",
				Name = profile.Data.Cosmetics.EquippedAuras,
				State = "Equip"
			})
		end
	end

	if profile.Data.Cosmetics.EquippedTitle ~= "" then
		ServerStorage.Bindables.Cosmetics:Fire(player, {
			Type = "Titles",
			Name = profile.Data.Cosmetics.EquippedTitle,
			State = "Equip"
		})
	end

	--AnimationService:loadAnimations(character)
	for _,v in player.Moveset:GetChildren() do
		v:Destroy()
	end
	MovesetHandler:AddBaseMoveset(player, player:GetAttribute("Moveset"))

	Humanoid.HealthChanged:Connect(function(health: number)
		if Humanoid.Health <= 0 and not character:GetAttribute("IsDead") then
			character:SetAttribute("IsDead", true)
			RagdollHandler.ragdoll(Humanoid, 2)
			local Stun = StunHandler:Stun(character, nil, true, 0, 0)
			Stun:SetAttribute("WalkSpeed", 0)
			--RagdollHandler.ragdoll(character, 2)

			--NewKnockback:Knockback(character, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 0, 100000), Velocity = HumanoidRootPart.CFrame.LookVector * 5})
			HumanoidRootPart:SetNetworkOwner(player)
			Humanoid.RequiresNeck = true

			if not ArenaMatch then -- the arena respawns players itself (3 lives)
				task.delay(2, function()
					player:LoadCharacterAsync()
				end)
			end
			warn("Player has died")
		end
	end)
	
	CharacterEquipment.Apply(player, character)	
end

-- Add leaderstats and sync player data
local function Initalize(player: Player, profile: typeof(PlayerStore:StartSessionAsync())) --typeo is a way to easily get methods and variables and have them autofill.
	-- an Early Access character without the pass (e.g. it was gifted then taken back) falls back to Zoro
	local Info = require(ReplicatedStorage.Info)
	local lastCharacter = profile.Data.LastCharacter or "Zoro"
	local lastInfo = Info.Movesets[lastCharacter]
	local eaPass = profile.Data.Gamepasses[tostring(Info.Passes.EarlyAccess)]
	if lastInfo and lastInfo.isEA and not (eaPass and eaPass.owned) and not isOwner(player) then
		lastCharacter = "Zoro"
	end
	player:SetAttribute("Character", lastCharacter)
	player:SetAttribute("Moveset", lastCharacter)
	player:SetAttribute("AutoUse", true)
	player:SetAttribute("NoCoolDown", true)
	player:SetAttribute("Ultimate", 0)
	player:SetAttribute("UltimateMax", 100)
	player:SetAttribute("InCombat", false)
	player:SetAttribute("HighCombat", false)
	player:SetAttribute("dmgMultiply", 1)

	for _, Object in script.StarterPlayer:GetChildren() do
		Object:Clone().Parent = player
	end

	-- Apply saved settings into the Configuration folder
	local config = player:FindFirstChild("Configuration")
	if config and profile.Data.Settings then
		for settingName, savedValue in profile.Data.Settings do
			local settingObj = config:FindFirstChild(settingName)
			if settingObj then
				settingObj.Value = savedValue
			end
		end
	end
	
	--print("[LOAD] OwnedEmotes:", profile.Data.Emotes.OwnedEmotes)
	--print("[LOAD] EquippedEmotes:", profile.Data.Emotes.EquippedEmotes)
	local equipped = profile.Data.Emotes.EquippedEmotes
	for key in pairs(equipped) do
		if type(key) ~= "string" or not string.match(key, "^%d+_%d+$") then
			equipped[key] = nil
		end
	end

	local owned = profile.Data.Emotes.OwnedEmotes
	for i = #owned, 1, -1 do
		if not GetEmoteAnim(owned[i]) then
			table.remove(owned, i)
		end
	end
	
	if player.UserId == 396527659 then --LegendaryPeep12's ID
		--profile.Data.Gamepasses["2063706242"].owned = false
		--profile.Data.Gamepasses["2063706242"].awarded = false

		--profile.Data.Gamepasses["2063782093"].owned = false
		--profile.Data.Gamepasses["2063782093"].awarded = false

		--profile.Data.TotalKills += 200
		--profile.Data.MonthlyKills = 0

		---- Force this player's leaderboard (OrderedDataStore) entries to match right away,
		---- instead of waiting for the 2-minute autosave / leave / shutdown writes.
		----pcall(function()
		----	TotalKillsDatastore:SetAsync(tostring(player.UserId), profile.Data.TotalKills)
		----	MonthlyKillsDatastore:SetAsync(tostring(player.UserId), profile.Data.MonthlyKills)
		----end)
		
		--profile.Data.EmoteSpins += 1000

		--print(profile.Data.Emotes.EquippedEmotes, "All of your EquippedEmotes")
		--print(profile.Data.Emotes.OwnedEmotes, "All of your owned emotes")
		--profile.Data.Cosmetics = {
		--	OwnedAuras = {},
		--	OwnedAccessories = {},
		--	OwnedTitles = {},
		--	EquippedAuras = "",
		--	EquippedAccessories = {},
		--	EquippedTitle = "",
		--}		
		--profile.Data.Cosmetics.OwnedAccessories = {}
		--profile.Data.Cosmetics.EquippedAccessories = {}
		
		--profile.Data.Emotes.OwnedEmotes = {"Resolute"}
		--profile.Data.Emotes.EquippedEmotes = {
		--	["1_1"] = "Resolute",
		--	["1_2"] = "Resolute",
		--	["1_3"] = "Resolute",
		--	["1_4"] = "Resolute",
		--	["1_5"] = "Resolute",
		--	["1_6"] = "Resolute",
		--	["1_7"] = "Resolute",
		--	["1_8"] = "Resolute",
		--	["2_1"] = "Resolute",
		--	["2_2"] = "Resolute",
		--	["2_3"] = "Resolute",
		--	["2_4"] = "Resolute",
		--	["2_5"] = "Resolute",
		--	["2_6"] = "Resolute",
		--	["2_7"] = "Resolute",
		--	["2_8"] = "Resolute",
		--}
	end
	
	--if player.UserId == 396527659 or player.UserId == 397697010 then --or player.UserId == 575892711 then -- First is legend and 2nd is mantis, 3rd is ErwinArms
	if player.UserId == 396527659 or player.UserId == 397697010 or player.UserId == 575892711 or player.UserId == 905943584 then -- First is legend and 2nd is mantis, 3rd is ErwinArms
		profile.Data.AdminLevel = 4
		player:SetAttribute("Admin", true)
	end
	
	if player.Character then
		setupCharacter(player, profile)
	end

	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
		local hrp = character:WaitForChild("HumanoidRootPart")

		print("Fully ready:", humanoid, hrp)

		-- Every spawn needs the full setup, not just the first: moveset tools, weapon model,
		-- the death -> respawn handler, collision group and cooldown resets.
		-- setupCharacter also applies the appearance, so it isn't called separately here.
		setupCharacter(player, profile)

		task.delay(1, function()
			ComSet:FireClient(player, "MobileButtons", profile.Data.ButtonsInfo)
		end)
	end)

	AnimationService:loadAnimations(player.Character)

	task.spawn(function()
		GamepassManager:UpdateOwnershipData(player)
		if profile.Data.Gamepasses[VIP_PASS].owned then
			player:SetAttribute("HasVIP", true)
		end

		task.delay(1, function()
			ComSet:FireClient(player, "MobileButtons", profile.Data.ButtonsInfo)
		end)

		local loadedData = Instance.new('BoolValue')
		loadedData.Name = 'LoadedData'
		loadedData.Value = true
		loadedData.Parent = player
		player:SetAttribute("Loaded", true)
		CollectionService:AddTag(player, "DataLoaded")
	end)

	-- Passes bought on the Roblox website while in game fire no event, so re-check every 5 minutes.
	-- A "not owned" result is only cached ~10 s, and only unowned passes are checked.
	task.spawn(function()
		while player.Parent == Players and DataManager.Profiles[player] == profile do
			task.wait(300)
			if player.Parent ~= Players or DataManager.Profiles[player] ~= profile then break end
			GamepassManager:UpdateOwnershipData(player)
		end
	end)

	--Shows the total time spent for the player. Will be a setting the player can see. We will update it visually every minute. But it only saves final time when player leaves.
	task.spawn(function()
		while player.Parent == Players do
			task.wait(60)
			local sessionStart = DataManager.SessionStart[player]
			if not sessionStart then break end

			local currentTotal = profile.Data.TotalTimeSpent + (os.time() - sessionStart)
		end
	end)	

	task.spawn(function()
		if (RunService:IsStudio() or isOwner(player) == true) then
			player:SetAttribute("Owner", true)
		
			-- Smart Wait: Checks every 0.5s for up to 10 seconds to see if the function exists
			local timeWaited = 0
			while type(shared.giveCommands) ~= "function" and timeWaited < 10 do
				task.wait(0.5)
				timeWaited += 0.5
			end

			-- Check if it timed out
			if type(shared.giveCommands) ~= "function" then
				--warn("3. FAILURE: shared.giveCommands NEVER loaded into memory! The other script is broken or yielding.")
				return
			end

			--print("3. Function found! Attempting to execute...")

			-- pcall catches errors INSIDE the shared function so they don't silently break the thread
			local success, errorMessage = pcall(function()
				shared.giveCommands(player)
			end)

			if success then
				print("4. SUCCESS: Gave Commands to Owner!")
			else
				warn("4. FAILURE: An error occurred INSIDE the giveCommands function:", errorMessage)
			end
		end
	end)
	
	Leaderboards.OnProfileLoaded(player, profile)
	player:SetAttribute("Gold", profile.Data.Gold)
	player:SetAttribute("TotalKills", profile.Data.TotalKills)
	player:SetAttribute("EmoteSpins", profile.Data.EmoteSpins)
	player.leaderstats.Kills.Value = profile.Data.MonthlyKills
	player.leaderstats["Total Kills"].Value = profile.Data.TotalKills
end

-- Creates and stores a profile of a player.
local function PlayerAdded(player: Player)
	if player.Character then
		CoverUntilDressed(player.Character)
	end
	player.CharacterAdded:Connect(CoverUntilDressed)
	-- Nothing respawns a character on its own any more, so one that was removed without dying
	-- (the death handler respawns the rest) comes back here. The arena handles its own respawns.
	player.CharacterRemoving:Connect(function(old)
		task.delay(3, function()
			if ArenaMatch or player.Parent ~= Players or not DataManager.Profiles[player] then return end
			if player.Character == nil or player.Character == old then
				pcall(player.LoadCharacterAsync, player)
			end
		end)
	end)

	-- start a new profile session
	local profile = PlayerStore:StartSessionAsync("Player_" .. player.UserId, {
		Cancel = function()
			return player.Parent ~= Players
		end,
	})

	-- Sanity check to ensure profile exists.
	if profile ~= nil then	
		profile:AddUserId(player.UserId) -- For GDPR Compile and legal stuff regarding roblox.

		profile:Reconcile() -- Adds and fills in variables which are added to templateData.
		-- Template is a package; settings added after it was published get their default here
		if profile.Data.Settings["Low Graphics"] == nil then
			profile.Data.Settings["Low Graphics"] = false
		end

		-- Handles session locking
		profile.OnSessionEnd:Connect(function() --If player is leaving or joining another session.
			DataManager.Profiles[player] = nil
			player:Kick("Data Error Occured. Please rejoin.")
		end)

		if player.Parent == Players then
			DataManager.Profiles[player] = profile --The key will be the player,  and the data will be the profile. We will add this data to our DataManager Module which has a table called profile.
			DataManager.SessionStart[player] = os.time()

			-- Gifts sent with DataManager.queueGift. Runs now for gifts queued while they were away,
			-- and again whenever a new one arrives during this session. The grant and processed()
			-- are saved together, so a gift can't be lost or applied twice.
			profile:MessageHandler(function(message, processed)
				if type(message) == "table" and message.Type == "Gift" then
					local passId = tostring(message.PassId)
					local gamepass = profile.Data.Gamepasses[passId]

					if gamepass and not gamepass.owned then
						DataManager.grantGamepass(player, passId)
						print("Gift awarded to:", player.Name, "| Pass:", passId)

						-- wait so the client UI is loaded when the gift was queued before they joined
						task.delay(3, function()
							if player.Parent ~= Players then return end
							ReplicatedStorage.Remotes.Gamepasses.GamepassPurchased:FireClient(player, passId)
							ReplicatedStorage.Remotes.Comunicator.Set:FireClient(player, "SendNotification", {
								Title = "GIFTING",
								Text = "You received a gift from " .. tostring(message.From) .. "!",
								Time = 10,
							})
						end)
					end
				elseif type(message) == "table" and message.Type == "ItemGift" then
					-- an item gift: ShopService's seagull brings it once they're alive
					DataManager.addPendingItems(player, { tostring(message.ItemId) })
					task.delay(3, function()
						if player.Parent ~= Players then return end
						ReplicatedStorage.Remotes.Comunicator.Set:FireClient(player, "SendNotification", {
							Title = "GIFTING",
							Text = "You received a gift from " .. tostring(message.From) .. "! A seagull is bringing it.",
							Time = 10,
						})
					end)
				end

				-- Always mark handled, so a gift for an already-owned pass or a malformed message doesn't sit in the queue.
				processed()
			end)

			-- Characters don't spawn by themselves (Players.CharacterAutoLoads is off, like JS): the first one
			-- waits for the data, so nobody sees the plain StarterCharacter rig before the avatar is ready.
			if not player.Character then
				local ok, err = pcall(player.LoadCharacterAsync, player)
				if not ok then
					warn("First spawn failed:", err)
				end
			end
			Initalize(player, profile)
		else --If somehow the player's parent isn't in Players(the game service which tracks players in game) then we end session
			profile:EndSession()
		end

	else
		-- Server shuts down while player is joining.
		warn("Profile was nil for:", player.Name)
		player:Kick("Data Error Occured. Please rejoin.")
	end
end

-- Early Joiners who join to fast
for _, player in Players:GetChildren() do
	task.spawn(PlayerAdded, player)
end

Players.PlayerAdded:Connect(PlayerAdded)

Players.PlayerRemoving:Connect(function(player)
	-- Arena: a leaver's rating/rewards must be written before the session ends below
	if ArenaMatch then
		local ok, err = pcall(ArenaMatch.OnPlayerRemoving, player)
		if not ok then warn("[Arena] OnPlayerRemoving failed:", err) end
	end

	local profile: typeof(PlayerStore:StartSessionAsync()) = DataManager.Profiles[player]
	if not profile then return end

	local sessionStart = DataManager.SessionStart[player]
	if sessionStart then
		profile.Data.TotalTimeSpent = (profile.Data.TotalTimeSpent or 0) + (os.time() - sessionStart)
		DataManager.SessionStart[player] = nil
	end

	Leaderboards.FlushPlayer(player, profile, true)

	profile:EndSession()
	DataManager.Profiles[player] = nil
end)


local ComunicatorFunctions = {
	replicationLoaded = function(Player)
		Remotes.Replicate.Set:FireClient(Player, 'preloadanims', AnimationsTable)
	end,

	ResetCharacter = function(Player: Player)
		if not Player.Character or not Player.Character.Parent or Player.Commands.NoReset.Value == true or workspace.Configuration.NoReset.Value == true then return end

		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid

		local DamagedLog: ObjectValue = Character:FindFirstChild('DamagedLog')
		local DamagerLog: ObjectValue = Character:FindFirstChild('DamagerLog')

		if Character:HasTag('Stunned') then
			ComSet:FireClient(Player, 'SendNotification', { Title = 'NOTIFICATION'; Text = "YOU CAN'T RESET YOUR CHARACTER RIGHT NOW"; })

		elseif (DamagedLog and not DamagedLog:HasTag("Dummy")) or (DamagerLog and not DamagerLog:HasTag("Dummy")) then
			local TimeUntilReset = 0
			if DamagedLog then
				TimeUntilReset = DamagedLog.TimeRemaining.Value
			end

			if DamagerLog then
				if DamagerLog.TimeRemaining.Value > TimeUntilReset then
					TimeUntilReset = DamagerLog.TimeRemaining.Value
				end
			end

			ComSet:FireClient(Player, 'SendNotification', { Title = 'NOTIFICATION'; Text = 'WAIT '..tostring(math.round(TimeUntilReset))..' SECONDS BEFORE RESETTING'; })

		else
			Humanoid.Health = 0
		end
	end,
	SetConfig = function(Player: Player, Params)
		if typeof(Params) ~= "table" then
			return
		end

		-- Only allow this specific setting and a boolean value.
		if Params.CN ~= "Shiftlock" or typeof(Params.V) ~= "boolean" then
			return
		end

		-- Resolve the target on the server, under the actual sender.
		local Configuration = Player:FindFirstChild("Configuration")
		if not Configuration then
			return
		end

		local Setting = Configuration:FindFirstChild("Shiftlock")
		if not Setting or not Setting:IsA("BoolValue") then
			return
		end

		if Setting.Value ~= Params.V then
			Setting.Value = Params.V
		end
	end,

	SaveButtonsPos = function(Player: Player, Positions)
		local profile = DataManager.Profiles[Player]
		if not profile or type(Positions) ~= "table" then return end

		local function num(v, limit)
			if type(v) ~= "number" or v ~= v or math.abs(v) == math.huge then return 0 end
			return math.clamp(v, -limit, limit)
		end

		for _, buttonName in {"Dash", "M1", "Block", "Shiftlock"} do
			local incoming = Positions[buttonName]
			local saved = profile.Data.ButtonsInfo[buttonName]
			if type(incoming) == "table" and saved then
				saved.ScaleX  = num(incoming.ScaleX, 1)
				saved.OffsetX = num(incoming.OffsetX, 5000)
				saved.ScaleY  = num(incoming.ScaleY, 1)
				saved.OffsetY = num(incoming.OffsetY, 5000)
			end
		end
	end,

	SaveButtonSize = function(Player: Player, Parameters)
		local profile = DataManager.Profiles[Player]
		if not profile or type(Parameters) ~= "table" then return end

		local info = profile.Data.ButtonsInfo[Parameters.Button]
		local size = Parameters.Size
		if not info or type(size) ~= "number" or size ~= size then return end

		info.SizeMultiplier = math.clamp(size, 0.5, 2.5)
	end,

}

ComSet.OnServerEvent:Connect(function(Player, _Function, Params)
	if _Function == 'InputDetected' then
		for _, AnimationTrack: AnimationTrack in AnimationService:getLoadedAnimations(Player.Character) do
			if AnimationTrack.IsPlaying == true and AnimationTrack.Animation.Parent == Animations["Spawn Animations"] then
				AnimationService:stopAnimation(Player.Character, AnimationTrack.Animation)
			end
		end

		Player:SetAttribute('DoSpawnAnim', false)
	else
		if not ComunicatorFunctions[_Function] then
			warn("Missing communicator function:", _Function)
			return
		end
		ComunicatorFunctions[_Function](Player, Params)
	end
end)

shared.safeDestroy = function(instance)
	if not instance or typeof(instance) ~= "Instance" then
		return
	end

	instance:Destroy()
	instance = nil
end

shared.cfolder = function(instanceData, lifeTime)
	local newInstance = Instance.new("Accessory")

	for i, v in instanceData do
		newInstance[i] = v
	end

	if lifeTime and typeof(lifeTime)  == "number" then
		task.delay(lifeTime, function()
			shared.safeDestroy(newInstance)
		end)
	end

	return newInstance
end

shared.fireTo = function(RemoteEvent: RemoteEvent, Whitelist: { Players }, Parameters: { any })
	for _, Player: Player in Whitelist do
		RemoteEvent:FireClient(Player, table.unpack(Parameters))
	end
end

-- Runtime
Leaderboards.Start()

game:BindToClose(function()
	-- Give ProfileStore time to finish saving all sessions
	--if RunService:IsStudio() then
	--task.wait(2)
	--else
	-- In live game, properly end all sessions
	for player, profile in pairs(DataManager.Profiles) do
		task.spawn(Leaderboards.FlushPlayer, player, profile)
	end
	for _, player in Players:GetPlayers() do
		local profile = DataManager.Profiles[player]
		if profile then
			profile:EndSession()
		end
	end
	task.wait(3)
end)
