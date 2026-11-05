-- ============================================================================
--  Movement lean / run-tilt  —  R6 only
-- ============================================================================
--  Leans the character toward its direction of travel by rotating the R6
--  RootJoint (HumanoidRootPart -> Torso), scaled by speed, easing back to
--  neutral when idle. Skipped while ragdolled, physics-driven, seated, or when
--  _G.canuse is false.
-- ============================================================================

local RunService  = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid  = character:WaitForChild("Humanoid")
local rootPart  = character:WaitForChild("HumanoidRootPart")

-- R6 root Motor6D.
local rootJoint = rootPart:WaitForChild("RootJoint")

-- Neutral pose to lean away from and return to.
local baseC0 = rootJoint.C0

-- True once the lean has eased back to neutral, so we can stop working at rest.
local settled = false

RunService.Heartbeat:Connect(function(dt)
	if rootJoint == nil or character == nil or humanoid == nil then
		return
	end
	
	local Stunned    = character:FindFirstChild("Stunned")
	local Ragdolled  = character:GetAttribute("Ragdolled")
	local selfM1     = character:FindFirstChild("M1ing") ~= nil
	local Dashing   = character:GetAttribute("SideDashing")
	

	-- No leaning while ragdolled or physics-driven.
	if Ragdolled or Dashing or (Stunned and not selfM1) or humanoid:GetState() == Enum.HumanoidStateType.Physics then
		return
	end

	local moveDirection = humanoid.MoveDirection

	-- Suppress the lean when seated or globally disabled.
	local suppressLean = humanoid.SeatPart ~= nil or _G.canuse == false
	local effectiveMove = suppressLean and Vector3.zero or moveDirection

	-- Standing still and already settled → nothing to update.
	if effectiveMove == Vector3.zero and settled then
		return
	end

	local rootCF = rootPart.CFrame
	local localMove = rootCF:VectorToObjectSpace(effectiveMove)
	local localVel  = rootCF:VectorToObjectSpace(rootPart.Velocity) * 0.008

	-- Per-axis speed weighting (0..1): the lean grows with how fast you move.
	local speedX = math.clamp(math.abs(localVel.X), 0, 1)
	local speedZ = math.clamp(math.abs(localVel.Z), 0, 1)

	local scale = character:GetScale()
	local roll  = localMove.X * speedX / scale
	local pitch = math.max(0, localMove.Z * speedZ / scale)

	-- Lean is applied in the HumanoidRootPart's frame (pre-multiply), NOT the
	-- joint's frame — R6's RootJoint.C0 is rotated, so post-multiplying would
	-- tilt on the wrong axes. In HRP space: X = right (pitch), Z = back (roll).
	local leanRotation = CFrame.Angles(pitch, 0, -roll)

	local currentC0 = rootJoint.C0
	local targetC0 = currentC0:Lerp(leanRotation * baseC0, dt * 15)
	rootJoint.C0 = targetC0

	-- While idle, flag settled once the rotation has converged back to neutral.
	if effectiveMove == Vector3.zero then
		local _, currentAngle = targetC0:ToAxisAngle()
		local _, baseAngle = baseC0:ToAxisAngle()
		settled = math.abs(currentAngle - baseAngle) < 0.001
	else
		settled = false
	end
end)

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
	character = newCharacter
	humanoid  = character:WaitForChild("Humanoid")
	rootPart  = character:WaitForChild("HumanoidRootPart")
	rootJoint = rootPart:WaitForChild("RootJoint")
	baseC0    = rootJoint.C0
	settled   = false
end)
