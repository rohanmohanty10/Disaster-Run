 

local v1 = {}
local u2 = game:GetService("TweenService")
function v1.start(_, u3) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(u3.PrimaryPart.Position) then
        local u4 = script
        local v5 = u3.HumanoidRootPart
        local u6 = u3:FindFirstChild("KikokuSword")
        if u6 then
            u6.Blade.Transparency = 1
        end
        local u7 = u4.Sword:Clone()
        u7:PivotTo(u3.RightHand.CFrame)
        u7.Parent = workspace.Effects
        _G.customWeld(u7.PrimaryPart, u3.RightHand, CFrame.new(), u7.tag)
        _G.PlaySound(u3.PrimaryPart, script["Audio/LawSwordHorizontalSlashStart"])
        local v8 = v5.CFrame
        local u9 = u4.bodyPart:Clone()
        u9.CFrame = v8
        u9.Parent = workspace.Effects
        _G.customEmit(u9.startAttach, true)
        _G.destroy(u9, 4)
        local u10 = u4.handPart:Clone()
        u10.CFrame = u3.RightHand.CFrame * CFrame.new(0, -0.1, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
        u10.Parent = workspace.Effects
        _G.destroy(u10, 4)
        u10.Anchored = false
        local v11 = Instance.new("WeldConstraint")
        v11.Part0 = u10
        v11.Part1 = u7.Blade
        v11.Parent = u7.Blade
        for _, v12 in pairs(u10.startAttach:GetChildren()) do
            if v12.Enabled == false then
                _G.customEmit(v12.Rate, true)
            end
        end
        local u13 = nil
        u13 = u3:GetAttributeChangedSignal("kreisStop"):Connect(function() --[[ Line: 52 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u7
                [3] = u3
                [4] = u10
                [5] = u9
                [6] = u4
                [7] = u2
                [8] = u6
            --]]
            u13:Disconnect()
            u7.tag:Destroy()
            local u14 = u3.PrimaryPart.CFrame
            for _, v15 in pairs(u10.startAttach:GetChildren()) do
                v15.Enabled = false
            end
            u10.lineAura.Enabled = false
            u10.impulseAura.Enabled = false
            _G.customEmit(u9.burstAttach, true)
            local u16 = Instance.new("NumberValue")
            u16.Value = 3.141592653589793
            game:GetService("TweenService"):Create(u16, TweenInfo.new(1.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Value"] = u16.Value - 18.84955592153876
            }, true):Play()
            _G.destroy(u16, 4)
            local u17 = Instance.new("NumberValue")
            u17.Value = 0
            game:GetService("TweenService"):Create(u17, TweenInfo.new(0.45, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Value"] = u17.Value + 37.69911184307752
            }, true):Play()
            _G.destroy(u17, 4)
            local u18 = u4.centerPart:Clone()
            u18.CFrame = u14 * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 8) * CFrame.Angles(1.5707963267948966, 0, 0)
            u18.Parent = workspace.Effects
            _G.destroy(u18, 4)
            local u19 = tick()
            local u20 = nil
            u20 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 88 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u18
                    [3] = u20
                    [4] = u7
                    [5] = u14
                    [6] = u16
                    [7] = u17
                --]]
                if tick() - u19 > 0.025 then
                    if u18:FindFirstChild("activeAttach") == nil then
                        u20:Disconnect()
                    end
                    if u18.activeAttach.waveBurst2.Enabled == true then
                        u7:PivotTo(u14 * CFrame.Angles(0, u16.Value, 0) * CFrame.new(0, 0, 2) * CFrame.Angles(0, -3.141592653589793, 1.5707963267948966) * CFrame.Angles(0, 0, u17.Value))
                        u18.CFrame = u14 * CFrame.Angles(0, u16.Value, 0) * CFrame.new(0, 0, 8) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.Angles(0, 0, u17.Value)
                        return
                    end
                    u18.CFrame = u14 * CFrame.Angles(0, u16.Value, 0) * CFrame.new(0, 0, 8) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.Angles(0, 0, u17.Value)
                end
            end)
            _G.PlaySound(u3.PrimaryPart, script["Audio/LawSwordHorizontalSlash"])
            task.wait(0.45)
            local v21 = u20
            for _, v22 in pairs(u18.activeAttach:GetChildren()) do
                v22.Enabled = false
            end
            _G.customEmit(u10.catchAttach, true)
            u2:Create(u18.trailAttach0, TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Position"] = Vector3.new(0, 0, 0)
            }, true):Play()
            u2:Create(u18.trailAttach1, TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Position"] = Vector3.new(0, 0, 0)
            }, true):Play()
            u7:Destroy()
            if u6 then
                u6.Blade.Transparency = 0
            end
            task.wait(0.41)
            v21:Disconnect()
        end)
    end
end
return v1