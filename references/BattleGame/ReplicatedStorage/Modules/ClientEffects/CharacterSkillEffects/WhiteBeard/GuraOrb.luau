--[[
	GuraOrb (shared client module) — the new Whitebeard orb used by every Gura move.
	Location: ReplicatedStorage.Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraOrb
	Child:    GuraBall_Animated  (move it here from GuraPunchNew)

	Usage
		local GuraOrb = require(ReplicatedStorage.Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraOrb)

		local orb = GuraOrb.attach(attacker, attacker["Left Arm"], CFrame.new(0, -0.7, 0), {
			Scale = 1.45,   -- optional, see Defaults
			FadeIn = 0.5,
		})
		orb.stop()            -- grow x1.25 + fade out (GPO ending)
		orb.stop(0)           -- remove instantly
		GuraOrb.freeze(attacker, 0.3)   -- hit-stop: pauses every orb this attacker has
		GuraOrb.stopAll(attacker)

	Each orb has: the boil animation, the x1.25 size pulse, the particle flare (GPO GuraBall),
	and the per-frame neon trail (GPO BallTrail).
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)

local RNG = Random.new()
local BASE_SCALE = 1.45 -- the size the defaults below were tuned for (old Original Ball size)

local GuraOrb = {}

GuraOrb.Defaults = {
	AnimId = "rbxassetid://135066706819340", -- boil animation (must be owned by the game's owner)
	Scale = BASE_SCALE, -- GuraBall_Animated is ~1 stud; the old Original Ball was ~1.45
	FadeIn = 0.5,
	FadeOut = 0.25, -- GPO ending: grow x1.25 + fade
	Pulse = 1.25, -- GPO: Size * 1.25, 0.25s Sine Out, reverses forever
	PulseTime = 0.25,
	FlareStart = 12, -- GPO flare: big -> small over 2s while slowing to quarter speed
	FlareEnd = 4,
	FlareTime = 2,
	Trail = true,
	TrailColor = Color3.fromRGB(102, 207, 255),
	TrailWidth = 1.6, -- at BASE_SCALE; scales with Scale
	TrailFade = 0.25,
	TrailStep = 0.05,
}

local Active: { [Model]: { any } } = {}

local function opt(options: any, key: string): any
	if options and options[key] ~= nil then
		return options[key]
	end
	return GuraOrb.Defaults[key]
end

---------------------------------------------------------------------------------------------------
-- Trail (GPO BallTrail)
---------------------------------------------------------------------------------------------------
local trailTemplate: BasePart? = nil

local function getTrailTemplate(): BasePart
	if trailTemplate then
		return trailTemplate
	end
	-- Drop GPO's BallTrail "Part" under this module and name it "TrailPart" to use it instead.
	local custom = script:FindFirstChild("TrailPart")
	if custom then
		trailTemplate = custom
		return custom
	end

	local p = Instance.new("Part")
	p.Name = "GuraTrailSegment"
	p.Size = Vector3.one
	p.Material = Enum.Material.Neon
	p.Anchored = true
	p.CanCollide = false
	p.CanQuery = false
	p.CanTouch = false
	p.CastShadow = false

	local mesh = Instance.new("CylinderMesh")
	mesh.Name = "Mesh"
	mesh.Parent = p

	local att = Instance.new("Attachment")
	att.Parent = p

	local pe = Instance.new("ParticleEmitter")
	pe.Texture = "rbxassetid://1084996976" -- same texture GPO's trail uses
	pe.LightEmission = 1
	pe.LightInfluence = 0
	pe.Lifetime = NumberRange.new(0.25, 1)
	pe.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.16, 0.16),
		NumberSequenceKeypoint.new(1, 0),
	})
	pe.Speed = NumberRange.new(1, 4)
	pe.SpreadAngle = Vector2.new(180, 180)
	pe.Rate = 0
	pe.Enabled = false
	pe.Parent = att

	trailTemplate = p
	return p
end

