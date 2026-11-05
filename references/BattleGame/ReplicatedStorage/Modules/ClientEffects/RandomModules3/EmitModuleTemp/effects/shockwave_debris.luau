 
  
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local v1 = require("../mod/tween")
local v2 = require("../mod/utility")
local v3 = require("../pkg/Promise")
require("../obj/ObjectCache")
local v4 = Random.new()
local t = {}
local t2 = {}
local v5 = nil
local v6 = nil
function t.init(p1) --[[ init | Line: 18 | Upvalues: v6 (ref), v5 (ref), RunService (copy), t2 (copy) ]]
	if v6 then
		return
	end
	v5 = p1
	if not (RunService:IsStudio() and script:FindFirstAncestorOfClass("Plugin")) then
		return
	end
	v6 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 26 | Upvalues: t2 (ref) ]]
		if #t2 ~= 0 then
			workspace:StepPhysics(p1, t2)
		end
	end)
end
function t.deinit() --[[ deinit | Line: 36 | Upvalues: v6 (ref), v5 (ref), t2 (copy) ]]
	if v6 then
		v6:Disconnect()
		v6 = nil
	end
	v5 = nil
	for v1, v2 in t2 do
		v2:Destroy()
	end
	table.clear(t2)
end
function t.emit(p1, p2, p3) --[[ emit | Line: 51 | Upvalues: v5 (ref), v2 (copy), CollectionService (copy), v4 (copy), t2 (copy), v1 (copy), v3 (copy) ]]
	if not v5 then
		return
	end
	local v12 = v2.getAttribute(p2, "InheritanceEnabled", true)
	local v22 = v2.getAttribute(p2, "InheritanceRadius", 5)
	local v32
	if v12 then
		local v42 = v2.getAttribute(p2, "InheritanceMaxResults", 5)
		local v52 = v2.getAttribute(p1, "RayCollisionGroup", "Default")
		local v6 = v2.getAttribute(p1, "FilterTag", "")
		local v7 = v2.getAttribute(p1, "FilterType", "Exclude")
		local v8 = v2.getAttribute(p1, "IgnoreCanCollide", false)
		local v9 = OverlapParams.new()
		v9.MaxParts = v42
		v9.CollisionGroup = v52
		v9.RespectCanCollide = not v8
		v9.FilterType = Enum.RaycastFilterType[v7]
		v9.FilterDescendantsInstances = CollectionService:GetTagged(v6)
		if v7 == "Exclude" then
			v9:AddToFilter({ workspace.Terrain })
		end
		v32 = v9
	else
		v32 = nil
	end
	local v10 = v2.getAttribute(p2, "EmitDelay", 0)
	local v11 = v2.getRangeAttribute(p2, "Amount", NumberRange.new(5, 10), NumberRange.new(0, (1 / 0)))
	local v122 = v2.getRangeAttribute(p2, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)))
	local v13 = v2.getRangeAttribute(p2, "Airtime", NumberRange.new(0.5, 0.5), NumberRange.new(0, (1 / 0)))
	local v14 = v2.getRangeAttribute(p2, "LinearMagnitude", NumberRange.new(15, 25))
	local v15 = v2.getRangeAttribute(p2, "AngularMagnitude", NumberRange.new(5, 15))
	local v16 = v2.getAttribute(p2, "SizeScaleEnd", Vector3.new(0, 0, 0))
	local v17 = v2.getAttribute(p2, "MinSize", Vector3.new(2, 1, 2))
	local v18 = v2.getAttribute(p2, "MaxSize", Vector3.new(3, 2, 3))
	local v19 = v2.getAttribute(p2, "MinDirection", Vector3.new(-1, -1, -1))
	local v20 = v2.getAttribute(p2, "MaxDirection", Vector3.new(1, 1, 1))
	local v21 = v4:NextInteger(v11.Min, v11.Max)
	local v222 = v2.getAttribute(p2, "Size_Curve", v2.default_bezier)
	local v23 = v2.getAttribute(p2, "Transparency_Curve", v2.default_bezier)
	local v24 = v2.getAttribute(p2, "Transparency_Duration", 0.5)
	local v25 = v2.getAttribute(p2, "Size_Duration", 0.5)
	local v26 = v2.getAttribute(p2, "Transparency_Start", 0)
	local v27 = v2.getAttribute(p2, "Transparency_End", 1)
	local t = {}
	local t3 = {}
	p2.CanCollide = false
	if v32 then
		for v28, v29 in workspace:GetPartBoundsInRadius(p1.WorldPosition, v22, v32) do
			if v29.Transparency ~= 1 then
				table.insert(t, v29)
			end
		end
	end
	task.wait(v10)
	for i = 1, v21 do
		local v30 = if #t == 0 then false else t[v4:NextInteger(1, #t)]
		local v31 = v2.getRanomId()
		local v322 = v5:get(v31)
		local v33 = v322._getReal()
		v2.copyProperties(p2, v33, v2.COPY_PART_PROPERTIES)
		v2.copyProperties(p2, v33, v2.COPY_EXTENDED_PART_PROPERTIES)
		if #p2:GetChildren() ~= 0 then
			local v34 = p2:Clone()
			for v35, v36 in v34:GetChildren() do
				v36.Parent = v33
			end
			v34:Destroy()
		end
		v322.Anchored = false
		v322.CanCollide = true
		v322.Transparency = v26
		if v322.CollisionGroup == "Default" then
			v322.CollisionGroup = "ForgeDebris"
		end
		v322.CFrame = CFrame.new(p1.WorldPosition)
		local v40 = Vector3.new(v4:NextNumber(v17.X, v18.X), v4:NextNumber(v17.Y, v18.Y), v4:NextNumber(v17.Z, v18.Z))
		v322.Size = v40
		if v30 then
			v322.Material = v30.Material
			v322.Color = v30.Color
			v322.Transparency = v30.Transparency
		end
		local function f41() --[[ Line: 176 | Upvalues: t2 (ref), v33 (copy), v5 (ref), v31 (copy) ]]
			local v1 = table.find(t2, v33)
			if v1 then
				table.remove(t2, v1)
			end
			if not v5 then
				return
			end
			v5:free(v31)
		end
		table.insert(p3, f41)
		local v42 = t2
		table.insert(v42, v33)
		v322.AssemblyLinearVelocity = p1.WorldCFrame:VectorToWorldSpace(v322.AssemblyLinearVelocity)
		local v43 = v2.randomUnitVector(v19, v20)
		local v44 = p1.WorldCFrame:VectorToWorldSpace(v43)
		v322:ApplyImpulse(v322.AssemblyMass * v2.getImpulseForce(p1.WorldPosition, p1.WorldPosition + v44.Unit * v4:NextNumber(v14.Min, v14.Max), v4:NextNumber(v13.Min, v13.Max)))
		v322:ApplyAngularImpulse(v322.AssemblyMass * v4:NextUnitVector() * v4:NextNumber(v15.Min, v15.Max))
		if shared.vfx and #v322:GetChildren() ~= 0 then
			local Finished = shared.vfx.emit(v322).Finished
			table.insert(t3, Finished)
		end
		task.delay(v4:NextNumber(v122.Min, v122.Max), function() --[[ Line: 211 | Upvalues: v322 (copy), v40 (copy), v16 (copy), p3 (copy), v1 (ref), v222 (copy), v25 (copy), v26 (copy), v27 (copy), v23 (copy), v24 (copy), v2 (ref) ]]
			local Size = v322.Size
			if Size ~= v40 * v16 then
				local function f4(p1, p2) --[[ Line: 217 | Upvalues: v322 (ref), Size (copy), v40 (ref), v16 (ref) ]]
					v322.Size = Size:Lerp(v40 * v16, p1)
					return p2
				end
				table.insert(p3, v1.fromParams(v222, v25, f4))
			end
			if v26 == v27 then
				v322.Transparency = v26
			else
				local function f8(p1, p2) --[[ Line: 227 | Upvalues: v322 (ref), v2 (ref), v26 (ref), v27 (ref) ]]
					v322.Transparency = v2.lerp(v26, v27, p1)
					return p2
				end
				table.insert(p3, v1.fromParams(v23, v24, f8))
			end
		end)
	end
	task.wait(v122.Max + math.max(v24, v25))
	v3.all(t3):await()
end
return t