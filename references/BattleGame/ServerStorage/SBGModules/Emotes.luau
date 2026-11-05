--// Services \\--

local Players = game:GetService("Players")
local SvSt = game:GetService('ServerStorage')
local TS = game:GetService('TweenService')
local RS = game:GetService('ReplicatedStorage')
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")


--// Comunication \\--
local Remotes = RS.Remotes

local ReplicateSet = RS.Remotes.Replicate.Set

local EmotesComms = RS.Remotes.Emotes

local EmotesSet = EmotesComms.Set

local ComunicatorFolder = RS.Remotes.Comunicator

local PlrSet = ComunicatorFolder.Set



--// Modules \\--

local RpModules = RS.Modules

local WeldSystem = require(RpModules.WeldSystem)
local Utility = require(RpModules.Utility)
local Trove = require(RpModules.Trove)


local SvModules = SvSt.SBGModules
local SvAnimations = RS.Assets.Animations

local AnimationService = require(SvModules.AnimationService)
local SoundHandler = require(RS.Modules.SoundHandler)
local HandModule = require(SvModules.Other.HandModule)
local iFramesService = require(SvModules.iFramesService)
local StunHandler = require(SvModules.StunHandler)
local CollisionsModule = require(SvModules.CollisionsModule)
local NewKnockback = require(SvModules.BodymoverService)
local RagdollHandler = require(SvModules.RagdollHandler)


--local CustomWeld = require(script.Weld)
--local GetCharacters = require(script.GetCharacters)



--// Variables \\--

local AuraStateCache = {}


--// Local Functions \\--

local function TriggerHumanoid(Character: Model, Params: { any })
	local Humanoid: Humanoid = Character.Humanoid

	Character:SetAttribute('DefaultRunSpeed', Params.RS)
	Character:SetAttribute('DefaultWalkSpeed', Params.WS)
	Character:SetAttribute('DefaultJumpPower', Params.JP)

	Humanoid.WalkSpeed = Params.WS
	Humanoid.JumpPower = Params.JP
	if Params.AR == true then
		Character:RemoveTag("CantRotate")
	else
		Character:AddTag("CantRotate")
	end
end

-- The server (Emotes.server.luau) owns each emote's lifecycle and passes a
-- `session` object in. `session:AddAsset(inst)` registers a sound/effect to be
-- destroyed when the emote ends; `session:OnCleanup(fn)` registers a callback to
-- run on end (e.g. tell clients to stop VFX). The server handles freezing/
-- unfreezing and stopping the track, so these emotes no longer wire up their own
-- `Track.Stopped`. This fallback keeps an emote playable if it is ever invoked
-- without a session (it just loses the centralised cleanup).
local NoopSession = {
	AddAsset = function(_, instance) return instance end,
	OnCleanup = function() end,
}
local function ensureSession(session)
	return session or NoopSession
end

local function EmitAuraParticles(Model)
	for _, Descendant in pairs(Model:GetDescendants()) do
		if Descendant:IsA("ParticleEmitter") then
			local EmitCount = Descendant:GetAttribute("EmitCount")
			Descendant:Emit(EmitCount)
		end
	end
end

local function ResetAura(Character)
	if AuraStateCache[Character] then
		local CachedData = AuraStateCache[Character]
		local PartsToFade = CachedData.destroy
		local HairParts = CachedData.hairs

		for _, Part in pairs(PartsToFade) do
			Part.Transparency = 1
			game.Debris:AddItem(Part, 0.5)
		end

		for _, Hair in pairs(HairParts) do
			if not Character:GetAttribute("InMech") and Character.Head.Transparency < 1 then
				Hair.Transparency = 0
			end

			for _, HairChild in pairs(Hair:GetChildren()) do
				if HairChild:IsA("SpecialMesh") or HairChild:IsA("MeshPart") then
					HairChild.TextureId = HairChild:GetAttribute("basetext")
				end
			end
		end

		AuraStateCache[Character] = nil
	end

	for _, Descendant in pairs(Character:GetDescendants()) do
		if Descendant:GetAttribute("EmoteEffect") then
			Descendant:Destroy()
		end

		if Descendant:IsA("Sound") and tostring(Descendant) == "CrushEmoteAmbience" then
			game:GetService("TweenService"):Create(Descendant, TweenInfo.new(0.75), {
				Volume = 0
			}):Play()

			task.delay(1, function()
				if Descendant and Descendant.Parent then
					Descendant:Destroy()
				end
			end)
		end

		if (Descendant:IsA("Part") or Descendant:IsA("Folder")) and Descendant:GetAttribute("LimAura") then
			game.Debris:AddItem(Descendant, 3)
		end

		if (Descendant:IsA("ParticleEmitter") or Descendant:IsA("Beam") or Descendant:IsA("Attachment")) and Descendant:GetAttribute("LimitedAura") then
			if Descendant:IsA("Part") then
				for _, Effect in pairs(Descendant:GetDescendants()) do
					if Effect:IsA("Trail") or Effect:IsA("ParticleEmitter") or Effect:IsA("Beam") then
						Effect.Enabled = false
					end
				end
			end

			if Descendant:IsA("ParticleEmitter") or Descendant:IsA("Beam") then
				Descendant.Enabled = false
			else
				for _, ChildEffect in pairs(Descendant:GetChildren()) do
					if ChildEffect:IsA("ParticleEmitter") or ChildEffect:IsA("Beam") then
						ChildEffect.Enabled = false
					end
				end
			end

			task.delay(3, function()
				if Descendant and Descendant.Parent then
					Descendant:Destroy()
				end
			end)
		end
	end
