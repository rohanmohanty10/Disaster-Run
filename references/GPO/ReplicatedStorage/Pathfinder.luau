 

local v1 = {}
local u2 = nil
function BuildNodes()
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v3 = game:GetService("ServerStorage").NodeMapProjects:FindFirstChild("Town")
    local v4 = {}
    local v5 = {}
    for _, v6 in v3:GetChildren() do
        if v6:IsA("Folder") then
            local v7 = {
                ["Position"] = v6:GetAttribute("NodePosition"),
                ["Neighbors"] = {},
                ["F"] = 0,
                ["G"] = 0,
                ["H"] = 0,
                ["Parent"] = nil
            }
            table.insert(v4, v7)
            v5[v6:GetAttribute("NodeId")] = v7
        end
    end
    for _, v8 in v3:GetChildren() do
        if v8:IsA("Folder") then
            local v9 = v8:GetAttribute("NodeLinks"):split(",")
            local v10 = v5[v8:GetAttribute("NodeId")]
            for _, v11 in v9 do
                local v12 = v5[v11]
                local v13 = v10.Neighbors
                table.insert(v13, v12)
                local v14 = v12.Neighbors
                table.insert(v14, v10)
            end
        end
    end
    u2 = v4
end
function FindNearestNode(p15)
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v16 = (1 / 0)
    local v17 = nil
    for _, v18 in u2 do
        local v19 = (p15 - v18.Position).Magnitude
        if v19 < v16 then
            v17 = v18
            v16 = v19
        end
    end
    return v17
end
function v1.FindPath(p20, p21, p22) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if not u2 then
        p20:Init()
    end
    local v23 = FindNearestNode(p21)
    local v24 = FindNearestNode(p22)
    local v25 = {
        [v23] = true
    }
    local v26 = {}
    local v27 = false
    local v28 = {}
    while next(v25) do
        local v29 = (1 / 0)
        local v30 = nil
        for v31 in v25 do
            if v31.F < v29 then
                v29 = v31.F
                v30 = v31
            end
        end
        v25[v30] = nil
        v26[v30] = true
        if v30 == v24 then
            v27 = true
            break
        end
        for _, v32 in v30.Neighbors do
            if not v26[v32] then
                if v25[v32] then
                    if v32.G < v30.G then
                        v32.Parent = v30
                        v32.G = v30.G + (v32.Position - v30.Position).Magnitude
                        v32.F = v32.G + v32.H
                    end
                else
                    v25[v32] = true
                    v32.Parent = v30
                    v32.G = v30.G + (v32.Position - v30.Position).Magnitude
                    v32.H = (v32.Position - v24.Position).Magnitude
                    v32.F = v32.G + v32.H
                end
            end
        end
    end
    if v27 then
        while v24 do
            local v33 = v24.Position
            table.insert(v28, 1, v33)
            v24 = v24.Parent
        end
    end
    for v34 in v25 do
        v34.F = 0
        v34.G = 0
        v34.H = 0
        v34.Parent = nil
    end
    for v35 in v26 do
        v35.F = 0
        v35.G = 0
        v35.H = 0
        v35.Parent = nil
    end
    return v27 and v28 and v28 or nil
end
function v1.Init(_) --[[ Line: 156 ]]
    BuildNodes()
end
return v1