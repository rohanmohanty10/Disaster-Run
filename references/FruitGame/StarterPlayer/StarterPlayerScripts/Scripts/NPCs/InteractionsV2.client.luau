 

game:GetService("ReplicatedStorage")
local v1 = game:GetService("ReplicatedStorage")
local u2 = game.Players.LocalPlayer
if not u2.Character then
    u2.CharacterAdded:Wait()
end
local v3 = workspace.NPCs
local u4 = require(game.ReplicatedStorage.Modules.NPCInteractions)
local u5 = u4:getquests()
local u6 = require(v1.Modules.Shared.Signals.GoodSignal).new()
local function u9(p7, p8) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p7:FindFirstChild("busy") then
        warn("Busy NPC")
        return false
    end
    if _G.arena == true then
        return true
    end
    if not p7:FindFirstChild("Info") then
        warn("No Info Folder in NPC")
        return false
    end
    if p7.Info.Hostile.Value == true and p7.Info:FindFirstChild("RoamingNPC") == nil then
        warn("NPC is hostile")
        return false
    end
    if p7.Info:FindFirstChild("RoamingNPC") and not p7.Info.RoamingNPC.Value then
        warn("Not roaming npc??")
        return false
    end
    if (p7.LowerTorso.Position - u2.Character.HumanoidRootPart.Position).Magnitude >= p8 + 10 then
        warn("Too far away")
        return false
    end
    if not game.Players.LocalPlayer.Character or _G.canuse ~= false then
        return true
    end
    _G.displayMessage("<Color=Red>You are stunned, cant interact with NPCs!")
    return false
end
local function v21(u10) --[[ Line: 75 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
        [3] = u2
        [4] = u9
        [5] = u4
    --]]
    local v11
    if u5[u10.Name] then
        v11 = true
        ::l3::
        if v11 then
            local u12 = u10:WaitForChild("Info", 60)
            if u12 ~= nil then
                local v13 = u10:WaitForChild("UpperTorso")
                task.wait(1)
                local u14 = script.Prompt:Clone()
                u14.MaxActivationDistance = 3 + u10:GetModelSize().Magnitude / 2
                u14.ObjectText = u10.Name
                if u10.Name == "Robo" then
                    u14.ActionText = "Set Spawn"
                end
                u14.Parent = v13
                local u15 = nil
                local function u18() --[[ Line: 92 ]]
                    --[[
                    Upvalues:
                        [1] = u15
                        [2] = u6
                        [3] = u18
                        [4] = u12
                        [5] = u2
                        [6] = u14
                    --]]
                    if u15 then
                        u15:Disconnect()
                        u15 = nil
                    end
                    u15 = u6:Connect(u18)
                    local v16 = u12:FindFirstChild("Hostile")
                    local v17 = u2.Character
                    if v17 then
                        if (v16 and v16.Value == false or u12:FindFirstChild("RoamingNPC") and u12:FindFirstChild("RoamingNPC").Value == true) and (_G.canuse == true and (_G.check:inspect(v17) == true or (v17:FindFirstChild("Barrel") or v17:FindFirstChild("ragcarry")))) then
                            u14.Enabled = true
                        else
                            u14.Enabled = false
                        end
                    else
                        return
                    end
                end
                u14.Triggered:Connect(function() --[[ Line: 111 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                        [2] = u10
                        [3] = u14
                        [4] = u4
                    --]]
                    if u9(u10, u14.MaxActivationDistance) then
                        if _G.UIEnabled ~= false then
                            u14.Enabled = false
                            task.spawn(function() --[[ Line: 119 ]]
                                game.ReplicatedStorage.Events.Quest:InvokeServer({ "npcChat", true })
                            end)
                            u4:startchat(u10)
                            u14.Enabled = true
                            game.ReplicatedStorage.Events.Quest:InvokeServer({ "npcChat", false })
                        end
                    else
                        warn("Cannot interact with NPC")
                        return
                    end
                end)
                u14.PromptShown:Connect(u18)
                u18()
                task.spawn(function() --[[ Line: 132 ]]
                    --[[
                    Upvalues:
                        [1] = u12
                        [2] = u18
                    --]]
                    local v19 = u12:WaitForChild("Hostile", 3)
                    if v19 then
                        v19.Changed:Connect(u18)
                    end
                end)
                u14.Destroying:Connect(function() --[[ Line: 139 ]]
                    --[[
                    Upvalues:
                        [1] = u15
                    --]]
                    if u15 then
                        u15:Disconnect()
                    end
                end)
            end
        else
            return
        end
    else
        for _, v20 in u5 do
            if v20.NPC == u10.Name then
                v11 = true
                goto l3
            end
        end
        v11 = false
        goto l3
    end
end
for _, v22 in v3:GetChildren() do
    task.spawn(v21, v22)
end
v3.ChildAdded:Connect(v21)
local v23 = _G.canuse
local v24 = false
while true do
    task.wait(0.1)
    local v25 = u2.Character
    local v26
    if _G.check and v25 then
        v26 = _G.check:inspect(v25)
        if v24 == v26 then
            v26 = v24
        end
        u6:Fire()
    else
        v26 = v24
    end
    if v23 ~= _G.canuse then
        v23 = _G.canuse
        u6:Fire()
    end
    v24 = v26
end