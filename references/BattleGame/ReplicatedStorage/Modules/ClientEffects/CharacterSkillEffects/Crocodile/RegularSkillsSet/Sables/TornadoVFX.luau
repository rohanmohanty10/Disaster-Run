--[[
	TornadoVFX — self-contained 1:1 port of Heroes Battlegrounds' "StormOfRuinTornado".

	Replaces: ReplicatedStorage.EffectMods.EffectsHandler.StormOfRuinTornado
	          + ReplicatedStorage.EmitModule (37 modules) — none of which are needed.

	Place this as a ModuleScript, with the StormOfRuinTornado model as a sibling/child.
	Call TornadoVFX.Spawn{ Anchor = <BasePart>, Asset = <Model>, Parent = <Folder>, Color = <Color3> }.

	HOW THE ORIGINAL WORKS (so the code below reads as a port, not magic):

	  1. The cloned asset is an INVISIBLE RIG. Every template part in it is Transparency = 1.
	     Nothing you see is the rig itself.
	  2. The rig is PivotTo'd to an anchor part every frame with IDENTITY rotation
	     (CFrame.new(pos) — no CFrame.Angles). The rig never spins.
	  3. Each child Model tagged "ConstantVFX" re-emits every 1/Rate seconds (Rate default 5).
	     An emission clones ONLY the `Start` part into the world, animates it toward `End`'s
	     values, spins it, and destroys it. `End` is never parented into the world.
	  4. SyncPosition is false on this asset, so each emission caches its origin at spawn
	     and is LEFT BEHIND while the tornado travels on. The vortex is ~20 short-lived
	     spinning cones per second along the path — not one rotating object.

	Decoded asset recipe (for reference; the code reads these at runtime):
	  Model   EffectDuration 0.5-1.0            EmitCount 0  -> emits nothing
	  Model1  EffectDuration 0.5-1.0  yaw -360  RotSpeed -15 -> -15
	  Model2  EffectDuration 0.6      yaw -360  RotSpeed  -5 ->  -5
	  Model3  EffectDuration 1.0      yaw -360  RotSpeed  -5 ->  -5
	  Model4  EffectDuration 0.6      yaw -3600 RotSpeed  -5 ->  -1   (decelerates)
	  Up2     Decal_StartTransparency 0, 21-frame flipbook, SpecialMesh scale lerp
	  Up21    identical to Up2
	  Part    all emitters EmitCount 0 -> emits nothing
]]

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")

local TornadoVFX = {}

--=============================================================================
-- Tuning (values taken from the original)
--=============================================================================

local FOLLOW_OFFSET = Vector3.new(0, -2, 0) -- Execute(): PivotTo(pos + (0,-2,0))
local DEFAULT_RATE = 5 -- enabled_effects: attributes.get(model, "Rate", 5)
local SOUND_LOOP_ID = "rbxassetid://121998492094237"
local SOUND_END_ID = "rbxassetid://113162657820582"
local SOUND_VOLUME = 5
local SOUND_FADE = 2.5 -- linear volume fade on the loop when the tornado ends
local CLEANUP_DELAY = 3 -- destroy everything this long after the anchor dies
local POOL_LIMIT = 32 -- per-template free-list cap

-- effects/mesh writes `clone.CFrame = base * acc` where `base` ALREADY contains `acc`,
-- so the accumulated spin is applied twice — i.e. the effective rate is 2x the attribute.
-- That is what the decompiled bytecode does, so it is what this port does. If the spin
-- reads too fast for your asset, set this to false to apply it once.
local SPIN_APPLIED_TWICE = true

-- Up2 / Up21 are Transparency = 1 Parts whose only visual is a Decal — but they also
-- carry a FileMesh SpecialMesh with an empty TextureId. A Decal on a FileMesh part is
-- unreliable: depending on engine version it maps onto the mesh or does not draw at all.
-- If it does not draw, those two models render nothing (which means they render nothing
-- in the source game either).
-- Set this true to route the Decal's Texture into SpecialMesh.TextureId and drive the
-- part's Transparency with the decal's curve instead. It makes them visible, but it is
-- a deviation from the literal port — hence the default.
local DECAL_TO_MESH_TEXTURE = false

