 

game:GetService("ReplicatedStorage")
local u1 = game:GetService("RunService")
game:GetService("Debris")
local u2 = game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.EffectsUtil)
local _ = workspace.CurrentCamera
local u3 = Random.new()
function lerp(p4, p5, p6)
    return p4 + (p5 - p4) * p6
end
function quadBezier(p7, p8, p9, p10)
    return (1 - p7) ^ 2 * p8 + 2 * (1 - p7) * p7 * p9 + p7 ^ 2 * p10
end
local u11 = {
    ["Main"] = Color3.fromRGB(255, 255, 255),
    ["Side"] = Color3.new(0, 0, 0)
}
local u12 = {
    ["Main"] = Color3.fromRGB(255, 54, 28),
    ["Side"] = Color3.new(0, 0, 0)
}
function trailThing(p13, u14, u15, u16, u17, _, u18)
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u1
    --]]
    for v19 = 1, p13 do
        task.spawn(function() --[[ Line: 32 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u14
                [3] = u3
                [4] = u16
                [5] = u17
                [6] = u2
                [7] = u18
                [8] = u1
            --]]
            local u20 = script.TrailPart:Clone()
            u20.Parent = workspace.Effects
            local v21 = u20.Trail
            v21.Lifetime = v21.Lifetime + math.random(-100, 100) / 750
            u20.Trail.Color = u15
            local v22 = math.random(200, 600) / 1000
            u20.Attachment1.Position = Vector3.new(0, v22, 0)
            local v23 = u20.Attachment2
            local v24 = -v22
            v23.Position = Vector3.new(0, v24, 0)
            local v25 = u14.CFrame
            local v26 = CFrame.Angles
            local v27 = math.random(0, 360)
            local v28 = math.rad(v27)
            local v29 = math.random(0, 360)
            local v30 = math.rad(v29)
            local v31 = math.random(0, 360)
            local v32 = (v25 * v26(v28, v30, (math.rad(v31))) * CFrame.new(0, 0, u3:NextNumber(u16, u17))).Position
            local v33 = u14.Position
            local v34 = lerp(v32, v33, 0.5)
            local v35 = math.random(-5, 5)
            local v36 = math.random(-5, 5)
            local v37 = math.random
            local v38 = v34 + Vector3.new(v35, v36, v37(-5, 5))
            local v39 = tick()
            local v40 = 0.3 + math.random(-100, 100) / 2000
            local v41 = v39 + v40
            task.delay(v40 / 2, function() --[[ Line: 52 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u3
                --]]
                _G.tween(u20.Trail, { u3:NextNumber(0.1, 0.2), "Sine", Enum.EasingDirection.Out }, {
                    ["WidthScale"] = NumberSequence.new(0)
                })
            end)
            local v42 = true
            while tick() < v41 do
                local v43 = u14.Position
                local v44 = (tick() - v39) / v40
                u2:GetValue(v44, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
                u20.CFrame = CFrame.new(quadBezier(v44, v32, v38, v43))
                if v44 > 0.95 and v42 then
                    v42 = false
                    if u18 then
                        u18.ParticleEmitter:Emit(1)
                        u18.lines:Emit(2)
                        u18.lines2:Emit(2)
                    end
                end
                u1.RenderStepped:Wait()
            end
            task.wait(1)
            u20:Destroy()
        end)
        local v45 = u2:GetValue(v19 / p13, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        task.wait(lerp(0.13333333333333333, 0.016666666666666666, v45))
    end
end
return function(u46, u47, u48, u49, u50) --[[ Line: 84 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u11
    --]]
    local u51 = u47 and u12 or u11
    local u52 = u47 and script.MeraChargeParticles.Attachment:Clone() or script.ChargeParticles.Attachment:Clone()
    u52.Parent = u46
    task.spawn(function() --[[ Line: 88 ]]
        --[[
        Upvalues:
            [1] = u51
            [2] = u50
            [3] = u46
            [4] = u48
            [5] = u49
            [6] = u47
        --]]
        local v53 = u51.Main
        if typeof(v53) == "ColorSequence" then
            trailThing(u50, u46, u51.Main, u48, u49, u47)
        else
            trailThing(u50, u46, ColorSequence.new(u51.Main), u48, u49, u47)
        end
    end)
    task.spawn(function() --[[ Line: 95 ]]
        --[[
        Upvalues:
            [1] = u50
            [2] = u46
            [3] = u51
            [4] = u48
            [5] = u49
            [6] = u47
            [7] = u52
        --]]
        trailThing(u50, u46, ColorSequence.new(u51.Side), u48, u49, u47, u52)
        _G.destroy(u52, 1)
    end)
    return u52
end