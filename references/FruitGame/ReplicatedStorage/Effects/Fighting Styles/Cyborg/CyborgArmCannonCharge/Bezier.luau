 

local u1 = {}
u1.__index = u1
function u1.new(...) --[[ Line: 125 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local u2 = { ... }
    local v3 = #u2 >= 3
    assert(v3, "Must have at least 3 points")
    local v4 = #u2 == 3
    local v5 = #u2 == 4
    local v6 = {}
    local u7 = Vector3.new
    local u8 = u7().lerp
    local u9 = nil
    local v10 = {}
    local function v16(p11) --[[ Line: 150 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u8
        --]]
        return {
            p11.X,
            p11.Y,
            p11.Z,
            ["ToVector3"] = function(p12) --[[ Name: ToVector3, Line 153 ]]
                --[[
                Upvalues:
                    [1] = u7
                --]]
                return u7(p12[1], p12[2], p12[3])
            end,
            ["lerp"] = function(p13, p14, p15) --[[ Name: lerp, Line 156 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                return u8(p13:ToVector3(), p14:ToVector3(), p15)
            end
        }
    end
    local u17, u18, u19
    if v4 or v5 then
        u17 = v10
        u18 = 0
        u19 = nil
    else
        for v20 = 1, #u2 - 1 do
            local v21 = v16(u2[v20])
            local v22 = { v21, v16(u2[v20 + 1]), (v16(v21)) }
            v10[#v10 + 1] = v22
        end
        u17 = v10
        for v23 = #v10, 2, -1 do
            local v24 = {}
            for v25 = 1, v23 - 1 do
                local v26 = v10[v25]
                local v27 = v10[v25 + 1]
                local v28 = { v26[3], v27[3], (v16(v26[3])) }
                v24[v25] = v28
                u17[#u17 + 1] = v28
            end
            v10 = v24
        end
        u19 = v10[1]
        u18 = #u17
    end
    if v4 then
        local u29 = u2[1]
        local u30 = u2[2]
        local u31 = u2[3]
        function v6.Get(_, p32, p33) --[[ Line: 201 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u30
                [3] = u31
            --]]
            if p33 then
                p32 = p32 < 0 and 0 or (p32 > 1 and 1 or p32)
            end
            return (1 - p32) * (1 - p32) * u29 + 2 * (1 - p32) * p32 * u30 + p32 * p32 * u31
        end
    elseif v5 then
        local u34 = u2[1]
        local u35 = u2[2]
        local u36 = u2[3]
        local u37 = u2[4]
        function v6.Get(_, p38, p39) --[[ Line: 213 ]]
            --[[
            Upvalues:
                [1] = u34
                [2] = u35
                [3] = u36
                [4] = u37
            --]]
            if p39 then
                p38 = p38 < 0 and 0 or (p38 > 1 and 1 or p38)
            end
            return (1 - p38) * (1 - p38) * (1 - p38) * u34 + 3 * (1 - p38) * (1 - p38) * p38 * u35 + 3 * (1 - p38) * p38 * p38 * u36 + p38 * p38 * p38 * u37
        end
    else
        function v6.Get(_, p40, p41) --[[ Line: 222 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u17
                [3] = u19
            --]]
            if p41 then
                p40 = p40 < 0 and 0 or (p40 > 1 and 1 or p40)
            end
            for v42 = 1, u18 do
                local v43 = u17[v42]
                local v44 = v43[1]:lerp(v43[2], p40)
                local v45 = v43[3]
                local v46 = v44.X
                local v47 = v44.Y
                local v48 = v44.Z
                v45[1] = v46
                v45[2] = v47
                v45[3] = v48
            end
            return u19[3]:ToVector3()
        end
    end
    function v6.GetLength(p49, p50) --[[ Line: 240 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        if not u9 then
            local v51 = p49:GetPath(p50 or 0.1)
            local v52 = 0
            for v53 = 2, #v51 do
                v52 = v52 + (v51[v53 - 1] - v51[v53]).Magnitude
            end
            u9 = v52
        end
        return u9
    end
    function v6.GetPath(p54, p55) --[[ Line: 256 ]]
        local v56 = type(p55) == "number"
        assert(v56, "Must provide a step increment")
        local v57
        if p55 > 0 then
            v57 = p55 < 1
        else
            v57 = false
        end
        assert(v57, "Step out of domain; should be between 0 and 1 (exclusive)")
        local v58 = {}
        local v59 = 0
        for v60 = 0, 1, p55 do
            v58[#v58 + 1] = p54:Get(v60)
            v59 = v60
        end
        if v59 < 1 then
            local v61 = 1 - v59 < p55 * 0.5
            v58[#v58 + (v61 and 0 or 1)] = p54:Get(1)
        end
        return v58
    end
    function v6.GetPathByNumberSegments(p62, p63) --[[ Line: 275 ]]
        local v64 = type(p63) == "number"
        assert(v64, "Must provide number of segments")
        local v65 = p63 > 0
        assert(v65, "Number of segments must be greater than 0")
        return p62:GetPath(1 / p63)
    end
    function v6.GetPathBySegmentLength(p66, p67) --[[ Line: 282 ]]
        local v68 = type(p67) == "number"
        assert(v68, "Must provide a segment length")
        local v69 = p67 > 0
        assert(v69, "Segment length must be greater than 0")
        local v70 = p66:GetLength() / p67 + 0.5
        return p66:GetPathByNumberSegments((math.floor(v70)))
    end
    function v6.GetPoints(_) --[[ Line: 292 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        return u2
    end
    local v71 = u1
    return setmetatable(v6, v71)
end
return u1