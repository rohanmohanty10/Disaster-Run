 

local u1 = {}
u1.__index = u1
function u1.Init(p2, p3, p4, p5, p6) --[[ Line: 4 ]]
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
function u1.Draw(p9, p10, p11, p12, p13, p14) --[[ Line: 16 ]]
    local v15 = p9.Ceive
    if v15.Enabled then
        v15.Ray:Draw(p10, p11)
        local v16 = CFrame.lookAt(p11 + (p10 - p11).Unit * (p13 * 0.5), p11)
        v15.Cone:Draw(v16, p12, p13, p14)
    end
end
function u1.Create(p17, p18, p19, p20, p21, p22) --[[ Line: 29 ]]
    local v23 = {
        ["Origin"] = p18,
        ["End"] = p19,
        ["Radius"] = p20,
        ["Length"] = p21,
        ["Subdivisions"] = p22,
        ["AlwaysOnTop"] = p17.Propertys.AlwaysOnTop,
        ["Transparency"] = p17.Propertys.Transparency,
        ["Color3"] = p17.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p17.Retain(p17, v23)
    return v23
end
function u1.Update(p24, p25) --[[ Line: 48 ]]
    local v26 = p24.Ceive
    v26.PushProperty("AlwaysOnTop", p25.AlwaysOnTop)
    v26.PushProperty("Transparency", p25.Transparency)
    v26.PushProperty("Color3", p25.Color3)
    p24:Draw(p25.Origin, p25.End, p25.Radius, p25.Length, p25.Subdivisions)
end
return u1