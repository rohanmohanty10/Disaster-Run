 

return {
    ["start"] = function(_, p1, u2) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1:GetPivot().Position) then
            if p1 and p1.opeHeart:FindFirstChild("Heart3.001") == nil then
                return
            else
                local v3 = p1.target.Value
                if v3 == nil then
                    return
                elseif v3 and v3:FindFirstChild("Humanoid") == nil then
                    return
                elseif p1.Parent:IsA("Model") ~= false then
                    p1.opeHeart["Heart3.001"].OpeHeartBeat.TimePosition = 0
                    p1.opeHeart["Heart3.001"].OpeHeartBeat.Playing = true
                    local v4 = p1.Parent.PrimaryPart.CFrame
                    local u5 = script.heartbeatPart:Clone()
                    u5.CFrame = CFrame.new(p1.opeHeart.PrimaryPart.Position, p1.opeHeart.PrimaryPart.Position + v4.LookVector) * CFrame.Angles(0, 1.5707963267948966, 0) + Vector3.new(0, 3, 0)
                    u5.Parent = workspace.Effects
                    _G.destroy(u5, 1.5)
                    local u6 = Color3.fromRGB(120, 0, 0):Lerp(Color3.fromRGB(0, 193, 0), v3.Humanoid.Health / v3.Humanoid.MaxHealth)
                    for _, v7 in pairs(u5.centerAttach:GetChildren()) do
                        if u2 then
                            v7.Color = ColorSequence.new(Color3.fromRGB(120, 0, 0))
                        else
                            v7.Color = ColorSequence.new(u6)
                        end
                    end
                    _G.customEmit(u5.centerAttach, true)
                    task.spawn(function() --[[ Line: 37 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u5
                            [3] = u6
                        --]]
                        local u8 = u2 and 0.5 or 1
                        for v9 = 1, 8 do
                            if v9 ~= 8 then
                                local v10 = u5["attach" .. v9 + 1]
                                local v11 = v10.Position
                                v10.Position = u5["attach" .. v9].Position
                                if v9 == 1 or v9 == 7 then
                                    game:GetService("TweenService"):Create(v10, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                        ["Position"] = v11
                                    }, true):Play()
                                else
                                    game:GetService("TweenService"):Create(v10, TweenInfo.new(0.01, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                        ["Position"] = v11
                                    }, true):Play()
                                end
                            end
                            local u12 = u5["beam" .. v9]
                            if u2 then
                                u12.Color = ColorSequence.new(Color3.fromRGB(120, 0, 0))
                            else
                                u12.Color = ColorSequence.new(u6)
                            end
                            if v9 == 1 or v9 == 8 then
                                if v9 == 1 then
                                    game:GetService("TweenService"):Create(u12, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                        ["Width0"] = 0,
                                        ["Width1"] = 0.2
                                    }, true):Play()
                                    task.delay(0.05, function() --[[ Line: 93 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u12
                                            [2] = u8
                                        --]]
                                        game:GetService("TweenService"):Create(u12, TweenInfo.new(u8 * 1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                            ["Width0"] = 0,
                                            ["Width1"] = 0
                                        }, true):Play()
                                    end)
                                    task.wait(0.05)
                                elseif v9 == 8 then
                                    game:GetService("TweenService"):Create(u12, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                        ["Width0"] = 0.2,
                                        ["Width1"] = 0
                                    }, true):Play()
                                    task.delay(0.05, function() --[[ Line: 107 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u12
                                            [2] = u8
                                        --]]
                                        game:GetService("TweenService"):Create(u12, TweenInfo.new(u8 * 1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                            ["Width0"] = 0,
                                            ["Width1"] = 0
                                        }, true):Play()
                                    end)
                                    task.wait(0.05)
                                end
                            else
                                game:GetService("TweenService"):Create(u12, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                    ["Width0"] = 0.2,
                                    ["Width1"] = 0.2
                                }, true):Play()
                                task.delay(0.05, function() --[[ Line: 79 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u12
                                        [2] = u8
                                    --]]
                                    game:GetService("TweenService"):Create(u12, TweenInfo.new(u8 * 1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                        ["Width0"] = 0,
                                        ["Width1"] = 0
                                    }, true):Play()
                                end)
                                task.wait(0.01)
                            end
                        end
                    end)
                end
            end
        else
            return
        end
    end
}