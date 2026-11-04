 

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
            u3.ChildAdded:Connect(function(p7) --[[ Line: 29 ]]
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
        u3.Destroying:Connect(function() --[[ Line: 36 ]]
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
function u1.removeBar(_, p10) --[[ Line: 56 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2[p10] ~= nil then
        u2[p10]:Destroy()
        u2[p10] = nil
    end
end
game["Run Service"].Heartbeat:Connect(function() --[[ Line: 63 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v11 = workspace.CurrentCamera.CFrame.Position
    for v12, v13 in pairs(u2) do
        if v12 and v12.Parent ~= nil then
            if v12.PrimaryPart and ((v11 - v12.PrimaryPart.Position).Magnitude <= 30 and v12:FindFirstChild("Head")) then
                local v14 = v12:FindFirstChild("Suke")
                if v14 and v14:IsA("Tool") == false or v12:GetAttribute("hideOverhead") ~= nil then
                    v13.Enabled = false
                else
                    v13.Enabled = true
                end
            end
        else
            u1:removeBar(v12)
        end
    end
end)
return u1