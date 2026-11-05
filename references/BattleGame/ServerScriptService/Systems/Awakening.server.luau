--Services
local SvSt = game:GetService('ServerStorage')
local ServerScriptService = game:GetService("ServerScriptService")
local RS = game:GetService('ReplicatedStorage')
local TS = game:GetService('TweenService')
local Debris = game:GetService('Debris')
local RNS = game:GetService("RunService")
local Players = game.Players



--Assets
local Assets = SvSt.Assets
local Animations = Assets.Animations
local Sounds = RS.Assets.Sounds


--Modules
local RpModules = RS.Modules

local InfoModule = require(RS.Info)


local SvModules = SvSt.SBGModules

local StunHandler = require(SvModules.StunHandler)
local SoundsModule = require(SvModules.SoundsModule)
local HitboxHandler = require(SvModules.HitboxHandler)
local DamageHandler = require(SvModules.DamageHandler)
local AnimationService = require(SvModules.AnimationService)
local iFramesHandler = require(SvModules.iFramesService)
local MovesetHandler = require(SvModules.MovesetHandler)
local RagdollHandler = require(SvModules.RagdollHandler)
local NewKnockback = require(SvModules.BodymoverService)
local CollisionsModule = require(SvModules.CollisionsModule)

local SoundHandler = require(RS.Modules.SoundHandler)
local Velocity = require(RS.Modules.Velocity)

local ServerScriptService = game:GetService("ServerScriptService")

local CharacterAppearance = require(ServerScriptService.Data.DataInit.Modules.CharacterAppearance)

--Remotes
local RpRemotes = RS.Remotes

local Comms = RpRemotes.Comunicator

local CommsSet = Comms.Set
local CommsGet = Comms.Get

local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)
local TweenCreate = Essentials.Tween     -- re-exported from Essentials

--Functions
local function EndAwakening(Player: Player, Character: Model, Awk0C: RBXScriptConnection, AwkTween: Tween, ByPass: BoolValue)	
	if not Player or not Player.Parent then return end
	if not Character or not Character.Parent then return end

	local Humanoid: Humanoid = Character:FindFirstChild("Humanoid")
	local HumRP: BasePart = Character:FindFirstChild("HumanoidRootPart")


	if AwkTween and AwkTween.PlaybackState ~= Enum.PlaybackState.Completed then
		--ReplicateSet:FireAllClients('StopAwakeningMusics', { MusAtt = HumRP.AwakeningMusic; })
	end

	if Awk0C then
		Awk0C:Disconnect()
		Awk0C = nil
	end

	if AwkTween then
		AwkTween:Cancel()
		AwkTween = nil
	end
	
	local ultimateTime = InfoModule.Movesets[Player:GetAttribute("Character")].UltimateTime
	if ultimateTime == 0 and not Player.Commands.InfiniteAwk.Value then
		local AwkProgressObj: NumberValue = Player.AwakeningProgress

		AwkProgressObj.Value = 0
	end
		
	if Character and Character.Parent then
		Character:SetAttribute("Awakened", nil)
		Character:SetAttribute("AwakeningAura", false)
		
		local CurrentMoveset: string = Player:GetAttribute("Character")

		task.spawn(function()
			CharacterAppearance.Apply(Player, Character)
		end)

		MovesetHandler:AddBaseMoveset(Player, CurrentMoveset)
	end

	CommsSet:FireClient(Player, 'ShowHotbar')
	CommsSet:FireClient(Player, 'ShowAwkbar')
end

