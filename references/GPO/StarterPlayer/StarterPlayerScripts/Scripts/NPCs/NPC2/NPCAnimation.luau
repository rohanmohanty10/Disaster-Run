 

local v1 = game:GetService("Players")
if not v1.LocalPlayer then
    v1.PlayerAdded:Wait()
end
local u2 = v1.LocalPlayer
local u3 = {}
local u4 = {}
local u5 = {}
local u6 = require(game.ReplicatedStorage.Modules.NPCInteractions):getquests()
local u7 = game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
local u8 = game:GetService("HttpService")
local u9 = {}
local u10 = {}
local u11 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true, 0)
local u12 = {
    ["Transparency"] = 0.5
}
function u3.animate(_, u13, u14) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u2
        [3] = u9
        [4] = u5
        [5] = u6
        [6] = u3
        [7] = u10
        [8] = u11
        [9] = u12
        [10] = u4
    --]]
    if not u7 then
        u7 = game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
    end
    task.spawn(function() --[[ Line: 23 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u2
            [3] = u9
            [4] = u14
            [5] = u5
            [6] = u6
            [7] = u3
            [8] = u10
            [9] = u11
            [10] = u12
            [11] = u4
        --]]
        local v15 = u13:WaitForChild("Head", 100000000000)
        local u16 = game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
        if not u9[u13] then
            u9[u13] = {}
        end
        if script.Animations:FindFirstChild(u14) and (not u13:FindFirstChild("animated") and (u13:FindFirstChild("Info") and u13:FindFirstChild("Head"))) then
            local v17 = Instance.new("BoolValue")
            v17.Name = "animated"
            v17.Parent = u13
            if u5[u13] then
                u5[u13]:Destroy()
                u5[u13] = nil
            end
            local u18 = nil
            if u13.Name == "Captain Zhen" then
                if u13:WaitForChild("Cape", 10):WaitForChild("AnimationController", 10) then
                    u13.Cape.AnimationController:LoadAnimation(script.whiteCape):Play()
                end
            elseif u13.Name == "Pharaoh Akshan" and u13:WaitForChild("Cape", 10):WaitForChild("AnimationController", 10) then
                u13.Cape.AnimationController:LoadAnimation(script.crocCape):Play()
            end
            if u13:FindFirstChild("Marine Captain CapeHat") then
                u13:FindFirstChild("Marine Captain CapeHat").AnimationController:LoadAnimation(script.whiteCape):Play()
            end
            if not u5[u13] then
                for _, v19 in u9[u13] do
                    v19:Disconnect()
                end
                u9[u13] = {}
                local u20
                if u13:FindFirstChild("noOverhead") == nil then
                    u20 = script.Overhead:Clone()
                    u20.NameT.Text = u13.Name
                    if u13.Name == "Robo" then
                        u20.NameT.Text = "Robo <br/>[Set Spawn Point]"
                    end
                    u20.Health.Frame.Script.char.Value = u13
                    task.spawn(function() --[[ Line: 73 ]]
                        --[[
                        Upvalues:
                            [1] = u13
                            [2] = u20
                        --]]
                        u13:WaitForChild("HumanoidRootPart")
                        if u13.PrimaryPart ~= nil and u20.StudsOffset.Y > u13:GetModelSize().Y / 2 + 3 then
                            local v21 = u20
                            local v22 = u13:GetModelSize().Y / 2 + 3
                            v21.StudsOffset = Vector3.new(0, v22, 0)
                        end
                    end)
                    u20.Health.Frame.Script.playerName.Value = u13.Name
                    u20.Health.Frame.Script.Disabled = false
                    u20.Adornee = u13.Head
                    u20.Name = u13.Name
                    u20.Parent = u13.Head
                    u5[u13] = u20
                    if u6[u13.Name] and (u6[u13.Name].lvlReq ~= nil and u16.Stats.Level.Value < u6[u13.Name].lvlReq) then
                        u20.Level.Visible = true
                        local v23 = u20.Level
                        local v24 = u6[u13.Name].lvlReq
                        v23.Text = "Level " .. math.ceil(v24) .. "+"
                        local v27 = u16.Stats.Level.Changed:Connect(function() --[[ Line: 102 ]]
                            --[[
                            Upvalues:
                                [1] = u16
                                [2] = u6
                                [3] = u13
                                [4] = u20
                                [5] = u18
                            --]]
                            if u16.Stats.Level.Value < u6[u13.Name].lvlReq then
                                u20.Level.Visible = true
                                local v25 = u20.Level
                                local v26 = u6[u13.Name].lvlReq
                                v25.Text = "Level " .. math.ceil(v26) .. "+"
                            else
                                if u18 then
                                    u18:Disconnect()
                                    u18 = nil
                                end
                                u20.Level.Visible = false
                            end
                        end)
                        local v28 = u9[u13]
                        local v29 = v27
                        table.insert(v28, v29)
                        u18 = v27
                    end
                    if u13:FindFirstChild("Info") and (u13.Info:FindFirstChild("Hostile") and u13.Info.Hostile.Value == false) then
                        u20.Health.Visible = false
                    else
                        u20.MaxDistance = 50
                    end
                else
                    u20 = nil
                end
                if u13.Humanoid:IsA("Humanoid") then
                    local u30 = nil
                    u30 = u13.AncestryChanged:Connect(function(_, p31) --[[ Line: 127 ]]
                        --[[
                        Upvalues:
                            [1] = u18
                            [2] = u30
                            [3] = u20
                            [4] = u5
                            [5] = u13
                            [6] = u3
                        --]]
                        if p31 == workspace.Effects.DeadNPCs then
                            if u18 then
                                u18:Disconnect()
                                u18 = nil
                            end
                            if u30 then
                                u30:Disconnect()
                                u30 = nil
                            end
                            if u20 then
                                u20:Destroy()
                            end
                            if u5[u13] then
                                u5[u13]:Destroy()
                            end
                            u5[u13] = nil
                            u3:remove(u13)
                            _G.destroy(u13, 1)
                            u13 = nil
                        end
                    end)
                    local v32 = u9[u13]
                    local v33 = u30
                    table.insert(v32, v33)
                end
            end
            if u13.Info:FindFirstChild("noAnims") == nil then
                if u13.Info:FindFirstChild("Idle") then
                    local v34 = u13:FindFirstChild("Humanoid")
                    if v34 == nil then
                        v34 = u13:FindFirstChild("AnimationController")
                    end
                    local v35 = v34:LoadAnimation(u13.Info.Idle)
                    v35:Play()
                    v35.Looped = true
                    v35.Priority = Enum.AnimationPriority.Idle
                    if u13:FindFirstChild("Duck") then
                        u13.Duck.AnimationController:LoadAnimation(u13.Duck.Idle):Play()
                    end
                else
                    local u36 = script.Animations:FindFirstChild(u14):Clone()
                    u36.Character.Value = u13
                    u36.Disabled = false
                    u36.Name = u13.Name
                    u36.Parent = script.CurrentAnimations
                    u10[u13] = u36
                    u13.Destroying:Connect(function() --[[ Line: 176 ]]
                        --[[
                        Upvalues:
                            [1] = u36
                        --]]
                        u36:Destroy()
                    end)
                end
                if u13.Info:FindFirstChild("Hostile") and (u13.Info.Hostile.Value == false and u13.Info:FindFirstChild("Idle") == nil) then
                    local v37 = u13.Humanoid:LoadAnimation(script.Idle)
                    v37:Play()
                    v37.Priority = Enum.AnimationPriority.Action
                    v37.Looped = true
                end
            end
        end
        if u13:FindFirstChild("QuestMark") then
            u13:FindFirstChild("QuestMark"):Destroy()
        end
        if u6[u13.Name] and (u6[u13.Name].QuestName and not u13:FindFirstChild("QuestMark")) then
            local v38 = script.MeshPart:Clone()
            v38.Parent = workspace.Env
            v38.Name = "QuestMark"
            Instance.new("BoolValue", u13).Name = "QuestMark"
            game:GetService("TweenService"):Create(v38, u11, u12):Play()
            u4[v38] = { v15, 0 }
        end
    end)
    return nil
