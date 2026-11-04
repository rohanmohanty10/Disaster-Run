 

Ess = _G.Ess
TweenCreate = Ess.Tween
return {
    ["CreateSideRocks"] = function(p1, p2, p3) --[[ Name: CreateSideRocks, Line 6 ]]
        for _ = 1, 2 do
            local u4 = Random.new():NextNumber(0.8, 1.2)
            local v5 = script.Rocks
            local v6 = math.random
            local u7 = v5:FindFirstChild((tostring(v6(1, 5)))):Clone()
            local u8 = u7:FindFirstChild("Rock")
            local v9 = u7:FindFirstChild("Land")
            u8.Size = u8.Size * u4
            v9.Size = v9.Size * u4
            v9.CFrame = v9.CFrame * CFrame.new(0, v9.Size.Y * u4 / 2, 0)
            _G.matchMaterial(u8, p3.Instance)
            _G.matchMaterial(v9, p3.Instance)
            u8.Color = p3.Instance.Color:Lerp(Color3.new(0, 0, 0), 0.35)
            v9.Color = p3.Instance.Color:Lerp(Color3.new(0.3205, 0.3205, 0.3205), 0.15)
            u7:PivotTo((CFrame.new((p1 * CFrame.new(p2, 0, 0)).Position, p1.Position) - Vector3.new(0, 6, 0)) * CFrame.Angles(-Random.new():NextNumber(1, 2.5) / 5, Random.new():NextNumber(-2, 2) / 15, Random.new():NextNumber(-3, 3) / 30))
            u7.Parent = workspace.Effects
            TweenCreate(u8, TweenInfo.new(0.2 * u4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["CFrame"] = u8.CFrame + Vector3.new(0, 6.4, 0)
            })
            task.delay(0.35 * u4, function() --[[ Line: 33 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u4
                    [3] = u7
                --]]
                TweenCreate(u8, TweenInfo.new(0.3 * u4, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
                    ["CFrame"] = (u8.CFrame - Vector3.new(0, 12, 0)) * CFrame.Angles(0.08726646259971647, 0, 0)
                })
                Ess.Destroy(u7, 0.3)
            end)
            p2 = -p2
        end
    end
}