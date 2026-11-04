 

local v1 = {}
local u2 = game:GetService("RunService")
local u3 = game:GetService("TweenService")
game:GetService("UserInputService")
local u4 = script.Animations
game.Players.LocalPlayer:GetMouse()
local function u10(p5) --[[ Line: 13 ]]
    local v6 = UserSettings().GameSettings.SavedQualityLevel.Value
    local v7 = math.clamp(v6, 1, 10)
    for _, v8 in p5:GetDescendants() do
        if v8:IsA("ParticleEmitter") then
            local v9 = v8:GetAttribute("EmitCount") * (v7 / 10)
            v8:Emit((math.clamp(v9, 1, v8:GetAttribute("EmitCount"))))
        end
    end
end
function PlayAnim(p11, p12)
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v13 = (p11:FindFirstChild("Humanoid") or p11:FindFirstChild("AnimationController")).Animator:LoadAnimation(u4[p12])
    v13:Play(0, 1, 1)
    return v13
end
local function u27(p14, p15) --[[ Line: 42 ]]
    local v16 = script.Cylinder:Clone()
    local v17 = (p14 - p15).Magnitude
    local v18 = next
    local v19, v20 = v16:GetChildren()
    for _, v21 in v18, v19, v20 do
        local v22 = v21.Size.Y * 1.2
        local v23 = v21.Size.Z * 1.2
        v21.Size = Vector3.new(v17, v22, v23)
    end
    local v24 = CFrame.new(p14, p15) * CFrame.new(0, 0, -v17 / 2) * CFrame.Angles(0, -1.5707963267948966, 0)
    local v25 = CFrame.Angles
    local v26 = math.random(-360, 360)
    v16:PivotTo(v24 * v25(math.rad(v26), 0, 0))
    v16:SetAttribute("priCFrame", v16:GetPivot())
    v16.Parent = workspace.Effects
    return v16
end
function ApplyProperties(u28, p29)
    for u30, v31 in next, p29 do
        if pcall(function() --[[ Line: 72 ]]
            --[[
            Upvalues:
                [1] = u28
                [2] = u30
            --]]
            return u28[u30] ~= nil
        end) then
            u28[u30] = v31
        end
    end
end
local function u44(p32) --[[ Line: 80 ]]
    if p32 ~= nil then
        local u33 = p32:GetAttribute("priCFrame")
        local v34 = next
        local v35, v36 = p32:GetDescendants()
        for _, u37 in v34, v35, v36 do
            if u37:IsA("ParticleEmitter") then
                u37.Enabled = false
            elseif u37:IsA("BasePart") ~= false then
                local u38 = u37.Name == "Glass" and 0.3 or 0.25
                task.delay(0.125, function() --[[ Line: 91 ]]
                    --[[
                    Upvalues:
                        [1] = u37
                        [2] = u38
                        [3] = u33
                    --]]
                    local v39 = _G.tween
                    local v40 = u37
                    local v41 = {
                        u38,
                        "Linear",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }
                    local v42 = {}
                    local v43 = u37.Size.X
                    v42.Size = Vector3.new(v43, 0, 0)
                    v42.CFrame = u33 + u33:inverse() * u37.Position * 0
                    v39(v40, v41, v42, nil, true)
                    _G.destroy(u37, u38)
                end)
            end
        end
    end
