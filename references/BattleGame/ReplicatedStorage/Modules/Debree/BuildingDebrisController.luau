-- Tsunami client debris. Local only: nothing here touches players or the server.
-- Carry: anchored pieces moved by math (rolling water, weight classes, water-driven spin), one
--        BulkMoveTo per frame. Fall: handed to real local physics so landings rest believably.
-- Rest: anchored where they landed until the building resets. Over the fall cap: drop hard through
--       the ground and get deleted below it. Out of the wave, gravity grows with height.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Settings = require(script.Parent.BuildingDebrisMotion)
local Records = require(script.Parent.Records)
local Controller = {}
local Started = false
local Root
local States = {}
local Kinematic, Falling = {}, {}
local FallingCount = 0
local Queue, Head = {}, 1
local Count = 0
local StatsClock, SettleClock = 0, 0
local MapParams
local MoveParts, MoveCFrames = {}, {}
local Finished, Dead, Settled = {}, {}, {}
local UP = Vector3.yAxis

local function groundAt(position)
	local hit = workspace:Raycast(position + UP * 2, UP * -400, MapParams)
	return hit and hit.Position.Y
end

-- Gravity once a piece is out of the wave: stronger the higher it is above the ground.
local function dropGravity(height)
	return workspace.Gravity * math.min(Settings.DropGravityMax,
		Settings.DropGravityBase + math.max(0, height) * Settings.DropGravityPerStud)
end

local function release(part, record, state)
	if not record.Counted then return end
	record.Counted = false
	Kinematic[part] = nil
	if Falling[part] then Falling[part] = nil; FallingCount = math.max(0, FallingCount - 1) end
	state.Parts[part] = nil
	Count = math.max(0, Count - 1)
end

local function clearState(id)
	local state = States[id]
	if not state then return end
	state.Cleared = true
	for part, record in state.Parts do release(part, record, state); part:Destroy() end
	state.Folder:Destroy()
	States[id] = nil
end

