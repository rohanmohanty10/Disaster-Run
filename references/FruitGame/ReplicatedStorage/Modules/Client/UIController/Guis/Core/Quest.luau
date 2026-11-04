 

local u1 = game:GetService("ReplicatedStorage")
local u2 = game.Players.LocalPlayer
local u3 = u2.PlayerGui
local v4 = u1.Modules
local v5 = v4.Shared
local u6 = require(v5:WaitForChild("GamePlaceInfo"))
local v7 = require(v4:WaitForChild("NPCInteractions"))
local u8 = require(game.ReplicatedStorage.Modules.Trove)
local u9 = v7:getquests()
local u48 = {
    ["Initialized"] = false,
    ["Initialize"] = function(u10) --[[ Name: Initialize, Line 28 ]]
        --[[
        Upvalues:
            [1] = u48
            [2] = u3
            [3] = u1
            [4] = u9
            [5] = u2
            [6] = u8
            [7] = u6
        --]]
        if u48.Initialized then
            return
        else
            local u11 = u3:WaitForChild("Quest", 360)
            local u12 = u11:WaitForChild("Main")
            local v13 = u12:WaitForChild("Info")
            local u14 = v13:WaitForChild("Bar"):WaitForChild("Fill")
            local v15 = v13:WaitForChild("Top")
            local u16 = v15:WaitForChild("QuestName")
            local u17 = v15:WaitForChild("Progress")
            local u18 = u12:WaitForChild("Misc")
            local u19 = u18:WaitForChild("Quit")
            if _G.isCustomHUB == true or _G.arena == true then
                u11.Enabled = false
            else
                local u20 = u10:GetStatsFolder()
                local v21 = u20.Quest
                local u22 = v21.CurrentQuest
                local u23 = v21.QuestProgress
                local u24 = nil
                u19.MouseButton1Click:Connect(function() --[[ Line: 72 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                        [2] = u22
                        [3] = u1
                        [4] = u19
                        [5] = u12
                        [6] = u24
                    --]]
                    u10.UIUtils.ButtonEffect()
                    if u22.Value ~= "None" then
                        u1.Events.Quest:InvokeServer({ "quit" })
                        u19.Visible = false
                        u12.Visible = false
                        print("reset quest")
                        if u24 then
                            u24:Destroy()
                            u24 = nil
                        end
                    end
                end)
                local function u46(p25) --[[ Line: 85 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                        [2] = u12
                        [3] = u19
                        [4] = u11
                        [5] = u24
                        [6] = u20
                        [7] = u16
                        [8] = u18
                        [9] = u23
                        [10] = u2
                        [11] = u17
                        [12] = u14
                        [13] = u8
                    --]]
                    warn("update quest")
                    for _, v27 in u9 do
                        if p25 == v27.QuestName then
                            goto l4
                        end
                    end
                    local v27 = nil
                    ::l4::
                    u12.Visible = v27 ~= nil
                    if p25 ~= "None" then
                        u12.Visible = true
                    end
                    u19.Visible = u12.Visible
                    u11.Enabled = false
                    if p25 == "None" then
                        print("reset quest")
                        if u24 then
                            u24:Destroy()
                            u24 = nil
                        end
                    else
                        print("reset quest")
                        if u24 then
                            u24:Destroy()
                            u24 = nil
                        end
                        if v27 then
                            local v28 = u20.Quest.MultiQuestProgress.Value
                            local u29 = v27.QuestInfo
                            if v28 > 0 and v27.QuestInfo.MultiQuest ~= nil then
                                u29 = v27.QuestInfo.MultiQuest[v28]
                            end
                            u16.Text = u29.Type
                            if u29.MiscType ~= nil then
                                u16.Text = u29.MiscType
                            end
                            u16.Shadow.Text = u16.Text
                            local v30 = u29.Rewards
                            local v31 = u18:GetChildren()
                            for v32 = 1, #v31 do
                                if v31[v32]:GetAttribute("reward") then
                                    v31[v32]:Destroy()
                                end
                            end
                            if v30 and u29.hideRewards == nil then
                                u18.title.Visible = true
                                for v33, v34 in pairs(v30) do
                                    if v33 == "Items" then
                                        for v35, v36 in pairs(v34) do
                                            local v37 = script.title:Clone()
                                            v37.Name = v35
                                            v37.Text = v36 .. "x " .. v35
                                            v37.Parent = u18
                                        end
                                    else
                                        local v38 = script.title:Clone()
                                        v38.Name = v33
                                        v38.Text = v34 .. " " .. v33
                                        v38.Parent = u18
                                    end
                                end
                            else
                                u18.title.Visible = false
                            end
                            local function u45() --[[ Line: 145 ]]
                                --[[
                                Upvalues:
                                    [1] = u23
                                    [2] = u29
                                    [3] = u2
                                    [4] = u17
                                    [5] = u14
                                --]]
                                if u23 ~= nil and u29 ~= nil then
                                    local v39 = u23.Value
                                    local v40 = u29.Ammount
                                    if u29.customProgress ~= nil then
                                        local v41, v42 = u29.customProgress(u2)
                                        local v43 = v41 == nil and 0 or v41
                                        v40 = v42 == nil and 1 or v42
                                        v39 = math.floor(v43)
                                    end
                                    local v44 = v39 / v40
                                    u17.Text = ("%* / %* %*"):format(v39, v40, u29.MobName)
                                    u17.Shadow.Text = u17.Text
                                    u14:TweenSize(UDim2.new(v44, 0, 1, 0), "Out", "Quad", 0.25, true)
                                end
                            end
                            u24 = u8.new()
                            u24:Connect(u23.Changed, u45)
                            u24:Add(task.spawn(function() --[[ Line: 178 ]]
                                --[[
                                Upvalues:
                                    [1] = u45
                                --]]
                                while true do
                                    u45()
                                    task.wait(0.3)
                                end
                            end))
                            u45()
                        end
                        u11.Enabled = true
                    end
                end
                u20.Quest.MultiQuestProgress.Changed:Connect(function() --[[ Line: 191 ]]
                    --[[
                    Upvalues:
                        [1] = u46
                        [2] = u22
                    --]]
                    u46(u22.Value)
                end)
                u22.Changed:Connect(u46)
                u46(u22.Value)
                local v47 = u6:GetPlaceIds()[game.PlaceId]
                if v47 ~= nil and v47 == "Trade Hub" then
                    u11.Enabled = false
                end
                warn("Quest Initialized")
                u48.Initialized = true
            end
        end
    end
}
return u48