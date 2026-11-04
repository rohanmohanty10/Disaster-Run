 

local u1 = {
    "rbxassetid://14180004270",
    "rbxassetid://14180008643",
    "rbxassetid://14180008466",
    "rbxassetid://14180008276",
    "rbxassetid://14179995622",
    "rbxassetid://14179995395",
    "rbxassetid://14179995198",
    "rbxassetid://14179994973",
    "rbxassetid://14179994663",
    "rbxassetid://14179994433",
    "rbxassetid://14179986193",
    "rbxassetid://14179985950",
    "rbxassetid://14179985701",
    "rbxassetid://14179985442",
    "rbxassetid://14179985161",
    "rbxassetid://14179984874"
}
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
local u3 = game:GetService("TweenService")
local u4 = Random.new()
local u5 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
return {
    ["start"] = function(_, p6, u7, u8) --[[ Name: start, Line 154 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u5
            [4] = u4
            [5] = u1
        --]]
        local u9 = u7.Parent
        if _G.checkRenderDistance(p6.Position) ~= false then
            local u10 = _G.FPS
            local u11 = 60 / _G.FPS
            local u12 = workspace.CurrentCamera
            local u13 = true
            task.delay(u8, function() --[[ Line: 163 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13 = false
            end)
            local v14 = p6 * CFrame.new(0, 0, -50)
            local v15 = (v14.Position - p6.Position).Magnitude
            local v16 = workspace:Raycast(p6.Position, v14.Position - p6.Position, u2)
            if v16 then
                v15 = (v16.Position - p6.Position).Magnitude
                local _ = p6 * CFrame.new(0, 0, -v15)
            end
            _G.PlaySound(u7, script["Audio/ShadowOnslaught"])
            task.spawn(function() --[[ Line: 181 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u12
                    [3] = u7
                    [4] = u3
                    [5] = u10
                --]]
                local v17 = script.ColorCorrection:Clone()
                local v18 = v17.Brightness
                local v19 = v17.Contrast
                local v20 = v17.Saturation
                local v21 = v17.TintColor
                v17.Brightness = 0
                v17.Contrast = 0
                v17.Saturation = 0
                v17.TintColor = Color3.new(1, 1, 1)
                v17.Parent = game:GetService("Lighting")
                local v22 = tick()
                while tick() - v22 <= u8 - 0.2 do
                    if (u12.CFrame.Position - u7.Position).Magnitude <= 125 then
                        u3:Create(v17, TweenInfo.new(0.2), {
                            ["Brightness"] = v18,
                            ["Contrast"] = v19,
                            ["Saturation"] = v20,
                            ["TintColor"] = v21
                        }):Play()
                    else
                        u3:Create(v17, TweenInfo.new(0.2), {
                            ["Brightness"] = 0,
                            ["Contrast"] = 0,
                            ["Saturation"] = 0,
                            ["TintColor"] = Color3.new(1, 1, 1)
                        }):Play()
                    end
                    task.wait(1 / u10)
                end
                u3:Create(v17, TweenInfo.new(0.2), {
                    ["Brightness"] = 0,
                    ["Contrast"] = 0,
                    ["Saturation"] = 0,
                    ["TintColor"] = Color3.new(1, 1, 1)
                }):Play()
                task.wait(0.2)
                v17:Destroy()
            end)
            task.spawn(function() --[[ Line: 230 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u5
                    [3] = u9
                    [4] = u7
                    [5] = u4
                    [6] = u3
                    [7] = u2
                --]]
                local v23 = tick()
                local u24 = nil
                while tick() - v23 <= u8 do
                    task.spawn(function() --[[ Line: 236 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                            [2] = u9
                            [3] = u7
                            [4] = u4
                            [5] = u3
                        --]]
                        local u25 = script.Fear:Clone()
                        u5.apply(u25, u9)
                        u25.CFrame = u7.CFrame * CFrame.new(u4:NextNumber(-15, 15), u4:NextNumber(-1, 12), u4:NextNumber(-5, 5))
                        task.spawn(function() --[[ Line: 241 ]]
                            --[[
                            Upvalues:
                                [1] = u25
                                [2] = u3
                            --]]
                            local v26 = u25.LightAttachment.PointLight
                            local v27 = v26.Range
                            v26.Range = 0
                            u3:Create(v26, TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, true), {
                                ["Range"] = v27
                            }):Play()
                        end)
                        u25.Parent = workspace.Effects
                        task.wait(0.05)
                        _G.customEmit(u25)
                        _G.destroy(u25, 2)
                    end)
                    task.spawn(function() --[[ Line: 261 ]]
                        --[[
                        Upvalues:
                            [1] = u7
                            [2] = u4
                            [3] = u24
                            [4] = u2
                            [5] = u5
                            [6] = u9
                        --]]
                        local v28 = (u7.CFrame * CFrame.new(u4:NextNumber(-10, 10), 0, u4:NextNumber(-10, 10))).Position
                        u24 = workspace:Raycast(v28 + Vector3.new(0, 10, 0), Vector3.new(0, -30, 0), u2)
                        if u24 then
                            local v29 = script.ShadowFloorExplode:Clone()
                            u5.apply(v29, u9)
                            v29.CFrame = CFrame.lookAt(u24.Position, u24.Position + u24.Normal)
                            v29.Parent = workspace.Effects
                            _G.customEmit(v29)
                            task.wait(2)
                            v29:Destroy()
                        end
                    end)
                    task.wait(0.05)
                end
            end)
            local u30 = script.DashParticleEffect:Clone()
            u5.apply(u30, u9)
            u30.Weld.Part0 = u7
            task.spawn(function() --[[ Line: 289 ]]
                --[[
                Upvalues:
                    [1] = u30
                    [2] = u3
                    [3] = u8
                --]]
                local v31 = u30.LightAttachment.PointLight
                local v32 = v31.Range
                v31.Range = 0
                u3:Create(v31, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    ["Range"] = v32
                }):Play()
                task.wait(u8)
                u3:Create(v31, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                    ["Range"] = 0
                }):Play()
            end)
            u30.Parent = workspace.Effects
            _G.customEmit(u30)
            task.delay(u8, function() --[[ Line: 310 ]]
                --[[
                Upvalues:
                    [1] = u30
                --]]
                _G.particleEnabled(u30, false)
            end)
            local u33 = tick()
            task.spawn(function() --[[ Line: 317 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u8
                    [3] = u5
                    [4] = u9
                    [5] = u7
                    [6] = u4
                    [7] = u3
                    [8] = u1
                    [9] = u10
                --]]
                while tick() - u33 <= u8 - 0.1 do
                    local u34 = script.PartMesh:Clone()
                    u5.apply(u34, u9)
                    u34.Weld.Part0 = u7
                    u34.Weld.C1 = CFrame.new(0, 0, 2) * CFrame.Angles(0, 0, u4:NextNumber(0, 6.283185307179586))
                    u34.Parent = workspace.Effects
                    local v35 = {
                        ["Transparency"] = 0
                    }
                    u3:Create(u34.Decal, TweenInfo.new(0.5), v35):Play()
                    task.spawn(function() --[[ Line: 330 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u34
                            [3] = u3
                            [4] = u10
                        --]]
                        for _, v36 in u1 do
                            u34.Decal.Texture = v36
                            if v36 == u1[4] then
                                u3:Create(u34.Decal, TweenInfo.new(0.3), {
                                    ["Transparency"] = 1
                                }):Play()
                                u3:Create(u34.Decal, TweenInfo.new(0.3), {
                                    ["Color3"] = Color3.new(0, 0, 0)
                                }):Play()
                                u3:Create(u34.Mesh, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                    ["Scale"] = Vector3.new(4, 4, 7)
                                }):Play()
                                u3:Create(u34.Weld, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                    ["C1"] = CFrame.new(0, 0, -4)
                                }):Play()
                            end
                            task.wait(1 / u10)
                        end
                        _G.destroy(u34, 0.4)
                    end)
                    task.wait(0.1)
                end
            end)
            local u37 = Instance.new("Model")
            u37.Parent = workspace.Effects
            local u38 = p6.LookVector
            task.spawn(function() --[[ Line: 387 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u8
                    [3] = u7
                    [4] = u4
                    [5] = u2
                    [6] = u38
                    [7] = u5
                    [8] = u9
                    [9] = u37
                    [10] = u3
                --]]
                while tick() - u33 <= u8 do
                    local v39 = workspace
                    local v40 = u7.Position
                    local v41 = u4:NextNumber(-10, 10)
                    local v42 = u4
                    if v39:Raycast(v40 + Vector3.new(v41, 30, v42:NextNumber(-10, 10)), Vector3.new(0, -40, 0), u2) then
                        local u43 = (u7.CFrame * CFrame.new(0, 0, -3.6)).Position
                        local u44 = (u7.CFrame * CFrame.new(u4:NextNumber(-27, 27), u4:NextNumber(5, 10), u4:NextNumber(13, 20))).Position
                        local v45 = (u43 + u44) / 2 + u38 * 21
                        local v46 = u4:NextNumber(-10, 10)
                        local v47 = u4:NextNumber(-10, 10)
                        local v48 = u4
                        local u49 = v45 + Vector3.new(v46, v47, v48:NextNumber(-10, 10))
                        local v50 = u44 + u38 * 27
                        local v51 = u4:NextNumber(-10, 10)
                        local v52 = u4:NextNumber(-10, 10)
                        local v53 = u4
                        local u54 = v50 + Vector3.new(v51, v52, v53:NextNumber(-10, 10))
                        local u55 = u43
                        task.spawn(function() --[[ Line: 401 ]]
                            --[[
                            Upvalues:
                                [1] = u5
                                [2] = u9
                                [3] = u43
                                [4] = u49
                                [5] = u54
                                [6] = u44
                                [7] = u55
                                [8] = u37
                                [9] = u3
                            --]]
                            for v56 = 0.01, 1, 0.0375 do
                                local u57 = script.CylinderBezier:Clone()
                                u5.apply(u57, u9)
                                local u58 = script.InvertedCylinder:Clone()
                                u5.apply(u58, u9)
                                local v59 = u43
                                local v60 = v59 + (u49 - v59) * v56
                                local v61 = u49
                                local v62 = v61 + (u54 - v61) * v56
                                local v63 = u54
                                local v64 = v63 + (u44 - v63) * v56
                                local v65 = v60 + (v62 - v60) * v56
                                local v66 = v62 + (v64 - v62) * v56
                                u57.CFrame = CFrame.lookAt(v65 + (v66 - v65) * v56, u55) * CFrame.Angles(0, 1.5707963267948966, 0)
                                local v67 = (u55 - u57.Position).Magnitude
                                u57.Size = Vector3.new(v67, 0, 0)
                                u57.Parent = u37
                                u55 = u57.Position
                                u58.CFrame = u57.CFrame
                                u58.Size = Vector3.new(v67, 0, 0)
                                task.spawn(function() --[[ Line: 423 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u58
                                        [2] = u3
                                    --]]
                                    local v68 = u58.LightAttachment.PointLight
                                    local v69 = v68.Range
                                    v68.Range = 0
                                    u3:Create(v68, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, true), {
                                        ["Range"] = v69
                                    }):Play()
                                end)
                                u58.Parent = u37
                                u55 = u57.Position
                                u3:Create(u57, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
                                    ["Size"] = Vector3.new(v67, 1, 1)
                                }):Play()
                                u3:Create(u58, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
                                    ["Size"] = Vector3.new(v67, 1.5, 1.5)
                                }):Play()
                                task.delay(0.4, function() --[[ Line: 443 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u57
                                        [2] = u58
                                    --]]
                                    for _, v70 in u57:GetDescendants() do
                                        if v70:IsA("ParticleEmitter") then
                                            v70.Enabled = false
                                        end
                                    end
                                    u57.Transparency = 1
                                    u58.Transparency = 1
                                    task.wait(0.4)
                                    u57:Destroy()
                                    u58:Destroy()
                                end)
                                task.wait()
                            end
                        end)
                        task.delay(0.25, function() --[[ Line: 461 ]]
                            --[[
                            Upvalues:
                                [1] = u5
                                [2] = u9
                                [3] = u44
                            --]]
                            local v71 = script.EndPortal:Clone()
                            u5.apply(v71, u9)
                            v71.Position = u44
                            v71.Parent = workspace.Effects
                            task.wait(0.15)
                            for _, v72 in v71:GetDescendants() do
                                if v72:IsA("ParticleEmitter") then
                                    v72.Enabled = false
                                end
                            end
                            task.wait(2)
                            v71:Destroy()
                        end)
                    end
                    task.wait(0.05)
                end
                _G.destroy(u37, 3)
            end)
            task.spawn(function() --[[ Line: 492 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u8
                    [3] = u5
                    [4] = u9
                    [5] = u4
                    [6] = u7
                    [7] = u13
                    [8] = u11
                    [9] = u10
                --]]
                while tick() - u33 <= u8 - 0.3 do
                    task.spawn(function() --[[ Line: 495 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                            [2] = u9
                            [3] = u4
                            [4] = u7
                            [5] = u13
                            [6] = u11
                            [7] = u10
                        --]]
                        local v73 = script.Wisp:Clone()
                        u5.apply(v73, u9)
                        local v74 = u4:NextNumber(0, 360)
                        local v75 = u4:NextNumber(3, 8)
                        local v76 = u4:NextNumber(3, 8)
                        local v77 = u4:NextNumber(3, 8)
                        local v78 = u7.CFrame
                        local v79 = CFrame.new
                        local v80 = math.rad(v74)
                        local v81 = math.sin(v80) * v75
                        local v82 = math.rad(v74)
                        local v83 = math.cos(v82) * v77 + 4
                        local v84 = math.rad(v74)
                        v73.CFrame = v78 * v79(v81, v83, math.sin(v84) * v76)
                        v73.Parent = workspace.Effects
                        local v85 = u4:NextNumber(3, 6)
                        local v86 = u4:NextNumber(0.2, 0.7)
                        local v87 = tick()
                        while tick() - v87 <= v86 and u13 == true do
                            local v88 = u7.CFrame
                            local v89 = CFrame.new
                            local v90 = math.rad(v74)
                            local v91 = math.sin(v90) * v75
                            local v92 = math.rad(v74)
                            local v93 = math.cos(v92) * v77 + 4
                            local v94 = math.rad(v74)
                            v73.CFrame = v88 * v89(v91, v93, math.sin(v94) * v76)
                            v74 = v74 + v85 * u11
                            task.wait(1 / u10)
                        end
                        for _, v95 in v73:GetDescendants() do
                            if v95:IsA("ParticleEmitter") then
                                v95.Enabled = false
                            end
                        end
                        task.wait(2)
                        v73:Destroy()
                    end)
                    task.wait(u4:NextNumber(0.005, 0.02))
                end
            end)
            if workspace:Raycast(p6.Position, Vector3.new(0, -4, 0), u2) then
                local u96 = script.FloorEffect:Clone()
                u5.apply(u96, u9)
                u96.CFrame = u7.CFrame * CFrame.new(0, -u7.Parent.Humanoid.HipHeight, 0)
                u96.Size = Vector3.new(12, 1, 0)
                u96.Parent = workspace.Effects
                u3:Create(u96, TweenInfo.new(u8, Enum.EasingStyle.Linear), {
                    ["Size"] = Vector3.new(12, 1, v15),
                    ["Position"] = (u96.CFrame * CFrame.new(0, 0, -v15 / 2)).Position
                }):Play()
                task.delay(u8 + 0.25, function() --[[ Line: 552 ]]
                    --[[
                    Upvalues:
                        [1] = u96
                    --]]
                    for _, v97 in u96:GetDescendants() do
                        if v97:IsA("ParticleEmitter") then
                            v97.Enabled = false
                        end
                    end
                    task.wait(3)
                    u96:Destroy()
                end)
            end
            local u98 = Instance.new("Highlight")
            u98.DepthMode = Enum.HighlightDepthMode.Occluded
            u98.FillTransparency = 0
            u98.OutlineColor = Color3.fromRGB(200, 400, 400)
            u98.FillColor = Color3.fromRGB(0, 0, 0)
            u98:SetAttribute("UniqueID", "e5a4b6c7-d8f9-4e01-a234-000000000010")
            u5.apply(u98, u9)
            u98.Parent = u7.Parent
            u98.FillTransparency = 1
            u98.OutlineTransparency = 1
            u3:Create(u98, TweenInfo.new(u8 / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, true), {
                ["FillTransparency"] = 0,
                ["OutlineTransparency"] = 0
            }):Play()
            task.delay(u8, function() --[[ Line: 629 ]]
                --[[
                Upvalues:
                    [1] = u98
                --]]
                u98:Destroy()
            end)
            task.wait(2)
            u30:Destroy()
        end
    end
}