local function spawn(item)
	local state, packet = item.State, item.Packet
	local now = workspace:GetServerTimeNow()
	if state.Cleared or now >= state.ResetAt then return end

	local cf, size = Records.ReadPiece(packet.Geometry, item.Index)
	local rng = Random.new(packet.Seed + item.Index * 97)
	local wave = packet.Wave
	local age = math.max(0, now - wave.At)
	if now > wave.EndAt + Settings.SinkLifetime then return end
	if packet.Snapshot == true and age > Settings.LateJoinReplayAge then return end
	local camera = workspace.CurrentCamera
	local character = Players.LocalPlayer.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local viewPosition = if root then root.Position elseif camera then camera.CFrame.Position else cf.Position
	if (cf.Position - viewPosition).Magnitude > Settings.ClientDistance then return end
	if (state.Created or 0) >= Settings.ClientVoxelsPerBuilding then return end
	if Count >= Settings.MaxClientParts then
		if (state.Created or 0) >= Settings.ContactBurst then Root:SetAttribute("Capped", true); return end
		-- Reserve a new building's first impact burst by replacing older pieces (resting ones first).
		local victim, owner, oldest, oldRecord
		for _, other in States do
			if other == state then continue end
			for part, record in other.Parts do
				local ageKey = record.Born - (if record.ReleasedAt then 100000 else 0)
				if not oldest or ageKey < oldest then victim, owner, oldest, oldRecord = part, other, ageKey, record end
			end
		end
		if not victim then return end
		release(victim, oldRecord, owner); victim:Destroy()
	end

	local direction = wave.Direction
	local side = direction:Cross(UP)
	local volume = size.X * size.Y * size.Z
	-- Weight class is a weighted roll; size only shifts the odds (big pieces lean heavy, small lean light).
	local weights = Settings.ClassWeights
	local bias = math.clamp(math.log10(math.max(volume, 1)) - 2.3, -1, 1) * Settings.SizeBias
	local wHeavy, wLight = weights.Heavy * (1 + bias), weights.Light * (1 - bias)
	local pick = rng:NextNumber() * (wHeavy + weights.Medium + wLight)
	local className = if pick < wHeavy then "Heavy" elseif pick < wHeavy + weights.Medium then "Medium" else "Light"
	local class = Settings.Classes[className]

	local part = Instance.new("Part")
	part.Name = packet.PieceKind
	part.Size = size
	part.CFrame = cf
	part.Color = packet.Color
	part.Material = packet.Material
	part.MaterialVariant = packet.Variant
	part.Transparency = packet.Transparency
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.CollisionGroup = Settings.CollisionGroup
	part:SetAttribute("TsunamiClientDebris", true)

	local scale = rng:NextNumber(0.85, 1.1)
	local record = {
		Counted = true, Born = now, BaseTransparency = packet.Transparency,
		FadeLead = rng:NextNumber(Settings.FadeBeforeResetMin, Settings.FadeBeforeResetMax),
		Phase = "Carry", Class = class, Wave = wave, Scale = scale, Seed = rng:NextNumber(0, 1000),
		Pos = cf.Position, Rot = cf.Rotation, Vel = Vector3.zero,
		AngVel = side * (class.Spin * rng:NextNumber(1, 3))
			+ Vector3.new(rng:NextNumber(-1, 1), rng:NextNumber(-1, 1), rng:NextNumber(-1, 1)) * class.Spin,
		Radius = math.max(0.5, size.Magnitude * 0.3),
		StartAt = now + rng:NextNumber(Settings.HangMin, Settings.HangMax),
		Launch = direction * (wave.Speed * class.Entry * scale) + side * rng:NextNumber(-5, 5)
			+ UP * rng:NextNumber(class.Lift[1], class.Lift[2]),
		CarryUntil = now + rng:NextNumber(Settings.CarrySecondsMin, Settings.CarrySecondsMax) * class.Carry,
		Ground = groundAt(cf.Position) or (cf.Position.Y - size.Y),
		NextGround = now + rng:NextNumber(0, Settings.GroundProbeInterval),
		ReleaseOffset = rng:NextNumber(0, Settings.ReleaseStagger),
		-- Per-piece variation.
		Rng = rng,
		SpeedMul = 1 + rng:NextNumber(-Settings.SpeedJitter, Settings.SpeedJitter),
		BuoyancyOffset = rng:NextNumber(-Settings.BuoyancyJitter, Settings.BuoyancyJitter),
		DragMul = 1 + rng:NextNumber(-Settings.DragJitter, Settings.DragJitter),
		LoopPhase = rng:NextNumber(0, math.pi * 2),
		LoopPeriod = rng:NextNumber(Settings.LoopPeriodMin, Settings.LoopPeriodMax),
		LoopRadius = rng:NextNumber(Settings.LoopRadiusMin, Settings.LoopRadiusMax),
		NextKick = now + rng:NextNumber(Settings.KickIntervalMin, Settings.KickIntervalMax),
		SpinAxis = rng:NextUnitVector(),
	}
	state.Parts[part] = record
	state.Created = (state.Created or 0) + 1
	if not state.FirstSpawnAt then
		state.FirstSpawnAt = now
		local delay = math.max(0, state.FirstSpawnAt - (packet.ContactAt or state.FirstSpawnAt)) * 1000
		Root:SetAttribute("LastFirstDebrisDelayMs", delay)
		Root:SetAttribute("MaxFirstDebrisDelayMs", math.max(Root:GetAttribute("MaxFirstDebrisDelayMs") or 0, delay))
		if packet.Category ~= "Decor" then Root:SetAttribute("MaxFirstBuildingDebrisDelayMs", math.max(Root:GetAttribute("MaxFirstBuildingDebrisDelayMs") or 0, delay)) end
		state.Folder:SetAttribute("FirstSpawnDelayMs", delay)
	end
	Count += 1
	part.Destroying:Once(function()
		release(part, record, state)
	end)
	part.Parent = state.Folder
	Kinematic[part] = record
end

