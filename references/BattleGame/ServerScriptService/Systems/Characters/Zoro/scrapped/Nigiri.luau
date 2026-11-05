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

local PerfectKnockback = require(ServerModules.PerfectKnockback)


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)

local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds


local NewAnimLocation = ServerStorage.Assets.Animations.Zoro.Moveset.RegularMoveSet.Nigiri


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
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Janitor = Trove.new()

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		local initialAnim = NewAnimLocation.NewMiss

		local StartAnimation = initialAnim
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		local Assets = {}
		local Container = {}
		
		local Hit1 = false
		local Hit2 = false
		local Hit3 = false

		
		local Finisher = false
		
		local HitCharacter = nil
		local HitHumanoid = nil
		local HitHumRP = nil
		local HitPlayer = nil
		local EnemyStun = nil
		
		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.Name = "moveme"
		BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000, 0)
		BodyVelocity:SetAttribute("Speed", 60)
		BodyVelocity:SetAttribute("Fallout", .98)
		BodyVelocity:SetAttribute("End", 5)
		
		local DashHitbox
		StartEvents["dashstart"] = StartTrack:GetMarkerReachedSignal("dashstart"):Once(function()
			DashHitbox = HitboxHandler.new()
			DashHitbox.Instance = HumRP
			DashHitbox.Size = Vector3.new(8, 8, 12)
			DashHitbox.Offset = CFrame.new(0, 0, -6)
			DashHitbox.Ignore = { Character }
			DashHitbox.Visualize = false
			DashHitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid = EnemyCharacter:FindFirstChild("Humanoid")
				if not EnemyHumanoid or EnemyHumanoid.Health <= 0 then return end
				if iFramesService:HasiFrame(EnemyCharacter, 2) then return end

				-- store the hit target
				HitCharacter = EnemyCharacter
				HitHumanoid = EnemyHumanoid
				HitHumRP = EnemyCharacter:FindFirstChild("HumanoidRootPart")

				-- blast through dash frames to hit1
				StartTrack:AdjustSpeed(4)
				
			end
			DashHitbox:Start()
			RemotesContainer.ClientEffects:FireAllClients("Nigiri", {
				Attacker  = Character,
				SkillType = "Dash", 
				
			})
			
		end)
		
		StartEvents["dashend"] = StartTrack:GetMarkerReachedSignal("dashend"):Once(function()
			
			DashHitbox:Stop()
			StartTrack:AdjustSpeed(1)
			ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
			
		end)
		
		
		StartEvents["hit1"] = StartTrack:GetMarkerReachedSignal("hit1"):Once(function()
			StartTrack:AdjustSpeed(1)
			RemotesContainer.ClientEffects:FireAllClients("Nigiri", {
				Attacker  = Character,
				SkillType = "Slash1", 
			})
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(10, 8, 10)
			Hitbox.Offset = CFrame.new(0, (Hitbox.Size.Y / 2) - 3, -5)
			Hitbox.Ignore = { Character }
			Hitbox.Visualize = true
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				
				HitCharacter = EnemyCharacter
				HitHumanoid = EnemyHumanoid
				HitHumRP = EnemyHumRP
				
				AnimationService:stopAll(EnemyCharacter)
				
				if Hit1 or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
			
				--local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, nil, nil, false, true, true, true, false, nil, 19.5)
				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 5, 0.75, Animations.Character.Damaged["Damaged" ..tostring(math.random(0, 4))], true, true, true, true, false, nil, 13)

				if HitInfo.Countered == true then return end 

				--Finisher = HitInfo.Finisher == true
				Hit1 = true


				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				end

				

				
				--EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

				
				
				

			end
			Hitbox:Once()
		end)
		StartEvents["hit2"] = StartTrack:GetMarkerReachedSignal("hit2"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("Nigiri", {
				Attacker  = Character,
				SkillType = "Slash2", 
				
			})

			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(10, 8, 10)
			Hitbox.Offset = CFrame.new(0, (Hitbox.Size.Y / 2) - 3, -5)
			Hitbox.Ignore = { Character }
			Hitbox.Visualize = true
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				
				
				HitCharacter = EnemyCharacter
				HitHumanoid = EnemyHumanoid
				HitHumRP = EnemyHumRP

				AnimationService:stopAll(EnemyCharacter)

				if Hit2 or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 5, 0.75, Animations.Character.Damaged["Damaged" ..tostring(math.random(0, 4))], true, true, true, true, false, nil, 13)

				if HitInfo.Countered == true then return end 

				--Finisher = HitInfo.Finisher == true
				Hit2 = true


				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				end




			end
			Hitbox:Once()
		end)
		
		
		
		StartEvents["hit3"] = StartTrack:GetMarkerReachedSignal("hit3"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("Nigiri", {
				Attacker  = Character,
				SkillType = "Slash3", 
				
			})
			--BodyVelocity.Parent = HumRP
			--BodyVelocity.Parent = HitHumRP

			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(10, 8, 10)
			Hitbox.Offset = CFrame.new(0, (Hitbox.Size.Y / 2) - 3, -5)
			Hitbox.Ignore = { Character }
			Hitbox.Visualize = true
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)

				HitCharacter = EnemyCharacter
				HitHumanoid = EnemyHumanoid
				HitHumRP = EnemyHumRP
				
				AnimationService:stopAll(EnemyCharacter)

				if Hit3 or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 5, 0.75, Animations.Character.Damaged["Damaged" ..tostring(math.random(0, 4))], true, true, true, true, false, nil, 95)
				--local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 5, 0.75, Animations.Character.Damaged["Damaged" ..tostring(math.random(0, 4))], true, true, true, true, false, nil, 13)

				if HitInfo.Countered == true then return end 

				Finisher = HitInfo.Finisher == true
				Hit3 = true


				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				end


				if Finisher then
					Finisher = true

					local selfToOtherChar = (EnemyHumRP.Position - HumRP.Position).Unit
					local lookVector = Character.HumanoidRootPart.CFrame.LookVector
					local dotProduct = lookVector:Dot(selfToOtherChar)
					if EnemyHumanoid.FloorMaterial ~= Enum.Material.Air then
						dotProduct = 1
					end

					local at = Character.HumanoidRootPart.Position
					local forward = Character.HumanoidRootPart.CFrame.LookVector
					local lookposition = CFrame.lookAt(at, at + Vector3.new(forward.X, 0, forward.Z))

					EnemyCharacter:AddTag("CantRotate")
					Character:AddTag("CantRotate")

					iFramesService:AddAlliFrames(Character)
					iFramesService:AddAlliFrames(EnemyCharacter)
					CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")

					PerfectKnockback.KnockBack(nil, EnemyCharacter, {
						LookVector = lookposition.LookVector,
						LookForce = 58.5,
						LookFinalForce = 55,
						LookAt = lookposition,
						DestroyRagdoll = true,
						GroundStunTime = 0.95,
						Escapable = false,
						FallingDetectDelay = 0.2,
						Dot = dotProduct,
						DotParams = {0.4, 1},
						canHitWall = true
					}, Character)

					RemotesContainer.ClientEffects:FireAllClients("Nigiri", {
						Attacker  = Character,
						SkillType = "transparent", 
						Target = EnemyCharacter,
					})
					
					
					task.wait(.25)
					

					local UserAnimation = NewAnimLocation.UserFinisher
					local VictimAnimation = NewAnimLocation.VictimFinisher

					local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
					local UserTrack, UserEvents = AnimationService:getAnimationTrack(Character, UserAnimation)
					
					UserEvents["slash"] = UserTrack:GetMarkerReachedSignal("slash"):Once(function()
						RemotesContainer.ClientEffects:FireAllClients("Nigiri", {
							Attacker  = Character,
							SkillType = "TowerSlash", 
							Target = EnemyCharacter,
						})
						task.delay(.35, function()
							shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 13, Last = 0.3 } })
							RemotesContainer.ClientEffects:FireAllClients("Nigiri", {
								Attacker  = Character,
								SkillType = "FinalSlash", 
								Target = EnemyCharacter,
							})
							
							
						end)

						
					end)
					VictimTrack.Stopped:Once(function()
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						iFramesService:RemoveAlliFrames(EnemyCharacter)
						CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
						EnemyCharacter:RemoveTag("CantRotate")
					end)

					UserTrack.Stopped:Once(function()
						StunHandler:Unstun(Character, Stun)
						iFramesService:RemoveAlliFrames(Character)
						CollisionsModule:SetCollisionGroup(Character, "Players")
						Character:RemoveTag("CantRotate")
						
						
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						iFramesService:RemoveAlliFrames(EnemyCharacter)
						CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
						EnemyCharacter:RemoveTag("CantRotate")
						
					end)
					
					RemotesContainer.ClientEffects:FireAllClients("Nigiri", {
						Attacker  = Character,
						SkillType = "NigiriFinisherDash", 
						Target = EnemyCharacter,
					})
					RemotesContainer.ClientEffects:FireAllClients("Nigiri", {
						Attacker  = Character,
						SkillType = "FinisherDashEffect", 
						Target = EnemyCharacter,
					})
					
					task.wait(.2)
					AnimationService:stopAll(Character)
					--AnimationService:stopAll(EnemyCharacter)
					AnimationService:playAnimation(Character, UserAnimation)
					--AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
					RemotesContainer.ClientEffects:FireAllClients("Nigiri", {
						Attacker  = Character,
						SkillType = "untransparent", 
						Target = EnemyCharacter,
					})		
						
					

				else
					local selfToOtherChar = (EnemyHumRP.Position - HumRP.Position).Unit
					local lookVector = Character.HumanoidRootPart.CFrame.LookVector

					local dotProduct = lookVector:Dot(selfToOtherChar)
					if EnemyHumanoid.FloorMaterial ~= Enum.Material.Air then
						dotProduct = 1
					end

					local at = Character.HumanoidRootPart.Position
					local forward = Character.HumanoidRootPart.CFrame.LookVector
					local lookposition = CFrame.lookAt(at, at + Vector3.new(forward.X, 0, forward.Z))

					PerfectKnockback.KnockBack(nil, EnemyCharacter, {
						LookVector = lookposition.LookVector,
						LookForce = 58.5,
						LookFinalForce = 55,
						LookAt = lookposition,
						DestroyRagdoll = true,
						GroundStunTime = 0.95,
						Escapable = false,
						FallingDetectDelay = 0.2,
						Dot = dotProduct,
						DotParams = {0.4, 1},
						canHitWall = true
					}, Character)

				end
				
			end
			Hitbox:Once()
			
			
			
		end)


		

		StartTrack.Stopped:Once(function()
			for _,v in StartEvents do
				v:Disconnect()
			end
			
			if Finisher then return end
			
			Character:RemoveTag("CantRotate")
			StunHandler:Unstun(Character, Stun)
			iFramesService:RemoveAlliFrames(Character)
			CollisionsModule:SetCollisionGroup(Character, "Players")
			
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		
		--Character:AddTag("CantRotate")

	end
}