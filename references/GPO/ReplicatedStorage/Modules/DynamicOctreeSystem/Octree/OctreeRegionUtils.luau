 

local u1 = {
    { 0.25, 0.25, -0.25 },
    { -0.25, 0.25, -0.25 },
    { 0.25, 0.25, 0.25 },
    { -0.25, 0.25, 0.25 },
    { 0.25, -0.25, -0.25 },
    { -0.25, -0.25, -0.25 },
    { 0.25, -0.25, 0.25 },
    { -0.25, -0.25, 0.25 }
}
local u142 = {
    ["visualize"] = function(_, _, _, _) --[[ Name: visualize, Line 31 ]]
        return nil
    end,
    ["create"] = function(p2, p3, p4, p5, p6, p7, p8, p9) --[[ Name: create, Line 75 ]]
        local v10 = p5 / 2
        local v11 = p6 / 2
        local v12 = p7 / 2
        return {
            ["subRegions"] = {},
            ["lowerBounds"] = { p2 - v10, p3 - v11, p4 - v12 },
            ["upperBounds"] = { p2 + v10, p3 + v11, p4 + v12 },
            ["position"] = { p2, p3, p4 },
            ["size"] = { p5, p6, p7 },
            ["parent"] = p8,
            ["depth"] = p8 and p8.depth + 1 or 1,
            ["parentIndex"] = p9,
            ["nodes"] = {},
            ["node_count"] = 0
        }
    end,
    ["addNode"] = function(p13, p14) --[[ Name: addNode, Line 126 ]]
        assert(p14, "Bad node")
        while p13 do
            if not p13.nodes[p14] then
                p13.nodes[p14] = p14
                p13.node_count = p13.node_count + 1
            end
            p13 = p13.parent
        end
    end,
    ["moveNode"] = function(p15, p16, p17) --[[ Name: moveNode, Line 146 ]]
        local v18 = p15.depth == p16.depth
        assert(v18, "fromLowest.depth ~= toLowest.depth")
        local v19 = p15 ~= p16
        assert(v19, "fromLowest == toLowest")
        while p15 ~= p16 do
            local v20 = p15.nodes[p17]
            assert(v20, "Not in currentFrom")
            local v21 = p15.node_count > 0
            assert(v21, "No nodes in currentFrom")
            p15.nodes[p17] = nil
            p15.node_count = p15.node_count - 1
            if p15.node_count <= 0 and p15.parentIndex then
                local v22 = p15.parent
                assert(v22, "Bad currentFrom.parent")
                local v23 = p15.parent.subRegions[p15.parentIndex] == p15
                assert(v23, "Not in subregion")
                p15.parent.subRegions[p15.parentIndex] = nil
            end
            local v24 = not p16.nodes[p17]
            assert(v24, "Failed to add")
            p16.nodes[p17] = p17
            p16.node_count = p16.node_count + 1
            p15 = p15.parent
            p16 = p16.parent
        end
    end,
    ["removeNode"] = function(p25, p26) --[[ Name: removeNode, Line 187 ]]
        assert(p26, "Bad node")
        while p25 do
            local v27 = p25.nodes[p26]
            assert(v27, "Not in current")
            local v28 = p25.node_count > 0
            assert(v28, "Current has bad node count")
            p25.nodes[p26] = nil
            p25.node_count = p25.node_count - 1
            if p25.node_count <= 0 and p25.parentIndex then
                local v29 = p25.parent
                assert(v29, "No parent")
                local v30 = p25.parent.subRegions[p25.parentIndex] == p25
                assert(v30, "Not in subregion")
                p25.parent.subRegions[p25.parentIndex] = nil
            end
            p25 = p25.parent
        end
    end,
    ["getSearchRadiusSquared"] = function(p31, p32, p33) --[[ Name: getSearchRadiusSquared, Line 219 ]]
        local v34 = p31 + 0.8660254037844386 * p32
        return v34 * v34 + p33
    end,
    ["getNeighborsWithinRadius"] = function(p35, p36, p37, p38, p39, p40, p41, p42) --[[ Name: getNeighborsWithinRadius, Line 241 ]]
        --[[
        Upvalues:
            [1] = u142
        --]]
        assert(p42, "Bad maxDepth")
        local v43 = p35.size[1] / 2
        local v44 = u142.getSearchRadiusSquared(p36, v43, 1e-6)
        local v45 = p36 * p36
        for _, v46 in pairs(p35.subRegions) do
            local v47 = v46.position
            local v48 = v47[1]
            local v49 = v47[2]
            local v50 = v47[3]
            local v51 = p37 - v48
            local v52 = p38 - v49
            local v53 = p39 - v50
            if v51 * v51 + v52 * v52 + v53 * v53 <= v44 then
                if v46.depth == p42 then
                    for v54, _ in pairs(v46.nodes) do
                        local v55, v56, v57 = v54:GetRawPosition()
                        local v58 = p37 - v55
                        local v59 = p38 - v56
                        local v60 = p39 - v57
                        local v61 = v58 * v58 + v59 * v59 + v60 * v60
                        if v61 <= v45 then
                            p40[#p40 + 1] = v54:GetObject()
                            p41[#p41 + 1] = v61
                        end
                    end
                else
                    u142.getNeighborsWithinRadius(v46, p36, p37, p38, p39, p40, p41, p42)
                end
            end
        end
    end,
    ["getOrCreateSubRegionAtDepth"] = function(p62, p63, p64, p65, p66) --[[ Name: getOrCreateSubRegionAtDepth, Line 289 ]]
        --[[
        Upvalues:
            [1] = u142
        --]]
        for _ = p62.depth, p66 do
            local v67 = u142.getSubRegionIndex(p62, p63, p64, p65)
            local v68 = p62.subRegions[v67]
            if not v68 then
                v68 = u142.createSubRegion(p62, v67)
                p62.subRegions[v67] = v68
            end
            p62 = v68
        end
        return p62
    end,
    ["createSubRegion"] = function(p69, p70) --[[ Name: createSubRegion, Line 313 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u142
        --]]
        local v71 = p69.size
        local v72 = p69.position
        local v73 = u1[p70]
        local v74 = v72[1] + v73[1] * v71[1]
        local v75 = v72[2] + v73[2] * v71[2]
        local v76 = v72[3] + v73[3] * v71[3]
        local v77 = v71[1] / 2
        local v78 = v71[2] / 2
        local v79 = v71[3] / 2
        return u142.create(v74, v75, v76, v77, v78, v79, p69, p70)
    end,
    ["inRegionBounds"] = function(p80, p81, p82, p83) --[[ Name: inRegionBounds, Line 337 ]]
        local v84 = p80.lowerBounds
        local v85 = p80.upperBounds
        local v86
        if v84[1] <= p81 and (p81 <= v85[1] and (v84[2] <= p82 and (p82 <= v85[2] and v84[3] <= p83))) then
            v86 = p83 <= v85[3]
        else
            v86 = false
        end
        return v86
    end,
    ["getSubRegionIndex"] = function(p87, p88, p89, p90) --[[ Name: getSubRegionIndex, Line 356 ]]
        local v91 = p87.position[1] < p88 and 1 or 2
        if p89 <= p87.position[2] then
            v91 = v91 + 4
        end
        if p87.position[3] <= p90 then
            v91 = v91 + 2
        end
        return v91
    end,
    ["getTopLevelRegionHash"] = function(p92, p93, p94) --[[ Name: getTopLevelRegionHash, Line 378 ]]
        return p92 * 73856093 + p93 * 19351301 + p94 * 83492791
    end,
    ["getTopLevelRegionCellIndex"] = function(p95, p96, p97, p98) --[[ Name: getTopLevelRegionCellIndex, Line 394 ]]
        local v99 = p96 / p95[1] + 0.5
        local v100 = math.floor(v99)
        local v101 = p97 / p95[2] + 0.5
        local v102 = math.floor(v101)
        local v103 = p98 / p95[3] + 0.5
        return v100, v102, math.floor(v103)
    end,
    ["getTopLevelRegionPosition"] = function(p104, p105, p106, p107) --[[ Name: getTopLevelRegionPosition, Line 411 ]]
        return p104[1] * p105, p104[2] * p106, p104[3] * p107
    end,
    ["areEqualTopRegions"] = function(p108, p109, p110, p111) --[[ Name: areEqualTopRegions, Line 427 ]]
        local v112 = p108.position
        local v113
        if v112[1] == p109 and v112[2] == p110 then
            v113 = v112[3] == p111
        else
            v113 = false
        end
        return v113
    end,
    ["findRegion"] = function(p114, p115, p116, p117, p118) --[[ Name: findRegion, Line 444 ]]
        --[[
        Upvalues:
            [1] = u142
        --]]
        local v119, v120, v121 = u142.getTopLevelRegionCellIndex(p115, p116, p117, p118)
        local v122 = p114[u142.getTopLevelRegionHash(v119, v120, v121)]
        if not v122 then
            return nil
        end
        local v123, v124, v125 = u142.getTopLevelRegionPosition(p115, v119, v120, v121)
        for _, v126 in pairs(v122) do
            if u142.areEqualTopRegions(v126, v123, v124, v125) then
                return v126
            end
        end
        return nil
    end,
    ["getOrCreateRegion"] = function(p127, p128, p129, p130, p131) --[[ Name: getOrCreateRegion, Line 473 ]]
        --[[
        Upvalues:
            [1] = u142
        --]]
        local v132, v133, v134 = u142.getTopLevelRegionCellIndex(p128, p129, p130, p131)
        local v135 = u142.getTopLevelRegionHash(v132, v133, v134)
        local v136 = p127[v135]
        if not v136 then
            v136 = {}
            p127[v135] = v136
        end
        local v137, v138, v139 = u142.getTopLevelRegionPosition(p128, v132, v133, v134)
        for _, v140 in pairs(v136) do
            if u142.areEqualTopRegions(v140, v137, v138, v139) then
                return v140
            end
        end
        local v141 = u142.create(v137, v138, v139, p128[1], p128[2], p128[3])
        table.insert(v136, v141)
        return v141
    end
}
return u142