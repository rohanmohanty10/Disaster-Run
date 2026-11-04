 

local u1 = {}
u1.__index = u1
function u1.Init(p2, p3, p4, p5, p6, p7) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v8 = u1
    local v9 = setmetatable({}, v8)
    v9.Ceive = p2
    v9.Propertys = p3
    v9.Request = p4
    v9.Release = p5
    v9.Retain = p6
    v9.Register = p7
    return v9
end
function u1.Draw(p10, p11, p12, p13, p14, p15, p16) --[[ Line: 17 ]]
    local v17 = p10.Ceive
    if v17.Enabled then
        local v18 = CFrame.lookAt(p12 - (p12 - p11).Unit * (p15 * 0.5), p12)
        if p16 == true then
            local v19 = v18.Position
            local v20 = (v19 - p11).Magnitude
            local v21 = CFrame.lookAt((p11 + v19) * 0.5, p12)
            v17.VolumeCylinder:Draw(v21, p13, v20)
        else
            v17.Ray:Draw(p11, p12)
        end
        v17.VolumeCone:Draw(v18, p14, p15)
        p10.Ceive.ScheduleCleaning()
    end
end
function u1.Create(p22, p23, p24, p25, p26, p27, p28) --[[ Line: 40 ]]
    local v29 = {
        ["Origin"] = p23,
        ["End"] = p24,
        ["CylinderRadius"] = p25,
        ["ConeRadius"] = p26,
        ["Length"] = p27,
        ["UseCylinder"] = p28,
        ["AlwaysOnTop"] = p22.Propertys.AlwaysOnTop,
        ["Transparency"] = p22.Propertys.Transparency,
        ["Color3"] = p22.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p22.Retain(p22, v29)
    return v29
end
function u1.Update(p30, p31) --[[ Line: 60 ]]
    local v32 = p30.Ceive
    v32.PushProperty("AlwaysOnTop", p31.AlwaysOnTop)
    v32.PushProperty("Transparency", p31.Transparency)
    v32.PushProperty("Color3", p31.Color3)
    p30:Draw(p31.Origin, p31.End, p31.Radius, p31.Length, p31.UseCylinder)
end
return u1