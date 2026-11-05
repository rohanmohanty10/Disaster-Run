--!strict
-- Signature visuals for the Thunder God and Gravity Lord kits (original effects, built from
-- parts, particles and lights so they need no imported assets). FxController calls these with
-- the same info it receives from the server; each returns true if it handled the effect.
--
--   Lightning Dragon  — a serpent of light snakes down the line, crackling, then bursts
--   Lightning Wrath   — a storm cloud gathers over the area; jagged bolts crash out of it
--   Raigo             — a crackling storm sphere sinks onto the target while charging, then detonates
--   Meteor Strike     — a burning meteor streaks in at an angle, landing exactly on impact
--   Meteor Fury       — a shower of smaller meteors following the God's aim
--   Gravity Dominance — a violet pressure dome with crushing rings; screen pressure for Runners inside

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local SkillFx = {}

local LIGHTNING = Color3.fromRGB(255, 240, 120)
local LIGHTNING_CORE = Color3.fromRGB(255, 255, 230)
local STORM = Color3.fromRGB(35, 40, 70)
local METEOR = Color3.fromRGB(255, 120, 40)
local GRAVITY = Color3.fromRGB(150, 90, 255)

local folder: Instance = workspace

function SkillFx.SetFolder(target: Instance)
	folder = target
end

local function part(props: { [string]: any }): Part
	local p = Instance.new("Part")
	p.Anchored = true
	p.CanCollide = false
	p.CanQuery = false
	p.CanTouch = false
	p.CastShadow = false
	p.Material = Enum.Material.Neon
	for key, value in props do
		(p :: any)[key] = value
	end
	p.Parent = folder
	return p
end

local function fade(instance: Instance, time: number, props: { [string]: any }, destroyAfter: number?)
	TweenService:Create(instance, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
	Debris:AddItem(instance, destroyAfter or time + 0.05)
end

local function light(parent: Instance, color: Color3, range: number, brightness: number): PointLight
	local l = Instance.new("PointLight")
	l.Color = color
	l.Range = range
	l.Brightness = brightness
	l.Parent = parent
	return l
end

local function particles(parent: Instance, props: { [string]: any }): ParticleEmitter
	local emitter = Instance.new("ParticleEmitter")
	emitter.LightEmission = 1
	emitter.Rate = 0
	for key, value in props do
		(emitter :: any)[key] = value
	end
	emitter.Parent = parent
	return emitter
end

-- A jagged bolt between two points, made of short neon segments.
local function bolt(from: Vector3, to: Vector3, color: Color3, thickness: number, segments: number, life: number)
	local points = { from }
	local rng = Random.new()
	local direction = to - from
	local length = direction.Magnitude
	local side = direction:Cross(Vector3.yAxis)
	if side.Magnitude < 0.01 then
		side = Vector3.xAxis
	end
	side = side.Unit
	local up = side:Cross(direction.Unit)
	for i = 1, segments - 1 do
		local t = i / segments
		local jitter = length * 0.08 * math.sin(t * math.pi)
		table.insert(points, from + direction * t + side * rng:NextNumber(-jitter, jitter) + up * rng:NextNumber(-jitter, jitter))
	end
	table.insert(points, to)
	for i = 1, #points - 1 do
		local a, b = points[i], points[i + 1]
		local segmentLength = (b - a).Magnitude
		local seg = part({
			Size = Vector3.new(thickness, thickness, segmentLength),
			CFrame = CFrame.lookAt(a, b) * CFrame.new(0, 0, -segmentLength / 2),
			Color = color,
			Transparency = 0,
		})
		fade(seg, life, { Transparency = 1, Size = Vector3.new(thickness * 0.3, thickness * 0.3, segmentLength) })
	end
end

local function flash(position: Vector3, color: Color3, size: number, life: number)
	local ball = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * size * 0.4, Position = position, Color = color, Transparency = 0.05 })
	light(ball, color, size * 2, 6)
	fade(ball, life, { Size = Vector3.one * size, Transparency = 1 })
