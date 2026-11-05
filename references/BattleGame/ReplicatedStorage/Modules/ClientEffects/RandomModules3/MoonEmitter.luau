 
  
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local t = {}
t.__index = t
local function trim(p1) --[[ trim | Line: 57 ]]
	return p1:gsub("^%s+", ""):gsub("%s+$", "")
end
local function splitNums(p1) --[[ splitNums | Line: 61 ]]
	local t = {}
	for v1 in string.gmatch(p1, "([^,]+)") do
		local v3 = tonumber((v1:gsub("^%s+", ""):gsub("%s+$", "")))
		if v3 ~= nil then
			table.insert(t, v3)
		end
	end
	return t
end
local function parseBoolean(p1) --[[ parseBoolean | Line: 70 ]]
	return p1 == "true"
end
local function parseParams(p1) --[[ parseParams | Line: 74 ]]
	local t = {}
	for v3 in string.gmatch(p1, "([^,]+)") do
		local v1, v2
		local v4 = v3:gsub("^%s+", ""):gsub("%s+$", "")
		if #v4 > 0 then
			local v5 = string.find(v4, "=", 1, true)
			if v5 then
				local v6 = string.sub(v4, 1, v5 - 1):gsub("^%s+", ""):gsub("%s+$", "")
				local v7 = string.sub(v4, v5 + 1):gsub("^%s+", ""):gsub("%s+$", "")
				if #v7 >= 2 then
					local v8
					if v7:sub(1, 1) == "\"" and v7:sub(-1) == "\"" then
						v1 = v7
						v2 = v6
						v8 = v1:sub(2, -2)
						v1 = v8
					else
						v1 = v7
						if v1:sub(1, 1) == "\'" and v1:sub(-1) == "\'" then
							v2 = v6
							v8 = v1:sub(2, -2)
							v1 = v8
						else
							v2 = v6
						end
					end
				else
					v1 = v7
					v2 = v6
				end
				local v9 = tonumber(v1)
				if v9 == nil then
					if v1 == "true" or v1 == "false" then
						t[v2] = if v1 == "true" then true else false
						continue
					end
					t[v2] = v1
					continue
				end
				t[v2] = v9
			end
		end
	end
	return t
end
local function parseExternalKeyPath(p1) --[[ parseExternalKeyPath | Line: 101 ]]
	local t = {}
	local t2 = {}
	local function parseSeg(p1) --[[ parseSeg | Line: 105 ]]
		local v1 = p1:gsub("^%s+", ""):gsub("%s+$", "")
		local v2 = string.find(v1, "<", 1, true)
		local v3 = v2 and string.find(v1, ">", v2 + 1, true) or nil
		if v2 and (v3 and v2 < v3) then
			local v5 = string.sub(v1, 1, v2 - 1):gsub("^%s+", ""):gsub("%s+$", "")
			local v6 = string.sub(v1, v2 + 1, v3 - 1):gsub("^%s+", ""):gsub("%s+$", "")
			if v6 == "" or not v6 then
				v6 = nil
			end
			return v5, v6
		else
			return v1, nil
		end
	end
	local v1 = tostring(p1 or "")
	if v1 ~= "" then
		local v2 = 1
		local list = {}
		while true do
			local v3 = string.find(v1, " > ", v2, true)
			if not v3 then
				break
			end
			table.insert(list, (string.sub(v1, v2, v3 - 1)))
			v2 = v3 + 3
		end
		table.insert(list, (string.sub(v1, v2)))
		for i, v in ipairs(list) do
			local v6, v7 = parseSeg(v)
			table.insert(t, v6)
			table.insert(t2, v7 or "")
		end
	end
	return t, t2, #t > 0 and t[#t] or nil, if #t2 > 0 and t2[#t2] ~= "" then t2[#t2] else nil
end
local function resolveOrCreateUnder(p1, p2, p3, p4) --[[ resolveOrCreateUnder | Line: 156 ]]
	if not p1 or typeof(p1) ~= "Instance" then
		return nil
	end
	if type(p2) ~= "table" or #p2 == 0 then
		return nil
	end
	local v1 = 1
	for i, v in ipairs(p2) do
		if string.lower((tostring(v))) == "lighting" then
			v1 = i + 1
			break
		end
	end
	if #p2 < v1 then
		return p1
	end
	local v2 = p1
	for i = v1, #p2 do
		local v3
		local v5 = tostring(p2[i])
		v3 = type(p3) == "table" and tostring(p3[i] or "") or ""
		local v7 = v2:FindFirstChild(v5)
		if v7 and (v3 ~= "" and v7.ClassName ~= v3) then
			v7 = nil
		end
		if not v7 then
			if not p4 then
				return nil
			end
			if v3 == "" then
				return nil
			end
			local v8, v9 = pcall(function() --[[ Line: 186 | Upvalues: v3 (copy) ]]
				return Instance.new(v3)
			end)
			if not (v8 and v9) then
				return nil
			end
			v9.Name = v5
			v9.Parent = v2
			pcall(function() --[[ Line: 198 | Upvalues: v9 (copy) ]]
				v9:SetAttribute("LightingTarget", "Lighting")
			end)
			v7 = v9
		end
		v2 = v7
	end
	return v2
end
local function resolvePathUnder(p1, p2, p3, p4) --[[ resolvePathUnder | Line: 212 ]]
	if not p1 or typeof(p1) ~= "Instance" then
		return nil
	end
	if type(p3) ~= "table" or #p3 == 0 then
		return nil
	end
	local v1 = 1
	for i, v in ipairs(p3) do
		if v == p2 then
			v1 = i + 1
			break
		end
	end
	if #p3 < v1 then
		return p1
	end
	local v2 = p1
	for i = v1, #p3 do
		local v3
		local v5 = tostring(p3[i])
		v3 = type(p4) == "table" and tostring(p4[i] or "") or ""
		local v7 = nil
		for i2, v in ipairs(v2:GetChildren()) do
			if v.Name == v5 and (v3 == "" or v.ClassName == v3) then
				v7 = v
				break
			end
		end
		if not v7 then
			local v8 = v2:FindFirstChild(v5, true)
			v7 = if v8 and (v3 ~= "" and v8.ClassName ~= v3) then nil else v8
		end
		if not v7 then
			return nil
		end
		v2 = v7
	end
	return v2
end
local function toVector2(p1) --[[ toVector2 | Line: 262 ]]
	return Vector2.new(p1[1], p1[2])
end
local function toVector3(p1) --[[ toVector3 | Line: 263 ]]
	return Vector3.new(p1[1], p1[2], p1[3])
end
local function toColor3(p1) --[[ toColor3 | Line: 264 ]]
	return Color3.new(p1[1], p1[2], p1[3])
end
local function toUDim(p1) --[[ toUDim | Line: 265 ]]
	return UDim.new(p1[1], p1[2])
end
local function toUDim2(p1) --[[ toUDim2 | Line: 266 ]]
	return UDim2.new(p1[1], p1[2], p1[3], p1[4])
end
local function toCFrame(p1) --[[ toCFrame | Line: 267 ]]
	return CFrame.new(table.unpack(p1, 1, 12))
end
local function toNumberRange(p1) --[[ toNumberRange | Line: 268 ]]
	return NumberRange.new(p1[1], p1[2])
end
local function toNumberSequence(p1) --[[ toNumberSequence | Line: 270 ]]
	local t = {}
	for i = 1, #p1, 2 do
		local v1 = p1[i]
		local v2 = p1[i + 1]
		if v1 ~= nil and v2 ~= nil then
			table.insert(t, NumberSequenceKeypoint.new(v1, v2))
		end
	end
	if #t == 0 then
		t = { NumberSequenceKeypoint.new(0, 0) }
	end
	return NumberSequence.new(t)
end
local function toColorSequence(p1) --[[ toColorSequence | Line: 282 ]]
	local t = {}
	for i = 1, #p1, 4 do
		local v1 = p1[i]
		local v2 = p1[i + 1]
		local v3 = p1[i + 2]
		local v4 = p1[i + 3]
		if v1 ~= nil and (v2 ~= nil and (v3 ~= nil and v4 ~= nil)) then
			local v5 = ColorSequenceKeypoint.new
			table.insert(t, v5(v1, Color3.new(v2, v3, v4)))
		end
	end
	if #t == 0 and #p1 == 3 then
		return ColorSequence.new((Color3.new(p1[1], p1[2], p1[3])))
	end
	if #t == 0 then
		return ColorSequence.new(Color3.new(255/255, 255/255, 255/255))
	end
	if #t == 1 then
		local v8 = t[1]
		if v8.Time <= 0 then
			local v9 = ColorSequenceKeypoint.new
			table.insert(t, v9(1, v8.Value))
		else
			local v11 = ColorSequenceKeypoint.new
			table.insert(t, 1, v11(0, v8.Value))
		end
	end
	return ColorSequence.new(t)
