 
  
local RunService = game:GetService("RunService")
local PhysicsService = game:GetService("PhysicsService")
local v1 = require("./logger")
local t = {
	DEG_TO_RAD = math.rad(1),
	BEZIER_TAG = "BezierParticle",
	SHOCKWAVE_TAG = "Shockwave",
	SCREENSHAKE_TAG = "CameraShake",
	ENABLED_VFX_TAG = "ConstantVFX",
	TEXTURE_LOAD_TAG = "LoadVFXTextures",
	RENDER_PRIORITY = Enum.RenderPriority.Camera.Value + 1,
	COLLISION_GROUPS = {
		StudioSelectable = {},
		ForgeDebris = {
			ForgeDebris = false
		},
		ForgeMouseIgnore = {
			StudioSelectable = false
		}
	},
	COPY_SPECIALMESH_PROPERTIES = { "MeshId", "MeshType", "Offset", "Scale", "TextureId", "VertexColor" },
	COPY_PART_PROPERTIES = {
		"CastShadow",
		"Color",
		"Material",
		"MaterialVariant",
		"Reflectance",
		"Shape",
		"FrontSurface",
		"BackSurface",
		"LeftSurface",
		"RightSurface",
		"TopSurface",
		"BottomSurface"
	},
	COPY_EXTENDED_PART_PROPERTIES = { "Size", "Transparency", "CanCollide", "CanQuery", "CanTouch", "CollisionGroup" }
}
local v2 = setmetatable({}, {
	__mode = "k"
})
function t.lock(p1) --[[ lock | Line: 75 | Upvalues: v2 (copy) ]]
	if v2[p1] then
		return true
	else
		v2[p1] = coroutine.running()
		return false
	end
end
function t.unlock(p1, p2) --[[ unlock | Line: 85 | Upvalues: v2 (copy), v1 (copy) ]]
	local v12 = v2[p1]
	if coroutine.running() == v12 or p2 == v12 then
		v2[p1] = nil
		return
	end
	v1.error("attempt to unlock an instance owned by a different thread")
	v2[p1] = nil
end
function t.setCollisionGroups(p1) --[[ setCollisionGroups | Line: 95 | Upvalues: PhysicsService (copy), RunService (copy) ]]
	local t = {}
	for v1, v2 in p1 do
		PhysicsService:RegisterCollisionGroup(v1)
		if not v1:match("Studio") or RunService:IsStudio() then
			t[v1] = v2
		end
	end
	for v3, v4 in t do
		for v5, v6 in v4 do
			if not v5:match("Studio") or RunService:IsStudio() then
				PhysicsService:CollisionGroupSetCollidable(v3, v5, v6)
			end
		end
	end
end
local v3 = 0
function t.getRanomId() --[[ getRanomId | Line: 119 | Upvalues: v3 (ref) ]]
	v3 = v3 + 1
	return tostring(v3)
end
function t.copyProperties(p1, p2, p3) --[[ copyProperties | Line: 124 ]]
	for v1, v2 in p3 do
		p2[v2] = p1[v2]
	end
end
function t.lerp(p1, p2, p3) --[[ lerp | Line: 130 ]]
	return p1 + (p2 - p1) * p3
end
function t.try(p1, p2, ...) --[[ try | Line: 134 | Upvalues: v1 (copy) ]]
	local t = { xpcall(p2, function(p12) --[[ Line: 135 | Upvalues: v1 (ref), p1 (copy) ]]
			v1.warn(string.format(p1, p12))
		end, ...) }
	return t[1], table.unpack(t, 2)
end
function t.reboundfn(p1, p2) --[[ reboundfn | Line: 142 ]]
	local v1 = nil
	return function(...) --[[ Line: 145 | Upvalues: v1 (ref), p1 (copy), p2 (copy) ]]
		local v12
		if not v1 then
			v12 = { ... }
			v1 = task.delay(p1, function() --[[ Line: 152 | Upvalues: v1 (ref), p2 (ref), v12 (copy) ]]
				v1 = nil
				p2(table.unpack(v12))
			end)
			return
		end
		task.cancel(v1)
		v12 = { ... }
		v1 = task.delay(p1, function() --[[ Line: 152 | Upvalues: v1 (ref), p2 (ref), v12 (copy) ]]
			v1 = nil
			p2(table.unpack(v12))
		end)
	end
end
function t.randomUnitVector(p1, p2, p3) --[[ randomUnitVector | Line: 159 ]]
	if not p3 then
		p3 = Random.new()
	end
	return Vector3.new(p3:NextNumber(p1.X, p2.X), p3:NextNumber(p1.Y, p2.Y), p3:NextNumber(p1.Z, p2.Z))
