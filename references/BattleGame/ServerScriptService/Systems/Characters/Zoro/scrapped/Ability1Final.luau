local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService = game:GetService("Players")

local ServerModules    = ServerStorage.SBGModules
local ReplicatedModules = ReplicatedStorage.Modules
local RemotesContainer = ReplicatedStorage.Remotes

local StunHandler      = require(ServerModules.StunHandler)
local HitboxHandler    = require(ServerModules.HitboxHandler)
local DamageHandler    = require(ServerModules.DamageHandler)
local RagdollHandler   = require(ServerModules.RagdollHandler)
local NewKnockback     = require(ServerModules.BodymoverService)
local AnimationService = require(ServerModules.AnimationService)
local iFramesService   = require(ServerModules.iFramesService)
local CollisionsModule = require(ServerModules.CollisionsModule)
local SoundsModule     = require(ServerModules.SoundsModule)
local KnockbackModule  = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local StatesHandler    = require(ServerModules.StatesHandler)
local WeldSystem       = require(ReplicatedModules.WeldSystem)
local SoundHandler     = require(ReplicatedModules.SoundHandler)
local Trove            = require(ReplicatedModules.Trove)

local Sounds             = ReplicatedStorage.Assets.Sounds
local NewAnimLocation    = ServerStorage.Assets.Animations["Zoro"]
local MoveSounds         = Sounds.Characters
local ReplicateEffects_Set = RemotesContainer.Replicate.Set

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true

