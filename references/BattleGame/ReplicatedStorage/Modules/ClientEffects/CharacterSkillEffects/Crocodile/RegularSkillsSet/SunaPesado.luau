--WhiteBeard Railgun — CLIENT effects + flight physics.
--Studio location: mirror SanjiFlameShot, e.g.
--   ReplicatedStorage > Modules > ClientEffects > CharacterSkillEffects > WhiteBeard > <SkillSet> > WhiteBeardRailgun
--Dispatched by your ClientEffects handler:  ClientEffects:Fire...("WhiteBeardRailgun", data)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local LightningBolt = require(ReplicatedStorage.Modules.ClientEffects.LightningBolt)
--pcall(function() require(script.LightningBolt.LightningSparks) end)
--pcall(function() require(script.LightningBolt.LightningExplosion) end)

--------------------------------------------------------------------------------
-- Tuning
--------------------------------------------------------------------------------
local PURPLE = Color3.fromRGB(148, 121, 255)
local FLIGHT_SPEED = 20      -- drift speed while flying
local LAUNCH_UP = 80         -- upward pop when flight begins
local LEG_NAMES = { "Left Leg", "Right Leg" } -- R6

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
local function setEnabled(inst, on)
	for _, d in inst:GetDescendants() do
		if d:IsA("ParticleEmitter") or d:IsA("Beam") or d:IsA("Trail") then
			d.Enabled = on
		end
	end
end

-- Disable emitters, then destroy once the last live particle has expired.
local function fadeOutVFX(inst, extra)
	if not inst or not inst.Parent then return end
	setEnabled(inst, false)
	local longest = 0
	for _, d in inst:GetDescendants() do
		if d:IsA("ParticleEmitter") then
			longest = math.max(longest, d.Lifetime.Max)
		elseif d:IsA("Trail") then
			longest = math.max(longest, d.Lifetime)
		end
	end
	Debris:AddItem(inst, longest + (extra or 0.1))
end

local function emitAll(inst)
	for _, d in inst:GetDescendants() do
		if d:IsA("ParticleEmitter") then
			local count = d:GetAttribute("EmitCount") or (d.Rate > 0 and d.Rate) or 10
			d:Emit(count)
		end
	end
end

local function makeAttachment(cframe: CFrame): Attachment
	local a = Instance.new("Attachment")
	a.Parent = workspace.Terrain
	a.WorldCFrame = cframe
	Debris:AddItem(a, 5)
	return a
end

local function getControls()
	local pm = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
	return pm:GetControls()
end

local function effectsFolder()
	--return workspace:FindFirstChild("Effects") or workspace
	return workspace.World.Visuals

end

local function setLegs(character: Model, transparent: boolean)
	local FLIGHT_TWEEN_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	local goal = transparent and 1 or 0
	for _, name in LEG_NAMES do
		local leg = character:FindFirstChild(name)
		if leg then
			TweenService:Create(leg, FLIGHT_TWEEN_INFO, { Transparency = goal }):Play()
		end
	end
end



--------------------------------------------------------------------------------
-- FLIGHT (owner only).
--------------------------------------------------------------------------------
local currentSession = nil

