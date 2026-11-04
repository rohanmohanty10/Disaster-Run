 

local v1 = {}
local u2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
local u3 = require(game:GetService("ReplicatedStorage").Modules.sBeat)
local u4 = Random.new()
game:GetService("TweenService")
function v1.start(_, p5, p6) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u4
    --]]
    if _G.checkRenderDistance(p5.HumanoidRootPart.Position) ~= false then
        local v7 = p5.HumanoidRootPart.CFrame
        _G.PlaySound(p5.HumanoidRootPart, script.Swing)
        _G.PlaySound(p5.HumanoidRootPart, script.Judg)
        _G.PlaySound(p5.HumanoidRootPart, script.Sting)
        _G.PlaySound(p5.HumanoidRootPart, script.More)
        local u8 = script.krakenslash:Clone()
        u8:PivotTo(v7)
        u8.areaswirl.Color = p6
        u8.slashswirl.Color = p6
        u8.SwooshB.Decal.Color3 = Color3.new((p6.R * 120) ^ 1.5 * 0.0039215, (p6.G * 120) ^ 1.5 * 0.0039215, (p6.B * 120) ^ 1.5 * 0.0039215)
        u8.root.Attachment.Sparkles.Color = ColorSequence.new(p6)
        task.spawn(function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u3
            --]]
            for v9 = 0.5, 0, -0.01 do
                u8.SwirlA.Size = u8.SwirlA.Size + Vector3.new(3, 3, 0.15) * v9
                u8.SwirlB.Size = u8.SwirlA.Size * 1.2
                u8.SwirlA.CFrame = u8.SwirlA.CFrame * CFrame.Angles(0, 0, v9)
                u8.SwirlB.CFrame = u8.SwirlB.CFrame * CFrame.Angles(0, 0, -v9 * 0.25)
                u3()
            end
        end)
        local v10 = u8.SwooshA.Mesh.Scale
        local v11 = u8.SwooshB.Mesh.Scale
        u2.Do("slice_veryslow", u8.SwooshA)
        u2.Do("slice_veryslow", u8.SwooshB)
        local v12 = {
            0.5,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        u8.SwooshA.Mesh.Scale = Vector3.new(5.2, 15, 5.2)
        u8.SwooshB.Mesh.Scale = Vector3.new(3.6, 30, 3.6)
        u8.Parent = workspace.Effects
        _G.tween(u8.SwirlA, {
            1.9,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.tween(u8.SwirlB, {
            1.5,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.tween(u8.slashswirl, {
            0.18,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1,
            ["CFrame"] = u8.slashswirl.CFrame * CFrame.Angles(0, 3.13, 0),
            ["Size"] = Vector3.new(35, 3, 35)
        })
        _G.tween(u8.areaswirl, {
            1.3,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1,
            ["CFrame"] = u8.areaswirl.CFrame * CFrame.Angles(0, 3.13, 0),
            ["Size"] = Vector3.new(40, 8.75, 40)
        })
        _G.tween(u8.SwooshA.Mesh, v12, {
            ["Scale"] = v10
        })
        _G.tween(u8.SwooshB.Mesh, v12, {
            ["Scale"] = v11
        })
        local v13 = u8.SwooshA.CFrame
        local v14 = u8.SwooshB.CFrame
        _G.tween(u8.SwooshA, v12, {
            ["CFrame"] = v13
        })
        _G.tween(u8.SwooshB, v12, {
            ["CFrame"] = v14
        })
        for v15 = 1, 5 do
            local v16 = script.Swoosh:Clone()
            local v17 = u4:NextNumber(3.5, 6.5)
            local v18 = u4:NextNumber(0.15, 0.35)
            v16.Mesh.Scale = Vector3.new(v17, 42, v17)
            v16.CFrame = v13 * CFrame.Angles(v15 % 2 == 0 and v18 and v18 or -v18, 0, 0)
            _G.tween(v16.Decal, {
                0.1,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 0
            })
            u2.Do("thswir", v16)
            v16.Parent = u8
        end
        _G.destroy(u8, 5)
        local v19 = u8.root.Attachment
        local v20 = u8.root.Attachment2
        local v21 = Ray.new(p5.HumanoidRootPart.CFrame.Position, p5.HumanoidRootPart.CFrame.upVector * -10)
        local v22, _, _ = _G.raycastWhitelist(v21, { workspace.Islands, workspace.Ships, workspace.Env })
        if v22 then
            v19.sm2.Color = ColorSequence.new(v22.Color)
            _G.customEmit(v19.sm2)
        end
        v19.GroundRings2.Color = ColorSequence.new(p6)
        _G.customEmit(v20.Wave)
        _G.customEmit(v19.BlackWisps)
        _G.customEmit(v19.GroundRings2)
        _G.customEmit(v19.GroundRings)
    end
end
return v1