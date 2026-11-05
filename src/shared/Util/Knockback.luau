--!strict
-- Applies a push to a character on whichever side owns its physics
-- (the server for NPCs, the player's own client for their character).
-- The velocity tapers off over the duration, like the reference's velocity objects.

local RunService = game:GetService("RunService")

local Knockback = {}

local MOVER_NAME = "KnockbackVelocity"

-- Removes any knockback or leftover body movers still on the character.
function Knockback.Clear(character: Model)
	for _, d in character:GetDescendants() do
		if d.Name == MOVER_NAME or d:IsA("BodyVelocity") or d:IsA("BodyPosition") then
			d:Destroy()
		end
	end
end

function Knockback.Push(character: Model, velocity: Vector3, duration: number)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = humanoid and humanoid.RootPart
	if not root then
		return
	end
	Knockback.Clear(character)
	root.AssemblyLinearVelocity = Vector3.zero

	local attachment = Instance.new("Attachment")
	attachment.Name = MOVER_NAME
	attachment.Parent = root

	local mover = Instance.new("LinearVelocity")
	mover.Name = MOVER_NAME
	mover.Attachment0 = attachment
	mover.RelativeTo = Enum.ActuatorRelativeTo.World
	mover.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
	mover.MaxForce = math.huge
	mover.VectorVelocity = velocity
	mover.Parent = root

	-- Upward pushes need the humanoid out of its grounded state to leave the floor.
	if humanoid and velocity.Y > 1 and humanoid:GetState() ~= Enum.HumanoidStateType.Physics then
		humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
	end

	local started = os.clock()
	local connection: RBXScriptConnection
	connection = RunService.Heartbeat:Connect(function()
		local t = (os.clock() - started) / duration
		if t >= 1 or not mover.Parent then
			connection:Disconnect()
			attachment:Destroy()
			mover:Destroy()
			return
		end
		mover.VectorVelocity = velocity * (1 - t * 0.6)
	end)
end

return Knockback