local function beginFlight(duration: number?)
	local character = LocalPlayer.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not root then return end

	if currentSession then currentSession.stop() end
	
	local flyVFX = script.Fly.Main:Clone()
	flyVFX.Anchored = false          -- must be unanchored for the weld to move it
	flyVFX.CanCollide = false
	flyVFX.CanQuery = false
	flyVFX.CanTouch = false
	flyVFX.CastShadow = false
	flyVFX.Massless = true           -- keeps it out of the root's mass/physics budget
	flyVFX.CFrame = root.CFrame * CFrame.new(0, -1, 0)  -- set BEFORE welding
	flyVFX.Parent = workspace.World.Visuals

	local flyWeld = Instance.new("WeldConstraint")
	flyWeld.Part0 = root
	flyWeld.Part1 = flyVFX
	flyWeld.Parent = flyVFX
	
	local cloudVFX = script.Fly.Cloud:Clone()
	cloudVFX.Anchored = false          -- must be unanchored for the weld to move it
	cloudVFX.CanCollide = false
	cloudVFX.CanQuery = false
	cloudVFX.CanTouch = false
	cloudVFX.CastShadow = false
	cloudVFX.Massless = true           -- keeps it out of the root's mass/physics budget
	cloudVFX.CFrame = root.CFrame * CFrame.new(0, -2.4, 0)  -- set BEFORE welding
	cloudVFX.Parent = workspace.World.Visuals

	local cloudWeld = Instance.new("WeldConstraint")
	cloudWeld.Part0 = root
	cloudWeld.Part1 = cloudVFX
	cloudWeld.Parent = cloudVFX

	

	local bodyVel = Instance.new("BodyVelocity")
	bodyVel.Name = "RailgunFlight"
	bodyVel.MaxForce = Vector3.new(1e9, 1e9, 1e9)
	bodyVel.Velocity = Vector3.new(0, LAUNCH_UP, 0)
	bodyVel.Parent = root

	local bodyGyro = Instance.new("BodyGyro")
	bodyGyro.P = 100000
	bodyGyro.D = 2500
	bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
	bodyGyro.CFrame = workspace.CurrentCamera.CFrame
	bodyGyro.Parent = root

	humanoid.PlatformStand = true
	setLegs(character, true)

	local controls = getControls()
	local session = { active = true }
	currentSession = session

	local launchVel = LAUNCH_UP

	local conn = RunService.RenderStepped:Connect(function(dt)
		if not session.active or not bodyVel.Parent then return end
		local camera = workspace.CurrentCamera
		local mv = controls:GetMoveVector()
		local move = (camera.CFrame.LookVector * -mv.Z * 2 + camera.CFrame.RightVector * mv.X) * FLIGHT_SPEED
		bodyVel.Velocity = move + Vector3.new(0, launchVel, 0)
		launchVel = math.max(0, launchVel - dt * (LAUNCH_UP / 0.4))
		bodyGyro.CFrame = camera.CFrame
		humanoid.PlatformStand = true
	end)

	session.stop = function()
		if not session.active then return end
		session.active = false
		conn:Disconnect()
		if bodyVel then bodyVel:Destroy() end
		if bodyGyro then bodyGyro:Destroy() end
		fadeOutVFX(flyVFX, 0.25)
		--flyVFX = nil
		fadeOutVFX(cloudVFX, 0.25)
		--flyVFX = nil
		if humanoid then
			humanoid.PlatformStand = false
			humanoid.AutoRotate = true
		end
		setLegs(character, false)
		if currentSession == session then currentSession = nil end
	end

	task.delay((duration or 3.5) + 6, function()
		if currentSession == session then
			session.stop()
			setLegs(character, false)
			currentSession = nil
		end
	end)
end

local function endFlight()
	if currentSession and currentSession.active then
		currentSession.stop()
	end
end

local function landRestore()
	local character = LocalPlayer.Character
	if character then
		setLegs(character, false)
	end
	currentSession = nil
end

--------------------------------------------------------------------------------
-- CHARGE — faithful port of the Pesado hold (Part1 = start, Part2 = stop).
--------------------------------------------------------------------------------
local activeCharges: { [Model]: any } = {}

local function worldCF(inst): CFrame
	return inst:IsA("Attachment") and inst.WorldCFrame or inst.CFrame
end

-- Scale every emitter's Size/Speed by mult (was u23).
local function scaleEmitters(holder: Instance, mult: number)
	mult = mult or 1
	for _, e in holder:GetChildren() do
		if e:IsA("ParticleEmitter") then
			local keys = {}
			for _, k in e.Size.Keypoints do
				table.insert(keys, NumberSequenceKeypoint.new(k.Time, k.Value * mult))
			end
			e.Drag = e.Drag / mult
			e.Size = NumberSequence.new(keys)
			e.Speed = NumberRange.new(e.Speed.Min * mult, e.Speed.Max * mult)
		end
	end
end

local function emitClone(clone)
	for _, p:ParticleEmitter in ipairs(clone:GetDescendants()) do
		if not p:IsA("ParticleEmitter") then
			continue
		end

		local emitDelay = p:GetAttribute("EmitDelay") or 0
		local emitDuration = p:GetAttribute("EmitDuration") or 0
		local emitCount = p:GetAttribute("EmitCount") or 0

		task.spawn(function()
			if emitDelay > 0 then
				task.wait(emitDelay)
			end

			p:Emit(emitCount)
			if emitDuration > 0 then
				p.Enabled = true
				task.wait(emitDuration)
				p.Enabled = false
			end
		end)
	end
end

