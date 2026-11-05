 
local u20 = {
	["lerp"] = function(_, p1, p2, p3) -- name: lerp
		if typeof(p1) == "CFrame" or (typeof(p1) == "Vector3" or typeof(p1) == "Color3") then
			return p1:Lerp(p2, p3)
		else
			return p1 + (p2 - p1) * p3
		end
	end,
	["unlimitedBezier"] = function(_, p4, p5) -- name: unlimitedBezier
		-- upvalues: (copy) u20
		while true do
			local v6 = {}
			for v7, v8 in ipairs(p5) do
				if v7 <= #p5 - 1 then
					v6[v7] = u20:lerp(v8, p5[v7 + 1], p4)
				end
			end
			if #v6 == 1 then
				return v6[1]
			end
			p5 = v6
		end
	end,
	["quadLerp"] = function(_, p9, p10, p11, p12) -- name: quadLerp
		return (1 - p12) ^ 2 * p9 + 2 * (1 - p12) * p12 * p10 + p12 ^ 2 * p11
	end,
	["cubicLerp"] = function(_, p13, p14, p15, p16, p17) -- name: cubicLerp
		return (1 - p17) ^ 3 * p13 + 3 * (1 - p17) ^ 2 * p17 * p14 + 3 * (1 - p17) * p17 ^ 2 * p15 + p17 ^ 3 * p16
	end,
	["reflectNormal"] = function(_, p18, p19) -- name: reflectNormal
		return p18 - 2 * p18:Dot(p19) * p19
	end
}
local u21 = math.clamp
function u20.rollOffValue(_, p22, p23, p24) -- name: rollOffValue
	-- upvalues: (copy) u21
	return 1 - u21(p24 * ((p22 - (p24 - (p24 - p23))) / (p24 - p23)), 0, p24) / p24
end
function u20.limitedCFrameRotation(_, p25, p26) -- name: limitedCFrameRotation
	local v27 = Vector3.new(p25:ToOrientation())
	return CFrame.fromOrientation(v27.X * p26.X, v27.Y * p26.Y, v27.Z * p26.Z)
end
return u20