 

local u1 = game:GetService("RunService")
local u2 = game.ReplicatedStorage.Refrences.Fishman
local u3 = workspace:WaitForChild("Effects")
local u4 = require(game:GetService("ReplicatedStorage").Util.Tween)
local u5 = require(game:GetService("ReplicatedStorage").Util.Misc)
local u6 = require(u2.Effects.Shockwave)
local u7 = require(u2.Effects.Slash)
local u8 = require(u2.Effects.Wind)
local _ = workspace.CurrentCamera
local u9 = {}
u1:BindToRenderStep(script.Parent.Name .. "-" .. script.Name, Enum.RenderPriority.Last.Value - 1000, function(p10) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    tick()
    local v11 = 0
    for v12, u14 in next, u9 do
        if v11 > 0 then
            local u14 = u9[v12 - v11]
        end
        if u14.Reference.Parent then
            u14:Update(p10)
        else
            spawn(function() --[[ Line: 24 ]]
                --[[
                Upvalues:
                    [1] = u14
                --]]
                u14:Destroy()
            end)
            table.remove(u9, v12 - v11)
            v11 = v11 + 1
        end
    end
end)
local u101 = {
    ["new"] = function(p15, p16) --[[ Name: new, Line 35 ]]
        --[[
        Upvalues:
            [1] = u101
        --]]
        local v17 = p16 or {}
        local v18 = {
            ["Reference"] = p15,
            ["FadeIn"] = v17.FadeIn or 0.5,
            ["FadeOut"] = v17.FadeOut or 0.5
        }
        local v19 = {
            ["__index"] = u101
        }
        return setmetatable(v18, v19):__init()
    end,
    ["__init"] = function(p20) --[[ Name: __init, Line 44 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u9
        --]]
        p20.Effect = u2.Assets.Orb:Clone()
        p20.Mesh = p20.Effect.Mesh
        p20.UnitScale = p20.Mesh.Scale
        p20.Transparency = p20.Effect.Transparency
        p20.Attachments = {}
        local v21 = next
        local v22, v23 = p20.Effect:GetChildren()
        for _, v24 in v21, v22, v23 do
            if v24:IsA("Attachment") and not v24.Name:find("2") then
                local v25 = p20.Attachments
                local v26 = v24.Name
                local v27 = {
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
                v25[v26] = v27
            end
        end
        p20.Mesh.Scale = p20.UnitScale * 0
        p20.Effect.Transparency = p20.Transparency
        p20.Effect.CFrame = p20.Reference.CFrame
        p20.Effect.Parent = u3
        local v28 = script.WaterBallLoop:Clone()
        v28.Parent = p20.Attachments.Origin.Object
        v28:Play()
        p20.SoundLoop = v28
        for _, v29 in next, p20.Attachments do
            v29.Particle.Object.Enabled = true
        end
        local v30 = u9
        table.insert(v30, p20)
        return p20
    end,
    ["Update"] = function(p31, p32) --[[ Name: Update, Line 88 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u5
            [3] = u2
            [4] = u6
            [5] = u8
        --]]
        local v33 = tick()
        if not p31.Start then
            p31.Start = v33
        end
        local v34 = v33 - p31.Start
        local v35 = p31.Reference.CFrame
        p31.CurrentScale = (p31.Reference.Size.X + p31.Reference.Size.Y + p31.Reference.Size.Z) / 3
        if not p31.LastScale then
            p31.LastScale = p31.CurrentScale
        end
        p31.CurrentPosition = v35.p
        if not p31.LastPosition then
            p31.LastPosition = p31.CurrentPosition
        end
        local v36 = p31.LastPosition:Lerp(p31.CurrentPosition, p32 * 12)
        local v37 = u4.point(p31.LastScale, p31.CurrentScale, p32 * 6)
        local v38 = p31.Reference.Velocity.Magnitude > 0.01 and (p31.Reference.Velocity.Unit or Vector3.new(0, 1, 0)) or Vector3.new(0, 1, 0)
        p31.Effect.CFrame = CFrame.new(v36, v36 + v38)
        local v39 = v34 / p31.FadeIn
        local v40 = math.min(1, v39)
        local v41 = u4.ease.out.back(v40, 0, 1, 1)
        local v42 = u4.ease["in"].back(v40, 0, 1, 1)
        local v43 = 6.283185307179586 * v33
        local v44 = math.sin(v43)
        local v45 = v37 * v41
        local v46 = v37 * v42
        p31.Effect.Transparency = u4.point(1, p31.Transparency, v41)
        p31.Effect.Mesh.Scale = p31.UnitScale * v46
        p31.Mesh.Scale = p31.Mesh.Scale + p31.UnitScale * 0.1 * v46 * v44
        for _, v47 in next, p31.Attachments do
            local v48 = v47.Particle.Acceleration
            if v47.Particle.Acceleration.Magnitude > 0.01 then
                v48 = v35:VectorToWorldSpace(v47.Particle.Acceleration.Unit) * v47.Particle.Acceleration.Magnitude
            end
            local v49 = v47.Particle.Acceleration.Magnitude > 0.01 and v46 + v46 * 0.1 * v44 or v45 + v45 * 0.1 * v44
            v47.Object.Position = v47.Offset * v46 + v47.Offset * 0.1 * v44
            v47.Particle.Object.Size = u5.ScaleParticleSize(v47.Particle.Size, v49 + 2)
            v47.Particle.Object.Acceleration = v48 * v45 + v48 * v45 * 0.1 * v44
            v47.Particle.Object.Speed = NumberRange.new(v47.Particle.Speed * v45 + v47.Particle.Speed * v45 * 0.1 * v44)
            v47.Particle.Object.ZOffset = v47.Particle.ZOffset * v45 + v47.Particle.ZOffset * v45 * 0.1 * v44
        end
        local v50 = (p31.CurrentPosition - p31.LastPosition).Magnitude > 1
        if v40 ~= 1 then
            v50 = false
        end
        if not v50 then
            local v51 = 5 * v34
            local v52 = 6.283185307179586 * v51 / 2
            p31.Effect.Trail.Lifetime = p31.FadeIn
            p31.Effect.Trail2.Lifetime = p31.Effect.Trail.Lifetime
            local v53 = CFrame.new() * CFrame.new(0, v45 * math.sin(v51), 0) * CFrame.Angles(0, v52, 0)
            local v54 = CFrame.Angles(1.5707963267948966, 0, 0)
            local v55 = CFrame.new
            local v56 = v51 + 1.5707963267948966
            local v57 = v54 * v55(0, v45 * math.sin(v56), 0) * CFrame.Angles(0, v52, 0)
            local v58 = v53 * CFrame.new(0, 0, -v45)
            local v59 = v57 * CFrame.new(0, 0, -v45)
            p31.Effect.Top2.CFrame = v58 * CFrame.new(v45 * 0.175, 0, 0)
            p31.Effect.Top22.CFrame = v58 * CFrame.new(-v45 * 0.175, 0, 0)
            p31.Effect.Bottom2.CFrame = v59 * CFrame.new(v45 * 0.175, 0, 0)
            p31.Effect.Bottom22.CFrame = v59 * CFrame.new(-v45 * 0.175, 0, 0)
        end
        if v40 == 1 and v50 then
            if not p31.Emitted then
                u5.PlaySound(p31.Attachments.Origin.Object, u2.Sounds.Pulse, {
                    ["PlaybackSpeed"] = 1.5
                })
                local v60 = u2.Particles.EnergyRing:Clone()
                v60.Color = ColorSequence.new(Color3.fromRGB(100, 200, 255))
                v60.LockedToPart = false
                v60.Size = u5.ScaleParticleSize({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) }, v37 * 1.75)
                v60.Lifetime = NumberRange.new(0.35 * p31.FadeIn)
                v60.Parent = p31.Attachments.Origin.Object
                v60:Emit(1)
                local v61 = u2.Particles.WaterSplash:Clone()
                v61.Color = ColorSequence.new(Color3.fromRGB(75, 175, 255))
                v61.LockedToPart = false
                v61.Transparency = u2.Particles.EnergyRing.Transparency
                v61.Size = u5.ScaleParticleSize({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) }, v37 * 1.75)
                v61.Lifetime = NumberRange.new(0.45 * p31.FadeIn)
                v61.Parent = p31.Attachments.Origin.Object
                v61:Emit(1)
                p31.Emitted = true
            end
            if not p31.StartShockwave then
                p31.StartShockwave = Vector3.new()
            end
            if not p31.StartWind then
                p31.StartWind = Vector3.new()
            end
            local v62 = 10 * v34
            local v63 = math.cos(v62)
            local v64 = math.sin(v62)
            local v65 = Vector3.new(v63, v64)
            local v66 = 3.141592653589793 + v62
            local v67 = math.cos(v66)
            local v68 = 3.141592653589793 + v62
            local v69 = math.sin(v68)
            local v70 = Vector3.new(v67, v69)
            local v71 = CFrame.new(v45 * 0.5 * v65) * CFrame.new(0, v45 / 4, 0)
            local v72 = CFrame.new(v45 * 0.5 * v70) * CFrame.new(0, -v45 / 4, 0)
            if (p31.CurrentPosition - p31.StartShockwave).Magnitude > v37 * 0.55 and p31.Effect.Anchored == false then
                local v73 = u6
                local v74 = {
                    ["CFrame"] = CFrame.new(v35.p, v35.p + v38) * CFrame.Angles(-1.5707963267948966, 0, 0),
                    ["Scale"] = v37 * 1.25,
                    ["Duration"] = 0.55
                }
                local v75 = -v37 / 2
                v74.Offset = Vector3.new(0, v75, 0)
                v74.YInfluence = 0.25
                v73(v74)
                p31.StartShockwave = p31.CurrentPosition
            end
            if (v35.p - p31.StartWind).Magnitude > v37 * 0.4 then
                local v76 = p31.Reference.Velocity.Unit
                local v77 = Ray.new(v35.p, Vector3.new(0, -1, 0) * v37 * 0.75)
                local v78, v79, v80 = _G.raycastWhitelist(v77, { workspace.Islands, workspace.Env, workspace.Ships })
                if v78 then
                    local v81 = u5.AlignCFrame(CFrame.new(v79, v79 + v76), v80) * CFrame.new(0, 0, -v37 * 0.25)
                    for v82 = 1, 2 do
                        local v83 = v82 % 2 == 0 and 1 or -1
                        local v84 = u8
                        local v85 = {
                            ["CFrame"] = v81 * CFrame.new(v83 * v37 * 0.125, 0, 0) * CFrame.Angles(0, v83 * 3.141592653589793 * 0.0125, v83 * -3.141592653589793 / 6),
                            ["Scale"] = v37 * 1.125,
                            ["Duration"] = 0.75
                        }
                        local v86 = v83 * v37 * 0.25
                        local v87 = v37 * 0.1
                        local v88 = 0.5 * v37
                        v85.Offset = Vector3.new(v86, v87, v88)
                        v84(v85)
                    end
                end
                p31.StartWind = v35.p
            end
            p31.Effect.Trail.Lifetime = 50 / p31.Reference.Velocity.Magnitude
            p31.Effect.Trail2.Lifetime = p31.Effect.Trail.Lifetime
            p31.Effect.Top2.CFrame = v71 + v71.UpVector * v45 * 0.5
            p31.Effect.Top22.CFrame = v71 - v71.UpVector * v45 * 0.5
            p31.Effect.Bottom2.CFrame = v72 + v72.UpVector * v45 * 0.5
            p31.Effect.Bottom22.CFrame = v72 - v72.UpVector * v45 * 0.5
        end
        p31.LastPosition = v36
        p31.LastScale = v37
    end,
    ["Destroy"] = function(p89) --[[ Name: Destroy, Line 268 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u2
            [3] = u4
            [4] = u7
            [5] = u1
        --]]
        u5.PlaySound(p89.LastPosition, u2.Sounds.WaterPillarStart, {
            ["PlaybackSpeed"] = 1 / (p89.FadeOut * 0.75)
        })
        p89.LastScale = p89.LastScale or Vector3.new()
        p89.Effect.Trail.Lifetime = p89.FadeOut
        p89.Effect.Trail2.Lifetime = p89.Effect.Trail.Lifetime
        local v90 = p89.Mesh.Scale
        local v91 = nil
        while true do
            local v92 = tick()
            v91 = v91 or v92
            local v93 = (v92 - v91) / p89.FadeOut
            local v94 = math.min(1, v93)
            local v95 = u4.ease["in"].quad(v94, 0, 1, 1)
            local v96 = u4.ease.out.sine(v94, 0, 1, 1)
            if v94 < 0.75 then
                if not p89.LastRender then
                    p89.LastRender = 0
                end
                if p89.LastRender == 10 then
                    u7({
                        ["CFrame"] = p89.Effect.CFrame,
                        ["Scale"] = p89.LastScale * 0.9 * 0.25,
                        ["AngleOffset"] = CFrame.Angles(Random.new():NextNumber(-1, 1) * 3.141592653589793, Random.new():NextNumber(-1, 1) * 3.141592653589793, Random.new():NextNumber(-1, 1) * 3.141592653589793),
                        ["Duration"] = p89.FadeOut * 0.45,
                        ["YInfluence"] = 10
                    })
                    p89.LastRender = 0
                else
                    p89.LastRender = p89.LastRender + 1
                end
            end
            p89.Effect.Transparency = u4.point(p89.Transparency, 1, v95)
            local v97 = p89.Mesh
            local v98 = Vector3.new(0.1, 0.1, 0.1) * v90.Magnitude
            local v99 = 6.283185307179586 * v96
            v97.Scale = v90 + v98 * math.sin(v99)
            if v94 > 0.5 then
                for _, v100 in next, p89.Attachments do
                    v100.Particle.Object.Enabled = false
                end
            end
            if v94 == 1 then
                task.wait(1)
                p89.Effect:Destroy()
                return
            end
            u1.RenderStepped:Wait()
        end
    end
}
return u101