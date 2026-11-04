 

local u1 = false
local u2 = {}
_G.UIEnabled = u1
function _G.hideUI(p3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    if p3 ~= nil then
        u1 = p3
    end
    if u1 then
        for _, v4 in game.Players.LocalPlayer.PlayerGui:GetDescendants() do
            if v4:IsA("ScreenGui") and (v4.Enabled and (string.lower(v4.Name):match("topbar") == nil and v4:GetAttribute("unhideable") == nil)) then
                local v5 = u2
                table.insert(v5, v4)
                v4.Enabled = false
            end
        end
        _G.UIEnabled = false
    else
        for _, v6 in u2 do
            v6.Enabled = true
        end
        _G.UIEnabled = true
        u2 = {}
    end
end
local v7 = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("TopbarPlus"):WaitForChild("Icon"))
v7.setDisplayOrder(50000)
game.ReplicatedStorage.Events:WaitForChild("coffinTween")
game.ReplicatedStorage.Events.coffinTween.OnClientEvent:Connect(function(u8, p9, p10, p11) --[[ Line: 29 ]]
    if u8 == nil then
        return
    else
        local v12 = tick()
        if u8.PrimaryPart == nil then
            repeat
                task.wait(0.1)
            until u8.PrimaryPart ~= nil or p10 <= tick() - v12
        end
        if u8.PrimaryPart ~= nil then
            local u13 = Instance.new("CFrameValue", game.ReplicatedStorage)
            u13.Value = u8:GetPrimaryPartCFrame()
            if p11 ~= nil then
                p10 = p11 - workspace:GetServerTimeNow()
            end
            u13:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 48 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u13
                --]]
                if u8 and (u8.Parent ~= nil and u8.PrimaryPart ~= nil) then
                    u8.PrimaryPart.CFrame = u13.Value
                end
            end)
            _G.tween(u13, {
                p10,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Value"] = p9
            })
            _G.destroy(u13, p10)
        end
    end
end)
local v14 = game.ReplicatedStorage:WaitForChild("Stats" .. game.Players.LocalPlayer.Name)
v14:WaitForChild("Stats"):WaitForChild("CurrentSea")
local u15 = u1
repeat
    task.wait()
until _G.arena ~= nil
local u16 = game:GetService("TeleportService")
game:GetService("ReplicatedStorage")
local u17 = v7.new()
u17:setLeft()
u17:disableStateOverlay(true)
u17:setCaption("Exit to")
u17:setImage("13868790754")
u17:setImageScale(0.7)
local v18 = u17.new()
v18:setLabel("Main Menu")
local u19, u20, u21
if game.GameId == 2097989947 then
    u19 = 7422493775
    u20 = 6175058954
    u21 = 6729320818
else
    u19 = 1730877806
    u20 = 6360478118
    u21 = 6811831486
end
v18.selected:Connect(function() --[[ Line: 90 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u19
    --]]
    if game.Players.LocalPlayer.Character:FindFirstChild("inCombat") then
        _G.displayMessage("<Color=Red>Cannot leave while in-combat!")
    else
        _G.displayMessage("<Color=Green>Teleporting to MAIN MENU...")
        u16:Teleport(u19, game.Players.LocalPlayer)
    end
end)
local v22 = u17.new()
v22:setLabel("Universe HUB")
v22.selected:Connect(function() --[[ Line: 104 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u20
    --]]
    if game.Players.LocalPlayer.Character:FindFirstChild("inCombat") and _G.arenaMatchStarted ~= nil then
        _G.displayMessage("<Color=Red>Cannot leave while in-combat!")
    else
        _G.displayMessage("<Color=Green>Teleporting to UNIVERSE HUB...")
        u16:Teleport(u20, game.Players.LocalPlayer)
    end
end)
local u23 = v14:WaitForChild("Stats").CurrentSea.Value .. " Sea"
local v24 = {
    ["test"] = {
        ["first"] = 5875630735,
        ["second"] = 7122743591,
        ["tradeHub"] = 6729320818
    },
    ["real"] = {
        ["first"] = 3978370137,
        ["second"] = 7465136166,
        ["tradeHub"] = 6811831486
    }
}
local v25 = v24.real
if game.GameId ~= 648454481 then
    v25 = v24.test
end
local u26
if u23 == "First Sea" then
    u26 = v25.first
else
    u26 = v25.second
