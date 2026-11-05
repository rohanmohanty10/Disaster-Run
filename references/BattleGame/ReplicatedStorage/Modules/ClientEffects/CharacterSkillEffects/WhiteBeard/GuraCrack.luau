--[[
	GuraCrack (shared client module) — GuraPunchNew's crack + break, usable from any Gura move.
	Location: ReplicatedStorage.Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraCrack
	Child:    Gura Crack   (a COPY of GuraPunchNew's "Gura Crack": Gura1, Gura2, Gura3, guraglass1)

	Usage
		local GuraCrack = require(ReplicatedStorage.Modules.ClientEffects.CharacterSkillEffects.WhiteBeard.GuraCrack)

		GuraCrack.play(placement, {
			Orientation = "Ground", -- "Wall" (like GuraPunchNew), "Ground" (lying flat), or "Side" (standing, facing sideways)
			Scale = 0.7,            -- 1 = GuraPunchNew size (~32 studs across)
			BreakAfter = 1,         -- seconds until it breaks (match the move's own timer)
			Seed = argumentData.Seed, -- optional: same random spin on every client
			Burst = nil,            -- optional Vector3: which way the glass shards fly (defaults per Orientation)
			Grow = nil,             -- optional seconds: crack spreads in (Gura3 -> Gura2 -> Gura1 -> glass) instead of popping in
		})

	Breaking is the same as GuraPunchNew:
	  - Gura1 / Gura2 / Gura3 fly apart with shatterAndDestroy (radial order, spin, outward kick, shrink).
	  - guraglass1 (one mesh) gets the JJS-style fake break: flash, vanish, generated glass shards fly out.
]]

local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")

local RNG = Random.new()

local GuraCrack = {}

-- Rotation applied before the random spin, per orientation.
-- The model's local Y axis is its thin axis, so:
--   Ground: no extra rotation  -> lies flat
--   Wall:   -90 deg about X    -> stands up facing forward (GuraPunchNew's authored rotation)
--   Side:   90 deg about Z     -> stands up facing left/right
local ORIENT = {
	Ground = CFrame.identity,
	Wall = CFrame.Angles(-math.pi / 2, 0, 0),
	Side = CFrame.Angles(0, 0, math.pi / 2),
}

-- Grow-in order (smallest first, glass last). Anything not listed grows in after these.
GuraCrack.GrowOrder = { "Gura3", "Gura2", "Gura1", "guraglass1" }

GuraCrack.Glass = {
	SHARDS = 22,
	LIFE = 0.6,
	FLASH = 0.12,
}

---------------------------------------------------------------------------------------------------
-- Break helpers (same as GuraPunchNew)
---------------------------------------------------------------------------------------------------
local function shatterAndDestroy(model: Instance, origin: Vector3?)
	local LIFETIME = 0.55
	local SHRINK_TO = 0.25
	local STAGGER = 0.008
	local SPIN = 12
	local KICK = 14

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
		p.Massless = false

		local out = (p.Position - root)
		out = out.Magnitude > 0.01 and out.Unit or Vector3.yAxis

		local vel = out * KICK * (0.5 + math.random()) + Vector3.new(0, 5, 0)
		local spin = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5).Unit * SPIN

		task.delay((i - 1) * STAGGER, function()
			if not p.Parent then
				return
			end
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

local function fakeGlassBreak(glassModel: Instance, origin: Vector3, burst: Vector3, sizeScale: number)
	local G = GuraCrack.Glass
	local srcPart = glassModel:FindFirstChildWhichIsA("BasePart", true)
	if not srcPart then
		glassModel:Destroy()
		return
	end

	local srcHL = srcPart:FindFirstChildWhichIsA("Highlight") or glassModel:FindFirstChildWhichIsA("Highlight", true)
	local hlTemplate = srcHL and srcHL:Clone()

	if srcHL then
		srcHL.FillColor = Color3.new(1, 1, 1)
		srcHL.FillTransparency = 0.2
		TS:Create(srcHL, TweenInfo.new(G.FLASH), { FillTransparency = 1, OutlineTransparency = 1 }):Play()
	end
	task.delay(G.FLASH, function()
		if glassModel.Parent then
			glassModel:Destroy()
		end
	end)

	local cf, size = srcPart.CFrame, srcPart.Size

	local shards = Instance.new("Model")
	shards.Name = "GuraGlassShards"
	if hlTemplate then
		hlTemplate.Adornee = nil
		hlTemplate.Parent = shards
	end
	shards.Parent = workspace.World.Visuals

	local shrinkInfo = TweenInfo.new(G.LIFE, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)
	for _ = 1, G.SHARDS do
		local r = math.sqrt(RNG:NextNumber()) * 0.9
		local a = RNG:NextNumber(0, math.pi * 2)
		-- glass is thin along its local Z, so shards are scattered across its local X/Y
		local localPos = Vector3.new(math.cos(a) * r * size.X / 2, math.sin(a) * r * size.Y / 2, 0)

		local p = Instance.new("Part")
		p.Size = Vector3.new(RNG:NextNumber(1.2, 4.5) * sizeScale, RNG:NextNumber(1.2, 4.5) * sizeScale, 0.15)
		p.CFrame = cf * CFrame.new(localPos) * CFrame.Angles(0, 0, RNG:NextNumber(0, math.pi * 2))
		p.Material = srcPart.Material
		p.Color = srcPart.Color
		p.Transparency = hlTemplate and srcPart.Transparency or 0.4
		p.Anchored = false
		p.CanCollide = false
		p.CanQuery = false
		p.CanTouch = false
		p.CastShadow = false
		p.Parent = shards

		local out = p.Position - origin
		out = out.Magnitude > 0.01 and out.Unit or burst
		p.AssemblyLinearVelocity = out * RNG:NextNumber(18, 40)
			+ burst * RNG:NextNumber(10, 28)
			+ Vector3.new(0, RNG:NextNumber(4, 12), 0)
		p.AssemblyAngularVelocity = Vector3.new(RNG:NextNumber(-12, 12), RNG:NextNumber(-12, 12), RNG:NextNumber(-12, 12))

		TS:Create(p, shrinkInfo, { Size = Vector3.zero }):Play()
	end

	Debris:AddItem(shards, G.LIFE + 0.1)
end

-- Same idea as the old growCrack: each layer starts hidden and fades in, one after another.
-- Works for both visible parts (Gura1) and Highlight-only parts (Gura2, Gura3, guraglass1).
local function growIn(model: Instance, total: number, isBroken: () -> boolean)
	local groups, seen = {}, {}
	for _, name in GuraCrack.GrowOrder do
		local g = model:FindFirstChild(name)
		if g then
			table.insert(groups, g)
			seen[g] = true
		end
	end
	for _, c in model:GetChildren() do
		if not seen[c] then
			table.insert(groups, c)
		end
	end

	local fade = total * 0.5
	local stagger = #groups > 1 and (total - fade) / (#groups - 1) or 0
	local fadeInfo = TweenInfo.new(fade, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	for i, g in groups do
		local items = {}
		local list = g:GetDescendants()
		table.insert(list, g)
		for _, d in list do
			if d:IsA("BasePart") and d.Transparency < 1 then
				table.insert(items, { d, { Transparency = d.Transparency } })
				d.Transparency = 1
			elseif d:IsA("Highlight") then
				table.insert(items, { d, { FillTransparency = d.FillTransparency, OutlineTransparency = d.OutlineTransparency } })
				d.FillTransparency = 1
				d.OutlineTransparency = 1
			end
		end

		task.delay((i - 1) * stagger, function()
			if isBroken() then
				return
			end
			for _, item in items do
				if item[1].Parent then
					TS:Create(item[1], fadeInfo, item[2]):Play()
				end
			end
		end)
	end
end

---------------------------------------------------------------------------------------------------
-- API
---------------------------------------------------------------------------------------------------
function GuraCrack.play(placement: CFrame, options: any?)
	options = options or {}
	local orientation = options.Orientation or "Ground"
	local scale = options.Scale or 1
	local breakAfter = options.BreakAfter or 1
	local rng = options.Seed and Random.new(options.Seed) or RNG

	-- On the ground, lift it a hair so the glass panel isn't half buried
	if orientation == "Ground" then
		placement = placement * CFrame.new(0, (options.Lift or 0.3) * scale, 0)
	end

	local clone = script["Gura Crack"]:Clone()
	if scale ~= 1 then
		clone:ScaleTo(clone:GetScale() * scale)
	end

	local spin = CFrame.Angles(0, rng:NextNumber(0, math.pi * 2), 0)
	clone:PivotTo(placement * (ORIENT[orientation] or ORIENT.Ground) * spin)

	-- guraglass is one mesh, so it gets the fake break instead of shatterAndDestroy
	local glass = clone:FindFirstChild("guraglass1")
	if glass then
		for _, d in glass:GetDescendants() do
			if d:IsA("BasePart") then
				d:SetAttribute("NoShatter", true)
			end
		end
	end

	clone.Parent = workspace.World.Visuals

	local burst = options.Burst
	if not burst then
		if orientation == "Wall" then
			burst = placement.LookVector
		elseif orientation == "Side" then
			burst = placement.RightVector
		else
			burst = placement.UpVector
		end
	end

	local handle = {}
	local broken = false

	if options.Grow and options.Grow > 0 then
		growIn(clone, options.Grow, function()
			return broken
		end)
	end

	function handle.breakNow()
		if broken then
			return
		end
		broken = true
		if not clone.Parent then
			return
		end
		if glass and glass.Parent then
			fakeGlassBreak(glass, placement.Position, burst.Unit, scale)
		end
		shatterAndDestroy(clone, placement.Position)
	end

	function handle.destroy()
		broken = true
		if clone.Parent then
			clone:Destroy()
		end
	end

	if breakAfter >= 0 then
		task.delay(breakAfter, handle.breakNow)
	end

	handle.Model = clone
	return handle
end

return GuraCrack