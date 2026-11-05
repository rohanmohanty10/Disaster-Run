--AttachStretch (R6 rewrite) — keep GumRight & GumLeft as children of this ModuleScript
local GumRightTemplate = script:WaitForChild("GumRight")
local GumLeftTemplate  = script:WaitForChild("GumLeft")

-- R6 humanoids usually don't have body-scale NumberValues; default to 1 if missing
local function scaleOf(humanoid, propName)
	if not humanoid then return 1 end
	local v = humanoid:FindFirstChild(propName)
	return (v and v.Value) or 1
end

local creators = {
	RightArm = function(char)
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		local arm = char:FindFirstChild("Right Arm")
		if not arm then return end

		local gum = GumRightTemplate:Clone()
		gum.Name = "GumRight"
		gum.Color = arm.Color
		gum.Size = Vector3.new(
			scaleOf(humanoid, "BodyWidthScale"),
			scaleOf(humanoid, "BodyHeightScale"),
			scaleOf(humanoid, "BodyDepthScale")
		)

		local weld = Instance.new("Motor6D")
		weld.Name = "GumRight"
		weld.Part0 = arm
		weld.Part1 = gum
		weld.C0 = CFrame.new(0, -1, 0)  -- hand end of the R6 "Right Arm"; TUNE THIS
		weld.C1 = CFrame.new()
		weld.Parent = arm

		gum.Parent = char
		gum.Transparency = 0
	end,

	LeftArm = function(char)
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		local arm = char:FindFirstChild("Left Arm")
		if not arm then return end

		local gum = GumLeftTemplate:Clone()
		gum.Name = "GumLeft"
		gum.Color = arm.Color
		gum.Size = Vector3.new(
			scaleOf(humanoid, "BodyWidthScale"),
			scaleOf(humanoid, "BodyHeightScale") * 1.302, -- original left-arm fudge factor
			scaleOf(humanoid, "BodyDepthScale")
		)

		local weld = Instance.new("Motor6D")
		weld.Name = "GumLeft"
		weld.Part0 = arm
		weld.Part1 = gum
		weld.C0 = CFrame.new(0, -1, 0)  -- hand end of the R6 "Left Arm"; TUNE THIS
		weld.C1 = CFrame.new()
		weld.Parent = arm

		gum.Parent = char
		gum.Transparency = 0
	end,
}

return function(char, sideKey)
	local fn = creators[sideKey]
	if fn then fn(char) end
end