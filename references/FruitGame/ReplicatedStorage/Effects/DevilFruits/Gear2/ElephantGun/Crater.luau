 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
function crater(p2, p3, _)
    math.random(0, 180)
    local v4 = {}
    for v5 = 1, 8 do
        local v6 = v5 / 8 * 360
        local v7 = script.Rock1:Clone()
        local v8 = (p2 + Vector3.new(0, 5, 0)) * CFrame.Angles(0, math.rad(v6), 0) * CFrame.new(0, 0, -p3) * CFrame.Angles(-0.6981317007977318, 0, 0)
        local v9 = CFrame.Angles
        local v10 = math.random(2, 5)
        local v11 = math.rad(v10)
        local v12 = math.random(-12, 12)
        local v13 = math.rad(v12)
        local v14 = math.random(2, 10)
        v7:PivotTo(v8 * v9(v11, v13, (math.rad(v14))))
        local v15, _, _ = _G.getRayFloor(v7:GetPivot() + Vector3.new(0, 5, 0), 35)
        if v15 then
            _G.matchMaterial(v7.Land, v15)
            _G.matchMaterial(v7.Rock, v15)
            v7.Land.Color = v15.Color:Lerp(Color3.new(0, 0, 0), 0.3)
            v7.Rock.Color = v15.Color:Lerp(Color3.new(0.3205, 0.3205, 0.3205), 0)
        end
        table.insert(v4, v7)
        v7.Parent = workspace.Effects
    end
    for v16 = 1, 18 do
        local v17 = v16 / 18 * 360 + 90
        local v18 = script.Rock2:Clone()
        local v19 = math.random(-2, -1)
        local v20 = (p2 + Vector3.new(0, v19, 0)) * CFrame.Angles(0, math.rad(v17), 0) * CFrame.new(0, 0, -(p3 + math.random(5, 8)))
        local v21 = CFrame.Angles
        local v22 = math.random(-25, 25)
        v18:PivotTo(v20 * v21(-0.2617993877991494, math.rad(v22), 0))
        local v23, _, _ = _G.getRayFloor(v18:GetPivot() + Vector3.new(0, 5, 0), 35)
        if v23 then
            _G.matchMaterial(v18.Land, v23)
            _G.matchMaterial(v18.Rock, v23)
            v18.Land.Color = v23.Color:Lerp(Color3.new(0, 0, 0), 0.3)
            v18.Rock.Color = v23.Color:Lerp(Color3.new(0.3205, 0.3205, 0.3205), 0)
        end
        table.insert(v4, v18)
        v18.Parent = workspace.Effects
    end
    return v4
end
function v1.start(_, p24, p25, p26) --[[ Line: 51 ]]
    local u27 = crater(p24, p25, p26)
    for _, v28 in pairs(u27) do
        v28:PivotTo(v28.PrimaryPart.CFrame - Vector3.new(0, 6, 0))
        local v29 = 0.1 + math.random(0, 20) / 400
        local _ = v28.Name == "Rock1"
        _G.tween(v28.PrimaryPart, { v29, "Exponential", Enum.EasingDirection.Out }, {
            ["CFrame"] = v28.PrimaryPart.CFrame * CFrame.new(0, 0, -7) + Vector3.new(0, 1, 0)
        })
    end
    task.delay(2, function() --[[ Line: 64 ]]
        --[[
        Upvalues:
            [1] = u27
        --]]
        for _, v30 in pairs(u27) do
            _G.tween(v30.PrimaryPart, { 0.9 + math.random(0, 200) / 500, "Quad", Enum.EasingDirection.InOut }, {
                ["CFrame"] = v30.PrimaryPart.CFrame * CFrame.new(0, -14, 0)
            })
            _G.destroy(v30, 0.7)
        end
    end)
end
return v1