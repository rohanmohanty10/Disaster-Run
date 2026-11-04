 

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
        local u22 = nil
        local u23 = nil
        local u24 = nil
        local u25 = nil
        local function v33(p26, p27, p28) --[[ Line: 58 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u24
                [3] = u25
                [4] = u13
                [5] = u12
            --]]
            local v29 = u14 + (p26 - p27 + p28)
            local v30 = u14 + (p26 + p27 + p28)
            local v31 = u14 + (-p26 - p27 + p28)
            local v32 = u14 + (-p26 + p27 + p28)
            u24 = v29
            u25 = v30
            u13.Ray:Draw(v29, v30)
            u13.Ray:Draw(v29, v31)
            u13.Ray:Draw(v30, v32)
            if u12 ~= false then
                u13.Ray:Draw(v30, v31)
            end
            u13.Ray:Draw(v31, v32)
        end
        (function(p34, p35, p36) --[[ Name: CalculateYFace, Line 38 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u22
                [3] = u23
                [4] = u13
                [5] = u12
            --]]
            local v37 = u14 + (p34 - p35 + p36)
            local v38 = u14 + (p34 + p35 + p36)
            local v39 = u14 + (p34 - p35 - p36)
            local v40 = u14 + (p34 + p35 - p36)
            u22 = v37
            u23 = v38
            u13.Ray:Draw(v37, v38)
            u13.Ray:Draw(v37, v39)
            u13.Ray:Draw(v38, v40)
            if u12 ~= false then
                u13.Ray:Draw(v38, v39)
            end
            u13.Ray:Draw(v39, v40)
        end)(-v19, v20, v21)
        v33(v19, v20, -v21)
        u13.Ray:Draw(u22, u24)
        u13.Ray:Draw(u23, u25)
        if u12 ~= false then
            u13.Ray:Draw(u23, u24)
        end
    end
end
function u1.Create(p41, p42, p43, p44) --[[ Line: 89 ]]
    local v45 = {
        ["Transform"] = p42,
        ["Size"] = p43,
        ["DrawTriangles"] = p44,
        ["AlwaysOnTop"] = p41.Propertys.AlwaysOnTop,
        ["Transparency"] = p41.Propertys.Transparency,
        ["Color3"] = p41.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p41.Retain(p41, v45)
    return v45
end
function u1.Update(p46, p47) --[[ Line: 106 ]]
    local v48 = p46.Ceive
    v48.PushProperty("AlwaysOnTop", p47.AlwaysOnTop)
    v48.PushProperty("Transparency", p47.Transparency)
    v48.PushProperty("Color3", p47.Color3)
    p46:Draw(p47.Transform, p47.Size, p47.DrawTriangles)
end
return u1