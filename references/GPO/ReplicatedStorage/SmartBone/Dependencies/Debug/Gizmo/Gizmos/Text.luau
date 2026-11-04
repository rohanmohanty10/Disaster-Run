 

local u1 = workspace.CurrentCamera
local u2 = {}
u2.__index = u2
function u2.Init(p3, p4, p5, p6, p7) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v8 = u2
    local v9 = setmetatable({}, v8)
    v9.Ceive = p3
    v9.Propertys = p4
    v9.Request = p5
    v9.Release = p6
    v9.Retain = p7
    return v9
end
function u2.Draw(p10, p11, p12, p13) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v14 = p10.Ceive
    if v14.Enabled then
        if p10.Propertys.AlwaysOnTop then
            local v15 = (p11 - u1.CFrame.Position).Magnitude
            local v16 = v14.PopProperty("Color3")
            v14.PushProperty("Color3", Color3.new())
            local v17 = -(Vector3.new(1, 1, 0)).Unit
            v14.AOTWireframeHandle:AddText(p11 + v17 * (v15 * 0.00175), p12, p13)
            v14.PushProperty("Color3", v16)
            v14.AOTWireframeHandle:AddText(p11, p12, p13)
        else
            local v18 = (p11 - u1.CFrame.Position).Magnitude
            local v19 = v14.PopProperty("Color3")
            v14.PushProperty("Color3", Color3.new())
            local v20 = -(Vector3.new(1, 1, 0)).Unit
            v14.WireframeHandle:AddText(p11 + v20 * (v18 * 0.00175), p12, p13)
            v14.PushProperty("Color3", v19)
            v14.WireframeHandle:AddText(p11, p12, p13)
        end
        p10.Ceive.ScheduleCleaning()
    end
end
function u2.Create(p21, p22, p23, p24) --[[ Line: 60 ]]
    local v25 = {
        ["Origin"] = p22,
        ["Text"] = p23,
        ["Size"] = p24,
        ["AlwaysOnTop"] = p21.Propertys.AlwaysOnTop,
        ["Transparency"] = p21.Propertys.Transparency,
        ["Color3"] = p21.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p21.Retain(p21, v25)
    return v25
end
function u2.Update(p26, p27) --[[ Line: 77 ]]
    local v28 = p26.Ceive
    v28.PushProperty("AlwaysOnTop", p27.AlwaysOnTop)
    v28.PushProperty("Transparency", p27.Transparency)
    v28.PushProperty("Color3", p27.Color3)
    p26:Draw(p27.Origin, p27.Text, p27.Size)
end
return u2