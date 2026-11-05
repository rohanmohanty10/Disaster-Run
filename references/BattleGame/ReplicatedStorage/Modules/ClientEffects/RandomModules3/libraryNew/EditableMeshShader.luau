 
  
local AssetService = game:GetService("AssetService")
local RunService = game:GetService("RunService")
local t = {}
t.__index = t
function t.new(p1, p2, p3, p4) --[[ new | Line: 11 | Upvalues: t (copy), AssetService (copy), RunService (copy) ]]
	local v2 = setmetatable({}, t)
	v2.Mesh = p1
	v2.FixedTime = 0
	v2.Time = 0
	v2._alive = true
	task.spawn(function() --[[ Line: 23 | Upvalues: AssetService (ref), p1 (copy), v2 (copy), RunService (ref), p4 (copy), p2 (copy), p3 (copy) ]]
		local v1, v22 = pcall(function() --[[ Line: 24 | Upvalues: AssetService (ref), p1 (ref) ]]
			return AssetService:CreateEditableMeshAsync(p1.MeshContent)
		end)
		if v1 and v22 then
			if not v2._alive then
				v22:Destroy()
				return
			end
			v2.EditableMesh = v22
			p1:ApplyMesh((AssetService:CreateMeshPartAsync(Content.fromObject(v22))))
			local v3 = v22:GetVertices()
			local v4 = v22:GetUVs()
			local v5 = #v3
			local v6 = table.create(v5)
			local v7 = table.create(v5)
			local v8 = #v4
			for i = 1, v5 do
				local v9 = v22:GetPosition(v3[i])
				v6[i] = v9
				v7[i] = v9
			end
			local v10 = table.create(v8)
			local v11 = table.create(v8)
			for j = 1, v8 do
				local v12 = v22:GetUV(v4[j])
				v10[j] = v12
				v11[j] = v12
			end
			v2._vertexIds = v3
			v2._uvIds = v4
			v2._originalPositions = v6
			v2._lastPositions = v7
			v2._originalUVs = v10
			v2._lastUVs = v11
			local v13 = 0
			v2.Update = RunService.Heartbeat:Connect(function(p1) --[[ Line: 72 | Upvalues: v2 (ref), p4 (ref), v13 (ref), v22 (copy), v5 (copy), p2 (ref), v6 (copy), v7 (copy), v3 (copy), v8 (copy), p3 (ref), v10 (copy), v11 (copy), v4 (copy) ]]
				local v1 = v2
				v1.FixedTime = v1.FixedTime + p1
				v2.Time = p4 and v2.Time + p1 * p4.Value or v2.FixedTime
				v13 = v13 + p1
				if v13 < 0.03333333333333333 then
					return
				end
				local v42 = v13
				v13 = 0
				local Time = v2.Time
				local FixedTime = v2.FixedTime
				local SetPosition = v22.SetPosition
				local SetUV = v22.SetUV
				for i = 1, v5 do
					local v52 = p2(v6[i], Time, v42, FixedTime)
					local v62 = v7[i]
					local v72 = v52.X - v62.X
					local v82 = v52.Y - v62.Y
					local v9 = v52.Z - v62.Z
					if v72 * v72 + v82 * v82 + v9 * v9 > 1e-6 then
						SetPosition(v22, v3[i], v52)
						v7[i] = v52
					end
				end
				for j = 1, v8 do
					local v102 = p3(v10[j], Time, v42, FixedTime)
					local v112 = v11[j]
					local v12 = v102.X - v112.X
					local v132 = v102.Y - v112.Y
					if v12 * v12 + v132 * v132 > 1e-8 then
						SetUV(v22, v4[j], v102)
						v11[j] = v102
					end
				end
			end)
		else
			warn("EditableMesh failed:", v22)
		end
	end)
	return v2
end
function t.Destroy(p1) --[[ Destroy | Line: 115 ]]
	p1._alive = false
	if p1.Update then
		p1.Update:Disconnect()
		p1.Update = nil
	end
	if not p1.EditableMesh then
		return
	end
	p1.EditableMesh:Destroy()
	p1.EditableMesh = nil
end
return t