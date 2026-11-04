 

local v1 = {}
game:GetService("PhysicsService")
local u2 = Random.new()
function v1.start(_, u3, _) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = script.Fx:Clone()
    v4.Parent = workspace.Effects
    v4.CFrame = u3.PrimaryPart.CFrame
    _G.customEmit(v4)
    _G.destroy(v4, 3)
    _G.PlaySound(v4, script.CoinGrip)
    for _ = 1, math.random(7, 8) do
        coroutine.wrap(function() --[[ Line: 15 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u2
            --]]
            local u5 = script.Coin:Clone()
            local v6 = u5:FindFirstChild("shader")
            if v6 then
                local v7 = u3.PrimaryPart.CFrame * CFrame.new(0, 2, 0)
                local v8 = CFrame.Angles
                local v9 = math.random(0, 360)
                local v10 = math.rad(v9)
                local v11 = math.random(0, 360)
                local v12 = math.rad(v11)
                local v13 = math.random(0, 360)
                v6.CFrame = v7 * v8(v10, v12, (math.rad(v13)))
            end
            u5.Parent = workspace.Effects
            local v14 = u2:NextNumber(-15, 15)
            local v15 = math.random(30, 50)
            local v16 = u2
            u5.AssemblyLinearVelocity = Vector3.new(v14, v15, v16:NextNumber(-15, 15))
            local v17 = math.random(-25, 25)
            local v18 = math.random(-25, 25)
            local v19 = math.random
            u5.AssemblyAngularVelocity = Vector3.new(v17, v18, v19(-25, 25))
            task.delay(u2:NextNumber(1, 1.3), function() --[[ Line: 26 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                u5.Trail.Enabled = false
                _G.tween(u5, {
                    0.5,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0.1, 0, 0.1)
                })
                _G.tween(u5.shader, {
                    0.5,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0, 0, 0)
                })
                _G.destroy(u5, 0.5)
            end)
        end)()
    end
end
return v1