end

local function groundRing(position: Vector3, color: Color3, radius: number, life: number)
	local ring = part({
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(0.4, 2, 2),
		CFrame = CFrame.new(position + Vector3.new(0, 0.3, 0)) * CFrame.Angles(0, 0, math.rad(90)),
		Color = color,
		Transparency = 0.15,
	})
	fade(ring, life, { Size = Vector3.new(0.2, radius * 2, radius * 2), Transparency = 1 })
end

local function shakeNear(position: Vector3, strength: number)
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = humanoid and humanoid.RootPart
	if not humanoid or not root or LocalPlayer:GetAttribute("Role") == "God" then
		return
	end
	local distance = (root.Position - position).Magnitude
	if distance > 90 then
		return
	end
	local power = strength * (1 - distance / 90)
	task.spawn(function()
		local base = humanoid.CameraOffset
		for i = 1, 12 do
			local decay = 1 - i / 12
			humanoid.CameraOffset = base + Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10)) / 10 * power * decay
			task.wait(0.03)
		end
		humanoid.CameraOffset = base
	end)
end

-- ------------------------------------------------------------------ Thunder God
local function lightningDragon(info: { [string]: any })
	local cf: CFrame = info.CFrame
	local length = tonumber(info.Length) or 80
	local start = cf.Position + Vector3.new(0, 4, 0)
	local forward = cf.LookVector
	local right = cf.RightVector
	local segmentCount = 16
	local travel = 0.45
	local body: { Part } = {}
	for i = 1, segmentCount do
		local size = if i == 1 then 4.5 else 3.2 - i * 0.12
		local seg = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * math.max(size, 1), Position = start, Color = if i == 1 then LIGHTNING_CORE else LIGHTNING, Transparency = 0.1 })
		if i == 1 then
			light(seg, LIGHTNING, 30, 5)
		end
		body[i] = seg
	end
	local started = os.clock()
	local connection: RBXScriptConnection
	connection = RunService.Heartbeat:Connect(function()
		local elapsed = os.clock() - started
		for i, seg in body do
			-- Each segment trails the head; the body weaves side to side like a serpent.
			local t = math.clamp((elapsed - i * 0.025) / travel, 0, 1)
			local wave = math.sin(t * math.pi * 3 + i * 0.5) * 4 * (1 - t * 0.5)
			local lift = math.sin(t * math.pi) * 3
			seg.Position = start + forward * length * t + right * wave + Vector3.new(0, lift, 0)
		end
		if math.random() < 0.5 then
			local a = body[math.random(1, segmentCount - 1)]
			local b = body[math.random(1, segmentCount - 1)]
			bolt(a.Position, b.Position, LIGHTNING_CORE, 0.25, 4, 0.12)
		end
		if elapsed > travel + segmentCount * 0.025 then
			connection:Disconnect()
			local head = body[1].Position
			flash(head, LIGHTNING, 16, 0.4)
			for _ = 1, 6 do
				local offset = Vector3.new(math.random(-10, 10), math.random(-2, 6), math.random(-10, 10))
				bolt(head, head + offset, LIGHTNING_CORE, 0.35, 4, 0.2)
			end
			for _, seg in body do
				fade(seg, 0.25, { Transparency = 1, Size = seg.Size * 0.3 })
			end
		end
	end)
end

