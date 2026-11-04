 

local v1 = {}
local u2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
local u3 = game:GetService("RunService").Heartbeat
local u4 = Random.new()
game:GetService("TweenService")
TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
function v1.start(_, p5, p6) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
    --]]
    if _G.checkRenderDistance(p5.Position) ~= false then
        _G.PlaySound(p6.HumanoidRootPart, script.Woosh)
        _G.PlaySound(p6.HumanoidRootPart, script.Flurry)
        local u7 = script.poundv3:Clone()
        if p6:FindFirstChild("BusoMelee") then
            u7:Destroy()
            u7 = script.poundv3Buso:Clone()
            require(script.Parent.BusoColor):applyColors(p6, u7)
        end
        u7:PivotTo(p5)
        u7.Parent = workspace.Effects
        _G.tween(u7.ShockwaveA, {
            0.4,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(16.911, 5.395, 4.277),
            ["CFrame"] = u7.ShockwaveA.CFrame * CFrame.new(-4, 2, -1),
            ["Transparency"] = 1
        })
        _G.tween(u7.ShockwaveB, {
            0.4,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(16.911, 5.395, 4.277),
            ["CFrame"] = u7.ShockwaveB.CFrame * CFrame.new(-4, 2, 1),
            ["Transparency"] = 1
        })
        u2.Do("slice_slow", u7.SwooshA)
        u2.Do("slice_slow", u7.SwooshB)
        _G.tween(u7.FrontBig, {
            0.5,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(16, 12, 16),
            ["CFrame"] = u7.FrontBig.CFrame * CFrame.new(0, 3, 0) * CFrame.Angles(0, -3.13, 0),
            ["Transparency"] = 1
        })
        task.spawn(function() --[[ Line: 34 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u3
            --]]
            local u8 = u7.WindS1
            local u9 = u7.WindS2
            local u10 = u7.SwooshA
            local u11 = u7.SwooshB
            for u12 = 0, 1, 0.04 do
                if pcall(function() --[[ Line: 40 ]]
                    --[[
                    Upvalues:
                        [1] = u12
                        [2] = u8
                        [3] = u9
                        [4] = u10
                        [5] = u11
                    --]]
                    local v13 = 1 - u12
                    u8.Size = u8.Size + Vector3.new(1.9, 0, 1.9) * v13
                    u9.Size = u9.Size + Vector3.new(1.9, 0, 1.9) * v13
                    u8.Transparency = u12 + 0.3
                    u9.Transparency = u8.Transparency
                    u8.CFrame = u8.CFrame * CFrame.Angles(0, u12 * 0.6 + -0.6, 0)
                    u9.CFrame = u9.CFrame * CFrame.Angles(0, u12 * 0.3 + -0.3, 0)
                    u10.Mesh.Scale = u10.Mesh.Scale + Vector3.new(0.005, 0.005, 0.005)
                    u11.Mesh.Scale = u11.Mesh.Scale + Vector3.new(0.005, 0.005, 0.005)
                end) == false then
                    break
                end
                u3:Wait()
            end
        end)
        local v14 = script.Part:Clone()
        v14.Parent = workspace.Effects
        v14.CFrame = p5 * CFrame.Angles(3.141592653589793, 0, 0)
        local v15 = v14.Size
        local v16 = v15.y
        v14.Size = Vector3.new(2, v16, 2)
        _G.tween(v14, {
            0.25,
            "Linear",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = p5 * CFrame.new(0, 0, -55),
            ["Size"] = v15
        })
        _G.PlayEffect("RockFollow", nil, v14, 1.5, 2, true, 0.25)
        _G.destroy(v14, 0.25)
        spawn(function() --[[ Line: 66 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u4
                [3] = u2
                [4] = u3
            --]]
            local v17 = u7.FrontTravel
            local v18 = u7.SwooshTravel
            for _ = 1, 15 do
                v17.CFrame = v17.CFrame * CFrame.new(0, 3, 0) * CFrame.Angles(0, -0.7, 0)
                local v19 = v18:Clone()
                v19.CFrame = v17.CFrame * CFrame.Angles(u4:NextNumber(-5, 5), u4:NextNumber(-5, 5), u4:NextNumber(-5, 5))
                v19.Mesh.Scale = Vector3.new(1, 1, 1) * u4:NextNumber(1.25, 5)
                v19.Decal.Transparency = 0
                u2.Do("slice_quick", v19)
                v19.Parent = u7
                v17.Sparkles:Emit(2)
                u3:Wait()
            end
            _G.tween(v17, {
                0.25,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(0, 4, 0),
                ["CFrame"] = u7.FrontTravel.CFrame * CFrame.new(0, 15, 0) * CFrame.Angles(0, -3.13, 0),
                ["Transparency"] = 1
            })
        end)
        _G.destroy(u7, 5)
    end
end
return v1