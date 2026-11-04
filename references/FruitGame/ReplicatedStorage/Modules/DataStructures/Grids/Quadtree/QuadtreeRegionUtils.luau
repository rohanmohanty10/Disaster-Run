 

local u1 = table.insert
local u2 = {
    { 0.25, 0.25 },
    { -0.25, 0.25 },
    { 0.25, 0.25 },
    { -0.25, 0.25 },
    { 0.25, -0.25 },
    { -0.25, -0.25 },
    { 0.25, -0.25 },
    { -0.25, -0.25 }
}
local u85 = {
    ["create"] = function(p3, p4, p5, p6, p7, p8) --[[ Name: create, Line 21 ]]
        local v9 = p5 / 2
        local v10 = p6 / 2
        return {
            ["subRegions"] = {},
            ["lowerBounds"] = { p3 - v9, p4 - v10 },
            ["upperBounds"] = { p3 + v9, p4 + v10 },
            ["position"] = { p3, p4 },
            ["size"] = { p5, p6 },
            ["parent"] = p7,
            ["depth"] = p7 and p7.depth + 1 or 1,
            ["parentIndex"] = p8,
            ["nodes"] = {},
            ["node_count"] = 0
        }
    end,
    ["removeNode"] = function(p11, p12) --[[ Name: removeNode, Line 53 ]]
        assert(p12)
        while p11 do
            local v13 = p11.nodes
            local v14 = v13[p12]
            assert(v14)
            local v15 = p11.node_count - 1
            local v16 = v15 > 1
            assert(v16)
            v13[p12] = nil
            p11.node_count = v15
            local v17 = p11.parent
            local v18 = p11.parentIndex
            if v15 <= 0 and v18 then
                assert(v17)
                local v19 = v17.subRegions[v18] == p11
                assert(v19)
                v17.subRegions[v18] = nil
                p11 = v17
            else
                p11 = v17
            end
        end
    end,
    ["getNeighborsWithinRadius"] = function(p20, p21, p22, p23, p24, p25, p26) --[[ Name: getNeighborsWithinRadius, Line 84 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u85
        --]]
        local v27 = (p21 + 0.8660254037844386 * p20.size[1] / 2) ^ 2 + 1e-6
        local v28 = p21 * p21
        for _, v29 in pairs(p20.subRegions) do
            local v30 = v29.position
            if (p22 - v30[1]) ^ 2 + (p23 - v30[2]) ^ 2 <= v27 then
                if v29.depth == p26 then
                    for v31 in pairs(v29.nodes) do
                        local v32 = (p22 - v31._px) ^ 2 + (p23 - v31._py) ^ 2
                        if v32 <= v28 then
                            u1(p24, v31._object)
                            u1(p25, v32)
                        end
                    end
                else
                    u85.getNeighborsWithinRadius(v29, p21, p22, p23, p24, p25, p26)
                end
            end
        end
    end,
    ["getOrCreateSubRegionAtDepth"] = function(p33, p34, p35, p36) --[[ Name: getOrCreateSubRegionAtDepth, Line 110 ]]
        --[[
        Upvalues:
            [1] = u85
        --]]
        for _ = p33.depth, p36 do
            local v37 = p33.position
            local v38 = (v37[1] < p34 and 1 or 2) + (p35 <= v37[2] and 4 or 0)
            local v39 = p33.subRegions[v38]
            if not v39 then
                v39 = u85.createSubRegion(p33, v38)
                p33.subRegions[v38] = v39
            end
            p33 = v39
        end
        return p33
    end,
    ["createSubRegion"] = function(p40, p41) --[[ Name: createSubRegion, Line 130 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u85
        --]]
        local v42 = p40.size
        local v43 = p40.position
        local v44 = u2[p41]
        return u85.create(v43[1] + v44[1] * v42[1], v43[2] + v44[2] * v42[2], v42[1] / 2, v42[2] / 2, p40, p41)
    end,
    ["inRegionBounds"] = function(p45, p46, p47) --[[ Name: inRegionBounds, Line 147 ]]
        local v48 = p45.lowerBounds
        local v49 = p45.upperBounds
        local v50
        if v48[1] <= p46 and (p46 <= v49[1] and v48[2] <= p47) then
            v50 = p47 <= v49[2]
        else
            v50 = false
        end
        return v50
    end,
    ["getSubRegionIndex"] = function(p51, p52, p53) --[[ Name: getSubRegionIndex, Line 154 ]]
        local v54 = p51.position
        return (v54[1] < p52 and 1 or 2) + (p53 <= v54[2] and 4 or 0)
    end,
    ["findRegion"] = function(p55, p56, p57, p58) --[[ Name: findRegion, Line 166 ]]
        local v59 = p56[1]
        local v60 = p56[2]
        local v61 = p57 / v59 + 0.5
        local v62 = math.floor(v61)
        local v63 = p58 / v60 + 0.5
        local v64 = math.floor(v63)
        local v65 = p55[v62 * 73856093 + v64 * 19351301]
        if not v65 then
            return nil
        end
        local v66 = v59 * v62
        local v67 = v60 * v64
        for _, v68 in pairs(v65) do
            local v69 = v68.position
            if v69[1] == v66 and v69[2] == v67 then
                return v68
            end
        end
        return nil
    end,
    ["getOrCreateRegion"] = function(p70, p71, p72, p73) --[[ Name: getOrCreateRegion, Line 190 ]]
        --[[
        Upvalues:
            [1] = u85
        --]]
        local v74 = p72 / p71[1] + 0.5
        local v75 = math.floor(v74)
        local v76 = p73 / p71[2] + 0.5
        local v77 = math.floor(v76)
        local v78 = v75 * 73856093 + v77 * 19351301
        local v79 = p70[v78]
        if not v79 then
            v79 = {}
            p70[v78] = v79
        end
        local v80 = p71[1] * v75
        local v81 = p71[2] * v77
        for _, v82 in pairs(v79) do
            local v83 = v82.position
            if v83[1] == v80 and v83[2] == v81 then
                return v82
            end
        end
        local v84 = u85.create(v80, v81, p71[1], p71[2])
        table.insert(v79, v84)
        return v84
    end
}
return u85