end
if game.PlaceId == u26 then
    local v27 = u17.new()
    v27:setLabel("Trade HUB")
    v27.selected:Connect(function() --[[ Line: 163 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u21
        --]]
        if game.Players.LocalPlayer.Character:FindFirstChild("inCombat") then
            _G.displayMessage("<Color=Red>Cannot leave while in-combat!")
        else
            _G.displayMessage("<Color=Green>Teleporting to TRADE HUB...")
            u16:Teleport(u21, game.Players.LocalPlayer)
        end
    end)
    u17:setDropdown({ v18, v22, v27 })
else
    local v28 = u17.new()
    v28:setLabel(u23)
    v28.selected:Connect(function() --[[ Line: 147 ]]
        --[[
        Upvalues:
            [1] = u23
            [2] = u16
            [3] = u26
        --]]
        local v29 = game.Players.LocalPlayer.Character
        if v29 and v29:FindFirstChild("inCombat") then
            _G.displayMessage("<Color=Red>Cannot leave while in-combat!")
        else
            _G.displayMessage("<Color=Green>Teleporting to " .. string.upper(u23) .. "...")
            u16:Teleport(u26, game.Players.LocalPlayer)
        end
    end)
    u17:setDropdown({ v18, v22, v28 })
end
if _G.arena == true then
    task.spawn(function() --[[ Line: 177 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        local u30 = game.ReplicatedStorage:WaitForChild("Matchinfo"):WaitForChild("matchStarted")
        u30:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 180 ]]
            --[[
            Upvalues:
                [1] = u30
                [2] = u17
            --]]
            if u30.Value == true then
                u17:destroy()
            end
        end)
    end)
end
local v31 = v7.new()
v31:setName("Misc Menu")
v31:setImage(13868240933)
v31:setImageScale(0.7)
local v32 = v31.new()
v32:setLeft()
v32:disableStateOverlay(true)
v32:setCaption("Hide UIs")
v32:setImage("13858661978", "deselected")
v32:setImage("13858672956", "selected")
v32:setImageScale(0.7)
v32.toggled:Connect(function() --[[ Line: 202 ]]
    --[[
    Upvalues:
        [1] = u15
    --]]
    u15 = not u15
    _G.hideUI()
end)
local v33
if _G.arena == false then
    v33 = v31.new():setName("ServerList"):setCaption("View Servers"):setImage(14897649708):setImageScale(0.7):oneClick():bindEvent("selected", function(_) --[[ Line: 217 ]]
        local v34 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ServerList")
        if v34 then
            v34.Enabled = not v34.Enabled
        end
    end)
else
    v33 = nil
end
local v36 = v7.new():setName("Emote"):setCaption("Emote [U]"):setImage(14930205724):setImageScale(0.7):oneClick():bindEvent("selected", function(_) --[[ Line: 233 ]]
    local v35 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("EmoteGui")
    if v35 then
        warn("fire emote")
        v35.ToggleUI:Fire()
    end
end)
local v37 = nil
local v38
if _G.arena == false then
    v38 = v31.new():setName("Controls"):setCaption("Controls/Tips"):setImage(14897440793):setImageScale(0.7):oneClick():bindEvent("selected", function(_) --[[ Line: 253 ]]
        local v39 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Tips")
        if v39 then
            v39.Enabled = not v39.Enabled
        end
    end)
    local u40 = game:GetService("SocialService")
    local u41 = false
    pcall(function() --[[ Line: 262 ]]
        --[[
        Upvalues:
            [1] = u41
            [2] = u40
        --]]
        u41 = u40:CanSendGameInviteAsync(game.Players.LocalPlayer)
    end)
    if u41 then
        v37 = v31.new():setName("InviteFriends"):setCaption("Invite Friends"):setImage(13868688758):setImageScale(0.7):oneClick():bindEvent("selected", function(_) --[[ Line: 273 ]]
            --[[
            Upvalues:
                [1] = u40
            --]]
            u40:PromptGameInvite(game.Players.LocalPlayer)
        end)
    end
else
    v38 = nil
end
v31:setMenu({
    v32,
    v33,
    v36,
    v38,
    v37
})
if _G.isCustomHUB == false then
    script.BRReport.Enabled = true
