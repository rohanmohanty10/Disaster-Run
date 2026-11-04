 

game:GetService("ReplicatedStorage")
local u1 = script.Cast
local v2 = {}
local u3 = RaycastParams.new()
u3.FilterType = Enum.RaycastFilterType.Whitelist
u3.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
function v2.start(_, u4, p5) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    local v6 = u4.HumanoidRootPart
    if p5 then
        if _G.checkRenderDistance(u4.PrimaryPart.Position) == false then
            return
        end
        local v7 = workspace:Raycast(v6.Position, Vector3.new(0, -10, 0), u3)
        if v7 then
            local u8 = u1:Clone()
            u8.Name = "CastEffect" .. u4.Name
            u8:SetPrimaryPartCFrame(CFrame.new(v7.Position, v7.Position + v7.Normal) * CFrame.new(0, 0, 0) * CFrame.Angles(-1.5707963267948966, 0, 0))
            u8.Parent = workspace.Effects
            local v9 = script.IceDaggersSpin:Clone()
            v9.Parent = u4.PrimaryPart
            v9:Play()
            for _, u10 in u8:GetChildren() do
                local v11 = u10.Name
                if v11 ~= "Main" then
                    if v11 == "Impact" then
                        _G.tween(u10.Decal, { 0.6, "Linear", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 0.4
                        })
                    elseif v11 == "Inner" then
                        _G.tween(u10.Decal, { 0.35, "Cubic", Enum.EasingDirection.Out }, {
                            ["Transparency"] = -1
                        })
                        _G.tween(u10, { 0.35, "Cubic", Enum.EasingDirection.Out }, {
                            ["Size"] = Vector3.new(12, 12, 0.1),
                            ["CFrame"] = u10.CFrame * CFrame.Angles(0, 0, -1.5707963267948966)
                        })
                        task.delay(0.35, function() --[[ Line: 47 ]] end)
                    elseif v11 == "Outer" then
                        _G.tween(u10, { 0.27, "Cubic", Enum.EasingDirection.Out }, {
                            ["Size"] = Vector3.new(45, 45, 0.1),
                            ["CFrame"] = u10.CFrame * CFrame.Angles(0, 0, 1.3962634015954636)
                        })
                        _G.tween(u10.Decal, { 0.27, "Cubic", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 0
                        })
                        task.delay(0.1, function() --[[ Line: 53 ]]
                            --[[
                            Upvalues:
                                [1] = u10
                            --]]
                            _G.tween(u10.Decal, { 0.13, "Cubic", Enum.EasingDirection.Out }, {
                                ["Transparency"] = 0,
                                ["Color3"] = Color3.fromRGB(240, 270, 2000)
                            })
                            task.delay(0.13, function() --[[ Line: 56 ]]
                                --[[
                                Upvalues:
                                    [1] = u10
                                --]]
                                _G.tween(u10.Decal, { 0.15, "Circular", Enum.EasingDirection.Out }, {
                                    ["Transparency"] = 0,
                                    ["Color3"] = Color3.fromRGB(128, 158, 255)
                                })
                            end)
                        end)
                    elseif v11 == "Rotating" then
                        _G.tween(u10, { 0.45, "Cubic", Enum.EasingDirection.Out }, {
                            ["Size"] = Vector3.new(46, 46, 0.1),
                            ["CFrame"] = u10.CFrame * CFrame.Angles(0, 0, 1.3962634015954636)
                        })
                        _G.tween(u10.Decal, { 0.4, "Linear", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 0.74
                        })
                    elseif v11 == "Rotating2" then
                        _G.tween(u10, { 0.45, "Cubic", Enum.EasingDirection.Out }, {
                            ["Size"] = Vector3.new(40, 40, 0.1),
                            ["CFrame"] = u10.CFrame * CFrame.Angles(0, 0, 1.3962634015954636)
                        })
                        _G.tween(u10.Decal, { 0.35, "Linear", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 0.5
                        })
                    elseif v11 == "Textures" then
                        _G.tween(u10.Decal, { 0.8, "Cubic", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 0.7
                        })
                    elseif v11 == "BlackTexture" then
                        task.delay(0.5, function() --[[ Line: 69 ]]
                            --[[
                            Upvalues:
                                [1] = u10
                            --]]
                            _G.tween(u10.Decal, { 0.5, "Linear", Enum.EasingDirection.Out }, {
                                ["Transparency"] = 0.5
                            })
                        end)
                    elseif v11 == "StuckyWindy" then
                        _G.tween(u10, { 0.4, "Cubic", Enum.EasingDirection.Out }, {
                            ["CFrame"] = u10.CFrame * CFrame.new(4.5, 0, 0) * CFrame.Angles(-2.0943951023931953, 0, 0)
                        })
                        _G.tween(u10.Mesh, { 0.4, "Circular", Enum.EasingDirection.Out }, {
                            ["Scale"] = Vector3.new(0.1, 1.5, 1.5)
                        })
                        _G.tween(u10.Decal, { 0.4, "Circular", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                    elseif v11 == "BeanWind" then
                        _G.tween(u10, { 0.4, "Cubic", Enum.EasingDirection.Out }, {
                            ["CFrame"] = u10.CFrame * CFrame.new(0, -5, 0) * CFrame.Angles(0, -2.0943951023931953, 0)
                        })
                        _G.tween(u10.Mesh, { 0.4, "Circular", Enum.EasingDirection.Out }, {
                            ["Scale"] = Vector3.new(10, 5, 10)
                        })
                        _G.tween(u10.Decal, { 0.4, "Circular", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                    elseif v11 == "BeanWind2" then
                        _G.tween(u10, { 0.4, "Cubic", Enum.EasingDirection.Out }, {
                            ["CFrame"] = u10.CFrame * CFrame.Angles(0, 0.4363323129985824, 0)
                        })
                        _G.tween(u10.Mesh, { 0.4, "Circular", Enum.EasingDirection.Out }, {
                            ["Scale"] = Vector3.new(16, 40, 16)
                        })
                        _G.tween(u10.Decal, { 0.4, "Linear", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                    elseif v11 == "Fake" then
                        _G.tween(u10.PointLight, { 0.3, "Linear", "Out" }, {
                            ["Brightness"] = 5
                        })
                    end
                end
            end
            local u12 = 0
            local u13 = 0
            local u14 = 0
            local u15 = 0
            local u16 = 0
            local u17 = 0
            local u18 = 0
            for _, v19 in u8.Fake:GetChildren() do
                if v19:IsA("ParticleEmitter") then
                    v19.Enabled = true
                end
            end
            for _, v20 in u8.Main:GetDescendants() do
                if v20:IsA("ParticleEmitter") then
                    v20.Enabled = true
                    _G.customEmit(v20)
                end
            end
            task.delay(5, function() --[[ Line: 108 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                _G.PlayEffect(script.Name, nil, u4, false)
            end)
            while u8 and not u8:GetAttribute("Destroyed") do
                task.defer(function() --[[ Line: 112 ]]
                    --[[
                    Upvalues:
                        [1] = u12
                        [2] = u8
                    --]]
                    if tick() - u12 >= 1.3 then
                        local u21 = u8.Textures
                        _G.tween(u21.Decal, { 0.4, "Linear", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                        task.delay(0.4, function() --[[ Line: 121 ]]
                            --[[
                            Upvalues:
                                [1] = u21
                                [2] = u8
                            --]]
                            if u21 and not u8:GetAttribute("Cancelled") then
                                _G.tween(u21.Decal, { 0.5, "Linear", Enum.EasingDirection.Out }, {
                                    ["Transparency"] = 0.55
                                })
                            end
                        end)
                        u12 = tick()
                    end
                end)
                task.defer(function() --[[ Line: 130 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                        [2] = u8
                    --]]
                    local v22 = tick() - u13
                    u13 = tick()
                    local v23 = u8.Outer
                    local v24 = v23.CFrame
                    local v25 = CFrame.Angles
                    local v26 = v22 * 5
                    v23.CFrame = v24 * v25(0, 0, (math.rad(v26)))
                end)
                task.defer(function() --[[ Line: 137 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u8
                    --]]
                    local v27 = tick() - u14
                    u14 = tick()
                    local v28 = u8.Rotating
                    local v29 = v28.CFrame
                    local v30 = CFrame.Angles
                    local v31 = v27 * -70
                    v28.CFrame = v29 * v30(0, 0, (math.rad(v31)))
                end)
                task.defer(function() --[[ Line: 145 ]]
                    --[[
                    Upvalues:
                        [1] = u15
                        [2] = u8
                    --]]
                    local v32 = tick() - u15
                    u15 = tick()
                    local v33 = u8.Fake
                    local v34 = v33.CFrame
                    local v35 = CFrame.Angles
                    local v36 = v32 * -60
                    v33.CFrame = v34 * v35(0, math.rad(v36), 0)
                end)
                task.defer(function() --[[ Line: 153 ]]
                    --[[
                    Upvalues:
                        [1] = u16
                        [2] = u8
                        [3] = u17
                    --]]
                    local v37 = tick() - u16
                    u16 = tick()
                    local u38 = u8.Rotating2
                    local v39 = u38.CFrame
                    local v40 = CFrame.Angles
                    local v41 = v37 * 50
                    u38.CFrame = v39 * v40(0, 0, (math.rad(v41)))
                    if tick() - u17 >= 1.6 then
                        _G.tween(u38.Decal, { 0.64, "Linear", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                        task.delay(0.8, function() --[[ Line: 166 ]]
                            --[[
                            Upvalues:
                                [1] = u38
                                [2] = u8
                            --]]
                            if u38 and not u8:GetAttribute("Cancelled") then
                                _G.tween(u38.Decal, { 0.5, "Linear", Enum.EasingDirection.Out }, {
                                    ["Transparency"] = 0
                                })
                            end
                        end)
                        u17 = tick()
                    end
                end)
                task.defer(function() --[[ Line: 175 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                        [2] = u18
                    --]]
                    local v42 = u8.Inner
                    local v43 = tick() - u18
                    u18 = tick()
                    local v44 = v42.CFrame
                    local v45 = CFrame.Angles
                    local v46 = v43 * -45
                    v42.CFrame = v44 * v45(0, 0, (math.rad(v46)))
                end)
                task.wait()
            end
            return
        end
    else
        local u47 = workspace.Effects:FindFirstChild("CastEffect" .. u4.Name)
        if not u47 then
            return
        end
        u47:SetAttribute("Cancelled", true)
        u47.Name = "_"
        local v48 = u4.PrimaryPart:FindFirstChild("IceDaggersSpin")
        if v48 then
            _G.tween(v48, { 0.15, "Circular", Enum.EasingDirection.Out }, {
                ["Volume"] = 0
            })
            v48.Name = "d"
            _G.destroy(v48, 0.15)
        end
        task.delay(0.6, function() --[[ Line: 202 ]]
            --[[
            Upvalues:
                [1] = u47
            --]]
            u47:SetAttribute("Destroyed", true)
        end)
        for _, v49 in u47:GetDescendants() do
            if v49:IsA("ParticleEmitter") then
                v49.Enabled = false
            elseif v49:IsA("PointLight") then
                _G.tween(v49, { 0.7, "Linear", "Out" }, {
                    ["Brightness"] = 0
                })
            elseif v49:IsA("Decal") then
                _G.tween(v49, { 0.7, "Linear", "Out" }, {
                    ["Transparency"] = 1
                })
            end
        end
        task.wait(1.8)
        u47:Destroy()
    end
end
return v2