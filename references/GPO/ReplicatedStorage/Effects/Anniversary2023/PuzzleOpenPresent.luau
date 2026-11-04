 

game:GetService("Players")
local u1 = game:GetService("RunService")
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 7 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v3 = p2.Item.Value
        local v4 = game.ReplicatedStorage.Tools[v3]:Clone()
        local u5
        if v4:IsA("Model") then
            u5 = v4
        else
            u5 = Instance.new("Model")
            v4.Parent = u5
        end
        local v6 = p2:GetPivot()
        local v7 = p2.PrimaryPart.Size.Y / 2 + u5:GetExtentsSize().Y / 2
        local u8 = v6 + Vector3.new(0, v7, 0)
        u5:PivotTo(u8)
        u5.Name = "Model"
        for _, v9 in pairs(u5:GetDescendants()) do
            if v9:IsA("BasePart") then
                v9.Anchored = true
                v9.CanCollide = false
            end
        end
        u5.Parent = p2.Item
        local u14 = u1.Heartbeat:Connect(function(_) --[[ Line: 30 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u8
            --]]
            local v10 = u5
            local v11 = u8
            local v12 = tick()
            local v13 = math.sin(v12)
            v10:PivotTo((v11 + Vector3.new(0, v13, 0)) * CFrame.Angles(0, tick() % 3.141592653589793 * 2, 0))
        end)
        u5.Destroying:Connect(function() --[[ Line: 34 ]]
            --[[
            Upvalues:
                [1] = u14
            --]]
            u14:Disconnect()
            u14 = nil
        end)
    end
}