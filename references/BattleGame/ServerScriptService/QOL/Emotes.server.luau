-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- Modules
local DataManager = require(ServerScriptService.Data.DataManager)
local AnimationService = require(ServerStorage.SBGModules.AnimationService)
local SoundsModule = require(ServerStorage.SBGModules.SoundsModule)
local EmotesModule = require(ServerStorage.SBGModules.Emotes)

-- Folders & Remotes
local EmotesFolder = ReplicatedStorage.Assets.Animations.Emotes
local Sounds = ReplicatedStorage.Assets.Sounds
local Remotes = ReplicatedStorage.Remotes
local EmotesRemotes = Remotes.Emotes
local ComunicatorComms = Remotes.Comunicator
local ComSet = ComunicatorComms.Set

-- Default movement values restored when an emote ends.
local DEFAULT_RUN_SPEED = 25
local DEFAULT_WALK_SPEED = 16
local DEFAULT_JUMP_POWER = 50

-- Helper Function
local function GetEmoteAnim(emoteName)
	for _, descendant in EmotesFolder:GetDescendants() do
		if descendant:IsA("Animation") and descendant.Name == emoteName then
			return descendant
		end
	end
	return nil
end

-- /// REMOTE INVOCATIONS (Moved from DataManager) ///
EmotesRemotes.GetOwnedEmotes.OnServerInvoke = function(player)
	return DataManager.getOwnedEmotes(player)
end

EmotesRemotes.GetEquippedEmotes.OnServerInvoke = function(player)
	local profile = DataManager.Profiles[player]
	if not profile then return {}, {} end

	local page1, page2 = {}, {}
	for key, emoteName in profile.Data.Emotes.EquippedEmotes do
		local pageNum, slot = string.match(key, "^(%d+)_(%d+)$")
		if pageNum == "1" then page1[slot] = emoteName
		elseif pageNum == "2" then page2[slot] = emoteName end
	end
	return page1, page2
end

EmotesRemotes.ChangeEmotes.OnServerInvoke = function(player, params)
	return DataManager.changeEmoteSlot(player, params.EmoteName, params.Slot, params.Page)
end

EmotesRemotes.BuyEmoteSpins.OnServerInvoke = function(player)
	local cost = 3500  -- server decides the price; same as ShopConfig.EmoteSpin.Price (50 kills, like JJS)
	local result
	
	if DataManager.getGold(player) < cost then
		result = "NotEnough"
	else
		result = "Bought"
	end
	
	if result == "Bought" then
		DataManager.addGold(player, -cost)
		DataManager.addEmoteSpins(player, 1)
		ComSet:FireClient(player, "SendNotification", { Title = "MARKET", Text = "Bought emote spin!", Time = 5 })
	elseif result == "NotEnough" then
		ComSet:FireClient(player, "SendNotification", { Title = "MARKET", Text = "Not enough Beli. (Need " .. cost .. ")", Time = 5 })
	end

	return result
end

EmotesRemotes.SpinEmote.OnServerInvoke = function(player)
	local success, emoteName, rarityName, goldAwarded, rolledEmoteName = DataManager.spinEmote(player)
	return success, emoteName, rarityName, goldAwarded, rolledEmoteName
end

-- /// EMOTE SESSION MANAGEMENT ///
--
-- Every emote a character plays is tracked as a single "session". Only one
-- session can be active per character at a time. This is what fixes the two
-- long-standing bugs:
--
--  * The old code hung all of its cleanup off `AnimationTrack.Stopped`. Because
--    the tracks are cached and reused, a Stopped fired for one play would run
--    cleanup belonging to a *different* play. Starting a second emote would let
--    the first emote's (async) cleanup reset the character's walk/jump speed a
--    frame later, unfreezing you mid-animation. Replaying the *same* emote made
--    the restart's Stopped tear down the sound/VFX that had just been created.
--
--  * A session owns its own assets, its own VFX-stop callbacks and its own
--    single Stopped connection. Starting a new emote ends the previous session
--    *synchronously* (disconnecting its Stopped connection so it can never fire
--    late), which makes the whole thing deterministic.

-- Weak keys so a despawned character never keeps its session table alive.
local EmoteSessions = setmetatable({}, { __mode = "k" })

local SessionMethods = {}
SessionMethods.__index = SessionMethods

-- Register an instance (sound / effect) to be destroyed when the emote ends.
function SessionMethods:AddAsset(instance)
	if instance then
		table.insert(self.assets, instance)
	end
	return instance
end

-- Register a callback to run when the emote ends (e.g. tell clients to stop VFX).
function SessionMethods:OnCleanup(callback)
	if callback then
		table.insert(self.cleanups, callback)
	end
end

-- Restore normal movement/rotation once an emote is over. Skipped when a stun is
-- currently holding the character in place so we don't fight the stun handler.
local function restoreMovement(Character)
	if not Character or not Character.Parent then return end

	if not Character:HasTag("Stunned") then
		Character:SetAttribute("DefaultRunSpeed", DEFAULT_RUN_SPEED)
		Character:SetAttribute("DefaultWalkSpeed", DEFAULT_WALK_SPEED)
		Character:SetAttribute("DefaultJumpPower", DEFAULT_JUMP_POWER)
	end
	Character:RemoveTag("CantRotate")
