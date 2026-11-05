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
--
-- King of Curses:
--   Dismantle          — a flurry of thin, near-invisible blades flickers down the line, leaving a cut
--   Cleave             — one crossing X slash, then a burst of small cuts that "fit" the target
--   Flame Arrow        — a fire orb charges in the sky, an arrow streaks in, a fireball detonates
--   World Slash        — a red seam hangs across the canyon, then one huge blade splits it wall to wall
--   Shrine of Calamity — a dark shrine rises inside a crimson domain full of endless slashes

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
local CURSE = Color3.fromRGB(205, 20, 45)
local CURSE_DARK = Color3.fromRGB(28, 6, 12)
local BLADE = Color3.fromRGB(255, 236, 238)
local FLAME = Color3.fromRGB(255, 125, 35)
local FLAME_CORE = Color3.fromRGB(255, 230, 160)

local folder: Instance = workspace
local playerGui: Instance? = nil

function SkillFx.SetFolder(target: Instance)
	folder = target
end

function SkillFx.SetPlayerGui(gui: Instance)
	playerGui = gui
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

-- ------------------------------------------------------------------ King of Curses
local function localRoot(): BasePart?
	local character = LocalPlayer.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	return if root and root:IsA("BasePart") then root else nil
end

local function isLocalRunner(): boolean
	return LocalPlayer:GetAttribute("Role") == "Runner"
end

-- One blade: a thin vertical sheet that snaps out to full length, then fades.
local function slash(centerPos: Vector3, direction: Vector3, length: number, height: number, color: Color3, life: number, tilt: number?)
	local flat = Vector3.new(direction.X, 0, direction.Z)
	if flat.Magnitude < 0.01 then
		flat = Vector3.new(0, 0, -1)
	end
	local cf = CFrame.lookAt(centerPos, centerPos + flat.Unit) * CFrame.Angles(0, 0, math.rad(tilt or 0))
	local blade = part({ Size = Vector3.new(0.12, height, length * 0.15), CFrame = cf, Color = color, Transparency = 0.05 })
	TweenService:Create(blade, TweenInfo.new(0.05, Enum.EasingStyle.Linear), { Size = Vector3.new(0.12, height, length) }):Play()
	task.delay(0.05, function()
		fade(blade, life, { Transparency = 1, Size = Vector3.new(0.05, height * 0.4, length * 1.1) })
	end)
end

-- A dark cut left in the ground along a line.
local function groundCut(start: Vector3, direction: Vector3, length: number, width: number, linger: number)
	local cf = CFrame.lookAt(start, start + direction) * CFrame.new(0, 0.12, -length / 2)
	local cut = part({ Size = Vector3.new(width, 0.15, length), CFrame = cf, Color = CURSE_DARK, Material = Enum.Material.SmoothPlastic, Transparency = 0.15 })
	local glow = part({ Size = Vector3.new(width * 0.35, 0.18, length), CFrame = cf, Color = CURSE, Transparency = 0.2 })
	fade(glow, 0.8, { Transparency = 1 })
	task.delay(linger, function()
		fade(cut, 1, { Transparency = 1 })
	end)
end

local function sparks(position: Vector3, color: Color3, count: number)
	local anchor = part({ Size = Vector3.one * 0.2, Transparency = 1, Position = position })
	local emitter = particles(anchor, {
		Color = ColorSequence.new(color),
		Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0) }),
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }),
		Lifetime = NumberRange.new(0.2, 0.45),
		Speed = NumberRange.new(25, 50),
		SpreadAngle = Vector2.new(180, 180),
		Drag = 6,
	})
	emitter:Emit(count)
	Debris:AddItem(anchor, 1)
end

-- Shake for the local Runner based on their distance to a line segment (long strikes).
local function shakeNearLine(start: Vector3, direction: Vector3, length: number, strength: number)
	local root = localRoot()
	if not root then
		return
	end
	local along = math.clamp((root.Position - start):Dot(direction), 0, length)
	shakeNear(start + direction * along, strength)
