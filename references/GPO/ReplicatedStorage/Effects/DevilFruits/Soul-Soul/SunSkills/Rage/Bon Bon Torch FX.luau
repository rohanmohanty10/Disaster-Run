 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
Random.new()
require(script.Parent.Shared)
local u2 = require(game.ReplicatedStorage.Modules.Shared.Maids.Maid)
local u3 = script.VFX
local v4 = {}
local function u11(p5, p6, _) --[[ Line: 13 ]]
    local v7 = p5.Position
    local v8 = p5.LookVector:Cross(p6).Unit
    local v9 = (v8.Magnitude > 0.001 and v8 and v8 or p5.RightVector).Unit
    local v10 = v9:Cross(p6).Unit.Unit
    return CFrame.fromMatrix(v7, v9, p6, v10)
end
function v4.start(_, u12) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u11
        [4] = u1
    --]]
    local u13 = u12.Cloud
    local u14 = u12.Character
    local v15 = workspace:GetServerTimeNow() - u12.serverStartTime
    local u16 = Vector3.new(0, 0, 0)
    local u17 = Vector3.new(0, 0, 0)
    local u18 = Vector3.new(0, 0, 0)
    local u19 = u12.BodyRoot
    local u20 = u14.PrimaryPart
    local u21 = 0.5 - v15
    local u22 = true
    local u23 = u13.AttachedPart.SkillTrail
    _G.customEmit(u13.AttachedPart.SkillStart)
    _G.PlaySound(u14.PrimaryPart, script.SoulPrometheusFlameThrowerStartup)
    local u24 = CFrame.Angles(0, -0.3490658503988659, 0)
    task.spawn(function() --[[ Line: 50 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u21
            [3] = u18
            [4] = u20
            [5] = u16
            [6] = u17
            [7] = u19
            [8] = u22
            [9] = u24
        --]]
        while true do
            while true do
                local v25 = task.wait()
                local v26 = workspace:GetServerTimeNow() - u12.serverStartTime
                local v27 = v26 / u21
                local v28 = math.min(v27, 1)
                u18 = u20.Position:Lerp(u20.Position + u20.CFrame.LookVector * 8, v28)
                local v29 = u18 + u16 + u17
                if v26 > u21 then
                    break
                end
                local v30 = u20.CFrame
                local v31 = CFrame.new
                local v32 = 3.141592653589793 * v28
                local v33 = math.sin(v32)
                local v34 = 3.141592653589793 * v28
                local v35 = math.cos(v34)
                local v36 = Vector3.new(v33, 0, v35)
                local v37 = v28 * 3.141592653589793
                u16 = v30 * v31(v36 * math.sin(v37) * 25).Position - u20.Position
                local v38 = v28 * 3.141592653589793
                u17 = Vector3.new(0, 15, 0) * math.sin(v38)
                u19.BodyGyro.CFrame = u19.CFrame:Lerp(CFrame.new(u19.Position, v29), v25 * 3)
                u19.BodyPosition.Position = v29
            end
            if not u22 then
                return
            end
            local v39 = u20.CFrame * CFrame.new(0, 0, -8) * u24
            u19.BodyGyro.CFrame = v39
            u19.BodyPosition.Position = v39.Position
            u19.CFrame = v39
        end
    end)
    _G.particleEnabled(u23, true)
    task.delay(0.5 - v15, function() --[[ Line: 81 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u23
            [3] = u13
            [4] = u2
            [5] = u24
            [6] = u3
            [7] = u14
            [8] = u11
            [9] = u1
            [10] = u22
        --]]
        _G.PlayEffect("Homie Impact Flash", nil, {
            ["Color"] = Color3.fromRGB(255, 85, 0),
            ["Position"] = u19.CFrame.Position
        })
        _G.particleEnabled(u23, false)
        _G.customEmit(u13.AttachedPart.SkillStart)
        u13:ScaleTo(1.6)
        local v40 = script.SoulPrometheusFlameThrowerLoop:Clone()
        v40.Parent = u19
        v40:Play()
        local v41 = u2.new()
        local v42 = CFrame.new(0, 0, -5) * u24:Inverse()
        local v43 = u3.FlameBreath:Clone()
        v43:PivotTo(u19.CFrame * v42)
        v43.Anchored = true
        v43.Parent = workspace.Effects
        v41.Breathe = v43
        _G.customWeld(v43, u19, v42, v43)
        local u44 = u3.FX_Wind:Clone()
        u44:PivotTo(u19.CFrame * CFrame.new(0, 0, -6))
        u44.Anchored = true
        u44.Parent = workspace.Effects
        v41.Wind = u44
        _G.customWeld(u44, u19, v42, u44)
        _G.PlaySound(u19, script.SoulPrometheusFlameThrowerStart).Parent = u19
        local v48 = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 124 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u44
                [3] = u11
            --]]
            if u14.PrimaryPart then
                local v45, v46, v47 = _G.getRayFloor(u14.PrimaryPart.CFrame, 15)
                u44.Ember.Acceleration = u14.PrimaryPart.CFrame.LookVector * -380
                if v45 then
                    _G.recolorParticles(u44.FloorAttachment, v45.Color)
                    _G.particleEnabled(u44.FloorAttachment, true)
                    u44.FloorAttachment.WorldCFrame = u11(CFrame.new(Vector3.new(), u14.HumanoidRootPart.CFrame.LookVector) + v46, v47)
                    return
                end
                _G.particleEnabled(u44.FloorAttachment, false)
            end
        end)
        u1:Create(v43.SpotLight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true, 0), {
            ["Angle"] = 50
        }):Play()
        repeat
            task.wait()
        until u14:GetAttribute("SunTorch") == nil
        v48:Disconnect()
        u1:Create(v43.SpotLight, TweenInfo.new(0.25), {
            ["Brightness"] = 0
        }):Play()
        u1:Create(v40, TweenInfo.new(0.25), {
            ["Volume"] = 0
        }):Play()
        _G.destroy(v40, 0.25)
        _G.particleEnabled(v43, false)
        _G.particleEnabled(u44, false)
        u22 = false
        _G.PlaySound(u19, script.SoulPrometheusFlameThrowerEnd)
        u13:ScaleTo(1)
        task.wait(1)
        v41:Destroy()
    end)
end
return v4