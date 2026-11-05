-- Sanji Ability 2
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


local NewAnimLocation = ServerStorage.Assets.Animations.Sanji["Mutton Kick"]


local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set


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
		
		if Player:GetAttribute("ModeAbilityTwoCooldown") then return end
		Player:SetAttribute("ModeAbilityTwoCooldown", 10)

		-- Start a 10-second cooldown timer
		task.delay(10, function()
			if Player then
				Player:SetAttribute("ModeAbilityTwoCooldown", false)
			end
		end)

		Character:SetAttribute("SanjiHaveATaste", true)
		
		local Janitor = Trove.new()
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local Hit = false

		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.Name = "moveme"
		BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000)
		BodyVelocity:SetAttribute("Speed", 120)
		BodyVelocity:SetAttribute("Fallout", .98)
		BodyVelocity:SetAttribute("End", 5)
		
		local StartAnimation = ServerStorage.Assets.Animations.Sanji.Mode["Have A Taste"].Normal
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}


		local Hitbox = ReplicatedHitbox.new(Player)
		Hitbox.Instance = HumRP
		Hitbox.Size = Vector3.new(8, 8, 8)
		Hitbox.Offset =  CFrame.new(0, 1, -4)
		Hitbox.Ignore = { Character }
		Hitbox.onTouch = function(EnemyCharacter)			
			if Character then
				ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
				BodyVelocity:Destroy()
				BodyVelocity = nil
			end

			if Hitbox then
				Hitbox:Stop()
				Hitbox:Destroy()
				Hitbox = nil
			end
			
			local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
			local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

			--if Hit == true or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
			if Hit == true or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
			Hit = true

			local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, nil, nil, false, true, true, true, false, nil, 19.5)
			if HitInfo.Countered == true then return end --Simple and easy
			
			local HitConfirmed = false
			
			if HitInfo.Blocked then
				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				end

				CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")

				AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)

				EnemyCharacter:AddTag("CantRotate")
				--Character:AddTag("CantRotate")
				Character:AddTag('NoHeadFollow')

				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

				local UserAnimation = ServerStorage.Assets.Animations.Sanji.Mode["Have A Taste"].Hit
				local UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
				local UserEvents = {}

				local VictimAnimation = ServerStorage.Assets.Animations.Sanji.Mode["Have A Taste"].Victim
				local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
				local VictimEvents = {}

				local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -4.5) * CFrame.Angles(0, math.pi, 0), -1)	

				UserEvents["hit"] = UserTrack:GetMarkerReachedSignal("hit"):Once(function()
					if Weld then
						pcall(function()
							Weld:Stop()
						end)
						Weld = nil
					end

					if EnemyStun then                                -- still truthy → fires again
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						EnemyStun = nil
					end

					HitConfirmed = true

					iFramesService:RemoveAlliFrames(EnemyCharacter)
					EnemyCharacter:RemoveTag("CantRotate")
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 9, Last = 0.2 } })

					--NewKnockback:Knockback(EnemyCharacter, {KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.LookVector * 100 + Vector3.new(0, 40, 0) })
					--RagdollHandler.ragdoll(EnemyHumanoid, 2.25)

					--RagdollHandler.ragdoll(EnemyHumanoid, 2.25, false, Character, nil, nil, true, 
					--	{
					--		Size = Vector3.new(5, 5, 5),
					--		MaxDuration = 2,
					--		Player = Player,
					--		MinimumSize = 4,
					--		VoxelDestroyChance = 0,
					--		FlingDestroyChance = 1,
					--		LaunchKnockback = {
					--			KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.LookVector * 100 + Vector3.new(0, 40, 0)
					--		}

					--	}
					--)
					--RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true, {
					--	DestructionAttach = {

					--	},
					--})

					--RagdollHandler.ragdoll(EnemyHumanoid, 2.25, false, Character, nil, nil, true, 
					--	{
					--		Size = Vector3.new(10, 10, 10),
					--		MaxDuration = 2,
					--		Player = Player,
					--		MinimumSize = 4,
					--		VoxelDestroyChance = 0,
					--		FlingDestroyChance = 1,
					--		LaunchKnockback = {
					--			KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.LookVector * 100 + Vector3.new(0, 40, 0)
					--		},

					--		VoxelVelocity = function(voxel, hitPos)
					--			local outward = voxel.Position - hitPos
					--			outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)
					--			return outward * math.random(40, 80) + Vector3.new(0, 20, 0)
					--		end,
					--	}
					--)

					RagdollHandler.ragdoll(EnemyHumanoid, 2.25, false, Character, nil, nil, true, {
						DestructionAttach = true,              -- ← add this; it's what your handler checks
						Size = Vector3.new(10, 10, 10),
						MaxDuration = 2.25,
						Player = Player,
						MinimumSize = 6,
						VoxelDestroyChance = 0,
						FlingDestroyChance = 0,
						ExtrapolateWithPing = true,
						Shake = true,


						LaunchKnockback = {
							KnockbackType = "Velocity",
							MaxForce = Vector3.new(100000, 50000, 100000),
							Velocity = HumRP.CFrame.LookVector * 80 + Vector3.new(0, 40, 0),
						},
						--VoxelVelocity = function(voxel, hitPos)
						--	local outward = voxel.Position - hitPos
						--	outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)
						--	return outward * math.random(30, 60) + Vector3.new(0, 20, 0)
						--end,
						VoxelVelocity = HumRP.CFrame.LookVector * 30 + Vector3.new(0, 10, 0),
					})
				end)

				VictimTrack.Stopped:Once(function()
					if Weld then
						pcall(function()
							Weld:Stop()
						end)
						Weld = nil
					end

					for _,v in VictimEvents do
						v:Disconnect()
					end

					if EnemyStun then
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						EnemyStun = nil
					end

					iFramesService:RemoveAlliFrames(EnemyCharacter)

					if not HitConfirmed then
						CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players") -- can't add this cause of the destruction stuff. But if someone leaves, enemy would be bugged. So we have to add not hit.
					end

					if HitConfirmed and not EnemyCharacter:HasTag("Ragdolled") then
						CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
					end

					EnemyCharacter:RemoveTag("CantRotate")
				end)

				UserTrack.Stopped:Once(function()
					-- Clear the state so we know the move is completely over (or was interrupted)
					Character:SetAttribute("SanjiHaveATaste", nil)

					if Weld then
						pcall(function() Weld:Stop() end)
						Weld = nil
					end

					for _,v in UserEvents do v:Disconnect() end

					Character:RemoveTag('NoHeadFollow')
					Character:RemoveTag("CantRotate")

					if Stun then
						StunHandler:Unstun(Character, Stun)
						Stun = nil
					end

					iFramesService:RemoveAlliFrames(Character)
					CollisionsModule:SetCollisionGroup(Character, "Players")
				end)

				--iFramesService:AddAlliFrames(Character)
				--iFramesService:AddAlliFrames(EnemyCharacter)
				--RemotesContainer.Velocity.DestroyVelocity:FireClient(Player, "moveme")
				--RemotesContainer.Velocity.DestroyVelocity:FireClient()

				--ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

				AnimationService:playAnimation(Character, UserAnimation)
				AnimationService:playAnimation(EnemyCharacter, VictimAnimation)

				Weld:Start(nil, Player) --No more or player
				--RemotesContainer.ClientEffects:FireAllClients("SanjiFirstAbility", {Attacker = Character, SkillType =  "finisherStart",})
			else
				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				end

				CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")

				AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)

				EnemyCharacter:AddTag("CantRotate")
				Character:AddTag('NoHeadFollow')

				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

				local UserAnimation = ServerStorage.Assets.Animations.Sanji.Mode["Have A Taste"].NewTest
				local UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
				local UserEvents = {}

				--local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
				--local VictimEvents = {}

				local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -3) * CFrame.Angles(0, math.pi, 0), -1)

				-- ===== Follow-up combo =====
				local TotalFollowUps = 4
				local FollowUpCount = 1
				local Finished = false

				local function FinishCombo()
					if Finished then return end
					Finished = true
					HitConfirmed = true

					if UserEvents["hit"] then
						UserEvents["hit"]:Disconnect()
						UserEvents["hit"] = nil
					end

					if Weld then
						pcall(function() Weld:Stop() end)
						Weld = nil
					end

					if EnemyStun then
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						EnemyStun = nil
					end

					iFramesService:RemoveAlliFrames(EnemyCharacter)
					EnemyCharacter:RemoveTag("CantRotate")

					RagdollHandler.ragdoll(EnemyHumanoid, 2.25, false, Character, nil, nil, true, {
						DestructionAttach = true,
						Size = Vector3.new(10, 10, 10),
						MaxDuration = 2.25,
						Player = Player,
						MinimumSize = 6,
						VoxelDestroyChance = 0,
						FlingDestroyChance = 0,
						ExtrapolateWithPing = true,
						Shake = true,
						LaunchKnockback = {
							KnockbackType = "Velocity",
							MaxForce = Vector3.new(100000, 50000, 100000),
							Velocity = HumRP.CFrame.LookVector * 80 + Vector3.new(0, 40, 0),
						},
						VoxelVelocity = HumRP.CFrame.LookVector * 30 + Vector3.new(0, 10, 0),
					})
				end

				-- :Connect (not :Once) so it fires on every "hit" marker, not just the first.
				UserEvents["hit"] = UserTrack:GetMarkerReachedSignal("hit"):Connect(function()
					if Finished then return end
					if not EnemyCharacter or not EnemyCharacter.Parent or EnemyHumanoid.Health <= 0 then
						return
					end
					
					if Stun then
						StunHandler:Unstun(Character, Stun)
						Stun = nil
					end
					
					if EnemyStun then
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						Stun = nil
					end
					
					if Weld then
						pcall(function() Weld:Stop() end)
						Weld = nil
					end
					
					--if EnemyCharacter:HasTag("Ragdolled") then
					--	RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
					--end
					
					--RagdollHandler.ragdoll(EnemyHumanoid, 2.25)
					if FollowUpCount == 1 then
						warn("hit1")
						FollowUpCount += 1
						
						local VictimAnimation = ServerStorage.Assets.Animations.Sanji.Mode["Have A Taste"].VictimHits["1"]
						local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
						
						DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, nil, nil, false, true, true, true, false, nil, 19.5)
						
						EnemyCharacter:PivotTo(CFrame.lookAlong(EnemyHumRP.Position, -HumRP.CFrame.LookVector))
						NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(math.huge, 0, math.huge), Velocity = HumRP.CFrame.LookVector * 40, Time = VictimTrack.Length, P = 1250 })

						task.delay(VictimTrack.Length + .1, function()
							RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATaste", {Attacker = Character, SkillType =  "useTwice", Player = Player, time_between = .1, Enemy = EnemyCharacter})
							AnimationService:stopAnimation(Character, UserAnimation)
						end)	
						AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
						
					elseif FollowUpCount == 2 then
						warn("hit2")
						FollowUpCount += 1
						local VictimAnimation = ServerStorage.Assets.Animations.Sanji.Mode["Have A Taste"].VictimHits["2"]
						local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
						
						DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, nil, nil, false, true, true, true, false, nil, 19.5)

						EnemyCharacter:PivotTo(CFrame.lookAlong(EnemyHumRP.Position, -HumRP.CFrame.RightVector))
						NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(math.huge, 0, math.huge), Velocity = HumRP.CFrame.RightVector * 100, Time = VictimTrack.Length, P = 1250 })

						task.delay(1, function()
							RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATaste", {Attacker = Character, SkillType =  "useTwice", Player = Player, time_between = .1, Enemy = EnemyCharacter})
						end)
	
						AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
			
					elseif FollowUpCount == 3 then
						warn("hit3")
						FollowUpCount += 1
						local VictimAnimation = ServerStorage.Assets.Animations.Sanji.Mode["Have A Taste"].VictimHits["3"]
						local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
						
						DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, nil, nil, false, true, true, true, false, nil, 19.5)

						EnemyCharacter:PivotTo(CFrame.lookAlong(EnemyHumRP.Position, HumRP.CFrame.RightVector))
						NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(math.huge, 0, math.huge), Velocity = -HumRP.CFrame.RightVector * 55, Time = .5, P = 1250 })

						task.delay(.3, function()
							RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATaste", {Attacker = Character, SkillType =  "useTwice", Player = Player, time_between = .1, Enemy = EnemyCharacter})
						end)
						
						AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
					
					elseif FollowUpCount == 4 then
						warn("hit4")
						
						local VictimAnimation = ServerStorage.Assets.Animations.Sanji.Mode["Have A Taste"].VictimHits["4"]
						local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
						
						DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, nil, nil, false, true, true, true, false, nil, 19.5)

						EnemyCharacter:PivotTo(CFrame.lookAlong(EnemyHumRP.Position, -HumRP.CFrame.LookVector))
						NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(math.huge, 0, math.huge), Velocity = HumRP.CFrame.LookVector * 55, Time = .5, P = 1250 })

						task.delay(.3, function()
							RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATaste", {Attacker = Character, SkillType =  "useTwice", Player = Player, time_between = .1, Enemy = EnemyCharacter})
						end)
						AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
						
					--elseif FollowUpCount >= TotalFollowUps then
					--	warn("hit4")
					--	FinishCombo()
					end
				end)

				--VictimTrack.Stopped:Once(function()
				--	if Weld then
				--		pcall(function() Weld:Stop() end)
				--		Weld = nil
				--	end

				--	for _, v in VictimEvents do v:Disconnect() end

				--	if EnemyStun then
				--		StunHandler:Unstun(EnemyCharacter, EnemyStun)
				--		EnemyStun = nil
				--	end

				--	iFramesService:RemoveAlliFrames(EnemyCharacter)

				--	if not HitConfirmed then
				--		CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
				--	end

				--	if HitConfirmed and not EnemyCharacter:HasTag("Ragdolled") then
				--		CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
				--	end

				--	EnemyCharacter:RemoveTag("CantRotate")
				--end)

				UserTrack.Stopped:Once(function()
					Character:SetAttribute("SanjiHaveATaste", nil)

					if Weld then
						pcall(function() Weld:Stop() end)
						Weld = nil
					end

					for _, v in UserEvents do
						if v then v:Disconnect() end
					end

					Character:RemoveTag('NoHeadFollow')
					Character:RemoveTag("CantRotate")

					if Stun then
						StunHandler:Unstun(Character, Stun)
						Stun = nil
					end

					iFramesService:RemoveAlliFrames(Character)
					CollisionsModule:SetCollisionGroup(Character, "Players")
				end)

				AnimationService:playAnimation(Character, UserAnimation)

				Weld:Start(nil, Player)
			end						
		end
		
		Janitor:Add(Humanoid.Died:Connect(function()
			if Stun then StunHandler:Unstun(Character, Stun); Stun = nil end
			if BodyVelocity then BodyVelocity:Destroy(); BodyVelocity = nil end
			if Hitbox then Hitbox:Destroy(); Hitbox = nil end
		end))

		StartEvents["start"] = StartTrack:GetMarkerReachedSignal("start"):Once(function()
			print("KickStart")
			--Hitbox:Destroy()

			--RemotesContainer.ClientEffects:FireAllClients("SanjiFirstAbility", {Attacker = Character, SkillType =  "hit",})
		end)

		StartEvents["end"] = StartTrack:GetMarkerReachedSignal("end"):Once(function()
			if Hitbox then
				Hitbox:Stop()
				Hitbox:Destroy()
				Hitbox = nil
			end
		end)

		StartTrack.Stopped:Once(function()
			if Hitbox then
				Hitbox:Stop()
				Hitbox:Destroy()
				Hitbox = nil
			end
			
			for _,v in StartEvents do
				v:Disconnect()
			end

			if not Hit then
				if Character then
					ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
					BodyVelocity:Destroy()
					BodyVelocity = nil
				end

				Character:RemoveTag('NoHeadFollow')
				if Character:GetAttribute("SanjiHaveATaste") then
					-- They finished naturally and missed. Play the miss animation.
					local MissAnimation = ServerStorage.Assets.Animations.Sanji.Mode["Have A Taste"].Miss
					local MissTrack = AnimationService:getAnimationTrack(Character, MissAnimation)
					local MissEvents = {}

					-- Ensure the miss animation also clears the state when it ends
					MissTrack.Stopped:Once(function()
						Character:SetAttribute("SanjiHaveATaste", nil)
						for _,v in MissEvents do
							v:Disconnect()
						end
						if Stun then
							StunHandler:Unstun(Character, Stun)
							Stun = nil
						end
					end)

					AnimationService:stopAll(Character)
					AnimationService:playAnimation(Character, MissAnimation)
				else
					-- They were punched out of the dash. Just clean up the stun and exit.
					if Stun then
						StunHandler:Unstun(Character, Stun)
						Stun = nil
					end
				end
			end
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)

		SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.Start, Character.Torso)
		--SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.StartExtra, Character.Torso)
		--RemotesContainer.ClientEffects:FireAllClients("SanjiFirstAbility", {Attacker = Character, SkillType =  "start",})
		task.delay(.3, function()
			if not Character.Parent or not Character:GetAttribute("SanjiHaveATaste") then return end
			Character:AddTag('NoHeadFollow')
			if BodyVelocity then BodyVelocity.Parent = HumRP end
			if Hitbox then Hitbox:Start(1, true) end
		end)
	end
}