return {
	Start = function(Player: Player)
		local Character  = Player.Character
		local HumRP: BasePart    = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		if not (Character and Humanoid and HumRP) or Humanoid.Health <= 0 then return end

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0)
		Stun:SetAttribute("WalkSpeed", 0)

		local pullGrab  = false
		local landed    = false
		local enemyData = {}
		local StartEvents = {}
		
		local EnemyCharacter = nil
		local EnemyPlayer = nil
		local EnemyHumRP = nil
		local EnemyHumanoid = nil
		local EnemyStun = nil


		
		

		local StartAnimation  = NewAnimLocation.Moveset.ModeMoveSet.SecondSkill.Final.Miss
		--local SpinAnimation   = NewAnimLocation.Moveset.ModeMoveSet.SecondSkill.Final.Spin   -- adjust path
		local ImpactAnimation = NewAnimLocation.Moveset.ModeMoveSet.SecondSkill.Impact -- adjust path

		local StartTrack  = AnimationService:getAnimationTrack(Character, StartAnimation)
		--local SpinTrack   = AnimationService:getAnimationTrack(Character, SpinAnimation)
		local ImpactTrack = AnimationService:getAnimationTrack(Character, ImpactAnimation)

		-- ── Cleanup: disconnect orbit/grow, destroy constraints, knockback enemies ──
		local function cleanupEnemies(finalBlast)
			for enemyCharacter, data in pairs(enemyData) do
				if data.orbitConnection then data.orbitConnection:Disconnect() end
				if data.growConnection  then data.growConnection:Disconnect()  end

				if data.AlignPos           and data.AlignPos.Parent           then data.AlignPos:Destroy()           end
				if data.AttackerAttachment and data.AttackerAttachment.Parent then data.AttackerAttachment:Destroy() end
				if data.OrbAttachment      and data.OrbAttachment.Parent      then data.OrbAttachment:Destroy()      end
				if data.EnemyAttachment    and data.EnemyAttachment.Parent    then data.EnemyAttachment:Destroy()    end

				local enemyHumRP    = enemyCharacter:FindFirstChild("HumanoidRootPart")
				local enemyHumanoid = enemyCharacter:FindFirstChild("Humanoid")
				local enemyPlayer   = PlayersService:GetPlayerFromCharacter(enemyCharacter)

				if enemyHumRP and enemyHumanoid then
					StunHandler:Unstun(enemyCharacter, data.EnemyStun)

					if finalBlast then
						shared.fireTo(ReplicateEffects_Set, { enemyPlayer }, { "ShakeCamera", { Intensity = 9, Last = 0.2 } })

						local orbCenter    = HumRP.Position + Vector3.new(0, 40, 0)
						local knockbackDir = (enemyHumRP.Position - orbCenter).Unit
						local flatDir      = Vector3.new(knockbackDir.X, 0, knockbackDir.Z).Unit

						NewKnockback:Knockback(enemyCharacter, {
							KnockbackType = "Velocity",
							MaxForce      = Vector3.new(100000, 50000, 100000),
							Velocity      = flatDir * 60,
						})

						ReplicateEffects_Set:FireAllClients("collisionWall", {
							root      = enemyHumRP,
							NoCrater  = "regularSmokeSmash",
							hit       = enemyCharacter,
							caller    = Character,
							OnlyCheck = { workspace.World.Map },
						})

						task.delay(0.2, function()
							CollisionsModule:SetCollisionGroup(enemyCharacter, "Players")
						end)
					else
						CollisionsModule:SetCollisionGroup(enemyCharacter, "Players")
						RagdollHandler.cancelRagdoll(enemyHumanoid, false)
					end
				end
			end
			enemyData = {}
		end

		

		-- ── fly marker ────────────────────────────────────────────────────────────
		StartEvents["first"] = StartTrack:GetMarkerReachedSignal("first"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("GrandTornadoFinal", {
				Attacker  = Character,
				SkillType = "fly",
			})
		end)

		-- ── up marker ─────────────────────────────────────────────────────────────
		StartEvents["jump"] = StartTrack:GetMarkerReachedSignal("jump"):Once(function()
			--print("ServerJump")
			RemotesContainer.ClientEffects:FireAllClients("GrandTornadoFinal", {
				Attacker  = Character,
				SkillType = "up",
			})
		end)

		-- ── upback marker ─────────────────────────────────────────────────────────
		StartEvents["upback"] = StartTrack:GetMarkerReachedSignal("upback"):Once(function()
			--print("ServerUpBack")

			RemotesContainer.ClientEffects:FireAllClients("GrandTornadoFinal", {
				Attacker  = Character,
				SkillType = "upback",
			})
		end)

		-- ── dive marker: fire client, spin anim, wait for ground remote ───────────
		StartEvents["dive"] = StartTrack:GetMarkerReachedSignal("dive"):Once(function()
			-- Play spin animation on top of windup
			print("Dived")
			--SpinTrack:Play(0.25)

			RemotesContainer.ClientEffects:FireAllClients("GrandTornadoFinal", {
				Attacker  = Character,
				SkillType = "dive",
			})

			-- Listen for client to report ground hit
			local groundConnection
			groundConnection = RemotesContainer.GrandTornadoLanded.OnServerEvent:Connect(function(firingPlayer)
				if firingPlayer ~= Player then return end

				groundConnection:Disconnect()
				landed = true

				-- Stop both animations, play impact
				StartTrack:Stop(0)
				--SpinTrack:Stop(0)
				AnimationService:playAnimation(Character, ImpactAnimation)

				local ActiveImpact = AnimationService:getAnimationTrack(Character, ImpactAnimation)

				shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = 13, Last = 0.4 } })

				-- ── Impact vfx marker ──────────────────────────────────────────
				ActiveImpact:GetMarkerReachedSignal("vfx"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("GrandTornado", {Attacker = Character, SkillType =  "start"}) 


					local Hitbox = HitboxHandler.new()
					Hitbox.Instance = HumRP
					Hitbox.Size = Vector3.new(50, 80, 50)
					--Hitbox.Offset = CFrame.new(0, -2, 0)
					Hitbox.Offset = CFrame.new(0, -25, 0)

					Hitbox.Visualize = true
					Hitbox.onTouch = function(HitCharacter)
						

						EnemyCharacter = HitCharacter
						EnemyHumanoid = HitCharacter.Humanoid
						EnemyHumRP = HitCharacter.HumanoidRootPart
						EnemyPlayer = game.Players:GetPlayerFromCharacter(HitCharacter)

						if HitCharacter == Character or iFramesService:HasiFrame(HitCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

						local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0.75, 0.75, nil, true, true, true, true, false, nil, 13)
						if HitInfo.Countered == true then return end

						if not enemyData[HitCharacter] then

							enemyData[HitCharacter] = {
								AttackerAttachment = nil,
								OrbAttachment = nil,
								EnemyAttachment = nil,
								AlignPos = nil,
								orbitConnection = nil,
								growConnection = nil,
								EnemyStun = nil,
							}

							EnemyStun = StunHandler:Stun(HitCharacter, nil, true, 0, 0, true)
							enemyData[HitCharacter].EnemyStun = EnemyStun

							local EnemyPlayer = PlayersService:GetPlayerFromCharacter(HitCharacter)
							local EnemyHumanoid: Humanoid = HitCharacter.Humanoid
							local EnemyHRP = HitCharacter.HumanoidRootPart

							--if HitCharacter == Character or iFramesService:HasiFrame(HitCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
							--if HitCharacter == Character or iFramesService:HasiFrame(HitCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

							local HitInfo2 = DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, nil, nil, false, true, true, true, false, nil, 19.5)
							if HitInfo2.Countered == true then return end

							CollisionsModule:SetCollisionGroup(HitCharacter, "TornadoCollisions")
							HitCharacter:AddTag("CantRotate")
							pcall(function() EnemyHRP:SetNetworkOwner(nil) end)

							-- Anchor point on the attacker (tornado center)
							local AttackerAttachment = Instance.new("Attachment")
							AttackerAttachment.Name = "TornadoAnchor"
							AttackerAttachment.Position = Vector3.new(0, 0, 0)
							AttackerAttachment.Parent = HumRP

							-- The moving point enemies are pulled toward — starts low and close
							local OrbAttachment = Instance.new("Attachment")
							OrbAttachment.Name = "TornadoOrb"

							--OrbAttachment.WorldPosition = HumRP.Position + Vector3.new(3, 2, 0)
							OrbAttachment.WorldPosition = HumRP.Position + Vector3.new(40, 5, 0)

							OrbAttachment.Parent = workspace.Terrain

							-- Attachment on the enemy
							local EnemyAttachment = Instance.new("Attachment")
							EnemyAttachment.Parent = EnemyHRP

							-- AlignPosition pointed straight at OrbAttachment (no pull phase)
							local AlignPos = Instance.new("AlignPosition")
							AlignPos.Mode = Enum.PositionAlignmentMode.TwoAttachment
							AlignPos.Attachment0 = EnemyAttachment
							AlignPos.Attachment1 = OrbAttachment
							AlignPos.MaxForce = 50000
							AlignPos.Responsiveness = 500 --200
							AlignPos.MaxVelocity = 200 --100
							AlignPos.Parent = EnemyHRP

							RagdollHandler.ragdoll(EnemyHumanoid, 15, false, nil, nil, nil, true, "TornadoCollisions")

							-- Grow state: radius and height expand over time (tornado spirals outward+up)
							--local radius = 3
							--local currentY = 2
							--local growDuration = 4
							--local startRadius = 3
							--local endRadius = 22
							--local startY = 2
							--local endY = 30
							--local growElapsed = 0



							local startRadius = math.random(30, 50)
							local endRadius = math.random(70, 100)    -- each enemy spirals to a different max distance
							local radius = startRadius

							local startY = math.random(3, 10)         -- some start lower, some higher
							local endY = math.random(70, 90)          -- some end lower, some way higher
							local currentY = startY

							local growDuration = math.random(30, 50) / 10  -- between 3.0 and 5.0 seconds, so they reach max at different times
							local growElapsed = 0


							-- Each enemy gets a random starting angle so they don't stack
							local t = math.random(0, 628) / 100
							local speed = math.random(80, 130) / 10

							local orbitConnection
							local growConnection

							growConnection = RunService.Heartbeat:Connect(function(dt)
								growElapsed = growElapsed + dt
								local alpha = math.clamp(growElapsed / growDuration, 0, 1)
								local eased = alpha ^ 2 -- ease-in: accelerates outward over time

								radius = startRadius + (endRadius - startRadius) * eased
								currentY = startY + (endY - startY) * eased

								if alpha >= 1 then
									growConnection:Disconnect()
								end
							end)

							orbitConnection = RunService.Heartbeat:Connect(function(dt)
								if not EnemyHRP or not EnemyHRP.Parent or not OrbAttachment or not OrbAttachment.Parent then
									orbitConnection:Disconnect()
									return
								end

								t = t + dt
								local origin = HumRP.Position

								OrbAttachment.WorldPosition = origin + Vector3.new(
									math.cos(t * speed) * radius,
									currentY,
									math.sin(t * speed) * radius
								)
							end)

							-- Store everything so the explode block can clean up
							enemyData[HitCharacter] = {
								AttackerAttachment = AttackerAttachment,
								OrbAttachment = OrbAttachment,
								EnemyAttachment = EnemyAttachment,
								AlignPos = AlignPos,
								orbitConnection = orbitConnection,
								growConnection = growConnection,
								EnemyStun = EnemyStun,
							}

							task.delay(16, function()
								if orbitConnection then orbitConnection:Disconnect() end
								if growConnection then growConnection:Disconnect() end

								if AttackerAttachment and AttackerAttachment.Parent then AttackerAttachment:Destroy() end
								if OrbAttachment and OrbAttachment.Parent then OrbAttachment:Destroy() end
								if EnemyAttachment and EnemyAttachment.Parent then EnemyAttachment:Destroy() end
								if AlignPos and AlignPos.Parent then AlignPos:Destroy() end

								RagdollHandler.cancelRagdoll(EnemyHumanoid, false)
							end)

							iFramesService:AddAlliFrames(HitCharacter)
							ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = HitCharacter })
						end
					end

					task.delay(.033, function()
						Hitbox:Once()
						task.delay(4, function()
							Hitbox:Destroy()
							print("Hitbox destroyed")
						end)
					end)
					task.wait(3.7)
					shared.fireTo(ReplicateEffects_Set, {Player }, { "ShakeCamera", { Intensity = 13, Last = 0.4 } })



					for enemyCharacter, data in pairs(enemyData) do
						if data.orbitConnection then data.orbitConnection:Disconnect() end

						-- Destroy instances
						if data.AlignPos and data.AlignPos.Parent then data.AlignPos:Destroy() end
						if data.AttackerAttachment and data.AttackerAttachment.Parent then data.AttackerAttachment:Destroy() end
						if data.OrbAttachment and data.OrbAttachment.Parent then data.OrbAttachment:Destroy() end
						if data.EnemyAttachment and data.EnemyAttachment.Parent then data.EnemyAttachment:Destroy() end
						if data.debugPart and data.debugPart.Parent then data.debugPart:Destroy() end

						local enemyHumRP = enemyCharacter:FindFirstChild("HumanoidRootPart")
						local enemyHumanoid = enemyCharacter:FindFirstChild("Humanoid")

						local enemyPlayer = game.Players:GetPlayerFromCharacter(enemyCharacter)

						if enemyHumRP and enemyHumanoid then
							StunHandler:Unstun(enemyCharacter, data.EnemyStun)

							shared.fireTo(ReplicateEffects_Set, {enemyPlayer }, { "ShakeCamera", { Intensity = 9, Last = 0.2 } })


							local orbCenter = HumRP.Position + Vector3.new(0, 40, 0) -- where the orb was
							local knockbackDir = (enemyHumRP.Position - orbCenter).Unit
							local flatDir = Vector3.new(knockbackDir.X, 0, knockbackDir.Z).Unit

							NewKnockback:Knockback(enemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = flatDir * 60 + Vector3.new(0, 0, 0) })
							ReplicateEffects_Set:FireAllClients("collisionWall", { root = enemyHumRP,
								NoCrater = "regularSmokeSmash",
								hit = enemyCharacter,
								caller = Character,
								OnlyCheck = {workspace.World.Map}, --added
							})
							task.delay(.2, function()
								CollisionsModule:SetCollisionGroup(enemyCharacter, "Players")

							end)

						end	

					end
					
					
				end)

			

				-- ── Impact animation finished ──────────────────────────────────
				ActiveImpact.Stopped:Once(function()
					--print("Stopped")
					StartTrack:Stop(0)

					ActiveImpact:Stop(.3)
					
					
					--AnimationService:stopAll(Character)
					
					for _, v in StartEvents do v:Disconnect() end
					
					StunHandler:Unstun(Character, Stun)
					Character:RemoveTag("CantRotate")

					Character:SetAttribute("AbilityTwoCoolDown", 5)
					task.delay(5, function()
						if Character and Character.Parent and Humanoid and HumRP then
							Character:SetAttribute("AbilityTwoCoolDown", false)
						end
					end)
				end)
			end)
		end)

		-- ── StartTrack ended before dive/ground hit (missed) ─────────────────────
		StartTrack.Stopped:Once(function()
			for _, v in StartEvents do v:Disconnect() end

			if not landed then
				--SpinTrack:Stop(0)
				StunHandler:Unstun(Character, Stun)
				cleanupEnemies(false)
			end

			--Character:RemoveTag("CantRotate")

			--Character:SetAttribute("AbilityTwoCoolDown", 5)
			--task.delay(5, function()
			--	if Character and Character.Parent and Humanoid and HumRP then
			--		Character:SetAttribute("AbilityTwoCoolDown", false)
			--	end
			--end)
		end)

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		Character:AddTag("CantRotate")
	end,
}