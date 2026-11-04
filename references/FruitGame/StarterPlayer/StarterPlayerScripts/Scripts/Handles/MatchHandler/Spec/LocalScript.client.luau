 

game:GetService("Players")
local u1 = workspace.CurrentCamera
local v2 = game:GetService("UserInputService")
local u3 = game:GetService("ReplicatedStorage"):WaitForChild("setReplicationFocus")
local u4 = 0
local u5 = false
local u6 = true
script.Parent.Blackout.Visible = true
local v7 = nil
local u8 = {}
local v9 = game.SoundService:GetChildren()
local u10 = v7
local u11 = {}
local function u35(p12, p13, p14) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v15 = math.floor(p13)
    local v16 = math.floor(p14)
    local v17 = (v15 < 0 and 0 or v15) / v16
    local v18 = p12.bar.Size.X.Scale
    if u8[p12.Name] == nil then
        u8[p12.Name] = 0
    end
    if u8[p12.Name] ~= v17 then
        local v19 = v18 - v17
        local v20 = v17 >= 1 and 1 or v17
        u8[p12.Name] = v20
        local v21 = math.pow(10, 3 or 0)
        local v22 = v20 * v21
        local v23
        if v22 >= 0 then
            local v24 = v22 + 0.5
            v23 = math.floor(v24)
        else
            local v25 = v22 - 0.5
            v23 = math.ceil(v25)
        end
        local v26 = v23 / v21
        local v27 = p12.bar.Size.X.Scale
        local v28 = math.pow(10, 3 or 0)
        local v29 = v27 * v28
        local v30
        if v29 >= 0 then
            local v31 = v29 + 0.5
            v30 = math.floor(v31)
        else
            local v32 = v29 - 0.5
            v30 = math.ceil(v32)
        end
        if v26 ~= v30 / v28 then
            p12.bar:TweenSize(UDim2.new(v20, 0, 1, 0), "Out", "Quad", 0.25, true)
        end
        if v19 > 0 then
            if p12.bar.Parent:FindFirstChild("a") then
                p12.bar.Parent.a:Destroy()
            end
            local v33 = p12.bar:Clone()
            v33.Name = "a"
            v33.ZIndex = 2
            v33.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            v33.Size = UDim2.new(v19, 0, 1, 0)
            v33.Position = UDim2.new(v20, 0, 0.5, 0)
            v33:ClearAllChildren()
            v33.Parent = p12.bar.Parent
            local v34 = v19 + 0.25
            _G.tween(v33, {
                v34,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.In,
                0,
                false,
                0
            }, {
                ["BackgroundTransparency"] = 1,
                ["Size"] = UDim2.new(0, 0, 1, 0)
            })
            _G.destroy(v33, v34)
        end
    end
end
for v36 = 1, #v9 do
    if v9[v36]:IsA("SoundGroup") then
        v9[v36].Volume = 0
    end
end
local function u40(p37) --[[ Line: 113 ]]
    local v38 = script.Parent.ScrollingFrame.ScrollingFrame:GetChildren()
    for v39 = 1, #v38 do
        if v38[v39]:IsA("TextButton") then
            if v38[v39].Name == p37 then
                v38[v39].TextColor3 = Color3.fromRGB(170, 255, 0)
            else
                v38[v39].TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end
    end
