 
local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("Debris")
local v_u_13 = {
	["Linear"] = function(p4)
		return p4
	end,
	["Quad"] = function(p5)
		return p5 * p5
	end,
	["Cubic"] = function(p6)
		return p6 * p6 * p6
	end,
	["Quart"] = function(p7)
		return p7 * p7 * p7 * p7
	end,
	["Quint"] = function(p8)
		return p8 * p8 * p8 * p8 * p8
	end,
	["Sine"] = function(p9)
		local v10 = p9 * 3.141592653589793 / 2
		return 1 - math.cos(v10)
	end,
	["Exp"] = function(p11)
		if p11 == 0 then
			return 0
		end
		local v12 = 10 * (p11 - 1)
		return math.pow(2, v12)
	end
}
local function v_u_17(p14, p15, p16)
	if p16 == "In" then
		return p15(p14)
	elseif p16 == "Out" then
		return 1 - p15(1 - p14)
	elseif p16 == "InOut" then
		if p14 < 0.5 then
			return p15(p14 * 2) / 2
		else
			return 1 - p15((1 - p14) * 2) / 2
		end
	else
		return p14
	end
end
local function v_u_21(p18)
	local v19 = p18:Clone()
	v19.Name = p18.Name .. "_BeamClone"
	v19.Parent = workspace.World.Visuals
	for _, v20 in ipairs(v19:GetDescendants()) do
		if v20:IsA("Beam") then
			v20.Enabled = false
		end
	end
	return v19
end
function v_u_1.new(p22)
	-- upvalues: (copy) v_u_1
	local v23
	if p22 then
		v23 = p22:IsA("BasePart")
	else
		v23 = p22
	end
	assert(v23, "BeamEmit.new requires a BasePart")
	local v24 = v_u_1
	return setmetatable({
		["Object"] = p22
	}, v24)
end
function v_u_1.TweenTextureSpeed(_, p25, p_u_26, p_u_27, p_u_28, p29, p30)
	-- upvalues: (copy) v_u_13, (copy) v_u_17, (copy) v_u_2
	local v_u_31 = v_u_13[p29] or v_u_13.Linear
	local v_u_32 = p30 or "Out"
	for _, v_u_33 in ipairs(p25:GetDescendants()) do
		if v_u_33:IsA("Beam") then
			local v_u_34 = v_u_33.TextureSpeed
			task.spawn(function()
				-- upvalues: (copy) p_u_26, (ref) v_u_17, (copy) v_u_31, (copy) v_u_32, (copy) p_u_27, (copy) p_u_28, (copy) v_u_33, (ref) v_u_2, (copy) v_u_34
				local v35 = tick()
				repeat
					local v36 = (tick() - v35) / p_u_26
					local v37 = math.clamp(v36, 0, 1)
					local v38 = v_u_17(v37, v_u_31, v_u_32)
					v_u_33.TextureSpeed = p_u_27 + (p_u_28 - p_u_27) * v38
					v_u_2.Heartbeat:Wait()
				until v37 >= 1
				v_u_33.TextureSpeed = v_u_34
			end)
		end
	end
end
function v_u_1.FadeBeams(_, p39, p_u_40, p41, p42)
	-- upvalues: (copy) v_u_13, (copy) v_u_17, (copy) v_u_2
	local v_u_43 = v_u_13[p41] or v_u_13.Linear
	local v_u_44 = p42 or "Out"
	for _, v_u_45 in ipairs(p39:GetDescendants()) do
		if v_u_45:IsA("Beam") then
			task.spawn(function()
				-- upvalues: (copy) v_u_45, (copy) p_u_40, (ref) v_u_17, (copy) v_u_43, (copy) v_u_44, (ref) v_u_2
				local v46 = v_u_45.Transparency
				local v47 = v46.Keypoints
				local v48 = {}
				for v49 = 1, #v47 do
					v48[v49] = v47[v49].Value
				end
				local v50 = tick()
				v_u_45.Enabled = true
				while true do
					local v51 = (tick() - v50) / p_u_40
					local v52 = math.clamp(v51, 0, 1)
					local v53 = v_u_17(v52, v_u_43, v_u_44)
					local v54 = {}
					for v55 = 1, #v47 do
						local v56 = v47[v55]
						local v57 = v48[v55] + (1 - v48[v55]) * v53
						v54[v55] = NumberSequenceKeypoint.new(v56.Time, v57, v56.Envelope)
					end
					v_u_45.Transparency = NumberSequence.new(v54)
					v_u_2.Heartbeat:Wait()
					if v52 >= 1 then
						v_u_45.Enabled = false
						v_u_45.Transparency = v46
						return
					end
				end
			end)
		end
	end
