 

local u1 = game:GetService("TweenService")
local u2 = game:GetService("MarketplaceService")
local u3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("Players")
local v5 = u3.Modules.Shared
local u6 = require(v5.CrewUtils)
local u7 = require(v5.Marketplace.Products)
local v8 = {}
local u9 = {}
function GetNameFromUserId(p10)
    --[[
    Upvalues:
        [1] = u9
        [2] = u4
    --]]
    local u11 = p10.UserId
    if u11 == nil then
        return nil
    end
    if typeof(u11) ~= "number" then
        return nil
    end
    local v12 = u9[u11]
    if v12 then
        return v12
    end
    local u13 = nil
    local v14, _ = pcall(function() --[[ Line: 27 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u4
            [3] = u11
        --]]
        u13 = u4:GetNameFromUserIdAsync(u11)
    end)
    if v14 then
        u9[u11] = u13
    end
    return u13
end
function v8.Setup(u15, u16) --[[ Line: 38 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u2
        [4] = u7
        [5] = u6
        [6] = u1
    --]]
    local u17 = u15.CrewsUI
    local v18 = u15.Frame
    local v19 = v18:WaitForChild("Crew")
    local u20 = v19:WaitForChild("View")
    local u21 = u20:WaitForChild("Info")
    local v22 = u20:WaitForChild("Members")
    local v23 = v22:WaitForChild("RankSelection")
    local u24 = v23:WaitForChild("AvailableRanks")
    local v25 = v23:WaitForChild("RankListButton")
    local u26 = v23:WaitForChild("CurrentRank")
    local u27 = nil
    local u28 = v19:WaitForChild("Configure")
    local u29 = u28:WaitForChild("Info")
    local v30 = u28:WaitForChild("Pages")
    local v31 = v30:WaitForChild("Options")
    local u32 = v30:WaitForChild("Tabs")
    local u33 = v19:WaitForChild("ConfigureButton")
    local v34 = v18:WaitForChild("NoCrew")
    local u35 = v34:WaitForChild("Input"):WaitForChild("TextBox")
    local u36 = v34:WaitForChild("Create")
    local u37 = v34:WaitForChild("CreateWithRobux")
    local u38 = u37:WaitForChild("Tokens")
    local u39 = {}
    local u40 = {}
    os.clock()
    local u41 = false
    u36.MouseButton1Click:Connect(function() --[[ Line: 78 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u35
            [3] = u17
            [4] = u41
            [5] = u36
            [6] = u37
        --]]
        u16.UIUtils.ButtonEffect()
        local v42 = u35.Text or ""
        if v42 == "" then
            u17.Notify("Error", "Invalid Input (Empty)")
            return
        else
            local v43 = v42:len()
            if v43 > 20 then
                u17.Notify("Error", "Invalid Input (Too many Characters - 20 Max)")
                return
            elseif v43 < 3 then
                u17.Notify("Error", "Invalid Input (Too little Characters - 3 Min)")
                return
            elseif u41 == true then
                u17.Notify("Error", "Wait for previous action to finish")
            else
                u41 = true
                u36.Visible = false
                u37.Visible = false
                task.delay(10, function() --[[ Line: 112 ]]
                    --[[
                    Upvalues:
                        [1] = u36
                        [2] = u37
                    --]]
                    u36.Visible = true
                    u37.Visible = true
                end)
                local v44 = u17.Notify("Information", "Creating Crew")
                local v45, v46 = u17.UIClient:GetRemote():InvokeServer({
                    ["Method"] = "CreateCrew",
                    ["CrewName"] = u35.Text
                })
                u17.RemoveNotification(v44, true)
                print("success", v46)
                print("msg", v45)
                if v45 then
                    u17.Notify(v46 == nil and "Error" or "Success", v45)
                end
                u36.Visible = true
                u37.Visible = true
                u41 = false
            end
        end
    end)
    task.spawn(function() --[[ Line: 136 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u17
            [4] = u38
        --]]
        local v47 = u3:WaitForChild("Stats" .. u4.LocalPlayer.Name)
        if v47 then
            local v48 = v47:WaitForChild("Stats")
            if v48 then
                local u49 = v48:WaitForChild("CrewToken")
                if u49 then
                    u38.Text = "Crew Tokens: " .. u49.Value
                    u49:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 157 ]]
                        --[[
                        Upvalues:
                            [1] = u38
                            [2] = u49
                        --]]
                        u38.Text = "Crew Tokens: " .. u49.Value
                    end)
                else
                    u17.Notify("Information", "Crew token data not loaded yet!")
                end
            else
                u17.Notify("Information", "Stats data not loaded yet!")
                return
            end
        else
            u17.Notify("Information", "Data not loaded yet!")
            return
        end
    end)
    u37.MouseButton1Click:Connect(function() --[[ Line: 162 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u3
            [3] = u4
            [4] = u17
            [5] = u2
            [6] = u7
            [7] = u35
            [8] = u41
            [9] = u36
            [10] = u37
        --]]
        u16.UIUtils.ButtonEffect()
        local v50 = u3:FindFirstChild("Stats" .. u4.LocalPlayer.Name)
        if v50 then
            local v51 = v50:FindFirstChild("Stats")
            if v51 then
                local v52 = v51:FindFirstChild("CrewToken")
                if v52 then
                    if v52.Value == 0 then
                        u2:PromptProductPurchase(u4.LocalPlayer, u7:GetProductIdByPlace("Create Crew"))
                        return
                    else
                        local v53 = u35.Text or ""
                        if v53 == "" then
                            u17.Notify("Error", "Invalid Input (Empty)")
                            return
                        else
                            local v54 = v53:len()
                            if v54 > 20 then
                                u17.Notify("Error", "Invalid Input (Too many Characters - 20 Max)")
                                return
                            elseif v54 < 3 then
                                u17.Notify("Error", "Invalid Input (Too little Characters - 3 Min)")
                                return
                            elseif u41 == true then
                                u17.Notify("Error", "Wait for previous action to finish")
                            else
                                u41 = true
                                u36.Visible = false
                                u37.Visible = false
                                task.delay(10, function() --[[ Line: 219 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u36
                                        [2] = u37
                                    --]]
                                    u36.Visible = true
                                    u37.Visible = true
                                end)
                                local v55 = u17.Notify("Information", "Creating Crew")
                                local v56, v57 = u17.UIClient:GetRemote():InvokeServer({
                                    ["Method"] = "CreateCrew",
                                    ["CrewName"] = u35.Text,
                                    ["WithRobux"] = true
                                })
                                u17.RemoveNotification(v55, true)
                                print("success", v57)
                                print("msg", v56)
                                if v57 and v56 then
                                    u17.Notify(v57 == nil and "Error" or "Success", v56)
                                end
                                u36.Visible = true
                                u37.Visible = true
                                u41 = false
                            end
                        end
                    end
                else
                    u17.Notify("Information", "Crew token data not loaded yet!")
                    return
                end
            else
                u17.Notify("Information", "Stats data not loaded yet!")
                return
            end
        else
            u17.Notify("Information", "Data not loaded yet!")
            return
        end
    end)
    function u15.AddMember(_, _, _) --[[ Line: 246 ]]
        print("todo remove method")
    end
    function u15.RemoveMember(_, _) --[[ Line: 265 ]]
        print("todo remove method")
    end
    function u15.RemoveAllMembers(_) --[[ Line: 273 ]]
        print("todo remove method")
    end
    v25.MouseButton1Click:Connect(function() --[[ Line: 281 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u24
        --]]
        u16.UIUtils.ButtonEffect()
        u24.Visible = not u24.Visible
        if u24.Visible == true then
            u24.Parent.Arrow.Rotation = 180
        else
            u24.Parent.Arrow.Rotation = 0
        end
    end)
    local u58 = {}
    function u15.UpdateViewInfo(_, p59, p60, p61) --[[ Line: 307 ]]
        --[[
        Upvalues:
            [1] = u58
            [2] = u21
        --]]
        if u58[p59] == nil then
            local v62 = u21:FindFirstChild(p59)
            if v62 then
                u58[p59] = v62
                u58[p59][p60] = p61
            end
        else
            u58[p59][p60] = p61
        end
    end
    function u15.UpdateConfigureInfo(_, p63, p64, p65) --[[ Line: 320 ]]
        --[[
        Upvalues:
            [1] = u58
            [2] = u29
        --]]
        if u58[p63] == nil then
            local v66 = u29:FindFirstChild(p63)
            if v66 then
                u58[p63] = v66
                u58[p63][p64] = p65
            else
                print("Missing UIObject", v66)
            end
        else
            u58[p63][p64] = p65
            return
        end
    end
    local u67 = nil
    function u15.UpdateCachedData(_, p68) --[[ Line: 338 ]]
        --[[
        Upvalues:
            [1] = u67
            [2] = u21
            [3] = u6
        --]]
        warn(u67)
        if p68.ConquestPoints then
            u21.ConquestPoints.Cache.Text = ("(%s)"):format(p68.ConquestPoints)
        else
            u21.ConquestPoints.Cache.Text = ""
        end
        if p68.Infamy then
            u21.Infamy.Cache.Text = ("(%s)"):format(p68.Infamy)
        else
            u21.Infamy.Cache.Text = ""
        end
        if p68.MemberContribution then
            local v69 = os.date("!*t")
            local v70 = v69.month .. "_" .. v69.year
            for v71, v72 in pairs(p68.MemberContribution) do
                local v73 = u6.GetRankInCrewById(v71, u67)
                if v73 then
                    local v74 = u67.Members[v73][v71]
                    if v74 ~= nil and (v74.Infamy ~= nil and (v74.Infamy[v70] ~= nil and (v74.Gain ~= nil and v74.Lost ~= nil))) then
                        if v72 > 0 then
                            v74.Gain = v74.Gain + v72
                        else
                            v74.Lost = v74.Lost - math.abs(v72)
                        end
                    end
                end
            end
        end
    end
    local u75 = {}
    local v76 = u32:WaitForChild("Logo")
    local u77 = v76:WaitForChild("LogoImage")
    local v78 = v76:WaitForChild("Update")
    local u79 = v76:WaitForChild("Input"):WaitForChild("TextBox")
    u75.Logo = v76
    u79:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 389 ]]
        --[[
        Upvalues:
            [1] = u79
        --]]
        u79.Text = u79.Text:gsub("%D+", "")
    end)
    v78.MouseButton1Click:Connect(function() --[[ Line: 393 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u79
            [3] = u17
            [4] = u6
        --]]
        u16.UIUtils.ButtonEffect()
        local v80 = u79.Text or ""
        if v80 == "" then
            u17.Notify("Error", "Invalid Input (Empty)")
            return
        else
            local v81 = u17.UIClient:GetLastestData()
            if v81 == nil then
                u17.Notify("Error", "Please wait for crew data to load first")
                return
            elseif tonumber(v80) == v81.CrewImage then
                u17.Notify("Error", "Inputted crew image is the same as the current image")
                return
            else
                local v82, v83 = u6.IsImageIdValid((tonumber(v80)))
                if v82 == false then
                    u17.Notify("Error", v83 or "Invalid Image Id")
                else
                    local v84 = u17.Notify("Information", "Updating Crew Image")
                    local v85, v86 = u17.UIClient:GetRemote():InvokeServer({
                        ["Method"] = "UpdateCrewLogo",
                        ["CrewImage"] = v80
                    })
                    u17.RemoveNotification(v84, true)
                    u17.Notify(v86 == nil and "Error" or "Success", v85)
                end
            end
        end
    end)
    function u15.UpdateLogoImage(_, p87) --[[ Line: 432 ]]
        --[[
        Upvalues:
            [1] = u77
        --]]
        u77.Image = p87
    end
    local u88 = script:WaitForChild("MemberTemplateButton")
    local u89 = u32:WaitForChild("Members")
    local u90 = u89:WaitForChild("List")
    local u91 = u89:WaitForChild("ConfigureMember")
    local v92 = u91:WaitForChild("Close")
    local u93 = u91:WaitForChild("MemberInfo")
    local v94 = u93:WaitForChild("Kick")
    local u95 = u93:WaitForChild("Confirmation")
    local u96 = u89:WaitForChild("Search"):WaitForChild("TextBox")
    local u97 = false
    local u98 = nil
    v94.MouseButton1Click:Connect(function() --[[ Line: 452 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u97
            [3] = u98
            [4] = u95
            [5] = u17
            [6] = u91
        --]]
        u16.UIUtils.ButtonEffect()
        if u97 == true then
            return
        elseif u98 == nil then
            return
        elseif u95.Visible == true then
            u97 = true
            local v99 = u17.Notify("Information", "Kicking player...")
            local v100 = {
                ["Method"] = "KickMember",
                ["UserIdToKick"] = u98
            }
            local v101, v102 = u17.UIClient:GetRemote():InvokeServer(v100)
            u17.RemoveNotification(v99, true)
            u17.Notify(v102 == nil and "Error" or "Success", v101)
            if v102 then
                u91.Visible = false
                u98 = nil
            end
            u97 = false
            u95.Visible = false
        else
            u95.Visible = true
        end
    end)
    v92.MouseButton1Click:Connect(function() --[[ Line: 482 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u91
            [3] = u98
        --]]
        u16.UIUtils.ButtonEffect()
        u91.Visible = false
        u98 = nil
    end)
    local u103 = u93:WaitForChild("RankSelection")
    local u104 = u103:WaitForChild("AvailableRanks")
    local v105 = u103:WaitForChild("RankListButton")
    local u106 = u93:WaitForChild("Infamy")
    v105.MouseButton1Click:Connect(function() --[[ Line: 495 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u104
        --]]
        u16.UIUtils.ButtonEffect()
        u104.Visible = not u104.Visible
    end)
    local function u114(p107, p108) --[[ Line: 500 ]]
        --[[
        Upvalues:
            [1] = u91
            [2] = u98
            [3] = u6
            [4] = u67
            [5] = u93
            [6] = u103
            [7] = u106
        --]]
        u91.Visible = true
        u98 = p107
        local v109, v110 = u6.GetRankInCrewById(tostring(p107), u67 or {})
        u93.DisplayName.Text = p108
        u93.Portrait.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(p107)
        u103.CurrentRank.Text = v109 or "Unknown"
        if v110 then
            local v111 = os.date("!*t")
            local v112 = v111.month .. "_" .. v111.year
            if v110.Infamy then
                local v113 = v110.Infamy[v112]
                if v113 then
                    u106.Text = ("Gained: %s | Lost: %s"):format(v113.Gain, v113.Lost)
                else
                    u106.Text = ""
                end
            else
                u106.Text = ""
                return
            end
        else
            u106.Text = ""
            return
        end
    end
    local u115 = {}
    local v116 = v22:WaitForChild("PageOptions")
    local v117 = v116:WaitForChild("Left")
    local v118 = v116:WaitForChild("Right")
    local u119 = v116:WaitForChild("Current")
    local u120 = v22:WaitForChild("Pages")
    local u121 = nil
    v117.MouseButton1Click:Connect(function() --[[ Line: 545 ]]
        --[[
        Upvalues:
            [1] = u121
            [2] = u119
        --]]
        u121:Previous()
        u119.Text = "Page " .. u121.CurrentPage.LayoutOrder
    end)
    v118.MouseButton1Click:Connect(function() --[[ Line: 550 ]]
        --[[
        Upvalues:
            [1] = u121
            [2] = u119
        --]]
        u121:Next()
        u119.Text = "Page " .. u121.CurrentPage.LayoutOrder
    end)
    function u15.RemoveAllViewPageObjects(_) --[[ Line: 555 ]]
        --[[
        Upvalues:
            [1] = u40
            [2] = u115
        --]]
        for _, v122 in pairs(u40) do
            v122:Destroy()
        end
        for _, v123 in pairs(u115) do
            v123:Destroy()
        end
    end
    function u15.CreateViewPageMembers(p124, p125) --[[ Line: 565 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u40
            [3] = u120
            [4] = u115
            [5] = u121
            [6] = u26
            [7] = u27
            [8] = u16
            [9] = u119
        --]]
        local v126 = p125.Members
        local v127 = p125.Ranks
        p124:RemoveAllViewPageObjects()
        for v128, v129 in pairs(v126) do
            local v130 = v127[v128]
            local u131 = script.ChangeRankTemplate:Clone()
            u131.Name = v128
            u131.LayoutOrder = v130.Id
            u131.Text = v128
            u131.Parent = u24
            u40[v128] = u131
            local u132 = script.PageTemplate:Clone()
            u132.Name = v128
            u132.Parent = u120
            u132.Visible = v130.IsDefault
            u115[v128] = u132
            if v130.IsDefault then
                u121 = u132.UIPageLayout
                u26.Text = v128
                u27 = u131
                u27.UIStroke.Enabled = true
            end
            local v133 = 0
            local v134 = 0
            local v135 = 0
            local v136 = nil
            v135 = v135 + 1
            local v137 = script.MemberPageTemplate:Clone()
            v137.Name = v135
            v137.LayoutOrder = v135
            v137.Parent = u132
            v136 = v137
            local v138 = v135
            for u139, _ in pairs(v129) do
                if v134 == 5 then
                    v135 = v138 + 1
                    local v140 = script.MemberPageTemplate:Clone()
                    v140.Name = v135
                    v140.LayoutOrder = v135
                    v140.Parent = u132
                    v136 = v140
                    v138 = v135
                    v134 = 0
                end
                local u141 = script.MemberTemplate:Clone()
                u141.Name = u139
                u141.Parent = v136
                u141.PortraitFrame.Portrait.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(u139)
                task.spawn(function() --[[ Line: 629 ]]
                    --[[
                    Upvalues:
                        [1] = u141
                        [2] = u139
                    --]]
                    local v142 = u141.NameFrame.Username
                    local v143 = GetNameFromUserId
                    local v144 = {}
                    local v145 = u139
                    v144.UserId = tonumber(v145)
                    v142.Text = v143(v144) or "Failed to load name"
                end)
                v133 = v133 + 1
                v134 = v134 + 1
            end
            u131.Text = v128 .. " (" .. v133 .. ")"
            u131.MouseButton1Click:Connect(function() --[[ Line: 645 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u27
                    [3] = u131
                    [4] = u121
                    [5] = u132
                    [6] = u119
                --]]
                u16.UIUtils.ButtonEffect()
                if u27 ~= u131 then
                    if u27 ~= nil then
                        u27.UIStroke.Enabled = false
                    end
                    u27 = u131
                    u27.UIStroke.Enabled = true
                    u121.Parent.Visible = false
                    u121 = u132.UIPageLayout
                    u132.Visible = true
                    u121:JumpToIndex(0)
                    u119.Text = "Page " .. u121.CurrentPage.LayoutOrder
                end
            end)
        end
    end
    function u15.CreateAvailableRanks(p146, p147) --[[ Line: 681 ]]
        --[[
        Upvalues:
            [1] = u67
            [2] = u39
            [3] = u104
            [4] = u16
            [5] = u97
            [6] = u98
            [7] = u103
            [8] = u17
        --]]
        u67 = p147
        local v148 = p147.Ranks
        for u149, v150 in pairs(v148) do
            if u39[u149] == nil and v150.IsAdministrator ~= true then
                local v151 = script.ChangeRankTemplate:Clone()
                v151.Parent = u104
                v151.Name = u149
                v151.LayoutOrder = v150.Id
                v151.Text = u149
                v151.MouseButton1Click:Connect(function() --[[ Line: 697 ]]
                    --[[
                    Upvalues:
                        [1] = u16
                        [2] = u97
                        [3] = u98
                        [4] = u103
                        [5] = u149
                        [6] = u17
                        [7] = u104
                    --]]
                    u16.UIUtils.ButtonEffect()
                    if u97 == true then
                        return
                    elseif u98 == nil then
                        return
                    elseif u103.CurrentRank.Text ~= u149 then
                        u97 = true
                        local v152 = u98
                        local v153 = u17.Notify("Information", "Adjusting player rank...")
                        local v154 = {
                            ["Method"] = "AdjustMemberRank",
                            ["UserIdToAdjust"] = u98,
                            ["NewRank"] = u149
                        }
                        local v155, v156 = u17.UIClient:GetRemote():InvokeServer(v154)
                        u17.RemoveNotification(v153, true)
                        u17.Notify(v156 == nil and "Error" or "Success", v155)
                        if v156 then
                            if v152 == u98 then
                                u103.CurrentRank.Text = u149
                            end
                            u104.Visible = false
                        end
                        u97 = false
                    end
                end)
                u39[u149] = v151
            end
        end
        for v157, v158 in pairs(u39) do
            if v148[v157] == nil then
                v158:Destroy()
                u39[v157] = nil
            end
        end
        p146:CreateViewPageMembers(p147)
    end
    local u159 = {}
    u96:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 751 ]]
        --[[
        Upvalues:
            [1] = u159
            [2] = u96
        --]]
        for _, v160 in pairs(u159) do
            v160.Visible = string.find(string.lower(v160.Name), string.lower(u96.Text))
        end
    end)
    function u15.AddConfigureMember(_, u161, u162) --[[ Line: 757 ]]
        --[[
        Upvalues:
            [1] = u159
            [2] = u88
            [3] = u90
            [4] = u16
            [5] = u98
            [6] = u91
            [7] = u114
        --]]
        if u159[u161] == nil then
            local v163 = u88:Clone()
            v163.Parent = u90
            v163.Name = u162 .. " (" .. u161 .. ")"
            v163.Portrait.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(u161)
            v163.Username.Text = u162
            v163.MouseButton1Click:Connect(function() --[[ Line: 770 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u98
                    [3] = u161
                    [4] = u91
                    [5] = u114
                    [6] = u162
                --]]
                u16.UIUtils.ButtonEffect()
                if u98 == u161 then
                    u91.Visible = false
                    u98 = nil
                else
                    u114(u161, u162)
                end
            end)
            u159[u161] = v163
        end
    end
    function u15.RemoveConfigureMember(_, p164) --[[ Line: 783 ]]
        --[[
        Upvalues:
            [1] = u159
        --]]
        if u159[p164] then
            u159[p164]:Destroy()
            u159[p164] = nil
        end
    end
    function u15.AddMembersToConfigure(p165, p166) --[[ Line: 791 ]]
        --[[
        Upvalues:
            [1] = u159
        --]]
        for v167, v168 in pairs(p166) do
            p165:AddConfigureMember(v167, v168)
        end
        for v169, _ in pairs(u159) do
            if p166[v169] == nil then
                p165:RemoveConfigureMember(v169)
            end
        end
    end
    function u15.RemoveAllConfigureMembers(_) --[[ Line: 803 ]]
        --[[
        Upvalues:
            [1] = u159
        --]]
        for v170, v171 in pairs(u159) do
            v171:Destroy()
            u159[v170] = nil
        end
    end
    u89:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 810 ]]
        --[[
        Upvalues:
            [1] = u89
            [2] = u91
            [3] = u98
        --]]
        if u89.Visible == false then
            u91.Visible = false
            u98 = nil
        end
    end)
    local u172 = script:WaitForChild("RankTemplate")
    local v173 = u32:WaitForChild("Ranks")
    local u174 = v173:WaitForChild("RankList")
    local v175 = v173:WaitForChild("RankInfo")
    local u176 = v175:WaitForChild("Delete")
    local v177 = v175:WaitForChild("Members")
    local u178 = v175:WaitForChild("Name")
    local u179 = v175:WaitForChild("Rank")
    local u180 = u178:WaitForChild("Apply")
    local u181 = u179:WaitForChild("Apply")
    local u182 = v177.Frame:WaitForChild("CanKick")
    local u183 = v177.Frame:WaitForChild("CanRank")
    local u184 = v177.Frame:WaitForChild("SpendFunds")
    local v185 = v173:WaitForChild("Create")
    local u186 = v173:WaitForChild("CreateBox")
    local u187 = {}
    local u188 = nil
    local u189 = nil
    local function u196(p190, p191) --[[ Line: 842 ]]
        --[[
        Upvalues:
            [1] = u178
            [2] = u179
            [3] = u180
            [4] = u181
            [5] = u182
            [6] = u183
            [7] = u184
            [8] = u176
        --]]
        local v192
        if p191.IsDefault then
            v192 = true
        else
            local _ = p191.IsAdministrator
            v192 = not p191.IsDefault
            if v192 then
                local v193 = not p191.IsAdministrator
                v192 = v193 and true or v193
            end
        end
        local _ = p191.IsDefault
        local _ = p191.IsAdministrator
        local v194 = not p191.IsDefault
        if v194 then
            local v195 = not p191.IsAdministrator
            v194 = v195 and true or v195
        end
        u178.Frame.Input.PlaceholderText = not v192 and "Cant Change" or p190.Name
        u178.Frame.Input.Text = not v192 and "Cant Change" or p190.Name
        u178.Frame.Input.TextEditable = v192
        u179.Frame.Input.PlaceholderText = not v194 and "Cant Change" or p191.Id
        u179.Frame.Input.Text = not v194 and "Cant Change" or p191.Id
        u179.Frame.Input.TextEditable = v194
        u180.Visible = false
        u181.Visible = false
        u182.Button.Visible = v194
        u183.Button.Visible = v194
        u184.Button.Visible = v194
        u182.ValueHolder.Visible = v194
        u183.ValueHolder.Visible = v194
        u184.ValueHolder.Visible = v194
        u184.ValueHolder.ButtonVisual.Position = p191.ManageFunds == true and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0, 0, 0.5, 0)
        u184.ValueHolder.BackgroundColor3 = p191.ManageFunds == true and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 4, 12)
        u182.ValueHolder.ButtonVisual.Position = p191.ManageMembers == true and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0, 0, 0.5, 0)
        u182.ValueHolder.BackgroundColor3 = p191.ManageMembers == true and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 4, 12)
        u183.ValueHolder.ButtonVisual.Position = p191.ManageMemberRank == true and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0, 0, 0.5, 0)
        u183.ValueHolder.BackgroundColor3 = p191.ManageMemberRank == true and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 4, 12)
        u176.Visible = v194
    end
    local u197 = false
    local u198 = u178:WaitForChild("Frame"):WaitForChild("Input")
    u198:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 886 ]]
        --[[
        Upvalues:
            [1] = u198
            [2] = u180
        --]]
        u198.Text = u198.Text:sub(1, 40)
        u180.Visible = u198.Text ~= u198.PlaceholderText
    end)
    u198.FocusLost:Connect(function() --[[ Line: 891 ]]
        --[[
        Upvalues:
            [1] = u198
        --]]
        if (u198.Text or "") == "" then
            u198.Text = u198.PlaceholderText
        end
    end)
    u180.MouseButton1Click:Connect(function() --[[ Line: 898 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u197
            [3] = u189
            [4] = u198
            [5] = u17
        --]]
        u16.UIUtils.ButtonEffect()
        if u197 == true then
            return
        elseif u189 == nil then
            return
        else
            local v199 = u198.Text or ""
            if v199 == "" then
                u17.Notify("Error", "Invalid Input (Empty)")
                return
            elseif v199 == u189.Name then
                u17.Notify("Information", "New rank name can not be the same as previous rank name!")
                return
            else
                local v200 = v199:len()
                if v200 > 40 then
                    u17.Notify("Error", "Invalid Input (Too many Characters - 40 Max)")
                    return
                elseif v200 < 1 then
                    u17.Notify("Error", "Invalid Input (Too little Characters - 3 Min)")
                else
                    u197 = true
                    local v201 = u17.Notify("Information", "Updating rank name...")
                    local v202, v203 = u17.UIClient:GetRemote():InvokeServer({
                        ["Method"] = "UpdateRankInfo",
                        ["Rank"] = u189.Name,
                        ["Action"] = "ChangeName",
                        ["NewValue"] = v199
                    })
                    u17.RemoveNotification(v201, true)
                    u17.Notify(v203 == nil and "Error" or "Success", v202)
                    u197 = false
                end
            end
        end
    end)
    local u204 = u179:WaitForChild("Frame"):WaitForChild("Input")
    u181.MouseButton1Click:Connect(function() --[[ Line: 947 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u197
            [3] = u189
            [4] = u204
            [5] = u17
            [6] = u188
        --]]
        u16.UIUtils.ButtonEffect()
        if u197 == true then
            return
        elseif u189 == nil then
            return
        else
            local v205 = u204.Text or ""
            if v205 == "" then
                u17.Notify("Error", "Invalid Input (Empty)")
                return
            else
                local v206 = tonumber(v205)
                if v206 then
                    local v207 = u188[u189.Name]
                    if v207 == nil then
                        u17.Notify("Error", "Issue occured with getting ranks information!")
                        return
                    elseif v207.Id == v206 then
                        u17.Notify("Information", "New rank Id can not be the same as previous rank Id!")
                    else
                        u197 = true
                        local v208 = u17.Notify("Information", "Updating rank id...")
                        local v209, v210 = u17.UIClient:GetRemote():InvokeServer({
                            ["Method"] = "UpdateRankInfo",
                            ["Rank"] = u189.Name,
                            ["Action"] = "ChangeRankId",
                            ["NewValue"] = v206
                        })
                        u17.RemoveNotification(v208, true)
                        u17.Notify(v210 == nil and "Error" or "Success", v209)
                        u197 = false
                    end
                else
                    u17.Notify("Error", "Invalid Input (Numbers Only)")
                    return
                end
            end
        end
    end)
    u204:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 995 ]]
        --[[
        Upvalues:
            [1] = u204
            [2] = u181
        --]]
        u204.Text = u204.Text:gsub("%D+", ""):sub(1, 3)
        u181.Visible = u204.Text ~= u204.PlaceholderText
    end)
    u204.FocusLost:Connect(function() --[[ Line: 1001 ]]
        --[[
        Upvalues:
            [1] = u204
        --]]
        if (u204.Text or "") == "" then
            u204.Text = u204.PlaceholderText
        end
    end)
    u182.Button.MouseButton1Click:Connect(function() --[[ Line: 1008 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u197
            [3] = u189
            [4] = u17
        --]]
        u16.UIUtils.ButtonEffect()
        if u197 == true then
            return
        elseif u189 ~= nil then
            u197 = true
            local v211 = u17.Notify("Information", "Updating rank data...")
            local v212, v213 = u17.UIClient:GetRemote():InvokeServer({
                ["Method"] = "UpdateRankInfo",
                ["Rank"] = u189.Name,
                ["Action"] = "ManageMembers",
                ["NewValue"] = "[ignore]"
            })
            u17.RemoveNotification(v211, true)
            u17.Notify(v213 == nil and "Error" or "Success", v212)
            u197 = false
        end
    end)
    u183.Button.MouseButton1Click:Connect(function() --[[ Line: 1030 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u197
            [3] = u189
            [4] = u17
        --]]
        u16.UIUtils.ButtonEffect()
        if u197 == true then
            return
        elseif u189 ~= nil then
            u197 = true
            local v214 = u17.Notify("Information", "Updating rank data...")
            local v215, v216 = u17.UIClient:GetRemote():InvokeServer({
                ["Method"] = "UpdateRankInfo",
                ["Rank"] = u189.Name,
                ["Action"] = "ManageMemberRank",
                ["NewValue"] = "[ignore]"
            })
            u17.RemoveNotification(v214, true)
            u17.Notify(v216 == nil and "Error" or "Success", v215)
            u197 = false
        end
    end)
    u184.Button.MouseButton1Click:Connect(function() --[[ Line: 1052 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u197
            [3] = u189
            [4] = u17
        --]]
        u16.UIUtils.ButtonEffect()
        if u197 == true then
            return
        elseif u189 ~= nil then
            u197 = true
            local v217 = u17.Notify("Information", "Updating rank data...")
            local v218, v219 = u17.UIClient:GetRemote():InvokeServer({
                ["Method"] = "UpdateRankInfo",
                ["Rank"] = u189.Name,
                ["Action"] = "ManageFunds",
                ["NewValue"] = "[ignore]"
            })
            u17.RemoveNotification(v217, true)
            u17.Notify(v219 == nil and "Error" or "Success", v218)
            u197 = false
        end
    end)
    local v220 = u176:WaitForChild("Delete")
    local u221 = u176:WaitForChild("Confirmation"):WaitForChild("TextBox")
    v220.MouseButton1Click:Connect(function() --[[ Line: 1078 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u197
            [3] = u221
            [4] = u17
            [5] = u189
        --]]
        u16.UIUtils.ButtonEffect()
        if u197 == true then
            return
        elseif u221.Text == "Yes" then
            u197 = true
            local v222 = u17.Notify("Information", "Deleting rank...")
            local v223, v224 = u17.UIClient:GetRemote():InvokeServer({
                ["Method"] = "UpdateRankInfo",
                ["Rank"] = u189.Name,
                ["Action"] = "DeleteRank",
                ["NewValue"] = "[Deleted Rank]"
            })
            u17.RemoveNotification(v222, true)
            u17.Notify(v224 == nil and "Error" or "Success", v223)
            if v224 then
                u221.Text = ""
            end
            u197 = false
        else
            u17.Notify("Error", "Please type \"Yes\" to confirm the action")
        end
    end)
    v185.MouseButton1Click:Connect(function() --[[ Line: 1107 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u186
        --]]
        u16.UIUtils.ButtonEffect()
        u186.Visible = not u186.Visible
    end)
    u186.Cancel.MouseButton1Click:Connect(function() --[[ Line: 1112 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u186
        --]]
        u16.UIUtils.ButtonEffect()
        u186.Visible = false
    end)
    local u225 = u186:WaitForChild("Frame"):WaitForChild("Input")
    u225:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 1119 ]]
        --[[
        Upvalues:
            [1] = u225
        --]]
        u225.Text = u225.Text:sub(1, 40)
    end)
    u186.Create.MouseButton1Click:Connect(function() --[[ Line: 1123 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u197
            [3] = u225
            [4] = u17
            [5] = u187
            [6] = u186
        --]]
        u16.UIUtils.ButtonEffect()
        if u197 == true then
            return
        else
            local v226 = u225.Text or ""
            if v226 == "" then
                u17.Notify("Error", "Invalid Input (Empty)")
                return
            elseif u187[v226] == nil then
                local v227 = v226:len()
                if v227 > 40 then
                    u17.Notify("Error", "Invalid Input (Too many Characters - 40 Max)")
                    return
                elseif v227 < 1 then
                    u17.Notify("Error", "Invalid Input (Too little Characters - 3 Min)")
                else
                    u197 = true
                    local v228 = u17.Notify("Information", "Creating rank...")
                    local v229, v230 = u17.UIClient:GetRemote():InvokeServer({
                        ["Method"] = "UpdateRankInfo",
                        ["Rank"] = "",
                        ["Action"] = "CreateRank",
                        ["NewValue"] = v226
                    })
                    u17.RemoveNotification(v228, true)
                    u17.Notify(v230 == nil and "Error" or "Success", v229)
                    if v230 then
                        u225.Text = ""
                        u186.Visible = false
                    end
                    u197 = false
                end
            else
                u17.Notify("Information", "A rank with the name " .. v226 .. " already exist!")
                return
            end
        end
    end)
    local function u233(p231, p232) --[[ Line: 1176 ]]
        --[[
        Upvalues:
            [1] = u189
            [2] = u196
        --]]
        if u189 ~= p231 then
            if u189 ~= nil then
                u189.TextColor3 = Color3.fromRGB(214, 214, 214)
            end
            p231.TextColor3 = Color3.fromRGB(255, 255, 255)
            u196(p231, p232)
            u189 = p231
        end
    end
    function u15.CreateRankButton(_, u234, p235) --[[ Line: 1190 ]]
        --[[
        Upvalues:
            [1] = u187
            [2] = u172
            [3] = u174
            [4] = u16
            [5] = u197
            [6] = u233
            [7] = u188
            [8] = u189
            [9] = u196
        --]]
        if u187[u234] == nil then
            local u236 = u172:Clone()
            u236.Name = u234
            u236.Text = u234
            u236.LayoutOrder = -p235.Id
            u236.Parent = u174
            u236.MouseButton1Click:Connect(function() --[[ Line: 1200 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u197
                    [3] = u233
                    [4] = u236
                    [5] = u188
                    [6] = u234
                --]]
                u16.UIUtils.ButtonEffect()
                if u197 ~= true then
                    u233(u236, u188[u234])
                end
            end)
            if p235.Id == 1 then
                u233(u236, p235)
            end
            u187[u234] = u236
        else
            local v237 = u187[u234]
            v237.Name = u234
            v237.Text = u234
            v237.LayoutOrder = -p235.Id
            if v237 == u189 then
                u196(v237, p235)
            end
        end
    end
    function u15.CreateRankButtons(p238, p239) --[[ Line: 1224 ]]
        --[[
        Upvalues:
            [1] = u188
            [2] = u187
            [3] = u189
            [4] = u233
        --]]
        local v240 = p239.Ranks
        u188 = v240
        local v241 = nil
        local v242 = nil
        for v243, v244 in pairs(v240) do
            p238:CreateRankButton(v243, v244)
            if v244.Id == 1 then
                v242 = v244
                v241 = v243
            end
        end
        for v245, v246 in pairs(u187) do
            if v240[v245] == nil then
                if u189 == v246 then
                    u233(u187[v241], v242)
                end
                v246:Destroy()
                u187[v245] = nil
            end
        end
    end
    local v247 = u32:WaitForChild("Leave")
    local u248 = v247:WaitForChild("Confirmation"):WaitForChild("TextBox")
    local u249 = v247:WaitForChild("Button")
    local u250 = v247:WaitForChild("Display")
    local u251 = v247:WaitForChild("Title")
    function u15.UpdateLeaveFrameText(_, p252) --[[ Line: 1260 ]]
        --[[
        Upvalues:
            [1] = u249
            [2] = u251
            [3] = u250
        --]]
        u249.TextLabel.Text = p252 and "DISBAND" or "LEAVE"
        u251.Text = p252 and "Disband Crew" or "Leave Crew"
        u250.Text = p252 and "Are you sure you want to disband?" or "Are you sure you want to leave?"
    end
    u249.MouseButton1Click:Connect(function() --[[ Line: 1268 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u248
            [3] = u17
            [4] = u15
        --]]
        u16.UIUtils.ButtonEffect()
        if u248.Text == "Yes" then
            local v253 = u17.Notify("Information", "Disbanding/Leaving Crew...")
            local v254, v255 = u17.UIClient:GetRemote():InvokeServer({
                ["Method"] = "LeaveCrew"
            })
            u17.RemoveNotification(v253, true)
            u17.Notify(v255 == nil and "Error" or "Success", v254)
            if v255 then
                u248.Text = ""
                u15:RemoveAllMembers()
                return
            end
        else
            u17.Notify("Error", "Please type \"Yes\" to confirm the action")
        end
    end)
    local u256 = v31.Logo.TabLine
    local v257 = nil
    local u258 = v257
    for _, u259 in ipairs(v31:GetChildren()) do
        if u259:IsA("Frame") then
            local v260 = u259:FindFirstChildOfClass("TextButton")
            if v260 then
                v260.MouseButton1Click:Connect(function() --[[ Line: 1328 ]]
                    --[[
                    Upvalues:
                        [1] = u16
                        [2] = u256
                        [3] = u259
                        [4] = u75
                        [5] = u32
                        [6] = u258
                    --]]
                    u16.UIUtils.ButtonEffect()
                    u256.Parent = u259
                    local v261 = u259.Name
                    local v262 = u75[v261] or u32:WaitForChild(v261)
                    if u75[v261] == nil then
                        u75[v261] = v262
                    end
                    if v262 then
                        if u258 then
                            u258.Visible = false
                        end
                        v262.Visible = true
                        u258 = v262
                    else
                        warn("Could not find tab with the name of", v261)
                    end
                end)
                if u259.Name == "Logo" then
                    local v263 = u75.Logo or u32:WaitForChild("Logo")
                    if u75.Logo == nil then
                        u75.Logo = v263
                    end
                    if v263 then
                        if u258 then
                            u258.Visible = false
                        end
                        v263.Visible = true
                        v257 = v263
                        u258 = v257
                    else
                        warn("Could not find tab with the name of", "Logo")
                    end
                else
                    local v264 = u259.Name
                    local v265 = u75[v264] or u32:WaitForChild(v264)
                    if u75[v264] == nil then
                        u75[v264] = v265
                    end
                    v265.Visible = false
                end
            else
                warn("Failed to load option button")
            end
        end
    end
    u33.MouseButton1Click:Connect(function() --[[ Line: 1345 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u1
            [3] = u33
            [4] = u20
            [5] = u28
        --]]
        u16.UIUtils.ButtonEffect()
        u1:Create(u33, TweenInfo.new(0.2), {
            ["Rotation"] = u33.Rotation + 180
        }):Play()
        u20.Visible = not u20.Visible
        u28.Visible = not u20.Visible
    end)
end
return v8