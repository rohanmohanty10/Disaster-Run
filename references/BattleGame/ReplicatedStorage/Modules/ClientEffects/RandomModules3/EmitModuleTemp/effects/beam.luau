 
  
local v1 = require("../mod/tween")
local v2 = require("../mod/utility")
local v3 = Random.new()
local function getLegacyWidths(p1, p2) --[[ getLegacyWidths | Line: 6 | Upvalues: v2 (copy) ]]
	return v2.getAttribute(p1, "Width0", p1.Width0, true) * p2, v2.getAttribute(p1, "Width1", p1.Width1, true) * p2, v2.getAttribute(p1, "StartWidth0", p1.Width0, true) * p2, v2.getAttribute(p1, "StartWidth1", p1.Width1, true) * p2
end
return {
	emit = function(p1, p2, p3, p4) --[[ emit | Line: 18 | Upvalues: getLegacyWidths (copy), v2 (copy), v3 (copy), v1 (copy) ]]
		local v12, v22, v32, v4 = getLegacyWidths(p1, p4)
		local v5 = v2.getAttribute(p1, "Width0_Start", v32)
		local v6 = v2.getAttribute(p1, "Width0_End", v12)
		local v7 = v2.getAttribute(p1, "Width1_Start", v4)
		local v8 = v2.getAttribute(p1, "Width1_End", v22)
		local v9 = v2.getAttribute(p1, "EmitDelay", 0)
		local v10 = v2.getAttribute(p1, "Duration", 1, true)
		local v11 = v2.getAttribute(p1, "EndTransparencyScale", 1, true)
		local v122 = v2.getRangeAttribute(p1, "EffectDuration", NumberRange.new(v10, v10), NumberRange.new(0, (1 / 0)))
		local v13 = v3:NextNumber(v122.Min, v122.Max)
		local v14 = v2.getAttribute(p1, "Transparency_Scale_Start", 1)
		local v15 = v2.getAttribute(p1, "Transparency_Scale_End", v11)
		local v16 = v2.getAttribute(p1, "Speed_Start", 1)
		local v17 = v2.getAttribute(p1, "Speed_End", 1)
		local TextureSpeed = p2.TextureSpeed
		task.wait(v9)
		p2.Enabled = true
		local v18 = 1
		local v19
		if v16 == v17 then
			v19 = nil
		else
			v19 = v1.fromParams(v2.getAttribute(p1, "Speed_Curve", v2.default_bezier), v2.getAttribute(p2, "Speed_Duration", 0.1), function(p1, p22) --[[ Line: 61 | Upvalues: v18 (ref), v2 (ref), v16 (copy), v17 (copy), p2 (copy), TextureSpeed (copy) ]]
				v18 = v2.lerp(v16, v17, p1)
				p2.TextureSpeed = TextureSpeed * v18
				return p22
			end)
			table.insert(p3, v19)
		end
		local function setTScale(p12) --[[ setTScale | Line: 73 | Upvalues: p2 (copy), v2 (ref), p1 (copy) ]]
			p2.Transparency = v2.scaleNumberSequence(p1.Transparency, function(p1, p2) --[[ Line: 74 | Upvalues: p12 (copy) ]]
				return p1 + (p12 > 1 and 1 - p1 or -p1) * (p12 > 1 and p12 - 1 or 1 - p12), p2
			end)
		end
		if v14 == v15 then
			if v14 ~= 1 then
				p2.Transparency = v2.scaleNumberSequence(p1.Transparency, function(p1, p2) --[[ Line: 74 | Upvalues: v14 (copy) ]]
					return p1 + (v14 > 1 and 1 - p1 or -p1) * (v14 > 1 and v14 - 1 or 1 - v14), p2
				end)
			end
		else
			local v20 = v2.getAttribute(p1, "Transparency_Scale_Curve", v2.default_bezier)
			local function f21(p12, p22) --[[ Line: 88 | Upvalues: v2 (ref), v14 (copy), v15 (copy), p2 (copy), p1 (copy), v18 (ref) ]]
				local v1 = v2.lerp(v14, v15, p12)
				p2.Transparency = v2.scaleNumberSequence(p1.Transparency, function(p1, p2) --[[ Line: 74 | Upvalues: v1 (copy) ]]
					return p1 + (v1 > 1 and 1 - p1 or -p1) * (v1 > 1 and v1 - 1 or 1 - v1), p2
				end)
				return p22 * v18
			end
			table.insert(p3, v1.fromParams(v20, v13, f21, v19))
		end
		if v5 == v6 then
			p2.Width0 = v5
		else
			local v222 = v2.getAttribute(p1, "Width0_Curve", v2.default_bezier)
			local function f23(p1, p22) --[[ Line: 105 | Upvalues: p2 (copy), v2 (ref), v5 (copy), v6 (copy), v18 (ref) ]]
				p2.Width0 = v2.lerp(v5, v6, p1)
				return p22 * v18
			end
			table.insert(p3, v1.fromParams(v222, v13, f23, v19))
		end
		if v7 == v8 then
			p2.Width1 = v7
		else
			local v24 = v2.getAttribute(p1, "Width1_Curve", v2.default_bezier)
			local function f25(p1, p22) --[[ Line: 122 | Upvalues: p2 (copy), v2 (ref), v7 (copy), v8 (copy), v18 (ref) ]]
				p2.Width1 = v2.lerp(v7, v8, p1)
				return p22 * v18
			end
			table.insert(p3, v1.fromParams(v24, v13, f25, v19))
		end
		v1.timer(v13, function(p1, p2) --[[ Line: 133 | Upvalues: v18 (ref), v19 (ref) ]]
			if v18 > 0 or p2 > 0 and (v19 and v19.Connected) then
				return p1 * v18
			else
				return nil
			end
		end, v19, p3)
	end
}