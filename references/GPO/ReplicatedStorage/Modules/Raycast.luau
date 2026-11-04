 

script:WaitForChild("AllActors")
script:WaitForChild("Actor")
local u1 = {}
local v2 = {}
for _ = 1, 64 do
    local v3 = script.Actor:Clone()
    v3.Parent = script.AllActors
    local v4 = require
    local v5 = v3.Caster
    table.insert(u1, v4(v5))
end
function v2.cast(_, p6, p7, p8, p9) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if typeof(p6) ~= "Ray" then
        return u1[math.random(1, 64)](p6, p7, p8, p9)
    end
    local v10 = p6.Origin
    local v11 = p6.Direction
    return u1[math.random(1, 64)](v10, v11, p7, p8)
end
function _G.raycastWhitelist(p12, p13, p14) --[[ Line: 22 ]]
    if typeof(p12) ~= "Ray" then
        p12 = Ray.new(p12.Origin, p12.Direction)
    end
    local v15 = RaycastParams.new()
    v15.FilterDescendantsInstances = p13
    v15.FilterType = Enum.RaycastFilterType.Include
    if p14 == true then
        v15.RespectCanCollide = true
    end
    local v16 = workspace:Raycast(p12.Origin, p12.Direction, v15)
    local v17, v18, v19
    if v16 then
        v17 = v16.Instance
        v18 = v16.Position
        v19 = v16.Normal
    else
        v19 = nil
        v18 = nil
        v17 = nil
    end
    local v20 = (v19 == Vector3.new(0, 0, 0) or v19 == nil) and Vector3.new(0, 1, 0) or v19
    if v18 == nil then
        v18 = p12.Origin + p12.Direction
    end
    return v17, v18, v20
end
function _G.raycastIgnoreList(p21, p22) --[[ Line: 49 ]]
    if typeof(p21) ~= "Ray" then
        p21 = Ray.new(p21.Origin, p21.Direction)
    end
    local v23, v24, v25 = workspace:FindPartOnRayWithIgnoreList(p21, p22)
    return v23, v24, v25
end
return v2