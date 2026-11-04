 

local u1 = {}
u1.__index = u1
function u1.Init(p2, p3, p4, p5, p6) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v7 = u1
    local v8 = setmetatable({}, v7)
    v8.Ceive = p2
    v8.Propertys = p3
    v8.Request = p4
    v8.Release = p5
    v8.Retain = p6
    return v8
end
function u1.Draw(p9, p10, p11, p12, p13) --[[ Line: 18 ]]
    local v14 = p9.Ceive
    if v14.Enabled then
        v14.Circle:Draw(p10, p11, p12, p13)
        v14.Circle:Draw(p10 * CFrame.Angles(0, 1.5707963267948966, 0), p11, p12, p13)
        v14.Circle:Draw(p10 * CFrame.Angles(1.5707963267948966, 0, 0), p11, p12, p13)
    end
end
function u1.Create(p15, p16, p17, p18, p19) --[[ Line: 30 ]]
    local v20 = {
        ["Transform"] = p16,
        ["Radius"] = p17,
        ["Subdivisions"] = p18,
        ["Angle"] = p19,
        ["AlwaysOnTop"] = p15.Propertys.AlwaysOnTop,
        ["Transparency"] = p15.Propertys.Transparency,
        ["Color3"] = p15.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p15.Retain(p15, v20)
    return v20
end
function u1.Update(p21, p22) --[[ Line: 48 ]]
    local v23 = p21.Ceive
    v23.PushProperty("AlwaysOnTop", p22.AlwaysOnTop)
    v23.PushProperty("Transparency", p22.Transparency)
    v23.PushProperty("Color3", p22.Color3)
    p21:Draw(p22.Transform, p22.Radius, p22.Subdivisions, p22.Angle)
end
return u1