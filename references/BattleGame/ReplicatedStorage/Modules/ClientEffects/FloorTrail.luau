local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")
local Debris       = game:GetService("Debris")

local FloorTrail = {}

local function makeRayParams()
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = { workspace.World.Map.Destroyable.Map.Floor, workspace.World.Voxel, workspace.World.Map["Indestructible Map"].IndestructableFloor}--,
	params.IgnoreWater = true
	return params
end

function FloorTrail.Start(config)
	local object      = config.Object
	local attachment  = config.Attachment
	if not (object and object:IsA("BasePart")) then return end

	local duration    = config.Duration
	local offset      = config.Offset or CFrame.new()
	local width       = config.Width or 2
	local threshold   = config.MoveThreshold or 0.2
	local rayExtra    = config.RayExtra or 0
	local growTime    = config.GrowTime or 0.5
	local startColor  = config.StartColor or Color3.new(1, 1, 1)
	local endColor    = config.EndColor or startColor
	local fadeDelay   = config.FadeDelay
	local fadeTime    = config.FadeTime or 0.5

	local rayParams = makeRayParams()

	local function getSamplePos(): Vector3
		if attachment then
			return attachment.WorldPosition
		else
			return (object.CFrame * offset).Position
		end
	end

	-- Cast 50+ studs down from slightly above the part so jumping/elevation changes don't fail
	local function sampleFloor(): Vector3?
		local samplePos = getSamplePos()
		local origin = samplePos + Vector3.new(0, 2, 0)
		local castDistance = 50 + rayExtra
		local dir = Vector3.new(0, -castDistance, 0)

		local result = workspace:Raycast(origin, dir, rayParams)
		-- Add a tiny 0.05 stud lift to avoid Z-fighting with the ground texture
		return result and (result.Position + Vector3.new(0, 0.05, 0)) or nil
	end

	task.spawn(function()
		local startTime = os.clock()
		local segments = {}

		local lastPos = getSamplePos()
		local lastFloor: Vector3? = sampleFloor()

		while true do
			if (duration and os.clock() - startTime >= duration)
				or not object:IsDescendantOf(workspace)
			then
				break
			end

			local currentPos = getSamplePos()

			if (currentPos - lastPos).Magnitude >= threshold then
				lastPos = currentPos

				local floorPos = sampleFloor()

				if floorPos then
					-- Only bridge if we have a valid previous ground point
					if lastFloor then
						local diff = floorPos - lastFloor
						local length = diff.Magnitude

						if length > 0.05 then
							local seg = script.trail:Clone()
							seg.Color = startColor

							-- Bridge between two floor positions
							seg.CFrame = CFrame.new(lastFloor, floorPos)
								* CFrame.Angles(math.rad(90), 0, 0)
								* CFrame.new(0, -length / 2, 0)

							seg.Mesh.Scale = Vector3.new(0, length, 0)
							seg.Parent = workspace.World.Visuals

							TweenService:Create(seg, TweenInfo.new(growTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Color = endColor,
							}):Play()
							TweenService:Create(seg.Mesh, TweenInfo.new(growTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Scale = Vector3.new(width, length, 0.1),
							}):Play()

							if fadeDelay then
								task.delay(fadeDelay, function()
									if seg.Parent then
										TweenService:Create(seg.Mesh, TweenInfo.new(fadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
											Scale = Vector3.new(0, seg.Mesh.Scale.Y, 0),
										}):Play()
										Debris:AddItem(seg, fadeTime)
									end
								end)
							else
								table.insert(segments, seg)
							end
						end
					end

					lastFloor = floorPos
				else
					-- Lost ground contact (e.g. jumped off a ledge); reset so it won't bridge mid-air
					lastFloor = nil
				end
			end

			RunService.Heartbeat:Wait()
		end

		for _, seg in segments do
			if seg.Parent then
				TweenService:Create(seg.Mesh, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Scale = Vector3.new(0, seg.Mesh.Scale.Y, 0),
				}):Play()
				Debris:AddItem(seg, 2)
			end
		end
	end)
end

return FloorTrail