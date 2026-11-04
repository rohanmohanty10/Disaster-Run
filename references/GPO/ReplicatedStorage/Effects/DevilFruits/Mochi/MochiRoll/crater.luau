 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
function crater(p2)
    local v3 = {}
    for v4 = 1, 12 do
        local v5 = v4 / 12 * 360
        local v6 = script.Rock1:Clone()
        local v7 = p2 * CFrame.new(0, -2, 0) * CFrame.Angles(0, math.rad(v5), 0) * CFrame.new(0, 0, -13) * CFrame.Angles(-0.3490658503988659, 0, 0)
        local v8 = CFrame.Angles
        local v9 = math.random(-15, 15)
        local v10 = math.rad(v9)
        local v11 = math.random(-15, 15)
        local v12 = math.rad(v11)
        local v13 = math.random(-15, 15)
        v6:PivotTo(v7 * v8(v10, v12, (math.rad(v13))))
        v6.Parent = workspace.Effects
        local v14, _, _ = _G.getRayFloor(v6.bot.CFrame, 10)
        if v14 == nil then
            v6:Destroy()
        else
            _G.matchMaterial(v6.top, v14)
            v6.bot.Color = v14.Color
            table.insert(v3, v6)
        end
    end
    for v15 = 1, 8 do
        local v16 = v15 / 8 * 360
        local v17 = script.Rock2:Clone()
        local v18 = p2 * CFrame.new(0, -1.5, 0) * CFrame.Angles(0, math.rad(v16), 0) * CFrame.new(0, 0, -10) * CFrame.Angles(0.3490658503988659, 0, 0)
        local v19 = CFrame.Angles
        local v20 = math.random(-15, 15)
        local v21 = math.rad(v20)
        local v22 = math.random(-15, 15)
        local v23 = math.rad(v22)
        local v24 = math.random(-15, 15)
        v17:PivotTo(v18 * v19(v21, v23, (math.rad(v24))))
        v17.Parent = workspace.Effects
        local v25, _, _ = _G.getRayFloor(v17.bot.CFrame, 10)
        if v25 == nil then
            v17:Destroy()
        else
            _G.matchMaterial(v17.top, v25)
            _G.matchMaterial(v17.bot, v25)
            table.insert(v3, v17)
        end
    end
    return v3
end
function v1.start(_, p26, p27) --[[ Line: 48 ]]
    local u28 = crater(p26 * CFrame.new(0, -p27, 0))
    for _, v29 in u28 do
        v29:PivotTo(v29.PrimaryPart.CFrame * CFrame.new(0, -4, 0))
        local v30 = 0.05 + math.random(0, 50) / 1000
        if v29.Name == "Rock1" then
            v30 = v30 + 0.06666666666666667
        end
        _G.tween(v29.PrimaryPart, { v30, "Quad", Enum.EasingDirection.Out }, {
            ["CFrame"] = v29.PrimaryPart.CFrame * CFrame.new(0, 4.5, 0)
        })
    end
    task.delay(1.5, function() --[[ Line: 59 ]]
        --[[
        Upvalues:
            [1] = u28
        --]]
        for _, v31 in u28 do
            _G.tween(v31.PrimaryPart, { 0.5 + math.random(0, 200) / 1000, "Quint", Enum.EasingDirection.In }, {
                ["CFrame"] = v31.PrimaryPart.CFrame * CFrame.new(0, -6, 0)
            })
            _G.destroy(v31, 0.6)
        end
    end)
end
return v1