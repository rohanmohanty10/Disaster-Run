 

local v1 = {}
local u2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
require(game:GetService("ReplicatedStorage").Modules.sBeat)
function v1.start(_, p3, p4, p5) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p4.Position) ~= false then
        local u6 = (p4.Position - p5.Position).Magnitude
        local _ = u6 * 2
        local _ = u6 * 1.5
        local u7 = CFrame.new(p4.Position, p5.Position)
        _G.PlaySound(p3.HumanoidRootPart, script.Slash)
        _G.PlaySound(p3.HumanoidRootPart, script.Flurry)
        _G.PlaySound(p3.HumanoidRootPart, script.spin)
        local u8 = script.tornado:Clone()
        u8:PivotTo(p4)
        u8.SwirlLinger.CFrame = u7 * CFrame.Angles(1.5707963267948966, 0, 1.5707963267948966)
        u8.FinalSwoosh.CFrame = p5 * u8.FinalSwoosh.CFOffset.Value
        u8.Parent = workspace.Effects
        _G.tween(u8.Shock, {
            0.12,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u8.Shock.CFrame * CFrame.new(u6, 0, 0),
            ["Size"] = Vector3.new(u6, 1, 1),
            ["Transparency"] = 1
        })
        _G.tween(u8.SwirlLinger, {
            1.4,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u8.SwirlLinger.CFrame * CFrame.new(-u6 * 0.5, 0, 0) * CFrame.Angles(3.11, 0, 0),
            ["Size"] = Vector3.new(u6, 3, 2),
            ["Transparency"] = 1
        })
        _G.tween(u8.SwirlA, {
            1,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u8.SwirlA.CFrame * CFrame.Angles(0, 0, -2.13),
            ["Size"] = Vector3.new(32, 32, 4),
            ["Transparency"] = 1
        })
        _G.tween(u8.SwirlB, {
            0.87,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u8.SwirlB.CFrame * CFrame.Angles(0, 0, 3.13),
            ["Size"] = Vector3.new(36, 36, 5),
            ["Transparency"] = 1
        })
        _G.tween(u8.tornado1, {
            0.8,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u8.tornado1.CFrame * CFrame.new(0, u6, 0) * CFrame.Angles(0, -3.13, 0),
            ["Size"] = Vector3.new(8, u6, 8),
            ["Transparency"] = 1
        })
        _G.tween(u8.tornado2, {
            0.25,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u8.tornado2.CFrame * CFrame.new(0, u6 * 0.5, 0) * CFrame.Angles(0, -2.763, 0),
            ["Size"] = Vector3.new(18, u6, 18),
            ["Transparency"] = 1
        })
        u2.Do("slice_slow", u8.FirstSwoosh)
        _G.destroy(u8, 2)
        u8.root.Attachment.Sparkles:Emit(2)
        local v9 = Ray.new(p4.Position + Vector3.new(0, 3, 0), p4.upVector * -10)
        local v10, _, _ = _G.raycastIgnoreList(v9, {
            workspace.Effects,
            workspace.Projectiles,
            workspace.PlayerCharacters,
            workspace.NPCs,
            workspace.Ragdolls
        })
        if v10 then
            u8.root.Attachment.sm2.Color = ColorSequence.new(v10.Color)
            _G.customEmit(u8.root.Attachment.sm2)
        end
        spawn(function() --[[ Line: 53 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u7
                [3] = u8
                [4] = u2
            --]]
            local v11 = u6 / 3
            local v12 = Random.new()
            for v13 = 1, 3 do
                local v14 = u7 * CFrame.new(0, 0, -v13 * v11) * CFrame.Angles(v13 * 2.5, v12:NextNumber(-0.2, 0.2), v12:NextNumber(-3.3415926535897933, -2.941592653589793))
                local v15 = script.Swoosh:Clone()
                v15.CFrame = v14
                v15.Mesh.Scale = Vector3.new(1.25, 50, 1.25) + Vector3.new(0.7, 5, 0.5) * v13
                v15.Parent = u8
                u2.Do("thswir", v15)
                task.wait()
            end
            u8.FinalSwoosh.Mesh.Scale = u8.FinalSwoosh.Mesh.Scale + Vector3.new(3, 8, 3)
            _G.tween(u8.FinalSwoosh.Mesh, { 0.4, "Quart", Enum.EasingDirection.Out }, {
                ["Scale"] = u8.FinalSwoosh.Mesh.Scale - Vector3.new(3, 8, 3)
            })
            u2.Do("slice_slow", u8.FinalSwoosh)
        end)
    end
end
return v1