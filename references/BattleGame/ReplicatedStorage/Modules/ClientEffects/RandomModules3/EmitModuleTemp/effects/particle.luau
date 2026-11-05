 
  
local v1 = require("../mod/tween")
local v2 = require("../mod/utility")
return {
	emit = function(p1, p2, p3) --[[ emit | Line: 6 | Upvalues: v2 (copy), v1 (copy) ]]
		if p1.Enabled then
			p1.Enabled = false
		end
		local v12 = v2.getAttribute(p1, "EmitDelay", 0)
		local v22 = v2.getAttribute(p1, "EmitCount", 1)
		local v3 = v2.getAttribute(p1, "EmitDuration", 0)
		local v4 = if v3 > 0 then true else false
		task.wait(v12)
		if v4 then
			p2.Enabled = true
		end
		local v5 = v2.getAttribute(p1, "TimeScale_Duration", 0.1)
		local v6 = v2.getAttribute(p1, "TimeScale_Start", p2.TimeScale)
		local v7 = v2.getAttribute(p1, "TimeScale_End", p2.TimeScale)
		local v8 = nil
		if v6 == v7 then
			if v6 ~= 1 then
				p2.TimeScale = v6
			end
		else
			v8 = v1.fromParams(v2.getAttribute(p1, "TimeScale_Curve", v2.default_bezier), v5, function(p1, p22) --[[ Line: 34 | Upvalues: v2 (ref), v6 (copy), v7 (copy), p2 (copy) ]]
				p2.TimeScale = v2.lerp(v6, v7, (math.clamp(p1, 0, 1)))
				return p22
			end)
			table.insert(p3, v8)
		end
		p2:Emit(v22)
		if not v4 then
			v1.timer(p1.Lifetime.Max, function(p12_2, p2_2) --[[ Line: 55 | Upvalues: p1 (copy), v8 (ref) ]]
				if p1.TimeScale > 0 or p2_2 > 0 and (v8 and v8.Connected) then
					return p12_2 * p1.TimeScale
				else
					return nil
				end
			end, v8, p3)
			return
		end
		task.wait(v3)
		p2.Enabled = false
		v1.timer(p1.Lifetime.Max, function(p12_2, p2_2) --[[ Line: 55 | Upvalues: p1 (copy), v8 (ref) ]]
			if p1.TimeScale > 0 or p2_2 > 0 and (v8 and v8.Connected) then
				return p12_2 * p1.TimeScale
			else
				return nil
			end
		end, v8, p3)
	end
}