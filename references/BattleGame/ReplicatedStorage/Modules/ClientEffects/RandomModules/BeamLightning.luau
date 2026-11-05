 
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = {}
v_u_2.__index = v_u_2
--local v3 = v1.Packages.Modules.DevModules.Tjanime
local v3 = v1.Modules.ClientEffects.RandomModules

local v_u_4 = require(v3.EffectsFunctions.Bezier)
local v_u_5 = require(v3.EffectsFunctions.Tweening)
require(v3.LoopService)
local v_u_6 = require(v3.BeamLightningCache)
local v_u_7 = workspace:WaitForChild("BeamFolder")
local function v_u_17(p8, p9, p10, p11)
	-- upvalues: (copy) v_u_6
	local v12 = {}
	for v13 = 1, #p8 - (p11 and 1 or 0) do
		local v14 = v13 + (p10 or 0) + (p11 and 1 or 0)
		local v15 = "Attachment" .. tostring(v14)
		local v16 = v_u_6.GetAttachment(p9)
		v16.Name = v15
		v16.Visible = false
		if v13 == #p8 then
			v16.WorldPosition = p8[v13]
		else
			v16.WorldPosition = p8[v13 + (p11 and 1 or 0)]
		end
		table.insert(v12, v16)
	end
	return v12
end
local function v_u_25(p18, p19, p20, p21, p22, p23)
	-- upvalues: (copy) v_u_5
	for v24 = 1, #p19 - (p23 and 1 or 0) do
		v_u_5.TweenProperty(p18[v24], p20, p21, p22, {
			["WorldPosition"] = p19[v24 + (p23 and 1 or 0)]
		}):Play()
	end
	return p18
end
local function v_u_37(p26, p27, p28, p29, p30, p31, p32)
	-- upvalues: (copy) v_u_6
	local v33 = v_u_6.GetBeam(p31)
	v33.Enabled = true
	v33.Attachment0 = p26
	v33.Attachment1 = p27
	v33.Width0 = p28
	v33.Width1 = p29
	v33.Texture = p30 == nil and "" or p30.Texture
	v33.Segments = p30 == nil and 3 or p30.Segments
	v33.FaceCamera = p30 == nil and true or p30.FaceCamera
	local v34
	if p30 == nil then
		v34 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0) })
	else
		v34 = p30.Transparency
	end
	v33.Transparency = v34
	v33.Brightness = p30 == nil and 3 or p30.Brightness
	local v35
	if p30 == nil then
		v35 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(109, 192, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(109, 192, 255)) })
	else
		v35 = p30.Color
	end
	v33.Color = v35
	v33.LightEmission = p30 == nil and 0 or p30.LightEmission
	v33.LightInfluence = p30 == nil and 0 or p30.LightInfluence
	v33.TextureLength = p30 == nil and 1 or p30.TextureLength
	v33.TextureSpeed = p30 == nil and 1 or p30.TextureSpeed
	local v36 = p32 + 1
	v33.Name = "Beam" .. p32 .. "-" .. tostring(v36)
	return v33
