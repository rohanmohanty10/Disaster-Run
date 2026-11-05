 
local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Modules.ClientEffects.RandomModules.Welding)
local v_u_4 = require(v2.Modules.ClientEffects.RandomModules.EffectsFunctions.Tweening)
local v_u_5 = require(v2.Modules.ClientEffects.RandomModules.mesh_emit)
local v_u_6 = require(v2.Modules.ClientEffects.RandomModules.BeamEmit)


local function v_u_12(p7, p8, p9, p10)
	for _, v11 in pairs(p7:GetDescendants()) do
		if v11:IsA(p8) then
			v11[p9] = p10
		end
	end
end
local function v_u_16(p13, p14)
	for _, v15 in pairs(p13:GetDescendants()) do
		if v15:IsA("Trail") then
			v15.Enabled = p14
		end
	end
end
local function v_u_19(p17)
	-- upvalues: (copy) v_u_5
	for _, v18 in pairs(p17:GetDescendants()) do
		if v18:IsA("Model") and v18:GetAttribute("AttributesAdded") == true then
			v_u_5.new(v18):Emit(v18:GetPivot())
		end
	end
end
local function v_u_23(p20)
	-- upvalues: (copy) v_u_6
	for _, v21 in pairs(p20:GetDescendants()) do
		if v21:IsA("BasePart") and v21:GetAttribute("AttributesAdded") == true then
			local v22 = v_u_6.new(v21)
			v22:Emit(v22.CFrame)
		end
	end
end
local function v_u_27(p24, p25)
	for _, v26 in pairs(p24:GetDescendants()) do
		if v26:IsA("ParticleEmitter") then
			v26.Enabled = p25
		end
	end
end
function v_u_1.SetCollision(p28, p29)
	-- upvalues: (copy) v_u_12
	if p28.Object and p28.Type ~= "Attachment" then
		if p28.Type == "FullMesh" or p28.Type == "ParticlePart" then
			p28.Object.CanCollide = p29
		else
			v_u_12(p28.Object, "BasePart", "CanCollide", p29)
		end
	else
		return
	end
end
function v_u_1.SetSize(p30, p31)
	if p30.Object and p30.Type ~= "Attachment" then
		p30.Object.Size = p31
	end
end
function v_u_1.SetTransparency(p32, p33)
	-- upvalues: (copy) v_u_12
	if p32.Object and p32.Type ~= "Attachment" then
		if p32.Type == "FullMesh" or p32.Type == "ParticlePart" then
			p32.Object.Transparency = p33
		else
			v_u_12(p32.Object, "BasePart", "Transparency", p33)
		end
	else
		return
	end
end
function v_u_1.SetCFrame(p34, p35)
	if p34.Object and p34.Type ~= "Attachment" then
		if p34.Type == "FullMesh" or p34.Type == "ParticlePart" then
			p34.Object.CFrame = p35
		else
			p34.Object:PivotTo(p35)
		end
	else
		return
	end
end
function v_u_1.SetOrientation(p36, p37)
	if p36.Object and (p36.Type ~= "Attachment" and p36.Type ~= "Model") then
		p36.Object.Orientation = p37
	end
end
function v_u_1.SetAttachmentCFrame(p38, p39, p40)
	if p38.Object and p38.Type == "Attachment" then
		if p39 then
			p38.Object.WorldCFrame = p40
		else
			p38.Object.CFrame = p40
		end
	else
		return
	end
end
function v_u_1.SetAttachmentPosition(p41, p42, p43)
	if p41.Object and p41.Type == "Attachment" then
		if p42 then
			p41.Object.WorldPosition = p43
		else
			p41.Object.Position = p43
		end
	else
		return
	end
end
function v_u_1.ParentTo(p44, p45)
	if p44.Object then
		p44.Object.Parent = p45
	end
