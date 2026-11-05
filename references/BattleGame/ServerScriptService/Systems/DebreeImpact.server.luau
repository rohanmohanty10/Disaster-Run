-- ServerScriptService > DebreeImpacts   (Script, server)
--
-- JJS-style impact destruction: a character knocked flying (tagged "Ragdolled" or "Knockbacked")
-- who slams into a wall or the floor fast breaks it where they hit, bigger the faster they were
-- going. Works for every move with no changes to them: it only watches the characters in
-- workspace.World.Live. The flight effect (wind + rings) is on the client: StarterPlayerScripts >
-- ImpactTrails. Tune with the numbers below.

local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")

local DebreeService = require(ServerStorage.SBGModules.DebreeService)

------------------------------------------------------------------------
-- Tuning
------------------------------------------------------------------------
local IMPACT_SPEED = 55 -- studs/s: at least this fast just before a hit to break something
local IMPACT_SLOWDOWN = 0.5 -- a "hit" = speed drops below this share of the speed a moment ago
local IMPACT_MIN_SIZE, IMPACT_MAX_SIZE = 6, 14 -- hole size, from IMPACT_SPEED up to fast hits
local IMPACT_COOLDOWN = 0.3 -- seconds between breaks per character (ragdolls bounce)

local CHECK_HZ = 30 -- checks per second

------------------------------------------------------------------------

local Live = workspace:WaitForChild("World"):WaitForChild("Live")
local Map = workspace.World:WaitForChild("Map")

local Params = RaycastParams.new()
Params.FilterType = Enum.RaycastFilterType.Include
Params.FilterDescendantsInstances = { Map, DebreeService.GetBodiesFolder() }
Params.RespectCanCollide = true

type State = { Speed: number, Position: Vector3, Velocity: Vector3, LastImpact: number }
local States: { [Model]: State } = {}

local function Flying(Character: Model): boolean
	return Character:HasTag("Ragdolled") or Character:HasTag("Knockbacked")
end

local function Flat(V: Vector3): Vector3?
	local F = Vector3.new(V.X, 0, V.Z)
	return if F.Magnitude > 1e-3 then F.Unit else nil
end

-- Breaks what a character just slammed into. Velocity: how they were moving just before.
local function Impact(Character: Model, From: Vector3, Velocity: Vector3)
	local Speed = Velocity.Magnitude
	local Hit = workspace:Raycast(From, Velocity.Unit * math.max(Speed / CHECK_HZ * 2, 6), Params)
	if not Hit or Hit.Instance:IsDescendantOf(Character) then
		return
	end
	local Alpha = math.clamp((Speed - IMPACT_SPEED) / IMPACT_SPEED, 0, 1)
	local Size = Vector3.one * (IMPACT_MIN_SIZE + (IMPACT_MAX_SIZE - IMPACT_MIN_SIZE) * Alpha)
	if Hit.Normal.Y > 0.7 then
		-- slammed into the floor: a crater, walls in it are driven down
		DebreeService.Destroy(CFrame.new(Hit.Position), Size, {
			Shape = "Ball",
			Direction = Vector3.new(0, -1, 0),
			Bounce = 10 + 15 * Alpha,
		})
	else
		-- into a wall: a hole, the pieces carry on the way they were flying
		DebreeService.Destroy(CFrame.new(Hit.Position), Size, {
			Shape = "Ball",
			Direction = Flat(Velocity) or -Hit.Normal,
			Power = Speed * 0.4,
			Lift = 3,
		})
	end
end

local Clock = 0
RunService.Heartbeat:Connect(function(DeltaTime)
	Clock += DeltaTime
	if Clock < 1 / CHECK_HZ then
		return
	end
	Clock = 0
	local Now = time()

	for _, Character in Live:GetChildren() do
		local Root = Character:FindFirstChild("HumanoidRootPart")
		if not (Character:IsA("Model") and Root and Root:IsA("BasePart")) then
			continue
		end
		local Velocity = Root.AssemblyLinearVelocity
		local Speed = Velocity.Magnitude
		local State = States[Character]
		if not State then
			State = { Speed = Speed, Position = Root.Position, Velocity = Velocity, LastImpact = 0 }
			States[Character] = State
		end

		if Flying(Character)
			and State.Speed >= IMPACT_SPEED
			and Speed < State.Speed * IMPACT_SLOWDOWN
			and Now - State.LastImpact >= IMPACT_COOLDOWN
		then
			State.LastImpact = Now
			Impact(Character, State.Position, State.Velocity)
		end

		State.Speed, State.Position, State.Velocity = Speed, Root.Position, Velocity
	end
end)

Live.ChildRemoved:Connect(function(Character)
	States[Character] = nil
end)