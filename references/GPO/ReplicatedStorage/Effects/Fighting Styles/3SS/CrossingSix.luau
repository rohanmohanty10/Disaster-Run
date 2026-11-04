 

local v1 = {}
game:GetService("ReplicatedStorage")
game:GetService("Players")
game:GetService("Debris")
local u2 = game:GetService("Workspace")
local u3 = script.Move5
local u4 = u3.Anims
local u5 = {
    ["Slash1"] = u3.Slashes.First,
    ["Slash2"] = u3.Slashes.Second,
    ["Slash3"] = u3.Slashes.First,
    ["Slash4"] = u3.Slashes.First,
    ["Slash5"] = u3.Slashes.First,
    ["Fanum"] = u3.Slashes.Third
}
local function u8(p6) --[[ Line: 28 ]]
    for _, v7 in ipairs(p6:GetDescendants()) do
        if v7:IsA("ParticleEmitter") then
            v7:Emit(v7:GetAttribute("EmitCount") or 0)
        end
    end
end
local function u12(p9, p10) --[[ Line: 36 ]]
    for _, v11 in ipairs(p9:GetDescendants()) do
        if v11:IsA("ParticleEmitter") then
            v11.Enabled = p10
        end
    end
end
local function u18(p13, p14, p15, p16, p17) --[[ Line: 52 ]]
    _G.tween(p13, {
        p15,
        p16 or "Sine",
        p17 or "Out",
        0,
        false,
        0
    }, {
        ["Size"] = p14
    })
end
local function u24(p19, p20, p21) --[[ Line: 56 ]]
    local v22 = p21 or {}
    local v23 = p19:LoadAnimation(p20)
    v23.Priority = v22.Priority or Enum.AnimationPriority.Action4
    v23.Looped = v22.Looped or false
    v23:Play()
    return v23
