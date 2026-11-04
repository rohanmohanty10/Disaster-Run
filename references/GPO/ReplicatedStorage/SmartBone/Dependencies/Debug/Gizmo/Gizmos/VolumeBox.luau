 

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
function u2.Draw(p11, p12, p13) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v14 = p11.Ceive
    if v14.Enabled then
        local v15 = p11.Request("BoxHandleAdornment")
        v15.Color3 = p11.Propertys.Color3
        v15.Transparency = p11.Propertys.Transparency
        v15.CFrame = p12
        v15.Size = p13
        v15.AlwaysOnTop = p11.Propertys.AlwaysOnTop
        v15.ZIndex = 1
        v15.Adornee = u1
        v15.Parent = u1
        v14.ActiveInstances = v14.ActiveInstances + 1
        p11.Register(v15)
        p11.Ceive.ScheduleCleaning()
    end
end
function u2.Create(p16, p17, p18) --[[ Line: 43 ]]
    local v19 = {
        ["Transform"] = p17,
        ["Size"] = p18,
        ["AlwaysOnTop"] = p16.Propertys.AlwaysOnTop,
        ["Transparency"] = p16.Propertys.Transparency,
        ["Color3"] = p16.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p16.Retain(p16, v19)
    return v19
end
function u2.Update(p20, p21) --[[ Line: 59 ]]
    local v22 = p20.Ceive
    v22.PushProperty("AlwaysOnTop", p21.AlwaysOnTop)
    v22.PushProperty("Transparency", p21.Transparency)
    v22.PushProperty("Color3", p21.Color3)
    p20:Draw(p21.Transform, p21.Size)
end
return u2