end
function t.getImpulseForce(p1, p2, p3) --[[ getImpulseForce | Line: 167 ]]
	return (p2 - p1) / p3 + Vector3.new(0, workspace.Gravity * p3 * 0.5, 0)
end
function t.isMeshVFX(p1) --[[ isMeshVFX | Line: 171 ]]
	return if p1 then p1:IsA("Model") and (p1:FindFirstChild("Start") and (p1.Start:IsA("BasePart") and (p1:FindFirstChild("End") and p1.End:IsA("BasePart")))) else p1
end
function t.cleanupScope(p1) --[[ cleanupScope | Line: 180 | Upvalues: t (copy) ]]
	for v1, v2 in p1 do
		local v3 = typeof(v2)
		if v3 == "Instance" then
			v2:Destroy()
			continue
		end
		if v3 == "RBXScriptConnection" then
			v2:Disconnect()
			continue
		end
		if v3 == "thread" then
			if coroutine.status(v2) ~= "dead" then
				task.cancel(v2)
			end
			continue
		end
		if v3 == "function" then
			task.spawn(v2)
			continue
		end
		if v3 == "table" then
			if v2.__tweenEntry then
				v2:Disconnect()
				continue
			end
			t.cleanupScope(v2)
		end
	end
	table.clear(p1)
end
function t.protectParent(p1, p2) --[[ protectParent | Line: 206 ]]
	table.insert(p1, p2.AncestryChanged:Connect(function(p1, p22) --[[ Line: 209 | Upvalues: p2 (copy) ]]
		if p2.Parent ~= workspace.Terrain then
			p2.Parent = workspace.Terrain
		end
	end))
end
function t.findFirstClassWithTag(p1, p2, p3) --[[ findFirstClassWithTag | Line: 219 | Upvalues: t (copy) ]]
	if not p1 or p1.Parent == game then
		return
	end
	if p1.ClassName == p2 and p1:HasTag(p3) then
		return p1
	end
	return t.findFirstClassWithTag(p1.Parent, p2, p3)
end
function t.cloneParticleAncestry(p1, p2) --[[ cloneParticleAncestry | Line: 231 ]]
	if not (p1:FindFirstAncestorWhichIsA("BasePart") or p1:FindFirstAncestorOfClass("Attachment")) then
		return
	end
	local function v1(p1) --[[ findAncestor | Line: 236 | Upvalues: v1 (copy) ]]
		return if p1.Parent and (p1.Parent:IsA("BasePart") or p1.Parent:IsA("Attachment")) then v1(p1.Parent) else p1
	end
	local function v2(p12) --[[ recurse | Line: 246 | Upvalues: p2 (copy), p1 (copy), v1 (copy), v2 (copy) ]]
		local v12 = p2[p12]
		if v12 then
			if p12 == p1 then
				return v12, p2[p12.Parent]
			end
			local v3 = p12.Parent
			local v4, v5
			if v3.Parent and (v3.Parent:IsA("BasePart") or v3.Parent:IsA("Attachment")) then
				v4, v5 = v1(v3.Parent), v12
			else
				v4 = v3
				v5 = v12
			end
			return v5, p2[v4] or p2[p12]
		else
			local v8 = Instance.fromExisting(p12)
			v8.Archivable = false
			if v8:IsA("BasePart") then
				v8.Locked = true
			end
			if p2 then
				p2[p12] = v8
			end
			local v9
			if p12.Parent and (p12.Parent:IsA("BasePart") or p12.Parent:IsA("Attachment")) then
				local v10, v11 = v2(p12.Parent)
				v9 = if v11 then v11 else v8
				if v10 then
					v8.Parent = v10
				end
			else
				v9 = v8
			end
			return v8, v9
		end
	end
	return v2(p1.Parent)
end
function t.getAttribute(p1, p2, p3, p4) --[[ getAttribute | Line: 284 ]]
	local v1 = p1:GetAttribute(p2)
	if v1 == nil or typeof(v1) ~= typeof(p3) then
		v1 = p3
	end
	if not p4 then
		p1:SetAttribute(p2, v1)
	end
	return v1
end
function t.getRangeAttribute(p1, p2, p3, p4, p5) --[[ getRangeAttribute | Line: 298 ]]
	local v1 = p1:GetAttribute(p2)
	if typeof(v1) ~= "NumberRange" then
		v1 = p3
	end
	if p4 then
		v1 = NumberRange.new(math.clamp(v1.Min, p4.Min, p4.Max), (math.clamp(v1.Max, p4.Min, p4.Max)))
	end
	if not p5 then
		p1:SetAttribute(p2, v1)
	end
	return v1
