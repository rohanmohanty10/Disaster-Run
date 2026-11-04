 

return {
    ["start"] = function(_, u1, _) --[[ Name: start, Line 4 ]]
        local u2 = script
        local u3 = u1.HumanoidRootPart
        if _G.checkRenderDistance(u1.PrimaryPart.Position) then
            local u4 = u2.sphereMesh:Clone()
            u4.CFrame = u3.CFrame * CFrame.new(0.25, -0.5, -2.2)
            u4.Name = "room" .. u1.Name
            u4.Parent = workspace.Effects
            _G.customEmit(u4.activateAttach, true)
            u4.OpeRoomHoldLOOP.Playing = true
            u4.OpeRoomStart.Playing = true
            local u5 = u2.floorPart:Clone()
            u5.CFrame = u3.CFrame * CFrame.new(0.25, -2.95, -2.2)
            u5.Parent = u4
            u5.Attachment.innerPulse:Emit(1)
            for _, v6 in pairs(u4:GetChildren()) do
                if v6.Name == "innerBeam" then
                    game:GetService("TweenService"):Create(v6, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Width0"] = 0.3,
                        ["Width1"] = 0.3
                    }, true):Play()
                elseif v6.Name == "outerBeam" then
                    game:GetService("TweenService"):Create(v6, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Width0"] = 0.6,
                        ["Width1"] = 0.6
                    }, true):Play()
                end
            end
            game:GetService("TweenService"):Create(u4, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                ["Size"] = Vector3.new(1.2, 1.2, 1.2)
            }, true):Play()
            game:GetService("TweenService"):Create(u4, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["Color"] = Color3.fromRGB(49, 86, 108)
            }, true):Play()
            local u7 = Instance.new("NumberValue")
            u7.Value = -0.5
            game:GetService("TweenService"):Create(u7, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 10000, true), {
                ["Value"] = -0.7
            }, true):Play()
            _G.destroy(u7, 60)
            local v8 = Instance.new("NumberValue")
            v8.Value = 1.2
            game:GetService("TweenService"):Create(v8, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["Value"] = 150
            }, true):Play()
            _G.destroy(u7, 60)
            _G.destroy({ u5, u4, v8 }, 6)
            local u9 = 1
            local u10 = 0
            local u11 = tick()
            local u12 = nil
            u12 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 75 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u4
                    [3] = u1
                    [4] = u12
                    [5] = u5
                    [6] = u3
                    [7] = u7
                    [8] = u10
                    [9] = u9
                    [10] = u2
                --]]
                if tick() - u11 > 0.0075 then
                    if u4.Parent ~= workspace.Effects or (u1.Parent == workspace.Ragdolls or u1:IsDescendantOf(workspace) == false) then
                        u12:Disconnect()
                        u12 = nil
                    end
                    u5.CFrame = u3.CFrame * CFrame.new(0.25, -2.98, -2.2)
                    u4.CFrame = u3.CFrame * CFrame.new(0.25, u7.Value, -2.2) * CFrame.Angles(0, u10, 0)
                    if u9 % 3 == 1 then
                        local v13 = u4.CFrame * CFrame.Angles(Random.new():NextNumber(-0.20943951023931953, 0.20943951023931953), Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-0.20943951023931953, 0.20943951023931953)) * CFrame.new(0, 0, Random.new():NextNumber(2, 3)).Position
                        local v14 = Instance.new("Attachment")
                        v14.Parent = u4
                        v14.WorldPosition = v13 + Vector3.new(0, 0.5, 0)
                        local v15 = Instance.new("Attachment")
                        v15.Parent = u4
                        v15.WorldPosition = v13 + Vector3.new(0, -0.5, 0)
                        local v16 = u2.orbTrail:Clone()
                        v16.Attachment0 = v14
                        v16.Attachment1 = v15
                        v16.Transparency = NumberSequence.new(Random.new():NextNumber(0.6, 0.8))
                        v16.Parent = u4
                        _G.destroy(v14, 0.7)
                        _G.destroy(v15, 0.7)
                        _G.destroy(v16, 0.7)
                        game:GetService("TweenService"):Create(v14, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Position"] = Vector3.new(0, 0, 0)
                        }, true):Play()
                        game:GetService("TweenService"):Create(v15, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Position"] = Vector3.new(0, 0, 0)
                        }, true):Play()
                    end
                    u10 = u10 + 0.12566370614359174
                    u9 = u9 + 1
                    u11 = tick()
                end
            end)
            task.wait(0.3)
            game:GetService("TweenService"):Create(u4, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 10000, true), {
                ["Color"] = Color3.fromRGB(69, 106, 128),
                ["Size"] = Vector3.new(1.1, 1.1, 1.1)
            }, true):Play()
        end
    end
}