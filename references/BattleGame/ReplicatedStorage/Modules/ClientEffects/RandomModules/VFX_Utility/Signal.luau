 
local v_u_7 = {
	["new"] = function()
		-- upvalues: (copy) v_u_7
		local v1 = {
			["__index"] = v_u_7
		}
		return setmetatable({}, v1)
	end,
	["Connect"] = function(p2, p3)
		p2.callback = p3
	end,
	["Fire"] = function(p4, ...)
		if p4.callback then
			p4.callback(...)
		end
		if p4.thread then
			coroutine.resume(p4.thread)
		end
	end,
	["Wait"] = function(p5)
		if p5.callback then
			p5.thread = coroutine.running()
			coroutine.yield()
		end
	end,
	["Disconnect"] = function(p6)
		table.clear(p6)
	end
}
return v_u_7