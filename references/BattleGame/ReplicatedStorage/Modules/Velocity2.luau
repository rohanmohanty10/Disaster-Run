

local Velocity = {}

local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local references = script:WaitForChild("references")

-- Forward wall-check ray used by `bezier` to stop on impact.
local rayParams = RaycastParams.new()
rayParams.IgnoreWater = true
rayParams.FilterDescendantsInstances = { workspace.World.Map }
rayParams.FilterType = Enum.RaycastFilterType.Include
--rayParams.CollisionGroup = "OnlyDefault"
rayParams.RespectCanCollide = true

local function isInfinite(n)
	return n == math.huge or n == -math.huge
end

local function isNaN(n)
	return n ~= n
end

-- True only if every component of the vector is finite and non-NaN.
local function isFiniteVector(v)
	if isInfinite(v.X) or isInfinite(v.Y) or isInfinite(v.Z) then
		return false
	end
	return not (isNaN(v.X) or isNaN(v.Y) or isNaN(v.Z))
end

-- ----------------------------------------------------------------------------
--  linear: push `attachment` along `direction`, ramping speed from
--  `startSpeed` to `goalSpeed` over `tweenInfo`, destroyed after `duration`.
--  `properties` optionally overrides fields on the cloned LinearVelocity.
--  Returns the LinearVelocity instance and its RenderStepped connection.
-- ----------------------------------------------------------------------------
function Velocity.linear(attachment, direction, duration, startSpeed, goalSpeed, tweenInfo, properties)
	local linearVelocity = references.LinearVelocity:Clone()

	-- Speed lives in an IntValue so TweenService can ease it; each frame the
	-- LinearVelocity's vector is rebuilt from the current value.
	local speedValue = Instance.new("IntValue")
	local speedTween = TweenService:Create(speedValue, tweenInfo, { Value = goalSpeed })

	linearVelocity.Parent = attachment.Parent
	linearVelocity.Attachment0 = attachment

	if properties then
		for key, value in properties do
			linearVelocity[key] = value
		end
	end

	speedValue.Parent = linearVelocity
	speedValue.Value = startSpeed

	local connection
	connection = RunService.RenderStepped:Connect(function()
		if linearVelocity and linearVelocity.Parent then
			linearVelocity.VectorVelocity = direction * speedValue.Value
		else
			connection:Disconnect()
		end
	end)

	speedTween:Play()

	task.delay(duration, function()
		if connection then
			connection:Disconnect()
		end
		linearVelocity:Destroy()
	end)

	return linearVelocity, connection
end