end
local function expectTypeFor(p1, p2) --[[ expectTypeFor | Line: 315 ]]
	if p1:IsA("Model") then
		if p2 == "Scale" then
			return "number"
		end
		if p2 == "CFrame" then
			return "CFrame"
		end
	end
	if p1.ClassName == "Lighting" then
		if p2 == "Ambient" then
			return "Color3"
		end
		if p2 == "OutdoorAmbient" then
			return "Color3"
		end
		if p2 == "FogColor" then
			return "Color3"
		end
		if p2 == "ColorShift_Top" then
			return "Color3"
		end
		if p2 == "ColorShift_Bottom" then
			return "Color3"
		end
		if p2 == "Brightness" then
			return "number"
		end
		if p2 == "ClockTime" then
			return "number"
		end
		if p2 == "FogStart" then
			return "number"
		end
		if p2 == "FogEnd" then
			return "number"
		end
		if p2 == "GeographicLatitude" then
			return "number"
		end
		if p2 == "ExposureCompensation" then
			return "number"
		end
		if p2 == "EnvironmentDiffuseScale" then
			return "number"
		end
		if p2 == "EnvironmentSpecularScale" then
			return "number"
		end
		if p2 == "ShadowSoftness" then
			return "number"
		end
		if p2 == "GlobalShadows" then
			return "boolean"
		end
	end
	if p1:IsA("Atmosphere") then
		if p2 == "Color" then
			return "Color3"
		end
		if p2 == "Decay" then
			return "Color3"
		end
		if p2 == "Density" or (p2 == "Offset" or (p2 == "Haze" or p2 == "Glare")) then
			return "number"
		end
	end
	if p1:IsA("Light") then
		if p2 == "Brightness" then
			return "number"
		end
		if p2 == "Enabled" then
			return "boolean"
		end
		if p2 == "Range" then
			return "number"
		end
		if p2 == "Shadows" then
			return "boolean"
		end
		if p2 == "Color" then
			return "Color3"
		end
	end
	if p1:IsA("ParticleEmitter") then
		if p2 == "Color" then
			return "ColorSequence"
		end
		if p2 == "Transparency" then
			return "NumberSequence"
		end
		if p2 == "Size" then
			return "NumberSequence"
		end
		if p2 == "Texture" then
			return "string"
		end
		if p2 == "Enabled" then
			return "boolean"
		end
	end
	if p1:IsA("GuiObject") then
		if p2 == "Position" or p2 == "Size" then
			return "UDim2"
		end
		if p2 == "AnchorPoint" or p2 == "CanvasPosition" then
			return "Vector2"
		end
		if p2 == "Rotation" then
			return "number"
		end
		if p2 == "BackgroundTransparency" or (p2 == "ImageTransparency" or p2 == "TextTransparency") then
			return "number"
		end
		if p2 == "BackgroundColor3" or (p2 == "ImageColor3" or p2 == "TextColor3") then
			return "Color3"
		end
		if p2 == "Visible" then
			return "boolean"
		end
	end
	if p1:IsA("TextLabel") or (p1:IsA("TextBox") or p1:IsA("TextButton")) then
		if p2 == "Text" then
			return "string"
		end
		if p2 == "RichText" then
			return "boolean"
		end
		if p2 == "TextColor3" then
			return "Color3"
		end
		if p2 == "TextTransparency" then
			return "number"
		end
		if p2 == "TextStrokeColor3" then
			return "Color3"
		end
		if p2 == "TextStrokeTransparency" then
			return "number"
		end
		if p2 == "TextSize" then
			return "number"
		end
		if p2 == "TextScaled" then
			return "boolean"
		end
		if p2 == "TextWrapped" then
			return "boolean"
		end
		if p2 == "LineHeight" then
			return "number"
		end
		if p2 == "Font" then
			return "string"
		end
		if p2 == "TextXAlignment" then
			return "string"
		end
		if p2 == "TextYAlignment" then
			return "string"
		end
	end
	if p1:IsA("BlurEffect") then
		if p2 == "Size" then
			return "number"
		end
		if p2 == "Enabled" then
			return "boolean"
		end
	end
	if p1:IsA("BloomEffect") then
		if p2 == "Intensity" or (p2 == "Size" or p2 == "Threshold") then
			return "number"
		end
		if p2 == "Enabled" then
			return "boolean"
		end
	end
	if p1:IsA("ColorCorrectionEffect") then
		if p2 == "Brightness" or (p2 == "Contrast" or p2 == "Saturation") then
			return "number"
		end
		if p2 == "TintColor" then
			return "Color3"
		end
		if p2 == "Enabled" then
			return "boolean"
		end
	end
	if p1:IsA("SunRaysEffect") then
		if p2 == "Intensity" or p2 == "Spread" then
			return "number"
		end
		if p2 == "Enabled" then
			return "boolean"
		end
	end
	if p1:IsA("DepthOfFieldEffect") then
		if p2 == "FarIntensity" or (p2 == "NearIntensity" or p2 == "InFocusRadius") then
			return "number"
		end
		if p2 == "FocusDistance" then
			return "number"
		end
		if p2 == "Enabled" then
			return "boolean"
		end
	end
	if p2 == "CFrame" then
		return "CFrame"
	end
	if p1:IsA("BasePart") then
		if p2 == "Position" or (p2 == "Orientation" or p2 == "Size") then
			return "Vector3"
		end
		if p2 == "Color" then
			return "Color3"
		end
		if p2 == "Transparency" then
			return "number"
		end
	end
	if p1:IsA("Attachment") and (p2 == "Position" or p2 == "Orientation") then
		return "Vector3"
	end
	if p1:IsA("Highlight") then
		if p2 == "FillColor" then
			return "Color3"
		end
		if p2 == "OutlineColor" then
			return "Color3"
		end
		if p2 == "FillTransparency" then
			return "number"
		end
		if p2 == "OutlineTransparency" then
			return "number"
		end
		if p2 == "Enabled" then
			return "boolean"
		end
		if p2 == "Adornee" then
			return "string"
		end
		if p2 == "DepthMode" then
			return "string"
		end
	end
	if p1:IsA("ValueBase") then
		local ClassName = p1.ClassName
		if ClassName == "CFrameValue" then
			return "CFrame"
		end
		if ClassName == "Vector3Value" then
			return "Vector3"
		end
		if ClassName == "Color3Value" then
			return "Color3"
		end
		if ClassName == "NumberValue" or (ClassName == "IntValue" or ClassName == "DoubleConstraintValue") then
			return "number"
		end
		if ClassName == "BoolValue" then
			return "boolean"
		end
		if ClassName == "StringValue" then
			return "string"
		end
	end
	if p2 == "Color" then
		return "Color3"
	end
	if p2 == "Transparency" then
		return "number"
	end
	if p2 == "Enabled" then
		return "boolean"
	end
	if p2 == "Texture" then
		return "string"
	end
	if p2 == "NumberSequence" then
		return "NumberSequence"
	end
	if p2 == "ColorSequence" then
		return "ColorSequence"
	end
	if p2 == "Range" or p2 == "NumberRange" then
		return "NumberRange"
	else
		return nil
	end
end
local function deserialize(p1, p2) --[[ deserialize | Line: 464 | Upvalues: splitNums (copy), toVector2 (copy), toColor3 (copy), toUDim (copy), toUDim2 (copy), toCFrame (copy), toNumberRange (copy), toNumberSequence (copy), toColorSequence (copy) ]]
	if p2 == "boolean" then
		return p1 == "true"
	else
		if p2 == "number" then
			return tonumber(p1)
		end
		if p2 == "string" then
			return p1
		end
		local v2 = splitNums(p1)
		if p2 == "Vector3" then
			return Vector3.new(v2[1], v2[2], v2[3])
		end
		if p2 == "Vector2" then
			return toVector2(v2)
		end
		if p2 == "Color3" then
			return toColor3(v2)
		end
		if p2 == "UDim" then
			return toUDim(v2)
		end
		if p2 == "UDim2" then
			return toUDim2(v2)
		end
		if p2 == "CFrame" then
			return toCFrame(v2)
		end
		if p2 == "NumberRange" then
			return toNumberRange(v2)
		end
		if p2 == "NumberSequence" then
			return toNumberSequence(v2)
		end
		if p2 == "ColorSequence" then
			return toColorSequence(v2)
		end
		if #v2 == 12 then
			return toCFrame(v2)
		end
		if #v2 == 4 then
			return toUDim2(v2)
		end
		if #v2 == 3 then
			return Vector3.new(v2[1], v2[2], v2[3])
		end
		if #v2 == 2 then
			return toVector2(v2)
		end
		if #v2 == 1 then
			return v2[1]
		end
		local v9 = tonumber(p1)
		if not v9 then
			v9 = (p1 == "true" or p1 == "false") and p1 == "true" or p1
		end
		return v9
	end