end

local function v112(v106)
	local l_orig_0 = v106.orig
	local l_dir_0 = v106.dir

	local v109 = RaycastParams.new()
	v109.FilterDescendantsInstances = v106.Whitelist or v106.Ignore or {
		workspace.Thrown, 
		workspace.Live
	}

	if v106.Whitelist then
		v109.FilterType = Enum.RaycastFilterType.Include
	else
		v109.FilterType = Enum.RaycastFilterType.Exclude
	end

	if v106.Blockcast then
		local v110 = workspace:Blockcast(l_orig_0, v106.Blockcast, l_dir_0, v109)
		if v110 then
			return v110.Instance, v110.Position, v110.Material, v110.Normal
		else
			return
		end
	else
		local v111 = workspace:Raycast(l_orig_0, l_dir_0, v109)
		if v111 then
			return v111.Instance, v111.Position, v111.Material, v111.Normal
		else
			return
		end
	end
end

local function v3483(v3481)
	local Params = {
		Seed = math.random(1, 2000000000), 
		start = v3481.startpos, 
		["end"] = Vector3.new(0, -14, 0, 0), 
		amount = v3481.amount, 
		size = v3481.size, 
		nosound = v3481.nosound
	}

	ReplicateSet:FireAllClients("Ground Crater", Params)
end

local function v35(v32)
	for _, v34 in pairs(v32:GetDescendants()) do
		if v34:IsA("BasePart") or v34:IsA("Decal") then
			v34.Transparency = 1

			if v34:IsA("BasePart") then
				v34.CollisionGroup = "untouchable"
			end

		elseif v34:IsA("ParticleEmitter") or v34:IsA("Texture") or v34:IsA("Beam") or v34:IsA("Trail") or v34:IsA("BillboardGui") then
			v34:Destroy()
		end

		if v34:IsA("Humanoid") then
			v34.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			v34.HealthDisplayDistance = 0
			v34.NameDisplayDistance = 0
		end
	end
end


