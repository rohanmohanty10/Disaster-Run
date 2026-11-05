 
game:GetService("TweenService")
local v1 = Instance.new("Folder", workspace)
v1.Name = "BeamFolder"
local v_u_2 = Instance.new("Beam")
v_u_2.LightInfluence = 0
v_u_2.TextureMode = Enum.TextureMode.Stretch
local v_u_3 = Instance.new("Attachment")
local v_u_4 = {}
local v_u_5 = {}
local v6 = {}
for _ = 1, 1000 do
	local v7 = v_u_3:Clone()
	v7.WorldPosition = Vector3.new(50000, 50000, 50000)
	v7.Parent = workspace.Terrain
	table.insert(v_u_4, v7)
	local v8 = v_u_2:Clone()
	v8.Parent = v1
	table.insert(v_u_5, v8)
end
function v6.GetBeam(p9)
	-- upvalues: (copy) v_u_5, (copy) v_u_2
	local v10
	if #v_u_5 > 0 then
		v10 = table.remove(v_u_5)
	else
		v10 = v_u_2:Clone()
	end
	v10.Parent = p9
	return v10
end
function v6.ReturnBeam(p11)
	-- upvalues: (copy) v_u_5
	p11.Attachment0 = nil
	p11.Attachment1 = nil
	local v12 = v_u_5
	table.insert(v12, p11)
end
function v6.GetAttachment(p13)
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v14
	if #v_u_4 > 0 then
		v14 = table.remove(v_u_4)
	else
		v14 = v_u_3:Clone()
	end
	v14.Parent = p13
	return v14
end
function v6.ReturnAttachment(p15)
	-- upvalues: (copy) v_u_4
	p15.WorldPosition = Vector3.new(50000, 50000, 50000)
	local v16 = v_u_4
	table.insert(v16, p15)
end
function v6.Clear()
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	table.clear(v_u_5)
	table.clear(v_u_4)
end
return v6