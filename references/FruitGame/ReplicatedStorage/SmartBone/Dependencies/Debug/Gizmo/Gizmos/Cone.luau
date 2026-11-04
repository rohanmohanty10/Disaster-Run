 

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
        local v15 = p10 * CFrame.Angles(-1.5707963267948966, 0, 0)
        local v16 = v15.Position + v15.UpVector * (p12 * 0.5)
        local v17 = v15.Position + -v15.UpVector * (p12 * 0.5)
        local v18 = CFrame.lookAt(v16, v16 + v15.UpVector)
        local v19 = CFrame.lookAt(v17, v17 - v15.UpVector)
        local v20 = 360 / p13
        local v21 = nil
        local v22 = nil
        for v23 = 0, 360, math.floor(v20) do
            local v24 = math.rad(v23)
            local v25 = math.sin(v24) * p11
            local v26 = math.rad(v23)
            local v27 = math.cos(v26) * p11
            local v28 = v15.LookVector * v27 + v15.RightVector * v25
            local v29 = v19.Position + v28
            if v21 then
                v14.Ray:Draw(v29, v18.Position)
                v14.Ray:Draw(v21, v29)
                v21 = v29
            else
                v14.Ray:Draw(v29, v18.Position)
                v22 = v29
                v21 = v22
                local v30 = v22
                v22 = v21
                v30 = v21
            end
        end
        v14.Ray:Draw(v21, v22)
    end
end
function u1.Create(p31, p32, p33, p34, p35) --[[ Line: 63 ]]
    local v36 = {
        ["Transform"] = p32,
        ["Radius"] = p33,
        ["Length"] = p34,
        ["Subdivisions"] = p35,
        ["AlwaysOnTop"] = p31.Propertys.AlwaysOnTop,
        ["Transparency"] = p31.Propertys.Transparency,
        ["Color3"] = p31.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p31.Retain(p31, v36)
    return v36
end
function u1.Update(p37, p38) --[[ Line: 81 ]]
    local v39 = p37.Ceive
    v39.PushProperty("AlwaysOnTop", p38.AlwaysOnTop)
    v39.PushProperty("Transparency", p38.Transparency)
    v39.PushProperty("Color3", p38.Color3)
    p37:Draw(p38.Transform, p38.Radius, p38.Length, p38.Subdivisions)
end
return u1