 

local u1, _, _, u2, u3 = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u4 = require(game.ReplicatedStorage.Modules.Shared.Maids.Maid)
local u5 = require(game.ReplicatedStorage.Modules.NPCInteractions)
game.ReplicatedStorage:WaitForChild("NPCCache")
function pointToScreen(p6, p7, p8, p9)
    local v10 = p9 / 2
    local v11 = 1 / math.tan(v10)
    local v12 = p8.y / p8.x
    local v13 = p6:pointToObjectSpace(p7)
    local v14 = Vector2.new(v13.x, v13.y) / -v13.z
    local v15 = Vector2.new(v14.x * v12, v14.y) * v11 / 2 * p8 + p8 / 2
    return Vector2.new(v15.x, p8.y - v15.y), -v13.z
end
local u16 = nil
local function u34() --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u5
        [3] = u2
        [4] = u1
        [5] = u16
    --]]
    local _, v17 = u5:getmob_formquest(u3.Quest.CurrentQuest.Value, u3.Quest.MultiQuestProgress.Value)
    local u18 = game.Players.LocalPlayer.Character
    if v17 and u18 then
        v17 = v17.QuestInfo
        if v17.Type == "Find" then
            if workspace:FindFirstChild("RItem") == nil and u3.Quest.QuestProgress.Value == 0 then
                local v19 = game.ReplicatedStorage.RItems:FindFirstChild(v17.MobName)
                if v19 then
                    local u20 = v19:Clone()
                    u20.Name = "RItem"
                    local u21 = game.ReplicatedStorage.Events.Quest:InvokeServer({ "requestposition" })
                    u20.CFrame = u21
                    u20.Parent = workspace.Effects
                    local v22 = Instance.new("Highlight")
                    v22.DepthMode = Enum.HighlightDepthMode.Occluded
                    v22.FillTransparency = 1
                    v22.OutlineTransparency = 0.5
                    v22.Parent = u20
                    if u20:FindFirstChild("hint") then
                        u20.hint:Play()
                    end
                    local u23 = script.Prompt:Clone()
                    u23.ActionText = "Pick up"
                    u23.ObjectText = v17.MobName
                    u23.Parent = u20
                    local u24 = nil
                    u24 = u23.Triggered:Connect(function() --[[ Line: 52 ]]
                        --[[
                        Upvalues:
                            [1] = u18
                            [2] = u21
                            [3] = u24
                            [4] = u23
                        --]]
                        u18 = game.Players.LocalPlayer.Character
                        if (u18.HumanoidRootPart.Position - u21.p).magnitude <= 10 then
                            game.ReplicatedStorage.Events.Quest:InvokeServer({ "founditem" })
                            u24:disconnect()
                            u23:Destroy()
                            u24 = nil
                        end
                    end)
                    task.spawn(function() --[[ Line: 63 ]]
                        --[[
                        Upvalues:
                            [1] = u23
                            [2] = u20
                            [3] = u21
                            [4] = u18
                            [5] = u2
                        --]]
                        while u23:IsDescendantOf(u20) == true do
                            game["Run Service"].RenderStepped:Wait()
                            u20.Name = "Part"
                            local _, v25 = workspace.CurrentCamera:WorldToScreenPoint(u21.p)
                            if v25 then
                                u20.Parent = workspace.Effects
                            else
                                u20.Parent = game.ReplicatedStorage
                            end
                            u18 = game.Players.LocalPlayer.Character
                        end
                        u20:Destroy()
                        u2:Destroy()
                    end)
                end
            elseif u3.Quest.QuestProgress.Value == 1 and u1.Backpack:FindFirstChild(v17.MobName) == nil then
                game.ReplicatedStorage.Events.Quest:InvokeServer({ "requestitem" })
            end
        elseif v17.Type == "Deliver" then
            if u1.Backpack:FindFirstChild(v17.MobName) == nil and u18:FindFirstChild(v17.MobName) == nil then
                game.ReplicatedStorage.Events.Quest:InvokeServer({ "requestitem" })
            end
            if u16 == nil and v17.block == nil then
                u18:WaitForChild("UpperTorso")
                local _, v26 = u5:getmob_formquest(u3.Quest.CurrentQuest.Value)
                game.ReplicatedStorage:FindFirstChild("NPCCache"):FindFirstChild(v26.QuestInfo.EndNPC)
                local u27 = Instance.new("Attachment", u18.UpperTorso)
                local u28 = Instance.new("Attachment", workspace.Terrain)
                local u29 = script.Beam:Clone()
                u29.Parent = u18.UpperTorso
                u29.Attachment0 = u27
                u29.Attachment1 = u28
                u16 = u29
                local u30 = game.ReplicatedStorage.Events.Quest:InvokeServer({ "requestEndCFrame" })
                if u30 == nil then
                    if u16 then
                        u16:Destroy()
                        u16 = nil
                    end
                    u27:Destroy()
                    return
                end
                task.spawn(function() --[[ Line: 135 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                        [2] = u28
                        [3] = u30
                        [4] = u29
                        [5] = u16
                        [6] = u27
                    --]]
                    while u18.Parent ~= nil do
                        game["Run Service"].Heartbeat:Wait()
                        u28.WorldCFrame = u30
                        local v31 = u29
                        local v32 = (u18.HumanoidRootPart.Position - u28.WorldCFrame.Position).magnitude / 10
                        v31.TextureLength = math.clamp(v32, 1, 5)
                    end
                    if u16 then
                        u16:Destroy()
                        u16 = nil
                    end
                    u27:Destroy()
                end)
            end
        end
    end
    if v17 == nil then
        local v33 = game.Players.LocalPlayer.Character
        if workspace:FindFirstChild("RItem") then
            workspace:FindFirstChild("RItem"):Destroy()
        end
        if v33:FindFirstChild("DeliverItem") then
            v33:FindFirstChild("DeliverItem"):Destroy()
        end
        if u16 then
            u16:Destroy()
            u16 = nil
        end
    end
