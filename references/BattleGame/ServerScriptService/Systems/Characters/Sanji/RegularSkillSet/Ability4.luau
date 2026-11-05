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


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)

local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds


--local NewAnimLocation = ServerStorage.Assets.Animations.Sanji
local NewAnimLocation = ServerStorage.Assets.Animations.Sanji


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
	Start = function(Player: Player, Tool: Tool)
		
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		local Animator: Animator = Humanoid.Animator


		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("AbilityFourCooldown") then return end
		if Character:GetAttribute("SanjiFourthAbility") then return end

		Player:SetAttribute("AbilityFourCooldown", true)
		Character:SetAttribute("SanjiFourthAbility", true)

		local CooldownTime = 12
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local Bind = Instance.new("StringValue");
		Bind.Parent = Character
		Bind.Name = "Barrage"
		--Bind:SetAttribute("Delay", 0.0001)
		Bind:SetAttribute("Delay", 0.0001)

		Bind:SetAttribute("Times", 1)


		local Stun = StunHandler:Stun(Character, nil, true, 5, 0, true)

		local Finisher = false


		local UserAnimation = NewAnimLocation.Barrage.User

		local UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
		local UserEvents = {}


		local HitTimes = {.100,  .150,  .250,  .334,  .400,  .445,  .500, .565,  .600,  .625,  .645,  .675,  .700,  .800, .900,  .1000,  1.1,  1.20,  1.30,  1.40, 1.5, 1.6, 1.7, 1.8 }
		
		local BV = Instance.new("BodyVelocity")
		BV.Name = "moveme"
		BV.MaxForce = Vector3.new(100000, 100000, 100000)
		BV:SetAttribute("Speed", 1)              -- forward speed
		BV:SetAttribute("Fallout", 1)          -- slight forward deceleration
		BV:SetAttribute("Aerial", 20)             -- upward boost
		BV:SetAttribute("AerialDecrease", 0.97)   -- multiplier for Monster (not subtractor)
		--BV:SetAttribute("Monster", true)          -- enable parabolic decay
		BV:SetAttribute("EndExclusion", true)     -- don't auto-destroy
		BV:SetAttribute("YForceImmunity", true)
		
		local var
		
		Character:AddTag("NoHeadFollow")
		
		UserEvents["jump"] = UserTrack:GetMarkerReachedSignal("jump"):Once(function()			
			BV.Parent = HumRP
		end)

		UserEvents["start"] = UserTrack:GetMarkerReachedSignal("start"):Once(function()
			print("started")
			UserTrack:AdjustSpeed(1.5)
			
			RemotesContainer.ClientEffects:FireAllClients("SanjiFourthAbility", {Char = Character, SkillType =  "barrage",  Bind = Bind})
			--RemotesContainer.ClientEffects:FireAllClients("SanjiFourthAbility", {Char = Character, SkillType =  "BarrageEffects",  Bind = Bind})

			for _, delayTime in ipairs(HitTimes) do
				task.delay(delayTime, function()
					if not UserTrack.IsPlaying then return end
					local Hit = false

					local Hitbox = HitboxHandler.new()
					Hitbox.Instance = HumRP
					Hitbox.Size = Vector3.new(1,1,1) * 9
					Hitbox.Offset = CFrame.new(0,0,-Hitbox.Size.Z/2)
					Hitbox.Visualize = false
					Hitbox.onTouch = function(EnemyCharacter)
						local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
						local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
						local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)

						if Finisher == true or EnemyCharacter == Character or EnemyCharacter:HasTag("Ragdolled") or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

						local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0.75, 0.75, Animations.Character.Damaged["Damaged" ..tostring(math.random(0, 4))], true, true, true, true, false, nil, 13)

						if HitInfo.Countered == true then return end
						if HitInfo.Blocked == true then return end

						if EnemyPlayer then
							ReplicateEffects_Set:FireClient(EnemyPlayer, "ShakeCamera", { Intensity = 0.75, Last = .1 })
						end

						Hit = true
						local randomSwingNumber = math.random(1, 3)
						local selectedSwing = ReplicatedStorage.Assets.Sounds.Characters.Sanji.Barrage.BarrageHits:FindFirstChild(tostring(randomSwingNumber))
					end

					task.delay(.033,function()
						Hitbox:Once()
						Hitbox:Destroy()

						if Hit then
							ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 0.75, Last = .1 })
						end
					end)
					local randomSwingNumber = math.random(1, 7)
					local selectedSwing = ReplicatedStorage.Assets.Sounds.Characters.Sanji.Barrage.Swing:FindFirstChild(tostring(randomSwingNumber))
				end)
			end
			--var	= SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Characters.Sanji.Barrage.BarrageHits["Sanji Kicks loop"], HumRP)
			var	= SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Characters.Sanji.Barrage.New.loop, HumRP)
			--var:Play()
		end)

		UserEvents["end"] = UserTrack:GetMarkerReachedSignal("end"):Once(function()
			if Bind then
				Bind:Destroy()
				Bind = nil
			end
			
			task.delay(.5, function()
				if BV and Character then
					BV:Destroy()
					BV = nil
				end
			end)
			
			UserTrack:AdjustSpeed(1)
			SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Characters.Sanji.Barrage.FinalHit["Whoosh 1 spin"], HumRP)
			SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Characters.Sanji.Barrage.FinalHit["Whoosh2"], HumRP)
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
			fastFadeOut(var, 2)
			task.delay(.6, function()
				if var and Character and HumRP and Humanoid then
					var:Stop()
					var = nil
				end
			end)
		end)
		
		UserEvents["finalKick"] = UserTrack:GetMarkerReachedSignal("finalKick"):Once(function()
			local hit2 = false
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(1,1,1) * 9
			Hitbox.Offset = CFrame.new(0,0,-Hitbox.Size.Z/2)
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)

				if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

				--local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0.75, 0.75, Animations.Combat.Hits[tostring(math.random(1, 1))], true, true, true, true, false, nil, 13)
				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 10, nil, Animations.Character.Damaged["Damaged" ..tostring(math.random(0, 4))], false, true, true, true, true, nil, 13)

				if HitInfo.Countered == true then
					return
				end
				
				if EnemyPlayer then
					ReplicateEffects_Set:FireClient(EnemyPlayer, "ShakeCamera", { Intensity = 0.75, Last = .1 })
				end

				hit2 = true
				if EnemyCharacter:HasTag('Ragdolled') then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, nil, nil, false, true)
				end
				
				for RockValue = 1, 2 do
					local Position = {
						Seed = math.random(1, 8) + RockValue, 
						start = EnemyHumRP.Position + Vector3.new(0, 0.1, 0), 
						["end"] = Vector3.new(0, -8, 0), 
						amount = 6 + RockValue / 2, 
						nosound = true, 
						nosmoke = RockValue > 2
					}

					local minusValue = false
					if RockValue <= 2 then
						minusValue = {
							minus = 0
						}
					end

					Position.stronger = minusValue
					Position.sizemult = 0.55 * RockValue
					Position.size = 0.85 * RockValue

					ReplicateEffects_Set:FireAllClients('Ground Crater', Position)
				end
				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 8, Last = 0.6 } })
				
				NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(math.huge, 0, math.huge), Velocity = -HumRP.CFrame.RightVector * 40, Time = .5, P = 1250 })
				RagdollHandler.ragdoll(EnemyHumanoid, 2)
				SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Characters.Sanji.Barrage.FinalHit["hit kick"], HumRP)
				SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Characters.Sanji.Barrage.FinalHit["hit_kick2"], HumRP)
			end

			Hitbox:Once()
			Hitbox:Destroy()

			ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 3, Last = 0.2 })
			SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Characters.Sanji.Barrage.FinalHit["swing_kick new"], HumRP)
		end)


		UserTrack.Stopped:Once(function()
			if Bind then
				Bind:Destroy()
				Bind = nil
			end

			for _,v in UserEvents do
				v:Disconnect()
			end
			
			if BV then
				BV:Destroy()
				BV = nil
			end
			
			if Stun then
				StunHandler:Unstun(Character, Stun)
				Stun = nil
			end
			
			if var then
				var:Stop()
				var = nil
			end
			
			Character:RemoveTag("NoHeadFollow")
			
			Character:SetAttribute("SanjiFourthAbility", nil)

			Player:SetAttribute("AbilityFourCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityFourCooldown", false)
				end
			end)
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, UserAnimation)
		SoundHandler:AddSound(ReplicatedStorage.Assets.Sounds.Characters.Sanji.Barrage["53_es_backflip (1)"], HumRP)
	end
}