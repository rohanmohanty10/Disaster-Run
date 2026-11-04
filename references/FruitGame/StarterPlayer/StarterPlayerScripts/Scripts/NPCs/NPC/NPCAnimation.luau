 

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
local u9 = game:GetService("TweenService")
local u10 = {}
local u11 = {}
local u12 = {
    ["Captain Zhen"] = "whiteCape",
    ["Pharaoh Akshan"] = "crocCape"
}
local u13 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true, 0)
local u14 = {
    ["Transparency"] = 0.5
}
function u3.animate(_, u15, u16) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u2
        [3] = u10
        [4] = u5
        [5] = u12
        [6] = u6
        [7] = u3
        [8] = u11
        [9] = u9
        [10] = u13
        [11] = u14
        [12] = u4
    --]]
    if not u7 then
        u7 = game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
    end
    task.spawn(function() --[[ Line: 28 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u10
            [3] = u16
            [4] = u5
            [5] = u12
            [6] = u6
            [7] = u7
            [8] = u3
            [9] = u11
            [10] = u9
            [11] = u13
            [12] = u14
            [13] = u4
        --]]
        local v17 = u15:FindFirstChild("Head") or u15:WaitForChild("Head", 3)
        if v17 ~= nil then
            if not u10[u15] then
                u10[u15] = {}
            end
            if script.Animations:FindFirstChild(u16) and (not u15:FindFirstChild("animated") and (u15:FindFirstChild("Info") and u15:FindFirstChild("Head"))) then
                local v18 = Instance.new("BoolValue")
                v18.Name = "animated"
                v18.Parent = u15
                if u5[u15] then
                    u5[u15]:Destroy()
                    u5[u15] = nil
                end
                local u19 = nil
                local v20 = u12[u15.Name]
                if v20 then
                    local v21 = u15:FindFirstChild("Cape") or u15:WaitForChild("Cape", 3)
                    local v22 = v21
                    if v22 then
                        v22 = v21:FindFirstChild("AnimationController") or v21:WaitForChild("AnimationController", 3)
                    end
                    if v22 then
                        v22:LoadAnimation(script[v20]):Play()
                    end
                end
                if u15:FindFirstChild("Marine Captain CapeHat") then
                    u15:FindFirstChild("Marine Captain CapeHat").AnimationController:LoadAnimation(script.whiteCape):Play()
                end
                if not u5[u15] then
                    for _, v23 in u10[u15] do
                        v23:Disconnect()
                    end
                    u10[u15] = {}
                    local u24
                    if u15:FindFirstChild("noOverhead") == nil then
                        u24 = script.Overhead:Clone()
                        u24.NameT.Text = u15.Name
                        if u15.Name == "Robo" then
                            u24.NameT.Text = "Robo <br/>[Set Spawn Point]"
                        end
                        u24.Health.Frame.Script.char.Value = u15
                        task.spawn(function() --[[ Line: 73 ]]
                            --[[
                            Upvalues:
                                [1] = u15
                                [2] = u24
                            --]]
                            if (u15:FindFirstChild("HumanoidRootPart") or u15:WaitForChild("HumanoidRootPart", 2)) and (u15.PrimaryPart ~= nil and u24.StudsOffset.Y > u15:GetModelSize().Y / 2 + 3) then
                                local v25 = u24
                                local v26 = u15:GetModelSize().Y / 2 + 3
                                v25.StudsOffset = Vector3.new(0, v26, 0)
                            end
                        end)
                        u24.Health.Frame.Script.playerName.Value = u15.Name
                        u24.Health.Frame.Script.Disabled = false
                        u24.Adornee = u15.Head
                        u24.Name = u15.Name
                        u24.Parent = u15.Head
                        u5[u15] = u24
                        local u27 = u6[u15.Name]
                        if u27 and (u27.lvlReq ~= nil and u7.Stats.Level.Value < u27.lvlReq) then
                            u24.Level.Visible = true
                            local v28 = u24.Level
                            local v29 = u27.lvlReq
                            v28.Text = "Level " .. math.ceil(v29) .. "+"
                            local v32 = u7.Stats.Level.Changed:Connect(function() --[[ Line: 95 ]]
                                --[[
                                Upvalues:
                                    [1] = u7
                                    [2] = u27
                                    [3] = u24
                                    [4] = u19
                                --]]
                                if u7.Stats.Level.Value < u27.lvlReq then
                                    u24.Level.Visible = true
                                    local v30 = u24.Level
                                    local v31 = u27.lvlReq
                                    v30.Text = "Level " .. math.ceil(v31) .. "+"
                                else
                                    if u19 then
                                        u19:Disconnect()
                                        u19 = nil
                                    end
                                    u24.Level.Visible = false
                                end
                            end)
                            local v33 = u10[u15]
                            local v34 = v32
                            table.insert(v33, v34)
                            u19 = v32
                        end
                        if u15:FindFirstChild("Info") and (u15.Info:FindFirstChild("Hostile") and u15.Info.Hostile.Value == false) then
                            u24.Health.Visible = false
                        else
                            u24.MaxDistance = 50
                        end
                    else
                        u24 = nil
                    end
                    if u15.Humanoid:IsA("Humanoid") then
                        local u35 = nil
                        u35 = u15.AncestryChanged:Connect(function(_, p36) --[[ Line: 119 ]]
                            --[[
                            Upvalues:
                                [1] = u19
                                [2] = u35
                                [3] = u24
                                [4] = u5
                                [5] = u15
                                [6] = u3
                            --]]
                            if p36 == workspace.Effects.DeadNPCs then
                                if u19 then
                                    u19:Disconnect()
                                    u19 = nil
                                end
                                if u35 then
                                    u35:Disconnect()
                                    u35 = nil
                                end
                                if u24 then
                                    u24:Destroy()
                                end
                                if u5[u15] then
                                    u5[u15]:Destroy()
                                end
                                u5[u15] = nil
                                u3:remove(u15)
                                _G.destroy(u15, 1)
                                u15 = nil
                            end
                        end)
                        local v37 = u10[u15]
                        local v38 = u35
                        table.insert(v37, v38)
                    end
                end
                if u15.Info:FindFirstChild("noAnims") == nil then
                    if u15.Info:FindFirstChild("Idle") then
                        local v39 = u15:FindFirstChild("Humanoid")
                        if v39 == nil then
                            v39 = u15:FindFirstChild("AnimationController")
                        end
                        local v40 = v39:LoadAnimation(u15.Info.Idle)
                        v40:Play()
                        v40.Looped = true
                        v40.Priority = Enum.AnimationPriority.Idle
                        if u15:FindFirstChild("Duck") then
                            u15.Duck.AnimationController:LoadAnimation(u15.Duck.Idle):Play()
                        end
                    else
                        local u41 = script.Animations:FindFirstChild(u16):Clone()
                        u41.Character.Value = u15
                        u41.Disabled = false
                        u41.Name = u15.Name
                        u41.Parent = script.CurrentAnimations
                        u11[u15] = u41
                        local v42 = u15.Destroying:Connect(function() --[[ Line: 168 ]]
                            --[[
                            Upvalues:
                                [1] = u41
                            --]]
                            u41:Destroy()
                        end)
                        local v43 = u10[u15]
                        table.insert(v43, v42)
                    end
                    if u15.Info:FindFirstChild("Hostile") and (u15.Info.Hostile.Value == false and u15.Info:FindFirstChild("Idle") == nil) then
                        local v44 = u15.Humanoid:LoadAnimation(script.Idle)
                        v44:Play()
                        v44.Priority = Enum.AnimationPriority.Action
                        v44.Looped = true
                    end
                end
            end
            local v45 = u15:FindFirstChild("QuestMark")
            if v45 then
                v45:Destroy()
            end
            local v46 = u6[u15.Name]
            if v46 and (v46.QuestName and not u15:FindFirstChild("QuestMark")) then
                local v47 = script.MeshPart:Clone()
                v47.Parent = workspace.Env
                v47.Name = "QuestMark"
                Instance.new("BoolValue", u15).Name = "QuestMark"
                u9:Create(v47, u13, u14):Play()
                u4[v47] = { v17, 0, v47.Size.Y / 2 + 2 }
            end
        end
    end)
    return nil
