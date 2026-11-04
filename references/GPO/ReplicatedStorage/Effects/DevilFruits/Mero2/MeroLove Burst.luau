 

game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v1 = game:GetService("Players")
game:GetService("TweenService")
local _ = v1.LocalPlayer
local _ = workspace.Effects
return {
    ["start"] = function(_, p2, p3) --[[ Name: start, Line 28 ]]
        if _G.checkRenderDistance(p2.PrimaryPart.Position) ~= false then
            local v4 = script.Shoot:Clone()
            v4.CFrame = p2.PrimaryPart.CFrame
            v4.Parent = workspace.Effects
            _G.customEmit(v4)
            _G.destroy(v4, 3)
            for v5 = 1, #p3 do
                local v6 = p3[v5].EndCFrame
                local v7 = p3[v5].StartCFrame
                local v8 = p3[v5].Speed
                local u9 = p3[v5].HitGround
                local u10 = script.Arrow:Clone()
                u10.CFrame = v7
                u10.Parent = workspace.Effects
                local v11 = u9 == nil and 1 or 0
                local v12 = _G.tween
                local v13 = {
                    v8,
                    Enum.EasingStyle.Linear,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v14 = {}
                local v15 = CFrame.Angles
                local v16 = math.random(0, 360)
                v14.CFrame = v6 * v15(0, math.rad(v16), 0)
                v14.Transparency = v11
                v12(u10, v13, v14)
                _G.PlaySound(u10, script["Audio/Mero2ArrowsShoot"], {
                    ["Pitch"] = math.random(90, 110) / 100
                }).Parent = u10
                task.delay(v8, function() --[[ Line: 54 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                        [2] = u9
                    --]]
                    _G.destroy(u10, 3)
                    if u9 ~= nil then
                        _G.PlaySound(u10, script.ArrowHitGround, {
                            ["Pitch"] = math.random(90, 110) / 100
                        })
                        local v17 = script.Part:Clone()
                        v17.CFrame = CFrame.new(u9)
                        v17.Parent = workspace.Effects
                        _G.customEmit(v17)
                        _G.destroy(v17, 2)
                        task.wait(1)
                        _G.tween(u10, {
                            1,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Transparency"] = 1
                        })
                    end
                end)
            end
        end
    end
}