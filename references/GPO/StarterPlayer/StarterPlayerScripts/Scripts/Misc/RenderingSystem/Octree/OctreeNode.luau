 

local u1 = require(script.Parent.OctreeRegionUtils)
local u2 = {
    ["ClassName"] = "OctreeNode"
}
u2.__index = u2
function u2.new(p3, p4) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = u2
    local v6 = setmetatable({}, v5)
    v6._octree = p3 or error("No octree")
    v6._object = p4 or error("No object")
    v6._currentLowestRegion = nil
    v6._position = nil
    return v6
end
function u2.KNearestNeighborsSearch(p7, p8, p9) --[[ Line: 26 ]]
    return p7._octree:KNearestNeighborsSearch(p7._position, p8, p9)
end
function u2.GetObject(p10) --[[ Line: 30 ]]
    return p10._object
end
function u2.RadiusSearch(p11, p12) --[[ Line: 34 ]]
    return p11._octree:RadiusSearch(p11._position, p12)
end
function u2.GetPosition(p13) --[[ Line: 38 ]]
    return p13._position
end
function u2.GetRawPosition(p14) --[[ Line: 42 ]]
    return p14._px, p14._py, p14._pz
end
function u2.SetPosition(p15, p16) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p15._position == p16 then
        return
    else
        local v17 = p16.x
        local v18 = p16.y
        local v19 = p16.z
        p15._px = v17
        p15._py = v18
        p15._pz = v19
        p15._position = p16
        if not (p15._currentLowestRegion and u1.inRegionBounds(p15._currentLowestRegion, v17, v18, v19)) then
            local v20 = p15._octree:GetOrCreateLowestSubRegion(v17, v18, v19)
            if p15._currentLowestRegion then
                u1.moveNode(p15._currentLowestRegion, v20, p15)
            else
                u1.addNode(v20, p15)
            end
            p15._currentLowestRegion = v20
        end
    end
end
function u2.Destroy(p21) --[[ Line: 80 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p21._currentLowestRegion then
        u1.removeNode(p21._currentLowestRegion, p21)
    end
end
return u2