 

local u1 = {}
u1.__index = u1
function u1.Init(p2, p3, p4, p5, p6) --[[ Line: 8 ]]
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
function u1.Draw(p9, p10, p11, p12, p13) --[[ Line: 20 ]]
    local v14 = p9.Ceive
    if v14.Enabled then
        local v15 = (-1 / 0)
        local v16 = (-1 / 0)
        local v17 = (-1 / 0)
        local v18 = (1 / 0)
        local v19 = (1 / 0)
        local v20 = (1 / 0)
        for _, v21 in p12 do
            local v22 = v21.x
            v15 = math.max(v15, v22)
            local v23 = v21.y
            v16 = math.max(v16, v23)
            local v24 = v21.z
            v17 = math.max(v17, v24)
            local v25 = v21.x
            v18 = math.min(v18, v25)
            local v26 = v21.y
            v19 = math.min(v19, v26)
            local v27 = v21.z
            v20 = math.min(v20, v27)
        end
        for v28, v29 in p12 do
            local v30 = (v29.x - v18) / (v15 - v18) * 1 + -0.5
            local v31 = (v29.y - v19) / (v16 - v19) * 1 + -0.5
            local v32 = (v29.z - v20) / (v17 - v20) * 1 + -0.5
            p12[v28] = p10 * CFrame.new(Vector3.new(v30, v31, v32) * p11)
        end
        for _, v33 in p13 do
            if #v33 == 3 then
                local v34 = p12[v33[1].v]
                local v35 = p12[v33[2].v]
                local v36 = p12[v33[3].v]
                v14.Ray:Draw(v34.Position, v35.Position)
                v14.Ray:Draw(v35.Position, v36.Position)
                v14.Ray:Draw(v36.Position, v34.Position)
            else
                local v37 = p12[v33[1].v]
                local v38 = p12[v33[2].v]
                local v39 = p12[v33[3].v]
                local v40 = p12[v33[4].v]
                v14.Ray:Draw(v37.Position, v38.Position)
                v14.Ray:Draw(v37.Position, v40.Position)
                v14.Ray:Draw(v40.Position, v38.Position)
                v14.Ray:Draw(v39.Position, v40.Position)
                v14.Ray:Draw(v38.Position, v39.Position)
            end
        end
    end
end
function u1.Create(p41, p42, p43, p44, p45) --[[ Line: 79 ]]
    local v46 = {
        ["Transform"] = p42,
        ["Size"] = p43,
        ["Vertices"] = p44,
        ["Faces"] = p45,
        ["AlwaysOnTop"] = p41.Propertys.AlwaysOnTop,
        ["Transparency"] = p41.Propertys.Transparency,
        ["Color3"] = p41.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p41.Retain(p41, v46)
    return v46
end
function u1.Update(p47, p48) --[[ Line: 97 ]]
    local v49 = p47.Ceive
    v49.PushProperty("AlwaysOnTop", p48.AlwaysOnTop)
    v49.PushProperty("Transparency", p48.Transparency)
    v49.PushProperty("Color3", p48.Color3)
    p47:Draw(p48.Transform, p48.Size, p48.Vertices, p48.Faces)
end
return u1