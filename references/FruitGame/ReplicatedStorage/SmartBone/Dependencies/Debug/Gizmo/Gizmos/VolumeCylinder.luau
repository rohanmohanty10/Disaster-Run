 

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
function u2.Draw(p11, p12, p13, p14, p15, p16) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v17 = p11.Ceive
    if v17.Enabled then
        local v18 = p11.Request("CylinderHandleAdornment")
        v18.Color3 = p11.Propertys.Color3
        v18.Transparency = p11.Propertys.Transparency
        v18.CFrame = p12
        v18.Height = p14
        v18.Radius = p13
        v18.InnerRadius = p15 or 0
        v18.Angle = p16 or 360
        v18.AlwaysOnTop = p11.Propertys.AlwaysOnTop
        v18.ZIndex = 1
        v18.Adornee = u1
        v18.Parent = u1
        v17.ActiveInstances = v17.ActiveInstances + 1
        p11.Register(v18)
        p11.Ceive.ScheduleCleaning()
    end
end
function u2.Create(p19, p20, p21, p22, p23, p24) --[[ Line: 46 ]]
    local v25 = {
        ["Transform"] = p20,
        ["Radius"] = p21,
        ["Length"] = p22,
        ["InnerRadius"] = p23 or 0,
        ["Angle"] = p24 or 360,
        ["AlwaysOnTop"] = p19.Propertys.AlwaysOnTop,
        ["Transparency"] = p19.Propertys.Transparency,
        ["Color3"] = p19.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p19.Retain(p19, v25)
    return v25
end
function u2.Update(p26, p27) --[[ Line: 65 ]]
    local v28 = p26.Ceive
    v28.PushProperty("AlwaysOnTop", p27.AlwaysOnTop)
    v28.PushProperty("Transparency", p27.Transparency)
    v28.PushProperty("Color3", p27.Color3)
    p26:Draw(p27.Transform, p27.Radius, p27.Length, p27.InnerRadius, p27.Angle)
end
return u2