return {
	
	-- Common Emotes
	["Hm"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Common.Hm["music"], HumRP))
	end,
	
	["Griddy"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Common.Griddy["music"], HumRP))
	end,
	
	-- Rare Emotes
	["Billy Bounce"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Rare["Billy Bounce"].music, HumRP))
	end,
	
	["Boogie Down"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Rare["Boogie Down"].music, HumRP))
	end,
	
	["Electro Swing"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Rare["Electro Swing"].music, HumRP))
	end,
	
	["Floss"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Rare["Floss"].music, HumRP))
	end,
	
	["FreeStyle"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Rare["FreeStyle"].music, HumRP))
	end,

	["Fresh"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Rare["Fresh"].music, HumRP))
	end,
	
	["Gangnam"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Rare["Gangnam"].music, HumRP))
	end,
	
	["Hype"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Rare["Hype"].music, HumRP))
	end,
	
	["Requiem"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Rare.Requiem.music, HumRP))
	end,
	
	["Smooth Moves"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Rare["Smooth Moves"].music, HumRP))
	end,
	
	







	-- Epic Emotes
	["Chika Edit"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script["Epic"]["Chika Edit"].music, HumRP))
	end,
	
	["Iris"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		--session:AddAsset(SoundHandler:AddSound(script.Epic.Iris.music, HumRP))
	end,
	
	["Luffy Dance"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Epic["Luffy Dance"].music, HumRP))
	end,
	
	["Moon Walk"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Epic["Moon Walk"].music, HumRP))
	end,

	["Oshi No Ko"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Epic["Oshi No Ko"].music, HumRP))
	end,
	
	["Orange Justice"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script.Epic["Orange Justice"].music, HumRP))
	end,
	
	["Torture"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		session:AddAsset(SoundHandler:AddSound(script.Epic.Torture.music, HumRP))

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,





	
	-- Legendary Emotes
	["Deer"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })  -- freeze; set WS>0 if it should move
		
		session:AddAsset(SoundHandler:AddSound(script.Legendary.Deer.music, HumRP))
	end,
	
	["Saiyan Walk"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		session:AddAsset(SoundHandler:AddSound(script.Legendary["Saiyan Walk"].music, HumRP))

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	
	["Shinji"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })  -- freeze; set WS>0 if it should move
		session:AddAsset(SoundHandler:AddSound(script.Legendary.Shinji.music, HumRP))
		
		if not Character:FindFirstChild("Shinji Chair") then
			local chair = script.Legendary["Shinji"].Chair:Clone()
			chair.Name = "Shinji Chair"
			chair.CFrame = HumRP.CFrame * CFrame.new(0, -1.6, 0) * CFrame.Angles(0, math.rad(-45 + 180), 0)
			chair.Parent = Character

			local chairWeld = Instance.new("WeldConstraint")
			chairWeld.Part0 = HumRP
			chairWeld.Part1 = chair
			chairWeld.Parent = chair

			session:OnCleanup(function()
				if chair and chair.Parent then
					chair:Destroy()
				end
			end)
		end
	end,
	
	["Take The L"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script["Legendary"]["Take The L"].music, HumRP))
	end,

	
	
	
	
	
	-- Mythic Emotes
	["Aura Farming"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script["Mythic"]["Aura Farming"].music, HumRP))
		
		Remotes.ClientEffects:FireAllClients("Aura Farming Emote", {Character = Character, Status = "Play"})
		session:OnCleanup(function()
			Remotes.ClientEffects:FireAllClients("Aura Farming Emote", {Character = Character, Status = "Stop"})
		end)
	end,
	
	["Honored One"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		session:AddAsset(SoundHandler:AddSound(script["Mythic"]["Honored One"].music, HumRP))

		Remotes.ClientEffects:FireAllClients("Honored One Emote", {Character = Character, Status = "Play"})
		session:OnCleanup(function()
			Remotes.ClientEffects:FireAllClients("Honored One Emote", {Character = Character, Status = "Stop"})
		end)
	end,
	

	["Hakari"] = function(Player: Player, Emote: Animation, session)
		session = ensureSession(session)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })  -- freeze; set WS>0 if it should move

		session:AddAsset(SoundHandler:AddSound(script.Mythic.Hakari.music, HumRP))

		Remotes.ClientEffects:FireAllClients("Hakari Emote", {Character = Character, Status = "Play"})
		session:OnCleanup(function()
			Remotes.ClientEffects:FireAllClients("Hakari Emote", {Character = Character, Status = "Stop"})
		end)
	end,
	
	-- Paste this entry INSIDE the return table in ServerStorage.SBGModules.Emotes.
	-- Put it under -- Mythic Emotes, alongside Aura Farming / Honored One / Hakari.
	["Aura Walk"] = function(player: Player, emote: Animation, session)
		local RS = game:GetService("ReplicatedStorage")
		local RunService = game:GetService("RunService")
		local CollectionService = game:GetService("CollectionService")
		local HttpService = game:GetService("HttpService")

		local WALK_SPEED = 8
		local RUN_SPEED = 14
		local SPRINT_THRESHOLD = 11
		local TAG = "AuraWalkActive"
		local EFFECT = "Aura Walk Emote"

		assert(session and session.track, "Aura Walk needs your emote session")
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local root = character and character:FindFirstChild("HumanoidRootPart")
		assert(humanoid and root, "Aura Walk needs a living character")
		assert(humanoid.RigType == Enum.HumanoidRigType.R6, "This Aura Walk uses your R6 rig")
		local effectModule = RS.Modules.ClientEffects.Emotes["Aura Walk Emote"]
		local assets = effectModule:FindFirstChild("AuraWalkAssets")
		assert(assets, "Put AuraWalkAssets under the Aura Walk Emote ModuleScript")
		local template = assets:FindFirstChild("PlatformRig")
		assert(template, "Run PreparePlatforms.command.luau once to prepare the animated platforms")

		local track = session.track
		local token = HttpService:GenerateGUID(false)
		local connections = {}
		local stopped = false
		local oldPriority, oldLooped = track.Priority, track.Looped
		local props, rootMotor

		local function cleanup()
			if stopped then return end
			stopped = true
			for _, connection in ipairs(connections) do connection:Disconnect() end
			-- A cached track may already belong to a newer emote. Never reset it here.
			if character:GetAttribute("AuraWalkSession") == token then
				CollectionService:RemoveTag(character, TAG)
				character:SetAttribute("AuraWalkSession", nil)
				character:SetAttribute("AuraWalkSprinting", nil)
				character:SetAttribute("AuraWalkAnimationId", nil)
				track.Priority = oldPriority
				track.Looped = oldLooped
			end
			if rootMotor then rootMotor:Destroy() end
			if props then props:Destroy() end
			RS.Remotes.ClientEffects:FireAllClients(EFFECT, {
				Character = character, Status = "Stop", Session = token,
			})
		end
		-- Registered before creating anything so the existing setup-error handler cleans up.
		session:OnCleanup(cleanup)

		props = template:Clone()
		props.Name = "AuraWalkPlatforms"
		rootMotor = props:FindFirstChild("RootMotor")
		local platformRoot = props:FindFirstChild("PlatformRoot", true)
		assert(rootMotor and rootMotor:IsA("Motor6D") and platformRoot,
			"PlatformRig must contain RootMotor and PlatformRoot")
		rootMotor.Name = "PlatformRoot"
		rootMotor.Part0 = root
		rootMotor.Part1 = platformRoot
		rootMotor.Transform = CFrame.identity
		local motors = {rootMotor}
		for _, item in ipairs(props:GetDescendants()) do
			if item:IsA("BasePart") then
				item.Anchored = false
				item.Massless = true
				item.CanCollide = false
				item.CanTouch = false
				-- Visible platforms remain queryable for marker-driven footstep raycasts.
				item.CanQuery = item.Transparency < 1
			elseif item:IsA("Motor6D") and item ~= rootMotor then
				item.Transform = CFrame.identity
				table.insert(motors, item)
			end
		end
		-- Put the cloned parts at this character, never at the editor rig's position.
		local positioned = {[root] = true}
		for _ = 1, #motors do
			for _, motor in ipairs(motors) do
				if motor.Part0 and motor.Part1 and positioned[motor.Part0] then
					motor.Part1.CFrame = motor.Part0.CFrame * motor.C0 * motor.C1:Inverse()
					positioned[motor.Part1] = true
				end
			end
		end
		props.Parent = character
		rootMotor.Parent = root

		character:SetAttribute("DefaultWalkSpeed", WALK_SPEED)
		character:SetAttribute("DefaultRunSpeed", RUN_SPEED)
		character:SetAttribute("DefaultJumpPower", 0)
		character:RemoveTag("CantRotate")
		humanoid.WalkSpeed = WALK_SPEED
		humanoid.JumpPower = 0
		character:SetAttribute("AuraWalkAnimationId", emote.AnimationId)
		character:SetAttribute("AuraWalkSprinting", false)
		character:SetAttribute("AuraWalkSession", token)
		CollectionService:AddTag(character, TAG)

		track.Priority = Enum.AnimationPriority.Action4
		track.Looped = true
		-- Use the session's existing track; don't load a second copy.
		track:Play(0.15, 1, 1)

		local music = assets:FindFirstChild("Music")
		if music and music:IsA("Sound") then
			local sound = session:AddAsset(music:Clone())
			sound.PlayOnRemove = false
			sound.Looped = true
			sound.Parent = root
			sound:Play()
		end

		local function cancel()
			if stopped then return end
			-- The central Emotes script receives Stopped and restores normal movement.
			track:Stop(0)
			cleanup()
		end
		table.insert(connections, humanoid.Died:Connect(cancel))
		table.insert(connections, character.AncestryChanged:Connect(function()
			if not character:IsDescendantOf(workspace) then cancel() end
		end))
		local elapsed = 0
		table.insert(connections, RunService.Heartbeat:Connect(function(dt)
			if stopped or session.ended then return end
			elapsed += dt
			if elapsed < 0.1 then return end
			elapsed = 0
			if character:GetAttribute("AuraWalkSession") ~= token then cleanup(); return end
			if humanoid.Health <= 0 or character:HasTag("Stunned")
				or character:FindFirstChild("Stunned") or character:HasTag("Ragdolled")
				or character:GetAttribute("Ragdolled") == true then
				cancel()
				return
			end
			local velocity = root.AssemblyLinearVelocity
			local speed = Vector3.new(velocity.X, 0, velocity.Z).Magnitude
			local state = humanoid:GetState()
			local grounded = state ~= Enum.HumanoidStateType.Freefall
				and state ~= Enum.HumanoidStateType.Jumping
			local sprinting = grounded and speed >= SPRINT_THRESHOLD and speed <= RUN_SPEED * 1.6
			if character:GetAttribute("AuraWalkSprinting") ~= sprinting then
				character:SetAttribute("AuraWalkSprinting", sprinting)
			end
			-- The emote also plays in place; walking/running changes its cadence.
			track:AdjustSpeed(speed > 1 and math.clamp(speed / WALK_SPEED, 0.65, 1.8) or 1)
		end))
	end,

}