-- Prints one line per emission: which model, where, how big, and what transparencies it
-- resolved to. Turn this on before blaming rendering — if Up2 / Up21 never print, the
-- problem is emission, not visibility.
local DEBUG = false

-- effects/mesh: `local v67 = u34 and getTransformedOriginExtents(u55) or u57` — when a
-- model's SyncPosition attribute is true the emitting part's transform is re-read every
-- frame, so the puff RIDES the moving rig. When false the origin is cached at emit time
-- and the puff is LEFT BEHIND, which is what makes the cones trail the particle emitters.
-- The attribute is honoured per model; set this true to force it on for all of them when
-- your asset omits it but you want the puffs to track the tornado.
local FORCE_SYNC_POSITION = false

local DEG = math.pi / 180
local ZERO_RANGE = NumberRange.new(0, 0)
local RNG = Random.new()

--=============================================================================
-- default_bezier — exact port of EmitModule utility.default_bezier + obj/Bezier
--
-- The framework's Path2D control points:
--   P0 (0,1)  RightTangent (0.215, -0.61)
--   P3 (1,0)  LeftTangent  (-0.645, 0)
-- serializePath flattens each point to [pos + leftTangent], [pos], [pos + rightTangent],
-- which for these two points yields the single cubic control polygon below.
--=============================================================================

local BEZ = {
	Vector2.new(0, 1),
	Vector2.new(0.215, 0.39), -- P0 + RightTangent
	Vector2.new(0.355, 0), -- P3 + LeftTangent
	Vector2.new(1, 0),
}

local function bezPoint(t: number): Vector2
	local u = 1 - t
	return BEZ[1] * (u * u * u) + BEZ[2] * (3 * u * u * t) + BEZ[3] * (3 * u * t * t) + BEZ[4] * (t * t * t)
end

-- obj/Bezier._getEaseRaw: Newton-solve the parameter whose X equals `x`, then return the point.
local function bezSolve(x: number): Vector2
	local t = math.clamp(x, 0, 1) -- single segment, so getEasedSegmentIndex returns x directly
	for _ = 1, 5 do
		local u = 1 - t
		local fx = u * u * u * BEZ[1].X + 3 * u * u * t * BEZ[2].X + 3 * u * t * t * BEZ[3].X + t * t * t * BEZ[4].X
		local d = 3 * u * u * (BEZ[2].X - BEZ[1].X) + 6 * u * t * (BEZ[3].X - BEZ[2].X) + 3 * t * t * (BEZ[4].X - BEZ[3].X)
		if d == 0 then
			break
		end
		local step = (fx - x) / d
		t = math.clamp(t - step, 0, 1)
		if math.abs(step) < 0.001 then
			break
		end
	end
	return bezPoint(t)
end

-- obj/Bezier._buildEaseLUT: 65 samples, lerped in getEase.
local EASE_LUT = {}
for i = 0, 64 do
	EASE_LUT[i] = bezSolve(i / 64)
end

-- mod/tween.fromParams feeds callbacks `1 - bezier:getEase(elapsed / duration).y`.
local function ease(t: number): number
	local x = math.clamp(t, 0, 1) * 64
	local i = math.floor(x)
	local a = EASE_LUT[i]
	local b = EASE_LUT[math.min(i + 1, 64)]
	return 1 - a:Lerp(b, x - i).Y
end

--=============================================================================
-- Attribute helpers (stand in for mod/attributes)
--=============================================================================

local function attr(inst: Instance, name: string, default: any): any
	local v = inst:GetAttribute(name)
	if v == nil then
		return default
	end
	return v
end

local function attrRange(inst: Instance, name: string, default: NumberRange): NumberRange
	local v = inst:GetAttribute(name)
	if typeof(v) == "NumberRange" then
		return v
	elseif typeof(v) == "number" then
		return NumberRange.new(v, v)
	end
	return default
end

-- Random.NextNumber errors when min > max; MinInitRot is negative with MaxInitRot at 0.
local function randBetween(a: number, b: number): number
	if a == b then
		return a
	elseif a > b then
		a, b = b, a
	end
	return RNG:NextNumber(a, b)
end

