 

local v1 = {}
local u2 = game:GetService("RunService").Heartbeat
function v1.start(_, p3, _) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.HumanoidRootPart.Position) ~= false then
        local v4 = p3.HumanoidRootPart.CFrame
        _G.PlaySound(p3.HumanoidRootPart, script.Bazooka)
        _G.PlaySound(p3.HumanoidRootPart, script.Woosh)
        local u5 = script.bazooka:Clone()
        u5:SetPrimaryPartCFrame(v4)
        u5.Parent = workspace.Effects
        _G.tween(u5.WaveLeft, {
            0.2,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(25.6, 0.1, 5.3),
            ["CFrame"] = u5.WaveLeft.CFrame * CFrame.new(-5, 0, 1),
            ["Transparency"] = 1
        })
        _G.tween(u5.WaveRight, {
            0.2,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(25.6, 0.1, 5.3),
            ["CFrame"] = u5.WaveRight.CFrame * CFrame.new(-5, 0, 1),
            ["Transparency"] = 1
        })
        _G.tween(u5.Ring, {
            0.8,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u5.Ring.CFrame * CFrame.new(0, 11, 0),
            ["Size"] = Vector3.new(25, 0, 25),
            ["Transparency"] = 1
        })
        _G.tween(u5.Ring2, {
            0.9,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u5.Ring2.CFrame * CFrame.new(0, -11, 0),
            ["Size"] = Vector3.new(17, 0, 17),
            ["Transparency"] = 1
        })
        _G.tween(u5.Shock, {
            0.2,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u5.Shock.CFrame * CFrame.new(10, 0, 0),
            ["Size"] = Vector3.new(20, 9, 9),
            ["Transparency"] = 1
        })
        _G.tween(u5.SwirlLinger, {
            1.4,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u5.SwirlLinger.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, -1.51, 0),
            ["Size"] = Vector3.new(15, 40, 15),
            ["Transparency"] = 1
        })
        _G.destroy(u5, 2)
        local v6 = Ray.new(p3.HumanoidRootPart.CFrame.Position, p3.HumanoidRootPart.CFrame.upVector * -10)
        local v7, _, _ = _G.raycastWhitelist(v6, { workspace.Islands, workspace.Ships, workspace.Env })
        if v7 then
            u5.root.Attachment.sm2.Color = ColorSequence.new(v7.Color)
            _G.customEmit(u5.root)
        end
        task.spawn(function() --[[ Line: 37 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u2
            --]]
            local v8 = u5.SwooshA
            local v9 = u5.SwooshB
            for v10 = 0, 1.2, 0.1 do
                v8.Mesh.Scale = v8.Mesh.Scale + Vector3.new(0.2, 0.2, 0.2)
                v9.Mesh.Scale = v8.Mesh.Scale + Vector3.new(1, 1, 1)
                v8.Decal.Transparency = v10 - 0.15
                v9.Decal.Transparency = v10 - 0.15
                v8.CFrame = v8.CFrame * CFrame.Angles(0, -0.6, 0)
                v9.CFrame = v9.CFrame * CFrame.Angles(0, 0.4, 0)
                u2:Wait()
            end
        end)
        local v11 = script.Part:Clone()
        v11.CFrame = v4 * CFrame.new(0, 0, -3.5)
        v11.Parent = workspace.Effects
        _G.customEmit(v11)
        _G.tween(v11, {
            0.2,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v11.CFrame * CFrame.new(0, 0, -40)
        })
        _G.PlayEffect("RockFollow", nil, v11, 1.75, 2.25)
        _G.destroy(v11, 1)
        for v12 = 1, 3.3333333333333335 do
            local v13 = v4 * CFrame.new(0, 0, v12 * -10) * CFrame.Angles(1.5707963267948966, 0, 0)
            local v14 = 1 - v12 / 5.333333333333334
            _G.PlayEffect("Shockwave2", nil, v13 * CFrame.new(0, 10, 0), v13, BrickColor.new("White"), Vector3.new(35, 1, 35) * v14, Vector3.new(8.75, 1, 8.75) * v14, v12 / 3, 0, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
            game["Run Service"].Heartbeat:Wait()
        end
    end
end
return v1