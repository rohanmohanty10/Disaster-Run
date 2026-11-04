 

game:GetService("TweenService")
game:GetService("Debris")
Random.new()
return {
    ["start"] = function(_, u1, u2, u3, u4) --[[ Name: start, Line 8 ]]
        local u5 = nil
        u5 = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 11 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u5
                [3] = u1
                [4] = u2
                [5] = u4
            --]]
            if u3 == nil or u3 and u3:IsDescendantOf(game) == false then
                u5:Disconnect()
                u5 = nil
            else
                u1.CFrame = CFrame.new(u2.Position, (u4.CFrame * CFrame.new(0, 0, -1000)).Position) * CFrame.new(0, 0, -3)
            end
        end)
    end
}