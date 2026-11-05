 
local v_u_1 = game:GetService("Debris")
local v2 = {}
local v_u_3 = { "Weld", "WeldConstraint", "Motor6D" }
local function v_u_12(p4, p5, p6, p7, p8, p9)
	-- upvalues: (copy) v_u_3, (copy) v_u_1
	if table.find(v_u_3, p4) == nil then
		error("WELD TYPE", p4, "IS NOT FOUND")
	end
	local v10 = not p6:IsA("Model") or p6.PrimaryPart
	if v10 then
		local v11 = Instance.new(p4)
		v11.Parent = p5
		v11.Part0 = p5
		v11.Part1 = v10
		v11.Name = p8
		if p4 ~= "WeldConstraint" and p7 ~= nil then
			v11.C0 = p7
		end
		if p9 ~= nil then
			v_u_1:AddItem(v11, p9)
		end
		return v11
	end
end
function v2.NormalWeld(p13, p14, p15, p16, p17)
	-- upvalues: (copy) v_u_12
	return v_u_12("Weld", p13, p14, p15, p16, p17)
end
function v2.WeldConstraint(p18, p19, p20, p21)
	-- upvalues: (copy) v_u_12
	return v_u_12("WeldConstraint", p18, p19, nil, p20, p21)
end
function v2.Motor6D(p22, p23, p24, p25, p26)
	-- upvalues: (copy) v_u_12
	return v_u_12("Motor6D", p22, p23, p24, p25, p26)
end
return v2