end
u34()
local u35 = {}
local u36, u37 = u5:getmob_formquest(u3.Quest.CurrentQuest.Value, u3.Quest.MultiQuestProgress.Value)
local function u41() --[[ Line: 204 ]]
    --[[
    Upvalues:
        [1] = u34
        [2] = u3
        [3] = u35
        [4] = u36
        [5] = u37
        [6] = u5
    --]]
    u34()
    if u3.Quest.CurrentQuest.Value == "None" then
        for _, v38 in pairs(u35) do
            v38.Maid:Destroy()
        end
        table.clear(u35)
        u36 = nil
        u37 = nil
    else
        local v39, v40 = u5:getmob_formquest(u3.Quest.CurrentQuest.Value, u3.Quest.MultiQuestProgress.Value)
        u36 = v39
        u37 = v40
    end
end
u3.Quest.CurrentQuest.Changed:Connect(function() --[[ Line: 218 ]]
    --[[
    Upvalues:
        [1] = u41
    --]]
    if workspace:FindFirstChild("RItem") then
        workspace:FindFirstChild("RItem"):Destroy()
    end
    u41()
end)
u3.Quest.MultiQuestProgress.Changed:Connect(function() --[[ Line: 226 ]]
    --[[
    Upvalues:
        [1] = u35
        [2] = u41
    --]]
    for _, v42 in pairs(u35) do
        v42.Maid:Destroy()
    end
    u41()
end)
game.Players.LocalPlayer.CharacterAdded:Connect(u34)
local function u47(p43, p44, p45) --[[ Line: 235 ]]
    --[[
    Upvalues:
        [1] = u35
    --]]
    if p44 == nil then
        p44 = p43:GetAttribute("NPCID")
    end
    local v46 = u35[p44]
    if v46 then
        v46 = v46.markerAttachment:WaitForChild("questMarker", 1)
    end
    if v46 ~= nil then
        if p43 and p43:IsDescendantOf(workspace) then
            if p43:WaitForChild("Head", 3) then
                v46.StudsOffsetWorldSpace = Vector3.new()
                v46.Adornee = nil
                v46.Adornee = p43.Head
                return
            end
        elseif p45 then
            v46.Adornee = nil
            v46.StudsOffsetWorldSpace = p45
        end
    end
end
workspace.NPCs.ChildAdded:Connect(u47)
local v48 = u36
while true do
    if u3.Quest.CurrentQuest.Value ~= "None" then
        tick()
        if v48 then
            local v49 = game.ReplicatedStorage.Events.Quest:InvokeServer("getNPCQuestLocations")
            for u50, u51 in pairs(v49) do
                local u52 = u51.Position
                task.spawn(function() --[[ Line: 274 ]]
                    --[[
                    Upvalues:
                        [1] = u51
                        [2] = u35
                        [3] = u50
                        [4] = u4
                        [5] = u47
                        [6] = u52
                    --]]
                    local u53 = u51.npcModel
                    local v54 = u35[u50]
                    if v54 then
                        v54.markerAttachment:FindFirstChild("questMarker")
                    end
                    if not (u53 and u53:IsDescendantOf(workspace.Effects)) then
                        if u35[u50] == nil then
                            local v55 = u4.new()
                            local v56 = Instance.new("Attachment", workspace.Terrain)
                            local v57 = game.ReplicatedStorage.Assets.NPCCircle:Clone()
                            v57.Name = "questMarker"
                            v57.Parent = v56
                            local v58 = Instance.new("ObjectValue", v57)
                            v58.Name = "attachmentObject"
                            v58.Value = v56
                            u35[u50] = {
                                ["Maid"] = v55,
                                ["markerAttachment"] = v56
                            }
                            v55:AddTask(v56)
                            v55:AddTask(v57)
                        end
                        if u53 and u35[u50].deathConnection == nil then
                            u35[u50].Maid:AddTask(u53:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 302 ]]
                                --[[
                                Upvalues:
                                    [1] = u53
                                    [2] = u35
                                    [3] = u50
                                --]]
                                if u53:IsDescendantOf(workspace.Effects) then
                                    u35[u50].Maid:Destroy()
                                    u35[u50] = nil
                                end
                            end))
                        end
                        u47(u53, u50, u52)
                    end
                end)
            end
        end
    end
    task.wait(1)
end