 

local u1 = game:GetService("HttpService")
local v2 = script.Parent.Parent.Parent:WaitForChild("Dependencies")
local v3 = script.Parent:WaitForChild("Colliders")
local u4 = require(v3:WaitForChild("Box"))
local u5 = require(v3:WaitForChild("Capsule"))
local u6 = require(v3:WaitForChild("Cylinder"))
local u7 = require(v3:WaitForChild("Sphere"))
local u8 = require(script.Parent.Parent.Parent:WaitForChild("Dependencies"):WaitForChild("Utilities")).SB_VERBOSE_LOG
local u9 = require(v2:WaitForChild("Debug"):WaitForChild("Gizmo"))
local u10 = {}
u10.__index = u10
function u10.new() --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u10
    --]]
    local v11 = {
        ["Type"] = "Box",
        ["Scale"] = Vector3.new(0, 0, 0),
        ["Offset"] = Vector3.new(0, 0, 0),
        ["Rotation"] = Vector3.new(0, 0, 0),
        ["Radius"] = 0,
        ["PreviousScale"] = Vector3.new(0, 0, 0),
        ["PreviousOffset"] = Vector3.new(0, 0, 0),
        ["PreviousRotation"] = Vector3.new(0, 0, 0),
        ["PreviousObjectPosition"] = Vector3.new(0, 0, 0),
        ["PreviousObjectRotation"] = Vector3.new(0, 0, 0),
        ["m_Object"] = nil,
        ["InNarrowphase"] = false,
        ["Transform"] = CFrame.identity,
        ["Size"] = Vector3.new(0, 0, 0),
        ["GUID"] = u1:GenerateGUID(false)
    }
    local v12 = u10
    return setmetatable(v11, v12)
end
function u10.SetObject(p13, p14) --[[ Line: 99 ]]
    p13.m_Object = p14
    p13:UpdateTransform()
end
function u10.UpdateTransform(p15) --[[ Line: 106 ]]
    local v16 = p15.m_Object
    local v17 = v16.CFrame
    local v18 = v16.Size
    local v19 = p15.Scale
    local v20 = p15.Offset
    local v21 = p15.Rotation
    local v22 = v18 * v20
    local v23 = v18 * v19
    local v24 = CFrame.Angles(v21.X * 0.017453, v21.Y * 0.017453, v21.Z * 0.017453)
    p15.Transform = v17 * CFrame.new(v22) * v24
    p15.Size = v23
    local v25 = v23.X
    local v26 = v23.Y
    local v27 = v23.Z
    local v28 = math.max(v25, v26, v27) * 0.5
    local v29 = v28 * v28 * 2
    p15.Radius = math.sqrt(v29)
end
function u10.GetClosestPoint(p30, p31, p32) --[[ Line: 130 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u7
        [4] = u6
    --]]
    if p30.m_Object == nil then
        return
    else
        p30.InNarrowphase = false
        if (p31 - p30.Transform.Position).Magnitude - p32 <= p30.Radius then
            p30.InNarrowphase = true
            local v33 = p30.Type
            local v34 = p30.Transform
            local v35 = p30.Size
            if v33 == "Box" then
                return u4(v34, v35, p31, p32)
            end
            if v33 == "Capsule" then
                return u5(v34, v35, p31, p32)
            end
            if v33 == "Sphere" then
                return u7(v34, v35, p31, p32)
            end
            if v33 == "Cylinder" then
                return u6(v34, v35, p31, p32)
            end
        end
    end
end
function u10.Step(p36) --[[ Line: 161 ]]
    p36:UpdateTransform()
end
function u10.DrawDebug(p37, p38, p39, p40, p41, p42) --[[ Line: 173 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local v43 = Color3.new(0.509803, 0.933333, 0.42745)
    local v44 = Color3.new(0.90196, 0.784313, 0.513725)
    local v45 = Color3.new(1, 0, 1)
    local v46 = Color3.new(0, 1, 1)
    local v47 = Color3.new(1, 0.3, 0.3)
    local v48 = p37.Type
    local v49 = p37.Transform
    local v50 = p37.Size
    if p38.m_Awake then
        v45 = v43
    elseif not p41 then
        v45 = v43
    end
    if p37.InNarrowphase == false then
        if not p42 then
            v46 = v44
        end
    else
        v46 = v44
    end
    if p40 then
        u9.SetStyle(v47, 0, false)
        u9.Sphere:Draw(v49, p37.Radius, 25, 360)
    end
    if v48 == "Box" then
        u9.SetStyle(v45, 0, false)
        u9.Box:Draw(v49, v50)
        if p39 then
            u9.SetStyle(v46, 0.75, false)
            u9.VolumeBox:Draw(v49, v50)
            u9.PushProperty("Transparency", 0)
        end
        return
    elseif v48 == "Capsule" then
        local v51 = (v50.Y < v50.Z and v50.Y or v50.Z) * 0.5
        local v52 = v50.X
        local v53 = v49 * CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0)
        u9.SetStyle(v45, 0, false)
        u9.Capsule:Draw(v53, v51, v52, 15)
        if p39 then
            local v54 = v53.Position + v53.UpVector * (v52 * 0.5)
            local v55 = v53.Position - v53.UpVector * (v52 * 0.5)
            u9.SetStyle(v46, 0.75, false)
            u9.VolumeCylinder:Draw(v49, v51, v52)
            u9.VolumeSphere:Draw(CFrame.new(v54), v51)
            u9.VolumeSphere:Draw(CFrame.new(v55), v51)
            u9.PushProperty("Transparency", 0)
        end
        return
    elseif v48 == "Sphere" then
        local v56 = v50.X
        local v57 = v50.Y
        local v58 = v50.Z
        local v59 = math.min(v56, v57, v58) * 0.5
        u9.SetStyle(v45, 0, false)
        u9.Sphere:Draw(v49, v59, 15, 360)
        if p39 then
            u9.SetStyle(v46, 0.75, false)
            u9.VolumeSphere:Draw(v49, v59)
            u9.PushProperty("Transparency", 0)
        end
        return
    elseif v48 == "Cylinder" then
        local v60 = (v50.Y < v50.Z and v50.Y or v50.Z) * 0.5
        u9.SetStyle(v45, 0, false)
        u9.Cylinder:Draw(v49 * CFrame.Angles(0, 0, 1.5707963267948966), v60, v50.X, 15)
        if p39 then
            u9.SetStyle(v46, 0.75, false)
            u9.VolumeCylinder:Draw(v49 * CFrame.Angles(0, -1.5707963267948966, 0), v60, v50.X, 0, 360)
            u9.PushProperty("Transparency", 0)
        end
    end
end
function u10.Destroy(p61) --[[ Line: 265 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    u8((("Collider destroying, object: %*"):format(p61.m_Object)))
    table.clear(p61)
    setmetatable(p61, nil)
end
return u10