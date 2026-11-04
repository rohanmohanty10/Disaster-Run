 

local v1 = {}
local u2 = game:GetService("RunService").Heartbeat
function v1.start(_, u3, u4, _) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(u3.HumanoidRootPart.Position) ~= false then
        _G.PlaySound(u3.HumanoidRootPart, script.Rifle)
        _G.PlaySound(u3.HumanoidRootPart, script.Woosh)
        local u5 = script.rifleefx:Clone()
        u5:PivotTo(u3.HumanoidRootPart.CFrame)
        u5.Parent = workspace.Effects
        _G.tween(u5.Ring, {
            0.4,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u5.Ring.CFrame * CFrame.new(0, -9, 0),
            ["Size"] = Vector3.new(14, 0, 14),
            ["Transparency"] = 1
        })
        _G.tween(u5.Impact, {
            0.15,
            "EntranceExpressive",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["CFrame"] = u5.Impact.CFrame * CFrame.new(0, 3, 0),
            ["Size"] = Vector3.new(0, 0, 0),
            ["Transparency"] = 1
        })
        _G.tween(u5.Shock, {
            0.1,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u5.Shock.CFrame * CFrame.new(10, 0, 0),
            ["Size"] = Vector3.new(20, 9, 9),
            ["Transparency"] = 1
        })
        _G.destroy(u5, 2)
        _G.PlayEffect("meshShock", nil, u3.RightHand.CFrame, 15, 0.5)
        spawn(function() --[[ Line: 24 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u2
            --]]
            local v6 = u5.SwooshA
            local v7 = u5.SwooshB
            for v8 = 0, 1.2, 0.05 do
                v6.Mesh.Scale = v6.Mesh.Scale + Vector3.new(0.15, 0.15, 0.15)
                v7.Mesh.Scale = v6.Mesh.Scale + Vector3.new(0.5, 0.5, 0.5)
                v6.Decal.Transparency = v8
                v7.Decal.Transparency = v8
                v6.CFrame = v6.CFrame * CFrame.Angles(0, 0.4, 0)
                v7.CFrame = v7.CFrame * CFrame.Angles(0, -0.2, 0)
                u2:Wait()
            end
        end)
        local u9 = script.SwirlLight
        delay(0.5, function() --[[ Line: 37 ]]
            --[[
            Upvalues:
                [1] = u9
            --]]
            u9 = script.SwirlHeavy
        end)
        delay(0, function() --[[ Line: 40 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u3
                [3] = u9
            --]]
            if u4:FindFirstChild("LowerTorso") then
                local v10 = script.wooshy.root.Fast.Waves:Clone()
                v10.Parent = u4.LowerTorso
                for v11 = 1, 35 do
                    task.wait()
                    if v11 % 4 == 0 then
                        local v12 = u3.RightHand.CFrame * CFrame.Angles(0, v11, 0)
                        local v13 = u9:Clone()
                        v13.CFrame = v12
                        v13.Parent = workspace.Effects
                        _G.tween(v13, {
                            0.18,
                            "EntranceExpressive",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["CFrame"] = v13.CFrame * CFrame.Angles(0, 3.12, 0) * CFrame.new(0, 2, 0),
                            ["Size"] = Vector3.new(3, 2, 3),
                            ["Transparency"] = 1
                        })
                        _G.destroy(v13, 0.2)
                    end
                    if v11 > 20 then
                        v10:Emit(1)
                    end
                end
                v10:Destroy()
            end
        end)
    end
end
return v1