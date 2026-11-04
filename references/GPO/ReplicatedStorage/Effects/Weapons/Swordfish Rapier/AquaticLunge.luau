 

local v1 = {}
local u2 = game:GetService("RunService")
game:GetService("Debris")
local u3 = script.VFX:GetScale()
local u13 = {
    ["Linear"] = function(p4) --[[ Name: Linear, Line 33 ]]
        return p4
    end,
    ["Quad"] = function(p5) --[[ Name: Quad, Line 34 ]]
        return p5 * p5
    end,
    ["Cubic"] = function(p6) --[[ Name: Cubic, Line 35 ]]
        return p6 * p6 * p6
    end,
    ["Quart"] = function(p7) --[[ Name: Quart, Line 36 ]]
        return p7 * p7 * p7 * p7
    end,
    ["Quint"] = function(p8) --[[ Name: Quint, Line 37 ]]
        return p8 * p8 * p8 * p8 * p8
    end,
    ["Sine"] = function(p9) --[[ Name: Sine, Line 38 ]]
        local v10 = p9 * 3.141592653589793 / 2
        return 1 - math.cos(v10)
    end,
    ["Exp"] = function(p11) --[[ Name: Exp, Line 39 ]]
        if p11 == 0 then
            return 0
        end
        local v12 = 10 * (p11 - 1)
        return math.pow(2, v12)
    end
}
local function u17(p14, p15, p16) --[[ Line: 43 ]]
    if p16 == "In" then
        return p15(p14)
    elseif p16 == "Out" then
        return 1 - p15(1 - p14)
    elseif p16 == "InOut" then
        if p14 < 0.5 then
            return p15(p14 * 2) / 2
        else
            return 1 - p15((1 - p14) * 2) / 2
        end
    else
        return p14
    end
end
function DisableBeams(p18, u19, p20, p21)
    --[[
    Upvalues:
        [1] = u13
        [2] = u17
    --]]
    if p18 then
        local u22 = u13[p20 or "Linear"] or u13.Linear
        local u23 = p21 or "Out"
        for _, u24 in pairs(p18:GetDescendants()) do
            if u24:IsA("Beam") then
                task.spawn(function() --[[ Line: 69 ]]
                    --[[
                    Upvalues:
                        [1] = u24
                        [2] = u19
                        [3] = u17
                        [4] = u22
                        [5] = u23
                    --]]
                    local v25 = u24
                    local v26 = v25.Transparency.Keypoints
                    local v27 = {}
                    for v28, v29 in ipairs(v26) do
                        v27[v28] = v29.Value
                    end
                    local v30 = tick()
                    while true do
                        local v31 = (tick() - v30) / u19
                        local v32 = math.clamp(v31, 0, 1)
                        local v33 = u17(v32, u22, u23)
                        local v34 = {}
                        for v35, v36 in ipairs(v26) do
                            local v37 = v27[v35] + (1 - v27[v35]) * v33
                            v34[v35] = NumberSequenceKeypoint.new(v36.Time, v37)
                        end
                        v25.Enabled = false
                        v25.Transparency = NumberSequence.new(v34)
                        v25.Enabled = true
                        task.wait()
                        if v32 >= 1 then
                            return
                        end
                    end
                end)
            end
        end
    end
end
local u38 = game:GetService("TweenService")
function TweenProperty(p39, p40, p41, p42, p43, p44)
    --[[
    Upvalues:
        [1] = u38
    --]]
    if p39 then
        if p44 == nil then
            p44 = false
        end
        return u38:Create(p39, TweenInfo.new(p40, Enum.EasingStyle[p41], Enum.EasingDirection[p42], 0, p44), p43)
    end
end
function TweenVelocity(p45, p46, p47, p48, p49, p50, p51, p52)
    local v53 = p52 or Instance.new("BodyVelocity")
    v53.Parent = p45
    v53.Velocity = p46
    v53.MaxForce = p48
    return {
        ["Velocity"] = v53,
        ["Tween"] = TweenProperty(v53, p51, p49, p50, {
            ["Velocity"] = p47
        })
    }
