 

return {
    ["start"] = function(_, u1, _) --[[ Name: start, Line 3 ]]
        task.spawn(function() --[[ Line: 4 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v2 = workspace.Effects:WaitForChild(u1.Name .. "IceBike", 3)
            while u1.PrimaryPart ~= nil do
                _G.PlayEffect("FloorFreeze", nil, u1.HumanoidRootPart.CFrame * CFrame.new(0, 1, -4), u1.Humanoid.HipHeight * 2, 8, 10)
                game["Run Service"].Heartbeat:Wait()
                if v2 == nil or v2 and v2.Parent == nil then
                    break
                end
            end
        end)
    end
}