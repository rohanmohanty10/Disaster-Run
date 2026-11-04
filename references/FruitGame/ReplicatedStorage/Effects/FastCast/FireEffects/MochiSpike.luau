 

local v1 = {}
local _ = _G.getHumanoid
function v1.impact(u2, p3, p4, _, p5) --[[ Line: 7 ]]
    if p3 then
        u2.shard.Color = ColorSequence.new(p3.Color)
        u2.flour.Color = ColorSequence.new(p3.Color)
        u2.flour2.Color = ColorSequence.new(p3.Color)
        local v6 = CFrame.new(p4, p5.startpos) * CFrame.new(0, 0, -u2.Size.Y / 3)
        local v7 = CFrame.Angles
        local v8 = math.random(-360, 360)
        u2.CFrame = v6 * v7(1.5707963267948966, math.rad(v8), 0)
        task.delay(0.1, function() --[[ Line: 16 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            u2["0"]["2"].Enabled = false
            u2["0"].Trail.Enabled = false
            u2["01"]["2"].Enabled = false
            _G.tween(u2, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
        end)
        if p4.Y > workspace.Env.WaterStuff.Sand.Position.Y - 1 then
            u2.Anchored = false
            local v9 = Instance.new("WeldConstraint")
            v9.Part0 = p3
            v9.Part1 = u2
            v9.Parent = u2
        end
        _G.Emit(u2, true)
        _G.PlaySound(u2, script.Sounds.HitGround:GetChildren()[math.random(1, 3)], {
            ["Pitch"] = math.random(90, 110) / 100
        })
    end
    _G.destroy(u2.Parent, 3)
end
function v1.splash(p10, p11) --[[ Line: 41 ]]
    _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Splash]:start({
        ["obj"] = p10,
        ["Strength"] = 25,
        ["Size"] = 7,
        ["cf"] = p11,
        ["PSize"] = NumberSequence.new(2, 0)
    })
end
function v1.Fire(_, _, p12, p13) --[[ Line: 46 ]]
    p12.Size = p12.Size * 0.75
    p12.CFrame = p13
    _G.PlaySound(p12.CFrame, script.Sounds.Shoot:GetChildren()[math.random(1, 3)])
    _G.Emit(p12.Attachment, true)
end
function v1.whiz(p14) --[[ Line: 54 ]]
    if p14 == nil then
        return true
    end
end
return v1