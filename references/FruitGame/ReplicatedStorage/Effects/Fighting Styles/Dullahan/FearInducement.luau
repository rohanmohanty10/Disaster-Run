 

local u1 = Random.new()
local u2 = game:GetService("TweenService")
local u3 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
return {
    ["start"] = function(_, u4, u5, p6) --[[ Name: start, Line 29 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u1
        --]]
        local u7 = p6 or game.Players.LocalPlayer.Character
        if _G.checkRenderDistance(u4.Position) ~= false then
            local u8 = 60 / _G.FPS
            local u9 = script.ScareEffect:Clone()
            u3.apply(u9, u7)
            u9.Position = u4.Position
            task.spawn(function() --[[ Line: 40 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u2
                --]]
                local v10 = u9.LightAttachment.PointLight
                local v11 = v10.Range
                v10.Range = 0
                u2:Create(v10, TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    ["Range"] = v11
                }):Play()
                task.wait(0.05)
                u2:Create(v10, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    ["Brightness"] = 0
                }):Play()
            end)
            u9.Parent = workspace.Effects
            local v12 = next
            local v13, v14 = u9:GetDescendants()
            for _, v15 in v12, v13, v14 do
                if v15:IsA("ParticleEmitter") then
                    _G.customEmit(v15)
                end
            end
            task.delay(2, u9.Destroy, u9)
            task.delay(0.2, function() --[[ Line: 68 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u7
                    [3] = u4
                    [4] = u1
                    [5] = u5
                    [6] = u8
                --]]
                for _ = 1, 6 do
                    task.spawn(function() --[[ Line: 70 ]]
                        --[[
                        Upvalues:
                            [1] = u3
                            [2] = u7
                            [3] = u4
                            [4] = u1
                            [5] = u5
                            [6] = u8
                        --]]
                        local v16 = script.Bezier:Clone()
                        u3.apply(v16, u7)
                        local v17 = u4.Position
                        local v18 = (u4 * CFrame.new(u1:NextNumber(-25, 25), u1:NextNumber(5, 10), -u1:NextNumber(0, 25))).Position
                        local v19 = (u5.UpperTorso.CFrame * CFrame.new(0, 0, -2)).Position
                        v16.Position = v17
                        v16.Parent = workspace.Effects
                        for v20 = 0, 1, 0.07 * u8 do
                            local v21 = v17 + (v18 - v17) * v20
                            v16.Position = v21 + (v18 + (v19 - v18) * v20 - v21) * v20
                            task.wait(1 / _G.FPS)
                        end
                        v16.Position = v19
                        _G.customEmit(v16)
                        task.wait(2)
                        v16:Destroy()
                    end)
                    task.wait(u1:NextNumber(0.05, 0.125))
                end
            end)
            if (workspace.CurrentCamera.CFrame.Position - u9.Position).Magnitude <= 50 then
                local v22 = script.DarkColorCorrection:Clone()
                local v23 = v22.TintColor
                v22.TintColor = Color3.new(1, 1, 1)
                v22.Parent = game:GetService("Lighting")
                u2:Create(v22, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["TintColor"] = v23
                }):Play()
                task.wait(0.2)
                u2:Create(v22, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    ["TintColor"] = Color3.new(1, 1, 1)
                }):Play()
            end
        end
    end
}