end

local function dismantle(info: { [string]: any })
	local cf: CFrame = info.CFrame
	local length = tonumber(info.Length) or 60
	local width = tonumber(info.Width) or 4
	local start, forward, right = cf.Position, cf.LookVector, cf.RightVector
	local rng = Random.new()
	for i = 1, 9 do
		local t = (i - 0.5) / 9 + rng:NextNumber(-0.04, 0.04)
		local position = start + forward * length * t + right * rng:NextNumber(-width / 2, width / 2) + Vector3.new(0, rng:NextNumber(1.5, 5), 0)
		local direction = (CFrame.Angles(0, math.rad(rng:NextNumber(-30, 30)), 0) * CFrame.lookAt(Vector3.zero, forward)).LookVector
		task.delay(i * 0.025, slash, position, direction, rng:NextNumber(9, 16), rng:NextNumber(2, 3.5), if i % 2 == 0 then CURSE else BLADE, 0.16, rng:NextNumber(-70, 70))
	end
	groundCut(start, forward, length, 0.6, 2.5)
	for i = 1, 3 do
		sparks(start + forward * length * (i / 4) + Vector3.new(0, 1, 0), BLADE, 8)
	end
	shakeNearLine(start, forward, length, 1)
end

local function cleave(position: Vector3, radius: number)
	local mid = position + Vector3.new(0, 3, 0)
	local size = radius * 3.2
	slash(mid, Vector3.new(1, 0, 1), size, 4, BLADE, 0.25, 55)
	slash(mid, Vector3.new(-1, 0, 1), size, 4, CURSE, 0.25, -55)
	groundCut(position - Vector3.new(1, 0, 1).Unit * size / 2, Vector3.new(1, 0, 1).Unit, size, 0.5, 2)
	groundCut(position - Vector3.new(-1, 0, 1).Unit * size / 2, Vector3.new(-1, 0, 1).Unit, size, 0.5, 2)
	flash(mid, CURSE, radius * 2.5, 0.3)
	-- The follow-up: small cuts that wrap around whatever was there.
	local rng = Random.new()
	task.delay(0.08, function()
		for _ = 1, 8 do
			local offset = Vector3.new(rng:NextNumber(-1, 1), 0, rng:NextNumber(-1, 1)) * radius * 0.8
			slash(mid + offset + Vector3.new(0, rng:NextNumber(-1.5, 1.5), 0), Vector3.new(rng:NextNumber(-1, 1), 0, rng:NextNumber(-1, 1)), rng:NextNumber(3, 6), 1.2, BLADE, 0.12, rng:NextNumber(-90, 90))
			task.wait(0.02)
		end
	end)
	sparks(mid, CURSE, 14)
	shakeNear(position, 1.5)
end