end
function v_u_1.SetOriginals(p46)
	if p46.Object and p46.Type ~= "Attachment" then
		if p46.Type == "Model" then
			for _, v47 in pairs(p46.Object:GetDescendants()) do
				if v47:IsA("BasePart") then
					local v48 = Instance.new("Vector3Value")
					v48.Name = "OriginalSize"
					v48.Parent = v47
					v48.Value = v47.Size
					local v49 = Instance.new("NumberValue")
					v49.Name = "OriginalTransparency"
					v49.Parent = v47
					v49.Value = v47.Transparency
				end
				if v47:IsA("SpecialMesh") then
					local v50 = Instance.new("Vector3Value")
					v50.Name = "OriginalScale"
					v50.Parent = v47
					v50.Value = v47.scale
				end
			end
			return
		elseif p46.Type == "MeshPart" then
			for _, v51 in pairs(p46.Object:GetDescendants()) do
				if v51:IsA("SpecialMesh") then
					local v52 = Instance.new("Vector3Value")
					v52.Name = "OriginalScale"
					v52.Parent = v51
					v52.Value = v51.scale
				end
			end
			local v53 = p46.Object
			local v54 = Instance.new("Vector3Value")
			v54.Name = "OriginalSize"
			v54.Parent = v53
			v54.Value = v53.Size
			local v55 = Instance.new("NumberValue")
			v55.Name = "OriginalTransparency"
			v55.Parent = v53
			v55.Value = v53.Transparency
		else
			local v56 = p46.Object
			local v57 = Instance.new("Vector3Value")
			v57.Name = "OriginalSize"
			v57.Parent = v56
			v57.Value = v56.Size
			local v58 = Instance.new("NumberValue")
			v58.Name = "OriginalTransparency"
			v58.Parent = v56
			v58.Value = v56.Transparency
		end
	else
		return
	end
end
function v_u_1.Destroy(p_u_59, p60)
	if p_u_59.Object then
		if p60 == nil or p60 <= 0 then
			p_u_59.Object:Destroy()
		else
			task.delay(p60, function()
				-- upvalues: (ref) p_u_59
				p_u_59.Object:Destroy()
			end)
		end
	end
end
function v_u_1.Emit(p61)
	-- upvalues: (copy) v_u_19, (copy) v_u_23
	if p61.Object then
		v_u_19(p61.Object)
		v_u_23(p61.Object)
		for _, v_u_62 in pairs(p61.Object:GetDescendants()) do
			if v_u_62:IsA("ParticleEmitter") and v_u_62:GetAttribute("EmitCount") then
				task.delay(v_u_62:GetAttribute("EmitDelay"), function()
					-- upvalues: (copy) v_u_62
					v_u_62:Emit(v_u_62:GetAttribute("EmitCount"))
				end)
			end
			if v_u_62:IsA("Sound") then
				v_u_62:Play()
			end
		end
	end
end
function v_u_1.EmitV2(p63)
	if p63.Object then
		for _, v_u_64 in pairs(p63.Object:GetDescendants()) do
			if v_u_64:IsA("ParticleEmitter") and v_u_64:GetAttribute("EmitDuration") then
				task.delay(v_u_64:GetAttribute("EmitDelay"), function()
					-- upvalues: (copy) v_u_64
					if v_u_64:GetAttribute("EmitDuration") > 0 then
						v_u_64.Enabled = true
						task.delay(v_u_64:GetAttribute("EmitDuration"), function()
							-- upvalues: (ref) v_u_64
							v_u_64.Enabled = false
						end)
					end
				end)
			end
		end
	end
end
function v_u_1.SelectiveEmit(p65, p66)
	if p65.Object then
		for _, v_u_67 in pairs(p65.Object:GetDescendants()) do
			if v_u_67.Name == p66 then
				if v_u_67:IsA("ParticleEmitter") then
					task.delay(v_u_67:GetAttribute("EmitDelay"), function()
						-- upvalues: (copy) v_u_67
						v_u_67:Emit(v_u_67:GetAttribute("EmitCount"))
					end)
				else
					p65:Emit()
				end
			end
		end
	end
