local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).BlackBeard[4]
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local ServerModules = ServerStorage.SBGModules
local DebreeService = require(ServerModules.DebreeService)

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
local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)

local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)
local VoxelSerializer = require(ReplicatedModules.VoxelSerializer)

local Trove = require(ReplicatedModules.Trove)

local Sounds = ReplicatedStorage.Assets.Sounds
local MoveSounds = Sounds.Characters

local NewAnimLocation = ServerStorage.Assets.Animations["BlackBeard"]

local ReplicateEffects_Set = RemotesContainer.Replicate.Set
local Animations = ReplicatedStorage.Assets.Animations

local rad = math.rad

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true

local SPIN_TIME = 4
local ORBIT_RADIUS = 3 -- studs
local ORBIT_SPEED = 15 -- radians/sec

--local function orbitEnemy(data, gatherPoint, startAngle)
--	local worldAnchor = Instance.new("Attachment")
--	worldAnchor.WorldPosition = gatherPoint
--	worldAnchor.Parent = workspace.Terrain

--	if data.AlignPos and data.AlignPos.Parent then
--		data.AlignPos.Attachment1    = worldAnchor
--		data.AlignPos.Mode           = Enum.PositionAlignmentMode.TwoAttachment
--		data.AlignPos.MaxForce       = 200000
--		data.AlignPos.Responsiveness = 500
--		data.AlignPos.MaxVelocity    = math.ceil(ORBIT_SPEED * ORBIT_RADIUS * 2)
--	end

--	local rootAttachment = data.HumRP:FindFirstChild("RootAttachment")
--	local av
--	if rootAttachment then
--		local spinSign = math.random(0, 1) == 0 and 1 or -1
--		av = Instance.new("AngularVelocity")
--		av.Attachment0     = rootAttachment
--		av.RelativeTo      = Enum.ActuatorRelativeTo.World
--		av.AngularVelocity = Vector3.new(
--			spinSign * math.random(20, 50),
--			spinSign * math.random(20, 50),
--			spinSign * math.random(20, 50)
--		)
--		av.MaxTorque = 400
--		av.Parent    = data.HumRP
--	end

--	local function randUnit()
--		local v = Vector3.new(math.random(-100,100), math.random(-100,100), math.random(-100,100))
--		return v.Magnitude > 0.01 and v.Unit or Vector3.new(1, 0, 0)
--	end

--	local function randTangent(n)
--		local arb = math.abs(n.X) < 0.9 and Vector3.new(1,0,0) or Vector3.new(0,1,0)
--		local t1 = n:Cross(arb).Unit
--		local t2 = n:Cross(t1).Unit
--		local a = math.random(0, 628) / 100
--		return (math.cos(a) * t1 + math.sin(a) * t2)
--	end

--	local posDir   = randUnit()
--	local velDir   = randTangent(posDir)
--	local curvature  = math.random(100, 300) / 100
--	local curveSign  = math.random(0, 1) == 0 and 1 or -1
--	local curveTimer = 0
--	local nextChange = math.random(8, 20) / 10

--	local connection = RunService.Heartbeat:Connect(function(dt)
--		curveTimer += dt
--		if curveTimer >= nextChange then
--			curveTimer  = 0
--			nextChange  = math.random(8, 20) / 10
--			curveSign   = math.random(0, 1) == 0 and 1 or -1
--			curvature   = math.random(100, 300) / 100
--		end

--		local sideAxis = posDir:Cross(velDir)
--		if sideAxis.Magnitude > 0.001 then
--			velDir = velDir + sideAxis * curveSign * curvature * dt
--			velDir = velDir - posDir * velDir:Dot(posDir)
--			if velDir.Magnitude > 0.001 then
--				velDir = velDir.Unit
--			end
--		end

--		local newPos = posDir + velDir * ORBIT_SPEED * dt
--		if newPos.Magnitude > 0.001 then
--			posDir = newPos.Unit
--		end

--		worldAnchor.WorldPosition = gatherPoint + posDir * ORBIT_RADIUS
--	end)

--	return connection, worldAnchor, av
--end

