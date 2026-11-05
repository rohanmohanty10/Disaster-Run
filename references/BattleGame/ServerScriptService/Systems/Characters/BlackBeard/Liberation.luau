local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).BlackBeard.Ult
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService = game:GetService("Players")

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
local VoxelSerializer = require(ReplicatedModules.VoxelSerializer)

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

-- ── Absorbed-color tally (Liberation explosion) ──────────────────────────────
local COLOR_BUCKETS = 6 -- levels per RGB channel; higher = finer color separation

local function colorKey(c: Color3): string
	return math.floor(c.R * COLOR_BUCKETS + 0.5)
		.. "_"
		.. math.floor(c.G * COLOR_BUCKETS + 0.5)
		.. "_"
		.. math.floor(c.B * COLOR_BUCKETS + 0.5)
end

-- fold a snapshot list into `tally`, weighting each color by the part's VOLUME
-- so one big wall dominates over a pile of pebbles
local function tallySnapshots(tally, snapshots)
	if not snapshots then
		return
	end
	for _, snap in snapshots do
		if snap.Color then
			local key = colorKey(snap.Color)
			local bucket = tally[key]
			if not bucket then
				bucket =
					{ Color = snap.Color, Material = snap.Material, MaterialVariant = snap.MaterialVariant, weight = 0 }
				tally[key] = bucket
			end
			local s = snap.Size
			bucket.weight += (s and s.X * s.Y * s.Z) or 1
		end
	end
end

-- turn the tally into exactly `count` {Color, Material, MaterialVariant} picks,
-- distributed by weight (largest-remainder = exact ratio) and shuffled
local function buildRockPalette(tally, count, rng)
	local buckets, total = {}, 0
	for _, b in tally do
		table.insert(buckets, b)
		total += b.weight
	end
	if #buckets == 0 or total <= 0 then
		return nil
	end -- nothing eaten → default gray

	local assigned = 0
	for _, b in buckets do
		local exact = b.weight / total * count
		b._whole = math.floor(exact)
		b._rem = exact - b._whole
		assigned += b._whole
	end
	table.sort(buckets, function(a, b)
		return a._rem > b._rem
	end)
	local leftover = count - assigned

	local picks = {}
	for i, b in buckets do
		local n = b._whole + ((i <= leftover) and 1 or 0)
		for _ = 1, n do
			table.insert(picks, { Color = b.Color, Material = b.Material, MaterialVariant = b.MaterialVariant })
		end
	end
	for i = #picks, 2, -1 do -- shuffle so colors aren't grouped
		local j = rng:NextInteger(1, i)
		picks[i], picks[j] = picks[j], picks[i]
	end
	return picks
end

