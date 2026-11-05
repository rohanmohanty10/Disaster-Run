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
--local DestructionHandler = require(ServerStorage.Modules.DestructionHandler)


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)

local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds


local NewAnimLocation = ServerStorage.Assets.Animations.Zoro.Moveset.ModeMoveSet["3000worlds"]


local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set


local rad = math.rad


local IndestructibleParams = RaycastParams.new()
IndestructibleParams.FilterType = Enum.RaycastFilterType.Include
IndestructibleParams.FilterDescendantsInstances = { workspace.World.Map["Indestructible Map"] }
IndestructibleParams.RespectCanCollide = true

local WALL_BUFFER = 5

local function getDashDistance(originCF: CFrame, maxDist: number): number
	local result = workspace:Raycast(
		originCF.Position,
		originCF.LookVector * maxDist,
		IndestructibleParams
	)
	if result then
		return math.max(result.Distance - WALL_BUFFER, 0)
	end
	return maxDist
end


return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("ModeAbilityTwoCooldown") then return end
		if Character:GetAttribute("ZoroSecondAbility") then return end

		Player:SetAttribute("ModeAbilityTwoCooldown", true)
		Character:SetAttribute("ZoroSecondAbility", true)
		
		local CooldownTime = 30
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end
		
		local Janitor = Trove.new()

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		--local initialAnim = NewAnimLocation.Miss
		local initialAnim = NewAnimLocation.Miss

		local StartAnimation = initialAnim
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		local Assets = {}
		local Container = {}
		
		local Hit = false
		local Finisher = false
		local startSound

		

		local SwordSpinWind
		local GroundScrape
		
		StartEvents["spin"] = StartTrack:GetMarkerReachedSignal("spin"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
				Attacker  = Character,
				SkillType = "spin",            
			})
			SwordSpinWind = SoundHandler:AddSound(Sounds.Characters.Zoro.Moves["3000Worlds"].AnotherSlash, HumRP)
			GroundScrape = SoundHandler:AddSound(Sounds.Characters.Zoro.Moves["3000Worlds"].GroundScrape, HumRP)
			
			SoundHandler:StopSound(startSound, .2)

		end)
		
		
		
		local Hitbox = HitboxHandler.new()
		StartEvents["move"] = StartTrack:GetMarkerReachedSignal("move"):Once(function()
			SoundHandler:AddSound(Sounds.Characters.Zoro.Moves["3000Worlds"].New.Dash, HumRP)
			SoundHandler:AddSound(Sounds.Characters.Zoro.Moves["3000Worlds"].HitSU, HumRP)

			RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
				Attacker  = Character,
				SkillType = "spinstop",
			})
			
			SoundHandler:StopSound(SwordSpinWind, .5)
			SoundHandler:StopSound(GroundScrape, .5)

			local UserAnimation = NewAnimLocation.UserNormal
			local UserTrack, UserEvents = AnimationService:getAnimationTrack(Character, UserAnimation)

			local DASH_DISTANCE = 55
			local origin      = HumRP.CFrame
			local lookDir     = origin.LookVector
			local dashDist    = getDashDistance(origin, DASH_DISTANCE)
			local destination = origin.Position + lookDir * dashDist
			local flatDest    = Vector3.new(destination.X, origin.Position.Y, destination.Z)
			local dashCFrame  = dashDist >= 1 and CFrame.new(origin.Position, flatDest) or origin

			--local results = DestructionHandler.destroy(
			--	Vector3.new(15, 10, 60),
			--	HumRP.CFrame * CFrame.new(0, 2, -25),
			--	Enum.PartType.Block,
			--	{
			--		MinimumSize = 5, --5.5,
			--		TimeToReset = 30,
			--		Player = Player,
			--		VoxelDestroyChance = 0.5,
			--		FlingDestroyChance = 1,
			--		VoxelVelocity = HumRP.CFrame.LookVector * 30,
			--		Visualize = true,
			--		IgnoreFloor = true
			--	}
			--)
			local results
			--if dashDist >= 1 then
			--	results = DestructionHandler.destroy(
			--		Vector3.new(15, 10, dashDist),                        -- was 60
			--		HumRP.CFrame * CFrame.new(0, 2, -(dashDist / 2 + 5)), -- was -25
			--		Enum.PartType.Block,
			--		{
			--			MinimumSize = 5, --5.5,
			--			TimeToReset = 30,
			--			Player = Player,
			--			VoxelDestroyChance = 0.5,
			--			FlingDestroyChance = 1,
			--			VoxelVelocity = HumRP.CFrame.LookVector * 30,
			--			Visualize = true,
			--			IgnoreFloor = true
			--		}
			--	)
			--end
			

			-- Whiff cleanup: only runs if no hit landed by the time this animation ends
			UserTrack.Stopped:Once(function()
				if Hit then return end
				StunHandler:Unstun(Character, Stun)
				iFramesService:RemoveAlliFrames(Character)
				CollisionsModule:SetCollisionGroup(Character, "Players")
				Character:RemoveTag("CantRotate")
				
				Character:SetAttribute("ZoroSecondAbility", nil)

				Player:SetAttribute("ModeAbilityTwoCooldown", CooldownTime)
				task.delay(CooldownTime, function()
					if Player then
						Player:SetAttribute("ModeAbilityTwoCooldown", false)
					end
				end)
			end)

			AnimationService:stopAll(Character)
			AnimationService:playAnimation(Character, UserAnimation)

			RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
				Attacker    = Character,
				SkillType   = "teleportVFX",
				Origin      = origin.Position,
				DashCFrame  = dashCFrame,
				Destination = destination,
			})

			RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
				Attacker     = Character,
				SkillType    = "teleport",
				--Destination  = HumRP.CFrame * CFrame.new(0, 0, -DASH_DISTANCE),
				Destination  = HumRP.CFrame * CFrame.new(0, 0, -dashDist),  -- was -DASH_DISTANCE
			})
			
			
			
			Hitbox.Instance = HumRP
			local hbLen = math.max(dashDist, 6)          -- 6-stud floor for point-blank casts
			Hitbox.Size = Vector3.new(15, 10, hbLen)     -- was 55
			Hitbox.Offset = CFrame.new(0, 0, -(hbLen * 18 / 55))  -- was -18; keeps the original ratio
			--Hitbox.Instance = HumRP
			--Hitbox.Size = Vector3.new(15, 10, 55)
			--Hitbox.Offset = CFrame.new(0, 0, -18)
			Hitbox.Ignore = { Character }
			Hitbox.Visualize = true
			Hitbox.onTouch = function(EnemyCharacter)
				Hitbox:Destroy()
				ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if Hit == true or iFramesService:HasiFrame(EnemyCharacter, 2) then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 45, nil, nil, false, EnemyCharacter:HasTag('DEATH') and true or false, true, true, false, nil, 40)
				if HitInfo.Countered then return end
				Hit = true

				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
				end

				EnemyCharacter:AddTag("CantRotate")
				Character:AddTag("CantRotate")

				iFramesService:AddAlliFrames(Character)
				iFramesService:AddAlliFrames(EnemyCharacter)

				CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")

				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

				if HitInfo.Finisher == true and not Finisher then
					Finisher = true

					-- Finisher is the only case that repositions you relative to the enemy
					local myLook = HumRP.CFrame.LookVector
					local targetPos = EnemyHumRP.Position
					EnemyHumRP.CFrame = CFrame.lookAt(targetPos, targetPos + myLook)
					local behindEnemyOffset = EnemyHumRP.CFrame * CFrame.new(0, 0, 3)
					HumRP.CFrame = behindEnemyOffset

					local FinisherUserAnimation = NewAnimLocation.UserFinisher
					local FinisherVictimAnimation = NewAnimLocation.VictimFinisher

					local FinVictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, FinisherVictimAnimation)
					local FinUserTrack, FinUserEvents = AnimationService:getAnimationTrack(Character, FinisherUserAnimation)

					--table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("Flash"):Once(function()
						RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
							Attacker  = Character,
							SkillType = "Flash",
							targetPosition = targetPos,
						})
					--end))
					table.insert(FinUserEvents, FinUserTrack:GetMarkerReachedSignal("SlashEnd"):Once(function()

						RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
							Attacker  = Character,
							SkillType = "SlashEnd",
						})
					end))
					table.insert(FinUserEvents, FinUserTrack:GetMarkerReachedSignal("fall"):Once(function()
						RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
							Attacker  = Character,
							SkillType = "fall",
						})
					end))
					table.insert(FinUserEvents, FinUserTrack:GetMarkerReachedSignal("blood"):Once(function()
						local bloodTargetPos = EnemyHumRP.Position
						RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
							Attacker  = Character,
							SkillType = "blood",
							targetPosition = bloodTargetPos,
							enemyCFrame   = EnemyHumRP.CFrame
						})
						--DamageHandler:TakeDamage(Character, EnemyHumanoid, EnemyHumanoid.Health, nil, nil, false, false, true, true, true, nil, nil)
					end))
					table.insert(FinUserEvents, FinUserTrack:GetMarkerReachedSignal("bloodsword"):Once(function()
						RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
							Attacker  = Character,
							SkillType = "bloodsword",
						})
					end))

					FinVictimTrack.Stopped:Once(function()
						DamageHandler:TakeDamage(Character, EnemyHumanoid, EnemyHumanoid.Health, nil, nil, false, false, true, true, true, nil, nil)
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						iFramesService:RemoveAlliFrames(EnemyCharacter)
						CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
						EnemyCharacter:RemoveTag("CantRotate")
						
						Character:SetAttribute("ZoroSecondAbility", nil)

						Player:SetAttribute("ModeAbilityTwoCooldown", CooldownTime)
						task.delay(CooldownTime, function()
							if Player then
								Player:SetAttribute("ModeAbilityTwoCooldown", false)
							end
						end)
						
					end)

					FinUserTrack.Stopped:Once(function()
						StunHandler:Unstun(Character, Stun)
						iFramesService:RemoveAlliFrames(Character)
						CollisionsModule:SetCollisionGroup(Character, "Players")
						Character:RemoveTag("CantRotate")
					end)

					AnimationService:stopAll(Character)
					AnimationService:stopAll(EnemyCharacter)
					AnimationService:playAnimation(Character, FinisherUserAnimation)
					AnimationService:playAnimation(EnemyCharacter, FinisherVictimAnimation)

					local FDASH = 16
					local forigin = HumRP.CFrame
					local flook = forigin.LookVector
					local fdashDist = getDashDistance(forigin, FDASH)                                    -- NEW
					local fdest = forigin.Position + flook * fdashDist                                   -- was FDASH
					local fflat = Vector3.new(fdest.X, forigin.Position.Y, fdest.Z)
					local fdashCFrame = fdashDist >= 1 and CFrame.new(forigin.Position, fflat) or forigin -- degenerate guard

					RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
						Attacker    = Character,
						SkillType   = "teleportVFX",
						Origin      = forigin.Position,
						DashCFrame  = fdashCFrame,
						Destination = fdest,
					})
					RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
						Attacker     = Character,
						SkillType    = "teleport",
						--Destination  = HumRP.CFrame * CFrame.new(0, 0, -FDASH),
						Destination  = HumRP.CFrame * CFrame.new(0, 0, -fdashDist),  -- was -FDASH
					})
					shared.fireTo(ReplicateEffects_Set, {Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 16, Last = 1 } })
					--RemotesContainer.ClientEffects:FireClient(Player, "ThreethousandWorlds", {
					--	Attacker    = Character,
					--	SkillType   = "Camera",
					--	EnemyHRPCFrame = EnemyHumRP.CFrame,
					--})
					--if EnemyPlayer then
					--	RemotesContainer.ClientEffects:FireClient(EnemyPlayer, "ThreethousandWorlds", {
					--		Attacker  = Character,
					--		SkillType = "Camera",
					--		EnemyHRPCFrame = EnemyHumRP.CFrame,
					--	})
					--end
				else
					-- Normal hit: no repositioning, you stay exactly where your dash put you
					local myLook = HumRP.CFrame.LookVector
					local targetPos = EnemyHumRP.Position
					EnemyHumRP.CFrame = CFrame.lookAt(targetPos, targetPos + myLook)
					local behindEnemyOffset = EnemyHumRP.CFrame * CFrame.new(0, 0, 3)
					HumRP.CFrame = behindEnemyOffset
					
					
					local VictimAnimation = NewAnimLocation.VictimNormal
					local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
					
					--table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("Flash"):Once(function()
						RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
							Attacker  = Character,
							SkillType = "Flash",
							targetPosition = targetPos,
						})
					--end))
					task.delay(.4, function()
						--table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("SlashEnd"):Once(function()
							RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
								Attacker  = Character,
								SkillType = "SlashEnd",
							})
						--end))
					end)
					

					VictimTrack.Stopped:Once(function()
						task.delay(.7, function()
							StunHandler:Unstun(EnemyCharacter, EnemyStun)
							iFramesService:RemoveAlliFrames(EnemyCharacter)
							CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
							EnemyCharacter:RemoveTag("CantRotate")
						end)
					end)

					AnimationService:stopAll(EnemyCharacter)
					AnimationService:playAnimation(EnemyCharacter, VictimAnimation)

					-- This re-registers the real unstun for the attacker since the move marker's
					-- whiff-guard (`if Hit then return end`) skipped it once Hit became true.
					UserTrack.Stopped:Once(function()
						StunHandler:Unstun(Character, Stun)
						iFramesService:RemoveAlliFrames(Character)
						CollisionsModule:SetCollisionGroup(Character, "Players")
						Character:RemoveTag("CantRotate")
						
						Character:SetAttribute("ZoroSecondAbility", nil)

						Player:SetAttribute("ModeAbilityTwoCooldown", CooldownTime)
						task.delay(CooldownTime, function()
							if Player then
								Player:SetAttribute("ModeAbilityTwoCooldown", false)
							end
						end)
						
					end)
				end
			end
			Hitbox:Start()
			task.delay(0.2, function() -- tune to match how long the dash/swing should realistically be able to land
				if Hit then return end -- already resolved via a real hit, nothing to clean up
				if Hitbox then
					Hitbox:Destroy()
				end
			end)
		end)

		StartEvents["spinstop"] = StartTrack:GetMarkerReachedSignal("spinstop"):Once(function()
			if Hitbox then
				Hitbox:Destroy()

			end			
			RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
				Attacker  = Character,
				SkillType = "spinstop",            
			})
			
		end)	

		StartTrack.Stopped:Once(function()
			

			for _,v in StartEvents do
				v:Disconnect()
			end
			

			if Hit then return end

			--StunHandler:Unstun(Character, Stun)
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		startSound = SoundHandler:AddSound(Sounds.Characters.Zoro.Moves["3000Worlds"].New.Start, HumRP)

		--temp
		--RemotesContainer.ClientEffects:FireAllClients("TigerHunt", {Attacker = Character, SkillType =  "start",})
	end
}