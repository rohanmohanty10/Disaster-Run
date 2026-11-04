 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = RaycastParams.new()
local v5 = { workspace.Islands, workspace.Env, workspace.Ships }
local v6 = Enum.RaycastFilterType.Include
u4.FilterDescendantsInstances = v5
u4.FilterType = v6
local function u12(p7, p8, p9) --[[ Line: 10 ]]
    local v10 = script[p7]:Clone()
    v10:PivotTo(p8)
    v10.Parent = workspace.Effects
    for _, v11 in v10:GetChildren() do
        if p9[v11.Name] then
            p9[v11.Name](v11)
        else
            v11:Destroy()
        end
    end
    return v10
end
local function u14(p13) --[[ Line: 27 ]]
    _G.customEmit(p13)
end
local function u23(p15, p16, p17, p18, p19) --[[ Line: 53 ]]
    local v20 = (1 - p15) ^ 3 * p16 + 3 * (1 - p15) ^ 2 * p15 * p17 + 3 * (1 - p15) * p15 ^ 2 * p18 + p15 ^ 3 * p19
    local v21 = p15 + 0.006944444444444444
    local v22 = (1 - v21) ^ 3 * p16 + 3 * (1 - v21) ^ 2 * v21 * p17 + 3 * (1 - v21) * v21 ^ 2 * p18 + v21 ^ 3 * p19
    return CFrame.new(v20, v22)
end
local function u40(u24) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    local v25 = u24.HumanoidRootPart.CFrame
    local u26 = CFrame.new(Random.new():NextNumber(-8.5, 8.5), Random.new():NextNumber(-3, 8.5), Random.new():NextNumber(-8.5, 8.5))
    local v27 = ((u26 * v25).Position - v25.Position).Magnitude
    local u28 = CFrame.new(Random.new():NextNumber(-12.5, 12.5), Random.new():NextNumber(-16, 16), v27 / 2.5)
    local u29 = CFrame.new(Random.new():NextNumber(-4.5, 4.5), Random.new():NextNumber(-7, 7), v27 / 1.75)
    local u30 = nil
    local u31 = 0
    local u32 = script.Trail:Clone()
    u32.CFrame = v25 * u26
    u32.Parent = workspace.Effects
    u30 = game:GetService("RunService").Heartbeat:Connect(function(p33) --[[ Line: 85 ]]
        --[[
        Upvalues:
            [1] = u31
            [2] = u30
            [3] = u32
            [4] = u24
            [5] = u26
            [6] = u28
            [7] = u29
            [8] = u23
        --]]
        if u31 >= 1 then
            u30:Disconnect()
            for _, v34 in u32:GetChildren() do
                if v34:IsA("ParticleEmitter") then
                    v34.Enabled = false
                end
            end
            _G.destroy(u32, 0.85)
        else
            local v35 = u24.PrimaryPart.CFrame
            local v36 = (v35 * u26).Position
            local v37 = CFrame.new(v36, v35.Position) * u28
            local v38 = CFrame.new(v36, v35.Position) * u29
            u32.CFrame = u23(u31, v36, v37.Position, v38.Position, v35.Position)
            local v39 = u31 + p33 * 5
            u31 = math.clamp(v39, 0, 1)
        end
    end)
    return 5
end
function PlayAnim(p41, p42)
    local v43 = (p41:FindFirstChild("Humanoid") or p41:FindFirstChild("AnimationController")).Animator:LoadAnimation(script[p42])
    v43:Play(0, 1, 1)
    return v43
