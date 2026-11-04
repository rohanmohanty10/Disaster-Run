 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 7 ]]
        if _G.checkRenderDistance(p2.Position) then
            local v4 = p3 / 50
            local v5 = math.floor(v4)
            local v6 = v5 < 1 and 1 or v5
            local v7 = v6 >= 25 and 25 or v6
            if (p1.HumanoidRootPart.Position - p2.Position).Magnitude <= 200 then
                local u8 = 1
                local u9 = 0.1
                for v10 = 1, v7 do
                    task.wait()
                    local u11 = script.Orb:Clone()
                    local v12 = CFrame.Angles
                    local v13 = math.random(-360, 360)
                    local v14 = math.rad(v13)
                    local v15 = math.random(-360, 360)
                    local v16 = math.rad(v15)
                    local v17 = math.random(-360, 360)
                    u11.CFrame = p2 * v12(v14, v16, (math.rad(v17)))
                    u11.Rocket.Target = p1.HumanoidRootPart
                    if v10 % 2 == 0 then
                        u11.Color = Color3.fromRGB(239, 184, 56)
                    end
                    u11.Trail.Color = ColorSequence.new(u11.Color)
                    local v18 = math.random(-75, 75)
                    local v19 = math.random(25, 75)
                    local v20 = math.random
                    u11.Velocity = Vector3.new(v18, v19, v20(-75, 75))
                    u11.Rocket.MaxSpeed = math.random(75, 125)
                    u11.Parent = workspace.Effects
                    task.spawn(function() --[[ Line: 36 ]]
                        --[[
                        Upvalues:
                            [1] = u11
                            [2] = u8
                            [3] = u9
                        --]]
                        task.wait(0.2)
                        if u11:FindFirstChild("Rocket") then
                            u11.Rocket:Fire()
                        end
                        local u21 = nil
                        u21 = u11.Rocket.ReachedTarget:Connect(function() --[[ Line: 43 ]]
                            --[[
                            Upvalues:
                                [1] = u11
                                [2] = u8
                                [3] = u9
                                [4] = u21
                            --]]
                            u11.Trail.Enabled = false
                            u11.Transparency = 1
                            u11.sfx.Pitch = u8
                            u11.sfx.Volume = u9
                            u11.sfx:Play()
                            u21:Disconnect()
                            u21 = nil
                            u9 = u9 + 0.05
                            u8 = u8 + 0.01
                            _G.destroy(u11, 2)
                        end)
                    end)
                end
            end
        else
            return
        end
    end
}