 

local v1 = {}
game:GetService("TweenService")
function v1.start(_, p2, p3) --[[ Line: 6 ]]
    if _G.checkRenderDistance(p2.Position) then
        local v4 = CFrame.new(p2.Position, p3)
        for _, v5 in p2:GetChildren() do
            if v5:IsA("ParticleEmitter") then
                v5.Enabled = false
                v5:Clear()
            end
        end
        p2.Transparency = 1
        p2.Sparkles.Speed = NumberRange.new(5, 50)
        p2.Sparkles:Emit(12)
        _G.PlaySound(p2, script.NoobShoot)
        _G.PlaySound(p2, script.Woosh)
        local v6 = script.Shoot:Clone()
        v6:PivotTo(v4)
        v6.Parent = workspace.Effects
        _G.tween(v6.Ring, {
            0.8,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v6.Ring.CFrame * CFrame.new(0, 10, 0),
            ["Size"] = Vector3.new(25, 0, 25),
            ["Transparency"] = 1
        })
        _G.tween(v6.Ring2, {
            0.9,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v6.Ring2.CFrame * CFrame.new(0, -10, 0),
            ["Size"] = Vector3.new(10, 0, 10),
            ["Transparency"] = 1
        })
        _G.tween(v6.Shock, {
            0.2,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v6.Shock.CFrame * CFrame.new(10, 0, 0),
            ["Size"] = Vector3.new(20, 9, 9),
            ["Transparency"] = 1
        })
        _G.tween(v6.SwirlLinger, {
            1.4,
            "FabricDecelerate",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v6.SwirlLinger.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, -1.51, 0),
            ["Size"] = Vector3.new(5, 40, 5),
            ["Transparency"] = 1
        })
        _G.destroy(v6, 2)
    end
end
return v1