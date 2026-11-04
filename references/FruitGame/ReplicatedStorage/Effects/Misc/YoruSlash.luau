 

local v1 = {}
require(script.Parent.Lightning)
local u2 = {}
local function u8() --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2 = {}
    local v3 = workspace.Islands:GetDescendants()
    local v4 = {}
    for v5 = 1, #v3 do
        if v3[v5].Parent.Name:match("Tree") and v4[v3[v5].Parent] == nil then
            v4[v3[v5].Parent] = true
            local v6 = u2
            local v7 = v3[v5].Parent
            table.insert(v6, v7)
        end
    end
end
function v1.start(_, p9) --[[ Line: 47 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u2
    --]]
    if _G.checkRenderDistance(p9.HumanoidRootPart.Position) ~= false then
        local u10 = p9.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0)
        local v11 = CFrame.Angles(0, 1.6580627893946132, 0)
        local u12 = p9.HumanoidRootPart.CFrame * v11
        local u13 = 15
        local u14 = 6.666666666666667
        local u15 = Vector3.new(4, 4, 4)
        task.spawn(function() --[[ Line: 6 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u12
                [3] = u14
                [4] = u15
            --]]
            for v16 = 1, u13 do
                local v17 = u12 * CFrame.new(u14 * v16, 0, 0)
                local v18 = Ray.new(v17.Position + Vector3.new(0, 2, 0), v17.upVector * -15)
                local v19, v20, _ = _G.raycastIgnoreList(v18, {
                    workspace.Effects,
                    workspace.Projectiles,
                    workspace.NPCs,
                    workspace.PlayerCharacters,
                    workspace.Ragdolls
                })
                if v19 then
                    local u21 = script.Part2:Clone()
                    u21.Parent = workspace.Effects
                    _G.matchMaterial(u21, v19)
                    u21.Attachment.sm.Color = ColorSequence.new(u21.Color)
                    u21.Attachment.sm.Size = NumberSequence.new(u15.Magnitude / 2)
                    u21.Size = u15 * (v16 / u13 + 0.2)
                    local v22 = u21.Attachment
                    local v23 = u15.Y
                    v22.Position = Vector3.new(0, v23, 0)
                    local v24 = CFrame.new(v20)
                    local v25 = CFrame.Angles
                    local v26 = math.random(-360, 360)
                    local v27 = math.rad(v26)
                    local v28 = math.random(-360, 360)
                    local v29 = math.rad(v28)
                    local v30 = math.random(-360, 360)
                    local u31 = v24 * v25(v27, v29, (math.rad(v30)))
                    u21.CFrame = CFrame.new(u31.Position) * CFrame.new(0, -u15.Y / 2, 0)
                    _G.tween(u21, {
                        0.25,
                        Enum.EasingStyle.Exponential,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["CFrame"] = u31
                    })
                    _G.destroy(u21, 3)
                    task.spawn(function() --[[ Line: 26 ]]
                        --[[
                        Upvalues:
                            [1] = u21
                            [2] = u31
                            [3] = u15
                        --]]
                        task.wait(1)
                        _G.tween(u21, {
                            1,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["CFrame"] = CFrame.new(u31.Position) * CFrame.new(0, -u15.Y / 2, 0),
                            ["Transparency"] = 1
                        })
                    end)
                end
                game["Run Service"].Heartbeat:Wait()
            end
        end)
        local v32 = CFrame.Angles(0, 1.4835298641951802, 0)
        local u33 = p9.HumanoidRootPart.CFrame * v32
        local u34 = 15
        local u35 = 6.666666666666667
        local u36 = Vector3.new(4, 4, 4)
        task.spawn(function() --[[ Line: 6 ]]
            --[[
            Upvalues:
                [1] = u34
                [2] = u33
                [3] = u35
                [4] = u36
            --]]
            for v37 = 1, u34 do
                local v38 = u33 * CFrame.new(u35 * v37, 0, 0)
                local v39 = Ray.new(v38.Position + Vector3.new(0, 2, 0), v38.upVector * -15)
                local v40, v41, _ = _G.raycastIgnoreList(v39, {
                    workspace.Effects,
                    workspace.Projectiles,
                    workspace.NPCs,
                    workspace.PlayerCharacters,
                    workspace.Ragdolls
                })
                if v40 then
                    local u42 = script.Part2:Clone()
                    u42.Parent = workspace.Effects
                    _G.matchMaterial(u42, v40)
                    u42.Attachment.sm.Color = ColorSequence.new(u42.Color)
                    u42.Attachment.sm.Size = NumberSequence.new(u36.Magnitude / 2)
                    u42.Size = u36 * (v37 / u34 + 0.2)
                    local v43 = u42.Attachment
                    local v44 = u36.Y
                    v43.Position = Vector3.new(0, v44, 0)
                    local v45 = CFrame.new(v41)
                    local v46 = CFrame.Angles
                    local v47 = math.random(-360, 360)
                    local v48 = math.rad(v47)
                    local v49 = math.random(-360, 360)
                    local v50 = math.rad(v49)
                    local v51 = math.random(-360, 360)
                    local u52 = v45 * v46(v48, v50, (math.rad(v51)))
                    u42.CFrame = CFrame.new(u52.Position) * CFrame.new(0, -u36.Y / 2, 0)
                    _G.tween(u42, {
                        0.25,
                        Enum.EasingStyle.Exponential,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["CFrame"] = u52
                    })
                    _G.destroy(u42, 3)
                    task.spawn(function() --[[ Line: 26 ]]
                        --[[
                        Upvalues:
                            [1] = u42
                            [2] = u52
                            [3] = u36
                        --]]
                        task.wait(1)
                        _G.tween(u42, {
                            1,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["CFrame"] = CFrame.new(u52.Position) * CFrame.new(0, -u36.Y / 2, 0),
                            ["Transparency"] = 1
                        })
                    end)
                end
                game["Run Service"].Heartbeat:Wait()
            end
        end)
        task.spawn(function() --[[ Line: 63 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u8
                [3] = u2
            --]]
            task.wait()
            local u53 = u10
            u8()
            local u54 = u2
            local v55 = {
                workspace.Effects,
                workspace.PlayerCharacters,
                workspace.NPCs,
                workspace.Projectiles,
                workspace.Ragdolls,
                workspace.CurrentCamera
            }
            local u56 = nil
            local u57 = {}
            for v58 = 1, #v55 do
                local v59 = v55[v58]
                table.insert(u54, v59)
            end
            for u60 = 1, 100 do
                scheduler:QueueTask(function() --[[ Line: 77 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                        [2] = u60
                        [3] = u54
                        [4] = u53
                        [5] = u56
                        [6] = u57
                    --]]
                    local v61 = u10 * CFrame.new(0, 0, (u60 - 1) / 10 * -10)
                    local v62 = v61 * CFrame.new(0, 50, 0)
                    local v63 = Ray.new(v62.Position, v62.upVector * -100)
                    local u64, v65 = _G.raycastIgnoreList(v63, u54)
                    if u64 then
                        local _ = (v61.Position - v65).Magnitude
                        local v66 = CFrame.new(v65)
                        local u67 = script.trail:Clone()
                        local v68 = (u53.Position - v66.Position).Magnitude
                        u67.CFrame = CFrame.new(u53.Position, v66.Position) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -v68 / 2, 0)
                        local u69 = u60 / 100
                        local v70 = u60 / 100 * 2
                        local v71 = Vector3.new(v70, v68, 0.1)
                        u56 = (u67.CFrame * CFrame.new(0, 0, v68)).Y
                        u67.Mesh.Scale = Vector3.new(0, v68, 0)
                        u67.Parent = workspace.Effects
                        local u72 = NumberSequence.new(u69 * 10)
                        local u73 = NumberRange.new(u69 * 150 / 2, u69 * 150)
                        local u74 = NumberRange.new(u69 * 200 / 2, u69 * 200)
                        task.spawn(function() --[[ Line: 102 ]]
                            --[[
                            Upvalues:
                                [1] = u69
                                [2] = u67
                                [3] = u73
                                [4] = u74
                                [5] = u72
                                [6] = u64
                            --]]
                            task.wait(u69 * 0.2)
                            u67.dust.Speed = u73
                            u67.dust2.Speed = u73
                            u67.rock.Speed = u74
                            u67.dust.Size = u72
                            u67.dust2.Size = u72
                            u67.dust.Color = ColorSequence.new(u64.Color)
                            u67.dust2.Color = ColorSequence.new(u64.Color)
                            u67.rock.Color = ColorSequence.new(u64.Color)
                            u67.rock:Emit(2)
                            u67.dust:Emit(5)
                            u67.dust2:Emit(5)
                        end)
                        _G.tween(u67, {
                            0.5,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Color"] = Color3.fromRGB(0, 0, 0)
                        })
                        _G.tween(u67.Mesh, {
                            0.5,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Scale"] = v71
                        })
                        u53 = CFrame.new(v65)
                        local _ = u67.CFrame
                        local v75 = u57
                        table.insert(v75, u67)
                    end
                end)
            end
            task.wait(1)
            for v76 = 1, #u57 do
                local v77 = _G.tween
                local v78 = u57[v76].Mesh
                local v79 = {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v80 = {}
                local v81 = u57[v76].Mesh.Scale.Y
                v80.Scale = Vector3.new(0, v81, 0)
                v77(v78, v79, v80)
                _G.destroy(u57[v76], 2)
            end
        end)
        local v82 = script.Main:Clone()
        v82.Parent = workspace.Effects
        v82.CFrame = u10 * CFrame.Angles(0, 3.141592653589793, 1.5707963267948966) * CFrame.new(0, 0, 22.5)
        v82.Mesh.Scale = Vector3.new(0, 0, 0)
        _G.tween(v82.Mesh, {
            0.25,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = script.Main.Mesh.Scale,
            ["Offset"] = Vector3.new(0, 0, -50)
        })
        _G.tween(v82.decal, {
            0.5,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.tween(v82, {
            0.5,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v82.CFrame * CFrame.new(0, 0, 100)
        })
        _G.destroy(v82, 0.5)
    end
end
return v1