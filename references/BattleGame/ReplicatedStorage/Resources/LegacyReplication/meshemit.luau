local TweenService = game:GetService("TweenService")

local function getTweenInfo(part, duration, tweenType, defaultStyle)
	local tweenParamsString = part:GetAttribute(tweenType .. "_TweenParams")
	local defaultParams = {
		{"TweenStyle", defaultStyle},
		{"TweenDirection", Enum.EasingDirection.Out}
	}
	local resolvedParams = {}

	if typeof(tweenParamsString) == "string" then
		local parsed = {tweenParamsString:match("(%a+),(%a+)")}
		for i = 1, 2 do
			local value = parsed[i]
			local key, fallback = table.unpack(defaultParams[i])
			if not value then
				resolvedParams[key] = fallback
			elseif not pcall(function()
					resolvedParams[key] = Enum[key][value]
				end) then
				resolvedParams[key] = fallback
			end
		end
	else
		for _, param in ipairs(defaultParams) do
			resolvedParams[param[1]] = param[2]
		end
	end

	return TweenInfo.new(duration, resolvedParams.TweenStyle, resolvedParams.TweenDirection)
end

return function(startPart)
	local endPart = startPart.Parent:FindFirstChild("End")
	if not endPart then
		warn("Goal is not defined.")
		return
	end

	local clone = startPart:Clone()
	local startTransparency = tonumber(startPart.Parent:GetAttribute("StartTransparency")) or 0

	if clone:IsA("MeshPart") then
		clone.Transparency = startTransparency
	elseif clone:IsA("BasePart") and clone:FindFirstChildOfClass("Decal") then
		clone.Transparency = 1
	end

	clone.Parent = workspace.CurrentCamera
	local duration = tonumber(startPart.Parent:GetAttribute("Duration")) or 0.1

	if clone:FindFirstChildOfClass("Decal") then
		TweenService:Create(clone, getTweenInfo(startPart.Parent, duration, "Part", Enum.EasingStyle.Cubic), {
			Size = endPart.Size,
			CFrame = endPart.CFrame
		}):Play()
	else
		TweenService:Create(clone, getTweenInfo(startPart.Parent, duration, "Part", Enum.EasingStyle.Cubic), {
			Size = endPart.Size,
			CFrame = endPart.CFrame,
			Transparency = 1
		}):Play()
	end

	local startMesh = clone:FindFirstChildOfClass("SpecialMesh")
	local endMesh = endPart:FindFirstChildOfClass("SpecialMesh")
	if startMesh and endMesh then
		TweenService:Create(startMesh, getTweenInfo(startPart.Parent, duration, "Mesh", Enum.EasingStyle.Sine), {
			Scale = endMesh.Scale
		}):Play()
	end

	local startDecal = clone:FindFirstChildOfClass("Decal")
	local endDecal = endPart:FindFirstChildOfClass("Decal")
	if startDecal and endDecal then
		startDecal.Transparency = startTransparency
		TweenService:Create(startDecal, getTweenInfo(startPart.Parent, duration, "Decal", Enum.EasingStyle.Cubic), {
			Transparency = endDecal.Transparency,
			Color3 = endDecal.Color3
		}):Play()
	end

	task.delay(duration, clone.Destroy, clone)
end