end
function u3.remove(_, p39) --[[ Line: 207 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u9
        [3] = u10
        [4] = u4
    --]]
    if u5[p39] then
        u5[p39]:Destroy()
    end
    u5[p39] = nil
    if u9[p39] then
        for _, v40 in u9[p39] do
            v40:Disconnect()
        end
        u9[p39] = nil
    end
    if u10[p39] then
        u10[p39]:Destroy()
        u10[p39] = nil
    end
    local v41 = p39.Humanoid:GetPlayingAnimationTracks()
    for v42 = 1, #v41 do
        v41[v42]:Stop()
    end
    for v43, v44 in u4 do
        if p39:findFirstChild("Head") and v44[1] == p39.Head then
            v43:Destroy()
        end
    end
end
local u45 = {}
local function v46() --[[ Line: 236 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u45
        [3] = u8
    --]]
    u45 = u8:JSONDecode(u7.Quest.CompletedQuests.Value)
end
u45 = u8:JSONDecode(u7.Quest.CompletedQuests.Value)
u7.Quest.CompletedQuests.Changed:Connect(v46)
local function v55() --[[ Line: 243 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
        [3] = u45
    --]]
    for v47, v48 in u4 do
        local v49 = v48[1]
        local v50 = v48[2]
        local v51 = v48[1].Parent
        if v51 == nil or v51.Parent ~= workspace.NPCs then
            if v51 == nil then
                v47:Destroy()
                u4[v47] = nil
            end
        else
            local v52 = v51.Name
            if v51 and (u6[v52] and u6[v52].QuestName ~= nil) then
                local v53 = false
                for v54, _ in u45 do
                    if u45[v54] == u6[v51.Name].QuestName then
                        v53 = true
                        break
                    end
                end
                if v53 == true then
                    u4[v47] = nil
                    v47:Destroy()
                end
            end
            v47.CFrame = CFrame.new(v49.Position) * CFrame.new(0, v47.Size.Y / 2 + 2, 0) * CFrame.Angles(0, math.rad(v50), 0)
            v48[2] = v48[2] + 2
        end
    end
end
game:GetService("RunService").Heartbeat:Connect(v55)
return u3