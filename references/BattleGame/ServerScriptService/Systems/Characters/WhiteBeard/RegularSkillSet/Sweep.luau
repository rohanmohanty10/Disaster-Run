local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).WhiteBeard[2]
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService = game:GetService("Players")


local ServerModules = ServerStorage.SBGModules

local ReplicatedModules = ReplicatedStorage.Modules
local RemotesContainer = ReplicatedStorage.Remotes


local StunHandler = require(ServerModules.StunHandler)
local HitboxHandler = require(ServerModules.HitboxHandler)
local DamageHandler = require(ServerModules.DamageHandler)
local RagdollHandler = require(ServerModules.RagdollHandler)
local NewKnockback = require(ServerModules.BodymoverService)
local AnimationService = require(ServerModules.AnimationService)
local iFramesService = require(ServerModules.iFramesService)
--local WeaponsHandler = require(ServerModules.WeaponsHandler)
local CollisionsModule = require(ServerModules.CollisionsModule)
local SoundsModule = require(ServerModules.SoundsModule)
local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local StatesHandler = require(ServerModules.StatesHandler)
local Velocity = require(ReplicatedStorage.Modules.Velocity)
local DebreeService = require(ServerModules.DebreeService)
--local DestructionHandler = require(ServerStorage.Modules.DestructionHandler)


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)

local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds


--local NewAnimLocation = ServerStorage.Assets.Animations.Sanji
local NewAnimLocation = ServerStorage.Assets.Animations.WhiteBeard


local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set
local Animations = ServerStorage.Assets.Animations


local rad = math.rad

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true


