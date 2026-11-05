 
local v1 = {}
local function v_u_16(p2, p3)
	local v4 = #p3 - 1
	local v5 = Vector3.new()
	for v6 = 0, v4 do
		local v7 = 1 - p2
		local v8 = v4 - v6
		local v9 = math.pow(v7, v8) * math.pow(p2, v6)
		local v10
		if v6 == 0 or v6 == v4 then
			v10 = 1
		elseif v4 < v6 then
			v10 = 0
		else
			local v11 = 1
			for v12 = v4, v4 - v6 + 1, -1 do
				v11 = v11 * v12
			end
			local v13 = 1
			for v14 = 1, v6 do
				v13 = v13 * v14
			end
			v10 = v11 / v13
		end
		local v15 = v9 * v10
		v5 = v5 + p3[v6 + 1] * v15
	end
	return v5
end
local function v_u_27(p17, p18, p19)
	-- upvalues: (copy) v_u_16
	local v20 = tick()
	local v21 = 0
	while v21 < p19 and p17:GetAttribute("HitboxHit") == nil do
		local v22 = (v21 + 0.01) / p19
		local v23 = math.min(1, v22)
		local v24 = v21 / p19
		local v25 = v_u_16(math.min(1, v24), p18)
		local v26 = v_u_16(v23, p18)
		p17.Position = v25
		p17.CFrame = CFrame.lookAt(p17.Position, v26)
		task.wait(0.01)
		v21 = tick() - v20
	end
end
local function v_u_37(p28, p29, p30)
	-- upvalues: (copy) v_u_16
	local v31 = tick()
	local v32 = 0
	while v32 < p30 and p28:GetAttribute("HitboxHit") == nil do
		local v33 = (v32 + 0.01) / p30
		local v34 = math.min(1, v33)
		local v35 = v32 / p30
		local v36 = v_u_16(math.min(1, v35), p29)
		v_u_16(v34, p29)
		p28.Position = v36
		task.wait(0.01)
		v32 = tick() - v31
	end
end
function v1.GenerateBezierPoints(p38, p39)
	-- upvalues: (copy) v_u_16
	local v40 = {}
	for v41 = 0, p39 do
		local v42 = v_u_16(v41 / p39, p38)
		table.insert(v40, v42)
	end
	return v40
end
function v1.CreateBezier(p_u_43, p_u_44, p_u_45, p_u_46)
	-- upvalues: (copy) v_u_27
	task.spawn(function()
		-- upvalues: (ref) v_u_27, (copy) p_u_43, (copy) p_u_45, (copy) p_u_44, (copy) p_u_46
		v_u_27(p_u_43, p_u_45, p_u_44)
		if p_u_46 then
			p_u_46()
		end
	end)
end
function v1.CreateBezierV2(p_u_47, p_u_48, p_u_49, p_u_50)
	-- upvalues: (copy) v_u_37
	task.spawn(function()
		-- upvalues: (ref) v_u_37, (copy) p_u_47, (copy) p_u_49, (copy) p_u_48, (copy) p_u_50
		v_u_37(p_u_47, p_u_49, p_u_48)
		if p_u_50 then
			p_u_50()
		end
	end)
end
function v1.CreateRandomBezier(p_u_51, p_u_52, p_u_53, p54, p55, p_u_56, p_u_57)
	-- upvalues: (copy) v_u_27
	local v_u_58 = nil
	local v59 = CFrame.lookAt(p_u_53, p54)
	local v60 = v59.RightVector * math.random(-p55, p55)
	local v61 = math.random(0, p55)
	local v62 = v59.UpVector * v61
	local v_u_63, v_u_64
	if p_u_52 == "Quadratic" then
		v_u_63 = p54
		v_u_64 = p_u_53:Lerp(v_u_63, math.random(10, 90) * 0.01) + v60 + v62
	else
		v_u_64 = nil
		v_u_63 = nil
	end
	if p_u_52 == "Cubic" then
		v_u_58 = p54
		local v65 = math.random(10, 35) * 0.01
		local v66 = math.random(40, 65) * 0.01
		local v67 = v59.RightVector * math.random(-p55, p55)
		local v68 = v59.UpVector * math.random(-v61, p55)
		v_u_64 = p_u_53:Lerp(v_u_58, v65) + v60 + v62
		v_u_63 = p_u_53:Lerp(v_u_58, v66) + v67 + v68
	end
	task.spawn(function()
		-- upvalues: (copy) p_u_52, (copy) p_u_53, (ref) v_u_64, (ref) v_u_63, (ref) v_u_58, (ref) v_u_27, (copy) p_u_51, (copy) p_u_56, (copy) p_u_57
		local v69 = nil
		local v70
		if p_u_52 == "Quadratic" then
			v70 = { p_u_53, v_u_64, v_u_63 }
		else
			v70 = p_u_52 == "Cubic" and {
				p_u_53,
				v_u_64,
				v_u_63,
				v_u_58
			} or v69
		end
		v_u_27(p_u_51, v70, p_u_56)
		if p_u_57 then
			p_u_57()
		end
	end)
end
return v1