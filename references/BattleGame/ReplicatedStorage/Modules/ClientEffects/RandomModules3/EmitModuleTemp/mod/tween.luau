 
  
local RunService = game:GetService("RunService")
local v1 = require("./logger")
local v2 = require("./utility")
local v3 = require("../obj/Bezier")
local t = {}
local t2 = {}
local v4 = nil
local function ensureMaster() --[[ ensureMaster | Line: 17 | Upvalues: v4 (ref), t2 (copy), RunService (copy) ]]
	if v4 then
		return
	end
	if #t2 ~= 0 then
		v4 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 21 | Upvalues: t2 (ref), v4 (ref) ]]
			local count = 1
			while count <= #t2 do
				local v1 = t2[count]
				if v1.dead then
					t2[count] = t2[#t2]
					t2[#t2] = nil
				else
					local v2, v3 = pcall(v1.step, p1)
					if not v2 then
						warn("[EmitModule.tween] step error: " .. tostring(v3))
						v1.dead = true
						v1.Connected = false
					end
					if v1.dead then
						t2[count] = t2[#t2]
						t2[#t2] = nil
						continue
					end
					count = count + 1
				end
			end
			if #t2 ~= 0 or not v4 then
				return
			end
			v4:Disconnect()
			v4 = nil
		end)
	end
end
local function makeEntry(p1) --[[ makeEntry | Line: 53 ]]
	local t = {
		__tweenEntry = true,
		dead = false,
		Connected = true,
		step = p1
	}
	function t.Disconnect(p1) --[[ Disconnect | Line: 61 | Upvalues: t (copy) ]]
		if not t.dead then
			t.dead = true
			t.Connected = false
		end
	end
	return t
end
function t.fromParams(p1, p2, p3, p4, p5, p6, p7) --[[ fromParams | Line: 73 | Upvalues: v2 (copy), v1 (copy), v3 (copy), t2 (copy), v4 (ref), RunService (copy) ]]
	local v12, v22 = pcall(function() --[[ Line: 82 | Upvalues: v2 (ref), p1 (copy) ]]
		return v2.deserializePath(p1)
	end)
	if not v12 then
		v1.error((("failed to decode bezier path data with error: %*"):format(v22)))
	end
	local v32 = v3.new(v22, 0)
	local v42 = 0
	local v5 = nil
	local function step(p1) --[[ step | Line: 96 | Upvalues: p6 (copy), v42 (ref), p2 (copy), v32 (copy), p3 (copy), p4 (copy), v5 (ref), p5 (copy) ]]
		if not p6 and v42 == 0 then
			v42 = math.clamp(v42 + p1, 0, (math.max(p2, 0)))
		end
		local v52 = p3(1 - v32:getEase((math.clamp(v42 / p2, 0, 1))).y, p1, v42)
		local v6, v7, v8
		if v52 ~= nil and not (if p2 == 0 then if p2 < v42 then true else false else p2 <= v42) then
			if not v52 then
				return
			end
			v6 = v42 + v52
			v7 = p2
			v8 = math.max(p2, 0.001)
			v42 = math.clamp(v6, 0, v8)
			return
		end
		if p4 and p4.Connected then
			if not v52 then
				return
			end
			v6 = v42 + v52
			v7 = p2
			v8 = math.max(p2, 0.001)
			v42 = math.clamp(v6, 0, v8)
		else
			v5()
			if not p5 then
				return
			end
			p5(true)
		end
	end
	if p7 then
		local v6 = v2.getRanomId()
		RunService:BindToRenderStep(v6, p7, step)
		local v7 = true
		v5 = function() --[[ Line: 143 | Upvalues: v7 (ref), RunService (ref), v6 (copy) ]]
			if v7 then
				v7 = false
				RunService:UnbindFromRenderStep(v6)
			end
		end
		return v5
	end
	local t = {
		__tweenEntry = true,
		dead = false,
		Connected = true,
		step = step
	}
	function t.Disconnect(p1) --[[ Disconnect | Line: 61 | Upvalues: t (copy) ]]
		if not t.dead then
			t.dead = true
			t.Connected = false
		end
	end
	local v8 = t
	v5 = function() --[[ Line: 128 | Upvalues: v8 (copy) ]]
		v8:Disconnect()
	end
	local v9 = t2
	table.insert(v9, v8)
	if v4 or #t2 == 0 then
		return v8
	end
	v4 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 21 | Upvalues: t2 (ref), v4 (ref) ]]
		local count = 1
		while count <= #t2 do
			local v1 = t2[count]
			if v1.dead then
				t2[count] = t2[#t2]
				t2[#t2] = nil
			else
				local v2, v3 = pcall(v1.step, p1)
				if not v2 then
					warn("[EmitModule.tween] step error: " .. tostring(v3))
					v1.dead = true
					v1.Connected = false
				end
				if v1.dead then
					t2[count] = t2[#t2]
					t2[#t2] = nil
					continue
				end
				count = count + 1
			end
		end
		if #t2 ~= 0 or not v4 then
			return
		end
		v4:Disconnect()
		v4 = nil
	end)
	return v8
end
function t.timer(p1, p2, p3, p4, p5) --[[ timer | Line: 157 | Upvalues: t2 (copy), v4 (ref), RunService (copy), v2 (copy) ]]
	local v1 = coroutine.running()
	local v22 = 0
	local v3 = nil
	local function step(p12) --[[ step | Line: 170 | Upvalues: p2 (copy), v22 (ref), p1 (copy), p3 (copy), v3 (ref), v1 (copy) ]]
		local v12 = p2(p12, v22)
		local v2, v4
		if v12 ~= nil and not (if p1 == 0 then if p1 < v22 then true else false else p1 <= v22) then
			local v32
			if not v12 then
				return
			end
			v2 = v22 + v12
			v32 = p1
			v4 = math.max(p1, 0.001)
			v22 = math.clamp(v2, 0, v4)
			return
		end
		if not (p3 and p3.Connected) then
			v3()
			task.spawn(v1)
			return
		end
		if not v12 then
			return
		end
		v2 = v22 + v12
		v4 = math.max(p1, 0.001)
		v22 = math.clamp(v2, 0, v4)
	end
	if p5 then
		local v42 = v2.getRanomId()
		RunService:BindToRenderStep(v42, p5, step)
		local v5 = true
		v3 = function() --[[ Line: 207 | Upvalues: v5 (ref), RunService (ref), v42 (copy) ]]
			if v5 then
				v5 = false
				RunService:UnbindFromRenderStep(v42)
			end
		end
		if p4 then
			table.insert(p4, v3)
		end
	else
		local t = {
			__tweenEntry = true,
			dead = false,
			Connected = true,
			step = step
		}
		function t.Disconnect(p1) --[[ Disconnect | Line: 61 | Upvalues: t (copy) ]]
			if not t.dead then
				t.dead = true
				t.Connected = false
			end
		end
		local v7 = t
		v3 = function() --[[ Line: 190 | Upvalues: v7 (copy) ]]
			v7:Disconnect()
		end
		local v8 = t2
		table.insert(v8, v7)
		if not v4 and #t2 ~= 0 then
			v4 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 21 | Upvalues: t2 (ref), v4 (ref) ]]
				local count = 1
				while count <= #t2 do
					local v1 = t2[count]
					if v1.dead then
						t2[count] = t2[#t2]
						t2[#t2] = nil
					else
						local v2, v3 = pcall(v1.step, p1)
						if not v2 then
							warn("[EmitModule.tween] step error: " .. tostring(v3))
							v1.dead = true
							v1.Connected = false
						end
						if v1.dead then
							t2[count] = t2[#t2]
							t2[#t2] = nil
							continue
						end
						count = count + 1
					end
				end
				if #t2 ~= 0 or not v4 then
					return
				end
				v4:Disconnect()
				v4 = nil
			end)
		end
		if not p4 then
			coroutine.yield()
			return
		end
		table.insert(p4, v7)
	end
	coroutine.yield()
end
return t