local function flameArrowCharge(from: Vector3, duration: number)
	local life = math.max(duration - 0.2, 0.2)
	local orb = part({ Shape = Enum.PartType.Ball, Size = Vector3.one, Position = from, Color = FLAME_CORE, Transparency = 0.1 })
	local shell = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * 2, Position = from, Color = FLAME, Transparency = 0.45 })
	local glow = light(orb, FLAME, 10, 4)
	local fire = Instance.new("Fire")
	fire.Size = 4
	fire.Heat = 8
	fire.Color = FLAME
	fire.SecondaryColor = FLAME_CORE
	fire.Parent = orb
	-- Embers drawn in toward the orb as it charges.
	local gather = particles(shell, {
		Color = ColorSequence.new(FLAME, FLAME_CORE),
		Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 0) }),
		Transparency = NumberSequence.new(0, 1),
		Lifetime = NumberRange.new(0.4, 0.6),
		Speed = NumberRange.new(-14, -10),
		SpreadAngle = Vector2.new(180, 180),
		Rate = 60,
	})
	gather.EmissionDirection = Enum.NormalId.Top
	local grow = TweenInfo.new(life, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	TweenService:Create(orb, grow, { Size = Vector3.one * 5 }):Play()
	TweenService:Create(shell, grow, { Size = Vector3.one * 9 }):Play()
	TweenService:Create(glow, grow, { Range = 40, Brightness = 8 }):Play()
	Debris:AddItem(orb, life)
	Debris:AddItem(shell, life)
end

local function flameArrowFlight(from: Vector3, to: Vector3, duration: number)
	local shaft = part({ Size = Vector3.new(0.7, 0.7, 12), CFrame = CFrame.lookAt(from, to), Color = FLAME_CORE, Transparency = 0 })
	local tip = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * 3, Position = from, Color = FLAME, Transparency = 0.15 })
	light(tip, FLAME, 30, 6)
	local fire = Instance.new("Fire")
	fire.Size = 6
	fire.Heat = 0
	fire.Color = FLAME
	fire.SecondaryColor = FLAME_CORE
	fire.Parent = tip
	local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
	a0.Position = Vector3.new(0, 1.2, 0)
	a1.Position = Vector3.new(0, -1.2, 0)
	a0.Parent = tip
	a1.Parent = tip
	local trail = Instance.new("Trail")
	trail.Attachment0 = a0
	trail.Attachment1 = a1
	trail.Lifetime = 0.35
	trail.Color = ColorSequence.new(FLAME_CORE, FLAME)
	trail.Transparency = NumberSequence.new(0, 1)
	trail.LightEmission = 1
	trail.Parent = tip
	local started = os.clock()
	local connection: RBXScriptConnection
	connection = RunService.Heartbeat:Connect(function()
		local t = math.clamp((os.clock() - started) / math.max(duration, 0.05), 0, 1)
		local position = from:Lerp(to, t)
		tip.Position = position
		shaft.CFrame = CFrame.lookAt(position, to + (to - from).Unit) * CFrame.new(0, 0, 6)
		if t >= 1 then
			connection:Disconnect()
			shaft:Destroy()
			tip:Destroy()
		end
	end)
end

local function flameArrowBlast(position: Vector3, radius: number)
	flash(position + Vector3.new(0, 3, 0), FLAME_CORE, radius * 1.6, 0.35)
	local fireball = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * radius * 0.6, Position = position + Vector3.new(0, 2, 0), Color = FLAME, Transparency = 0.1 })
	light(fireball, FLAME, radius * 4, 6)
	fade(fireball, 0.6, { Size = Vector3.one * radius * 2.4, Transparency = 1, Color = CURSE })
	groundRing(position, FLAME, radius * 1.3, 0.6)
	groundRing(position, CURSE, radius, 0.8)
	-- Scorched ground that lingers.
	local scorch = part({
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(0.25, radius * 1.8, radius * 1.8),
		CFrame = CFrame.new(position + Vector3.new(0, 0.15, 0)) * CFrame.Angles(0, 0, math.rad(90)),
		Color = Color3.fromRGB(35, 18, 12),
		Material = Enum.Material.Slate,
		Transparency = 0.1,
	})
	task.delay(4, function()
		fade(scorch, 1.5, { Transparency = 1 })
	end)
	local anchor = part({ Size = Vector3.one * 0.2, Transparency = 1, Position = position + Vector3.new(0, 1, 0) })
	local flames = particles(anchor, {
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, FLAME_CORE), ColorSequenceKeypoint.new(0.4, FLAME), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 20, 15)) }),
		Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 3), NumberSequenceKeypoint.new(1, 7) }),
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1) }),
		Lifetime = NumberRange.new(0.6, 1.1),
		Speed = NumberRange.new(20, 45),
		SpreadAngle = Vector2.new(70, 70),
		Acceleration = Vector3.new(0, 12, 0),
		Drag = 3,
	})
	flames.EmissionDirection = Enum.NormalId.Top
	flames:Emit(45)
	Debris:AddItem(anchor, 2)
	sparks(position + Vector3.new(0, 2, 0), FLAME_CORE, 25)
	local exposure = Instance.new("ColorCorrectionEffect")
	exposure.Brightness = 0.25
	exposure.TintColor = Color3.fromRGB(255, 220, 190)
	exposure.Parent = Lighting
	fade(exposure, 0.45, { Brightness = 0, TintColor = Color3.new(1, 1, 1) })
	shakeNear(position, 3)
