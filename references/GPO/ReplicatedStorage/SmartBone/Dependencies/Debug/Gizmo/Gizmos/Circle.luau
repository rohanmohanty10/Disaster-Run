 

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
        local v16 = p13 / p12
        local v17 = nil
        local v18 = 0
        local v19 = nil
        for v20 = 0, p13, math.floor(v16) do
            local v21 = math.rad(v20)
            local v22 = math.sin(v21) * p11
            local v23 = math.rad(v20)
            local v24 = math.cos(v23) * p11
            local v25 = p10.Position + (p10.UpVector * v24 + p10.RightVector * v22)
            if v17 == nil then
                v19 = v25
                v18 = v20
                v17 = v19
                local v26 = v19
                v19 = v17
                v26 = v17
            else
                v15.Ray:Draw(v17, v25)
                v18 = v20
                v17 = v25
            end
        end
        if v18 ~= p13 then
            local v27 = math.rad(p13)
            local v28 = math.sin(v27) * p11
            local v29 = math.rad(p13)
            local v30 = math.cos(v29) * p11
            local v31 = p10.Position + (p10.UpVector * v30 + p10.RightVector * v28)
            v15.Ray:Draw(v17, v31)
        end
        if p14 ~= false then
            v15.Ray:Draw(v17, v19)
        end
        return v17
    end
end
function u1.Create(p32, p33, p34, p35, p36, p37) --[[ Line: 64 ]]
    local v38 = {
        ["Transform"] = p33,
        ["Radius"] = p34,
        ["Subdivisions"] = p35,
        ["Angle"] = p36,
        ["ConnectToStart"] = p37,
        ["AlwaysOnTop"] = p32.Propertys.AlwaysOnTop,
        ["Transparency"] = p32.Propertys.Transparency,
        ["Color3"] = p32.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p32.Retain(p32, v38)
    return v38
end
function u1.Update(p39, p40) --[[ Line: 83 ]]
    local v41 = p39.Ceive
    v41.PushProperty("AlwaysOnTop", p40.AlwaysOnTop)
    v41.PushProperty("Transparency", p40.Transparency)
    v41.PushProperty("Color3", p40.Color3)
    p39:Draw(p40.Transform, p40.Radius, p40.Subdivisions, p40.Angle, p40.ConnectToStart)
end
return u1