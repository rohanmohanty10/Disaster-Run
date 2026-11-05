 
local v_u_1 = {}
v_u_1.__index = v_u_1
function v_u_1.LoopWithFunctions(p2, p_u_3, p_u_4)
	-- upvalues: (copy) v_u_1
	local v_u_5 = nil
	local v_u_6 = 0
	for v7 = 1, #p_u_3 do
		if v_u_5 == nil then
			v_u_5 = p_u_3[v7].Iterations
		end
		if v_u_5 < p_u_3[v7].Iterations then
			v_u_5 = p_u_3[v7].Iterations
		end
	end
	local v8 = v_u_1
	local v_u_9 = setmetatable({}, v8)
	v_u_9.LoopDone = false
	v_u_9.LoopWait = p2
	v_u_9.FunctionsData = p_u_3
	v_u_9.Data = p_u_4
	task.spawn(function()
		-- upvalues: (copy) v_u_9, (ref) v_u_6, (copy) p_u_3, (copy) p_u_4, (ref) v_u_5
		while v_u_9.LoopDone ~= true do
			v_u_6 = v_u_6 + 1
			for v_u_10 = 1, #p_u_3 do
				task.spawn(function()
					-- upvalues: (ref) p_u_3, (copy) v_u_10, (ref) v_u_6, (ref) p_u_4, (ref) v_u_9
					local v11 = v_u_6 / p_u_3[v_u_10].Iterations
					local _, v12 = math.modf(v11)
					if v12 == 0 then
						p_u_3[v_u_10].Function(p_u_4, v_u_9)
					end
				end)
			end
			if v_u_6 == v_u_5 then
				v_u_6 = 0
			end
			task.wait(v_u_9.LoopWait)
			if v_u_9.LoopDone then
				break
			end
		end
	end)
	return v_u_9
end
function v_u_1.EndLoop(p13)
	p13.LoopDone = true
end
function v_u_1.UpdateFunctions(p14, p15, p16, p17)
	-- upvalues: (copy) v_u_1
	local v18 = p15 or p14.FunctionsData
	local v19 = p17 or p14.Data
	local v20 = p16 or p14.LoopWait
	if p16 ~= p14.LoopWait or (p17 ~= p14.Data or v18 ~= p14.FunctionsData) then
		p14:EndLoop()
		return v_u_1.LoopWithFunctions(v20, v18, v19)
	end
end
return v_u_1