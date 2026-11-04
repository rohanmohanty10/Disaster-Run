 

local v1 = {}
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Whitelist
u2.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
function crater(p3, p4, p5)
    local v6 = {}
    for v7 = 1, 14 do
        local v8 = v7 / 14 * 360
        local v9 = script.Rock1:Clone()
        local v10 = p3 * CFrame.new(0, -2, 0) * CFrame.Angles(0, math.rad(v8), 0) * CFrame.new(0, 0, -p5) * CFrame.Angles(-0.3490658503988659, 0, 0)
        local v11 = CFrame.Angles
        local v12 = math.random(-15, 15)
        local v13 = math.rad(v12)
        local v14 = math.random(-15, 15)
        local v15 = math.rad(v14)
        local v16 = math.random(-15, 15)
        v9:PivotTo(v10 * v11(v13, v15, (math.rad(v16))))
        table.insert(v6, v9)
        v9.Parent = workspace.Effects
    end
    for v17 = 1, 15 do
        local v18 = v17 / 15 * 360
        local v19 = script.Rock2:Clone()
        local v20 = p3 * CFrame.new(0, -1.5, 0) * CFrame.Angles(0, math.rad(v18), 0) * CFrame.new(0, 0, -p4) * CFrame.Angles(0.3490658503988659, 0, 0)
        local v21 = CFrame.Angles
        local v22 = math.random(-15, 15)
        local v23 = math.rad(v22)
        local v24 = math.random(-15, 15)
        local v25 = math.rad(v24)
        local v26 = math.random(-15, 15)
        v19:PivotTo(v20 * v21(v23, v25, (math.rad(v26))))
        table.insert(v6, v19)
        v19.Parent = workspace.Effects
    end
    return v6
end
function v1.start(_, p27, p28, p29, p30) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u31 = crater(p27, p28, p29)
    for v32, v33 in u31 do
        local v34 = workspace:Raycast(v33.PrimaryPart.Position + Vector3.new(0, 6, 0), Vector3.new(0, -8, 0), u2)
        if v34 then
            _G.matchMaterial(v33.Top, v34.Instance)
            v33:PivotTo(v33.PrimaryPart.CFrame * CFrame.new(0, -4, 0))
            local v35 = 0.05 + math.random(0, 50) / 1000
            if v33.Name == "Rock1" then
                v35 = v35 + 0.06666666666666667
            end
            _G.tween(v33.PrimaryPart, { v35, "Quad", Enum.EasingDirection.Out }, {
                ["CFrame"] = v33.PrimaryPart.CFrame * CFrame.new(0, 4, 0)
            })
        else
            v33:Destroy()
            u31[v32] = nil
        end
    end
    task.delay(p30, function() --[[ Line: 47 ]]
        --[[
        Upvalues:
            [1] = u31
        --]]
        for _, v36 in u31 do
            _G.tween(v36.PrimaryPart, { 0.5 + math.random(0, 200) / 1000, "Quint", Enum.EasingDirection.In }, {
                ["CFrame"] = v36.PrimaryPart.CFrame * CFrame.new(0, -6, 0)
            })
            _G.destroy(v36, 0.6)
        end
    end)
end
return v1