local function randomPurple()
	return Color3.fromRGB(
		math.random(148-15, 148+15),   -- R
		math.random(121-15, 121+15),    -- G
		math.random(255-15, 255)    -- B
	)
end
-- Faithful port of GPO's "Spheres" effect (spikes radiating from a point).
-- Needs script.sphere = a Part with a "Mesh" (SpecialMesh) child.
local function spawnSpheres(params)
	local cf = params.cf
	local part = params.part
	local range = params.range or 0
	local minThick = params.minThick or 1
	local maxThick = params.maxThick or 2
	local ti = params.ti or 0.1
	local ti2 = params.ti2 or ti
	local color = params.color or PURPLE
	local am = params.am or 1
	local startSize = params.startSize
	local xr, yr, zr = params.xrange, params.yrange, params.zrange
	local yMin
	if xr == nil then
		xr, yr, zr = range, range, range
	else
		yMin = yr / 10
	end

	local template = script:FindFirstChild("sphere")
	if not template then return end

	for _ = 1, am do
		local centerCF = (part and part.CFrame) or cf

		local spike = template:Clone()
		spike.Color = color
		local mesh = spike:FindFirstChild("Mesh")

		local offset = centerCF * CFrame.new(
			math.random(-xr, xr),
			math.random(yMin or -yr, yr),
			math.random(-zr, zr)
		)
		spike.CFrame = CFrame.new(centerCF.Position, offset.Position) * CFrame.Angles(math.pi / 2, 0, 0)

		local thickness = math.random(minThick, maxThick)
		local length = (offset.Position - centerCF.Position).Magnitude
		if startSize and mesh then mesh.Scale = startSize end
		spike.Parent = effectsFolder()

		TweenService:Create(spike, TweenInfo.new(ti, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			CFrame = CFrame.new(offset.Position, centerCF.Position) * CFrame.Angles(-math.pi / 2, 0, 0),
			Size = Vector3.new(0, 1, 0),
		}):Play()
		if mesh then
			TweenService:Create(mesh, TweenInfo.new(ti, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Scale = Vector3.new(thickness, length, thickness),
				Offset = Vector3.new(0, -length / 2, 0),
			}):Play()
		end

		task.spawn(function()
			task.wait(ti / 2)
			if mesh and mesh.Parent then
				TweenService:Create(mesh, TweenInfo.new(ti2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Scale = Vector3.new(0, 0, 0),
					Offset = Vector3.new(0, -length, 0),
				}):Play()
			end
		end)

		Debris:AddItem(spike, ti2 * 2 + ti)
	end
end


local function newStartCharge(character: Model)
	--if activeCharges[character] then return end

	local hand = character:FindFirstChild("Right Arm") -- R6
	local template = script.NewFx:FindFirstChild("SandBall")
	if not hand or not template then return end

	local swirl = template.swirl:Clone()
	local tornado = template.tornado:Clone()
	--local orb = hand:FindFirstChild("SandOrb") or template.orb:Clone()
	--local trail1 = hand:FindFirstChild("sandTrail1") or Instance.new("Attachment")
	--local trail2 = hand:FindFirstChild("sandTrail2") or Instance.new("Attachment")
	--trail1.Name = "sandTrail1"; trail1.Parent = hand; trail1.Position = Vector3.new(0, -1.7, 0)
	--trail2.Name = "sandTrail2"; trail2.Parent = hand; trail2.Position = Vector3.new(0, -1.175, 0)
	swirl.Parent = hand
	tornado.Parent = hand
	Debris:AddItem(swirl, 5)
	emitClone(swirl)
	Debris:AddItem(tornado, 5)
	emitClone(tornado)
	
	
	--local PURPLE = Color3.fromRGB(148, 121, 255)

	--local origin = workspace.Sand["My Desert Pesado"].TemplateR6["Right Arm"].swirl.WorldPosition
	task.spawn(function()
		for i = 1, 55 do -- .1 * 30 is 3 seconds.
			local origin = hand:FindFirstChild("RightGripAttachment").WorldPosition

			local function randomPurple()
				return Color3.fromRGB(
					math.random(148-15, 148+15),   -- R
					math.random(121-15, 121+15),    -- G
					math.random(255-15, 255)    -- B
				)
			end


			local base = origin + Vector3.new(0, 0, 0)
			local b0 = Instance.new("Attachment"); b0.Parent = workspace.Terrain; b0.WorldPosition = base
			local b1 = Instance.new("Attachment"); b1.Parent = workspace.Terrain; b1.WorldPosition = base + Vector3.new(math.random(-1,1), math.random(-1, 1), math.random(-1,1))
			game:GetService("Debris"):AddItem(b0, 1)
			game:GetService("Debris"):AddItem(b1, 1)
			local b = LightningBolt.new(b0, b1, 20)
			b.Color = randomPurple()
			b.PulseSpeed = math.random(15, 50)
			b.PulseLength = math.random(1, 2)
			b.FadeLength = 0.1
			b.Thickness = math.random(80, 200) / 500
			b.Frequency = math.random(10, 50) / 100
			b.MaxRadius = math.random(1, 3)
			task.wait(0.05)
		end
	end)
	--orb.Parent = hand

	--local trailFX = template.Trail:Clone()
	--trailFX.Parent = trail1
	--trailFX.Attachment0 = trail1
	--trailFX.Attachment1 = trail2
	--trailFX.Enabled = false

	--local record = { running = true, tornado = tornado, orb = orb, trail1 = trail1, trail2 = trail2, trailFX = trailFX }
	--activeCharges[character] = record

