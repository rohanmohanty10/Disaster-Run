 

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
        if p9.Propertys.AlwaysOnTop then
            v12.AOTWireframeHandle:AddLine(p10, p11)
        else
            v12.WireframeHandle:AddLine(p10, p11)
        end
        local v13 = p9.Ceive
        v13.ActiveRays = v13.ActiveRays + 1
        p9.Ceive.ScheduleCleaning()
    end
end
function u1.Create(p14, p15, p16) --[[ Line: 34 ]]
    local v17 = {
        ["Origin"] = p15,
        ["End"] = p16,
        ["AlwaysOnTop"] = p14.Propertys.AlwaysOnTop,
        ["Transparency"] = p14.Propertys.Transparency,
        ["Color3"] = p14.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p14.Retain(p14, v17)
    return v17
end
function u1.Update(p18, p19) --[[ Line: 50 ]]
    local v20 = p18.Ceive
    v20.PushProperty("AlwaysOnTop", p19.AlwaysOnTop)
    v20.PushProperty("Transparency", p19.Transparency)
    v20.PushProperty("Color3", p19.Color3)
    p18:Draw(p19.Origin, p19.End)
end
return u1