 

return {
    ["start"] = function(_, p1, _) --[[ Name: start, Line 3 ]]
        local _ = workspace.CurrentCamera
        Random.new()
        game:GetService("RunService")
        local v2 = game:GetService("TweenService")
        game:GetService("Debris")
        local v3 = script.BomuGrip:Clone()
        local u4 = v3.MineM
        v3.Parent = workspace
        u4.Position = p1.HumanoidRootPart.Position + Vector3.new(-1, -3.1, -2)
        _G.PlaySound(p1.PrimaryPart, script.BomuGripSFX)
        for v5 = 0, 360, 45 do
            local v6 = math.rad(v5)
            local v7 = math.cos(v6) * math.random(4, 15)
            local v8 = math.sin(v6) * math.random(4, 15)
            local v9 = Vector3.new(v7, -3.1, v8)
            local v10 = script.Mines:Clone()
            local v11 = v10.Mines
            v10.Parent = v3
            v11.Position = p1.HumanoidRootPart.Position + v9
            v2:Create(v11, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                ["Size"] = Vector3.new(0.1, 2, 2),
                ["Transparency"] = 1
            }):Play()
            if v5 == 360 then
                local u12 = p1.Humanoid.Animator:LoadAnimation(v3:WaitForChild("BomuANIM"))
                v2:Create(u4, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    ["Size"] = Vector3.new(0.1, 2.5, 2.5),
                    ["Transparency"] = 1
                }):Play()
                task.spawn(function() --[[ Line: 38 ]]
                    --[[
                    Upvalues:
                        [1] = u12
                        [2] = u4
                    --]]
                    task.wait(0.5)
                    u12:Play()
                    task.wait(1.15)
                    _G.customEmit(u4.VFX)
                end)
            end
            task.wait(0.02)
            task.spawn(function() --[[ Line: 47 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                task.wait(1.83)
                _G.customEmit(u4.VFX)
            end)
        end
        _G.destroy(v3, 4)
    end
}