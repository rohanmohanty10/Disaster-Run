 

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
        local u8 = script.krakenidklol:Clone()
        u8:PivotTo(v7)
        u8.areaswirl.Color = p6
        u8.sliceswirl.Color = p6
        u8.Spike.Color = p6
        u8.SwooshB.Decal.Color3 = Color3.new((p6.R * 120) ^ 1.5 * 0.0039215, (p6.G * 120) ^ 1.5 * 0.0039215, (p6.B * 120) ^ 1.5 * 0.0039215)
        u8.LineA.Decal.Color3 = u8.SwooshB.Decal.Color3
        u8.root.Attachment.Sparkles.Color = ColorSequence.new(p6)
        u8.root.Attachment.Burn.Color = u8.root.Attachment.Sparkles.Color
        task.spawn(function() --[[ Line: 31 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u3
            --]]
            for v9 = 0.25, 0, -0.004 do
                u8.SwirlA.Size = u8.SwirlA.Size + Vector3.new(2.5, 2.5, 0.07) * v9
                u8.SwirlB.Size = u8.SwirlA.Size * 1.2
                u8.SwirlA.CFrame = u8.SwirlA.CFrame * CFrame.Angles(0, 0, v9)
                u8.SwirlB.CFrame = u8.SwirlB.CFrame * CFrame.Angles(0, 0, -v9 * 0.25)
                u3()
            end
        end)
        local v10 = u8.SwooshA.Mesh.Scale
        local v11 = u8.SwooshB.Mesh.Scale
        u2.Do("slice_slow", u8.SwooshA)
        u2.Do("slice_slow", u8.SwooshB)
        u2.Do("slice_veryslow", u8.LineA)
        u2.Do("slice_veryslow", u8.LineB)
        local v12 = {
            0.5,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        u8.SwooshA.Mesh.Scale = Vector3.new(1.2, 40, 2.2)
        u8.SwooshB.Mesh.Scale = Vector3.new(2.6, 50, 3.6)
        u8.Parent = workspace.Effects
        _G.tween(u8.SwirlA, {
            1.3,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.tween(u8.SwirlB, {
            1.5,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.tween(u8.sliceswirl, {
            0.3,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1,
            ["CFrame"] = u8.sliceswirl.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, -3.13, 0),
            ["Size"] = Vector3.new(0.5, 15, 0.5)
        })
        _G.tween(u8.Spike, {
            0.15,
            "ExitProductive",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1,
            ["CFrame"] = u8.Spike.CFrame * CFrame.new(0, 12, 0),
            ["Size"] = Vector3.new(0.5, 40, 0.5)
        })
        _G.tween(u8.areaswirl, {
            0.7,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1,
            ["CFrame"] = u8.areaswirl.CFrame * CFrame.Angles(0, 3.13, 0),
            ["Size"] = Vector3.new(25, 8.75, 25)
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
            local v17 = u4:NextNumber(1.5, 4.5)
            local v18 = u4:NextNumber(0.1, 0.3)
            v16.Mesh.Scale = Vector3.new(v17, 42, v17)
            v16.CFrame = v13 * CFrame.Angles(v15 % 2 == 0 and v18 and v18 or -v18, 0, 0)
            u2.Do("thswir", v16)
            v16.Parent = u8
        end
        _G.destroy(u8, 2)
        local v19 = u8.root.Attachment
        u8.root.Attachment2.Wave:Emit(3)
        v19.Sparkles:Emit(4)
        _G.customEmit(v19.Burn)
    end
end
return v1