end
function t.getEnumAttribute(p1, p2, p3, p4, p5) --[[ getEnumAttribute | Line: 326 ]]
	local v1 = p1:GetAttribute(p2)
	if v1 == nil or not table.find(p4, v1) then
		v1 = p3
	end
	if not p5 then
		p1:SetAttribute(p2, v1)
	end
	return v1
end
function t.getMeshDecals(p1, p2) --[[ getMeshDecals | Line: 340 | Upvalues: t (copy) ]]
	local v1 = t.getAttribute(p1, "Flipbook", false, true)
	local t2 = {}
	local t3 = {}
	local t4 = {}
	local function filter(p1) --[[ filter | Line: 347 ]]
		local t = {}
		for v1, v2 in p1 do
			if v2:IsA("Decal") then
				table.insert(t, v2)
			end
		end
		return t
	end
	if v1 then
		return filter(p2:GetChildren()), t3, t4
	end
	local End = p1:FindFirstChild("End")
	local Start = p1:FindFirstChild("Start")
	if End then
		for v2, v3 in p2:GetChildren() do
			if v3:IsA("Decal") then
				local v4 = End:FindFirstChild(v3.Name)
				if v4 and v4:IsA("Decal") then
					table.insert(t2, v3)
					t4[v3] = v4
					if v3:GetAttribute("FlipbookEnabled") then
						t3[v3] = t.deserializeFlipbook(v3:GetAttribute("FlipbookTextures"))
						continue
					end
					table.insert(t2, v3)
				end
			end
		end
		for v5, v6 in Start:GetChildren() do
			if v6:IsA("Decal") then
				local v7 = v6:GetChildren()
				local count = 0
				for i = 1, #v7 do
					local v8 = i - count
					if not v7[v8]:IsA("Decal") then
						table.remove(v7, v8)
						count = count + 1
					end
				end
				if #v7 ~= 0 then
					local function idx(p1) --[[ idx | Line: 414 ]]
						return tonumber(p1:match("%d+")) or 0
					end
					table.sort(v7, function(p1, p2) --[[ Line: 418 ]]
						local v2 = tonumber(p1.Name:match("%d+")) or 0
						return v2 < (tonumber(p2.Name:match("%d+")) or 0)
					end)
					local t5 = {}
					for v9, v10 in v7 do
						table.insert(t5, tonumber(v10.Texture:match("%d+")) or 0)
						v10:Destroy()
					end
					local v12 = t.serializeFlipbook(t5)
					v6:SetAttribute("FlipbookEnabled", true)
					v6:SetAttribute("FlipbookTextures", buffer.tostring(v12))
				end
			end
		end
	end
	return t2, t3, t4
end
function t.getBezierPoints(p1, p2) --[[ getBezierPoints | Line: 441 ]]
	local v1 = p1:GetChildren()
	table.sort(v1, function(p1, p2) --[[ Line: 444 ]]
		local v2 = tonumber(p1.Name)
		return v2 < tonumber(p2.Name)
	end)
	local t = {}
	local t2 = {}
	local t3 = {}
	local function vec(p12) --[[ vec | Line: 452 | Upvalues: p1 (copy), t (copy), p2 (copy), t3 (copy), t2 (copy) ]]
		local v1 = p1.WorldCFrame:PointToObjectSpace(p12.WorldPosition)
		local v2 = vector.create(v1.X, v1.Y, v1.Z)
		table.insert(t, v2)
		if p2 then
			t3[p12] = v2
			table.insert(t2, p12)
		end
		return v2
	end
	for v2, v3 in v1 do
		local T0 = v3:FindFirstChild("T0")
		local T1 = v3:FindFirstChild("T1")
		if v2 == 1 then
			local v4 = p1.WorldCFrame:PointToObjectSpace(v3.WorldPosition)
			local v5 = vector.create(v4.X, v4.Y, v4.Z)
			table.insert(t, v5)
			if p2 then
				t3[v3] = v5
				table.insert(t2, v3)
			end
		end
		if v2 ~= 1 and T1 then
			local v6 = p1.WorldCFrame:PointToObjectSpace(T1.WorldPosition)
			local v7 = vector.create(v6.X, v6.Y, v6.Z)
			table.insert(t, v7)
			if p2 then
				t3[T1] = v7
				table.insert(t2, T1)
			end
		elseif v2 ~= 1 then
			local v8 = p1.WorldCFrame:PointToObjectSpace(v3.WorldPosition)
			local v9 = vector.create(v8.X, v8.Y, v8.Z)
			table.insert(t, v9)
			if p2 then
				t3[v3] = v9
				table.insert(t2, v3)
			end
		end
		if v2 ~= 1 and v2 ~= #v1 then
			local v10 = p1.WorldCFrame:PointToObjectSpace(v3.WorldPosition)
			local v11 = vector.create(v10.X, v10.Y, v10.Z)
			table.insert(t, v11)
			if p2 then
				t3[v3] = v11
				table.insert(t2, v3)
			end
		end
		if v2 ~= #v1 and T0 then
			local v12 = p1.WorldCFrame:PointToObjectSpace(T0.WorldPosition)
			local v13 = vector.create(v12.X, v12.Y, v12.Z)
			table.insert(t, v13)
			if p2 then
				t3[T0] = v13
				table.insert(t2, T0)
			end
		elseif v2 ~= #v1 then
			local v14 = p1.WorldCFrame:PointToObjectSpace(v3.WorldPosition)
			local v15 = vector.create(v14.X, v14.Y, v14.Z)
			table.insert(t, v15)
			if p2 then
				t3[v3] = v15
				table.insert(t2, v3)
			end
		end
		if v2 == #v1 then
			local v16 = p1.WorldCFrame:PointToObjectSpace(v3.WorldPosition)
			local v17 = vector.create(v16.X, v16.Y, v16.Z)
			table.insert(t, v17)
			if p2 then
				t3[v3] = v17
				table.insert(t2, v3)
			end
		end
	end
	return t, t2, t3