end
function u3.remove(_, p48) --[[ Line: 201 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u10
        [3] = u11
        [4] = u4
    --]]
    if u5[p48] then
        u5[p48]:Destroy()
    end
    u5[p48] = nil
    if u10[p48] then
        for _, v49 in u10[p48] do
            v49:Disconnect()
        end
        u10[p48] = nil
    end
    if u11[p48] then
        u11[p48]:Destroy()
        u11[p48] = nil
    end
    local v50 = p48:FindFirstChild("Humanoid")
    if v50 then
        local v51 = v50:GetPlayingAnimationTracks()
        for v52 = 1, #v51 do
            v51[v52]:Stop()
        end
    end
    for _, v53 in p48:GetDescendants() do
        if v53:IsA("AnimationController") then
            for _, v54 in v53:GetPlayingAnimationTracks() do
                v54:Stop()
            end
        end
    end
    local v55 = p48:FindFirstChild("Head")
    if v55 then
        for v56, v57 in u4 do
            if v57[1] == v55 then
                v56:Destroy()
                u4[v56] = nil
            end
        end
    end
end
local u58 = {}
local function v61() --[[ Line: 244 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u7
        [3] = u58
    --]]
    local v59 = {}
    for _, v60 in u8:JSONDecode(u7.Quest.CompletedQuests.Value) do
        v59[v60] = true
    end
    u58 = v59
end
local v62 = u7
local v63 = {}
for _, v64 in u8:JSONDecode(u7.Quest.CompletedQuests.Value) do
    v63[v64] = true
end
u58 = v63
v62.Quest.CompletedQuests.Changed:Connect(v61)
local u65 = 0
local function v74() --[[ Line: 258 ]]
    --[[
    Upvalues:
        [1] = u65
        [2] = u4
        [3] = u6
        [4] = u58
    --]]
    u65 = u65 + 1
    local v66 = u65 % 30 == 0
    for v67, v68 in u4 do
        local v69 = v68[1]
        local v70 = v68[2]
        local v71 = v68[3]
        local v72 = v68[1].Parent
        if v72 == nil or v72.Parent ~= workspace.NPCs then
            if v72 == nil then
                v67:Destroy()
                u4[v67] = nil
            end
        elseif v66 then
            local v73 = u6[v72.Name]
            if not (v73 and (v73.QuestName and u58[v73.QuestName])) then
                goto l10
            end
            u4[v67] = nil
            v67:Destroy()
        else
            ::l10::
            v67.CFrame = CFrame.new(v69.Position) * CFrame.new(0, v71, 0) * CFrame.Angles(0, math.rad(v70), 0)
            v68[2] = v68[2] + 2
        end
    end
end
game:GetService("RunService").Heartbeat:Connect(v74)
return u3