end
function v1.start(_, u25, u26, p27, u28) --[[ Line: 66 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u12
        [4] = u24
        [5] = u4
        [6] = u8
        [7] = u18
        [8] = u5
    --]]
    if u25 ~= nil then
        local v29
        if u25 then
            v29 = u25.PrimaryPart
        else
            v29 = u25
        end
        if v29 ~= nil then
            if _G.checkRenderDistance(u25.PrimaryPart.Position) ~= false then
                local u30 = Instance.new("Folder")
                u30.Parent = u2.Effects
                local u31 = u25:WaitForChild("HumanoidRootPart")
                local v32 = u25:WaitForChild("Humanoid")
                local u33 = u25 == game.Players.LocalPlayer.Character
                if u33 == false then
                    u25:SetPrimaryPartCFrame(p27)
                end
                local v34, v35, v36 = _G.getRayFloor(u25.PrimaryPart.CFrame, u25.Humanoid.HipHeight + u25.PrimaryPart.Size.Y / 2)
                local v37 = CFrame.new(v35, v35 + v36)
                local v38 = CFrame.Angles
                local v39 = math.random(0, 360)
                local v40 = v37 * v38(-1.5707963267948966, math.rad(v39), 0)
                local u41 = u3.Chargup:Clone()
                u41.CFrame = CFrame.new(u31.Position) * CFrame.new(0, -2.5, 0)
                if v34 then
                    u41.CFrame = v40 * CFrame.new(0, 0.5, 0)
                end
                if u28 then
                    _G.PlayEffect("3SSRecolor", nil, u41, u28, "isBlue", Color3.fromRGB(46, 74, 255))
                end
                u41.Parent = u30
                u12(u41, true)
                local u42 = script["Audio/3ssSlashesChargeLoop"]:Clone()
                u42.Parent = u25.PrimaryPart
                u42:Play()
                tick()
                local u43 = u24(v32, u4.SixPaths)
                local u44 = nil
                local function u49(p45, p46, p47) --[[ Line: 108 ]]
                    --[[
                    Upvalues:
                        [1] = u33
                        [2] = u44
                        [3] = u25
                    --]]
                    if u33 ~= false then
                        if u44 then
                            u44:Destroy()
                        end
                        local v48 = Instance.new("BodyVelocity")
                        v48.MaxForce = Vector3.new(1000000, 1000000, 1000000)
                        v48.Velocity = u25.PrimaryPart.CFrame.LookVector * (p45 or 45)
                        if p46 then
                            v48.Velocity = p46 * p45
                        end
                        if p47 then
                            v48.Velocity = v48.Velocity + p47
                        end
                        v48.Parent = u25.PrimaryPart
                        _G.destroy(v48, 0.4)
                        u44 = v48
                    end
                end
                u43:GetMarkerReachedSignal("dash"):Connect(function(_) --[[ Line: 130 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                        [2] = u3
                        [3] = u31
                        [4] = u49
                    --]]
                    u25.PrimaryPart.Anchored = false
                    local v50 = u3.Dash2:Clone()
                    v50.CFrame = u31.CFrame * CFrame.new(0, -2.5, -5)
                    v50.Parent = workspace.Effects
                    _G.destroy(v50, 4)
                    _G.customEmit(v50)
                    u49(nil, nil, Vector3.new(0, 0, 0))
                end)
                u43:GetMarkerReachedSignal("dash1"):Connect(function() --[[ Line: 154 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                        [2] = u33
                        [3] = u44
                        [4] = u25
                        [5] = u3
                        [6] = u31
                        [7] = u28
                        [8] = u30
                        [9] = u8
                        [10] = u42
                        [11] = u18
                    --]]
                    local v51, _, _ = _G.getRayFloor(u25.PrimaryPart.CFrame, 8)
                    if u33 == true then
                        local v52 = _G.MouseCF.Position.X
                        local v53 = _G.MouseCF.Position.Y
                        local v54 = u25.PrimaryPart.Position.Y
                        local v55 = math.clamp(v53, v54, 100000000000)
                        local v56 = _G.MouseCF.Position.Z
                        local v57 = Vector3.new(v52, v55, v56)
                        u25:SetPrimaryPartCFrame((CFrame.new(u25.PrimaryPart.Position, v57)))
                        _G.tween(workspace.CurrentCamera, {
                            0.05,
                            "Quad",
                            Enum.EasingDirection.Out,
                            0,
                            true,
                            0
                        }, {
                            ["FieldOfView"] = 90
                        })
                        u25.Humanoid.AutoRotate = false
                        local v58 = CFrame.new(u25.PrimaryPart.Position, _G.MouseCF.Position).LookVector
                        if u33 ~= false then
                            if u44 then
                                u44:Destroy()
                            end
                            local v59 = Instance.new("BodyVelocity")
                            v59.MaxForce = Vector3.new(1000000, 1000000, 1000000)
                            v59.Velocity = u25.PrimaryPart.CFrame.LookVector * 65
                            if v58 then
                                v59.Velocity = v58 * 65
                            end
                            v59.Parent = u25.PrimaryPart
                            _G.destroy(v59, 0.4)
                            u44 = v59
                        end
                    end
                    local v60 = u3.Dash:Clone()
                    v60.CFrame = u31.CFrame * CFrame.new(0, -2.5, 0)
                    if u28 then
                        _G.PlayEffect("3SSRecolor", nil, v60, u28, "isBlue", Color3.fromRGB(46, 74, 255))
                    end
                    if v51 then
                        _G.recolorParticles(v60, v51.Color)
                    else
                        _G.removeParticles(v60)
                    end
                    v60.Parent = u30
                    u8(v60)
                    _G.tween(u42, {
                        0.25,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Volume"] = 0
                    })
                    _G.destroy(u42, 0.25)
                    _G.PlaySound(u25.PrimaryPart, script["Audio/3ssSlashesDash"]).Parent = u25.PrimaryPart
                    local v61 = u3.Pierce:Clone()
                    local v62 = Instance.new("Highlight")
                    v62.OutlineTransparency = 1
                    v62.DepthMode = Enum.HighlightDepthMode.Occluded
                    v62.FillTransparency = 1
                    v62.OutlineColor = Color3.fromRGB(70, 104, 255)
                    if u28 then
                        v62.OutlineColor = u28
                    end
                    v62.FillColor = Color3.fromRGB(19, 29, 47)
                    v62.Parent = v61
                    v61.CFrame = u31.CFrame * CFrame.Angles(0, -1.5707963267948966, 0)
                    v61.Parent = u30
                    u18(v61, Vector3.new(27, 0, 0), 0.23)
                    _G.destroy(v61, 0.23)
                end)
                _G.PlaySound(u25.PrimaryPart, script["Audio/3ssSlashesStance"])
                local u78 = u43:GetMarkerReachedSignal("Ohio"):Connect(function() --[[ Line: 209 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                        [2] = u5
                        [3] = u43
                        [4] = u3
                        [5] = u31
                        [6] = u28
                        [7] = u30
                        [8] = u8
                        [9] = u33
                        [10] = u26
                        [11] = u18
                        [12] = u12
                        [13] = u41
                    --]]
                    u25.Humanoid.AutoRotate = true
                    for u63, u64 in pairs(u5) do
                        u43:GetMarkerReachedSignal(u63):Connect(function() --[[ Line: 214 ]]
                            --[[
                            Upvalues:
                                [1] = u25
                                [2] = u64
                                [3] = u3
                                [4] = u31
                                [5] = u63
                                [6] = u28
                                [7] = u30
                                [8] = u8
                                [9] = u33
                                [10] = u26
                            --]]
                            local v65, _, _ = _G.getRayFloor(u25.PrimaryPart.CFrame, 8)
                            local v66 = u25.PrimaryPart.Velocity:Dot(u25.PrimaryPart.CFrame.LookVector) / 10
                            local v67 = u25.PrimaryPart.Velocity:Dot(u25.PrimaryPart.CFrame.upVector) / 10
                            local v68 = u64:Clone()
                            local v69 = u3.Ground:Clone()
                            v69.CFrame = u31.CFrame * CFrame.new(0, 0, -v66)
                            if u63 == "Fanum" then
                                v68.CFrame = v68.CFrame * CFrame.Angles(-0.017453292519943295, 0, 0)
                            end
                            if u28 then
                                _G.PlayEffect("3SSRecolor", nil, { v68, v69 }, u28, "isBlue", Color3.fromRGB(46, 74, 255))
                            end
                            if v65 then
                                _G.recolorParticles(v69, v65.Color)
                            else
                                _G.removeParticles(v69)
                            end
                            local v70 = v68.Position.Y + v67
                            local v71 = -v66
                            v68.Position = Vector3.new(0, v70, v71)
                            v68.Parent = u31
                            local v72 = v69.Bottom
                            v72.Parent = u25.UpperTorso
                            _G.customEmit(v72)
                            _G.destroy(v72, 4)
                            v69.Parent = u30
                            u8(v68)
                            u8(v69)
                            _G.destroy(v68, 1.25)
                            if script:FindFirstChild(u63) then
                                _G.PlaySound(u25.PrimaryPart, script:FindFirstChild(u63), {
                                    ["RandomPitch"] = true
                                }).Parent = u25.PrimaryPart
                            end
                            if u33 and u26 then
                                u26:FireServer(u63, u25.PrimaryPart.CFrame)
                            end
                        end)
                    end
                    u43:GetMarkerReachedSignal("Fanum"):Connect(function() --[[ Line: 257 ]]
                        --[[
                        Upvalues:
                            [1] = u33
                            [2] = u25
                            [3] = u3
                            [4] = u31
                            [5] = u28
                            [6] = u30
                            [7] = u8
                            [8] = u18
                        --]]
                        if u33 == true then
                            u25.PrimaryPart.Anchored = true
                            u25.Humanoid.AutoRotate = false
                            u25.PrimaryPart.Velocity = Vector3.new()
                        end
                        local v73 = u3.SlashImpactStartup:Clone()
                        v73.CFrame = u31.CFrame * CFrame.new(0, 0, -9)
                        if u28 then
                            _G.PlayEffect("3SSRecolor", nil, v73, u28, "isBlue", Color3.fromRGB(46, 74, 255))
                        end
                        v73.Parent = u30
                        u8(v73)
                        _G.PlaySound(u25.PrimaryPart, script["3ssSlashesW3.5"])
                        task.wait(0.5)
                        local v74 = u3.SlashImpact:Clone()
                        v74.CFrame = v73.CFrame
                        if u28 then
                            _G.PlayEffect("3SSRecolor", nil, v74, u28, "isBlue", Color3.fromRGB(46, 74, 255))
                        end
                        v74.Parent = u30
                        local v75 = u3.Mesh:Clone()
                        local v76 = Instance.new("Highlight")
                        v76.DepthMode = Enum.HighlightDepthMode.Occluded
                        v76.FillTransparency = 1
                        v76.OutlineColor = Color3.fromRGB(88, 138, 255)
                        if u28 then
                            v76.OutlineColor = u28
                        end
                        v76.FillColor = Color3.fromRGB(3, 5, 11)
                        v76.Parent = v75
                        v75.Parent = u30
                        v75.CFrame = v73.CFrame
                        u8(v74)
                        u18(v75, Vector3.new(48, 0, 0), 0.15, "Quad", "Out")
                        _G.destroy(v75, 0.15)
                        for _, v77 in ipairs(v74:GetDescendants()) do
                            if v77:IsA("Beam") then
                                _G.tween(v77, {
                                    0.45,
                                    "Quad",
                                    "Out",
                                    0,
                                    false,
                                    0
                                }, {
                                    ["Width0"] = 0,
                                    ["Width1"] = 0
                                })
                            end
                        end
                        _G.PlaySound(u25.PrimaryPart, script["Audio/3ssSlashesFinalSlash"])
                        if u33 == true then
                            u25.PrimaryPart.Anchored = false
                            u25.Humanoid.AutoRotate = true
                        end
                    end)
                    u12(u41, false)
                end)
                task.spawn(function() --[[ Line: 317 ]]
                    --[[
                    Upvalues:
                        [1] = u33
                        [2] = u25
                        [3] = u26
                        [4] = u43
                    --]]
                    if u33 == true then
                        local v79 = tick()
                        while true do
                            task.wait()
                            if (u25:FindFirstChild("PB") or u25:GetAttribute("crossingsixCancel")) and u26 then
                                u26:FireServer("forceCancel")
                                break
                            end
                            if u43.IsPlaying == false or tick() - v79 >= 5 then
                                break
                            end
                        end
                        u43:Stop()
                    end
                end)
                task.delay(4.5, function() --[[ Line: 333 ]]
                    --[[
                    Upvalues:
                        [1] = u78
                        [2] = u30
                    --]]
                    if u78 then
                        u78:Disconnect()
                    end
                    _G.destroy(u30, 1.5)
                end)
            end
        end
    end
end
return v1