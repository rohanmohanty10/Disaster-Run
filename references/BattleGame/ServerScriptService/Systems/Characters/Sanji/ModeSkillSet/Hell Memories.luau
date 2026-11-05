-- Server: Auto Follow-Up Slash (SBG format)
-- Reference: scripts 6 & 7 | No press-again; follow-up fires automatically ~0.5s after hit.
-- Client fires bezier + VFX when it receives "SlashKick" ClientEffects events.

local TweenService      = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local Debris            = game:GetService("Debris")
local ServerStorage     = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService    = game:GetService("Players")

local ServerModules     = ServerStorage.SBGModules
local ReplicatedModules = ReplicatedStorage.Modules
local RemotesContainer  = ReplicatedStorage.Remotes

local StunHandler      = require(ServerModules.StunHandler)
local HitboxHandler    = require(ServerModules.HitboxHandler)
local DamageHandler    = require(ServerModules.DamageHandler)
local RagdollHandler   = require(ServerModules.RagdollHandler)
local NewKnockback     = require(ServerModules.BodymoverService)
local AnimationService = require(ServerModules.AnimationService)
local iFramesService   = require(ServerModules.iFramesService)
local CollisionsModule = require(ServerModules.CollisionsModule)
local SoundsModule     = require(ServerModules.SoundsModule)
local StatesHandler    = require(ServerModules.StatesHandler)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)


local WeldSystem   = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)
local Trove        = require(ReplicatedModules.Trove)

local Sounds    = ReplicatedStorage.Assets.Sounds
local AnimFolder      = ServerStorage.Assets.Animations.Sanji.Mode.HellMemories  -- ← swap this path
local MoveSounds      = Sounds.Characters
local ReplicateEffects_Set = RemotesContainer.Replicate.Set


--local DestructionHandler = require(ServerStorage.Modules.DestructionHandler)


-- Ground raycast (same Include pattern as script 8)
local GroundRay = RaycastParams.new()
GroundRay.FilterType = Enum.RaycastFilterType.Include
GroundRay.FilterDescendantsInstances = { workspace.World.Map }
GroundRay.RespectCanCollide = true
GroundRay.IgnoreWater = true


