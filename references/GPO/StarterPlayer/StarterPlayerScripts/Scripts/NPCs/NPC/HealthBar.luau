 

local u1 = {}
local u2 = {}
function u1.addBar(_, u3, u4) --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    task.spawn(function() --[[ Line: 4 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u1
            [4] = u4
        --]]
        if u2[u3] ~= nil then
            u2[u3]:Destroy()
            u2[u3] = nil
        end
        local v5 = script.Parent.NPCAnimation.Overhead:Clone()
        v5.Name = u3.Name
        v5.NameT.Text = u3.Name
        v5.Health.Frame.Script.char.Value = u3
        v5.Health.Frame.Script.Disabled = false
        v5.Parent = game.Players.LocalPlayer.PlayerGui.HealthBars
        u2[u3] = v5
        if game.Players:GetPlayerFromCharacter(u3) ~= nil then
            local u6 = nil
            u6 = u3.AncestryChanged:Connect(function() --[[ Line: 20 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u6
                    [3] = u1
                --]]
                if u3.Parent == workspace.Effects then
                    u6:Disconnect()
                    u6 = nil
                    u1:removeBar(u3)
                end
            end)
        end
        if u4 == nil then
            u3.ChildAdded:Connect(function(p7) --[[ Line: 30 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u3
                --]]
                if p7.Name == "Head" then
                    u1:addBar(u3, true)
                end
            end)
        end
        u3.Destroying:Connect(function() --[[ Line: 37 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u3
            --]]
            u1:removeBar(u3)
        end)
        local v8 = u3:WaitForChild("Head", 100000000000)
        if v8 == nil then
            u1:removeBar(u3)
        else
            if v8:FindFirstChild("Overhead") then
                v8:FindFirstChild("Overhead"):Destroy()
            end
            local v9 = Instance.new("ObjectValue", v8)
            v9.Name = "Overhead"
            v9.Value = v5
            v5.Adornee = v8
        end
    end)
end
function u1.removeBar(_, p10) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2[p10] ~= nil then
        u2[p10]:Destroy()
        u2[p10] = nil
    end
end
local u11 = 0
game["Run Service"].Heartbeat:Connect(function() --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u2
        [3] = u1
    --]]
    u11 = u11 + 1
    if u11 >= 5 then
        u11 = 0
        local v12 = workspace.CurrentCamera.CFrame.Position
        for v13, v14 in pairs(u2) do
            if v13 and v13.Parent ~= nil then
                local v15 = v13.PrimaryPart
                if v15 then
                    if (v12 - v15.Position).Magnitude <= 30 then
                        if v13:FindFirstChild("Head") then
                            local v16 = v13:FindFirstChild("Suke")
                            if v16 and v16:IsA("Tool") == false or v13:GetAttribute("hideOverhead") ~= nil then
                                v14.Enabled = false
                            else
                                v14.Enabled = true
                            end
                        end
                    else
                        v14.Enabled = false
                    end
                end
            else
                u1:removeBar(v13)
            end
        end
    end
end)
return u1