end

local function worldSlashSeam(info: { [string]: any }, duration: number)
	local cf: CFrame = info.CFrame
	local length = tonumber(info.Length) or 170
	local seam = part({ Size = Vector3.new(0.15, 0.15, length), CFrame = cf * CFrame.new(0, 6, -length / 2), Color = CURSE, Transparency = 0.9 })
	TweenService:Create(seam, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Transparency = 0.1, Size = Vector3.new(0.35, 0.35, length) }):Play()
	Debris:AddItem(seam, duration + 0.05)
end

-- A thin red line across the local Runner's screen that splits open (World Slash).
local function screenSplit()
	if not playerGui then
		return
	end
	local gui = Instance.new("ScreenGui")
	gui.Name = "WorldSlashSplit"
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 60
	gui.Parent = playerGui
	local whiteout = Instance.new("Frame")
	whiteout.Size = UDim2.fromScale(1, 1)
	whiteout.BorderSizePixel = 0
	whiteout.BackgroundColor3 = BLADE
	whiteout.BackgroundTransparency = 0.35
	whiteout.Parent = gui
	local seam = Instance.new("Frame")
	seam.AnchorPoint = Vector2.new(0.5, 0.5)
	seam.Position = UDim2.fromScale(0.5, 0.5)
	seam.Size = UDim2.new(1.2, 0, 0, 3)
	seam.Rotation = -8
	seam.BorderSizePixel = 0
	seam.BackgroundColor3 = CURSE
	seam.Parent = gui
	TweenService:Create(whiteout, TweenInfo.new(0.35), { BackgroundTransparency = 1 }):Play()
	TweenService:Create(seam, TweenInfo.new(0.45, Enum.EasingStyle.Quad), { Size = UDim2.new(1.2, 0, 0, 14), BackgroundTransparency = 1 }):Play()
	Debris:AddItem(gui, 0.5)
end

local function worldSlash(info: { [string]: any })
	local cf: CFrame = info.CFrame
	local length = tonumber(info.Length) or 170
	local start, forward = cf.Position, cf.LookVector
	-- The blade sweeps from one wall to the other in a blink.
	local sweep = 0.12
	local outer = part({ Size = Vector3.new(0.6, 34, 1), CFrame = cf * CFrame.new(0, 14, -0.5), Color = CURSE, Transparency = 0.25 })
	local core = part({ Size = Vector3.new(0.2, 30, 1), CFrame = cf * CFrame.new(0, 14, -0.5), Color = BLADE, Transparency = 0 })
	light(core, CURSE, 40, 6)
	local info2 = TweenInfo.new(sweep, Enum.EasingStyle.Linear)
	TweenService:Create(outer, info2, { Size = Vector3.new(0.6, 34, length), CFrame = cf * CFrame.new(0, 14, -length / 2) }):Play()
	TweenService:Create(core, info2, { Size = Vector3.new(0.2, 30, length), CFrame = cf * CFrame.new(0, 14, -length / 2) }):Play()
	task.delay(sweep, function()
		fade(outer, 0.4, { Transparency = 1, Size = Vector3.new(3, 46, length) })
		fade(core, 0.3, { Transparency = 1, Size = Vector3.new(0.05, 40, length) })
	end)
	groundCut(start, forward, length, 1.6, 4)
	for i = 1, 6 do
		sparks(start + forward * length * (i / 7) + Vector3.new(0, 1.5, 0), BLADE, 10)
	end
	-- Every Runner near the cut feels it.
	local root = localRoot()
	if root and isLocalRunner() then
		local along = math.clamp((root.Position - start):Dot(forward), 0, length)
		if (root.Position - (start + forward * along)).Magnitude < 60 then
			screenSplit()
		end
	end
	shakeNearLine(start, forward, length, 3)
