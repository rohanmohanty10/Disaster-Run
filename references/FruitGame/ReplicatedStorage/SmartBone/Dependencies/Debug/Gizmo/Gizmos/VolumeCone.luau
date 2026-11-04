 

local u1 = workspace.Terrain
local u2 = {}
u2.__index = u2
function u2.Init(p3, p4, p5, p6, p7, p8) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v9 = u2
    local v10 = setmetatable({}, v9)
    v10.Ceive = p3
    v10.Propertys = p4
    v10.Request = p5
    v10.Release = p6
    v10.Retain = p7
    v10.Register = p8
    return v10
end
function u2.Draw(p11, p12, p13, p14) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v15 = p11.Ceive
    if v15.Enabled then
        local v16 = p11.Request("ConeHandleAdornment")
        v16.Color3 = p11.Propertys.Color3
        v16.Transparency = p11.Propertys.Transparency
        v16.CFrame = p12
        v16.AlwaysOnTop = p11.Propertys.AlwaysOnTop
        v16.ZIndex = 1
        v16.Height = p14
        v16.Radius = p13
        v16.Adornee = u1
        v16.Parent = u1
        v15.ActiveInstances = v15.ActiveInstances + 1
        p11.Register(v16)
        p11.Ceive.ScheduleCleaning()
    end
end
function u2.Create(p17, p18, p19, p20) --[[ Line: 44 ]]
    local v21 = {
        ["Transform"] = p18,
        ["Radius"] = p19,
        ["Length"] = p20,
        ["AlwaysOnTop"] = p17.Propertys.AlwaysOnTop,
        ["Transparency"] = p17.Propertys.Transparency,
        ["Color3"] = p17.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p17.Retain(p17, v21)
    return v21
end
function u2.Update(p22, p23) --[[ Line: 61 ]]
    local v24 = p22.Ceive
    v24.PushProperty("AlwaysOnTop", p23.AlwaysOnTop)
    v24.PushProperty("Transparency", p23.Transparency)
    v24.PushProperty("Color3", p23.Color3)
    p22:Draw(p23.Transform, p23.Radius, p23.Length)
end
return u2