local AwakeningAnimations = {
	
	--[[
	["KJ"] = function(Player: Player)
		local Character = Player.Character


		if not Character then return end


		local Stun = StunHandler:Stun(Character, nil, true)


		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		
		if Humanoid.MoveDirection.Magnitude > 0 then
			local AnimTrack, AnimEvents = AnimationService:getAnimationTrack(Character, AwkAnims.KJ.Walking)

			AnimEvents["End"] = AnimTrack:GetMarkerReachedSignal("End"):Once(function()
				ReplicateSet:FireAllClients('Awakening', { Char = Character, Awk = 'KJ', Stage = 'End' })

				AddAwakeningOutfit(Player, 'KJ')
			end)

			AnimTrack.Stopped:Once(function()
				StunHandler:Unstun(Character, Stun)
			end)


			local SFX = AwkSounds.KJ.Walking.SFX:Clone()
			SFX.SoundGroup = game.SoundService.Sounds
			SFX.Parent = HumRP
			SFX:Play()
			Debris:AddItem(SFX, SFX.TimeLength + 1)

			local Voice = AwkSounds.KJ.Walking.Voice:Clone()
			Voice.SoundGroup = game.SoundService.Sounds
			Voice.Parent = HumRP
			Voice:Play()
			Debris:AddItem(Voice, Voice.TimeLength + 1)

			ReplicateSet:FireAllClients('PlayAwakeningMusic', { MusAtt = HumRP.AwakeningMusic; Id = AwkSounds.KJ.Walking.Music.SoundId; })

			AnimationService:playAnimation(Character, AwkAnims.KJ.Walking)


			ReplicateSet:FireClient(Player, 'Awakening', { Char = Character, Awk = 'KJ', Stage = 'Start' })

			repeat task.wait() until AnimTrack.IsPlaying == false
		else
			local AnimTrack, AnimEvents = AnimationService:getAnimationTrack(Character, AwkAnims.KJ.Idle)

			AnimEvents["ParticleActivate"] = AnimTrack:GetMarkerReachedSignal("ParticleActivate"):Once(function()
				ReplicateSet:FireAllClients('Awakening', { Char = Character, Awk = 'KJ', Stage = 'StartIdle' })
			end)

			AnimEvents["StartLoop"] = AnimTrack:GetMarkerReachedSignal("StartLoop"):Once(function()
				ReplicateSet:FireAllClients('Awakening', { Char = Character, Awk = 'KJ', Stage = 'IdleEnd' })

				AddAwakeningOutfit(Player, 'KJ')
			end)

			AnimTrack.Stopped:Once(function()
				StunHandler:RemoveAllStuns(Character, Stun)
			end)


			local SFX = AwkSounds.KJ.Idle.SFX:Clone()
			SFX.SoundGroup = game.SoundService.Sounds
			SFX.Parent = HumRP
			SFX:Play()
			Debris:AddItem(SFX, SFX.TimeLength + 1)

			ReplicateSet:FireAllClients('PlayAwakeningMusic', { MusAtt = HumRP.AwakeningMusic; Id = AwkSounds.KJ.Idle.Music.SoundId; })

			AnimationService:playAnimation(Character, AwkAnims.KJ.Idle)

			repeat task.wait() until AnimTrack.IsPlaying == false
		end
	end,
	
	["Martial Artist"] = function(Player: Player)
		local Character: Model = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid


		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		iFramesHandler:AddAlliFrames(Character)
		Character:AddTag("CantRotate")


		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, AwkAnims.Suiryu.Start)

		ReplicateSet:FireAllClients("suiryuawakening", { Char = Character, cfr = HumRP.CFrame * CFrame.new(-0.0033507347106933594, 0.000732421875, 0.00286865234375, 1.0000001192092896, -4.0216292518380214e-08, -0.000031771138310432434, 4.021450550339978e-08, 1, -5.632735877725281e-08, 0.000031771138310432434, 5.6326076247614765e-08, 1.0000001192092896), sound = Instance.new("Sound") })
		ReplicateSet:FireAllClients("PlayAwakeningMusic", { MusAtt = HumRP.AwakeningMusic, Id = AwkSounds.Suiryu.Music.SoundId, Volume = AwkSounds.Suiryu.Music.Volume })

		task.wait(0.75)


		local OriginalTransparencies = {}
		for _, Part in Character:GetDescendants() do
			if Part:IsA("BasePart") or Part:IsA("Decal") then
				OriginalTransparencies[Part] = Part.Transparency
				Part.Transparency = 1
			end
		end


		task.wait(3.85)


		ReplicateSet:FireAllClients("suiryuawakeningaura", Character)
		AddAwakeningOutfit(Player, 'Martial Artist')
		
		for _, Part in Character:GetDescendants() do
			if Part:IsA("BasePart") or Part:IsA("Decal") then
				Part.Transparency = OriginalTransparencies[Part]
			end
		end

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, AwkAnims.Suiryu.End)


		HitboxHandler:SimpleOnce(HumRP, Vector3.new(100, 100, 100), CFrame.new(0, 47, 0), { Character }, nil, nil, function(EnemyCharacter: Model)
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
			local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid

			if iFramesHandler:HasiFrame(EnemyCharacter, "Awakenings") then return end
			
			
			DamageHandler:TakeDamage(Character, EnemyHumanoid, 20, nil, nil, false, false, true, false, true)
			RagdollHandler.ragdoll(EnemyHumanoid, 2)
			NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 100000, 100000), Velocity = -CFrame.lookAt(EnemyHumRP.Position, HumRP.Position).LookVector * 50 + Vector3.new(0, 25, 0) })
		end)


		task.wait(1.4)


		StunHandler:Unstun(Character, Stun)
		iFramesHandler:RemoveAlliFrames(Character)
		Character:RemoveTag("CantRotate")
	end,
	
	["Turbo Kun"] = function(Player: Player)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid


		local Stun = StunHandler:Stun(Character, nil)
		local CartoonVariant = math.random(1, 3) == 1

		iFramesHandler:AddAlliFrames(Character)

		local function AddMask()
			local Mask = RS.Resources.Okarun.awakening.OkarunMask:Clone()
			Mask.Parent = Character
			Mask.Weld.Part0 = Character.Head
		end



		local Animation = (CartoonVariant and AwkAnims.Okarun.Cartoon or AwkAnims.Okarun.Animation)
		local animationTrack = AnimationService:getAnimationTrack(Character, Animation)
		local AnimationEvents = {}

		if CartoonVariant then
			AnimationEvents["1"] = animationTrack:GetMarkerReachedSignal("1"):Once(function()
				StunHandler:Unstun(Character, Stun)

				local MainCF = HumRP.CFrame

				RagdollHandler.ragdoll(Humanoid, 1)
				NewKnockback:Knockback(Character, { KnockbackType = "Velocity", MaxForce = Vector3.new(75000, 75000, 75000), Velocity = HumRP.CFrame.LookVector * 75 + Vector3.new(0, 10, 0) })

				ReplicateSet:FireAllClients("turboawakening", { Stage = "CartoonHeadbutt", Char = Character, MainCF = MainCF })
			end)

			AddMask()

		else
			AnimationEvents["Mask"] = animationTrack:GetMarkerReachedSignal("Mask"):Once(AddMask)

			AnimationEvents["Cutscene"] = animationTrack:GetMarkerReachedSignal("Cutscene"):Once(function()
				Character:AddTag("CantRotate")
				AddAwakeningOutfit(Player, "Turbo Kun")
			end)

		end

		animationTrack.Stopped:Once(function()
			for _,v in AnimationEvents do
				v:Disconnect()
			end


			if not CartoonVariant then
				Character:RemoveTag("CantRotate")
			end

			StunHandler:Unstun(Character, Stun)
		end)

		AnimationService:playAnimation(Character, Animation)


		ReplicateSet:FireAllClients('PlayAwakeningMusic', { MusAtt = HumRP.AwakeningMusic; Id = AwkSounds.Okarun.Music.SoundId; })
		ReplicateSet:FireAllClients("turboawakening", { Stage = (CartoonVariant and "Cartoon" or "Normal"), Char = Character })

		SoundsModule:PlaySound((CartoonVariant and AwkSounds.Okarun.Cartoon_SFX or AwkSounds.Okarun.SFX), HumRP)



		repeat task.wait() until animationTrack.IsPlaying == false
	end,
	
	["The Frozen Soul"] = function(Player: Player)
		local Character = Player.Character
		local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
		local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart')

		if not Humanoid or not HumRP then return end
		local Ended = false
		
		
		iFramesHandler:AddAlliFrames(Character)
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		
		
		local UserAnimation = AwkAnims.Subzero.User
		local UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
		local UserEvents = {}
		
		
		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Vector3.new(500000, 0, 500000)
		BodyVelocity.Name = "moveme"
		BodyVelocity:SetAttribute("End", 1)
		BodyVelocity:SetAttribute("Goto", nil)
		
		
		local Sword = Assets.Models.Weapons.Subzero.Blade:Clone()
		Sword.Parent = Character
		Sword.Blade.Part0 = Character['Right Arm']
		
		
		UserEvents["slash"] = UserTrack:GetMarkerReachedSignal("slash"):Connect(function()
			BodyVelocity:SetAttribute("Goto", 50)
			BodyVelocity.Parent = HumRP
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP.CFrame
			Hitbox.Size = Vector3.new(45,45,45)
			Hitbox.Offset = CFrame.new(0, 0, -Hitbox.Size.Z/2)
			Hitbox.Ignore = { Character }
			Hitbox.DestroyAmbient = { Owner = Player, Velocity = -HumRP.CFrame.LookVector * Vector3.new(45,45,45) + Vector3.new(0, 25, 0) }
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if iFramesHandler:HasiFrame(EnemyCharacter, "Awakenings") or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 5.5, nil, nil, true, false, true, true, true, nil, nil)

				if HitInfo.Blocked == true then
					return
				end

				local LookVector = -CFrame.lookAt(EnemyHumRP.Position, HumRP.Position).LookVector


				RagdollHandler.ragdoll(EnemyHumanoid, 2)
				NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity', MaxForce = Vector3.new(1, 1, 1) * math.huge, Velocity = Vector3.new(LookVector.X * 30, 45, LookVector.Z * 30) })
			end
			
			Hitbox:Once()
			Hitbox:Destroy()
		end)
		
		UserEvents["heavyslash"] = UserTrack:GetMarkerReachedSignal("heavyslash"):Once(function()
			BodyVelocity:Destroy()
			Sword:Destroy()
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP.CFrame
			Hitbox.Size = Vector3.new(1,1,1) * 60
			Hitbox.Ignore = { Character }
			Hitbox.DestroyAmbient = { Owner = Player, Velocity = -HumRP.CFrame.LookVector * Vector3.new(1,1,1) * 60 + Vector3.new(0, 25, 0) }
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if iFramesHandler:HasiFrame(EnemyCharacter, "Awakenings") or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 18, nil, nil, true, false, true, true, true, nil, nil)

				if HitInfo.Blocked == true then
					return
				end

				local LookVector = -CFrame.lookAt(EnemyHumRP.Position, HumRP.Position).LookVector


				RagdollHandler.ragdoll(EnemyHumanoid, 2)
				NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity', MaxForce = Vector3.new(1, 1, 1) * math.huge, Velocity = Vector3.new(LookVector.X * 50, 75, LookVector.Z * 50) })
			end
			
			Hitbox:Once()
			Hitbox:Destroy()
			
			SoundsModule:PlaySound(AwkSounds.Subzero.Final, HumRP)
		end)
		
		
		UserTrack.Stopped:Once(function()
			for _,v in UserEvents do
				v:Disconnect()
			end
			
			BodyVelocity:Destroy()
			
			iFramesHandler:RemoveAlliFrames(Character)
			StunHandler:Unstun(Character, Stun)
			Ended = true
			
			task.delay(1, function()
				Player.AwakeningProgress.Value = 0
			end)
		end)
		
		
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, UserAnimation)
		
		ReplicateSet:FireAllClients("frozenAwakening", { Char = Character, Anim = UserAnimation.AnimationId, bv = BodyVelocity, Sword = Sword })
		
		SoundsModule:PlaySound(AwkSounds.Subzero.Spear, Sword)
		SoundsModule:PlaySound(AwkSounds.Subzero.Barrage, HumRP)
		
		repeat task.wait() until Ended == true
	end,
	
	["The Strongest Hero"] = function(Player: Player)
		local Character = Player.Character
		local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
		local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart')

		if not Humanoid or not HumRP then return end
		local Ended = false


		iFramesHandler:AddAlliFrames(Character)
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)


		local UserAnimation = AwkAnims["The Strongest Hero"].User
		local UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
		local UserEvents = {}
		
		
		UserEvents["start"] = UserTrack:GetMarkerReachedSignal("start"):Once(function()
			ReplicateSet:FireAllClients("baldAwakening", { Char = Character })
			ReplicateSet:FireClient(Player, "ShakeCamera", { Intensity = 5 })
			
			Character:SetAttribute("BaldAwakenPassive", true)
			
			AddAwakeningOutfit(Player, 'The Strongest Hero')
		end)
		
		
		UserTrack.Stopped:Once(function()
			for _,v in UserEvents do
				v:Disconnect()
			end
			
			iFramesHandler:RemoveAlliFrames(Character)
			StunHandler:Unstun(Character, Stun)
			Ended = true
		end)
		
		
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, UserAnimation)
		
		SoundsModule:PlaySound(AwkSounds["The Strongest Hero"].User, HumRP)
		
		repeat task.wait() until Ended == true
	end,
	
	["Cursed Child"] = function(Player: Player)
		local Character = Player.Character
		local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
		local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart')

		if not Humanoid or not HumRP then return end
		local Ended = false
		local Variant = false
		if Humanoid.Health <= 40 then
			Variant = true
		end


		iFramesHandler:AddAlliFrames(Character)
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		Character:AddTag("CantRotate")
		
		
		local UserAnimation = (Variant and AwkAnims["Cursed Child"]["User Variant"] or AwkAnims["Cursed Child"].User)
		local UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
		local UserEvents = {}
		
		local Music = (Variant and AwkSounds["Cursed Child"].MusicVariant or AwkSounds["Cursed Child"].Music)
		TS:Create(Music, TweenInfo.new(0.25), {
			Volume = 0.75
		}):Play()
		
		
		UserTrack.Stopped:Once(function()
			for _,v in UserEvents do
				v:Disconnect()
			end

			Character:RemoveTag("CantRotate")
			iFramesHandler:RemoveAlliFrames(Character)
			StunHandler:Unstun(Character, Stun)
			Ended = true

			AddAwakeningOutfit(Player, 'Cursed Child')
			Humanoid.Health = Humanoid.MaxHealth
			
			Character:SetAttribute("AwakeningAura", true)
		end)


		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, UserAnimation)
		
		
		ReplicateSet:FireAllClients("CharaAwakening", { Stage = "Start", Variant = Variant, Char = Character, AwakeninAnimation = UserAnimation.AnimationId })
		ReplicateSet:FireAllClients('PlayAwakeningMusic', { MusAtt = HumRP.AwakeningMusic, Id = Music.SoundId })
		
		repeat task.wait() until Ended == true
	end,
	
	["Black"] = function(Player: Player)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		
		
		local VfxUtility = ServicesModule:GetService("VFX_Utility")
		local KnockbackService = ServicesModule:GetService("KnockbackService")
		local Clock = ServicesModule:GetService("Clock")
		
		
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local Ended = false
		
		
		Character:AddTag("CantRotate")
		iFramesHandler:AddAlliFrames(Character)
		
		
		local UserAnimation = AwkAnims.Black.Main
		local UserTrack, UserEvents = AnimationService:getAnimationTrack(Character, UserAnimation)
		
		
		local Sphere = RS.Resources.Black.Awakening.Mutation.Rigs.MutatedSphere:Clone()
		Debris:AddItem(Sphere, 5.918)
		Sphere.Sphere.Transparency = 1
		Sphere.Parent = workspace.Thrown
		task.delay(2.8, function()
			Sphere.Sphere.Transparency = 0
		end)
		
		
		local StartTime = Clock.get()
		
		local Wings = Assets.Models.Black.WingsModel:Clone()
		Debris:AddItem(Wings, 7.75)

		for _, v in Wings.Trails:GetChildren() do
			if v:IsA("Trail") then
				v.Enabled = false
			end
		end
		
		Wings.Wings.Transparency = 1
		Wings.Parent = Character
		Wings:PivotTo(Character.Torso.CFrame)
		
		
		local WingsWeld = Wings.Wings.Wings
		Debris:AddItem(WingsWeld, 7.75)
		WingsWeld.Parent = HumRP
		WingsWeld.Part0 = Character.Torso

		task.delay(7.65, function()
			for _, v in Wings.Trails:GetChildren() do
				if v:IsA("Trail") then
					v.Enabled = false
				end
			end
		end)
		
		
		UserEvents["ball_spawn"] = UserTrack:GetMarkerReachedSignal("ball_spawn"):Connect(function()
			HumRP.CFrame = CFrame.new(HumRP.Position, HumRP.Position + HumRP.CFrame.LookVector * Vector3.new(1, 0, 1))
			BodyAuras.LoadAura(RS.Resources.Black.VFX.Core.AwakeningAura, Character)
			
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(38, 38, 38)
			Hitbox.DestroyAmbient = { Owner = Player, Velocity = -HumRP.CFrame.LookVector * Vector3.new(38, 38, 38) + Vector3.new(0, 25, 0) }
			Hitbox.Ignore = { Character }
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				if iFramesHandler:HasiFrame(EnemyCharacter, "Awakenings") or EnemyCharacter:FindFirstChild("Ragdolled") then return end
				
				
				DamageHandler:TakeDamage(Character, EnemyHumanoid, 13.7, 2, nil, false, false, false, false, true, nil, nil)
				RagdollHandler.ragdoll(EnemyHumanoid, 2)
				local KnockbackData = {
					["duration"] = 0.15,
					["force"] = 20,
					["direction"] = CFrame.new(HumRP.Position, EnemyCharacter.PrimaryPart.Position).LookVector + Vector3.new(0, 1.5, 0)
				}
				KnockbackService.Knockback(EnemyCharacter.PrimaryPart, KnockbackData)
			end
			
			Hitbox:Start()
			
			task.wait(3.1)
			
			Hitbox:Destroy()
		end)
		
		UserEvents["wings_appear"] = UserTrack:GetMarkerReachedSignal("wings_appear"):Connect(function()
			for _, v in Wings.Trails:GetChildren() do
				if v:IsA("Trail") then
					v.Enabled = true
				end
			end
			
			Wings.Wings.Transparency = 0
			
			local RemoteConnection = nil
			local Landed = false
			
			RemoteConnection = AwakeningRemotes.BlackAwakening.OnServerEvent:Connect(function(plr, req, data)
				if plr.UserId == Player.UserId then
					if RemoteConnection then
						RemoteConnection:Disconnect()
						RemoteConnection = nil
					end
					
					if not Landed then
						Landed = true
						
						if req == "db_t" then
							ReplicateSet:FireAllClients("Mutation", { Char = Character, Stage = "divebomb", posData = data })
							
							local ClockTime = Clock.get(data.st)
							local task_delay = task.delay
							local timer = 0.3 - ClockTime
							
							task_delay(math.max(timer, 0), function()
								local Hitbox = HitboxHandler.new()
								Hitbox.Instance = CFrame.new(data.pos)
								Hitbox.Size = Vector3.new(120, 120, 120)
								Hitbox.Ignore = { Character }
								Hitbox.DestroyAmbient = { Owner = Player, Velocity = Hitbox.Instance.LookVector * Vector3.new(120, 120, 120) + Vector3.new(0, 25, 0) }
								Hitbox.onTouch = function(EnemyCharacter)
									local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
									local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
									if iFramesHandler:HasiFrame(EnemyCharacter, "Awakenings") or EnemyCharacter:FindFirstChild("Ragdolled") then return end
									
									DamageHandler:TakeDamage(Character, EnemyHumanoid, 37.5, 2, nil, false, false, false, false, true, nil, nil)
									RagdollHandler.ragdoll(EnemyHumanoid, 2)
									local KnockbackData = {
										["duration"] = 0.25,
										["force"] = 40,
										["direction"] = CFrame.new(data.pos, EnemyCharacter.PrimaryPart.Position).LookVector + Vector3.new(0, 1.7, 0)
									}
									KnockbackService.Knockback(EnemyCharacter.PrimaryPart, KnockbackData)
								end
								
								Hitbox:Once()
								Hitbox:Destroy()
							end)
						end
					end
				end
			end)
			
			task.delay(1.2, function()
				if RemoteConnection then
					RemoteConnection:Disconnect()
					RemoteConnection = nil
				end
			end)
		end)
		
		
		local AnimationsContainer = {}
		for i = 1, 4 do
			local MutatedArm = RS.Resources.Black.Awakening.Mutation.Rigs["MutatedArm" .. i]:Clone()
			Debris:AddItem(MutatedArm, 2.79)
			MutatedArm.Arm.Transparency = 1
			MutatedArm.Parent = workspace.Thrown
			MutatedArm.PrimaryPart.CFrame = HumRP.CFrame * MutatedArm.PrimaryPart.Weld.C0
			MutatedArm.PrimaryPart.Weld.Part0 = HumRP
			
			task.delay(1.617, function()
				MutatedArm.Arm.Transparency = 0
			end)
			
			local ArmAnimation = MutatedArm.AnimationController.Animator:LoadAnimation(AwkAnims.Black["Arm" .. i])
			ArmAnimation:Play(0)
			AnimationsContainer[#AnimationsContainer + 1] = ArmAnimation
		end
		
		coroutine.wrap(function()
			local SphereAnimation = Sphere.AnimationController.Animator:LoadAnimation(AwkAnims.Black.Sphere)
			SphereAnimation:Play(0)
			AnimationsContainer[#AnimationsContainer + 1] = SphereAnimation
			
			coroutine.wrap(function()
				while true do
					for v, track in AnimationsContainer do
						if track.IsPlaying then
							SphereAnimation.TimePosition = Clock.get() - StartTime
						else
							AnimationsContainer[v] = nil
						end
					end
					
					RNS.Heartbeat:Wait()
					
					if Clock.get() - StartTime >= 8.57 then
						return
					end
				end
			end)()
			
			local startTime = tick()
			
			while Sphere and Sphere.PrimaryPart do
				Sphere.PrimaryPart.CFrame = HumRP.CFrame * Sphere.PrimaryPart.Weld.C0
				
				RNS.Heartbeat:Wait()
				
				if tick() - startTime >= 5.9 then
					return
				end
			end
		end)()
		
		
		UserTrack.Stopped:Connect(function()
			Ended = true

			Character:RemoveTag("CantRotate")
			iFramesHandler:RemoveAlliFrames(Character)
			StunHandler:Unstun(Character, Stun)
			
			HumRP.Anchored = false
		end)
		
		
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, UserAnimation)
		
		ReplicateSet:FireAllClients('PlayAwakeningMusic', { MusAtt = HumRP.AwakeningMusic, Id = AwkSounds.Black.Music.SoundId })
		AddAwakeningOutfit(Player, "Black")
		ReplicateSet:FireAllClients("Mutation", { Char = Character, Stage = "pa", mutatedSphere = Sphere, Animation = UserAnimation.AnimationId })
		
		repeat task.wait() until Ended == true
	end,
	
	["Hero Hunter"] = function(Player: Player)
		local Character = Player.Character
		local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
		local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart')

		if not Humanoid or not HumRP then return end
		local Ended = false
		
		
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		iFramesHandler:AddAlliFrames(Character)
		
		
		local UserAnimation = AwkAnims["Hero Hunter"].User
		local UserTrack, UserEvents = AnimationService:getAnimationTrack(Character, UserAnimation)
		
		
		local function DistanceShake()
			if Player:DistanceFromCharacter(HumRP.Position) > 200 then
				return nil
			end
			
			ReplicateSet:FireAllClients("ShakeCamera", { Intensity = 14 })
		end
		
		table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("slam"):Once(function()
			DistanceShake()
			SoundsModule:PlaySound(AwkSounds["Hero Hunter"].Slam, Character.Torso)
			ReplicateSet:FireAllClients("BigSlam", { Seed = math.random(1, 2000000000), CFrame = HumRP.CFrame, Hunter = true })
			
			HitboxHandler:SimpleOnce(HumRP, Vector3.new(200, 200, 200), CFrame.new(0, 0, 0), { Character }, nil, nil, function(EnemyCharacter: Model)
				local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				
				if iFramesHandler:HasiFrame(EnemyCharacter, "Awakenings") then return end
				
				local damageMultiplier = math.clamp(1 + (200 - (HumRP.Position - EnemyHumRP.Position).Magnitude) / 200, 0.5, 2)
				local DamageUlt = 6 * damageMultiplier
				
				
				DamageHandler:TakeDamage(Character, EnemyHumanoid, DamageUlt, nil, nil, false, false, false, false, true, nil, nil)
				RagdollHandler.ragdoll(EnemyHumanoid, 3)
				NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(1, 1, 1, 0) * 40000, Velocity = EnemyHumRP.CFrame.UpVector * math.random(100, 150), Time = 0.2 })
			end)
			
			AddAwakeningOutfit(Player, 'Hero Hunter')
		end))
		
		
		task.delay(3.4, function()
			SoundsModule:PlaySound(AwkSounds["Hero Hunter"]["Blood Swipe"], Character.Head)
		end)
		
		
		UserTrack.Stopped:Once(function()
			Character:RemoveTag("CantRotate")
			iFramesHandler:RemoveAlliFrames(Character)
			StunHandler:Unstun(Character, Stun)
			Ended = true
		end)
		
		
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, UserAnimation)
		
		ReplicateSet:FireAllClients("HunterAwakening", { Char = Character })
		ReplicateSet:FireAllClients('PlayAwakeningMusic', { MusAtt = HumRP.AwakeningMusic, Id = AwkSounds["Hero Hunter"].Music.SoundId })
		
		SoundsModule:PlaySound(AwkSounds["Hero Hunter"]["Blood Drop"], Character.Head)
		
		repeat task.wait() until Ended == true
	end,
	
	["Monster Form"] = function(Player: Player)
		local Character = Player.Character
		local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
		local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart')

		if not Humanoid or not HumRP then return end
		local Ended = false


		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		iFramesHandler:AddAlliFrames(Character)
		Character:AddTag("CantRotate")


		local UserAnimation = AwkAnims["Hero Hunter"]["Monster Form"].User
		local UserTrack, UserEvents = AnimationService:getAnimationTrack(Character, UserAnimation)
		
		
		local Music = AwkSounds["Hero Hunter"]["Monster Form"]["Music First"]:Clone()
		Music.SoundGroup = game.SoundService.Sounds
		Music.Parent = HumRP
		Music:Play()
		Debris:AddItem(Music, Music.TimeLength + 1)
		
		Music.Ended:Once(function()
			ReplicateSet:FireAllClients('PlayAwakeningMusic', { MusAtt = HumRP.AwakeningMusic, Id = AwkSounds["Hero Hunter"]["Monster Form"].Music.SoundId })
		end)
		
		
		local SmashCount = 0
		local HitboxSize = Vector3.new(0, 0, 0)
		
		
		table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("smash"):Connect(function()
			SmashCount = SmashCount + 1
			
			if SmashCount == 1 then
				HitboxSize = Vector3.new(110, 110, 110)
				
			elseif SmashCount == 2 then
				HitboxSize = Vector3.new(155, 155, 155)
				
			elseif SmashCount == 3 then
				HitboxSize = Vector3.new(190, 190, 190)
			
				AddAwakeningOutfit(Player, 'Hero Hunter')
				Character:SetAttribute("AwakeningAura", true)
			end
			
			local VoxelParameters = {
				Velocity = HumRP.CFrame.UpVector,
				Multiplier = { 5, 10 },
				Size = HitboxSize,
				CFrame = HumRP.CFrame * CFrame.new(0, 0, 0)
			}
			
			local DestroyParams = {
				Owner = Player,
				Velocity = -HumRP.CFrame.LookVector * HitboxSize + Vector3.new(0, 25, 0)
			}
			
			HitboxHandler:SimpleOnce(HumRP, HitboxSize, CFrame.new(0, 0, 0), { Character }, nil, nil, function(EnemyCharacter: Model)
				local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if iFramesHandler:HasiFrame(EnemyCharacter, "Awakenings") then return end

				local damageMultiplier = math.clamp(1 + (200 - (HumRP.Position - EnemyHumRP.Position).Magnitude) / 200, 0.5, 2)
				local DamageUlt = 6 * damageMultiplier


				DamageHandler:TakeDamage(Character, EnemyHumanoid, DamageUlt, nil, nil, false, false, false, false, true, nil, nil)
				RagdollHandler.ragdoll(EnemyHumanoid, 2.5)
				NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(1, 1, 1, 0) * 40000, Velocity = EnemyHumRP.CFrame.UpVector * math.random(20, 40), Time = 0.2 })
			end, DestroyParams, VoxelParameters)
		end))
		
		
		UserTrack.Stopped:Once(function()
			Character:RemoveTag("CantRotate")
			iFramesHandler:RemoveAlliFrames(Character)
			StunHandler:Unstun(Character, Stun)
			Ended = true
		end)


		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, UserAnimation, 1.2)
		
		
		ReplicateSet:FireAllClients("MonsterAwakening", { Char = Character })
		
		SoundsModule:PlaySound(AwkSounds["Hero Hunter"]["Monster Form"].Outside, HumRP)
		
		repeat task.wait() until Ended == true
	end,
	
	["Frozen Warrior"] = function(Player: Player)
		local Character = Player.Character
		local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
		local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart')
		
		if not Humanoid or not HumRP then return end
		local Ended = false
		
		
		local KnockbackService = ServicesModule:GetService("KnockbackService")
		
		
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		iFramesHandler:AddAlliFrames(Character)
		Character:AddTag("CantRotate")
		
		
		local UserAnimation = AwkAnims["Frozen Warrior"].Main
		local UserTrack, UserEvents = AnimationService:getAnimationTrack(Character, UserAnimation)
		
		
		local IceBall = Assets.Models.Frozen.IceBall:Clone()
		Debris:AddItem(IceBall, 12)
		IceBall.CFrame = HumRP.CFrame
		IceBall.IceBallBone.Part0 = HumRP
		IceBall.Transparency = 1
		IceBall.Parent = Character
		
		task.delay(1.8, function()
			if IceBall then
				IceBall.Transparency = 0
			end
		end)
		
		task.delay(4.75, function()
			if IceBall then
				IceBall.Transparency = 1
			end
		end)
		
		
		task.delay(0.883, function()
			local HitboxSize = Vector3.new(40, 40, 40)
			local VoxelParameters = {
				Velocity = HumRP.CFrame.UpVector,
				Multiplier = { 5, 10 },
				Size = HitboxSize,
				CFrame = HumRP.CFrame * CFrame.new(0, 0, 0)
			}
			local DestroyParams = {
				Owner = Player,
				Velocity = -HumRP.CFrame.LookVector * HitboxSize + Vector3.new(0, 25, 0)
			}
			
			HitboxHandler:SimpleOnce(CFrame.new(HumRP.Position), HitboxSize, nil, { Character }, nil, nil, function(EnemyCharacter: Model)
				local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if iFramesHandler:HasiFrame(EnemyCharacter, "Awakenings") then return end
				
				DamageHandler:TakeDamage(Character, EnemyHumanoid, 7, nil, nil, false, false, false, false, true, nil, nil)
				KnockbackService.Knockback(EnemyCharacter.PrimaryPart, {
					["duration"] = 0.15,
					["force"] = 28,
					["direction"] = Vector3.new(0, 1, 0)
				})
				RagdollHandler.ragdoll(EnemyHumanoid, 4)
			end, DestroyParams, VoxelParameters)
		end)
		
		task.delay(4.733, function()
			local HitboxSize = Vector3.new(40, 40, 40)
			local VoxelParameters = {
				Velocity = HumRP.CFrame.UpVector,
				Multiplier = { 5, 10 },
				Size = HitboxSize,
				CFrame = HumRP.CFrame * CFrame.new(0, 0, 0)
			}
			local DestroyParams = {
				Owner = Player,
				Velocity = -HumRP.CFrame.LookVector * HitboxSize + Vector3.new(0, 25, 0)
			}
			
			HitboxHandler:SimpleOnce(CFrame.new(HumRP.Position), HitboxSize, nil, { Character }, nil, nil, function(EnemyCharacter: Model)
				local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if iFramesHandler:HasiFrame(EnemyCharacter, "Awakenings") then return end

				DamageHandler:TakeDamage(Character, EnemyHumanoid, 8, nil, nil, false, false, false, false, true, nil, nil)
				KnockbackService.Knockback(EnemyCharacter.PrimaryPart, {
					["duration"] = 0.15,
					["force"] = 28,
					["direction"] = Vector3.new(0, 1, 0)
				})
				RagdollHandler.ragdoll(EnemyHumanoid, 3.5)
			end, DestroyParams, VoxelParameters)
		end)
		
		task.delay(6.25, function()
			local HitboxSize = Vector3.new(50, 150, 50)
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = CFrame.new(HumRP.Position + Vector3.new(0, 75, 0))
			Hitbox.Size = HitboxSize
			Hitbox.Ignore = { Character }
			Hitbox.DestroyAmbient = { Owner = Player, Velocity = -HumRP.CFrame.LookVector * HitboxSize + Vector3.new(0, 75, 0) }
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if iFramesHandler:HasiFrame(EnemyCharacter, "Awakenings") then return end

				DamageHandler:TakeDamage(Character, EnemyHumanoid, 10, nil, nil, false, false, false, false, true, nil, nil)
				local RandomValue = math.random(-1, 1)
				local RandomFunc = math.random
				local KnockbackParams = {
					["duration"] = 0.15,
					["force"] = 20,
					["direction"] = Vector3.new(RandomValue, 0, RandomFunc(-1, 1)) + Vector3.new(0, 1.5, 0)
				}
				KnockbackService.Knockback(EnemyCharacter.PrimaryPart, KnockbackParams)
				RagdollHandler.ragdoll(EnemyHumanoid, 2.5)
			end
			
			Hitbox:Start()
			
			task.wait(1.25)
			
			Hitbox:Destroy()
		end)
		
		task.delay(9.7, function()
			local HitboxSize = Vector3.new(185, 165, 185)
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = CFrame.new(HumRP.Position + Vector3.new(0, 82.5, 0))
			Hitbox.Size = HitboxSize
			Hitbox.Ignore = { Character }
			Hitbox.DestroyAmbient = { Owner = Player, Velocity = -HumRP.CFrame.LookVector * HitboxSize + Vector3.new(0, 82.5, 0) }
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid

				if iFramesHandler:HasiFrame(EnemyCharacter, "Awakenings") then return end

				DamageHandler:TakeDamage(Character, EnemyHumanoid, 25, nil, nil, false, false, false, false, true, nil, nil)
				local KnockbackParams = {
					["duration"] = 0.3,
					["force"] = math.random(70, 85),
					["direction"] = CFrame.new(HumRP.Position, EnemyCharacter.PrimaryPart.Position).LookVector + Vector3.new(0, 1, 0)
				}
				KnockbackService.Knockback(EnemyCharacter.PrimaryPart, KnockbackParams)
				RagdollHandler.ragdoll(EnemyHumanoid, 3)
			end

			Hitbox:Start()
			
			task.wait(2)
			
			Hitbox:Destroy()
		end)
		
		
		UserTrack.Stopped:Once(function()
			Character:RemoveTag("CantRotate")
			iFramesHandler:RemoveAlliFrames(Character)
			StunHandler:Unstun(Character, Stun)
			Ended = true
			
			task.delay(1, function()
				Player.AwakeningProgress.Value = 0
			end)
		end)
		
		
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, UserAnimation)
		
		ReplicateSet:FireAllClients("BelowZero", { Char = Character, Stage = "pa", iceball = IceBall })
		
		repeat task.wait() until Ended == true
	end,
	]]
	
	["Sanji"] = function(Player: Player)
		local Character = Player.Character
		local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
		local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart')
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		RpRemotes.Replicate.Set:FireAllClients("clearVelocities", { Char = Character })

		local AnimTrack, AnimEvents = AnimationService:getAnimationTrack(Character, SvSt.Assets.Animations.Sanji.Awakening)
		warn("Sanji Awakening")
		local Ended = false
		
		local spinSound
		local flameLoopSound = nil

		AnimEvents["flame"] = AnimTrack:GetMarkerReachedSignal("flame"):Once(function()
			RpRemotes.ClientEffects:FireAllClients("SanjiMode", {Attacker = Character, SkillType =  "FireLegMoutonKickStartup",})
			RpRemotes.ClientEffects:FireAllClients("SanjiMode", {Attacker = Character, SkillType =  "FinalFlameExplosion",})
			SoundHandler:StopSound(spinSound, .5)
			SoundHandler:AddSound(Sounds.Characters.Sanji.Awakening.explode, HumRP)
			shared.fireTo(RpRemotes.Replicate.Set, { Player }, { "ShakeCamera", { Intensity = 7 } })

			
			local function knockUpward(EnemyCharacter, EnemyHumanoid, originPosition)
				local root = EnemyCharacter:FindFirstChild("HumanoidRootPart")
				
				local KNOCK_OUT = 40 -- horizontal (outward) force
				local KNOCK_UP  = 50 -- vertical lift
				DamageHandler:TakeDamage(Character, EnemyHumanoid, 5, nil, nil, false, false, true, true, true, nil, nil)

				-- direction away from the explosion centre, flattened so it's horizontal
				local horizontal = (root.Position - originPosition) * Vector3.new(1, 0, 1)
				local pushDir = horizontal.Magnitude > 0.05
					and horizontal.Unit
					or root.CFrame.LookVector * -1 -- fallback if dead-centre

				local knockback = pushDir * KNOCK_OUT + Vector3.yAxis * KNOCK_UP

				local VelocityObject = Velocity.new(EnemyCharacter)
				VelocityObject.Settings.RemoveTime = 0.2
				VelocityObject.Settings.MaxForce = Vector3.new(100000, 100000, 100000)
				VelocityObject.Settings.Velocity = knockback
				VelocityObject.Settings.Spin = Vector3.new(
					(math.random() - 0.5) * 2,
					(math.random() - 0.5) * 2,
					(math.random() - 0.5) * 2
				).Unit * 8
				VelocityObject:Fire()

				--local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
				--BodyAngularVelocity.MaxTorque = Vector3.new(50000, 50000, 50000)
				--BodyAngularVelocity.AngularVelocity = Vector3.new(math.random(2.5, 5), math.random(2.5, 5), math.random(2.5, 5))
				--BodyAngularVelocity.Parent = root
				--Debris:AddItem(BodyAngularVelocity, 0.1)

				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				end

				RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true)
			end
			
			local HitboxSize = Vector3.new(20, 20, 20)
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = HitboxSize
			Hitbox.Offset = CFrame.new(0, (HitboxSize.Y / 2) - 3, 0)
			Hitbox.Ignore = { Character }
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyPlayer: Player = Players:GetPlayerFromCharacter(EnemyCharacter)

				if iFramesHandler:HasiFrame(EnemyCharacter, 2) then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 5, nil, nil, false, false, false, true, false, nil, 13)
				
				AnimationService:stopAll(EnemyCharacter)
				
				local hitboxCenter = (HumRP.CFrame * Hitbox.Offset).Position
				knockUpward(EnemyCharacter, EnemyHumanoid, hitboxCenter)												
			end
			
			if Hitbox then Hitbox:Once() end
			if Hitbox then Hitbox:Destroy() Hitbox = nil end
			
			--DestructionHandler.destroy(
			--	Vector3.new(22, 18, 22),
			--	HumRP.CFrame,
			--	Enum.PartType.Block,
			--	{
			--		MinimumSize = 5, --5.5,
			--		TimeToReset = 60,
			--		Player = Player,
			--		VoxelDestroyChance = .3,
			--		FlingDestroyChance = .8,
			--		VoxelVelocity = function(voxel, hitPos)
			--			local outward = voxel.Position - hitPos
			--			outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)
			--			return outward * math.random(40, 80) + Vector3.new(0, 20, 0)
			--		end,
			--		Visualize = true,
			--	}
			--)
			
			local Awk0C
			Awk0C = Player.AwakeningProgress:GetPropertyChangedSignal('Value'):Connect(function()
				if Player.AwakeningProgress.Value <= 0 then
					RpRemotes.ClientEffects:FireAllClients("SanjiMode", {Attacker = Character, SkillType =  "FireLegMoutonKickDestroy",})
					if flameLoopSound then
						SoundHandler:StopSound(flameLoopSound, 1)
					end
					Awk0C:Disconnect()
				end
			end)
			Ended = true
		end)

		AnimTrack.Stopped:Once(function()
			for _,v in AnimEvents do
				v:Disconnect()
			end
			
			if Stun and Character and Character.Parent then
				StunHandler:Unstun(Character, Stun)
				Stun = nil
			end
			Ended = true
		end)

		AnimationService:playAnimation(Character, SvSt.Assets.Animations.Sanji.Awakening)
		
		RpRemotes.ClientEffects:FireAllClients("SanjiMode", {Attacker = Character, SkillType =  "AwakeningEffects",})
		spinSound = SoundHandler:AddSound(Sounds.Characters.Sanji.Awakening.SpinSoundLoop, HumRP)
		spinSound.Volume = .05
		spinSound.PlaybackSpeed = .5
		TweenCreate(spinSound, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Volume = .5, -- target loudness; change to taste
		})
		TweenCreate(spinSound, TweenInfo.new(2.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			PlaybackSpeed = 1, -- target loudness; change to taste
		})
		task.delay(2.5, function()
			SoundHandler:AddSound(Sounds.Characters.Sanji.Awakening.flameOn, HumRP)
			SoundHandler:AddSound(Sounds.Characters.Sanji.Awakening.woosh, HumRP)
			flameLoopSound = SoundHandler:AddSound(Sounds.Characters.Sanji.Awakening.FlameLoop, Character["Right Leg"])
		end)

		repeat task.wait() until Ended == true 
	end,
	
	["Zoro"] = function(Player: Player)
		local Character = Player.Character
		local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
		local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart')

		local Zoro = require(ServerScriptService.Systems.Characters.Zoro)
		local skill = Zoro.Skills["Mode Skill"]
		skill.Activate(Player, skill, {})
	end,
	
	["BlackBeard"] = function(Player: Player)
		local Character = Player.Character
		local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
		local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart')
		
		local BlackBeard = require(ServerScriptService.Systems.Characters.BlackBeard)
		local skill = BlackBeard.Skills["Mode Skill"]
		skill.Activate(Player, skill, {})
	end,
	
	["WhiteBeard"] = function(Player: Player)
		local Character = Player.Character
		local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
		local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart')

		local WhiteBeard = require(ServerScriptService.Systems.Characters.WhiteBeard)
		local skill = WhiteBeard.Skills["Mode Skill"]
		skill.Activate(Player, skill, {})
	end,
	
	["Crocodile"] = function(Player: Player)
		local Character = Player.Character
		local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
		local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart')

		local Crocodile = require(ServerScriptService.Systems.Characters.Crocodile)
		local skill = Crocodile.Skills["Mode Skill"]
		skill.Activate(Player, skill, {})
	end,
	
}

