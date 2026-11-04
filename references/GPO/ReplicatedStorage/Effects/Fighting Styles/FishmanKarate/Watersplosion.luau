 

local u1 = game:GetService("RunService")
local u2 = game.ReplicatedStorage.Refrences.Fishman
local u3 = workspace.CurrentCamera
local u4 = workspace:WaitForChild("Effects")
local u5 = require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Misc)
local u6 = require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Tween)
require(u2.Effects.Slash)
local u7 = require(u2.Effects.Shockwave)
local u8 = require(u2.Modules.SpikyFoam)
local u9 = require(u2.Modules.Strand)
local u10 = require(u2.Effects.Portal)
require(u2.Modules.WaterBlob)
local u11 = require(script.Shockwave)
local u12 = require(game:GetService("ReplicatedStorage"):WaitForChild("Util").ShakeCamera)
return {
    ["start"] = function(_, p13) --[[ Name: start, Line 21 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u4
            [3] = u8
            [4] = u9
            [5] = u5
            [6] = u6
            [7] = u3
            [8] = u7
            [9] = u11
            [10] = u12
            [11] = u1
            [12] = u10
        --]]
        local v14 = p13 or {}
        local u15 = v14.CFrame or CFrame.new()
        if _G.checkRenderDistance(u15.Position) == false then
            return
        else
            local u16 = v14.Scale or 10
            local v17 = v14.FadeIn or 0.75
            local u18 = v14.Lifetime or 2
            local v19 = u2.Assets.Aura:Clone()
            v19.CFrame = u15
            local v20 = next
            local v21, v22 = v19:GetChildren()
            local v23 = {}
            for _, v24 in v20, v21, v22 do
                if v24:IsA("Attachment") then
                    v23[v24.Name] = {
                        ["Object"] = v24,
                        ["Offset"] = v24.Position,
                        ["Particle"] = {
                            ["Size"] = v24.Water.Size.Keypoints,
                            ["Object"] = v24.Water,
                            ["Acceleration"] = v24.Water.Acceleration,
                            ["Speed"] = v24.Water.Speed.Max,
                            ["ZOffset"] = v24.Water.ZOffset
                        }
                    }
                end
            end
            local v25 = {}
            local v26 = u2.Assets.Trail:Clone()
            v26.CFrame = u15
            table.insert(v25, v26)
            local v27 = u2.Assets.Trail:Clone()
            v27.CFrame = u15
            table.insert(v25, v27)
            local v28 = v23.Gravity
            v28.Object.Parent = workspace.Terrain
            v28.Object.CFrame = u15
            v19.Parent = u4
            for _, v29 in next, v25 do
                v29.Parent = u4
            end
            for _, v30 in next, v23 do
                v30.Particle.Object.Enabled = true
            end
            u8.new({
                ["CFrame"] = u15 * CFrame.Angles(0, 1.5707963267948966, 0),
                ["Scale"] = u16 * 2.25,
                ["FadeIn"] = v17 * 1.125,
                ["Lifetime"] = u18,
                ["FadeOut"] = 0.3,
                ["Speed"] = 5.5,
                ["Color"] = Color3.fromRGB(0, 100, 175)
            })
            local v31 = {}
            for _ = 1, 10 do
                local v32 = u9.new({
                    ["CFrame"] = u15,
                    ["Scale"] = Vector2.new(u16 * Random.new():NextNumber(1.25, 1.75), u16 * Random.new():NextNumber(1.75, 2)),
                    ["FadeIn"] = v17 * 0.5,
                    ["Lifetime"] = u18 * 1.5,
                    ["FadeOut"] = v17
                })
                table.insert(v31, v32)
            end
            local v33 = u2.Particles.EnergyRing:Clone()
            v33.Color = ColorSequence.new(Color3.fromRGB(100, 200, 255))
            v33.LockedToPart = false
            v33.Size = u5.ScaleParticleSize(v33.Size.Keypoints, u16 * 1.75)
            v33.Lifetime = NumberRange.new(v17)
            v33.Parent = v28.Object
            v33:Emit(1)
            local v34 = u2.Particles.WaterSplash:Clone()
            v34.Color = ColorSequence.new(Color3.fromRGB(75, 175, 255))
            v34.LockedToPart = false
            v34.Transparency = u2.Particles.EnergyRing.Transparency
            v34.Size = u5.ScaleParticleSize(u2.Particles.EnergyRing.Size.Keypoints, u16 * 2)
            v34.Lifetime = NumberRange.new(0.65 * v17)
            v34.Parent = v28.Object
            v34:Emit(1)
            u5.PlaySound(u15, script.WaterBallBoom, {
                ["PlaybackSpeed"] = 1
            })
            local v35 = nil
            local v36 = 0
            local v37 = 0
            local v38 = 0
            while true do
                local v39 = tick()
                v35 = v35 or v39
                local v40 = (v39 - v35) / v17
                local v41 = math.min(1, v40)
                local v42 = u6.ease.out.back(v41, 0, 1, 1)
                local v43 = u6.ease.out.quad(v41, 0, 1, 1)
                v36 = v36 + 0.10471975511965977
                local v44 = u16 * v43
                local v45 = (u3.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
                v19.CFrame = CFrame.new(u15.Position, u15.Position + v45) * CFrame.Angles(0, 0, 1.5707963267948966) * CFrame.Angles(v36, 0, 0)
                for _, v46 in next, v23 do
                    local v47 = v46.Particle.Acceleration
                    if v46.Particle.Acceleration.Magnitude > 0.01 then
                        v47 = u15:VectorToWorldSpace(v46.Particle.Acceleration.Unit) * v46.Particle.Acceleration.Magnitude
                    end
                    if v46.Object.Parent == v19 then
                        v46.Object.Position = v46.Offset * u16 * v42
                    else
                        v46.Object.CFrame = u15 * CFrame.new(v46.Offset * u16 * v42)
                    end
                    local v48 = v46.Particle.Object
                    local v49 = u5.ScaleParticleSize
                    local v50 = v46.Particle.Size
                    local v51
                    if v46.Particle.Acceleration.Magnitude > 0.01 then
                        v51 = u16 * v42 or v44
                    else
                        v51 = v44
                    end
                    v48.Size = v49(v50, v51)
                    v46.Particle.Object.Acceleration = v47 * v44
                    v46.Particle.Object.Speed = NumberRange.new(v46.Particle.Speed * v44 * 1.5)
                    v46.Particle.Object.ZOffset = v46.Particle.ZOffset * v44
                end
                local v52 = v44 * 1.5
                for v53, v54 in next, v25 do
                    local v55 = v53 % 2 == 0 and 1 or -1
                    v54.CFrame = u15 * CFrame.Angles(0, v36, 0) * CFrame.new(v52 * (v55 == 1 and math.sin(v36) or math.cos(v36)), v55 * v52 * (v55 == 1 and math.cos(v36) or math.sin(v36)), v55 * v52)
                    local v56 = v54.A
                    local v57 = 0.35 * u16 * v42
                    v56.Position = Vector3.new(0, 0, v57)
                    local v58 = v54.B
                    local v59 = -0.35 * u16 * v42
                    v58.Position = Vector3.new(0, 0, v59)
                end
                v37 = v37 + 0.05235987755982988
                for v60, v61 in next, v31 do
                    local v62 = 6.283185307179586 * (v60 / #v31)
                    local v63 = u15 * CFrame.Angles(0, v37 + v62, 0) * CFrame.new(0, 0, -v44)
                    v61.Reference.CFrame = v63
                end
                if v39 - v38 > 0.175 then
                    local v64 = u7
                    local v65 = {
                        ["CFrame"] = u15,
                        ["Scale"] = u16 * 3 * u6.point(0.5, 1, v41 / 0.5),
                        ["Duration"] = v17 * 0.75
                    }
                    local v66 = u16 * 0.15
                    v65.Offset = Vector3.new(0, v66, 0)
                    v65.YInfluence = 0.1
                    v64(v65)
                    u11({
                        ["CFrame"] = u15,
                        ["Scale"] = u16 * 1.5 * u6.point(0.5, 1, v41 / 0.25),
                        ["Duration"] = v17
                    })
                    v38 = v39
                end
                if v39 - 0 > 0.15 then
                    local v67 = (u3.CFrame.Position - u15.Position).Magnitude / (10 + u16 * 3.5)
                    if v67 < 1 then
                        local v68 = 1 - v67
                        u12({
                            ["RotationInfluence"] = Vector3.new(0, 0, 1),
                            ["Roughness"] = 8 * v68,
                            ["Magnitude"] = 6 * v68,
                            ["FadeIn"] = 0.5,
                            ["FadeOut"] = 0.25
                        })
                    end
                end
                if v41 == 1 then
                    coroutine.resume(coroutine.create(function() --[[ Line: 252 ]]
                        --[[
                        Upvalues:
                            [1] = u10
                            [2] = u15
                            [3] = u16
                            [4] = u18
                        --]]
                        u10({
                            ["CFrame"] = u15,
                            ["Scale"] = u16 * 1.75,
                            ["FadeIn"] = u18 * 0.9,
                            ["Lifetime"] = u18,
                            ["FadeOut"] = 1.25,
                            ["Surface"] = true,
                            ["Special2"] = true
                        })
                    end))
                    local v69 = nil
                    local v70 = 0
                    while true do
                        local v71 = tick()
                        v69 = v69 or v71
                        local v72 = (v71 - v69) / u18
                        local v73 = math.min(1, v72)
                        v36 = v36 + 0.10471975511965977
                        local v74 = u6.ease["in"].back(v73, 0, 1, 1)
                        local v75 = (u3.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
                        v19.CFrame = CFrame.new(u15.Position, u15.Position + v75) * CFrame.Angles(0, 0, 1.5707963267948966) * CFrame.Angles(v36, 0, 0)
                        local v76 = u16 * 0.25
                        local v77 = v36 * 0.75
                        local v78 = u16 + v76 * math.sin(v77) ^ 2
                        for _, v79 in next, v23 do
                            local v80 = v79.Particle.Acceleration
                            if v79.Particle.Acceleration.Magnitude > 0.01 then
                                v80 = u15:VectorToWorldSpace(v79.Particle.Acceleration.Unit) * v79.Particle.Acceleration.Magnitude
                            end
                            if v79.Object.Parent == v19 then
                                v79.Object.Position = v79.Offset * u16 * v74
                            else
                                v79.Object.CFrame = u15 * CFrame.new(v79.Offset * u16)
                            end
                            v79.Particle.Object.Acceleration = v80 * v78
                            v79.Particle.Object.Speed = NumberRange.new(v79.Particle.Speed * v78 * 1.5)
                            v79.Particle.Object.ZOffset = v79.Particle.ZOffset * v78
                        end
                        v37 = v37 + 0.05235987755982988
                        for v81, v82 in next, v31 do
                            local v83 = 6.283185307179586 * (v81 / #v31)
                            local v84 = u15 * CFrame.Angles(0, v37 + v83, 0) * CFrame.new(0, 0, -v78)
                            v82.Reference.CFrame = v84
                        end
                        if v71 - v70 > 0.175 then
                            local v85 = u7
                            local v86 = {
                                ["CFrame"] = u15,
                                ["Scale"] = u16 * 3.25 * u6.point(0.9, 1, v73 / 0.5),
                                ["Duration"] = v17 * 1.175
                            }
                            local v87 = u16 * u6.point(0, 0.5, v73 / 0.25)
                            v86.Offset = Vector3.new(0, v87, 0)
                            v86.YInfluence = 0.075
                            v85(v86)
                            u11({
                                ["CFrame"] = u15,
                                ["Scale"] = u16 * 2 * u6.point(0.75, 1, v73 / 0.25),
                                ["Duration"] = v17
                            })
                            v70 = v71
                        end
                        local v88 = v78 * 1.5
                        for v89, v90 in next, v25 do
                            local v91 = v89 % 2 == 0 and 1 or -1
                            v90.CFrame = u15 * CFrame.Angles(0, v36, 0) * CFrame.new(v88 * (v91 == 1 and math.sin(v36) or math.cos(v36)), v91 * v88 * (v91 == 1 and math.cos(v36) or math.sin(v36)), v91 * v88)
                            local v92 = v90.A
                            local v93 = 0.35 * v88
                            v92.Position = Vector3.new(0, 0, v93)
                            local v94 = v90.B
                            local v95 = -0.35 * v88
                            v94.Position = Vector3.new(0, 0, v95)
                        end
                        if v71 - 0 > 0.15 then
                            local v96 = (u3.CFrame.Position - u15.Position).Magnitude / (10 + u16 * 3.5)
                            if v96 < 1 then
                                local v97 = 1 - v96
                                u12({
                                    ["RotationInfluence"] = Vector3.new(0, 0, 1),
                                    ["Roughness"] = 8 * v97,
                                    ["Magnitude"] = 6 * v97,
                                    ["FadeIn"] = 0.5,
                                    ["FadeOut"] = 0.25
                                })
                            end
                        end
                        if v73 == 1 then
                            local v98 = nil
                            for _, v99 in next, v23 do
                                v99.Particle.Object.Enabled = false
                                v99.Particle.Object.Drag = 8
                                v99.Particle.Object.Acceleration = Vector3.new(0, -5, 0) * u16
                            end
                            while true do
                                local v100 = tick()
                                v98 = v98 or v100
                                v36 = v36 + 0.10471975511965977
                                local v101 = (v100 - v98) / 1
                                local v102 = math.min(1, v101)
                                u6.ease["in"].quad(v102, 1, -1, 1)
                                local v103 = (u3.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
                                v19.CFrame = CFrame.new(u15.Position, u15.Position + v103) * CFrame.Angles(0, 0, 1.5707963267948966) * CFrame.Angles(v36, 0, 0)
                                v37 = v37 + 0.05235987755982988
                                for v104, v105 in next, v31 do
                                    local v106 = 6.283185307179586 * (v104 / #v31)
                                    local v107 = u15 * CFrame.Angles(0, v37 + v106, 0) * CFrame.new(0, 0, -u16)
                                    v105.Reference.CFrame = v107
                                end
                                local v108 = u16 * 1.3
                                for v109, v110 in next, v25 do
                                    local v111 = v109 % 2 == 0 and 1 or -1
                                    v110.CFrame = u15 * CFrame.Angles(0, v36, 0) * CFrame.new(v108 * (v111 == 1 and math.sin(v36) or math.cos(v36)), v111 * v108 * (v111 == 1 and math.cos(v36) or math.sin(v36)), v111 * v108)
                                    local v112 = v110.A
                                    local v113 = 0.35 * v108
                                    v112.Position = Vector3.new(0, 0, v113)
                                    local v114 = v110.B
                                    local v115 = -0.35 * v108
                                    v114.Position = Vector3.new(0, 0, v115)
                                end
                                if v102 == 1 then
                                    task.wait(1)
                                    v28.Object:Destroy()
                                    v19:Destroy()
                                    for _, v116 in next, v25 do
                                        v116:Destroy()
                                    end
                                    return
                                end
                                u1.RenderStepped:Wait()
                            end
                        end
                        u1.RenderStepped:Wait()
                    end
                end
                u1.RenderStepped:Wait()
            end
        end
    end
}