end
local function u52() --[[ Line: 126 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v41 = {}
    if game.ReplicatedStorage.reservedCode:GetAttribute("battleRoyale") == nil then
        local v42 = game.Players:GetPlayers()
        for v43 = 1, #v42 do
            local v44 = v42[v43]:FindFirstChild("leaderstats")
            if v44 and v44.Lives.Value >= 0 then
                local v45 = v42[v43]
                table.insert(v41, v45)
            elseif v44 == nil then
                local v46 = v42[v43]
                table.insert(v41, v46)
            end
        end
    else
        local v47 = game.Players:GetPlayers()
        for v48 = 1, #v47 do
            if v47[v48].Team == game.Teams.Players and (game.Players.LocalPlayer.Party.Value == nil or (u6 ~= true or game.Players.LocalPlayer.Party.Value == v47[v48].Party.Value)) then
                local v49 = v47[v48]
                table.insert(v41, v49)
            end
        end
    end
    table.sort(v41, function(p50, p51) --[[ Line: 152 ]]
        return p50.Name < p51.Name
    end)
    return v41
end
local function u70(p53) --[[ Line: 160 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u52
        [3] = u3
        [4] = u1
        [5] = u40
        [6] = u10
        [7] = u11
        [8] = u35
    --]]
    u4 = u4 + 1
    local v54 = u52()
    local u55 = nil
    local function v57(p56) --[[ Line: 169 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
            [3] = u55
        --]]
        if p56 ~= nil then
            _G.requestStream(game.ReplicatedStorage.getPlayerPosition:InvokeServer(p56), 1)
            u3:InvokeServer(p56)
            u1.CameraSubject = p56.Character.Humanoid
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.PrimaryPart then
                if p56 == game.Players.LocalPlayer then
                    if game.ReplicatedStorage.reservedCode:GetAttribute("battleRoyale") == nil then
                        game.Players.LocalPlayer.Character.PrimaryPart.Anchored = false
                    end
                else
                    game.Players.LocalPlayer.Character.PrimaryPart.Anchored = true
                end
            end
            u55 = p56.Name
        end
    end
    local v58
    if p53 == nil then
        v58 = u55
        for v59, v60 in v54 do
            if v59 == u4 then
                v57(v60)
            end
        end
    else
        v57(game.Players:FindFirstChild(p53))
        u55 = p53
        v58 = u55
    end
    if u4 >= #v54 then
        u4 = 0
    end
    if v58 ~= nil then
        u40(v58)
        script.Parent.Frame.TextLabel.Text = "SPECTATING " .. string.upper(v58) .. " [" .. game.Players:FindFirstChild(v58).UserId .. "]"
        u10 = game.Players:FindFirstChild(v58)
        if game.ReplicatedStorage.reservedCode:GetAttribute("battleRoyale") == nil then
            script.Parent.Frame.DMG.Visible = false
        else
            script.Parent.Frame.DMG.Visible = true
            if u10 and u10.Parent ~= nil then
                script.Parent.Frame.DMG.Text = u10.leaderstats.Damage.Value .. " DAMAGE TO OTHERS"
            end
        end
        pcall(function() --[[ Line: 72 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u10
                [3] = u35
            --]]
            for v61 = 1, #u11 do
                if u11[v61] then
                    u11[v61]:Disconnect()
                    u11[v61] = nil
                end
            end
            table.clear(u11)
            local u62 = game.ReplicatedStorage:FindFirstChild("Stats" .. u10.Name)
            local u63 = u10.Character:WaitForChild("Humanoid", 3)
            u35(script.Parent.Frame.Health.Bars.HealthBar, u63.Health, u63.MaxHealth)
            u35(script.Parent.Frame.Health.Bars.HealthBar, u63.Health, u63.MaxHealth)
            u35(script.Parent.Frame.Health.Bars.StaminaBar, u62.Stamina.Value, u62.Stamina.MaxValue)
            local v64 = u63:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 88 ]]
                --[[
                Upvalues:
                    [1] = u35
                    [2] = u63
                --]]
                u35(script.Parent.Frame.Health.Bars.HealthBar, u63.Health, u63.MaxHealth)
            end)
            local v65 = u63:GetPropertyChangedSignal("MaxHealth"):Connect(function() --[[ Line: 92 ]]
                --[[
                Upvalues:
                    [1] = u35
                    [2] = u63
                --]]
                u35(script.Parent.Frame.Health.Bars.HealthBar, u63.Health, u63.MaxHealth)
            end)
            local v66 = u62.Stamina.Changed:Connect(function() --[[ Line: 96 ]]
                --[[
                Upvalues:
                    [1] = u35
                    [2] = u62
                --]]
                u35(script.Parent.Frame.Health.Bars.StaminaBar, u62.Stamina.Value, u62.Stamina.MaxValue)
            end)
            local v67 = u11
            table.insert(v67, v64)
            local v68 = u11
            table.insert(v68, v65)
            local v69 = u11
            table.insert(v69, v66)
        end)
    end