local function orbitEnemy(data, gatherPoint, startAngle)
	local worldAnchor = Instance.new("Attachment")
	worldAnchor.WorldPosition = gatherPoint
	worldAnchor.Parent = workspace.Terrain

	if data.AlignPos and data.AlignPos.Parent then
		data.AlignPos.Attachment1 = worldAnchor
		data.AlignPos.Mode = Enum.PositionAlignmentMode.TwoAttachment
		data.AlignPos.MaxForce = 200000
		data.AlignPos.Responsiveness = 500
		data.AlignPos.MaxVelocity = math.ceil(ORBIT_SPEED * ORBIT_RADIUS * 2)
	end

	-- Random tumble spin
	local spinAttach = data.HumRP:FindFirstChild("RootAttachment") or Instance.new("Attachment")
	if not spinAttach.Parent then
		spinAttach.Parent = data.HumRP
	end

	local av = Instance.new("AngularVelocity")
	av.Attachment0 = spinAttach
	av.RelativeTo = Enum.ActuatorRelativeTo.World
	av.AngularVelocity = Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
	av.MaxTorque = 1e9
	av.Parent = data.HumRP

	-- Random starting point on the sphere surface
	local function randUnit()
		local v = Vector3.new(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100))
		return v.Magnitude > 0.01 and v.Unit or Vector3.new(1, 0, 0)
	end

	-- Random tangent to a surface normal
	local function randTangent(n)
		local arb = math.abs(n.X) < 0.9 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0)
		local t1 = n:Cross(arb).Unit
		local t2 = n:Cross(t1).Unit
		local a = math.random(0, 628) / 100
		return (math.cos(a) * t1 + math.sin(a) * t2)
	end

	local posDir = randUnit() -- unit vector: where on the sphere the enemy is
	local velDir = randTangent(posDir) -- which direction they're moving along the surface

	-- Each enemy curves at a different rate and direction, changing periodically
	local curvature = math.random(100, 300) / 100
	local curveSign = math.random(0, 1) == 0 and 1 or -1
	local curveTimer = 0
	local nextChange = math.random(8, 20) / 10 -- change direction every 0.8-2s

	local connection = RunService.Heartbeat:Connect(function(dt)
		-- Randomly change curve direction so they don't loop forever
		curveTimer += dt
		if curveTimer >= nextChange then
			curveTimer = 0
			nextChange = math.random(8, 20) / 10
			curveSign = math.random(0, 1) == 0 and 1 or -1
			curvature = math.random(100, 300) / 100
		end

		-- Steer the velocity direction sideways (turning on the sphere surface)
		local sideAxis = posDir:Cross(velDir)
		if sideAxis.Magnitude > 0.001 then
			velDir = velDir + sideAxis * curveSign * curvature * dt
			velDir = velDir - posDir * velDir:Dot(posDir) -- strip radial component, keep tangent
			if velDir.Magnitude > 0.001 then
				velDir = velDir.Unit
			end
		end

		-- Move forward along the sphere surface and renormalize
		local newPos = posDir + velDir * ORBIT_SPEED * dt
		if newPos.Magnitude > 0.001 then
			posDir = newPos.Unit
		end

		worldAnchor.WorldPosition = gatherPoint + posDir * ORBIT_RADIUS
	end)

	return connection, worldAnchor, av
end