--=============================================================================
-- Flipbook (mod/common/flipbook) — FlipbookTextures is a buffer of float64 asset ids
--=============================================================================

local function readFlipbook(source: Instance): { string }?
	if not source:GetAttribute("FlipbookEnabled") then
		return nil
	end
	local packed = source:GetAttribute("FlipbookTextures")
	if typeof(packed) ~= "string" or #packed < 8 then
		return nil
	end
	local buf = buffer.fromstring(packed)
	local frames = {}
	for i = 0, buffer.len(buf) // 8 - 1 do
		table.insert(frames, ("%.0f"):format(buffer.readf64(buf, i * 8)))
	end
	return #frames > 0 and frames or nil
end

--=============================================================================
-- Emitter toggling (port of shared.vfx.disable)
--
-- No colour pass: the asset keeps its authored colours. The original ran
-- morefunctions.Color() here to tint per-character from the ColorForEffects /
-- ColorForEffects2 attributes, which this game does not use.
--=============================================================================

local function setEmittersEnabled(root: Instance, enabled: boolean)
	for _, d in root:GetDescendants() do
		if d:IsA("ParticleEmitter") or d:IsA("Beam") then
			d.Enabled = enabled
		end
	end
end

--=============================================================================
-- One emission — the port of effects/mesh.emit
--=============================================================================

type Session = {
	parent: Instance,
	pools: { [BasePart]: { BasePart } },
	live: { [any]: true },
	dead: boolean,
}

local function poolGet(session: Session, template: BasePart): BasePart
	local free = session.pools[template]
	local part = free and table.remove(free)
	if not part then
		part = template:Clone()
		part.Archivable = false
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
		part.Locked = true
	end
	part.Parent = session.parent
	return part
end

local function poolFree(session: Session, template: BasePart, part: BasePart)
	if session.dead then
		part:Destroy()
		return
	end
	part.Parent = nil
	local free = session.pools[template]
	if not free then
		free = {}
		session.pools[template] = free
	end
	if #free < POOL_LIMIT then
		table.insert(free, part)
	else
		part:Destroy()
	end
end

