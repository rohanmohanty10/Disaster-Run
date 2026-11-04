 

local u1 = {}
u1.__index = u1
function u1.new(p2, p3, p4, p5) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v6 = {
        ["Bone"] = p2,
        ["RestLength"] = 0,
        ["Weight"] = 0.7,
        ["ParentIndex"] = 0,
        ["Transform"] = p2.WorldCFrame:ToObjectSpace(p3.WorldCFrame):Inverse(),
        ["LocalTransform"] = p2.CFrame:ToObjectSpace(p3.CFrame):Inverse(),
        ["RootTransform"] = p3.WorldCFrame:ToObjectSpace(p4.CFrame):Inverse(),
        ["Radius"] = p5.Radius,
        ["IsColliding"] = false,
        ["TransformOffset"] = CFrame.identity,
        ["LastTransformOffset"] = CFrame.identity,
        ["LocalTransformOffset"] = CFrame.identity,
        ["RestPosition"] = Vector3.new(0, 0, 0),
        ["BoneTransform"] = CFrame.identity,
        ["CalculatedWorldCFrame"] = p2.WorldCFrame,
        ["CalculatedWorldPosition"] = p2.WorldPosition,
        ["Position"] = p2.WorldPosition,
        ["LastPosition"] = p2.WorldPosition,
        ["Anchored"] = false,
        ["RecyclingBin"] = {}
    }
    local v7 = u1
    return setmetatable(v6, v7)
end
return u1