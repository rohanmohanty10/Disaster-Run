--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)
local EffectBlood = require(ReplicatedStorage.Modules.ClientEffects.Blood)
local RockHandler = require(ReplicatedStorage.Modules.ClientEffects.RockHandler)

local VFX = require(game.ReplicatedStorage.Modules.ClientEffects.G_VFX)
local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)

local Essentials = Essentials
local Tween      = Essentials.Tween

return function(argumentData: any)
	local Attacker: Model = argumentData.Attacker
	local skillType = argumentData.SkillType

	local hrp = Attacker and Attacker:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

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
				NumberSequenceKeypoint.new(1, kp.Value, kp.Envelope)
			}
		end

		return NumberSequence.new(newKeypoints)
	end

	local function expandAttachmentVFX(bhPart, duration, targetScale, startScale)
		startScale = startScale or 0.05 -- defaults to original behavior if not provided
		local emitterData = {}

		for _, child in ipairs(bhPart:GetDescendants()) do
			if child:IsA("Attachment") then
				for _, emitter in ipairs(child:GetDescendants()) do
					if emitter:IsA("ParticleEmitter") then
						local original = emitter.Size

						-- Only reset size if starting from near-zero
						if startScale < 0.5 then
							emitter.Size = getScaledSequence(original, startScale)
						end

						table.insert(emitterData, {
							Instance = emitter,
							OriginalSize = original
						})
					end
				end
			end
		end

		local startTime = os.clock()
		task.spawn(function()
			while os.clock() - startTime < duration do
				local elapsed = os.clock() - startTime
				local progress = math.min(elapsed / duration, 1)
				local easedProgress = 1 - math.pow(1 - progress, 3)
				local currentScale = startScale + ((targetScale - startScale) * easedProgress)

				for _, data in ipairs(emitterData) do
					data.Instance.Size = getScaledSequence(data.OriginalSize, currentScale)
				end

				task.wait()
			end
		end)
	end

	local function shrinkAttachmentVFX(bhPart, duration, targetScale)
		local emitterData = {}

		for _, emitter in ipairs(bhPart:GetDescendants()) do 
			if emitter:IsA("ParticleEmitter") then
				local original = emitter.Size
				-- Don't touch size yet — start from original
				table.insert(emitterData, {
					Instance = emitter,
					OriginalSize = original
				})
			end
		end

		local startTime = os.clock()
		task.spawn(function()
			while os.clock() - startTime < duration do
				local elapsed = os.clock() - startTime
				local progress = math.min(elapsed / duration, 1)
				-- Cubic In easing — starts slow, accelerates into the shrink
				local easedProgress = progress * progress * progress
				local currentScale = 1 - ((1 - targetScale) * easedProgress)
				for _, data in ipairs(emitterData) do
					data.Instance.Size = getScaledSequence(data.OriginalSize, currentScale)
				end
				task.wait()
			end
			-- Ensure it lands exactly at targetScale
			for _, data in ipairs(emitterData) do
				data.Instance.Size = getScaledSequence(data.OriginalSize, targetScale)
			end
		end)
	end


	if skillType == "BlackHoleStart" then
		if EffectUtilities.CheckRenderDistance(Attacker.HumanoidRootPart.CFrame, 1000) == false then 
			return
		end
		local fakePartCFrame: CFrame = argumentData.PartCFrame

		local Torso = Attacker:FindFirstChild("Torso") or Attacker:FindFirstChild("HumanoidRootPart")
		local Arm = Attacker:FindFirstChild("Right Arm")
		local blackholeClone = script.NewBlackHole2:Clone()
		blackholeClone.CFrame = fakePartCFrame
		blackholeClone.Parent = workspace.World.Debris

		EffectUtilities.Emit(blackholeClone)
		Debris:AddItem(blackholeClone, 5)

		--local blackholeClone = script.NewBlackHole2:Clone()
		--blackholeClone.CFrame = fakePartCFrame
		--blackholeClone.Parent = workspace.World.Debris
		TS:Create(
			blackholeClone,
			TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{Transparency = 0}):Play()
		TS:Create(
			blackholeClone,
			TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
			{Size = Vector3.new(1.5, 1.5, 1.5)}
		):Play()


		task.delay(.9, function()
			--blackholeClone.Transparency = .5
			--local expandTween = TS:Create(
			--	blackholeClone,
			--	TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			--	{
			--		Size = Vector3.new(3, 3, 3), -- bigger than shrink size
			--		Color = Color3.new(1, 1, 1),   -- white
			--	}
			--)
			--expandTween:Play()
			--TS:Create(
			--	blackholeClone,
			--	TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
			--	{Size = Vector3.new(2, 2, 2)}
			--):Play()
			--blackholeClone:Destroy()
			TS:Create(
				blackholeClone,
				TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
				{Size = Vector3.new(0, 0, 0)}
			):Play()
		end)

		task.delay(.1, function()
			local startClock = os.clock()

			local container = Instance.new("Model")
			container.Parent = workspace.World.Visuals

			local highlight = Instance.new("Highlight")
			highlight.Enabled = false
			highlight.Parent  = container

			while os.clock() - startClock < .5 do
				local bubble = script.Bubble:Clone()
				bubble.CFrame = fakePartCFrame
				bubble.Size   = Vector3.new(40, 40, 40)
				bubble.Parent = container

				TS:Create(bubble, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
					Size         = Vector3.new(5, 5, 5),
					Transparency = 1,
				}):Play()

				Essentials.Destroy(bubble, 0.25)
				task.wait(0.2)
			end

			Essentials.Destroy(container, 0.35)
		end)
	end

	if skillType == "BlackHoleExplosion" then
		if EffectUtilities.CheckRenderDistance(Attacker.HumanoidRootPart.CFrame, 1000) == false then 
			return
		end
		local fakePart: BasePart = argumentData.Part
		local Position = (argumentData.Part.CFrame * CFrame.new(0, -5, 0)).Position
		local Direction = Vector3.yAxis * -5

		local Attachment = Instance.new("Attachment")
		Attachment.WorldPosition = Position
		Attachment.Parent = workspace.Terrain
		task.delay(3, Attachment.Destroy, Attachment)

		coroutine.wrap(RockHandler.Crater)(Position, Direction, {
			Amount = 14,
			Distance = 9,

			LookAt = {
				Min = -10,
				Max = -10
			},

			Exposure = {
				Min = 1,
				Max = 1.4
			},

			BaseZ = 2.7,
			SizeMultiplier = 1.6,
			CraterSmoke = false,
			CastShadow = false
		})

		coroutine.wrap(RockHandler.Crater)(Position, Direction, {
			Amount = 24,
			Distance = 15,

			LookAt = {
				Min = 14,
				Max = -14
			},

			Exposure = {
				Min = 1,
				Max = 1.4
			},
			BaseZ = 2.7,
			SizeMultiplier = 1.4,
			CraterSmoke = false,
			CastShadow = false
		})

		--coroutine.wrap(RockHandler.Rockst)(Position, Direction, {
		--	Count = 20,
		--	Size = {0.35, 0.9},
		--	Velocity = 30,
		--})

		--coroutine.wrap(RockHandler.Rockst)(Position, Direction, {
		--	Count = 5,
		--	Size = {2, 4},
		--	Velocity = 10,
		--})

	end

	if skillType == "FinisherBlackHole" then
		if EffectUtilities.CheckRenderDistance(Attacker.HumanoidRootPart.CFrame, 1000) == false then 
			return
		end
		local Hole = script.Hole:Clone()
		Hole.CFrame = hrp.CFrame * CFrame.new(0, -5, -8)
		Hole.Parent = workspace.World.Visuals

		task.spawn(function()
			local startClock = os.clock()

			local container = Instance.new("Model")
			container.Parent = workspace.World.Visuals

			local highlight = Instance.new("Highlight")
			highlight.Enabled = false
			highlight.Parent  = container

			while os.clock() - startClock < 3.8 do
				-- ramp the starting size from 20 -> 40 over the first second
				local t = math.clamp((os.clock() - startClock) / .7, 0, 1) -- Change the first 1 to any number for the time it takes for growing to 50.
				local startSize = 20 + (50 - 20) * t

				local bubble = script.Bubble:Clone()
				bubble.CFrame = Hole.CFrame
				bubble.Size   = Vector3.new(startSize, startSize, startSize)
				bubble.Parent = container

				-- still pulses inward to 5
				TS:Create(bubble, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
					Size         = Vector3.new(5, 5, 5),
					Transparency = 1,
				}):Play()

				Essentials.Destroy(bubble, 0.25)
				task.wait(0.15)
			end

			Essentials.Destroy(container, 0.35)
		end)

		task.wait(1)

		expandAttachmentVFX(Hole, 1.5, 1.5, 1)
		task.wait(2.5)

		-- Shrink back down before disabling
		shrinkAttachmentVFX(Hole, 0.5, 0.05)
		task.spawn(function()
			TS:Create(Hole, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Transparency = 1}):Play()
		end)
		task.wait(0.5)

		EffectUtilities.ToggleVFX(Hole, false)
		Debris:AddItem(Hole, 1)
	end

	if skillType == "FinisherBlackHoleExplode" then
		--if EffectUtilities.CheckRenderDistance(Attacker.HumanoidRootPart.CFrame, 500) == false then 
		--	return
		--end
		--local victim = argumentData.Victim
		--EffectBlood.Explode(victim.HumanoidRootPart)
		
		local victim = argumentData.Victim
		if not victim or not victim:FindFirstChild("HumanoidRootPart") then return end

		EffectBlood.ExplodeGore(victim.HumanoidRootPart, {
			Sounds = {
				ReplicatedStorage.Assets.Sounds.Gore.GoreExplode1,
				ReplicatedStorage.Assets.Sounds.Gore.GoreExplode2,
				ReplicatedStorage.Assets.Sounds.Characters.BlackBeard.BlackBallExplosion.Liger_Bomb_Crater,
			},
		})
		
	end

	local function Absorb(voxelList, targetAttachment, opts)
		if not voxelList or not targetAttachment then return end
		opts = opts or {}

		local WAVE_TIME      = opts.WaveTime      or 0.5
		local PULL_ACCEL     = opts.PullAccel     or 35    -- ↓ gentler inward pull, so spin dominates over diving in
		local PROXIMITY_GAIN = opts.ProximityGain or 90    -- ↓ softer final yank so they aren't snapped into the core
		local MAX_SPEED      = opts.MaxSpeed      or 120   -- ↑ lets them whip around faster as they tighten in
		local DAMPING        = opts.Damping       or 0.6   -- ↓↓ KEY: low damping = the orbit doesn't get braked away
		local SPIN_SPEED     = opts.SpinSpeed     or 40    -- ↑↑ KEY: much more orbital (sideways) velocity
		local CONSUME_RADIUS = opts.ConsumeRadius or 1     -- ↓ must get very close to be eaten, so near passes keep circling
		local MAX_LIFETIME   = opts.MaxLifetime   or 4     -- ↑ KEY: time to complete several orbits before it dissolves
		local TUMBLE         = opts.Tumble        or 24    -- a bit more per-piece tumble for flair
		local MIN_SCALE      = opts.MinScale      or 0.03

		local PARENT         = opts.Parent        or workspace.World.Debris

		local center0 = targetAttachment.WorldPosition
		local maxDist = 1
		for _, vData in voxelList do
			local d = (vData.CFrame.Position - center0).Magnitude
			if d > maxDist then maxDist = d end
		end

		local active = {}
		local t0 = os.clock()
		for _, vData in voxelList do
			local piece = Instance.new("Part")
			piece.Anchored = true
			piece.CanCollide, piece.CanQuery, piece.CanTouch = false, false, false
			piece.Massless, piece.CastShadow = true, false
			piece.CFrame, piece.Size, piece.Color, piece.Material = vData.CFrame, vData.Size, vData.Color, vData.Material
			-- without this, voxels from variant-textured parts (e.g. the white
			-- Plastic + FloorConcrete3 floor) rebuild as plain white blocks
			piece.MaterialVariant = vData.MaterialVariant or ""
			piece.Parent = PARENT

			local dist = (vData.CFrame.Position - center0).Magnitude
			active[piece] = {
				vel = Vector3.zero, started = false,
				startAt = t0 + (dist / maxDist) * WAVE_TIME,
				offset  = Vector3.new(math.random(-15,15), math.random(-10,10), math.random(-15,15)) / 10,
				baseSize  = vData.Size,
				startDist = math.max(dist, 1),
				shrink    = 1,
			}
			Debris:AddItem(piece, MAX_LIFETIME + 1)
		end

		local conn
		conn = RunService.Heartbeat:Connect(function(dt)
			if not targetAttachment.Parent or os.clock() - t0 > MAX_LIFETIME then
				conn:Disconnect()
				for piece in active do if piece.Parent then piece:Destroy() end end
				return
			end

			local center, now, remaining = targetAttachment.WorldPosition, os.clock(), 0
			for piece, data in active do
				if not piece.Parent then active[piece] = nil continue end
				remaining += 1
				if now < data.startAt then continue end

				if not data.started then
					data.started = true
					-- kinematic: stays anchored for its whole life; tumble is integrated
					-- manually instead of handing the part to the physics engine
					local spin = Vector3.new(
						(math.random() * 2 - 1) * TUMBLE,
						(math.random() * 2 - 1) * TUMBLE,
						(math.random() * 2 - 1) * TUMBLE
					)
					if spin.Magnitude < 1e-3 then
						spin = Vector3.yAxis * TUMBLE
					end
					data.spinAxis = spin.Unit
					data.spinRate = spin.Magnitude
					local toC = center - piece.Position
					local nrm = toC.Magnitude > 0 and toC.Unit or Vector3.yAxis
					local tangent = nrm:Cross(Vector3.yAxis)
					tangent = tangent.Magnitude > 1e-3 and tangent.Unit or nrm:Cross(Vector3.xAxis).Unit
					data.vel = tangent * SPIN_SPEED
				end

				local offset = (center + data.offset) - piece.Position
				local d = offset.Magnitude

				-- Continuous shrink: smaller as it nears the core OR as its time runs out — never grows back.
				local kDist = math.clamp(d / data.startDist, 0, 1)
				local kTime = math.clamp(1 - (now - data.startAt) / (MAX_LIFETIME * 0.9), 0, 1)
				local k = math.min(data.shrink, kDist, kTime)
				data.shrink = k
				piece.Size = data.baseSize * math.max(k, MIN_SCALE)
				piece.Transparency = 1 - k
				data.offset *= 0.96

				if d < CONSUME_RADIUS or k <= MIN_SCALE then piece:Destroy() active[piece] = nil continue end

				local accel = offset.Unit * (PULL_ACCEL + PROXIMITY_GAIN / math.max(d, 1))
				local vel = (data.vel + accel * dt) * (1 - DAMPING * dt)
				if vel.Magnitude > MAX_SPEED then vel = vel.Unit * MAX_SPEED end
				data.vel = vel
				-- kinematic move: integrate position + spin ourselves, no physics engine
				piece.CFrame = (piece.CFrame + vel * dt)
					* CFrame.fromAxisAngle(data.spinAxis, data.spinRate * dt)
			end

			if remaining == 0 then conn:Disconnect() end
		end)
	end

	if skillType == "Voxels" then
		if EffectUtilities.CheckRenderDistance(Attacker.HumanoidRootPart.CFrame, 800) == false then 
			return
		end
		Absorb(argumentData.voxelList, argumentData.targetAttachment)              -- skill 1 (defaults)
	end
end