end

local function stopCharge(character: Model)
	local record = activeCharges[character]
	if not record then return end
	activeCharges[character] = nil
	record.running = false

	if record.tornado then
		local wcf = worldCF(record.tornado)
		record.tornado.Parent = workspace.Terrain
		if record.tornado:IsA("Attachment") then record.tornado.WorldCFrame = wcf end
		Debris:AddItem(record.tornado, 4)
	end
	if record.orb then Debris:AddItem(record.orb, 0.3) end
	if record.trailFX then record.trailFX.Enabled = false end
	if record.trail1 then Debris:AddItem(record.trail1, 3) end
	if record.trail2 then Debris:AddItem(record.trail2, 3) end
end


-- Animates a NumberSequence property from its current value toward a target,
-- by stepping through intermediate sequences. Blocks until done (call in a task.spawn).
--   startSeq   : the sequence to animate FROM (e.g. beam.Transparency right now)
--   targetSeq  : the sequence to animate TO
--   smoothness : steps per second (higher = smoother, more task.waits). e.g. 50
--   duration   : total time in seconds
--   object     : the instance whose property is being written
--   property   : the property name (string), e.g. "Transparency"
--   easingStyle, easingDir : optional Enum.EasingStyle / EasingDirection
local function TweenNumberSequence(startSeq, targetSeq, smoothness, duration, object, property, easingStyle, easingDir)
	assert(typeof(startSeq) == "NumberSequence", "Invalid startSeq")
	assert(typeof(targetSeq) == "NumberSequence", "Invalid targetSeq")
	assert(type(smoothness) == "number" and smoothness > 0, "Invalid smoothness")
	assert(type(duration) == "number" and duration > 0, "Invalid duration")
	assert(typeof(object[property]) == "userdata", "Invalid object/property")
	assert(type(property) == "string", "Invalid property name")

	easingStyle = easingStyle or Enum.EasingStyle.Linear
	easingDir = easingDir or Enum.EasingDirection.Out

	local targetKPs = targetSeq.Keypoints

	-- snapshot the start sequence's keypoints
	local times, values, envelopes = {}, {}, {}
	for _, kp in ipairs(startSeq.Keypoints) do
		table.insert(times, kp.Time)
		table.insert(values, kp.Value)
		table.insert(envelopes, kp.Envelope)
	end

	-- for each start-keypoint time, find the nearest target keypoint by time
	local function nearestTargetIndex(t)
		local bestDist = math.abs(t - targetKPs[1].Time)
		local bestIdx = 1
		for i, kp in ipairs(targetKPs) do
			local d = math.abs(t - kp.Time)
			if d < bestDist then
				bestDist = d
				bestIdx = i
			end
		end
		return bestIdx
	end

	-- build an interpolated sequence at fraction `alpha` (0 = start, 1 = target)
	local function buildAt(alpha)
		local kps = {}
		for i, t in ipairs(times) do
			local idx = nearestTargetIndex(t)
			local v = values[i]
			local e = envelopes[i]
			table.insert(kps, NumberSequenceKeypoint.new(
				t,
				v + (targetKPs[idx].Value - v) * alpha,
				e + (targetKPs[idx].Envelope - e) * alpha
				))
		end
		return NumberSequence.new(kps)
	end

	local steps = math.max(1, math.floor(smoothness * duration))
	for i = 0, steps do
		local alpha = TweenService:GetValue(i / steps, easingStyle, easingDir)
		object[property] = buildAt(alpha)
		task.wait(1 / smoothness)
	end

	-- snap exactly to target (value used for both value and envelope, matching original)
	local finalKPs = {}
	for _, t in ipairs(times) do
		local idx = nearestTargetIndex(t)
		local v = targetKPs[idx].Value
		table.insert(finalKPs, NumberSequenceKeypoint.new(t, v, v))
	end
	object[property] = NumberSequence.new(finalKPs)
