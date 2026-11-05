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
--local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local StatesHandler = require(ServerModules.StatesHandler)


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)
local Velocity = require(ReplicatedStorage.Modules.Velocity)

local services = require(ReplicatedStorage.Services)
local VfxUtility = services:GetService("VFX_Utility")
local knockbackService = services:GetService("KnockbackService")


local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds

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
		-- FIX #5: validate BEFORE touching the cooldown, so a nil character can't lock the ability
		local Character = Player.Character
		if not Character or not Character.Parent then return end
		local Humanoid: Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local HumRP: BasePart = Character:FindFirstChild("HumanoidRootPart")
		if not Humanoid or not HumRP or Humanoid.Health <= 0 then return end

		if Player:GetAttribute("AbilityThreeCooldown") then return end
		Player:SetAttribute("AbilityThreeCooldown", true)

		local CooldownTime = 12
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		-- single source of truth for the cooldown so every exit path resolves it once
		local cooldownStarted = false
		local function startCooldown()
			if cooldownStarted then return end
			cooldownStarted = true
			Player:SetAttribute("AbilityThreeCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then Player:SetAttribute("AbilityThreeCooldown", false) end
			end)
		end

		local Janitor = Trove.new()
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local Hit = false

		

		local StartAnimation = ServerStorage.Assets.Animations.Sanji.Concasse.Start
		local StartTrack, StartEvents = AnimationService:getAnimationTrack(Character, StartAnimation)
		local Container = {}
		
		local function onHit(EnemyCharacter)
			
		end
		
		
		
		table.insert(StartEvents, StartTrack:GetMarkerReachedSignal("jump"):Connect(function()
			RemotesContainer.ClientEffects:FireAllClients("Concasse", {Attacker = Character, SkillType =  "jump",})
			ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 3, Last = 1.7 })
			SoundsModule:PlaySound(MoveSounds.Sanji.Concasse["crater3 jun sfx"], Character.Torso)
			CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
		end))
		
		table.insert(StartEvents, StartTrack:GetMarkerReachedSignal("loop"):Connect(function()
			
		end))
		
		table.insert(StartEvents, StartTrack:GetMarkerReachedSignal("spin"):Connect(function()
			RemotesContainer.ClientEffects:FireAllClients("Concasse", {Attacker = Character, SkillType =  "spinStart",})

		end))
		table.insert(StartEvents, StartTrack:GetMarkerReachedSignal("spinStop"):Connect(function()
			RemotesContainer.ClientEffects:FireAllClients("Concasse", {Attacker = Character, SkillType =  "spinEnd",})

		end))
		table.insert(StartEvents, StartTrack:GetMarkerReachedSignal("removeTrail"):Connect(function()
			RemotesContainer.ClientEffects:FireAllClients("Concasse", {Attacker = Character, SkillType =  "removeTrail",})

		end))
		table.insert(StartEvents, StartTrack:GetMarkerReachedSignal("slam"):Connect(function()
			RemotesContainer.ClientEffects:FireAllClients("Concasse", {Attacker = Character, SkillType =  "slam",})
			RemotesContainer.ClientEffects:FireAllClients("Concasse", {Attacker = Character, SkillType =  "slam2",})

			ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 8, Last = .2 })
			ReplicateEffects_Set:FireAllClients("Ring", {
				FirstProps = {
					Size = Vector3.new(10, 0.5, 10),
					Transparency = 0.25
				},

				--CF = EnemyHumRP.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(math.rad(90), 0, 0),
				CF = HumRP.CFrame * CFrame.new(0, -5, 0) ,


				TN_Info = {
					Time = 0.3,
					Style = 'Quad',
					Direction = 'Out'
				},

				FinalProps = {
					Size = Vector3.new(20, 0.25, 20),
					Transparency = 1
				}
			})
			
			local function knockUpward(EnemyCharacter, EnemyHumanoid)
				local root = EnemyCharacter:FindFirstChild("HumanoidRootPart")
				
				DamageHandler:TakeDamage(Character, EnemyHumanoid, 5, nil, nil, false, false, true, true, true, nil, nil) -- remove if no damage wanted
				local VelocityObject = Velocity.new(EnemyCharacter)
				VelocityObject.Settings.RemoveTime = 0.2
				VelocityObject.Settings.MaxForce = Vector3.new(100000, 100000, 100000)
				VelocityObject.Settings.Velocity = Vector3.yAxis * 60 -- straight up
				--VelocityObject.Settings.Spin = root.CFrame.RightVector * 14 -- forward somersault
				VelocityObject:Fire()
				
				RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true)
			end
			
			-- I should determine how close a player is before grabbing them. If they to far, it does a simple ragdoll instead. 
			-- Close to direct hits will lead into a grab.
			local groundConnection
			groundConnection = RemotesContainer.MoveSkills.ConcasseDrop.OnServerEvent:Connect(function(firingPlayer, Position)
				groundConnection:Disconnect()
				local Hitbox = HitboxHandler.new()
				Hitbox.Instance = CFrame.lookAlong(Position, HumRP.CFrame.LookVector)
				Hitbox.Size = Vector3.new(20, 20, 20)
				Hitbox.Ignore = { Character }
				Hitbox.onTouch = function(EnemyCharacter)
					local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
					local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
					local EnemyPlayer: Player = PlayersService:GetPlayerFromCharacter(EnemyCharacter)

					if iFramesService:HasiFrame(EnemyCharacter, 2) then return end

					-- Only grab targets within 5 studs of where you land; otherwise just launch them up.
					local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 5, nil, nil, false, false, false, true, false, nil, 13)

					local grabDistance = (EnemyHumRP.Position - Position).Magnitude
					if Hit or grabDistance > 5 or HitInfo.Blocked then
						knockUpward(EnemyCharacter, EnemyHumanoid)
						return
					else
						
						
					end
					
					Hit = true
					
					
					if EnemyCharacter:HasTag("Ragdolled") then
						RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
					end
					
					DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, nil, ServerStorage.Assets.Animations.Sanji.Concasse.ConHit, false, false, false, true, false, nil, 13)

					CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")

					EnemyCharacter:AddTag("CantRotate")

					local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -4) * CFrame.Angles(0, math.pi, 0), -1)	
					local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

					local UserAnimation, VictimAnimation
					local UserTrack
					local UserEvents = {}

					local VictimTrack
					local VictimEvents = {}
					
					local movemeRun = Instance.new("BodyVelocity")
					movemeRun.MaxForce = Vector3.new(40000, 40000, 40000)
					movemeRun.Name = "moveme"
					movemeRun:SetAttribute("Speed", 40)
					movemeRun:SetAttribute("Fallout", 0.97)
					movemeRun:SetAttribute("End", 5)
					
					local movemeTest = Instance.new("BodyVelocity")
					movemeTest.MaxForce = Vector3.new(40000, 40000, 40000)
					movemeTest.Name = "moveme"
					movemeTest:SetAttribute("Speed", 30)
					movemeTest:SetAttribute("Fallout", 0.99)
					movemeTest:SetAttribute("Aerial", 25)
					movemeTest:SetAttribute("AerialDecrease", .18)
					movemeTest:SetAttribute("End", 4)
					movemeTest:SetAttribute("EndExclusion", true)
					movemeTest:SetAttribute("YForceImmunity", true)

					UserAnimation = ServerStorage.Assets.Animations.Sanji.Concasse.User
					VictimAnimation = ServerStorage.Assets.Animations.Sanji.Concasse.Victim
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

							if movemeTest then movemeTest:Destroy() movemeTest = nil end

							if VictimTrack and VictimTrack.IsPlaying then
								VictimTrack:Stop()
							end

							if Stun then
								StunHandler:Unstun(Character, Stun)
								Stun = nil
							end

							iFramesService:RemoveAlliFrames(Character)
							CollisionsModule:SetCollisionGroup(Character, "Players")

							Player:SetAttribute("AbilityThreeCooldown", CooldownTime)

							task.delay(CooldownTime, function()
								if Player then
									Player:SetAttribute("AbilityThreeCooldown", false)
								end
							end)
						end)
					end
					
					UserEvents["hit"] = UserTrack:GetMarkerReachedSignal("hit"):Once(function()
						movemeRun.Parent = HumRP
						SoundsModule:PlaySound(MoveSounds.Sanji.Concasse.GrabPart["kickSweep Hit"], Character.Torso)
						shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", {Intensity = 3 }})
					end)
					
					UserEvents["hit2"] = UserTrack:GetMarkerReachedSignal("hit2"):Once(function()
						SoundsModule:PlaySound(MoveSounds.Sanji.Concasse.GrabPart["hit2"], Character.Torso)
						movemeRun:SetAttribute("Speed", 30)
						shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 3 }})
					end)
					
					UserEvents["hit3"] = UserTrack:GetMarkerReachedSignal("hit3"):Once(function()
						if movemeRun then
							movemeRun:Destroy()
						end

						movemeTest.Parent = HumRP
						SoundsModule:PlaySound(MoveSounds.Sanji.Concasse.GrabPart["hit3"], Character.Torso)
						SoundsModule:PlaySound(MoveSounds.Sanji.Concasse.GrabPart["finalKick windup"], Character.Torso)
						shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 5}})
					end)

						
					UserEvents["hit4"] = UserTrack:GetMarkerReachedSignal("hit4"):Once(function()
						--RemotesContainer.ClientEffects:FireAllClients("BlackBeardThirdAbility", {Attacker = Character, SkillType =  "throw",})
						if movemeTest then
							movemeTest:Destroy()
							movemeTest = nil
						end
						
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
						--RagdollHandler.ragdoll(EnemyHumanoid, 2)
						--NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 100000, 100000), Velocity = HumRP.CFrame.LookVector * 40 + Vector3.new(0, 20, 0) })
						
						local VelocityObject =  Velocity.new(EnemyCharacter);
						--VelocityObject.Settings.Duration = 0.6
						VelocityObject.Settings.RemoveTime = 0.2
						VelocityObject.Settings.MaxForce = Vector3.new(10000, 10000, 10000) --Force
						VelocityObject.Settings.Velocity = HumRP.CFrame.UpVector * -50 -- + Vector3.yAxis * 8.5 --KnockbackVelocity * 40 + Vector3.yAxis * 8.5
						--VelocityObject.Settings.Controllable = true
						--VelocityObject.Settings.Z = 60
						VelocityObject:Fire()

						RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true)
						SoundsModule:PlaySound(MoveSounds.Sanji.Concasse.GrabPart["finalKick hit"], Character.Torso)
						shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 6, Last = 0.2 } })
					end)
					
					UserTrack.Stopped:Once(EndFunction)

					VictimTrack.Stopped:Once(function()
						EndFunction()

						if EnemyStun then
							StunHandler:Unstun(EnemyCharacter, EnemyStun)
							EnemyStun = nil
						end

						iFramesService:RemoveAlliFrames(EnemyCharacter)
						--if not ragdollApplied then -- let cancelRagdoll own the restore
						CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
						EnemyCharacter:RemoveTag("CantRotate")
						--end
					end)

					iFramesService:AddBaseiFrames(Character)
					iFramesService:AddBaseiFrames(EnemyCharacter)

					ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

					--knockbackService.Knockback(EnemyCharacter.PrimaryPart, {
					--	["duration"] = 0.15,
					--	["force"] = 10,
					--	["direction"] = HumRP.CFrame.LookVector + Vector3.new(0, 0.3, 0)
					--})


					task.delay(1.183, function()
						DamageHandler:TakeDamage(Character, EnemyHumanoid, 1.5, nil, nil, false, false, true, true, false, nil, nil)
					end)

					task.delay(1.45, function()
						DamageHandler:TakeDamage(Character, EnemyHumanoid, 1.5, nil, nil, false, false, true, true, false, nil, nil)
					end)

					task.delay(0.2, function()
						if EnemyCharacter:HasTag('Ragdolled') then
							RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, nil, nil, false, true)
						end

						AnimationService:stopAll(EnemyCharacter)
						--AnimationService:playAnimation(EnemyCharacter, VictimAnimation, 1, 0.72)
						AnimationService:playAnimation(Character, UserAnimation)
						AnimationService:playAnimation(EnemyCharacter, VictimAnimation)

						Weld:Start(.5, Player)
						SoundsModule:PlaySound(MoveSounds.Sanji.Concasse.GrabPart["kickSweep SFX"], Character.Torso)
					end)
					
					AnimationService:stopAll(Character)
					AnimationService:stopAll(EnemyCharacter)
					--Weld:Start(nil, Player)
					--AnimationService:playAnimation(Character, UserAnimation)
					--AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
					
					--task.delay(.1, function()
					--	movemeTest.Parent = HumRP
					--end)
					
					-- Old knockback. Will add this for other players around who didn't get grabbed.
					--NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity",
					--	MaxForce = Vector3.new(1, 50000, 1),
					--	Velocity = HumRP.CFrame.UpVector * 70, ApplyAngular = true })
					--RagdollHandler.ragdoll(EnemyHumanoid, 2)
				end

				Hitbox:Once()
				Hitbox:Destroy()
				SoundsModule:PlaySound(MoveSounds.Sanji.Concasse["crater main"], Character.Torso)
				SoundsModule:PlaySound(MoveSounds.Sanji.Concasse["crater3 jun sfx"], Character.Torso)
				shared.fireTo(ReplicateEffects_Set, { Player}, { "ShakeCamera", { Intensity = 7 } })
			end)
		end))
		

		StartTrack.Stopped:Once(function()
			StunHandler:Unstun(Character, Stun)
			startCooldown()
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		
		SoundsModule:PlaySound(MoveSounds.Sanji.Concasse.jump1, Character.Torso)
		SoundsModule:PlaySound(MoveSounds.Sanji.Concasse.jump2, Character.Torso)
	end
}