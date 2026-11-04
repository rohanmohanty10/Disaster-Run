 

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
local function u23(p15, p16, p17, p18, p19) --[[ Line: 31 ]]
    local v20 = (1 - p15) ^ 3 * p16 + 3 * (1 - p15) ^ 2 * p15 * p17 + 3 * (1 - p15) * p15 ^ 2 * p18 + p15 ^ 3 * p19
    local v21 = p15 + 0.006944444444444444
    local v22 = (1 - v21) ^ 3 * p16 + 3 * (1 - v21) ^ 2 * v21 * p17 + 3 * (1 - v21) * v21 ^ 2 * p18 + v21 ^ 3 * p19
    return CFrame.new(v20, v22)
end
local function u40(u24) --[[ Line: 43 ]]
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
    u30 = game:GetService("RunService").Heartbeat:Connect(function(p33) --[[ Line: 63 ]]
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
    v43.Priority = Enum.AnimationPriority.Action4
    return v43
end
local function u62(p44, p45) --[[ Line: 98 ]]
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
                u56.Size = Vector3.new(0, 0, 0)
                _G.matchMaterial(u56, v55.Instance)
                u56.Parent = workspace.Effects
                u2:Create(u56, TweenInfo.new(0.1), {
                    ["Size"] = Vector3.new(1, 1, 1) * v46:NextNumber(2, 3.75)
                }):Play()
                task.delay(v46:NextNumber(1.75, 2.25), function() --[[ Line: 126 ]]
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
function v1.start(_, u63, p64, p65) --[[ Line: 137 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u14
        [3] = u12
        [4] = u62
        [5] = u3
        [6] = u40
    --]]
    local u66 = Random.new()
    local v67 = u63 == game.Players.LocalPlayer.Character
    local v68 = workspace:GetServerTimeNow() - p65
    local function v75(p69) --[[ Line: 142 ]]
        --[[
        Upvalues:
            [1] = u63
            [2] = u2
        --]]
        local v70 = script.Hit:Clone()
        v70.CFrame = u63.PrimaryPart.CFrame
        local v71, v72, _ = _G.getRayFloor(v70.CFrame, 15)
        if v71 then
            v70.groundParticles.WorldPosition = v72 + Vector3.new(0, 0.3, 0)
            _G.recolorParticles(v70.groundParticles, v71.Color)
        else
            v70.groundParticles:Destroy()
        end
        v70.Parent = workspace.Effects
        if p69 then
            v70.Lines:Destroy()
            v70.Wind:Destroy()
        end
        _G.customEmit(v70)
        _G.destroy(v70, 3.5)
        for _, u73 in v70:GetDescendants() do
            if u73:IsA("Beam") then
                local u74 = Instance.new("NumberValue")
                u74.Value = 0
                u74.Changed:Connect(function() --[[ Line: 170 ]]
                    --[[
                    Upvalues:
                        [1] = u73
                        [2] = u74
                    --]]
                    u73.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, u74.Value), NumberSequenceKeypoint.new(1, 1) })
                end)
                u2:Create(u73, TweenInfo.new(0.75), {
                    ["TextureSpeed"] = u73.TextureSpeed * 0,
                    ["Width0"] = u73.Width0 * 0.8,
                    ["Width1"] = u73.Width1 * 0.8
                }):Play()
                u2:Create(u74, TweenInfo.new(0.5), {
                    ["Value"] = 1
                }):Play()
                _G.destroy(u74, 1)
            end
        end
    end
    local v88 = {
        ["Particles"] = u14,
        ["Outer"] = function(p76) --[[ Name: Outer, Line 190 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            local v77 = p76.Mesh.Scale * 1.5
            local v78 = p76.Mesh
            v78.Scale = v78.Scale * 0.5
            u2:Create(p76.Mesh, TweenInfo.new(0.25), {
                ["Scale"] = v77
            }):Play()
            u2:Create(p76.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
                ["Transparency"] = 1
            }):Play()
            u2:Create(p76, TweenInfo.new(0.45), {
                ["CFrame"] = p76.CFrame * CFrame.new(2.5, 0, 0) * CFrame.Angles(1.0471975511965976, 0, 0)
            }):Play()
        end,
        ["InnerW"] = function(p79) --[[ Name: InnerW, Line 200 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            local v80 = p79.Mesh.Scale * 1.5
            local v81 = p79.Mesh
            v81.Scale = v81.Scale * 0.75
            u2:Create(p79.Mesh, TweenInfo.new(0.3), {
                ["Scale"] = v80
            }):Play()
            u2:Create(p79.Decal, TweenInfo.new(0.325, Enum.EasingStyle.Linear), {
                ["Transparency"] = 1
            }):Play()
            u2:Create(p79, TweenInfo.new(0.4), {
                ["CFrame"] = p79.CFrame * CFrame.new(3, 0, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
            }):Play()
        end,
        ["Debris"] = function(p82) --[[ Name: Debris, Line 210 ]]
            --[[
            Upvalues:
                [1] = u66
                [2] = u2
            --]]
            local v83 = p82.Mesh.Scale * u66:NextNumber(1.25, 1.5)
            local v84 = u66:NextNumber(1, 5)
            local v85 = u66:NextNumber(-1.5707963267948966, 1.5707963267948966)
            u2:Create(p82.Mesh, TweenInfo.new(0.4), {
                ["Scale"] = v83
            }):Play()
            u2:Create(p82.Decal, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
                ["Transparency"] = 1
            }):Play()
            u2:Create(p82, TweenInfo.new(0.5), {
                ["CFrame"] = p82.CFrame * CFrame.new(v84, 0, 0) * CFrame.Angles(v85, 0, 0)
            }):Play()
        end,
        ["Main"] = function(p86) --[[ Name: Main, Line 219 ]]
            --[[
            Upvalues:
                [1] = u66
                [2] = u2
            --]]
            local v87 = u66:NextNumber(-1.5707963267948966, 1.5707963267948966)
            p86.Mesh.Scale = Vector3.new(0.097, 0.217, 0.209)
            p86.CFrame = p86.CFrame * CFrame.new(-3, 0, 0)
            u2:Create(p86.Mesh, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                ["Scale"] = Vector3.new(0.55, 0, 0)
            }):Play()
            u2:Create(p86, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                ["CFrame"] = p86.CFrame * CFrame.new(9, 0, 0) * CFrame.Angles(v87, 0, 0)
            }):Play()
        end
    }
    _G.PlaySound(u63.PrimaryPart, script.DragonTripleStrikeStart).Parent = u63.PrimaryPart
    if _G.castingSkill(u63, 0.533 - v68) == false then
        return
    else
        v75()
        _G.PlaySound(u63.PrimaryPart, script.DragonTripleStrikeWhoosh1).Parent = u63.PrimaryPart
        local v89 = u12("Fire", u63.PrimaryPart.CFrame * CFrame.new(0, 0, -3), v88)
        _G.destroy(v89, 2.5)
        u62(u66:NextInteger(3, 6), u63)
        local u90 = Instance.new("NumberValue")
        u90.Value = 75
        u2:Create(u90, TweenInfo.new(0.45), {
            ["Value"] = 7
        }):Play()
        local u91 = nil
        local u92
        if v67 == true then
            u92 = Instance.new("BodyVelocity")
            u92.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
            u92.Velocity = Vector3.new()
            u92.Parent = u63.PrimaryPart
            local u93 = u63.PrimaryPart
            local v98 = u3.Heartbeat:Connect(function() --[[ Line: 320 ]]
                --[[
                Upvalues:
                    [1] = u63
                    [2] = u91
                    [3] = u92
                    [4] = u93
                    [5] = u90
                --]]
                if u63:FindFirstChild("PB") then
                    u91:Disconnect()
                    u92:Destroy()
                else
                    u93.AssemblyAngularVelocity = Vector3.new()
                    local v94 = u93.CFrame.LookVector
                    local v95 = v94.X
                    local v96 = v94.Z
                    local v97 = Vector3.new(v95, 0, v96).Unit * u90.Value
                    if v97 == v97 then
                        u92.Velocity = v97
                    end
                end
            end)
            u91 = v98
        else
            u92 = nil
        end
        if v67 == true then
            p64:FireServer(u63.PrimaryPart.CFrame)
        end
        task.wait(0.55 - v68)
        local v99
        if u63:FindFirstChild("PB") then
            if v67 then
                p64:FireServer("cancel")
                if u91 then
                    u91:Disconnect()
                    v99 = nil
                end
                if u92 then
                    u92:Destroy()
                end
                u90:Destroy()
            end
            return
        else
            u90.Value = 45
            u2:Create(u90, TweenInfo.new(0.25), {
                ["Value"] = 2
            }):Play()
            _G.PlaySound(u63.PrimaryPart, script.DragonTripleStrikeWhoosh2).Parent = u63.PrimaryPart
            v75()
            u62(u66:NextInteger(4, 7), u63)
            local v100 = u12("Thunder", u63.PrimaryPart.CFrame * CFrame.new(0, 0, -3), v88)
            _G.destroy(v100, 2.5)
            if v67 == true then
                p64:FireServer(u63.PrimaryPart.CFrame)
            end
            task.wait(0.5 - v68)
            if u63:FindFirstChild("PB") then
                if v67 then
                    p64:FireServer("cancel")
                    if u91 then
                        u91:Disconnect()
                        v99 = nil
                    end
                    if u92 then
                        u92:Destroy()
                    end
                    u90:Destroy()
                end
            else
                u90.Value = 15
                local u101 = script.chargup:Clone()
                u101.CFrame = u63.PrimaryPart.CFrame * CFrame.new(0, 0, -1.25)
                u101.Anchored = false
                u101.Parent = workspace.Effects
                local v102 = Instance.new("WeldConstraint")
                local v103 = u63.PrimaryPart
                v102.Parent = u101
                v102.Part0 = u101
                v102.Part1 = v103
                _G.destroy(u101, 6)
                _G.PlaySound(u63.PrimaryPart, script.DragonTripleStrikeWhoosh3).Parent = u63.PrimaryPart
                local v107 = u3.Heartbeat:Connect(function() --[[ Line: 403 ]]
                    --[[
                    Upvalues:
                        [1] = u63
                        [2] = u101
                    --]]
                    local v104, v105, v106 = _G.getRayFloor(u63.PrimaryPart.CFrame, 15)
                    u101.FloorAttachment.WorldCFrame = CFrame.new(v105, v105 + v106) * CFrame.Angles(1.5707963267948966, 0, 0)
                    if v104 then
                        _G.recolorParticles(u101.FloorAttachment, v104.Color)
                        _G.particleEnabled(u101.FloorAttachment, true)
                    else
                        _G.particleEnabled(u101.FloorAttachment, false)
                    end
                end)
                for _ = 1, 16 do
                    u40(u63)
                    task.wait(0.0625)
                end
                v107:Disconnect()
                _G.particleEnabled(u101, false)
                if v67 == true then
                    p64:FireServer(u63.PrimaryPart.CFrame)
                end
                task.wait(0.08)
                u90.Value = 2
                _G.destroy({ u90 }, 1)
                if u92 then
                    _G.destroy(u92, 1)
                    task.delay(1, function() --[[ Line: 435 ]]
                        --[[
                        Upvalues:
                            [1] = u91
                            [2] = u90
                        --]]
                        if u91 then
                            u91:Disconnect()
                            u91 = nil
                        end
                        u90:Destroy()
                    end)
                end
                v75(true)
                local v114 = u12("Final", u63.PrimaryPart.CFrame * CFrame.new(0, 0, -3), {
                    ["Debris"] = v88.Debris,
                    ["Particles"] = u14,
                    ["Outer"] = v88.Outer,
                    ["InnerW"] = v88.InnerW,
                    ["Main"] = v88.Main,
                    ["FrontOuter"] = function(p108) --[[ Name: FrontOuter, Line 453 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u66
                        --]]
                        local v109 = p108.Mesh.Scale * 1.5
                        local v110 = p108.Mesh
                        v110.Scale = v110.Scale * 0.25
                        u2:Create(p108.Mesh, TweenInfo.new(u66:NextNumber(0.25, 0.4)), {
                            ["Scale"] = v109
                        }):Play()
                        u2:Create(p108.Decal, TweenInfo.new(u66:NextNumber(0.3, 0.5), Enum.EasingStyle.Linear), {
                            ["Transparency"] = 1
                        }):Play()
                        u2:Create(p108, TweenInfo.new(0.45), {
                            ["CFrame"] = p108.CFrame * CFrame.new(5, 0, 0) * CFrame.Angles(u66:NextNumber(1, 2.5) * 3.141592653589793 / 3, 0, 0)
                        }):Play()
                    end,
                    ["MiddleOuter"] = function(p111) --[[ Name: MiddleOuter, Line 462 ]]
                        --[[
                        Upvalues:
                            [1] = u66
                            [2] = u2
                        --]]
                        local v112 = u66:NextNumber(-1.5707963267948966, 1.5707963267948966)
                        local v113 = p111.Mesh
                        v113.Scale = v113.Scale * 1.25
                        u2:Create(p111.Mesh, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                            ["Scale"] = Vector3.new(0.5, 0, 0)
                        }):Play()
                        u2:Create(p111.Decal, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
                            ["Transparency"] = 1
                        }):Play()
                        u2:Create(p111, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                            ["CFrame"] = p111.CFrame * CFrame.new(6, 0, 0) * CFrame.Angles(v112, 0, 0)
                        }):Play()
                    end
                })
                _G.destroy(v114, 5)
                u62(u66:NextInteger(9, 14), u63)
            end
        end
    end
end
return v1