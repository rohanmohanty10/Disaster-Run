 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
function crater(p2, p3, p4)
    local v5 = math.random(0, 180)
    local v6 = {}
    for v7 = 1, 8 do
        local v8 = v7 / 8 * 360 + v5
        local v9 = script.Rock2:Clone()
        _G.matchMaterial(v9.Land, p4.Instance)
        _G.matchMaterial(v9.Rock, p4.Instance)
        v9.Land.Color = p4.Instance.Color:Lerp(Color3.new(0, 0, 0), 0.35)
        v9.Rock.Color = p4.Instance.Color:Lerp(Color3.new(0.3205, 0.3205, 0.3205), 0.15)
        local v10 = p2 * CFrame.new(0, -1.8, 0) * CFrame.Angles(0, math.rad(v8), 0) * CFrame.new(0, 0, -p3) * CFrame.Angles(0.20943951023931956, 0, 0)
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
    return v6
end
function v1.start(_, p17, p18, p19) --[[ Line: 29 ]]
    local u20 = crater(p17, p18, p19)
    for _, v21 in pairs(u20) do
        v21:PivotTo(v21.PrimaryPart.CFrame * CFrame.new(0, -4, 0))
        local v22 = 0.0125 + math.random(0, 50) / 1000
        if v21.Name == "Rock1" then
            v22 = v22 + 0.016666666666666666
        end
        _G.tween(v21.PrimaryPart, { v22, "Quad", Enum.EasingDirection.Out }, {
            ["CFrame"] = v21.PrimaryPart.CFrame * CFrame.new(0, 1.5, -10)
        })
    end
    task.delay(0.4, function() --[[ Line: 40 ]]
        --[[
        Upvalues:
            [1] = u20
        --]]
        for _, v23 in pairs(u20) do
            _G.tween(v23.PrimaryPart, { 0.9 + math.random(0, 200) / 500, "Quad", Enum.EasingDirection.InOut }, {
                ["CFrame"] = v23.PrimaryPart.CFrame * CFrame.new(0, -14, 0)
            })
            _G.destroy(v23, 0.7)
        end
    end)
end
return v1