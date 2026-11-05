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
local NewAnimLocation = ServerStorage.Assets.Animations["BlackBeard"]


local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set
local Animations = ReplicatedStorage.Assets.Animations


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

		local Stun = StunHandler:Stun(Character, nil, true, 5, 0)
		Stun:SetAttribute("WalkSpeed", 5)


		local Hit = false
		local grabHit = false
		local Finisher = false
		
		local Janitor = Trove.new()
		local Container = {}
		local Assets = {}
		local function MoveChar(Params)
			for _, v in pairs(Container) do
				v:Destroy()
			end

			local BodyVelocity = Janitor:Add(Instance.new("BodyVelocity"))

			table.insert(Assets, BodyVelocity)
			table.insert(Container, BodyVelocity)

			BodyVelocity.Name = "moveme"
			BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000, 0)
			BodyVelocity:SetAttribute("Speed", Params.speed or 100)
			BodyVelocity:SetAttribute("Fallout", Params.fallout or 0.95)
			BodyVelocity:SetAttribute("End", Params.endd or 5)
			BodyVelocity.Parent = HumRP

			Debris:AddItem(BodyVelocity, Params.deletiontime or 5)
		end
		local BodyVelocity = Janitor:Add(Instance.new("BodyVelocity"))
		BodyVelocity.Name = "moveme"
		BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000, 0)
		BodyVelocity:SetAttribute("Speed", 45)
		BodyVelocity:SetAttribute("Fallout", .92)
		BodyVelocity:SetAttribute("End", 2)

		--local UserAnimation = MoveAnims.BaldHero["Consecutive Punches"].User
		local StartAnimation = NewAnimLocation["Abyssal Vortex"].Miss
		

		local UserTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}


		local HitTimes = { .50,  .100,  .150,  .250,  .334,  .400,  .445,  .500, .565,
			.600,  .625,  .645,  .675,  .700, .75, .800, .850, .900, .950, 1.000,  1.050,
			1.1,  
		}
		
		local PullHit = false
		local victimsInVortex = {}

		local pullConnection
		pullConnection = RunService.Heartbeat:Connect(function(dt)
			if not UserTrack.IsPlaying then 
				pullConnection:Disconnect()
				return 
			end

			local minPullSpeed = 30  -- The baseline "inevitable" pull
			local maxPullSpeed = 70  -- The speed limit so they don't teleport
			local vortexRadius = 50

			for enemyChar, enemyHRP in pairs(victimsInVortex) do
				if enemyChar and enemyChar.Parent and enemyHRP then
					local relativeVector = HumRP.Position - enemyHRP.Position
					local distance = relativeVector.Magnitude

					if distance < vortexRadius then
						local direction = relativeVector.Unit

						-- 1. Calculate how strong the pull is based on distance
						-- 1 = at the center, 0 = at the edge
						local distanceAlpha = 1 - math.clamp(distance / vortexRadius, 0, 1)

						-- 2. Linearly Interpolate between your Min and Max speeds
						-- This ensures that even at the very edge (alpha 0), they move at minPullSpeed
						local targetSpeed = math.lerp(minPullSpeed, maxPullSpeed, distanceAlpha)

						-- 3. Calculate the new Velocity
						-- We use a Lerp on the velocity itself for "Smooth Acceleration"
						local currentVelocity = enemyHRP.AssemblyLinearVelocity
						local targetVelocity = direction * targetSpeed

						-- We apply the force smoothly so it doesn't look like a "snap"
						-- 0.15 is the "snappiness" factor. Lower = floatier, Higher = stickier.
						local lerpAlpha = 1 - math.exp(-15 * dt)
						enemyHRP.AssemblyLinearVelocity = currentVelocity:Lerp(targetVelocity, lerpAlpha)

						-- 4. Visual Polish: Face the center
						enemyHRP.CFrame = enemyHRP.CFrame:Lerp(CFrame.lookAt(enemyHRP.Position, Vector3.new(HumRP.Position.X, enemyHRP.Position.Y, HumRP.Position.Z)), 0.1)
					else
						victimsInVortex[enemyChar] = nil
					end
				else
					--pcall(function() enemyHRP:SetNetworkOwner(PlayersService:GetPlayerFromCharacter(enemyChar)) end)
					victimsInVortex[enemyChar] = nil
				end
			end
		end)
		
		local GrabHitbox = HitboxHandler.new()
		GrabHitbox.Instance = HumRP
		GrabHitbox.Size = Vector3.new(5, 5, 5)
		GrabHitbox.Offset = CFrame.new(0, 0, -2)
		GrabHitbox.Method = "Box"
		
		local function doGrab(EnemyCharacter)
			local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
			local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
			if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

			if pullConnection then pullConnection:Disconnect() end
			GrabHitbox:Stop()

			--if Hit == true or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
			if grabHit == true or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

			Character:SetAttribute("VortexGrabbedVfxEnd", true)
			task.delay(.15, function()
				Character:SetAttribute("VortexGrabbedVfxEnd", false)
			end)
			local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, nil, nil, false, true, true, true, false, nil, 19.5)
			if HitInfo.Countered == true then return end --Simple and easy

			local Finisher = false --- HitInfo.Finisher == true
			grabHit = true


			if EnemyCharacter:HasTag("Ragdolled") then
				RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
			end

			AnimationService:stopAll(Character)
			AnimationService:stopAll(EnemyCharacter)

			CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
			CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")

			EnemyCharacter:AddTag("CantRotate")

			local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -3) * CFrame.Angles(0, math.pi, 0), 10)	
			--local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -3), 10)	

			local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)


			local UserAnimation = NewAnimLocation["Abyssal Vortex"].User
			local VictimAnimation = NewAnimLocation["Abyssal Vortex"].Target
			local UserTrack
			local UserEvents = {}

			local VictimTrack
			local VictimEvents = {}
			--if Finisher then

			--else

			UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
			VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)

			local Ended = false
			local function EndFunction()
				task.spawn(function()
					if Ended then return end
					Ended = true


					for _,v in UserEvents do
						v:Disconnect()
					end

					for _,v in VictimEvents do
						v:Disconnect()
					end


					if Weld then
						pcall(function()
							Weld:Stop()
						end)
						Weld = nil
					end

					StunHandler:Unstun(Character, Stun)
					iFramesService:RemoveAlliFrames(Character)
					CollisionsModule:SetCollisionGroup(Character, "Players")
				end)
			end



			UserEvents["move"] = UserTrack:GetMarkerReachedSignal("move"):Once(function()
				print("move")
				--MoveChar({ speed = 45, fallout = 0.92, endd = 2, deletiontime = 0.2 })


				BodyVelocity.Parent = HumRP
				--MoveChar({ speed = 80, fallout = 0.95, endd = 5, deletiontime = 3 })

				--RemotesContainer.ClientEffects:FireAllClients("SanjiThirdAbility", {Attacker = Character, SkillType =  "spin",})
			end)

			UserEvents["slam"] = UserTrack:GetMarkerReachedSignal("slam"):Once(function()
				print("Slam")
				if BodyVelocity then
					BodyVelocity:Destroy()
					BodyVelocity = nil
				end
				ReplicateEffects_Set:FireAllClients("Ground Crater", { start = Character.PrimaryPart.Position, Seed = math.random(1,2147483647), ["end"] = Vector3.new(0, -7, 0), nosound = true })
				ReplicateEffects_Set:FireAllClients("Ground Crater", { ["end"] = Vector3.new(0, -14, 0), start = Character.PrimaryPart.Position, Seed = math.random(1,2147483647), size = 2 })
				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 10 } })
				--shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 8, Last = 0.6 } })

				if Weld then
					pcall(function()
						Weld:Stop()
					end)
					Weld = nil
				end

				iFramesService:RemoveAlliFrames(EnemyCharacter)
				EnemyCharacter:RemoveTag("CantRotate")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
				StunHandler:Unstun(EnemyCharacter, EnemyStun)


				DamageHandler:TakeDamage(Character, EnemyHumanoid, 6, nil, nil, false, false, true, true, true, nil, nil)
				--NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.UpVector * 40 + Vector3.new(0, 20, 30) })
				RagdollHandler.ragdoll(EnemyHumanoid, 2)
				NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(1, 100000, 1), Velocity = HumRP.CFrame.UpVector * 75 })

			end)


			UserTrack.Stopped:Once(function()
				if Weld then
					pcall(function()
						Weld:Stop()
					end)
					Weld = nil
				end

				StunHandler:Unstun(Character, Stun)
				iFramesService:RemoveAlliFrames(Character)
				CollisionsModule:SetCollisionGroup(Character, "Players")
			end)


			VictimTrack.Stopped:Once(function()
				if Weld then
					pcall(function()
						Weld:Stop()
					end)
					Weld = nil
				end

				StunHandler:Unstun(EnemyCharacter, EnemyStun)
				EnemyCharacter:RemoveTag('CantRotate')
				iFramesService:RemoveAlliFrames(EnemyCharacter)
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")

			end)

			iFramesService:AddBaseiFrames(Character)
			iFramesService:AddBaseiFrames(EnemyCharacter)

			--SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.User, Character.Torso)
			--SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.Victim, EnemyCharacter.Torso)
			--end

			ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

			AnimationService:playAnimation(Character, UserAnimation)
			AnimationService:playAnimation(EnemyCharacter, VictimAnimation)

			shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 5 } })

			Weld:Start(nil, Player)
		end
			
		GrabHitbox.onTouch = function(EnemyCharacter)
			doGrab(EnemyCharacter)
		end
		
		task.delay(.6, function()
			--Maybe add a check to see if player is stunned.
			GrabHitbox:Start()
		end)
		
		for _, delayTime in ipairs(HitTimes) do
			task.delay(delayTime, function()
				if not UserTrack.IsPlaying then return end


				local Hitbox = HitboxHandler.new()
				Hitbox.Instance = HumRP
				Hitbox.Size = Vector3.new(1,1,3) * 11
				Hitbox.Offset = CFrame.new(0,0,-Hitbox.Size.Z/2)
				Hitbox.onTouch = function(EnemyCharacter)
					local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
					local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
					local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)

					if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead or EnemyCharacter:HasTag("Ragdolled") then return end

					local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0.75, 0.75, nil, true, true, true, true, false, nil, 13)

					if HitInfo.Countered == true then
						return
					end

					if not victimsInVortex[EnemyCharacter] then
						victimsInVortex[EnemyCharacter] = EnemyHumRP
						
						pcall(function()
							--EnemyHumRP:SetNetworkOwner(nil) 
						end)

						-- Optional: If you want to stop the pull if the enemy hits you
						-- You can remove them from the table if you are stunned.
					end
					if EnemyCharacter:HasTag('Ragdolled') then
						Hit = true
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
						--ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 0.75, Last = .1 })
					end
				end)
			end)
		end
		
		StartEvents["grab"] = UserTrack:GetMarkerReachedSignal("grab"):Once(function()
			--print("grab")
			
			--if grabHit == true then
			--	return
			--else
			--	local Hitbox = HitboxHandler.new()
			--	Hitbox.Instance = HumRP
			--	Hitbox.Size = Vector3.new(6, 8, 6)
			--	Hitbox.Offset = CFrame.new(0, (Hitbox.Size.Y / 2) - 3, -5)
			--	Hitbox.Ignore = { Character }
			--	Hitbox.onTouch = function(EnemyCharacter)
			--		doGrab(EnemyCharacter)
			--	end

			--	Hitbox:Once()
			--	Hitbox:Destroy()
			--end
		end)

		UserTrack.Stopped:Once(function()
			for _,v in StartEvents do
				v:Disconnect()
			end
			
			if GrabHitbox then
				GrabHitbox:Stop()
			end
			StunHandler:Unstun(Character, Stun)
			iFramesService:RemoveAlliFrames(Character)
		end)


		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		
		--RemotesContainer.ClientEffects:FireAllClients("BlackBeardFirstAbility", {Attacker = Character, SkillType =  "start"})
		--RemotesContainer.ClientEffects:FireAllClients("BlackBeardFirstAbility", {Attacker = Character, SkillType =  "LiberationTest"})
		RemotesContainer.ClientEffects:FireAllClients("BlackBeardFirstAbility", {Attacker = Character, SkillType =  "Vortex"})
	end
}