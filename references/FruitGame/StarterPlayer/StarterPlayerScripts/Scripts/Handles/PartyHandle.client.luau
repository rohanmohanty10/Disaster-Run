 

repeat
    task.wait()
until game.Players.LocalPlayer
local u1 = game.Players.LocalPlayer
u1:WaitForChild("Party")
local u2 = {}
local u3 = 0
local u4 = u1.PlayerGui:WaitForChild("globalFeed"):WaitForChild("partyMembers")
local function u7() --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v5 = u4:GetChildren()
    for v6 = 1, #v5 do
        if v5[v6]:IsA("Frame") then
            v5[v6]:Destroy()
        end
    end
end
game["Run Service"].Heartbeat:Connect(function() --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u7
        [5] = u4
    --]]
    local v8
    if u1.Party.Value == nil then
        v8 = nil
    else
        v8 = game.ReplicatedStorage.currentParty:FindFirstChild(u1.Party.Value.Name)
    end
    local v9 = u2
    local v10 = 0
    for _, _ in pairs(v9) do
        v10 = v10 + 1
    end
    if v10 > 0 and v8 ~= nil then
        for u11, v12 in u2 do
            if v8:FindFirstChild(v12.Name) == nil or game.Players:FindFirstChild(v12.Name) == nil then
                pcall(function() --[[ Line: 34 ]]
                    --[[
                    Upvalues:
                        [1] = u11
                    --]]
                    u11:Destroy()
                end)
                u2[u11] = nil
            end
        end
    end
    if tick() - u3 >= 1 then
        u3 = tick()
        if u1.Party.Value == nil then
            local v13 = u2
            local v14 = 0
            for _, _ in pairs(v13) do
                v14 = v14 + 1
            end
            if v14 > 0 then
                for u15, _ in u2 do
                    pcall(function() --[[ Line: 109 ]]
                        --[[
                        Upvalues:
                            [1] = u15
                        --]]
                        u15:Destroy()
                    end)
                    u2[u15] = nil
                end
                u7()
                table.clear(u2)
            end
        else
            local _ = u1.Party.Value
            if v8 == nil then
                u7()
                return
            end
            local u16 = v8:GetChildren()
            for u17 = 1, #u16 do
                local v18 = game.Players:FindFirstChild(u16[u17].Name)
                local v19 = u16[u17]
                if v18 then
                    local v20 = v18.Character
                    if v20 and v20 ~= game.Players.LocalPlayer.Character then
                        local v21 = game.Players.LocalPlayer.PlayerGui.HealthBars:FindFirstChild(v18.Name .. "PartyCircle")
                        if v21 == nil then
                            local u22 = script.PartyCircle:Clone()
                            u22.targetPlayer.Value = v18
                            u22.Name = v18.Name .. "PartyCircle"
                            u22.Parent = game.Players.LocalPlayer.PlayerGui.HealthBars
                            u22.LocalScript.Disabled = false
                            task.spawn(function() --[[ Line: 71 ]]
                                --[[
                                Upvalues:
                                    [1] = u16
                                    [2] = u17
                                    [3] = u22
                                --]]
                                local v23 = u16[u17]:WaitForChild("playerColor", 10)
                                if v23 ~= nil then
                                    u22.Frame.BackgroundColor3 = v23.Value
                                    u22.Frame.UIGradient.Color = ColorSequence.new(v23.Value)
                                end
                            end)
                            u2[u22] = v18
                        else
                            v21.targetPlayer.Value = v18
                        end
                        if u4 ~= nil and (u4:FindFirstChild(v18.Name) == nil and v19:FindFirstChild("playerColor")) then
                            local v24 = script.Health:Clone()
                            v24.Name = v18.Name
                            v24.Bars.LocalScript.char.Value = v20
                            v24.TextLabel.Text = v18.Name
                            v24.playerColor.BackgroundColor3 = v19.playerColor.Value
                            v24.Parent = u4
                            v24.Bars.LocalScript.Disabled = false
                        end
                    end
                end
            end
            if v8 then
                local v25 = u4:GetChildren()
                for v26 = 1, #v25 do
                    if v25[v26]:IsA("Frame") and v8:FindFirstChild(string.gsub(v25[v26].Name, "PartyCircle", "")) == nil then
                        v25[v26]:Destroy()
                    end
                end
                return
            end
        end
    end
end)