 

local v1 = {}
function lookAt(p2, p3)
    local v4 = (p3 - p2).Unit
    local v5 = v4:Cross(Vector3.new(0, 1, 0))
    local v6 = v5:Cross(v4)
    return CFrame.fromMatrix(p2, v5, v6)
end
function v1.start(_, p7, p8, p9) --[[ Line: 14 ]]
    if _G.checkRenderDistance(p7.PrimaryPart.Position) == false then
        return
    else
        local u10 = {}
        local u11 = {}
        while true do
            for v12, v13 in u10 do
                if v12.IsPlaying == false and v12.Looped == true then
                    v13:Stop()
                    u10[v12] = nil
                end
            end
            local u14 = p7.Humanoid:GetPlayingAnimationTracks()
            for u15 = 1, #u14 do
                if u14[u15].IsPlaying == true and u10[u14[u15]] == nil then
                    local u16 = p8.Humanoid:LoadAnimation(u14[u15].Animation)
                    u16:Play()
                    u16:AdjustWeight(u14[u15].WeightTarget)
                    u16:AdjustSpeed(0)
                    u10[u14[u15]] = u16
                    local u17 = nil
                    local u18 = nil
                    u17 = u10[u14[u15]].Stopped:Connect(function() --[[ Line: 38 ]]
                        --[[
                        Upvalues:
                            [1] = u17
                            [2] = u18
                            [3] = u16
                            [4] = u10
                            [5] = u14
                            [6] = u15
                        --]]
                        u17:Disconnect()
                        u18:Disconnect()
                        u16:Stop()
                        u10[u14[u15]] = nil
                    end)
                    u18 = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 44 ]]
                        --[[
                        Upvalues:
                            [1] = u16
                            [2] = u14
                            [3] = u15
                            [4] = u17
                        --]]
                        u16.TimePosition = u14[u15].TimePosition
                        if u14[u15].Looped == false and u16.TimePosition >= u16.Length then
                            u16:Stop(0.25)
                            u17:Disconnect()
                        end
                    end)
                    local v19 = u17
                    table.insert(u11, v19)
                    local v20 = u18
                    table.insert(u11, v20)
                end
            end
            local v21 = p7.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1000)
            if p8.PrimaryPart then
                local v22 = v21.X + 0.001
                local v23 = p8.PrimaryPart.Position.Y
                local v24 = v21.Z
                local v25 = Vector3.new(v22, v23, v24)
                p8.PrimaryPart.CFrame = p8.PrimaryPart.CFrame:Lerp(CFrame.new(p8.PrimaryPart.Position, v25), 0.1)
            end
            task.wait()
            if p9 == nil or p9 and p9:IsDescendantOf(game) == false then
                for _ = 1, #u11 do
                    pcall(function() --[[ Line: 66 ]]
                        --[[
                        Upvalues:
                            [1] = u11
                        --]]
                        u11:Disconnect()
                    end)
                end
                table.clear(u11)
                return
            end
        end
    end
end
return v1