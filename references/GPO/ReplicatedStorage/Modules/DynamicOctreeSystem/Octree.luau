 

local u1 = require(script.OctreeRegionUtils)
local u2 = require(script.OctreeNode)
local u3 = {
    ["ClassName"] = "Octree"
}
u3.__index = u3
u3.Node = script.OctreeNode
u3.RegionUtils = script.OctreeRegionUtils
function u3.new(p4, p5) --[[ Line: 53 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v6 = u3
    local v7 = setmetatable({}, v6)
    v7._maxRegionSize = p5 and { p5, p5, p5 } or { 512, 512, 512 }
    v7._maxDepth = p4 or 4
    v7._regionHashMap = {}
    return v7
end
function u3.GetAllNodes(p8) --[[ Line: 77 ]]
    local v9 = {}
    for _, v10 in pairs(p8._regionHashMap) do
        for _, v11 in pairs(v10) do
            for v12, _ in pairs(v11.nodes) do
                v9[#v9 + 1] = v12
            end
        end
    end
    return v9
end
function u3.CreateNode(p13, p14, p15) --[[ Line: 106 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v16 = typeof(p14) == "Vector3"
    assert(v16, "Bad position value")
    assert(p15, "Bad object value")
    local v17 = u2.new(p13, p15)
    v17:SetPosition(p14)
    return v17
end
function u3.RadiusSearch(p18, p19, p20) --[[ Line: 132 ]]
    local v21 = typeof(p19) == "Vector3"
    assert(v21, "Bad position")
    local v22 = type(p20) == "number"
    assert(v22, "Bad radius")
    return p18:_radiusSearch(p19.x, p19.y, p19.z, p20)
end
function u3.KNearestNeighborsSearch(p23, p24, p25, p26) --[[ Line: 150 ]]
    local v27 = typeof(p24) == "Vector3"
    assert(v27, "Bad position")
    local v28 = type(p26) == "number"
    assert(v28, "Bad radius")
    local v29, v30 = p23:_radiusSearch(p24.x, p24.y, p24.z, p26)
    local v31 = {}
    for v32, v33 in pairs(v30) do
        table.insert(v31, {
            ["dist2"] = v33,
            ["index"] = v32
        })
    end
    table.sort(v31, function(p34, p35) --[[ Line: 165 ]]
        return p34.dist2 < p35.dist2
    end)
    local v36 = #v31
    local v37 = {}
    local v38 = {}
    for v39 = 1, math.min(v36, p25) do
        local v40 = v31[v39]
        v37[#v37 + 1] = v40.dist2
        v38[#v38 + 1] = v29[v40.index]
    end
    return v38, v37
end
function u3.GetOrCreateLowestSubRegion(p41, p42, p43, p44) --[[ Line: 188 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v45 = p41:_getOrCreateRegion(p42, p43, p44)
    return u1.getOrCreateSubRegionAtDepth(v45, p42, p43, p44, p41._maxDepth)
end
function u3._radiusSearch(p46, p47, p48, p49, p50) --[[ Line: 193 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v51 = p46._maxRegionSize[1]
    local v52 = u1.getSearchRadiusSquared(p50, v51, 1e-9)
    local v53 = {}
    local v54 = {}
    for _, v55 in pairs(p46._regionHashMap) do
        for _, v56 in pairs(v55) do
            local v57 = v56.position
            local v58 = v57[1]
            local v59 = v57[2]
            local v60 = v57[3]
            local v61 = p47 - v58
            local v62 = p48 - v59
            local v63 = p49 - v60
            if v61 * v61 + v62 * v62 + v63 * v63 <= v52 then
                u1.getNeighborsWithinRadius(v56, p50, p47, p48, p49, v53, v54, p46._maxDepth)
            end
        end
    end
    return v53, v54
end
function u3._getRegion(p64, p65, p66, p67) --[[ Line: 217 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1.findRegion(p64._regionHashMap, p64._maxRegionSize, p65, p66, p67)
end
function u3._getOrCreateRegion(p68, p69, p70, p71) --[[ Line: 221 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1.getOrCreateRegion(p68._regionHashMap, p68._maxRegionSize, p69, p70, p71)
end
return u3