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


local NewAnimLocation = ServerStorage.Assets.Animations.Zoro.Moveset.Garbage.TigetHunt


local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set


local rad = math.rad

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true

local DASH_DISTANCE = 40

local FADE_DELAY    = 0.135
local FADE_DURATION = 0.35
local BV_DURATION   = 0.19
local BV_DECEL_TIME = 0.16






return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Janitor = Trove.new()

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		--local initialAnim = NewAnimLocation.Miss
		local initialAnim = NewAnimLocation.Miss

		local StartAnimation = initialAnim
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		local Assets = {}
		local Container = {}
		
		local Hit = {}
		
		--local BodyVelocity = Instance.new("BodyVelocity")
		--BodyVelocity.Name = "moveme"
		--BodyVelocity.MaxForce = Vector3.new(40000, 2000, 40000)
		--BodyVelocity:SetAttribute("Speed", 65)
		--BodyVelocity:SetAttribute("Fallout", .96)
		--BodyVelocity:SetAttribute("Aerial", 20)
		--BodyVelocity:SetAttribute("AerialDecrease", 1)
		--BodyVelocity:SetAttribute("End", 5)
		
		--local BodyVelocity = Instance.new("BodyVelocity")
		--BodyVelocity.Name = "moveme"
		--BodyVelocity.MaxForce = Vector3.new(40000, 2000, 40000)
		--BodyVelocity:SetAttribute("Speed", 110)
		--BodyVelocity:SetAttribute("Fallout", .97)
		----BodyVelocity:SetAttribute("Aerial", 20)
		----BodyVelocity:SetAttribute("AerialDecrease", 1)
		--BodyVelocity:SetAttribute("End", 15)
		
		StartEvents["jump"] = StartTrack:GetMarkerReachedSignal("jump"):Once(function()
			--BodyVelocity.Parent = HumRP
			RemotesContainer.ClientEffects:FireAllClients("TigerHunt", {
				Attacker  = Character,
				SkillType = "jump",
			})
		end)
		
		StartEvents["swing"] = StartTrack:GetMarkerReachedSignal("swing"):Once(function()
			--BodyVelocity.Parent = HumRP
			RemotesContainer.ClientEffects:FireAllClients("TigerHunt", {
				Attacker  = Character,
				SkillType = "swing",
			})
		end)	
		
		
		StartEvents["hit"] = StartTrack:GetMarkerReachedSignal("hit"):Once(function()
			
			--local origin      = HumRP.CFrame
			--local lookDir     = origin.LookVector
			--local destination = origin.Position + lookDir * DASH_DISTANCE

			--local dashVector   = destination - origin.Position
			--local dashLength   = dashVector.Magnitude
			--local dashMidpoint = origin.Position + dashVector * 0.5
			--local hitboxCFrame = CFrame.new(dashMidpoint, destination)
			
			--if BodyVelocity then
			--	--task.wait(.2)
			--	BodyVelocity:Destroy()
			--	BodyVelocity = nil
			--end
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(10, 8, 10)
			
			--Hitbox.Offset   = hitboxCFrame:ToObjectSpace(origin) -- offset relative to HumRP
			Hitbox.Offset = CFrame.new(0, 0, -4)

			Hitbox.Ignore = { Character }
			Hitbox.Visualize = true
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if Hit[EnemyCharacter] or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
				if EnemyCharacter:GetAttribute("Ragdolled") then
					return
				end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 15, nil, nil, false, true, true, true, false, nil, 19.5)
				if HitInfo.Countered == true then return end --Simple and easy

				local Finisher = HitInfo.Finisher == true
				Hit[EnemyCharacter] = true


				--if EnemyCharacter:HasTag("Ragdolled") then
				--	RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				--end

				--AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)


				EnemyCharacter:AddTag("CantRotate")

				--local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -7) * CFrame.Angles(0, math.pi, 0), 10)	
				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

				--local UserAnimation = NewAnimLocation.User

				--local UserTrack
				--local UserEvents = {}

				--local VictimTrack
				--local VictimEvents = {}


				if Finisher then
					print("Finisher: None")

				else
					--UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
					
					
					local Ended = false
					
					for enemyCharacter, data in pairs(Hit) do
						local enemyHumRP = enemyCharacter:FindFirstChild("HumanoidRootPart")
						local enemyHumanoid = enemyCharacter:FindFirstChild("Humanoid")

						local enemyPlayer = game.Players:GetPlayerFromCharacter(enemyCharacter)

						if enemyHumRP and enemyHumanoid then
							RagdollHandler.ragdoll(enemyHumanoid, 2)
							--NewKnockback:Knockback(enemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.LookVector * Vector3.new(5, -20 ,5)})
							--NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.LookVector * Vector3.new(40 ,0 ,40) + Vector3.new(0, -130, 0) })
							--NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(1, 100000, 1), Velocity = HumRP.CFrame.UpVector * 55 })
							--NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(1, 100000, 1), Velocity = HumRP.CFrame.UpVector * 75 })
							--task.spawn(function()
							--	shared.fireTo(ReplicateEffects_Set, { Player, enemyPlayer }, { "ShakeCamera", { Intensity = 5 } })

							--	local LoopTask = nil
							--	LoopTask = task.spawn(function()
							--		local PastTime = 0
							--		while true do
							--			if PastTime < 0.4 then PastTime += task.wait() continue end

							--			if EnemyCharacter and EnemyCharacter.Parent then
							--				local Velocity = EnemyHumRP.AssemblyLinearVelocity
							--				local HitRay = workspace:Raycast(EnemyHumRP.Position, Vector3.new(math.clamp(Velocity.X, -10.3, 10.3), math.clamp(Velocity.Y, -10.3, 10.3), math.clamp(Velocity.Z, -10.3, 10.3)), MapRayParams)
							--				if HitRay then
							--					local Position = HitRay.Position

							--					ReplicateEffects_Set:FireAllClients("Ground Crater",{
							--						Seed = math.random(1, 2000000000), 
							--						start = Position + Vector3.new(0, 0.10000000149011612, 0, 0), 
							--						["end"] = Vector3.new(0, -24, 0, 0), 
							--						amount = 4, 
							--						size = 0.2, 
							--						nosmoke = true, 
							--						nosound = false
							--					})

							--					ReplicateEffects_Set:FireAllClients("Ground Crater",{
							--						Seed = math.random(1, 2000000000), 
							--						start = Position + Vector3.new(0, 0.10000000149011612, 0, 0), 
							--						["end"] = Vector3.new(0, -14, 0, 0), 
							--						amount = 5, 
							--						sizemult = 1.55, 
							--						size = 1.4, 
							--						nosound = true
							--					})

							--					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(1, 100000, 1), Velocity = HumRP.CFrame.UpVector * 75 })
							--					break
							--				else
							--					task.wait()
							--				end
							--			else
							--				break
							--			end
							--		end

							--		LoopTask = nil
							--	end)

							--	task.delay(6, function()
							--		pcall(function()
							--			task.cancel(LoopTask)
							--		end)
							--		LoopTask = nil
							--	end)

							--	--SoundsModule:PlaySound(MoveSounds["Hero Hunter"]["Monster Form"]["Binding Cloth"].Craters.Crater, GoalCF)
							--end)
							local Position = EnemyHumRP.Position
							RemotesContainer.ClientEffects:FireAllClients("TigerHunt", {
								Attacker  = Character,
								SkillType = "hit",
								Position = Position
							})
							ReplicateEffects_Set:FireAllClients("Ground Crater",{
								Seed = math.random(1, 2000000000), 
								start = Position + Vector3.new(0, 0.10000000149011612, 0, 0), 
								["end"] = Vector3.new(0, -24, 0, 0), 
								amount = 4, 
								size = 0.2, 
								nosmoke = true, 
								nosound = false
							})

							ReplicateEffects_Set:FireAllClients("Ground Crater",{
								Seed = math.random(1, 2000000000), 
								start = Position + Vector3.new(0, 0.10000000149011612, 0, 0), 
								["end"] = Vector3.new(0, -14, 0, 0), 
								amount = 5, 
								sizemult = 1.55, 
								size = 1.4, 
								nosound = true
							})

							--NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(10000, 100000, 10000), Velocity = HumRP.CFrame.UpVector * 75 + HumRP.CFrame.LookVector * 5})
							NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.LookVector * 5 + Vector3.new(0, 75, 0) })
							--local att = Instance.new("Attachment")
							--att.Parent = EnemyCharacter.HumanoidRootPart

							--local angVel = Instance.new("AngularVelocity")
							--angVel.Attachment0 = att
							--angVel.AngularVelocity = Vector3.new(0, 0, 10) -- tweak axis/speed
							--angVel.MaxTorque = math.huge
							--angVel.RelativeTo = Enum.ActuatorRelativeTo.World
							--angVel.Parent = EnemyCharacter.HumanoidRootPart

							--game:GetService("Debris"):AddItem(att, 0.3)
							--game:GetService("Debris"):AddItem(angVel, 0.3)

						end
					end
					--local function EndFunction()
					--	task.spawn(function()
					--		if Ended then return end
					--		Ended = true


					--		for _,v in UserEvents do
					--			v:Disconnect()
					--		end


					--		StunHandler:Unstun(Character, Stun)
					--	end)
					--end

					

					--UserTrack.Stopped:Once(EndFunction)



					--ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

					--AnimationService:stopAll(Character)
					--AnimationService:playAnimation(Character, UserAnimation)
					
					
				end

			end
			
			Hitbox:Once()
			--Hitbox:Start()
			--task.delay(.1, function()
			--	Hitbox:Destroy()
			--end)
			--if BodyVelocity then
			--	--task.wait(.2)
			--	BodyVelocity:Destroy()
			--	BodyVelocity = nil
			--end
			--executeTeleport(HumRP, Character)

		end)

		

		StartTrack.Stopped:Once(function()
			

			for _,v in StartEvents do
				v:Disconnect()
			end
			--if BodyVelocity then
			--	--task.wait(.2)
			--	BodyVelocity:Destroy()
			--	BodyVelocity = nil
			--end

			--if Hit then return end

			StunHandler:Unstun(Character, Stun)
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)

		--temp
		--RemotesContainer.ClientEffects:FireAllClients("TigerHunt", {Attacker = Character, SkillType =  "start",})
	end
}