-- One frame of a carried piece. true = it leaves the wave (dumped, overtaken, or the wave ended).
local function stepCarry(record, now, dt)
	if now < record.StartAt then return false end -- still hanging where it broke off
	if not record.Launched then record.Launched = true; record.Vel = record.Launch end
	local wave = record.Wave
	local dir = wave.Direction
	local side = dir:Cross(UP)
	local age = now - wave.At
	local pos = record.Pos
	local behind = (wave.Front + dir * (wave.Speed * age) - pos):Dot(dir) -- > 0: behind the front
	if now >= record.CarryUntil or now >= wave.EndAt + record.ReleaseOffset or behind > wave.Depth or age > Settings.MaxCarrySeconds then
		return true
	end
	if now >= record.NextGround then
		record.NextGround = now + Settings.GroundProbeInterval
		local ground = groundAt(pos)
		if ground then record.Ground = ground end
	end

	local class = record.Class
	local rng = record.Rng
	local h = math.clamp((pos.Y - record.Ground) / Settings.CrestHeight, 0, 1.2) -- 0 base .. 1 crest
	local weight = if behind >= -Settings.FrontSkin and h <= 1.05 then 1
		elseif behind > -Settings.AirPushDistance then Settings.AirPush else 0
	-- Per-piece noise (own offsets, choppier) so neighbours don't move as one block.
	local s, t = Settings.NoiseScale, now * Settings.NoiseRate
	local n1 = math.noise(pos.X / s + record.Seed, pos.Z / s, t)
	local n2 = math.noise(pos.Z / s, pos.X / s - record.Seed, t * 0.8)
	local n3 = math.noise(t * 0.9, pos.X / s, pos.Z / s + record.Seed)
	-- Own loop through the wave: up the back, forward over the top, down the front, back under.
	local theta = record.LoopPhase + (math.pi * 2) * now / record.LoopPeriod
	local loopSpeed = (math.pi * 2) * record.LoopRadius / record.LoopPeriod * class.Roll
	-- Mean flow: the base runs slower and lifts, the crest runs faster and pushes down.
	local u = wave.Speed * math.clamp((class.Speed + class.Roll * (h - 0.4) * Settings.RollerShear
		+ n2 * Settings.TurbulenceForward) * record.Scale * record.SpeedMul, 0.3, 1.5) - loopSpeed * math.cos(theta)
	local w = wave.Speed * (class.Roll * (0.5 - h) * Settings.RollerLift + n1 * Settings.TurbulenceVertical)
		+ loopSpeed * math.sin(theta)
	local sideTarget = wave.Speed * Settings.LateralTurbulence * n3 * 2

	local vel = record.Vel
	local along, lateral, vy = vel:Dot(dir), vel:Dot(side), vel.Y
	local pull = math.min(1, class.Drag * record.DragMul * weight * dt)
	along += (u - along) * pull
	lateral += (sideTarget * weight - lateral) * math.min(1, Settings.SideDrag * dt)
	vy += (w - vy) * pull
	local buoyancy = if weight >= 1 then math.clamp(class.Buoyancy + record.BuoyancyOffset, 0, 1) else 0
	vy -= workspace.Gravity * (1 - buoyancy) * dt

	-- Turbulence kicks: sudden shoves at random intervals; now and then a big one throws it out of the crest.
	if now >= record.NextKick then
		record.NextKick = now + rng:NextNumber(Settings.KickIntervalMin, Settings.KickIntervalMax)
		if weight > 0 then
			local kick
			if rng:NextNumber() < Settings.BigKickChance then
				kick = UP * Settings.BigKickStrength + dir * (Settings.BigKickStrength * 0.4) + side * rng:NextNumber(-15, 15)
			else
				kick = (dir * rng:NextNumber(-0.6, 1) + side * rng:NextNumber(-1, 1) + UP * rng:NextNumber(-0.3, 1)) * Settings.KickStrength
			end
			kick *= class.Kick
			along += kick:Dot(dir); lateral += kick:Dot(side); vy += kick.Y
			record.AngVel += rng:NextUnitVector() * (Settings.KickSpin * class.Kick)
		end
	end
	pos += (dir * along + side * lateral + UP * vy) * dt

	local contact = false
	local floor = record.Ground + record.Radius
	if pos.Y < floor then
		pos = Vector3.new(pos.X, floor, pos.Z)
		if vy < 0 then vy = -vy * Settings.Bounce end
		along *= 1 - math.min(1, class.Friction * dt) -- scraping (heavy pieces slide more)
		contact = true
	end
	record.Pos = pos
	record.Vel = dir * along + side * lateral + UP * vy

	-- Spin: rolls while scraping, otherwise driven by the water shearing past it, plus its own
	-- slowly wandering axis so it never stops tumbling.
	record.SpinAxis = (record.SpinAxis + rng:NextUnitVector() * (Settings.SpinDrift * dt)).Unit
	local r = math.max(record.Radius, 1.5)
	local roll = if contact then along / r else (u - along) * Settings.ShearSpin / r
	local target = side * (roll * class.Spin) + Vector3.new(n1, n2, n3) * (class.Spin * Settings.Wobble)
		+ record.SpinAxis * class.MinSpin
	if target.Magnitude > Settings.MaxSpin then target = target.Unit * Settings.MaxSpin end
	record.AngVel = record.AngVel:Lerp(target, math.min(1, Settings.SpinResponse * dt))
	if record.AngVel.Magnitude < class.MinSpin then record.AngVel = record.SpinAxis * class.MinSpin end
	local a = record.AngVel.Magnitude
	if a > 1e-4 then record.Rot = CFrame.fromAxisAngle(record.AngVel / a, a * dt) * record.Rot end
	return false
