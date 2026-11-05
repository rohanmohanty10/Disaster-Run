--!optimize 2

--[[
	DrownSink (LocalScript)
	Place in: StarterPlayer > StarterPlayerScripts

	CLIENT half of drowning: physics feel only.
	When your own character's head goes below sea level it instantly:
	- kills your fall momentum so you don't plunge deep
	- applies a slow downward sink
	- throws the body into a free tumble, which the limbs trail off
	- plays the water entry sound

	Nothing here commands an orientation. The body is left to physics exactly
	like a knockback ragdoll in mid-air -- it gets a random spin and tumbles
	however it tumbles. Holding it to a pose (an AlignOrientation chasing a
	target) is what made it look stiff and land the same way every time.

	The SERVER (DrownService) independently handles HP damage + the ragdoll
	itself. This script does no damage, so it can't be cheated for advantage.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer

repeat task.wait() until game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").KeyboardEnabled or game:GetService("UserInputService").GamepadEnabled
repeat task.wait() until game:IsLoaded() and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")

-- ============================================================
-- Config (keep SEA_LEVEL / SUBMERGE_MARGIN matching DrownService)
-- ============================================================

local SEA_LEVEL        = 0    -- water surface Y
local SUBMERGE_MARGIN  = 0    -- extra studs the head must be under before it counts
local SINK_SPEED       = 4    -- studs/sec you sink while under (small = slow)
local GROUND_CHECK_DIST = 3   -- stop sinking when this close to a floor (prevents clipping)
local BOB_AMOUNT       = 1.5  -- studs/sec the sink speed wanders, so the descent isn't a dead glide

-- The tumble, built the same way the uppercut spins a body: a
-- BodyAngularVelocity on the root part with heavy torque behind it. The
-- uppercut fires one at 8 rad/sec for a tenth of a second; drowning holds a
-- much slower one and wanders the axis, so you keep turning over.
local SPIN_TORQUE     = Vector3.one * 1e6 -- matches the uppercut's MaxTorque
local SPIN_POWER      = 1e5               -- matches its P
local SPIN_MIN        = 1.0   -- rad/sec, slowest the tumble gets
local SPIN_MAX        = 2.2   -- rad/sec, fastest. the uppercut uses 8, far too fast for this
local SPIN_CHANGE_MIN = 1.5   -- seconds before picking a new axis
local SPIN_CHANGE_MAX = 3.5
local SPIN_BLEND      = 1.2   -- how quickly it eases onto a new axis. higher = sharper changes

-- Nothing here touches the arms and legs. They trail off the tumbling torso on
-- their own, the same way they do off an uppercut. Pushing them directly means
-- assigning a limb a new velocity outright, which skips the acceleration and
-- fights the joint holding it on -- it reads as jerky, not as flailing.

-- How fast sideways momentum bleeds off once you're under. Higher = water
-- stops you sooner. A dash carries a lot of speed in with it.
local HORIZONTAL_DRAG = 7

local DROWN_ASSETS = ReplicatedStorage.Assets.Animations.Drown

local LocalPlayer = Players.LocalPlayer

-- ============================================================
-- State
-- ============================================================

local character, humanoid, hrp, head
local sink = nil
local spin = nil        -- the BodyAngularVelocity doing the tumbling
local spinNow = Vector3.zero    -- axis it's turning on right now
local spinGoal = Vector3.zero   -- axis it's easing toward
local nextSpinChange = 0        -- clock time we pick a new one
local swayPhase = 0     -- drives the bob
local submerged = false

local groundParams = RaycastParams.new()
groundParams.FilterType = Enum.RaycastFilterType.Exclude
-- The sea is Terrain water, and a downward ray cast from inside it reports a
-- hit -- so without this the ground check says "landed" the whole time you're
-- under, which parks the sink and the bob.
groundParams.IgnoreWater = true

local function clearDrown()
	if sink then
		sink:Destroy()
		sink = nil
	end
	if spin then
		spin:Destroy()
		spin = nil
	end
	spinNow = Vector3.zero
	spinGoal = Vector3.zero
	nextSpinChange = 0
	swayPhase = 0
	submerged = false
end

local function bindCharacter(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
	hrp = char:WaitForChild("HumanoidRootPart")
	head = char:WaitForChild("Head")
	clearDrown()
	humanoid.Died:Once(clearDrown)
end

if LocalPlayer.Character then
	bindCharacter(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(bindCharacter)

local function randomAxis()
	local axis = Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1)
	return axis.Magnitude > 0.01 and axis.Unit or Vector3.yAxis
end

-- A dash (and plenty of skills) call shared.clearVelocities on the root part,
-- which destroys every BodyMover on it -- our sink included. So never assume it
-- survived: rebuild it whenever it's gone and we're still under.
local function ensureSink()
	if sink and sink.Parent then return end

	sink = Instance.new("BodyVelocity")
	sink.Name = "DrownSink"
	-- Vertical only, so it holds you up against gravity without touching your
	-- spin or your sideways drift. Force on X/Z would snap sideways motion dead
	-- the instant you touch water; HORIZONTAL_DRAG bleeds it off instead.
	sink.MaxForce = Vector3.new(0, math.huge, 0)
	sink.Velocity = Vector3.new(0, -SINK_SPEED, 0)
	sink.Parent = hrp
end

-- A dash's velocity outlives the moment you hit the water -- it's a BodyVelocity
-- with 50k of force on X/Z, so it drags you sideways the whole way down while
-- our sink is only asking for straight down. Nothing else gets to drive you
-- while you're under, so strip anything that isn't ours. This also clears any
-- AlignOrientation, which is what would otherwise pin the body to a pose.
local function purgeMovers()
	for _, thing in hrp:GetDescendants() do
		if thing == sink or thing == spin then continue end

		if thing:IsA("BodyMover")            -- BodyVelocity, BodyGyro, BodyPosition, BodyForce, ...
			or thing:IsA("LinearVelocity")
			or thing:IsA("AngularVelocity")
			or thing:IsA("VectorForce")
			or thing:IsA("AlignPosition")
			or thing:IsA("AlignOrientation")
		then
			thing:Destroy()
		end
	end
end

local function randomSpin()
	return randomAxis() * (SPIN_MIN + math.random() * (SPIN_MAX - SPIN_MIN))
end

-- Same object the uppercut uses to send a ragdoll spinning, just slower and
-- held instead of fired for a tenth of a second. Rebuilt whenever something
-- clears it, exactly like the sink.
local function ensureSpin()
	if spin and spin.Parent then return end

	spin = Instance.new("BodyAngularVelocity")
	spin.Name = "DrownSpin"
	spin.MaxTorque = SPIN_TORQUE
	spin.P = SPIN_POWER
	spin.AngularVelocity = spinNow
	spin.Parent = hrp
end

-- Wander the axis so you roll, pitch and yaw by turns instead of tipping the
-- same way every time. Easing between axes rather than snapping is what keeps
-- it looking limp.
local function tumbleBody(now, deltaTime, landed)
	if landed then
		spin.AngularVelocity = Vector3.zero
		return
	end

	if now >= nextSpinChange then
		nextSpinChange = now + SPIN_CHANGE_MIN + math.random() * (SPIN_CHANGE_MAX - SPIN_CHANGE_MIN)
		spinGoal = randomSpin()
	end

	spinNow = spinNow:Lerp(spinGoal, math.min(deltaTime * SPIN_BLEND, 1))
	spin.AngularVelocity = spinNow
end

local function isOnGround()
	if not (character and hrp) then return false end
	groundParams.FilterDescendantsInstances = { character }
	local feetY = hrp.Position.Y - hrp.Size.Y / 2
	local origin = Vector3.new(hrp.Position.X, feetY, hrp.Position.Z)
	local result = workspace:Raycast(origin, Vector3.new(0, -GROUND_CHECK_DIST, 0), groundParams)
	return result ~= nil
end

-- ============================================================
-- Per-frame physics
-- ============================================================

RunService.Heartbeat:Connect(function(deltaTime)
	if not (character and humanoid and hrp and head) or humanoid.Health <= 0 then
		clearDrown()
		return
	end

	local topOfHead = head.Position.Y + head.Size.Y / 2
	local isUnder = topOfHead < (SEA_LEVEL - SUBMERGE_MARGIN)

	if isUnder then
		local now = os.clock()

		if not submerged then
			submerged = true

			-- Kill fall momentum the instant you enter so you don't plunge deep
			hrp.AssemblyLinearVelocity = Vector3.zero

			-- Go in already turning, on a random axis, like a body that just
			-- got launched. Which way you roll is different every time.
			spinNow = randomSpin()
			spinGoal = randomSpin()
			nextSpinChange = now + SPIN_CHANGE_MIN

			DROWN_ASSETS.enterwater:Play()
		end

		purgeMovers()
		ensureSink()
		ensureSpin()

		local landed = isOnGround()
		swayPhase += deltaTime

		-- Stop pushing down once landed (only matters if a floor exists).
		-- Otherwise the descent wanders a little instead of being a dead glide.
		local sinkSpeed = SINK_SPEED + math.sin(swayPhase * 0.7) * BOB_AMOUNT
		sink.Velocity = landed and Vector3.zero or Vector3.new(0, -sinkSpeed, 0)

		-- Only stir a limp body. Out of the ragdoll (evasive'd out, or the
		-- NoRagdoll command) the Humanoid is trying to stand you up and this
		-- would just fight it.
		if character:HasTag("Ragdolled") then
			tumbleBody(now, deltaTime, landed)
		else
			spin.AngularVelocity = Vector3.zero
		end

		-- Water drag: bleed off whatever you carried in (a dash is fast) and
		-- never let anything pull you down faster than the sink. Only touches
		-- linear motion -- the tumble is left alone.
		local velocity = hrp.AssemblyLinearVelocity
		local drag = math.exp(-HORIZONTAL_DRAG * deltaTime)
		hrp.AssemblyLinearVelocity = Vector3.new(
			velocity.X * drag,
			math.max(velocity.Y, -sinkSpeed),
			velocity.Z * drag
		)
	else
		if submerged then
			clearDrown()
		end
	end
end)
