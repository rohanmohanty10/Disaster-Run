 

local u1 = {}
u1.__index = u1
function u1.SnapToGrid(p2, p3) --[[ Line: 4 ]]
    return p3 - p3 % p2.CellSize
end
function u1.FillRect(p4, p5, p6, p7, p8, p9) --[[ Line: 7 ]]
    local v10 = typeof(p5) == "Rect"
    assert(v10, "Argument #1 to RectGrid:FillRect must be a Rect datatype")
    local v11 = p6 ~= nil
    assert(v11, "Argument #2 to RectGrid:FillRect cannot be nil")
    local v12 = p8 == nil and true or type(p8) == "number"
    assert(v12, "Argument #3 to \'RectGrid:FillRect\' must be a number")
    local v13 = p9 == nil and true or typeof(p9) == "Vector2"
    assert(v13, "Argument #4 to \'RectGrid:FillRect\' must be a Vector2")
    local v14 = p8 or 0
    local v15 = p5.Min
    local v16 = p5.Max
    local v17 = v15.X
    local v18 = v16.X
    local v19 = v15.Y
    local v20 = v16.Y
    local v21 = v15:lerp(v16, 0.5)
    local v22 = CFrame.new(v21.X, 0, v21.Y)
    local v23 = {}
    if p7 then
        v22 = v22 * CFrame.Angles(0, math.rad(p7), 0) or v22
    end
    __set_list(v23, 1, {v22, (p9 and p9.X or v16.X - v15.X) / 2, (p9 and p9.Y or v16.Y - v15.Y) / 2, v14, p6})
    for v24 = p4:SnapToGrid(v17), p4:SnapToGrid(v18), p4.CellSize do
        for v25 = p4:SnapToGrid(v19), p4:SnapToGrid(v20), p4.CellSize do
            local v26 = v24 * 73856093 + v25 * 19351301
            local v27 = p4.Cells[v26]
            if v27 then
                table.insert(v27, v23)
            else
                p4.Cells[v26] = { v23 }
            end
        end
    end
end
function u1.GetPointData(p28, p29, p30) --[[ Line: 46 ]]
    local v31 = p28.CellSize
    local v32 = p28.Cells[(p29 - p29 % v31) * 73856093 + (p30 - p30 % v31) * 19351301]
    if v32 then
        local v33 = Vector3.new(p29, 0, p30)
        local v34 = (-1 / 0)
        local v35 = nil
        for _, v36 in next, v32 do
            local v37 = v36[1]:PointToObjectSpace(v33)
            if v37.X > -v36[2] and (v37.X < v36[2] and (v37.Z > -v36[3] and (v37.Z < v36[3] and v34 < v36[4]))) then
                v34 = v36[4]
                v35 = v36
            end
        end
        if v35 then
            v35 = v35[5]
        end
        return v35
    end
end
return {
    ["new"] = function(p38) --[[ Name: new, Line 72 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v39 = type(p38) == "number"
        assert(v39, "Argument #1 to RectGrid.new must be cell size")
        local v40 = u1
        return setmetatable({
            ["CellSize"] = p38,
            ["Cells"] = {}
        }, v40)
    end
}