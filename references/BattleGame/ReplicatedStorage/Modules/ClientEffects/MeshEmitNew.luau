local MeshEmit = {}
MeshEmit.__index = MeshEmit


local TS = game:GetService("TweenService")
local RNS = game:GetService("RunService")


local function RotateMesh(v11, v12, v13)
	local CFConnection = RNS.Heartbeat:Connect(function(dt)
		v11.CFrame = v11.CFrame * CFrame.Angles(0, math.rad(v12), 0)
	end)

	task.delay(v13, function()
		CFConnection:Disconnect()
	end)
end


local function RetrieveProperities(v20)
	local v21 = {}

	if (v20:IsA("Part") and v20:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh") == "SpecialMesh" then
		local l_SpecialMesh_0 = v20:FindFirstChildOfClass("SpecialMesh")

		if not l_SpecialMesh_0 then
			return {}
		else
			v21.Scale = l_SpecialMesh_0.Scale
		end
	else
		v21.Size = v20.Size
	end

	v21.Position = v20.CFrame.Position

	return v21
end


MeshEmit.new = function(v24)
	return (setmetatable({
		Model = v24, 
		Type = v24.Start:IsA("Part") and v24.Start:FindFirstChildOfClass("SpecialMesh") and "SpecialMesh" or "Mesh", 
		Properities = RetrieveProperities(v24.Start), 
		EndProperities = RetrieveProperities(v24.End), 
		Settings = v24:GetAttributes()
	}, MeshEmit))
end


MeshEmit.Emit = function(v25, v26)
	local l_Lifetime_0 = v25.Settings.Lifetime
	local v28 = Enum.EasingStyle[v25.Settings.EasingStyle]
	local v29 = Enum.EasingDirection[v25.Settings.EasingDirection]
	local v30 = v25.Settings.Transparency or 1
	local v31 = v25.Settings.StartTransparency or 1
	local l_RotationX_0 = v25.Settings.RotationX
	local v33 = not l_RotationX_0 and 0 or math.random(l_RotationX_0.Min, l_RotationX_0.Max)
	local l_RotationY_0 = v25.Settings.RotationY
	l_RotationX_0 = not l_RotationY_0 and 0 or math.random(l_RotationY_0.Min, l_RotationY_0.Max)
	local l_RotationZ_0 = v25.Settings.RotationZ
	l_RotationY_0 = not l_RotationZ_0 and 0 or math.random(l_RotationZ_0.Min, l_RotationZ_0.Max)
	l_RotationZ_0 = TweenInfo.new(l_Lifetime_0, v28, v29)
	local v36 = v25.Model.Start:Clone()

	task.delay(l_Lifetime_0 or 10, function()
		if v36 then
			v36:Destroy("")
		end
	end)

	v36.CFrame = (typeof(v26) == "CFrame" and v26 or v26.CFrame) * CFrame.Angles(math.rad(v33), math.rad(l_RotationX_0), (math.rad(l_RotationY_0)))
	v36.Parent = workspace.World.Debris

	local v37 = v25.Model.Start.CFrame:ToObjectSpace(v25.Model.End.CFrame)
	v25.EndProperities.Position = nil
	if v25.Settings.RotationSpeed then
		RotateMesh(v36, v25.Settings.RotationSpeed, l_Lifetime_0)
	end

	if v25.Type == "SpecialMesh" then
		local l_SpecialMesh_1 = v36:FindFirstChildOfClass("SpecialMesh")
		local l_Decal_0 = v36:FindFirstChildOfClass("Decal")

		if l_SpecialMesh_1 then
			local v40 = TS:Create(l_SpecialMesh_1, l_RotationZ_0, v25.EndProperities)
			local v41 = TS:Create(v36, l_RotationZ_0, {
				CFrame = v36.CFrame * v37
			})

			v40:Play()
			v41:Play()

			v40.Completed:Once(function()
				l_SpecialMesh_1.Scale = v25.Properities.Scale or Vector3.new(1, 1, 1, 0)
				v36.Transparency = 1
			end)
		end

		if l_Decal_0 then
			l_Decal_0.Transparency = v31
			local v42 = TweenInfo.new(l_Lifetime_0, Enum.EasingStyle[v25.Settings.TransparencyEasingStyle], Enum.EasingDirection[v25.Settings.TransparencyEasingDirection])

			TS:Create(l_Decal_0, v42, {
				Transparency = v30
			}):Play()

			return
		end
	else
		v36.Transparency = v31
		local _ = TweenInfo.new(l_Lifetime_0, Enum.EasingStyle[v25.Settings.TransparencyEasingStyle], Enum.EasingDirection[v25.Settings.TransparencyEasingDirection])
		if v25.Settings.Movement then
			v25.EndProperities.CFrame = v36.CFrame * v37
		end

		v25.EndProperities.Transparency = v30

		local v44 = TS:Create(v36, l_RotationZ_0, v25.EndProperities)
		v44:Play()

		v44.Completed:Once(function()
			v36.Size = v25.Properities.Size or Vector3.new(1, 1, 1, 0)
			v36.Transparency = 1
		end)
	end
end

MeshEmit.EmitRate = function(v45, v46, v47, v48)
	local v49 = 0
	local v51 = RNS.Heartbeat:Connect(function(v50)
		v49 = v49 + v50
		if v49 > v46 / 60 then
			v49 = 0
			v45:Emit(v48)
		end
	end)

	task.delay(v47, function()
		v51:Disconnect()
	end)
end

return MeshEmit