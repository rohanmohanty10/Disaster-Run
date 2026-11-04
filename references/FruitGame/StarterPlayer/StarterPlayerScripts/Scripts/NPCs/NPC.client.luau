 

local _, _, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u1 = game.Players.LocalPlayer
u1:WaitForChild("PlayerGui"):WaitForChild("HealthBars")
if not u1.Character then
    u1.CharacterAdded:Wait()
end
local u2 = require(script.HealthBar)
local u3 = require(script.NPCAnimation)
local v4 = workspace.NPCs:GetChildren()
local u5 = {}
local u6 = {}
local u7 = {}
local function u17(u8) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v9 = u8:FindFirstChild("Info") or u8:WaitForChild("Info", 2)
    if v9 == nil then
        return
    elseif v9:FindFirstChild("SeaNPC") then
        return
    else
        local v10 = u8:FindFirstChild("Humanoid") or u8:WaitForChild("Humanoid", 2)
        if v10 == nil then
            return
        elseif v9:FindFirstChild("AnimationStyle") ~= nil then
            u3:animate(u8, v9.AnimationStyle.Value)
            if v10:IsA("Humanoid") and v10:GetAttribute("deadSet") == nil then
                v10:SetAttribute("deadSet", true)
                local u11 = nil
                u11 = v10.HealthChanged:Connect(function(p12) --[[ Line: 22 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                        [2] = u11
                    --]]
                    if p12 <= 0 then
                        local v13 = u8:FindFirstChild("damageHighlight")
                        if v13 then
                            v13:Destroy()
                        end
                        u11:Disconnect()
                        u11 = nil
                        task.defer(function() --[[ Line: 33 ]]
                            --[[
                            Upvalues:
                                [1] = u8
                            --]]
                            local v14 = u8:GetDescendants()
                            for v15 = 1, #v14 do
                                if v14[v15]:IsA("BasePart") then
                                    v14[v15].Transparency = 1
                                    v14[v15].Anchored = true
                                    if v14[v15].Parent == u8 then
                                        local v16 = script.ParticleEmitter:Clone()
                                        v16.Name = "deathVFX"
                                        v16.Parent = v14[v15]
                                        _G.customEmit(v16)
                                        _G.destroy(v16, 1)
                                    end
                                elseif v14[v15]:IsA("ParticleEmitter") and (v14[v15].Name ~= "deathVFX" and v14[v15].Enabled == true) then
                                    v14[v15]:Clear()
                                    v14[v15]:Destroy()
                                elseif v14[v15]:IsA("BillboardGui") or (v14[v15]:IsA("Beam") or v14[v15]:IsA("Decal")) then
                                    v14[v15]:Destroy()
                                end
                            end
                        end)
                    end
                end)
            end
        end
    end
end
local u18 = 0
local u19 = 0
for v20 = 1, #v4 do
    u5[v4[v20]] = true