end
local function u64(p44, p45) --[[ Line: 120 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    local v46 = Random.new()
    local v47 = p45.PrimaryPart.CFrame * CFrame.new(0, 0, -13)
    for v48 = 1, p44 do
        for v49 = -1, 1, 2 do
            local v50 = v48 / p44
            local v51 = (v49 + math.sign(v49) * v46:NextNumber(0.1, 1)) * (v50 * 5 + 3)
            local v52 = v50 * 18 + v46:NextNumber(-0.75, 0.75)
            local v53 = v47 * CFrame.new(0, 0, v52)
            local v54 = v53 * CFrame.new(v51, 0, 0)
            local v55 = workspace:Raycast(v54.Position, Vector3.new(0, -25, 0), u4)
            if v55 then
                local _ = v55.Position
                local u56 = script.Debris:Clone()
                u56.CanCollide = false
                u56.Anchored = true
                local v57 = CFrame.lookAt
                local v58 = v55.Position
                local v59 = v53.X
                local v60 = v55.Position.Y
                local v61 = v53.Z
                u56.CFrame = v57(v58, (Vector3.new(v59, v60, v61))) * CFrame.Angles(0, v46:NextNumber(-3.141592653589793, 3.141592653589793), 0)
                local v62 = v55.Material
                local v63 = v55.Instance.Color
                u56.Material = v62
                u56.Color = v63
                u56.Size = Vector3.new(0, 0, 0)
                u56.Parent = workspace.Effects
                u2:Create(u56, TweenInfo.new(0.1), {
                    ["Size"] = Vector3.new(1, 1, 1) * v46:NextNumber(2, 3.75)
                }):Play()
                task.delay(v46:NextNumber(1.75, 2.25), function() --[[ Line: 147 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u56
                    --]]
                    u2:Create(u56, TweenInfo.new(0.75), {
                        ["Size"] = Vector3.new(0, 0, 0)
                    }):Play()
                    _G.destroy(u56, 0.75)
                end)
            end
        end
    end
end
function v1.start(_, u65, p66, p67) --[[ Line: 158 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u14
        [3] = u12
        [4] = u64
        [5] = u3
        [6] = u40
    --]]
    local u68 = Random.new()
    local v69 = u65 == game.Players.LocalPlayer.Character
    local v70 = workspace:GetServerTimeNow() - p67
    local function v76(p71) --[[ Line: 163 ]]
        --[[
        Upvalues:
            [1] = u65
            [2] = u2
        --]]
        local v72 = script.Hit:Clone()
        v72.CFrame = u65.PrimaryPart.CFrame
        local v73, _, _ = _G.getRayFloor(v72.CFrame, 15)
        if v73 then
            _G.recolorParticles(v72.groundParticles, v73.Color)
        else
            v72.groundParticles:Destroy()
        end
        v72.Parent = workspace.Effects
        if p71 then
            v72.Lines:Destroy()
            v72.Wind:Destroy()
        end
        _G.customEmit(v72)
        _G.destroy(v72, 3.5)
        for _, u74 in v72:GetDescendants() do
            if u74:IsA("Beam") then
                local u75 = Instance.new("NumberValue")
                u75.Value = 0
                u75.Changed:Connect(function() --[[ Line: 190 ]]
                    --[[
                    Upvalues:
                        [1] = u74
                        [2] = u75
                    --]]
                    u74.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, u75.Value), NumberSequenceKeypoint.new(1, 1) })
                end)
                u2:Create(u74, TweenInfo.new(0.75), {
                    ["TextureSpeed"] = u74.TextureSpeed * 0,
                    ["Width0"] = u74.Width0 * 0.8,
                    ["Width1"] = u74.Width1 * 0.8
                }):Play()
                u2:Create(u75, TweenInfo.new(0.5), {
                    ["Value"] = 1
                }):Play()
                _G.destroy(u75, 1)
            end
        end
    end
    local v89 = {
        ["Particles"] = u14,
        ["Outer"] = function(p77) --[[ Name: Outer, Line 210 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            local v78 = p77.Mesh.Scale * 1.5
            local v79 = p77.Mesh
            v79.Scale = v79.Scale * 0.5
            u2:Create(p77.Mesh, TweenInfo.new(0.25), {
                ["Scale"] = v78
            }):Play()
            u2:Create(p77.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
                ["Transparency"] = 1
            }):Play()
            u2:Create(p77, TweenInfo.new(0.45), {
                ["CFrame"] = p77.CFrame * CFrame.new(2.5, 0, 0) * CFrame.Angles(1.0471975511965976, 0, 0)
            }):Play()
        end,
        ["InnerW"] = function(p80) --[[ Name: InnerW, Line 220 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            local v81 = p80.Mesh.Scale * 1.5
            local v82 = p80.Mesh
            v82.Scale = v82.Scale * 0.75
            u2:Create(p80.Mesh, TweenInfo.new(0.3), {
                ["Scale"] = v81
            }):Play()
            u2:Create(p80.Decal, TweenInfo.new(0.325, Enum.EasingStyle.Linear), {
                ["Transparency"] = 1
            }):Play()
            u2:Create(p80, TweenInfo.new(0.4), {
                ["CFrame"] = p80.CFrame * CFrame.new(3, 0, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
            }):Play()
        end,
        ["Debris"] = function(p83) --[[ Name: Debris, Line 230 ]]
            --[[
            Upvalues:
                [1] = u68
                [2] = u2
            --]]
            local v84 = p83.Mesh.Scale * u68:NextNumber(1.25, 1.5)
            local v85 = u68:NextNumber(1, 5)
            local v86 = u68:NextNumber(-1.5707963267948966, 1.5707963267948966)
            u2:Create(p83.Mesh, TweenInfo.new(0.4), {
                ["Scale"] = v84
            }):Play()
            u2:Create(p83.Decal, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
                ["Transparency"] = 1
            }):Play()
            u2:Create(p83, TweenInfo.new(0.5), {
                ["CFrame"] = p83.CFrame * CFrame.new(v85, 0, 0) * CFrame.Angles(v86, 0, 0)
            }):Play()
        end,
        ["Main"] = function(p87) --[[ Name: Main, Line 239 ]]
            --[[
            Upvalues:
                [1] = u68
                [2] = u2
            --]]
            local v88 = u68:NextNumber(-1.5707963267948966, 1.5707963267948966)
            p87.Mesh.Scale = Vector3.new(0.097, 0.217, 0.209)
            p87.CFrame = p87.CFrame * CFrame.new(-3, 0, 0)
            u2:Create(p87.Mesh, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                ["Scale"] = Vector3.new(0.55, 0, 0)
            }):Play()
            u2:Create(p87, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                ["CFrame"] = p87.CFrame * CFrame.new(9, 0, 0) * CFrame.Angles(v88, 0, 0)
            }):Play()
        end
    }
    _G.PlaySound(u65.PrimaryPart, script.DragonTripleStrikeStart).Parent = u65.PrimaryPart
    if _G.castingSkill(u65, 0.533 - v70) == false then
        return
    else
        v76()
        _G.PlaySound(u65.PrimaryPart, script.DragonTripleStrikeWhoosh1).Parent = u65.PrimaryPart
        local v90 = u12("Fire", u65.PrimaryPart.CFrame * CFrame.new(0, 0, -3), v89)
        _G.destroy(v90, 2.5)
        u64(u68:NextInteger(3, 6), u65)
        local u91 = Instance.new("NumberValue")
        u91.Value = 75
        u2:Create(u91, TweenInfo.new(0.45), {
            ["Value"] = 7
        }):Play()
        local _ = u65.Name .. "CharacterVelocityControl"
        local u92, v93
        if v69 == true then
            local u94 = Instance.new("BodyVelocity")
            u94.Velocity = u65.PrimaryPart.CFrame.LookVector * u91.Value
            u94.MaxForce = Vector3.new(70000, 70000, 70000)
            u94.Parent = u65.PrimaryPart
            u92 = u3.RenderStepped:Connect(function() --[[ Line: 283 ]]
                --[[
                Upvalues:
                    [1] = u94
                    [2] = u65
                    [3] = u91
                --]]
                u94.Velocity = u65.PrimaryPart.CFrame.LookVector * u91.Value
            end)
            v93 = u94
        else
            u92 = nil
            v93 = nil
        end
        if v69 == true then
            p66:FireServer(u65.PrimaryPart.CFrame)
        end
        task.wait(0.55 - v70)
        local v95
        if u65:FindFirstChild("PB") then
            if v69 then
                p66:FireServer("cancel")
                u92:Disconnect()
                v95 = nil
                v93:Destroy()
                u91:Destroy()
            end
            return
        else
            u91.Value = 45
            u2:Create(u91, TweenInfo.new(0.25), {
                ["Value"] = 2
            }):Play()
            _G.PlaySound(u65.PrimaryPart, script.DragonTripleStrikeWhoosh2).Parent = u65.PrimaryPart
            v76()
            u64(u68:NextInteger(4, 7), u65)
            local v96 = u12("Thunder", u65.PrimaryPart.CFrame * CFrame.new(0, 0, -3), v89)
            _G.destroy(v96, 2.5)
            if v69 == true then
                p66:FireServer(u65.PrimaryPart.CFrame)
            end
            task.wait(0.5 - v70)
            if u65:FindFirstChild("PB") then
                if v69 then
                    p66:FireServer("cancel")
                    u92:Disconnect()
                    v95 = nil
                    v93:Destroy()
                    u91:Destroy()
                end
            else
                u91.Value = 15
                local v97 = script.chargup:Clone()
                v97.CFrame = u65.PrimaryPart.CFrame * CFrame.new(0, 0, -1.25)
                v97.Parent = workspace.Effects
                v97.Anchored = false
                local v98 = Instance.new("WeldConstraint")
                local v99 = u65.PrimaryPart
                v98.Parent = v97
                v98.Part0 = v97
                v98.Part1 = v99
                _G.destroy(v97, 2)
                _G.PlaySound(u65.PrimaryPart, script.DragonTripleStrikeWhoosh3).Parent = u65.PrimaryPart
                for _ = 1, 16 do
                    u40(u65)
                    task.wait(0.0625)
                end
                _G.particleEnabled(v97, false)
                if v69 == true then
                    p66:FireServer(u65.PrimaryPart.CFrame)
                end
                task.wait(0.08)
                u91.Value = 2
                _G.destroy({ u91 }, 1)
                if v93 then
                    _G.destroy(v93, 1)
                    task.delay(1, function() --[[ Line: 369 ]]
                        --[[
                        Upvalues:
                            [1] = u92
                        --]]
                        u92:Disconnect()
                        u92 = nil
                    end)
                end
                v76(true)
                local v106 = u12("Final", u65.PrimaryPart.CFrame * CFrame.new(0, 0, -3), {
                    ["Debris"] = v89.Debris,
                    ["Particles"] = u14,
                    ["Outer"] = v89.Outer,
                    ["InnerW"] = v89.InnerW,
                    ["Main"] = v89.Main,
                    ["FrontOuter"] = function(p100) --[[ Name: FrontOuter, Line 384 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u68
                        --]]
                        local v101 = p100.Mesh.Scale * 1.5
                        local v102 = p100.Mesh
                        v102.Scale = v102.Scale * 0.25
                        u2:Create(p100.Mesh, TweenInfo.new(u68:NextNumber(0.25, 0.4)), {
                            ["Scale"] = v101
                        }):Play()
                        u2:Create(p100.Decal, TweenInfo.new(u68:NextNumber(0.3, 0.5), Enum.EasingStyle.Linear), {
                            ["Transparency"] = 1
                        }):Play()
                        u2:Create(p100, TweenInfo.new(0.45), {
                            ["CFrame"] = p100.CFrame * CFrame.new(5, 0, 0) * CFrame.Angles(u68:NextNumber(1, 2.5) * 3.141592653589793 / 3, 0, 0)
                        }):Play()
                    end,
                    ["MiddleOuter"] = function(p103) --[[ Name: MiddleOuter, Line 393 ]]
                        --[[
                        Upvalues:
                            [1] = u68
                            [2] = u2
                        --]]
                        local v104 = u68:NextNumber(-1.5707963267948966, 1.5707963267948966)
                        local v105 = p103.Mesh
                        v105.Scale = v105.Scale * 1.25
                        u2:Create(p103.Mesh, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                            ["Scale"] = Vector3.new(0.5, 0, 0)
                        }):Play()
                        u2:Create(p103.Decal, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
                            ["Transparency"] = 1
                        }):Play()
                        u2:Create(p103, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                            ["CFrame"] = p103.CFrame * CFrame.new(6, 0, 0) * CFrame.Angles(v104, 0, 0)
                        }):Play()
                    end
                })
                _G.destroy(v106, 2.5)
                u64(u68:NextInteger(9, 14), u65)
            end
        end
    end
end
return v1