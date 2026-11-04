 

local u1 = require(script.Parent:WaitForChild("Collider"))
local u2 = require(script.Parent.Parent.Parent:WaitForChild("Dependencies"):WaitForChild("Utilities")).SB_VERBOSE_LOG
local u3 = os.clock
local u4 = {}
u4.__index = u4
function u4.new(p5, u6) --[[ Line: 59 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v7 = u4
    local u8 = setmetatable({
        ["m_Object"] = u6,
        ["m_Awake"] = true,
        ["m_LastSleepCycle"] = 0,
        ["Destroyed"] = false,
        ["Colliders"] = {}
    }, v7)
    u8:m_LoadColliderTable(p5)
    u8.DestroyConnection = u6:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 70 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u8
        --]]
        if u6.Parent == nil then
            u8.Destroyed = true
        end
    end)
    return u8
end
function u4.m_LoadCollider(p9, p10) --[[ Line: 82 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v11 = p10.ScaleX
    local v12 = p10.ScaleY
    local v13 = p10.ScaleZ
    local v14 = Vector3.new(v11, v12, v13)
    local v15 = p10.OffsetX
    local v16 = p10.OffsetY
    local v17 = p10.OffsetZ
    local v18 = Vector3.new(v15, v16, v17)
    local v19 = p10.RotationX
    local v20 = p10.RotationY
    local v21 = p10.RotationZ
    local v22 = Vector3.new(v19, v20, v21)
    local v23 = u1.new()
    v23.Scale = v14
    v23.Offset = v18
    v23.Rotation = v22
    v23.Type = p10.Type
    v23:SetObject(p9.m_Object)
    p9.Colliders[#p9.Colliders + 1] = v23
end
function u4.m_LoadColliderTable(p24, p25) --[[ Line: 100 ]]
    for _, v26 in p25 do
        p24:m_LoadCollider(v26)
    end
end
function u4.GetObject(p27) --[[ Line: 110 ]]
    return p27.m_Object
end
function u4.GetCollisions(p28, p29, p30, p31, p32, p33) --[[ Line: 121 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if not p28.m_Object then
        return p33
    end
    local v34 = p28.Colliders
    local v35 = #v34
    if v35 == 0 then
        return p33
    end
    local v36 = u3()
    if v36 - p28.m_LastSleepCycle >= 0.2 then
        p28.m_LastSleepCycle = v36
        p28.m_Awake = p28.m_Object:IsDescendantOf(workspace)
    end
    if not p28.m_Awake then
        return p33
    end
    for v37 = 1, v35 do
        local v38, v39, v40 = v34[v37]:GetClosestPoint(p29, p30)
        if v38 then
            p33 = p33 + 1
            p31[p33] = v39
            p32[p33] = v40
        end
    end
    return p33
end
function u4.CouldIntersectBounds(p41, p42, p43) --[[ Line: 160 ]]
    if not (p41.m_Awake and p41.m_Object) then
        return false
    end
    local v44 = p41.Colliders
    for v45 = 1, #v44 do
        local v46 = v44[v45]
        if (v46.Transform.Position - p42).Magnitude < p43 + v46.Radius then
            return true
        end
    end
    return false
end
function u4.Step(p47) --[[ Line: 176 ]]
    local v48 = p47.Colliders
    for v49 = 1, #v48 do
        v48[v49]:Step()
    end
end
function u4.DrawDebug(p50, p51, p52, p53, p54) --[[ Line: 188 ]]
    for _, v55 in p50.Colliders do
        v55:DrawDebug(p50, p51, p52, p53, p54)
        v55.InNarrowphase = false
    end
end
function u4.Destroy(p56) --[[ Line: 196 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    task.synchronize()
    u2((("Collider object destroying, object: %*"):format(p56.m_Object)))
    p56.DestroyConnection:Disconnect()
    if #p56.Colliders ~= 0 then
        for _, v57 in p56.Colliders do
            v57:Destroy()
        end
    end
    table.clear(p56)
    setmetatable(p56, nil)
    task.desynchronize()
end
return u4