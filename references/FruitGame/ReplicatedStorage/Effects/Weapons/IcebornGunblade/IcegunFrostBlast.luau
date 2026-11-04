 

local v1 = {}
game:GetService("Players")
game:GetService("TweenService")
local u2 = workspace.Effects
function v1.start(_, u3, u4) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if typeof(u3) == "CFrame" then
        local v5 = script.Model:Clone()
        v5:ScaleTo(u4)
        local v6 = v5.Start_FX
        v6.CFrame = u3
        v6.Parent = u2
        _G.destroy(v6, 5)
        _G.customEmit(v6)
        if u4 < 2.5 then
            _G.PlaySound(u3, script.IceGunbladeBlastShoot)
        else
            _G.PlaySound(u3, script.IceGunbladeBlastMaxCharge)
        end
        task.wait(0.12)
        local v7 = v5.Push_FX
        v7.CFrame = u3
        v7.Parent = u2
        _G.destroy(v7, 5)
        _G.customEmit(v7)
        v5:Destroy()
    else
        local _ = u3.HumanoidRootPart
        task.spawn(function() --[[ Line: 66 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u2
                [3] = u3
            --]]
            local v8 = u4.Weapon
            if v8 then
                local v9 = v8:WaitForChild("Muzzle")
                local v10 = script.Energy_Condenced:Clone()
                local v11 = Instance.new("Weld")
                v11.Part0 = v9
                v11.Part1 = v10
                v11.Parent = v10
                v10.Parent = u2
                local u12 = false
                local v13 = {
                    ["startScale"] = 1,
                    ["endScale"] = 0.2,
                    ["customEnd"] = function() --[[ Name: customEnd, Line 94 ]]
                        --[[
                        Upvalues:
                            [1] = u12
                        --]]
                        return u12
                    end
                }
                _G.PlayEffect("TweenParticlesScale", nil, v10, v13, 3)
                local v14 = script.IceGunbladeBlastCharge:Clone()
                v14.Parent = u3.PrimaryPart
                v14:Play()
                local v15 = tick()
                local v16 = false
                while u3:GetAttribute("holdingGunBlast") ~= nil do
                    if tick() - v15 >= 2 and v16 == false then
                        _G.PlaySound(u3.PrimaryPart, script.IceGunbladeMaxCharge)
                        local v17 = Instance.new("Highlight")
                        v17.DepthMode = Enum.HighlightDepthMode.Occluded
                        v17.FillColor = Color3.fromRGB(255, 255, 255)
                        v17.FillTransparency = 0
                        v17.OutlineTransparency = 1
                        v17.Parent = u3
                        _G.tween(v17, { 0.5, "Cubic", Enum.EasingDirection.Out }, {
                            ["FillTransparency"] = 1
                        })
                        _G.destroy(v17, 0.5)
                        v16 = true
                    end
                    task.wait()
                end
                u12 = true
                _G.PlayEffect("TweenParticles", nil, v10, NumberSequence.new(0), 0.2)
                _G.destroy(v10, 0.2)
                _G.tween(v14, {
                    0.25,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0
                })
                _G.destroy(v14, 0.25)
            end
        end)
    end
end
return v1