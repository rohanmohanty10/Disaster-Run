 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.RichText)
local u3
if game["Run Service"]:IsServer() == false then
    u3 = require(game.ReplicatedStorage.Modules.MEnterLeave)
else
    u3 = nil
end
local u4 = script.Talks:GetDescendants()
local u5 = {}
for u6 = 1, #u4 do
    if u4[u6]:IsA("ModuleScript") then
        task.spawn(function() --[[ Line: 13 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u4
                [3] = u6
            --]]
            u5[u4[u6].Name] = require(u4[u6])
        end)
    end
end
local function u13(p7, p8) --[[ Line: 37 ]]
    if p8 == true then
        local v9 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
        local v10 = {
            ["Size"] = script.ScreenGui.Frame.go.Size,
            ["TextTransparency"] = 0
        }
        game:GetService("TweenService"):Create(p7, v9, v10):Play()
    else
        local v11 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
        local v12 = {
            ["Size"] = UDim2.new(0, 0, script.ScreenGui.Frame.go.Size.Y.Scale, 0),
            ["TextTransparency"] = 1
        }
        game:GetService("TweenService"):Create(p7, v11, v12):Play()
        p7.Text = ""
    end
end
local function u19(u14) --[[ Line: 56 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v15, v16 = u3.MouseEnterLeaveEvent(u14)
    v15:Connect(function() --[[ Line: 58 ]]
        --[[
        Upvalues:
            [1] = u14
        --]]
        local v17 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
        game:GetService("TweenService"):Create(u14.ImageLabel, v17, {
            ["ImageTransparency"] = 0.25
        }):Play()
    end)
    v16:Connect(function() --[[ Line: 66 ]]
        --[[
        Upvalues:
            [1] = u14
        --]]
        local v18 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
        game:GetService("TweenService"):Create(u14.ImageLabel, v18, {
            ["ImageTransparency"] = 0.5
        }):Play()
    end)
end
local function u25(p20, p21) --[[ Line: 76 ]]
    local v22 = game:GetService("HttpService"):JSONDecode(p20.Quest.CompletedQuests.Value)
    local v23 = false
    for v24 = 1, #v22 do
        if v22[v24] == p21 then
            return true
        end
    end
    return v23
end
local function u30(p26) --[[ Line: 89 ]]
    local v27 = p26:GetDescendants()
    for v28 = 1, #v27 do
        if v27[v28]:IsA("TextLabel") then
            local v29 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
            game:GetService("TweenService"):Create(v27[v28], v29, {
                ["TextTransparency"] = 1
            }):Play()
        end
    end
end
local function u37(p31, p32) --[[ Line: 103 ]]
    local v33 = game.ReplicatedStorage:FindFirstChild("Stats" .. p31.Name)
    local v34 = 0
    for v35, v36 in game:GetService("HttpService"):JSONDecode(v33.Inventory.Inventory.Value) do
        if v35 == p32 then
            v34 = v36
        end
    end
    return v34
end
function deepcopy(p38)
    if type(p38) ~= "table" then
        return p38
    end
    local v39 = {}
    for v40, v41 in next, p38 do
        v39[deepcopy(v40)] = deepcopy(v41)
    end
    local v42 = deepcopy
    local v43 = getmetatable(p38)
    setmetatable(v39, v42(v43))
    return v39
end
local function u52(p44, p45) --[[ Line: 130 ]]
    local v46 = p45 or {}
    if type(p44) ~= "table" then
        return p44
    end
    if v46[p44] then
        return v46[p44]
    end
    local v47 = {}
    v46[p44] = v47
    for v48, v49 in next, p44 do
        v47[deepcopy(v48, v46)] = deepcopy(v49, v46)
    end
    local v50 = deepcopy
    local v51 = getmetatable(p44)
    setmetatable(v47, v50(v51, v46))
    return v47
end
local u53 = game:GetService("UserInputService")
require(game.ReplicatedStorage.Modules.ToolDesc)
function v1.startchat(_, u54, p55, u56, p57, u58, p59, p60) --[[ Line: 152 ]]
    --[[
    Upvalues:
        [1] = u52
        [2] = u5
        [3] = u37
        [4] = u19
        [5] = u2
        [6] = u25
        [7] = u53
        [8] = u13
        [9] = u30
    --]]
    if u54 == nil then
        u54 = game.Players.LocalPlayer.Character
    end
    local v61 = u52(u5)
    local u62
    if u56 == nil then
        u62 = v61[u54.Name]
    else
        u62 = nil
    end
    local v63
    if p55 == true and p59 then
        local v64 = require(game.ReplicatedStorage.Modules.ToolDesc)
        if v64[u56].Max then
            local v65 = u37(game.Players.LocalPlayer, u56)
            if v65 + p59 > v64[u56].Max then
                local v66 = v64[u56].Max - (v65 + p59)
                v63 = p59 - math.abs(v66)
            else
                v63 = p59
            end
        else
            v63 = p59
        end
    else
        v63 = p59
    end
    if p59 == nil then
        p59 = 0
        v63 = 0
    end
    local v67 = p60 == nil and 0 or p60
    if p55 then
        warn("IS A BUY ITEM")
        u62 = {
            ["TalkAmmount"] = 2,
            ["NPC"] = "Shop",
            ["Talk1"] = {
                ["Text"] = "Would you like to purchase a <Color=Green>" .. u56 .. "<Color=/> for <Color=255,255,126>" .. p57 .. " Peli<Color=/>?",
                ["go"] = "Yes",
                ["stop"] = "No",
                ["stoptext"] = "...",
                ["endtext"] = false
            },
            ["Talk5"] = {
                ["Text"] = "Would you like to purchase <Color=Blue>" .. p59 .. " <Color=/><Color=Green>" .. u56 .. "s" .. "<Color=/> for <Color=255,255,126>" .. p57 .. " Peli<Color=/>?",
                ["go"] = "Yes",
                ["stop"] = "No",
                ["stoptext"] = "...",
                ["endtext"] = false
            },
            ["Talk52"] = {
                ["Text"] = "You\'ve bought " .. v63 .. " <AnimateStyle=Rainbow><AnimateStepFrequency=1><AnimateStyleTime=0.5>" .. u56 .. "s<AnimateStyle=/><AnimateStepFrequency=/><AnimateStyleTime=/><Color=/>!",
                ["go"] = "..",
                ["stop"] = "..",
                ["stoptext"] = "...",
                ["endtext"] = true,
                ["excu"] = function(_) --[[ Name: excu, Line 205 ]]
                    --[[
                    Upvalues:
                        [1] = u58
                    --]]
                    script.Item_Box_Get2:Play()
                    game.ReplicatedStorage.Events.Shop:InvokeServer(u58)
                end
            },
            ["Talk2"] = {
                ["Text"] = "You\'ve bought a <AnimateStyle=Rainbow><AnimateStepFrequency=1><AnimateStyleTime=0.5>" .. u56 .. "<AnimateStyle=/><AnimateStepFrequency=/><AnimateStyleTime=/><Color=/>!",
                ["go"] = "..",
                ["stop"] = "..",
                ["stoptext"] = "...",
                ["endtext"] = true,
                ["excu"] = function(_) --[[ Name: excu, Line 216 ]]
                    --[[
                    Upvalues:
                        [1] = u58
                    --]]
                    script.Item_Box_Get2:Play()
                    game.ReplicatedStorage.Events.Shop:InvokeServer(u58, 1)
                end
            },
            ["Talk4"] = {
                ["Text"] = "<Color=Red>You have reached the maxium ammount of copies you can have for this item.<Color=/><AnimateYield=1>",
                ["go"] = "..",
                ["stop"] = "..",
                ["stoptext"] = "...",
                ["endtext"] = true
            },
            ["HowMany"] = {
                ["Text"] = "",
                ["go"] = "",
                ["stop"] = "",
                ["stoptext"] = "",
                ["endtext"] = true,
                ["yield"] = true,
                ["excu"] = function(_) --[[ Name: excu, Line 235 ]]
                    --[[
                    Upvalues:
                        [1] = u56
                        [2] = u58
                    --]]
                    local v68 = script.Shop:Clone()
                    v68.LocalScript:SetAttribute("Item", u56)
                    v68.LocalScript.itemProp.Value = u58
                    v68.Parent = game.Players.LocalPlayer.PlayerGui
                    repeat
                        task.wait()
                    until v68.LocalScript.done.Value == true
                end
            },
            ["TeamTalk"] = {
                ["Text"] = "<Color=Red>This item can only be bought by people in " .. v67 .. "s.<Color=/><AnimateYield=1>",
                ["go"] = "..",
                ["stop"] = "..",
                ["stoptext"] = "...",
                ["endtext"] = true
            },
            ["notLevel"] = {
                ["Text"] = "<Color=Red>You dont meet the level requirements to take this quest.<Color=/><AnimateYield=1>",
                ["go"] = "..",
                ["stop"] = "..",
                ["stoptext"] = "...",
                ["endtext"] = true
            }
        }
    end
    if p55 == true then
        local v69 = require(game.ReplicatedStorage.Modules.ToolDesc)[u56].Max
        if p59 ~= 0 then
            u62.Talk1 = u62.Talk5
            u62.Talk2 = u62.Talk52
        end
        if v69 and v69 <= u37(game.Players.LocalPlayer, u56) then
            u62.Talk2 = u62.Talk4
        elseif v69 > 1 then
            u62.Talk2 = u62.HowMany
        end
    end
    if u62 == nil then
        return
    elseif not game.Players.LocalPlayer.PlayerGui:FindFirstChild("NPCCHAT") then
        local u70 = game.Players.LocalPlayer.Character
        local v71 = Instance.new("ObjectValue", u70)
        _G.canuse = false
        local v72 = game.ReplicatedStorage:FindFirstChild("Stats" .. game.Players.LocalPlayer.Name)
        _G.hideUI(true)
        local u73 = script.ScreenGui:Clone()
        u73.Parent = game.Players.LocalPlayer.PlayerGui
        u73.Name = "NPCCHAT"
        if u62.Team ~= nil and v72.Stats.Team.Value == u62.Team then
            u62.TalkAmmount = 1
            u62.Talk1 = u62.TalkTeam
        end
        if v67 ~= 0 and v72.Stats.Team.Value ~= v67 then
            u62.TalkAmmount = 1
            u62.Talk1 = u62.TeamTalk
        end
        local v74 = UDim2.new(0, 0, script.ScreenGui.Frame.go.Size.Y.Scale, 0)
        u73.Frame.go.TextTransparency = 1
        u73.Frame.stop.TextTransparency = 1
        u73.Frame.endChat.TextTransparency = 1
        u73.Frame.stop.Size = v74
        u73.Frame.go.Size = v74
        u73.Frame.endChat.Size = v74
        if script.Conditions:FindFirstChild(u54.Name) and u56 == nil then
            local v75 = require(script.Conditions:FindFirstChild(u54.Name))
            if v75.adjust ~= nil then
                local v76 = v75:adjust(u54)
                if v76 then
                    for v77 = 1, #v76 do
                        local v78 = v76[v77]
                        local v79 = v78.talkname
                        local v80 = v78.new
                        u62[v79].Text = v80
                    end
                end
            end
            local v81 = v75:check(u54)
            if v81 then
                for v82 = 1, #v81 do
                    local v83 = v81[v82]
                    local v84 = v83.talkname
                    local v85 = v83.talknumber
                    local v86 = v83.talkend
                    u62["Talk" .. v85] = u62[v84]
                    u62.TalkAmmount = v86
                end
            end
        end
        if u62.lvlReq ~= nil and v72.Stats.Level.Value < u62.lvlReq then
            u62 = v61.notreq
        end
        local v87, v88
        if u54:IsA("Model") and (u54.Parent == workspace.NPCs and (p55 == nil and u54.Info:FindFirstChild("Idle") == nil)) then
            v87 = u54.Humanoid:LoadAnimation(script.Talk)
            v87.Priority = Enum.AnimationPriority.Action2
            v87:Play()
            v88 = u54.HumanoidRootPart.CFrame
            local v89 = u54.HumanoidRootPart.Position
            local v90 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
            local v91 = {}
            local v92 = CFrame.new
            local v93 = v89.X
            local v94 = v89.Y
            local v95 = v89.Z
            local v96 = Vector3.new(v93, v94, v95)
            local v97 = u70.HumanoidRootPart.Position.X
            local v98 = v89.Y
            local v99 = u70.HumanoidRootPart.Position.Z
            v91.CFrame = v92(v96, (Vector3.new(v97, v98, v99)))
            game:GetService("TweenService"):Create(u54.HumanoidRootPart, v90, v91):Play()
        else
            v87 = nil
            v88 = nil
        end
        if p55 == nil and u54.Info:FindFirstChild("InteractSFX") then
            u54.Info.InteractSFX:Play()
        elseif p55 == true and v72.Stats.Peli.Value < p57 then
            u62.Talk2 = {
                ["Text"] = "<Color=Red>You dont have enough Peli!<Color=/><AnimateYield=.45>",
                ["go"] = "..",
                ["stop"] = "..",
                ["stoptext"] = "...",
                ["endtext"] = true
            }
        end
        u19(u73.Frame.go)
        u19(u73.Frame.stop)
        u19(u73.Frame.endChat)
        u2:New(u73.Frame.npcname, u54.Name .. "", {
            ["TextScale"] = 1,
            ["AnimateStyle"] = "Fade"
        }):Animate(true)
        u70.Humanoid.WalkSpeed = 0
        task.wait(0.25)
        local u100 = u62.TalkAmmount
        local u101 = false
        local u102 = false
        local u103 = nil
        local u104 = nil
        local v105 = false
        local v106 = u25(v72, u62.QuestName)
        if p55 == nil then
            if v106 == true and u62.bypassComplete == nil then
                u62 = v61["quest completed"]
                u100 = 1
                v105 = true
            end
            if v105 == false and (u62.QuestInfo and (u62.QuestInfo.Type == "DeliverEnd" and v72.Quest.CurrentQuest.Value == u62.QuestInfo.QuestDeliveryName)) then
                warn("evierley ending")
                u62 = u52(v61)[u54.Name]
                v105 = true
            elseif v105 == false and (u62.QuestInfo and (u62.QuestInfo.Type == "DeliverEnd" and v72.Quest.CurrentQuest.Value ~= u62.QuestInfo.QuestDeliveryName)) then
                u100 = 1
                v105 = true
                if u25(v72, u62.QuestInfo.QuestDeliveryName) == true then
                    u62 = v61[u54.Name].TalkFinished
                else
                    u62 = v61[u54.Name].TalkMissing
                end
            end
            if u62.QuestInfo and (u62.QuestInfo.Type ~= nil and v105 == false) then
                if v72.Quest.CurrentQuest.Value == "None" or u62.QuestInfo.Type == "Find" then
                    if u62.QuestInfo.Type == "Find" and (v72.Quest.CurrentQuest.Value == u62.QuestName and (game.Players.LocalPlayer.Backpack:FindFirstChild(u62.QuestInfo.MobName) or game.Players.LocalPlayer.Character:FindFirstChild(u62.QuestInfo.MobName))) then
                        u62 = v61["return item"]
                        game.ReplicatedStorage.Events.Quest:InvokeServer({ "returnitem" })
                        u100 = 1
                    elseif v72.Quest.CurrentQuest.Value ~= "None" then
                        u62 = v61["already have quest"]
                        u100 = 1
                    end
                else
                    u62 = v61["already have quest"]
                    u100 = 1
                end
            end
            if game.Players.LocalPlayer.QuestCD.Value == true and (u62 ~= v61["return item"] and u62.QuestInfo ~= nil) then
                u62 = v61["quest cooldown"]
                u100 = 1
            end
        end
        local _, v122 = pcall(function() --[[ Line: 432 ]]
            --[[
            Upvalues:
                [1] = u100
                [2] = u70
                [3] = u103
                [4] = u104
                [5] = u101
                [6] = u102
                [7] = u62
                [8] = u2
                [9] = u73
                [10] = u54
                [11] = u53
                [12] = u13
            --]]
            for v107 = 1, u100 do
                u70.Humanoid.WalkSpeed = 0
                if u103 then
                    u103:disconnect()
                    u103 = nil
                end
                if u104 then
                    u104:disconnect()
                    u104 = nil
                end
                u101 = false
                u102 = false
                local u108 = u62["Talk" .. v107]
                if u108 ~= nil then
                    local v109 = {
                        ["SFX"] = true
                    }
                    local u110 = u2:New(u73.Frame.ImageLabel.desc, u108.Text, v109)
                    if u108.excu then
                        if u108.yield == nil then
                            task.spawn(function() --[[ Line: 454 ]]
                                --[[
                                Upvalues:
                                    [1] = u108
                                    [2] = u54
                                --]]
                                u108.excu(u54)
                            end)
                        else
                            u108.excu(u54)
                        end
                    end
                    u73.Frame.go.Visible = true
                    u73.Frame.stop.Visible = true
                    u73.Frame.go.Text = u108.go
                    u73.Frame.stop.Text = u108.stop
                    if u108.endtext == true then
                        u73.Frame.go.Text = ""
                        u73.Frame.stop.Text = ""
                        task.delay(1, function() --[[ Line: 468 ]]
                            --[[
                            Upvalues:
                                [1] = u73
                                [2] = u101
                            --]]
                            if u73:FindFirstChild("Frame") and u73.Frame.endChat.Visible == false then
                                u101 = true
                            end
                        end)
                    end
                    local u111 = nil
                    u111 = u53.InputBegan:Connect(function(p112) --[[ Line: 477 ]]
                        --[[
                        Upvalues:
                            [1] = u111
                            [2] = u110
                        --]]
                        if p112.UserInputType == Enum.UserInputType.MouseButton1 or p112.UserInputType == Enum.UserInputType.Touch then
                            u111:Disconnect()
                            u110:Show()
                        end
                    end)
                    u110:Animate(true)
                    if u100 <= v107 then
                        u73.Frame.endChat.Visible = true
                        local v113 = u73.Frame.endChat
                        local v114 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
                        local v115 = {
                            ["Size"] = script.ScreenGui.Frame.go.Size,
                            ["TextTransparency"] = 0
                        }
                        game:GetService("TweenService"):Create(v113, v114, v115):Play()
                        u73.Frame.endChat.MouseButton1Click:Connect(function() --[[ Line: 487 ]]
                            --[[
                            Upvalues:
                                [1] = u101
                                [2] = u13
                                [3] = u73
                            --]]
                            u101 = true
                            u13(u73.Frame.endChat, false)
                        end)
                    end
                    u111:Disconnect()
                    if u108.endtext == false then
                        task.wait(0.25)
                        local v116 = u73.Frame.go
                        local v117 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
                        local v118 = {
                            ["Size"] = script.ScreenGui.Frame.go.Size,
                            ["TextTransparency"] = 0
                        }
                        game:GetService("TweenService"):Create(v116, v117, v118):Play()
                        local v119 = u73.Frame.stop
                        local v120 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
                        local v121 = {
                            ["Size"] = script.ScreenGui.Frame.go.Size,
                            ["TextTransparency"] = 0
                        }
                        game:GetService("TweenService"):Create(v119, v120, v121):Play()
                    end
                    u103 = u73.Frame.go.MouseButton1Click:Connect(function() --[[ Line: 498 ]]
                        --[[
                        Upvalues:
                            [1] = u101
                            [2] = u108
                            [3] = u54
                        --]]
                        u101 = true
                        if u108.result then
                            u108.result(u54)
                        end
                    end)
                    u104 = u73.Frame.stop.MouseButton1Click:Connect(function() --[[ Line: 505 ]]
                        --[[
                        Upvalues:
                            [1] = u101
                            [2] = u102
                        --]]
                        u101 = true
                        u102 = true
                    end)
                    if u100 <= v107 then
                        task.wait(1)
                    end
                    repeat
                        game["Run Service"].Heartbeat:Wait()
                    until u101 == true
                    u13(u73.Frame.go, false)
                    u13(u73.Frame.stop, false)
                    task.wait(0.25)
                    if u102 == true then
                        u2:New(u73.Frame.ImageLabel.desc, u108.stoptext, v109):Animate(true)
                        task.wait(0.5)
                        return
                    end
                    if u108.afterEnd ~= nil then
                        u108.afterEnd(u54)
                    end
                end
            end
        end)
        if v122 then
            warn(v122)
        end
        local v123 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
        game:GetService("TweenService"):Create(u73.Frame.ImageLabel, v123, {
            ["ImageTransparency"] = 1
        }):Play()
        u30(u73)
        if v87 then
            v87:Stop(0.25)
            if u54 and u54.PrimaryPart then
                local v124 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
                game:GetService("TweenService"):Create(u54.PrimaryPart, v124, {
                    ["CFrame"] = v88
                }):Play()
            end
        end
        u62 = {}
        u62 = nil
        task.wait(0.25)
        if u54 and (u54.PrimaryPart and (u54.Parent == workspace.NPCs and u54.Info:FindFirstChild("RoamingNPC"))) then
            warn("invoked server!")
            game.ReplicatedStorage.Events.NPCChat:InvokeServer(u54)
        end
        _G.canuse = true
        v71:Destroy()
        u70.Humanoid.WalkSpeed = 16
        _G.hideUI(false)
        u73:Destroy()
    end
end
function v1.getquests(_) --[[ Line: 572 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    return u5
end
local function u130(p125) --[[ Line: 576 ]]
    --[[
    Upvalues:
        [1] = u130
    --]]
    local v126 = {}
    for v127, v129 in pairs(p125) do
        if type(v129) == "table" then
            local v129 = u130(v129)
        end
        v126[v127] = v129
    end
    return v126
end
function v1.getmob_formquest(_, p131, p132) --[[ Line: 587 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u130
    --]]
    local v133 = nil
    local v134 = nil
    local v135 = nil
    for _, v136 in u5 do
        if v136.QuestName == p131 then
            local v137 = v136.QuestInfo
            if p132 and v137.MultiQuest ~= nil then
                v137 = v137.MultiQuest[p132]
            end
            if v137 ~= nil then
                v134 = v137.MobName
                if p132 == nil or v137.MultiQuest == nil then
                    v135 = v136
                else
                    v135 = u130(v136)
                    v135.QuestInfo = v137
                end
                if v136.noNPC == nil then
                    local v138 = workspace.NPCs:FindFirstChild(v136.NPC)
                    if v138 == nil then
                        if game["Run Service"]:IsClient() then
                            return v134, v135, workspace.NPCs:WaitForChild(v136.NPC, 2)
                        else
                            return v134, v135, _G.npcStorageFolder:FindFirstChild(v136.NPC)
                        end
                    else
                        return v134, v135, v138
                    end
                end
                break
            end
        end
    end
    return v134, v135, v133
end
function v1.getquest_formname(_, p139) --[[ Line: 626 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v140 = nil
    local v141 = nil
    for _, v142 in u5 do
        if v142.NPC == p139 then
            return v142.QuestInfo.MobName, v142
        end
    end
    return v140, v141
end
return v1