end

local function playThrow(character: Model, Direction: Vector3)
	local arm = character:FindFirstChild("Right Arm")
	if not arm then return end
	
	local throwTemplate = script:FindFirstChild("NewFx").Throw:FindFirstChild("Lightning")
	if not throwTemplate then return end
		
	local center = CFrame.lookAt(arm.Position, arm.Position + Direction)

	local throw = throwTemplate:Clone()
	throw.CFrame = center * CFrame.new(2, 2.5, -2)
	throw.Parent = workspace.World.Visuals
	Debris:AddItem(throw, 10)
	emitClone(throw)
	
	local emit = script.NewFx.Throw.emit:Clone()
	emit.CFrame = center * CFrame.new(2, 2.5, -2) * CFrame.Angles(0, math.rad(180), 0)
	emit.Parent = workspace.World.Visuals
	Debris:AddItem(emit, 10)
	emitClone(emit)
	
	local ground = script.NewFx.Throw.ground:Clone()
	ground.CFrame = center * CFrame.new(2, 0, -2)  * CFrame.Angles(0, math.rad(180), 0)
	ground.Parent = workspace.World.Visuals
	Debris:AddItem(ground, 10)
	emitClone(ground)

	
	-- Wind + ring mesh burst
	local mesh = script.NewFx.mesh:Clone()
	mesh:PivotTo(center * CFrame.new(0, 0, 10))                 -- position the whole model at the throw point
	mesh.Parent = workspace.World.Visuals
	Debris:AddItem(mesh, 2)

	
	--local Wind = mesh:FindFirstChild("Wind")
	--if Wind then
	--	TweenService:Create(Wind, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
	--		Size = Vector3.new(50/2.5, 75/2.5, 50/2.5),
	--		CFrame = Wind.CFrame * CFrame.Angles(0, -2.0943951023931953, 0) * CFrame.new(0, -5, 0),
	--	}):Play()
	--	TweenService:Create(Wind, TweenInfo.new(0.15, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
	--		Transparency = 1,
	--	}):Play()
	--end
	local ring = mesh:FindFirstChild("ring")
	if ring then
		TweenService:Create(ring, TweenInfo.new(0.15, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
			Size = Vector3.new(22.5/1.2, 12.5/1.2, 22.5/1.2),
			Position = (ring.CFrame * CFrame.new(0, -5, 0)).Position,
		}):Play()
		TweenService:Create(ring, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
			Transparency = 1,
		}):Play()
	end
end
--------------------------------------------------------------------------------
-- IMPACT
--------------------------------------------------------------------------------

