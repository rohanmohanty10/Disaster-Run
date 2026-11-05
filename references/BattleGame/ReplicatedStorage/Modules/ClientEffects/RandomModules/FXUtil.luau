 
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = {}
local v_u_3 = require(v1.Modules.ClientEffects.RandomModules.EffectsFunctions.Tweening)
local v_u_4 = require(v1.Modules.ClientEffects.RandomModules.mesh_emit)
local function v_u_7(p5)
	-- upvalues: (copy) v_u_4
	for _, v6 in pairs(p5:GetDescendants()) do
		if v6:IsA("Model") and v6:GetAttribute("AttributesAdded") == true then
			v_u_4.new(v6):Emit(v6:GetPivot())
		end
	end
end
local function v_u_11(p8, p9)
	for _, v10 in pairs(p8:GetDescendants()) do
		if v10:IsA("Trail") then
			v10.Enabled = p9
		end
	end
end
local function v_u_15(p12, p13)
	for _, v14 in pairs(p12:GetDescendants()) do
		if v14:IsA("ParticleEmitter") then
			v14.Enabled = p13
		end
	end
end
function v_u_2.Emit(_, p16)
	-- upvalues: (copy) v_u_7
	v_u_7(p16)
	for _, v_u_17 in pairs(p16:GetDescendants()) do
		if v_u_17:IsA("ParticleEmitter") then
			task.delay(v_u_17:GetAttribute("EmitDelay"), function()
				-- upvalues: (copy) v_u_17
				v_u_17:Emit(v_u_17:GetAttribute("EmitCount"))
			end)
		end
		if v_u_17:IsA("Sound") then
			v_u_17:Play()
		end
	end
end
function v_u_2.EmitV2(_, p18)
	for _, v_u_19 in pairs(p18:GetDescendants()) do
		if v_u_19:IsA("ParticleEmitter") and (v_u_19:GetAttribute("EmitDuration") and v_u_19:GetAttribute("EmitDuration") > 0) then
			task.delay(v_u_19:GetAttribute("EmitDelay"), function()
				-- upvalues: (copy) v_u_19
				v_u_19.Enabled = true
				task.delay(v_u_19:GetAttribute("EmitDuration"), function()
					-- upvalues: (ref) v_u_19
					v_u_19.Enabled = false
				end)
			end)
		end
	end
end
function v_u_2.SelectiveEmit(_, p20, p21)
	-- upvalues: (copy) v_u_2
	for _, v_u_22 in pairs(p20:GetDescendants()) do
		if v_u_22.Name == p21 then
			if v_u_22:IsA("ParticleEmitter") then
				task.delay(v_u_22:GetAttribute("EmitDelay"), function()
					-- upvalues: (copy) v_u_22
					v_u_22:Emit(v_u_22:GetAttribute("EmitCount"))
				end)
			else
				v_u_2:Emit(p20)
			end
		end
	end
end
function v_u_2.Enable(_, p23)
	-- upvalues: (copy) v_u_15
	v_u_15(p23, true)
end
function v_u_2.Disable(_, p24)
	-- upvalues: (copy) v_u_15
	v_u_15(p24, false)
end
function v_u_2.EnableBeams(_, p25, p26)
	for _, v27 in pairs(p25:GetDescendants()) do
		if v27:IsA("Beam") then
			v27.Enabled = true
			local v28 = v27.Brightness
			local v29 = v27.LightEmission
			v27.Brightness = 0
			v27.LightEmission = 1
			local v30 = TweenInfo.new(p26)
			game:GetService("TweenService"):Create(v27, v30, {
				["LightEmission"] = v29,
				["Brightness"] = v28
			}):Play()
		end
		if v27:IsA("Trail") then
			v27.Enabled = true
		end
	end
end
local v_u_40 = {
	["Linear"] = function(p31)
		return p31
	end,
	["Quad"] = function(p32)
		return p32 * p32
	end,
	["Cubic"] = function(p33)
		return p33 * p33 * p33
	end,
	["Quart"] = function(p34)
		return p34 * p34 * p34 * p34
	end,
	["Quint"] = function(p35)
		return p35 * p35 * p35 * p35 * p35
	end,
	["Sine"] = function(p36)
		local v37 = p36 * 3.141592653589793 / 2
		return 1 - math.cos(v37)
	end,
	["Exp"] = function(p38)
		if p38 == 0 then
			return 0
		end
		local v39 = 10 * (p38 - 1)
		return math.pow(2, v39)
	end
}
local function v_u_44(p41, p42, p43)
	if p43 == "In" then
		return p42(p41)
	elseif p43 == "Out" then
		return 1 - p42(1 - p41)
	elseif p43 == "InOut" then
		if p41 < 0.5 then
			return p42(p41 * 2) / 2
		else
			return 1 - p42((1 - p41) * 2) / 2
		end
	else
		return p41
	end
