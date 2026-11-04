 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
function crater(p2, p3, _, p4)
    math.random(0, 180)
    local v5 = p4 or 8
    local v6 = {}
    for v7 = 1, v5 do
        local v8 = v7 / v5 * 360 + 90
        local v9 = script.Rock2:Clone()
        local v10 = math.random(-2, -1)
        local v11 = (p2 + Vector3.new(0, v10, 0)) * CFrame.Angles(0, math.rad(v8), 0) * CFrame.new(0, 0, -(p3 + math.random(5, 8)))
        local v12 = CFrame.Angles
        local v13 = math.random(-15, 15)
        v9:PivotTo(v11 * v12(-0.17453292519943295, math.rad(v13), 0))
        local v14, _, _ = _G.getRayFloor(v9:GetPivot() + Vector3.new(0, 5, 0), 35)
        if v14 then
            _G.matchMaterial(v9.Rock, v14)
            _G.matchMaterial(v9.Land, v14)
            v9.Land.Color = v14.Color:Lerp(Color3.new(0, 0, 0), 0.3)
            v9.Rock.Color = v14.Color:Lerp(Color3.new(0.3205, 0.3205, 0.3205), 0)
        end
        table.insert(v6, v9)
        v9.Parent = workspace.Effects
    end
    return v6
end
function v1.start(_, p15, p16, p17, p18) --[[ Line: 38 ]]
    local u19 = crater(p15, p16, p17, p18)
    for _, v20 in pairs(u19) do
        v20:PivotTo(v20.PrimaryPart.CFrame - Vector3.new(0, 12, 0))
        local _ = v20.Name == "Rock1"
        _G.tween(v20.PrimaryPart, { 0.3, "Sine", Enum.EasingDirection.Out }, {
            ["CFrame"] = v20.PrimaryPart.CFrame * CFrame.new(0, 0, -7) + Vector3.new(0, 4, 0)
        })
    end
    task.delay(0.3, function() --[[ Line: 49 ]]
        --[[
        Upvalues:
            [1] = u19
        --]]
        for _, v21 in pairs(u19) do
            v21.PrimaryPart.Anchored = false
            local v22 = v21.PrimaryPart
            local v23 = math.random(40, 80)
            v22.Velocity = Vector3.new(0, v23, 0)
            local v24 = v21.PrimaryPart
            local v25 = math.random(-2, 2)
            local v26 = math.random(-2, 2)
            local v27 = math.random
            v24.RotVelocity = Vector3.new(v25, v26, v27(-2, 2)) / 2
            _G.destroy(v21, 3)
        end
    end)
end
return v1