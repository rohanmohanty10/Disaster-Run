 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.HumanoidRootPart.Position) then
            local v2 = p1.PrimaryPart:FindFirstChild("burnMochi")
            local v3
            if v2 then
                v3 = v2.Value
                v2:Destroy()
            else
                v3 = v2
            end
            if v3 then
                v3.HotBall.Fire.Enabled = false
                local _ = p1.HumanoidRootPart.CFrame
                _G.PlaySound(p1.HumanoidRootPart, script.Shoot)
                _G.PlaySound(p1.HumanoidRootPart, script.Woosh)
                local v4 = script.burnshoot:Clone()
                v4:PivotTo(p1.HumanoidRootPart.CFrame)
                v4.Parent = workspace.Effects
                _G.tween(v4.WaveLeft, {
                    0.35,
                    "FabricDecelerate",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(24, 4, 0.05),
                    ["CFrame"] = v4.WaveLeft.CFrame * CFrame.new(-12, -1, -3),
                    ["Transparency"] = 1
                })
                _G.tween(v4.WaveRight, {
                    0.35,
                    "FabricDecelerate",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(24, 4, 0.05),
                    ["CFrame"] = v4.WaveRight.CFrame * CFrame.new(-12, -1, 3),
                    ["Transparency"] = 1
                })
                _G.tween(v4.Shock, {
                    0.1,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = v4.Shock.CFrame * CFrame.new(8, 0, 0),
                    ["Size"] = Vector3.new(55, 12, 12),
                    ["Transparency"] = 1
                })
                _G.tween(v4.SwirlLinger, {
                    1.4,
                    "FabricDecelerate",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = v4.SwirlLinger.CFrame * CFrame.new(0, 4, 0) * CFrame.Angles(0, -3.11, 0),
                    ["Size"] = Vector3.new(12, 18, 12),
                    ["Transparency"] = 1
                })
                _G.tween(v4.slashswirl, {
                    0.2,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1,
                    ["CFrame"] = v4.slashswirl.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, 3.13, 0),
                    ["Size"] = Vector3.new(18, 4, 18)
                })
                _G.tween(v4.Stab, {
                    0.07,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1,
                    ["CFrame"] = v4.Stab.CFrame * CFrame.new(0, -4, 0),
                    ["Size"] = Vector3.new(0, 48, 0)
                })
                _G.tween(v4.root.PointLight, {
                    0.25,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Range"] = 45,
                    ["Brightness"] = 0
                })
                local v5 = Ray.new(p1.HumanoidRootPart.CFrame.Position, p1.HumanoidRootPart.CFrame.upVector * -10)
                local v6, _, _ = _G.raycastWhitelist(v5, { workspace.Islands, workspace.Ships, workspace.Env })
                if v6 then
                    v4.root.GroundAttachment.sm2.Color = ColorSequence.new(v6.Color)
                else
                    v4.root.GroundAttachment.sm2:Destroy()
                end
                _G.customEmit(v4)
                _G.destroy(v4, 3)
                for _, v7 in v3:GetChildren() do
                    v7.Transparency = 1
                end
                _G.destroy(v3, 2.5)
                v3.Name = "tobecleared"
            end
        else
            return
        end
    end
}