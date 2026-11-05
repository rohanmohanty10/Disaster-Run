local module = {}

local BODY_PARTS = {
	["FakeHead"] = true,
	["Head"] = true,
	["Hitbox_Head"] = true,
	["Hitbox_LeftArm"] = true,
	["Hitbox_LeftLeg"] = true,
	["Hitbox_RightArm"] = true,
	["Hitbox_RightLeg"] = true,
	["Hitbox_Torso"] = true,
	["HumanoidRootPart"] = true,
	["Left Arm"] = true,
	["Right Arm"] = true,
	["Left Leg"] = true,
	["Right Leg"] = true,
	["Torso"] = true,
}

local function HasProperty(_Instance: Part?, Property: string)
	return pcall(function()
		_Instance[Property] = _Instance[Property]
	end)
end

function module:SetCollisionGroup(Character: Model, Group: string)
	if not Character or not Character.Parent then return end
	
	for _,Part: Part in Character:GetDescendants() do
		
		----if Part.Name:find("Hitbox_") then continue end
		
		--if HasProperty(Part, 'CollisionGroup') then
		--	Part.CollisionGroup = Group
		--end
		if not Part:IsA("BasePart") then continue end
		if not BODY_PARTS[Part.Name] then continue end

		Part.CollisionGroup = Group

	end
end

return module