end
local function typeofStr(p1) --[[ typeofStr | Line: 489 ]]
	local v1 = typeof(p1)
	if v1 == "Instance" then
		return p1.ClassName
	else
		return v1
	end
end
local EasingStyle = Enum.EasingStyle
local EasingDirection = Enum.EasingDirection
local function easeInOut(p1) --[[ easeInOut | Line: 497 ]]
	return function(p12) --[[ Line: 498 | Upvalues: p1 (copy) ]]
		if p12 < 0.5 then
			return 0.5 * p1(p12 * 2)
		else
			return 1 - 0.5 * p1((1 - p12) * 2)
		end
	end
end
local function makeBack(p1) --[[ makeBack | Line: 503 ]]
	return function(p12) --[[ Line: 503 | Upvalues: p1 (copy) ]]
		return p12 * p12 * ((p1 + 1) * p12 - p1)
	end
end
local function makeElastic(p1, p2) --[[ makeElastic | Line: 504 ]]
	return function(p12) --[[ Line: 505 | Upvalues: p2 (copy), p1 (copy) ]]
		if p12 ~= 0 and p12 ~= 1 then
			return -2 ^ (10 * (p12 - 1)) * math.sin((p12 - 1 - p2) * 6.283185307179586 / p1)
		end
		return p12
	end
end
local function bounceOut(p1) --[[ bounceOut | Line: 510 ]]
	if p1 < 0.36363636363636365 then
		return p1 * 7.5625 * p1
	end
	if p1 < 0.7272727272727273 then
		local v1 = p1 - 0.5454545454545454
		return v1 * 7.5625 * v1 + 0.75
	end
	if p1 < 0.9090909090909091 then
		local v2 = p1 - 0.8181818181818182
		return v2 * 7.5625 * v2 + 0.9375
	else
		local v3 = p1 - 0.9545454545454546
		return v3 * 7.5625 * v3 + 0.984375
	end
end
local function bounceIn(p1) --[[ bounceIn | Line: 516 ]]
	local v1 = 1 - p1
	local v2
	if v1 < 0.36363636363636365 then
		v2 = v1 * 7.5625 * v1
	elseif v1 < 0.7272727272727273 then
		local v3 = v1 - 0.5454545454545454
		v2 = v3 * 7.5625 * v3 + 0.75
	elseif v1 < 0.9090909090909091 then
		local v4 = v1 - 0.8181818181818182
		v2 = v4 * 7.5625 * v4 + 0.9375
	else
		local v5 = v1 - 0.9545454545454546
		v2 = v5 * 7.5625 * v5 + 0.984375
	end
	return 1 - v2
end
local t2 = {
	[EasingStyle.Linear] = function(p1) --[[ Line: 519 ]]
		return p1
	end,
	[EasingStyle.Sine] = function(p1) --[[ Line: 520 ]]
		return 1 - math.cos(p1 * math.pi / 2)
	end,
	[EasingStyle.Quad] = function(p1) --[[ Line: 521 ]]
		return p1 * p1
	end,
	[EasingStyle.Cubic] = function(p1) --[[ Line: 522 ]]
		return p1 * p1 * p1
	end,
	[EasingStyle.Quart] = function(p1) --[[ Line: 523 ]]
		return p1 * p1 * p1 * p1
	end,
	[EasingStyle.Quint] = function(p1) --[[ Line: 524 ]]
		return p1 * p1 * p1 * p1 * p1
	end,
	[EasingStyle.Exponential] = function(p1) --[[ Line: 525 ]]
		if p1 == 0 then
			return 0
		else
			return 2 ^ (10 * p1 - 10)
		end
	end,
	[EasingStyle.Circular] = function(p1) --[[ Line: 526 ]]
		return 1 - math.sqrt(1 - p1 * p1)
	end
}
local v1 = 1.70158
t2[EasingStyle.Back] = function(p1) --[[ Line: 503 | Upvalues: v1 (copy) ]]
	return p1 * p1 * ((v1 + 1) * p1 - v1)
end
t2[EasingStyle.Bounce] = bounceIn
local v2 = 0.075
local v3 = 0.3
t2[EasingStyle.Elastic] = function(p1) --[[ Line: 505 | Upvalues: v2 (copy), v3 (copy) ]]
	if p1 ~= 0 and p1 ~= 1 then
		return -2 ^ (10 * (p1 - 1)) * math.sin((p1 - 1 - v2) * 6.283185307179586 / v3)
	end
	return p1
end
local t3 = {
	Linear = EasingStyle.Linear,
	Sine = EasingStyle.Sine,
	Quad = EasingStyle.Quad,
	Cubic = EasingStyle.Cubic,
	Quart = EasingStyle.Quart,
	Quint = EasingStyle.Quint,
	Expo = EasingStyle.Exponential,
	Exponential = EasingStyle.Exponential,
	Circle = EasingStyle.Circular,
	Circular = EasingStyle.Circular,
	Back = EasingStyle.Back,
	Bounce = EasingStyle.Bounce,
	Elastic = EasingStyle.Elastic
}
local t4 = {
	In = EasingDirection.In,
	Out = EasingDirection.Out,
	InOut = EasingDirection.InOut
}
local function applyDirection(p1, p2) --[[ applyDirection | Line: 539 | Upvalues: EasingDirection (copy) ]]
	if p2 == EasingDirection.In then
		return p1
	end
	if p2 == EasingDirection.Out then
		return function(p12) --[[ Line: 542 | Upvalues: p1 (copy) ]]
			return 1 - p1(1 - p12)
		end
	else
		return function(p12) --[[ Line: 498 | Upvalues: p1 (copy) ]]
			if p12 < 0.5 then
				return 0.5 * p1(p12 * 2)
			else
				return 1 - 0.5 * p1((1 - p12) * 2)
			end
		end
	end
end
local function easingFromNames(p1, p2) --[[ easingFromNames | Line: 547 | Upvalues: t3 (copy), EasingStyle (copy), t4 (copy), EasingDirection (copy), t2 (copy) ]]
	if p1 == "None" then
		return function(p1) --[[ Line: 549 ]]
			if p1 >= 1 then
				return 1
			else
				return 0
			end
		end
	end
	local v2 = t4[p2 or "In"] or EasingDirection.In
	local v3 = t2[t3[p1 or "Linear"] or EasingStyle.Linear] or t2[EasingStyle.Linear]
	if v2 == EasingDirection.In then
		return v3
	end
	if v2 == EasingDirection.Out then
		return function(p1) --[[ Line: 542 | Upvalues: v3 (copy) ]]
			return 1 - v3(1 - p1)
		end
	else
		return function(p1) --[[ Line: 498 | Upvalues: v3 (copy) ]]
			if p1 < 0.5 then
				return 0.5 * v3(p1 * 2)
			else
				return 1 - 0.5 * v3((1 - p1) * 2)
			end
		end
	end
end
local t5 = {}
local function getCachedEasing(p1, p2) --[[ getCachedEasing | Line: 560 | Upvalues: t5 (copy), easingFromNames (copy) ]]
	local v1 = (p1 or "Linear") .. "|" .. (p2 or "In")
	local v2 = t5[v1]
	if v2 then
		return v2
	else
		local v3 = easingFromNames(p1, p2)
		t5[v1] = v3
		return v3
	end
