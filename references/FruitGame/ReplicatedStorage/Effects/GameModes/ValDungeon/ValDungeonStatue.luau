 

game:GetService("RunService")
game:GetService("TweenService")
return {
    ["start"] = function(_, p1) --[[ Name: start, Line 12 ]]
        local v2 = p1.Statue
        local v3 = p1.Enabled
        local v4 = v3 and Color3.fromRGB(255, 64, 64) or Color3.fromRGB(0, 0, 0)
        local v5 = v2:FindFirstChild("Wave")
        if v5 then
            local v6 = v2.Heart["Meshes/HeartMe_Dress.003"]
            _G.tween(v6, {
                0.85,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Color"] = v4
            })
            task.wait(0.425)
            local u7 = v5:FindFirstChild("Summon")
            if not u7 then
                u7 = script.Summon:Clone()
                u7.Parent = v5
            end
            for _, v8 in u7:QueryDescendants("ParticleEmitter") do
                v8.Enabled = v3
            end
            if v3 then
                u7.SummonSFX:Play()
                _G.tween(u7.SummonSFX, {
                    1,
                    Enum.EasingStyle.Linear,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0.5
                })
            else
                _G.tween(u7.SummonSFX, {
                    1,
                    Enum.EasingStyle.Linear,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0
                })
                task.delay(1, function() --[[ Line: 65 ]]
                    --[[
                    Upvalues:
                        [1] = u7
                    --]]
                    u7.SummonSFX:Stop()
                end)
            end
        end
    end
}