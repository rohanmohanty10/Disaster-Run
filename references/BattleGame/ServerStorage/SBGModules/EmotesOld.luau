--// Services \\--

local Players = game:GetService("Players")
local SvSt = game:GetService('ServerStorage')
local TS = game:GetService('TweenService')
local RS = game:GetService('ReplicatedStorage')
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")


--// Comunication \\--

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
local SoundsModule = require(SvModules.SoundsModule)
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
	
	["Saiyan Walk"] = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)


		table.insert(assets, SoundsModule:PlaySound(script["Saiyan Walk"].music, HumRP, 1, 1))

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	
	["Honored One"] = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)

		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })
			for _, v in assets do
				if v and v.Parent then v:Destroy() end
			end
			ReplicateSet:FireAllClients("Honored One", { Character = Character, Status = "Stop" })
		end)

		AnimationService:playAnimation(Character, Emote)
		
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = false; })
		table.insert(assets, SoundsModule:PlaySound(script["Honored One"].music, HumRP, 1, 1))
		ReplicateSet:FireAllClients("Honored One", { Character = Character, Status = "Play" })
	end,
	
	["Hakari"] = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)

		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })
			for _, v in assets do
				if v and v.Parent then v:Destroy() end
			end
			ReplicateSet:FireAllClients("Hakari", { Character = Character, Status = "Stop" })
		end)

		AnimationService:playAnimation(Character, Emote)
		
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = false; })  -- freeze; set WS>0 if it should move
		local musicFolder = script:FindFirstChild("Hakari")
		if musicFolder and musicFolder:FindFirstChild("music") then
			table.insert(assets, SoundsModule:PlaySound(musicFolder.music, HumRP, 1, 1))
		end
		ReplicateSet:FireAllClients("Hakari", { Character = Character, Status = "Play" })
	end,
	
	["Billy Bounce"] = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)

		AnimationService:playAnimation(Character, Emote)
		
		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
		table.insert(assets, SoundsModule:PlaySound(script["Billy Bounce"].music, HumRP, 1, 1))
	end,
	
	["Torture"] = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)


		table.insert(assets, SoundsModule:PlaySound(script["Torture"].music, HumRP, 1, 1))

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	
	["FreeStyle"] = function(Player: Player, Emote: Animation)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Emote)


		local assets = {}
		Track.Stopped:Once(function()
			TriggerHumanoid(Character, { RS = 25; WS = 16; JP = 50; AR = true; })

			for _,v in assets do
				if v and v.Parent then
					v:Destroy()
				end
			end
		end)


		table.insert(assets, SoundsModule:PlaySound(script["FreeStyle"].music, HumRP, 1, 1))

		AnimationService:playAnimation(Character, Emote)

		TriggerHumanoid(Character, { RS = 0; WS = 0; JP = 0; AR = true; })
	end,
	

	
}