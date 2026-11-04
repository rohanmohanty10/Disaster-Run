 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.PrimaryPart.Position) then
            local v2 = script
            local u3 = p1.HumanoidRootPart
            local u4 = p1:FindFirstChild("KikokuSword")
            if u4 then
                u4.Blade.Transparency = 1
            end
            local u5 = v2.swordExample:Clone()
            u5.CFrame = p1.RightHand.CFrame * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -2.6, 0)
            u5.Parent = workspace.Effects
            local u6 = script.VerticalSlashExtended:Clone()
            u6.Parent = u5
            u6:Play()
            local u7 = Instance.new("CFrameValue")
            u7.Value = u3.CFrame:ToObjectSpace(u5.CFrame)
            game:GetService("TweenService"):Create(u7, TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Value"] = CFrame.new(0, 3, -8) * CFrame.Angles(0, 1.5707963267948966, 0)
            }, true):Play()
            _G.destroy(u7, 8)
            local u8 = v2.centerPart:Clone()
            u8.CFrame = u3.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 1.5707963267948966, 0)
            u8.Parent = workspace.Effects
            _G.destroy(u8, 8)
            local u9 = RaycastParams.new()
            u9.FilterType = Enum.RaycastFilterType.Whitelist
            u9.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
            u9.IgnoreWater = true
            local u10 = workspace:Raycast(u8.Position, CFrame.new(u8.Position, u8.Position - Vector3.new(0, 1000, 0)).LookVector * 5, u9)
            local u11 = v2.floorPart:Clone()
            u11.VerticalSlashGroundScrape.Volume = 0
            u11.Parent = workspace.Effects
            _G.destroy(u11, 8)
            if u10 ~= nil then
                u11.CFrame = CFrame.lookAt(u10.Position, u10.Position + u10.Normal, u3.CFrame.LookVector)
                u11.cloudTrail.Color = ColorSequence.new(u10.Instance.Color)
            end
            u11.VerticalSlashGroundScrape:Play()
            for _, v12 in pairs(u8.initialAttach:GetChildren()) do
                if v12.Rate > 0 then
                    _G.customEmit(v12)
                end
            end
            local u13 = tick()
            local u14 = tick()
            local u15 = nil
            u15 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 62 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u5
                    [3] = u3
                    [4] = u7
                    [5] = u8
                    [6] = u13
                    [7] = u10
                    [8] = u9
                    [9] = u11
                    [10] = u15
                --]]
                if tick() - u14 > 0.0125 then
                    u5.CFrame = u3.CFrame * u7.Value
                    u8.CFrame = u3.CFrame * u7.Value
                    if tick() - u13 > 0.1 then
                        u7.Value = u7.Value * CFrame.Angles(0, 0, 0.4487989505128276)
                    end
                    local v16 = u10
                    u10 = workspace:Raycast(u8.Position, CFrame.new(u8.Position, u8.Position - Vector3.new(0, 1000, 0)).LookVector * 8, u9)
                    local v17 = u11:FindFirstChild("cloudTrail")
                    if v17 == nil then
                        u15:Disconnect()
                        u15 = nil
                        return
                    end
                    if u10 == nil then
                        u10 = v16
                        if v17.Enabled == true then
                            for _, v18 in pairs(u11:GetChildren()) do
                                if v18:IsA("ParticleEmitter") then
                                    v18.Enabled = false
                                end
                            end
                            u11.VerticalSlashGroundScrape.Volume = 0
                        end
                    elseif v17.Enabled == false then
                        for _, v19 in pairs(u11:GetChildren()) do
                            if v19:IsA("ParticleEmitter") then
                                v19.Enabled = true
                            end
                        end
                        u11.VerticalSlashGroundScrape.Volume = script.floorPart.VerticalSlashGroundScrape.Volume
                    end
                    if u10 and (v16 and v16.Position ~= u10.Position) then
                        u11.CFrame = CFrame.lookAt(u10.Position, u10.Position + u10.Normal, u3.CFrame.LookVector)
                        u11.VerticalSlashGroundScrape.Volume = script.floorPart.VerticalSlashGroundScrape.Volume
                        if v16.Instance.Color ~= u10.Instance.Color then
                            u11.cloudTrail.Color = ColorSequence.new(u10.Instance.Color)
                        end
                    end
                    u14 = tick()
                end
            end)
            local u20 = nil
            u20 = p1:GetAttributeChangedSignal("holdingLinie"):Connect(function() --[[ Line: 118 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u20
                    [3] = u8
                    [4] = u11
                    [5] = u5
                    [6] = u4
                    [7] = u6
                --]]
                u15:Disconnect()
                u20:Disconnect()
                for _, v21 in pairs(u8.activeAttach:GetChildren()) do
                    v21.Enabled = false
                end
                for _, v22 in pairs(u8.outerAttach:GetChildren()) do
                    v22.Enabled = false
                end
                for _, v23 in pairs(u11:GetChildren()) do
                    if v23:IsA("ParticleEmitter") then
                        v23.Enabled = false
                    end
                end
                u8.Trail1.Enabled = false
                u8.Trail2.Enabled = false
                _G.customEmit(u8.initialAttach)
                u5.Transparency = 1
                if u4 then
                    u4.Blade.Transparency = 0
                end
                game:GetService("TweenService"):Create(u6, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Volume"] = 0
                }, true):Play()
                game:GetService("TweenService"):Create(u11.VerticalSlashGroundScrape, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Volume"] = 0
                }, true):Play()
                _G.destroy(u5, 0.5)
            end)
        end
    end
}