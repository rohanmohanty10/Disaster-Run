 

local u1 = require(script.Parent.QuadtreeRegionUtils)
local u2 = {
    ["ClassName"] = "QuadtreeNode"
}
u2.__index = u2
function u2.new(p3, p4) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = {
        ["_quadtree"] = p3 or error("No quadtree"),
        ["_object"] = p4 or error("No object"),
        ["_currentLowestRegion"] = nil,
        ["_position"] = nil
    }
    local v6 = u2
    return setmetatable(v5, v6)
end
function u2.KNearestNeighborsSearch(p7, p8, p9) --[[ Line: 19 ]]
    return p7._quadtree:KNearestNeighborsSearch(p7._position, p8, p9)
end
function u2.GetObject(p10) --[[ Line: 23 ]]
    return p10._object
end
function u2.UpdatePosition(p11, p12) --[[ Line: 27 ]]
    p11:RemoveObject(p12, true)
    p11:AddObject(p12)
end
function u2.RadiusSearch(p13, p14) --[[ Line: 32 ]]
    return p13._quadtree:RadiusSearch(p13._position, p14)
end
function u2.GetPosition(p15) --[[ Line: 36 ]]
    return p15._position
end
function u2.SetPosition(p16, p17) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p16._position == p17 then
        return
    else
        local v18 = p17.X
        local v19 = p17.Y
        p16._px = v18
        p16._py = v19
        p16._position = p17
        local v20 = p16._currentLowestRegion
        if not (v20 and u1.inRegionBounds(v20, v18, v19)) then
            local v21 = p16._quadtree:GetOrCreateLowestSubRegion(v18, v19)
            local v22
            if v20 then
                v22 = v21
                while v20 ~= v21 do
                    local v23 = v20.parent
                    local v24 = v20.node_count
                    v20.nodes[p16] = nil
                    v20.node_count = v24 - 1
                    local v25
                    if v24 <= 1 then
                        v25 = v20.parentIndex
                    else
                        v25 = false
                    end
                    if v25 then
                        v23.subRegions[v25] = nil
                    end
                    v21.nodes[p16] = p16
                    v21.node_count = v21.node_count + 1
                    v21 = v21.parent
                    v20 = v23
                end
            else
                v22 = v21
                while v21 do
                    if not v21.nodes[p16] then
                        v21.nodes[p16] = p16
                        v21.node_count = v21.node_count + 1
                    end
                    v21 = v21.parent
                end
            end
            p16._currentLowestRegion = v22
        end
    end
end
function u2.Destroy(p26) --[[ Line: 112 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v27 = p26._currentLowestRegion
    if v27 then
        u1.removeNode(v27, p26)
    end
end
return u2