local function playNewImpact(position: Vector3, color: Color3)
	color = color or PURPLE
	local center = CFrame.new(position)

	local explosionTemplate = script:FindFirstChild("NewFx"):FindFirstChild("Explosion")
	if explosionTemplate then
		local explosion = explosionTemplate:Clone()
		explosion.CFrame = center
		explosion.Parent = workspace.World.Visuals
		Debris:AddItem(explosion, 10)
		
		emitClone(explosion)
	end
	
	task.wait(.9)
	
	-- Bubble
	local VFX = require(game.ReplicatedStorage.Modules.ClientEffects.G_VFX)
	local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)

	local Essentials = Essentials
	local Tween      = Essentials.Tween
	local container = Instance.new("Model")
	container.Parent = workspace.World.Visuals

	local highlight = Instance.new("Highlight")
	highlight.Enabled = false
	highlight.Parent = container

	local bubble = script.NewFx.Bubble:Clone()
	bubble.CFrame = center
	bubble.Size = Vector3.one * 30
	bubble.Parent = container

	TweenService:Create(bubble, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
		Size = Vector3.one * 175,
		Transparency = 1,
	}):Play()

	Essentials.Destroy(bubble, 0.2)
	Essentials.Destroy(container, 0.3)
	
	
	task.spawn(function()
		for _ = 1, 15 do
			local dir = center
				* CFrame.Angles(math.rad(math.random(-360, 360)), math.rad(math.random(-360, 360)), math.rad(math.random(-360, 360))) * CFrame.new(math.random(-5, 5), math.random(-2, 2), math.random(-5, 5))
			local base = makeAttachment(dir)
			local tip = makeAttachment(dir * CFrame.new(0, math.random(600, 1200) / 10, 0))
			local bolt = LightningBolt.new(base, tip, 15)
			bolt.Color = randomPurple()
			bolt.CurveSize0 = 0
			bolt.CurveSize1 = 0
			bolt.PulseSpeed = math.random(8, 12)
			bolt.PulseLength = math.random(3, 6)
			bolt.FadeLength = math.random(100, 200) / 1000
			bolt.Thickness = math.random(200, 400) / 100
			bolt.Frequency = math.random(1, 10) / 50
			bolt.MaxRadius = math.random(20, 80)
		end
	end)

	for i = 1, 2 do
		local ring = Instance.new("Part")
		ring.Shape = Enum.PartType.Cylinder
		ring.Anchored, ring.CanCollide, ring.CanQuery, ring.CastShadow = true, false, false, false
		ring.Material = Enum.Material.Neon
		ring.Color = color
		ring.Transparency = 0.2
		ring.Size = Vector3.new(0.4, 4, 4)
		ring.CFrame = center * CFrame.new(0, 1, 0) * CFrame.Angles(0, 0, math.rad(90))
		ring.Parent = workspace.World.Visuals
		local d = (120 + i * 40)
		TweenService:Create(ring, TweenInfo.new(0.45 + i * 0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			Size = Vector3.new(0.4, d, d),
			Transparency = 1,
		}):Play()
		Debris:AddItem(ring, 0.8)
	end

	local flash = Instance.new("Part")
	flash.Shape = Enum.PartType.Ball
	flash.Material = Enum.Material.Neon
	flash.Color = color
	flash.Size = Vector3.new(2, 2, 2)
	flash.Anchored, flash.CanCollide, flash.CanQuery, flash.CastShadow = true, false, false, false
	flash.CFrame = center
	flash.Parent = workspace.World.Visuals
	local light = Instance.new("PointLight")
	light.Color = color
	light.Brightness = 8
	light.Range = 40
	light.Parent = flash
	TweenService:Create(flash, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = Vector3.new(60, 60, 60),
		Transparency = 1,
	}):Play()
	TweenService:Create(light, TweenInfo.new(0.35), { Brightness = 0, Range = 120 }):Play()
	Debris:AddItem(flash, 0.4)

	local char = LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	--if hrp and (hrp.Position - position).Magnitude <= 90 then
	--	local lightingFolder = script:FindFirstChild("Lighting")
	--	local cc = lightingFolder and lightingFolder:FindFirstChild("PesadoCorrection")
	--	local blur = lightingFolder and lightingFolder:FindFirstChild("PesadoBlur")
	--	if cc and blur then
	--		cc = cc:Clone(); cc.Parent = game.Lighting
	--		blur = blur:Clone(); blur.Parent = game.Lighting
	--		TweenService:Create(cc, TweenInfo.new(0.2), { Brightness = 0.2, Contrast = 1, Saturation = -1 }):Play()
	--		TweenService:Create(blur, TweenInfo.new(0.3), { Size = 9 }):Play()
	--		task.wait(0.2)
	--		TweenService:Create(cc, TweenInfo.new(0.3), { Contrast = -0.45 }):Play()
	--		task.wait(1)
	--		TweenService:Create(cc, TweenInfo.new(1), { Brightness = 0, Contrast = 0, Saturation = 0 }):Play()
	--		TweenService:Create(blur, TweenInfo.new(1), { Size = 0 }):Play()
	--		Debris:AddItem(cc, 3)
	--		Debris:AddItem(blur, 3)
	--	end
	--end
	if hrp and (hrp.Position - position).Magnitude <= 100 then
		local lightingFolder = script:FindFirstChild("Lighting")
		local cc = lightingFolder and lightingFolder:FindFirstChild("PesadoCorrection")
		local blur = lightingFolder and lightingFolder:FindFirstChild("PesadoBlur")
		if cc and blur then
			cc = cc:Clone(); cc.Enabled = true; cc.Parent = game.Lighting
			blur = blur:Clone(); blur.Enabled = true; blur.Parent = game.Lighting

			-- Atmosphere is global and shared: use the existing one, capture originals, restore later.
			-- Only destroy it if we created it ourselves.
			local atmos = game.Lighting:FindFirstChildOfClass("Atmosphere")
			local atmosCreatedByUs = false
			if not atmos then
				atmos = Instance.new("Atmosphere")
				atmos.Parent = game.Lighting
				atmosCreatedByUs = true
			end
			local aHaze, aDensity, aColor = atmos.Haze, atmos.Density, atmos.Color

			task.spawn(function()
				-- impact: dust engulfs the screen
				TweenService:Create(cc, TweenInfo.new(0.15), {
					Brightness = 0.15,
					Contrast = 0.6,
					Saturation = -0.3,
					TintColor = Color3.fromRGB(220, 200, 160),
				}):Play()
				TweenService:Create(blur, TweenInfo.new(0.1), { Size = 14 }):Play()
				TweenService:Create(atmos, TweenInfo.new(0.2), {
					Haze = 8, Density = 0.5, Color = Color3.fromRGB(200, 180, 140),
				}):Play()

				task.wait(0.2)

				-- settle: contrast dips as dust hangs
				TweenService:Create(cc, TweenInfo.new(0.3), { Contrast = -0.25 }):Play()

				task.wait(1)

				-- recovery: clears slowly
				TweenService:Create(cc, TweenInfo.new(1.5), {
					Brightness = 0, Contrast = 0, Saturation = 0, TintColor = Color3.new(1, 1, 1),
				}):Play()
				TweenService:Create(blur, TweenInfo.new(1.5), { Size = 0 }):Play()
				TweenService:Create(atmos, TweenInfo.new(1.5), {
					Haze = aHaze, Density = aDensity, Color = aColor,
				}):Play()

				task.wait(3) --1.6

				if atmosCreatedByUs then
					atmos:Destroy()
				end
			end)

			Debris:AddItem(cc, 3)
			Debris:AddItem(blur, 3)
		end
	end
	
	shared.flyingdebris({
		position = position,
		Seed = math.random(1, 1000000),
		chunk = {
			amountRange = { 5, 7 },   -- default {3,5}; big ult wants a crowd
			sizeRange = { 4, 8  },       -- default {1,3}; visible boulders at ult scale
			spread = { -35, 35 },       -- default {-25,25}; wider scatter
			upward = { 25, 60 },        -- default {5,25}; launch high for a tall eruption
			speedMult = 2.5,            -- default 2; more force
			lifetime = 4,
			tweenTime = 1,
			jitter = 1.2,               -- staggers fade so they don't vanish together
			spin = true,                -- default false for chunks — turn ON, boulders should tumble
			spinTorque = 14000,          -- default is Roblox's 4000; more so they actually spin
		},
		--small = {
		--	amountRange = { 20, 30 },   -- default {4,7}; dense shard spray
		--	sizeRange = { 0.5, 1.0 },   -- default {0.6,0.8}; a touch bigger
		--	spread = { -45, 45 },       -- shards fly wider than chunks
		--	upward = { 20, 35 },
		--	speedMult = 2.2,
		--	lifetime = 2.5,
		--	jitter = 1,
		--	-- spin defaults to true for small — leave it
		--},
	})
end
--------------------------------------------------------------------------------
-- Dispatch
--------------------------------------------------------------------------------
return function(Data)
	local skill = Data.SkillType
	local character = Data.Char or Data.Attacker

	if skill == "flightStart" then
		beginFlight(Data.Duration)
	elseif skill == "flightEnd" then
		endFlight()
	elseif skill == "charge" then
		--if character then startCharge(character) end
	elseif skill == "chargeEnd" then
		--if character then stopCharge(character) end
	elseif skill == "reworkedImpact" then
		if Data.Position then playNewImpact(Data.Position, Data.Color) end
	elseif skill == "throw" then
		if character and Data.Direction then playThrow(character, Data.Direction) end
	elseif skill == "newCharge" then
		if character then newStartCharge(character) end
	end
end