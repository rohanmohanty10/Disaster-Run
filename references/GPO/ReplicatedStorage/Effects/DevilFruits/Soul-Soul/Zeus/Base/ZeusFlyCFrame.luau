 

game:GetService("TweenService")
game:GetService("Debris")
Random.new()
return {
    ["start"] = function(_, u1, u2, u3) --[[ Name: start, Line 8 ]]
        if u2 and u3 then
            local u4 = nil
            local u5 = u1.PrimaryPart
            u4 = game["Run Service"].RenderStepped:Connect(function() --[[ Line: 15 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u4
                    [3] = u2
                    [4] = u5
                    [5] = u3
                --]]
                if u1:GetAttribute("ZeusFlying") == nil then
                    u4:Disconnect()
                    u4 = nil
                else
                    local v6 = u2:GetScale() or 1
                    local v7 = u5.CFrame * CFrame.new(0, -3 * v6, 0)
                    u3.CFrame = v7
                    u2:PivotTo(v7)
                end
            end)
        end
    end
}