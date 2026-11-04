 

local _ = _G.Ess.Tween
local u1 = _G.Emit
game:GetService("RunService")
local u17 = {
    ["InUse"] = {},
    ["Uppercut"] = function(p2, _, p3, p4) --[[ Name: Uppercut, Line 14 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u1
        --]]
        local _ = p2.PrimaryPart
        local _ = p2.Humanoid
        local v5, v6, v7 = _G.getRayFloor(p2.PrimaryPart.CFrame, 25)
        local v8 = p4.Model:Clone()
        v8:PivotTo(CFrame.new(v6 + Vector3.new(0, 0.1, 0)))
        u17.InUse[p3] = v8
        v8:PivotTo(CFrame.new(v6, v6 + v7) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0))
        v8.Parent = workspace.Effects
        if v5 ~= nil then
            v8.Rise.Dust.Rock.Color = ColorSequence.new(v5.Color)
        end
        u1(v8.Rise:GetDescendants(), true)
    end,
    ["Land"] = function(u9, _, p10, u11, p12, _) --[[ Name: Land, Line 37 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u1
        --]]
        local _ = u9.PrimaryPart
        local _ = u9.Humanoid
        local u13 = u17.InUse[p12]
        task.delay(p10, function() --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u13
                [3] = u11
                [4] = u1
            --]]
            local v14, v15, v16 = _G.getRayFloor(u9.PrimaryPart.CFrame, 70)
            u13:PivotTo(CFrame.new(v15, v15 + v16) * CFrame.Angles(-1.5707963267948966, 0, 0))
            task.wait(u11)
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 25,
                ["Position"] = v15 + Vector3.new(0, 5, 0),
                ["DistanceRandomness"] = Vector2.new(0.5, 1),
                ["Duration"] = 2,
                ["TweenDuration"] = 1,
                ["Radius"] = 12,
                ["Direction"] = Vector3.new(0, -35, 0)
            })
            u1(u13.Fall:GetDescendants(), true)
            if v14 then
                u13.Rise.Dust.Rock.Color = ColorSequence.new(v14.Color)
                u13.Rise.Dust["Dust 2"].Color = ColorSequence.new(v14.Color)
                u1(u13.Rise.Dust, true)
            end
            _G.destroy(u13, 3)
        end)
    end
}
return u17