local function stormCloud(center: Vector3, radius: number, duration: number)
	local cloud = part({
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(6, radius * 2.2, radius * 2.2),
		CFrame = CFrame.new(center + Vector3.new(0, 70, 0)) * CFrame.Angles(0, 0, math.rad(90)),
		Color = STORM,
		Material = Enum.Material.SmoothPlastic,
		Transparency = 1,
	})
	local emitter = particles(cloud, {
		Color = ColorSequence.new(Color3.fromRGB(60, 65, 95)),
		LightEmission = 0,
		Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 8), NumberSequenceKeypoint.new(1, 14) }),
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3, 0.4), NumberSequenceKeypoint.new(1, 1) }),
		Lifetime = NumberRange.new(1.5, 2.5),
		Speed = NumberRange.new(1, 3),
		SpreadAngle = Vector2.new(180, 180),
		Rate = 40,
	})
	TweenService:Create(cloud, TweenInfo.new(0.6), { Transparency = 0.35 }):Play()
	task.delay(duration, function()
		emitter.Enabled = false
		fade(cloud, 0.8, { Transparency = 1 }, 2.5)
	end)
end

local function wrathBolt(position: Vector3)
	local top = position + Vector3.new(math.random(-6, 6), 70, math.random(-6, 6))
	bolt(top, position, LIGHTNING, 1.1, 9, 0.25)
	bolt(top, position, LIGHTNING_CORE, 0.45, 9, 0.18)
	flash(position + Vector3.new(0, 1, 0), LIGHTNING, 9, 0.3)
	groundRing(position, LIGHTNING, 7, 0.4)
end

local function raigoSphere(center: Vector3, radius: number, duration: number)
	local sphere = part({
		Shape = Enum.PartType.Ball,
		Size = Vector3.one * radius * 1.6,
		Position = center + Vector3.new(0, 90, 0),
		Color = STORM,
		Material = Enum.Material.ForceField,
		Transparency = 0.2,
	})
	local core = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * radius * 0.6, Position = sphere.Position, Color = Color3.fromRGB(120, 140, 255), Transparency = 0.3 })
	light(core, Color3.fromRGB(140, 160, 255), radius * 3, 4)
	TweenService:Create(sphere, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = center + Vector3.new(0, radius * 0.5, 0) }):Play()
	TweenService:Create(core, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = center + Vector3.new(0, radius * 0.5, 0) }):Play()
	task.spawn(function()
		local started = os.clock()
		while os.clock() - started < duration do
			local p = sphere.Position
			local offset = Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10)).Unit * radius * 0.8
			bolt(p, p + offset, LIGHTNING_CORE, 0.4, 5, 0.12)
			task.wait(0.06)
		end
		Debris:AddItem(sphere, 0.05)
		Debris:AddItem(core, 0.05)
	end)
end

local function raigoBlast(center: Vector3, radius: number)
	flash(center + Vector3.new(0, 4, 0), Color3.fromRGB(200, 210, 255), radius * 2.4, 0.6)
	groundRing(center, LIGHTNING, radius * 1.3, 0.7)
	groundRing(center, Color3.fromRGB(140, 160, 255), radius, 0.9)
	for _ = 1, 14 do
		local angle = math.random() * math.pi * 2
		local reach = radius * (0.6 + math.random() * 0.6)
		bolt(center + Vector3.new(0, 3, 0), center + Vector3.new(math.cos(angle) * reach, math.random(0, 6), math.sin(angle) * reach), LIGHTNING_CORE, 0.6, 7, 0.3)
	end
	local exposure = Instance.new("ColorCorrectionEffect")
	exposure.Brightness = 0.4
	exposure.TintColor = Color3.fromRGB(220, 225, 255)
	exposure.Parent = Lighting
	fade(exposure, 0.5, { Brightness = 0, TintColor = Color3.new(1, 1, 1) })
	shakeNear(center, 3)
end

