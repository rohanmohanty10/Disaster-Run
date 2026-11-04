 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
return {
    ["start"] = function(_, u3, p4, p5, p6, u7, u8) --[[ Name: start, Line 6 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local u9 = workspace.CurrentCamera
        local v10 = game.Players.LocalPlayer.PlayerGui.UIIndicator
        local u11 = p6 or 1
        local v12 = p4 or Color3.new(1, 1, 1)
        local u13 = script.Frame:Clone()
        u13.ImageColor3 = v12
        u13.Parent = v10
        local u14 = tick()
        local u15 = tick()
        local u16 = u8 and 10000 or (p5 or 10)
        local u17 = nil
        u17 = u1.RenderStepped:Connect(function() --[[ Line: 62 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u16
                [3] = u8
                [4] = u3
                [5] = u17
                [6] = u13
                [7] = u14
                [8] = u2
                [9] = u11
                [10] = u7
                [11] = u9
            --]]
            if u16 > tick() - u15 and not (u8 and u8:GetAttribute("noteDone")) then
                local v18 = u3
                if typeof(v18) ~= "Instance" or u3.Parent then
                    local v19 = u3
                    local v20 = typeof(v19) == "Instance" and u3.Position or u3
                    if tick() - u14 >= 1 then
                        u14 = tick()
                        u2:Create(u13, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Size"] = UDim2.new(u11 * 0.2, 0, u11 * 0.2, 0),
                            ["ImageTransparency"] = 1
                        }):Play()
                        u13.Size = UDim2.new()
                        u13.ImageTransparency = 0
                        if u7 then
                            _G.PlaySound(CFrame.new(v20), script.NotificationTick)
                        end
                    end
                    local v21 = u9.ViewportSize.X
                    local v22 = u9.ViewportSize.Y
                    local v23 = (v21 / 2) ^ 2 + (v22 / 2) ^ 2
                    local v24 = math.sqrt(v23)
                    local v25 = u9.CFrame
                    local v26, v27 = u9:WorldToViewportPoint(v20)
                    local v28 = v26.X
                    local v29 = math.clamp(v28, 0, v21)
                    local v30 = v26.Y
                    local v31 = math.clamp(v30, 0, v22)
                    if v29 ~= v26.X or (v31 ~= v26.Y or not v27) then
                        local v32 = v25:VectorToObjectSpace(v20 - v25.Position)
                        local v33 = Vector2.new(v32.X, v32.Y).Unit
                        local v34 = v33 * v24
                        local v35 = v33.X
                        local v36 = v33.Y
                        math.atan2(v35, v36)
                        local v37 = v34.Y
                        local v38
                        if math.abs(v37) > v22 / 2 then
                            local v39 = v22 / 2 / v33.Y
                            v38 = v33 * math.abs(v39)
                        else
                            local v40 = v21 / 2 / v33.X
                            v38 = v33 * math.abs(v40)
                        end
                        v29 = v21 / 2 + v38.X
                        v31 = v22 / 2 - v38.Y
                    end
                    u13.Position = UDim2.fromOffset(v29, v31)
                    return
                end
            end
            u17:Disconnect()
            u13:Destroy()
        end)
    end
}