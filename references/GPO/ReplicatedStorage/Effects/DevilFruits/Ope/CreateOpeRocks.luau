 

return {
    ["start"] = function(_, u1, p2) --[[ Name: start, Line 3 ]]
        local _ = script
        if _G.checkRenderDistance(p2.Position) then
            local u3 = u1:FindFirstChild("floatingVal")
            task.spawn(function() --[[ Line: 12 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                for _, v4 in pairs(u1:GetChildren()) do
                    if v4:IsA("Model") then
                        local v5 = v4:GetAttribute("incVal")
                        local v6 = v4:GetAttribute("startingCFrame")
                        local v7 = v4:GetAttribute("incMultiplier")
                        local v8, v9, v10 = _G.getRayFloor(v6, 150)
                        local v11 = script.floorPart:Clone()
                        local v12 = v11.Size.X * v5
                        local v13 = v11.Size.Z * v5
                        v11.Size = Vector3.new(v12, 0.05, v13) / 35
                        v11.CFrame = CFrame.new(v9, v9 + v10) * CFrame.Angles(-1.5707963267948966, 0, 0)
                        v11.Parent = workspace.Effects
                        _G.destroy(v11, 1.5)
                        _G.PlaySound(v11, script.OpeTactStart, {
                            ["Pitch"] = math.random(90, 110) / 100,
                            ["RollOffMaxDistance"] = 125 * v7
                        })
                        game:GetService("TweenService"):Create(v11.Decal, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                            ["Transparency"] = 1
                        }, true):Play()
                        for _, v14 in pairs(v11:GetChildren()) do
                            if v14:IsA("ParticleEmitter") then
                                local v15 = {}
                                for _, v16 in ipairs(v14.Size.Keypoints) do
                                    local v17 = NumberSequenceKeypoint.new
                                    local v18 = v16.Time
                                    local v19 = v16.Value * v7
                                    local v20 = v16.Envelope * v7
                                    table.insert(v15, v17(v18, v19, v20))
                                end
                                v14.Size = NumberSequence.new(v15)
                                v14.Speed = NumberRange.new(v14.Speed.Min * v7, v14.Speed.Max * v7)
                                local v21 = v14.Acceleration.X * v7
                                local v22 = v14.Acceleration.Y * v7
                                local v23 = v14.Acceleration.Z * v7
                                v14.Acceleration = Vector3.new(v21, v22, v23)
                                if v14:GetAttribute("recolor") and v8 ~= nil then
                                    v14.Color = ColorSequence.new(v8.Color)
                                end
                            end
                        end
                        for _, v24 in pairs(v11.Attachment:GetChildren()) do
                            local v25 = {}
                            for _, v26 in ipairs(v24.Size.Keypoints) do
                                local v27 = NumberSequenceKeypoint.new
                                local v28 = v26.Time
                                local v29 = v26.Value * v7
                                local v30 = v26.Envelope * v7
                                table.insert(v25, v27(v28, v29, v30))
                            end
                            v24.Size = NumberSequence.new(v25)
                        end
                        _G.customEmit(v11, true)
                    end
                end
            end)
            local u31 = Random.new():NextNumber(0.5, 0.6)
            task.delay(u31, function() --[[ Line: 61 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u31
                --]]
                for _, u32 in pairs(u1:GetChildren()) do
                    if u32:IsA("Model") and u32.PrimaryPart ~= nil then
                        task.spawn(function() --[[ Line: 64 ]]
                            --[[
                            Upvalues:
                                [1] = u32
                                [2] = u31
                            --]]
                            local v33 = u32:GetAttribute("incVal")
                            local v34 = u32.yVal
                            local v35 = u32.zVal
                            local v36 = -0.05 * v33
                            while true do
                                _G.tween(v34, {
                                    u31,
                                    Enum.EasingStyle.Quad,
                                    Enum.EasingDirection.InOut,
                                    0,
                                    false,
                                    0
                                }, {
                                    ["Value"] = v34.Value + v36
                                })
                                _G.tween(v35, {
                                    u31,
                                    Enum.EasingStyle.Quad,
                                    Enum.EasingDirection.InOut,
                                    0,
                                    false,
                                    0
                                }, {
                                    ["Value"] = v35.Value * -1
                                })
                                if 0.005 * v33 < v36 then
                                    v36 = v36 * -0.5
                                else
                                    v36 = v36 * -1
                                end
                                task.wait(u31)
                            end
                        end)
                    end
                end
            end)
            task.spawn(function() --[[ Line: 87 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u1
                --]]
                while u3.Value == true do
                    for _, v37 in pairs(u1:GetChildren()) do
                        if v37:IsA("Model") and v37.PrimaryPart ~= nil then
                            v37:SetPrimaryPartCFrame(v37.startVal.Value * CFrame.new(0, v37.yVal.Value, 0) * v37.setRotateVal.Value * CFrame.new(0, 0, v37.zVal.Value))
                            v37.setRotateVal.Value = v37.setRotateVal.Value * v37.rotateVal.Value
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
}