return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart    = Character.HumanoidRootPart

		-- Cooldown gate (same pattern as script 8)
		if Character:HasTag("Stunned") then return end

		if Player:GetAttribute("ModeAbilityTwoCooldown") then return end

		Player:SetAttribute("ModeAbilityTwoCooldown", true)

		local CooldownTime = 14
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = 0.5
		end

		Character:SetAttribute("SlashKickActive", true)

		local Janitor = Trove.new()
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, false)  -- locks attacker; mirrors script 6's 1s stun
		local Hit  = false
		
		local launchHandle = nil
		local launchHandleEnemy = nil
		
		local function dashSounds(hit)
			if hit == 1 then
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.DashWoosh1)
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.FireSFX)
			elseif hit == 2 then
				--SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.FireKick2)
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.FlameDash)
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.FireSFX)
			elseif hit == 3 then
				--SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.FireKick3)
				--SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.DashWoosh1)
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.FireKick1)
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.FireSFX)
			elseif hit == 4 then -- The jump part
				--SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.FireKick1)
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.FireSFX)
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.Jump)
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.FlameDash)
			end
		end
		
		local function hitSounds(hit)
			if hit == 1 then
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.Hits.First["hit kick"])
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.BasicHits["1"])
			elseif hit == 2 then
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.Hits.move4_endKickHit)
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.BasicHits["2"])
			elseif hit == 3 then
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.Hits.KickToAir)
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.Hits.Uppercut)
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.BasicHits["3"])
			elseif hit == 4 then
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.Hits.FireFinalKick)
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.BasicHits["4"])
			end
		end
		
		local function performFollowUp4(EnemyCharacter, EnemyPlayer, IncomingAttStun, IncomingEneStun)
			if not EnemyCharacter or not EnemyCharacter.Parent then return end

			local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
			local EnemyHumRP: BasePart    = EnemyCharacter.HumanoidRootPart

			if EnemyHumanoid.Health <= 0 then return end

			if IncomingAttStun then StunHandler:Unstun(Character, IncomingAttStun) end
			local AttStun5 = StunHandler:Stun(Character, nil, true, 0, 0, false)
			iFramesService:AddAlliFrames(Character)

			if IncomingEneStun then StunHandler:Unstun(EnemyCharacter, IncomingEneStun) end
			local EneStun4 = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

			--RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATasteTest", {
			--	Attacker  = Character,
			--	Victim    = EnemyCharacter,
			--	SkillType = "followUpImpact4",
			--})
			
			RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATasteTest", {
				Attacker  = Character,
				Victim    = EnemyCharacter,
				SkillType = "Hit4",
			})
			hitSounds(4)
			
			AnimationService:stopAll(EnemyCharacter)

			HumRP.AssemblyLinearVelocity = Vector3.new(0, 0, 0)

			local FollowUpWeld2 = WeldSystem.new(
				HumRP, EnemyHumRP,
				CFrame.new(0, 0, -2.23) * CFrame.Angles(0, math.pi, 0),
				-1
			)
			FollowUpWeld2:Start(nil, Player)

			task.delay(0.1, function()
				if FollowUpWeld2 then
					pcall(function() FollowUpWeld2:Stop() end)
					FollowUpWeld2 = nil
				end
				
				if launchHandle then
					launchHandle:Stop()
					launchHandle = nil
				end
				if launchHandleEnemy then
					launchHandleEnemy:Stop()
					launchHandleEnemy = nil
				end

				local enemyStillValid = EnemyCharacter.Parent and EnemyHumanoid.Health > 0

				if enemyStillValid then
					EnemyHumRP.CFrame = HumRP.CFrame
						* CFrame.new(0, 0, -10)
						* CFrame.Angles(0, math.pi, 0)

					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer },
					{ "ShakeCamera", { Intensity = 15, Last = 0.3 } })

					DamageHandler:TakeDamage(Character, EnemyHumanoid,
						7, nil, nil, false, false, true, true, true, nil, 6.5)

					EnemyCharacter:PivotTo(CFrame.lookAlong(EnemyHumRP.Position, HumRP.CFrame.RightVector))
					
					-- Old before attached destruction
					--NewKnockback:Knockback(EnemyCharacter, { 
					--	KnockbackType = "Velocity",
					--	MaxForce = Vector3.new(100000, 50000, 100000),
					--	Velocity = HumRP.CFrame.LookVector * 30 + Vector3.new(0, -100, 0), P = 1250 })

					--RagdollHandler.ragdoll(EnemyHumanoid, 2.5, false)
					
					RagdollHandler.ragdoll(EnemyHumanoid, 2.5, false, Character, nil, nil, true, {
						DestructionAttach = true,
						Size = Vector3.new(8, 8, 8),
						MaxDuration = 2.5,
						Player = EnemyPlayer,
						MinimumSize = 5,
						VoxelDestroyChance = 0,
						FlingDestroyChance = 0,
						ExtrapolateWithPing = true,
						Shake = true,
						IgnoreFloor = true,

						LaunchKnockback = {
							KnockbackType = "Velocity",
							MaxForce = Vector3.new(100000, 50000, 100000),
							Velocity = HumRP.CFrame.LookVector * 30 + Vector3.new(0, -100, 0), P = 1250 ,
						},
						
						VoxelVelocity = HumRP.CFrame.LookVector * 30 + Vector3.new(0, 10, 0),
					})

					ReplicateEffects_Set:FireAllClients("collisionWall", {
						root = EnemyHumRP,
						NoCrater = "regularSmokeSmash",
						hit = EnemyCharacter,
						caller = Character,
						OnlyCheck = { workspace.World.Map },
						Justdown = true,
					})
				end

				-- This IS the end of the whole combo — true release, no refresh.
				if EneStun4 then StunHandler:Unstun(EnemyCharacter, EneStun4); EneStun4 = nil end
				Character:RemoveTag("CantRotate")
				iFramesService:RemoveAlliFrames(Character)
				CollisionsModule:SetCollisionGroup(Character, "Players") -- We only do this with the player since the enemy will get their back after ragdoll.

				if AttStun5 then StunHandler:Unstun(Character, AttStun5); AttStun5 = nil end

				Character:SetAttribute("SlashKickActive", nil)
			end)
		end


		local function performFollowUp3(EnemyCharacter, EnemyPlayer, IncomingAttStun, IncomingEneStun)
			if not EnemyCharacter or not EnemyCharacter.Parent then return end

			local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
			local EnemyHumRP: BasePart    = EnemyCharacter.HumanoidRootPart

			if EnemyHumanoid.Health <= 0 then return end

			if IncomingAttStun then StunHandler:Unstun(Character, IncomingAttStun) end
			local AttStun4 = StunHandler:Stun(Character, nil, true, 0, 0, false)
			iFramesService:AddAlliFrames(Character)

			if IncomingEneStun then StunHandler:Unstun(EnemyCharacter, IncomingEneStun) end
			local EneStun3 = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

			--RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATasteTest", {
			--	Attacker  = Character,
			--	Victim    = EnemyCharacter,
			--	SkillType = "followUpImpact3",
			--})
			RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATasteTest", {
				Attacker  = Character,
				SkillType = "Hit3",
			})
			hitSounds(3)

			AnimationService:stopAll(EnemyCharacter)
			AnimationService:playAnimation(EnemyCharacter, AnimFolder.Knockback2)

			HumRP.AssemblyLinearVelocity = Vector3.new(0, 0, 0)

			local FollowUpWeld2 = WeldSystem.new(
				HumRP, EnemyHumRP,
				CFrame.new(0, 0, -2.23) * CFrame.Angles(0, math.pi, 0),
				-1
			)
			FollowUpWeld2:Start(nil, Player)

			task.delay(0.1, function()
				if FollowUpWeld2 then
					pcall(function() FollowUpWeld2:Stop() end)
					FollowUpWeld2 = nil
				end

				local enemyStillValid = EnemyCharacter.Parent and EnemyHumanoid.Health > 0

				if enemyStillValid then
					EnemyHumRP.CFrame = HumRP.CFrame
						* CFrame.new(0, 0, -10)
						* CFrame.Angles(0, math.pi, 0)

					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer },
					{ "ShakeCamera", { Intensity = 15, Last = 0.3 } })

					DamageHandler:TakeDamage(Character, EnemyHumanoid,
						5, nil, nil, false, false, true, true, false, nil, 6.5)

					EnemyCharacter:PivotTo(CFrame.lookAlong(EnemyHumRP.Position, HumRP.CFrame.RightVector))

					NewKnockback:Knockback(EnemyCharacter, {
						KnockbackType = "Velocity",
						MaxForce = Vector3.new(math.huge, math.huge, math.huge),
						Velocity = HumRP.CFrame.LookVector * 20 + Vector3.new(0, 95, 0),
						Time = 1.5, P = 1250
					})

					-- Refresh enemy stun (not release) — keeps them stunned through
					-- the launch arc and the gap into the next grab.
					if EneStun3 then StunHandler:Unstun(EnemyCharacter, EneStun3) end
					local NextEneStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

					Character:RemoveTag("CantRotate")
					task.delay(.25, function()
						if not Character.Parent or not EnemyCharacter.Parent or EnemyHumanoid.Health <= 0 then
							Character:RemoveTag("CantRotate")
							iFramesService:RemoveAlliFrames(Character)
							if AttStun4 then StunHandler:Unstun(Character, AttStun4); AttStun4 = nil end
							if NextEneStun then StunHandler:Unstun(EnemyCharacter, NextEneStun); NextEneStun = nil end
							Character:SetAttribute("SlashKickActive", nil)
							return
						end

						-- Refresh attacker stun (not release) — keeps them stunned
						-- through the gap and the next dash too.
						if AttStun4 then StunHandler:Unstun(Character, AttStun4) end
						local NextAttStun = StunHandler:Stun(Character, nil, true, 0, 0, false)

						RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATasteTest", {
							Attacker  = Character,
							Victim    = EnemyCharacter,
							SkillType = "followUpDash4",
						})
						
						dashSounds(4)
						
						Character:AddTag("CantRotate")

						task.delay(0.5167, function()
							performFollowUp4(EnemyCharacter, EnemyPlayer, NextAttStun, NextEneStun)
						end)
					end)
					return
				end

				-- Enemy invalid before this hit landed — clean up immediately
				if EneStun3 then StunHandler:Unstun(EnemyCharacter, EneStun3); EneStun3 = nil end
				Character:RemoveTag("CantRotate")
				iFramesService:RemoveAlliFrames(Character)

				if AttStun4 then StunHandler:Unstun(Character, AttStun4); AttStun4 = nil end

				Character:SetAttribute("SlashKickActive", nil)
			end)
		end


		local function performFollowUp2(EnemyCharacter, EnemyPlayer, IncomingAttStun, IncomingEneStun)
			if not EnemyCharacter or not EnemyCharacter.Parent then return end

			local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
			local EnemyHumRP: BasePart    = EnemyCharacter.HumanoidRootPart

			if EnemyHumanoid.Health <= 0 then return end

			if IncomingAttStun then StunHandler:Unstun(Character, IncomingAttStun) end
			local AttStun3 = StunHandler:Stun(Character, nil, true, 0, 0, false)
			iFramesService:AddAlliFrames(Character)

			if IncomingEneStun then StunHandler:Unstun(EnemyCharacter, IncomingEneStun) end
			local EneStun2 = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

			--RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATasteTest", {
			--	Attacker  = Character,
			--	Victim    = EnemyCharacter,
			--	SkillType = "followUpImpact2",
			--})
			RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATasteTest", {
				Attacker  = Character,
				SkillType = "Hit2",
			})
			hitSounds(2)
			
			AnimationService:stopAll(EnemyCharacter)
			AnimationService:playAnimation(EnemyCharacter, AnimFolder.Knockback2)

			HumRP.AssemblyLinearVelocity = Vector3.new(0, 0, 0)

			local FollowUpWeld2 = WeldSystem.new(
				HumRP, EnemyHumRP,
				CFrame.new(0, 0, -2.23) * CFrame.Angles(0, math.pi, 0),
				-1
			)
			FollowUpWeld2:Start(nil, Player)

			task.delay(0.1, function()
				if FollowUpWeld2 then
					pcall(function() FollowUpWeld2:Stop() end)
					FollowUpWeld2 = nil
				end

				local enemyStillValid = EnemyCharacter.Parent and EnemyHumanoid.Health > 0

				if enemyStillValid then
					EnemyHumRP.CFrame = HumRP.CFrame
						* CFrame.new(0, 0, -10)
						* CFrame.Angles(0, math.pi, 0)

					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer },
					{ "ShakeCamera", { Intensity = 15, Last = 0.3 } })

					DamageHandler:TakeDamage(Character, EnemyHumanoid,
						5, nil, nil, false, false, true, true, false, nil, 6.5)

					EnemyCharacter:PivotTo(CFrame.lookAlong(EnemyHumRP.Position, HumRP.CFrame.RightVector))

					NewKnockback:Knockback(EnemyCharacter, {
						KnockbackType = "Velocity",
						MaxForce = Vector3.new(math.huge, 0, math.huge),
						Velocity = -HumRP.CFrame.RightVector * 90,
						Time = 1.5, P = 1250
					})


					if EneStun2 then StunHandler:Unstun(EnemyCharacter, EneStun2) end
					local NextEneStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

					Character:RemoveTag("CantRotate")
					task.delay(.25, function()
						if not Character.Parent or not EnemyCharacter.Parent or EnemyHumanoid.Health <= 0 then
							Character:RemoveTag("CantRotate")
							iFramesService:RemoveAlliFrames(Character)
							if AttStun3 then StunHandler:Unstun(Character, AttStun3); AttStun3 = nil end
							if NextEneStun then StunHandler:Unstun(EnemyCharacter, NextEneStun); NextEneStun = nil end
							Character:SetAttribute("SlashKickActive", nil)
							return
						end

						if AttStun3 then StunHandler:Unstun(Character, AttStun3) end
						local NextAttStun = StunHandler:Stun(Character, nil, true, 0, 0, false)

						RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATasteTest", {
							Attacker  = Character,
							Victim    = EnemyCharacter,
							SkillType = "followUpDash3",
						})
						
						dashSounds(3)
						
						Character:AddTag("CantRotate")

						task.delay(0.5167, function()
							performFollowUp3(EnemyCharacter, EnemyPlayer, NextAttStun, NextEneStun)
						end)
					end)
					return
				end

				if EneStun2 then StunHandler:Unstun(EnemyCharacter, EneStun2); EneStun2 = nil end
				Character:RemoveTag("CantRotate")
				iFramesService:RemoveAlliFrames(Character)

				if AttStun3 then StunHandler:Unstun(Character, AttStun3); AttStun3 = nil end

				Character:SetAttribute("SlashKickActive", nil)
			end)
		end


		local function performFollowUp(EnemyCharacter, EnemyPlayer)
			if not EnemyCharacter or not EnemyCharacter.Parent then return end

			local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
			local EnemyHumRP: BasePart    = EnemyCharacter.HumanoidRootPart

			if EnemyHumanoid.Health <= 0 then return end

			-- Stun (refreshed in Hitbox.onTouch) hands off to AttStun2 here
			if Stun then StunHandler:Unstun(Character, Stun); Stun = nil end
			local AttStun2 = StunHandler:Stun(Character, nil, true, 0, 0, false)
			iFramesService:AddAlliFrames(Character)

			-- EnemyStun hands off to EneStun2 — this part was already gap-free
			local EneStun2 = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

			--RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATasteTest", {
			--	Attacker  = Character,
			--	Victim    = EnemyCharacter,
			--	SkillType = "followUpImpact",
			--})
			
			RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATasteTest", {
				Attacker  = Character,
				Victim    = EnemyCharacter,
				SkillType = "Hit1",
			})
			hitSounds(1)
			
			AnimationService:stopAll(EnemyCharacter)
			AnimationService:playAnimation(EnemyCharacter, AnimFolder.victimKnockback)

			HumRP.AssemblyLinearVelocity = Vector3.new(0, 0, 0)	
			
			local FollowUpWeld = WeldSystem.new(
				HumRP, EnemyHumRP,
				CFrame.new(0, 0, -2.23) * CFrame.Angles(0, math.pi, 0),
				-1
			)
			FollowUpWeld:Start(nil, Player)

			task.delay(0.1, function()
				if FollowUpWeld then
					pcall(function() FollowUpWeld:Stop() end)
					FollowUpWeld = nil
				end

				local enemyStillValid = EnemyCharacter.Parent and EnemyHumanoid.Health > 0

				if enemyStillValid then
					EnemyHumRP.CFrame = HumRP.CFrame
						* CFrame.new(0, 0, -10)
						* CFrame.Angles(0, math.pi, 0)

					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer },
					{ "ShakeCamera", { Intensity = 15, Last = 0.3 } })

					DamageHandler:TakeDamage(Character, EnemyHumanoid,
						5, nil, nil, false, false, true, true, false, nil, 6.5)

					local VictimAnimation = AnimFolder.Knockback2
					AnimationService:stopAll(EnemyCharacter)
					AnimationService:playAnimation(EnemyCharacter, VictimAnimation)

					EnemyCharacter:PivotTo(CFrame.lookAlong(EnemyHumRP.Position, -HumRP.CFrame.RightVector))

					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity",
						MaxForce = Vector3.new(math.huge, 0, math.huge),
						Velocity = HumRP.CFrame.RightVector * 90,
						Time = 1.5, P = 1250 })

					if EneStun2 then StunHandler:Unstun(EnemyCharacter, EneStun2) end
					local NextEneStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

					Character:RemoveTag("CantRotate")
					task.delay(.25, function()
						if not Character.Parent or not EnemyCharacter.Parent or EnemyHumanoid.Health <= 0 then
							Character:RemoveTag("CantRotate")
							iFramesService:RemoveAlliFrames(Character)
							if AttStun2 then StunHandler:Unstun(Character, AttStun2); AttStun2 = nil end
							if NextEneStun then StunHandler:Unstun(EnemyCharacter, NextEneStun); NextEneStun = nil end
							Character:SetAttribute("SlashKickActive", nil)
							return
						end

						if AttStun2 then StunHandler:Unstun(Character, AttStun2) end
						local NextAttStun = StunHandler:Stun(Character, nil, true, 0, 0, false)

						RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATasteTest", {
							Attacker  = Character,
							Victim    = EnemyCharacter,
							SkillType = "followUpDash2",
						})
						dashSounds(2)
						
						Character:AddTag("CantRotate")

						task.delay(0.5167, function()
							performFollowUp2(EnemyCharacter, EnemyPlayer, NextAttStun, NextEneStun)
						end)
					end)
					return
				end

				if EneStun2 then StunHandler:Unstun(EnemyCharacter, EneStun2); EneStun2 = nil end
				Character:RemoveTag("CantRotate")
				iFramesService:RemoveAlliFrames(Character)

				if AttStun2 then StunHandler:Unstun(Character, AttStun2); AttStun2 = nil end
				if Stun     then StunHandler:Unstun(Character, Stun);     Stun     = nil end

				Character:SetAttribute("SlashKickActive", nil)
			end)
		end
		
		
		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.Name = "moveme"
		BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000)
		BodyVelocity:SetAttribute("Speed", 100)
		BodyVelocity:SetAttribute("Fallout", .98)
		BodyVelocity:SetAttribute("End", 5)
		-- ================================================================
		--  STARTUP ANIMATION
		-- ================================================================
		local StartAnimation = AnimFolder.Normal
		local StartTrack     = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents    = {}

		local Hitbox = ReplicatedHitbox.new(Player)
		StartEvents["start"] = StartTrack:GetMarkerReachedSignal("start"):Once(function()
			if not Character.Parent then return end

			Hitbox.Instance  = HumRP
			Hitbox.Size      = Vector3.new(12, 12, 9)   
			Hitbox.Offset    = CFrame.new(0, 3, -5)  
			Hitbox.Ignore    = { Character }
			Hitbox.Visualize = false

			Hitbox.onTouch = function(EnemyCharacter)
				if Hit then return end

				if Character then
					ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
					if BodyVelocity then BodyVelocity:Destroy(); BodyVelocity = nil end
				end

				if Hitbox then
					Hitbox:Stop()
					Hitbox:Destroy()
					Hitbox = nil
				end

				local EnemyPlayer   = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart    = EnemyCharacter.HumanoidRootPart

				if iFramesService:HasiFrame(EnemyCharacter, 2)                    then return end
				if EnemyHumanoid.Health <= 0                                       then return end
				if EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead         then return end
				if EnemyCharacter:GetAttribute("Ragdolled")                        then return end

				Hit = true

				-- First hit damage
				local HitInfo = DamageHandler:TakeDamage(
					Character, EnemyHumanoid,
					5, nil, nil, false, true, true, true, false, nil, nil
				)
				if HitInfo.Countered == true then return end

				-- ============================================================
				--  DASH-GRAB (non-blocked branch from script 29)
				--  Weld user+enemy, play both anims, hold, release, THEN knockback.
				-- ============================================================
				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				end

				CollisionsModule:SetCollisionGroup(Character,      "Phasing")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "Phasing")

				AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)

				EnemyCharacter:AddTag("CantRotate")
				Character:AddTag("NoHeadFollow")

				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

				-- ← swap these two paths for your real user/victim animations
				local UserAnimation   = AnimFolder.Hit
				local VictimAnimation = AnimFolder.Victim
				local UserTrack     = AnimationService:getAnimationTrack(Character, UserAnimation)
				
				


				-- Weld them together (script 29 used -3 studs in front)
				local Weld = WeldSystem.new(
					HumRP, EnemyHumRP,
					CFrame.new(0, 0, -3) * CFrame.Angles(0, math.pi, 0),
					-1
				)
				
				UserTrack:GetMarkerReachedSignal("hit"):Once(function()
					hitSounds(1)
					SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.InitialHit.sendBack, HumRP)
					-- VFX/sound to client for the grab
					RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATasteTest", { --Only one which is horizantal.
						Attacker  = Character,
						SkillType = "Hit2",
					})
				end)
				
				UserTrack.Stopped:Once(function()
					if BodyVelocity then BodyVelocity:Destroy(); BodyVelocity = nil end

					--Character:RemoveTag("NoHeadFollow")
					--CollisionsModule:SetCollisionGroup(Character,      "Players")

					
					--if launchHandle then
					--	launchHandle:Stop()
					--	launchHandle = nil
					--end
					--if launchHandleEnemy then
					--	launchHandleEnemy:Stop()
					--	launchHandleEnemy = nil
					--end
					
					--warn("Stopped early for some reason")
				end)

				AnimationService:playAnimation(Character, UserAnimation)
				AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
				Weld:Start(nil, Player)
				
				SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.InitialHit.Hit1, HumRP)

				-- Hold the grab briefly, then release weld → knockback → enter the existing chain
				task.delay(0.65, function()
					-- Release the weld FIRST so the knockback isn't fighting it
					if Weld then
						pcall(function() Weld:Stop() end)
						Weld = nil
					end

					Character:RemoveTag("NoHeadFollow")
					EnemyCharacter:RemoveTag("CantRotate")

					if not Character.Parent or not EnemyCharacter.Parent or EnemyHumanoid.Health <= 0 then
						if EnemyStun then StunHandler:Unstun(EnemyCharacter, EnemyStun); EnemyStun = nil end
						return
					end

					-- Heavy knockback animation on enemy (unchanged from orig)
					AnimationService:stopAll(EnemyCharacter)
					AnimationService:playAnimation(EnemyCharacter, AnimFolder.Knockback1)

					-- === EXISTING knockback (moved verbatim from the old onTouch) ===
					local groundHit = workspace:Raycast(HumRP.Position, Vector3.new(0, -30, 0), GroundRay)
					if groundHit then
						local faceCFrame = CFrame.new(
							EnemyHumRP.Position * Vector3.new(1, 0, 1),
							groundHit.Position  * Vector3.new(1, 0, 1)
						)
						local launchPos = Vector3.new(
							EnemyHumRP.Position.X,
							groundHit.Position.Y + 2.6,
							EnemyHumRP.Position.Z
						)
						EnemyHumRP.CFrame = CFrame.new(launchPos, launchPos + faceCFrame.LookVector)

						NewKnockback:Knockback(EnemyCharacter, {
							KnockbackType = "Velocity",
							MaxForce      = Vector3.new(100000, 0, 100000),
							Velocity      = -faceCFrame.LookVector * Vector3.new(1, 0, 1) * 200,
						})
					else
						NewKnockback:Knockback(EnemyCharacter, {
							KnockbackType = "Velocity",
							MaxForce      = Vector3.new(100000, 50000, 100000),
							Velocity      = HumRP.CFrame.LookVector * 60 + Vector3.new(0, 25, 0),
						})
					end

					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer },
					{ "ShakeCamera", { Intensity = 9, Last = 0.2 } })

					-- Refresh attacker stun (unchanged from orig)
					if Stun then StunHandler:Unstun(Character, Stun) end
					Stun = StunHandler:Stun(Character, nil, true, 0, 0, false)

					-- === EXISTING dash chain — identical timing to the current script ===
					local DashStartDelay = .5

					task.delay(DashStartDelay, function()
						if not Character.Parent or not EnemyCharacter.Parent then return end

						RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATasteTest", {
							Attacker  = Character,
							Victim    = EnemyCharacter,
							SkillType = "followUpDash",
						})
						dashSounds(1)
						Character:AddTag("CantRotate")

						task.delay(0.5167, function()
							if EnemyStun then
								StunHandler:Unstun(EnemyCharacter, EnemyStun)
								EnemyStun = nil
							end
							performFollowUp(EnemyCharacter, EnemyPlayer)
						end)
					end)

					-- Destruction attaches (moved from old onTouch, unchanged)
					--launchHandle = DestructionHandler.attach(HumRP, {
					--	Size = Vector3.new(8, 8, 8),
					--	Shape = Enum.PartType.Ball,
					--	MaxDuration = 7,
					--	Player = Player,
					--	MinimumSize = 4,
					--	VoxelDestroyChance = .9,
					--	FlingDestroyChance = 1,
					--	Phasing = false,
					--	ExtrapolateWithPing = true,
					--	Shake = true,
					--	VoxelVelocity = HumRP.CFrame.LookVector * 30 + Vector3.new(0, 10, 0),
					--	IgnoreFloor = true,
					--})

					--launchHandleEnemy = DestructionHandler.attach(EnemyHumRP, {
					--	Size = Vector3.new(8, 8, 8),
					--	Shape = Enum.PartType.Ball,
					--	MaxDuration = 7,
					--	Player = EnemyPlayer,
					--	MinimumSize = 4,
					--	VoxelDestroyChance = .9,
					--	FlingDestroyChance = 1,
					--	Phasing = false,
					--	ExtrapolateWithPing = true,
					--	Shake = true,
					--	VoxelVelocity = EnemyHumRP.CFrame.LookVector * 30 + Vector3.new(0, 10, 0),
					--	IgnoreFloor = true,
					--})
				end)
			end

			Hitbox:Start()
			--task.delay(0.35, function()
			--	if Hitbox then Hitbox:Stop(); Hitbox = nil end
			--end)
		end)
		
		StartEvents["end"] = StartTrack:GetMarkerReachedSignal("end"):Once(function()
			--task.delay(0.35, function()
				if Hitbox then Hitbox:Stop(); Hitbox = nil end
			--end)
		end)

		

		-- ================================================================
		--  STARTUP ANIMATION STOPPED
		-- ================================================================
		StartTrack.Stopped:Once(function()
			for _, v in StartEvents do v:Disconnect() end

			-- Miss path: no hit was registered, clean up now
			if not Hit then
				Character:SetAttribute("SlashKickActive", nil)
				ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
				if BodyVelocity then BodyVelocity:Destroy(); BodyVelocity = nil end
				
				Character:RemoveTag('NoHeadFollow')
				local MissAnimation = ServerStorage.Assets.Animations.Sanji.Mode["Have A Taste"].Miss
				local MissTrack = AnimationService:getAnimationTrack(Character, MissAnimation)
				local MissEvents = {}

				-- Ensure the miss animation also clears the state when it ends
				MissTrack.Stopped:Once(function()
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
			end
			
			
			-- Cooldown (same as script 8: starts when startup animation ends)
			Player:SetAttribute("ModeAbilityTwoCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("ModeAbilityTwoCooldown", false)
				end
			end)
		end)

		Janitor:Add(Humanoid.Died:Connect(function()
			if Stun then StunHandler:Unstun(Character, Stun); Stun = nil end
		end))

		-- Fire "psa" equivalent to client before playing the startup animation
		RemotesContainer.ClientEffects:FireAllClients("SanjiHaveATasteTest", {
			Attacker  = Character,
			SkillType = "slashStart",
		})
		
		SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.StartDash.startDash3, HumRP)

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		
		task.delay(.3, function()
			--if not Character.Parent or not Character:GetAttribute("SanjiHaveATaste") then return end
			Character:AddTag('NoHeadFollow')
			if BodyVelocity then BodyVelocity.Parent = HumRP end
			SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.StartDash.startDash, HumRP)
			SoundHandler:AddSound(Sounds.Characters.Sanji.HaveATaste.StartDash.startDash2, HumRP)
		end)
	end
}