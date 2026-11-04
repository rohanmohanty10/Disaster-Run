 

local u1 = game:GetService("Players")
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("PolicyService")
local u4 = game:GetService("UserInputService")
local u5 = game:GetService("TweenService")
local u6 = u1.LocalPlayer
local u7 = u6:WaitForChild("PlayerGui")
local v8 = u2:WaitForChild("Modules")
require(v8.Trove)
local u9 = require(v8.NameFormID)
local v10 = v8.Shared
require(v10.GameUtils)
local u11 = require(v10.Queues.QueueTask)
local u12 = require(v10.SoundUtils)
local v13 = v8.Client
local u14 = require(v13.Notification)
local u15 = require(v13.ItemDisplay)
local u16 = u2:WaitForChild("Events")
local u166 = {
    ["Initialized"] = false,
    ["Initialize"] = function(u17) --[[ Name: Initialize, Line 28 ]]
        --[[
        Upvalues:
            [1] = u166
            [2] = u16
            [3] = u7
            [4] = u1
            [5] = u12
            [6] = u14
            [7] = u11
            [8] = u15
            [9] = u9
            [10] = u6
            [11] = u5
            [12] = u3
            [13] = u4
            [14] = u2
        --]]
        if not u166.Initialized then
            local u18 = u16:WaitForChild("Settings")
            local u19 = u16:WaitForChild("trade")
            local u20 = u17:GetStatsFolder()
            u20:WaitForChild("Gamepasses"):WaitForChild("FruitBag")
            local u21 = u7:WaitForChild("TradeMenu")
            local u22 = u21:WaitForChild("Main")
            local v23 = u22:WaitForChild("Menu")
            local v24 = v23:WaitForChild("PastTrades")
            local u25 = v24:WaitForChild("List")
            local u26 = v24:WaitForChild("Page")
            local u27 = u26:WaitForChild("Next")
            local u28 = u26:WaitForChild("Back")
            local v29 = u26:WaitForChild("Refresh")
            local u30 = v23:WaitForChild("PendingTrades"):WaitForChild("List")
            local v31 = v23:WaitForChild("SendTrades")
            local u32 = v31:WaitForChild("User"):WaitForChild("Input")
            local u33 = u32:WaitForChild("Find")
            local v34 = v31:WaitForChild("Trade")
            local u35 = u22:WaitForChild("ShoutFrame")
            local v36 = u35:WaitForChild("Shout")
            local v37 = v23:WaitForChild("ShowShout")
            local u38 = u35:WaitForChild("InputFrame"):WaitForChild("Input")
            local v39 = v23:WaitForChild("ShowShouts")
            local v40 = v23:WaitForChild("AcceptTrades")
            local u41 = u7:WaitForChild("HUD"):WaitForChild("Main"):WaitForChild("Buttons"):WaitForChild("Trade"):WaitForChild("Alert")
            u22.Visible = false
            local u42 = {}
            u1.PlayerRemoving:Connect(function(p43) --[[ Line: 79 ]]
                --[[
                Upvalues:
                    [1] = u42
                --]]
                if u42[p43] ~= nil then
                    u42[p43]:Destroy()
                    u42[p43] = nil
                end
            end)
            local u44 = {}
            function u19.OnClientInvoke(u45) --[[ Line: 87 ]]
                --[[
                Upvalues:
                    [1] = u44
                    [2] = u12
                    [3] = u42
                    [4] = u30
                    [5] = u19
                    [6] = u14
                --]]
                if u45 and typeof(u45) == "string" then
                    if u44[u45] == nil then
                        local v46 = u12:GetSoundCategory("Trade"):FindFirstChild(u45)
                        local v47 = v46:GetChildren()[math.random(#v46:GetChildren())]
                        v47:Play()
                        v47.Volume = 1.5
                        u44[u45] = true
                        task.wait(v47.TimeLength)
                        u44[u45] = nil
                    end
                    return
                elseif u42[u45] == nil then
                    local u48 = script.PlayerTemplate:Clone()
                    u48.Name = u45.Name
                    u48.Parent = u30
                    u42[u45] = u48
                    u48.Username.Text = u45.Name
                    local v49 = script.currentAlerts
                    v49.Value = v49.Value + 1
                    u48.Accept.MouseButton1Click:Connect(function() --[[ Line: 127 ]]
                        --[[
                        Upvalues:
                            [1] = u48
                            [2] = u42
                            [3] = u45
                            [4] = u19
                        --]]
                        local v50 = script.currentAlerts
                        v50.Value = v50.Value - 1
                        u48:Destroy()
                        if u42[u45] then
                            u42[u45] = nil
                        end
                        u19:InvokeServer({
                            ["tradeFeedback"] = true,
                            ["accept"] = true,
                            ["tradePlayer"] = u45
                        })
                    end)
                    u48.Decline.MouseButton1Click:Connect(function() --[[ Line: 134 ]]
                        --[[
                        Upvalues:
                            [1] = u48
                            [2] = u42
                            [3] = u45
                            [4] = u19
                        --]]
                        local v51 = script.currentAlerts
                        v51.Value = v51.Value - 1
                        u48:Destroy()
                        if u42[u45] then
                            u42[u45] = nil
                        end
                        u19:InvokeServer({
                            ["tradeFeedback"] = true,
                            ["tradePlayer"] = u45
                        })
                    end)
                    u12.PlaySound(("t%*"):format((math.random(4))), {
                        ["SoundCategory"] = "Trade",
                        ["SubCategory"] = "request"
                    })
                    u14.DisplayMessage("<Color=Green>" .. u45.Name .. "<Color=/> has sent you a trade request!")
                end
            end
            script.currentAlerts.Changed:Connect(function() --[[ Line: 144 ]]
                --[[
                Upvalues:
                    [1] = u41
                --]]
                if script.currentAlerts.Value > 0 then
                    u41.Text = script.currentAlerts.Value
                    u41.Visible = true
                else
                    u41.Visible = false
                end
            end)
            v36.MouseButton1Click:Connect(function() --[[ Line: 154 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u19
                    [3] = u38
                --]]
                u17.UIUtils.ButtonEffect()
                local v52 = u19:InvokeServer({
                    ["filterText"] = true,
                    ["text"] = u38.Text
                })
                if v52 ~= nil and v52 ~= u38.Text then
                    u38.Text = v52
                end
            end)
            v37.MouseButton1Click:Connect(function() --[[ Line: 162 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u35
                --]]
                u17.UIUtils.ButtonEffect()
                u35.Visible = not u35.Visible
            end)
            local u53 = u11.new()
            local u54 = nil
            local u55 = {}
            local u56 = nil
            local u57 = 1
            local u58 = false
            local u59 = false
            local function u70(p60) --[[ Line: 188 ]]
                local v61 = os.time() - p60
                local v62 = v61 % 60
                local v63 = v61 / 60
                local v64 = math.floor(v63) % 60
                local v65 = v61 / 3600
                local v66 = math.floor(v65) % 24
                local v67 = v61 / 86400
                local v68 = math.floor(v67)
                local v69 = "Days"
                if v68 < 1 then
                    if v66 > 0 then
                        return v66, "Hours", v61
                    elseif v64 > 0 then
                        return v64, "Mins", v61
                    else
                        return v62, "Seconds", v61
                    end
                else
                    return v68, v69, v61
                end
            end
            local function u78(p71) --[[ Line: 212 ]]
                --[[
                Upvalues:
                    [1] = u54
                --]]
                if u54 ~= nil then
                    local v72 = (p71 - 1) * 10 + 1
                    local v73 = p71 * 10
                    local v74 = #u54
                    local v75 = {}
                    for v76 = v72, math.min(v73, v74) do
                        local v77 = u54[v76]
                        table.insert(v75, v77)
                    end
                    return v75
                end
                warn("Missing Trade Data, how?")
            end
            local function u82() --[[ Line: 243 ]]
                --[[
                Upvalues:
                    [1] = u55
                    [2] = u56
                --]]
                local v79 = u55[u56]
                if v79 ~= nil then
                    v79.ItemDisplay:Destroy()
                    v79.ItemDisplay = nil
                    for v80, v81 in pairs(v79.Items) do
                        v81:Destroy()
                        v79.Items[v80] = nil
                    end
                    u55[u56] = nil
                    task.wait()
                end
            end
            local function u102(p83) --[[ Line: 259 ]]
                --[[
                Upvalues:
                    [1] = u56
                    [2] = u82
                    [3] = u55
                    [4] = u15
                    [5] = u166
                    [6] = u26
                    [7] = u25
                    [8] = u78
                    [9] = u70
                    [10] = u9
                    [11] = u28
                    [12] = u27
                    [13] = u57
                --]]
                if u56 ~= p83 then
                    u82()
                    u56 = p83
                    local v84 = u55[p83] or {
                        ["Items"] = {}
                    }
                    if u55[p83] == nil then
                        u55[p83] = v84
                        local v85 = {
                            ["Gui"] = u166,
                            ["Trade"] = false
                        }
                        v84.ItemDisplay = u15.new(v85)
                        local v86 = u55[u56]
                        if v86 ~= nil then
                            v86.ItemDisplay:StartRotation()
                        end
                    end
                    u26.Text = ("Past Trades: Page %*"):format(p83)
                    u25.CanvasPosition = Vector2.new(0, 0)
                    local v87 = 0
                    for v88, v89 in pairs(u78(p83)) do
                        if v87 == 2 then
                            task.wait()
                            v87 = 0
                        end
                        v87 = v87 + 1
                        local v90, v91, v92 = u70(v89.timeStamp)
                        local _ = v89.tradeNumber
                        local _ = v89.tradeID
                        local v93 = v89.traderID
                        local v94 = v89.itemsGiven
                        local v95 = v89.itemsGot
                        local v96 = script.PastTradeTemplate:Clone()
                        v96.Name = v88
                        v96.LayoutOrder = v88
                        v96.Parent = u25
                        v96.Received.Username.Text = ("<font color=\"rgb(255,165,0)\">[%*]</font> %*"):format(v88, (u9(v93)))
                        v96.Given.Days.Text = ("%* %* ago"):format(tostring(v90), v91)
                        local v97 = v96.Given.Days
                        local v98 = Color3.fromRGB(170, 255, 127)
                        local v99 = Color3.fromRGB(255, 0, 0)
                        local v100 = v92 / 2592000
                        v97.TextColor3 = v98:Lerp(v99, (math.clamp(v100, 0, 1)))
                        v84.ItemDisplay:AddItemsWithDictionary(v96.Given.Items, v94)
                        v84.ItemDisplay:AddItemsWithDictionary(v96.Received.Items, v95)
                        local v101 = v84.Items
                        table.insert(v101, v96)
                    end
                    u28.Visible = u56 ~= 1
                    u27.Visible = u56 ~= u57
                end
            end
            local function u108() --[[ Line: 320 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u19
                    [3] = u54
                    [4] = u59
                    [5] = u82
                    [6] = u57
                    [7] = u56
                    [8] = u102
                --]]
                local v103 = u6.UserId
                if _G.customTradeCheckID then
                    v103 = _G.customTradeCheckID
                end
                local v104 = u19:InvokeServer("getTrades", v103)
                if v104 ~= nil then
                    if u54 ~= nil then
                        if #u54 == #v104 then
                            return
                        end
                        u54 = nil
                    end
                    u59 = true
                    u82()
                    table.sort(v104, function(p105, p106) --[[ Line: 341 ]]
                        return p105.timeStamp > p106.timeStamp
                    end)
                    local v107 = #v104 / 10
                    u57 = math.ceil(v107)
                    if u54 == nil then
                        u56 = nil
                        u54 = v104
                        u102(1)
                    end
                    u54 = v104
                    u59 = false
                end
            end
            local function u112() --[[ Line: 358 ]]
                --[[
                Upvalues:
                    [1] = u57
                    [2] = u56
                    [3] = u102
                --]]
                if u57 == nil then
                    return
                elseif u57 < u56 + 1 then
                    warn("Compare pages", u56 + 1, u57)
                    return
                else
                    local v109 = u56 + 1
                    local v110 = u57
                    local v111 = math.clamp(v109, 1, v110)
                    if u56 ~= v111 then
                        u102(v111)
                    end
                end
            end
            local function u116() --[[ Line: 377 ]]
                --[[
                Upvalues:
                    [1] = u56
                    [2] = u57
                    [3] = u102
                --]]
                local v113 = u56 - 1
                local v114 = u57
                local v115 = math.clamp(v113, 1, v114)
                if u56 ~= v115 then
                    u102(v115)
                end
            end
            v29.MouseButton1Click:Connect(function() --[[ Line: 387 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u59
                    [3] = u108
                --]]
                u17.UIUtils.ButtonEffect()
                if u59 ~= true then
                    u108()
                end
            end)
            u27.MouseButton1Click:Connect(function() --[[ Line: 393 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u59
                    [3] = u53
                    [4] = u112
                --]]
                u17.UIUtils.ButtonEffect()
                if u59 ~= true then
                    u53:QueueTask(u112)
                end
            end)
            u28.MouseButton1Click:Connect(function() --[[ Line: 399 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u59
                    [3] = u53
                    [4] = u116
                --]]
                u17.UIUtils.ButtonEffect()
                if u59 ~= true then
                    u53:QueueTask(u116)
                end
            end)
            local function u120(p117) --[[ Line: 406 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u6
                --]]
                local v118 = u1:FindFirstChild(p117)
                if v118 and v118 ~= u6 then
                    return v118.Name
                end
                for _, v119 in ipairs(u1:GetPlayers()) do
                    if v119 ~= u6 and v119.Name:lower():sub(1, p117:len()) == p117:lower() then
                        return v119.Name
                    end
                end
                return nil
            end
            local u121 = ""
            local u122 = nil
            u32:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 426 ]]
                --[[
                Upvalues:
                    [1] = u32
                    [2] = u121
                    [3] = u33
                    [4] = u122
                    [5] = u120
                --]]
                local v123 = u32.Text
                if v123 == "" or v123 == u121 then
                    u33.Text = ""
                    return
                else
                    u122 = nil
                    local v124 = u120(v123)
                    if v124 == nil then
                        u33.Text = ""
                    else
                        u122 = v124
                        u33.Text = v124
                        u32.Text = v124:sub(1, v123:len())
                        u121 = v124
                    end
                end
            end)
            u32.FocusLost:Connect(function(_) --[[ Line: 448 ]]
                --[[
                Upvalues:
                    [1] = u122
                    [2] = u32
                --]]
                if u122 then
                    u32.Text = u122
                end
            end)
            u1.PlayerRemoving:Connect(function(p125) --[[ Line: 454 ]]
                --[[
                Upvalues:
                    [1] = u122
                    [2] = u32
                --]]
                if p125.Name == u122 then
                    u32.Text = ""
                    u122 = nil
                end
            end)
            v34.MouseButton1Click:Connect(function() --[[ Line: 461 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u1
                    [3] = u121
                    [4] = u19
                --]]
                u17.UIUtils.ButtonEffect()
                local v126 = u1:FindFirstChild(u121)
                if v126 then
                    u19:InvokeServer({
                        ["invite"] = true,
                        ["invitedPlayer"] = v126.Name
                    })
                end
            end)
            local u127 = {
                ["On"] = true,
                ["Off"] = false,
                [true] = "On",
                [false] = "Off"
            }
            local u128 = Color3.fromRGB(170, 12, 1)
            local u129 = Color3.fromRGB(85, 170, 0)
            local u136 = {
                ["AcceptTradesInit"] = function(p130) --[[ Name: AcceptTradesInit, Line 491 ]]
                    --[[
                    Upvalues:
                        [1] = u20
                        [2] = u127
                        [3] = u129
                        [4] = u128
                    --]]
                    local v131 = u20.Settings.AcceptTrade.Value
                    local v132 = p130.Options.Select
                    v132.Position = UDim2.new(u127[v131] == "On" and 0.5 or 0, 0, 0.5, 0)
                    v132.ImageColor3 = u127[v131] == "On" and u129 or u128
                    return u127[u20.Settings.AcceptTrade.Value]
                end,
                ["AcceptTradesOn"] = function(_) --[[ Name: AcceptTradesOn, Line 496 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    u18:InvokeServer("AcceptTrade", true)
                end,
                ["AcceptTradesOff"] = function(_) --[[ Name: AcceptTradesOff, Line 500 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    u18:InvokeServer("AcceptTrade", false)
                end,
                ["ShowShoutsInit"] = function(p133) --[[ Name: ShowShoutsInit, Line 504 ]]
                    --[[
                    Upvalues:
                        [1] = u20
                        [2] = u127
                        [3] = u129
                        [4] = u128
                    --]]
                    local v134 = u20.Settings.ShowShouts.Value
                    local v135 = p133.Options.Select
                    v135.Position = UDim2.new(u127[v134] == "On" and 0.5 or 0, 0, 0.5, 0)
                    v135.ImageColor3 = u127[v134] == "On" and u129 or u128
                    return u127[u20.Settings.ShowShouts.Value]
                end,
                ["ShowShoutsOn"] = function(_) --[[ Name: ShowShoutsOn, Line 509 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    u18:InvokeServer("ShowShouts", true)
                end,
                ["ShowShoutsOff"] = function(_) --[[ Name: ShowShoutsOff, Line 513 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    u18:InvokeServer("ShowShouts", false)
                end
            }
            local function v142(u137) --[[ Line: 517 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u136
                    [3] = u5
                    [4] = u129
                    [5] = u128
                --]]
                local v138 = u137.Options
                local u139 = v138.Select
                local u140 = "On"
                local u141 = false
                v138.Button.MouseButton1Click:Connect(function() --[[ Line: 525 ]]
                    --[[
                    Upvalues:
                        [1] = u17
                        [2] = u141
                        [3] = u140
                        [4] = u136
                        [5] = u137
                        [6] = u5
                        [7] = u139
                        [8] = u129
                        [9] = u128
                    --]]
                    u17.UIUtils.ButtonEffect()
                    if u141 ~= true then
                        u141 = true
                        u140 = u140 == "On" and "Off" or "On"
                        if u136[u137.Name .. u140] then
                            u136[u137.Name .. u140](u137)
                        else
                            warn("Missing Functions for", u137, u140)
                        end
                        u5:Create(u139, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                            ["Position"] = UDim2.new(u140 == "On" and 0.5 or 0, 0, 0.5, 0),
                            ["ImageColor3"] = u140 == "On" and u129 or u128
                        }):Play()
                        task.wait(0.25)
                        u141 = false
                    end
                end)
                if u136[u137.Name .. "Init"] then
                    u140 = u136[u137.Name .. "Init"](u137, u140) or "On"
                end
            end
            v142(v39)
            v142(v40)
            local u143 = false
            local u144 = "Close"
            local u145 = u22.Size
            u22.Size = UDim2.new(0, 0, 0, 0)
            u22.Visible = false
            local u146 = {
                ["Open"] = function() --[[ Name: Open, Line 571 ]]
                    --[[
                    Upvalues:
                        [1] = u22
                        [2] = u145
                        [3] = u58
                        [4] = u108
                    --]]
                    u22.Visible = true
                    u22.Size = UDim2.new(u145.X.Scale / 2, 0, u145.Y.Scale / 2, 0)
                    u22:TweenSize(u145, "Out", "Quad", 0.25, true)
                    if u58 == false then
                        u58 = true
                        u108()
                    end
                end,
                ["Close"] = function() --[[ Name: Close, Line 581 ]]
                    --[[
                    Upvalues:
                        [1] = u22
                    --]]
                    u22:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.25, true)
                    task.wait(0.25)
                    u22.Visible = false
                end
            }
            local u147 = nil
            local u148 = nil
            local v149, v150 = pcall(function() --[[ Line: 591 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u6
                --]]
                return u3:GetPolicyInfoForPlayerAsync(u6)
            end)
            u147 = v149
            u148 = v150
            task.spawn(function() --[[ Line: 598 ]]
                --[[
                Upvalues:
                    [1] = u144
                    [2] = u108
                --]]
                while task.wait(2) do
                    if u144 == "Open" then
                        u108()
                    end
                end
            end)
            local function u154() --[[ Line: 606 ]]
                --[[
                Upvalues:
                    [1] = u147
                    [2] = u148
                    [3] = u14
                    [4] = u3
                    [5] = u6
                    [6] = u143
                    [7] = u144
                    [8] = u21
                    [9] = u146
                --]]
                if u147 and u148 then
                    if u148.IsPaidItemTradingAllowed == false then
                        u14.DisplayMessage("<Color=Red>You cannot access the trading system because of your country\'s policys")
                        return
                    elseif u143 ~= true then
                        u143 = true
                        u144 = u144 == "Close" and "Open" or "Close"
                        if u21.Main.Size == UDim2.new(0, 0, 0, 0) and u21.Main.Visible == false then
                            u144 = "Open"
                        end
                        local v151 = u146[u144]
                        if v151 then
                            v151()
                        end
                        u143 = false
                    end
                else
                    u14.DisplayMessage("Failed to get policy info! Please press again to retry")
                    local v152, v153 = pcall(function() --[[ Line: 591 ]]
                        --[[
                        Upvalues:
                            [1] = u3
                            [2] = u6
                        --]]
                        return u3:GetPolicyInfoForPlayerAsync(u6)
                    end)
                    u147 = v152
                    u148 = v153
                    return
                end
            end
            u166.SetFrameState = u154
            local function v160(p155) --[[ Line: 644 ]]
                --[[
                Upvalues:
                    [1] = u143
                    [2] = u22
                    [3] = u154
                --]]
                if u143 == false then
                    local v156 = u22
                    local v157 = p155.Position
                    local v158 = v156.AbsoluteSize
                    local v159 = v156.AbsolutePosition
                    if v157.X > v159.X and (v157.X < v159.X + v158.X and (v157.Y > v159.Y and v157.Y < v159.Y + v158.Y)) then
                        return
                    end
                    u154()
                end
            end
            local u161 = {
                [Enum.UserInputType.MouseButton1] = v160,
                [Enum.UserInputType.Touch] = v160
            }
            local u162 = nil
            u22:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 668 ]]
                --[[
                Upvalues:
                    [1] = u162
                    [2] = u22
                    [3] = u4
                    [4] = u161
                --]]
                if u162 then
                    u162:Disconnect()
                    u162 = nil
                end
                if u22.Visible == true and u162 == nil then
                    u162 = u4.InputBegan:Connect(function(p163, p164) --[[ Line: 676 ]]
                        --[[
                        Upvalues:
                            [1] = u161
                        --]]
                        if not p164 then
                            local v165 = p163.UserInputType
                            if u161[v165] then
                                u161[v165](p163)
                            end
                        end
                    end)
                end
            end)
            function u2.tradeCheck.OnClientInvoke() --[[ Line: 686 ]]
                return true
            end
            u166.Initialized = true
        end
    end
}
return u166