end
local v42 = {
    ["Phoeating"] = true,
    ["DeadzoneRemadeLEVEL"] = true
}
local u43 = game.Players.LocalPlayer
local v44 = game.ReplicatedStorage:WaitForChild("reservedCode", 10)
local v45 = nil
if v44 then
    repeat
        task.wait()
    until v44.Value ~= "checking"
    if v44.Value ~= "" then
        repeat
            task.wait()
        until v44:GetAttribute("ownerID") ~= nil
        v45 = v44:GetAttribute("ownerID")
    end
elseif v42[u43.Name] == nil then
    return
end
if v42[u43.Name] or u43.UserId == v45 then
    local v46 = v7.new()
    v46:setLeft()
    v46:disableStateOverlay(true)
    v46:setCaption("Private Server Settings")
    v46:setImage("14923131291")
    v46:setImageScale(0.7)
    local u47 = game.ReplicatedStorage.Events.privateServerSettings
    local function v57(u48, u49, p50) --[[ Line: 363 ]]
        --[[
        Upvalues:
            [1] = u47
        --]]
        local _ = p50 or Color3.fromRGB(255, 75, 75)
        u48:setName(u49)
        u48:autoDeselect(false)
        u48:setLabel(("\240\159\159\169  %*"):format(u49), "Selected")
        u48:setLabel(("\240\159\159\165  %* "):format(u49), "Deselected")
        if u47:InvokeServer({
            ["checkSettingName"] = u49
        }) == true then
            u48:select()
        else
            u48:deselect()
        end
        u48.toggled:Connect(function(p51, _) --[[ Line: 377 ]]
            --[[
            Upvalues:
                [1] = u48
                [2] = u49
                [3] = u47
            --]]
            u48:lock()
            if u49 == "No Cooldowns" and p51 then
                local u52 = false
                local u53 = false
                local v54 = {
                    [true] = function() --[[ Line: 384 ]]
                        --[[
                        Upvalues:
                            [1] = u52
                        --]]
                        u52 = true
                    end,
                    [false] = function() --[[ Line: 387 ]]
                        --[[
                        Upvalues:
                            [1] = u53
                            [2] = u52
                        --]]
                        u53 = true
                        u52 = true
                    end
                }
                _G.promptQuestion(game.Players.LocalPlayer, "Are you sure you want to <font color=\"rgb(255,0,0)\">turn off cooldowns?</font> You will <font color=\"rgb(255,0,0)\">not be able to turn off PVP Pads afterwards, a server restart would be required.</font>", v54)
                local v55 = u53
                repeat
                    task.wait()
                until u52 == true
                u48:unlock()
                if v55 == true then
                    u48:setLabel((("\240\159\159\165  %*"):format(u49)))
                    return
                end
            end
            local v56, _ = u47:InvokeServer({
                ["Toggle"] = p51,
                ["settingName"] = u49
            })
            if v56 == true then
                u48:setLabel((("\240\159\159\169  %*"):format(u49)))
            else
                u48:setLabel((("\240\159\159\165  %*"):format(u49)))
            end
            u48:unlock()
        end)
    end
    local u58 = nil
    local function v63(p59, p60, _) --[[ Line: 464 ]]
        --[[
        Upvalues:
            [1] = u58
            [2] = u43
            [3] = u47
        --]]
        p59:setName(p60)
        p59:autoDeselect(true)
        p59:setLabel(p60)
        p59:oneClick()
        p59:bindEvent("selected", function(_) --[[ Line: 470 ]]
            --[[
            Upvalues:
                [1] = u58
                [2] = u43
                [3] = u47
            --]]
            if u58 == nil then
                u58 = script.PBWindowUI:Clone()
                u58.Parent = u43.PlayerGui
                u58.Client.Enabled = true
                local u61 = u58.Client.CustomValue
                local function v62() --[[ Line: 478 ]]
                    --[[
                    Upvalues:
                        [1] = u47
                        [2] = u61
                    --]]
                    u47:InvokeServer({
                        ["settingName"] = "Custom PB Window",
                        ["customValue"] = u61.Value
                    })
                end
                u58.Main.OptionsFrame.Accept.MouseButton1Click:Connect(v62)
            end
            u58.Enabled = not u58.Enabled
        end)
    end
    local u64 = nil
    local function v69(p65, p66, _) --[[ Line: 491 ]]
        --[[
        Upvalues:
            [1] = u64
            [2] = u43
            [3] = u47
        --]]
        p65:setName(p66)
        p65:autoDeselect(true)
        p65:setLabel(p66)
        p65:oneClick()
        p65:bindEvent("selected", function(_) --[[ Line: 497 ]]
            --[[
            Upvalues:
                [1] = u64
                [2] = u43
                [3] = u47
            --]]
            if u64 == nil then
                u64 = script.CustomM1WindowUI:Clone()
                u64.Parent = u43.PlayerGui
                u64.Client.Enabled = true
                local u67 = u64.Client.CustomValue
                local function v68() --[[ Line: 505 ]]
                    --[[
                    Upvalues:
                        [1] = u47
                        [2] = u67
                    --]]
                    u47:InvokeServer({
                        ["settingName"] = "Custom M1 Window",
                        ["customValue"] = u67.Value
                    })
                end
                u64.Main.OptionsFrame.Accept.MouseButton1Click:Connect(v68)
            end
            u64.Enabled = not u64.Enabled
        end)
    end
    local u70 = nil
    local function v74(p71, p72, _) --[[ Line: 518 ]]
        --[[
        Upvalues:
            [1] = u70
            [2] = u43
            [3] = u47
        --]]
        p71:setName(p72)
        p71:autoDeselect(true)
        p71:setLabel(p72)
        p71:oneClick()
        p71:bindEvent("selected", function(_) --[[ Line: 524 ]]
            --[[
            Upvalues:
                [1] = u70
                [2] = u43
                [3] = u47
            --]]
            if u70 == nil then
                u70 = script.ServerAnnoucementUI:Clone()
                u70.Parent = u43.PlayerGui
                local function v73() --[[ Line: 530 ]]
                    --[[
                    Upvalues:
                        [1] = u70
                        [2] = u47
                    --]]
                    u47:InvokeServer({
                        ["settingName"] = "Server Annoucement",
                        ["customValue"] = u70.Main.BackgroundInput.Input.Text
                    })
                end
                u70.Main.Update.MouseButton1Click:Connect(v73)
            end
            u70.Enabled = not u70.Enabled
        end)
    end
    v46:setDropdown({
        v7.new():call(v57, "PVP Pads"),
        v7.new():call(v57, "No Cooldowns"),
        v7.new():call(v57, "Lock Server"),
        v7.new():call(function(u75, u76, _) --[[ Name: banButton, Line 416 ]]
            --[[
            Upvalues:
                [1] = u47
            --]]
            u75:setName(u76)
            u75:autoDeselect(false)
            u75:setLabel(("\240\159\147\150  %*"):format(u76), "Selected")
            u75:setLabel(("\240\159\147\152  %* "):format(u76), "Deselected")
            u75.toggled:Connect(function(p77, _) --[[ Line: 422 ]]
                --[[
                Upvalues:
                    [1] = u75
                    [2] = u47
                    [3] = u76
                --]]
                u75:lock()
                local v78, _ = u47:InvokeServer({
                    ["Toggle"] = p77,
                    ["settingName"] = u76
                })
                if v78 == true then
                    u75:setLabel((("\240\159\147\150  %*"):format(u76)))
                else
                    u75:setLabel((("\240\159\147\152  %*"):format(u76)))
                end
                u75:unlock()
            end)
        end, "Ban List"),
        v7.new():call(v74, "\240\159\147\162  Server Annoucement"),
        v7.new():call(function(p79, p80, _) --[[ Name: invitePartyButton, Line 441 ]]
            p79:setName(p80)
            p79:autoDeselect(true)
            p79:setLabel(p80)
            p79:oneClick()
            p79:bindEvent("selected", function(_) --[[ Line: 447 ]]
                local v81 = game.Players:GetPlayers()
                for v82 = 1, #v81 do
                    if v81[v82] ~= game.Players.LocalPlayer then
                        local v83 = v81[v82]:FindFirstChild("Party")
                        if v83 and v83.Value == nil then
                            game.ReplicatedStorage.Events.PartySystem:FireServer({
                                ["action"] = "invite",
                                ["ply"] = v81[v82]
                            })
                        end
                    end
                end
                _G.displayMessage("<Color=Green>Party invites sent!")
            end)
        end, "\240\159\145\165  Party Invite All"),
        v7.new():call(v63, "Custom PB Window"),
        v7.new():call(v69, "Custom M1 Window")
    })
end