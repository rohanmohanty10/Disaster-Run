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
local NewAnimLocation = ServerStorage.Assets.Animations.Zoro.Moveset.RegularMoveSet.SlashRun


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

		local Bind = Instance.new("StringValue");
		Bind.Parent = Character
		Bind.Name = "Barrage"
		--Bind:SetAttribute("Delay", 0.0001)
		Bind:SetAttribute("Delay", 0.0001)

		Bind:SetAttribute("Times", 1)


		local Stun = StunHandler:Stun(Character, nil, true, 5, 0)

		local Hit = false
		local Finisher = false


		--local UserAnimation = MoveAnims.BaldHero["Consecutive Punches"].User
		local UserAnimation = NewAnimLocation.Miss

		local UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
		local UserEvents = {}


		local HitTimes = {.100,  .150,  .250,  .334,  .400,  .445,  .500, .565,  .600,  .625,  .645,  .675,  .700,  .800, .900,  .1000,  1.1,  1.20,  1.30 }

		
		UserEvents["transparent"] = UserTrack:GetMarkerReachedSignal("transparent"):Once(function()			
		end)
		
		UserEvents["move"] = UserTrack:GetMarkerReachedSignal("move"):Once(function()			
			--BV.Parent = HumRP
			
			RemotesContainer.ClientEffects:FireAllClients("ZoroSlashes", {Char = Character, SkillType =  "move"})

		end)

		UserEvents["barrage"] = UserTrack:GetMarkerReachedSignal("barrage"):Once(function()
			print("started")
			--UserTrack:AdjustSpeed(1.5)
			
			--RemotesContainer.ClientEffects:FireAllClients("ZoroSlashes", {Char = Character, SkillType =  "barrage",  Bind = Bind})
			RemotesContainer.ClientEffects:FireAllClients("ZoroSlashes", {Char = Character, SkillType =  "newBarrage",  Bind = Bind})

			--RemotesContainer.ClientEffects:FireAllClients("SanjiFourthAbility", {Char = Character, SkillType =  "BarrageEffects",  Bind = Bind})

			--SoundsModule:PlaySound(MoveSounds.Baldhero["Conencutive Punches"].Startup, HumRP)
			for _, delayTime in ipairs(HitTimes) do
				task.delay(delayTime, function()
					if not UserTrack.IsPlaying then return end

					local Hitbox = HitboxHandler.new()
					Hitbox.Instance = HumRP
					Hitbox.Size = Vector3.new(1,1,1) * 16
					Hitbox.Offset = CFrame.new(0,0,-Hitbox.Size.Z/2)
					Hitbox.Visualize = true
					Hitbox.onTouch = function(EnemyCharacter)
						local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
						local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
						local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)

						if Finisher == true or EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

						--local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0.75, 0.75, Animations.Combat.Hits[tostring(math.random(1, 1))], true, true, true, true, false, nil, 13)
						local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0.75, 0.75, Animations.Character.Damaged["Damaged" ..tostring(math.random(0, 4))], true, true, true, true, false, nil, 13)

						--if HitInfo.Countered == true then
						--	return
						--end


						--SoundsModule:PlaySound(MoveSounds.Baldhero["Conencutive Punches"]["Hit" .. tostring(math.random(1, 3))], HumRP)


						if EnemyPlayer then
							ReplicateEffects_Set:FireClient(EnemyPlayer, "ShakeCamera", { Intensity = 0.75, Last = .1 })
						end


						if
							EnemyCharacter:HasTag('Ragdolled') then
							Hit = true

							if Finisher then
								RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, nil, nil, false, true)
							end
						else
							Hit = true

							task.delay(0.1,function()

								if not Hit then
									StunHandler:Stun(Character, nil, true, 5, 0)
								end
							end)
						end
					end

					task.delay(.033,function()
						Hitbox:Once()
						Hitbox:Destroy()

						if Hit then
							ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 0.75, Last = .1 })
						end
					end)
				end)
			end
		end)
		UserEvents["barrageend"] = UserTrack:GetMarkerReachedSignal("barrageend"):Once(function()			
			--BV.Parent = HumRP

			--RemotesContainer.ClientEffects:FireAllClients("ZoroSlashes", {Char = Character, SkillType =  "move"})
			if Bind then
				Bind:Destroy()
				Bind = nil
			end
		end)
		UserEvents["end"] = UserTrack:GetMarkerReachedSignal("end"):Once(function()
			if Bind then
				Bind:Destroy()
				Bind = nil
			end


			UserTrack:AdjustSpeed(1)
		end)

		UserTrack.Stopped:Once(function()
			if Bind then
				Bind:Destroy()
				Bind = nil
			end

			for _,v in UserEvents do
				v:Disconnect()
			end


			if Stun then
				StunHandler:Unstun(Character, Stun)
				Stun = nil
			end
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, UserAnimation)
		--UserTrack:AdjustSpeed(1.2)


	end
}