end
workspace.NPCs.ChildAdded:Connect(function(p21) --[[ Line: 72 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
        [3] = u7
        [4] = u17
    --]]
    local v22 = p21:WaitForChild("Info", 5)
    if v22 == nil then
        return
    elseif v22:FindFirstChild("SeaNPC") == nil then
        u5[p21] = true
        local v23 = u6
        table.insert(v23, p21)
        local v24 = workspace.CurrentCamera
        if v24 == nil then
            return
        else
            local v25 = p21:FindFirstChild("HumanoidRootPart")
            if v25 ~= nil then
                if (game.ReplicatedStorage:FindFirstChild("raidMode") ~= nil and true or game.ReplicatedStorage.reservedCode.Value == "arena" or (v24.CFrame.Position - v25.Position).Magnitude <= 500) and not u7[p21] then
                    u7[p21] = true
                    task.spawn(u17, p21)
                end
            end
        end
    else
        return
    end
end)
workspace.NPCs.ChildRemoved:Connect(function(u26) --[[ Line: 102 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u7
        [3] = u3
    --]]
    u5[u26] = nil
    u7[u26] = nil
    local v27 = u26:FindFirstChild("animated")
    if v27 then
        v27:Destroy()
    end
    pcall(function() --[[ Line: 111 ]]
        --[[
        Upvalues:
            [1] = u26
        --]]
        local v28 = u26:GetDescendants()
        for v29 = 1, #v28 do
            if v28[v29]:IsA("BodyVelocity") or v28[v29]:IsA("BodyGyro") then
                v28[v29]:Destroy()
            end
        end
    end)
    pcall(function() --[[ Line: 119 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u26
        --]]
        u3:remove(u26)
    end)
end)
local function u32(p30) --[[ Line: 123 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    if not p30:FindFirstChild("noOverhead") then
        if p30 == u1.Character or p30.Name == u1.Character.Name then
            local v31 = game.ReplicatedStorage:FindFirstChild("Stats" .. u1.Name)
            if v31 and v31.Settings.ShowLocalPlayerBar.Value == false then
                return
            end
        end
        u2:addBar(p30)
    end
end
workspace.PlayerCharacters.ChildAdded:Connect(function(p33) --[[ Line: 136 ]]
    --[[
    Upvalues:
        [1] = u32
    --]]
    u32(p33)
end)
local v34 = workspace.PlayerCharacters:GetChildren()
for v35 = 1, #v34 do
    if v34[v35]:IsA("Model") then
        u32(v34[v35])
    end
end
game.ReplicatedStorage.Events.clientCommand.OnClientEvent:Connect(function(p36, p37) --[[ Line: 147 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v38 = u1.PlayerGui.HealthBars:GetChildren()
    for v39 = 1, #v38 do
        if v38[v39].Name == p36 then
            v38[v39].Health.Frame.Script.playerName.Value = p37
        end
    end
end)
local function u42() --[[ Line: 161 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u5
        [3] = u7
    --]]
    table.clear(u6)
    for v40 in u5 do
        if v40.Parent == workspace.NPCs then
            local v41 = u6
            table.insert(v41, v40)
        else
            u5[v40] = nil
            u7[v40] = nil
        end
    end
end
game:GetService("RunService").Heartbeat:Connect(function() --[[ Name: cullNPCs, Line 173 ]]
    --[[
    Upvalues:
        [1] = u18
        [2] = u42
        [3] = u19
        [4] = u5
        [5] = u7
        [6] = u17
        [7] = u6
        [8] = u3
    --]]
    local v43 = tick()
    if v43 - u18 >= 2 then
        u42()
        u18 = v43
        u19 = 0
    end
    local v44 = workspace.CurrentCamera
    if v44 == nil then
        return
    else
        local v45 = v44.CFrame.Position
        if game.ReplicatedStorage:FindFirstChild("raidMode") == nil and game.ReplicatedStorage.reservedCode.Value ~= "arena" then
            local v46 = #u6
            if v46 ~= 0 then
                local v47 = 0
                while v47 < 10 do
                    u19 = u19 + 1
                    if v46 < u19 then
                        u19 = 1
                    end
                    local u48 = u6[u19]
                    if u48 == nil or u48.Parent ~= workspace.NPCs then
                        v47 = v47 + 1
                    else
                        local v49 = u48:FindFirstChild("HumanoidRootPart")
                        if v49 == nil then
                            v47 = v47 + 1
                        else
                            local v50 = (v45 - v49.Position).Magnitude
                            local v51 = u7[u48] == true
                            if v51 or v50 > 500 then
                                if v51 and v50 > 550 then
                                    u7[u48] = nil
                                    pcall(function() --[[ Line: 230 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u3
                                            [2] = u48
                                        --]]
                                        u3:remove(u48)
                                    end)
                                    local v52 = u48:FindFirstChild("animated")
                                    if v52 then
                                        v52:Destroy()
                                    end
                                end
                            else
                                u7[u48] = true
                                local v53 = u48:FindFirstChild("animated")
                                if v53 then
                                    v53:Destroy()
                                end
                                task.spawn(u17, u48)
                            end
                            v47 = v47 + 1
                        end
                    end
                end
            end
        else
            for v54 in u5 do
                if not u7[v54] and v54.Parent == workspace.NPCs then
                    u7[v54] = true
                    task.spawn(u17, v54)
                end
            end
            return
        end
    end
end)