--Connections
local function Awakening(Player: Player)
	local Character = Player.Character
	if Character == nil or Character.Parent == nil or not Character:FindFirstChild('Humanoid') or (Character:FindFirstChild('Humanoid') and Character.Humanoid.Health <= 0) or not Character:FindFirstChild('HumanoidRootPart') then return end
	if Character:GetAttribute("Awakened") or Character:GetAttribute("AwakeningStarting") then warn("Currently already awakened") return end
	if Character:HasTag('Stunned') then return end
	if Player.Commands.NoAwk.Value == true then return end

	Character:SetAttribute("AwakeningStarting", true)
	task.spawn(function()
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local AwkProgressObj: NumberValue = Player.AwakeningProgress

		local ultimateTime = InfoModule.Movesets[Player:GetAttribute("Character")].UltimateTime
		
		local CurrentMoveset = Player:GetAttribute("Character")
		Character:SetAttribute("Awakened", true)
		
		iFramesHandler:AddAlliFrames(Character)

		CommsSet:FireClient(Player, 'HideHotbar')
		CommsSet:FireClient(Player, 'HideAwkbar')
		
		if AwakeningAnimations[CurrentMoveset] then
			local ok, err = pcall(function()
				AwakeningAnimations[CurrentMoveset](Player)
			end)
			if not ok then
				warn("Awakening animation failed for " .. CurrentMoveset .. ":", err)
			end
		end
		
		-- If there is an awakening animation, this ensures if the player didn't die or reset and have an different char.
		if Player.Character ~= Character
			or not Character.Parent
			or Humanoid.Health <= 0 then
			return
		end
		
		local Ended = false

		if ultimateTime == 0 then
			Ended = true
			EndAwakening(Player, Character, nil, nil, true)
			Character:SetAttribute("AwakeningStarting", nil)
			iFramesHandler:RemoveAlliFrames(Character)
			return
		end

		if Character and Character.Parent and Character:GetAttribute("Awakened") then
			MovesetHandler:AddAwakeningMoveset(Player, CurrentMoveset)
		end
		
		--if AwakeningAnimations[CurrentMoveset] then
		--	AwakeningAnimations[CurrentMoveset](Player)

		--	CommsSet:FireClient(Player, 'ShowHotbar')
		--	if CurrentMoveset ~= 'KJ' and CurrentMoveset ~= "The Strongest Hero" then
		--		CommsSet:FireClient(Player, 'ShowAwkbar')
		--	end
		--else
		task.delay(.5, function()
			CommsSet:FireClient(Player, 'ShowHotbar')
			CommsSet:FireClient(Player, 'ShowAwkbar')
		end)
		
		--local playerClass = shared.playerClasses[Player.UserId]
		--if playerClass then
		--	playerClass.TitlesProgress.Awakens += 1
		--	Player:SetAttribute("AwakensProgress", playerClass.TitlesProgress.Awakens)
		--end
		

		iFramesHandler:RemoveAlliFrames(Character)

		local AwkTween = TS:Create(AwkProgressObj, TweenInfo.new(ultimateTime, Enum.EasingStyle.Linear), { Value = 0 })
		local Awk0C: RBXScriptConnection
		local infiniteConnection: RBXScriptConnection?

		local cleanupConnection
		cleanupConnection = Player.CharacterRemoving:Connect(function(removedCharacter)
			if removedCharacter == Character then
				if cleanupConnection then cleanupConnection:Disconnect() end
				if Ended == false then
					Ended = true		
					if infiniteConnection then
						infiniteConnection:Disconnect()
					end
					if AwkTween and AwkTween.PlaybackState ~= Enum.PlaybackState.Completed then
						--ReplicateSet:FireAllClients('StopAwakeningMusics', { MusAtt = HumRP.AwakeningMusic; })
					end
					
					if Awk0C then
						Awk0C:Disconnect()
						Awk0C = nil
					end

					if AwkTween then
						AwkTween:Cancel()
						AwkTween = nil
					end

					EndAwakening(Player, Character, Awk0C, AwkTween, nil)
				end
			end
		end)
		
		Awk0C = AwkProgressObj:GetPropertyChangedSignal('Value'):Connect(function()
			if Ended == false and AwkProgressObj.Value <= 0 then
				Ended = true
				if infiniteConnection then infiniteConnection:Disconnect() end
				if cleanupConnection then cleanupConnection:Disconnect() end
				Awk0C:Disconnect()

				EndAwakening(Player, Character, Awk0C, AwkTween, nil)
			end
		end)

		local InfiniteAwk = Player.Commands.InfiniteAwk

		AwkTween.Completed:Once(function(playbackState)
			if playbackState ~= Enum.PlaybackState.Completed or Ended then
				return
			end

			Ended = true

			if cleanupConnection then
				cleanupConnection:Disconnect()
			end

			if infiniteConnection then
				infiniteConnection:Disconnect()
			end

			EndAwakening(Player, Character, Awk0C, AwkTween, nil)
		end)

		local function updateAwakeningTimer()
			if Ended then return end

			if InfiniteAwk.Value then
				if AwkTween.PlaybackState == Enum.PlaybackState.Playing then
					AwkTween:Pause()
				end
			else
				AwkTween:Play()
			end
		end

		infiniteConnection =
			InfiniteAwk:GetPropertyChangedSignal("Value"):Connect(updateAwakeningTimer)

		updateAwakeningTimer()
		
		Character:SetAttribute("AwakeningStarting", nil)
	end)
end

RS.Remotes.ModeRequest.OnServerEvent:Connect(function(Player)
	if Player.AwakeningProgress.Value < 100 then return end
	Awakening(Player)
end)

shared.ActivateAwakening = Awakening