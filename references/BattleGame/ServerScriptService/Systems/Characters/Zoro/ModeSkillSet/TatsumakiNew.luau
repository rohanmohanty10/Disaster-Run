local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).Zoro.Ult
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

local DebreeService = require(ServerModules.DebreeService)



local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds


--local NewAnimLocation = ServerStorage.Assets.Animations.Sanji
local NewAnimLocation = ServerStorage.Assets.Animations["Zoro"]


local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set
local Animations = ReplicatedStorage.Assets.Animations

-- NEW: server-owned dragon rig for the spin. Server clones + animates it;
-- clients keep doing all the VFX/sounds/tweens on the replicated instance.
local DragonRig = ServerStorage.Assets.Dragon.Dragon1


local rad = math.rad

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true



return {
	Start = function(Player: Player) --removed tool
		local Character = Player.Character		
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		if not (Character and Humanoid and HumRP) or Humanoid.Health <= 0 then return end
		local Animator: Animator = Humanoid.Animator


		local EnemyCharacter = nil
		local EnemyPlayer = nil
		local EnemyHumRP = nil

		--local EnemyStun = nil
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0)
		Stun:SetAttribute("WalkSpeed", 0)


		local grabHit = false
		local pullGrab = false
		local Finisher = false

		local Janitor = Trove.new()
		local Container = {}
		local Assets = {}

		local StartAnimation = NewAnimLocation.Moveset.ModeMoveSet.Tatsumaki.TatsumakiSpin
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		local TatsumakiLoop1
		local TatsumakiLoop2
		local TatsumakiLoop3

		local function stopAllSounds()
			if TatsumakiLoop1 then
				SoundHandler:StopSound(TatsumakiLoop1, .5)
			end
			if TatsumakiLoop2 then
				SoundHandler:StopSound(TatsumakiLoop2, .5)
			end
			if TatsumakiLoop3 then
				SoundHandler:StopSound(TatsumakiLoop3, .5)
			end
		end

		local EnemyHumanoid = nil
		local enemyData = {} 


		StartEvents["hit"] = StartTrack:GetMarkerReachedSignal("hit"):Once(function()
			local fakeRoot = Instance.new("Part")
			fakeRoot.Anchored = true
			fakeRoot.CanCollide = false
			fakeRoot.CanTouch = false
			fakeRoot.CanQuery = false
			fakeRoot.Transparency = 1
			fakeRoot.Size = Vector3.new(1, 1, 1)
			fakeRoot.CFrame = HumRP.CFrame * CFrame.new(0, 50, 0)
			fakeRoot.Parent = workspace.World.Debris
			Debris:AddItem(fakeRoot, 6)

			-- clients spin the absorbed debris around Zoro under this name (DebreeController's
			-- "Tatsumaki" style) until the final slash releases it
			local DebrisTarget = `Tatsumaki_{Player.UserId}_{math.floor(os.clock() * 1000)}`
			RemotesContainer.ClientEffects:FireAllClients("GrandTornadoNew", {Attacker = Character, SkillType =  "start", DebrisTarget = DebrisTarget}) 

			-- ============================================================
			-- NEW: spawn the dragon ON THE SERVER and play SpinAnim here.
			-- Clone/pivot/parent exactly like the client used to. Clients get
			-- the replicated instance through the remote and do everything
			-- else (sounds, Elden/Roar, up/down tween, wind meshes) locally.
			-- ============================================================
			local dragon = DragonRig:Clone()
			dragon:PivotTo(HumRP.CFrame * CFrame.new(0, 10, 0))
			dragon.Parent = workspace.World.Visuals
			Debris:AddItem(dragon, 15) -- safety net if the markers never fire

			local dragonTrack = dragon.AnimationController:LoadAnimation(dragon.SpinAnim)

			dragonTrack:GetMarkerReachedSignal("speedup"):Once(function()
				dragonTrack:AdjustSpeed(2)
			end)

			dragonTrack:GetMarkerReachedSignal("end"):Once(function()
				dragonTrack:AdjustSpeed(1)
				-- clients stop their dragon sounds + fade the parts on this signal
				RemotesContainer.ClientEffects:FireAllClients("GrandTornadoNew", {
					Attacker = Character, SkillType = "DragonEnd",
				})
				-- destroy AFTER the clients' 0.2s wait + 0.1s fade has finished
				Debris:AddItem(dragon, 0.6)
			end)

			dragonTrack:Play()

			RemotesContainer.ClientEffects:FireAllClients("GrandTornadoNew", {
				Attacker = Character, SkillType = "Dragon", Dragon = dragon,
			})

			TatsumakiLoop1 = SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Tatsumaki.Wind.TatsumakiLoop, fakeRoot)
			TatsumakiLoop2 = SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Tatsumaki.Wind.Tornado, fakeRoot)
			TatsumakiLoop3 = SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Tatsumaki.Wind.Tornado2, fakeRoot)

			local center = HumRP.CFrame * CFrame.new(0, 30, 0)

			task.spawn(function()
				task.wait(0.1) -- let clients register DebrisTarget first
				for i = 1, 3 do
					-- the column grows across the 3 waves: 40 wide -> 80 wide, bottom just under the feet
					local alpha = (i - 1) / 2 -- 0, 0.5, 1
					local size = Vector3.new(40, 60, 40):Lerp(Vector3.new(80, 90, 80), alpha)
					local absorbCF = HumRP.CFrame * CFrame.new(0, -5 + size.Y / 2, 0)

					DebreeService.Absorb(absorbCF, size, {
						Shape = "Oval",
						TargetId = DebrisTarget,
						Style = "Tatsumaki",
						GridSize = 5,
						Attacker = Player,
					})
					task.wait(1)
				end
			end)

			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(50, 50, 50)
			--Hitbox.Offset = CFrame.new(0, -2, 0)
			Hitbox.Offset = CFrame.new(0, 0, 0)

			Hitbox.Visualize = true
			Hitbox.onTouch = function(HitCharacter)
				--print("Players hit")

				EnemyCharacter = HitCharacter
				EnemyHumanoid = HitCharacter.Humanoid
				EnemyHumRP = HitCharacter.HumanoidRootPart
				EnemyPlayer = game.Players:GetPlayerFromCharacter(HitCharacter)

				if HitCharacter == Character or iFramesService:HasiFrame(HitCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Pull, nil, nil, false, true, true, true, false, nil, 19.5)
				if HitInfo.Countered == true then return end

				if EnemyPlayer then
					shared.fireTo(ReplicateEffects_Set, { EnemyPlayer }, { "ShakeCamera", { Intensity = 9, Last = 0.4 } })
				end

				if not enemyData[HitCharacter] then

					local EnemyPlayer = PlayersService:GetPlayerFromCharacter(HitCharacter)
					local EnemyHumanoid: Humanoid = HitCharacter.Humanoid
					local EnemyHRP = HitCharacter.HumanoidRootPart

					if HitCharacter == Character or iFramesService:HasiFrame(HitCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

					local HitInfo2 = DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Pull, nil, nil, false, true, true, true, false, nil, 19.5)
					if HitInfo2.Countered == true then return end

					enemyData[HitCharacter] = {
						AttackerAttachment = nil,
						OrbAttachment = nil,
						EnemyAttachment = nil,
						AlignPos = nil,
						orbitConnection = nil,
						growConnection = nil,
						--EnemyStun = nil,
					}

					--EnemyStun = StunHandler:Stun(HitCharacter, nil, true, 0, 0, true)
					--enemyData[HitCharacter].EnemyStun = EnemyStun



					--CollisionsModule:SetCollisionGroup(HitCharacter, "TornadoCollisions")
					CollisionsModule:SetCollisionGroup(HitCharacter, "NoCol")

					HitCharacter:AddTag("CantRotate")

					if HitCharacter:HasTag("Ragdolled") then
						RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
					end
					
					RagdollHandler.ragdoll(EnemyHumanoid, 10, false, Character, nil, nil, false, {Cosmetic = true})
					--pcall(function() EnemyHRP:SetNetworkOwner(nil) end)
					--pcall(function() EnemyHRP:SetNetworkOwner(Player) end)
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

					--RagdollHandler.ragdoll(EnemyHumanoid, 9, false, nil, nil, nil, true, "TornadoCollisions")

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
						--EnemyStun = EnemyStun,
					}

					-- tick damage while they spin, TickTotal spread over TickTime
					task.spawn(function()
						local Ticks = math.max(1, math.floor(MoveConfig.TickTime / MoveConfig.TickInterval))
						local PerTick = MoveConfig.Damage.TickTotal / Ticks
						for _ = 1, Ticks do
							task.wait(MoveConfig.TickInterval)
							if not EnemyHumanoid.Parent or EnemyHumanoid.Health <= 0 then break end
							DamageHandler:TakeDamage(Character, EnemyHumanoid, PerTick, nil, nil, false, false, true, true, false, nil, nil)
						end
					end)

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
				shared.fireTo(ReplicateEffects_Set, {Player}, { "ShakeCamera", { Intensity = 7, Last = 0.2 } })
				task.delay(4, function()
					Hitbox:Destroy()
				end)
			end)
			task.wait(3.5)
			--task.delay(.1, function()
			StartTrack:AdjustSpeed(1)

			--end)
			stopAllSounds()
			-- final slash: everything still spinning bursts outward
			RemotesContainer.ClientEffects:FireAllClients("GrandTornadoNew", { Attacker = Character, SkillType = "ReleaseDebris", DebrisTarget = DebrisTarget })
			SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Tatsumaki.Wind["Strong Wind"], fakeRoot)
			SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Tatsumaki.Wind.FinalSlashAndWind, fakeRoot)

			shared.fireTo(ReplicateEffects_Set, {Player }, { "ShakeCamera", { Intensity = 13, Last = 0.4 } })

			for enemyCharacter, data in pairs(enemyData) do
				if data.orbitConnection then data.orbitConnection:Disconnect() end
				if data.growConnection then data.growConnection:Disconnect() end

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

					--pcall(function()
					--	if enemyPlayer then
					--		enemyHumRP:SetNetworkOwner(enemyPlayer)
					--	else
					--		enemyHumRP:SetNetworkOwner(nil)
					--	end
					--end)
					--task.delay(4, function()
					--	StunHandler:Unstun(enemyCharacter, data.EnemyStun)
					--end)

					shared.fireTo(ReplicateEffects_Set, {enemyPlayer }, { "ShakeCamera", { Intensity = 9, Last = 0.1 } })


					local orbCenter = HumRP.Position + Vector3.new(0, 40, 0) -- where the orb was
					local knockbackDir = (enemyHumRP.Position - orbCenter).Unit
					local flatDir = Vector3.new(knockbackDir.X, 0, knockbackDir.Z).Unit

					--if enemyCharacter:HasTag("Ragdolled") then
					--	RagdollHandler.cancelRagdoll(enemyHumanoid, false)
					--end

					--RagdollHandler.ragdoll(enemyCharacter.Humanoid, 4.5)

					--if enemyCharacter:HasTag("Ragdolled") then
					--	RagdollHandler.cancelRagdoll(enemyHumanoid, nil, false, nil, nil, true)
					--end
					if enemyCharacter:HasTag("Ragdolled") then
						RagdollHandler.cancelRagdoll(enemyHumanoid)
					end
					
					DamageHandler:TakeDamage(Character, enemyHumanoid, MoveConfig.Damage.Final, nil, nil, false, false, true, true, true, nil, MoveConfig.FinisherHP)
					
					RagdollHandler.ragdoll(enemyHumanoid, 4.5)

					NewKnockback:Knockback(enemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = flatDir * 60 + Vector3.new(0, 0, 0) })
					ReplicateEffects_Set:FireAllClients("collisionWall", { root = enemyHumRP,
						NoCrater = "regularSmokeSmash",
						hit = enemyCharacter,
						caller = Character,
						OnlyCheck = {workspace.World.Map}, --added
					})


					task.delay(.2, function()
						--CollisionsModule:SetCollisionGroup(enemyCharacter, "Players")
						iFramesService:RemoveAlliFrames(enemyCharacter)


					end)

				end	

			end
		end)


		StartEvents["freeze"] = StartTrack:GetMarkerReachedSignal("freeze"):Once(function()
			StartTrack:AdjustSpeed(0)
		end)

		StartTrack.Stopped:Once(function()
			for _,v in StartEvents do
				v:Disconnect()
			end
			if pullGrab ~= true then
				StunHandler:Unstun(Character, Stun)
			end
			Character:RemoveTag("CantRotate")

			Character:SetAttribute("AbilityTwoCoolDown", 5)
			task.delay(5, function()
				if Character and Character.Parent and Humanoid and HumRP then
					Character:SetAttribute("AbilityTwoCoolDown", false)
				end
			end)

			stopAllSounds()
		end)


		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)

		Character:AddTag("CantRotate")
		SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Tatsumaki.Sword.TatsumakiStart, HumRP)
		SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Tatsumaki.Sword.Slash, HumRP)
		SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Tatsumaki.Sword.Slash2, HumRP)
		SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Tatsumaki.Sword.Skill2, HumRP)
		SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Tatsumaki.Sword.StartUp2, HumRP)
	end
}