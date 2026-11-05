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
local CollisionsModule = require(ServerModules.CollisionsModule)
local SoundsModule = require(ServerModules.SoundsModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local StatesHandler = require(ServerModules.StatesHandler)
--local DestructionHandler = require(ServerStorage.Modules.DestructionHandler)


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
		local Character = Player.Character
		if not Character or not Character.Parent then return end
		local Humanoid: Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local HumRP: BasePart = Character:FindFirstChild("HumanoidRootPart")
		if not Humanoid or not HumRP or Humanoid.Health <= 0 then return end

		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("AbilityTwoCooldown") then return end
		if Character:GetAttribute("SanjiSecondAbility") then return end

		Player:SetAttribute("AbilityTwoCooldown", true)
		Character:SetAttribute("SanjiSecondAbility", true)

		local CooldownTime = 12
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local Janitor = Trove.new()
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local Hit = false
		local landed = false
		local cleanedUp = false

		local StartAnimation = ServerStorage.Assets.Animations.Sanji.Concasse.Start
		local LoopAnimation  = ServerStorage.Assets.Animations.Sanji.Concasse.Loop
		local EndAnimation   = ServerStorage.Assets.Animations.Sanji.Concasse.EndNew

		local StartTrack, StartEvents = AnimationService:getAnimationTrack(Character, StartAnimation)
		local LoopTrack = AnimationService:getAnimationTrack(Character, LoopAnimation)

		local groundConnection

		local function cleanupMove()
			if cleanedUp then return end
			cleanedUp = true
			if Stun then
				StunHandler:Unstun(Character, Stun)
				Stun = nil
			end
			ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
			iFramesService:RemoveAlliFrames(Character)
			CollisionsModule:SetCollisionGroup(Character, "Players")
			--startCooldown()
			
			Character:SetAttribute("SanjiSecondAbility", nil)

			Player:SetAttribute("AbilityTwoCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityTwoCooldown", false)
				end
			end)
		end

		local function knockUpward(EnemyCharacter, EnemyHumanoid)
			local root = EnemyCharacter:FindFirstChild("HumanoidRootPart")

			DamageHandler:TakeDamage(Character, EnemyHumanoid, 5, nil, nil, false, false, true, true, true, nil, nil)
			local VelocityObject = Velocity.new(EnemyCharacter)
			VelocityObject.Settings.RemoveTime = 0.2
			VelocityObject.Settings.MaxForce = Vector3.new(100000, 100000, 100000)
			VelocityObject.Settings.Velocity = Vector3.yAxis * 60
			VelocityObject.Settings.Spin = Vector3.new(
				(math.random() - 0.5) * 2,
				(math.random() - 0.5) * 2,
				(math.random() - 0.5) * 2
			).Unit * 8
			VelocityObject:Fire()

			RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true)
		end

		-- runs the moment the player actually reaches the ground (remote, or the safety timeout)
		local function OnGroundHit(Position)
			if landed then return end
			landed = true

			if groundConnection then
				groundConnection:Disconnect()
				groundConnection = nil
			end

			-- stop the looping fall before we play the landing
			if LoopTrack and LoopTrack.IsPlaying then
				LoopTrack:Stop()
			end

			--if not Character.Parent or not Humanoid or Humanoid.Health <= 0 or not HumRP.Parent then
			--	cleanupMove()
			--	return
			--end

			local EndTrack, EndEvents = AnimationService:getAnimationTrack(Character, EndAnimation)

			table.insert(EndEvents, EndTrack:GetMarkerReachedSignal("slam"):Connect(function()
				-- impact VFX
				RemotesContainer.ClientEffects:FireAllClients("Concasse", {Attacker = Character, SkillType = "slam"})
				RemotesContainer.ClientEffects:FireAllClients("Concasse", {Attacker = Character, SkillType = "slam2"})

				-- trail + spin stop now fire right on the slam, not on guessed Start markers
				RemotesContainer.ClientEffects:FireAllClients("Concasse", {Attacker = Character, SkillType = "spinEnd"})
				RemotesContainer.ClientEffects:FireAllClients("Concasse", {Attacker = Character, SkillType = "removeTrail"})

				ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 8, Last = .2 })
				--ReplicateEffects_Set:FireAllClients("Ring", {
				--	FirstProps = {
				--		Size = Vector3.new(10, 0.5, 10),
				--		Transparency = 0.25
				--	},
				--	CF = HumRP.CFrame * CFrame.new(0, -5, 0),
				--	TN_Info = {
				--		Time = 0.3,
				--		Style = 'Quad',
				--		Direction = 'Out'
				--	},
				--	FinalProps = {
				--		Size = Vector3.new(20, 0.25, 20),
				--		Transparency = 1
				--	}
				--})

				local Hitbox = HitboxHandler.new()
				Hitbox.Instance = CFrame.lookAlong(Position, HumRP.CFrame.LookVector)
				Hitbox.Size = Vector3.new(20, 20, 20)
				Hitbox.Ignore = { Character }
				Hitbox.onTouch = function(EnemyCharacter)
					local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
					local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
					local EnemyPlayer: Player = PlayersService:GetPlayerFromCharacter(EnemyCharacter)

					if iFramesService:HasiFrame(EnemyCharacter, 2) then return end

					local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 5, nil, nil, false, false, false, true, false, nil, 13)

					local grabDistance = (EnemyHumRP.Position - Position).Magnitude
					if Hit or grabDistance > 10 or HitInfo.Blocked then
						knockUpward(EnemyCharacter, EnemyHumanoid)
						return
					else

					end

					Hit = true

					if EnemyCharacter:HasTag("Ragdolled") then
						RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
					end

					AnimationService:stopAll(Character)
					AnimationService:stopAll(EnemyCharacter)

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
							if movemeRun then movemeRun:Destroy() movemeRun = nil end

							if VictimTrack and VictimTrack.IsPlaying then
								VictimTrack:Stop()
							end

							if Stun then
								StunHandler:Unstun(Character, Stun)
								Stun = nil
							end

							iFramesService:RemoveAlliFrames(Character)
							CollisionsModule:SetCollisionGroup(Character, "Players")

							Character:SetAttribute("SanjiSecondAbility", nil)

							Player:SetAttribute("AbilityTwoCooldown", CooldownTime)
							task.delay(CooldownTime, function()
								if Player then
									Player:SetAttribute("AbilityTwoCooldown", false)
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
						
						--for RockValue = 1, 2 do
						--	local Position = {
						--		Seed = math.random(1, 10) + RockValue,
						--		start = EnemyHumRP.Position + Vector3.new(0, 0.1, 0),
						--		["end"] = Vector3.new(0, -6, 0),
						--		amount = 6 + RockValue / 2,
						--		nosound = true,
						--		nosmoke = true,
						--		sizemult = 0.55 * RockValue,
						--		size = 0.85 * RockValue,
						--	}
						--	ReplicateEffects_Set:FireAllClients('Ground Crater', Position)
						--end
						--ReplicateEffects_Set:FireAllClients("collisionWall", { root = EnemyHumRP,
						--	NoCrater = "SanjiExplosion",
						--	hit = EnemyCharacter,
						--	caller = Character,
						--	OnlyCheck = {workspace.World.Map.Destroyable.Map}, --added
						--})
						ReplicateEffects_Set:FireAllClients("collisionWall", {
							root = EnemyHumRP,
							NoCrater = "regularSmokeSmash",
							hit = EnemyCharacter,
							caller = Character,
							OnlyCheck = { workspace.World.Map.Destroyable.Map },
							Justdown = true,
						})
						iFramesService:RemoveAlliFrames(EnemyCharacter)
						EnemyCharacter:RemoveTag("CantRotate")
						CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
		
						DamageHandler:TakeDamage(Character, EnemyHumanoid, 6, nil, nil, false, false, true, true, true, nil, nil)
	
						local VelocityObject =  Velocity.new(EnemyCharacter);
						VelocityObject.Settings.RemoveTime = 0.2
						VelocityObject.Settings.MaxForce = Vector3.new(10000, 10000, 10000)
						VelocityObject.Settings.Velocity = HumRP.CFrame.UpVector * -50
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
						CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
						EnemyCharacter:RemoveTag("CantRotate")
					end)

					iFramesService:AddBaseiFrames(Character)
					iFramesService:AddBaseiFrames(EnemyCharacter)

					ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

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
						AnimationService:playAnimation(Character, UserAnimation)
						AnimationService:playAnimation(EnemyCharacter, VictimAnimation)

						Weld:Start(.5, Player)
						SoundsModule:PlaySound(MoveSounds.Sanji.Concasse.GrabPart["kickSweep SFX"], Character.Torso)
					end)
				end

				Hitbox:Once()
				Hitbox:Destroy()
				SoundsModule:PlaySound(MoveSounds.Sanji.Concasse["crater main"], Character.Torso)
				SoundsModule:PlaySound(MoveSounds.Sanji.Concasse["crater3 jun sfx"], Character.Torso)
				shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = 7 } })
				
				--local results = DestructionHandler.destroy(
				--	Vector3.new(22, 18, 22), --Vector3.new(22, 18, 22),
				--	CFrame.new(Position) * CFrame.new(0, 0, 0),
				--	Enum.PartType.Ball,
				--	{
				--		MinimumSize = 5, --5.5,
				--		TimeToReset = 30,
				--		Player = Player,
				--		VoxelDestroyChance = .7,
				--		FlingDestroyChance = .8,
				--		VoxelVelocity = function(voxel, hitPos)
				--			local outward = voxel.Position - hitPos
				--			outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)
				--			return outward * math.random(40, 80) + Vector3.new(0, 20, 0)
				--		end,
				--		Visualize = false,
				--	}
				--)
			end))

			-- no grab happened -> end the move when the landing animation finishes
			EndTrack.Stopped:Once(function()
				
				if not Hit then
					cleanupMove()
				end
			end)

			AnimationService:playAnimation(Character, EndAnimation)
			
			
			
		end

		-- listen for the real ground signal up front so it can never race the loop marker
		groundConnection = RemotesContainer.MoveSkills.ConcasseDrop.OnServerEvent:Connect(function(firingPlayer, Position)
			if firingPlayer ~= Player then return end
			OnGroundHit(Position)
		end)

		-- ───────────── Start markers ─────────────
		table.insert(StartEvents, StartTrack:GetMarkerReachedSignal("jump"):Connect(function()
			RemotesContainer.ClientEffects:FireAllClients("Concasse", {Attacker = Character, SkillType =  "jump",})
			ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 3, Last = 1.7 })
			SoundsModule:PlaySound(MoveSounds.Sanji.Concasse["crater3 jun sfx"], Character.Torso)
			CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
		end))

		table.insert(StartEvents, StartTrack:GetMarkerReachedSignal("spin"):Connect(function()
			RemotesContainer.ClientEffects:FireAllClients("Concasse", {Attacker = Character, SkillType =  "spinStart",})
		end))

		-- loop keyframe -> start the looping fall and arm the safety
		table.insert(StartEvents, StartTrack:GetMarkerReachedSignal("loop"):Connect(function()
			AnimationService:playAnimation(Character, LoopAnimation)

			-- safety: if the ground signal never arrives, force the landing so nothing hangs
			task.delay(6, function()
				if not landed then
					local r = workspace:Raycast(HumRP.Position, Vector3.new(0, -200, 0), MapRayParams)
					OnGroundHit(r and r.Position or HumRP.Position)
				end
			end)
		end))

		StartTrack.Stopped:Once(function()
			-- Start is only the intro now; the move ends in OnGroundHit / the grab, not here.
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)

		SoundsModule:PlaySound(MoveSounds.Sanji.Concasse.jump1, Character.Torso)
		SoundsModule:PlaySound(MoveSounds.Sanji.Concasse.jump2, Character.Torso)
	end
}