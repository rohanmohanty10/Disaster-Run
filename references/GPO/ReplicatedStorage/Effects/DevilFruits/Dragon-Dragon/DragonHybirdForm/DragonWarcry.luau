
local u1 = game:GetService("TweenService")
local v2 = game:GetService("Players")
local u3 = game:GetService("RunService")
local v4 = game:GetService("ReplicatedStorage")
local u5 = script.Warcry
local u6 = workspace.CurrentCamera
local u7 = require(v4.Modules.CameraShaker)
local u8 = v2.LocalPlayer
local _ = _G.Emit
local function u13(p9, _) --[[ Line: 24 ]]
    local v10 = RaycastParams.new()
    local v11 = { workspace.Islands, workspace.Ships, workspace.Env }
    local v12 = Enum.RaycastFilterType.Include
    v10.FilterDescendantsInstances = v11
    v10.FilterType = v12
    return workspace:Raycast(p9, Vector3.new(0, -35, 0), v10) or {
        ["Position"] = Vector3.new(0, 0, 0),
        ["Normal"] = Vector3.new(1, 1, 1)
    }
end
local function u19(p14, p15) --[[ Line: 31 ]]
    local v16 = p14:FindFirstChild("Humanoid") or p14:FindFirstChild("AnimationController")
    if p14:IsA("AnimationController") ~= false then
        local v17 = p14:LoadAnimation((script:FindFirstChild(p15)))
        v17:Play()
        return v17
    end
    if not v16 then
        return nil
    end
    local v18 = v16:FindFirstChild("Animator"):LoadAnimation((script:FindFirstChild(p15)))
    v18:Play()
    return v18
end
local function u23(p20, p21) --[[ Line: 53 ]]
    for _, v22 in p20:GetDescendants() do
        if v22:IsA("ParticleEmitter") then
            v22.Enabled = p21
        end
    end
end
local function u51(u24, p25) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v26 = u24:GetPivot() * CFrame.new(0, 1.5, 0)
    local v27 = v26 * CFrame.new(p25:NextNumber(-25, 25), p25:NextNumber(-25, 25), p25:NextNumber(-25, 25))
    local v28 = CFrame.lookAt(v27.Position, v26.Position) * CFrame.new(p25:NextNumber(-15, 15), p25:NextNumber(-15, 15), -(v26.Position - v27.Position).Magnitude / 3)
    local v29 = CFrame.lookAt(v27.Position, v26.Position) * CFrame.new(p25:NextNumber(-15, 15), p25:NextNumber(-15, 15), -(v26.Position - v27.Position).Magnitude / 1.5)
    local u30 = v28.Position
    local u31 = v29.Position
    local u32 = v26.Position
    local u33 = v27.Position
    local u34 = script.Trail:Clone()
    u34.Position = u33
    u34.Parent = workspace.Effects
    local u35 = p25:NextNumber(0.1, 0.275)
    local u36 = nil
    local u37 = 0
    u36 = u3.Heartbeat:Connect(function(p38) --[[ Line: 89 ]]
        --[[
        Upvalues:
            [1] = u37
            [2] = u35
            [3] = u24
            [4] = u36
            [5] = u34
            [6] = u32
            [7] = u33
            [8] = u30
            [9] = u31
        --]]
        u37 = u37 + p38 / u35
        if u37 >= 1 or not u24:FindFirstChild("Head") then
            u36:Disconnect()
            u36 = nil
            _G.destroy(u34, 0.4)
        else
            u32 = u24:FindFirstChild("Head").Position
            local v39 = u37
            local v40 = u33
            local v41 = u30
            local v42 = u31
            local v43 = u32
            local v44 = (1 - v39) ^ 3 * v40 + (1 - v39) ^ 2 * 3 * v39 * v41 + (1 - v39) * 3 * v39 ^ 2 * v42 + v39 ^ 3 * v43
            local v45 = u37 + 0.004166666666666667
            local v46 = u33
            local v47 = u30
            local v48 = u31
            local v49 = u32
            local v50 = (1 - v45) ^ 3 * v46 + (1 - v45) ^ 2 * 3 * v45 * v47 + (1 - v45) * 3 * v45 ^ 2 * v48 + v45 ^ 3 * v49
            u34.CFrame = CFrame.lookAt(v44, v50)
        end
    end)
