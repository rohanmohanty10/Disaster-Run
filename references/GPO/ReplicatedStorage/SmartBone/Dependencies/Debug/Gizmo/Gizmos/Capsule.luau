 

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
        local v15 = p10.Position + p10.UpVector * (p12 * 0.5)
        local v16 = p10.Position - p10.UpVector * (p12 * 0.5)
        local v17 = CFrame.lookAt(v15, v15 + p10.UpVector)
        local v18 = CFrame.lookAt(v16, v16 - p10.UpVector)
        local v19 = 360 / p13
        local v20 = nil
        local v21 = nil
        local v22 = nil
        local v23 = nil
        for v24 = 0, 360, math.floor(v19) do
            local v25 = math.rad(v24)
            local v26 = math.sin(v25) * p11
            local v27 = math.rad(v24)
            local v28 = math.cos(v27) * p11
            local v29 = p10.LookVector * v28 + p10.RightVector * v26
            local v30 = v17.Position + v29
            local v31 = v18.Position + v29
            v14.Ray:Draw(v30, v31)
            v14.Circle:Draw(CFrame.new(v17.Position) * p10.Rotation * CFrame.Angles(0, math.rad(v24), 0), p11, p13 * 0.5, 90, false)
            v14.Circle:Draw(CFrame.new(v18.Position) * p10.Rotation * CFrame.Angles(3.141592653589793, math.rad(v24), 0), p11, p13 * 0.5, 90, false)
            if v20 then
                v14.Ray:Draw(v20, v30)
                v14.Ray:Draw(v21, v31)
                v21 = v31
                v20 = v30
            else
                v23 = v31
                v22 = v30
                v21 = v23
                v20 = v22
                local v32 = v23
                v23 = v21
                v32 = v22
                v22 = v20
                v32 = v21
                v21 = v23
                v32 = v20
            end
        end
        v14.Ray:Draw(v20, v22)
        v14.Ray:Draw(v21, v23)
    end
end
function u1.Create(p33, p34, p35, p36, p37) --[[ Line: 88 ]]
    local v38 = {
        ["Transform"] = p34,
        ["Radius"] = p35,
        ["Length"] = p36,
        ["Subdivisions"] = p37,
        ["AlwaysOnTop"] = p33.Propertys.AlwaysOnTop,
        ["Transparency"] = p33.Propertys.Transparency,
        ["Color3"] = p33.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p33.Retain(p33, v38)
    return v38
end
function u1.Update(p39, p40) --[[ Line: 106 ]]
    local v41 = p39.Ceive
    v41.PushProperty("AlwaysOnTop", p40.AlwaysOnTop)
    v41.PushProperty("Transparency", p40.Transparency)
    v41.PushProperty("Color3", p40.Color3)
    p39:Draw(p40.Transform, p40.Radius, p40.Length, p40.Subdivisions)
end
return u1