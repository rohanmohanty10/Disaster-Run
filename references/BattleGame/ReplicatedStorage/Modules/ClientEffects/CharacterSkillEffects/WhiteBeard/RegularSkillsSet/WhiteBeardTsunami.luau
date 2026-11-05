-- WhiteBeardTsunami — client effect handler (rewrite)
--
-- Timeline (all keyed off one `elapsed`, seconds since spawn):
--   RISE    : 0 .. riseTime      -- emerges from the ground while it starts travelling
--   TRAVEL  : .. duration        -- rides Start -> Target, matching the server hitbox
--   SINK    : duration ..        -- keeps going forward at full speed, sinks into the ground, then removed
--
-- Payload: { SkillType="wave", Start, Target, Direction, Speed, Duration }

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer


local RockHandler = require(ReplicatedStorage.Modules.ClientEffects.RockHandler)
local GuraOrb = require(game:GetService("ReplicatedStorage").Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraOrb)
local GuraCrack = require(game:GetService("ReplicatedStorage").Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraCrack)
-- Functions
local function emitClone(clone)
	for _, v in ipairs(clone:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			local duration = v:GetAttribute("EmitDuration")
			if duration then
				v.Enabled = true
				task.delay(duration, function()
					v.Enabled = false
				end)
			else
				v:Emit(v:GetAttribute("EmitCount"))
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Tuning
--------------------------------------------------------------------------------
local OCEAN_HEIGHT   = -5    -- world Y the wave crest rides at during travel
local RISE_TIME      = 1.5   -- seconds to emerge from the ground
local RISE_DISTANCE  = 100   -- how far below OCEAN_HEIGHT it starts (≈ wave height)
local SINK_TIME     = 3     -- seconds the crash-sink takes
local SINK_DISTANCE = 200   

local MODEL_FACING_OFFSET = CFrame.identity -- CFrame.Angles(0, math.pi, 0) if it faces backwards

local RISE_EASE_STYLE = Enum.EasingStyle.Quad
local RISE_EASE_DIR   = Enum.EasingDirection.Out

local DEBUG = true -- flip true to log position each frame

--------------------------------------------------------------------------------
-- Camera-inside-wave tracking. SeaEffects reads LocalPlayer "InTsunami" and shows
-- the same underwater tint/blur/reverb as the sea. One entry per wave, so two
-- waves (or overlapping casts) can't overwrite each other.
--------------------------------------------------------------------------------
local InsideWaves = {}

--------------------------------------------------------------------------------
-- Ground rumble (camera shake) for every player while the waves travel. It builds
-- as the camera gets closer to the nearest wave. Uses shared.addshake, so the
-- player's "Camera Shake" / "Reduce Camera Shake" settings still apply.
--------------------------------------------------------------------------------
local RUMBLE_INTERVAL = 0.05 -- seconds between shake pulses
local RUMBLE_FAR      = 0.08 -- pulse strength across the map
local RUMBLE_PEAK     = 0.95  -- pulse strength at / inside a wave
local RUMBLE_RANGE    = 600  -- studs over which it builds from FAR to PEAK

local WaveRumble = {} -- [wave model] = current pulse strength
local rumbleConn
local rumbleClock = 0

local function stepRumble(dt)
	if next(WaveRumble) == nil then
		rumbleConn:Disconnect()
		rumbleConn = nil
		return
	end
	rumbleClock += dt
	if rumbleClock < RUMBLE_INTERVAL then return end
	rumbleClock = 0
	local strength = 0
	for _, s in WaveRumble do
		if s > strength then strength = s end
	end
	if strength > 0 and shared.addshake then shared.addshake(strength) end
end

local function setRumble(key, strength: number?)
	WaveRumble[key] = strength
	if strength and not rumbleConn then
		rumbleClock = 0
		rumbleConn = RunService.Heartbeat:Connect(stepRumble)
	end
end

local function setInside(key, inside: boolean)
	if (InsideWaves[key] == true) == inside then return end
	InsideWaves[key] = if inside then true else nil
	local any = next(InsideWaves) ~= nil
	if LocalPlayer:GetAttribute("InTsunami") ~= any then
		LocalPlayer:SetAttribute("InTsunami", any)
	end
end

--------------------------------------------------------------------------------
return function(data)
	local SkillType = data.SkillType
	if SkillType == "wave" then 
		local template = script:FindFirstChild("tsunami")
		if not template then
			warn("[WhiteBeardTsunami] no 'tsunami' model parented under the effect script")
			return
		end

		local startPos: Vector3 = data.Start
		local targetPos: Vector3 = data.Target
		if not startPos or not targetPos then return end

		local duration = data.Duration
		if not duration or duration <= 0 then
			warn("[WhiteBeardTsunami] bad Duration, bailing")
			return
		end

		-- Horizontal travel direction (flattened, unit).
		local dir = data.Direction
		if not dir or dir.Magnitude < 1e-3 then
			dir = targetPos - startPos
		end
		dir = Vector3.new(dir.X, 0, dir.Z)
		if dir.Magnitude < 1e-3 then return end -- degenerate; nothing sane to animate
		dir = dir.Unit

		local travelSpeed = (targetPos - startPos).Magnitude / duration
		local riseTime = math.min(RISE_TIME, duration) -- never still rising when it arrives

		local model = template:Clone()
		-- The wave mesh's box is the "inside the tsunami" volume (slightly bigger than the curl; that's fine).
		local waveMesh = model:FindFirstChild("tsunami")
		if waveMesh and not waveMesh:IsA("BasePart") then waveMesh = nil end

		-- Returns the pivot CFrame for a given elapsed time.
		local function poseAt(elapsed: number): CFrame
			-- Horizontal: lerp Start->Target during travel, then continue past Target
			-- along dir at the SAME speed during the crash.
			local flat
			if elapsed <= duration then
				flat = startPos:Lerp(targetPos, elapsed / duration)
			else
				flat = targetPos + dir * (travelSpeed * (elapsed - duration))
			end

			-- Vertical offset from OCEAN_HEIGHT: rise up, hold, then sink (clamped).
			local yOffset
			if elapsed <= duration then
				local a = math.clamp(elapsed / riseTime, 0, 1)
				local eased = TweenService:GetValue(a, RISE_EASE_STYLE, RISE_EASE_DIR)
				yOffset = -RISE_DISTANCE * (1 - eased)
			else
				local a = math.clamp((elapsed - duration) / SINK_TIME, 0, 1)
				yOffset = -SINK_DISTANCE * a
			end



			local pos = Vector3.new(flat.X, OCEAN_HEIGHT + yOffset, flat.Z)
			return CFrame.lookAlong(pos, dir) * MODEL_FACING_OFFSET
		end

		model:PivotTo(poseAt(0))
		model.Parent = workspace.World.Visuals

		--------------------------------------------------------------------------------
		-- Lifecycle: exactly ONE owner (cleanup). Debris is only a far safety net.
		--------------------------------------------------------------------------------
		local startedAt=data.StartedAt or workspace:GetServerTimeNow()
		local elapsed=math.max(0,workspace:GetServerTimeNow()-startedAt)
		local conn
		local finished = false

		local function cleanup()
			if finished then return end
			finished = true
			if conn then conn:Disconnect() conn = nil end
			setInside(model, false)
			setRumble(model, nil)
			if model.Parent then model:Destroy() end
		end
		-- Safety: if anything else removes the wave (Debris net), never leave the effects stuck on.
		model.Destroying:Once(function()
			setInside(model, false)
			setRumble(model, nil)
		end)
		
		conn = RunService.Heartbeat:Connect(function(dt)
			elapsed=math.max(0,workspace:GetServerTimeNow()-startedAt)
			model:PivotTo(poseAt(elapsed))

			-- Is the camera inside this wave? (point vs the mesh's oriented box)
			local camera = workspace.CurrentCamera
			if camera and waveMesh then
				local p = waveMesh.CFrame:PointToObjectSpace(camera.CFrame.Position)
				local half = waveMesh.Size * 0.5
				setInside(model, math.abs(p.X) <= half.X and math.abs(p.Y) <= half.Y and math.abs(p.Z) <= half.Z)

				-- Rumble: distance from the camera to this wave's box (0 when inside), squared
				-- closeness so it stays faint far away and ramps hard near the wave. It also
				-- ramps in while the wave rises and dies out while it sinks.
				local outside = Vector3.new(
					math.max(0, math.abs(p.X) - half.X),
					math.max(0, math.abs(p.Y) - half.Y),
					math.max(0, math.abs(p.Z) - half.Z))
				local closeness = 1 - math.clamp(outside.Magnitude / RUMBLE_RANGE, 0, 1)
				local fade = if elapsed > duration
					then 1 - math.clamp((elapsed - duration) / SINK_TIME, 0, 1)
					else math.clamp(elapsed / riseTime, 0, 1)
				setRumble(model, (RUMBLE_FAR + (RUMBLE_PEAK - RUMBLE_FAR) * closeness * closeness) * fade)
			end

			--if DEBUG then
			--	local p = model:GetPivot().Position
			--	print(("[TSUNAMI] t=%.2f y=%.0f parent=%s"):format(elapsed, p.Y, tostring(model.Parent)))
			--end

			-- Fully buried -> done.
			if elapsed - duration >= SINK_TIME then
				cleanup()
			end
			
			--if DEBUG then
			--	local p = model:GetPivot().Position
			--	local cam = workspace.CurrentCamera
			--	local dist = cam and (cam.CFrame.Position - p).Magnitude or -1
			--	print(("[TSUNAMI] t=%.2f y=%.0f distFromCam=%.0f parent=%s streamed=%s")
			--		:format(elapsed, p.Y, dist, tostring(model.Parent),
			--			tostring(model.PrimaryPart ~= nil and model.PrimaryPart:IsDescendantOf(workspace))))
			--end
		end)

		Debris:AddItem(model, duration + SINK_TIME + 5)
	end

	if SkillType == "collide" then
		local groundPos = data.Position
		local fixedPos = Vector3.new(groundPos.X, OCEAN_HEIGHT, groundPos.Z)

		local template = script:FindFirstChild("Crash")
		local rainTemplate = script:FindFirstChild("Rain")
		local puddleTemplate = script:FindFirstChild("Puddle")

		local axis = data.Axis
		axis = axis and Vector3.new(axis.X, 0, axis.Z) or Vector3.new(0, 0, 1)
		axis = axis.Magnitude > 1e-3 and axis.Unit or Vector3.new(0, 0, 1)

		local fx = template:Clone()
		fx:PivotTo(CFrame.lookAlong(fixedPos, axis))
		fx.Parent = workspace.World.Visuals
		
		emitClone(fx)

		Debris:AddItem(fx, 4) 
		
		
		local puddleFX = puddleTemplate:Clone()
		puddleFX:PivotTo(CFrame.lookAlong(data.PuddlePos, axis))
		--puddleFX:PivotTo(CFrame.lookAlong(fixedPos * CFrame.new(0, 10, 0), axis))
		puddleFX.Parent = workspace.World.Visuals

		emitClone(puddleFX)

		Debris:AddItem(puddleFX, 4) 
		
		
		local rainFX = rainTemplate:Clone()
		rainFX:PivotTo(CFrame.lookAlong(fixedPos + Vector3.new(0, 50, 0), axis))
		rainFX.Parent = workspace.World.Visuals
		
		emitClone(rainFX)

		Debris:AddItem(rainFX, 4) 
	end
	
	if SkillType == "Lines" then
		local character: Model = data.Attacker

		local function scaleLifetime(model: Instance, mul: number)
			for _, d in model:GetDescendants() do
				if d:IsA("ParticleEmitter") then
					local lt = d.Lifetime
					d.Lifetime = NumberRange.new(lt.Min * mul, lt.Max * mul)
				end
			end
		end

		local function speedLinesSmol(cf: CFrame, scale: number): Model?
			local fx = script.SpeedLinesStartup:Clone()

			for _, p in fx:GetDescendants() do
				if p:IsA("BasePart") then
					p.Anchored = true
					p.CanCollide = false
					p.CanQuery = false
					p.CanTouch = false
					p.CastShadow = false
				end
			end

			fx:ScaleTo(scale)
			fx:PivotTo(cf)

			-- Sustained emission, not a one-shot burst. Rate boosted, lifetimes shortened.
			scaleLifetime(fx, 1)
			for _, d in fx:GetDescendants() do
				if d:IsA("ParticleEmitter") then
					d.Rate = d.Rate * 5
					d.Enabled = true
				end
			end
			
			task.delay(1, function()
				for _, d in fx:GetDescendants() do
					if d:IsA("ParticleEmitter") then
						d.Enabled = false
					end
				end
			end)

			fx.Parent = workspace.World.Visuals
			Debris:AddItem(fx, 3)
			return fx
		end

		local linesCF = character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) --CFrame.new(0, -character.HumanoidRootPart.Size.Y, 0)
		local smol = speedLinesSmol(linesCF, 1)		
	end
	
	if SkillType == "Startup" then
		local attacker: Model = data.Attacker
		local Bind: StringValue? = data.Bind
		
		if not Bind or not Bind:IsDescendantOf(game) then
			return
		end

		local function setEmitters(model: Instance, on: boolean)
			for _, d in model:GetDescendants() do
				if d:IsA("ParticleEmitter") then
					d.Enabled = on
				end
			end
		end
		
		local function fadeOutFX(fx: Model?)
			if not fx then return end
			setEmitters(fx, false)
			Debris:AddItem(fx, 2)
		end

		local orbs = {}

		for _, armName in { "Left Arm", "Right Arm" } do
			local arm = attacker:FindFirstChild(armName)
			if not arm then
				continue
			end

			local orb = GuraOrb.attach(attacker, arm, CFrame.new(0, -0.7, 0), { Scale = 1, FadeIn = 0.5 })

			-- Keep the startup burst from the old Startup Ball
			local emit = script["Startup Ball"].Force:FindFirstChild("Emit")
			if emit then
				local burst = emit:Clone()
				burst.Parent = orb.Outside
				emitClone(burst)
			end

			table.insert(orbs, orb)
		end

		local cleaned = false
		local charConn: RBXScriptConnection?
		local bindConn: RBXScriptConnection?

		local function cleanup()
			if cleaned then return end
			cleaned = true
			if charConn then charConn:Disconnect() end
			if bindConn then bindConn:Disconnect() end

			for _, orb in orbs do
				orb.stop(0.5)
			end
		end

		charConn = attacker.AncestryChanged:Connect(function(_, parent)
			if not parent then cleanup() end
		end)
		
		bindConn = Bind.AncestryChanged:Connect(function(_, parent)
			if not parent then cleanup() end
		end)


		task.delay(1.5, function()
			cleanup()
		end)
	end
	
	
	local function shatterAndDestroy(model: Instance, origin: Vector3?)
		local LIFETIME = 0.55
		local SHRINK_TO = 0.25
		local STAGGER = 0.008
		local SPIN = 12              -- rad/s angular velocity
		local KICK = 14              -- outward burst, studs/s

		local root = origin or model:GetPivot().Position

		local parts = {}
		for _, d in model:GetDescendants() do
			if d:IsA("BasePart") and not d:GetAttribute("NoShatter") then
				table.insert(parts, d)
			end
		end
		if #parts == 0 then
			model:Destroy()
			return
		end

		-- Radial order so the break propagates outward, not in Blender's export order.
		table.sort(parts, function(a, b)
			return (a.Position - root).Magnitude < (b.Position - root).Magnitude
		end)

		for _, d in model:GetDescendants() do
			if d:IsA("Highlight") then
				TS:Create(d, TweenInfo.new(0.2), {
					FillTransparency = 1,
					OutlineTransparency = 1,
				}):Play()
			end
		end

		for i, p in parts do
			p.CanCollide = false
			p.CanQuery = false
			p.CanTouch = false
			p.CastShadow = false
			p.Massless = false           -- needs mass for gravity to act

			local out = (p.Position - root)
			out = out.Magnitude > 0.01 and out.Unit or Vector3.yAxis

			local vel = out * KICK * (0.5 + math.random()) + Vector3.new(0, 5, 0)
			local spin = Vector3.new(
				math.random() - 0.5,
				math.random() - 0.5,
				math.random() - 0.5
			).Unit * SPIN

			task.delay((i - 1) * STAGGER, function()
				if not p.Parent then return end
				p.Anchored = false
				p.AssemblyLinearVelocity = vel
				p.AssemblyAngularVelocity = spin
				TS:Create(p, TweenInfo.new(LIFETIME, Enum.EasingStyle.Linear), {
					Size = p.Size * SHRINK_TO,
				}):Play()
			end)
		end

		Debris:AddItem(model, LIFETIME + (#parts * STAGGER) + 0.2)
	end
	
	local function growCrack(model: Model, total: number)
		local TOTAL = total or 0.2
		local RINGS = { "1", "2", "3" }
		local FADE_TIME = TOTAL * 0.5
		local stagger = (TOTAL - FADE_TIME) / (#RINGS - 1)

		for i, ringName in RINGS do
			local ring = model:FindFirstChild(ringName)
			if not ring then
				warn(`growCrack: missing ring "{ringName}"`)
				continue
			end

			local parts = {}
			for _, d in ring:GetDescendants() do
				if d:IsA("BasePart") then
					d.Transparency = 1
					table.insert(parts, d)
				end
			end

			task.delay((i - 1) * stagger, function()
				for _, p in parts do
					if p.Parent then
						TweenService:Create(p, TweenInfo.new(FADE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Transparency = 0,
						}):Play()
					end
				end
			end)
		end
	end
	
	if SkillType == "cracks" then
		local attacker = data.Attacker

		local OFFSET = 4
		local CFrameToUse = data.CFrameToUse
		local rng = Random.new(data.Seed)

		-- Randomly decide which model goes on which side.
		local swap = rng:NextInteger(0, 1) == 1
		local leftModel  = swap and "2" or "1"
		local rightModel = swap and "1" or "2"

		local look = CFrameToUse.LookVector * Vector3.new(1, 0, 1)
		local facing = CFrame.lookAt(CFrameToUse.Position, CFrameToUse.Position + look.Unit)

		local function placeCrack(sideOffset)
			local placement = facing * CFrame.new(sideOffset, 0, 0)
			local crack = GuraCrack.play(placement, {
				Orientation = "Side",
				Scale = 0.8,
				BreakAfter = -1,
				Grow = 0.3,
				Seed = rng:NextInteger(1, 1000000), -- same on every client, different per side
				Burst = sideOffset < 0 and -facing.RightVector or facing.RightVector,
			})
			return crack, placement
		end

		local crack1, placement1 = placeCrack(-OFFSET)
		local crack2, placement2 = placeCrack(OFFSET)

		task.delay(2, function()
			crack1.breakNow()
			local breakFX = script.Cracks["BreakFx"]:Clone()
			breakFX:PivotTo(placement1 * breakFX:GetPivot().Rotation)
			breakFX.Parent = workspace.World.Visuals
			Debris:AddItem(breakFX, 4)
			emitClone(breakFX)

			crack2.breakNow()
			local breakFX2 = script.Cracks["BreakFx"]:Clone()
			breakFX2:PivotTo(placement2 * breakFX2:GetPivot().Rotation)
			breakFX2.Parent = workspace.World.Visuals
			Debris:AddItem(breakFX2, 4)
			emitClone(breakFX2)
		end)
		
		
		-- Rock stuff
		local sideLeftCF = CFrame.lookAlong(placement1.Position, -facing.RightVector) --left
		local sideRightCF = CFrame.lookAlong(placement2.Position, facing.RightVector) --right
		
		
		task.spawn(function() -- The outer left
			RockHandler.RockLines(sideLeftCF , {Angle = math.rad(130), NoSmoke = true, TimeTilNextRock = 0.07, HoldTime = 4, Amount = 20})
		end)
		task.spawn(function()		-- The inner left
			--RockHandler.RockLines(sideLeftCF, {RandomJitter = 0.95, SizeIndex = 0.1, Angle = math.rad(70), Amount = 20, TimeTilNextRock = 0.015, HoldTime = 3, NoSmoke = true}) 
		end)
		
		
		task.spawn(function() -- The outer right
			RockHandler.RockLines(sideRightCF , {Angle = math.rad(130), NoSmoke = true, TimeTilNextRock = 0.07, HoldTime = 4, Amount = 20})
		end)
		task.spawn(function()		-- The inner right
			--RockHandler.RockLines(sideRightCF, {RandomJitter = 0.95, SizeIndex = 0.1, Angle = math.rad(70), Amount = 20, TimeTilNextRock = 0.015, HoldTime = 3, NoSmoke = true}) 
		end)
		
		
		
		-- glass screen effect
		local IsMainPlayer = (LocalPlayer.Character == attacker)

		if IsMainPlayer then
			require(ReplicatedStorage.Modules.ClientEffects.GlassShatterWB).Play({
				Color = Color3.fromRGB(245, 245, 250), -- cyan
				ImpactPosition = Vector2.new(0.5, 0.5),
				Depth = 4,
				HoldTime = .01,
				Distance = 4,
				Thickness = 0.01,
				FallAcceleration = 150
			})
		end
	end
end
