 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
function crater(p2, p3, p4, p5)
    math.random(0, 180)
    local v6 = p2 * CFrame.new(0, 3.85, 0)
    local v7 = {}
    for v8 = 1, 6 do
        local v9 = v8 / 6 * 360
        local v10 = script.Rock1:Clone()
        v10.Land.Material = p5.Material
        v10.Rock.Material = p5.Material
        v10.Land.Color = p5.Instance.Color:Lerp(Color3.new(0, 0, 0), 0.45)
        v10.Rock.Color = p5.Instance.Color:Lerp(Color3.new(0.3205, 0.3205, 0.3205), 0.4)
        v10:ScaleTo(v10:GetScale() * p4)
        local v11 = v6 * CFrame.new(0, 3, 0) * CFrame.Angles(0, math.rad(v9), 0) * CFrame.new(0, 0, -p3) * CFrame.Angles(-0.6981317007977318, 0, 0)
        local v12 = CFrame.Angles
        local v13 = math.random(2, 5)
        local v14 = math.rad(v13)
        local v15 = math.random(-12, 12)
        local v16 = math.rad(v15)
        local v17 = math.random(2, 10)
        v10:PivotTo(v11 * v12(v14, v16, (math.rad(v17))))
        table.insert(v7, v10)
        v10.Parent = workspace.Effects
    end
    for v18 = 1, 12 do
        local v19 = v18 / 12 * 360 + 90
        local v20 = script.Rock2:Clone()
        v20.Land.Material = p5.Material
        v20.Rock.Material = p5.Material
        v20.Land.Color = p5.Instance.Color:Lerp(Color3.new(0, 0, 0), 0.45)
        v20.Rock.Color = p5.Instance.Color:Lerp(Color3.new(0.3205, 0.3205, 0.3205), 0.4)
        v20:ScaleTo(v20:GetScale() * p4)
        local v21 = v6 * CFrame.new(0, math.random(-1, 2), 0) * CFrame.Angles(0, math.rad(v19), 0) * CFrame.new(0, 0, -(p3 + 4))
        local v22 = CFrame.Angles
        local v23 = math.random(-25, 25)
        v20:PivotTo(v21 * v22(-0.2617993877991494, math.rad(v23), 0))
        table.insert(v7, v20)
        v20.Parent = workspace.Effects
    end
    return v7
end
function v1.start(_, p24, p25, p26, p27) --[[ Line: 49 ]]
    local u28 = crater(p24, p25, p26, p27)
    for _, v29 in pairs(u28) do
        v29:PivotTo(v29.PrimaryPart.CFrame - Vector3.new(0, 6, 0))
        local v30 = 0.1 + math.random(0, 20) / 400
        local _ = v29.Name == "Rock1"
        _G.tween(v29.PrimaryPart, { v30, "Exponential", Enum.EasingDirection.Out }, {
            ["CFrame"] = v29.PrimaryPart.CFrame * CFrame.new(0, 0, -7) + Vector3.new(0, 1, 0)
        })
    end
    task.delay(1.25, function() --[[ Line: 60 ]]
        --[[
        Upvalues:
            [1] = u28
        --]]
        for _, v31 in pairs(u28) do
            _G.tween(v31.PrimaryPart, { 0.9 + math.random(0, 200) / 500, "Quad", Enum.EasingDirection.InOut }, {
                ["CFrame"] = v31.PrimaryPart.CFrame * CFrame.new(0, -14, 0)
            })
            _G.destroy(v31, 0.7)
        end
    end)
end
return v1