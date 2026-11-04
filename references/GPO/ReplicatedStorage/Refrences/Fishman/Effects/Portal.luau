 

local v1 = game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
local u3 = game.ReplicatedStorage.Refrences.Fishman
local u4 = require(v2.Util.Tween)
local u5 = require(v2.Util.Misc)
local u6 = require(u3.Effects.Shockwave)
local u7 = require(u3.Effects.Slash)
local u8 = workspace:WaitForChild("Effects")
local u9 = workspace.CurrentCamera
local u10 = require(v2.Util.ShakeCamera)
local u11 = {}
v1:BindToRenderStep(script.Parent.Name .. "-" .. script.Name, Enum.RenderPriority.Last.Value - 1000, function(_) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u4
        [3] = u5
        [4] = u6
    --]]
    local v12 = tick()
    local v13 = 0
    for v14, v16 in next, u11 do
        if v13 > 0 then
            local v16 = u11[v14 - v13]
        end
        local v17 = v12 - v16.Start
        if v16.FadeIn + v16.FadeOut + v16.Lifetime < v17 then
            v16.crown:Destroy()
            v16.blob.Transparency = 1
            if v16.FadeIn + v16.FadeOut + v16.Lifetime + 1 < v17 then
                v16.blob:Destroy()
                table.remove(u11, v14 - v13)
                v13 = v13 + 1
            end
        elseif v16.FadeIn + v16.Lifetime < v17 then
            local v18 = (v17 - v16.FadeIn - v16.Lifetime) / v16.FadeOut
            u4.ease.out.quad(v18, 1, -1, 1)
            local v19 = u4.ease["in"].quad(v18, 1, -1, 1)
            local v20 = u4.ease["in"].quad(v18, 0, 1, 1)
            local v21 = u4.ease.inout.quad(v18, 1, -1, 1)
            local v22 = u4.ease.out.quad(v18, 0, 1, 1)
            local v23 = v16.Scale * v19
            local v24 = v16.Scale * v19 ^ 0.5
            local v25 = v16.blob_mesh
            local v26 = v16.BLOB_SCALE
            local v27 = v21 ^ 0.125
            local v28 = v19 ^ 0.5
            local v29 = v21 ^ 0.125
            v25.Scale = v26 * Vector3.new(v27, v28, v29) * v16.Scale
            local v30 = v16.Origin
            local v31 = v16.Scale * 0.005 * v20
            local v32 = v30 - Vector3.new(0, v31, 0)
            v16.blob.CFrame = v32
            v16.blob.Transparency = u4.point(0.55, 1, v20)
            if v16.Surface then
                v16.crown.CFrame = v32 * CFrame.Angles(0, 3.141592653589793 * (v18 % 2) / (2 + 2 * v20), 0)
                v16.crown.Transparency = v22
            end
            for _, v33 in next, v16.attachments do
                v33.Object.Position = v33.Offset * v23
                v33.Particle.Object.Size = u5.ScaleParticleSize(v33.Particle.Size, 1.5 * v23)
                v33.Particle.Object.Acceleration = v33.Particle.Acceleration * (v16.Surface and v23 and v23 or v24 * 5 * v19 ^ 0.5)
                v33.Particle.Object.Speed = NumberRange.new(v33.Particle.Speed * v23)
                v33.Particle.Object.ZOffset = v33.Particle.ZOffset * v23
            end
            if v18 > 0.75 then
                for _, v34 in next, v16.attachments do
                    v34.Particle.Object.Enabled = false
                end
            end
        elseif v16.FadeIn < v17 then
            local v35 = (v17 - v16.FadeIn) / v16.Lifetime
            for _, v36 in next, v16.waves do
                v36:Destroy()
            end
            local v37 = u4.ease.out.quad(v35, 0, 1, 1)
            if v16.Surface then
                v16.crown.CFrame = v16.Origin * CFrame.Angles(0, 6.283185307179586 * (v17 % 2 / 2), 0)
            else
                v16.crown.Transparency = v37
            end
        else
            local v38 = v17 / v16.FadeIn
            local v39 = u4.ease.out.quad(v38, 0, 1, 1)
            local v40 = u4.ease.inout.sine(v38, 0, 1, 1)
            u4.ease["in"].quad(v38, 0, 1, 1)
            local v41 = v16.Scale * v39
            v16.blob_mesh.Scale = v16.BLOB_SCALE * v16.Scale * v40
            v16.crown_mesh.Scale = v16.CROWN_SCALE * v16.Scale * v40 * 0.75
            local v42 = v16.crown
            local v43 = v16.Origin * CFrame.Angles(0, 6.283185307179586 * (v17 % 2 / 2), 0)
            local v44 = v16.Scale * 0.01 * v40
            v42.CFrame = v43 + Vector3.new(0, v44, 0)
            local v45 = v16.Origin
            v16.blob.CFrame = v45
            for _, v46 in next, v16.attachments do
                v46.Object.Position = v46.Offset * v41
                v46.Particle.Object.Size = u5.ScaleParticleSize(v46.Particle.Size, 1.5 * v41)
                v46.Particle.Object.Acceleration = v46.Particle.Acceleration * v41 * (v16.Surface and 1 or 5)
                v46.Particle.Object.Speed = NumberRange.new(v46.Particle.Speed * v41)
                v46.Particle.Object.ZOffset = v46.Particle.ZOffset * v41
            end
            local v47 = v16.Scale / 3
            u4.ease.inout.quad(v38, 0, 1, 1)
            local v48 = u4.ease.out.quad(v38, 0, 1, 1)
            local v49 = u4.ease["in"].sine(v38, 0, 1, 1)
            local v50 = u4.ease.out.quad
            local v51 = v38 / 0.5
            local v52 = v50(math.min(v51, 1), 0, 1, 1)
            for v53, v54 in next, v16.waves do
                local v55 = 6.283185307179586 * (v53 / 10)
                local v56 = v47 * v52 * 1.25
                v54.CFrame = v45 * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), v55) * CFrame.new(0, 0, -u4.point(0, v47 * 1.125, v52)) * CFrame.Angles(-3.141592653589793 - 2.792526803190927 * v48 ^ 2, 0, 0)
                v54.Tip.Position = Vector3.new(0, 0, -1) * v56 * 1.5
                v54.Beam.Width0 = v56 / 1.5
                v54.Beam.Width1 = v56
                v54.Beam.Transparency = NumberSequence.new(v49 ^ 0.5)
                v54.Beam.ZOffset = 1 * v47 * v48
            end
            if v38 > 0.65 then
                v16.attachments.Origin.Particle.Object.Enabled = false
            elseif v38 > 0.1 then
                if not v16.emitted then
                    v16.emitted = true
                    v16.e_ring:Emit(1)
                end
                if not v16.lastShockwave then
                    v16.lastShockwave = 0
                end
                if v16.first and v12 - v16.lastShockwave > v16.FadeIn * 0.65 / 3 then
                    local v57 = u6
                    local v58 = {
                        ["CFrame"] = v45,
                        ["Scale"] = v16.Scale * 0.9,
                        ["Duration"] = v16.FadeIn * 0.5
                    }
                    local v59 = v16.Scale * u4.point(0.5, 1, v38 / 0.65)
                    v58.Offset = Vector3.new(0, v59, 0)
                    v57(v58)
                    v16.lastShockwave = v12
                elseif not v16.first then
                    u6({
                        ["CFrame"] = v45,
                        ["Scale"] = v16.Scale * 1.25,
                        ["Duration"] = v16.FadeIn * 0.75
                    })
                    v16.first = true
                end
            end
        end
    end
