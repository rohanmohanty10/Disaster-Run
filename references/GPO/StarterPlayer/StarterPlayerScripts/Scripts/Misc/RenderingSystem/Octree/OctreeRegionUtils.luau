 

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
local u153 = {
    ["visualize"] = function(p2) --[[ Name: visualize, Line 26 ]]
        local v3 = p2.size
        local v4 = p2.position
        local v5 = v3[1]
        local v6 = v3[2]
        local v7 = v3[3]
        local v8 = v4[1]
        local v9 = v4[2]
        local v10 = v4[3]
        local v11 = Draw.box(Vector3.new(v8, v9, v10), (Vector3.new(v5, v6, v7)))
        v11.Transparency = 0.9
        local v12 = p2.depth
        v11.Name = "OctreeRegion_" .. tostring(v12)
        return v11
    end,
    ["create"] = function(p13, p14, p15, p16, p17, p18, p19, p20) --[[ Name: create, Line 39 ]]
        local v21 = p16 / 2
        local v22 = p17 / 2
        local v23 = p18 / 2
        return {
            ["subRegions"] = {},
            ["lowerBounds"] = { p13 - v21, p14 - v22, p15 - v23 },
            ["upperBounds"] = { p13 + v21, p14 + v22, p15 + v23 },
            ["position"] = { p13, p14, p15 },
            ["size"] = { p16, p17, p18 },
            ["parent"] = p19,
            ["depth"] = p19 and p19.depth + 1 or 1,
            ["parentIndex"] = p20,
            ["nodes"] = {},
            ["node_count"] = 0
        }
    end,
    ["addNode"] = function(p24, p25) --[[ Name: addNode, Line 71 ]]
        assert(p25)
        while p24 do
            if not p24.nodes[p25] then
                p24.nodes[p25] = p25
                p24.node_count = p24.node_count + 1
            end
            p24 = p24.parent
        end
    end,
    ["moveNode"] = function(p26, p27, p28) --[[ Name: moveNode, Line 84 ]]
        local v29 = p26.depth == p27.depth
        assert(v29, "fromLowest.depth ~= toLowest.depth")
        local v30 = p26 ~= p27
        assert(v30, "fromLowest == toLowest")
        while p26 ~= p27 do
            local v31 = p26.nodes[p28]
            assert(v31)
            local v32 = p26.node_count > 0
            assert(v32)
            p26.nodes[p28] = nil
            p26.node_count = p26.node_count - 1
            if p26.node_count <= 0 and p26.parentIndex then
                local v33 = p26.parent
                assert(v33)
                local v34 = p26.parent.subRegions[p26.parentIndex] == p26
                assert(v34)
                p26.parent.subRegions[p26.parentIndex] = nil
            end
            local v35 = not p27.nodes[p28]
            assert(v35)
            p27.nodes[p28] = p28
            p27.node_count = p27.node_count + 1
            p26 = p26.parent
            p27 = p27.parent
        end
    end,
    ["removeNode"] = function(p36, p37) --[[ Name: removeNode, Line 119 ]]
        assert(p37)
        while p36 do
            local v38 = p36.nodes[p37]
            assert(v38)
            local v39 = p36.node_count > 0
            assert(v39)
            p36.nodes[p37] = nil
            p36.node_count = p36.node_count - 1
            if p36.node_count <= 0 and p36.parentIndex then
                local v40 = p36.parent
                assert(v40)
                local v41 = p36.parent.subRegions[p36.parentIndex] == p36
                assert(v41)
                p36.parent.subRegions[p36.parentIndex] = nil
            end
            p36 = p36.parent
        end
    end,
    ["getSearchRadiusSquared"] = function(p42, p43, p44) --[[ Name: getSearchRadiusSquared, Line 141 ]]
        local v45 = p42 + 0.8660254037844386 * p43
        return v45 * v45 + p44
    end,
    ["getNeighborsWithinRadius"] = function(p46, p47, p48, p49, p50, p51, p52, p53) --[[ Name: getNeighborsWithinRadius, Line 151 ]]
        --[[
        Upvalues:
            [1] = u153
        --]]
        assert(p53)
        local v54 = p46.size[1] / 2
        local v55 = u153.getSearchRadiusSquared(p47, v54, 1e-6)
        local v56 = p47 * p47
        for _, v57 in p46.subRegions do
            local v58 = v57.position
            local v59 = v58[1]
            local v60 = v58[2]
            local v61 = v58[3]
            local v62 = p48 - v59
            local v63 = p49 - v60
            local v64 = p50 - v61
            if v62 * v62 + v63 * v63 + v64 * v64 <= v55 then
                if v57.depth == p53 then
                    for v65, _ in v57.nodes do
                        local v66, v67, v68 = v65:GetRawPosition()
                        local v69 = p48 - v66
                        local v70 = p49 - v67
                        local v71 = p50 - v68
                        local v72 = v69 * v69 + v70 * v70 + v71 * v71
                        if v72 <= v56 then
                            p51[#p51 + 1] = v65:GetObject()
                            p52[#p52 + 1] = v72
                        end
                    end
                else
                    u153.getNeighborsWithinRadius(v57, p47, p48, p49, p50, p51, p52, p53)
                end
            end
        end
    end,
    ["getOrCreateSubRegionAtDepth"] = function(p73, p74, p75, p76, p77) --[[ Name: getOrCreateSubRegionAtDepth, Line 188 ]]
        --[[
        Upvalues:
            [1] = u153
        --]]
        for _ = p73.depth, p77 do
            local v78 = u153.getSubRegionIndex(p73, p74, p75, p76)
            local v79 = p73.subRegions[v78]
            if not v79 then
                v79 = u153.createSubRegion(p73, v78)
                p73.subRegions[v78] = v79
            end
            p73 = v79
        end
        return p73
    end,
    ["createSubRegion"] = function(p80, p81) --[[ Name: createSubRegion, Line 206 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u153
        --]]
        local v82 = p80.size
        local v83 = p80.position
        local v84 = u1[p81]
        local v85 = v83[1] + v84[1] * v82[1]
        local v86 = v83[2] + v84[2] * v82[2]
        local v87 = v83[3] + v84[3] * v82[3]
        local v88 = v82[1] / 2
        local v89 = v82[2] / 2
        local v90 = v82[3] / 2
        return u153.create(v85, v86, v87, v88, v89, v90, p80, p81)
    end,
    ["inRegionBounds"] = function(p91, p92, p93, p94) --[[ Name: inRegionBounds, Line 220 ]]
        local v95 = p91.lowerBounds
        local v96 = p91.upperBounds
        local v97
        if v95[1] <= p92 and (p92 <= v96[1] and (v95[2] <= p93 and (p93 <= v96[2] and v95[3] <= p94))) then
            v97 = p94 <= v96[3]
        else
            v97 = false
        end
        return v97
    end,
    ["getSubRegionIndex"] = function(p98, p99, p100, p101) --[[ Name: getSubRegionIndex, Line 230 ]]
        local v102 = p98.position[1] < p99 and 1 or 2
        if p100 <= p98.position[2] then
            v102 = v102 + 4
        end
        if p98.position[3] <= p101 then
            v102 = v102 + 2
        end
        return v102
    end,
    ["getTopLevelRegionHash"] = function(p103, p104, p105) --[[ Name: getTopLevelRegionHash, Line 244 ]]
        return p103 * 73856093 + p104 * 19351301 + p105 * 83492791
    end,
    ["getTopLevelRegionCellIndex"] = function(p106, p107, p108, p109) --[[ Name: getTopLevelRegionCellIndex, Line 249 ]]
        local v110 = p107 / p106[1] + 0.5
        local v111 = math.floor(v110)
        local v112 = p108 / p106[2] + 0.5
        local v113 = math.floor(v112)
        local v114 = p109 / p106[3] + 0.5
        return v111, v113, math.floor(v114)
    end,
    ["getTopLevelRegionPosition"] = function(p115, p116, p117, p118) --[[ Name: getTopLevelRegionPosition, Line 255 ]]
        return p115[1] * p116, p115[2] * p117, p115[3] * p118
    end,
    ["areEqualTopRegions"] = function(p119, p120, p121, p122) --[[ Name: areEqualTopRegions, Line 261 ]]
        local v123 = p119.position
        local v124
        if v123[1] == p120 and v123[2] == p121 then
            v124 = v123[3] == p122
        else
            v124 = false
        end
        return v124
    end,
    ["findRegion"] = function(p125, p126, p127, p128, p129) --[[ Name: findRegion, Line 268 ]]
        --[[
        Upvalues:
            [1] = u153
        --]]
        local v130, v131, v132 = u153.getTopLevelRegionCellIndex(p126, p127, p128, p129)
        local v133 = p125[u153.getTopLevelRegionHash(v130, v131, v132)]
        if not v133 then
            return nil
        end
        local v134, v135, v136 = u153.getTopLevelRegionPosition(p126, v130, v131, v132)
        for _, v137 in v133 do
            if u153.areEqualTopRegions(v137, v134, v135, v136) then
                return v137
            end
        end
        return nil
    end,
    ["getOrCreateRegion"] = function(p138, p139, p140, p141, p142) --[[ Name: getOrCreateRegion, Line 287 ]]
        --[[
        Upvalues:
            [1] = u153
        --]]
        local v143, v144, v145 = u153.getTopLevelRegionCellIndex(p139, p140, p141, p142)
        local v146 = u153.getTopLevelRegionHash(v143, v144, v145)
        local v147 = p138[v146]
        if not v147 then
            v147 = {}
            p138[v146] = v147
        end
        local v148, v149, v150 = u153.getTopLevelRegionPosition(p139, v143, v144, v145)
        for _, v151 in v147 do
            if u153.areEqualTopRegions(v151, v148, v149, v150) then
                return v151
            end
        end
        local v152 = u153.create(v148, v149, v150, p139[1], p139[2], p139[3])
        table.insert(v147, v152)
        return v152
    end
}
return u153