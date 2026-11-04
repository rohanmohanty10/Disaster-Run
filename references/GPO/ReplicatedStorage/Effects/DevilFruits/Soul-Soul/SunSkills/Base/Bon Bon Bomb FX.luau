 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
local u2 = Random.new()
require(script.Parent.Shared)
local u3 = script.VFX
return {
    ["start"] = function(_, p4) --[[ Name: start, Line 11 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
            [3] = u2
        --]]
        local u5 = p4.Prometheus
        local v6 = p4.RootBody
        local u7 = p4.RootBody
        local v8 = p4.Type
        if v8 == "Charging" then
            _G.PlaySound(u7, script.SoulPrometheusThrowStart).Parent = u7
            _G.particleEnabled(u5.AttachedPart.SkillTrail, true, true)
            task.delay(0.3, function() --[[ Line: 22 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u7
                --]]
                _G.customEmit(u5.AttachedPart.SkillStart)
                _G.PlaySound(u7, script.SoulPrometheusThrowReady)
            end)
            u5:GetAttributeChangedSignal("Charging"):Once(function() --[[ Line: 27 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                _G.particleEnabled(u5.AttachedPart.SkillTrail, false, true)
            end)
            return
        end
        if v8 == "Throw" then
            local _ = p4.Gravity
            local _ = p4.Velocity
            local v9 = p4.Character
            local v10 = p4.Duration
            local v11 = p4.serverStartTime
            local v12 = p4.Velocity
            local v13 = p4.StartCFrame.Position
            local v14 = p4.Gravity
            v6.CFrame = p4.StartCFrame
            local v15 = RaycastParams.new()
            v15.FilterDescendantsInstances = _G.getTargetsWithENV(v9)
            v15.FilterType = Enum.RaycastFilterType.Include
            local u16 = v6.Parent
            _G.PlaySound(u7, script.SoulPrometheusThrowShoot).Parent = u7
            local v17 = v13
            local v18 = nil
            while true do
                local v19 = workspace:GetServerTimeNow() - v11
                if v10 <= v19 then
                    break
                end
                local v20 = v13 + v12 * v19 + 0.5 * v14 * v19 * v19
                local v21 = v12 + v14 * v19
                u16:SetAttribute("CustomMovement", true)
                v18 = workspace:Raycast(v17, v20 - v17, v15)
                if v18 and v18.Instance then
                    break
                end
                v6.CFrame = CFrame.lookAlong(v20, v21)
                task.wait()
                v17 = v20
            end
            _G.particleEnabled(u5.AttachedPart.SkillTrail, false)
            task.delay(1, function() --[[ Line: 86 ]]
                --[[
                Upvalues:
                    [1] = u16
                --]]
                u16:SetAttribute("CustomMovement", nil)
            end)
            if v18 and v18.Instance then
                local v22 = {
                    ["Position"] = v18.Position,
                    ["Normal"] = v18.Normal,
                    ["Instance"] = v18.Instance
                }
                if _G.getTargetByPart(v22.Instance) then
                    local v23, v24, v25 = _G.getRayFloor(CFrame.new(v22.Position), 15)
                    v22 = v23 and {
                        ["Position"] = v24,
                        ["Normal"] = v25,
                        ["Instance"] = v23
                    } or v22
                end
                local v26 = u3.Explosion:Clone()
                v26.CFrame = CFrame.new(v22.Position, v22.Position + v22.Normal) * CFrame.Angles(-1.5707963267948966, 0.00017453292519943296, 0.00017453292519943296) * CFrame.new(0, 0.01, 0)
                v26.CFrame = v26.CFrame * CFrame.Angles(0, math.random(-360, 360), 0)
                _G.recolorParticles(v26, v22.Instance.Color)
                v26.Parent = workspace.Effects
                task.delay(6, v26.Destroy, v26)
                _G.customEmit(v26)
                u1:Create(v26.PointLight, TweenInfo.new(0.35), {
                    ["Brightness"] = 0,
                    ["Range"] = v26.PointLight.Range * 1.5
                }):Play()
                local v27 = v26.Position
                _G.PlayEffect("GroundRocks4", nil, {
                    ["Segments"] = 20,
                    ["Position"] = v27 + Vector3.new(0, 2, 0),
                    ["DistanceRandomness"] = Vector2.new(0.3, 1),
                    ["Duration"] = 4,
                    ["TweenDuration"] = 1,
                    ["Radius"] = 20,
                    ["Direction"] = -v22.Normal * 45,
                    ["Angle"] = -0.7853981633974483
                })
                local v28 = u2:NextNumber(1.5, 2.4)
                _G.PlayEffect("RockDebris", nil, {
                    ["PartCount"] = 10,
                    ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * v28,
                    ["Position"] = v27,
                    ["Direction"] = Vector3.new(0, 15, 0),
                    ["RaycastDirection"] = -v22.Normal * 35,
                    ["Size"] = Vector3.new(0.4, 0.4, 0.4) * v28,
                    ["TrailEnabled"] = true
                })
                _G.PlaySound(v26, script.SoulPrometheusThrowExplode)
                _G.shakenear(v26.Position, 175, 100, 75, -1)
            end
        end
    end
}