 

local u1 = _G.Ess.Tween
local v11 = {
    ["Settings"] = {
        ["Rate"] = 0.05,
        ["ScaleMult"] = 2,
        ["Offset"] = 24,
        ["Height"] = 9
    },
    ["Create"] = function(p2, p3, p4, p5, u6) --[[ Name: Create, Line 14 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        for _ = 1, 2 do
            local v7 = Random.new()
            CFrame.fromAxisAngle(v7:NextUnitVector() * 12, v7:NextNumber(0, 1))
            local u8 = script.RockModel:Clone()
            u8:ScaleTo(p5)
            u8:PivotTo(p2 * CFrame.new(p3, 0, 0) * CFrame.Angles(0, 1.5707963267948966 * math.sign(p3), 0) * p4)
            u8.Parent = workspace.Effects
            for _, u9 in u8:GetDescendants() do
                if u9:IsA("BasePart") then
                    local v10, _, _ = _G.getRayFloor(CFrame.new(u9.Position + Vector3.new(0, 5, 0)), 55)
                    if v10 then
                        _G.matchMaterial(u9, v10)
                    end
                    u1(u9, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        ["CFrame"] = u9.CFrame + Vector3.new(0, 4, 0)
                    })
                    task.delay(0.5, function() --[[ Line: 42 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u9
                            [3] = u6
                        --]]
                        u1(u9, TweenInfo.new(u6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            ["CFrame"] = u9.CFrame - Vector3.new(0, 15, 0)
                        })
                    end)
                end
            end
            task.delay(u6 + 0.8, function() --[[ Line: 51 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                u8:Destroy()
            end)
            p3 = -p3
        end
    end
}
return v11