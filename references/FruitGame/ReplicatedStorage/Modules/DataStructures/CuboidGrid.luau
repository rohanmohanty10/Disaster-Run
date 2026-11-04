 

local u1 = {}
u1.__index = u1
function u1.SnapToGrid(p2, p3) --[[ Line: 4 ]]
    return p3 - p3 % p2.CellSize
end
function u1.FillCuboid(p4, p5, p6, p7) --[[ Line: 7 ]]
    local v8
    if type(p5) == "table" then
        v8 = p5.__type == "Cuboid"
    else
        v8 = false
    end
    assert(v8, "Argument #1 to CuboidGrid:FillCuboid must be a Cuboid datatype")
    local v9 = p6 ~= nil
    assert(v9, "Argument #2 to CuboidGrid:FillCuboid cannot be nil")
    local v10 = p7 == nil and true or type(p7) == "number"
    assert(v10, "Argument #3 to CuboidGrid:FillCuboid must be a number")
    local v11 = p5.Min
    local v12 = p5.Max
    local v13 = v11.X
    local v14 = v12.X
    local v15 = v11.Y
    local v16 = v12.Y
    local v17 = v11.Z
    local v18 = v12.Z
    local v19 = {
        v13,
        v15,
        v17,
        v14,
        v16,
        v18,
        p7 or 0,
        p6
    }
    for v20 = p4:SnapToGrid(v13), p4:SnapToGrid(v14), p4.CellSize do
        for v21 = p4:SnapToGrid(v15), p4:SnapToGrid(v16), p4.CellSize do
            for v22 = p4:SnapToGrid(v17), p4:SnapToGrid(v18), p4.CellSize do
                local v23 = v20 * 73856093 + v21 * 19351301 + v22 * 83492791
                local v24 = p4.Cells[v23]
                if v24 then
                    table.insert(v24, v19)
                else
                    p4.Cells[v23] = { v19 }
                end
            end
        end
    end
end
function u1.GetPointData(p25, p26, p27, p28) --[[ Line: 46 ]]
    debug.profilebegin("Get data")
    local v29 = p25.CellSize
    local v30 = p25.Cells[(p26 - p26 % v29) * 73856093 + (p27 - p27 % v29) * 19351301 + (p28 - p28 % v29) * 83492791]
    debug.profileend()
    if v30 then
        debug.profilebegin("Get cuboid")
        local v31 = nil
        local v32 = nil
        for _, v33 in next, v30 do
            if v33[1] <= p26 and (p26 <= v33[4] and (v33[2] <= p27 and (p27 <= v33[5] and (v33[3] <= p28 and (p28 <= v33[6] and (v31 == nil or v32 < v33[7])))))) then
                v32 = v33[7]
                v31 = v33
            end
        end
        debug.profileend()
        if v31 then
            v31 = v31[8]
        end
        return v31
    end
end
return {
    ["new"] = function(p34) --[[ Name: new, Line 74 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v35 = type(p34) == "number"
        assert(v35, "Argument #1 to CuboidGrid.new must be cell size")
        local v36 = u1
        return setmetatable({
            ["CellSize"] = p34,
            ["Cells"] = {}
        }, v36)
    end
}