 

game:GetService("ReplicatedStorage")
local u1 = script.TargetCast
local u2 = script.IceDagger
local u3 = script.Hit
local v4 = {}
local u5 = RaycastParams.new()
u5.FilterType = Enum.RaycastFilterType.Whitelist
u5.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
local u6 = {}
function v4.start(_, p7, p8, p9, p10, u11, p12) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u1
        [3] = u6
        [4] = u2
        [5] = u3
    --]]
    if _G.checkRenderDistance(p7.PrimaryPart.Position) ~= false then
        local v13 = p7.HumanoidRootPart
        if p9 == true and p8 then
            local _ = p8.HumanoidRootPart
            local v14 = workspace:Raycast(p10.Position, Vector3.new(0, -10, 0), u5)
            if v14 then
                local u15 = u1:Clone()
                u15.Name = "CastEffectTarget" .. p7.Name .. p8.Name
                u15:SetPrimaryPartCFrame(CFrame.new(v14.Position, v14.Position + v14.Normal) * CFrame.new(0, 0, -0.2) * CFrame.Angles(-1.5707963267948966, 0, 0))
                u15.Parent = workspace.Effects
                if u6[u11] == nil then
                    u6[u11] = {}
                end
                u6[u11][p8] = u15
                for _, u16 in u15:GetChildren() do
                    local v17 = u16.Name
                    if v17 ~= "Main" then
                        if v17 == "Inner" then
                            _G.tween(u16.Decal, { 0.3, "Cubic", Enum.EasingDirection.Out }, {
                                ["Transparency"] = -1
                            })
                            _G.tween(u16, { 0.3, "Cubic", Enum.EasingDirection.Out }, {
                                ["Size"] = Vector3.new(9, 9, 0.1),
                                ["CFrame"] = u16.CFrame * CFrame.Angles(0, 0, -1.5707963267948966)
                            })
                        elseif v17 == "Outer" then
                            _G.tween(u16, { 0.23, "Cubic", Enum.EasingDirection.Out }, {
                                ["Size"] = Vector3.new(9, 9, 0.1),
                                ["CFrame"] = u16.CFrame * CFrame.Angles(0, 0, 1.3962634015954636)
                            })
                            _G.tween(u16.Decal, { 0.23, "Cubic", Enum.EasingDirection.Out }, {
                                ["Transparency"] = 0
                            })
                            task.delay(0.1, function() --[[ Line: 48 ]]
                                --[[
                                Upvalues:
                                    [1] = u16
                                --]]
                                _G.tween(u16.Decal, { 0.13, "Cubic", Enum.EasingDirection.Out }, {
                                    ["Transparency"] = 0,
                                    ["Color3"] = Color3.fromRGB(240, 270, 2000)
                                })
                                task.delay(0.13, function() --[[ Line: 51 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u16
                                    --]]
                                    _G.tween(u16.Decal, { 0.15, "Circular", Enum.EasingDirection.Out }, {
                                        ["Transparency"] = -2,
                                        ["Color3"] = Color3.fromRGB(130, 180, 1000)
                                    })
                                end)
                            end)
                        elseif v17 == "Rotating2" then
                            _G.tween(u16, { 0.45, "Cubic", Enum.EasingDirection.Out }, {
                                ["Size"] = Vector3.new(9, 9, 0.1),
                                ["CFrame"] = u16.CFrame * CFrame.Angles(0, 0, 1.3962634015954636)
                            })
                            _G.tween(u16.Decal, { 0.4, "Linear", Enum.EasingDirection.Out }, {
                                ["Transparency"] = 0
                            })
                        elseif v17 == "Rotating3" then
                            _G.tween(u16, { 0.45, "Cubic", Enum.EasingDirection.Out }, {
                                ["Size"] = Vector3.new(11, 11, 0.1),
                                ["CFrame"] = u16.CFrame * CFrame.Angles(0, 0, 1.3962634015954636)
                            })
                            _G.tween(u16.Decal, { 0.35, "Linear", Enum.EasingDirection.Out }, {
                                ["Transparency"] = 0
                            })
                        elseif v17 == "BlackTexture" or v17 == "BlackTexture2" then
                            task.delay(0.5, function() --[[ Line: 62 ]]
                                --[[
                                Upvalues:
                                    [1] = u15
                                    [2] = u16
                                --]]
                                if u15.Name ~= "done" then
                                    _G.tween(u16.Decal, { 0.5, "Linear", Enum.EasingDirection.Out }, {
                                        ["Transparency"] = 0
                                    })
                                end
                            end)
                        end
                    end
                end
                local u18 = 0
                local u19 = 0
                local u20 = 0
                local u21 = 0
                for _, v22 in u15.Main:GetDescendants() do
                    if v22:IsA("ParticleEmitter") then
                        v22.Enabled = true
                        _G.customEmit(v22)
                    end
                end
                task.defer(function() --[[ Line: 83 ]]
                    --[[
                    Upvalues:
                        [1] = u15
                        [2] = u18
                        [3] = u19
                        [4] = u20
                        [5] = u21
                    --]]
                    while u15 and not u15:GetAttribute("Destroyed") do
                        task.defer(function() --[[ Line: 85 ]]
                            --[[
                            Upvalues:
                                [1] = u18
                                [2] = u15
                            --]]
                            local v23 = tick() - u18
                            u18 = tick()
                            local v24 = u15.Rotating3
                            local v25 = v24.CFrame
                            local v26 = CFrame.Angles
                            local v27 = v23 * -70
                            v24.CFrame = v25 * v26(0, 0, (math.rad(v27)))
                        end)
                        task.defer(function() --[[ Line: 93 ]]
                            --[[
                            Upvalues:
                                [1] = u19
                                [2] = u15
                                [3] = u20
                            --]]
                            local v28 = tick() - u19
                            u19 = tick()
                            local u29 = u15.Rotating2
                            local v30 = u29.CFrame
                            local v31 = CFrame.Angles
                            local v32 = v28 * 50
                            u29.CFrame = v30 * v31(0, 0, (math.rad(v32)))
                            if tick() - u20 >= 1.6 then
                                _G.tween(u29.Decal, { 0.64, "Linear", Enum.EasingDirection.Out }, {
                                    ["Transparency"] = 1
                                })
                                task.delay(0.8, function() --[[ Line: 106 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u29
                                        [2] = u15
                                    --]]
                                    if u29 and not u15:GetAttribute("Cancelled") then
                                        _G.tween(u29.Decal, { 0.5, "Linear", Enum.EasingDirection.Out }, {
                                            ["Transparency"] = 0
                                        })
                                    end
                                end)
                                u20 = tick()
                            end
                        end)
                        task.defer(function() --[[ Line: 115 ]]
                            --[[
                            Upvalues:
                                [1] = u15
                                [2] = u21
                            --]]
                            local v33 = u15.Inner
                            local v34 = tick() - u21
                            u21 = tick()
                            local v35 = v33.CFrame
                            local v36 = CFrame.Angles
                            local v37 = v34 * 15
                            v33.CFrame = v35 * v36(0, 0, (math.rad(v37)))
                        end)
                        task.wait()
                    end
                end)
            end
            while p12 and p12:IsDescendantOf(game) == true do
                local v38 = p8.HumanoidRootPart
                local u39 = u2:Clone()
                local v40 = v13.Position
                local v41 = v38.Position
                u39:PivotTo(CFrame.new(v40, v41))
                u39.Parent = workspace.Effects
                local v42 = tick()
                local v43 = (v40 - v41).Magnitude / 125
                local v44 = v42 + v43
                repeat
                    local v45 = v40:Lerp(v41, (tick() - v42) / v43)
                    u39:PivotTo(CFrame.new(v45, v41) * CFrame.Angles(3.141592653589793, 0, 0))
                    task.wait()
                until v44 <= tick()
                local u46 = u3:Clone()
                u46.Position = v38.Position + Vector3.new(0, 1, 0)
                u46.Parent = workspace.Effects
                for _, v47 in u46:GetDescendants() do
                    if v47:IsA("ParticleEmitter") then
                        _G.customEmit(v47)
                    end
                end
                task.delay(0.8, function() --[[ Line: 167 ]]
                    --[[
                    Upvalues:
                        [1] = u46
                    --]]
                    u46:Destroy()
                end)
                _G.PlaySound(v38, script.hitSFX, {
                    ["Pitch"] = math.random(90, 110) / 100
                })
                for _, v48 in u39:GetChildren() do
                    if v48:IsA("BasePart") then
                        v48.Transparency = 1
                    end
                end
                task.delay(0.6, function() --[[ Line: 177 ]]
                    --[[
                    Upvalues:
                        [1] = u39
                    --]]
                    u39:Destroy()
                end)
                task.wait(0.2)
            end
        else
            if u6[u11] == nil then
                return
            end
            local u49 = u6[u11][p8]
            if not u49 then
                return
            end
            u6[u11][p8] = nil
            u49:SetAttribute("Cancelled", true)
            u49.Name = "done"
            task.delay(0.6, function() --[[ Line: 195 ]]
                --[[
                Upvalues:
                    [1] = u49
                --]]
                u49:SetAttribute("Destroyed", true)
            end)
            for _, v50 in u49:GetDescendants() do
                if v50:IsA("ParticleEmitter") then
                    v50.Enabled = false
                elseif v50:IsA("PointLight") then
                    _G.tween(v50, { 0.7, "Linear", "Out" }, {
                        ["Brightness"] = 0
                    }, nil, true)
                elseif v50:IsA("Decal") then
                    _G.tween(v50, { 0.7, "Linear", "Out" }, {
                        ["Transparency"] = 1
                    }, nil, true)
                elseif v50:IsA("Beam") then
                    _G.tween(v50, { 0.7, "Linear", "Out" }, {
                        ["Transparency"] = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1) })
                    }, nil, true)
                end
            end
            task.delay(1.8, function() --[[ Line: 214 ]]
                --[[
                Upvalues:
                    [1] = u49
                --]]
                u49:Destroy()
            end)
            task.delay(10, function() --[[ Line: 217 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u11
                --]]
                u6[u11] = nil
            end)
        end
    end
end
return v4