end
function v_u_2.DisableBeams(_, p45, p_u_46, p47, p48)
	-- upvalues: (copy) v_u_40, (copy) v_u_44
	local v_u_49 = v_u_40[p47 or "Linear"] or v_u_40.Linear
	local v_u_50 = p48 or "Out"
	for _, v_u_51 in pairs(p45:GetDescendants()) do
		if v_u_51:IsA("Beam") then
			task.spawn(function()
				-- upvalues: (copy) v_u_51, (copy) p_u_46, (ref) v_u_44, (copy) v_u_49, (ref) v_u_50
				local v52 = v_u_51.Transparency
				local v53 = v_u_51
				local v54 = v53.Transparency.Keypoints
				local v55 = {}
				for v56, v57 in ipairs(v54) do
					v55[v56] = v57.Value
				end
				local v58 = tick()
				while true do
					local v59 = (tick() - v58) / p_u_46
					local v60 = math.clamp(v59, 0, 1)
					local v61 = v_u_44(v60, v_u_49, v_u_50)
					local v62 = {}
					for v63, v64 in ipairs(v54) do
						local v65 = v55[v63] + (1 - v55[v63]) * v61
						v62[v63] = NumberSequenceKeypoint.new(v64.Time, v65)
					end
					v53.Transparency = NumberSequence.new(v62)
					task.wait()
					if v60 >= 1 then
						v53.Enabled = false
						v53.Transparency = v52
						return
					end
				end
			end)
		end
	end
end
function v_u_2.SlowBeams(_, p66, p67, p68, p69, p70, p71)
	-- upvalues: (copy) v_u_3
	for _, v72 in pairs(p66:GetDescendants()) do
		if v72:IsA("Beam") then
			local v73 = v_u_3.TweenProperty
			local v74 = {}
			local v75
			if p71 then
				v75 = v72.TextureSpeed / p70
			else
				v75 = p70
			end
			v74.TextureSpeed = v75
			v73(v72, p67, p68, p69, v74):Play()
		end
	end
end
function v_u_2.EnableBeamsV2(_, p76, p_u_77, p78, p79, p_u_80)
	-- upvalues: (copy) v_u_40, (copy) v_u_44
	local v_u_81 = v_u_40[p78 or "Linear"] or v_u_40.Linear
	local v_u_82 = p79 or "Out"
	for _, v_u_83 in pairs(p76:GetDescendants()) do
		if v_u_83:IsA("Beam") then
			task.spawn(function()
				-- upvalues: (copy) v_u_83, (copy) p_u_80, (copy) p_u_77, (ref) v_u_44, (copy) v_u_81, (ref) v_u_82
				local _ = v_u_83.Transparency
				local v84 = v_u_83
				local v85 = v84.Transparency.Keypoints
				local v86 = p_u_80
				local v87 = typeof(v86) == "NumberSequence"
				local v88 = v87 and p_u_80.Keypoints or nil
				local v89 = {}
				local v90 = {}
				for v91, v92 in ipairs(v85) do
					v89[v91] = NumberSequenceKeypoint.new(v92.Time, 1)
					local v93 = p_u_80
					local v94
					if typeof(v93) == "number" then
						v94 = p_u_80
					elseif v87 and v88[v91] then
						v94 = v88[v91].Value
					else
						v94 = v92.Value
					end
					v90[v91] = NumberSequenceKeypoint.new(v92.Time, v94)
				end
				v84.Transparency = NumberSequence.new(v89)
				v84.Enabled = true
				local v95 = tick()
				while true do
					local v96 = (tick() - v95) / p_u_77
					local v97 = math.clamp(v96, 0, 1)
					local v98 = v_u_44(v97, v_u_81, v_u_82)
					local v99 = {}
					for v100 = 1, #v89 do
						local v101 = v89[v100].Value
						local v102 = v101 + (v90[v100].Value - v101) * v98
						v99[v100] = NumberSequenceKeypoint.new(v89[v100].Time, v102)
					end
					v84.Transparency = NumberSequence.new(v99)
					task.wait()
					if v97 >= 1 then
						v84.Transparency = NumberSequence.new(v90)
						return
					end
				end
			end)
		end
	end
end
function v_u_2.EnableTrails(_, p103)
	-- upvalues: (copy) v_u_11
	v_u_11(p103, true)
end
function v_u_2.DisableTrails(_, p104)
	-- upvalues: (copy) v_u_11
	v_u_11(p104, false)
end
return v_u_2