 

local v1 = game:GetService("ReplicatedStorage")
local u2 = require(v1.Modules.Client.WeaponVFXRecolor)
local u3 = {
    "rbxassetid://14355301811",
    "rbxassetid://14355301672",
    "rbxassetid://14355293187",
    "rbxassetid://14355293046",
    "rbxassetid://14355292651",
    "rbxassetid://14355292453",
    "rbxassetid://14355301442",
    "rbxassetid://14355301181",
    "rbxassetid://14355284866",
    "rbxassetid://14355284744",
    "rbxassetid://14355284625",
    "rbxassetid://14355284308",
    "rbxassetid://14355284128"
}
local u4 = {
    "rbxassetid://14399495350",
    "rbxassetid://14399495100",
    "rbxassetid://14399494721",
    "rbxassetid://14399486622",
    "rbxassetid://14399486417",
    "rbxassetid://14399486214",
    "rbxassetid://14399486014",
    "rbxassetid://14399485747",
    "rbxassetid://14399485586",
    "rbxassetid://14399476969",
    "rbxassetid://14399476770",
    "rbxassetid://14399476606",
    "rbxassetid://14399476397",
    "rbxassetid://14399476397",
    "rbxassetid://14399476010"
}
local u5 = RaycastParams.new()
u5.FilterType = Enum.RaycastFilterType.Include
u5.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Islands }
local u6 = game:GetService("TweenService")
local u7 = Random.new()
local u8 = {}
return {
    ["start"] = function(_, p9) --[[ Name: start, Line 57 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u2
            [3] = u6
            [4] = u7
            [5] = u5
            [6] = u3
            [7] = u4
        --]]
        local u10 = p9.char
        local v11 = p9.State
        local u12 = p9.StartCFrame
        local u13 = p9.DashDistance
        local v14 = p9.Prestige
        local _ = _G.FPS
        if not u8[u10] then
            u8[u10] = {}
        end
        local u15
        if v14 == false or v14 == nil then
            u15 = script.NormalFireworks
        else
            u15 = script.PrestigeFireworks
        end
        if v11 == "StartSkill" then
            local v16 = Instance.new("Folder")
            v16.Name = "EffectsFolder"
            v16.Parent = workspace.Effects
            local v17 = u15.StartFirework:Clone()
            u2.apply(v17, u10)
            v17.Position = u12.Position
            v17.Parent = v16
            local v18 = next
            local v19, v20 = v17:GetDescendants()
            for _, v21 in v18, v19, v20 do
                if v21:IsA("ParticleEmitter") then
                    _G.customEmit(v21)
                end
            end
            local v22 = u15.WindBangMesh:Clone()
            u2.apply(v22, u10)
            v22.CFrame = u12
            v22.Size = Vector3.new(0, 5, 0)
            v22.Parent = v16
            local v23 = u15.StartUp:Clone()
            u2.apply(v23, u10)
            v23.CFrame = u12
            v23.Parent = v16
            _G.customEmit(v23)
            u6:Create(v22, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                ["Size"] = Vector3.new(10, 1, 10),
                ["CFrame"] = v22.CFrame * CFrame.new(0, -2, 0)
            }):Play()
            u6:Create(v22, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["Transparency"] = 1
            }):Play()
            u8[u10].EffectsFolder = v16
            u8[u10].ChargeUpEffect = v23
            u8[u10].StartFirework = v17
            task.wait(0.1)
            u6:Create(v17.PointLight, TweenInfo.new(0.1), {
                ["Brightness"] = 0
            }):Play()
        elseif v11 == "EndSkill" then
            local u24 = u8[u10].EffectsFolder
            local v25 = u8[u10].ChargeUpEffect
            _G.customEmit(v25)
            _G.particleEnabled(v25, false)
            u8[u10] = nil
            local u26 = u15.DashMesh:Clone()
            u2.apply(u26, u10)
            u26.CFrame = u12 * CFrame.Angles(0, 3.141592653589793, 0)
            local v27 = u26.Size.X
            local v28 = u26.Size.Y
            u26.Size = Vector3.new(v27, v28, 0)
            u26.Parent = u24
            local v29 = u6
            local v30 = TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
            local v31 = {}
            local v32 = u26.Size
            local v33 = u13 * 1
            v31.Size = v32 + Vector3.new(0, 0, v33)
            v31.CFrame = u26.CFrame * CFrame.new(0, 0, u13 / 2)
            v29:Create(u26, v30, v31):Play()
            task.delay(0.15, function() --[[ Line: 147 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u26
                    [3] = u13
                --]]
                local v34 = u6
                local v35 = u26
                local v36 = TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                local v37 = {}
                local v38 = u13 * 0.9
                v37.Size = Vector3.new(0, 0, v38)
                v34:Create(v35, v36, v37):Play()
                task.wait(0.15)
                u26:Destroy()
            end)
            local u39 = u15.RightWind:Clone()
            u2.apply(u39, u10)
            local v40 = u39.Size.Z
            u39.CFrame = u12 * CFrame.new(6, 0, -u13 * 0.75) * CFrame.Angles(0, 1.5707963267948966, 0)
            local v41 = u39.Size.Y
            u39.Size = Vector3.new(0, v41, 0)
            u39.Transparency = 1
            u6:Create(u39, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["Transparency"] = 0.7
            }):Play()
            u6:Create(u39, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["CFrame"] = u39.CFrame * CFrame.new(-u13 / 2, 0, 0),
                ["Size"] = u39.Size + Vector3.new(u13, 0, v40)
            }):Play()
            task.delay(0.1, function() --[[ Line: 171 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u39
                --]]
                u6:Create(u39, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    ["Transparency"] = 1
                }):Play()
            end)
            u39.Parent = u24
            local u42 = u15.LeftWind:Clone()
            u2.apply(u42, u10)
            local v43 = u42.Size.Z
            u42.CFrame = u12 * CFrame.new(-4, 0, -u13 * 0.75) * CFrame.Angles(0, 1.5707963267948966, 0)
            local v44 = u42.Size.Y
            u42.Size = Vector3.new(0, v44, 0)
            u42.Transparency = 1
            u6:Create(u42, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["Transparency"] = 0.7
            }):Play()
            u6:Create(u42, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["CFrame"] = u42.CFrame * CFrame.new(-u13 / 2, 0, 0),
                ["Size"] = u42.Size + Vector3.new(u13, 0, v43)
            }):Play()
            task.delay(0.1, function() --[[ Line: 193 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u42
                --]]
                u6:Create(u42, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    ["Transparency"] = 1
                }):Play()
            end)
            u42.Parent = u24
            local u45 = u15.DashParticle:Clone()
            u2.apply(u45, u10)
            u45.CFrame = u12
            u45.Parent = u24
            u45.SparkAttachment.Star:Emit(1)
            u6:Create(u45, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                ["CFrame"] = u12 * CFrame.new(0, 0, -u13)
            }):Play()
            task.delay(0.1, function() --[[ Line: 214 ]]
                --[[
                Upvalues:
                    [1] = u45
                --]]
                for _, v46 in u45:GetDescendants() do
                    if v46:IsA("ParticleEmitter") then
                        v46.Enabled = false
                    end
                end
            end)
            local u47 = 0
            local u48 = math.random(1, 2)
            local u49 = u13 / 30
            local _ = u13 > 50
            task.spawn(function() --[[ Line: 236 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u7
                    [3] = u5
                    [4] = u15
                    [5] = u2
                    [6] = u10
                    [7] = u6
                    [8] = u24
                    [9] = u13
                    [10] = u49
                --]]
                local v50 = nil
                local v51 = 0
                for _ = 1, 5 do
                    local v52 = math.random(1, 2) == 1 and 1 or -1
                    local u53 = v50 and v50 == v52 and workspace:Raycast((u12 * CFrame.new(v52 * -1 * u7:NextNumber(9, 14), 10, -u7:NextNumber(v51 - 3, v51 + 3))).Position, Vector3.new(0, -20, 0), u5)
                    if u53 then
                        local u54 = u15.FloorExplosion:Clone()
                        u2.apply(u54, u10)
                        u54.CFrame = CFrame.lookAt(u53.Position, u53.Position + u53.Normal)
                        u54.Parent = workspace.Effects
                        u54.Spark.Star:Emit(1)
                        task.delay(0.1, function() --[[ Line: 265 ]]
                            --[[
                            Upvalues:
                                [1] = u54
                                [2] = u15
                                [3] = u2
                                [4] = u10
                                [5] = u53
                                [6] = u7
                                [7] = u6
                                [8] = u24
                            --]]
                            _G.customEmit(u54)
                            local v55 = u15.Crack:Clone()
                            u2.apply(v55, u10)
                            v55.CFrame = CFrame.lookAt(u53.Position, u53.Position + u53.Normal) * CFrame.Angles(0, 0, u7:NextNumber(0, 3.141592653589793))
                            v55.Bright.Transparency = 1
                            v55.Black.Transparency = 1
                            u6:Create(v55.Bright, TweenInfo.new(0.1), {
                                ["Transparency"] = 0
                            }):Play()
                            u6:Create(v55.Black, TweenInfo.new(0.1), {
                                ["Transparency"] = 0
                            }):Play()
                            v55.Parent = u24
                            v55.Attachment.PointLight.Brightness = 0
                            u6:Create(v55.Attachment.PointLight, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                ["Brightness"] = 2
                            }):Play()
                            task.wait(0.1)
                            u6:Create(v55.Bright, TweenInfo.new(0.4), {
                                ["Transparency"] = 1
                            }):Play()
                            u6:Create(v55.Attachment.PointLight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                ["Brightness"] = 0,
                                ["Range"] = 0
                            }):Play()
                            task.wait(1.5)
                            u6:Create(v55.Black, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                ["Transparency"] = 1
                            }):Play()
                            _G.destroy(v55, 5)
                        end)
                        _G.destroy(u54, 5)
                    end
                    local u56 = workspace:Raycast((u12 * CFrame.new(v52 * u7:NextNumber(9, 14), 10, -u7:NextNumber(v51 - 3, v51 + 3))).Position, Vector3.new(0, -20, 0), u5)
                    if u56 then
                        local u57 = u15.FloorExplosion:Clone()
                        u2.apply(u57, u10)
                        u57.CFrame = CFrame.lookAt(u56.Position, u56.Position + u56.Normal)
                        u57.Parent = workspace
                        task.delay(0.1, function() --[[ Line: 322 ]]
                            --[[
                            Upvalues:
                                [1] = u57
                                [2] = u15
                                [3] = u2
                                [4] = u10
                                [5] = u56
                                [6] = u7
                                [7] = u6
                                [8] = u24
                            --]]
                            _G.customEmit(u57)
                            local v58 = u15.Crack:Clone()
                            u2.apply(v58, u10)
                            v58.CFrame = CFrame.lookAt(u56.Position, u56.Position + u56.Normal) * CFrame.Angles(0, 0, u7:NextNumber(0, 3.141592653589793))
                            v58.Bright.Transparency = 1
                            v58.Black.Transparency = 1
                            u6:Create(v58.Bright, TweenInfo.new(0.1), {
                                ["Transparency"] = 0
                            }):Play()
                            u6:Create(v58.Black, TweenInfo.new(0.1), {
                                ["Transparency"] = 0
                            }):Play()
                            v58.Parent = u24
                            v58.Attachment.PointLight.Brightness = 0
                            u6:Create(v58.Attachment.PointLight, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                ["Brightness"] = 2
                            }):Play()
                            task.wait(0.1)
                            u6:Create(v58.Bright, TweenInfo.new(0.4), {
                                ["Transparency"] = 1
                            }):Play()
                            u6:Create(v58.Attachment.PointLight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                ["Brightness"] = 0,
                                ["Range"] = 0
                            }):Play()
                            task.wait(1.5)
                            u6:Create(v58.Black, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                ["Transparency"] = 1
                            }):Play()
                        end)
                    end
                    if v51 <= u13 then
                        v51 = v51 + 6 * u49
                    end
                    task.wait(0.05)
                    v50 = v52
                end
            end)
            task.spawn(function() --[[ Line: 377 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u2
                    [3] = u10
                    [4] = u7
                    [5] = u3
                    [6] = u12
                    [7] = u13
                    [8] = u49
                --]]
                local v59 = 0
                for _ = 1, 9 do
                    for _ = 1, 2 do
                        local u60 = u15.SlashPart:Clone()
                        u2.apply(u60, u10)
                        local v61 = u7:NextNumber(-0.4, -0.2)
                        u60.Mesh.Scale = Vector3.new(v61, -0.3, v61)
                        u60.Decal.Texture = ""
                        u60.Parent = workspace.Effects
                        task.spawn(function() --[[ Line: 390 ]]
                            --[[
                            Upvalues:
                                [1] = u3
                                [2] = u60
                            --]]
                            for v62 = 1, #u3 do
                                u60.Decal.Texture = u3[v62]
                                task.wait(0.005)
                            end
                            u60.Decal.Texture = ""
                        end)
                        u60.CFrame = u12 * CFrame.new(u7:NextNumber(-2, 2), u7:NextNumber(2, 4), -u7:NextNumber(v59 - 3, v59 + 3)) * CFrame.Angles(u7:NextNumber(0, 3.141592653589793), u7:NextNumber(0, 3.141592653589793), u7:NextNumber(0, 3.141592653589793))
                        _G.destroy(u60, 3)
                    end
                    if v59 <= u13 then
                        v59 = v59 + 4 * u49
                    end
                    task.wait(0.005)
                end
            end)
            task.delay(0.1, function() --[[ Line: 415 ]]
                --[[
                Upvalues:
                    [1] = u48
                    [2] = u15
                    [3] = u2
                    [4] = u10
                    [5] = u12
                    [6] = u7
                    [7] = u47
                    [8] = u24
                    [9] = u6
                    [10] = u13
                    [11] = u49
                --]]
                local v63 = tick()
                while tick() - v63 <= 0.2 do
                    local v64
                    if u48 == 1 then
                        v64 = u15.Firework1:Clone()
                        u2.apply(v64, u10)
                    else
                        v64 = u15.Firework2:Clone()
                        u2.apply(v64, u10)
                    end
                    u48 = math.random(1, 2)
                    v64.CFrame = u12 * CFrame.new(u7:NextNumber(-10, 10), u7:NextNumber(1, 10), -u7:NextNumber(u47 - 1, u47 + 1))
                    v64.Parent = u24
                    _G.customEmit(v64)
                    v64.PointLight.Brightness = 0
                    u6:Create(v64.PointLight, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, true), {
                        ["Brightness"] = 1.3
                    }):Play()
                    if u47 <= u13 then
                        u47 = u47 + 3 * u49
                    end
                    task.wait(0.005)
                end
            end)
            local u65 = u15.ConeDashPartWind:Clone()
            u2.apply(u65, u10)
            u65.CFrame = u12 * CFrame.new(0, 0, -u13 / 3)
            local v66 = u65.Mesh
            local v67 = u13 * 0.5
            v66.Scale = Vector3.new(2, 2, v67)
            task.spawn(function() --[[ Line: 452 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u65
                --]]
                for v68 = 1, #u4 do
                    u65.Decal.Texture = u4[v68]
                    task.wait(0.035)
                end
            end)
            u65.Parent = u24
            u6:Create(u65.Decal, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                ["Transparency"] = 1
            }):Play()
            u6:Create(u65, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["CFrame"] = u12 * CFrame.new(0, 0, -u13 / 1.5)
            }):Play()
            u6:Create(u65.Mesh, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["Scale"] = Vector3.new(10, 10, u13)
            }):Play()
            task.wait(4)
            u24:Destroy()
        end
    end
}