end

-- Over the physics cap: falls hard from wherever it is (no fade), keeps its momentum and spin,
-- passes through the ground, and is deleted once it's out of sight below it. true = gone.
local function stepDrop(record, now, dt)
	local v = record.Vel
	local keep = math.max(0, 1 - Settings.DropHorizontalDrag * dt)
	local vy = v.Y - dropGravity(record.Pos.Y - record.Ground) * dt
	record.Vel = Vector3.new(v.X * keep, vy, v.Z * keep)
	record.Pos += record.Vel * dt
	local a = record.AngVel.Magnitude
	if a > 1e-4 then record.Rot = CFrame.fromAxisAngle(record.AngVel / a, a * dt) * record.Rot end
	return record.Pos.Y < record.Ground - (record.Radius + Settings.ThroughGroundDepth)
		or now - record.ReleasedAt > Settings.DropMaxSeconds
end

-- Leaves the wave: real physics decides how it falls and where it rests.
local function handoff(part, record, now)
	Kinematic[part] = nil
	local ground = groundAt(record.Pos)
	if ground then record.Ground = ground end
	if FallingCount >= Settings.MaxFallingParts then
		record.Phase = "Drop"; record.ReleasedAt = now
		Kinematic[part] = record
		return
	end
	record.Phase = "Fall"
	Falling[part] = record
	FallingCount += 1
	local floor = record.Ground + record.Radius + 0.25
	if record.Pos.Y < floor then record.Pos = Vector3.new(record.Pos.X, floor, record.Pos.Z) end
	part.CFrame = CFrame.new(record.Pos) * record.Rot
	part.CollisionGroup = Settings.FallCollisionGroup
	part.Anchored = false
	part.AssemblyLinearVelocity = record.Vel * Settings.HandoffVelocityScale
	part.AssemblyAngularVelocity = record.AngVel
	record.FallStart, record.CollideAt, record.Still = now, now + Settings.HandoffNoCollide, 0
end

local function rest(part, record, now)
	Falling[part] = nil
	FallingCount = math.max(0, FallingCount - 1)
	part.Anchored = true
	part.CanCollide = false
	record.Phase = "Rest"; record.ReleasedAt = now
end

local function setDeadline(state, resetAt)
	if resetAt > state.ResetAt then
		state.ResetAt = resetAt
		-- A later pass can extend regeneration after some rubble has already started fading.
		for part, record in state.Parts do
			if record.Phase ~= "Drop" then part.Transparency = record.BaseTransparency end
		end
	end
	state.Folder:SetAttribute("ResetAt", state.ResetAt)
end

local function onEvent(packet)
	local id = packet.BuildingId
	if packet.Kind == "Clear" then clearState(id); return end
	local state = States[id]
	if packet.Kind == "Deadline" then
		if state then setDeadline(state, packet.ResetAt) end
		return
	end
	if packet.Kind ~= "Add" or packet.ResetAt <= workspace:GetServerTimeNow() or workspace:GetServerTimeNow() > packet.Wave.EndAt + Settings.SinkLifetime then return end
	if not state then
		local folder = Instance.new("Folder"); folder.Name = tostring(id); folder.Parent = Root
		state = { Folder = folder, Parts = {}, Seen = {}, ResetAt = packet.ResetAt }
		States[id] = state
	end
	setDeadline(state, packet.ResetAt)
	if state.Seen[packet.PacketId] then return end
	state.Seen[packet.PacketId] = true
	for i = 1, Records.Count(packet.Geometry, Records.PIECE_SIZE) do
		if (state.Queued or 0) >= Settings.ClientVoxelsPerBuilding then break end
		if (state.Created or 0) >= Settings.ContactBurst and #Queue - Head + 1 >= Settings.MaxClientParts * 2 then break end
		state.Queued = (state.Queued or 0) + 1
		local item = { State = state, Packet = packet, Index = i }
		if (state.Created or 0) < Settings.ContactBurst then spawn(item) else table.insert(Queue, item) end
	end
