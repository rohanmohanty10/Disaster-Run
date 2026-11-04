 

local v1 = {}
game:GetService("Debris")
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("RunService")
local u4 = game:GetService("TweenService")
local u5 = require(v2.Modules.Client.WeaponVFXRecolor)
local u6 = script:WaitForChild("Animations")
script:WaitForChild("Models")
script:WaitForChild("SFX")
script:WaitForChild("VFX")
script:WaitForChild("Other")
local u7 = workspace:WaitForChild("Effects")
local u8 = Random.new()
local u9 = nil
local u10 = RaycastParams.new()
u10.FilterType = Enum.RaycastFilterType.Include
u10.RespectCanCollide = true
u10.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local function u101(u11, u12, p13, p14) --[[ Line: 98 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u9
        [3] = u7
        [4] = u4
        [5] = u8
    --]]
    if p14 == true then
        local v15 = u12.RocketExplosionGround:Clone()
        u5.apply(v15, u9)
        v15.CFrame = CFrame.lookAt(u11.Position, u11.Position + u11.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0.000017453292519943296) * CFrame.new(0, 0.1, 0)
        _G.customEmit(v15)
        v15.Parent = u7
        task.delay(3.05, v15.Destroy, v15)
        local v16 = u12.Energymesh:Clone()
        u5.apply(v16, u9)
        v16.Mesh.VertexColor = Vector3.new(0, 0, 0)
        v16.Mesh.Scale = Vector3.new(-5, -5, -5)
        v16.Transparency = 0.05
        v16.CFrame = CFrame.lookAt(u11.Position, u11.Position + u11.Normal) * CFrame.Angles(1.5707963267948966, 0, 0)
        u4:Create(v16.Mesh, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Scale"] = Vector3.new(-25, -25, -25)
        }):Play()
        u4:Create(v16, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ["Transparency"] = 1
        }):Play()
        v16.Parent = u7
        task.delay(0.45, v16.Destroy, v16)
        local v17 = v15.Stage2.PointLight
        v17.Enabled = true
        local _ = { Enum.EasingStyle.Sine, Enum.EasingStyle.Quad, Enum.EasingStyle.Linear }
        u4:Create(v17, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            ["Brightness"] = 0,
            ["Color"] = Color3.fromRGB(255, 135, 155)
        }):Play()
        local v18 = u12.ImpactRingMesh:Clone()
        u5.apply(v18, u9)
        v18.Transparency = 0.25
        local v19 = CFrame.lookAt(u11.Position, u11.Position + u11.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 5, 0)
        local v20 = CFrame.Angles
        local v21 = u8:NextNumber(-180, 180)
        v18.CFrame = v19 * v20(3.141592653589793, math.rad(v21), 0)
        v18.Mesh.Scale = Vector3.new(-0, -25, -0)
        v18.Mesh.VertexColor = Vector3.new(2, 2, 2)
        u4:Create(v18, TweenInfo.new(0.3125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ["CFrame"] = v18.CFrame * CFrame.new(0, 2.5, 0),
            ["Transparency"] = 1
        }):Play()
        u4:Create(v18.Mesh, TweenInfo.new(0.3125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ["Scale"] = Vector3.new(-35, -5, -35)
        }):Play()
        v18.Parent = u7
        task.delay(0.3125, v18.Destroy, v18)
        local v22 = Instance.new("Model")
        v22.Parent = workspace.Effects
        local v23 = Instance.new("Highlight")
        v23.Enabled = false
        v23.Parent = v22
        local u24 = script.glass:Clone()
        u5.apply(u24, u9)
        u24.CFrame = v15.CFrame
        u24.Size = Vector3.new(0, 0, 0)
        u24.Parent = v22
        _G.tween(u24, {
            0.2,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(45, 45, 45)
        })
        task.delay(0.2, function() --[[ Line: 283 ]]
            --[[
            Upvalues:
                [1] = u24
            --]]
            _G.tween(u24, {
                0.2,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1,
                ["Size"] = Vector3.new(0, 0, 0)
            })
        end)
        _G.destroy(v22, 0.4)
        for _ = 1, 3 do
            local v25 = u8:NextNumber(0.25, 0.35)
            local v26 = u8:NextNumber(1, 1.25)
            local v27 = u8:NextNumber(0.75, 2)
            local v28 = u12.WindRingMesh:Clone()
            u5.apply(v28, u9)
            v28.Transparency = 0.9
            v28.CFrame = CFrame.lookAt(u11.Position, u11.Position + u11.Normal) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -u8:NextNumber(0, 2.5, 5, 0), 0) * CFrame.Angles(0, u8:NextNumber(-180, 180), 0)
            local v29 = v28.Mesh
            local v30 = -25 * v27
            v29.Scale = Vector3.new(-15, v30, -15)
            v28.Mesh.VertexColor = v28.Mesh.VertexColor * u8:NextNumber(0.25, 1)
            local _ = v28.Mesh.Scale
            local _ = v28.CFrame
            local v31 = u4
            local v32 = v28.Mesh
            local v33 = TweenInfo.new(v25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            local v34 = {}
            local v35 = -12.5 * v27
            v34.Scale = Vector3.new(-25, v35, -25) * v26
            v31:Create(v32, v33, v34):Play()
            u4:Create(v28, TweenInfo.new(v25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ["CFrame"] = v28.CFrame * CFrame.new(0, u8:NextNumber(1, 2.5), 0) * CFrame.Angles(0, u8:NextNumber(-12.5, 12.5), 0)
            }):Play()
            v28.Parent = u7
            task.delay(v25, v28.Destroy, v28)
        end
        task.delay(0.125, function() --[[ Line: 309 ]]
            --[[
            Upvalues:
                [1] = u12
                [2] = u5
                [3] = u9
                [4] = u11
                [5] = u7
                [6] = u4
            --]]
            local u36 = u12.AnomalySpiral2:Clone()
            u5.apply(u36, u9)
            local v37 = u36.Holder
            local v38 = CFrame.lookAt(u11.Position, u11.Position + u11.Normal)
            local v39 = CFrame.Angles
            local v40 = math.random(-180, 180)
            v37.CFrame = v38 * v39(-1.5707963267948966, math.rad(v40), 0)
            local v41 = u36.Holder.AttachmentA0.BeamA.Transparency
            local u42 = {}
            for v43 = 1, #v41.Keypoints do
                local v44 = v41.Keypoints[v43]
                local v45 = NumberSequenceKeypoint.new
                local v46 = v44.Time
                table.insert(u42, v45(v46, 1, 0))
            end
            u36.Parent = u7
            for _, v47 in u36:GetDescendants() do
                if v47:IsA("Beam") then
                    v47.Transparency = NumberSequence.new(u42)
                    _G.tween(v47, { 0.125, "Sine", "Out" }, {
                        ["Transparency"] = v41
                    })
                end
            end
            local u48 = u12.AnomalySpiral1:Clone()
            u5.apply(u48, u9)
            u48.Holder.CFrame = u36.Holder.CFrame * CFrame.Angles(0, 0.2617993877991494, 0)
            local v49 = u48.Holder.AttachmentA0.BeamA.Transparency
            local u50 = {}
            for v51 = 1, #v49.Keypoints do
                local v52 = v49.Keypoints[v51]
                local v53 = NumberSequenceKeypoint.new
                local v54 = v52.Time
                table.insert(u50, v53(v54, 1, 0))
            end
            u48.Parent = u7
            for _, v55 in u48:GetDescendants() do
                if v55:IsA("Beam") then
                    v55.Transparency = NumberSequence.new(u50)
                    _G.tween(v55, { 0.125, "Sine", "Out" }, {
                        ["Transparency"] = v49
                    })
                end
            end
            u4:Create(u48.Holder, TweenInfo.new(0.625, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["CFrame"] = u48.Holder.CFrame * CFrame.Angles(0, 3.12413936106985, 0)
            }):Play()
            u4:Create(u36.Holder, TweenInfo.new(0.625, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["CFrame"] = u36.Holder.CFrame * CFrame.Angles(0, 3.12413936106985, 0)
            }):Play()
            task.wait(0.125)
            local u56 = Instance.new("NumberValue")
            u56.Value = 1
            local u57 = Instance.new("NumberValue")
            u57.Value = 1
            local v58 = u56:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 365 ]]
                --[[
                Upvalues:
                    [1] = u48
                    [2] = u56
                --]]
                u48:ScaleTo(u56.Value)
            end)
            local v59 = u57:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 369 ]]
                --[[
                Upvalues:
                    [1] = u36
                    [2] = u57
                --]]
                u36:ScaleTo(u57.Value)
            end)
            task.delay(0.025, function() --[[ Line: 373 ]]
                --[[
                Upvalues:
                    [1] = u48
                    [2] = u4
                    [3] = u50
                    [4] = u36
                    [5] = u42
                --]]
                for _, v60 in u48:GetDescendants() do
                    if v60:IsA("Beam") then
                        u4:Create(v60, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                            ["TextureSpeed"] = -9
                        }):Play()
                        _G.tween(v60, { 0.375, "Sine", "In" }, {
                            ["Transparency"] = NumberSequence.new(u50)
                        })
                    end
                end
                for _, v61 in u36:GetDescendants() do
                    if v61:IsA("Beam") then
                        _G.tween(v61, { 0.375, "Sine", "In" }, {
                            ["Transparency"] = NumberSequence.new(u42)
                        })
                    end
                end
            end)
            u4:Create(u56, TweenInfo.new(0.4375, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["Value"] = 0.45
            }):Play()
            u4:Create(u57, TweenInfo.new(0.4375, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["Value"] = 0.5
            }):Play()
            task.wait(0.0625)
            local v62 = u12.Energymesh2:Clone()
            u5.apply(v62, u9)
            v62.Mesh.VertexColor = Vector3.new(1.1, 1.5, 3)
            v62.Mesh.Scale = Vector3.new(0, 0, 0)
            v62.CFrame = CFrame.lookAt(u11.Position, u11.Position + u11.Normal) * CFrame.new(0, -0.1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
            u4:Create(v62.Mesh, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Scale"] = Vector3.new(-12.5, -12.5, -12.5)
            }):Play()
            u4:Create(v62, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                ["Transparency"] = 1
            }):Play()
            v62.Parent = u7
            task.delay(0.25, v62.Destroy, v62)
            task.wait(0.5)
            v59:Disconnect()
            v58:Disconnect()
            u56:Destroy()
            u57:Destroy()
            u48:Destroy()
            u36:Destroy()
        end)
        _G.PlaySound(v15, p13.JinxGunRocketExplosion)
    else
        local u63 = u12.RocketExplosionGround:Clone()
        u5.apply(u63, u9)
        u63.CFrame = CFrame.lookAt(u11.Position, u11.Position + u11.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0.000017453292519943296) * CFrame.new(0, 0.1, 0)
        u63.Parent = u7
        if u11.Instance then
            _G.recolorParticles(u63, u11.Instance.Color)
        end
        _G.customEmit(u63)
        _G.destroy(u63, 5)
        local v64 = u12.Energymesh:Clone()
        u5.apply(v64, u9)
        v64.Mesh.VertexColor = Vector3.new(0, 0, 0)
        v64.Mesh.Scale = Vector3.new(-5, -5, -5)
        v64.Transparency = 0.5
        v64.CFrame = CFrame.lookAt(u11.Position, u11.Position + u11.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0)
        u4:Create(v64.Mesh, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Scale"] = Vector3.new(-20, -20, -20)
        }):Play()
        u4:Create(v64, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Transparency"] = 1
        }):Play()
        v64.Parent = u7
        task.delay(0.45, v64.Destroy, v64)
        local u65 = u63.Stage2.PointLight
        local _ = { Enum.EasingStyle.Sine, Enum.EasingStyle.Quad, Enum.EasingStyle.Linear }
        task.delay(0.05, function() --[[ Line: 132 ]]
            --[[
            Upvalues:
                [1] = u65
                [2] = u4
                [3] = u12
                [4] = u5
                [5] = u9
                [6] = u11
                [7] = u8
                [8] = u7
                [9] = u63
            --]]
            u65.Enabled = true
            u4:Create(u65, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ["Brightness"] = 0,
                ["Color"] = Color3.fromRGB(255, 94, 255),
                ["Range"] = u65.Range * 1.2
            }):Play()
            local v66 = u12.ImpactRingMesh:Clone()
            u5.apply(v66, u9)
            v66.Transparency = 0.25
            local v67 = CFrame.lookAt(u11.Position, u11.Position + u11.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 5, 0)
            local v68 = CFrame.Angles
            local v69 = u8:NextNumber(-180, 180)
            v66.CFrame = v67 * v68(3.141592653589793, math.rad(v69), 0)
            v66.Mesh.Scale = Vector3.new(-0, -25, -0)
            v66.Mesh.VertexColor = Vector3.new(2, 2, 2)
            u4:Create(v66, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ["CFrame"] = v66.CFrame * CFrame.new(0, 2.5, 0),
                ["Transparency"] = 1
            }):Play()
            u4:Create(v66.Mesh, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ["Scale"] = Vector3.new(-35, -5, -35)
            }):Play()
            v66.Parent = u7
            task.delay(0.25, v66.Destroy, v66)
            local v70 = Instance.new("Model")
            v70.Parent = workspace.Effects
            local v71 = Instance.new("Highlight")
            v71.Enabled = false
            v71.Parent = v70
            local v72 = script.glass:Clone()
            u5.apply(v72, u9)
            v72.CFrame = u63.CFrame
            v72.Size = Vector3.new(20, 20, 20)
            v72.Parent = v70
            _G.tween(v72, {
                0.4,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1,
                ["Size"] = v72.Size + Vector3.new(20, 20, 20)
            })
            _G.destroy(v70, 0.4)
            task.wait(0.05)
            local v73 = u12.Energymesh:Clone()
            u5.apply(v73, u9)
            v73.Mesh.VertexColor = Vector3.new(1.1, 1.5, 5000)
            v73.Mesh.Scale = Vector3.new(0, 0, 0)
            v73.CFrame = CFrame.lookAt(u11.Position, u11.Position + u11.Normal) * CFrame.new(0, -0.1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
            u4:Create(v73.Mesh, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Scale"] = Vector3.new(-12.5, -12.5, -12.5)
            }):Play()
            u4:Create(v73, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                ["Transparency"] = 1
            }):Play()
            v73.Parent = u7
            task.delay(0.25, v73.Destroy, v73)
            for _ = 1, 3 do
                local v74 = u8:NextNumber(0.25, 0.325)
                local v75 = u8:NextNumber(1, 1.25)
                local v76 = u8:NextNumber(0.75, 1.25)
                local v77 = u12.WindRingMesh:Clone()
                u5.apply(v77, u9)
                v77.Transparency = 0.5
                v77.CFrame = CFrame.lookAt(u11.Position, u11.Position + u11.Normal) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -u8:NextNumber(0, 2.5, 5, 0), 0) * CFrame.Angles(0, u8:NextNumber(-180, 180), 0)
                local v78 = v77.Mesh
                local v79 = -25 * v76
                v78.Scale = Vector3.new(-15, v79, -15)
                local v80 = u4
                local v81 = v77.Mesh
                local v82 = TweenInfo.new(v74, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v83 = {}
                local v84 = -12.5 * v76
                v83.Scale = Vector3.new(-25, v84, -25) * v75
                v80:Create(v81, v82, v83):Play()
                u4:Create(v77, TweenInfo.new(v74, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["CFrame"] = v77.CFrame * CFrame.new(0, u8:NextNumber(1, 2.5), 0) * CFrame.Angles(0, u8:NextNumber(-12.5, 12.5), 0),
                    ["Transparency"] = 1
                }):Play()
                v77.Parent = u7
                task.delay(v74, v77.Destroy, v77)
            end
            task.wait(0.15)
            local v85 = u8:NextNumber(0.25, 0.325)
            local v86 = u12.LineMesh:Clone()
            u5.apply(v86, u9)
            v86.Mesh.Scale = Vector3.new(12.5, 12.5, 12.5)
            v86.Transparency = 0.75
            v86.CFrame = CFrame.lookAt(u11.Position, u11.Position + u11.Normal) * CFrame.new(0, -0.1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
            u4:Create(v86, TweenInfo.new(v85, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                ["Transparency"] = 1
            }):Play()
            local v87 = u4
            local v88 = TweenInfo.new(v85, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            local v89 = {}
            local v90 = v86.CFrame
            local v91 = CFrame.Angles
            local v92 = u8:NextNumber(22.5, 45)
            v89.CFrame = v90 * v91(0, math.rad(v92), 0)
            v87:Create(v86, v88, v89):Play()
            v86.Parent = u7
            task.delay(v85, v86.Destroy, v86)
            local v93 = u8:NextNumber(0.25, 0.325)
            local v94 = u12.LineMesh:Clone()
            u5.apply(v94, u9)
            v94.Mesh.Scale = Vector3.new(12.5, 12.5, 12.5)
            v94.Mesh.VertexColor = Vector3.new(0.1, 3, 5000)
            v94.Transparency = 0.75
            v94.CFrame = CFrame.lookAt(u11.Position, u11.Position + u11.Normal) * CFrame.new(0, -0.1, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
            u4:Create(v94, TweenInfo.new(v93, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                ["Transparency"] = 1
            }):Play()
            local v95 = u4
            local v96 = TweenInfo.new(v93, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            local v97 = {}
            local v98 = v94.CFrame
            local v99 = CFrame.Angles
            local v100 = u8:NextNumber(22.5, 45)
            v97.CFrame = v98 * v99(0, math.rad(v100), 0)
            v95:Create(v94, v96, v97):Play()
            v94.Parent = u7
            task.delay(v93, v94.Destroy, v94)
        end)
        _G.PlaySound(u63, p13.JinxGunRocketExplosion)
    end
    _G.shakenear(u11.Position, 125, 150, 120, -2)
end
function v1.start(_, u102, p103) --[[ Line: 421 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u6
        [3] = u5
        [4] = u4
        [5] = u7
        [6] = u8
        [7] = u3
        [8] = u10
        [9] = u101
    --]]
    u9 = u102
    local u104 = p103.isSpecial
    local v105 = p103.gunModel
    local u106 = script.VFX.Normal
    local u107 = script.SFX.Normal
    if u104 == true then
        u106 = script.VFX.Special
        u107 = script.SFX.Special
    end
    if p103.Shoot == nil then
        if v105 == nil or v105.PrimaryPart == nil then
            return
        end
        local v108 = v105:WaitForChild("RootPart")
        local u109 = v105:WaitForChild("AnimationController")
        local v110 = u102.Humanoid:LoadAnimation(u6.Start)
        v110:Play(0)
        local v111 = u109:LoadAnimation(u6.Start)
        v111:Play(0)
        local v112 = u106.RhinoRocketChargeUp:Clone()
        u5.apply(v112, u102)
        v112.Weld.Part1 = v108
        v112.Parent = workspace.Effects
        for _, v113 in v112:GetDescendants() do
            if v113:IsA("ParticleEmitter") then
                v113.Enabled = true
                v113:Emit(1)
            end
        end
        local v114 = _G.PlaySound(u102.PrimaryPart, u107.JinxGunRocketStart)
        v114.Parent = u102.PrimaryPart
        local v115 = u107.JinxGunRocketChargeLoop:Clone()
        v115.Parent = u102.PrimaryPart
        v115:Play()
        local v116 = RaycastParams.new()
        v116.FilterType = Enum.RaycastFilterType.Include
        v116.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
        v116.RespectCanCollide = true
        local v117 = os.clock()
        while true do
            if os.clock() - v117 >= 0.15 then
                v117 = os.clock()
                local v118 = workspace:Raycast(u102.HumanoidRootPart.Position, Vector3.new(0, -10, 0), v116)
                if v118 then
                    local v119 = u102.HumanoidRootPart.CFrame.LookVector
                    local v120 = u106.WindSpike:Clone()
                    u5.apply(v120, u102)
                    local v121 = CFrame.lookAt
                    local v122 = v118.Position
                    local v123 = v118.Position
                    local v124 = v119.X
                    local v125 = v119.Z
                    v120:PivotTo(v121(v122, v123 + Vector3.new(v124, 0, v125)))
                    for _, v126 in v120:GetChildren() do
                        if string.find(v126.Name, "Wind") then
                            u4:Create(v126, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ["CFrame"] = v126.CFrame * CFrame.new(-15, 0, 0)
                            }):Play()
                            local v127 = u4
                            local v128 = v126.Mesh
                            local v129 = TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                            local v130 = {}
                            local v131 = v126.Mesh.Scale.X * 6
                            local v132 = v126.Mesh.Scale.Y * 4
                            local v133 = v126.Mesh.Scale.Z * 4
                            v130.Scale = Vector3.new(v131, v132, v133)
                            v127:Create(v128, v129, v130):Play()
                            u4:Create(v126, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ["Transparency"] = 1
                            }):Play()
                        end
                    end
                    v120.Parent = u7
                    _G.destroy(v120, 1)
                end
            end
            task.wait()
            if u102:GetAttribute("MegaRocketHold") == nil then
                u4:Create(v115, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Volume"] = 0
                }):Play()
                _G.destroy(v115, 0.75)
                if v114 then
                    u4:Create(v114, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Volume"] = 0
                    }):Play()
                    _G.destroy(v114, 0.75)
                end
                v110:Stop()
                v111:Stop()
                v111:Destroy()
                v110:Destroy()
                pcall(function() --[[ Line: 508 ]]
                    --[[
                    Upvalues:
                        [1] = u102
                        [2] = u6
                        [3] = u109
                    --]]
                    u102.Humanoid:LoadAnimation(u6.Success):Play(0)
                    u109:LoadAnimation(u6.Success):Play(0)
                end)
                _G.particleEnabled(v112, false)
                _G.destroy(v112, 3)
                local v134 = u102.HumanoidRootPart.CFrame.LookVector
                local v135 = u106.WindBowlMeshFlipped:Clone()
                u5.apply(v135, u102)
                v135.Transparency = 0.25
                local v136 = CFrame.lookAt(v112.CFrame.Position, v112.CFrame.Position + v134)
                local v137 = CFrame.Angles
                local v138 = u8:NextNumber(-180, 180)
                v135.CFrame = v136 * v137(-1.5707963267948966, math.rad(v138), 0) * CFrame.new(0, 7.5, 0)
                u4:Create(v135, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["CFrame"] = v135.CFrame * CFrame.new(0, -15, 0) * CFrame.Angles(0, 1.5707963267948966, 0)
                }):Play()
                u4:Create(v135, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Transparency"] = 1
                }):Play()
                u4:Create(v135.Mesh, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Scale"] = Vector3.new(-10, -12.5, -10)
                }):Play()
                v135.Parent = u7
                local v139 = u106.WindBowlMeshFlipped:Clone()
                u5.apply(v139, u102)
                v139.Transparency = 0.9
                local v140 = CFrame.lookAt(v112.CFrame.Position, v112.CFrame.Position + v134)
                local v141 = CFrame.Angles
                local v142 = u8:NextNumber(-180, 180)
                v139.CFrame = v140 * v141(-1.5707963267948966, math.rad(v142), 0) * CFrame.new(0, 15, 0)
                u4:Create(v139, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["CFrame"] = v135.CFrame * CFrame.new(0, -7.5, 0) * CFrame.Angles(0, 0.7853981633974483, 0)
                }):Play()
                u4:Create(v139, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Transparency"] = 1
                }):Play()
                u4:Create(v139.Mesh, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Scale"] = Vector3.new(-5, -10, -5)
                }):Play()
                v139.Parent = u7
                _G.destroy({ v135, v139 }, 0.25)
                local v143 = u106.RhinoRocketFire:Clone()
                u5.apply(v143, u102)
                v143.CFrame = v112.CFrame
                v143.Parent = u7
                _G.customEmit(v143)
                _G.destroy(v143, 0.25)
                ::l24::
                return
            end
        end
    else
        local u144 = p103.StartPos
        local v145 = p103.Goal
        local _ = p103.gunModel
        local v146 = p103.targets
        local _ = p103.Character
        local u147 = p103.maxTime
        local u148 = p103.ProjectileStartTime
        local u149 = p103.ProjectileSpeed
        local u150 = p103.ProjectileAcceleration
        local v151 = CFrame.new(u144, v145.Position)
        local u152 = v151.LookVector
        local u153 = u106.Rocket:Clone()
        u5.apply(u153, u102)
        u153:SetPrimaryPartCFrame(v151)
        u153.Parent = u7
        local u154 = u106.RocketTrail:Clone()
        u5.apply(u154, u102)
        u154.CFrame = u153.PrimaryPart.CFrame
        u154.Parent = u7
        local u155 = RaycastParams.new()
        u155.FilterType = Enum.RaycastFilterType.Include
        u155.FilterDescendantsInstances = v146
        local u156 = u144
        local u157 = nil
        local u158 = _G.PlaySound(u153.PrimaryPart, u107.JinxGunRocketShoot)
        u158.Parent = u153.PrimaryPart
        _G.shakenear(u153.PrimaryPart.Position, 75, 100, 120, -4)
        local function u160() --[[ Line: 586 ]]
            --[[
            Upvalues:
                [1] = u153
                [2] = u158
                [3] = u4
            --]]
            local v159 = Instance.new("Attachment")
            v159.WorldPosition = u153.PrimaryPart.Position
            u158.Parent = v159
            v159.Parent = workspace.Terrain
            u4:Create(u158, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Volume"] = 0
            }):Play()
            _G.destroy(v159, 1)
        end
        local function u186() --[[ Line: 596 ]]
            --[[
            Upvalues:
                [1] = u160
                [2] = u106
                [3] = u5
                [4] = u102
                [5] = u153
                [6] = u7
                [7] = u104
                [8] = u8
                [9] = u4
                [10] = u154
                [11] = u107
            --]]
            u160()
            local u161 = u106.RocketExplosionAir:Clone()
            u5.apply(u161, u102)
            u161.CFrame = u153.PrimaryPart.CFrame
            u161.Parent = u7
            _G.customEmit(u161)
            task.delay(2.05, u161.Destroy, u161)
            if u104 == true then
                task.delay(0.075, function() --[[ Line: 609 ]]
                    --[[
                    Upvalues:
                        [1] = u106
                        [2] = u5
                        [3] = u102
                        [4] = u161
                        [5] = u8
                        [6] = u7
                        [7] = u4
                    --]]
                    local u162 = u106.AnomalySpiral2:Clone()
                    u5.apply(u162, u102)
                    local v163 = CFrame.lookAt(u161.Position, workspace.CurrentCamera.CFrame.Position) * CFrame.Angles(-1.5707963267948966, 0, 0)
                    local v164 = CFrame.Angles
                    local v165 = u8:NextNumber(-180, 180)
                    u162:PivotTo(v163 * v164(0, math.rad(v165), 0))
                    u162:ScaleTo(1.5)
                    local v166 = u162.Holder.AttachmentA0.BeamA.Transparency
                    local u167 = {}
                    for v168 = 1, #v166.Keypoints do
                        local v169 = v166.Keypoints[v168]
                        local v170 = NumberSequenceKeypoint.new
                        local v171 = v169.Time
                        table.insert(u167, v170(v171, 1, 0))
                    end
                    u162.Parent = u7
                    local u172 = Instance.new("NumberValue")
                    u172.Value = 1
                    local u173 = Instance.new("NumberValue")
                    u173.Value = 1
                    local u174 = u106.AnomalySpiral1:Clone()
                    u5.apply(u174, u102)
                    u174:PivotTo(u162.Holder.CFrame * CFrame.Angles(0, -0.2617993877991494, 0))
                    u174:ScaleTo(1.25)
                    local v175 = u174.Holder.AttachmentA0.BeamA.Transparency
                    local u176 = {}
                    for v177 = 1, #v175.Keypoints do
                        local v178 = v175.Keypoints[v177]
                        local v179 = NumberSequenceKeypoint.new
                        local v180 = v178.Time
                        table.insert(u176, v179(v180, 1, 0))
                    end
                    u174.Parent = u7
                    for _, v181 in u174:GetDescendants() do
                        if v181:IsA("Beam") then
                            v181.Transparency = NumberSequence.new(u176)
                            _G.tween(v181, { 0.0625, "Sine", "Out" }, {
                                ["Transparency"] = v175
                            })
                        end
                    end
                    for _, v182 in u162:GetDescendants() do
                        if v182:IsA("Beam") then
                            v182.Transparency = NumberSequence.new(u167)
                            _G.tween(v182, { 0.0625, "Sine", "Out" }, {
                                ["Transparency"] = v166
                            })
                        end
                    end
                    u172:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 663 ]]
                        --[[
                        Upvalues:
                            [1] = u174
                            [2] = u172
                        --]]
                        u174:ScaleTo(u172.Value)
                    end)
                    u173:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 667 ]]
                        --[[
                        Upvalues:
                            [1] = u162
                            [2] = u173
                        --]]
                        u162:ScaleTo(u173.Value)
                    end)
                    task.delay(0.0625, function() --[[ Line: 671 ]]
                        --[[
                        Upvalues:
                            [1] = u174
                            [2] = u4
                            [3] = u176
                            [4] = u162
                            [5] = u167
                        --]]
                        for _, v183 in u174:GetDescendants() do
                            if v183:IsA("Beam") then
                                u4:Create(v183, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                                    ["TextureSpeed"] = -9
                                }):Play()
                                _G.tween(v183, { 0.375, "Sine", "In" }, {
                                    ["Transparency"] = NumberSequence.new(u176),
                                    ["TextureSpeed"] = -9
                                })
                            end
                        end
                        for _, v184 in u162:GetDescendants() do
                            if v184:IsA("Beam") then
                                _G.tween(v184, { 0.375, "Sine", "In" }, {
                                    ["Transparency"] = NumberSequence.new(u167)
                                })
                            end
                        end
                    end)
                    u4:Create(u174.Holder, TweenInfo.new(0.4375, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        ["CFrame"] = u174.Holder.CFrame * CFrame.Angles(0, 3.12413936106985, 0)
                    }):Play()
                    u4:Create(u172, TweenInfo.new(0.4375, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        ["Value"] = 0.45
                    }):Play()
                    u4:Create(u162.Holder, TweenInfo.new(0.4375, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        ["CFrame"] = u162.Holder.CFrame * CFrame.Angles(0, 1.5533430342749532, 0)
                    }):Play()
                    u4:Create(u173, TweenInfo.new(0.4375, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        ["Value"] = 0.5
                    }):Play()
                end)
            end
            u153:Destroy()
            for _, v185 in u154:GetDescendants() do
                if v185:IsA("ParticleEmitter") or v185:IsA("PointLight") then
                    v185.Enabled = false
                end
            end
            task.delay(1.05, u154.Destroy, u154)
            _G.PlaySound(u161, u107.JinxGunRocketExplosion)
        end
        u157 = u3.Heartbeat:Connect(function() --[[ Line: 707 ]]
            --[[
            Upvalues:
                [1] = u148
                [2] = u147
                [3] = u157
                [4] = u186
                [5] = u144
                [6] = u152
                [7] = u149
                [8] = u150
                [9] = u156
                [10] = u155
                [11] = u10
                [12] = u154
                [13] = u160
                [14] = u101
                [15] = u106
                [16] = u107
                [17] = u104
                [18] = u153
            --]]
            local v187 = workspace:GetServerTimeNow() - u148
            if u147 <= v187 then
                u157:Disconnect()
                u157 = nil
                u186()
            else
                local v188 = u144 + u152 * (u149 * v187 + 0.5 * u150 * v187 ^ 2)
                local v189 = (v188 - u156).Unit
                local v190 = (v188 - u156).Magnitude
                if v190 > 0 then
                    local v191 = workspace:Blockcast(CFrame.new(u156, u156 + v189), Vector3.new(2, 2, 2), v189 * v190, u155)
                    if v191 and v191.Instance then
                        u157:Disconnect()
                        u157 = nil
                        local v192 = false
                        if _G.getTargetByPart(v191.Instance) ~= nil then
                            local v193 = workspace:Raycast(v191.Position + Vector3.new(0, 1, 0), Vector3.new(0, -10, 0), u10)
                            if v193 and v193.Instance ~= nil then
                                v191 = v193
                            else
                                v192 = true
                            end
                        end
                        if v192 == false then
                            for _, v194 in u154:GetDescendants() do
                                if v194:IsA("ParticleEmitter") or v194:IsA("PointLight") then
                                    v194.Enabled = false
                                end
                            end
                            _G.destroy(u154, 1)
                            local v195 = v191.Position + v191.Normal * 0.01
                            _G.PlayEffect("GroundRocks4", nil, {
                                ["Segments"] = 15,
                                ["Position"] = v195,
                                ["DistanceRandomness"] = Vector2.new(0.7, 1),
                                ["Duration"] = 4,
                                ["TweenDuration"] = 1,
                                ["Radius"] = 16,
                                ["Direction"] = -v191.Normal * 15,
                                ["Angle"] = -0.6108652381980153
                            })
                            u160()
                            u101(v191, u106, u107, u104)
                            u153:Destroy()
                        else
                            u186()
                        end
                    end
                end
                u153:MoveTo(v188)
                u154.Position = u153.PrimaryPart.Position
                u156 = v188
            end
        end)
        goto l24
    end
end
return v1