-- ReplicatedStorage > Modules > ClientEffects > KnockbackFX   (ModuleScript, client)
--
-- Knockback flight effects, like JJS's ragdoll "Collide" effect. One set per character, never
-- stacked, however it was started:
--   * the wind (Assets.Effects.Wind) on them, facing back along their flight; its trail when faster,
--   * rings trailing behind them (Resources.Misc.Ring),
--   * a line of chips kicked up from the ground under them (Debree's DustBreak),
--   * a puff of chips where they crash into something fast.
--
-- Two ways it runs:
--   * Automatically: anyone tagged "Ragdolled" or "Knockbacked" moving at least WIND_SPEED.
--     Nothing to call; the ClientEffects script loads this module at startup, which starts it.
--   * Forced, no matter the speed, until they land (Zoro's counter launch):
--       KnockbackFX.Force(Character)                                   -- from client code
--       ClientEffects:FireAllClients("KnockbackFX", { Target = Character }) -- from the server
-- The real breaking of walls and floors on impact is the server's (ServerScriptService > DebreeImpacts).

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

------------------------------------------------------------------------
-- Tuning (JJS: chips from 50 studs/s, its wind and the impact puff from 100)
------------------------------------------------------------------------
local DUST_SPEED = 50 -- studs/s before the chip line starts
local DUST_INTERVAL = 0.05 -- seconds between chip bursts (each is 2 chips)
local WIND_SPEED = 50 -- studs/s before the wind + rings start on their own
local WIND_TRAIL_SPEED = 100 -- studs/s before the wind's trail shows too
local RING_INTERVAL = 0.25 -- seconds between rings
local IMPACT_SPEED = 100 -- studs/s for the puff of chips on a crash
local MAX_DISTANCE = 300 -- nothing farther than this from the camera

-- Forced (Force): runs until they land
local GROUND_CHECK = 4 -- the root sits about 3 studs above the floor
local NO_LIFTOFF_TIMEOUT = 1.5 -- never left the ground: stop after this long
local MAX_FORCED_TIME = 8 -- hard stop
------------------------------------------------------------------------

type State = {
	LastDust: number,
	LastRing: number,
	Touching: boolean,
	Wind: BasePart?,
	ForcedAt: number?, -- set while forced
	LeftGround: boolean,
}

local States: { [Model]: State } = {}
local Started = false

local World: Instance, Live: Instance, Visuals: Instance
local DebreeController: any
local WindTemplate: BasePart?, RingTemplate: BasePart?
local Params: RaycastParams
local RingInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function SetWind(Wind: BasePart, On: boolean, Trail: boolean)
	for _, Child in Wind:GetDescendants() do
		if Child:IsA("ParticleEmitter") then
			Child.Enabled = On
		elseif Child:IsA("Trail") then
			Child.Enabled = On and Trail
		end
	end
end

-- wind off, then gone once its last particles have faded
local function DropWind(State: State)
	local Wind = State.Wind
	if Wind then
		State.Wind = nil
		SetWind(Wind, false, false)
		Debris:AddItem(Wind, 1)
	end
end

local function Stop(Target: Model)
	local State = States[Target]
	if State then
		DropWind(State)
		States[Target] = nil
	end
end

local function Ring(Root: BasePart, Velocity: Vector3)
	if not RingTemplate then
		return
	end
	local NewRing = RingTemplate:Clone()
	NewRing.CFrame = if Velocity.Magnitude > 1
		then CFrame.lookAt(Root.Position, Root.Position + Velocity.Unit)
		else Root.CFrame
	NewRing.Size = Vector3.new(0.6, 0.6, 0.6)
	NewRing.Transparency = 0
	NewRing.Parent = workspace:FindFirstChild("Thrown") or workspace
	TweenService:Create(NewRing, RingInfo, { Size = Vector3.new(12, 0.6, 12), Transparency = 1 }):Play()
	Debris:AddItem(NewRing, 0.25)
end

-- Is a forced effect over? Over once they've been seen off the ground and are back on it.
local function ForcedOver(Root: BasePart, State: State, Now: number): boolean
	local Age = Now - (State.ForcedAt :: number)
	if Age > MAX_FORCED_TIME then
		return true
	end
	local OnGround = workspace:Raycast(Root.Position, Vector3.new(0, -GROUND_CHECK, 0), Params) ~= nil
	if not OnGround then
		State.LeftGround = true
		return false
	end
	return State.LeftGround or Age > NO_LIFTOFF_TIMEOUT
end

local function Update(Target: Model, DeltaTime: number, Now: number, Camera: Camera?)
	local Root = Target:FindFirstChild("HumanoidRootPart")
	local State = States[Target]
	if not (Root and Root:IsA("BasePart")) then
		Stop(Target)
		return
	end
	local Velocity = Root.AssemblyLinearVelocity
	local Speed = Velocity.Magnitude

	local Forced = false
	if State and State.ForcedAt then
		Forced = true
		if ForcedOver(Root, State, Now) then
			State.ForcedAt = nil
			Forced = false
		end
	end
	local Tagged = Target:HasTag("Ragdolled") or Target:HasTag("Knockbacked")
	local Auto = Tagged and Speed >= WIND_SPEED
	local Far = Camera ~= nil and (Root.Position - Camera.CFrame.Position).Magnitude > MAX_DISTANCE
	if Far or not (Forced or Tagged) then
		Stop(Target)
		return
	end
	if not State then
		State = { LastDust = 0, LastRing = 0, Touching = false, Wind = nil, ForcedAt = nil, LeftGround = false }
		States[Target] = State
	end
	local S = State :: State

	-- crash: about to hit something fast -> one puff of chips off it, until they separate
	if Speed > 1 then
		local Ahead = Velocity * DeltaTime * 3
		local Hit = workspace:Raycast(Root.Position, Ahead, Params)
		if Hit and Speed > IMPACT_SPEED then
			if not S.Touching then
				S.Touching = true
				DebreeController.DustBreak(Hit.Position - Ahead.Unit, -Ahead, 4, 1, 0.4, 1)
			end
		else
			S.Touching = false
		end
	end

	-- the line: chips from the ground under them
	if Speed > DUST_SPEED and Now - S.LastDust > DUST_INTERVAL then
		S.LastDust = Now
		DebreeController.DustBreak(Root.Position, Vector3.yAxis, 3, 2, 0.4, 1, 4)
	end

	-- flight: the wind follows them, facing back along the way they fly, and rings trail behind
	if Forced or Auto then
		if not S.Wind and WindTemplate then
			local Wind = WindTemplate:Clone()
			Wind.Anchored = true
			Wind.CanCollide = false
			Wind.CanQuery = false
			Wind.CanTouch = false
			Wind.Parent = Visuals
			S.Wind = Wind
		end
		local Wind = S.Wind
		if Wind then
			Wind.CFrame = if Speed > 1
				then CFrame.lookAt(Root.Position, Root.Position - Velocity)
				else CFrame.new(Root.Position)
			SetWind(Wind, true, Speed > WIND_TRAIL_SPEED)
		end
		if Now - S.LastRing > RING_INTERVAL then
			S.LastRing = Now
			Ring(Root, Velocity)
		end
	else
		DropWind(S)
	end
end

local KnockbackFX = {}

-- Starts the effects on Target no matter how fast they're going, until they land. If they
-- already have them (fast knockback), it's the same set, just kept on until landing.
function KnockbackFX.Force(Target: Model)
	if typeof(Target) ~= "Instance" or not Target:IsA("Model") then
		return
	end
	local State = States[Target]
	if not State then
		State = { LastDust = 0, LastRing = 0, Touching = false, Wind = nil, ForcedAt = nil, LeftGround = false }
		States[Target] = State
	end
	State.ForcedAt = os.clock()
	State.LeftGround = false
	State.LastRing = 0 -- a ring right away, on launch
end

local function Start()
	if Started then
		return
	end
	Started = true
	World = workspace:WaitForChild("World")
	Live = World:WaitForChild("Live")
	Visuals = World:FindFirstChild("Visuals") or workspace
	DebreeController = require(ReplicatedStorage.Modules:WaitForChild("Debree"):WaitForChild("DebreeController"))
	local Effects = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Effects")
	local WindFolder = Effects:WaitForChild("Wind", 10)
	WindTemplate = WindFolder and WindFolder:FindFirstChild("Wind") :: BasePart?
	local Resources = ReplicatedStorage:FindFirstChild("Resources")
	local Misc = Resources and Resources:FindFirstChild("Misc")
	RingTemplate = Misc and Misc:FindFirstChild("Ring") :: BasePart?

	Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Include
	Params.FilterDescendantsInstances = { World:WaitForChild("Map"), World:FindFirstChild("Voxel") }
	Params.RespectCanCollide = true

	RunService.Heartbeat:Connect(function(DeltaTime)
		local Camera = workspace.CurrentCamera
		local Now = os.clock()
		for _, Target in Live:GetChildren() do
			if Target:IsA("Model") then
				Update(Target, DeltaTime, Now, Camera)
			end
		end
		-- forced characters that left Live (died, despawned)
		for Target in States do
			if Target.Parent ~= Live then
				Stop(Target)
			end
		end
	end)
end

-- Loaded by the ClientEffects script at startup: start watching right away, without holding it up
task.spawn(Start)

-- ClientEffects:FireAllClients("KnockbackFX", { Target = Character }) lands here
return setmetatable(KnockbackFX, {
	__call = function(_, ArgumentData: any)
		if typeof(ArgumentData) == "table" then
			KnockbackFX.Force(ArgumentData.Target)
		end
	end,
})
