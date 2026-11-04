 

local u1 = table.insert
local u2 = {}
u2.__index = u2
function u2.CreateNode(p3, p4, p5, p6) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v7 = p4 ~= nil
    assert(v7, "Argument #2 to RectGrid:FillRect cannot be nil")
    local v8 = workspace.CurrentCamera.CFrame.Position
    if (Vector2.new(v8.X, v8.Z) - Vector2.new(p5, p6)).Magnitude ^ 2 > 250000 then
        return
    else
        local v9 = p3.CellSize
        local v10 = p3.Cells
        local v11 = p5 - p5 % v9
        local v12 = p6 - p6 % v9
        local v13 = v11 * 73856093 + v12 * 19351301
        local v14 = { p4, p5, p6 }
        p3.NodePositions[p4] = v13
        local v15 = v10[v13]
        if v15 then
            u1(v15, v14)
        else
            v10[v13] = { v14 }
        end
    end
end
function u2.MoveNode(p16, p17, p18, p19) --[[ Line: 44 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v20 = p16.NodePositions
    local v21 = v20[p17]
    if v21 then
        local v22 = p16.Cells
        local v23 = p16.CellSize
        v22[v21] = nil
        local v24 = { p17, p18, p19 }
        v20[p17] = (p18 - p18 % v23) * 73856093 + (p19 - p19 % v23) * 19351301
        local v25 = v22[v21]
        if v25 then
            u1(v25, v24)
        else
            v22[v21] = { v24 }
        end
    else
        p16:CreateNode(p17, p18, p19)
        return
    end
end
function u2.GetCellNodes(p26, p27, p28) --[[ Line: 74 ]]
    local v29 = p26.CellSize
    return p26.Cells[(p27 - p27 % v29) * 73856093 + (p28 - p28 % v29) * 19351301]
end
function u2.RadiusSearch(p30, p31, p32, p33) --[[ Line: 81 ]]
    local v34 = p30.CellSize
    local v35 = p33 ^ 2
    local v36 = p31 - p33
    local v37 = p31 + p33
    local v38 = p32 - p33
    local v39 = p32 + p33
    local v40 = p30.Cells
    local v41 = {}
    for v42 = v36 - v36 % v34, v37 - v37 % v34, v34 do
        for v43 = v38 - v38 % v34, v39 - v39 % v34, v34 do
            local v44 = v40[v42 * 73856093 + v43 * 19351301]
            if v44 then
                for _, v45 in ipairs(v44) do
                    local v46 = p31 - v45[2]
                    local v47 = p32 - v45[3]
                    if v46 * v46 + v47 * v47 <= v35 then
                        local v48 = v45[1]
                        table.insert(v41, v48)
                    end
                end
            end
        end
    end
    return v41
end
function u2.CleanupFarNodes(p49, p50, p51) --[[ Line: 117 ]]
    local v52 = p51 ^ 2
    local v53 = {}
    local v54 = {}
    for v55, v56 in pairs(p49.Cells) do
        for v57, v58 in ipairs(v56) do
            if v52 < (p50 - Vector2.new(v58[2], v58[3])).Magnitude ^ 2 then
                v53[v58[1]] = true
                table.insert(v54, { v55, v57 })
            end
        end
    end
    for _, v59 in ipairs(v54) do
        local v60, v61 = unpack(v59)
        table.remove(p49.Cells[v60], v61)
        if #p49.Cells[v60] == 0 then
            p49.Cells[v60] = nil
        end
    end
    for v62 in pairs(v53) do
        p49.NodePositions[v62] = nil
    end
end
return {
    ["new"] = function(p63) --[[ Name: new, Line 149 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v64 = type(p63) == "number"
        assert(v64, "Argument #1 to RectGrid.new must be a number")
        local u65 = {
            ["CellSize"] = p63,
            ["Cells"] = {},
            ["NodePositions"] = {}
        }
        local v66 = u2
        setmetatable(u65, v66)
        task.spawn(function() --[[ Line: 159 ]]
            --[[
            Upvalues:
                [1] = u65
            --]]
            local v67 = workspace.CurrentCamera
            while true do
                if v67 then
                    u65:CleanupFarNodes(Vector2.new(v67.CFrame.Position.X, v67.CFrame.Position.Z), 500)
                end
                task.wait(5)
            end
        end)
        return u65
    end
}