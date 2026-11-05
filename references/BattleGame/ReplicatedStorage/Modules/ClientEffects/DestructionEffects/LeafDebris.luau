-- LeafDebris (ModuleScript, client-side only)
local RunService = game:GetService("RunService")

local LeafDebris = {}

-- tuning -----------------------------------------------------------------
local POOL_SIZE      = 250
local GRAVITY        = workspace.Gravity * 0.55 -- softer than real gravity = leafy fall
local HIDDEN_CFRAME  = CFrame.new(0, -1000, 0)

local CHUNK_STUDS    = 1.75   -- target chunk size; drives grid subdivision count
local MAX_DIV        = 3      -- max grid subdivisions per axis for big chunks
local SMALL_PER_LEAF = 10     -- fluttering flat leaves per burst

local RELEASE_LAG    = 0.03   -- sec per stud from impact before a piece breaks loose
local FADE_PORTION   = 0.35   -- last fraction of life spent fading out

-- shared wind drift for all falling leaves; tweak or animate from outside
LeafDebris.Wind = Vector3.new(2, 0, 1)

local rng = Random.new()

-- pool ---------------------------------------------------------------------
local container = Instance.new("Folder")
container.Name = "LeafDebrisPool"
container.Parent = workspace

local freeParts = {}
local active = {}

for i = 1, POOL_SIZE do
	local p = Instance.new("Part")
	p.Anchored = true
	p.CanCollide = false
	p.CanQuery = false
	p.CanTouch = false
	p.CastShadow = false
	p.Material = Enum.Material.Grass
	p.TopSurface = Enum.SurfaceType.Smooth
	p.BottomSurface = Enum.SurfaceType.Smooth
	p.CFrame = HIDDEN_CFRAME
	p.Parent = container
	freeParts[i] = p
end

local function acquire(): Part?
	local p = table.remove(freeParts)
	if p then return p end
	-- pool exhausted: steal the oldest active chunk so new bursts always show
	local oldest = table.remove(active, 1)
	return oldest and oldest.part or nil
end

local function release(state)
	state.part.CFrame = HIDDEN_CFRAME
	table.insert(freeParts, state.part)
end

-- ground height for the whole burst (one raycast per leaf, not per chunk)
local groundParams = RaycastParams.new()
groundParams.FilterType = Enum.RaycastFilterType.Exclude
groundParams.FilterDescendantsInstances = { container, workspace.World.Debris }
groundParams.RespectCanCollide = true

local function findFloorY(position: Vector3): number
	local hit = workspace:Raycast(position, Vector3.new(0, -200, 0), groundParams)
	return hit and hit.Position.Y or (position.Y - 200)
end

-- helpers ------------------------------------------------------------------
local function varyColor(base: Color3): Color3
	local h, s, v = base:ToHSV()
	if rng:NextNumber() < 0.15 then
		-- the occasional dry, yellowed leaf
		h -= rng:NextNumber(0.05, 0.11)
		s *= rng:NextNumber(0.65, 0.85)
	end
	h = math.clamp(h + rng:NextNumber(-0.015, 0.015), 0, 1)
	s = math.clamp(s * rng:NextNumber(0.85, 1.1), 0, 1)
	v = math.clamp(v * rng:NextNumber(0.75, 1.2), 0, 1)
	return Color3.fromHSV(h, s, v)
end

local function randomSpin(mag: number): Vector3
	return Vector3.new(
		rng:NextNumber(-mag, mag),
		rng:NextNumber(-mag, mag),
		rng:NextNumber(-mag, mag))
end

local function addPiece(state)
	local part = acquire()
	if not part then return end
	state.part = part
	part.Size = state.size
	part.Color = state.color
	part.Transparency = 0
	-- visible immediately at its in-block position, so the first frames read
	-- as the block cracking apart in place rather than confetti popping out
	part.CFrame = CFrame.new(state.pos) * state.rotCf
	table.insert(active, state)
end

