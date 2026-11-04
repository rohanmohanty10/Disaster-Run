 

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
function u1.Draw(p9, p10, p11) --[[ Line: 16 ]]
    local v12 = p9.Ceive
    if v12.Enabled then
        local v13 = p10.Position + p10.LookVector * (-p11 * 0.5)
        local v14 = p10.Position + p10.LookVector * (p11 * 0.5)
        v12.Ray:Draw(v13, v14)
    end
end
function u1.Create(p15, p16, p17) --[[ Line: 29 ]]
    local v18 = {
        ["Transform"] = p16,
        ["Length"] = p17,
        ["AlwaysOnTop"] = p15.Propertys.AlwaysOnTop,
        ["Transparency"] = p15.Propertys.Transparency,
        ["Color3"] = p15.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p15.Retain(p15, v18)
    return v18
end
function u1.Update(p19, p20) --[[ Line: 45 ]]
    local v21 = p19.Ceive
    v21.PushProperty("AlwaysOnTop", p20.AlwaysOnTop)
    v21.PushProperty("Transparency", p20.Transparency)
    v21.PushProperty("Color3", p20.Color3)
    p19:Draw(p20.Transform, p20.Length)
end
return u1