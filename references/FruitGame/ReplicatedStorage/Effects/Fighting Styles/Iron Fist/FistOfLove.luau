 

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
local u54 = RaycastParams.new()
u54.FilterType = Enum.RaycastFilterType.Include
u54.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p55, u56) --[[ Name: start, Line 130 ]]
        --[[
        Upvalues:
            [1] = u22
            [2] = u5
            [3] = u4
            [4] = u53
            [5] = u2
            [6] = u54
        --]]
        local v57 = p55:FindFirstChild("HumanoidRootPart")
        local v58 = script.Normal
        if u56.HakiColor then
            v58 = script.Haki
        end
        local v59
        if u56.HakiColor == nil then
            v59 = script.StartUpBody:Clone()
        else
            v59 = script.Haki_Body:Clone()
            _G.recolorParticles(v59, u56.HakiColor)
        end
        v59.CFrame = v57.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
        v59.Parent = workspace.Effects
        u22(v59, true)
        local v60 = Instance.new("WeldConstraint")
        v60.Part0 = v59
        v60.Part1 = v57
        v60.Parent = v59
        local v61, v62, v63 = _G.getRayFloor(v57.CFrame, 10)
        local v64 = CFrame.new(v62, v62 + v63) * CFrame.Angles(-1.5707963267948966, 0.0017453292519943296, 0)
        if v61 then
            _G.PlaySound(p55.PrimaryPart, v58.Stance)
        end
        task.wait(0.217)
        local v65 = v58.Loop:Clone()
        v65.Parent = p55.PrimaryPart
        v65:Play()
        if v61 then
            local v66 = script.StartUpFloor:Clone()
            _G.recolorParticles(v66, v61.Color)
            v66.CFrame = v64
            v66.Parent = u5
            _G.customEmit(v66)
            _G.destroy(v66, 3)
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 15,
                ["Position"] = v62 + Vector3.new(0, 5, 0),
                ["DistanceRandomness"] = Vector2.new(0.4, 1),
                ["Duration"] = 3,
                ["TweenDuration"] = 1,
                ["Radius"] = 7,
                ["Direction"] = Vector3.new(0, -15, 0)
            })
            if u56.HakiColor ~= nil then
                local v67 = script.Haki_Floor:Clone()
                _G.recolorParticles(v67, u56.HakiColor)
                v67.CFrame = v64
                v67.Parent = u5
                _G.customEmit(v67)
                _G.destroy(v67, 3)
            end
            local v68 = script.Big_Wind_mesh:Clone()
            v68:PivotTo(v64 * CFrame.Angles(0, 0, 1.5707963267948966))
            v68.Parent = u5
            _G.destroy(v68, 1)
            u4:Create(v68.Start.Decal, TweenInfo.new(0.2, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            u4:Create(v68.Start.Mesh, TweenInfo.new(0.1), {
                ["Scale"] = v68.End.Mesh.Scale
            }):Play()
            u4:Create(v68.Start, TweenInfo.new(0.1), {
                ["CFrame"] = v68.End.CFrame
            }):Play()
        end
        repeat
            task.wait()
        until p55:GetAttribute("FistofLoveHold") == nil
        u4:Create(v65, TweenInfo.new(0.2), {
            ["Volume"] = 0
        }):Play()
        _G.destroy(v65, 0.2)
        u22(v59, false)
        _G.destroy(v59, 2)
        local v69 = os.clock()
        repeat
            task.wait()
        until p55:GetAttribute("FistofLoveGoal") ~= nil or os.clock() - v69 > 8
        if p55:GetAttribute("FistofLoveGoal") then
            local v70 = p55:GetAttribute("FistofLoveGoal")
            local v71 = p55:FindFirstChild("HumanoidRootPart")
            local v72 = v71.CFrame
            local v73 = (v70.Position - v72.Position).Magnitude / 200
            if u56.HakiColor == nil then
                local u74 = script.BigWind:Clone()
                u74:PivotTo(v71.CFrame * CFrame.new(0, 0, -9) * CFrame.Angles(1.5707963267948966, 0, 0))
                u74.Parent = u5
                _G.destroy(u74, 1)
                u4:Create(u74.Start, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                    ["Size"] = u74.End.Size
                }):Play()
                u4:Create(u74.Start, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["CFrame"] = u74.Start.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                }):Play()
                task.delay(0.1, function() --[[ Line: 237 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u74
                    --]]
                    u4:Create(u74.Start, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {
                        ["Transparency"] = 1
                    }):Play()
                end)
                local u75 = script.AnotherWind:Clone()
                u75:PivotTo(v71.CFrame * CFrame.new(0, 2, -5) * CFrame.Angles(1.5707963267948966, 0, 0))
                u75.Parent = u5
                _G.destroy(u75, 1)
                u4:Create(u75.Start, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                    ["Size"] = u75.End.Size
                }):Play()
                u4:Create(u75.Start, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["CFrame"] = u75.Start.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                }):Play()
                task.delay(0.2, function() --[[ Line: 251 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u75
                    --]]
                    u4:Create(u75.Start, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
                        ["Transparency"] = 1
                    }):Play()
                end)
                local u76 = script.Meshes:Clone()
                u76:PivotTo(v71.CFrame)
                u76.Parent = u5
                _G.destroy(u76, 2)
                u4:Create(u76.Wind2.Start.Mesh, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                    ["Scale"] = u76.Wind2.End.Mesh.Scale
                }):Play()
                task.delay(0.1, function() --[[ Line: 262 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u76
                    --]]
                    u4:Create(u76.Wind2.Start, TweenInfo.new(0.1, Enum.EasingStyle.Quint), {
                        ["Transparency"] = 1
                    }):Play()
                end)
                u4:Create(u76.Wind1.Start.Mesh, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
                    ["Scale"] = u76.Wind1.End.Mesh.Scale
                }):Play()
                u4:Create(u76.Wind1.Start.Decal, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
                    ["Transparency"] = 1
                }):Play()
            else
                local u77 = script.Haki_BigWind:Clone()
                u77:PivotTo(v71.CFrame * CFrame.new(0, 0, -9) * CFrame.Angles(1.5707963267948966, 0, 0))
                _G.recolorParticles(u77, u56.HakiColor)
                u77.Parent = u5
                _G.destroy(u77, 1)
                u4:Create(u77.Start, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                    ["Size"] = u77.End.Size
                }):Play()
                u4:Create(u77.Start, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["CFrame"] = u77.Start.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                }):Play()
                task.delay(0.1, function() --[[ Line: 280 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u77
                    --]]
                    u4:Create(u77.Start, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {
                        ["Transparency"] = 1
                    }):Play()
                end)
                local v78 = script.Haki_Meshes:Clone()
                v78:PivotTo(v71.CFrame)
                _G.recolorParticles(v78, u56.HakiColor)
                v78.Parent = u5
                _G.destroy(v78, 2)
                u4:Create(v78.Wind1.Start.Mesh, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                    ["Scale"] = v78.Wind1.End.Mesh.Scale
                }):Play()
                u4:Create(v78.Wind1.Start.Decal, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
                    ["Transparency"] = 1
                }):Play()
            end
            local u79
            if u56.HakiColor == nil then
                u79 = script.Projectile:Clone()
            else
                u79 = script.Haki_Projectile:Clone()
                _G.recolorParticles(u79, u56.HakiColor)
            end
            u79:PivotTo(CFrame.new(v72.Position, v70.Position))
            u79.Parent = u5
            u22(u79, true)
            _G.shakenear(u79.PrimaryPart.CFrame.Position, 125, 75, 60, -0.67)
            local u80 = _G.PlaySound(u79.PrimaryPart, v58.Shoot)
            u80.Parent = u79.PrimaryPart
            for _, v81 in u79:GetDescendants() do
                if v81.ClassName == "Beam" then
                    v81.Enabled = true
                end
            end
            local u82 = script.Wind_Beam:Clone()
            u82:PivotTo(CFrame.new(v72.Position, v70.Position) * CFrame.new(0, 0, 0))
            u82.Parent = u5
            u22(u82, true)
            u53(u82, 0.6)
            for _, v83 in u82:GetDescendants() do
                if v83.ClassName == "Beam" then
                    v83.Enabled = true
                    u4:Create(v83, TweenInfo.new(0.9), {
                        ["TextureSpeed"] = 0
                    }):Play()
                end
            end
            u4:Create(u82.PartBeam1, TweenInfo.new(v73, Enum.EasingStyle.Linear), {
                ["CFrame"] = v70 * CFrame.Angles(0, 3.141592653589793, 0)
            }):Play()
            u4:Create(u79.PrimaryPart, TweenInfo.new(v73, Enum.EasingStyle.Linear), {
                ["CFrame"] = v70
            }):Play()
            local u84 = nil
            local u85 = u56.HakiColor or Color3.fromRGB(255, 255, 255)
            local u86 = 0
            local u104 = u2.Heartbeat:Connect(function() --[[ Line: 341 ]]
                --[[
                Upvalues:
                    [1] = u86
                    [2] = u84
                    [3] = u79
                    [4] = u54
                    [5] = u85
                    [6] = u56
                --]]
                if tick() - u86 >= 0.03 then
                    u84 = workspace:Raycast(u79.Dust.Position + Vector3.new(0, 5, 0), Vector3.new(0, -10, 0), u54)
                    for _ = 1, 2 do
                        local v87 = _G.PlayEffect
                        local v88 = {
                            ["Direction"] = -u79.PrimaryPart.CFrame.LookVector
                        }
                        local v89 = u79.PrimaryPart.Position
                        local v90 = math.random(-90, 90) / 10
                        local v91 = math.random(-90, 90) / 10
                        local v92 = math.random(-90, 90) / 10
                        v88.Position = v89 + Vector3.new(v90, v91, v92)
                        v88.Color = u85
                        v88.Brightness = u56.HakiColor == nil and 2 or 10
                        v88.Speed = math.random(5, 150)
                        v88.Width = math.random(500, 1000) / 1000
                        v88.Texture = u56.HakiColor == nil and "" or "rbxassetid://17287331411"
                        v87("CustomAirTrail", nil, v88)
                    end
                    u86 = tick()
                    if u84 and u84.Instance then
                        local v93 = u79.PrimaryPart
                        local v94 = u84.Position
                        local v95 = u84.Instance
                        local v96 = _G.PlayEffect
                        local v97 = {}
                        local v98 = math.random(-4, 4)
                        local v99 = math.random
                        v97.Position = v94 + Vector3.new(v98, 0, v99(-4, 4))
                        v97.Velocity = (Vector3.new(0, 1, 0)):Cross(v93.CFrame.LookVector) * (math.random(2) == 1 and 1 or -1) * math.random(25, 35) + Vector3.new(0, 1, 0) * math.random(30, 90)
                        v97.AngularVelocity = Random.new():NextUnitVector() * 3
                        v97.TargetPart = u84.Instance
                        v97.Material = v95.Material
                        local v100 = math.random(2)
                        local v101 = math.random(2)
                        local v102 = math.random
                        v97.Size = Vector3.new(v100, v101, v102(2))
                        v97.Color = v95.Color
                        v96("CreateRock", nil, v97)
                        local v103 = u79.Dust:Clone()
                        _G.recolorParticles(v103, u84.Instance.Color)
                        v103.CFrame = CFrame.new(u84.Position, (u79.PrimaryPart.CFrame * CFrame.new(0, 0, -30)).Position)
                        v103.Anchored = true
                        v103.Parent = workspace.Effects
                        _G.customEmit(v103)
                        _G.destroy(v103, 5)
                    end
                end
            end)
            task.delay(v73, function() --[[ Line: 387 ]]
                --[[
                Upvalues:
                    [1] = u104
                    [2] = u82
                    [3] = u4
                    [4] = u80
                    [5] = u53
                    [6] = u79
                    [7] = u22
                --]]
                u104:Disconnect()
                _G.destroy(u82, 2)
                u4:Create(u80, TweenInfo.new(4, Enum.EasingStyle.Quad), {
                    ["Volume"] = 0
                }):Play()
                u53(u79, 0.1)
                u22(u79, false)
                _G.destroy(u79, 5)
            end)
        else
            warn("TIMEOUT: FistOfLove yield expired")
        end
    end
}