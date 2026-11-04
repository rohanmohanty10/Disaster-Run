 

local v1 = game:GetService("Players")
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("TweenService")
game:GetService("GuiService")
game:GetService("UserInputService")
local u4 = v1.LocalPlayer
local u5 = u4:WaitForChild("PlayerGui")
local v6 = u2:WaitForChild("Modules")
local u7 = require(v6.Leveling)
local v8 = v6.Shared
require(v8.GameUtils)
local u9 = require(v8.GamePlaceInfo)
local u10 = {
    ["Initialized"] = false
}
local function u13(p11) --[[ Line: 24 ]]
    if typeof(p11) == "string" then
        p11 = tostring(p11) or p11
    end
    repeat
        local v12
        p11, v12 = string.gsub(p11, "^(-?%d+)(%d%d%d)", "%1,%2")
    until v12 == 0
    return p11
end
function u10.Initialize(u14) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u2
        [3] = u5
        [4] = u7
        [5] = u3
        [6] = u13
        [7] = u4
        [8] = u9
    --]]
    if u10.Initialized then
        warn("HUD already initialized")
    else
        local u15 = u2:WaitForChild("reservedCode")
        local v16 = u5:WaitForChild("HUD", 360)
        local v17 = v16:WaitForChild("Main")
        local v18 = v17:WaitForChild("Bars")
        local u19 = v18:WaitForChild("Experience")
        local u20 = v18:WaitForChild("Health")
        local u21 = u20.Base.Bar.ShieldFill
        local u22 = v18:WaitForChild("Stamina")
        local v23 = v17:WaitForChild("Boosts")
        local u24 = v23:WaitForChild("DevilFruit")
        local u25 = v23:WaitForChild("Drop")
        local u26 = v23:WaitForChild("Exp")
        local v27 = u20.Detail.Regen
        local v28 = u22.Detail.Regen
        v27.TextTransparency = 1
        v28.TextTransparency = 1
        local u29 = v17:WaitForChild("Peli")
        local v30 = u29:WaitForChild("Peli")
        local u31 = u29:WaitForChild("DropAmount")
        local u32 = v17:WaitForChild("Buttons")
        local u33 = u14:GetStatsFolder()
        local u34 = u33.Stats.Peli
        local u35 = u33.Stats.Level
        local u36 = u33.Stats.EXP
        local u37 = u33.Stamina
        local v38 = u33.Inventory.Inventory
        local v39 = u33.Boosts
        local u40 = v39["2XEXP"]
        local u41 = v39["2XDROP"]
        local u42 = v39.DFTimer
        local u43 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local u44 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local u45 = TweenInfo.new(0.25)
        local u46 = {}
        local function u61(p47, p48, p49) --[[ Line: 85 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u35
                [3] = u7
                [4] = u3
                [5] = u43
                [6] = u46
                [7] = u44
            --]]
            local v50 = math.floor(p48)
            local v51 = math.max(v50, 0)
            local v52 = math.floor(p49)
            local v53 = v51 / v52
            local u54 = math.clamp(v53, 0, 1)
            local v55 = p47.Detail.Progress
            local v56 = v55.Shadow
            local v57 = p47.Base.Bar
            local v58 = v57.Fill
            local u59 = v57.FillLag
            local v60 = ("%* / %*"):format(v51, v52)
            v55.Text = v60
            v56.Text = v60
            if p47 == u19 and u35.Value >= u7.MaxLevel then
                v55.Text = "MAX / MAX"
                v56.Text = "MAX / MAX"
                u54 = 1
            end
            u3:Create(v58, u43, {
                ["Size"] = UDim2.new(u54, 0, 1, 0)
            }):Play()
            if u46[v57] and coroutine.status(u46[v57]) ~= "dead" then
                task.defer(task.cancel, u46[v57])
            end
            u46[v57] = task.delay(0.35, function() --[[ Line: 125 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u59
                    [3] = u44
                    [4] = u54
                --]]
                u3:Create(u59, u44, {
                    ["Size"] = UDim2.new(u54, 0, 1, 0)
                }):Play()
            end)
        end
        local u62 = {}
        local function u72(p63, p64, _) --[[ Line: 137 ]]
            --[[
            Upvalues:
                [1] = u62
                [2] = u3
                [3] = u45
            --]]
            local u65 = p63.Detail.Regen
            local v66 = u62[p63.Name]
            if not v66 then
                u62[p63.Name] = {
                    ["LastTick"] = 0,
                    ["LastValue"] = p64,
                    ["Regeneration"] = 0,
                    ["Averages"] = {}
                }
                v66 = u62[p63.Name]
            end
            local v67 = p64 - v66.LastValue
            if os.clock() - v66.LastTick >= 1 then
                v66.LastTick = os.clock()
                table.clear(v66.Averages)
            end
            if v67 > 0 then
                local v68 = v66.Averages
                table.insert(v68, v67)
                local v69 = 0
                for _, v70 in v66.Averages do
                    v69 = v69 + v70
                end
                local v71 = v69 / #v66.Averages
                u65.TextTransparency = 0
                u65.Text = ("+%*"):format(v71 == 0 and "" or (math.floor(v71) or ""))
                if v66.Thread and coroutine.status(v66.Thread) ~= "dead" then
                    task.defer(task.cancel, v66.Thread)
                end
                v66.Thread = task.delay(2, function() --[[ Line: 176 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                        [2] = u65
                        [3] = u45
                    --]]
                    u3:Create(u65, u45, {
                        ["TextTransparency"] = 1
                    }):Play()
                end)
            end
            v66.LastValue = p64
        end
        local function v76() --[[ Line: 191 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u34
                [3] = u7
                [4] = u13
            --]]
            local v73 = u29.TextLabel
            local v74 = u34.Value >= u7.MaxPeli
            local v75 = ": " .. u13(u34.Value)
            if v74 then
                v75 = v75 .. " [MAX]"
            end
            v73.Text = v75
            v73.shadow.Text = v75
        end
        v30.MouseButton1Click:Connect(function() --[[ Line: 205 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u31
            --]]
            u14.UIUtils.ButtonEffect()
            u31.Visible = not u31.Visible
        end)
        u31.FocusLost:Connect(function(p77, _) --[[ Line: 210 ]]
            --[[
            Upvalues:
                [1] = u31
            --]]
            if p77 then
                local v78 = u31.Text
                local v79 = tonumber(v78)
                if v79 and v79 > 0 then
                    game.ReplicatedStorage.Events.MoneyDrop:FireServer(u31.Text)
                end
                u31.Visible = false
            end
        end)
        local function v82() --[[ Line: 222 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u61
                [3] = u36
                [4] = u7
                [5] = u4
                [6] = u33
            --]]
            local v80 = u19.Detail
            local v81 = v80.Level
            local _ = v80.Progress.Shadow
            u61(u19, u36.Value, u7:maxexp(u4))
            v81.Text = "Level " .. u33.Stats.Level.Value
            v81.Shadow.Text = u19.Detail.Level.Text
        end
        local function v83() --[[ Line: 235 ]]
            --[[
            Upvalues:
                [1] = u61
                [2] = u22
                [3] = u37
                [4] = u72
            --]]
            u61(u22, u37.Value, u37.MaxValue)
            u72(u22, u37.Value, u37.MaxValue)
        end
        function _G.StamRed(p84) --[[ Line: 240 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u33
            --]]
            local v85 = u22
            local v86 = v85.Base.Bar.Fill:Clone()
            v86.Name = "a"
            v86.ZIndex = 4
            v86.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            local v87 = 1 - p84 / u33.Stamina.MaxValue
            v86.Size = UDim2.new(1 - v87, 0, 1, 0)
            v86.Position = UDim2.new(0, 0, 0.5, 0)
            v86:ClearAllChildren()
            v86.Parent = v85.Base.Bar
            local v88 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)
            game:GetService("TweenService"):Create(v86, v88, {
                ["BackgroundTransparency"] = 1
            }):Play()
            script.NoStam:Play()
        end
        local function v107(p89) --[[ Line: 264 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u61
                [3] = u20
                [4] = u72
            --]]
            print(p89, "added")
            local u90 = p89:WaitForChild("Humanoid")
            local _ = u90.MaxHealth
            os.clock()
            local u91 = p89:WaitForChild("Boosts"):WaitForChild("Shield")
            local function v95() --[[ Line: 274 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u91
                    [3] = u90
                --]]
                local v92 = u21
                local v93 = UDim2.fromScale
                local v94 = u91.Value / u90.MaxHealth
                v92.Size = v93(math.min(1, v94), 1)
                u21.Visible = u91.Value ~= 0
            end
            local function v96() --[[ Line: 279 ]]
                --[[
                Upvalues:
                    [1] = u91
                    [2] = u21
                --]]
                if u91:GetAttribute("ShieldColor") then
                    u21.BackgroundColor3 = u91:GetAttribute("ShieldColor")
                end
            end
            local function v100() --[[ Line: 285 ]]
                --[[
                Upvalues:
                    [1] = u61
                    [2] = u20
                    [3] = u90
                    [4] = u72
                    [5] = u21
                    [6] = u91
                --]]
                u61(u20, u90.Health, u90.MaxHealth)
                u72(u20, u90.Health, u90.MaxHealth)
                local v97 = u21
                local v98 = UDim2.fromScale
                local v99 = u91.Value / u90.MaxHealth
                v97.Size = v98(math.min(1, v99), 1)
                u21.Visible = u91.Value ~= 0
            end
            u90.HealthChanged:Connect(v100)
            u90:GetPropertyChangedSignal("MaxHealth"):Connect(v100)
            u61(u20, u90.Health, u90.MaxHealth)
            u72(u20, u90.Health, u90.MaxHealth)
            local v101 = u21
            local v102 = UDim2.fromScale
            local v103 = u91.Value / u90.MaxHealth
            v101.Size = v102(math.min(1, v103), 1)
            u21.Visible = u91.Value ~= 0
            u91:GetAttributeChangedSignal("ShieldColor"):Connect(v96)
            u91.Changed:Connect(v95)
            local v104 = u21
            local v105 = UDim2.fromScale
            local v106 = u91.Value / u90.MaxHealth
            v104.Size = v105(math.min(1, v106), 1)
            u21.Visible = u91.Value ~= 0
            if u91:GetAttribute("ShieldColor") then
                u21.BackgroundColor3 = u91:GetAttribute("ShieldColor")
            end
            _G.hideUI(false)
        end
        local u108 = _G.HasBaseItem(u4, "All Seeing Eye")
        local function v112() --[[ Line: 306 ]]
            --[[
            Upvalues:
                [1] = u42
                [2] = u108
                [3] = u24
            --]]
            local v109 = u42.Value / 60
            local v110 = math.ceil(v109)
            local v111 = u108 and "<b>*[2X RATES]</b> DF Notifier: INF" or ("DF Notifier: %* mins"):format(v110)
            if v110 > 0 or u108 then
                u24.Text = string.upper(v111)
                u24.Visible = true
            else
                u24.Visible = false
            end
        end
        local v113 = u42.Value / 60
        local v114 = math.ceil(v113)
        local v115 = u108 and "<b>*[2X RATES]</b> DF Notifier: INF" or ("DF Notifier: %* mins"):format(v114)
        if v114 > 0 or u108 then
            u24.Text = string.upper(v115)
            u24.Visible = true
        else
            u24.Visible = false
        end
        u42:GetPropertyChangedSignal("Value"):Connect(v112)
        local function v118() --[[ Line: 322 ]]
            --[[
            Upvalues:
                [1] = u41
                [2] = u25
            --]]
            local v116 = u41.Value / 60
            local v117 = math.ceil(v116)
            if v117 > 0 then
                u25.Text = string.upper((("2x Drop rate: %* mins"):format(v117)))
                u25.Visible = true
            else
                u25.Visible = false
            end
        end
        local v119 = u41.Value / 60
        local v120 = math.ceil(v119)
        if v120 > 0 then
            u25.Text = string.upper((("2x Drop rate: %* mins"):format(v120)))
            u25.Visible = true
        else
            u25.Visible = false
        end
        u41:GetPropertyChangedSignal("Value"):Connect(v118)
        local function v123() --[[ Line: 337 ]]
            --[[
            Upvalues:
                [1] = u40
                [2] = u26
            --]]
            local v121 = u40.Value / 60
            local v122 = math.ceil(v121)
            if v122 > 0 then
                u26.Text = string.upper((("2x EXP: %* mins"):format(v122)))
                u26.Visible = true
            else
                u26.Visible = false
            end
        end
        local v124 = u40.Value / 60
        local v125 = math.ceil(v124)
        if v125 > 0 then
            u26.Text = string.upper((("2x EXP: %* mins"):format(v125)))
            u26.Visible = true
        else
            u26.Visible = false
        end
        u40:GetPropertyChangedSignal("Value"):Connect(v123)
        v38:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 353 ]]
            --[[
            Upvalues:
                [1] = u108
                [2] = u4
                [3] = u42
                [4] = u24
            --]]
            if u108 == false then
                u108 = _G.HasBaseItem(u4, "All Seeing Eye")
                local v126 = u42.Value / 60
                local v127 = math.ceil(v126)
                local v128 = u108 and "<b>*[2X RATES]</b> DF Notifier: INF" or ("DF Notifier: %* mins"):format(v127)
                if v127 > 0 or u108 then
                    u24.Text = string.upper(v128)
                    u24.Visible = true
                    return
                end
                u24.Visible = false
            end
        end)
        u34:GetPropertyChangedSignal("Value"):Connect(v76)
        local v129 = u29.TextLabel
        local v130 = u34.Value >= u7.MaxPeli
        local v131 = ": " .. u13(u34.Value)
        if v130 then
            v131 = v131 .. " [MAX]"
        end
        v129.Text = v131
        v129.shadow.Text = v131
        u36:GetPropertyChangedSignal("Value"):Connect(v82)
        u35:GetPropertyChangedSignal("Value"):Connect(v82)
        local v132 = u19.Detail
        local v133 = v132.Level
        local _ = v132.Progress.Shadow
        u61(u19, u36.Value, u7:maxexp(u4))
        v133.Text = "Level " .. u33.Stats.Level.Value
        v133.Shadow.Text = u19.Detail.Level.Text
        u37:GetPropertyChangedSignal("Value"):Connect(v83)
        u37:GetPropertyChangedSignal("MaxValue"):Connect(v83)
        u61(u22, u37.Value, u37.MaxValue)
        u72(u22, u37.Value, u37.MaxValue)
        v107(u4.Character or u4.CharacterAdded:Wait())
        u4.CharacterAdded:Connect(v107)
        local u139 = {
            ["Menu"] = function() --[[ Line: 378 ]]
                --[[
                Upvalues:
                    [1] = u14
                --]]
                local v134 = u14.GuiModules.MenuWheel
                if v134 and v134.Initialized == true then
                    v134.SetMenuState()
                end
            end,
            ["Party"] = function() --[[ Line: 384 ]]
                --[[
                Upvalues:
                    [1] = u14
                --]]
                local v135 = u14.GuiModules.Party
                if v135 and v135.Initialized == true then
                    v135.SetFrameState()
                end
            end,
            ["Trade"] = function() --[[ Line: 390 ]]
                --[[
                Upvalues:
                    [1] = u14
                --]]
                local v136 = u14.GuiModules.TradeMenu
                if v136 and v136.Initialized == true then
                    v136.SetFrameState()
                end
            end,
            ["DailyRewards"] = function() --[[ Line: 396 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                local v137 = u5:FindFirstChild("DailyRewards")
                if v137 then
                    v137.Enabled = not v137.Enabled
                end
            end,
            ["Backpack"] = function() --[[ Line: 402 ]]
                --[[
                Upvalues:
                    [1] = u14
                --]]
                local v138 = u14.GuiModules.BackpackService
                if v138 and v138.Initialized == true then
                    v138:SetBackpackVisible()
                end
            end
        }
        local v140 = u9:GetPlaceIds()[game.PlaceId]
        u32.Trade.Visible = false
        if v140 == nil or v140 ~= "Trade Hub" and v140 ~= "VC Trade Hub" then
            u32.Trade.Visible = false
        else
            u32.Trade.Visible = true
            u32.UGCShop.Visible = true
            u32.Party.Visible = false
            local u141 = u5:FindFirstChild("UGCShop")
            u141.shop.Enabled = true
            u32.UGCShop.MouseButton1Click:Connect(function() --[[ Line: 424 ]]
                --[[
                Upvalues:
                    [1] = u141
                --]]
                u141.Enabled = not u141.Enabled
            end)
        end
        local function v142() --[[ Line: 431 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u32
            --]]
            if u15.Value == "arena" then
                u32.Party.Visible = false
            end
        end
        if u15.Value == "arena" then
            u32.Party.Visible = false
        end
        u15:GetPropertyChangedSignal("Value"):Connect(v142)
        task.spawn(function() --[[ Line: 443 ]]
            --[[
            Upvalues:
                [1] = u32
            --]]
            if _G.unclaimedDailyRewards ~= nil then
                return
            end
            repeat
                task.wait()
            until _G.unclaimedDailyRewards ~= nil
            local v143 = u32.DailyRewards.AlertNum
            while true do
                if _G.unclaimedDailyRewards > 0 then
                    v143.Visible = true
                    local v144 = _G.unclaimedDailyRewards
                    v143.Text = tostring(v144)
                else
                    v143.Visible = false
                end
                task.wait(0.5)
            end
        end)
        for _, u145 in ipairs(u32:GetChildren()) do
            if u145:IsA("ImageButton") then
                u145.MouseButton1Click:Connect(function() --[[ Line: 464 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u139
                        [3] = u145
                    --]]
                    u14.UIUtils.ButtonEffect()
                    local v146 = u139[u145.Name]
                    if v146 then
                        v146()
                    end
                end)
            end
        end
        local v147 = v16.AbsoluteSize
        local v148 = v147.X
        local v149 = v147.Y
        local v150 = math.min(v148, v149) <= 500
        local u151 = v17:WaitForChild("UIAspectRatioConstraint")
        if v150 then
            u151.AspectRatio = 0.5
        end
        task.spawn(function() --[[ Line: 485 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u151
            --]]
            if u5:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton").Size == UDim2.new(0, 120, 0, 120) then
                u151.AspectRatio = 0.4
            end
        end)
        u10.Initialized = true
    end
end
return u10