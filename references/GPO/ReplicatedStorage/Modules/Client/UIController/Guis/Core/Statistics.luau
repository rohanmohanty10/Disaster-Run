 

local v1 = game:GetService("Players")
local u2 = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local u3 = game:GetService("MarketplaceService")
local u4 = v1.LocalPlayer
local u5 = u4:WaitForChild("PlayerGui")
local v6 = u2:WaitForChild("Modules")
local u7 = require(v6.Leveling)
local v8 = v6:WaitForChild("Client")
local u9 = require(v8:WaitForChild("Notification"))
local v10 = v6:WaitForChild("Shared")
local u11 = require(v10:WaitForChild("GameUtils"))
local u12 = require(v10:WaitForChild("SoundUtils"))
local u13 = u2:WaitForChild("Events"):WaitForChild("stats")
local u65 = {
    ["Initialized"] = false,
    ["Initialize"] = function(p14) --[[ Name: Initialize, Line 25 ]]
        --[[
        Upvalues:
            [1] = u65
            [2] = u2
            [3] = u5
            [4] = u7
            [5] = u4
            [6] = u12
            [7] = u13
            [8] = u11
            [9] = u9
            [10] = u3
        --]]
        if not u65.Initialized then
            local u15 = u2:WaitForChild("reservedCode")
            local u16 = p14:GetStatsFolder()
            local v17 = u16:WaitForChild("Stats")
            local u18 = v17:WaitForChild("SkillPoints")
            local u19 = v17:WaitForChild("FightingStyle")
            local u20 = u16:WaitForChild("Settings"):WaitForChild("DamageOutput")
            local u21 = v17:WaitForChild("DF")
            local v22 = v17:WaitForChild("Bounty")
            local v23 = u5:WaitForChild("Statistics", 360):WaitForChild("Main")
            local v24 = v23:WaitForChild("TopOptions")
            local v25 = v24:WaitForChild("Reset")
            local u26 = v24:WaitForChild("AvailableSP")
            local u27 = v24:WaitForChild("Base"):WaitForChild("Input")
            local u28 = v23:WaitForChild("Stats")
            local u29 = v23:WaitForChild("BountyBuff")
            local u30 = v23:WaitForChild("DMGWarning")
            local u31 = nil
            u27.Focused:Connect(function() --[[ Line: 56 ]]
                --[[
                Upvalues:
                    [1] = u31
                    [2] = u27
                --]]
                if u31 == nil then
                    u31 = task.spawn(function() --[[ Line: 58 ]]
                        --[[
                        Upvalues:
                            [1] = u27
                        --]]
                        while task.wait(0.1) do
                            u27.Text = u27.Text:gsub("%D+", "")
                        end
                    end)
                end
            end)
            u27.FocusLost:Connect(function() --[[ Line: 65 ]]
                --[[
                Upvalues:
                    [1] = u31
                --]]
                if u31 ~= nil and coroutine.status(u31) ~= "dead" then
                    task.cancel(u31)
                    u31 = nil
                end
            end)
            local u32 = false
            local function v35() --[[ Line: 73 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u18
                    [3] = u32
                    [4] = u28
                --]]
                u26.Text = ("Skill Points: %*"):format(u18.Value)
                if u18.Value > 0 then
                    if u32 == false then
                        u32 = true
                        for _, v33 in pairs(u28:GetChildren()) do
                            if v33:IsA("ImageLabel") then
                                v33.Add.Visible = true
                            end
                        end
                        return
                    end
                else
                    u32 = false
                    for _, v34 in pairs(u28:GetChildren()) do
                        if v34:IsA("ImageLabel") then
                            v34.Add.Visible = false
                        end
                    end
                end
            end
            local u36 = u28.FightingStyleMastery
            local function v37() --[[ Line: 96 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u36
                --]]
                if u19.Value == "" then
                    u36.Visible = false
                else
                    u36.Visible = true
                end
            end
            local u38 = u28.DevilFruitMastery
            u21:GetPropertyChangedSignal("Value"):Connect(function() --[[ Name: DevilFruitUpdated, Line 105 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u38
                --]]
                if u21.Value == "" then
                    if u21.Value == "" then
                        u38.Visible = false
                    end
                else
                    u38.Visible = true
                end
            end)
            if u21.Value == "" then
                if u21.Value == "" then
                    u38.Visible = false
                end
            else
                u38.Visible = true
            end
            u19:GetPropertyChangedSignal("Value"):Connect(v37)
            if u19.Value == "" then
                u36.Visible = false
            else
                u36.Visible = true
            end
            u18:GetPropertyChangedSignal("Value"):Connect(v35)
            v35()
            local function v42() --[[ Line: 126 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u29
                    [3] = u7
                    [4] = u4
                --]]
                if u15.Value == "arena" then
                    u29.Visible = false
                else
                    u29.Visible = true
                    local v39 = u7:GetBountyDefenseBuff(u4) * 100 * 100
                    local v40 = math.floor(v39) / 100
                    local v41 = u7:GetBountyDMGBuff(u4) * 100 * 100
                    u29.Text = "You are gaining <font color=\"rgb(255,176,0)\">+" .. math.floor(v41) / 100 .. "% damage</font> and <font color=\"rgb(0,255,0)\">+" .. v40 .. "% HP</font> from your bounty"
                end
            end
            v42()
            v22:GetPropertyChangedSignal("Value"):Connect(v42)
            local function v45() --[[ Line: 142 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u30
                --]]
                if u20.Value < 1 then
                    u30.Visible = true
                    local v43 = u30
                    local v44 = (1 - u20.Value) * 100
                    v43.Text = ("<b><font color=\"#ff0000\">%*%%</font></b> less damage due to <b><font color=\"#ff0000\">DAMAGE OUTPUT RATIO</font></b> setting."):format((math.floor(v44)))
                else
                    u30.Visible = false
                end
            end
            if u20.Value < 1 then
                u30.Visible = true
                local v46 = (1 - u20.Value) * 100
                u30.Text = ("<b><font color=\"#ff0000\">%*%%</font></b> less damage due to <b><font color=\"#ff0000\">DAMAGE OUTPUT RATIO</font></b> setting."):format((math.floor(v46)))
            else
                u30.Visible = false
            end
            u20:GetPropertyChangedSignal("Value"):Connect(v45)
            for _, u47 in pairs(u28:GetChildren()) do
                if u47:IsA("ImageLabel") then
                    local u48 = u47.Amount
                    u47.Add.MouseButton1Click:Connect(function() --[[ Line: 160 ]]
                        --[[
                        Upvalues:
                            [1] = u12
                            [2] = u27
                            [3] = u13
                            [4] = u47
                        --]]
                        u12.PlaySound("MenuClick", {
                            ["SoundCategory"] = "UI"
                        })
                        local v49 = u27.Text
                        local v50 = tonumber(v49)
                        local v51 = v50 == nil and 1 or v50
                        local v52 = v51 < 0 and 1 or v51
                        u13:FireServer(u47.Name, nil, v52)
                    end)
                    local u53 = script.PresetAdd:Clone()
                    u53.Parent = u47
                    local v54 = u47.Stat.UIGradient.Color
                    local v55 = v54.Keypoints
                    local v56 = #v54.Keypoints / 3
                    local v57 = v55[math.ceil(v56)].Value
                    for _, v58 in pairs(u53:GetChildren()) do
                        if v58:IsA("ImageButton") then
                            v58.ImageColor3 = v57
                            local v59 = v58.Name
                            local u60 = tonumber(v59)
                            v58.MouseButton1Click:Connect(function() --[[ Line: 191 ]]
                                --[[
                                Upvalues:
                                    [1] = u12
                                    [2] = u13
                                    [3] = u47
                                    [4] = u60
                                --]]
                                u12.PlaySound("MenuClick", {
                                    ["SoundCategory"] = "UI"
                                })
                                u13:FireServer(u47.Name, nil, u60)
                            end)
                        end
                    end
                    u53.Visible = true
                    local u61 = v17:WaitForChild(u47.Name)
                    local function v64() --[[ Line: 205 ]]
                        --[[
                        Upvalues:
                            [1] = u48
                            [2] = u61
                            [3] = u53
                            [4] = u16
                        --]]
                        u48.Text = u61.Value
                        for _, v62 in pairs(u53:GetChildren()) do
                            if v62:IsA("ImageButton") then
                                local v63 = v62.Name
                                if tonumber(v63) <= u16.Stats.SkillPoints.Value then
                                    v62.Visible = true
                                else
                                    v62.Visible = false
                                end
                            end
                        end
                    end
                    u16.Stats.SkillPoints:GetPropertyChangedSignal("Value"):Connect(v64)
                    u61:GetPropertyChangedSignal("Value"):Connect(v64)
                    v64()
                end
            end
            v25.MouseButton1Click:Connect(function() --[[ Line: 227 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u11
                    [3] = u4
                    [4] = u13
                    [5] = u9
                    [6] = u3
                --]]
                if u15.Value == "arena" then
                    if u11.PlayerHasItem(u4, "SP Reset Essence") == true then
                        u13:FireServer("BattleRoyaleSPReset")
                    else
                        u9.DisplayMessage("You need a <Color=Red>SP Reset Essence<Color=/> to reset your skill points!")
                    end
                elseif u11.PlayerHasItem(u4, "SP Reset Essence") == true then
                    u13:FireServer("BattleRoyaleSPReset")
                else
                    u3:PromptProductPurchase(u4, 699566079)
                end
            end)
            u65.Initialized = true
        end
    end
}
return u65