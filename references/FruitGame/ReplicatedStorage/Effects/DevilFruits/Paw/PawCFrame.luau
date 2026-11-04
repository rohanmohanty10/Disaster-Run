 

return {
    ["start"] = function(_, p1, u2, _, u3, _) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(u2.PrimaryPart.Position) ~= false then
            local u4 = _G.awaitObject(p1)
            local u5 = nil
            local u6 = u2.Humanoid:LoadAnimation(script.shrink)
            u6:Play()
            u6:AdjustSpeed(0)
            local u7 = false
            u5 = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 16 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u5
                    [3] = u6
                    [4] = u3
                    [5] = u2
                    [6] = u7
                --]]
                if u4:IsDescendantOf(workspace) == false or u4 and u4.Name == "done" then
                    u5:Disconnect()
                    u5 = nil
                    u6:Stop()
                else
                    u6.TimePosition = 1.33 * (1 - u4.Size.X / u3.X)
                    u4.CFrame = u2.PrimaryPart.CFrame * CFrame.new(0, u4.Size.Y / 2 + 2.75, 0)
                    if u7 == false then
                        u7 = true
                        u4.Start.WorldCFrame = u4.CFrame * CFrame.new(0, u3.Y / 2, 0)
                        _G.customEmit(u4.Start)
                    end
                end
            end)
        end
    end
}