end

local function shrineSigil(position: Vector3, radius: number, duration: number)
	local ring = part({
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(0.3, 2, 2),
		CFrame = CFrame.new(position + Vector3.new(0, 0.25, 0)) * CFrame.Angles(0, 0, math.rad(90)),
		Color = CURSE,
		Transparency = 0.2,
	})
	TweenService:Create(ring, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = Vector3.new(0.3, radius * 2, radius * 2), Transparency = 0.5 }):Play()
	Debris:AddItem(ring, duration + 0.05)
	-- Dark mist pouring out of the ground where the shrine will rise.
	local anchor = part({ Size = Vector3.one * 0.2, Transparency = 1, Position = position + Vector3.new(0, 1, 0) })
	local mist = particles(anchor, {
		Color = ColorSequence.new(CURSE_DARK, CURSE),
		LightEmission = 0.2,
		Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 3), NumberSequenceKeypoint.new(1, 9) }),
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.4), NumberSequenceKeypoint.new(1, 1) }),
		Lifetime = NumberRange.new(0.8, 1.4),
		Speed = NumberRange.new(4, 10),
		SpreadAngle = Vector2.new(60, 60),
		Rate = 50,
	})
	mist.EmissionDirection = Enum.NormalId.Top
	task.delay(duration, function()
		mist.Enabled = false
	end)
	Debris:AddItem(anchor, duration + 1.5)
end

-- A dark shrine built from parts. Returns its parts so they can rise and sink together.
local function buildShrine(position: Vector3): { Part }
	local parts: { Part } = {}
	local function add(size: Vector3, offset: Vector3, color: Color3, material: Enum.Material?)
		local p = part({ Size = size, CFrame = CFrame.new(position + offset), Color = color, Material = material or Enum.Material.Slate, Transparency = 0 })
		table.insert(parts, p)
	end
	add(Vector3.new(16, 2, 16), Vector3.new(0, 1, 0), CURSE_DARK)
	for _, x in { -6, 6 } do
		for _, z in { -6, 6 } do
			add(Vector3.new(1.4, 10, 1.4), Vector3.new(x, 7, z), Color3.fromRGB(45, 10, 18))
		end
	end
	add(Vector3.new(20, 1.6, 20), Vector3.new(0, 12.5, 0), CURSE, Enum.Material.SmoothPlastic)
	add(Vector3.new(13, 1.4, 13), Vector3.new(0, 15.5, 0), CURSE_DARK)
	add(Vector3.new(8, 1.2, 8), Vector3.new(0, 18, 0), CURSE, Enum.Material.SmoothPlastic)
	add(Vector3.new(1, 5, 1), Vector3.new(0, 21, 0), CURSE_DARK)
	-- Glowing trim under each roof.
	add(Vector3.new(20.4, 0.3, 20.4), Vector3.new(0, 11.6, 0), CURSE, Enum.Material.Neon)
	add(Vector3.new(13.4, 0.3, 13.4), Vector3.new(0, 14.7, 0), CURSE, Enum.Material.Neon)
	return parts
end

