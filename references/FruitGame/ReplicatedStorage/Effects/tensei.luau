 

local function u6(p1, p2) --[[ Line: 2 ]]
    local v3 = p1.PrimaryPart
    local v4 = v3.CFrame
    for _, v5 in p1:GetChildren() do
        if v5:IsA("BasePart") then
            v5.Size = v5.Size * p2
            if v5 ~= v3 then
                v5.CFrame = v4 + v4:inverse() * v5.Position * p2
            end
        end
    end
    return p1
end
local function u50(u7, u8, u9) --[[ Line: 26 ]]
    local u10 = u7:GetChildren()
    for u11 = 1, #u10 do
        if u10[u11] ~= u7.PrimaryPart then
            local u12 = u10[u11].CFrame
            u10[u11].Parent = nil
            local v13 = u10[u11]
            local v14 = CFrame.new(u12.Position) * CFrame.new(math.random(-500, 500), -1000, math.random(-500, 500))
            local v15 = CFrame.Angles
            local v16 = math.random(-360, 360)
            local v17 = math.rad(v16)
            local v18 = math.random(-360, 360)
            local v19 = math.rad(v18)
            local v20 = math.random(-360, 360)
            v13.CFrame = v14 * v15(v17, v19, (math.rad(v20)))
            local v21 = Ray.new(u12.Position, (u12.Position - u10[u11].Position).unit * -1000)
            local v22, v23, _ = _G.raycastWhitelist(v21, { workspace.Islands, workspace.Ships })
            if v23.Y < workspace.Env.WaterStuff.Falls.Position.Y then
                local v24 = v23.X
                local v25 = workspace.Env.WaterStuff.Falls.Position.Y
                local v26 = v23.Z
                v23 = Vector3.new(v24, v25, v26)
            end
            local v27 = u10[u11]
            local v28 = CFrame.new(v23)
            local v29 = CFrame.Angles
            local v30 = math.random(-360, 360)
            local v31 = math.rad(v30)
            local v32 = math.random(-360, 360)
            local v33 = math.rad(v32)
            local v34 = math.random(-360, 360)
            v27.CFrame = v28 * v29(v31, v33, (math.rad(v34)))
            if v22 and v23.Y > workspace.Env.WaterStuff.Falls.Position.Y then
                u10[u11].Color = v22.Color
                u10[u11].Material = v22.Material
            else
                u10[u11].Color = workspace.Env.WaterStuff.Falls.Color
                u10[u11].Material = Enum.Material.Granite
            end
            spawn(function() --[[ Line: 49 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u11
                    [3] = u7
                    [4] = u12
                --]]
                task.wait(math.random(300, 800) / 1000)
                u10[u11].Parent = u7
                local v35 = {
                    ["CFrame"] = u12
                }
                _G.tween(u10[u11], {
                    math.random(500, 1000) / 1000,
                    Enum.EasingStyle.Quint,
                    Enum.EasingDirection.Out,
                    0,
                    false
                }, v35)
            end)
            spawn(function() --[[ Line: 55 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u9
                    [3] = u10
                    [4] = u11
                    [5] = u7
                    [6] = u12
                --]]
                if u8 == u9 then
                    task.wait(2)
                    _G.tween(u10[u11], {
                        0.25,
                        Enum.EasingStyle.Cubic,
                        Enum.EasingDirection.Out,
                        0,
                        false
                    }, {
                        ["CFrame"] = u7.PrimaryPart.CFrame:Lerp(u12, 0.75),
                        ["Size"] = u10[u11].Size * 0.75
                    })
                    task.wait(0.35)
                    u10[u11].Parent = workspace.Effects
                    u10[u11].Anchored = false
                    local v36 = u10[u11].Size.Magnitude * 7
                    local v37 = u10[u11]
                    local v38 = math.random(-v36, v36)
                    local v39 = math.random(-50, 175)
                    local v40 = math.random
                    local v41 = -v36
                    v37.Velocity = Vector3.new(v38, v39, v40(v41, v36))
                    local v42 = u10[u11]
                    local v43 = math.random(-5, 5)
                    local v44 = math.random(-5, 5)
                    local v45 = math.random
                    v42.RotVelocity = Vector3.new(v43, v44, v45(-5, 5))
                    local u46 = nil
                    u46 = u10[u11].Touched:Connect(function(p47) --[[ Line: 69 ]]
                        --[[
                        Upvalues:
                            [1] = u10
                            [2] = u11
                            [3] = u46
                        --]]
                        if p47 and p47:IsDescendantOf(workspace.Islands) then
                            u10[u11].Anchored = true
                            u10[u11].Transparency = 1
                            local v48 = script.ParticleEmitter:Clone()
                            v48.Parent = u10[u11]
                            v48.Color = ColorSequence.new(u10[u11].Color)
                            v48.Size = NumberSequence.new(u10[u11].Size.Magnitude / 2)
                            v48:Emit(25)
                            local v49 = script["brickburst" .. math.random(1, 3)]:Clone()
                            v49.Parent = u10[u11]
                            v49:Play()
                            u46:Disconnect()
                        end
                    end)
                end
            end)
        end
    end