end

-- End a session deterministically.
--   keepFrozen = true  -> another emote is taking over and will apply its own
--                         freeze, so don't restore movement (prevents the
--                         "move while animating" race).
local function endSession(session, keepFrozen)
	if not session or session.ended then return end
	session.ended = true

	-- Detach first: once disconnected no late/stray Stopped can touch this
	-- session or the one that supersedes it.
	if session.stoppedConn then
		session.stoppedConn:Disconnect()
		session.stoppedConn = nil
	end

	local Character = session.character
	if Character and EmoteSessions[Character] == session then
		EmoteSessions[Character] = nil
	end

	-- Emote-specific teardown (e.g. FireAllClients "Stop" for VFX emotes).
	for _, callback in session.cleanups do
		task.spawn(callback)
	end

	-- Destroy the sounds / effects this emote created.
	for _, instance in session.assets do
		if instance and instance.Parent then
			instance:Destroy()
		end
	end

	if not keepFrozen then
		restoreMovement(Character)
	end

	if session.marker and session.marker.Parent then
		session.marker:Destroy()
	end
end

-- Begin a new session, tearing down any current one first (keeping the freeze,
-- because the incoming emote re-applies it immediately).
local function beginSession(Character, Player)
	local previous = EmoteSessions[Character]
	if previous then
		endSession(previous, true)
	end

	local marker = Instance.new("BoolValue")
	marker.Name = "Emoting"
	marker.Value = true
	marker.Parent = Character

	local session = setmetatable({
		character = Character,
		player = Player,
		assets = {},
		cleanups = {},
		marker = marker,
		track = nil,
		stoppedConn = nil,
		ended = false,
	}, SessionMethods)

	EmoteSessions[Character] = session
	return session
end


-- /// REMOTE EVENTS (Moved from DataInit) ///

EmotesRemotes.Set.OnServerEvent:Connect(function(player, action, AnimationName)
	if action == "PlayEmote" then
		local Character = player.Character
		if not Character or Character:HasTag("Stunned") or not Character:FindFirstChild("HumanoidRootPart") then return end

		local Anim = GetEmoteAnim(AnimationName)
		if not Anim then return end

		-- Only emotes the player owns (otherwise any client can fire this with a Mythic name).
		local owned = DataManager.getOwnedEmotes(player)
		if not owned or not table.find(owned, AnimationName) then return end

		-- Start a fresh session. This synchronously ends the previous emote
		-- (and disconnects its Stopped connection) so it can never clobber this
		-- one, while leaving the character frozen for a seamless swap.
		local session = beginSession(Character, player)

		-- Stop everything else that might be playing (combat animations, etc.).
		-- Safe now: the previous emote's Stopped connection is already gone.
		AnimationService:stopAll(Character)

		-- pcall guards the (unlikely) case of an animation that never loaded;
		-- on failure we unwind the session so the player is never left frozen
		-- or wearing a stuck "Emoting" marker.
		local gotTrack, Track = pcall(AnimationService.getAnimationTrack, AnimationService, Character, Anim)
		if not gotTrack or not Track then
			endSession(session)
			return
		end
		session.track = Track

		local setupOk, setupErr = pcall(function()
			if EmotesModule[AnimationName] then
				EmotesModule[AnimationName](player, Anim, session)
			else
				AnimationService:playAnimation(Character, Anim)

				Character:SetAttribute('DefaultRunSpeed', Anim:GetAttribute('WalkSpeed') or 0)
				Character:SetAttribute('DefaultWalkSpeed', Anim:GetAttribute('WalkSpeed') or 0)
				Character:SetAttribute('DefaultJumpPower', Anim:GetAttribute('JumpPower') or 0)

				if Anim:HasTag('NAR') then Character:AddTag("CantRotate") end

				local EmoteSound = Sounds.Emotes:FindFirstChild(Anim.Name)
				if EmoteSound then
					session:AddAsset(SoundsModule:PlaySound(EmoteSound, Character.PrimaryPart))
				end
			end
		end)

		if not setupOk then
			warn("[Emotes] failed to start '" .. tostring(AnimationName) .. "': " .. tostring(setupErr))
			if session.track then
				AnimationService:stopAnimation(Character, session.track.Animation, 0)
			end
			endSession(session)
			return
		end

		-- One session-guarded end handler. It fires when the emote track stops
		-- on its own (non-looping emotes finishing).
		--   * session check: a newer emote has taken over -> ignore.
		--   * IsPlaying check: the same cached track being restarted emits a
		--     transient Stopped; the track is playing again by then, so ignore
		--     it. A genuine finish leaves the track stopped.
		local conn
		conn = Track.Stopped:Connect(function()
			if EmoteSessions[Character] ~= session then return end
			if Track.IsPlaying then return end
			endSession(session)
		end)
		session.stoppedConn = conn

	elseif action == "StopEmote" then
		local Character = player.Character
		if not Character then return end

		local session = EmoteSessions[Character]
		if session then
			if session.track then
				AnimationService:stopAnimation(Character, session.track.Animation, 0)
			end
			endSession(session)
		end
	end
end)