-- simulation -----------------------------------------------------------
RunService.Heartbeat:Connect(function(dt)
	local wind = LeafDebris.Wind
	for i = #active, 1, -1 do
		local s = active[i]
		s.life += dt

		-- still "attached": hold in place until the break reaches this piece
		if s.life < 0 then continue end

		if s.grounded then
			-- slide to a stop; leaves also settle flat
			local damp = math.exp(-5 * dt)
			s.vel = Vector3.new(s.vel.X * damp, 0, s.vel.Z * damp)
			s.pos += s.vel * dt
			if s.flatCf then
				s.rotCf = s.rotCf:Lerp(s.flatCf, 1 - math.exp(-9 * dt))
			end
			s.part.CFrame = CFrame.new(s.pos) * s.rotCf

		elseif s.kind == "leaf" then
			-- drag-limited fall + side-to-side flutter
			local vy = math.max(s.vel.Y - GRAVITY * dt, -s.fallSpeed)
			local damp = math.exp(-1.4 * dt) -- burst impulse bleeds off into a drift
			s.vel = Vector3.new(s.vel.X * damp, vy, s.vel.Z * damp)

			local sway = math.sin(s.life * s.swayFreq + s.phase)
			s.pos += (s.vel + s.swayDir * (sway * s.swayAmp) + wind) * dt
			s.rotCf *= CFrame.fromEulerAnglesXYZ(s.spin.X * dt, s.spin.Y * dt, s.spin.Z * dt)

			if s.pos.Y <= s.floorY + s.halfHeight then
				s.pos = Vector3.new(s.pos.X, s.floorY + s.halfHeight, s.pos.Z)
				s.vel = Vector3.new(s.vel.X * 0.4, 0, s.vel.Z * 0.4)
				s.grounded = true
				local _, yaw, _ = s.rotCf:ToOrientation()
				s.flatCf = CFrame.fromOrientation(0, yaw, 0)
				-- don't lie around full-term once landed
				s.lifetime = math.min(s.lifetime, s.life + rng:NextNumber(0.8, 1.6))
				s.part.CFrame = CFrame.new(s.pos) * s.rotCf
			else
				s.part.CFrame = CFrame.new(s.pos) * s.rotCf
					* CFrame.fromAxisAngle(s.tiltAxis, sway * 0.5) -- bank into the sway
			end

		else -- chunk: heavier, ballistic, one damped bounce
			s.vel -= Vector3.new(0, GRAVITY * dt, 0)
			s.pos += s.vel * dt
			s.rotCf *= CFrame.fromEulerAnglesXYZ(s.spin.X * dt, s.spin.Y * dt, s.spin.Z * dt)

			if s.pos.Y <= s.floorY + s.halfHeight then
				s.pos = Vector3.new(s.pos.X, s.floorY + s.halfHeight, s.pos.Z)
				if s.vel.Y < -8 then
					s.vel = Vector3.new(s.vel.X * 0.5, -s.vel.Y * 0.3, s.vel.Z * 0.5)
					s.spin *= 0.4
				else
					s.grounded = true
					s.vel = Vector3.new(s.vel.X * 0.9, 0, s.vel.Z * 0.9)
					s.lifetime = math.min(s.lifetime, s.life + rng:NextNumber(0.5, 1.1))
				end
			end
			s.part.CFrame = CFrame.new(s.pos) * s.rotCf
		end

		-- fade out over the last portion of life
		local t = s.life / s.lifetime
		if t >= 1 then
			table.remove(active, i)
			release(s)
		elseif t > 1 - FADE_PORTION then
			local k = (t - (1 - FADE_PORTION)) / FADE_PORTION
			s.part.Transparency = k
			if s.kind == "chunk" then
				s.part.Size = s.size * (1 - 0.4 * k)
			end
		end
	end
end)

-- spawning ---------------------------------------------------------------