return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		if not (Character and Humanoid and HumRP) or Humanoid.Health <= 0 then
			return
		end
		local Animator: Animator = Humanoid.Animator

		if Character:HasTag("Stunned") then
			return
		end
		if Player:GetAttribute("ModeAbility") then
			return
		end

		Player:SetAttribute("ModeAbility", true)

		local CooldownTime = 30
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = 0.5
		end

		local EnemyCharacter = nil
		local EnemyPlayer = nil
		local EnemyHumRP = nil

		--local EnemyStun = nil
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		iFramesService:AddAlliFrames(Character)

		local grabHit = false
		local pullGrab = false
		local Finisher = false

		local Janitor = Trove.new()
		local colorTally = {} -- absorbed colors accumulate here across both suck-ins
		local Container = {}
		local Assets = {}

		local StartAnimation = NewAnimLocation["Liberation"].Full2

		local MainSound
		local BlackholeMiddle
		local KurozuLoop

		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		local fakeBallRoot = Instance.new("Part")
		fakeBallRoot.Anchored = true
		fakeBallRoot.CanCollide = false
		fakeBallRoot.CanTouch = false
		fakeBallRoot.CanQuery = false
		fakeBallRoot.AudioCanCollide = false
		fakeBallRoot.EnableFluidForces = false
		fakeBallRoot.Transparency = 1
		fakeBallRoot.Size = Vector3.new(1, 1, 1)
		fakeBallRoot.Parent = workspace.World.Visuals
		Debris:AddItem(fakeBallRoot, 20)

		local rockSound = nil
		StartEvents["vfx"] = StartTrack:GetMarkerReachedSignal("vfx"):Once(function()
			rockSound = SoundHandler:AddSound(MoveSounds.BlackBeard.Liberation.RockLoop, HumRP)
			Character:SetAttribute("LiberationVfxEnd", true)
			RemotesContainer.ClientEffects:FireAllClients(
				"BlackBeardLiberation",
				{ Attacker = Character, SkillType = "start" }
			)
			RemotesContainer.ClientEffects:FireAllClients(
				"BlackBeardLiberation",
				{ Attacker = Character, SkillType = "darkBeam1" }
			)

			fakeBallRoot.CFrame = HumRP.CFrame * CFrame.new(0, 40, 0)
			task.delay(5.5, function()
				RemotesContainer.ClientEffects:FireAllClients(
					"BlackBeardLiberation",
					{ Attacker = Character, SkillType = "bigBall" }
				)
				--RemotesContainer.ClientEffects:FireAllClients("BlackBeardLiberation", {Attacker = Character, SkillType =  "DebrisOrb"}) -- To much right now
				SoundHandler:AddSound(MoveSounds.BlackBeard.Liberation.Charge, HumRP)

				task.spawn(function()
					for i = 1, 9 do
						task.wait(0.6)
						SoundHandler:AddSound(MoveSounds.BlackBeard.Liberation.Charge, HumRP)
					end
				end)

				task.spawn(function()
					local startSize = Vector3.new(10, 10, 10)
					local endSize = Vector3.new(50, 50, 50)
					local duration = 3
					local startClock = os.clock()

					local skyTarget = Instance.new("Attachment")
					skyTarget.Name = "AbsorbTarget"
					skyTarget.Parent = fakeBallRoot
					local lastSkyAbsorb = 0

					while true do
						local alpha = math.clamp((os.clock() - startClock) / duration, 0, 1)
						local size = startSize:Lerp(endSize, alpha)

						-- The growing sky ball pulls in everything breakable around it (at most ~10 absorbs a second)
						if os.clock() - lastSkyAbsorb >= 0.15 or alpha >= 1 then
							lastSkyAbsorb = os.clock()
							local taken = {}
							DebreeService.Absorb(HumRP.CFrame * CFrame.new(0, 40, 0), size, {
								Shape = "Ball",
								Target = skyTarget,
								Attacker = Player,
								Style = "Tumble",
								GridSize = 3,
								Report = taken,
							})
							tallySnapshots(colorTally, taken) -- Orb tallying
						end

						if alpha >= 1 then
							break
						end
						task.wait()
					end
				end)
			end)

			--local results = DestructionHandler.destroy(
			--	Vector3.new(10, 50, 10),
			--	HumRP.CFrame * CFrame.new(0, 25, 0),
			--	Enum.PartType.Block,
			--	{
			--		MinimumSize = 5,
			--		TimeToReset = 60,
			--		Player = Player,
			--		VoxelDestroyChance = 0.7,
			--		FlingDestroyChance = 1,
			--		--Visualize = true
			--	}
			--)

			task.spawn(function()
				local startSize = Vector3.new(20, 10, 20)
				local endSize = Vector3.new(150, 30, 150)
				local duration = 2.5
				local startClock = os.clock()

				-- ONE anchor for the whole cast (was: a fresh Attachment every frame, each
				-- sent by reference before replicating — early batches stall on high ping)
				local pullAnchor = Instance.new("Attachment")
				pullAnchor.Name = "BlackHoleAnchor"
				pullAnchor.Position = Vector3.new(0, -2.9, 0) -- the hole's center, at your feet
				pullAnchor.Parent = HumRP
				Debris:AddItem(pullAnchor, duration + 6)

				local lastGroundAbsorb = 0

				while true do
					local alpha = math.clamp((os.clock() - startClock) / duration, 0, 1)
					local size = startSize:Lerp(endSize, alpha)

					-- The growing hole at the feet sinks everything breakable into the ground (floors stay)
					if os.clock() - lastGroundAbsorb >= 0.15 or alpha >= 1 then
						lastGroundAbsorb = os.clock()
						local taken = {}
						DebreeService.Absorb(HumRP.CFrame * CFrame.new(0, -3, 0), size, {
							Shape = "Oval",
							Target = pullAnchor,
							Attacker = Player,
							Style = "Sink",
							GridSize = 3,
							Report = taken,
						})
						tallySnapshots(colorTally, taken) -- Ground blackhole tallying
					end

					if alpha >= 1 then
						break
					end
					task.wait()
				end
			end)
		end)

		StartEvents["vfxend"] = StartTrack:GetMarkerReachedSignal("vfxend"):Once(function()
			Character:SetAttribute("LiberationVfxEnd", false)
			Character:SetAttribute("LiberationVfxEnd", nil)
		end)

		local EnemyHumanoid = nil

		local enemyData = {}
		
		local function releaseVictim(enemyCharacter, data)
			if data.released then return end
			data.released = true
			
			RemotesContainer.ClientEffects:FireAllClients(
				"BlackBeardLiberation",
				{ Attacker = enemyCharacter, SkillType = "UnTransparent" }
			)

			if data.reachedConnection then data.reachedConnection:Disconnect() end
			if data.orbReachedConnection then data.orbReachedConnection:Disconnect() end
			if data.orbitConnection then data.orbitConnection:Disconnect() end

			if data.AlignPos then data.AlignPos:Destroy() end
			if data.AttackerAttachment then data.AttackerAttachment:Destroy() end
			if data.OrbAttachment then data.OrbAttachment:Destroy() end
			if data.EnemyAttachment then data.EnemyAttachment:Destroy() end
			if data.debugPart then data.debugPart:Destroy() end

			if enemyCharacter and enemyCharacter.Parent then
				--StunHandler:Unstun(enemyCharacter, data.EnemyStun) -- nil falls back to clearing all stuns
				iFramesService:RemoveAlliFrames(enemyCharacter)
				if not EnemyCharacter:HasTag("Ragdolled") then
					CollisionsModule:SetCollisionGroup(enemyCharacter, "Players")
				end
				enemyCharacter:RemoveTag("CantRotate")

				local hrp = enemyCharacter:FindFirstChild("HumanoidRootPart")
				local p = PlayersService:GetPlayerFromCharacter(enemyCharacter)
				if hrp and p then
					pcall(function() hrp:SetNetworkOwner(p) end)
				end
			end
			
			if EnemyCharacter:HasTag("Ragdolled") then
				RagdollHandler.cancelRagdoll(EnemyHumanoid)
			end
		end
		
		local shouldShrink = false
		StartEvents["start"] = StartTrack:GetMarkerReachedSignal("start"):Once(function()
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(160, 5, 160)
			Hitbox.Offset = CFrame.new(0, -2, 0)
			Hitbox.Visualize = false
			Hitbox.onTouch = function(HitCharacter)
				EnemyCharacter = HitCharacter
				EnemyHumanoid = HitCharacter.Humanoid
				EnemyHumRP = HitCharacter.HumanoidRootPart

				EnemyPlayer = game.Players:GetPlayerFromCharacter(HitCharacter)

				if HitCharacter == Character
					or iFramesService:HasiFrame(HitCharacter, 2)
					or EnemyHumanoid.Health <= 0
					or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
				then
					return
				end

				local HitInfo = DamageHandler:TakeDamage(
					Character,
					EnemyHumanoid,
					MoveConfig.Damage.Tick,
					0.75,
					nil,
					true,
					true,
					true,
					true,
					false,
					nil,
					13
				)

				if not enemyData[HitCharacter] then
					enemyData[HitCharacter] = {
						AttackerAttachment = nil,
						OrbAttachment = nil,
						EnemyAttachment = nil,
						AlignPos = nil,
						debugPart = nil,
						reachedConnection = nil,
						orbReachedConnection = nil,
						orbitConnection = nil,
						--EnemyStun = nil,
					}

					--EnemyStun = StunHandler:Stun(HitCharacter, nil, true, 0, 0, true)
					--enemyData[HitCharacter].EnemyStun = EnemyStun

					local VictimAnimation = NewAnimLocation["Liberation"].Victim
					local VictimTrack
					local VictimEvents = {}

					VictimTrack = AnimationService:getAnimationTrack(HitCharacter, VictimAnimation)

					VictimEvents["inGround"] = VictimTrack:GetMarkerReachedSignal("inGround"):Once(function()
						VictimTrack:AdjustSpeed(1)
						
						RemotesContainer.ClientEffects:FireAllClients(
							"BlackBeardLiberation",
							{ Attacker = HitCharacter, SkillType = "Transparent" }
						)
						

						local EnemyPlayer = PlayersService:GetPlayerFromCharacter(HitCharacter)
						local EnemyHumanoid: Humanoid = HitCharacter.Humanoid
						local EnemyHRP = HitCharacter.HumanoidRootPart


						if HitCharacter == Character
							or iFramesService:HasiFrame(HitCharacter, 2)
							or EnemyHumanoid.Health <= 0
							or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
						then
							return
						end

						if pullGrab == true or iFramesService:HasiFrame(HitCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then
							return
						end
						
						local HitInfo = DamageHandler:TakeDamage(
							Character,
							EnemyHumanoid,
							MoveConfig.Damage.Pull,
							nil,
							nil,
							false,
							true,
							true,
							true,
							false,
							nil,
							19.5
						)
						
						--if HitInfo.Countered == true then
						--	return
						--end

						CollisionsModule:SetCollisionGroup(HitCharacter, "NoCol")

						HitCharacter:AddTag("CantRotate")

						--pcall(function()
						--	if EnemyHRP:CanSetNetworkOwnership() then
						--		EnemyHRP:SetNetworkOwner(nil)
						--	end
						--end)

						local AttackerAttachment = Instance.new("Attachment")

						AttackerAttachment.Name = "PullAttachment"
						AttackerAttachment.Position = Vector3.new(0, 0, 0) -- 3 studs in front
						AttackerAttachment.Parent = HumRP -- Your RootPart

						local OrbAttachment = Instance.new("Attachment")

						OrbAttachment.Name = "OrbAttachment"
						--OrbAttachment.Position = Vector3.new(0, 40, 0)
						OrbAttachment.Position = HumRP.Position + Vector3.new(0, 40, 0)

						OrbAttachment.Parent = workspace.Terrain
						--OrbAttachment.Parent = HumRP

						local debugPart = Instance.new("Part")

						debugPart.Name = "OrbDebug"
						debugPart.Size = Vector3.new(2, 2, 2)
						debugPart.Shape = Enum.PartType.Ball
						debugPart.Color = Color3.fromRGB(255, 0, 0) -- bright red so you can see it
						debugPart.Material = Enum.Material.Neon
						debugPart.CanCollide = false
						debugPart.CanQuery = false
						debugPart.Anchored = true
						debugPart.Parent = workspace

						-- 3. Create an Attachment on the Enemy
						local EnemyAttachment = Instance.new("Attachment")

						EnemyAttachment.Parent = EnemyHRP

						local AlignPos = Instance.new("AlignPosition")
						AlignPos.Mode = Enum.PositionAlignmentMode.TwoAttachment
						AlignPos.Attachment0 = EnemyAttachment
						AlignPos.Attachment1 = AttackerAttachment
						AlignPos.MaxForce = 30000 -- High force for a strong pull
						--AlignPos.Responsiveness = 3 -- How "snappy" the pull is (higher = faster)
						AlignPos.MaxVelocity = 20
						AlignPos.Parent = EnemyHRP

						local function getResponsiveness(dist)
							local maxDist = 80 -- distance where responsiveness is at max
							local minResp = 3
							local maxResp = 10
							local alpha = math.clamp(dist / maxDist, 0, 1)
							return minResp + (maxResp - minResp) * alpha
						end
						AlignPos.Responsiveness = getResponsiveness((EnemyHRP.Position - HumRP.Position).Magnitude)

						RagdollHandler.ragdoll(EnemyHumanoid, 15, false, nil, nil, nil, true, {Cosmetic = true})
						
						pcall(function()
							if EnemyHRP:CanSetNetworkOwnership() then
								EnemyHRP:SetNetworkOwner(nil)
							end
						end)
						
						EnemyHRP.AssemblyLinearVelocity = Vector3.zero
						EnemyHRP.AssemblyAngularVelocity = Vector3.zero
						
						local reachedConnection
						local orbReachedConnection
						local orbitConnection

						enemyData[HitCharacter] = {
							AttackerAttachment = AttackerAttachment,
							OrbAttachment = OrbAttachment,
							EnemyAttachment = EnemyAttachment,
							AlignPos = AlignPos,
							debugPart = debugPart,
							reachedConnection = nil,
							orbReachedConnection = nil,
							orbitConnection = nil,
						}

						-- CHECK 1: Has enemy reached HumRP (the attacker)?
						reachedConnection = RunService.Heartbeat:Connect(function()
							enemyData[HitCharacter].reachedConnection = reachedConnection

							if not EnemyHRP or not EnemyHRP.Parent then
								reachedConnection:Disconnect()
								return
							end

							local distance = (EnemyHRP.Position - HumRP.Position).Magnitude
							AlignPos.Responsiveness = getResponsiveness(distance)

							if distance <= 3 then
								--print("Reached attacker, redirecting to Orb")
								reachedConnection:Disconnect()

								-- Redirect AlignPos to the OrbAttachment now
								AlignPos.Attachment1 = OrbAttachment
								--AlignPos.MaxVelocity = 60
								RemotesContainer.ClientEffects:FireAllClients(
									"BlackBeardLiberation",
									{ Attacker = HitCharacter, SkillType = "UnTransparent" }
								)

								-- CHECK 2: Has enemy reached OrbAttachment?
								orbReachedConnection = RunService.Heartbeat:Connect(function()
									enemyData[HitCharacter].orbReachedConnection = orbReachedConnection

									if not EnemyHRP or not EnemyHRP.Parent then
										orbReachedConnection:Disconnect()
										return
									end

									local orbDistance = (EnemyHRP.Position - OrbAttachment.WorldPosition).Magnitude
									if orbDistance <= 8 then
										--print("Reached Orb, starting orbit")
										orbReachedConnection:Disconnect()

										local radius = 20 -- how wide the circle is
										local speed = 10 -- how fast they orbit
										local verticalSpeed = 8 -- how fast they bob up and down
										local verticalRange = 8 -- how far up and down they go
										AlignPos.MaxForce = 60000
										AlignPos.Responsiveness = 2000
										AlignPos.MaxVelocity = 140

										local t = math.random(0, 628) / 100

										local shrinkStarted = false

										orbitConnection = RunService.Heartbeat:Connect(function(dt)
											-- existing orbit code stays the same...
											t = t + dt
											local origin = HumRP.Position
											local x = math.cos(t * speed) * radius
											local z = math.sin(t * speed) * radius
											local y = 40 + math.sin(t * verticalSpeed) * verticalRange
											OrbAttachment.WorldPosition = origin + Vector3.new(x, y, z)
											debugPart.Position = OrbAttachment.WorldPosition

											-- add this at the bottom:
											if shouldShrink and not shrinkStarted then
												shrinkStarted = true
												local shrinkDuration = 4
												local startRadius = 20
												local endRadius = 3
												local startMaxForce = 60000
												local endMaxForce = 5000
												local startResponsiveness = 2000
												local endResponsiveness = 50
												local startMaxVelocity = 140
												local endMaxVelocity = 10
												local elapsed = 0

												local shrinkConnection
												shrinkConnection = RunService.Heartbeat:Connect(function(dt)
													elapsed = elapsed + dt
													local alpha = math.clamp(elapsed / shrinkDuration, 0, 1)
													local eased = 1 - (1 - alpha) ^ 3

													radius = startRadius + (endRadius - startRadius) * eased
													AlignPos.MaxForce = startMaxForce
														+ (endMaxForce - startMaxForce) * eased
													AlignPos.Responsiveness = startResponsiveness
														+ (endResponsiveness - startResponsiveness) * eased
													AlignPos.MaxVelocity = startMaxVelocity
														+ (endMaxVelocity - startMaxVelocity) * eased

													if alpha >= 1 then
														shrinkConnection:Disconnect()
													end
												end)
											end
										end)
									end
								end)
							end
						end)

						task.delay(16, function()
							if reachedConnection then
								reachedConnection:Disconnect()
							end
							if orbReachedConnection then
								orbReachedConnection:Disconnect()
							end
							if orbitConnection then
								orbitConnection:Disconnect()
							end

							AttackerAttachment:Destroy()
							OrbAttachment:Destroy()
							EnemyAttachment:Destroy()
							AlignPos:Destroy()
							debugPart:Destroy()
							RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true) -- New one?
						end)
						iFramesService:AddAlliFrames(HitCharacter)
					end)

					VictimTrack.Stopped:Once(function() end)

					--iFramesService:AddBaseiFrames(Character)
					--iFramesService:AddAlliFrames(HitCharacter)

					ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = HitCharacter })

					--AnimationService:playAnimation(Character, UserAnimation)
					AnimationService:playAnimation(HitCharacter, VictimAnimation)
					VictimTrack:AdjustSpeed(1.5)
				end
			end

			task.delay(0.033, function()
				Hitbox:Once()
				task.delay(1, function()
					Hitbox:Destroy()
				end)

				--if Hit then
				--	ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 0.75, Last = .1 })
				--end
			end)
			task.wait(0.1)
			StartTrack:AdjustSpeed(0.2)
			task.delay(3, function()
				StartTrack:AdjustSpeed(1)
			end)
		end)

		StartEvents["halfspeed"] = StartTrack:GetMarkerReachedSignal("halfspeed"):Once(function()
			StartTrack:AdjustSpeed(0.5)
		end)

		StartEvents["fullspeed"] = StartTrack:GetMarkerReachedSignal("fullspeed"):Once(function()
			StartTrack:AdjustSpeed(1)
		end)
		StartEvents["small"] = StartTrack:GetMarkerReachedSignal("small"):Once(function()
			task.delay(0.1, function()
				shouldShrink = true
			end)
			task.delay(0.7, function()
				SoundHandler:StopSound(rockSound, 0.5)
				RemotesContainer.ClientEffects:FireAllClients("BlackBeardLiberation", {
					Attacker = Character,
					SkillType = "shrinkOrb",
				})
				SoundHandler:AddSound(MoveSounds.BlackBeard.Liberation.Burst, HumRP)
			end)
		end)

		StartEvents["explode"] = StartTrack:GetMarkerReachedSignal("explode"):Once(function()
			local CFrameToUse = HumRP.CFrame * CFrame.new(0, 40, 0)

			local rockCount = 50
			local rockPalette = buildRockPalette(colorTally, rockCount, Random.new())
			local explodePos = HumRP.Position + Vector3.new(0, 40, 0)
			-- Debree: the final explosion obliterates a sphere around the orb, then breaks a rim around it
			task.spawn(function()
				local BLAST_SIZE = 150      -- across; the same reach as the pull (160 hitbox, 150 hole)
				local BLAST_RIM = 5        -- studs of broken rubble around it
				local BLAST_GRID = 4        -- wall piece size in the rim
				local BLAST_GROUND_GRID = 6 -- floor piece size in the rim
				local BlastCFrame = CFrame.new(explodePos)
				local BlastSize = Vector3.one * BLAST_SIZE
				DebreeService.Erase(BlastCFrame, BlastSize, {
					Shape = "Ball",
					IncludeGround = true, -- the ground goes too: a crater down to the unbreakable map underneath
					GridSize = BLAST_GRID,
					GroundGridSize = BLAST_GROUND_GRID,
				})
				task.wait(.1)
				DebreeService.Destroy(BlastCFrame, BlastSize + Vector3.one * (2 * BLAST_RIM), {
					Shape = "Ball",
					Hollow = BlastSize, -- only the rim outside the obliterated sphere breaks
					Outward = true,
					Power = 60,
					Lift = 20,
					Bounce = 0,
					GridSize = BLAST_GRID,
					GroundGridSize = BLAST_GROUND_GRID,
					-- no Attacker: the blast is 40 studs up, and the punch rule that nothing below
					-- your feet breaks would leave the walls around you standing
				})
			end)
			
			
			RemotesContainer.ClientEffects:FireAllClients(
				"BlackBeardLiberation",
				{ Attacker = Character, SkillType = "explode" }
			)
			RemotesContainer.ClientEffects:FireAllClients(
				"BlackBeardLiberation",
				{ Attacker = Character, SkillType = "ColorCorrection", HitPosition = explodePos }
			)
			ReplicateEffects_Set:FireAllClients("Liberation Rock Explosion", {
				position = HumRP.Position + Vector3.new(0, 40, 0),
				Seed = math.random(1, 2147483647),
				count = rockCount,
				minSpeed = 130,
				maxSpeed = 180,
				minSize = 3,
				maxSize = 5,
				upwardBias = 0.3,
				lifetime = 3,
				rocks = rockPalette,
			})

			shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = 13, Last = 0.4 } })

			local explodeSound = SoundHandler:AddSound(MoveSounds.BlackBeard.Liberation.Explode, fakeBallRoot)
			task.delay(2.1, function()
				SoundHandler:StopSound(explodeSound, 0.5)
			end)
			SoundHandler:StopSound(BlackholeMiddle, 1)
			SoundHandler:StopSound(KurozuLoop, 1)

			task.delay(1, function()
				SoundHandler:StopSound(MainSound, 1)
			end)

			--warn("Reached explode in liberation")
			--if reachedConnection then reachedConnection:Disconnect() end
			--if orbReachedConnection then orbReachedConnection:Disconnect() end
			--if orbitConnection then orbitConnection:Disconnect() end

			--if AttackerAttachment then
			--	AttackerAttachment:Destroy()

			--end
			--if OrbAttachment then
			--	OrbAttachment:Destroy()

			--end
			--if EnemyAttachment then
			--	EnemyAttachment:Destroy()

			--end
			--if AlignPos then
			--	AlignPos:Destroy()

			--end
			--if debugPart then
			--	debugPart:Destroy()

			--end
			for enemyCharacter, data in pairs(enemyData) do
				releaseVictim(enemyCharacter, data)


				local enemyHumRP = enemyCharacter:FindFirstChild("HumanoidRootPart")
				local enemyHumanoid = enemyCharacter:FindFirstChild("Humanoid")

				local enemyPlayer = game.Players:GetPlayerFromCharacter(enemyCharacter)

				if enemyHumRP and enemyHumanoid then
					--StunHandler:Unstun(enemyCharacter, data.EnemyStun)
					iFramesService:RemoveAlliFrames(enemyCharacter)

					--EnemyCharacter:RemoveTag("CantRotate")
					shared.fireTo(
						ReplicateEffects_Set,
						{ enemyPlayer },
						{ "ShakeCamera", { Intensity = 9, Last = 0.2 } }
					)

					local orbCenter = HumRP.Position + Vector3.new(0, 40, 0) -- where the orb was
					local knockbackDir = (enemyHumRP.Position - orbCenter).Unit
					local flatDir = Vector3.new(knockbackDir.X, 0, knockbackDir.Z).Unit
					
					if EnemyCharacter:HasTag("Ragdolled") then
						RagdollHandler.cancelRagdoll(EnemyHumanoid)
					end
					
					DamageHandler:TakeDamage(Character, enemyHumanoid, MoveConfig.Damage.Final, nil, nil, false, false, true, true, true, nil, nil)
					CollisionsModule:SetCollisionGroup(enemyCharacter, "Players")

					NewKnockback:Knockback(
						enemyCharacter,
						{
							KnockbackType = "Velocity",
							MaxForce = Vector3.new(50000, 50000, 50000),
							Velocity = flatDir * 150 + Vector3.new(0, 0, 0),
						}
					)
					
					RagdollHandler.ragdoll(EnemyHumanoid, 4, false, nil, nil, nil, false)

					
					ReplicateEffects_Set:FireAllClients("collisionWall", {
						root = enemyHumRP,
						NoCrater = "regularSmokeSmash",
						hit = enemyCharacter,
						caller = Character,
						OnlyCheck = { workspace.World.Map }, --added
					})
				end
			end
		end)

		StartTrack.Stopped:Once(function()
			for enemyCharacter, data in pairs(enemyData) do
				releaseVictim(enemyCharacter, data)
			end
			
			for _, v in StartEvents do
				v:Disconnect()
			end
			
			if pullGrab ~= true then
				StunHandler:Unstun(Character, Stun)
			end
			iFramesService:RemoveAlliFrames(Character)
			Character:RemoveTag("CantRotate")

			Player:SetAttribute("ModeAbility", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("ModeAbility", false)
				end
			end)
		end)

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)

		Character:AddTag("CantRotate")

		RemotesContainer.ClientEffects:FireAllClients(
			"BlackBeardLiberation",
			{ Attacker = Character, SkillType = "LiberationTest2" }
		) -- also contains the rock pull in logic
		MainSound = SoundHandler:AddSound(MoveSounds.BlackBeard.Liberation.Main, HumRP)
		BlackholeMiddle = SoundHandler:AddSound(MoveSounds.BlackBeard.Liberation["Blackhole Sound Middle"], HumRP)
		KurozuLoop = SoundHandler:AddSound(MoveSounds.BlackBeard.G.KurozuLOOP, HumRP)

		task.delay(7, function()
			SoundHandler:AddSound(MoveSounds.BlackBeard.Liberation["Blackhole Close (Fixed)"], HumRP)
		end)
	end,
}