end
local function u66(p54, p55, p56) --[[ Line: 128 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v57 = script.VFX.ring:Clone()
    v57.CFrame = p54.CFrame * CFrame.new(0, 0, 4 * u3 * p55) * CFrame.Angles(1.5707963267948966, 0, 0)
    v57.Parent = workspace.Effects
    TweenProperty(v57, 0.35 * p56, "Cubic", "Out", {
        ["CFrame"] = v57.CFrame * CFrame.new(0, -7 * u3 * p55, 0)
    }):Play()
    TweenProperty(v57.Decal, 0.35 * p56, "Cubic", "Out", {
        ["Transparency"] = 1
    }):Play()
    TweenProperty(v57.Mesh, 0.35 * p56, "Cubic", "Out", {
        ["Scale"] = Vector3.new(-2.297, -7, -2.283) * p55 * u3
    }):Play()
    _G.destroy(v57, 0.35 * p56)
    local v58 = script.VFX.ring2:Clone()
    v58.CFrame = p54.CFrame * CFrame.new(0, 0, 4 * u3 * p55) * CFrame.Angles(1.5707963267948966, 0, 0)
    v58.Parent = workspace.Effects
    TweenProperty(v58, 0.4 * p56, "Cubic", "Out", {
        ["CFrame"] = v58.CFrame * CFrame.new(0, -9 * p55, 0)
    }):Play()
    TweenProperty(v58.Decal, 0.4 * p56, "Cubic", "Out", {
        ["Transparency"] = 1
    }):Play()
    TweenProperty(v58.Mesh, 0.4 * p56, "Cubic", "Out", {
        ["Scale"] = Vector3.new(-5.034, -0.5, -5.004) * p55
    }):Play()
    _G.destroy(v58, 0.4 * p56)
    local v59 = script.VFX.mesh:Clone()
    v59.CFrame = p54.CFrame * CFrame.new(0, 0, -10 * u3 * p55) * CFrame.Angles(1.5707963267948966, 0, 0)
    v59.Parent = workspace.Effects
    local v60 = TweenProperty
    local v61 = 0.35 * p56
    local v62 = {}
    local v63 = v59.Size
    local v64 = 10 * p55 * u3
    local v65 = 10 * p55 * u3
    v62.Size = v63 + Vector3.new(v64, 0, v65)
    v62.Transparency = 1
    v62.CFrame = v59.CFrame * CFrame.new(0, 10 * p55 * u3, 0)
    v60(v59, v61, "Quad", "Out", v62):Play()
    _G.destroy(v59, 0.35 * p56)
end
local u67 = {
    "rbxassetid://119827538140482",
    "rbxassetid://94766371110676",
    "rbxassetid://123208912741587",
    "rbxassetid://134867710844761",
    "rbxassetid://83366600435524",
    "rbxassetid://128353111761737",
    "rbxassetid://136296600784735",
    "rbxassetid://104535960303264",
    "rbxassetid://96504567036241",
    "rbxassetid://126248396869379",
    "rbxassetid://81245934474468",
    "rbxassetid://112557701311012",
    "rbxassetid://136395168077016",
    "rbxassetid://140506293591590",
    "rbxassetid://133281062308678",
    "rbxassetid://81505048695528",
    "rbxassetid://18799643112"
}
local function u77(u68, u69, p70) --[[ Line: 181 ]]
    local u71 = Instance.new("NumberValue")
    u71.Value = 1
    local v72 = TweenProperty(u71, p70, "Quad", "Out", {
        ["Value"] = #u68
    })
    v72:Play()
    local u76 = u71.Changed:Connect(function(_) --[[ Line: 188 ]]
        --[[
        Upvalues:
            [1] = u69
            [2] = u68
            [3] = u71
        --]]
        local v73 = u69
        local v74 = u68
        local v75 = u71.Value
        v73.Texture = v74[math.round(v75)]
    end)
    v72.Completed:Connect(function(_) --[[ Line: 192 ]]
        --[[
        Upvalues:
            [1] = u76
        --]]
        u76:Disconnect()
    end)
end
local function u88(p78) --[[ Line: 197 ]]
    --[[
    Upvalues:
        [1] = u77
        [2] = u67
    --]]
    for _ = 1, 2 do
        local v79 = script.VFX.Shockwave:Clone()
        local v80 = CFrame.Angles
        local v81 = math.random(-180, 180)
        v79:PivotTo(p78 * v80(0, 0, (math.rad(v81))))
        v79.Parent = workspace.Effects
        u77(u67, v79.Shockwave.Decal, 0.3)
        _G.destroy(v79, 0.3)
        local v82 = script.VFX.IceWind:Clone()
        local v83 = CFrame.Angles
        local v84 = math.random(-180, 180)
        v82:PivotTo(p78 * v83(0, 0, (math.rad(v84))))
        v82.Parent = workspace.Effects
        TweenProperty(v82.IceWind.Decal, 0.15, "Sine", "Out", {
            ["Transparency"] = 0
        }):Play()
        u77(u67, v82.IceWind.Decal, 0.5)
        _G.destroy(v82, 1)
        local v85 = script.VFX.Wind1:Clone()
        local v86 = CFrame.Angles
        local v87 = math.random(-180, 180)
        v85:PivotTo(p78 * v86(0, 0, (math.rad(v87))))
        v85.Parent = workspace.Effects
        TweenProperty(v85.Wind1.Decal, 0.15, "Sine", "Out", {
            ["Transparency"] = 0
        }):Play()
        u77(u67, v85.Wind1.Decal, 0.5)
        _G.destroy(v85, 1)
        task.wait(0.1)
    end
end
function v1.start(_, u89, u90) --[[ Line: 223 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u66
        [3] = u88
        [4] = u3
    --]]
    local u91 = game.Players.LocalPlayer.Character == u89
    local u92 = u89.Humanoid
    local u93 = u89.HumanoidRootPart
    local u94 = u89:WaitForChild("Head")
    _G.PlaySound(u89.PrimaryPart, script.WaterRapierBarrageStart).Parent = u89.PrimaryPart
    local v95 = u89.Humanoid.Animator:LoadAnimation(script.lunge)
    v95:Play()
    v95.Priority = Enum.AnimationPriority.Action4
    task.wait(0.2)
    local v96 = script.VFX.Windup.Attachment:Clone()
    v96.Parent = u93
    _G.destroy(v96, 3)
    _G.customEmit(v96)
    task.wait(0.25)
    local u97 = script.VFX.Barrage:Clone()
    local v98, v99, _ = _G.getRayFloor(u89.PrimaryPart.CFrame, 7)
    local v100 = Instance.new("Weld")
    v100.Part0 = u93
    v100.Part1 = u97.Primary
    if v98 then
        v100.C0 = CFrame.new(0, -(u89.PrimaryPart.Position.Y - v99.Y) / 2, 0)
    end
    v100.Parent = u93
    u97.Parent = workspace.Effects
    _G.customEmit(u97)
    local u101 = true
    pcall(function() --[[ Line: 7 ]]
        --[[
        Upvalues:
            [1] = u97
            [2] = u101
        --]]
        local u102 = u97:GetDescendants()
        for u103 = 1, #u102 do
            if u102[u103]:IsA("ParticleEmitter") then
                local v104 = u102[u103]:GetAttribute("EmitDelay") or 0
                task.delay(v104, function() --[[ Line: 12 ]]
                    --[[
                    Upvalues:
                        [1] = u102
                        [2] = u103
                        [3] = u101
                    --]]
                    u102[u103].Enabled = u101
                end)
            end
        end
    end)
    local v105 = script.WaterRapierBarrageLoop:Clone()
    v105.Parent = u97.PrimaryPart
    v105:Play()
    if u91 then
        u92.WalkSpeed = 4
    end
    repeat
        task.wait()
    until u89:GetAttribute("AquaLungeBarrage") == nil
    local u106 = false
    pcall(function() --[[ Line: 7 ]]
        --[[
        Upvalues:
            [1] = u97
            [2] = u106
        --]]
        local u107 = u97:GetDescendants()
        for u108 = 1, #u107 do
            if u107[u108]:IsA("ParticleEmitter") then
                local v109 = u107[u108]:GetAttribute("EmitDelay") or 0
                task.delay(v109, function() --[[ Line: 12 ]]
                    --[[
                    Upvalues:
                        [1] = u107
                        [2] = u108
                        [3] = u106
                    --]]
                    u107[u108].Enabled = u106
                end)
            end
        end
    end)
    DisableBeams(u97, 0.25, "Quad", "Out")
    _G.destroy(u97, 3)
    game:GetService("TweenService"):Create(v105, TweenInfo.new(0.25), {
        ["Volume"] = 0
    }):Play()
    _G.destroy(v105, 0.4)
    if u89:GetAttribute("AquaLungeBarrageCancel") == nil then
        task.wait(0.25)
        local v110, _, _ = _G.getRayFloor(u89.PrimaryPart.CFrame, 7)
        if v110 then
            local v111 = script.VFX.Kick.Kick:Clone()
            v111.CFrame = u89.PrimaryPart.CFrame
            _G.recolorParticles(v111, v110.Color)
            v111.Parent = workspace.Terrain
            _G.destroy(v111, 3)
            _G.customEmit(v111)
        end
        _G.PlaySound(u89.PrimaryPart, script.WaterRapierBarrageKickWhoosh).Parent = u89.PrimaryPart
        task.wait(0.4)
        v95:Stop()
        local v112 = u89.Humanoid.Animator:LoadAnimation(script.jump)
        v112:AdjustWeight(2)
        v112:Play(0)
        v112.Priority = Enum.AnimationPriority.Action4
        task.spawn(function() --[[ Line: 307 ]]
            --[[
            Upvalues:
                [1] = u92
                [2] = u91
                [3] = u93
                [4] = u94
            --]]
            local v113 = u92.CameraOffset
            if u91 ~= false then
                local v114 = tick()
                repeat
                    game:GetService("TweenService"):Create(u92, TweenInfo.new(0.15), {
                        ["CameraOffset"] = (u93.CFrame + Vector3.new(0, 1.5, 0)):pointToObjectSpace(u94.CFrame.Position)
                    }):Play()
                    task.wait()
                until tick() - v114 >= 1.2
                task.wait(0.05)
                game:GetService("TweenService"):Create(u92, TweenInfo.new(0.5), {
                    ["CameraOffset"] = v113
                }):Play()
            end
        end)
        local v115, v116, v117 = _G.getRayFloor(u89.PrimaryPart.CFrame, 7)
        if v115 then
            local v118 = script.VFX.JumpFX:Clone()
            v118.CFrame = CFrame.new(v116, v116 + v117) * CFrame.Angles(-1.5707963267948966, 0, 0)
            _G.recolorParticles(v118, v115.Color)
            v118.Parent = workspace.Effects
            _G.customEmit(v118)
            _G.destroy(v118, 4)
        end
        _G.PlaySound(u89.PrimaryPart, script.WaterRapierBarrageJump).Parent = u89.PrimaryPart
        task.delay(1.05, function() --[[ Line: 340 ]]
            --[[
            Upvalues:
                [1] = u89
            --]]
            _G.PlaySound(u89.PrimaryPart, script.WaterRapierBarrageDownSlash).Parent = u89.PrimaryPart
        end)
        local u119 = RaycastParams.new()
        u119.FilterType = Enum.RaycastFilterType.Include
        u119.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
        local u120 = 0
        local u121 = 0
        local u122 = u89.PrimaryPart.Position.Y
        local u123 = 0
        if u91 == true then
            local u124 = u89.PrimaryPart:FindFirstChildWhichIsA("BodyVelocity")
            if u124 then
                u124.Parent = script
            end
            local u125 = Instance.new("BodyVelocity")
            u125.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
            u125.Parent = u89.PrimaryPart
            local u126 = Instance.new("NumberValue")
            u126.Value = 100
            u126.Parent = script
            game:GetService("TweenService"):Create(u126, TweenInfo.new(1.15), {
                ["Value"] = 0
            }):Play()
            v112:GetMarkerReachedSignal("jump"):Connect(function() --[[ Line: 368 ]]
                --[[
                Upvalues:
                    [1] = u121
                    [2] = u122
                    [3] = u89
                --]]
                u121 = 100
                u122 = u89.PrimaryPart.Position.Y
            end)
            task.spawn(function() --[[ Line: 373 ]]
                --[[
                Upvalues:
                    [1] = u123
                    [2] = u89
                    [3] = u122
                    [4] = u121
                    [5] = u120
                    [6] = u119
                    [7] = u125
                    [8] = u126
                    [9] = u92
                    [10] = u2
                    [11] = u124
                --]]
                local v127 = tick()
                while true do
                    u123 = u89.PrimaryPart.Position.Y - u122
                    if u123 >= 15 and u121 > 0 then
                        u121 = 0
                        u120 = 0
                    elseif u123 <= 0 and u121 < 0 then
                        u121 = 0
                        u120 = 0
                    end
                    local v128 = workspace:Raycast(u89.PrimaryPart.Position, u89.PrimaryPart.CFrame.LookVector * 5, u119)
                    local v129
                    if v128 then
                        local v130 = (v128.Position - u89.PrimaryPart.Position).Magnitude / 5
                        v129 = math.max(0.2, v130)
                    else
                        v129 = 1
                    end
                    u120 = u120 + (u121 - u120) * 0.5
                    local v131 = u120
                    u125.Velocity = u89.PrimaryPart.CFrame.LookVector * u126.Value * v129 + Vector3.new(0, v131, 0)
                    u92.WalkSpeed = 4
                    u2.Stepped:Wait()
                    if tick() - v127 >= 1.15 then
                        u125:Destroy()
                        u126:Destroy()
                        if u124 and u124:IsDescendantOf(game) then
                            u124.Parent = u89.PrimaryPart
                        end
                        return
                    end
                end
            end)
        end
        v112:GetMarkerReachedSignal("down"):Connect(function() --[[ Line: 413 ]]
            --[[
            Upvalues:
                [1] = u121
                [2] = u93
                [3] = u66
                [4] = u88
                [5] = u3
                [6] = u89
                [7] = u119
                [8] = u90
                [9] = u91
                [10] = u2
            --]]
            u121 = 0
            local v132 = script.VFX.FinalPierce:Clone()
            v132.CFrame = u93.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(-0.9599310885968813, 0, 0)
            v132.Parent = workspace.Effects
            _G.customEmit(v132)
            _G.destroy(v132, 4)
            u66(v132, 1.25, 1.25)
            u88(v132.CFrame * CFrame.new(0, 0, -20 * u3))
            local v133 = workspace:Raycast(u89.PrimaryPart.Position, u89.PrimaryPart.CFrame.LookVector * 10, u119)
            local v134
            if v133 then
                local v135 = -(v133.Distance - 1)
                v134 = math.max(v135, -8)
            else
                v134 = -8
            end
            local v136 = u89.PrimaryPart.CFrame * CFrame.new(0, 0, v134)
            local v137 = workspace:Raycast(u89.PrimaryPart.Position, v136.Position - u89.PrimaryPart.Position, u119)
            if v137 then
                local v138 = v137.Normal * 2
                v136 = CFrame.new(v137.Position + v138)
            end
            local v139, v140, _ = _G.getRayFloor(v136, 25)
            local v141 = v136.Position
            if v139 then
                local v142 = u89.Humanoid.HipHeight + u89.PrimaryPart.Size.Y / 2
                local v143 = v140 + Vector3.new(0, 0.1, 0)
                local v144 = v142 + 5
                local v145 = Vector3.new(0, v144, 0)
                local v146 = workspace:Raycast(v143, v145, u119)
                if v146 then
                    local v147 = (v146.Position - v140).Y - u89.PrimaryPart.Size.Y / 2 - 0.5
                    local v148 = math.max(0, v147)
                    v142 = math.min(v142, v148)
                end
                v141 = v140 + Vector3.new(0, v142, 0)
            end
            local v149 = u89.PrimaryPart.CFrame
            u89.PrimaryPart.CFrame = CFrame.new(v141) * CFrame.Angles(u89.PrimaryPart.CFrame:ToEulerAnglesXYZ())
            if u90 and u91 == true then
                u90:FireServer(u89.PrimaryPart.CFrame, v149)
            end
            local v150 = tick()
            local v151 = u89.PrimaryPart
            repeat
                v151.AssemblyLinearVelocity = Vector3.new()
                v151.AssemblyAngularVelocity = Vector3.new()
                u2.Stepped:Wait()
            until tick() - v150 >= 0.5
        end)
        task.wait(1.15)
        u92.AutoRotate = false
    else
        v95:Stop()
    end
end
return v1