end
function v1.start(_, u45, p46, p47, p48, p49) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u27
        [2] = u10
        [3] = u2
        [4] = u44
        [5] = u3
    --]]
    if u45.PrimaryPart == nil then
        return
    elseif _G.checkRenderDistance(u45.PrimaryPart.Position) then
        if u45 then
            local v50 = u45:GetPivot()
            local v51 = u45 == game.Players.LocalPlayer.Character
            Random.new()
            local u52 = script.DokuDragon:Clone()
            u52.Parent = workspace.Effects
            u52:SetPrimaryPartCFrame(v50 * CFrame.new(0, 0.75, 0))
            PlayAnim(u52, "Idle")
            _G.PlaySound(u45.PrimaryPart, script.Sounds.VenomTravelStart)
            for _, v53 in u52:GetChildren() do
                if v53:IsA("BasePart") then
                    v53.Size = v53.Size * 1.25
                end
            end
            local v54 = (v50.Position - p46).Magnitude
            if v54 <= 15 then
                local v55 = Ray.new(u45.PrimaryPart.Position, (u45.PrimaryPart.Position - p46).unit * -15)
                local v56
                v56, p46 = _G.raycastWhitelist(v55, { workspace.Islands, workspace.Ships, workspace.Env })
                v54 = (v50.Position - p46).Magnitude
            end
            local v57 = v54 / 200 * 60
            local v58 = math.round(v57)
            local v59 = math.clamp(v58, 8, (1 / 0))
            local u60 = {}
            local v61
            if v51 == true then
                v61 = Instance.new("BodyVelocity")
                v61.Velocity = Vector3.new()
                v61.MaxForce = Vector3.new(inf, inf, inf)
                v61.Parent = u45.LowerTorso
            else
                v61 = nil
            end
            if v54 <= 80 then
                local v62 = 0
                for v63 = 0, v59 - 2 do
                    local v64 = v63 / v59
                    local v65 = v50.Position + (p46 - v50.Position) * v64
                    local v66 = v50.Position + (p46 - v50.Position) * (v64 + 1 / v59)
                    u60[#u60 + 1] = u27(v65, v66)
                    local v67 = v50.Position + (p46 - v50.Position) * (v64 + 2 / v59)
                    u52:PivotTo(CFrame.new(v66, v67))
                    if v62 <= 0 then
                        local v68 = task.wait(0.008333333333333333) / 0.016666666666666666
                        local v69 = math.floor(v68) - 1
                        v62 = math.clamp(v69, 0, (1 / 0))
                    end
                    v62 = v62 - 1
                end
            else
                local v70 = 0
                for v71 = 0, v59 - 2 do
                    local v72 = v71 / v59
                    local v73 = v50.Position
                    local v74 = (1 - v72) ^ 3 * v73 + 3 * (1 - v72) ^ 2 * v72 * p47 + 3 * (1 - v72) * v72 ^ 2 * p48 + v72 ^ 3 * p46
                    local v75 = v50.Position
                    local v76 = v72 + 1 / v59
                    local v77 = (1 - v76) ^ 3 * v75 + 3 * (1 - v76) ^ 2 * v76 * p47 + 3 * (1 - v76) * v76 ^ 2 * p48 + v76 ^ 3 * p46
                    u60[#u60 + 1] = u27(v74, v77)
                    local v78 = v50.Position
                    local v79 = v72 + 2 / v59
                    local v80 = (1 - v79) ^ 3 * v78 + 3 * (1 - v79) ^ 2 * v79 * p47 + 3 * (1 - v79) * v79 ^ 2 * p48 + v79 ^ 3 * p46
                    u52:PivotTo(CFrame.new(v77, v80))
                    if v70 <= 0 then
                        local v81 = task.wait(0.008333333333333333) / 0.016666666666666666
                        local v82 = math.floor(v81) - 1
                        v70 = math.clamp(v82, 0, (1 / 0))
                    end
                    v70 = v70 - 1
                end
            end
            local v83 = script.Sounds.VenomTravelMovement:Clone()
            v83.Parent = u52.PrimaryPart
            v83:Play()
            if v51 == true then
                u45.Humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)
            end
            local v84 = script.Jump:Clone()
            v84.Parent = workspace.Effects
            v84.CFrame = u45:GetPivot() * CFrame.new(0, -3, 0)
            u10(v84)
            _G.destroy(v84, 1.2)
            local u85 = 0
            local u86 = false
            local u87 = 0
            local u88 = 0
            local u89 = nil
            u89 = u2.Stepped:Connect(function(_, p90) --[[ Line: 223 ]]
                --[[
                Upvalues:
                    [1] = u88
                    [2] = u85
                    [3] = u87
                    [4] = u60
                    [5] = u44
                    [6] = u52
                    [7] = u89
                    [8] = u86
                    [9] = u45
                --]]
                u88 = u88 + p90
                if u88 >= 0.014285714285714285 then
                    local v91 = u88 / 0.016666666666666666 - 1
                    local v92 = math.floor(v91)
                    u85 = math.clamp(v92, 0, (1 / 0))
                    u88 = 0
                    u87 = u87 + 1
                    if u85 > 0 then
                        u85 = u85 - 1
                        local v93 = u60[u87]
                        if v93 then
                            u44(v93)
                            task.delay(1, v93.Destroy, v93)
                        end
                    else
                        local u94 = u60[u87]
                        local v95 = u60[u87 + 1]
                        if v95 == nil then
                            v95 = u52
                            u89:Disconnect()
                            u86 = true
                        end
                        if u45.Parent ~= workspace.NPCs and (u94 and v95) then
                            u45:PivotTo(CFrame.new(u94.PrimaryPart.Position, v95.PrimaryPart.Position) * CFrame.Angles(1.5707963267948966, 0, 0))
                        end
                        task.delay(1, function() --[[ Line: 259 ]]
                            --[[
                            Upvalues:
                                [1] = u94
                            --]]
                            if u94 then
                                u94:Destroy()
                            end
                        end)
                        u44(u94)
                    end
                else
                    return
                end
            end)
            if v51 == true then
                u45:PivotTo(u52:GetPivot() * CFrame.Angles(1.5707963267948966, 0, 0))
            end
            local v96 = os.clock()
            local v97 = u89
            repeat
                task.wait()
            until u86 or os.clock() - v96 > 8
            if u86 then
                task.wait()
                v83:Destroy()
                _G.PlaySound(u45.PrimaryPart, script.Sounds.VenomTravelLand)
                local v98 = u52:GetPivot()
                if v51 == true then
                    u45.PrimaryPart.Anchored = false
                    u45.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    if v61 then
                        v61:Destroy()
                    end
                    local v99 = Instance.new("BodyVelocity")
                    v99.Velocity = v98.LookVector * 110
                    local v100 = u45.PrimaryPart
                    v99.MaxForce = Vector3.new(100000000, 0, 100000000)
                    v99.Parent = v100
                    u3:Create(v99, TweenInfo.new(0.5), {
                        ["Velocity"] = Vector3.new(0, 0, 0)
                    }):Play()
                    _G.destroy(v99, 0.4)
                    if p49 then
                        p49:FireServer(u45.PrimaryPart.CFrame)
                    end
                end
                local v101 = script.Spit:Clone()
                v101.Parent = workspace.Effects
                v101.CFrame = v98
                u10(v101)
                local v102 = next
                local v103, v104 = u52:GetDescendants()
                for _, u105 in v102, v103, v104 do
                    if u105:IsA("ParticleEmitter") then
                        u105.Enabled = false
                    end
                    if u105:IsA("BasePart") then
                        task.delay(0.125, function() --[[ Line: 324 ]]
                            --[[
                            Upvalues:
                                [1] = u3
                                [2] = u105
                            --]]
                            u3:Create(u105, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                                ["Size"] = Vector3.new(0, 0, 0),
                                ["Transparency"] = 1
                            }):Play()
                        end)
                    end
                end
                _G.destroy(v101, 1.5)
                _G.destroy(u52, 0.8)
            else
                warn("TIMEOUT: VenomRoad yield expired")
                v97:Disconnect()
                v83:Destroy()
                if v61 and v61.Parent then
                    v61:Destroy()
                end
                if u45.PrimaryPart then
                    u45.PrimaryPart.Anchored = false
                end
                _G.destroy(u52, 0)
            end
        else
            return
        end
    else
        return
    end
end
return v1