end
function v_u_1.ShrinkBeams(_, p58, p_u_59, p60, p61)
	-- upvalues: (copy) v_u_13, (copy) v_u_17, (copy) v_u_2
	local v_u_62 = v_u_13[p60] or v_u_13.Linear
	local v_u_63 = p61 or "Out"
	for _, v_u_64 in ipairs(p58:GetDescendants()) do
		if v_u_64:IsA("Beam") then
			task.spawn(function()
				-- upvalues: (copy) v_u_64, (copy) p_u_59, (ref) v_u_17, (copy) v_u_62, (copy) v_u_63, (ref) v_u_2
				local v65 = v_u_64.Width0
				local v66 = v_u_64.Width1
				v_u_64.Enabled = true
				local v67 = tick()
				repeat
					local v68 = (tick() - v67) / p_u_59
					local v69 = math.clamp(v68, 0, 1)
					local v70 = v_u_17(v69, v_u_62, v_u_63)
					v_u_64.Width0 = v65 * (1 - v70)
					v_u_64.Width1 = v66 * (1 - v70)
					v_u_2.Heartbeat:Wait()
				until v69 >= 1
				v_u_64.Enabled = false
				v_u_64.Width0 = v65
				v_u_64.Width1 = v66
			end)
		end
	end
end
function v_u_1.TweenRotation(_, p_u_71, p_u_72, p73, p74, p75, p76, p77)
	-- upvalues: (copy) v_u_13, (copy) v_u_17, (copy) v_u_2
	local v_u_78 = v_u_13[p76] or v_u_13.Linear
	local v_u_79 = p77 or "Out"
	local v_u_80 = p_u_71.CFrame
	local v_u_81 = math.rad(p73 or 0)
	local v_u_82 = math.rad(p74 or 0)
	local v_u_83 = math.rad(p75 or 0)
	if v_u_81 ~= 0 or (v_u_82 ~= 0 or v_u_83 ~= 0) then
		task.spawn(function()
			-- upvalues: (copy) p_u_72, (ref) v_u_17, (copy) v_u_78, (copy) v_u_79, (copy) p_u_71, (copy) v_u_80, (copy) v_u_81, (copy) v_u_82, (copy) v_u_83, (ref) v_u_2
			local v84 = tick()
			repeat
				local v85 = (tick() - v84) / (p_u_72 > 0 and p_u_72 or 0.001)
				local v86 = math.clamp(v85, 0, 1)
				local v87 = v_u_17(v86, v_u_78, v_u_79)
				p_u_71.CFrame = v_u_80 * CFrame.Angles(v_u_81 * v87, v_u_82 * v87, v_u_83 * v87)
				v_u_2.Heartbeat:Wait()
			until v86 >= 1
		end)
	end
end
function v_u_1.Emit(p88, p89)
	-- upvalues: (copy) v_u_21, (copy) v_u_3
	if p88.Object then
		local v90 = p88.Object
		local v91 = tonumber(v90:GetAttribute("Lifetime")) or 1
		local v92 = v90:GetAttribute("EasingStyle") or "Linear"
		local v93 = tostring(v92)
		local v94 = v90:GetAttribute("EasingDirection") or "Out"
		local v95 = tostring(v94)
		local v96 = v90:GetAttribute("TransparencyEasingStyle") or (v90:GetAttribute("TransparencyEasing Style") or "Linear")
		local v97 = tostring(v96)
		local v98 = v90:GetAttribute("TransparencyEasingDirection") or "Out"
		local v99 = tostring(v98)
		local v100 = v90:GetAttribute("Shrink")
		local v101 = tonumber(v90:GetAttribute("RotX")) or 0
		local v102 = tonumber(v90:GetAttribute("RotY")) or 0
		local v103 = tonumber(v90:GetAttribute("RotZ")) or 0
		local v104 = tonumber(v90:GetAttribute("StartSpeed")) or 0
		local v105 = tonumber(v90:GetAttribute("EndSpeed")) or 0
		local v106 = v_u_21(v90)
		if p89 ~= nil then
			v106.CFrame = p89
		end
		p88:TweenRotation(v106, v91, v101, v102, v103, v93, v95)
		if v104 ~= v105 then
			p88:TweenTextureSpeed(v106, v91, v104, v105, v93, v95)
		end
		if v100 == true or tostring(v100) == "true" then
			p88:ShrinkBeams(v106, v91, v93, v95)
		else
			p88:FadeBeams(v106, v91, v97, v99)
		end
		v_u_3:AddItem(v106, v91 + 0.15)
	end
end
return v_u_1