-- ------------------------------------------------------------------ Gravity Lord
local function meteorFall(target: Vector3, size: number, duration: number)
	local from = target + Vector3.new(-90, 160, 60)
	local rock = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * size, Position = from, Color = Color3.fromRGB(70, 50, 40), Material = Enum.Material.Basalt })
	local shell = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * size * 1.25, Position = from, Color = METEOR, Transparency = 0.45 })
	light(shell, METEOR, size * 6, 5)
	local fire = Instance.new("Fire")
	fire.Size = size * 1.5
	fire.Heat = 20
	fire.Color = METEOR
	fire.SecondaryColor = Color3.fromRGB(255, 220, 120)
	fire.Parent = rock
	local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
	a0.Position = Vector3.new(0, size * 0.4, 0)
	a1.Position = Vector3.new(0, -size * 0.4, 0)
	a0.Parent = shell
	a1.Parent = shell
	local trail = Instance.new("Trail")
	trail.Attachment0 = a0
	trail.Attachment1 = a1
	trail.Lifetime = 0.5
	trail.Color = ColorSequence.new(METEOR, Color3.fromRGB(255, 220, 120))
	trail.Transparency = NumberSequence.new(0.2, 1)
	trail.LightEmission = 1
	trail.Parent = shell
	TweenService:Create(rock, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = target }):Play()
	TweenService:Create(shell, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = target }):Play()
	Debris:AddItem(rock, duration + 0.05)
	Debris:AddItem(shell, duration + 0.05)
end

local function meteorImpact(center: Vector3, radius: number, big: boolean)
	flash(center + Vector3.new(0, 2, 0), METEOR, radius * 1.4, 0.45)
	groundRing(center, METEOR, radius * 1.2, 0.6)
	-- Crater rim: a dark ring that lingers.
	local crater = part({
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(0.3, radius * 1.4, radius * 1.4),
		CFrame = CFrame.new(center + Vector3.new(0, 0.2, 0)) * CFrame.Angles(0, 0, math.rad(90)),
		Color = Color3.fromRGB(40, 30, 25),
		Material = Enum.Material.Basalt,
		Transparency = 0.1,
	})
	task.delay(4, function()
		fade(crater, 1.5, { Transparency = 1 })
	end)
	-- Flying debris.
	for _ = 1, if big then 14 else 6 do
		local chunk = Instance.new("Part")
		chunk.Size = Vector3.new(math.random(10, 25) / 10, math.random(10, 25) / 10, math.random(10, 25) / 10)
		chunk.Position = center + Vector3.new(math.random(-3, 3), 2, math.random(-3, 3))
		chunk.Color = Color3.fromRGB(90, 70, 60)
		chunk.Material = Enum.Material.Basalt
		chunk.CanCollide = false
		chunk.CanQuery = false
		chunk.CanTouch = false
		chunk.Parent = folder
		chunk.AssemblyLinearVelocity = Vector3.new(math.random(-40, 40), math.random(30, 70), math.random(-40, 40))
		Debris:AddItem(chunk, 2.5)
	end
	local dust = part({ Size = Vector3.one * 0.2, Transparency = 1, Position = center + Vector3.new(0, 1, 0) })
	local emitter = particles(dust, {
		Color = ColorSequence.new(Color3.fromRGB(150, 130, 110)),
		LightEmission = 0,
		Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 4), NumberSequenceKeypoint.new(1, 10) }),
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1) }),
		Lifetime = NumberRange.new(1, 1.8),
		Speed = NumberRange.new(10, 25),
		SpreadAngle = Vector2.new(180, 30),
	})
	emitter:Emit(if big then 40 else 15)
	Debris:AddItem(dust, 2)
	shakeNear(center, if big then 3 else 1.5)
end

