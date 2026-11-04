 

local u1 = game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("HttpService")
local u4 = game.Players.LocalPlayer
local u5 = u4.PlayerGui
local u6 = workspace.CurrentCamera
local u7 = require(script.Recommended)
local u8 = require(u2.Modules.NPCInteractions):getquests()
local u9 = require(u2.Modules.Client.UIUtils)
local u10 = require(u2.Modules.Leveling)
local u82 = {
    ["Initialized"] = false,
    ["Initialize"] = function(u11) --[[ Name: Initialize, Line 18 ]]
        --[[
        Upvalues:
            [1] = u82
            [2] = u2
            [3] = u5
            [4] = u3
            [5] = u8
            [6] = u7
            [7] = u4
            [8] = u10
            [9] = u1
            [10] = u6
            [11] = u9
        --]]
        if not u82.Initialized then
            local u12 = u2:WaitForChild("reservedCode")
            local u13 = u5:WaitForChild("QuestTracker", 360)
            local function v14() --[[ Line: 26 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u13
                --]]
                if u12.Value == "arena" or (_G.isCustomHUB == true or _G.arena == true) then
                    u13.Enabled = false
                end
            end
            if u12.Value == "arena" or (_G.isCustomHUB == true or _G.arena == true) then
                u13.Enabled = false
            end
            u12:GetPropertyChangedSignal("Value"):Connect(v14)
            local u15 = u11:GetStatsFolder()
            local u16 = u15.Stats.Level
            local u17 = u2.Events.Quest:InvokeServer({ "getQuestLocations" })
            local u18 = script:WaitForChild("Marker")
            local u19 = u5:WaitForChild("UIIndicator", 360)
            local v20 = u13.QuestTracker
            local u21 = u13.Main
            local u22 = u21.QuestDescription
            local u23 = u21.Reccommended
            local _ = v20.ItemNum
            local u24 = u21.Track
            local u25 = u21.CompassOutline.Compass
            local u26 = u25.Arrow
            local u27 = game.ReplicatedStorage:FindFirstChild("2ndSea") == nil and "FirstSea" or "SecondSea"
            local function v30(p28) --[[ Line: 60 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u3
                    [3] = u15
                --]]
                if p28 then
                    if p28.lvlReq then
                        if p28.QuestInfo then
                            if p28.QuestInfo.Rewards then
                                if u17[p28.NPC] then
                                    if p28.noNPC == nil then
                                        if p28.MiscQuest == nil then
                                            for _, v29 in u3:JSONDecode(u15.Quest.CompletedQuests.Value) do
                                                if p28.QuestName == v29 then
                                                    return
                                                end
                                            end
                                            return true
                                        end
                                    end
                                else
                                    return
                                end
                            else
                                return
                            end
                        else
                            return
                        end
                    else
                        return
                    end
                else
                    return
                end
            end
            local u31 = false
            local u32 = nil
            local u33 = false
            local u34 = nil
            for _, v35 in u8 do
                if v35.NPC and v30(v35) ~= nil then
                    local v36 = v35.customQuestPosition or nil
                    if v36 then
                        u17[v35.NPC] = CFrame.new(v36)
                    end
                    local v37 = u7.Quests
                    local v38 = {
                        ["NPC"] = v35.NPC,
                        ["Description"] = ("Find %* and do their quest!"):format(v35.NPC),
                        ["LevelRequirement"] = v35.lvlReq,
                        ["QuestName"] = v35.QuestName,
                        ["Position"] = v36 or u17[v35.NPC].Position
                    }
                    table.insert(v37, v38)
                end
            end
            table.sort(u7.Quests, function(p39, p40) --[[ Line: 99 ]]
                return p39.LevelRequirement < p40.LevelRequirement
            end)
            local function u45() --[[ Line: 106 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u27
                    [3] = u16
                    [4] = u11
                    [5] = u4
                --]]
                if u7.MaxLevel[u27] and u7.MaxLevel[u27].LevelRequirement <= u16.Value then
                    return u7.MaxLevel[u27]
                end
                u11:GetStatsFolder()
                local v41 = u7.Quests[1]
                local v42 = (1 / 0)
                for _, v43 in u7.Quests do
                    if v43.LevelRequirement > u16.Value then
                        return v41
                    end
                    local v44 = (u4.Character.HumanoidRootPart.Position - v43.Position).Magnitude
                    if v43.LevelRequirement > v41.LevelRequirement or v43.LevelRequirement == v41.LevelRequirement and v44 < v42 then
                        v42 = v44
                        v41 = v43
                    end
                end
                return v41
            end
            local u46 = nil
            local function u81() --[[ Line: 129 ]]
                --[[
                Upvalues:
                    [1] = u32
                    [2] = u45
                    [3] = u22
                    [4] = u13
                    [5] = u15
                    [6] = u10
                    [7] = u12
                    [8] = u23
                    [9] = u46
                    [10] = u17
                    [11] = u31
                    [12] = u25
                    [13] = u21
                    [14] = u33
                    [15] = u34
                    [16] = u1
                    [17] = u6
                    [18] = u26
                    [19] = u18
                --]]
                u32 = u45()
                if u32 then
                    if u15.Stats.Level.Value >= u10.MaxLevel then
                        u13.Enabled = false
                        return
                    else
                        u13.Enabled = true
                        if u12.Value == "arena" or (_G.isCustomHUB == true or _G.arena == true) then
                            u13.Enabled = false
                        end
                        if u13.Enabled == false then
                            return
                        else
                            u22.Text = u32.Description
                            u23.Text = u32.QuestName
                            if u46 ~= u32 then
                                _G.displayMessage("<Color=Green>New recommended quest ready!")
                            end
                            u46 = u32
                            local u47 = u17[u32.NPC]
                            if u47 then
                                if u31 then
                                    u25.Parent = u21.CompassOutline
                                elseif u33 or not u34 then
                                    if u33 then
                                        u25.Parent = u13.QuestTracker.Compass
                                    end
                                else
                                    u34:Disconnect()
                                    u34 = nil
                                end
                                if u33 then
                                    if u34 then
                                        u34:Disconnect()
                                        u34 = nil
                                    end
                                    u34 = u1.RenderStepped:Connect(function() --[[ Line: 171 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u6
                                            [2] = u47
                                            [3] = u26
                                            [4] = u18
                                        --]]
                                        local v48 = u6.CFrame:ToObjectSpace(u47)
                                        local v49 = v48.Z
                                        local v50 = v48.X
                                        local v51 = math.atan2(v49, v50) + 3.141592653589793
                                        u26.Rotation = math.deg(v51)
                                        if u18.Parent ~= script then
                                            local v52 = u6.ViewportSize.X
                                            local v53 = u6.ViewportSize.Y
                                            local v54 = u18.AbsoluteSize.X
                                            local v55 = v52 - v54 * 2
                                            local v56 = v53 - v54 * 2
                                            local v57 = u6.CFrame
                                            local v58 = (v55 / 2) ^ 2 + (v56 / 2) ^ 2
                                            local v59 = math.sqrt(v58)
                                            local v60 = v57.LookVector
                                            local _ = Vector2.new(v60.X, v60.Z).Unit
                                            local v61 = u47.Position
                                            local v62, v63 = u6:WorldToViewportPoint(v61)
                                            local v64 = v62.X
                                            local v65 = v52 - v54
                                            local v66 = math.clamp(v64, v54, v65)
                                            local v67 = v62.Y
                                            local v68 = v53 - v54
                                            local v69 = math.clamp(v67, v54, v68)
                                            if v66 ~= v62.X or (v69 ~= v62.Y or not v63) then
                                                local v70 = v57:VectorToObjectSpace(v61 - v57.Position)
                                                local v71 = Vector2.new(v70.X, v70.Y).Unit
                                                local v72 = v71 * v59
                                                local v73 = v71.X
                                                local v74 = v71.Y
                                                math.atan2(v73, v74)
                                                local v75 = v72.Y
                                                local v76
                                                if math.abs(v75) > v56 / 2 then
                                                    local v77 = v56 / 2 / v71.Y
                                                    v76 = v71 * math.abs(v77)
                                                else
                                                    local v78 = v55 / 2 / v71.X
                                                    v76 = v71 * math.abs(v78)
                                                end
                                                v66 = v52 / 2 + v76.X
                                                v69 = v53 / 2 - v76.Y
                                            end
                                            u18.Position = UDim2.fromOffset(v66, v69)
                                            local v79 = u18.Distance
                                            local v80 = v48.Position.Magnitude
                                            v79.Text = ("%*m"):format((math.ceil(v80)))
                                        end
                                    end)
                                end
                            end
                        end
                    end
                else
                    u22.Text = "No quests ATM"
                    u13.Enabled = false
                    return
                end
            end
            u24.MouseButton1Click:Connect(function() --[[ Line: 229 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u9
                    [3] = u32
                    [4] = u24
                    [5] = u18
                    [6] = u19
                    [7] = u81
                --]]
                u33 = not u33
                u9.ButtonEffect()
                if u33 and u32 then
                    u24.InsideText.Text = "Stop Tracking"
                    u24.ImageColor3 = Color3.fromRGB(255, 14, 14)
                    u18.Parent = u19
                else
                    u24.InsideText.Text = "Track Quest"
                    u24.ImageColor3 = Color3.fromRGB(115, 255, 0)
                    u18.Parent = script
                end
                u81()
            end)
            v20.MouseButton1Click:Connect(function() --[[ Line: 248 ]]
                --[[
                Upvalues:
                    [1] = u31
                    [2] = u21
                    [3] = u81
                --]]
                u31 = not u31
                u21.Visible = u31
                u81()
            end)
            u15.Quest.CurrentQuest.Changed:Connect(function() --[[ Name: markerVisiblity, Line 255 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u18
                    [3] = u15
                    [4] = u81
                --]]
                if u33 then
                    u18.Visible = u15.Quest.CurrentQuest.Value == "None"
                    u81()
                end
            end)
            u16.Changed:Connect(u81)
            u81()
            u82.Initialized = true
        end
    end
}
return u82