end
local u71 = script.Parent.ScrollingFrame.ScrollingFrame
task.spawn(function() --[[ Line: 222 ]]
    --[[
    Upvalues:
        [1] = u52
        [2] = u71
        [3] = u70
    --]]
    while true do
        local u72 = u52()
        local v73 = {}
        for u74 = 1, #u72 do
            if u71:FindFirstChild(u72[u74].Name) == nil then
                local v75 = script.playerName:Clone()
                v75.Name = u72[u74].Name
                v75.Text = u72[u74].Name
                v75.Parent = u71
                v75.MouseButton1Click:Connect(function() --[[ Line: 234 ]]
                    --[[
                    Upvalues:
                        [1] = u70
                        [2] = u72
                        [3] = u74
                    --]]
                    u70(u72[u74].Name)
                end)
            end
            local v76 = u72[u74].Name
            table.insert(v73, v76)
        end
        table.sort(v73)
        local v77 = u71:GetChildren()
        for v78 = 1, #v77 do
            if v77[v78]:IsA("TextButton") and table.find(v73, v77[v78].Name) == nil then
                v77[v78]:Destroy()
            end
        end
        task.wait(1)
    end
end)
_G.tween(script.Parent.Blackout, {
    1,
    Enum.EasingStyle.Quad,
    Enum.EasingDirection.Out,
    0,
    false,
    0
}, {
    ["BackgroundTransparency"] = 1
})
v2.InputBegan:Connect(function(p79, p80) --[[ Line: 255 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u70
    --]]
    if not p80 and u5 ~= true then
        if (p79.UserInputType == Enum.UserInputType.MouseButton1 or p79.UserInputType == Enum.UserInputType.Touch) and workspace.CurrentCamera.CameraType == Enum.CameraType.Custom then
            u70()
        end
    end
end)
u70()
script.Parent.Frame.RETURN.MouseButton1Click:Connect(function() --[[ Line: 266 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u1
        [3] = u3
    --]]
    u5 = true
    u1.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
    game.ReplicatedStorage.Events.spectate:FireServer()
    game.ReplicatedStorage.matchEvents:FireServer("return")
    u3:InvokeServer(game.Players.LocalPlayer)
    script.Parent:Destroy()
end)
local u81 = game:GetService("ProximityPromptService")
task.defer(function() --[[ Line: 278 ]]
    --[[
    Upvalues:
        [1] = u81
    --]]
    u81.Enabled = false
end)
if game.ReplicatedStorage.reservedCode:GetAttribute("battleRoyale") ~= nil then
    script.Parent.Frame.RETURN.Visible = true
    script.Parent.Frame.RETURN.MouseButton1Click:Connect(function() --[[ Line: 288 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        if u6 == false and game.Players.LocalPlayer.Party.Value ~= game.Players.LocalPlayer then
            game.ReplicatedStorage.matchEvents:FireServer("requestReturn")
            return
        else
            script.Parent.Frame.TextLabel.Text = "RETURNING TO LOBBY..."
            script.Parent.Frame.TextLabel.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 170, 0))
            if u6 == true then
                game.ReplicatedStorage.matchEvents:FireServer("return")
            else
                game.ReplicatedStorage.matchEvents:FireServer("returnParty")
            end
        end
    end)
    task.spawn(function() --[[ Line: 303 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u70
        --]]
        while true do
            if u10 and u10.Parent ~= nil then
                script.Parent.Frame.DMG.Text = u10.leaderstats.Damage.Value .. " DAMAGE TO OTHERS"
                if u10.Team == game.Teams.Eliminated then
                    u70()
                end
            end
            task.wait()
        end
    end)
    while true do
        local v82 = game.Players:GetPlayers()
        local v83 = {}
        for v84 = 1, #v82 do
            if v82[v84].Team == game.Teams.Players and (game.Players.LocalPlayer.Party.Value == nil or game.Players.LocalPlayer.Party.Value == v82[v84].Party.Value) then
                local v85 = v82[v84]
                table.insert(v83, v85)
            end
        end
        if u10 ~= nil then
            local v86 = u10.Character
            if v86 and (v86.PrimaryPart ~= nil and game.Players.LocalPlayer.ReplicationFocus ~= v86.PrimaryPart) then
                _G.requestStream(game.ReplicatedStorage.getPlayerPosition:InvokeServer(u10), 1)
            end
            script.Parent.Frame.userName.Text = u10.Name
        end
        if game.ReplicatedStorage.reservedCode:GetAttribute("battleRoyale") and #v83 <= 0 then
            break
        end
        u81.Enabled = false
        task.wait()
    end
    script.Parent.Frame.TextLabel.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
    if game.Players.LocalPlayer.Party.Value == nil then
        script.Parent.Frame.TextLabel.Text = "YOU HAVE BEEN ELIMINATED : ("
    else
        local _ = false
        if game.Players.LocalPlayer == game.Players.LocalPlayer.Party.Value then
            script.Parent.Frame.RETURN.Text = "RETURN TO LOBBY AS PARTY"
        else
            script.Parent.Frame.RETURN.Text = "ASK PARTY OWNER TO RETURN TO LOBBY!"
        end
        script.Parent.Frame.TextLabel.Text = "YOUR ENTIRE SQUAD HAS BEEN ELIMINATED : ("
    end
end