end
local function u57(p51) --[[ Line: 90 ]]
    for v52 = 1, 6 do
        local u53 = script.CircleShockwave:Clone()
        u53.Parent = workspace.Effects
        local v54 = CFrame.Angles
        local v55 = v52 * 60
        u53.CFrame = p51 * v54(math.rad(v55), 0, 0)
        _G.tween(u53, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false
        }, {
            ["Transparency"] = 1,
            ["Size"] = Vector3.new(300, 2, 300)
        })
        local u56 = 0.25
        spawn(function() --[[ Line: 17 ]]
            --[[
            Upvalues:
                [1] = u56
                [2] = u53
            --]]
            task.wait(u56)
            if u53 then
                u53:Destroy()
            end
        end)
    end
end
local u58 = {}
local v59 = {}
local function u66(p60, p61) --[[ Line: 120 ]]
    local v62 = workspace.Projectiles:GetDescendants()
    for v63 = 1, #v62 do
        if v62[v63]:IsA("BasePart") and ((v62[v63].Position - p60.Position).Magnitude <= 800 and v62[v63]:FindFirstChild("tenseiSucked") == nil) then
            local v64 = Instance.new("ObjectValue")
            v64.Name = "tenseiSucked"
            v64.Value = p61
            v64.Parent = v62[v63]
            if v62[v63].Parent:IsA("Model") then
                local v65 = Instance.new("ObjectValue")
                v65.Name = "tenseiSucked"
                v65.Value = p61
                v65.Parent = v62[v63].Parent
            end
            v62[v63].Anchored = true
        end
    end
end
function v59.start(_, p67) --[[ Line: 139 ]]
    --[[
    Upvalues:
        [1] = u66
        [2] = u58
        [3] = u6
        [4] = u50
        [5] = u57
    --]]
    local _ = p67.target
    local v68 = p67.char
    local v69 = p67.max
    local u70 = p67.targetCF
    local u71 = script.orb:Clone()
    u71.Parent = workspace.Effects
    u71:PivotTo(v68.HumanoidRootPart.CFrame)
    u71.PrimaryPart.Attachment.ParticleEmitter:Emit(1)
    u71.PrimaryPart.sfx2:Play()
    _G.tween(u71.PrimaryPart, {
        4,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out,
        0,
        false
    }, {
        ["CFrame"] = u70
    })
    task.wait(4)
    u71.PrimaryPart.sfx:Play()
    local v72 = script.phoeyuRock.Ball.Size
    task.spawn(function() --[[ Line: 156 ]]
        --[[
        Upvalues:
            [1] = u66
            [2] = u70
            [3] = u71
        --]]
        for _ = 1, 80 do
            u66(u70, u71.PrimaryPart)
            task.wait(0.1)
        end
    end)
    for v73 = 1, v69 do
        if _G.checkRenderDistance(u70.Position) == false then
            return
        end
        if v73 == v69 then
            _G.tween(u71.PrimaryPart.sfx, {
                3,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["Volume"] = 0
            })
        end
        local v74 = script.phoeyuRock:Clone()
        local v75 = v73 + 1
        local u76
        if u58[v75] == nil then
            u6(v74, v75)
            u58[v75] = v74:Clone()
            u76 = v74
        else
            u76 = u58[v75]:Clone()
            u76.Parent = v74.Parent
            v74:Destroy()
        end
        u76:PivotTo(u70)
        local v77 = u76.PrimaryPart.CFrame
        local v78 = CFrame.Angles
        local v79 = math.random(-360, 360)
        local v80 = math.rad(v79)
        local v81 = math.random(-360, 360)
        local v82 = math.rad(v81)
        local v83 = math.random(-360, 360)
        u76:PivotTo(v77 * v78(v80, v82, (math.rad(v83))))
        local v84 = u76.PrimaryPart.Size
        u76.PrimaryPart.Size = v72
        v72 = v84 * 0.25
        u50(u76, v73, v69)
        u76.Parent = workspace.Env
        _G.tween(u76.PrimaryPart, {
            1.5,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false
        }, {
            ["Size"] = v84
        })
        if v73 == v69 then
            task.wait(2)
            _G.tween(u76.PrimaryPart, {
                0.25,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["Size"] = Vector3.new(0, 0, 0)
            })
            task.wait(0.35)
            u57(u76.PrimaryPart.CFrame)
            u76.PrimaryPart.sfx:play()
            _G.tween(u76.PrimaryPart, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["Size"] = u76.PrimaryPart.Size * 2,
                ["Transparency"] = 1
            })
            local u85 = 15
            spawn(function() --[[ Line: 17 ]]
                --[[
                Upvalues:
                    [1] = u85
                    [2] = u76
                --]]
                task.wait(u85)
                if u76 then
                    u76:Destroy()
                end
            end)
        else
            local u86 = 1.8
            spawn(function() --[[ Line: 17 ]]
                --[[
                Upvalues:
                    [1] = u86
                    [2] = u76
                --]]
                task.wait(u86)
                if u76 then
                    u76:Destroy()
                end
            end)
        end
        task.wait(0.25)
    end
    u71:Destroy()
end
return v59