 
  
local sRGB = require(script.Parent.sRGB)
local t = {
	fromLinear = function(p1) --[[ fromLinear | Line: 42 ]]
		local v2 = (p1.R * 0.4122214708 + p1.G * 0.5363325363 + p1.B * 0.0514459929) ^ 0.3333333333333333
		local v3 = (p1.R * 0.2119034982 + p1.G * 0.6806995451 + p1.B * 0.1073969566) ^ 0.3333333333333333
		local v4 = (p1.R * 0.0883024619 + p1.G * 0.2817188376 + p1.B * 0.6299787005) ^ 0.3333333333333333
		return Vector3.new(v2 * 0.2104542553 + v3 * 0.793617785 - v4 * 0.0040720468, v2 * 1.9779984951 - v3 * 2.428592205 + v4 * 0.4505937099, v2 * 0.0259040371 + v3 * 0.7827717662 - v4 * 0.808675766)
	end
}
function t.fromSRGB(p1) --[[ fromSRGB | Line: 59 | Upvalues: t (copy), sRGB (copy) ]]
	return t.fromLinear(sRGB.toLinear(p1))
end
function t.toLinear(p1, p2) --[[ toLinear | Line: 65 ]]
	local v2 = (p1.X + p1.Y * 0.3963377774 + p1.Z * 0.2158037573) ^ 3
	local v3 = (p1.X - p1.Y * 0.1055613458 - p1.Z * 0.0638541728) ^ 3
	local v4 = (p1.X - p1.Y * 0.0894841775 - p1.Z * 1.291485548) ^ 3
	local v5 = v2 * 4.0767416621 - v3 * 3.3077115913 + v4 * 0.2309699292
	local v6 = v2 * -1.2684380046 + v3 * 2.6097574011 - v4 * 0.3413193965
	local v7 = v2 * -0.0041960863 - v3 * 0.7034186147 + v4 * 1.707614701
	if not p2 then
		local v8 = math.clamp(v5, 0, 1)
		local v9 = math.clamp(v6, 0, 1)
		v5, v6, v7 = v8, v9, math.clamp(v7, 0, 1)
	end
	return Color3.new(v5, v6, v7)
end
function t.toSRGB(p1, p2) --[[ toSRGB | Line: 89 | Upvalues: sRGB (copy), t (copy) ]]
	return sRGB.fromLinear(t.toLinear(p1, p2))
end
return t