end
local t6 = {
	number = function(p1, p2, p3) --[[ number | Line: 571 ]]
		return p1 + (p2 - p1) * p3
	end,
	Vector2 = function(p1, p2, p3) --[[ Vector2 | Line: 572 ]]
		return p1 + (p2 - p1) * p3
	end,
	Vector3 = function(p1, p2, p3) --[[ Vector3 | Line: 573 ]]
		return p1:Lerp(p2, p3)
	end,
	Color3 = function(p1, p2, p3) --[[ Color3 | Line: 574 ]]
		return p1:Lerp(p2, p3)
	end,
	UDim = function(p1, p2, p3) --[[ UDim | Line: 575 ]]
		return UDim.new(p1.Scale + (p2.Scale - p1.Scale) * p3, (math.floor(p1.Offset + (p2.Offset - p1.Offset) * p3)))
	end,
	UDim2 = function(p1, p2, p3) --[[ UDim2 | Line: 581 ]]
		return UDim2.new(p1.X.Scale + (p2.X.Scale - p1.X.Scale) * p3, math.floor(p1.X.Offset + (p2.X.Offset - p1.X.Offset) * p3), p1.Y.Scale + (p2.Y.Scale - p1.Y.Scale) * p3, (math.floor(p1.Y.Offset + (p2.Y.Offset - p1.Y.Offset) * p3)))
	end,
	CFrame = function(p1, p2, p3) --[[ CFrame | Line: 589 ]]
		return p1:Lerp(p2, p3)
	end
}
local function findMeshChild(p1) --[[ findMeshChild | Line: 595 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("DataModelMesh") then
			return v
		end
	end
	return nil
end
local function effectiveRenderedSize(p1) --[[ effectiveRenderedSize | Line: 607 | Upvalues: findMeshChild (copy) ]]
	local Size = p1.Size
	local v1 = findMeshChild(p1)
	if v1 then
		local Scale = v1.Scale
		return Vector3.new(Size.X * Scale.X, Size.Y * Scale.Y, Size.Z * Scale.Z)
	else
		return Size
	end
end
local function isTinySize(p1) --[[ isTinySize | Line: 618 ]]
	local count = 0
	if p1.X < 0.02 then
		count = count + 1
	end
	if p1.Y < 0.02 then
		count = count + 1
	end
	if p1.Z < 0.02 then
		count = count + 1
	end
	return count >= 2
end
local function buildInstanceTrack(p1) --[[ buildInstanceTrack | Line: 627 | Upvalues: HttpService (copy) ]]
	local v1 = p1:GetAttribute("MeshEmitter")
	if not v1 then
		return nil
	end
	local v2, v3 = pcall(function() --[[ Line: 630 | Upvalues: HttpService (ref), v1 (copy) ]]
		return HttpService:JSONDecode(v1)
	end)
	if not v2 or type(v3) ~= "table" then
		return nil
	end
	local t = {}
	for k, v in pairs(v3) do
		if type(v) == "table" and #v > 0 then
			table.sort(v, function(p1, p2) --[[ Line: 636 ]]
				return (p1.Time or 0) < (p2.Time or 0)
			end)
			t[k] = {
				property = k,
				keys = v
			}
		end
	end
	return {
		_swapOrig = nil,
		_isExternal = false,
		instance = p1,
		groupType = p1:GetAttribute("GroupType"),
		tracks = t,
		_cache = {},
		_firedEmitIdx = {}
	}
end
local function collectTracks(p1) --[[ collectTracks | Line: 652 | Upvalues: buildInstanceTrack (copy), HttpService (copy), parseExternalKeyPath (copy) ]]
	local t = {}
	for i, v in ipairs(p1:GetDescendants()) do
		if v:GetAttribute("MeshEmitter") then
			local v1 = buildInstanceTrack(v)
			if v1 then
				table.insert(t, v1)
			end
		end
	end
	local v2 = p1:GetAttribute("MeshEmitterExternalTracks") or p1:GetAttribute("MeshEmitterExternal")
	if v2 then
		local v3, v4 = pcall(function() --[[ Line: 668 | Upvalues: HttpService (ref), v2 (ref) ]]
			return HttpService:JSONDecode(v2)
		end)
		if v3 and type(v4) == "table" then
			for k, v in pairs(v4) do
				local v5 = false
				if type(k) == "string" and (type(v) == "table" and #v > 0) then
					local v6 = v[1]
					if type(v6) == "table" and (v6.Tracks ~= nil or v6.InstanceNames ~= nil) then
						v5 = true
					end
				end
				if v5 then
					for i, v6 in ipairs(v) do
						if type(v6) == "table" then
							local Tracks = v6.Tracks
							local InstanceNames = v6.InstanceNames
							local InstanceTypes = v6.InstanceTypes
							if type(Tracks) == "table" and type(InstanceNames) == "table" then
								local t2 = {}
								for k2, v7 in pairs(Tracks) do
									if type(v7) == "table" and #v7 > 0 then
										table.sort(v7, function(p1, p2) --[[ Line: 691 ]]
											return (p1.Time or 0) < (p2.Time or 0)
										end)
										t2[k2] = {
											property = k2,
											keys = v7
										}
									end
								end
								if next(t2) ~= nil then
									local t3 = {}
									local t4 = {}
									local v7 = nil
									local v8 = nil
									for i2 = 1, #InstanceNames do
										local v9
										table.insert(t3, (tostring(InstanceNames[i2])))
										v9 = if type(InstanceTypes) == "table" then tostring(InstanceTypes[i2] or "") else ""
										table.insert(t4, v9)
									end
									if #t3 > 0 then
										v7 = t3[#t3]
									end
									if #t4 > 0 and t4[#t4] ~= "" then
										v8 = t4[#t4]
									end
									local v14 = ("GROUP:%s:%s"):format(k, table.concat(t3, " > "))
									table.insert(t, {
										instance = nil,
										_swapOrig = nil,
										_isExternal = true,
										groupType = k,
										tracks = t2,
										_cache = {},
										_firedEmitIdx = {},
										_externalId = v14,
										_externalName = v7 or v14,
										_externalClass = v8,
										_externalPathNames = t3,
										_externalPathTypes = t4
									})
								end
							end
						end
					end
					continue
				end
				if type(k) == "string" and type(v) == "table" then
					local t2 = {}
					for k2, v6 in pairs(v) do
						if type(v6) == "table" and #v6 > 0 then
							table.sort(v6, function(p1, p2) --[[ Line: 745 ]]
								return (p1.Time or 0) < (p2.Time or 0)
							end)
							t2[k2] = {
								property = k2,
								keys = v6
							}
						end
					end
					if next(t2) ~= nil then
						local v15, v16, v17, v18 = parseExternalKeyPath(k)
						table.insert(t, {
							instance = nil,
							groupType = "External",
							_swapOrig = nil,
							_isExternal = true,
							tracks = t2,
							_cache = {},
							_firedEmitIdx = {},
							_externalId = k,
							_externalName = v17 or k,
							_externalClass = v18,
							_externalPathNames = v15,
							_externalPathTypes = v16
						})
					end
				end
			end
		end
	end
	return t
end
local function findSegment(p1, p2) --[[ findSegment | Line: 778 ]]
	local v1 = #p1
	if v1 == 0 then
		return
	end
	if p2 <= p1[1].Time then
		return 1, 1, p1[1], p1[1], 0
	end
	if p1[v1].Time <= p2 then
		return v1, v1, p1[v1], p1[v1], 1
	end
	local v2 = 1
	local v3 = v1 - 1
	while v2 < v3 do
		local v4 = v2 + math.floor((v3 - v2 + 1) / 2)
		if p1[v4].Time <= p2 then
			v2 = v4
		else
			v3 = v4 - 1
		end
	end
	local v5 = p1[v2]
	local v6 = p1[v2 + 1]
	return v2, v2 + 1, v5, v6, (p2 - v5.Time) / math.max(1e-6, v6.Time - v5.Time)
end
local function getCachedValue(p1, p2, p3, p4, p5, p6) --[[ getCachedValue | Line: 801 | Upvalues: expectTypeFor (copy), deserialize (copy) ]]
	if p1[p2] ~= nil then
		return p1[p2]
	end
	local v2 = deserialize(p3.Value, if p4 then p4 else expectTypeFor(p5, p6))
	p1[p2] = v2
	return v2
end
local function processEmitBursts(p1, p2, p3) --[[ processEmitBursts | Line: 810 | Upvalues: deserialize (copy) ]]
	local instance = p1.instance
	if not instance then
		return
	end
	local Emit = p1.tracks.Emit
	if not (Emit and instance:IsA("ParticleEmitter")) then
		return
	end
	local keys = Emit.keys
	for i = math.max(1, (p1._firedEmitIdx.Emit or 0) + 1), #keys do
		local v2 = keys[i]
		if v2.Time and (v2.Time <= p2 and p3 < v2.Time) then
			local v5 = tonumber(deserialize(v2.Value, "number")) or 0
			if v5 > 0 then
				instance:Emit(v5)
			end
			p1._firedEmitIdx.Emit = i
			continue
		end
		if v2.Time and p2 < v2.Time then
			break
		end
	end
end
local function scaleCFrameOffset(p1, p2) --[[ scaleCFrameOffset | Line: 830 ]]
	if p2 == 1 then
		return p1
	else
		return CFrame.fromMatrix(p1.Position * p2, p1.XVector, p1.YVector, p1.ZVector)
	end
end
local function scaleNumberSequence(p1, p2) --[[ scaleNumberSequence | Line: 836 ]]
	if p2 == 1 then
		return p1
	end
	local Keypoints = p1.Keypoints
	local v1 = table.create(#Keypoints)
	for i, v in ipairs(Keypoints) do
		v1[i] = NumberSequenceKeypoint.new(v.Time, v.Value * p2)
	end
	return NumberSequence.new(v1)
end
local function scaleNumberSequenceStatic(p1, p2) --[[ scaleNumberSequenceStatic | Line: 846 | Upvalues: scaleNumberSequence (copy) ]]
	return scaleNumberSequence(p1, p2)
end
local function isEffect(p1) --[[ isEffect | Line: 851 ]]
	return p1:IsA("ColorCorrectionEffect") or (p1:IsA("BloomEffect") or (p1:IsA("BlurEffect") or (p1:IsA("DepthOfFieldEffect") or p1:IsA("SunRaysEffect"))))
end
local function getScreenGuiRoot(p1) --[[ getScreenGuiRoot | Line: 856 ]]
	local v1 = p1
	while v1 and (v1 ~= game and v1.Parent) do
		if v1:IsA("ScreenGui") then
			return v1
		end
		v1 = v1.Parent
	end
	return nil
end
local function buildPath(p1, p2) --[[ buildPath | Line: 865 ]]
	local v1, v2 = p2, {}
	while v1 and v1 ~= p1 do
		table.insert(v2, 1, v1.Name)
		v1 = v1.Parent
	end
	return v2
end
local function followPath(p1, p2) --[[ followPath | Line: 875 ]]
	local v1 = p1
	for i, v in ipairs(p2) do
		local v2 = v1:FindFirstChild(v)
		if not v2 then
			return nil
		end
		v1 = v2
	end
	return v1
end
local function updateTinyHide(p1, p2, p3) --[[ updateTinyHide | Line: 891 | Upvalues: findMeshChild (copy) ]]
	local Size = p1.Size
	local v1 = findMeshChild(p1)
	local v2
	if v1 then
		local Scale = v1.Scale
		v2 = Vector3.new(Size.X * Scale.X, Size.Y * Scale.Y, Size.Z * Scale.Z)
	else
		v2 = Size
	end
	local count = 0
	if v2.X < 0.02 then
		count = count + 1
	end
	if v2.Y < 0.02 then
		count = count + 1
	end
	if v2.Z < 0.02 then
		count = count + 1
	end
	if if count >= 2 then true else false then
		if p2[p1] == nil then
			p2[p1] = p1.Transparency
		end
		if p1.Transparency ~= 1 then
			p1.Transparency = 1
		end
		for i, v in ipairs(p1:GetChildren()) do
			if v:IsA("Highlight") then
				if p3[v] == nil then
					p3[v] = v.Enabled
				end
				if v.Enabled then
					v.Enabled = false
				end
			end
		end
	else
		local v8 = p2[p1]
		if v8 ~= nil then
			pcall(function() --[[ Line: 921 | Upvalues: p1 (copy), v8 (copy) ]]
				p1.Transparency = v8
			end)
			p2[p1] = nil
		end
		for i, v in ipairs(p1:GetChildren()) do
			if v:IsA("Highlight") then
				local v9 = p3[v]
				if v9 ~= nil then
					pcall(function() --[[ Line: 931 | Upvalues: v (copy), v9 (copy) ]]
						v.Enabled = v9
					end)
					p3[v] = nil
				end
			end
		end
	end
end
function t.new(p1) --[[ new | Line: 940 | Upvalues: t (copy), collectTracks (copy), HttpService (copy) ]]
	assert(p1 and p1:IsA("Model"), "MeshEmitterPlayer.new expects a Model")
	local v3 = setmetatable({}, t)
	v3.Model = p1
	v3.Primary = p1.PrimaryPart
	v3.AnchorCFrame = v3.Primary and v3.Primary.CFrame or CFrame.new()
	v3.FPS = 60
	v3.Speed = 1
	v3.Scale = 1
	v3.Looping = false
	v3._tracks = collectTracks(p1)
	v3._running = false
	v3._paused = false
	v3._t = 0
	v3._lastT = 0
	v3._len = 0
	v3._conn = nil
	v3._onCompleted = {}
	v3._onEvent = {}
	v3._named = {}
	v3._events = {}
	v3._eventIdx = 0
	v3._Offsets = {}
	v3._offsetsByName = {}
	v3._userEvents = {}
	v3._userEvtIdx = 0
	v3._tracksByInstance = {}
	v3._externalById = {}
	v3._externalByName = {}
	for i, v in ipairs(v3._tracks) do
		if v._isExternal then
			local v5 = v._externalId or ""
			if v5 ~= "" then
				v3._externalById[v5] = v
			end
			local _externalName = v._externalName
			if _externalName and _externalName ~= "" then
				v3._externalByName[_externalName] = v3._externalByName[_externalName] or {}
				table.insert(v3._externalByName[_externalName], v)
			end
			continue
		end
		if v.instance then
			v3._tracksByInstance[v.instance] = v
		end
	end
	v3._origPartSize = {}
	v3._origMeshScale = {}
	v3._origParticleSize = {}
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			v3._origPartSize[v] = v.Size
			for i2, v5 in ipairs(v:GetChildren()) do
				if v5:IsA("SpecialMesh") then
					v3._origMeshScale[v5] = v5.Scale
				end
			end
			continue
		end
		if v:IsA("ParticleEmitter") then
			v3._origParticleSize[v] = v.Size
		end
	end
	v3._lastAppliedStaticScale = 1
	for i, v in ipairs(v3._tracks) do
		for k, v5 in pairs(v.tracks) do
			local v8 = v5.keys[#v5.keys]
			if v8 and (v8.Time and v8.Time > v3._len) then
				v3._len = v8.Time
			end
		end
	end
	local v9 = p1:GetAttribute("MeshEmitterEvents")
	if v9 then
		local v10, v11 = pcall(function() --[[ Line: 1019 | Upvalues: HttpService (ref), v9 (copy) ]]
			return HttpService:JSONDecode(v9)
		end)
		if v10 and type(v11) == "table" then
			table.sort(v11, function(p1, p2) --[[ Line: 1021 ]]
				return (p1.Time or 0) < (p2.Time or 0)
			end)
			v3._events = v11
		end
	end
	v3._spawnedVisuals = false
	v3._addedLighting = false
	v3._lightingTarget = nil
	v3._timeStopped = false
	v3._liveEffects = {}
	v3._liveGuis = {}
	v3._uiRoots = {}
	v3._modelTransparencyCache = {}
	v3._tinyPartCache = {}
	v3._tinyHighlightCache = {}
	v3._tinyCandidates = {}
	return v3
end
function t.AssignExternal(p1, p2, p3, p4) --[[ AssignExternal | Line: 1073 | Upvalues: resolveOrCreateUnder (copy), resolvePathUnder (copy) ]]
end
function t.AssignExternalByName(p1, p2, p3, p4) --[[ AssignExternalByName | Line: 1319 ]]
	return p1:AssignExternal(p2, p3, p4)
end
function t.AssignAllExternalByClass(p1, p2, p3) --[[ AssignAllExternalByClass | Line: 1323 ]]
	for i, v in ipairs(p1._tracks) do
		if v._isExternal and v._externalClass == p2 then
			local t = {
				Id = v._externalId or "",
				Name = v._externalName,
				ClassName = v._externalClass,
				GroupType = v.groupType,
				Tracks = {}
			}
			local v1, v2 = pcall(function() --[[ Line: 1333 | Upvalues: p3 (copy), t (copy) ]]
				return p3(t)
			end)
			if v1 and (v2 and typeof(v2) == "Instance") then
				v.instance = v2
				p1._tracksByInstance[v2] = v
			end
		end
	end
	return p1
end
function t.SetAnchor(p1, p2) --[[ SetAnchor | Line: 1344 ]]
	p1.AnchorCFrame = p2
	return p1
end
function t.SetSpeed(p1, p2) --[[ SetSpeed | Line: 1345 ]]
	p1.Speed = math.max(0, p2 or 1)
	return p1
end
function t.SetScale(p1, p2) --[[ SetScale | Line: 1346 ]]
	p1.Scale = math.max(0, p2 or 1)
	p1:_applyStaticScaleIfNeeded(true)
	return p1
end
function t.GetScale(p1) --[[ GetScale | Line: 1347 ]]
	return p1.Scale
end
function t.OnCompleted(p1, p2) --[[ OnCompleted | Line: 1348 ]]
	table.insert(p1._onCompleted, p2)
	return p1
end
function t.OnEvent(p1, p2) --[[ OnEvent | Line: 1349 ]]
	table.insert(p1._onEvent, p2)
	return p1
end
function t.Bind(p1, p2, p3) --[[ Bind | Line: 1350 ]]
	p1._named[p2] = p1._named[p2] or {}
	table.insert(p1._named[p2], p3)
	return p1
end
function t.GetTime(p1) --[[ GetTime | Line: 1353 ]]
	return p1._t
end
function t.GetLength(p1) --[[ GetLength | Line: 1354 ]]
	return p1._len
end
function t.IsPlaying(p1) --[[ IsPlaying | Line: 1355 ]]
	return p1._running and not p1._paused
end
function t.IsPaused(p1) --[[ IsPaused | Line: 1356 ]]
	return p1._paused
end
function t.SetLooping(p1, p2) --[[ SetLooping | Line: 1357 ]]
	p1.Looping = p2
	return p1
end
function t.AddTimeEvent(p1, p2, p3) --[[ AddTimeEvent | Line: 1360 ]]
	local t = {
		Time = math.max(0, p3),
		Callback = p2
	}
	local v1 = false
	for i = 1, #p1._userEvents do
		if t.Time < p1._userEvents[i].Time then
			table.insert(p1._userEvents, i, t)
			v1 = true
			break
		end
	end
	if not v1 then
		table.insert(p1._userEvents, t)
	end
	if t.Time <= p1._t then
		p1._userEvtIdx = p1._userEvtIdx + 1
	end
	return p1
end
function t.AddFrameEvent(p1, p2, p3) --[[ AddFrameEvent | Line: 1371 ]]
	return p1:AddTimeEvent(p2, (p3 or 0) / (p1.FPS > 0 and p1.FPS or 60))
end
function t.AddOffset(p1, p2) --[[ AddOffset | Line: 1377 ]]
	table.insert(p1._Offsets, p2)
	p1:_rebuildOffsetIndex()
end
function t._rebuildOffsetIndex(p1) --[[ _rebuildOffsetIndex | Line: 1384 ]]
	local t = {}
	for k, v in pairs(p1._Offsets) do
		if v.Parts and v.Anchor then
			for k2, v2 in pairs(v.Parts) do
				t[v2] = v.Anchor
			end
		end
	end
	p1._offsetsByName = t
end
function t.AddFrameNamedEvent(p1, p2, p3, p4) --[[ AddFrameNamedEvent | Line: 1396 ]]
	local t = {
		Kind = "User",
		Time = (p3 or 0) / (p1.FPS > 0 and p1.FPS or 60)
	}
	t.String = p2 .. (if p4 then ": " .. p4 else "")
	local v5 = false
	for i = 1, #p1._events do
		if t.Time < p1._events[i].Time then
			table.insert(p1._events, i, t)
			v5 = true
			break
		end
	end
	if not v5 then
		table.insert(p1._events, t)
	end
	if t.Time <= p1._t then
		p1._eventIdx = p1._eventIdx + 1
	end
	return p1
end
function t._fireEvent(p1, p2) --[[ _fireEvent | Line: 1409 | Upvalues: parseParams (copy) ]]
	for i, v in ipairs(p1._onEvent) do
		task.spawn(v, p2, p1)
	end
	local v2 = tostring(p2.String or "")
	local v3 = string.find(v2, ":", 1, true)
	local v4, v5
	if v3 and v3 > 1 then
		local v6 = string.sub(v2, 1, v3 - 1):gsub("^%s+", ""):gsub("%s+$", "")
		v4, v5 = v6, string.sub(v2, v3 + 1):gsub("^%s+", ""):gsub("%s+$", "")
	else
		v4 = nil
		v5 = v2
	end
	if not (v4 and p1._named[v4]) then
		return
	end
	local t = {
		Time = p2.Time,
		Name = v4,
		Payload = v5,
		Params = parseParams(v5 or ""),
		Kind = p2.Kind,
		String = p2.String
	}
	for i, v in ipairs(p1._named[v4]) do
		task.spawn(v, t, p1)
	end
end
function t._applyStaticScaleIfNeeded(p1, p2) --[[ _applyStaticScaleIfNeeded | Line: 1422 | Upvalues: scaleNumberSequence (copy) ]]
	if not p2 and p1._lastAppliedStaticScale == p1.Scale then
		return
	end
	local Scale = p1.Scale
	local function hasTrack(p12, p2) --[[ hasTrack | Line: 1425 | Upvalues: p1 (copy) ]]
		local v1 = p1._tracksByInstance[p12]
		return if v1 == nil or v1.tracks[p2] == nil then false else #v1.tracks[p2].keys > 0
	end
	for k, v in pairs(p1._origPartSize) do
		if k.Parent then
			local v1 = p1._tracksByInstance[k]
			if not (if v1 == nil or v1.tracks.Size == nil then false else #v1.tracks.Size.keys > 0) then
				k.Size = v * Scale
				p1._tinyCandidates[k] = true
			end
		end
		for i, v2 in ipairs(k:GetChildren()) do
			if v2:IsA("SpecialMesh") then
				local v3 = p1._origMeshScale[v2]
				if v3 and v2.Parent then
					local v4 = p1._tracksByInstance[v2]
					if not (if v4 == nil or v4.tracks.Scale == nil then false else #v4.tracks.Scale.keys > 0) then
						v2.Scale = v3 * Scale
						p1._tinyCandidates[k] = true
					end
				end
			end
		end
	end
	for k, v in pairs(p1._origParticleSize) do
		if k.Parent then
			local v6 = p1._tracksByInstance[k]
			if not (if v6 == nil or v6.tracks.Size == nil then false else #v6.tracks.Size.keys > 0) then
				k.Size = scaleNumberSequence(v, Scale)
			end
		end
	end
	p1._lastAppliedStaticScale = Scale
end
local function applyProperty(p1, p2, p3, p4, p5, p6, p7) --[[ applyProperty | Line: 1452 | Upvalues: scaleNumberSequence (copy) ]]
	if p2 == "CFrame" and typeof(p3) == "CFrame" then
		local v4 = p4 * (if p5 == 1 then p3 else CFrame.fromMatrix(p3.Position * p5, p3.XVector, p3.YVector, p3.ZVector))
		if p1:IsA("BasePart") then
			p1.CFrame = v4
			return
		end
		if p1:IsA("Attachment") then
			p1.WorldCFrame = v4
			return
		end
		if p1:IsA("Model") then
			p1:PivotTo(v4)
			return
		end
		if not p1:IsA("ValueBase") then
			return
		end
		pcall(function() --[[ Line: 1471 | Upvalues: p1 (copy), v4 (copy) ]]
			p1.Value = v4
		end)
	elseif typeof(p3) == "Vector3" and (p2 == "Size" and p1:IsA("BasePart")) then
		p1[p2] = p3 * p5
		if not p7 then
			return
		end
		p7[p1] = true
	elseif typeof(p3) == "Vector3" and (p2 == "Scale" and p1:IsA("DataModelMesh")) then
		p1.Scale = p3 * p5
		if not (p7 and (p1.Parent and p1.Parent:IsA("BasePart"))) then
			return
		end
		p7[p1.Parent] = true
	else
		if typeof(p3) == "Vector3" and (p2 == "Position" and p1:IsA("Attachment")) then
			p1[p2] = p3 * p5
			return
		end
		if p1:IsA("ParticleEmitter") and (p2 == "Size" and typeof(p3) == "NumberSequence") then
			p1[p2] = scaleNumberSequence(p3, p5)
			return
		end
		if p1:IsA("Model") then
			if p2 == "Scale" then
				local v5 = nil
				if typeof(p3) == "number" then
					v5 = p3
				elseif typeof(p3) == "NumberRange" then
					v5 = p3.Max
				elseif typeof(p3) == "Vector2" then
					v5 = p3.Y
				elseif typeof(p3) == "Vector3" then
					v5 = p3.X
				else
					local v7 = tonumber((tostring(p3)))
					if v7 then
						v5 = v7
					end
				end
				if v5 == nil then
					return
				end
				p1:ScaleTo((math.clamp(v5, 0.0001, (1 / 0))))
				return
			elseif p2 == "Transparency" then
				local v8 = typeof(p3) == "number" and p3 or 0
				if p6 then
					local v9 = p6[p1]
					if not v9 then
						v9 = {}
						for v10, v11 in p1:GetDescendants() do
							if v11:IsA("BasePart") or v11:IsA("Decal") then
								v9[v11] = v11.Transparency
							end
						end
						p6[p1] = v9
					end
					for k, v in pairs(v9) do
						if k.Parent then
							k.Transparency = v + (1 - v) * v8
						end
					end
				else
					for v12, v13 in p1:GetDescendants() do
						if v13:IsA("BasePart") or v13:IsA("Decal") then
							v13.Transparency = v8
						end
					end
				end
				return
			end
		end
		if p1:IsA("Beam") or p1:IsA("Trail") then
			if p2 == "Color" then
				local v14 = nil
				if typeof(p3) == "ColorSequence" then
					v14 = p3
				elseif typeof(p3) == "Color3" then
					v14 = ColorSequence.new(p3)
				end
				if not v14 then
					return
				end
				p1.Color = v14
				return
			elseif p2 == "Transparency" then
				local v15 = nil
				if typeof(p3) == "NumberSequence" then
					v15 = p3
				elseif typeof(p3) == "number" then
					v15 = NumberSequence.new(p3)
				end
				if not v15 then
					return
				end
				p1.Transparency = v15
				return
			end
		end
		if p1:IsA("ValueBase") then
			pcall(function() --[[ Line: 1592 | Upvalues: p1 (copy), p3 (copy) ]]
				p1.Value = p3
			end)
		else
			pcall(function() --[[ Line: 1598 | Upvalues: p1 (copy), p2 (copy), p3 (copy) ]]
				p1[p2] = p3
			end)
		end
	end
end
function t.StopTime(p1) --[[ StopTime | Line: 1617 ]]
	p1._timeStopped = true
	return p1
end
function t.StartTime(p1) --[[ StartTime | Line: 1624 ]]
	p1._timeStopped = false
	return p1
end
function t.AddLighting(p1) --[[ AddLighting | Line: 1629 | Upvalues: resolveOrCreateUnder (copy), Lighting (copy), isEffect (copy), RunService (copy) ]]
	if p1._addedLighting then
		return p1
	end
	p1._addedLighting = true
	if p1._lightingTarget then
		for i, v in ipairs(p1._tracks) do
			if v._isExternal and (v.instance == nil and v._externalPathNames) then
				local v1 = false
				for i2, v2 in ipairs(v._externalPathNames) do
					if string.lower((tostring(v2))) == "lighting" then
						v1 = true
						break
					end
				end
				if v1 then
					local v2 = resolveOrCreateUnder(p1._lightingTarget, v._externalPathNames, v._externalPathTypes, true)
					if v2 then
						v.instance = v2
						p1._tracksByInstance[v2] = v
						table.insert(p1._liveEffects, v2)
					end
				end
			end
		end
	end
	for i, v in ipairs(p1._tracks) do
		local v3
		local instance = v.instance
		if instance and (instance:GetAttribute("GroupType") == "Lighting" and instance:IsDescendantOf(p1.Model)) then
			v3 = if (instance:GetAttribute("LightingTarget") or "Lighting") == "Terrain" then workspace:FindFirstChildOfClass("Terrain") else Lighting
			if v3 then
				local v4, v5 = pcall(function() --[[ Line: 1674 | Upvalues: instance (copy) ]]
					return instance:Clone()
				end)
				if v4 and v5 then
					v5.Parent = v3
					p1._tracksByInstance[v.instance] = nil
					v._swapOrig = v.instance
					v.instance = v5
					p1._tracksByInstance[v.instance] = v
					table.insert(p1._liveEffects, v5)
				end
			end
		end
	end
	for i, v in ipairs(p1._tracks) do
		local instance = v.instance
		if instance and (isEffect(instance) and not (instance:GetAttribute("LightingTarget") or v._swapOrig)) then
			local v6, v7 = pcall(function() --[[ Line: 1695 | Upvalues: instance (copy) ]]
				return instance:Clone()
			end)
			if v6 and v7 then
				local v8 = if instance.Parent and (instance.Parent:IsA("Camera") and RunService:IsClient()) then workspace.CurrentCamera else nil
				if v8 then
					v7.Parent = v8
				else
					v7.Parent = Lighting
				end
				p1._tracksByInstance[v.instance] = nil
				v._swapOrig = v.instance
				v.instance = v7
				p1._tracksByInstance[v.instance] = v
				table.insert(p1._liveEffects, v7)
			end
		end
	end
	pcall(function() --[[ Line: 1714 | Upvalues: p1 (copy) ]]
		p1:_evalAndApplyAt(p1._t, p1._t)
	end)
	return p1
end
function t._spawnRuntimeVisualsIfNeeded(p1) --[[ _spawnRuntimeVisualsIfNeeded | Line: 1718 | Upvalues: getScreenGuiRoot (copy), RunService (copy), Players (copy), buildPath (copy), followPath (copy) ]]
	if p1._spawnedVisuals then
		return
	end
	p1._spawnedVisuals = true
	local t = {}
	for i, v in ipairs(p1._tracks) do
		local instance = v.instance
		if instance and (instance.Parent and instance:IsA("GuiObject")) then
			local v1 = getScreenGuiRoot(instance)
			if v1 and (v1:IsDescendantOf(p1.Model) and not t[v1]) then
				t[v1] = true
				local v2 = nil
				if RunService:IsClient() then
					local LocalPlayer = Players.LocalPlayer
					if LocalPlayer then
						v2 = LocalPlayer:FindFirstChildOfClass("PlayerGui")
					end
				end
				if not v2 then
					local v3, v4 = pcall(function() --[[ Line: 1741 ]]
						return game:GetService("StarterGui")
					end)
					if v3 then
						v2 = v4
					end
				end
				if v2 then
					local v5, v6 = pcall(function() --[[ Line: 1746 | Upvalues: v1 (copy) ]]
						return v1:Clone()
					end)
					if v5 and v6 then
						v6.ResetOnSpawn = false
						v6.Parent = v2
						table.insert(p1._liveGuis, v6)
						table.insert(p1._uiRoots, v1)
						for i2, v3 in ipairs(p1._tracks) do
							local instance_2 = v3.instance
							if instance_2 and instance_2:IsDescendantOf(v1) then
								local v7 = followPath(v6, (buildPath(v1, instance_2)))
								if v7 then
									p1._tracksByInstance[v3.instance] = nil
									v3._swapOrig = v3.instance
									v3.instance = v7
									p1._tracksByInstance[v7] = v3
								end
							end
						end
					end
				end
			end
		end
	end
end
function t._cleanupRuntimeVisuals(p1) --[[ _cleanupRuntimeVisuals | Line: 1774 ]]
	for i, v in ipairs(p1._tracks) do
		if v._swapOrig then
			if v.instance then
				p1._tracksByInstance[v.instance] = nil
			end
			v.instance = v._swapOrig
			p1._tracksByInstance[v.instance] = v
			v._swapOrig = nil
		end
	end
	for i, v in ipairs(p1._liveEffects) do
		if v and v.Parent then
			v:Destroy()
		end
	end
	p1._liveEffects = {}
	for i, v in ipairs(p1._liveGuis) do
		if v and v.Parent then
			v:Destroy()
		end
	end
	p1._liveGuis = {}
	p1._uiRoots = {}
	p1._spawnedVisuals = false
	p1._addedLighting = false
	p1._lightingTarget = nil
	p1._timeStopped = false
end
function t._processEmbeddedEvents(p1, p2, p3) --[[ _processEmbeddedEvents | Line: 1795 ]]
	local _events = p1._events
	if #_events == 0 then
		return
	end
	local count = p1._eventIdx + 1
	while count <= #_events do
		local v1 = _events[count]
		local v2 = tonumber(v1.Time) or 0
		if v2 <= p2 and p3 < v2 then
			p1:_fireEvent(v1)
			p1._eventIdx = count
		else
			if p2 < v2 then
				break
			end
			if p1._eventIdx < count then
				p1._eventIdx = count
			end
		end
		count = count + 1
	end
end
function t._processUserEvents(p1, p2, p3) --[[ _processUserEvents | Line: 1811 ]]
	if #p1._userEvents == 0 then
		return
	end
	local count = p1._userEvtIdx + 1
	while count <= #p1._userEvents do
		local v1 = p1._userEvents[count]
		if v1.Time <= p2 and p3 < v1.Time then
			if typeof(v1.Callback) == "function" then
				task.spawn(v1.Callback, p1)
			end
			p1._userEvtIdx = count
		else
			if p2 < v1.Time then
				break
			end
			if p1._userEvtIdx < count then
				p1._userEvtIdx = count
			end
		end
		count = count + 1
	end
end
function t._evalAndApplyAt(p1, p2, p3) --[[ _evalAndApplyAt | Line: 1829 | Upvalues: processEmitBursts (copy), findSegment (copy), t5 (copy), easingFromNames (copy), expectTypeFor (copy), deserialize (copy), t6 (copy), applyProperty (copy), updateTinyHide (copy) ]]
	p1:_applyStaticScaleIfNeeded(false)
	p1:_processEmbeddedEvents(p2, p3)
	p1:_processUserEvents(p2, p3)
	local _offsetsByName = p1._offsetsByName
	for i, v in ipairs(p1._tracks) do
		local instance = v.instance
		if instance and (instance.Parent or instance:IsA("ValueBase")) then
			if instance:IsA("ValueBase") and not v._diagDone then
				v._diagDone = true
				local t = {}
				for k, v2 in pairs(v.tracks) do
					table.insert(t, k .. "(" .. tostring(#v2.keys) .. " keys)")
				end
				warn(("[MeshEmitter DIAG] ValueBase track found at index %d: inst=%s, class=%s, parent=%s, tracks=[%s]"):format(i, tostring(instance), instance.ClassName, tostring(instance.Parent), table.concat(t, ", ")))
			end
			processEmitBursts(v, p2, p3)
			for k, v2 in pairs(v.tracks) do
				local v6, v7, v8, v9, v10
				if k ~= "Emit" and (k ~= "ClockTime" or not p1._timeStopped) then
					local v11, v12, v13, v14, v15 = findSegment(v2.keys, p2)
					if v11 then
						local Style = v13.Style
						local Direction = v13.Direction
						local v16 = (Style or "Linear") .. "|" .. (Direction or "In")
						local v17 = t5[v16]
						if v17 then
							v6 = v17
						else
							local v18 = easingFromNames(Style, Direction)
							t5[v16] = v18
							v6 = v18
						end
						local v19 = v6(v15)
						v._cache[k] = v._cache[k] or {}
						local v21 = v._cache[k]
						local v22 = expectTypeFor(instance, k)
						if v21[v11] == nil then
							local v24 = deserialize(v13.Value, if v22 then v22 else expectTypeFor(instance, k))
							v21[v11] = v24
							v7 = v24
						else
							v7 = v21[v11]
						end
						if v21[v12] == nil then
							local v26 = deserialize(v14.Value, if v22 then v22 else expectTypeFor(instance, k))
							v21[v12] = v26
							v8 = v26
						else
							v8 = v21[v12]
						end
						local v27 = typeof(v7)
						local v28 = if v27 == "Instance" then v7.ClassName else v27
						local v29 = typeof(v8)
						if v28 == (if v29 == "Instance" then v8.ClassName else v29) then
							local v31 = t6[v28]
							v9 = if v31 then v31(v7, v8, v19) elseif v15 >= 1 then if v8 then v8 else v7 else v7
						else
							v10 = if v15 >= 1 and v8 then v8 else v7
							v9 = v10
						end
						applyProperty(instance, k, v9, _offsetsByName[instance.Name] and p1.AnchorCFrame * _offsetsByName[instance.Name] or p1.AnchorCFrame, p1.Scale, p1._modelTransparencyCache, p1._tinyCandidates)
					end
				end
			end
		end
	end
	if next(p1._tinyCandidates) == nil then
		return
	end
	for k, v in pairs(p1._tinyCandidates) do
		if k.Parent and k:IsA("BasePart") then
			updateTinyHide(k, p1._tinyPartCache, p1._tinyHighlightCache)
		end
	end
end
function t.Play(p1, p2) --[[ Play | Line: 1919 | Upvalues: RunService (copy) ]]
	if p1._running then
		p1._paused = false
		return p1
	end
	if p2 ~= nil then
		p1:SetTime(p2)
	end
	if pcall(function() --[[ Line: 1923 | Upvalues: p1 (copy) ]]
		p1:_spawnRuntimeVisualsIfNeeded()
	end) then
		p1._running = true
		p1._paused = false
		p1._conn = RunService.Heartbeat:Connect(function(p12_2) --[[ Line: 1929 | Upvalues: p1 (copy) ]]
			if not p1._running or p1._paused then
				return
			end
			local _t = p1._t
			p1._t = p1._t + p12_2 * p1.Speed
			if p1._t >= p1._len then
				p1._t = p1._len
			end
			p1:_evalAndApplyAt(p1._t, _t)
			if not (p1._t >= p1._len) then
				p1._lastT = p1._t
				return
			end
			if p1.Looping then
				p1._t = 0
				p1._lastT = 0
				p1._eventIdx = 0
				p1._userEvtIdx = 0
				for i2, v in ipairs(p1._tracks) do
					for k2, v3 in pairs(v._firedEmitIdx) do
						v._firedEmitIdx[k2] = 0
					end
				end
				for i2, v in ipairs(p1._onCompleted) do
					task.spawn(v)
				end
			else
				p1:_cleanupRuntimeVisuals()
				p1:_restoreModelTransparencies()
				p1:_restoreTinyParts()
				p1._running = false
				if p1._conn then
					p1._conn:Disconnect()
					p1._conn = nil
				end
				for i2, v in ipairs(p1._onCompleted) do
					task.spawn(v)
				end
			end
			p1._lastT = p1._t
		end)
		return p1
	end
	warn("[MeshEmitterPlayer] Visuals spawn skipped (non-fatal).")
	p1._running = true
	p1._paused = false
	p1._conn = RunService.Heartbeat:Connect(function(p12_2) --[[ Line: 1929 | Upvalues: p1 (copy) ]]
		if not p1._running or p1._paused then
			return
		end
		local _t = p1._t
		p1._t = p1._t + p12_2 * p1.Speed
		if p1._t >= p1._len then
			p1._t = p1._len
		end
		p1:_evalAndApplyAt(p1._t, _t)
		if not (p1._t >= p1._len) then
			p1._lastT = p1._t
			return
		end
		if p1.Looping then
			p1._t = 0
			p1._lastT = 0
			p1._eventIdx = 0
			p1._userEvtIdx = 0
			for i2, v in ipairs(p1._tracks) do
				for k2, v3 in pairs(v._firedEmitIdx) do
					v._firedEmitIdx[k2] = 0
				end
			end
			for i2, v in ipairs(p1._onCompleted) do
				task.spawn(v)
			end
		else
			p1:_cleanupRuntimeVisuals()
			p1:_restoreModelTransparencies()
			p1:_restoreTinyParts()
			p1._running = false
			if p1._conn then
				p1._conn:Disconnect()
				p1._conn = nil
			end
			for i2, v in ipairs(p1._onCompleted) do
				task.spawn(v)
			end
		end
		p1._lastT = p1._t
	end)
	return p1
end
function t.Pause(p1) --[[ Pause | Line: 1965 ]]
	p1._paused = true
	return p1
end
function t._restoreModelTransparencies(p1) --[[ _restoreModelTransparencies | Line: 1968 ]]
	if not p1._modelTransparencyCache then
		return
	end
	for k, v in pairs(p1._modelTransparencyCache) do
		for k2, v2 in pairs(v) do
			if k2.Parent then
				pcall(function() --[[ Line: 1973 | Upvalues: k2 (copy), v2 (copy) ]]
					k2.Transparency = v2
				end)
			end
		end
	end
	p1._modelTransparencyCache = {}
end
function t._restoreTinyParts(p1) --[[ _restoreTinyParts | Line: 1982 ]]
	if p1._tinyPartCache then
		for k, v in pairs(p1._tinyPartCache) do
			if k.Parent then
				pcall(function() --[[ Line: 1986 | Upvalues: k (copy), v (copy) ]]
					k.Transparency = v
				end)
			end
		end
		p1._tinyPartCache = {}
	end
	if p1._tinyHighlightCache then
		for k, v in pairs(p1._tinyHighlightCache) do
			if k.Parent then
				pcall(function() --[[ Line: 1994 | Upvalues: k (copy), v (copy) ]]
					k.Enabled = v
				end)
			end
		end
		p1._tinyHighlightCache = {}
	end
	p1._tinyCandidates = {}
end
function t.Stop(p1, p2) --[[ Stop | Line: 2002 ]]
	p1._running = false
	p1._paused = false
	if p1._conn then
		p1._conn:Disconnect()
		p1._conn = nil
	end
	p1:_cleanupRuntimeVisuals()
	p1:_restoreModelTransparencies()
	p1:_restoreTinyParts()
	if p2 then
		p1._t = 0
		p1._lastT = 0
		p1._eventIdx = 0
		p1._userEvtIdx = 0
		p1:_applyStaticScaleIfNeeded(true)
		p1:_evalAndApplyAt(p1._t, 0)
	end
	return p1
end
function t.SetTime(p1, p2) --[[ SetTime | Line: 2017 ]]
	local v1 = math.clamp(p2, 0, p1._len)
	p1._lastT = v1
	p1._t = v1
	if #p1._events > 0 then
		local v2 = 0
		for i, v in ipairs(p1._events) do
			if not ((v.Time or 0) <= v1) then
				break
			end
			v2 = i
		end
		p1._eventIdx = v2
	end
	if #p1._userEvents > 0 then
		local v3 = 0
		for i, v in ipairs(p1._userEvents) do
			if not ((v.Time or 0) <= v1) then
				break
			end
			v3 = i
		end
		p1._userEvtIdx = v3
	end
	p1:_applyStaticScaleIfNeeded(false)
	p1:_evalAndApplyAt(p1._t, p1._t)
	return p1
end
t.Seek = t.SetTime
function t.Destroy(p1) --[[ Destroy | Line: 2043 ]]
	p1:Stop()
	p1._tracks = {}
	p1._onCompleted = {}
	p1._onEvent = {}
	p1._named = {}
	p1._events = {}
	p1._userEvents = {}
	p1._tracksByInstance = {}
	p1._externalById = {}
	p1._externalByName = {}
	p1._origPartSize = {}
	p1._origMeshScale = {}
	p1._origParticleSize = {}
	p1._Offsets = {}
	p1._offsetsByName = {}
	p1._modelTransparencyCache = {}
	p1._tinyPartCache = {}
	p1._tinyHighlightCache = {}
	p1._tinyCandidates = {}
end
return {
	new = function(p1) --[[ new | Line: 2065 | Upvalues: t (copy) ]]
		return t.new(p1)
	end
}