end
function t.scaleNumberSequence(p1, p2) --[[ scaleNumberSequence | Line: 504 ]]
	if p2 == 1 then
		return p1
	end
	local t = {}
	for v3, v4 in p1.Keypoints do
		local v1, v2
		if typeof(p2) == "function" then
			local v5, v6 = p2(v4.Value, v4.Envelope)
			v1 = v5
			v2 = v6
		else
			v1 = v4.Value * p2
			v2 = v4.Envelope * p2
		end
		local v7 = NumberSequenceKeypoint.new
		table.insert(t, v7(v4.Time, v1, v2))
	end
	return NumberSequence.new(t)
end
function t.serializePath(p1) --[[ serializePath | Line: 529 ]]
	local v1 = buffer.create(#p1 * 4 * 6)
	local sum = 0
	for v2, v3 in p1 do
		local Scale = v3.Position.X.Scale
		local Scale_2 = v3.Position.Y.Scale
		if v2 ~= 1 then
			buffer.writef32(v1, sum, Scale + v3.LeftTangent.X.Scale)
			buffer.writef32(v1, sum + 4, Scale_2 + v3.LeftTangent.Y.Scale)
			sum = sum + 8
		end
		buffer.writef32(v1, sum, Scale)
		buffer.writef32(v1, sum + 4, Scale_2)
		sum = sum + 8
		if v2 ~= #p1 then
			buffer.writef32(v1, sum, Scale + v3.RightTangent.X.Scale)
			buffer.writef32(v1, sum + 4, Scale_2 + v3.RightTangent.Y.Scale)
			sum = sum + 8
		end
	end
	return v1
end
function t.deserializePath(p1) --[[ deserializePath | Line: 562 ]]
	local v1 = typeof(p1) == "string" and buffer.fromstring(p1) or p1
	local v2 = buffer.len(v1) / 24
	local t = {}
	for i = 0, v2 - 1 do
		local v3 = i * 4 * 6
		table.insert(t, (vector.create(buffer.readf32(v1, v3), (buffer.readf32(v1, v3 + 4)))))
		if i ~= v2 - 1 then
			local v7 = buffer.readf32(v1, v3 + 8)
			local v8 = buffer.readf32(v1, v3 + 12)
			local v9 = buffer.readf32(v1, v3 + 16)
			local v10 = buffer.readf32(v1, v3 + 20)
			table.insert(t, (vector.create(v7, v8)))
			table.insert(t, (vector.create(v9, v10)))
		end
	end
	return t
end
function t.serializeFlipbook(p1) --[[ serializeFlipbook | Line: 592 ]]
	local v1 = buffer.create(#p1 * 8)
	for v2, v3 in p1 do
		buffer.writef64(v1, (v2 - 1) * 8, v3)
	end
	return v1
end
function t.deserializeFlipbook(p1) --[[ deserializeFlipbook | Line: 603 ]]
	local v1 = typeof(p1) == "string" and buffer.fromstring(p1) or p1
	local t = {}
	for i = 0, buffer.len(v1) / 8 - 1 do
		table.insert(t, (buffer.readf64(v1, i * 8)))
	end
	return t
end
t.default_bezier = buffer.tostring(t.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1), UDim2.new(), UDim2.fromScale(0.215, -0.61)), Path2DControlPoint.new(UDim2.fromScale(1, 0), UDim2.fromScale(-0.645, 0), UDim2.new()) }))
t.linear_bezier = buffer.tostring(t.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1)), Path2DControlPoint.new(UDim2.fromScale(1, 0)) }))
return t