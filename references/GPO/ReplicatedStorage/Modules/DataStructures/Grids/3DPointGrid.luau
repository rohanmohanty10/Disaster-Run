 

local u1 = table.insert
local u2 = {}
u2.__index = u2
function u2.CreateNode(p3, p4, p5, p6, p7) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v8 = p4 ~= nil
    assert(v8, "Argument #2 to RectGrid:FillRect cannot be nil")
    local v9 = p3.CellSize
    local v10 = p3.Cells
    local v11 = (p5 - p5 % v9) * 73856093 + (p6 - p6 % v9) * 19351301 + (p7 - p7 % v9) * 83492791
    local v12 = {
        p4,
        p5,
        p6,
        p7
    }
    p3.NodePositions[p4] = v11
    local v13 = v10[v11]
    if v13 then
        u1(v13, v12)
    else
        v10[v11] = { v12 }
    end
end
function u2.MoveNode(p14, p15, p16, p17, p18) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v19 = p14.NodePositions
    local v20 = v19[p15]
    if v20 then
        local v21 = p14.Cells
        local v22 = p14.CellSize
        v21[v20] = nil
        local v23 = { p15, p16, p17 }
        v19[p15] = (p16 - p16 % v22) * 73856093 + (p17 - p17 % v22) * 19351301 + (p18 - p18 % v22) * 83492791
        local v24 = v21[v20]
        if not v24 then
            v21[v20] = { v23 }
            return
        end
        u1(v24, v23)
    end
end
function u2.GetCellNodes(p25, p26, p27, p28) --[[ Line: 56 ]]
    local v29 = p25.CellSize
    return p25.Cells[(p26 - p26 % v29) * 73856093 + (p27 - p27 % v29) * 19351301 + (p28 - p28 % v29) * 83492791]
end
function u2.RadiusSearch(p30, p31, p32) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v33 = p31.X
    local v34 = p31.Y
    local v35 = p31.Z
    local v36 = p30.CellSize
    local v37 = p32 ^ 2
    local v38 = v33 - p32
    local v39 = v33 + p32
    local v40 = v34 - p32
    local v41 = v34 + p32
    local v42 = v35 - p32
    local v43 = v35 + p32
    local v44 = {}
    for v45 = v38 - v38 % v36, v39 - v39 % v36, v36 do
        for v46 = v40 - v40 % v36, v41 - v41 % v36, v36 do
            for v47 = v42 - v42 % v36, v43 - v43 % v36, v36 do
                local v48 = p30.Cells[v45 * 73856093 + v46 * 19351301 + v47 * 83492791]
                if v48 then
                    for _, v49 in ipairs(v48) do
                        if (v33 - v49[2]) ^ 2 + (v34 - v49[3]) ^ 2 + (v35 - v49[4]) ^ 2 <= v37 then
                            u1(v44, v49[1])
                        end
                    end
                end
            end
        end
    end
    return v44
end
function u2.Cleanup(p50) --[[ Line: 90 ]]
    table.clear(p50.Cells)
    table.clear(p50.NodePositions)
end
return {
    ["new"] = function(p51) --[[ Name: new, Line 96 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v52 = type(p51) == "number"
        assert(v52, "Argument #1 to RectGrid.new must be a number")
        local v53 = u2
        return setmetatable({
            ["CellSize"] = p51,
            ["Cells"] = {},
            ["NodePositions"] = {}
        }, v53)
    end
}