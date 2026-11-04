 

local v1 = {}
local u2 = game:GetService("RunService").Heartbeat
function v1.start(_, p3, p4, p5) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.HumanoidRootPart.Position) then
        _G.PlaySound(p3.HumanoidRootPart, script.Rocket)
        _G.PlaySound(p3.HumanoidRootPart, script.Woosh)
        local v6 = p4 * 0.5
        local u7 = script.pistol:Clone()
        u7:PivotTo(p3.HumanoidRootPart.CFrame)
        if p5 and p3 ~= game.Players.LocalPlayer.Character then
            u7:PivotTo(p5)
        end
        u7.Parent = workspace.Effects
        _G.tween(u7.Ring, {
            0.4,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u7.Ring.CFrame * CFrame.new(0, -9, 0),
            ["Size"] = Vector3.new(14, 0, 14),
            ["Transparency"] = 1
        })
        _G.tween(u7.Sharp, {
            0.2,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u7.Sharp.CFrame * CFrame.new(-v6, 0, 0),
            ["Size"] = Vector3.new(v6, 0, 0),
            ["Transparency"] = 1
        })
        _G.tween(u7.Shock, {
            0.1,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u7.Shock.CFrame * CFrame.new(10, 0, 0),
            ["Size"] = Vector3.new(20, 9, 9),
            ["Transparency"] = 1
        })
        _G.destroy(u7, 1)
        spawn(function() --[[ Line: 26 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u2
            --]]
            local v8 = u7.SwooshA
            local v9 = u7.SwooshB
            for v10 = 0, 1.2, 0.1 do
                v8.Mesh.Scale = v8.Mesh.Scale + Vector3.new(0.2, 0.2, 0.2)
                v9.Mesh.Scale = v8.Mesh.Scale + Vector3.new(1, 1, 1)
                v8.Decal.Transparency = v10
                v9.Decal.Transparency = v10
                v8.CFrame = v8.CFrame * CFrame.Angles(0, 0.6, 0)
                v9.CFrame = v9.CFrame * CFrame.Angles(0, -0.4, 0)
                u2:Wait()
            end
        end)
    end
end
return v1