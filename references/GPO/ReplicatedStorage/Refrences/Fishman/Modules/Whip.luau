 

local u1 = game:GetService("RunService")
local u2 = game.ReplicatedStorage.Refrences.Fishman
local u3 = workspace:WaitForChild("Effects")
local u4 = require(game:GetService("ReplicatedStorage").Util.FABRIK)
local u5 = require(game:GetService("ReplicatedStorage").Util.Tween)
local u6 = require(game:GetService("ReplicatedStorage").Util.Misc)
local u7 = require(u2.Effects.Shockwave)
local u8 = {}
game["Run Service"].Heartbeat:Connect(function(p9) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    tick()
    local v10 = 0
    for v11, u13 in next, u8 do
        if v10 > 0 then
            local u13 = u8[v11 - v10]
        end
        if u13.Origin.Parent then
            u13:Update(nil, p9)
        else
            task.spawn(function() --[[ Line: 21 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13:Destroy()
            end)
            table.remove(u8, v11 - v10)
            v10 = v10 + 1
        end
    end
end)
local u93 = {
    ["new"] = function(p14, p15, p16) --[[ Name: new, Line 35 ]]
        --[[
        Upvalues:
            [1] = u93
        --]]
        local v17 = {
            ["Origin"] = p14 or Vector3.new(),
            ["Goal"] = p15 or Vector3.new(0, 0, -1),
            ["Width"] = p16 or 1
        }
        local v18 = {
            ["__index"] = u93
        }
        return setmetatable(v17, v18):__init()
    end,
    ["__init"] = function(p19) --[[ Name: __init, Line 43 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u4
            [3] = u3
            [4] = u6
            [5] = u8
        --]]
        if p19.Chain then
            return p19
        end
        local v20 = p19.Origin
        local v21 = typeof(v20) == "Vector3" and p19.Origin or p19.Origin.Position
        local v22 = p19.Goal
        local v23 = typeof(v22) == "Vector3" and p19.Goal or p19.Goal.Position
        p19.Growing = true
        p19.LastVelocity = Vector3.new(0, 1, 0)
        p19.Part = u2.Assets.Water:Clone()
        p19.Unit = p19.Part.Size
        p19.Bones = {}
        p19.Particles = {}
        p19.Points = { v21 }
        local v24 = next
        local v25, v26 = p19.Part:GetDescendants()
        for v27, v28 in v24, v25, v26 do
            if v28:IsA("Bone") then
                v28.Visible = false
                local v29 = v28.CFrame
                if v27 > 1 then
                    v29 = p19.Bones[v27 - 1].Offset * v28.CFrame
                end
                local v30 = p19.Bones
                local v31 = {
                    ["Bone"] = v28,
                    ["Offset"] = v29 - v29.p,
                    ["LocalOffset"] = v28.CFrame
                }
                table.insert(v30, v31)
                local v32 = Instance.new("Attachment")
                local v33 = u2.Particles.Water:Clone()
                local v34 = u2.Particles.WaterBlobs:Clone()
                v33.Rate = 5
                v33.ZOffset = -0.1
                v33.Enabled = true
                v33.Parent = v32
                v34.Rate = 20
                v34.ZOffset = p19.Width
                v34.Enabled = true
                v34.Parent = v32
                v32.Parent = p19.Part
                local v35 = p19.Particles
                local v36 = {
                    ["Particle"] = v33,
                    ["Particle2"] = v34,
                    ["Attachment"] = v32,
                    ["Size"] = v33.Size.Keypoints,
                    ["Size2"] = v34.Size.Keypoints
                }
                table.insert(v35, v36)
            end
        end
        for v37, v38 in next, p19.Bones do
            local v39
            if v37 == 1 then
                v39 = p19.Bones[v37].Bone.Position.Magnitude
            else
                v39 = v38.Bone.Position.Magnitude
                local _ = #p19.Bones - 2 <= v37
            end
            p19.Points[v37 + 1] = p19.Points[v37] - p19.LastVelocity * v39
        end
        p19.Chain = u4.new(p19.Points, v23)
        p19:SetWidth()
        p19:Update()
        p19.Part.Parent = u3
        p19.SoundLoop = u6.PlaySound(p19.Particles[1].Attachment, u2.Sounds.WaterPillarLoop)
        local v40 = u8
        table.insert(v40, p19)
        return p19
    end,
    ["ScaleParticles"] = function(p41, p42) --[[ Name: ScaleParticles, Line 125 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        for _, v43 in next, p41.Particles do
            v43.Particle.Size = u6.ScaleParticleSize(v43.Size, p42)
            v43.Particle.Speed = NumberRange.new(p42, 2 * p42)
            v43.Particle2.Size = u6.ScaleParticleSize(v43.Size2, 4 * p42)
            v43.Particle2.Speed = NumberRange.new(p42)
        end
    end,
    ["SetWidth"] = function(p44, p45) --[[ Name: SetWidth, Line 135 ]]
        local v46 = p45 or 0
        local v47 = p44.Chain.totallength
        Vector3.new()
        Vector3.new()
        local v48, v49
        if p44.Unit.X > p44.Unit.Y and p44.Unit.X > p44.Unit.Z then
            v48 = Vector3.new(1, 0, 0)
            v49 = Vector3.new(0, 1, 1)
        elseif p44.Unit.Y > p44.Unit.X and p44.Unit.Y > p44.Unit.Z then
            v48 = Vector3.new(0, 1, 0)
            v49 = Vector3.new(1, 0, 1)
        else
            v48 = Vector3.new(0, 0, 1)
            v49 = Vector3.new(1, 1, 0)
        end
        local v50 = v48 * v47 + v49 * v46
        p44.Part.Size = v50
        p44:ScaleParticles(v46)
    end,
    ["Destroy"] = function(p51) --[[ Name: Destroy, Line 161 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u1
        --]]
        local v52 = p51.Chain.origin
        local v53 = p51.LastVelocity
        local v54 = p51.Part.Transparency
        local v55 = p51.Width
        local v56 = nil
        local v57 = nil
        while true do
            local v58 = tick()
            if not v56 then
                v56 = v58
                v57 = 0.016666666666666666
            end
            local v59 = (v58 - v56) / 0.5
            local v60 = math.min(1, v59)
            u5.ease.out.quad(v60, 0, 1, 1)
            local v61 = u5.ease["in"].quad(v60, 0, 1, 1)
            local v62 = u5.ease.out.quint(v60, 0, 1, 1)
            p51:Update(v52 + v53 * p51.Chain.totallength * v60, v57)
            p51.Part.Transparency = u5.point(v54, 1, v61)
            p51:SetWidth(u5.point(v55, 0, v62))
            if v60 == 1 then
                p51.Part:Destroy()
                return
            end
            if v60 > 0.5 then
                for _, v63 in next, p51.Particles do
                    v63.Particle.Enabled = false
                end
            end
            u1.RenderStepped:Wait()
            v57 = tick() - v58
        end
    end,
    ["Update"] = function(p64, p65, _) --[[ Name: Update, Line 209 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        local v66 = tick()
        if not (p64.Start and p64.LastLerp) then
            p64.Start = v66
            p64.LastLerp = v66
        end
        local v67 = (v66 - p64.Start) / 0.25
        local v68 = math.min(1, v67)
        if p64.Growing then
            p64:SetWidth(p64.Width * v68)
        end
        if v68 == 1 then
            p64.Growing = false
        else
            p64.Growing = true
        end
        local v69 = 6.283185307179586 * tick()
        local v70
        if p65 then
            v70 = p65
        else
            local v71 = p64.Origin
            v70 = typeof(v71) == "Vector3" and p64.Origin or p64.Origin.Position
        end
        local v72 = p64.Origin.Parent and p64.Origin.CFrame.LookVector.Unit or p64.LastVelocity
        if v72 ~= v72 or v72.Magnitude < 0.01 then
            v72 = p64.LastVelocity
        end
        local v73 = p64.Chain.totallength * 0.1 * (p65 and 2 or 1)
        local v74 = 2 * v69 * (p65 and 2 or 1)
        local v75 = v73 * math.sin(v74)
        local v76 = Vector3.new(0, v75, 0)
        local v77 = CFrame.new(Vector3.new(), v72):PointToObjectSpace(v76)
        p64.Chain.origin = v70 + v77
        p64.Chain:forward()
        p64.Chain.target = p64.Chain.joints[#p64.Chain.joints]
        p64.LastVelocity = v72
        if not p65 then
            if not p64.StartShockwave then
                p64.StartShockwave = Vector3.new()
            end
            if (v70 - p64.StartShockwave).Magnitude > p64.Chain.totallength * 0.175 then
                local v78 = u7
                local v79 = {
                    ["CFrame"] = CFrame.new(p64.Chain.joints[1], p64.Chain.joints[2]) * CFrame.Angles(-1.5707963267948966, 0, 0),
                    ["Scale"] = p64.Width * 1.75,
                    ["Duration"] = 0.4
                }
                local v80 = p64.Width
                v79.Offset = Vector3.new(0, v80, 0)
                v79.YInfluence = 0.3
                v78(v79)
                p64.StartShockwave = v70
            end
        end
        local v81 = CFrame.new(p64.Chain.origin + (p64.Chain.target - p64.Chain.origin).Unit * p64.Chain.totallength / 2, p64.Chain.target)
        p64.Part.CFrame = v81
        for v82, _ in next, p64.Chain.joints do
            local v83
            if v82 < #p64.Chain.joints then
                v83 = v82 + 1
            else
                v83 = false
            end
            if v83 then
                local v84 = p64.Chain.joints[v83] - p64.Chain.joints[v82]
                local v85 = CFrame.new(p64.Chain.joints[v82] + v84 / 2, p64.Chain.joints[v83])
                local v86 = CFrame.Angles(0, 3.141592653589793, 0) * p64.Bones[v82].Offset
                local v87 = v81:ToObjectSpace(v85 * v86)
                local v88 = v81 * v87
                local v89 = CFrame.new(0, 0, -v84.Magnitude / 2)
                if v82 > 1 then
                    local v90 = p64.Chain.joints[v82] - p64.Chain.joints[v82 - 1]
                    local v91 = v81:ToObjectSpace(CFrame.new(p64.Chain.joints[v82 - 1] + v90 / 2, p64.Chain.joints[v82]) * v86)
                    local v92 = (v81 * v91):ToObjectSpace(v88)
                    p64.Bones[v82].Bone.CFrame = v92
                    p64.Particles[v82].Attachment.CFrame = v91 * v89
                else
                    p64.Bones[v82].Bone.CFrame = v87
                    p64.Particles[v82].Attachment.CFrame = v87 * v89
                end
                p64.Particles[v82].Particle.Acceleration = v72 * p64.Chain.totallength
            end
        end
    end
}
return u93