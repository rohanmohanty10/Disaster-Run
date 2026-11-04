 

local v1 = {}
game:GetService("TweenService")
function v1.start(_, u2) --[[ Line: 5 ]]
    if _G.checkRenderDistance(u2.PrimaryPart.Position) then
        local u3 = script
        local u4 = u2.HumanoidRootPart
        local u5 = u3.bodyPart:Clone()
        u5.CFrame = u4.CFrame
        u5.Parent = workspace.Effects
        _G.customEmit(u5.startAttach, true)
        _G.destroy(u5, 4)
        u5.startAttach.lightningBurst.Rate = 100
        u5.startAttach.glowFill.Rate = 15
        _G.PlaySound(u2.PrimaryPart, script["Audio/LawSwordBigHorizontalSlashStart"]).Parent = u2.PrimaryPart
        local u6 = script["Audio/LawSwordBigHorizontalSlashLoop"]:Clone()
        u6.Parent = u2.PrimaryPart
        u6:Play()
        _G.customWeld(u5, u2.PrimaryPart, CFrame.new(), u5.tag)
        local u7 = nil
        u7 = u2:GetAttributeChangedSignal("stopCleave"):Connect(function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u5
                [3] = u4
                [4] = u6
                [5] = u2
                [6] = u3
            --]]
            u7:Disconnect()
            u5.tag:Destroy()
            local u8 = u4.CFrame
            for _, v9 in pairs(u5.startAttach:GetChildren()) do
                v9:Destroy()
            end
            _G.customEmit(u5.burstAttach, true)
            u6:Destroy()
            if u2:GetAttribute("stopCleave") == "hasTarget" then
                _G.PlaySound(u2.PrimaryPart, script["Audio/LawSwordBigHorizontalSlashAttractPlayers"])
                task.wait(1.1)
                _G.PlaySound(u2.PrimaryPart, script["Audio/LawSwordBigHorizontalSlashCutPlayers"])
                local v10 = u2:FindFirstChild("KikokuSword")
                if v10 then
                    v10.Blade.Transparency = 1
                end
                local u11 = Instance.new("NumberValue")
                u11.Value = 3.141592653589793
                game:GetService("TweenService"):Create(u11, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ["Value"] = u11.Value - 6.283185307179586
                }, true):Play()
                _G.destroy(u11, 4)
                local u12 = Instance.new("NumberValue")
                u12.Value = 0
                game:GetService("TweenService"):Create(u12, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ["Value"] = u12.Value + 18.84955592153876
                }, true):Play()
                _G.destroy(u12, 4)
                local u13 = u3.centerPart:Clone()
                u13.CFrame = u4.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 8) * CFrame.Angles(1.5707963267948966, 0, 0)
                u13.Parent = workspace.Effects
                _G.destroy(u13, 4)
                local u14 = tick()
                local u15 = u3.swordExample:Clone()
                u15.CFrame = u2.RightHand.CFrame * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -2.6, 0)
                u15.Parent = workspace.Effects
                local u16 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 78 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u13
                        [3] = u15
                        [4] = u8
                        [5] = u11
                        [6] = u12
                    --]]
                    if tick() - u14 > 0.025 then
                        if u13.activeAttach.waveBurst2.Enabled == true then
                            u15.CFrame = u8 * CFrame.Angles(0, u11.Value, 0) * CFrame.new(0, 0, 8) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.Angles(0, 0, u12.Value)
                            u13.CFrame = u15.CFrame
                            return
                        end
                        u13.CFrame = u8 * CFrame.Angles(0, u11.Value, 0) * CFrame.new(0, 0, 8) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.Angles(0, 0, u12.Value)
                    end
                end)
                task.delay(5, function() --[[ Line: 90 ]]
                    --[[
                    Upvalues:
                        [1] = u16
                    --]]
                    if u16 then
                        u16:Disconnect()
                        u16 = nil
                    end
                end)
                task.wait(0.3)
                local v17 = u16
                for _, v18 in pairs(u13.activeAttach:GetChildren()) do
                    v18.Enabled = false
                end
                local v19 = u2:FindFirstChild("RightHand")
                if v19 then
                    local v20 = u3.handPart:Clone()
                    v20.CFrame = v19.CFrame * CFrame.new(0, -0.1, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
                    v20.Parent = workspace.Effects
                    _G.destroy(v20, 4)
                    _G.customEmit(v20.catchAttach, true)
                end
                u15:Destroy()
                local v21 = u2:FindFirstChild("KikokuSword")
                if v21 and v21:FindFirstChild("Blade") then
                    v21.Blade.Transparency = 0
                end
                task.wait(0.8)
                v17:Disconnect()
                u16 = nil
            end
        end)
    end
end
return v1