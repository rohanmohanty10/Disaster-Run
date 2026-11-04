 

game:GetService("RunService")
local u1 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 7 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u3 = p2.fireCFrame
        local u4 = p2.prestige
        local u5 = p2.speedMult
        local u6 = p2.char
        if _G.checkRenderDistance(u3.Position) ~= false then
            local u7 = RaycastParams.new()
            u7.FilterType = Enum.RaycastFilterType.Whitelist
            u7.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
            local v8 = u3 * CFrame.new(0, 0, -6)
            local v9 = workspace:Raycast(v8.Position, v8.UpVector * Vector3.new(0, -25, 0), u7)
            if v9 then
                local v10 = CFrame.new(v9.Position, v9.Position + v9.Normal)
                local v11 = script.LandFloor:Clone()
                if u4 == true then
                    v11:Destroy()
                    v11 = script.LandFloorPrestige:Clone()
                end
                u1.apply(v11, u6)
                v11.CFrame = v10
                v11.Parent = workspace.Effects
                _G.destroy(v11, 3)
                _G.customEmit(v11.Attachment)
                _G.PlaySound(u3, script.TripleImpactStart)
                for _, v12 in ipairs(v11.Enable:GetChildren()) do
                    v12.Enabled = true
                end
                task.spawn(function() --[[ Line: 36 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                        [2] = u7
                        [3] = u4
                        [4] = u1
                        [5] = u6
                        [6] = u5
                    --]]
                    for v13 = 1, 3 do
                        local v14 = u3 * CFrame.new(0, 0, -(v13 * (v13 * 4) + 6))
                        local v15 = workspace:Raycast(v14.Position, v14.UpVector * Vector3.new(0, -25, 0), u7)
                        if v15 then
                            local v16 = CFrame.new(v15.Position, v15.Position + v15.Normal)
                            local u17 = script.markers:Clone()
                            if u4 == true then
                                u17.Color = Color3.fromRGB(85, 85, 255)
                            end
                            u1.apply(u17, u6)
                            local v18 = CFrame.Angles
                            local v19 = math.random(0, 360)
                            u17.CFrame = v16 * v18(-1.5707963267948966, math.rad(v19), 0)
                            u17.Parent = workspace.Effects
                            _G.tween(u17, {
                                0.6 / u5,
                                "Exponential",
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["CFrame"] = u17.CFrame * CFrame.Angles(0, 1.0471975511965976, 0),
                                ["Size"] = Vector3.new(7, 0.15, 7) * v13
                            })
                            task.delay(0.45 / u5, function() --[[ Line: 50 ]]
                                --[[
                                Upvalues:
                                    [1] = u17
                                --]]
                                _G.tween(u17, {
                                    0.2,
                                    "Quad",
                                    Enum.EasingDirection.In,
                                    0,
                                    false,
                                    0
                                }, {
                                    ["CFrame"] = u17.CFrame * CFrame.Angles(0, -1.0471975511965976, 0),
                                    ["Size"] = Vector3.new(0, 0, 0)
                                })
                            end)
                            _G.destroy(u17, 1)
                            _G.PlaySound(u17, script.TripleGroundMarker)
                        end
                        task.wait(0.1)
                    end
                end)
                task.wait(0.6 / u5)
                _G.PlaySound(u3, script.TripleImpactSwordPull)
                for _, v20 in ipairs(v11.Enable:GetChildren()) do
                    v20.Enabled = false
                end
                _G.customEmit(v11.Attachment)
            end
        end
    end
}