end
local function v_u_57(p38, p39, p40)
	local v41 = {}
	local v_u_42 = p38.Keypoints
	local function v50(p43)
		-- upvalues: (copy) v_u_42
		for _, v44 in ipairs(v_u_42) do
			local v45 = v44.Time - p43
			if math.abs(v45) < 0.001 then
				return v44.Value
			end
		end
		for v46 = 1, #v_u_42 - 1 do
			local v47 = v_u_42[v46]
			local v48 = v_u_42[v46 + 1]
			if v47.Time <= p43 and p43 <= v48.Time then
				local v49 = (p43 - v47.Time) / (v48.Time - v47.Time)
				return v47.Value:Lerp(v48.Value, v49)
			end
		end
		return v_u_42[#v_u_42].Value
	end
	local v51 = ColorSequenceKeypoint.new
	table.insert(v41, v51(0, v50(p39)))
	for _, v52 in ipairs(v_u_42) do
		if p39 < v52.Time and v52.Time < p40 then
			local v53 = (v52.Time - p39) / (p40 - p39)
			local v54 = ColorSequenceKeypoint.new
			local v55 = v52.Value
			table.insert(v41, v54(v53, v55))
		end
	end
	local v56 = ColorSequenceKeypoint.new
	table.insert(v41, v56(1, v50(p40)))
	return ColorSequence.new(v41)
end
local function v_u_79(_, p58, p59, p60, p61, p62)
	-- upvalues: (copy) v_u_37, (copy) v_u_7, (copy) v_u_57
	local v63 = #p61 - 1
	local v64 = #p61 / 2
	local v65 = math.floor(v64)
	local v66 = (p59 - p58) / v65
	local v67 = (p59 - p60) / (v63 - v65)
	local v68 = {}
	for v69 = 1, v63 do
		local v70 = p61[v69]
		local v71 = p61[v69 + 1]
		local v72, v73
		if v69 <= v65 then
			v72 = p58 + v66 * (v69 - 1)
			v73 = p58 + v66 * v69
		else
			local v74 = v69 - v65
			v72 = p59 - v67 * (v74 - 1)
			v73 = p59 - v67 * v74
		end
		local v75 = v_u_37(v70, v71, v72, v73, p62, v_u_7, v69)
		if p62 and p62.Color then
			local v76 = p62.Color
			if typeof(v76) == "ColorSequence" then
				local v77 = (v69 - 1) / v63
				local v78 = v69 / v63
				v75.Color = v_u_57(p62.Color, v77, v78)
			end
		end
		table.insert(v68, v75)
	end
	return v68
end
local function v_u_88(p80, p81, p82, p83)
	local v84 = CFrame.lookAt(p81.Position, p82.Position)
	local v85 = v84.RightVector * (math.random(-50, 50) * 0.1 * p83) + v84.UpVector * (math.random(-50, 50) * 0.1 * p83) + v84.LookVector * (math.random(-20, 20) * 0.1 * p83)
	for v86, v87 in pairs(p80) do
		if v86 ~= 1 and v86 ~= #p80 then
			p80[v86] = v87 + v85
		end
	end
	return p80
end
function v_u_2.new(p89, p90, p91, p92, p93, p94, p95, p96, p97, p98, p99, _, p100, p101, p102)
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_88, (copy) v_u_17, (copy) v_u_25, (copy) v_u_79
	local v103 = v_u_2
	local v104 = setmetatable({}, v103)
	v104.Attachments = {}
	v104.Part1 = p89
	v104.Part2 = p90
	v104.MidPointCF = p93
	v104.Beams = {}
	v104.BeamFolder = {}
	v104.Curve1Attachments = {}
	v104.Curve2Attachments = {}
	if p89 == nil or (p90 == nil or (typeof(p89) ~= "Instance" or typeof(p90) ~= "Instance")) then
		error("PART1 OR PART2 DO NOT MEET THE REQUIREMENTS OF A PART")
	end
	v104.Segments = p91 or 5
	v104.CurveSize = p92 or 5
	v104.MidPointCF = p93 or CFrame.new(0, 0, 0)
	local v105 = p94 or 0
	local v106 = p95 or 1
	local v107 = p96 or 0
	v104.TweenTime = p97 or 1
	v104.EasingStyle = p98 or "Quad"
	v104.EasingDirection = p99 or "Out"
	v104.Intensity = p100 or 1
	local v108 = (p89.Position - p90.Position).Magnitude
	local v109 = CFrame.lookAt(p89.Position, p90.Position)
	v104.MidPoint = (v109 * CFrame.new(0, 0, -v108 / 2) * v104.MidPointCF).Position
	local v110 = p101 or math.random(-180, 180)
	local v111 = v104.Segments
	local v112
	if math.floor(v111) % 2 == 0 then
		v112 = v104.Segments / 2 - 1
	else
		local v113 = v104.Segments / 2
		v112 = math.floor(v113)
	end
	local v114 = {
		["CurvePoint1"] = v109 * CFrame.Angles(0, 0, (math.rad(v110))) * CFrame.new(0, v104.CurveSize, -v108 / 4),
		["CurvePoint2"] = v109 * CFrame.Angles(0, 0, (math.rad(v110))) * CFrame.new(0, -v104.CurveSize, -v108 / 2 + -v108 / 4)
	}
	local v115 = math.random(11, 22) * 0.1
	local v116 = math.random(11, 22) * 0.1
	local v117 = {
		["CurvePoint1"] = v109 * CFrame.Angles(0, 0, (math.rad(v110))) * CFrame.new(0, v104.CurveSize * v115, -v108 / 4),
		["CurvePoint2"] = v109 * CFrame.Angles(0, 0, (math.rad(v110))) * CFrame.new(0, -v104.CurveSize * v116, -v108 / 2 + -v108 / 4)
	}
	local v118 = { p89.Position, v114.CurvePoint1.Position, v104.MidPoint }
	local v119 = { v104.MidPoint, v114.CurvePoint2.Position, p90.Position }
	local v120 = { p89.Position, v117.CurvePoint1.Position, v104.MidPoint }
	local v121 = { v104.MidPoint, v117.CurvePoint2.Position, p90.Position }
	local v122 = v_u_4.GenerateBezierPoints(v118, v112)
	local v123 = v_u_88(v_u_4.GenerateBezierPoints(v120, v112), p89, p90, v104.Intensity)
	v104.Curve1Attachments = v_u_17(v122, workspace.Terrain)
	v_u_25(v104.Curve1Attachments, v123, v104.TweenTime, v104.EasingStyle, v104.EasingDirection)
	local v124 = v_u_4.GenerateBezierPoints(v119, v112)
	local v125 = v_u_88(v_u_4.GenerateBezierPoints(v121, v112), p89, p90, v104.Intensity)
	v104.Curve2Attachments = v_u_17(v124, workspace.Terrain, v112, true)
	v_u_25(v104.Curve2Attachments, v125, v104.TweenTime, v104.EasingStyle, v104.EasingDirection, true)
	v104:AddAttachments()
	v104.Beams = v_u_79(p89, v105, v106, v107, v104.Attachments, p102)
	return v104
end
function v_u_2.Destroy(p_u_126, p127, p128, p129, p130)
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	local v131 = p129 or "Quad"
	local v132 = p130 or "Out"
	if p_u_126.LightningLoop then
		p_u_126.LightningLoop:EndLoop()
	end
	for _, v_u_133 in pairs(p_u_126.Beams) do
		v_u_5.TweenProperty(v_u_133, p127 or 1, v131, v132, {
			["Width0"] = 0,
			["Width1"] = 0
		}):Play()
		task.delay(p127 or 1, function()
			-- upvalues: (copy) v_u_133
			v_u_133.Enabled = false
		end)
		task.delay(p128 or 1, function()
			-- upvalues: (ref) v_u_6, (copy) v_u_133
			v_u_6.ReturnBeam(v_u_133)
		end)
	end
	p_u_126.Beams = nil
	p_u_126.Curve1Attachments = nil
	p_u_126.Curve2Attachments = nil
	task.delay(p128 or 1, function()
		-- upvalues: (ref) p_u_126, (ref) v_u_6
		for _, v134 in pairs(p_u_126.Attachments) do
			v_u_6.ReturnAttachment(v134)
		end
		p_u_126.Attachments = nil
		table.clear(p_u_126)
		p_u_126 = nil
	end)
end
function v_u_2.AddAttachments(p135)
	for _, v136 in pairs(p135.Curve1Attachments) do
		local v137 = p135.Attachments
		table.insert(v137, v136)
	end
	for _, v138 in pairs(p135.Curve2Attachments) do
		local v139 = p135.Attachments
		table.insert(v139, v138)
	end
end
return v_u_2