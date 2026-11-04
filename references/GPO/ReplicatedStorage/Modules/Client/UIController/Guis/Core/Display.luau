 

local v1 = game:GetService("Players")
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("TweenService")
local u4 = v1.LocalPlayer
local u5 = u4:WaitForChild("PlayerGui")
local v6 = u2:WaitForChild("Modules")
require(v6.Leveling)
local v7 = v6.Shared
require(v7.GameUtils)
local u8 = require(v7:WaitForChild("SoundUtils"))
local u9 = require(v7.Signals.GoodSignal)
local u10 = v6.BindToRender
local u96 = {
    ["Initialized"] = false,
    ["Initialize"] = function(p11) --[[ Name: Initialize, Line 21 ]]
        --[[
        Upvalues:
            [1] = u96
            [2] = u2
            [3] = u5
            [4] = u10
            [5] = u3
            [6] = u9
            [7] = u8
            [8] = u4
        --]]
        if not u96.Initialized then
            local u12 = u2:WaitForChild("reservedCode")
            local v13 = u5:WaitForChild("Display", 360)
            local u14 = v13:WaitForChild("Region")
            local u15 = v13:WaitForChild("LogiaRate")
            local u16 = v13:WaitForChild("FPS")
            local u17 = v13:WaitForChild("ServerAge")
            v13:WaitForChild("Verson")
            local u18 = v13:WaitForChild("Combat")
            local u19 = v13:WaitForChild("Safe")
            local u20 = p11:GetStatsFolder():WaitForChild("Stats"):WaitForChild("SkillPoints")
            local u21 = v13:WaitForChild("UnspentSP")
            local u22 = u2:WaitForChild("ServerRegion")
            local u23 = u2:WaitForChild("logia")
            local u24 = 0
            os.clock()
            u10:GetAttributeChangedSignal("FPS"):Connect(function() --[[ Line: 49 ]]
                --[[
                Upvalues:
                    [1] = u24
                    [2] = u10
                    [3] = u16
                --]]
                if u24 ~= u10:GetAttribute("FPS") then
                    u24 = u10:GetAttribute("FPS")
                    u16.Text = u24
                    local v25 = u24 / 50
                    u16.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.new(255, 0, 0):Lerp(Color3.fromRGB(0, 255, 0), v25))
                end
            end)
            u20:GetPropertyChangedSignal("Value"):Connect(function() --[[ Name: SkillPointsUpdated, Line 65 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u21
                --]]
                if u20.Value > 0 then
                    u21.Visible = true
                else
                    u21.Visible = false
                end
            end)
            if u20.Value > 0 then
                u21.Visible = true
            else
                u21.Visible = false
            end
            local v26 = TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true, 0)
            u21.Rotation = -5
            u3:Create(u21, v26, {
                ["Rotation"] = 5
            }):Play()
            local function v28(p27) --[[ Line: 87 ]]
                --[[
                Upvalues:
                    [1] = u19
                --]]
                u19.Visible = p27
            end
            local function v29() --[[ Line: 91 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u19
                --]]
                if u12.Value == "arena" then
                    u19.Visible = false
                end
            end
            if u12.Value == "arena" then
                u19.Visible = false
            end
            u12:GetPropertyChangedSignal("Value"):Connect(v29)
            local u30 = nil
            local function v46(u31) --[[ Line: 105 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u30
                    [3] = u14
                    [4] = u22
                --]]
                task.spawn(function() --[[ Line: 106 ]]
                    --[[
                    Upvalues:
                        [1] = u31
                        [2] = u9
                        [3] = u30
                        [4] = u14
                        [5] = u22
                    --]]
                    if u31 == nil then
                        u14.Text = u22.Value
                    else
                        local v32 = os.clock()
                        local u33 = u9.new()
                        if u30 then
                            u30:Disconnect()
                            u30 = nil
                        end
                        u30 = game.ReplicatedStorage.Events.GetPing.Echo.OnClientEvent:Connect(function() --[[ Line: 115 ]]
                            --[[
                            Upvalues:
                                [1] = u33
                                [2] = u30
                            --]]
                            u33:Fire()
                            if u30 then
                                u30:Disconnect()
                                u30 = nil
                            end
                        end)
                        task.spawn(function() --[[ Line: 124 ]]
                            game.ReplicatedStorage.Events.GetPing:InvokeServer(workspace:GetServerTimeNow())
                        end)
                        u33:Wait()
                        u33:DisconnectAll()
                        local v34 = os.clock() - v32
                        local v35 = (v34 - 0.05) / 0.25
                        local v36 = math.clamp(v35, 0, 1)
                        local v37 = Color3.fromRGB(0, 255, 0):Lerp(Color3.fromRGB(255, 0, 0), v36)
                        local v38 = u14
                        local v39 = v37.R * 255
                        local v40 = math.ceil(v39)
                        local v41 = v37.G * 255
                        local v42 = math.ceil(v41)
                        local v43 = v37.B * 255
                        local v44 = ("<font color=\"rgb(%*,%*,%*)\">"):format(v40, v42, (math.ceil(v43)))
                        local v45 = v34 * 1000 * 1
                        v38.Text = v44 .. math.floor(v45) / 1 .. ("ms Ping </font><font color=\"rgb(255,255,255)\">[%*]</font> "):format(game.Players.LocalPlayer.UserId) .. u22.Value
                    end
                end)
            end
            function game.ReplicatedStorage.Events.GetPing.OnClientInvoke(p47) --[[ Line: 142 ]]
                local v48 = workspace:GetServerTimeNow()
                return v48, v48 - p47
            end
            u22:GetPropertyChangedSignal("Value"):Connect(v46)
            local u49 = nil
            task.spawn(function() --[[ Line: 106 ]]
                --[[
                Upvalues:
                    [1] = u49
                    [2] = u9
                    [3] = u30
                    [4] = u14
                    [5] = u22
                --]]
                if u49 == nil then
                    u14.Text = u22.Value
                else
                    local v50 = os.clock()
                    local u51 = u9.new()
                    if u30 then
                        u30:Disconnect()
                        u30 = nil
                    end
                    u30 = game.ReplicatedStorage.Events.GetPing.Echo.OnClientEvent:Connect(function() --[[ Line: 115 ]]
                        --[[
                        Upvalues:
                            [1] = u51
                            [2] = u30
                        --]]
                        u51:Fire()
                        if u30 then
                            u30:Disconnect()
                            u30 = nil
                        end
                    end)
                    task.spawn(function() --[[ Line: 124 ]]
                        game.ReplicatedStorage.Events.GetPing:InvokeServer(workspace:GetServerTimeNow())
                    end)
                    u51:Wait()
                    u51:DisconnectAll()
                    local v52 = os.clock() - v50
                    local v53 = (v52 - 0.05) / 0.25
                    local v54 = math.clamp(v53, 0, 1)
                    local v55 = Color3.fromRGB(0, 255, 0):Lerp(Color3.fromRGB(255, 0, 0), v54)
                    local v56 = u14
                    local v57 = v55.R * 255
                    local v58 = math.ceil(v57)
                    local v59 = v55.G * 255
                    local v60 = math.ceil(v59)
                    local v61 = v55.B * 255
                    local v62 = ("<font color=\"rgb(%*,%*,%*)\">"):format(v58, v60, (math.ceil(v61)))
                    local v63 = v52 * 1000 * 1
                    v56.Text = v62 .. math.floor(v63) / 1 .. ("ms Ping </font><font color=\"rgb(255,255,255)\">[%*]</font> "):format(game.Players.LocalPlayer.UserId) .. u22.Value
                end
            end)
            task.spawn(function() --[[ Line: 152 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u30
                    [3] = u14
                    [4] = u22
                --]]
                while true do
                    local u64 = true
                    task.spawn(function() --[[ Line: 106 ]]
                        --[[
                        Upvalues:
                            [1] = u64
                            [2] = u9
                            [3] = u30
                            [4] = u14
                            [5] = u22
                        --]]
                        if u64 == nil then
                            u14.Text = u22.Value
                        else
                            local v65 = os.clock()
                            local u66 = u9.new()
                            if u30 then
                                u30:Disconnect()
                                u30 = nil
                            end
                            u30 = game.ReplicatedStorage.Events.GetPing.Echo.OnClientEvent:Connect(function() --[[ Line: 115 ]]
                                --[[
                                Upvalues:
                                    [1] = u66
                                    [2] = u30
                                --]]
                                u66:Fire()
                                if u30 then
                                    u30:Disconnect()
                                    u30 = nil
                                end
                            end)
                            task.spawn(function() --[[ Line: 124 ]]
                                game.ReplicatedStorage.Events.GetPing:InvokeServer(workspace:GetServerTimeNow())
                            end)
                            u66:Wait()
                            u66:DisconnectAll()
                            local v67 = os.clock() - v65
                            local v68 = (v67 - 0.05) / 0.25
                            local v69 = math.clamp(v68, 0, 1)
                            local v70 = Color3.fromRGB(0, 255, 0):Lerp(Color3.fromRGB(255, 0, 0), v69)
                            local v71 = u14
                            local v72 = v70.R * 255
                            local v73 = math.ceil(v72)
                            local v74 = v70.G * 255
                            local v75 = math.ceil(v74)
                            local v76 = v70.B * 255
                            local v77 = ("<font color=\"rgb(%*,%*,%*)\">"):format(v73, v75, (math.ceil(v76)))
                            local v78 = v67 * 1000 * 1
                            v71.Text = v77 .. math.floor(v78) / 1 .. ("ms Ping </font><font color=\"rgb(255,255,255)\">[%*]</font> "):format(game.Players.LocalPlayer.UserId) .. u22.Value
                        end
                    end)
                    task.wait(1)
                end
            end)
            u23:GetPropertyChangedSignal("Value"):Connect(function() --[[ Name: UpdateLogiaRate, Line 159 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u23
                --]]
                u15.Visible = u23.Value
            end)
            u15.Visible = u23.Value
            local v79 = u2:WaitForChild("Events"):WaitForChild("CombatTag")
            u18.Visible = false
            local u80 = u18:WaitForChild("CD")
            local u81 = nil
            v79.OnClientEvent:Connect(function(p82) --[[ Line: 179 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u8
                    [3] = u81
                --]]
                if p82 == true and u18.Visible == false then
                    u8.PlaySound("InCombat", {
                        ["SoundCategory"] = "Announcer"
                    })
                    u18.Visible = true
                    u81 = nil
                elseif p82 == false and u18.Visible == true then
                    u8.PlaySound("Safe", {
                        ["SoundCategory"] = "Announcer"
                    })
                    u18.Visible = false
                    u81 = nil
                end
            end)
            task.spawn(function() --[[ Line: 202 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u81
                    [3] = u80
                    [4] = u17
                --]]
                while true do
                    if u4:GetAttribute("timeUntilSafe") == nil then
                        u80.Visible = false
                    else
                        local v83 = u4:GetAttribute("timeUntilSafe") - workspace:GetServerTimeNow()
                        local v84 = math.ceil(v83)
                        if u81 == nil then
                            u81 = v84
                        end
                        local v85 = math.clamp(v84, 0, 1000)
                        u80.Text = v85
                        local v86 = Color3.fromRGB(255, 0, 0)
                        if v85 <= 10 then
                            v86 = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(170, 255, 0), (10 - v85) / 10)
                        end
                        u80.TextColor3 = v86
                        u80.Visible = true
                        if v85 <= 0 then
                            u80.Visible = false
                        end
                    end
                    local v87 = workspace:GetAttribute("serverAge")
                    local v88 = v87 % 60
                    local v89 = math.floor(v88)
                    local v90 = v87 / 60 % 60
                    local v91 = math.floor(v90)
                    local v92 = v87 / 3600 % 24
                    local v93 = math.floor(v92)
                    local v94 = v87 / 86400
                    local v95 = math.floor(v94)
                    if v95 > 0 then
                        u17.Text = string.format("%d days %.2d:%.2d:%.2d", v95, v93, v91, v89)
                    else
                        u17.Text = string.format("%.2d:%.2d:%.2d", v93, v91, v89)
                    end
                    task.wait(0.1)
                end
            end)
            u2.Events.SafeZone.OnClientEvent:Connect(v28)
            u96.Initialized = true
        end
    end
}
return u96