 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
function crater(p2, p3, p4)
    local v5 = math.random(0, 180)
    local v6 = {}
    for v7 = 1, 10 do
        local v8 = v7 / 10 * 360 + v5
        local v9 = script.Rock2:Clone()
        _G.matchMaterial(v9.Land, p4.Instance)
        _G.matchMaterial(v9.Rock, p4.Instance)
        v9.Land.Color = p4.Instance.Color:Lerp(Color3.new(0, 0, 0), 0.3)
        v9.Rock.Color = p4.Instance.Color:Lerp(Color3.new(0.3205, 0.3205, 0.3205), 0)
        local v10 = p2 * CFrame.new(0, 2, 0) * CFrame.Angles(0, math.rad(v8), 0) * CFrame.new(0, 0, -p3) * CFrame.Angles(-0.5235987755982988, 0, 0)
        local v11 = CFrame.Angles
        local v12 = math.random(2, 5)
        local v13 = math.rad(v12)
        local v14 = math.random(0, 5)
        local v15 = math.rad(v14)
        local v16 = math.random(2, 10)
        v9:PivotTo(v10 * v11(v13, v15, (math.rad(v16))))
        table.insert(v6, v9)
        v9.Parent = workspace.Effects
    end
    for v17 = 1, 8 do
        local v18 = v17 / 8 * 360 + v5
        local v19 = script.Rock1:Clone()
        _G.matchMaterial(v19.Land, p4.Instance)
        _G.matchMaterial(v19.Rock, p4.Instance)
        v19.Land.Color = p4.Instance.Color:Lerp(Color3.new(0, 0, 0), 0)
        v19.Rock.Color = p4.Instance.Color:Lerp(Color3.new(0.3205, 0.3205, 0.3205), 0)
        local v20 = p2 * CFrame.new(0, -2.1, 0) * CFrame.Angles(0, math.rad(v18), 0) * CFrame.new(0, 0, -(p3 - 3)) * CFrame.Angles(0.2617993877991494, 0, 0)
        local v21 = CFrame.Angles
        local v22 = math.random(2, 5)
        local v23 = math.rad(v22)
        local v24 = math.random(0, 5)
        local v25 = math.rad(v24)
        local v26 = math.random(2, 10)
        v19:PivotTo(v20 * v21(v23, v25, (math.rad(v26))))
        table.insert(v6, v19)
        v19.Parent = workspace.Effects
    end
    return v6
end
function v1.start(_, p27, p28, p29) --[[ Line: 48 ]]
    local u30 = crater(p27, p28, p29)
    for _, v31 in pairs(u30) do
        v31:PivotTo(v31.PrimaryPart.CFrame - Vector3.new(0, 2, 0))
        local v32 = 0.0125 + math.random(0, 50) / 1000
        if v31.Name == "Rock1" then
            v32 = v32 + 0.016666666666666666
        end
        _G.tween(v31.PrimaryPart, { v32, "Quad", Enum.EasingDirection.Out }, {
            ["CFrame"] = v31.PrimaryPart.CFrame * CFrame.new(0, 0, -6) + Vector3.new(0, 1.4, 0)
        })
    end
    task.delay(2, function() --[[ Line: 59 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        for _, v33 in pairs(u30) do
            _G.tween(v33.PrimaryPart, { 0.9 + math.random(0, 200) / 500, "Quad", Enum.EasingDirection.InOut }, {
                ["CFrame"] = v33.PrimaryPart.CFrame - Vector3.new(0, 8, 0)
            })
            _G.destroy(v33, 0.7)
        end
    end)
end
return v1