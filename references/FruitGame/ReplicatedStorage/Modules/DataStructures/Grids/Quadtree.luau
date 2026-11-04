 

local u1 = require(script.QuadtreeRegionUtils)
local u2 = require(script.QuadtreeNode)
local u3 = {
    ["ClassName"] = "Quadtree"
}
u3.__index = u3
function u3.new() --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v4 = u3
    return setmetatable({
        ["_maxRegionSize"] = { 512, 512 },
        ["_maxDepth"] = 4,
        ["_regionHashMap"] = {}
    }, v4)
end
function u3.ClearNodes(p5) --[[ Line: 19 ]]
    p5._maxRegionSize = { 512, 512 }
    p5._maxDepth = 4
    table.clear(p5._regionHashMap)
end
function u3.GetAllNodes(p6) --[[ Line: 25 ]]
    local v7 = {}
    for _, v8 in pairs(p6._regionHashMap) do
        for _, v9 in pairs(v8) do
            for v10 in pairs(v9.nodes) do
                table.insert(v7, v10)
            end
        end
    end
    return v7
end
function u3.CreateNode(p11, p12, p13) --[[ Line: 39 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v14 = typeof(p12) == "Vector2"
    assert(v14, "Bad position value")
    assert(p13, "Bad object value")
    local v15 = u2.new(p11, p13)
    v15:SetPosition(p12)
    return v15
end
function u3.RadiusSearch(p16, p17, p18) --[[ Line: 50 ]]
    local v19 = typeof(p17) == "Vector2"
    local v20 = assert(v19)
    if v20 then
        v20 = p17.X
    end
    local v21 = p17.Y
    local v22 = type(p18) == "number"
    return p16:_radiusSearch(v20, v21, assert(v22) and p18)
end
function u3.KNearestNeighborsSearch(p23, p24, p25, p26) --[[ Line: 54 ]]
    local v27 = typeof(p24) == "Vector2"
    assert(v27)
    local v28 = type(p26) == "number"
    assert(v28)
    local v29, v30 = p23:_radiusSearch(p24.X, p24.Y, p26)
    local v31 = {}
    for v32, v33 in pairs(v30) do
        table.insert(v31, {
            ["dist2"] = v33,
            ["index"] = v32
        })
    end
    table.sort(v31, function(p34, p35) --[[ Line: 68 ]]
        return p34.dist2 < p35.dist2
    end)
    local v36 = #v31
    local v37 = {}
    local v38 = {}
    for v39 = 1, math.min(v36, p25) do
        local v40 = v31[v39]
        local v41 = v40.dist2
        table.insert(v37, v41)
        local v42 = v29[v40.index]
        table.insert(v38, v42)
    end
    return v38, v37
end
function u3.GetOrCreateLowestSubRegion(p43, p44, p45) --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1.getOrCreateSubRegionAtDepth(p43:_getOrCreateRegion(p44, p45), p44, p45, p43._maxDepth)
end
function u3._radiusSearch(p46, p47, p48, p49) --[[ Line: 87 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v50 = p46._maxDepth
    local v51 = (p49 + 0.8660254037844386 * p46._maxRegionSize[1]) ^ 2 + 1e-9
    local v52 = {}
    local v53 = {}
    for _, v54 in pairs(p46._regionHashMap) do
        for _, v55 in pairs(v54) do
            local v56 = v55.position
            if (p47 - v56[1]) ^ 2 + (p48 - v56[2]) ^ 2 <= v51 then
                u1.getNeighborsWithinRadius(v55, p49, p47, p48, v52, v53, v50)
            end
        end
    end
    return v52, v53
end
function u3._getRegion(p57, p58, p59) --[[ Line: 107 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1.findRegion(p57._regionHashMap, p57._maxRegionSize, p58, p59)
end
function u3._getOrCreateRegion(p60, p61, p62) --[[ Line: 111 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1.getOrCreateRegion(p60._regionHashMap, p60._maxRegionSize, p61, p62)
end
return u3