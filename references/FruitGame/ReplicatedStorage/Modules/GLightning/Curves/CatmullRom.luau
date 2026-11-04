 

local u1 = {}
local u2 = Vector3.new
local u3 = CFrame.new
local function u11(p4, p5, p6, p7, p8) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v9 = p8 * p8
    local v10 = v9 * p8
    return u2((p4[1] + p5[1] * p8 + p6[1] * v9 + p7[1] * v10) / 2, (p4[2] + p5[2] * p8 + p6[2] * v9 + p7[2] * v10) / 2, (p4[3] + p5[3] * p8 + p6[3] * v9 + p7[3] * v10) / 2)
end
function u1.create(p12, p13, p14, p15) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u1
    --]]
    local u16 = { 2 * p13.X, 2 * p13.Y, 2 * p13.Z }
    local u17 = { -p12.X + p14.X, -p12.Y + p14.Y, -p12.Z + p14.Z }
    local u18 = { 2 * p12.X - 5 * p13.X + 4 * p14.X - p15.X, 2 * p12.Y - 5 * p13.Y + 4 * p14.Y - p15.Y, 2 * p12.Z - 5 * p13.Z + 4 * p14.Z - p15.Z }
    local u19 = { -p12.X + 3 * p13.X - 3 * p14.X + p15.X, -p12.Y + 3 * p13.Y - 3 * p14.Y + p15.Y, -p12.Z + 3 * p13.Z - 3 * p14.Z + p15.Z }
    local v24 = {
        ["cA"] = u16,
        ["cB"] = u17,
        ["cC"] = u18,
        ["cD"] = u19,
        ["length"] = (function() --[[ Line: 33 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u16
                [3] = u17
                [4] = u18
                [5] = u19
            --]]
            local v20 = u11(u16, u17, u18, u19, 0)
            local v21 = 0
            for v22 = 0, 0.95, 0.05 do
                local v23 = u11(u16, u17, u18, u19, v22 + 0.05)
                v21 = v21 + (v23 - v20).magnitude
                v20 = v23
            end
            return v21 * 0.05
        end)()
    }
    local v25 = {
        ["__index"] = u1
    }
    return setmetatable(v24, v25)
end
function u1.Solve(p26, p27) --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    return u11(p26.cA, p26.cB, p26.cC, p26.cD, p27)
end
function u1.SolveNorm(p28, p29, p30) --[[ Line: 56 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    return u3(p28:Solve(p29), p28:Solve(p29 + (p30 or 0.01)))
end
local u56 = {
    ["create"] = function(p31) --[[ Name: create, Line 66 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u56
        --]]
        local v32 = #p31 >= 4
        assert(v32, "At least four points are required to construct a spline path")
        local u33 = {}
        local v34 = 0
        local v35 = nil
        local v36 = nil
        local v37 = #p31
        local v38 = p31[1] == p31[v37]
        local v39
        if v38 then
            v39 = u1.create(p31[2]:Lerp(p31[1], 2), p31[1], p31[2], p31[3])
        else
            v39 = u1.create(p31[v37], p31[1], p31[2], p31[3])
        end
        local v40 = v34 + v39.length
        u33[1] = v39
        for v41, v42 in p31 do
            local v43 = p31[v41 + 1]
            if v35 and (v36 and v43) then
                local v44 = u1.create(v35, v36, v42, v43)
                v40 = v40 + v44.length
                u33[#u33 + 1] = v44
            end
            v35 = v36
            v36 = v42
        end
        local v45
        if v38 then
            v45 = u1.create(p31[v37 - 2], p31[v37 - 1], p31[v37], p31[v37 - 1]:Lerp(p31[v37], 2))
        else
            v45 = u1.create(p31[v37 - 2], p31[v37 - 1], p31[v37], p31[1])
        end
        local u46 = v40 + v45.length
        u33[#u33 + 1] = v45
        local v47 = 0
        local u48 = {}
        for v49 = 1, #u33 do
            v47 = v47 + u33[v49].length
            u48[v49] = v47 / u46
        end
        local u50 = #u48
        local v51 = {
            ["__index"] = u56
        }
        return setmetatable({
            ["parts"] = u33,
            ["length"] = u46,
            ["GetPointOnPath"] = function(p52) --[[ Name: GetPointOnPath, Line 113 ]]
                --[[
                Upvalues:
                    [1] = u50
                    [2] = u48
                    [3] = u33
                    [4] = u46
                --]]
                local v53 = nil
                local v54 = nil
                for v55 = 1, u50 do
                    if p52 < u48[v55] or v55 == u50 then
                        v53 = (p52 - (u48[v55 - 1] or 0)) / u33[v55].length * u46
                        v54 = u33[v55]
                        break
                    end
                end
                return v54:Solve(v53)
            end
        }, v51)
    end
}
return {
    ["Spline"] = u1,
    ["Path"] = u56
}