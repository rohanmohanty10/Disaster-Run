 
  
local v1 = require("../mod/lerp")
local v2 = require("../mod/tween")
local v3 = require("../mod/utility")
local v4 = Random.new()
return {
	emit = function(p1, p2, p3) --[[ emit | Line: 9 | Upvalues: v3 (copy), v4 (copy), v2 (copy), v1 (copy) ]]
		local v12 = p2.Name
		local v22 = v3.getAttribute(p2, "EmitDelay", 0)
		local v32 = v3.getAttribute(p2, "ResetOnFinish", true)
		local v42 = v3.getRangeAttribute(p2, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)))
		if v22 > 0 then
			task.wait(v22)
		end
		local v5 = p2:GetAttribute("_END_VALUE")
		local v6 = p2:GetAttribute("_START_VALUE")
		local v7, v8 = pcall(function() --[[ Line: 24 | Upvalues: p1 (copy), v12 (copy) ]]
			return p1[v12]
		end)
		if v6 then
			v8 = v6
		end
		local v9 = typeof(v8)
		if not v7 or v9 ~= typeof(v5) then
			return
		end
		local v10 = v4:NextNumber(v42.Min, v42.Max)
		local v11 = v3.getAttribute(p2, "Speed_Start", 1)
		local v122 = v3.getAttribute(p2, "Speed_End", 1)
		local v13 = v11
		local v14
		if v11 == v122 then
			v14 = nil
		else
			v14 = v2.fromParams(v3.getAttribute(p2, "Speed_Curve", v3.default_bezier), v3.getAttribute(p2, "Speed_Duration", 0.1), function(p1, p2) --[[ Line: 51 | Upvalues: v13 (ref), v3 (ref), v11 (copy), v122 (copy) ]]
				v13 = v3.lerp(v11, v122, p1)
				return p2
			end)
			table.insert(p3, v14)
		end
		local v15 = v1[v9] or v1.Other
		local v16 = v3.getAttribute(p2, "Easing_Curve", v3.linear_bezier)
		local v17 = v3.RENDER_PRIORITY + p3.depth
		table.insert(p3, v2.fromParams(v16, v10, function(p12, p2) --[[ Line: 67 | Upvalues: p1 (copy), v12 (copy), v15 (copy), v8 (ref), v5 (copy), v13 (ref) ]]
			p1[v12] = v15(v8, v5, p12)
			return p2 * v13
		end, v14, nil, nil, v17))
		if v32 then
			table.insert(p3, function() --[[ Line: 79 | Upvalues: p1 (copy), v12 (copy), v8 (ref) ]]
				p1[v12] = v8
			end)
		end
		v2.timer(v10, function(p1, p2) --[[ Line: 84 | Upvalues: v13 (ref), v14 (ref) ]]
			if v13 > 0 or p2 > 0 and (v14 and v14.Connected) then
				return p1 * v13
			else
				return nil
			end
		end, v14, p3)
	end
}