end)
return function(p60) --[[ Line: 168 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u3
        [3] = u8
        [4] = u5
        [5] = u10
        [6] = u7
        [7] = u11
    --]]
    local u61 = p60.CFrame or CFrame.new()
    local u62 = p60.Scale or 20
    local v63 = p60.Shake or true
    if (u9.CFrame.p - u61.p).Magnitude <= 50 + u62 * 8 then
        local v64 = p60.Special
        local v65 = p60.Special2
        local u66 = p60.FadeIn or 0.75
        local v67 = p60.Lifetime or 1
        local v68 = p60.FadeOut or 0.5
        local v69 = p60.Surface
        local v70 = v69 and u3.Assets.Crown:Clone() or u3.Assets.Ring:Clone()
        local v71 = v70.Mesh
        local v72 = v69 and v71.Scale or Vector3.new(1, 1.75, 1) * v71.Scale.X
        local u73 = u3.Assets.Blob:Clone()
        local v74 = u73.Mesh
        local v75 = v69 and v74.Scale or Vector3.new(1, 1, 1) * v74.Scale.X
        u73.CFrame = u61
        v74.Scale = v75 * 0
        v71.Scale = v72 * 0
        v70.CFrame = u61
        local v76 = next
        local v77, v78 = u73:GetChildren()
        local v79 = {}
        local v80 = {}
        local v81 = {}
        for _, v82 in v76, v77, v78 do
            if v82:IsA("Attachment") then
                v79[v82.Name] = {
                    ["Object"] = v82,
                    ["Offset"] = v82.Position * (v69 and 1 or 4),
                    ["Particle"] = {
                        ["Size"] = v82.Water.Size.Keypoints,
                        ["Object"] = v82.Water,
                        ["Acceleration"] = v82.Water.Acceleration,
                        ["Speed"] = v82.Water.Speed.Max,
                        ["ZOffset"] = v82.Water.ZOffset
                    }
                }
            end
        end
        if not v69 then
            v79.Origin.Particle.Acceleration = Vector3.new()
            v79.Origin.Particle.Object.SpreadAngle = Vector2.new(180, 180)
            v79.Origin2.Particle.Object.SpreadAngle = Vector2.new(180, 180)
        end
        for _ = 1, 10 do
            local v83 = u3.Assets.Wave:Clone()
            v83.CFrame = u61
            v83.Beam.Width0 = 0
            v83.Beam.Width1 = 0
            v83.Beam.ZOffset = 0
            v83.Tip.Position = Vector3.new()
            v83.Parent = u8
            table.insert(v81, v83)
        end
        u73.Parent = u8
        v70.Parent = u8
        local v84 = u3.Particles.EnergyRing:Clone()
        v84.Size = u5.ScaleParticleSize(v84.Size.Keypoints, u62 / 2 * (v69 and 1 or 1.5))
        v84.Lifetime = NumberRange.new(u66 * 0.65)
        v84.Parent = v79.Origin.Object
        if v63 then
            local v85 = (u9.CFrame.p - u61.p).Magnitude / (10 + u62 * 2.75)
            if v85 < 1 then
                local v86 = 1 - v85
                u10({
                    ["RotationInfluence"] = Vector3.new(0, 0, 1),
                    ["Roughness"] = 8 * v86,
                    ["Magnitude"] = 6 * v86,
                    ["FadeIn"] = u66,
                    ["FadeOut"] = v68
                })
            end
        end
        if v64 then
            coroutine.resume(coroutine.create(function() --[[ Line: 267 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u61
                    [3] = u62
                    [4] = u73
                    [5] = u66
                --]]
                for v87 = 1, 3 do
                    u7({
                        ["CFrame"] = u61,
                        ["Scale"] = u62 * (v87 / 6 + 0.075),
                        ["Color"] = u73.Color,
                        ["Duration"] = u66 * (v87 / 9 + 0.65)
                    })
                    task.wait(0.15)
                end
            end))
        end
        for v88, v89 in next, v79 do
            v89.Object.Position = Vector3.new()
            if v65 and v88 ~= "Origin" or not v65 then
                v89.Particle.Object.Enabled = true
                v89.Particle.Object.Rate = v89.Particle.Object.Rate / 90 * u62
            end
        end
        u5.PlaySound(v79.Origin.Object, u3.Sounds.WaterPillarHit, {
            ["PlaybackSpeed"] = 1 / (u66 * 0.75)
        })
        local v90 = u11
        local v91 = {
            ["Origin"] = u61,
            ["Scale"] = u62,
            ["Shake"] = v63,
            ["FadeIn"] = u66,
            ["FadeOut"] = v68,
            ["Lifetime"] = v67,
            ["Special"] = v64,
            ["Special2"] = v65,
            ["Surface"] = v69,
            ["particles"] = v80,
            ["attachments"] = v79,
            ["waves"] = v81,
            ["e_ring"] = v84,
            ["crown"] = v70,
            ["crown_mesh"] = v71,
            ["CROWN_SCALE"] = v72,
            ["blob"] = u73,
            ["blob_mesh"] = v74,
            ["BLOB_SCALE"] = v75,
            ["Start"] = tick()
        }
        table.insert(v90, v91)
    end
end