end
function v_u_1.Enable(p68)
	-- upvalues: (copy) v_u_27
	if p68.Object then
		v_u_27(p68.Object, true)
	end
end
function v_u_1.Disable(p69)
	-- upvalues: (copy) v_u_27
	if p69.Object then
		v_u_27(p69.Object, false)
	end
end
function v_u_1.EnableBeams(p70, _, p71)
	if p70.Object then
		for _, v72 in pairs(p70.Object:GetDescendants()) do
			if v72:IsA("Beam") then
				v72.Enabled = true
				local v73 = v72.Brightness
				local v74 = v72.LightEmission
				v72.Brightness = 0
				v72.LightEmission = 1
				local v75 = TweenInfo.new(p71)
				game:GetService("TweenService"):Create(v72, v75, {
					["LightEmission"] = v74,
					["Brightness"] = v73
				}):Play()
			end
			if v72:IsA("Trail") then
				v72.Enabled = true
			end
		end
	end
end
local v_u_85 = {
	["Linear"] = function(p76)
		return p76
	end,
	["Quad"] = function(p77)
		return p77 * p77
	end,
	["Cubic"] = function(p78)
		return p78 * p78 * p78
	end,
	["Quart"] = function(p79)
		return p79 * p79 * p79 * p79
	end,
	["Quint"] = function(p80)
		return p80 * p80 * p80 * p80 * p80
	end,
	["Sine"] = function(p81)
		local v82 = p81 * 3.141592653589793 / 2
		return 1 - math.cos(v82)
	end,
	["Exp"] = function(p83)
		if p83 == 0 then
			return 0
		end
		local v84 = 10 * (p83 - 1)
		return math.pow(2, v84)
	end
}
local function v_u_89(p86, p87, p88)
	if p88 == "In" then
		return p87(p86)
	elseif p88 == "Out" then
		return 1 - p87(1 - p86)
	elseif p88 == "InOut" then
		if p86 < 0.5 then
			return p87(p86 * 2) / 2
		else
			return 1 - p87((1 - p86) * 2) / 2
		end
	else
		return p86
	end
end
function v_u_1.DisableBeams(p90, p_u_91, p92, p93)
	-- upvalues: (copy) v_u_85, (copy) v_u_89
	if p90.Object then
		local v_u_94 = v_u_85[p92 or "Linear"] or v_u_85.Linear
		local v_u_95 = p93 or "Out"
		for _, v_u_96 in pairs(p90.Object:GetDescendants()) do
			if v_u_96:IsA("Beam") then
				task.spawn(function()
					-- upvalues: (copy) v_u_96, (copy) p_u_91, (ref) v_u_89, (copy) v_u_94, (ref) v_u_95
					local v97 = v_u_96.Transparency
					local v98 = v_u_96
					local v99 = v98.Transparency.Keypoints
					local v100 = {}
					for v101, v102 in ipairs(v99) do
						v100[v101] = v102.Value
					end
					local v103 = tick()
					while true do
						local v104 = (tick() - v103) / p_u_91
						local v105 = math.clamp(v104, 0, 1)
						local v106 = v_u_89(v105, v_u_94, v_u_95)
						local v107 = {}
						for v108, v109 in ipairs(v99) do
							local v110 = v100[v108] + (1 - v100[v108]) * v106
							v107[v108] = NumberSequenceKeypoint.new(v109.Time, v110)
						end
						v98.Transparency = NumberSequence.new(v107)
						task.wait()
						if v105 >= 1 then
							v98.Enabled = false
							v98.Transparency = v97
							return
						end
					end
				end)
			end
		end
	end