local function shrineDomain(position: Vector3, radius: number, duration: number)
	local dome = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * 2, Position = position, Color = CURSE, Material = Enum.Material.ForceField, Transparency = 0.15 })
	TweenService:Create(dome, TweenInfo.new(0.4, Enum.EasingStyle.Back), { Size = Vector3.one * radius * 2 }):Play()
	light(dome, CURSE, radius * 1.5, 2)
	local floor = part({
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(0.2, radius * 2, radius * 2),
		CFrame = CFrame.new(position + Vector3.new(0, 0.2, 0)) * CFrame.Angles(0, 0, math.rad(90)),
		Color = CURSE_DARK,
		Material = Enum.Material.SmoothPlastic,
		Transparency = 0.45,
	})

	-- The shrine rises out of the ground.
	local shrine = buildShrine(position)
	for _, p in shrine do
		local final = p.CFrame
		p.CFrame = final - Vector3.new(0, 24, 0)
		TweenService:Create(p, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { CFrame = final }):Play()
	end

	-- Endless slashes inside the domain.
	task.spawn(function()
		local rng = Random.new()
		local started = os.clock()
		local count = 0
		while os.clock() - started < duration do
			for _ = 1, 3 do
				local angle = rng:NextNumber(0, math.pi * 2)
				local distance = math.sqrt(rng:NextNumber()) * radius * 0.95
				local spot = position + Vector3.new(math.cos(angle) * distance, rng:NextNumber(1, 9), math.sin(angle) * distance)
				count += 1
				slash(spot, Vector3.new(rng:NextNumber(-1, 1), 0, rng:NextNumber(-1, 1)), rng:NextNumber(8, 18), rng:NextNumber(1.5, 3), if count % 3 == 0 then CURSE else BLADE, 0.14, rng:NextNumber(-80, 80))
			end
			task.wait(0.05)
		end
		-- Close: the domain bursts and the shrine sinks back down.
		fade(dome, 0.5, { Transparency = 1, Size = Vector3.one * radius * 2.3 })
		fade(floor, 0.8, { Transparency = 1 })
		for _, p in shrine do
			TweenService:Create(p, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { CFrame = p.CFrame - Vector3.new(0, 24, 0) }):Play()
			Debris:AddItem(p, 0.65)
		end
	end)

	-- Runners caught inside see the world through the domain.
	local root = localRoot()
	if root and isLocalRunner() and ((root.Position - position) * Vector3.new(1, 0, 1)).Magnitude <= radius then
		local tint = Instance.new("ColorCorrectionEffect")
		tint.TintColor = Color3.fromRGB(255, 170, 175)
		tint.Saturation = -0.5
		tint.Contrast = 0.35
		tint.Brightness = -0.05
		tint.Parent = Lighting
		task.delay(duration, function()
			fade(tint, 0.5, { Saturation = 0, Contrast = 0, Brightness = 0, TintColor = Color3.new(1, 1, 1) })
		end)
		shakeNear(position, 1.5)
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
	elseif skill == "Flame Arrow" and typeof(info.From) == "Vector3" then
		flameArrowCharge(info.From, duration)
	elseif skill == "World Slash" and info.Shape == "Line" then
		worldSlashSeam(info, duration)
	elseif skill == "Shrine of Calamity" then
		shrineSigil(position, radius, duration)
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
	elseif skill == "Dismantle" and info.Shape == "Line" then
		dismantle(info)
		return true
	elseif skill == "Cleave" then
		cleave(position, radius)
		return true
	elseif skill == "Flame Arrow" then
		flameArrowBlast(position, radius)
		return true
	elseif skill == "World Slash" and info.Shape == "Line" then
		worldSlash(info)
		return true
	end
	return false
end

function SkillFx.Linger(info: { [string]: any }): boolean
	local position = center(info)
	if not position then
		return false
	end
	if info.Skill == "Gravity Dominance" then
		gravityDome(position, tonumber(info.Radius) or 12, math.clamp(tonumber(info.Duration) or 1.5, 0.2, 10))
		return true
	elseif info.Skill == "Shrine of Calamity" then
		shrineDomain(position, tonumber(info.Radius) or 40, math.clamp(tonumber(info.Duration) or 4, 0.2, 10))
		return true
	end
	return false
end

function SkillFx.Projectile(info: { [string]: any }): boolean
	if info.Skill ~= "Flame Arrow" or typeof(info.From) ~= "Vector3" or typeof(info.To) ~= "Vector3" then
		return false
	end
	if ((info.To :: Vector3) - (info.From :: Vector3)).Magnitude < 0.5 then
		return true
	end
	flameArrowFlight(info.From, info.To, math.clamp(tonumber(info.Duration) or 0.25, 0.05, 3))
	return true
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
