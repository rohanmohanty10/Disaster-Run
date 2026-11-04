 

local v1 = {}
game:GetService("PhysicsService")
function v1.impact(p2, p3, p4, _, _) --[[ Line: 4 ]]
    if p3 then
        p2.CFrame = CFrame.new(p4)
        _G.PlaySound(p2, script["snowball impact"])
        local v5 = p2.CFrame
        for _ = 1, math.random(4, 6) do
            local u6 = script.Part:Clone()
            u6.Parent = workspace.Effects
            local v7 = math.random(50, 75) / 100
            u6.Size = Vector3.new(v7, v7, v7)
            u6.CFrame = CFrame.new(v5.p) * CFrame.new(0, 1, 0)
            local v8 = math.random(-25, 25)
            local v9 = math.random(25, 35)
            local v10 = math.random
            u6.Velocity = Vector3.new(v8, v9, v10(-25, 25))
            u6.CollisionGroup = "NPC"
            task.spawn(function() --[[ Line: 21 ]]
                --[[
                Upvalues:
                    [1] = u6
                --]]
                task.wait()
                _G.tween(u6.Mesh, {
                    1,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = Vector3.new(0, 0, 0)
                })
                _G.tween(u6, {
                    1,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0, 0, 0)
                })
                _G.destroy(u6, 1)
            end)
        end
    end
    p2.Parent:Destroy()
end
function v1.splash(p11, p12) --[[ Line: 34 ]]
    _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Splash]:start({
        ["obj"] = p11,
        ["Strength"] = 25,
        ["Size"] = 7,
        ["cf"] = p12,
        ["PSize"] = NumberSequence.new(2, 0)
    })
end
function v1.Fire(_, _, p13) --[[ Line: 39 ]]
    local v14 = script.throw:Clone()
    v14.Parent = p13
    v14:Play()
end
function v1.whiz(p15) --[[ Line: 46 ]]
    if p15 == nil then
        return true
    end
end
return v1