local function emitOne(session: Session, model: Model, scale: number)
	local startPart = model:FindFirstChild("Start")
	local endPart = model:FindFirstChild("End")
	if not (startPart and endPart and startPart:IsA("BasePart") and endPart:IsA("BasePart")) then
		return -- utility.isMeshVFX() failed
	end

	-- ---- read the recipe ---------------------------------------------------
	local fallback = attr(model, "Duration", 1)
	local range = attrRange(model, "EffectDuration", NumberRange.new(fallback, fallback))
	local life = randBetween(range.Min, range.Max)
	if life <= 0 then
		return
	end

	-- Mesh_/Decal_ transparency defaults hinge on whether Start carries a Decal.
	local hasDecal = startPart:FindFirstChildOfClass("Decal") ~= nil
	local meshDefault = hasDecal and 1 or 0
	local tA = attr(model, "Part_Transparency_Start", attr(model, "Mesh_StartTransparency", meshDefault))
	local tB = attr(model, "Part_Transparency_End", attr(model, "Mesh_EndTransparency", meshDefault))
	local dA = attr(model, "Decal_StartTransparency", 0)
	local dB = attr(model, "Decal_EndTransparency", 1)

	local rsRangeA = attrRange(model, "Part_RotSpeed_Start", ZERO_RANGE)
	local rsRangeB = attrRange(model, "Part_RotSpeed_End", ZERO_RANGE)
	local rsA = randBetween(rsRangeA.Min, rsRangeA.Max)
	local rsB = randBetween(rsRangeB.Min, rsRangeB.Max)

	local minRot = attr(model, "MinInitRot", Vector3.zero)
	local maxRot = attr(model, "MaxInitRot", Vector3.zero)
	local initRot = Vector3.new(
		randBetween(minRot.X, maxRot.X),
		randBetween(minRot.Y, maxRot.Y),
		randBetween(minRot.Z, maxRot.Z)
	) * DEG

	-- The SIGN of the random initial rotation picks the spin axis; RotSpeed is the rate.
	local axis = Vector3.new(math.sign(initRot.X), math.sign(initRot.Y), math.sign(initRot.Z))
	local rotAroundOrigin = attr(model, "RotAroundOrigin", false)
	local syncPosition = FORCE_SYNC_POSITION or attr(model, "SyncPosition", false) == true

	local spread = attr(model, "SpreadAngle", Vector3.zero)
	local spreadCF = CFrame.fromOrientation(math.rad(randBetween(-spread.X, spread.X)), math.rad(randBetween(-spread.Y, spread.Y)), 0)

	-- ---- spawn -------------------------------------------------------------
	-- Origin cached HERE. With SyncPosition false it is never re-read, so the puff stays
	-- put while the tornado travels on (the trail). With it true the render loop re-reads
	-- startPart.CFrame each frame and the puff rides the rig instead.
	local origin = startPart.CFrame
	local offset = startPart.CFrame:ToObjectSpace(endPart.CFrame)
	local sizeA, sizeB = startPart.Size * scale, endPart.Size * scale

	local clone = poolGet(session, startPart)
	clone.Size = sizeA
	clone.Transparency = tA
	clone.CFrame = origin * spreadCF

	local meshA = startPart:FindFirstChildOfClass("SpecialMesh")
	local meshB = endPart:FindFirstChildOfClass("SpecialMesh")
	local meshC = clone:FindFirstChildOfClass("SpecialMesh")
	local mScaleA, mScaleB
	if meshC and meshA and meshB then
		mScaleA, mScaleB = meshA.Scale * scale, meshB.Scale * scale
		meshC.Scale = mScaleA
	end

	local decals = {}
	for _, d in clone:GetChildren() do
		if d:IsA("Decal") then
			-- A decal's own Transparency_Start / _End override the model's Decal_* pair:
			-- effects/mesh does get(decal, "Transparency_Start", Decal_StartTransparency).
			local eA = attr(d, "Transparency_Start", dA)
			local eB = attr(d, "Transparency_End", dB)
			d.Transparency = eA
			local frames = readFlipbook(d)
			-- Framework default for Flipbook_Change_Duration is the EFFECT duration, not 0
			-- (effects/mesh: get(decal, "Flipbook_Change_Duration", v17)). Only when it
			-- resolves to 0 does the flipbook stall and the authored Texture survive.
			local changeDuration = frames and attr(d, "Flipbook_Change_Duration", life) or 0
			table.insert(decals, { decal = d, frames = frames, duration = changeDuration, tA = eA, tB = eB })
		end
	end

	-- See DECAL_TO_MESH_TEXTURE. When active, the mesh wears the decal's texture and the
	-- part's transparency carries the decal's fade, so decal-on-FileMesh models render.
	local decalDrivesPart = false
	local driveA, driveB = 0, 1
	if DECAL_TO_MESH_TEXTURE and meshC and #decals > 0 and meshC.MeshType == Enum.MeshType.FileMesh and meshC.TextureId == "" then
		local first = decals[1]
		if first.decal.Texture ~= "" or first.frames then
			if first.decal.Texture ~= "" then
				meshC.TextureId = first.decal.Texture
			end
			for _, entry in decals do
				entry.decal.Transparency = 1
			end
			decalDrivesPart = true
			driveA, driveB = first.tA, first.tB
			clone.Transparency = driveA
		end
	end

	if DEBUG then
		local d1 = decals[1]
		print(string.format(
			"[TornadoVFX] %s  life=%.2f  sync=%s  pos=%s  size=%s  partT=%.3f->%.3f  decals=%d  decalT=%.3f->%.3f  frames=%d/%.2fs  tex=%s  mesh=%s",
			model.Name, life, tostring(syncPosition), tostring(origin.Position), tostring(sizeA), tA, tB, #decals,
			d1 and d1.tA or dA, d1 and d1.tB or dB,
			d1 and d1.frames and #d1.frames or 0, d1 and d1.duration or 0,
			d1 and d1.decal.Texture or "-",
			meshC and (meshC.MeshId .. " tex:" .. (meshC.TextureId ~= "" and meshC.TextureId or "<none>")) or "-"
			))
	end

	-- ---- drive -------------------------------------------------------------
	local acc = CFrame.fromOrientation(initRot.X, initRot.Y, initRot.Z)
	local elapsed = 0
	local conn
	local function stop()
		if not conn then
			return
		end
		conn:Disconnect()
		conn = nil
		session.live[stop] = nil
		poolFree(session, startPart, clone)
	end

	conn = RunService.RenderStepped:Connect(function(dt)
		if not clone.Parent then
			stop()
			return
		end
		elapsed += dt
		local a = ease(math.min(elapsed / life, 1))

		local rate = rsA + (rsB - rsA) * a
		local step = axis * rate * dt
		acc *= CFrame.fromOrientation(step.X, step.Y, step.Z)

		-- SyncPosition: re-read the emitting part's live transform so the puff tracks the
		-- rig, instead of using the origin cached at emit time.
		local frameOrigin = origin
		if syncPosition and startPart.Parent then
			frameOrigin = startPart.CFrame
		end

		local lerped = CFrame.identity:Lerp(offset, a)
		local base = if rotAroundOrigin then frameOrigin * spreadCF * acc * lerped else frameOrigin * spreadCF * lerped * acc
		clone.CFrame = if SPIN_APPLIED_TWICE then base * acc else base

		clone.Size = sizeA:Lerp(sizeB, a)
		clone.Transparency = if decalDrivesPart then driveA + (driveB - driveA) * a else tA + (tB - tA) * a

		if meshC and mScaleA then
			meshC.Scale = mScaleA:Lerp(mScaleB, a)
		end

		for _, entry in decals do
			if not decalDrivesPart then
				entry.decal.Transparency = entry.tA + (entry.tB - entry.tA) * a
			end
			if entry.frames and entry.duration > 0 then
				local fa = math.clamp(elapsed / entry.duration, 0, 1)
				local idx = math.clamp(math.round(#entry.frames * fa), 1, #entry.frames)
				local texture = "rbxassetid://" .. entry.frames[idx]
				if decalDrivesPart and meshC then
					meshC.TextureId = texture
				else
					entry.decal.Texture = texture
				end
			end
		end

		if elapsed >= life then
			stop()
		end
	end)

	session.live[stop] = true
end

--=============================================================================
-- Spawn — the port of StormOfRuinTornado.Execute
--=============================================================================

--[[
	opts = {
		Anchor = BasePart,   -- the part the tornado tracks (the server's Root, as in the original)
		Asset  = Model,      -- the StormOfRuinTornado model (not parented to workspace)
		Parent = Instance?,  -- where the rig and puffs go (default workspace)
		Scale  = number?,    -- uniform scale on sizes (default 1)
		Sound  = boolean?,   -- set false to skip the two Sounds (default true)
	}
	Returns a function that ends the effect early.
]]
function TornadoVFX.Spawn(opts)
	local anchor: BasePart = opts.Anchor
	local asset: Model = opts.Asset
	if not (anchor and anchor.Parent and asset) then
		warn("[TornadoVFX] missing Anchor or Asset")
		return function() end
	end

	local parent = opts.Parent or workspace
	local scale = opts.Scale or 1

	local rig = asset:Clone()
	rig.Parent = parent

	-- We drive emission ourselves; strip the framework's tags so nothing double-drives
	-- this rig if EmitModule is ever added to the place.
	for _, d in rig:GetDescendants() do
		CollectionService:RemoveTag(d, "ConstantVFX")
		CollectionService:RemoveTag(d, "LoadVFXTextures")
	end

	-- shared.vfx.enable(clone) — the last line of the original Execute(). EmitCount = 0
	-- only suppresses the framework's burst path; these still run as ordinary Roblox
	-- emitters riding the rig as it travels, and they are a large part of the look.
	setEmittersEnabled(rig, true)

	local session: Session = { parent = parent, pools = {}, live = {}, dead = false }

	-- Collect the emitters: every child Model that satisfies isMeshVFX.
	-- EmitCount = 0 on `Model` (and on every ParticleEmitter in the asset) makes them
	-- self-suppress here exactly as they do in the original.
	local emitters = {}
	for _, child in rig:GetChildren() do
		if child:IsA("Model") then
			local s, e = child:FindFirstChild("Start"), child:FindFirstChild("End")
			if s and e and s:IsA("BasePart") and e:IsA("BasePart") then
				table.insert(emitters, {
					model = child,
					rate = attr(child, "Rate", DEFAULT_RATE),
					count = attr(child, "EmitCount", 1),
					last = 0,
				})
			end
		end
	end

	if DEBUG then
		local names = {}
		for _, e in emitters do
			table.insert(names, ("%s(rate=%s count=%s)"):format(e.model.Name, tostring(e.rate), tostring(e.count)))
		end
		print(("[TornadoVFX] Spawn: anchor=%s asset=%s parent=%s emitters=%d -> %s")
			:format(anchor:GetFullName(), asset.Name, parent:GetFullName(), #emitters, table.concat(names, ", ")))
	end

	--local loopSound, endSound
	--if opts.Sound ~= false then
	--	loopSound = Instance.new("Sound")
	--	loopSound.SoundId = SOUND_LOOP_ID
	--	loopSound.Looped = true
	--	loopSound.Volume = SOUND_VOLUME
	--	loopSound.Parent = anchor
	--	loopSound:Play()

	--	endSound = Instance.new("Sound")
	--	endSound.SoundId = SOUND_END_ID
	--	endSound.Looped = false
	--	endSound.Volume = SOUND_VOLUME
	--	endSound.Parent = anchor
	--end
	
	local SoundHandler = require(game:GetService("ReplicatedStorage").Modules.SoundHandler)
	
	local carrier = Instance.new("Part")
	carrier.Anchored = true
	carrier.CanCollide = false
	carrier.CanQuery = false
	carrier.CanTouch = false
	carrier.Transparency = 1
	carrier.Size = Vector3.one
	carrier.CFrame = CFrame.new(anchor.Position)
	carrier.Parent = parent
	
	local lastAnchorPos = anchor.Position

	local S1 = SoundHandler:AddSound(script.Parent.SandHole, carrier)
	local S2 = SoundHandler:AddSound(script.Parent.Sandstorm, anchor)
	local S3 = SoundHandler:AddSound(script.Parent.Sandstorm2, anchor)
	task.delay(2, function()
		SoundHandler:AddSound(script.Parent.SandstormEnd, carrier)
	end)

	local finished = false
	local followConn
	local function finish()
		if finished then
			return
		end
		finished = true

		if followConn then
			followConn:Disconnect()
			followConn = nil
		end
		setEmittersEnabled(rig, false)
		carrier.CFrame = CFrame.new(lastAnchorPos)
		SoundHandler:StopSound(S3, .5)
		--if loopSound then
		--	local fade = TweenService:Create(
		--		loopSound,
		--		TweenInfo.new(SOUND_FADE, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
		--		{ Volume = 0 }
		--	)
		--	fade:Play()
		--	endSound:Play()
		--	task.delay(CLEANUP_DELAY, function()
		--		fade:Cancel()
		--		loopSound:Stop()
		--		loopSound:Destroy()
		--		endSound:Stop()
		--		endSound:Destroy()
		--	end)
		--end

		-- Puffs already in flight finish their own lives (<= ~1s), same as the original.
		task.delay(CLEANUP_DELAY, function()
			session.dead = true
			for stop in session.live do
				stop()
			end
			table.clear(session.live)
			for _, free in session.pools do
				for _, part in free do
					part:Destroy()
				end
			end
			table.clear(session.pools)
			rig:Destroy()
			carrier:Destroy()
		end)
	end

	-- One connection for both follow and emission, so emissions always read the
	-- position the rig was moved to THIS frame (the original relies on connection
	-- order for the same guarantee).
	followConn = RunService.RenderStepped:Connect(function()
		if not (anchor and anchor:IsDescendantOf(workspace)) then
			finish()
			return
		end

		-- Identity rotation is deliberate: the rig translates, it never spins.
		lastAnchorPos = anchor.Position
		rig:PivotTo(CFrame.new(anchor.Position + FOLLOW_OFFSET))
		carrier.CFrame = CFrame.new(anchor.Position)

		local now = os.clock()
		for _, e in emitters do
			if e.rate > 0 and now - e.last > 1 / e.rate then
				e.last = now
				for _ = 1, e.count do
					emitOne(session, e.model, scale)
				end
			end
		end
	end)

	return finish
end

return TornadoVFX