return {
	Start = function(Player: Player, Cooldown: number)
		
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		local Animator: Animator = Humanoid.Animator


		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("AbilityTwoCooldown") then return end

		Player:SetAttribute("AbilityTwoCooldown", true)

		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local OrbBind = Instance.new("StringValue");
		OrbBind.Parent = Character
		OrbBind.Name = "Sweep Orb"
		
		local SpinBind = Instance.new("StringValue");
		SpinBind.Parent = Character
		SpinBind.Name = "Sweep"
		
		local Stun = StunHandler:Stun(Character, nil, true, 5, 0, true)
		
		local removedConn
		local finishedSkill = false
		local canPlayCrackSound = true
		local canPlayShatterSound = false


		local UserAnimation = NewAnimLocation.Sweep.User

		local UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
		local UserEvents = {}


		local HitTimes = {.025,  .10,  .20,  .3,  .400,  .445,  .500, .565,  .600,  .625,  .645,  .675,  .700,  .800} --.900,  .1000,  1.1,  1.20,  1.30,  1.40, 1.5, 1.6, 1.7, 1.8 }
		
		
		local spinSound
		
		Character:AddTag("NoHeadFollow")
		
		local function finish()
			if finishedSkill then return end
			finishedSkill = true
			canPlayCrackSound = false
			
			for _,v in UserEvents do
				v:Disconnect()
			end
			
			if removedConn then
				removedConn:Disconnect()
				removedConn = nil
			end
			
			if OrbBind then
				OrbBind:Destroy()
				OrbBind = nil
			end

			Character:SetAttribute("sweepspin", nil)

			if SpinBind then
				SpinBind:Destroy()
				SpinBind = nil
			end

			if Stun then
				StunHandler:Unstun(Character, Stun)
				Stun = nil
			end

			if spinSound then
				spinSound:Stop()
				spinSound = nil
			end

			Character:RemoveTag("NoHeadFollow")

			Player:SetAttribute("AbilityTwoCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityTwoCooldown", false)
				end
			end)
		end
		
		removedConn = Character.AncestryChanged:Connect(function(_, parent)
			if not parent then finish() end
		end)
		
		UserEvents["start"] = UserTrack:GetMarkerReachedSignal("start"):Once(function()
			--print("started")
			--UserTrack:AdjustSpeed(1.5)
			
			--RemotesContainer.ClientEffects:FireAllClients("SanjiFourthAbility", {Char = Character, SkillType =  "barrage",  Bind = Bind})
			--RemotesContainer.ClientEffects:FireAllClients("WhiteBeardSweep", {Char = Character, SkillType =  "barrage",  Bind = Bind})
			
			--RemotesContainer.ClientEffects:FireAllClients("WhiteBeardSweep", {Char = Character, SkillType = "Spin", Bind = Bind})
			
			
			-- start it
			Character:SetAttribute("sweepspin", true)
			RemotesContainer.ClientEffects:FireAllClients("WhiteBeardSweep", { Char = Character, SkillType = "spin", Variant = "Red", Bind = SpinBind })

			for _, delayTime in ipairs(HitTimes) do
				task.delay(delayTime, function()
					if finishedSkill or not UserTrack.IsPlaying then return end
					local Hit = false

					local Hitbox = HitboxHandler.new()
					Hitbox.Instance = HumRP
					Hitbox.Size = Vector3.new(17,6,17)
					Hitbox.Offset = CFrame.new(0,2,0)
					Hitbox.Visualize = false
					Hitbox.onTouch = function(EnemyCharacter)
						local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
						local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
						local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)

						if EnemyCharacter == Character or EnemyCharacter:HasTag("Ragdolled") or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

						local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Tick, 0.75, Animations.Character.Damaged["Damaged" ..tostring(math.random(0, 4))], true, true, true, true, true, nil, nil)

						if HitInfo.Countered == true then return end
						if HitInfo.Blocked == true then return end

						if EnemyPlayer then
							ReplicateEffects_Set:FireClient(EnemyPlayer, "ShakeCamera", { Intensity = 0.75, Last = .1 })
						end

						Hit = true
						local randomSwingNumber = math.random(1, 3)
						local selectedSwing = ReplicatedStorage.Assets.Sounds.Characters.WhiteBeard.Sweep.Hits:FindFirstChild(tostring(randomSwingNumber))
						--SoundHandler:AddSound(selectedSwing, HumRP)
					end

					task.delay(.033,function()
						Hitbox:Once()
						Hitbox:Destroy()

						if Hit then
							ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 0.75, Last = .1 })
						end
					end)
					
					local randomSwingNumber = math.random(1, 4)
					local selectedSwing = ReplicatedStorage.Assets.Sounds.Characters.WhiteBeard.Sweep.Swing:FindFirstChild(tostring(randomSwingNumber))
					--SoundHandler:AddSound(selectedSwing, HumRP)
				end)
			end
			spinSound = SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Characters.Sanji.Barrage.New.loop, HumRP)
			--spinSound = SoundHandler:AddSound(Sounds.Characters.WhiteBeard.Sweep["Staff Spin"], HumRP)
			--SoundHandler:AddSound(Sounds.Characters.WhiteBeard.Sweep["Staff Start"], HumRP)
		end)
		
		UserEvents["orb"] = UserTrack:GetMarkerReachedSignal("orb"):Once(function()
			Character:SetAttribute("sweepspin", nil)
			RemotesContainer.ClientEffects:FireAllClients("WhiteBeardSweep", {Char = Character, SkillType = "Orb", Bind = OrbBind})
			SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Startup Sounds"].GuraStartBisento, HumRP)
			SoundHandler:AddSound(Sounds.Characters.WhiteBeard.Sweep.gura_lmb3_sfx, HumRP)
			
			task.delay(.25, function()
				if canPlayCrackSound then
					SoundHandler:AddSound(Sounds.Characters.WhiteBeard["Crack Sounds"].Bisento, HumRP.CFrame * CFrame.new(0, 0, -7))
				end
			end)
			task.delay(1.1, function()
				if canPlayShatterSound then
					SoundHandler:AddSound(Sounds.Characters.WhiteBeard.Sweep["Shatter"], HumRP.CFrame * CFrame.new(0, 0, -7))
				end
			end)
		end)

		UserEvents["end"] = UserTrack:GetMarkerReachedSignal("end"):Once(function()
			UserTrack:AdjustSpeed(1)
		
			local function fastFadeOut(sound, fadeSpeed)
				-- fadeSpeed: Higher numbers mean a faster fade (e.g., 5 is very fast, 1 is slower)
				task.spawn(function()
					local connection
					connection = RunService.Heartbeat:Connect(function(dt)
						if not sound or not sound.Parent or sound.Volume <= 0 then
							if sound then sound:Stop() end
							connection:Disconnect()
							return
						end

						-- Linear volume reduction independent of framerate
						sound.Volume = math.max(0, sound.Volume - (fadeSpeed * dt))
					end)
				end)
			end
			fastFadeOut(spinSound, 2)
			task.delay(.6, function()
				if spinSound then
					spinSound:Stop()
					spinSound = nil
				end
			end)
		end)
		
		UserEvents["slam"] = UserTrack:GetMarkerReachedSignal("slam"):Once(function()
			if OrbBind then
				OrbBind:Destroy()
				OrbBind = nil
			end
			
			canPlayShatterSound = true
			
			local CFrameToUse = HumRP.CFrame * CFrame.new(0, 0, -10)
					
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(19,19,19)
			Hitbox.Offset = CFrame.new(0,0,-Hitbox.Size.Z/2)
			Hitbox.Visualize = false	
			Hitbox.Ignore = { Character }
			Hitbox.onTouch = function(EnemyCharacter) -- explode from hit direction rather than directly upwards
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)

				if iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Final, nil, nil, false, true, true, true, true, nil, nil)
				if HitInfo.Countered == true then
					return
				end
				
				if EnemyPlayer then
					ReplicateEffects_Set:FireClient(EnemyPlayer, "ShakeCamera", { Intensity = 0.75, Last = .1 })
				end

				if EnemyCharacter:HasTag('Ragdolled') then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, nil, nil, false, true)
				end
								
				local diff = (EnemyHumRP.Position - HumRP.Position) * Vector3.new(1, 0, 1)
				local dir = diff.Magnitude > 0.01 and diff.Unit or HumRP.CFrame.LookVector * Vector3.new(1, 0, 1)
				
				local VelocityObject = Velocity.new(EnemyCharacter)
				VelocityObject.Settings.RemoveTime = 0.2
				VelocityObject.Settings.MaxForce = Vector3.new(10000, 10000, 10000) --Force
				VelocityObject.Settings.Velocity = dir * 30 + Vector3.new(0, 25, 0)
				VelocityObject.Settings.Spin = Vector3.new(
					(math.random() - 0.5) * 2,
					(math.random() - 0.5) * 2,
					(math.random() - 0.5) * 2
				).Unit * 8
				VelocityObject:Fire()
				RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true)
				
				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 8, Last = 0.6 } })
			end

			Hitbox:Once()
			Hitbox:Destroy()
						
			ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 3, Last = 0.1 })
			DebreeService.Destroy(CFrameToUse, Vector3.new(15, 15, 15), {
				Shape = "Ball",
				Outward = true,
				Power = 50,
				Lift = 15,
				Bounce = 12,
				Attacker = Player,
			})
			
			RemotesContainer.ClientEffects:FireAllClients("WhiteBeardSweep", { Char = Character, SkillType = "Slam", CFrameToUse = CFrameToUse, Seed = math.random(1, 2^5 - 1)})
		end)


		UserTrack.Stopped:Once(function()
			finish()
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, UserAnimation)		
	end
}