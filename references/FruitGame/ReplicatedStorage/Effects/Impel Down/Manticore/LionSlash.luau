 

return {
    ["start"] = function(_, u1, _) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(u1.PrimaryPart.Position) ~= false then
            local u2 = game:GetService("TweenService")
            local v3 = workspace.Effects
            local v4 = script.LionSlash:Clone()
            v4.Parent = v3
            local _, _ = u1:GetBoundingBox()
            local u5 = {
                14399492802,
                14399492596,
                14399492365,
                14399492055,
                14399491725,
                14399491447,
                14399491149,
                14399490913,
                14399490678,
                14399490439,
                14399490165,
                14399489881,
                14399489682,
                14399489443,
                14399489049
            }
            for _, u6 in pairs(v4:GetChildren()) do
                if u6:IsA("BasePart") then
                    task.spawn(function() --[[ Line: 21 ]]
                        --[[
                        Upvalues:
                            [1] = u6
                            [2] = u1
                            [3] = u2
                            [4] = u5
                        --]]
                        u6.CFrame = u1["Cube.006"].CFrame * CFrame.new(0, -2, -3) * CFrame.Angles(0, 0, 0.4363323129985824) * CFrame.Angles(0, 0, 3.141592653589793)
                        task.wait(0.55)
                        for _, u7 in pairs(u6:GetDescendants()) do
                            if u7:IsA("ParticleEmitter") then
                                task.spawn(function() --[[ Line: 29 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u7
                                    --]]
                                    u7.Enabled = true
                                    task.wait(0.275)
                                    u7.Enabled = false
                                end)
                            end
                        end
                        task.wait(0.1)
                        u2:Create(u6, TweenInfo.new(0.35, Enum.EasingStyle.Quart), {
                            ["CFrame"] = u6.CFrame * CFrame.Angles(0, -1.9198621771937625, 0)
                        }):Play()
                        for v8 = 1, #u5 do
                            if u6:FindFirstChild("Normal") then
                                u6.Normal.Texture = "rbxassetid://" .. u5[v8]
                                task.wait(0.125 / #u5)
                            end
                        end
                        task.wait(0.15)
                        u6.Orientation = Vector3.new(45, 0, -90)
                    end)
                end
            end
            _G.destroy(v4, 3)
        end
    end
}