return {
	Start = function(Player: Player, Cooldown)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		local Animator: Animator = Humanoid.Animator

		if Character:HasTag("Stunned") then
			return
		end
		if Player:GetAttribute("AbilityFourCooldown") then
			return
		end

		Player:SetAttribute("AbilityFourCooldown", true)

		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = 0.5
		end

		-- DestroyImmunity=true: skill lock, so the M1 EndFunction can't restore
		-- movement mid-skill (see skillLock check in NewCombatSystem)
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		Character:AddTag("NoHeadFollow")
		--Stun:SetAttribute("WalkSpeed", 5)
		--local BV = Instance.new("BodyVelocity")
		--BV.Name = "moveme"
		--BV.MaxForce = Vector3.new(100000, 100000, 100000)
		--BV:SetAttribute("Speed", 25)              -- forward speed
		--BV:SetAttribute("Fallout", .97)             -- no deceleration (constant forward)
		--BV:SetAttribute("Aerial", 70)            -- upward boost
		--BV:SetAttribute("AerialDecrease", 5)     -- drains fast so they stop going up quickly -- after Aerial drains, Y force shuts off so they fall naturally
		--BV:SetAttribute("EndExclusion", true)     -- don't auto-destroy at low speed
		--BV:SetAttribute("YForceImmunity", false)

		local BV = Instance.new("BodyVelocity")
		BV.Name = "moveme"
		BV.MaxForce = Vector3.new(100000, 100000, 100000)
		BV:SetAttribute("Speed", 40) -- forward speed
		BV:SetAttribute("Fallout", 0.97) -- slight forward deceleration
		BV:SetAttribute("Aerial", 30) -- upward boost
		BV:SetAttribute("AerialDecrease", 0.97) -- multiplier for Monster (not subtractor)
		--BV:SetAttribute("Monster", true)          -- enable parabolic decay
		BV:SetAttribute("EndExclusion", true) -- don't auto-destroy
		BV:SetAttribute("YForceImmunity", true)
		--local BV = Instance.new("BodyVelocity")
		--BV:SetAttribute("Aerial", 130)
		--BV:SetAttribute("AerialDecrease", 0.975)
		--BV:SetAttribute("BeganTick", tick())
		--BV:SetAttribute("End", 5)
		--BV:SetAttribute("Fallout", 0.9)
		--BV:SetAttribute("Inverted", true)
		--BV:SetAttribute("Monster", true)
		--BV:SetAttribute("RemoveOthers", true)
		--BV:SetAttribute("Speed", 90)

		local Hit = false
		local grabHit = false

		local BlackHoleLoopSound = nil

		local fakeRoot = Instance.new("Part")
		fakeRoot.Anchored = true
		fakeRoot.CanCollide = false
		fakeRoot.CanTouch = false
		fakeRoot.CanQuery = false
		fakeRoot.AudioCanCollide = false
		fakeRoot.EnableFluidForces = false
		fakeRoot.Transparency = 1
		fakeRoot.Size = Vector3.new(1, 1, 1)
		fakeRoot.Parent = workspace.World.Visuals
		Debris:AddItem(fakeRoot, 10)

		--local UserAnimation = MoveAnims.BaldHero["Consecutive Punches"].User
		local StartAnimation: AnimationTrack = NewAnimLocation.JumpExplosion.Animation

		local UserTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		local hitList = {}
		StartEvents["jump"] = UserTrack:GetMarkerReachedSignal("jump"):Once(function()
			BV.Parent = HumRP
		end)

		StartEvents["hit"] = UserTrack:GetMarkerReachedSignal("hit"):Once(function()
			--warn("Reached hit")
			local CFrameToUse = HumRP.CFrame * CFrame.new(0, -5, -10)
			fakeRoot.CFrame = CFrameToUse
			Character:AddTag("CantRotate")

			--BV:SetAttribute("YForceImmunity", true)
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = fakeRoot
			Hitbox.Size = Vector3.new(20, 20, 20)
			Hitbox.Offset = CFrame.new(0, 0, 0)
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)

				--if Finisher == true or EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
				if hitList[EnemyCharacter] then
					return
				end
				if
					EnemyCharacter == Character
					or iFramesService:HasiFrame(EnemyCharacter, 2)
					or EnemyHumanoid.Health <= 0
					or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
				then
					return
				end

				--local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0.75, 0.75, Animations.Combat.Hits[tostring(math.random(1, 1))], true, true, true, true, false, nil, 13)
				--local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 0.75, 0.75, Animations.Character.Damaged["Damaged" ..tostring(math.random(0, 4))], true, true, true, true, false, nil, 13)
				local HitInfo = DamageHandler:TakeDamage(
					Character,
					EnemyHumanoid,
					MoveConfig.Damage.Hit,
					2,
					nil,
					true,
					true,
					true,
					true,
					false,
					nil,
					13
				)

				if HitInfo.Countered == true then
					return
				end

				--table.insert(hitList, EnemyCharacter)
				EnemyCharacter:AddTag("CantRotate")
				RagdollHandler.ragdoll(EnemyHumanoid, 7, false, Character, nil, nil, false, {Cosmetic = true})

				local AttackerAttachment = Instance.new("Attachment")
				AttackerAttachment.Position = Vector3.new(0, -5, -8)
				AttackerAttachment.Parent = HumRP

				-- attachment on enemy
				local EnemyAttachment = Instance.new("Attachment")
				EnemyAttachment.Parent = EnemyHumRP

				-- AlignPosition to pull enemy to attacker attachment
				local AlignPos = Instance.new("AlignPosition")
				AlignPos.Mode = Enum.PositionAlignmentMode.TwoAttachment
				AlignPos.Attachment0 = EnemyAttachment
				AlignPos.Attachment1 = AttackerAttachment
				AlignPos.MaxForce = 40000
				AlignPos.Responsiveness = 15
				AlignPos.MaxVelocity = 30
				AlignPos.Parent = EnemyHumRP

				--pcall(function()
				--	EnemyHumRP:SetNetworkOwner(nil)
				--end)
				pcall(function() EnemyHumRP:SetNetworkOwner(Player) end)


				hitList[EnemyCharacter] = {
					--EnemyStun          = enemyStun,
					Player = EnemyPlayer,
					Humanoid = EnemyHumanoid,
					HumRP = EnemyHumRP,
					AttackerAttachment = AttackerAttachment,
					EnemyAttachment = EnemyAttachment,
					AlignPos = AlignPos,
				}
			end
			Hitbox:Start()
			task.delay(0.5, function()
				Hitbox:Stop()
				Hitbox:Destroy()
			end)

			RemotesContainer.ClientEffects:FireAllClients(
				"BlackBeardFourthAbility",
				{ Attacker = Character, SkillType = "BlackHoleStart", PartCFrame = CFrameToUse }
			)
			BlackHoleLoopSound =
				SoundHandler:AddSound(MoveSounds.BlackBeard.BlackBallExplosion["Blackhole Loop"], CFrameToUse)
			
			
			
			-- Everything breakable around the black hole gets pulled into it (walls, rubble, trees)
			local blackHoleTarget = Instance.new("Attachment")
			blackHoleTarget.Name = "AbsorbTarget"
			blackHoleTarget.Parent = fakeRoot
			DebreeService.Absorb(CFrameToUse, Vector3.new(28, 28, 28), {
				Shape = "Ball",
				Target = blackHoleTarget,
				Attacker = Player,
				Style = "Tumble",
				GridSize = 3,
			})
		end)

		

		StartEvents["flip"] = UserTrack:GetMarkerReachedSignal("flip"):Once(function()
			if BV and BV.Parent then
				--BV:SetAttribute("Aerial", 0)
				--BV:SetAttribute("Speed", 0)
				BV:SetAttribute("Inverted", true) -- reverse the LookVector → backwards
				BV:SetAttribute("Speed", 20) -- reset speed since fallout=1 keeps it constant
				BV:SetAttribute("Fallout", 0.98) -- decelerate over time so the flip doesn't go forever
				BV:SetAttribute("Aerial", 40) -- upward boost
				BV:SetAttribute("AerialDecrease", 1) -- drains so they peak and start falling
				BV:SetAttribute("End", 5) -- now allow auto-destroy at low speed
				BV:SetAttribute("EndExclusion", false) -- ↑ requires turning this off too
			end

			Character:RemoveTag("CantRotate")

			-- Sort the already-grabbed enemies into finisher vs normal
			local FINISHER_HP = 13 -- enemies at or below this HP get finished (tune to taste)

			-- Sort the already-grabbed enemies into finisher vs normal
			local finisherTargets = {}
			local normalTargets = {}

			for enemyChar, data in hitList do
				local enemyHumanoid = data.Humanoid
				if not enemyHumanoid or enemyHumanoid.Health <= 0 then
					continue
				end

				if enemyHumanoid.Health <= FINISHER_HP then
					finisherTargets[enemyChar] = data
				else
					normalTargets[enemyChar] = data
				end
			end

			-- NORMAL: release the hold and fling them away (now per-enemy — fixes Bug 5)
			for enemyChar, data in normalTargets do
				local enemyHumRP = data.HumRP

				if data.AlignPos and data.AlignPos.Parent then
					TweenService
						:Create(data.AlignPos, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							MaxForce = 0,
							MaxVelocity = 0,
						})
						:Play()
				end
				if enemyHumRP and enemyHumRP.Parent then
					--pcall(function()
					--	enemyHumRP:SetNetworkOwner(nil)
					--end)
					
					pcall(function()
						if data.Player then
							enemyHumRP:SetNetworkOwner(data.Player)
						else
							enemyHumRP:SetNetworkOwner(nil)
						end
					end)
					
					
					
					enemyHumRP.AssemblyLinearVelocity = Vector3.zero
					enemyHumRP.AssemblyAngularVelocity = Vector3.zero
				end
				if data.AlignPos and data.AlignPos.Parent then
					data.AlignPos:Destroy()
				end
				if data.AttackerAttachment and data.AttackerAttachment.Parent then
					data.AttackerAttachment:Destroy()
				end
				if data.EnemyAttachment and data.EnemyAttachment.Parent then
					data.EnemyAttachment:Destroy()
				end

				if enemyChar:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(data.Humanoid)
				end

				local hitboxCenter = (HumRP.CFrame * CFrame.new(0, -5, -10)).Position
				local pullDirection = (hitboxCenter - enemyHumRP.Position).Unit
				NewKnockback:Knockback(enemyChar, {
					KnockbackType = "Velocity",
					MaxForce = Vector3.new(100000, 100000, 100000),
					Velocity = pullDirection * 75,
				})
				
				RagdollHandler.ragdoll(data.Humanoid, 2)

				hitList[enemyChar] = nil
			end

			-- FINISHER: spin in place, then explode (Bug 4 fix: spawned so it doesn't yield the marker)
			--if next(finisherTargets) then
			--	RemotesContainer.ClientEffects:FireAllClients(
			--		"BlackBeardFourthAbility",
			--		{ Attacker = Character, SkillType = "FinisherBlackHole" }
			--	)

			--	-- Snapshot the gather point in WORLD space right now, before you flip away.
			--	local gatherPoint = (HumRP.CFrame * CFrame.new(0, -5, -8)).Position

			--	task.spawn(function()
			--		local targetCount = 0
			--		for _ in finisherTargets do
			--			targetCount += 1
			--		end
			--		local angleStep = (math.pi * 2) / math.max(1, targetCount)
			--		local angleIndex = 0

			--		local connections = {}
			--		local worldAnchors = {}
			--		local spins = {} -- add this

			--		for enemyChar, data in finisherTargets do
			--			local conn, anchor, av = orbitEnemy(data, gatherPoint, angleIndex * angleStep)
			--			connections[enemyChar] = conn
			--			worldAnchors[enemyChar] = anchor
			--			spins[enemyChar] = av
			--			angleIndex += 1

			--			if enemyChar:HasTag("Ragdolled") then
			--				RagdollHandler.cancelRagdoll(data.Humanoid)
			--			end
			--			RagdollHandler.ragdoll(data.Humanoid, 6, false, Character, nil, nil, false, {Cosmetic = true})
			--		end					
					

			--		-- fire every explosion at the same time
			--		for enemyChar in finisherTargets do
			--			task.delay(SPIN_TIME - 0.2, function()
			--				if not enemyChar.Parent or not enemyChar:FindFirstChild("HumanoidRootPart") then
			--					return
			--				end
			--				RemotesContainer.ClientEffects:FireAllClients("BlackBeardFourthAbility", {
			--					Attacker = Character,
			--					SkillType = "FinisherBlackHoleExplode",
			--					Victim = enemyChar,
			--				})
			--			end)
			--		end

			--		task.wait(SPIN_TIME) -- ONE wait for everyone, not one per enemy

			--		for enemyChar, data in finisherTargets do
			--			if connections[enemyChar] then
			--				connections[enemyChar]:Disconnect()
			--			end
			--			if worldAnchors[enemyChar] then
			--				worldAnchors[enemyChar]:Destroy()
			--			end
			--			if spins[enemyChar] then
			--				spins[enemyChar]:Destroy()
			--			end

			--			if data.AlignPos and data.AlignPos.Parent then
			--				data.AlignPos:Destroy()
			--			end
			--			if data.AttackerAttachment and data.AttackerAttachment.Parent then
			--				data.AttackerAttachment:Destroy()
			--			end
			--			if data.EnemyAttachment and data.EnemyAttachment.Parent then
			--				data.EnemyAttachment:Destroy()
			--			end

			--			local enemyHumRP = enemyChar:FindFirstChild("HumanoidRootPart")
			--			if not enemyHumRP then
			--				hitList[enemyChar] = nil
			--				continue
			--			end

			--			task.delay(0.1, function()
			--				local enemyHumanoid = enemyChar:FindFirstChild("Humanoid")
			--				if not enemyHumanoid then
			--					return
			--				end
			--				DamageHandler:TakeDamage(
			--					Character,
			--					enemyHumanoid,
			--					enemyHumanoid.Health,
			--					nil,
			--					nil,
			--					false,
			--					false,
			--					false,
			--					true,
			--					true,
			--					nil,
			--					nil
			--				)
			--			end)

			--			hitList[enemyChar] = nil
			--		end
			--	end)
			--end
			
			
			if next(finisherTargets) then
				-- FINISHER: explode straight away (no black hole / orbit VFX), then kill
				for enemyChar, data in finisherTargets do
					-- release the grab
					if data.AlignPos and data.AlignPos.Parent then
						data.AlignPos:Destroy()
					end
					if data.AttackerAttachment and data.AttackerAttachment.Parent then
						data.AttackerAttachment:Destroy()
					end
					if data.EnemyAttachment and data.EnemyAttachment.Parent then
						data.EnemyAttachment:Destroy()
					end

					hitList[enemyChar] = nil

					local enemyHumRP = enemyChar:FindFirstChild("HumanoidRootPart")
					if not enemyHumRP then
						continue
					end

					RemotesContainer.ClientEffects:FireAllClients("BlackBeardFourthAbility", {
						Attacker = Character,
						SkillType = "FinisherBlackHoleExplode",
						Victim = enemyChar,
					})

					task.delay(0.1, function()
						local enemyHumanoid = enemyChar:FindFirstChild("Humanoid")
						if not enemyHumanoid then
							return
						end
						DamageHandler:TakeDamage(
							Character,
							enemyHumanoid,
							enemyHumanoid.Health,
							nil,
							nil,
							false,
							false,
							false,
							true,
							true,
							nil,
							nil
						)
					end)
				end
			end
			
			
			RemotesContainer.ClientEffects:FireAllClients("BlackBeardFourthAbility", {
				Attacker = Character,
				SkillType = "BlackHoleExplosion",
				Part = fakeRoot,
			})

			SoundHandler:AddSound(MoveSounds.BlackBeard.BlackBallExplosion.Liger_Bomb_Crater, fakeRoot.CFrame)
			task.delay(0.2, function()
				if BlackHoleLoopSound then
					SoundHandler:StopSound(BlackHoleLoopSound, 1)
				end
			end)

			--local results = DestructionHandler.destroy(Vector3.new(30, 30, 30), fakeRoot.CFrame, Enum.PartType.Ball, {
			--	MinimumSize = 5,
			--	TimeToReset = 20,
			--	Player = Player,
			--	VoxelDestroyChance = 0.5,
			--	FlingDestroyChance = 1,
			--	VoxelVelocity = function(voxel, hitPos)
			--		local outward = voxel.Position - hitPos
			--		outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)

			--		local linear = outward * math.random(60, 100) + Vector3.new(0, 20, 0)
			--		local angular = Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
			--		return linear, angular
			--	end,
			--})
		end)

		UserTrack.Stopped:Once(function()
			for _, v in StartEvents do
				v:Disconnect()
			end

			if BV then
				BV:Destroy()
			end

			fakeRoot:Destroy()
			if BlackHoleLoopSound then
				SoundHandler:StopSound(BlackHoleLoopSound, 1)
			end
			Character:RemoveTag("CantRotate")
			Character:RemoveTag("NoHeadFollow")
			StunHandler:Unstun(Character, Stun)
			iFramesService:RemoveAlliFrames(Character)
			Player:SetAttribute("AbilityFourCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityFourCooldown", false)
				end
			end)
		end)

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)

		RemotesContainer.ClientEffects:FireAllClients(
			"BlackBeardSecondAbility",
			{ Attacker = Character, SkillType = "bodyAura" }
		)
		SoundHandler:AddSound(MoveSounds.BlackBeard.BlackBallExplosion.Explode, HumRP)
	end,
}
