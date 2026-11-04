 

local u1 = Random.new(1029410295159813)
local u2 = {}
u2.__index = u2
function u2.new(p3, p4, p5) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v6 = {
        ["WindOffset"] = u1:NextNumber(0, 1000000),
        ["Root"] = p3:IsA("Bone") and p3 and p3 or nil,
        ["RootPart"] = p4,
        ["RootWorldToLocal"] = p3.WorldCFrame:ToObjectSpace(p3.CFrame),
        ["BoneTotalLength"] = 0,
        ["DistanceFromCamera"] = 100,
        ["Particles"] = {},
        ["LocalCFrame"] = p3.WorldCFrame,
        ["LocalGravity"] = p3.CFrame:PointToWorldSpace(p5).Unit * p5.Magnitude,
        ["Force"] = Vector3.new(0, 0, 0),
        ["RestGravity"] = Vector3.new(-0, -1, -0),
        ["ObjectMove"] = Vector3.new(0, 0, 0),
        ["ObjectPreviousPosition"] = Vector3.new(0, 0, 0)
    }
    local v7 = u2
    return setmetatable(v6, v7)
end
return u2