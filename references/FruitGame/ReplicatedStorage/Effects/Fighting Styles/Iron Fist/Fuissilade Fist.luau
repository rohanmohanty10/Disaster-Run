 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local u4 = game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
require(v1.Modules.CraterHandler)
require(v1.Modules.ParticleTween)
local _ = v3.LocalPlayer
local u5 = workspace.Effects
function Flipbook(p6, u7, u8, u9)
    local u10 = p6:FindFirstChildOfClass("SpecialMesh")
    if u10 and u7 then
        task.spawn(function() --[[ Line: 22 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u10
                [3] = u8
                [4] = u9
            --]]
            for v11 = 1, #u7 do
                u10.TextureId = u7[v11]
                task.wait(1 / u8)
            end
            if u9 == true then
                u10.Parent:Destroy()
            end
        end)
    end
end
local function u22(p12, p13, p14) --[[ Line: 36 ]]
    local function v20(u15, p16, p17) --[[ Line: 37 ]]
        for _, v18 in ipairs(u15:GetDescendants()) do
            if v18:IsA("ParticleEmitter") or v18:IsA("Trail") then
                v18.Enabled = p16
            end
        end
        if p17 then
            task.delay(p17, function() --[[ Line: 45 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                for _, v19 in ipairs(u15:GetDescendants()) do
                    if v19:IsA("ParticleEmitter") or v19:IsA("Trail") then
                        v19.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p12) == "table" then
        for _, v21 in p12 do
            v20(v21, p13, p14)
        end
    else
        v20(p12, p13, p14)
    end
end
local function u53(p23, u24) --[[ Line: 74 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    for _, u25 in p23:GetDescendants() do
        if u25.ClassName == "Beam" then
            local v26 = {}
            local u27 = {}
            for _, v28 in u25.Transparency.Keypoints do
                local v29 = NumberSequenceKeypoint.new
                local v30 = v28.Time
                local v31 = v28.Value
                local v32 = v28.Envelope
                table.insert(v26, v29(v30, v31, v32))
            end
            local u33 = NumberSequence.new(v26)
            for _, v34 in ipairs(u33.Keypoints) do
                local v35 = v34.Value + 1
                local v36 = math.clamp(v35, 0, 1)
                local v37 = NumberSequenceKeypoint.new
                local v38 = v34.Time
                table.insert(u27, v37(v38, v36))
            end
            local u39 = u33.Keypoints[#u33.Keypoints].Time
            local u40 = tick()
            local u41 = 0
            local u42 = nil
            u42 = u2.Heartbeat:Connect(function() --[[ Line: 98 ]]
                --[[
                Upvalues:
                    [1] = u41
                    [2] = u40
                    [3] = u39
                    [4] = u24
                    [5] = u33
                    [6] = u27
                    [7] = u25
                    [8] = u42
                --]]
                u41 = tick() - u40
                local v43 = u39
                local v44 = u41
                local v45 = math.min(v43, v44)
                local v46 = v45 / u39 / u24
                local v47 = {}
                for v48, v49 in ipairs(u33.Keypoints) do
                    local v50 = v49.Value + (u27[v48].Value - v49.Value) * v46
                    local v51 = NumberSequenceKeypoint.new
                    local v52 = v49.Time
                    table.insert(v47, v51(v52, v50))
                end
                u25.Transparency = NumberSequence.new(v47)
                if u39 <= v45 then
                    u42:Disconnect()
                end
            end)
        end
    end
end
local v54 = RaycastParams.new()
v54.FilterType = Enum.RaycastFilterType.Include
v54.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, u55, u56) --[[ Name: start, Line 131 ]]
        --[[
        Upvalues:
            [1] = u22
            [2] = u4
            [3] = u5
            [4] = u53
        --]]
        local u57 = u55:FindFirstChild("HumanoidRootPart")
        u55:FindFirstChild("Humanoid")
        local u58 = script.Normal
        local v59, v60
        if u56.HakiColor == nil then
            v59 = script.Air_Resistance:Clone()
            v59.CFrame = u57.CFrame * CFrame.new(0, 0, -2)
            v59.Parent = workspace.Effects
            u22(v59, true)
            local v61 = Instance.new("WeldConstraint")
            v61.Part0 = v59
            v61.Part1 = u57
            v61.Parent = v59
            for _, v62 in v59:GetDescendants() do
                if v62:IsA("Beam") then
                    v62.Enabled = true
                    local v63 = v62.Width0
                    local v64 = v62.Width1
                    v62.Width0 = 0
                    v62.Width1 = 0
                    u4:Create(v62, TweenInfo.new(0.5), {
                        ["Width0"] = v63,
                        ["Width1"] = v64
                    }):Play()
                end
            end
            v60 = script.Speed_Lines:Clone()
            v60:PivotTo(u57.CFrame * CFrame.new(0, 0, -4))
            v60.Parent = workspace.Effects
            u22(v60, true)
            local v65 = v60.PrimaryPart
            local v66 = Instance.new("WeldConstraint")
            v66.Part0 = v65
            v66.Part1 = u57
            v66.Parent = v65
            task.spawn(function() --[[ Line: 166 ]]
                --[[
                Upvalues:
                    [1] = u55
                    [2] = u57
                    [3] = u5
                    [4] = u4
                --]]
                while u55:GetAttribute("FuissiladeFistHold") == true do
                    local v67 = script.Shockwave:Clone()
                    v67:PivotTo(u57.CFrame * CFrame.new(0, 0, 4) * CFrame.Angles(1.5707963267948966, 0, 0))
                    v67.Parent = u5
                    _G.destroy(v67, 0.6)
                    for _, u68 in v67:GetChildren() do
                        local v69 = u68.Size * 1.2
                        u68.Size = Vector3.new(0, 0, 0)
                        local v70 = {
                            ["Size"] = v69
                        }
                        u4:Create(u68, TweenInfo.new(0.6, Enum.EasingStyle.Quint), v70):Play()
                        task.delay(0.2, function() --[[ Line: 179 ]]
                            --[[
                            Upvalues:
                                [1] = u68
                                [2] = u4
                            --]]
                            for _, v71 in u68:GetChildren() do
                                if v71.ClassName == "Decal" then
                                    u4:Create(v71, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
                                        ["Transparency"] = 1
                                    }):Play()
                                end
                            end
                        end)
                    end
                    task.wait(0.4)
                end
            end)
            task.spawn(function() --[[ Line: 192 ]]
                --[[
                Upvalues:
                    [1] = u55
                    [2] = u57
                --]]
                while u55:GetAttribute("FuissiladeFistHold") == true do
                    local v72 = script.Barrage:Clone()
                    v72.CFrame = u57.CFrame * CFrame.new(math.random(-5, 5), math.random(-2, 4), -3)
                    v72.Parent = workspace.Effects
                    _G.customEmit(v72)
                    _G.destroy(v72, 2)
                    local v73 = u57
                    local v74 = Instance.new("WeldConstraint")
                    v74.Part0 = v72
                    v74.Part1 = v73
                    v74.Parent = v72
                    local v75 = script.Barrage:Clone()
                    v75.CFrame = u57.CFrame * CFrame.new(math.random(-5, 5), math.random(-2, 4), -3)
                    v75.Parent = workspace.Effects
                    _G.customEmit(v75)
                    _G.destroy(v75, 2)
                    v75.Anchored = true
                    task.wait(0.05)
                end
            end)
        else
            u58 = script.Haki
            v59 = script.Haki_Air_Resistance:Clone()
            v59.CFrame = u57.CFrame * CFrame.new(0, 0, -2)
            _G.recolorParticles(v59, u56.HakiColor)
            v59.Parent = workspace.Effects
            u22(v59, true)
            local v76 = Instance.new("WeldConstraint")
            v76.Part0 = v59
            v76.Part1 = u57
            v76.Parent = v59
            for _, v77 in v59:GetDescendants() do
                if v77:IsA("Beam") then
                    v77.Enabled = true
                    local v78 = v77.Width0
                    local v79 = v77.Width1
                    v77.Width0 = 0
                    v77.Width1 = 0
                    u4:Create(v77, TweenInfo.new(0.5), {
                        ["Width0"] = v78,
                        ["Width1"] = v79
                    }):Play()
                end
            end
            v60 = script.Haki_Speed_Lines:Clone()
            v60:PivotTo(u57.CFrame * CFrame.new(0, 0, -4))
            _G.recolorParticles(v60, u56.HakiColor)
            v60.Parent = workspace.Effects
            u22(v60, true)
            local v80 = v60.PrimaryPart
            local v81 = Instance.new("WeldConstraint")
            v81.Part0 = v80
            v81.Part1 = u57
            v81.Parent = v80
            task.spawn(function() --[[ Line: 240 ]]
                --[[
                Upvalues:
                    [1] = u55
                    [2] = u57
                    [3] = u56
                    [4] = u4
                --]]
                while u55:GetAttribute("FuissiladeFistHold") == true do
                    local v82 = script.Haki_Showcase:Clone()
                    v82:PivotTo(u57.CFrame * CFrame.new(0, 0, 1) * CFrame.Angles(1.5707963267948966, 0, 0))
                    _G.recolorParticles(v82, u56.HakiColor)
                    v82.Parent = workspace.Effects
                    _G.destroy(v82, 0.6)
                    for _, u83 in v82:GetChildren() do
                        local v84 = u83.Size * 1.2
                        u83.Size = Vector3.new(0, 0, 0)
                        local v85 = {
                            ["Size"] = v84
                        }
                        u4:Create(u83, TweenInfo.new(0.6, Enum.EasingStyle.Quint), v85):Play()
                        task.delay(0.2, function() --[[ Line: 255 ]]
                            --[[
                            Upvalues:
                                [1] = u83
                                [2] = u4
                            --]]
                            for _, v86 in u83:GetChildren() do
                                if v86.ClassName == "Decal" then
                                    u4:Create(v86, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
                                        ["Transparency"] = 1
                                    }):Play()
                                end
                            end
                        end)
                    end
                    task.wait(0.4)
                end
            end)
            task.spawn(function() --[[ Line: 268 ]]
                --[[
                Upvalues:
                    [1] = u55
                    [2] = u57
                    [3] = u56
                --]]
                while u55:GetAttribute("FuissiladeFistHold") == true do
                    local v87 = script.Haki_Barage:Clone()
                    v87.CFrame = u57.CFrame * CFrame.new(math.random(-5, 5), math.random(-2, 4), -3)
                    _G.recolorParticles(v87, u56.HakiColor)
                    v87.Parent = workspace.Effects
                    _G.customEmit(v87)
                    _G.destroy(v87, 2)
                    local v88 = u57
                    local v89 = Instance.new("WeldConstraint")
                    v89.Part0 = v87
                    v89.Part1 = v88
                    v89.Parent = v87
                    local v90 = script.Haki_Barage:Clone()
                    v90.CFrame = u57.CFrame * CFrame.new(math.random(-5, 5), math.random(-2, 4), -3)
                    _G.recolorParticles(v90, u56.HakiColor)
                    v90.Parent = workspace.Effects
                    _G.customEmit(v90)
                    _G.destroy(v90, 2)
                    v90.Anchored = true
                    task.wait(0.05)
                end
            end)
        end
        _G.PlaySound(u55.PrimaryPart, u58.Start).Parent = u55.PrimaryPart
        local v91 = u58.Loop:Clone()
        v91.Parent = u55.PrimaryPart
        v91:Play()
        repeat
            task.wait()
        until u55:GetAttribute("FuissiladeFistHold") == nil
        u4:Create(v91, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
            ["Volume"] = 0
        }):Play()
        _G.destroy(v91, 0.25)
        if u55:FindFirstChild("PB") == nil then
            task.delay(0.25, function() --[[ Line: 308 ]]
                --[[
                Upvalues:
                    [1] = u55
                    [2] = u58
                --]]
                _G.PlaySound(u55.PrimaryPart, u58.Last)
            end)
        end
        if u56.HakiColor == nil then
            u22(v60, false)
            u22(v59, false)
            u53(v59, 0.15)
            _G.destroy(v59, 2)
            _G.destroy(v60, 2)
            if u55:FindFirstChild("PB") then
                return
            end
            task.wait(0.25)
            local v92 = script.FinalPunch:Clone()
            v92.CFrame = u57.CFrame
            v92.Parent = u5
            _G.customEmit(v92)
            _G.destroy(v92, 2)
            local u93 = script.BigWind:Clone()
            u93:PivotTo(u57.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(1.5707963267948966, 0, 0))
            u93.Parent = u5
            _G.destroy(u93, 1)
            u4:Create(u93.Start, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                ["Size"] = u93.End.Size
            }):Play()
            u4:Create(u93.Start, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["CFrame"] = u93.Start.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            }):Play()
            task.delay(0.1, function() --[[ Line: 343 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u93
                --]]
                u4:Create(u93.Start, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {
                    ["Transparency"] = 1
                }):Play()
            end)
            local u94 = script.Meshes:Clone()
            u94:PivotTo(u57.CFrame)
            u94.Parent = u5
            _G.destroy(u94, 2)
            u4:Create(u94.Wind2.Start.Mesh, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {
                ["Scale"] = u94.Wind2.End.Mesh.Scale
            }):Play()
            task.delay(0.1, function() --[[ Line: 354 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u94
                --]]
                u4:Create(u94.Wind2.Start, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
                    ["Transparency"] = 1
                }):Play()
            end)
            u4:Create(u94.Wind1.Start.Mesh, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
                ["Scale"] = u94.Wind1.End.Mesh.Scale
            }):Play()
            u4:Create(u94.Wind1.Start.Decal, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
                ["Transparency"] = 1
            }):Play()
        else
            u22(v60, false)
            u22(v59, false)
            u53(v59, 0.15)
            _G.destroy(v59, 2)
            _G.destroy(v60, 2)
            if u55:FindFirstChild("PB") then
                return
            end
            task.wait(0.25)
            local v95 = script.HakiFinalPunch:Clone()
            v95.CFrame = u57.CFrame
            _G.recolorParticles(v95, u56.HakiColor)
            v95.Parent = u5
            _G.customEmit(v95)
            _G.destroy(v95, 2)
            local u96 = script.Haki_BigWind:Clone()
            u96:PivotTo(u57.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(1.5707963267948966, 0, 0))
            _G.recolorParticles(u96, u56.HakiColor)
            u96.Parent = u5
            _G.destroy(u96, 1)
            u4:Create(u96.Start, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                ["Size"] = u96.End.Size
            }):Play()
            u4:Create(u96.Start, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["CFrame"] = u96.Start.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            }):Play()
            task.delay(0.1, function() --[[ Line: 392 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u96
                --]]
                u4:Create(u96.Start, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {
                    ["Transparency"] = 1
                }):Play()
            end)
        end
    end
}