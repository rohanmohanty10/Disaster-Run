 

local v1 = {}
function set_transparency(p2, p3)
    for _, v4 in p2:GetChildren() do
        set_transparency(v4, p3)
        if v4:IsA("BasePart") and (v4.Name ~= "HumanoidRootPart" and v4.Name ~= "Middle") then
            v4.Transparency = p3
        end
    end
end
function v1.start(_, p5, p6, p7) --[[ Line: 13 ]]
    if _G.checkRenderDistance(p6.Position) ~= false then
        local v8 = (p6.Position - p7.Position).Magnitude
        local v9 = v8 * 2
        local v10 = v8 * 1.5
        _G.PlaySound(p5.HumanoidRootPart, script.lunge2)
        _G.PlaySound(p5.HumanoidRootPart, script.Strike)
        local v11 = script.lunge:Clone()
        v11:PivotTo(p7)
        v11.Line.Size = Vector3.new(v10, 2, 2)
        v11.Line.CFrame = p6 * CFrame.Angles(0, 1.57, 0) * CFrame.new(v8 * 0.1, 0, 0)
        v11.SwirlLinger.CFrame = v11.SwirlLinger.CFrame * CFrame.new(0, v10, 0)
        v11.Shock.CFrame = v11.Shock.CFrame * CFrame.new(-v8, 0, 0)
        v11.Stab.CFrame = v11.Stab.CFrame * CFrame.new(0, v8 * 1.25, 0)
        v11.WaveLeft.Size = Vector3.new(v9, 8, 0.05)
        v11.WaveRight.Size = v11.WaveLeft.Size
        v11.WaveLeft.CFrame = v11.WaveLeft.CFrame * CFrame.new(-v8 * 0.38, 0, 0)
        v11.WaveRight.CFrame = v11.WaveRight.CFrame * CFrame.new(-v8 * 0.38, 0, 0)
        v11.Parent = workspace.Effects
        v11.root.AppearParticles.WorldCFrame = p6
        v11.root.AppearParticles.Sparkles:Emit(1)
        v11.root.AppearParticles.Waves:Emit(3)
        _G.tween(v11.WaveLeft, {
            0.65,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(v8, 2.5, 0.05),
            ["CFrame"] = v11.WaveLeft.CFrame * CFrame.new(v8, -2.5, 0),
            ["Transparency"] = 1
        })
        _G.tween(v11.WaveRight, {
            0.65,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(v8, 2.5, 0.05),
            ["CFrame"] = v11.WaveRight.CFrame * CFrame.new(v8, -2.5, 0),
            ["Transparency"] = 1
        })
        _G.tween(v11.Shock, {
            0.2,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v11.Shock.CFrame * CFrame.new(v8, 0, 0),
            ["Size"] = Vector3.new(30, 6, 6),
            ["Transparency"] = 1
        })
        _G.tween(v11.SwirlLinger, {
            1.6,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v11.SwirlLinger.CFrame * CFrame.new(0, -v8, 0) * CFrame.Angles(0, -3.11, 0),
            ["Size"] = Vector3.new(8, v8, 8),
            ["Transparency"] = 1
        })
        _G.tween(v11.Line, {
            0.9,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v11.Line.CFrame * CFrame.new(v8 * 1.2, 0, 0),
            ["Size"] = Vector3.new(2, 0, 0),
            ["Transparency"] = 1
        })
        _G.tween(v11.slashswirl, {
            0.55,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1,
            ["CFrame"] = v11.slashswirl.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, 3.13, 0),
            ["Size"] = Vector3.new(2, 6, 2)
        })
        _G.tween(v11.Stab, {
            0.14,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1,
            ["CFrame"] = v11.Stab.CFrame * CFrame.new(0, -v10, 0),
            ["Size"] = Vector3.new(0, 24, 0)
        })
        _G.destroy(v11, 2)
        v11.root.Attachment.CFrame = v11.root.Attachment.CFrame * CFrame.new(0, 0, v8)
        local v12 = Ray.new(p6.Position + Vector3.new(0, 3, 0), p6.upVector * -10)
        local v13, _, _ = _G.raycastIgnoreList(v12, {
            workspace.Effects,
            workspace.Projectiles,
            workspace.PlayerCharacters,
            workspace.NPCs,
            workspace.Ragdolls
        })
        if v13 then
            v11.root.Attachment.sm2.Color = ColorSequence.new(v13.Color)
            _G.customEmit(v11.root.Attachment.sm2)
        end
    end
end
return v1