end

local function heartbeat(dt)
	local budget = Settings.SpawnPerFrame
	while Head <= #Queue and budget > 0 do
		spawn(Queue[Head]); Head += 1; budget -= 1
	end
	if Head > #Queue then Queue = {}; Head = 1 end
	local now = workspace:GetServerTimeNow()
	local killY = workspace.FallenPartsDestroyHeight + 30

	-- Carried and sinking pieces: math, then one bulk move.
	table.clear(MoveParts); table.clear(MoveCFrames); table.clear(Finished); table.clear(Dead)
	for part, record in Kinematic do
		local done
		if record.Phase == "Carry" then
			done = stepCarry(record, now, dt)
			if done then table.insert(Finished, part) end
		else
			done = stepDrop(record, now, dt) or record.Pos.Y < killY
			if done then table.insert(Dead, part) end
		end
		if not done then
			table.insert(MoveParts, part)
			table.insert(MoveCFrames, CFrame.new(record.Pos) * record.Rot)
		end
	end
	if #MoveParts > 0 then workspace:BulkMoveTo(MoveParts, MoveCFrames, Enum.BulkMoveMode.FireCFrameChanged) end
	for _, part in Finished do
		local record = Kinematic[part]
		if record then handoff(part, record, now) end
	end

	-- Falling pieces: collisions on after a short grace, anchor once they stop moving.
	SettleClock += dt
	local interval = SettleClock
	local checkSettle = SettleClock >= 0.15
	if checkSettle then SettleClock = 0 end
	table.clear(Settled)
	local gravity = workspace.Gravity
	for part, record in Falling do
		if not part.CanCollide and now >= record.CollideAt then part.CanCollide = true end
		-- Extra gravity while airborne (the engine already applies 1g); off near the ground so landings stay normal.
		local height = part.Position.Y - record.Ground
		if height > record.Radius + 1 then
			local extra = dropGravity(height) - gravity
			if extra > 0 then part.AssemblyLinearVelocity -= UP * (extra * dt) end
		end
		if checkSettle then
			if part.Position.Y < killY then
				table.insert(Dead, part)
			else
				local still = part.AssemblyLinearVelocity.Magnitude < Settings.SettleSpeed
					and part.AssemblyAngularVelocity.Magnitude < Settings.SettleAngularSpeed
				record.Still = if still then record.Still + interval else 0
				if record.Still >= Settings.SettleSeconds or now - record.FallStart > Settings.FallMaxSeconds then
					table.insert(Settled, part)
				end
			end
		end
	end
	for _, part in Settled do
		local record = Falling[part]
		if record then rest(part, record, now) end
	end
	for _, part in Dead do part:Destroy() end -- Destroying releases it

	-- Rubble stays until the building resets, then fades out.
	for id, state in States do
		if now >= state.ResetAt then clearState(id)
		elseif now >= state.ResetAt - Settings.FadeBeforeResetMax then
			for part, record in state.Parts do
				if record.Phase == "Drop" then continue end
				local fade = math.clamp((now - (state.ResetAt - record.FadeLead)) / Settings.FadeSeconds, 0, 1)
				part.Transparency = record.BaseTransparency + (1 - record.BaseTransparency) * fade
			end
		end
	end

	StatsClock += dt
	if StatsClock >= 0.25 then
		StatsClock = 0
		local carried = 0
		for _, record in Kinematic do if record.Phase == "Carry" then carried += 1 end end
		Root:SetAttribute("LiveParts", Count)
		Root:SetAttribute("CarriedParts", carried)
		Root:SetAttribute("FallingParts", FallingCount)
		Root:SetAttribute("PendingParts", math.max(0, #Queue - Head + 1))
	end
end

function Controller.Start()
	if Started then return end
	Started = true
	Root = Instance.new("Folder")
	Root.Name = "TsunamiBuildingDebris"
	Root.Parent = workspace.World.Visuals
	MapParams = RaycastParams.new()
	MapParams.FilterType = Enum.RaycastFilterType.Include
	MapParams.FilterDescendantsInstances = { workspace.World.Map, workspace.World.Voxel }
	MapParams.RespectCanCollide = true
	local remote = game.ReplicatedStorage.Remotes.Debree:WaitForChild("BuildingMotion")
	remote.OnClientEvent:Connect(onEvent)
	RunService.Heartbeat:Connect(heartbeat)
end

return Controller