-- ----------------------------------------------------------------------------
--  Stop: remove any mover (AlignPosition / AlignOrientation / LinearVelocity)
--  that is a DIRECT child of `instance`. (bezier passes the RootAttachment;
--  callers passing a Character won't reach movers nested under the HRP.)
-- ----------------------------------------------------------------------------
function Velocity.Stop(instance)
	for _, child in instance:GetChildren() do
		if child:IsA("AlignPosition") or child:IsA("AlignOrientation") or child:IsA("LinearVelocity") then
			child:Destroy()
		end
	end
end

-- ----------------------------------------------------------------------------
--  bezier: move `rootPart` along a quadratic bezier toward `target`.
--    target         BasePart or CFrame to move toward
--    controlOffset  CFrame offset applied to the curve's mid control point
--                   (this is what makes the path arc rather than go straight)
--    duration       seconds
--    easingStyle/easingDirection  passed to TweenService:GetValue for the alpha
--    goalOffset     CFrame offset applied at the destination (default identity)
--    orient         if true, also face along the direction of travel
--    onStep         optional (orientationCF, headingVector, dt) callback per frame
--  Returns the AlignPosition and AlignOrientation so the caller can Destroy them.
-- ----------------------------------------------------------------------------
function Velocity.bezier(rootPart, target, controlOffset, duration, easingStyle, easingDirection, goalOffset, orient, onStep)
	local connection
	local elapsed = 0
	goalOffset = goalOffset or CFrame.new()

	local startPos = rootPart.Position
	local rootAttachment = rootPart:FindFirstChild("RootAttachment")

	local alignPos = references.AlignPosition:Clone()
	local alignOrient = references.AlignOrientation:Clone()
	local targetIsCFrame = typeof(target) == "CFrame"

	alignPos.Position = startPos
	alignPos.Parent = rootAttachment
	alignOrient.Parent = rootAttachment
	alignPos.Attachment0 = rootAttachment
	alignOrient.Attachment0 = rootAttachment
	alignOrient.Enabled = orient
	
	--print("Created bezier ")
	connection = RunService.RenderStepped:Connect(function(dt)
		-- Bail if the subject went away.
		if not (rootPart and rootPart.Parent and alignPos) then
			if connection then
				connection:Disconnect()
				connection = nil
			end
			return
		end

		if duration < elapsed then
			-- Overshot the duration: stop and zero velocity.
			connection:Disconnect()
			connection = nil
			pcall(function()
				Velocity.Stop(rootAttachment)
				rootPart.AssemblyLinearVelocity = Vector3.zero
			end)
			return
		end

		-- Skip pathological frames (huge dt: first frame / lag spike).
		if dt >= 1 then
			return
		end

		local alpha = math.clamp(elapsed / duration, 0, 1)
		local easedAlpha = TweenService:GetValue(alpha, easingStyle, easingDirection)

		-- Curve endpoints in world space.
		local endPos = ((targetIsCFrame and rootPart.CFrame * target or target.CFrame) * goalOffset).Position
		local controlPos = (CFrame.lookAlong(startPos:Lerp(endPos, 0.5), rootPart.CFrame.LookVector) * controlOffset).Position

		-- Quadratic bezier: start -> control -> end.
		local legA = startPos:Lerp(controlPos, easedAlpha)
		local legB = controlPos:Lerp(endPos, easedAlpha)
		local pos = legA:Lerp(legB, easedAlpha)

		-- Look slightly ahead on the same legs to derive a heading/velocity vector.
		local lookAheadAlpha = easedAlpha + math.clamp(dt, 0, 1)
		local heading = legA:Lerp(legB, math.clamp(lookAheadAlpha, 0, 1)) - pos

		-- Wall check a short distance along the heading.
		local wallHit = workspace:Raycast(rootPart.Position, heading.Unit * 4, rayParams)

		local orientCF = orient
			and CFrame.lookAlong(pos, heading.Magnitude > 0 and heading.Unit or rootPart.CFrame.LookVector)
			or CFrame.new(pos)

		if isFiniteVector(pos) then
			alignPos.Position = pos
		end
		if isFiniteVector(orientCF.LookVector) then
			alignOrient.CFrame = orientCF
		end

		if onStep then
			onStep(orientCF, heading, dt)
		end

		--if alpha >= 1 or wallHit then
		if alpha >= 1 then
			-- Reached the destination or hit a wall: stop.
			connection:Disconnect()
			Velocity.Stop(rootAttachment)
			rootPart.AssemblyLinearVelocity = Vector3.zero
		else
			elapsed = elapsed + dt
		end
	end)

	return alignPos, alignOrient
end




--NewDash



-- ============================================================================
--  Dash  — faithful port of Combat/Dash `Process`.
--  Same parameters as the original settings table:
--    Launch, Direction, Distance, Duration, Style, Easing, TweenIn,
--    Validation, ForceDirection, LockDirection, VelocityReplication
--  Plus optional OnDirectionChanged (replaces Remote.Send("DashDirection")).
--  Signature: Velocity.Dash(rootPart, humanoid, settings, isSecondary)
--    isSecondary = true -> sub-dash that does NOT claim the active-dash token
--                          (matches u201 in the original).
--  Returns a cancel function; call it to abort the dash mid-flight.
-- ============================================================================

-- Forward/side wall rays (the original's `u3`): Map-only, respects CanCollide.
local dashRayParams = RaycastParams.new()
dashRayParams.FilterType = Enum.RaycastFilterType.Include
dashRayParams.FilterDescendantsInstances = { workspace.World.Map }
dashRayParams.RespectCanCollide = true

local activeDashId  -- token of the dash that currently "owns" movement (== u15)

local function flatLookVector(cf)            -- getCFLVXZ
	local lv = cf.LookVector
	return Vector3.new(lv.X, 0, lv.Z).Unit
end

local function cameraRelativeDirection(offsetCF)   -- getOffset
	local lv = workspace.CurrentCamera.CFrame.LookVector
	local flat = Vector3.new(lv.X, 0, lv.Z)
	return (CFrame.lookAt(Vector3.zero, flat) * offsetCF).Position
end

local function dashSpeedMultiplier()         -- Settings.Multipliers.DashSpeed / 100
	local ok, mult = pcall(function()
		return game.ReplicatedStorage.Settings.Multipliers.DashSpeed.Value / 100
	end)
	return (ok and mult) or 1
end

local function stillExists(inst)             -- Instance.Exists
	return inst ~= nil and inst.Parent ~= nil
end

-- Equivalent of u1.Cancel: invalidates whatever dash currently owns movement.
function Velocity.CancelDash()
	activeDashId = nil
end

function Velocity.Dash(rootPart, humanoid, settings, isSecondary)
	if not rootPart then return function() end end
	local speedMult = settings.Launch and dashSpeedMultiplier() or 1

	local baseFlatLook = flatLookVector(rootPart.CFrame)   -- for LockDirection
	local startClock   = os.clock()
	local id           = tostring(startClock)
	local parent       = rootPart.Parent
	local spawnsAttr   = parent:GetAttribute("Spawns")

	local cancelled = false
	if not isSecondary then activeDashId = id end

	local easingStyle     = Enum.EasingStyle[settings.Style or "Quad"]
	local easingDirection = Enum.EasingDirection[settings.Easing or "Out"]

	local elapsed   = 0
	local lastEased = 0        -- eased alpha last frame -> gives us the per-frame delta
	local connection
	connection = RunService.RenderStepped:Connect(function(dt)
		local finished   = elapsed >= settings.Duration
		local alpha      = math.clamp(elapsed / settings.Duration, 0, 1)
		local easedAlpha = TweenService:GetValue(alpha, easingStyle, easingDirection)
		local stepAlpha  = easedAlpha - lastEased     -- <<< only THIS frame's fraction
		lastEased = easedAlpha

		if isSecondary or id == activeDashId then
			local valid = (not settings.Validation or settings.Validation())
				and not cancelled
				and stillExists(parent)
				and parent:GetAttribute("Spawns") == spawnsAttr

			if valid and stepAlpha ~= 0 then
				local currentCF = rootPart.CFrame

				local dir = settings.ForceDirection
					or (settings.LockDirection and baseFlatLook)
					or (settings.Direction and cameraRelativeDirection(settings.Direction))
					or flatLookVector(currentCF)

				-- TweenIn ramp (scales this frame's step)
				local scale = 1
				if settings.TweenIn then
					scale = math.clamp((os.clock() - startClock) / settings.TweenIn, 0, 1)
				end

				-- per-frame displacement (delta * Distance), NOT cumulative
				local dist   = stepAlpha * settings.Distance * speedMult * scale
				local offset = dir * dist

				-- wall slide / corner stop
				if offset.Magnitude > 0 then
					local n = offset.Unit
					local leftHit  = workspace:Raycast((currentCF * CFrame.new(-1, 0.5, 0)).Position, n * 2.5, dashRayParams)
					local rightHit = workspace:Raycast((currentCF * CFrame.new( 1, 0.5, 0)).Position, n * 2.5, dashRayParams)
					if leftHit and rightHit and leftHit.Instance ~= rightHit.Instance then
						offset = Vector3.zero
					elseif leftHit or rightHit then
						local normal = (leftHit or rightHit).Normal
						offset = offset - normal * offset:Dot(normal)   -- project along wall
					end
				end

				-- apply delta, keep original height
				local newCF = currentCF + offset
				newCF = newCF + Vector3.new(0, currentCF.Position.Y - newCF.Position.Y, 0)
				rootPart.CFrame = newCF
			end
		end

		if finished then
			connection:Disconnect()
			connection = nil
		else
			elapsed = elapsed + dt
		end
	end)

	return function() cancelled = true end   -- cancel mid-dash
end

function Velocity.Jump(rootPart, settings)
	if not (rootPart and rootPart:IsA("BasePart")) then return function() end end

	local rootAttachment = rootPart:FindFirstChild("RootAttachment")
	if not rootAttachment then return function() end end

	local height   = settings.Height or 14
	local duration = settings.Duration or 0.3
	local maxForce = settings.MaxForce or 1e6
	local style    = Enum.EasingStyle[settings.Style or "Quad"]
	local easing   = Enum.EasingDirection[settings.Easing or "Out"]

	-- Calculate initial vertical velocity needed for this height/duration profile
	local baseVelocityY = (height / duration) * 2

	-- Setup single-axis constraint to preserve horizontal momentum
	local linearVel = references.LinearVelocity:Clone()
	linearVel.Name = "JumpVelocity"
	linearVel.Attachment0 = rootAttachment
	linearVel.RelativeTo = Enum.ActuatorRelativeTo.World
	linearVel.ForceLimitsEnabled = true
	linearVel.MaxAxesForce = Vector3.new(0, maxForce, 0)
	linearVel.VectorVelocity = Vector3.new(0, baseVelocityY, 0)
	linearVel.Parent = rootAttachment

	local elapsed = 0
	local cancelled = false
	local connection

	local function cleanup()
		if connection then
			connection:Disconnect()
			connection = nil
		end
		if linearVel and linearVel.Parent then
			linearVel:Destroy()
		end
	end

	connection = RunService.RenderStepped:Connect(function(dt)
		if cancelled or not (rootPart and rootPart.Parent and rootAttachment.Parent) then
			cleanup()
			return
		end

		elapsed = elapsed + dt
		local alpha = math.clamp(elapsed / duration, 0, 1)

		if alpha >= 1 then
			cleanup()
			return
		end

		-- Evaluate curve: starts high, decays to 0 before releasing to workspace gravity
		local progress = TweenService:GetValue(alpha, style, easing)
		local currentY = baseVelocityY * (1 - progress)

		linearVel.VectorVelocity = Vector3.new(0, currentY, 0)
	end)

	return function()
		cancelled = true
		cleanup()
	end
end

return Velocity