end
function v_u_1.SlowBeams(p111, p112, p113, p114, p115, p116)
	-- upvalues: (copy) v_u_4
	if p111.Object then
		for _, v117 in pairs(p111.Object:GetDescendants()) do
			if v117:IsA("Beam") then
				local v118 = v_u_4.TweenProperty
				local v119 = {}
				local v120
				if p116 then
					v120 = v117.TextureSpeed / p115
				else
					v120 = p115
				end
				v119.TextureSpeed = v120
				v118(v117, p112, p113, p114, v119):Play()
			end
		end
	end
end
function v_u_1.EnableBeamsV2(p121, p_u_122, p123, p124, p_u_125)
	-- upvalues: (copy) v_u_85, (copy) v_u_89
	if p121.Object then
		local v_u_126 = v_u_85[p123 or "Linear"] or v_u_85.Linear
		local v_u_127 = p124 or "Out"
		for _, v_u_128 in pairs(p121.Object:GetDescendants()) do
			if v_u_128:IsA("Beam") then
				task.spawn(function()
					-- upvalues: (copy) v_u_128, (copy) p_u_125, (copy) p_u_122, (ref) v_u_89, (copy) v_u_126, (ref) v_u_127
					local v129 = v_u_128
					local v130 = v129.Transparency.Keypoints
					local v131 = p_u_125
					local v132 = typeof(v131) == "NumberSequence"
					local v133 = v132 and p_u_125.Keypoints or nil
					local v134 = {}
					local v135 = {}
					for v136, v137 in ipairs(v130) do
						v134[v136] = NumberSequenceKeypoint.new(v137.Time, 1)
						local v138 = p_u_125
						local v139
						if typeof(v138) == "number" then
							v139 = p_u_125
						elseif v132 and v133[v136] then
							v139 = v133[v136].Value
						else
							v139 = v137.Value
						end
						v135[v136] = NumberSequenceKeypoint.new(v137.Time, v139)
					end
					v129.Transparency = NumberSequence.new(v134)
					v129.Enabled = true
					local v140 = tick()
					while true do
						local v141 = (tick() - v140) / p_u_122
						local v142 = math.clamp(v141, 0, 1)
						local v143 = v_u_89(v142, v_u_126, v_u_127)
						local v144 = {}
						for v145 = 1, #v134 do
							local v146 = v134[v145].Value
							local v147 = v146 + (v135[v145].Value - v146) * v143
							v144[v145] = NumberSequenceKeypoint.new(v134[v145].Time, v147)
						end
						v129.Transparency = NumberSequence.new(v144)
						task.wait()
						if v142 >= 1 then
							v129.Transparency = NumberSequence.new(v135)
							return
						end
					end
				end)
			end
		end
	end
end
function v_u_1.EnableTrails(p148, p149)
	-- upvalues: (copy) v_u_16
	if p148.Object then
		v_u_16(p149, true)
	end
end
function v_u_1.DisableTrails(p150, p151)
	-- upvalues: (copy) v_u_16
	if p150.Object then
		v_u_16(p151, false)
	end
end
function v_u_1.WeldTo(p152, p153, p154, p155)
	-- upvalues: (copy) v_u_3
	if p152.Object and p152.Type ~= "Attachment" then
		local v156 = nil
		if p154 == "Normal" then
			return v_u_3.NormalWeld(p153, p152.Object, p155, p153.Name)
		end
		if p154 == "Constraint" then
			return v_u_3.WeldConstraint(p153, p152.Object, p153.Name)
		end
		if p154 == "Motor6D" then
			v156 = v_u_3.Motor6D(p153, p152.Object, p155, p153.Name)
		end
		return v156
	end
end
function v_u_1.CreateEffect(p157, p158, p159, p160)
	-- upvalues: (copy) v_u_1
	local v161 = {
		["Type"] = p157,
		["Object"] = p158:Clone()
	}
	local v162 = v_u_1
	local v163 = setmetatable(v161, v162)
	v163:SetCFrame(p159)
	v163:ParentTo(p160)
	v163:SetOriginals()
	return v163
end
return v_u_1