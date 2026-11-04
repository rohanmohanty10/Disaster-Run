 

local u1 = require(script:WaitForChild("CatmullRom"))
return {
    ["Make"] = function(_, u2) --[[ Name: Make, Line 7 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v3 = #u2
        if v3 <= 1 then
            return function(_) --[[ Line: 11 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                local v4 = u2[1]
                return v4.X, v4.Y, v4.Z
            end
        end
        if v3 == 2 then
            return function(p5) --[[ Line: 21 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                local v6 = u2[1]
                local v7 = u2[2]
                local v8 = v6.X
                local v9 = v7.X
                local v10 = v8 * (1 - p5) + v9 * p5
                local v11 = v6.Y
                local v12 = v7.Y
                local v13 = v11 * (1 - p5) + v12 * p5
                local v14 = v6.Z
                local v15 = v7.Z
                return v10, v13, v14 * (1 - p5) + v15 * p5
            end
        end
        if v3 == 3 then
            return function(p16) --[[ Line: 36 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                local v17 = u2[1]
                local v18 = u2[2]
                local v19 = u2[3]
                local v20 = v17.X
                local v21 = v18.X
                local v22 = v19.X
                local v23 = (1 - p16) ^ 2 * v20 + 2 * (1 - p16) * p16 * v21 + p16 ^ 2 * v22
                local v24 = v17.Y
                local v25 = v18.Y
                local v26 = v19.Y
                local v27 = (1 - p16) ^ 2 * v24 + 2 * (1 - p16) * p16 * v25 + p16 ^ 2 * v26
                local v28 = v17.Z
                local v29 = v18.Z
                local v30 = v19.Z
                return v23, v27, (1 - p16) ^ 2 * v28 + 2 * (1 - p16) * p16 * v29 + p16 ^ 2 * v30
            end
        end
        if v3 >= 4 then
            local v31 = {}
            for v32, v33 in u2 do
                local v34 = v33.X
                local v35 = v33.Y
                local v36 = v33.Z
                v31[v32] = Vector3.new(v34, v35, v36)
            end
            local u37 = u1.Path.create(v31)
            return function(p38) --[[ Line: 56 ]]
                --[[
                Upvalues:
                    [1] = u37
                --]]
                local v39 = u37.GetPointOnPath(p38)
                return v39.X, v39.Y, v39.Z
            end
        end
    end,
    ["V3"] = function(_, p40, p41, p42) --[[ Name: V3, Line 64 ]]
        return Vector3.new(p40, p41, p42)
    end
}