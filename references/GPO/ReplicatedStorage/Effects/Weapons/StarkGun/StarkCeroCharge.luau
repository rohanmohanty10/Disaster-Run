 

return {
    ["start"] = function(_, u1, u2, u3, p4) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p4.Position) ~= false then
            local u5 = u1:GetScale()
            local u6 = nil
            u6 = game["Run Service"].Heartbeat:Connect(function(_) --[[ Line: 9 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u5
                    [3] = u3
                    [4] = u2
                    [5] = u6
                --]]
                if u1:IsDescendantOf(game) then
                    local v7 = u5 - u5 * ((workspace:GetServerTimeNow() - u3) / u2)
                    u1:ScaleTo((math.clamp(v7, 0.01, 1)))
                else
                    u6:Disconnect()
                    u6 = nil
                end
            end)
        end
    end
}