-- call this once per destroyed leaf, ideally passing the hit position so the
-- break propagates outward from the impact like FractureGlass
function LeafDebris.burst(leafCFrame: CFrame, leafSize: Vector3, color: Color3?, impactPoint: Vector3?)
	local baseColor = color or Color3.fromRGB(44, 94, 47)
	local origin = leafCFrame.Position
	impactPoint = impactPoint or origin
	local floorY = findFloorY(origin)

	-- big chunks: a grid that tessellates the original block
	local div = Vector3.new(
		math.clamp(math.round(leafSize.X / CHUNK_STUDS), 1, MAX_DIV),
		math.clamp(math.round(leafSize.Y / CHUNK_STUDS), 1, MAX_DIV),
		math.clamp(math.round(leafSize.Z / CHUNK_STUDS), 1, MAX_DIV))
	local cell = leafSize / div

	for xi = 1, div.X do
		for yi = 1, div.Y do
			for zi = 1, div.Z do
				local localOffset = Vector3.new(
					(xi - 0.5) / div.X - 0.5,
					(yi - 0.5) / div.Y - 0.5,
					(zi - 0.5) / div.Z - 0.5) * leafSize
				local pos = leafCFrame:PointToWorldSpace(localOffset)

				local fromImpact = pos - impactPoint
				local dist = fromImpact.Magnitude
				local dir = if dist > 0.05 then fromImpact.Unit else Vector3.yAxis

				local size = cell * rng:NextNumber(0.75, 0.95)
				addPiece({
					kind = "chunk",
					pos = pos,
					size = size,
					color = varyColor(baseColor),
					halfHeight = size.Y / 2,
					floorY = floorY,
					rotCf = leafCFrame.Rotation, -- aligned with the block while attached
					vel = dir * rng:NextNumber(7, 14) + Vector3.new(0, rng:NextNumber(5, 12), 0),
					spin = randomSpin(6),
					life = -(dist * RELEASE_LAG + rng:NextNumber(0, 0.04)),
					lifetime = rng:NextNumber(1.6, 2.8),
					grounded = false,
				})
			end
		end
	end

	-- fluttering flat leaves shaken loose from inside the volume
	local half = leafSize / 2
	for _ = 1, SMALL_PER_LEAF do
		local localOffset = Vector3.new(
			rng:NextNumber(-half.X, half.X),
			rng:NextNumber(-half.Y, half.Y),
			rng:NextNumber(-half.Z, half.Z)) * 0.9
		local pos = leafCFrame:PointToWorldSpace(localOffset)

		local fromImpact = pos - impactPoint
		local dist = fromImpact.Magnitude
		local dir = if dist > 0.05 then fromImpact.Unit else Vector3.yAxis

		local swayDir = Vector3.new(rng:NextNumber(-1, 1), 0, rng:NextNumber(-1, 1))
		swayDir = if swayDir.Magnitude > 0.01 then swayDir.Unit else Vector3.xAxis

		local size = Vector3.new(
			rng:NextNumber(0.7, 1.4),
			rng:NextNumber(0.06, 0.12),
			rng:NextNumber(0.5, 1.1))
		addPiece({
			kind = "leaf",
			pos = pos,
			size = size,
			color = varyColor(baseColor),
			halfHeight = size.Y / 2,
			floorY = floorY,
			rotCf = CFrame.fromEulerAnglesXYZ(
				rng:NextNumber(0, math.pi * 2),
				rng:NextNumber(0, math.pi * 2),
				rng:NextNumber(0, math.pi * 2)),
			vel = dir * rng:NextNumber(3, 8) + Vector3.new(0, rng:NextNumber(3, 8), 0),
			spin = randomSpin(3),
			fallSpeed = rng:NextNumber(6, 11),
			swayFreq = rng:NextNumber(4, 7),
			swayAmp = rng:NextNumber(2, 4.5),
			phase = rng:NextNumber(0, math.pi * 2),
			swayDir = swayDir,
			tiltAxis = swayDir:Cross(Vector3.yAxis),
			life = -(dist * RELEASE_LAG * 0.6 + rng:NextNumber(0, 0.05)),
			lifetime = rng:NextNumber(2.6, 4.2),
			grounded = false,
		})
	end
end

return LeafDebris