 

return {
    ["start"] = function(_, p1, u2, u3, u4, u5, u6) --[[ Name: start, Line 3 ]]
        local u7 = game.Players.LocalPlayer
        local u8 = nil
        if u5 == nil then
            local v9 = workspace.CurrentCamera
            table.insert(u2, v9)
        end
        local function u14(p10) --[[ Line: 9 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u2
            --]]
            local v11 = u5 == nil
            for v12 = 1, #u2 do
                local v13
                if u2[v12] == nil then
                    v13 = nil
                elseif u5 == nil then
                    v13 = p10:IsDescendantOf(u2[v12])
                else
                    v13 = p10:IsDescendantOf(u2[v12].Parent)
                end
                if v13 == true and u5 == nil then
                    return false
                end
                if v13 == false and u5 ~= nil then
                    v11 = false
                elseif v13 == true and u5 ~= nil then
                    return true
                end
            end
            return v11
        end
        local u15 = _G.awaitObject(p1)
        local _ = u15.Touched:Connect(function(p16) --[[ Line: 36 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u7
                [3] = u8
                [4] = u6
                [5] = u15
                [6] = u3
                [7] = u4
            --]]
            if u14(p16) == true and (p16.Transparency ~= 1 or (p16.Name == "HumanoidRootPart" or p16.Parent:FindFirstChild("Humanoid"))) then
                if u7.Character ~= nil and p16:IsDescendantOf(u7.Character) then
                    return
                end
                u8:Disconnect()
                u8 = nil
                if u6 == nil then
                    u15.Anchored = true
                end
                u3:FireServer(u15, u15.CFrame, p16)
                if u4 then
                    _G.clientimpacts[game.ReplicatedStorage.ClientImpacts:FindFirstChild(u4)]:start({
                        ["obj"] = u15,
                        ["cf"] = u15.CFrame,
                        ["hit"] = p16
                    })
                end
            end
        end)
    end
}