local function runTrail(followPart: BasePart, isAlive: () -> boolean, width: number, fade: number, step: number, color: Color3)
	local template = getTrailTemplate()
	local last = followPart.Position
	local conn: RBXScriptConnection
	conn = RunService.RenderStepped:Connect(function()
		if not isAlive() or not followPart.Parent then
			conn:Disconnect()
			return
		end

		local now = followPart.Position
		local len = (now - last).Magnitude
		if len < step then
			return
		end

		local seg = template:Clone()
		seg.Color = color
		-- Same math as GPO: point from the last spot to the new one, stand the cylinder up along it, center it.
		seg.CFrame = CFrame.lookAt(last, now) * CFrame.Angles(math.pi / 2, 0, 0) * CFrame.new(0, -len / 2, 0)
		seg.Mesh.Scale = Vector3.new(width, len, width)
		seg.Parent = workspace.World.Visuals

		local pe = seg:FindFirstChildWhichIsA("ParticleEmitter", true)
		if pe then
			pe:Emit(2)
		end

		TS:Create(seg.Mesh, TweenInfo.new(fade, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Scale = Vector3.new(0, len, 0),
		}):Play()
		Debris:AddItem(seg, fade + 2)

		last = now
	end)
	return conn
end

---------------------------------------------------------------------------------------------------
-- Orb
---------------------------------------------------------------------------------------------------
function GuraOrb.attach(attacker: Model, part: BasePart, offset: CFrame?, options: any?)
	local scale = opt(options, "Scale")
	local ratio = scale / BASE_SCALE

	local ball = script.GuraBall_Animated:Clone()
	local root: BasePart = ball.RootPart
	local inside: BasePart = ball.Inside
	local outside: BasePart = ball.Outside

	ball:ScaleTo(scale)

	-- Optional: carry an old ball's particle attachments over (e.g. CopyParticlesFrom = script["Original Ball"])
	local copyFrom = options and options.CopyParticlesFrom
	if copyFrom then
		for oldName, newPart in { Neon = inside, Force = outside } do
			local oldPart = copyFrom:FindFirstChild(oldName)
			if oldPart then
				for _, child in oldPart:GetChildren() do
					if child:IsA("Attachment") then
						child:Clone().Parent = newPart
					end
				end
			end
		end
	end

	for _, p in ball:GetDescendants() do
		if p:IsA("BasePart") then
			p.Anchored = false
			p.CanCollide = false
			p.CanQuery = false
			p.CanTouch = false
			p.CastShadow = false
			p.Massless = true
		end
	end

	local weld = Instance.new("Weld")
	weld.Part0 = part
	weld.Part1 = root
	weld.C0 = offset or CFrame.identity
	weld.Parent = root

	local fadeIn = opt(options, "FadeIn")
	if fadeIn > 0 then
		inside.Transparency = 1
		outside.Transparency = 1
	end
	ball.Parent = workspace.World.Visuals

	if fadeIn > 0 then
		local fadeInfo = TweenInfo.new(fadeIn, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
		TS:Create(inside, fadeInfo, { Transparency = 0 }):Play()
		TS:Create(outside, fadeInfo, { Transparency = 0 }):Play()
	end

	-- Boil animation
	local track: AnimationTrack? = nil
	local controller = ball:FindFirstChildOfClass("AnimationController")
	if controller then
		local animator = controller:FindFirstChildOfClass("Animator") or Instance.new("Animator")
		animator.Parent = controller
		local anim = Instance.new("Animation")
		anim.AnimationId = opt(options, "AnimId")
		local ok, loaded = pcall(function()
			return animator:LoadAnimation(anim)
		end)
		if ok and loaded then
			track = loaded
			loaded.Looped = true
			loaded:Play(0)
			loaded:AdjustSpeed(RNG:NextNumber(0.9, 1.15)) -- each orb boils a little differently
			task.spawn(function()
				local t0 = os.clock()
				while loaded.Length == 0 and os.clock() - t0 < 3 do
					task.wait()
				end
				if loaded.Length > 0 and loaded.IsPlaying then
					loaded.TimePosition = RNG:NextNumber(0, loaded.Length)
				end
			end)
		else
			warn("GuraOrb: couldn't load the boil animation:", loaded)
		end
	end

	-- Size pulse
	local pulse = opt(options, "Pulse")
	local pulseInfo = TweenInfo.new(opt(options, "PulseTime"), Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true)
	local pulses = {
		TS:Create(inside, pulseInfo, { Size = inside.Size * pulse }),
		TS:Create(outside, pulseInfo, { Size = outside.Size * pulse }),
	}
	for _, t in pulses do
		t:Play()
	end

	-- Particle flare
	local flare = root:FindFirstChild("Attachment") and root.Attachment:FindFirstChild("ParticleEmitter")
	local flareConn: RBXScriptConnection? = nil
	if flare then
		local fStart, fEnd, fTime = opt(options, "FlareStart") * ratio, opt(options, "FlareEnd") * ratio, opt(options, "FlareTime")
		flare.Enabled = true
		local t0 = os.clock()
		flareConn = RunService.Heartbeat:Connect(function()
			local a = math.clamp((os.clock() - t0) / fTime, 0, 1)
			local e = 1 - (1 - a) * (1 - a) -- Quad Out
			flare.Size = NumberSequence.new(fStart + (fEnd - fStart) * e, 0)
			flare.TimeScale = 1 + (0.25 - 1) * e
			if a >= 1 and flareConn then
				flareConn:Disconnect()
				flareConn = nil
			end
		end)
	end

	local alive = true

	local trailConn: RBXScriptConnection? = nil
	if opt(options, "Trail") then
		trailConn = runTrail(root, function()
			return alive
		end, (options and options.TrailWidth) or GuraOrb.Defaults.TrailWidth * ratio, opt(options, "TrailFade"), opt(options, "TrailStep"), opt(options, "TrailColor"))
	end

	local state = {
		Model = ball,
		Inside = inside,
		Outside = outside,
		Root = root,
	}

	function state.freeze(duration: number)
		if not alive then
			return
		end
		local speed = track and track.Speed or 0
		if track and speed ~= 0 then
			track:AdjustSpeed(0)
		end
		for _, t in pulses do
			t:Pause()
		end
		task.delay(duration, function()
			if not alive then
				return
			end
			if track and track.IsPlaying and track.Speed == 0 and speed ~= 0 then
				track:AdjustSpeed(speed)
			end
			for _, t in pulses do
				t:Play()
			end
		end)
	end

	function state.stop(fadeTime: number?)
		if not alive then
			return
		end
		alive = false

		local list = Active[attacker]
		if list then
			local i = table.find(list, state)
			if i then
				table.remove(list, i)
			end
			if #list == 0 then
				Active[attacker] = nil
			end
		end

		if state._ancestryConn then
			state._ancestryConn:Disconnect()
		end
		if trailConn then
			trailConn:Disconnect()
		end
		if flareConn then
			flareConn:Disconnect()
		end
		for _, t in pulses do
			t:Cancel()
		end

		local fade = fadeTime or opt(options, "FadeOut")
		if fade <= 0 then
			ball:Destroy()
			return
		end

		if track then
			track:Stop(0.1)
		end
		EffectUtilities.ToggleVFX(ball, false)

		local outInfo = TweenInfo.new(fade, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
		for _, p in { inside, outside } do
			TS:Create(p, outInfo, { Size = p.Size * 1.25, Transparency = 1 }):Play()
		end
		Debris:AddItem(ball, fade + 1.25) -- let particles already in the air finish
	end

	Active[attacker] = Active[attacker] or {}
	table.insert(Active[attacker], state)

	-- Safety net: attacker removed without the move cleaning up
	local ancestryConn
	ancestryConn = attacker.AncestryChanged:Connect(function(_, parent)
		if not parent then
			state.stop(0)
		end
	end)
	state._ancestryConn = ancestryConn

	return state
end

-- Hit-stop: pause every orb this attacker currently has.
function GuraOrb.freeze(attacker: Model, duration: number)
	for _, state in Active[attacker] or {} do
		state.freeze(duration)
	end
end

function GuraOrb.stopAll(attacker: Model, fadeTime: number?)
	local list = Active[attacker]
	if not list then
		return
	end
	for _, state in table.clone(list) do
		state.stop(fadeTime)
	end
end

return GuraOrb