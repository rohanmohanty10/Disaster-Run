 

return {
    ["start"] = function(_, p1, u2) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.PrimaryPart.Position) then
            local u3 = script
            local _ = p1.HumanoidRootPart
            local u4 = {}
            local _ = p1.PrimaryPart.CFrame * CFrame.new(0, 0, -7)
            local v5
            if u2 then
                local v6 = u2.PrimaryPart.CFrame
                v5 = u3.hitPart:Clone()
                v5.CFrame = v6
                v5.Parent = workspace.Effects
                _G.destroy(v5, 4)
            else
                v5 = nil
            end
            local v7 = p1.PrimaryPart.CFrame
            task.spawn(function() --[[ Line: 24 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u3
                    [3] = u4
                --]]
                if u2 ~= nil then
                    u2.Humanoid:LoadAnimation(script.victim):Play()
                    local v8 = nil
                    for _, v9 in pairs(u2:GetChildren()) do
                        if v9:IsA("BasePart") and v9.Transparency == 0 then
                            if v8 == nil then
                                v8 = v9
                            else
                                local v10 = Instance.new("Attachment")
                                v10.Parent = v8
                                local v11 = Instance.new("Attachment")
                                v11.Parent = v9
                                local v12 = u3.Beam:Clone()
                                v12.Attachment0 = v10
                                v12.Attachment1 = v11
                                v12.Parent = workspace.Effects
                                _G.destroy(v12, 4)
                                local v13 = u4
                                table.insert(v13, v12)
                                local v14 = u3.Beam2:Clone()
                                v14.Attachment0 = v10
                                v14.Attachment1 = v11
                                v14.Parent = workspace.Effects
                                _G.destroy(v14, 4)
                                local v15 = u4
                                table.insert(v15, v14)
                                v8 = v9
                            end
                        end
                    end
                end
            end)
            for _ = 1, 45 do
                local v16 = u3.turnPart:Clone()
                v16:PivotTo(v7 * CFrame.new(Random.new():NextNumber(-3, 3), Random.new():NextNumber(-3, 3), Random.new():NextNumber(-9, -7)) * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793)))
                v16.Parent = workspace.Effects
                _G.destroy(v16, 4)
                if v5 then
                    v5.cutLine:Emit(1)
                end
                game:GetService("TweenService"):Create(v16.outerPart.lineBurst, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["Rate"] = 0
                }, true):Play()
                for _, v17 in pairs(v16.outerPart:GetChildren()) do
                    if v17:IsA("ParticleEmitter") then
                        game:GetService("TweenService"):Create(v17, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            ["Rate"] = 0
                        }, true):Play()
                    end
                end
                _G.customEmit(v16.mainPart, true)
                game:GetService("TweenService"):Create(v16.PrimaryPart, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["CFrame"] = v16.PrimaryPart.CFrame * CFrame.Angles(0, 3.1101767270538954, 0)
                }, true):Play()
                game:GetService("TweenService"):Create(v16.outerPart.attach0, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["Position"] = Vector3.new(0, 0, 0)
                }, true):Play()
                game:GetService("TweenService"):Create(v16.outerPart.attach1, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["Position"] = Vector3.new(0, 0, 0)
                }, true):Play()
                task.wait(0.01)
            end
            task.wait(1)
            if v5 then
                game:GetService("TweenService"):Create(v5, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    ["Size"] = Vector3.new(0, 0, 0)
                }, true):Play()
            end
            task.wait(0.4)
            if v5 then
                v5.Attachment.glowFill.Enabled = false
                v5.lightning1.Enabled = false
                v5.lightning2.Enabled = false
                _G.customEmit(v5.stopAttach, true)
            end
            for _, v18 in pairs(u4) do
                v18:Destroy()
            end
        end
    end
}