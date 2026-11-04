 

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
function u1.Draw(p9, u10, p11, p12) --[[ Line: 16 ]]
    local u13 = p9.Ceive
    if u13.Enabled then
        local v14 = p12 * Vector3.new(1, 1, 0)
        local v15 = CFrame.lookAt(u10, u10 + p11)
        local v16 = v15.UpVector
        local v17 = v15.RightVector
        local v18 = v15.LookVector
        local v19 = v14 * 0.5
        (function(p20, p21, p22) --[[ Name: CalculateZFace, Line 35 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u13
            --]]
            local v23 = u10 + (p20 - p21 + p22)
            local v24 = u10 + (p20 + p21 + p22)
            local v25 = u10 + (-p20 - p21 + p22)
            local v26 = u10 + (-p20 + p21 + p22)
            u13.Ray:Draw(v23, v24)
            u13.Ray:Draw(v23, v25)
            u13.Ray:Draw(v24, v26)
            u13.Ray:Draw(v24, v25)
            u13.Ray:Draw(v25, v26)
        end)(v16 * v19.Y, v17 * v19.X, v18 * v19.Z)
    end
end
function u1.Create(p27, p28, p29, p30) --[[ Line: 53 ]]
    local v31 = {
        ["Position"] = p28,
        ["Normal"] = p29,
        ["Size"] = p30,
        ["AlwaysOnTop"] = p27.Propertys.AlwaysOnTop,
        ["Transparency"] = p27.Propertys.Transparency,
        ["Color3"] = p27.Propertys.Color3,
        ["Enabled"] = true,
        ["Destroy"] = false
    }
    p27.Retain(p27, v31)
    return v31
end
function u1.Update(p32, p33) --[[ Line: 70 ]]
    local v34 = p32.Ceive
    v34.PushProperty("AlwaysOnTop", p33.AlwaysOnTop)
    v34.PushProperty("Transparency", p33.Transparency)
    v34.PushProperty("Color3", p33.Color3)
    p32:Draw(p33.Position, p33.Normal, p33.Size)
end
return u1