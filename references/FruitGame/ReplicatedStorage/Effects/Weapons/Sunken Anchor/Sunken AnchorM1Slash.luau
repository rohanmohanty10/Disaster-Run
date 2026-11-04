 

local _ = script
game:GetService("ReplicatedStorage")
return {
    ["start"] = function(_, p1, p2, _, p3) --[[ Name: start, Line 6 ]]
        local u4 = p3 == true and "Dash" or p1
        local v5 = script.Slashes:FindFirstChild(u4)
        if v5 then
            local u6 = v5:Clone()
            u6.CFrame = p2.CFrame
            u6.Parent = p2
            local v7 = u6:GetDescendants()
            for v8 = 1, #v7 do
                if v7[v8]:IsA("Beam") then
                    _G.tween(v7[v8], {
                        0.2,
                        Enum.EasingStyle.Quad,
                        "Out",
                        0,
                        false,
                        0
                    }, {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    })
                end
            end
            local u9 = 1500
            if u6:GetAttribute("negitive") ~= nil then
                u9 = -u9
            end
            local u19 = game["Run Service"].Heartbeat:Connect(function(p10) --[[ Line: 28 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u6
                    [3] = u9
                --]]
                if u4 == "5" or (u4 == "Air-5" or u4 == "Air-4") then
                    local v11 = u6
                    local v12 = v11.CFrame
                    local v13 = CFrame.Angles
                    local v14 = u9 * p10
                    v11.CFrame = v12 * v13(math.rad(v14), 0, 0)
                else
                    local v15 = u6
                    local v16 = v15.CFrame
                    local v17 = CFrame.Angles
                    local v18 = u9 * p10
                    v15.CFrame = v16 * v17(0, math.rad(v18), 0)
                end
            end)
            task.delay(0.4, function() --[[ Line: 36 ]]
                --[[
                Upvalues:
                    [1] = u19
                --]]
                u19:Disconnect()
                u19 = nil
            end)
            _G.destroy(u6, 3)
            local v20 = script.Slashes3:FindFirstChild(u4):Clone()
            v20.Parent = p2
            _G.customEmit(v20)
            _G.destroy(v20, 3)
        else
            warn("cant find slashPart")
        end
    end
}