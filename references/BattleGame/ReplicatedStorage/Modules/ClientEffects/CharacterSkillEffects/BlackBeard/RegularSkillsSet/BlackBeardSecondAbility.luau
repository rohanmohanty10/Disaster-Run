--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)
local RockHandler = require(ReplicatedStorage.Modules.ClientEffects.RockHandler)
local VoxelSerializer = require(ReplicatedStorage.Modules.VoxelSerializer)

return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType = argumentData.SkillType

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end

	local function applyFacingCFrame(sourceFolder, cloneFolder, facingCFrame)
		local rootPart = cloneFolder:FindFirstChildWhichIsA("BasePart", true)
		local rootCFrame = rootPart.CFrame
		for _, v in ipairs(cloneFolder:GetDescendants()) do
			if v:IsA("BasePart") then
				local relativeOffset = rootCFrame:ToObjectSpace(v.CFrame)
				v.CFrame = facingCFrame * relativeOffset
			end
		end
	end

	local function getFacingCFrame(torso, offset)
		local look = torso.CFrame.LookVector
		local flatLook = Vector3.new(look.X, 0, look.Z).Unit
		return CFrame.lookAt(torso.CFrame.Position, torso.CFrame.Position + flatLook) * (offset or CFrame.new())
	end

	if skillType == "start" then
		if EffectUtilities.CheckRenderDistance(attacker.HumanoidRootPart.CFrame, 700) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end
		local Torso = attacker:FindFirstChild("Torso")
		local Arm = attacker:FindFirstChild("Right Arm")

		local hole = script.Hole:Clone()

		hole.CFrame = hrp.CFrame * CFrame.new(0, -2.9, 0)

		hole.Parent = workspace.World.Visuals

		local desiredSize = hole.Size
		hole.Size = Vector3.new(0, 0, 0)
		hole.Transparency = 1

		local growInfo = TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		local growTween = TS:Create(hole, growInfo, { Size = desiredSize, Transparency = 0 })
		growTween:Play()

		local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		local holeGoals = { Size = Vector3.new(0, 0, 0), Transparency = 1 }
		local holeTween = TS:Create(hole, tweenInfo, holeGoals)
		task.delay(1.65, function()
			holeTween:Play()
		end)
		
		EffectUtilities.Emit(hole)
		Debris:AddItem(hole)

		local function getScaledSequence(originalSequence, factor)
			local keypoints = originalSequence.Keypoints
			local newKeypoints = {}

			for _, v in ipairs(keypoints) do
				-- Standard properties: Time, Value, Envelope
				table.insert(newKeypoints, NumberSequenceKeypoint.new(v.Time, v.Value * factor, v.Envelope * factor))
			end

			-- Safety: Ensure at least 2 keypoints exist
			if #newKeypoints == 1 then
				local kp = newKeypoints[1]
				newKeypoints = {
					NumberSequenceKeypoint.new(0, kp.Value, kp.Envelope),
					NumberSequenceKeypoint.new(1, kp.Value, kp.Envelope),
				}
			end

			return NumberSequence.new(newKeypoints)
		end

		local function expandAttachmentVFX(bhPart, duration, targetScale)
			local emitterData = {}

			-- 1. Target emitters ONLY inside the Attachments
			for _, child in ipairs(bhPart:GetChildren()) do
				if child:IsA("Attachment") then
					for _, emitter in ipairs(child:GetDescendants()) do
						if emitter:IsA("ParticleEmitter") then
							-- Store original sequence and immediately set size to near zero
							local original = emitter.Size
							emitter.Size = getScaledSequence(original, 0.05)

							table.insert(emitterData, {
								Instance = emitter,
								OriginalSize = original,
							})
						end
					end
				end
			end

			-- 2. Animate the growth from 0.05 to targetScale
			local startTime = os.clock()
			task.spawn(function()
				while os.clock() - startTime < duration do
					local elapsed = os.clock() - startTime
					local progress = math.min(elapsed / duration, 1)

					-- Cubic Out easing for an explosive expansion feel
					local easedProgress = 1 - math.pow(1 - progress, 3)
					local currentScale = 0.05 + ((targetScale - 0.05) * easedProgress)

					for _, data in ipairs(emitterData) do
						data.Instance.Size = getScaledSequence(data.OriginalSize, currentScale)
					end

					task.wait()
				end
			end)
		end

		local blackhole = script.blackhole:Clone()
		blackhole.Parent = workspace.World.Visuals
		Debris:AddItem(blackhole, 5)
		blackhole.CFrame = hrp.CFrame * CFrame.new(0, -2.1, 0) * CFrame.Angles(0, math.rad(90), math.rad(90))

		local GROW_DURATION = 0.7
		local FINAL_VFX_SIZE = 1 -- 4x larger than your original Studio size

		-- Start the expansion logic for Attachments
		--expandAttachmentVFX(blackhole, GROW_DURATION, FINAL_VFX_SIZE)

		-- Standard Emission
		EffectUtilities.Emit(blackhole)

		-- Part Tween (Visual floor hole)
		local growTween = TS:Create(blackhole, TweenInfo.new(GROW_DURATION, Enum.EasingStyle.Quad), {
			Size = blackhole.Size,
			Transparency = 1,
		})
		growTween:Play()

		local bHoleWweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		local bHoleGoals = { Size = Vector3.new(0, 0, 0), Transparency = 1 }
		local bHoleTween = TS:Create(blackhole, bHoleWweenInfo, bHoleGoals)
		task.delay(1, function()
			bHoleTween:Play()
		end)

		-- Crater/rock stuff
		local Position = (hrp.CFrame * CFrame.new(0, -2.64, 0)).Position
		local Direction = Vector3.yAxis * -5

		RockHandler.ExpandingCrater(Position, Direction, {
			Amount = 35,
			Distance = 17, -- the determined final radius it grows to
			LookAt = { Min = 14, Max = -14 },
			Exposure = { Min = 1, Max = 1.4 },
			BaseZ = 2.7,
			SizeMultiplier = 1.5,
			Timing = { Idle = { Min = 4, Max = 6 }, Out = { Min = 6, Max = 10 } },
		}, {
			GrowTime = 0.4, -- matches your hole's grow tween
			StartRadius = 4, -- starts as a 4-stud ring, expands out to Distance (16)
		})
		return
	end

	if skillType == "hit" then
		if EffectUtilities.CheckRenderDistance(attacker.HumanoidRootPart.CFrame, 200) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end
		
		local Torso = attacker:FindFirstChild("Torso")
		local Arm = attacker:FindFirstChild("Right Arm")

		local source = script.SpawnBallNew:Clone()
		source.CFrame = argumentData.Location
		source.Parent = workspace.World.Visuals

		task.delay(0.15, function()
			EffectUtilities.Emit(source)
			Debris:AddItem(source, 5)
		end)
		return
	end

	if skillType == "shards" then
		if EffectUtilities.CheckRenderDistance(attacker.HumanoidRootPart.CFrame, 700) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end
		local MapRayParams = RaycastParams.new()
		MapRayParams.FilterType = Enum.RaycastFilterType.Include
		MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
		MapRayParams.RespectCanCollide = true
		MapRayParams.IgnoreWater = true

		local spawnPos = argumentData.spawnPosition
		local index = argumentData.index
		local idxNum = tonumber(index)
		local hitRay = workspace:Raycast(spawnPos.Position, Vector3.new(-0, -30, -0), MapRayParams)
		local groundCFrame

		if hitRay then
			groundCFrame = CFrame.new(hitRay.Position)
		else
			groundCFrame = spawnPos
		end

		--playProjectileTrail(0.2, rootPart.CFrame, groundCFrame, idxNum, mod)
		task.wait(0.1)

		local SecondAbility = script

		if hitRay then
			local nRange = NumberRange.new
			local hitScale = idxNum / 1.6 -- Increased divisor to make base scale smaller
			local scaleMin = math.max(1, hitScale) * 1.5
			local scaleMax = math.max(1, idxNum / 1.6) * 4
			local scaleRange = nRange(scaleMin, scaleMax)
			local shakeChance = math.random(3, 10) / 10
			local smashCFrame = CFrame.new(
				hitRay.Position + Vector3.new(0, 2, 0),
				hitRay.Position + Vector3.new(0, 2, 0) - Vector3.new(0, 1, 0)
			)

			--if (CurrentCamera.CFrame.Position - spawnPos.Position).Magnitude < 60 or LocalCharacter == Character then
			--	shared.repfire("ShakeCamera", { Magnitude = 10, Roughness = 16, FadeInTime = 0, FadeOutTime = 0.35 })
			--end

			--local spikes = vfxAssets.Base["Thorny Release"].Spikes:Clone()
			--Debris:AddItem(spikes, 4)
			--spikes.CFrame = CFrame.new(hitRay.Position)
			--spikes.Parent = workspace.Thrown

			--task.delay(0.02, function()
			--	for _, part in spikes:GetDescendants() do
			--		--VFX_Utility_Black.emit_effect(part)
			--	end
			--end)

			--playMeshEmit(vfxAssets.Base["Thorny Release"].MeshFX.Spikes, CFrame.new(hitRay.Position))
			--local soundBase = sfxAssets.Base["Thorny Release"]
			--local soundIndex = idxNum - 1
			--SoundsModule:AddSound(soundBase[mod + math.max(soundIndex, 0)].Explode, spikes)

			task.delay(1.1, function()
				local SpikesVFX = SecondAbility.SpikesVFX:Clone()
				SpikesVFX.CFrame = spawnPos * CFrame.new(0, -6, 0)
				SpikesVFX.Parent = workspace.World.Visuals
				Debris:AddItem(SpikesVFX, 3)
				EffectUtilities.Emit(SpikesVFX)
			end)

			for i = -1, 1, 1.0 do -- Decrease for more shards, increasae for less. Its a grid.
				for j = -1, 1, 1.0 do
					local isCenter = Vector2.new(i, j).Magnitude == 0
					if isCenter or math.random(0, shakeChance * 10) / 10 ~= 0 then
						local distFromCenter = Vector2.new(i, j).Magnitude
						local mag
						if isCenter then
							mag = 1
						else
							mag = math.max(Vector2.new(-1, 1).Magnitude - distFromCenter, 0.5)
						end

						local scale = mag * math.max(1, idxNum / 1.4)
						local scale = mag * math.max(1, idxNum / 1.2)
						local hitPos = hitRay.Position
						local dX = i * math.random(scaleRange.Min, scaleRange.Max)
						local dZ = j * math.random(scaleRange.Min, scaleRange.Max)
						local shardHit =
							workspace:Raycast(hitPos + Vector3.new(dX, 5, dZ), Vector3.new(-0, -10, -0), MapRayParams)
						if shardHit then
							local shardCFrame = CFrame.new(shardHit.Position, shardHit.Position + shardHit.Normal)
								* CFrame.Angles(-1.5707963267948966, 0, 0)
							local allShards = SecondAbility.Spikes.ISpikes:GetChildren() -- Gets a table of all 10 shards
							local randomShard = allShards[math.random(1, #allShards)] -- Picks one at random
							local shard = randomShard:Clone()
							Debris:AddItem(shard, 5)
							local rotAmount = isCenter and 20 or 35
							shard.CFrame = shardCFrame
								* CFrame.Angles(
									math.rad(math.random(-rotAmount, rotAmount)),
									math.rad(math.random(-360, 360)),
									math.rad(math.random(-rotAmount, rotAmount))
								)
								* CFrame.new(0, -10, 0)

							task.spawn(function()
								local tweenTime = math.random(20, 30) / 100
								TS:Create(shard, TweenInfo.new(tweenTime), { CFrame = shardCFrame }):Play()
								task.delay(1, function()
									TS:Create(shard, TweenInfo.new(0.5), {
										CFrame = shardCFrame * CFrame.new(0, -10, 0),
										Size = Vector3.new(0, 0, 0),
									}):Play()
								end)
							end)
							shard.Size = shard.Size * scale
							shard.Parent = workspace.Thrown
						end
					end
				end
			end
		end
		return
	end

	if skillType == "bodyAura" then
		if EffectUtilities.CheckRenderDistance(attacker.HumanoidRootPart.CFrame, 200) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end
		local Torso = attacker:FindFirstChild("Torso") or attacker:FindFirstChild("HumanoidRootPart")
		local LeftArm = attacker:FindFirstChild("Left Arm")
		local LeftFlame = script.AuraStuff.LeftFlame
		local clone = LeftFlame:Clone()
		clone.CFrame = LeftArm.CFrame
		clone.Parent = workspace.World.Debris

		local weld = Instance.new("Weld")
		weld.Part0 = clone
		weld.Part1 = LeftArm
		weld.Parent = clone

		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v:Emit(v:GetAttribute("EmitCount"))

				task.spawn(function()
					v.Enabled = true
					task.wait(v:GetAttribute("EmitDuration"))
					v.Enabled = false
				end)
			end
		end
		Debris:AddItem(clone, 5)

		local RightArm = attacker:FindFirstChild("Right Arm")
		local RightFlame = script.AuraStuff.RightFlame
		local clone2 = RightFlame:Clone()
		clone2.CFrame = RightArm.CFrame
		clone2.Parent = workspace.World.Debris

		local weld2 = Instance.new("Weld")
		weld2.Part0 = clone2
		weld2.Part1 = RightArm
		weld2.Parent = clone2

		for _, v in ipairs(clone2:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v:Emit(v:GetAttribute("EmitCount"))

				task.spawn(function()
					v.Enabled = true
					task.wait(v:GetAttribute("EmitDuration"))
					v.Enabled = false
				end)
			end
		end

		Debris:AddItem(clone2, 5)

		local TorsoFlame = script.AuraStuff.TorsoFlame
		local clone3 = TorsoFlame:Clone()
		clone3.CFrame = Torso.CFrame
		clone3.Parent = workspace.World.Debris

		local weld3 = Instance.new("Weld")
		weld3.Part0 = clone3
		weld3.Part1 = Torso
		weld3.Parent = clone3

		for _, v in ipairs(clone3:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v:Emit(v:GetAttribute("EmitCount"))

				task.spawn(function()
					v.Enabled = true
					task.wait(v:GetAttribute("EmitDuration"))
					v.Enabled = false
				end)
			end
		end

		Debris:AddItem(clone3, 5)
		return
	end

	local function absorbVoxelList(voxelList, targetAttachment)
		if not voxelList or not targetAttachment then
			return
		end

		local WAVE_TIME = 0.30
		local PULL_ACCEL = 150
		local PROXIMITY_GAIN = 200
		local MAX_SPEED = 110
		local DAMPING = 1.4
		local SPIN_SPEED = 20
		local SHRINK_RADIUS = 6
		local CONSUME_RADIUS = 1.5
		local MAX_LIFETIME = 2.0
		local DISSOLVE_DELAY = 1.0
		local DISSOLVE_TIME = 0.6
		local MIN_SCALE = 0.03
		local MAX_PIECES = 80 -- tune on a weak device

		local center0 = targetAttachment.WorldPosition

		-- distance LOD: far viewers get a lighter (or no) effect
		local camera = workspace.CurrentCamera
		local camDist = (center0 - camera.CFrame.Position).Magnitude
		if camDist > 250 then
			return
		end
		local budget = if camDist > 100 then MAX_PIECES // 3 else MAX_PIECES

		-- entries are either snapshots ({CFrame, Size, Color, ...}) or real-part
		-- references ({Part = BasePart}) from special props like chairs and bushes
		local function sizeOf(vData)
			if vData.Piece ~= nil then
				return vData.Piece.Size
			end
			if vData.Part ~= nil then
				return (typeof(vData.Part) == "Instance" and vData.Part:IsA("BasePart")) and vData.Part.Size or Vector3.zero
			end
			return vData.Size
		end

		local function sourceCFrame(vData)
			if vData.Piece ~= nil then
				return vData.Piece.CFrame
			end
			if vData.Part ~= nil then
				return (typeof(vData.Part) == "Instance" and vData.Part:IsA("BasePart")) and vData.Part.CFrame or nil
			end
			return vData.CFrame
		end

		-- cap: keep the biggest voxels, drop the crumbs
		if #voxelList > budget then
			table.sort(voxelList, function(a, b)
				local sa, sb = sizeOf(a), sizeOf(b)
				return (sa.X * sa.Y * sa.Z) > (sb.X * sb.Y * sb.Z)
			end)
			voxelList = table.move(voxelList, 1, budget, 1, {})
		end

		local maxDist = 1
		for _, vData in voxelList do
			local cf = sourceCFrame(vData)
			local d = cf and (cf.Position - center0).Magnitude or 0
			if d > maxDist then
				maxDist = d
			end
		end

		-- spawn everything up front (as before) so there's no gap between the
		-- real voxels vanishing and the replicas appearing
		local active = {}
		local t0 = os.clock()
		for _, vData in voxelList do
			local piece
			if vData.Piece ~= nil then
				-- existing GlassFragment picked up nearby; absorb the real part directly
				piece = vData.Piece
			elseif vData.Part ~= nil then
				local src = vData.Part
				if not (typeof(src) == "Instance" and src:IsA("BasePart")) then
					continue -- destroyed/not replicated (e.g. streamed out); skip this entry
				end
				-- real-mesh mode: clone the hidden original so chairs/bushes keep their
				-- actual geometry and textures instead of becoming cubes; hideModel()
				-- saved the pre-hide transparency in __OrigTrans
				piece = src:Clone()
				-- __OrigTrans: SpecialDestruction/hideModel convention (trees, bushes).
				-- (shatterable windows, absorbed flings) — without this fallback glass
				-- windows clone fully opaque instead of see-through.
				piece.Transparency = piece:GetAttribute("__OrigTrans")
					or 0
				CollectionService:RemoveTag(piece, "WindShake")
				for _, d in piece:GetDescendants() do
					if d:IsA("BasePart") or d:IsA("Bone") then
						CollectionService:RemoveTag(d, "WindShake")
					elseif d:IsA("Texture") or d:IsA("Decal") then
						-- hideModel() hid these on the original too; unhide the copies
						local orig = d:GetAttribute("__OrigTrans")
						if orig ~= nil then
							d.Transparency = orig
						end
					end
				end
			else
				piece = Instance.new("Part")
				piece.CFrame, piece.Size, piece.Color, piece.Material =
					vData.CFrame, vData.Size, vData.Color, vData.Material
				-- without this, voxels from variant-textured parts (e.g. the white
				-- Plastic + FloorConcrete3 floor) replicate as plain white blocks
				piece.MaterialVariant = vData.MaterialVariant or ""
			end
			piece.Anchored = true -- stays anchored for its whole life (kinematic)
			piece.CanCollide, piece.CanQuery, piece.CanTouch = false, false, false
			piece.CastShadow = false
			piece.Parent = workspace.World.Debris

			local cf0 = piece.CFrame
			local dist = (cf0.Position - center0).Magnitude
			active[piece] = {
				cf = cf0, -- CHANGED: cached transform; the loop never reads the engine again
				vel = Vector3.zero,
				started = false,
				startAt = t0 + (dist / maxDist) * WAVE_TIME,
				offset = Vector3.new(math.random(-15, 15), math.random(-10, 10), math.random(-15, 15)) / 10,
				baseSize = piece.Size,
				baseTransparency = piece.Transparency,  -- fade blends from this, not from opaque
			}
			Debris:AddItem(piece, MAX_LIFETIME + 0.5)
		end

		local moveParts, moveCFs = {}, {} -- CHANGED: reused each frame for BulkMoveTo
		local conn
		conn = RunService.Heartbeat:Connect(function(dt)
			if not targetAttachment.Parent or os.clock() - t0 > MAX_LIFETIME then
				conn:Disconnect()
				for piece in active do
					if piece.Parent then
						piece:Destroy()
					end
				end
				return
			end

			table.clear(moveParts)
			table.clear(moveCFs)

			local center, now, remaining = targetAttachment.WorldPosition, os.clock(), 0

			for piece, data in active do
				if not piece.Parent then
					active[piece] = nil
					continue
				end
				remaining += 1
				if now < data.startAt then
					continue
				end

				local pos = data.cf.Position -- CHANGED: was piece.Position (engine read)

				if not data.started then
					data.started = true
					local toC = center - pos
					local nrm = toC.Magnitude > 0 and toC.Unit or Vector3.yAxis
					local tangent = nrm:Cross(Vector3.yAxis)
					tangent = tangent.Magnitude > 1e-3 and tangent.Unit or nrm:Cross(Vector3.xAxis).Unit
					data.vel = tangent * SPIN_SPEED

					local spin = Vector3.new(math.random(-16, 16), math.random(-16, 16), math.random(-16, 16))
					if spin.Magnitude < 1e-3 then
						spin = Vector3.yAxis * 8
					end
					data.spinAxis = spin.Unit
					data.spinRate = math.rad(spin.Magnitude * 4)
				end

				local offset = (center + data.offset) - pos
				local d = offset.Magnitude

				local kDist = 1
				if d < SHRINK_RADIUS then
					kDist = math.clamp(d / SHRINK_RADIUS, 0, 1)
					data.offset *= 0.9
				end

				local kTime = 1
				local age = now - data.startAt
				if age > DISSOLVE_DELAY then
					kTime = math.clamp(1 - (age - DISSOLVE_DELAY) / DISSOLVE_TIME, 0, 1)
				end

				local k = math.min(kDist, kTime)

				if d < CONSUME_RADIUS or k <= MIN_SCALE then
					piece:Destroy()
					active[piece] = nil
					continue
				end

				-- CHANGED: step the Size/Transparency writes instead of writing every
				-- frame once shrinking starts (property writes are the expensive part)
				if k < 1 and math.abs((data.lastScale or 1) - k) > 0.07 then
					data.lastScale = k
					piece.Size = data.baseSize * math.max(k, MIN_SCALE)
					-- blend from the piece's own base transparency so glass stays see-through
					local base = data.baseTransparency
					piece.Transparency = base + (1 - base) * (1 - k)
				end

				local accel = offset.Unit * (PULL_ACCEL + PROXIMITY_GAIN / math.max(d, 1))
				local vel = (data.vel + accel * dt) * (1 - DAMPING * dt)
				if vel.Magnitude > MAX_SPEED then
					vel = vel.Unit * MAX_SPEED
				end
				data.vel = vel

				-- CHANGED: integrate the cached cf and queue for one bulk move
				data.cf = (data.cf + vel * dt) * CFrame.fromAxisAngle(data.spinAxis, data.spinRate * dt)
				local n = #moveParts + 1
				moveParts[n] = piece
				moveCFs[n] = data.cf
			end

			if #moveParts > 0 then
				workspace:BulkMoveTo(moveParts, moveCFs, Enum.BulkMoveMode.FireCFrameChanged)
			end
			if remaining == 0 then
				conn:Disconnect()
			end
		end)
	end

	if skillType == "Voxels" then
		if EffectUtilities.CheckRenderDistance(attacker.HumanoidRootPart.CFrame, 400) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end
		-- CHANGED: specials (chairs, bushes...) join the absorb as {Part = ...}
		-- wrappers so the real-mesh branch clones them instead of just vanishing
		local list = {}
		-- new path: binary buffer (Ability2). fallback: raw table (legacy senders)
		if argumentData.voxelBuffer then
			for _, snap in VoxelSerializer.decode(argumentData.voxelBuffer) do
				table.insert(list, snap)
			end
		elseif argumentData.voxelList then
			for _, snap in argumentData.voxelList do
				table.insert(list, snap)
			end
		end
		if argumentData.specialParts then
			for _, part in argumentData.specialParts do
				if typeof(part) == "Instance" and part:IsA("BasePart") then
					table.insert(list, { Part = part })
				end
			end
		end
		if #list > 0 then
			absorbVoxelList(list, argumentData.targetAttachment)
		end

		-- Pick up the glass shards FractureGlass already scattered nearby. They are
		-- CLIENT-ONLY parts (RenderGlass builds them per-client in workspace.Terrain),
		-- so the server never saw them — grabbing them has to happen here. Small delay
		-- so this-absorb's shatter fragments have spawned before we scan.
		local targetAttachment = argumentData.targetAttachment
		if targetAttachment then
			task.delay(0.12, function()
				if not targetAttachment.Parent then
					return
				end
				local center = targetAttachment.WorldPosition
				local params = OverlapParams.new()
				params.FilterType = Enum.RaycastFilterType.Include
				params.FilterDescendantsInstances = { workspace.Terrain, workspace.World.Debris }
				local glassList = {}
				for _, frag in workspace:GetPartBoundsInBox(CFrame.new(center), Vector3.new(40, 20, 40), params) do
					if frag.Name == "GlassFragment" then
						table.insert(glassList, { Piece = frag })
					end
				end
				if #glassList > 0 then
					absorbVoxelList(glassList, targetAttachment)
				end
			end)
		end
		
		-- hide small debris rocks for the absorb's duration (they keep spawning, so one
		-- pass isn't enough). Kept separate from the one-shot glass pickup above.
		--if targetAttachment then
			
		--	local dp = OverlapParams.new()
		--	dp.FilterType = Enum.RaycastFilterType.Include
		--	dp.FilterDescendantsInstances = { workspace.World.Debris }
		--	for _, frag in workspace:GetPartBoundsInBox(CFrame.new(targetAttachment.WorldPosition), Vector3.new(40, 20, 40), dp) do
		--		if frag.Name == "Debris" then
		--			frag.Transparency = 1
		--		end
		--	end
		--end
		return
	end
end