 

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
function u1.Draw(p9, p10, p11, u12) --[[ Line: 16 ]]
    local u13 = p9.Ceive
    if u13.Enabled then
        local u14 = p10.Position
        local v15 = p10.UpVector
        local v16 = p10.RightVector
        local v17 = p10.LookVector
        local v18 = p11 * 0.5
        local v19 = v15 * v18.Y
        local v20 = v16 * v18.X
        local v21 = v17 * v18.Z
        local function v29(p22, p23, p24) --[[ Line: 32 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u13
                [3] = u12
            --]]
            local v25 = u14 + (p22 - p23 + p24)
            local v26 = u14 + (p22 + p23 + p24)
            local v27 = u14 + (p22 - p23 - p24)
            local v28 = u14 + (p22 + p23 - p24)
            u13.Ray:Draw(v25, v26)
            u13.Ray:Draw(v25, v27)
            u13.Ray:Draw(v26, v28)
            if u12 ~= false then
                u13.Ray:Draw(v26, v27)
            end
            u13.Ray:Draw(v27, v28)
        end
        local function v37(p30, p31, p32) --[[ Line: 49 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u13
                [3] = u12
            --]]
            local v33 = u14 + (p30 - p31 + p32)
            local v34 = u14 + (p30 + p31 + p32)
            local v35 = u14 + (-p30 - p31 + p32)
            local v36 = u14 + (-p30 + p31 + p32)
            u13.Ray:Draw(v33, v34)
            u13.Ray:Draw(v33, v35)
            u13.Ray:Draw(v34, v36)
            if u12 ~= false then
                u13.Ray:Draw(v34, v35)
            end
            u13.Ray:Draw(v35, v36)
        end
        local function v45(p38, p39, p40) --[[ Line: 66 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u13
                [3] = u12
            --]]
            local v41 = u14 + (p38 - p39 - p40)
            local v42 = u14 + (p38 - p39 + p40)
            local v43 = u14 + (-p38 - p39 - p40)
            local v44 = u14 + (-p38 - p39 + p40)
            u13.Ray:Draw(v41, v42)
            u13.Ray:Draw(v41, v43)
            u13.Ray:Draw(v42, v44)
            if u12 ~= false then
                u13.Ray:Draw(v42, v43)
            end
            u13.Ray:Draw(v43, v44)
        end
        v45(v19, v20, v21)
        v45(v19, -v20, v21)
        v29(v19, v20, v21)
        v29(-v19, v20, v21)
        v37(v19, v20, v21)
        v37(v19, v20, -v21)
    end
end
function u1.Create(p46, p47, p48, p49) --[[ Line: 93 ]]
    local v50 = {
        ["Transform"] = p47,
        ["Size"] = p48,
        ["DrawTriangles"] = p49,
        ["AlwaysOnTop"] = p46.Propertys.AlwaysOnTop,
        ["Transparency"] = p46.Propertys.Transparency,
        ["Color3"] = p46.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p46.Retain(p46, v50)
    return v50
end
function u1.Update(p51, p52) --[[ Line: 110 ]]
    local v53 = p51.Ceive
    v53.PushProperty("AlwaysOnTop", p52.AlwaysOnTop)
    v53.PushProperty("Transparency", p52.Transparency)
    v53.PushProperty("Color3", p52.Color3)
    p51:Draw(p52.Transform, p52.Size, p52.DrawTriangles)
end
return u1