local function gravityDome(center: Vector3, radius: number, duration: number)
	local dome = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * 2, Position = center, Color = GRAVITY, Material = Enum.Material.ForceField, Transparency = 0.3 })
	TweenService:Create(dome, TweenInfo.new(0.35, Enum.EasingStyle.Back), { Size = Vector3.one * radius * 2 }):Play()
	light(dome, GRAVITY, radius * 2, 3)
	task.spawn(function()
		local started = os.clock()
		while os.clock() - started < duration do
			-- Rings fall from above and crush into the ground.
			local ring = part({
				Shape = Enum.PartType.Cylinder,
				Size = Vector3.new(0.4, radius * 2, radius * 2),
				CFrame = CFrame.new(center + Vector3.new(0, radius, 0)) * CFrame.Angles(0, 0, math.rad(90)),
				Color = GRAVITY,
				Transparency = 0.4,
			})
			TweenService:Create(ring, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { CFrame = CFrame.new(center + Vector3.new(0, 0.3, 0)) * CFrame.Angles(0, 0, math.rad(90)), Transparency = 0.9 }):Play()
			Debris:AddItem(ring, 0.5)
			task.wait(0.3)
		end
		fade(dome, 0.4, { Transparency = 1, Size = Vector3.one * radius * 2.3 })
	end)

	-- Screen pressure for the local Runner while inside.
	local character = LocalPlayer.Character
	local root = character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if root and LocalPlayer:GetAttribute("Role") == "Runner" and ((root.Position - center) * Vector3.new(1, 0, 1)).Magnitude <= radius then
		local tint = Instance.new("ColorCorrectionEffect")
		tint.TintColor = Color3.fromRGB(205, 180, 255)
		tint.Saturation = -0.3
		tint.Contrast = 0.2
		tint.Parent = Lighting
		local blur = Instance.new("BlurEffect")
		blur.Size = 6
		blur.Parent = Lighting
		task.delay(duration, function()
			fade(tint, 0.4, { Saturation = 0, Contrast = 0, TintColor = Color3.new(1, 1, 1) })
			fade(blur, 0.4, { Size = 0 })
		end)
	end
end

-- ------------------------------------------------------------------ dispatch
local function center(info: { [string]: any }): Vector3?
	return if typeof(info.CFrame) == "CFrame" then (info.CFrame :: CFrame).Position else nil
end

function SkillFx.Telegraph(info: { [string]: any }): boolean
	local skill = info.Skill
	local position = center(info)
	if not position then
		return false
	end
	local duration = math.clamp(tonumber(info.Duration) or 1, 0.05, 20)
	local radius = tonumber(info.Radius) or 10
	if skill == "Lightning Wrath" and info.Faint then
		stormCloud(position, radius, duration)
	elseif skill == "Raigo" then
		raigoSphere(position, radius, duration)
	elseif skill == "Meteor Strike" then
		meteorFall(position, 9, duration)
	elseif skill == "Meteor Fury" then
		meteorFall(position, 4.5, duration)
	end
	return false -- the ground warning still draws as normal
end

function SkillFx.Impact(info: { [string]: any }): boolean
	local skill = info.Skill
	local position = center(info)
	if not position then
		return false
	end
	local radius = tonumber(info.Radius) or 10
	if skill == "Lightning Dragon" then
		lightningDragon(info)
		return true
	elseif skill == "Lightning Wrath" then
		wrathBolt(position)
		return true
	elseif skill == "Raigo" then
		raigoBlast(position, radius)
		return true
	elseif skill == "Meteor Strike" then
		meteorImpact(position, radius, true)
		return true
	elseif skill == "Meteor Fury" then
		meteorImpact(position, radius, false)
		return true
	end
	return false
end

function SkillFx.Linger(info: { [string]: any }): boolean
	if info.Skill == "Gravity Dominance" then
		local position = center(info)
		if position then
			gravityDome(position, tonumber(info.Radius) or 12, math.clamp(tonumber(info.Duration) or 1.5, 0.2, 10))
			return true
		end
	end
	return false
end

function SkillFx.Bolt(info: { [string]: any }): boolean
	if info.Skill == "Lightning Dragon" and typeof(info.From) == "Vector3" and typeof(info.To) == "Vector3" then
		bolt(info.From, info.To, LIGHTNING_CORE, 0.6, 7, 0.25)
		bolt(info.From, info.To, LIGHTNING, 1.2, 7, 0.3)
		return true
	end
	return false
end

return SkillFx