end
return {
    ["start"] = function(_, u52, p53) --[[ Name: start, Line 111 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u23
            [3] = u51
            [4] = u8
            [5] = u1
            [6] = u6
            [7] = u7
            [8] = u5
            [9] = u13
        --]]
        local u54 = u52:GetPivot()
        local v55 = u52:FindFirstChild("Head")
        local u56 = Random.new()
        if v55 then
            local v57 = u19(u52, "Roar")
            local v58 = u52:FindFirstChild("DragonTailController", true)
            if v58 then
                u19(v58, "Roar")
            end
            _G.PlaySound(u52.PrimaryPart, script.DragonHalfFormRoarStart).Parent = u52.PrimaryPart
            local v59 = script.Chargeup:Clone()
            v59.CFrame = v55:GetPivot()
            v59.Parent = workspace.Effects
            v59.Anchored = false
            local v60 = Instance.new("WeldConstraint")
            v60.Part0 = v59
            v60.Part1 = v55
            v60.Parent = v59
            task.delay(0.55, u23, v59, false)
            for v61 = 1, 24 do
                task.delay((v61 - 1) * 0.02, u51, u52, u56)
            end
            if u52 == u8.Character then
                u1:Create(u6, TweenInfo.new(0.65), {
                    ["FieldOfView"] = 55
                }):Play()
            end
            v57:AdjustSpeed(p53)
            task.wait(0.7 / p53)
            v57:AdjustSpeed(1)
            local u62
            if (workspace.CurrentCamera.CFrame.Position - u54.Position).Magnitude <= 100 then
                u62 = _G.camShake:ShakeSustain(u7.Presets.Shaking)
            else
                u62 = nil
            end
            v59:Destroy()
            if u52 == u8.Character then
                u1:Create(u6, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
                    ["FieldOfView"] = 70
                }):Play()
            end
            _G.PlaySound(u52.PrimaryPart, script.DragonHalfFormRoar).Parent = u52.PrimaryPart
            local v63 = u5.Roar:Clone()
            v63.CFrame = v55:GetPivot()
            v63.Parent = workspace.Effects
            v63.Anchored = false
            local v64 = Instance.new("WeldConstraint")
            v64.Part0 = v63
            v64.Part1 = v55
            v64.Parent = v63
            local v65 = u5.Area:Clone()
            v65.CFrame = u52:GetPivot() * CFrame.new(0, 7, 0)
            v65.Parent = workspace.Effects
            local v66 = u13(u52:GetPivot().Position, u52)
            if v66 and v66.Instance then
                local v67 = v66.Position
                local v68 = v66.Normal
                local v69 = u5.Floor:Clone()
                v69.CFrame = CFrame.lookAlong(v67, u52:GetPivot().LookVector, v68) * CFrame.new(0, v69.Size.Y / 2, 0)
                for _, v70 in v69:GetDescendants() do
                    if v70:IsA("ParticleEmitter") and v70:HasTag("Recolor") then
                        v70.Color = ColorSequence.new(v66.Instance.Color:Lerp(BrickColor.White().Color, 0.2))
                    end
                end
                v69.Parent = workspace.Effects
                task.delay(1.5, u23, v69, false)
                _G.destroy(v69, 4)
            end
            task.spawn(function() --[[ Line: 192 ]]
                --[[
                Upvalues:
                    [1] = u52
                    [2] = u1
                --]]
                local v71 = os.clock()
                local v72 = Instance.new("Model")
                v72.Parent = workspace.Effects
                local v73 = Instance.new("Highlight")
                v73.Enabled = false
                v73.Parent = v72
                while os.clock() - v71 < 1.5 do
                    local v74 = script.Bubble:Clone()
                    v74.CFrame = u52.Head.CFrame
                    v74.Size = Vector3.new(10, 10, 10)
                    v74.Parent = v72
                    u1:Create(v74, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                        ["Size"] = Vector3.new(35, 35, 35),
                        ["Transparency"] = 1
                    }):Play()
                    _G.destroy(v74, 0.25)
                    task.wait(0.5)
                end
                _G.destroy(v72, 0.35)
            end)
            task.spawn(function() --[[ Line: 222 ]]
                --[[
                Upvalues:
                    [1] = u56
                    [2] = u52
                    [3] = u13
                    [4] = u5
                    [5] = u1
                    [6] = u54
                --]]
                local v75 = os.clock()
                local v76 = {}
                while os.clock() - v75 < 1.25 do
                    local v77 = (os.clock() - v75) / 1.25
                    local v78 = math.clamp(v77, 0.2, 1)
                    task.wait(0.03333333333333333)
                    local v79 = (os.clock() - v75) / 0.75
                    math.min(v79, 1)
                    for _ = 0, u56:NextInteger(1, 2) do
                        local v80 = v78 * 21 + u56:NextNumber(-2, 2)
                        local v81 = u56:NextNumber(-3.141592653589793, 3.141592653589793)
                        local v82 = u52:GetPivot().Position * Vector3.new(1, 0, 1)
                        local v83 = u52:GetPivot().Position
                        local v84 = math.cos(v81) * v80
                        local v85 = math.sin(v81) * v80
                        local v86 = u13(v83 + Vector3.new(v84, 0, v85), u52)
                        if v86 and (v86.Instance and v86.Instance:IsA("BasePart")) then
                            local v87 = v86.Position
                            local v88 = v86.Normal
                            local u89 = u5.Debris:Clone()
                            u89.CFrame = CFrame.lookAt(v87 - v88 * u89.Size.Y, v82 + v87 * Vector3.new(0, 1, 0), v88)
                            u89.CFrame = u89.CFrame:Lerp(CFrame.lookAlong(v82 + v87 * Vector3.new(0, 1, 0), u89.CFrame.LookVector), 0.33)
                            _G.matchMaterial(u89, v86.Instance)
                            local v90 = u89.Size
                            u89.Size = u89.Size * 0.85
                            u89.Parent = workspace.Effects
                            local v91 = TweenInfo.new(u56:NextNumber(0.35, 0.65), Enum.EasingStyle.Cubic)
                            local u92 = v90 * u56:NextNumber(0.9, 1.2) * v78
                            local u93 = u1:Create(u89, v91, {
                                ["Size"] = u92,
                                ["CFrame"] = CFrame.lookAt(v87 + v88 * u92.Y / 2, v82 + v87 * Vector3.new(0, 1, 0), v88)
                            })
                            u93:Play()
                            u93.Completed:Once(function() --[[ Line: 262 ]]
                                --[[
                                Upvalues:
                                    [1] = u93
                                    [2] = u56
                                    [3] = u1
                                    [4] = u89
                                    [5] = u92
                                --]]
                                u93:Destroy()
                                task.wait(u56:NextNumber(1.5, 2.5))
                                u1:Create(u89, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                                    ["Size"] = Vector3.new(0, 0, 0),
                                    ["CFrame"] = u89.CFrame * CFrame.new(0, -u92.Y * 1.5, 0)
                                }):Play()
                                _G.destroy(u89, 1.5)
                            end)
                        end
                    end
                    local v94 = math.clamp(v78, 0.35, 1) * 21 + u56:NextNumber(-2, 2)
                    local v95 = u56:NextNumber(-3.141592653589793, 3.141592653589793)
                    local _ = u52:GetPivot().Position * Vector3.new(1, 0, 1)
                    local v96 = u52:GetPivot().Position
                    local v97 = math.cos(v95) * v94
                    local v98 = math.sin(v95) * v94
                    local v99 = u13(v96 + Vector3.new(v97, 0, v98), u52)
                    if v99 and (v99.Instance and v99.Instance:IsA("BasePart")) then
                        local v100 = v99.Position
                        local v101 = v99.Normal
                        local v102 = u5.SmallRock:Clone()
                        v102.Anchored = false
                        v102.CFrame = CFrame.lookAlong(v100 - v101 * v102.Size.Y, u56:NextUnitVector())
                        v102.Size = v102.Size * u56:NextNumber(0.15, 0.4)
                        _G.matchMaterial(v102, v99.Instance)
                        v102.Parent = workspace.Effects
                        table.insert(v76, v102)
                        local v103 = Instance.new("BodyAngularVelocity")
                        v103.AngularVelocity = u56:NextUnitVector() * u56:NextNumber(5, 15)
                        v103.MaxTorque = Vector3.new(600000, 600000, 600000)
                        v103.Parent = v102
                        local v104 = Instance.new("BodyPosition")
                        v104.Position = v100 + v101 * u56:NextNumber(6, 14)
                        v104.MaxForce = Vector3.new(600000, 600000, 600000)
                        v104.Parent = v102
                    end
                end
                task.wait(0.1)
                for _, u105 in v76 do
                    if u105:IsA("BasePart") then
                        u105:ClearAllChildren()
                        local v106 = u105.Position
                        local v107 = u54.Position.X
                        local v108 = v106.Y
                        local v109 = u54.Position.Z
                        local v110 = Vector3.new(v107, v108, v109)
                        local v111 = Instance.new("BodyVelocity")
                        v111.Velocity = CFrame.lookAt(v106, v110).LookVector * -u56:NextNumber(30, 45) + Vector3.new(0, 1, 0) * u56:NextNumber(15, 45)
                        v111.MaxForce = Vector3.new(600000, 600000, 600000)
                        v111.Parent = u105
                        task.delay(0.4, function() --[[ Line: 323 ]]
                            --[[
                            Upvalues:
                                [1] = u1
                                [2] = u105
                            --]]
                            u1:Create(u105, TweenInfo.new(1), {
                                ["Size"] = Vector3.new(0, 0, 0)
                            }):Play()
                        end)
                        _G.destroy(v111, 0.15)
                        _G.destroy(u105, 2.5)
                    end
                end
            end)
            task.delay(1.45, u23, v63, false)
            task.delay(1.6, u23, v65, false)
            task.delay(1.7, function() --[[ Line: 336 ]]
                --[[
                Upvalues:
                    [1] = u62
                --]]
                if u62 then
                    _G.camShake:StopSustained(0.2)
                end
            end)
            _G.destroy(v63, 3.5)
            _G.destroy(v65, 3.5)
        end
    end
}