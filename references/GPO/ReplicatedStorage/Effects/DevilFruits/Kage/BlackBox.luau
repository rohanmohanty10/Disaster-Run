 

game:GetService("RunService")
local function u3(p1, ...) --[[ Line: 3 ]]
    for _, v2 in { ... } do
        table.insert(p1, v2)
    end
    return p1
end
Emit = _G.Emit
Tween = _G.tween
BeamToggle = _G.Ess.BeamToggle
return {
    ["start"] = function(_, p4, p5, p6) --[[ Name: start, Line 18 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        if p6 and game.Players.LocalPlayer == p6 then
            return
        elseif _G.checkRenderDistance(p5) ~= false then
            Random.new()
            local v7 = p4:FindFirstChildWhichIsA("Humanoid").RootPart
            local v8 = v7.Position
            local _ = (v7.CFrame * CFrame.new(0, -1.7, 0)).Position
            local v9 = p5 + Vector3.new(0, 2.25, 0)
            local u10 = {}
            local u11 = script.Portal:Clone()
            table.insert(u10, u11)
            local v12 = CFrame.new
            local v13 = v8.X
            local v14 = v9.Y
            local v15 = v8.Z
            u11:PivotTo(v12(v9, (Vector3.new(v13, v14, v15))) * CFrame.Angles(0, 0.2617993877991494, 0) + Vector3.new(0, 4, 0))
            u11.Parent = workspace.Effects
            local u16 = u11.pull
            local v17 = u3
            local v18 = { u16["1"], u11.mid.ParticleEmitter }
            local v19 = u16.middle
            local v20 = v17(v18, table.unpack(v19:GetChildren()))
            Emit(v20, false)
            local u21 = script.BlackBox:Clone()
            table.insert(u10, u21)
            local v22 = u21.Bone["Bone.001"]
            local v23 = CFrame.new
            local v24 = u21.Size.Y / 2
            local v25 = v9 + Vector3.new(0, v24, 0)
            local v26 = v8.X
            local v27 = v9.Y + u21.Size.Y / 2
            local v28 = v8.Z
            local v29 = v23(v25, (Vector3.new(v26, v27, v28))) * CFrame.new(0.5, -2, -0.25)
            u21.CFrame = v29 - Vector3.new(0, 15, 0)
            v22.Orientation = v22.Orientation + Vector3.new(-60, 0, 0)
            u21.Parent = workspace.Effects
            local u30 = script.BeanWind:Clone()
            table.insert(u10, u30)
            u30.CFrame = v29
            local u31 = {
                0.7,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }
            local _ = { 1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut }
            local u32 = {
                1,
                Enum.EasingStyle.Cubic,
                Enum.EasingDirection.Out,
                0,
                false
            }
            local u33 = {
                0.5,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.InOut,
                0,
                false,
                0
            }
            local v34 = { 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut }
            local v35 = script.BlackBoxSound:Clone()
            v35.Parent = u21
            v35:Play()
            local u36 = {}
            for v37 = 1, 5 do
                local v38 = u11:FindFirstChild((tostring(v37)))
                local v39 = v38["end"]
                local v40 = v39.WorldPosition + v38.CFrame.LookVector * -3
                v38.CFrame = v38.CFrame * (CFrame.new(-4, 0, 0) - Vector3.new(0, 5, 0))
                Tween(v38, u31, {
                    ["CFrame"] = v38.CFrame * CFrame.new(8, 0, 0) + Vector3.new(0, 5, 0)
                })
                Tween(v39, u31, {
                    ["WorldPosition"] = v40
                })
                u36[v37] = v38
            end
            task.delay(v34[1], function() --[[ Line: 98 ]]
                --[[
                Upvalues:
                    [1] = u11
                --]]
                Emit({ u11.mid.ParticleEmitter }, false)
            end)
            task.wait(0.1)
            Tween(u21, v34, {
                ["CFrame"] = v29
            })
            task.wait(v34[1] + 0.2)
            Tween(v22, { 0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In }, {
                ["Orientation"] = v22.Orientation - Vector3.new(60, 0, 0)
            })
            task.delay(0.2, function() --[[ Line: 112 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u21
                    [3] = u32
                    [4] = u36
                    [5] = u33
                    [6] = u3
                    [7] = u30
                    [8] = u31
                    [9] = u10
                --]]
                Emit(u16.close:GetChildren(), true)
                Tween(u21, u32, {
                    ["Size"] = u21.Size * Vector3.new(2, 1, 2),
                    ["CFrame"] = u21.CFrame * CFrame.new(0, 0, 4)
                })
                for v41 = 1, 5 do
                    local u42 = u36[v41]
                    local u43 = u42["end"]
                    local v44 = u43.WorldPosition + u42.CFrame.LookVector * -5
                    Tween(u42, u32, {
                        ["CFrame"] = u42.CFrame * CFrame.new(5, 0, 0) + Vector3.new(0, 0, 0)
                    })
                    Tween(u43, u32, {
                        ["WorldPosition"] = v44
                    })
                    task.delay(1, function() --[[ Line: 134 ]]
                        --[[
                        Upvalues:
                            [1] = u42
                            [2] = u33
                            [3] = u43
                        --]]
                        Tween(u42, u33, {
                            ["CFrame"] = u42.CFrame * CFrame.new(-16, 0, 0) + Vector3.new(0, 0, 0)
                        })
                        Tween(u43, u33, {
                            ["WorldPosition"] = u43.WorldPosition + u42.CFrame.LookVector * 16
                        })
                        for _, v45 in u42:GetChildren() do
                            if v45:IsA("Beam") then
                                Tween(v45, u33, {
                                    ["TextureSpeed"] = v45.TextureSpeed * 2,
                                    ["Width0"] = 0,
                                    ["Width1"] = 0
                                })
                            elseif v45:IsA("ParticleEmitter") then
                                v45.Enabled = false
                            end
                        end
                    end)
                end
                task.delay(u33[1] - 0.1, function() --[[ Line: 158 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                        [2] = u16
                    --]]
                    local v46 = Emit
                    local v47 = u3
                    local v48 = { u16["1"] }
                    local v49 = u16.middle
                    v46(v47(v48, table.unpack(v49:GetChildren())), false)
                end)
                task.wait(1)
                Tween(u21, u33, {
                    ["Size"] = u21.Size * Vector3.new(0, 1, 0),
                    ["CFrame"] = u21.CFrame * CFrame.new(0, 0, -8),
                    ["Transparency"] = 1
                })
                task.wait(u33[1] / 2)
                u30.Parent = workspace.Effects
                Tween(u30, u31, {
                    ["CFrame"] = u30.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                })
                Tween(u30.Decal, u31, {
                    ["Transparency"] = 1
                })
                Tween(u30.Mesh, { 0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out }, {
                    ["Scale"] = u30.Mesh.Scale * Vector3.new(3, 2, 3)
                })
                task.delay(1, function() --[[ Line: 186 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                    --]]
                    for _, v50 in u10 do
                        _G.destroy(v50, 0.1)
                    end
                end)
            end)
        end
    end
}