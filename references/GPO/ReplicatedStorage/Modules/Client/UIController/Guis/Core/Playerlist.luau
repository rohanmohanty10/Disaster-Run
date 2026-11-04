 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("Players")
local u3 = game:GetService("TweenService")
local u4 = game:GetService("Teams")
local u5 = game:GetService("StarterGui")
local u6 = game:GetService("UserInputService")
local v7 = game:GetService("StarterPlayer")
local u8 = workspace.CurrentCamera
local u9 = u2.LocalPlayer.PlayerGui:WaitForChild("Playerlist"):WaitForChild("Main")
local u10 = u9:WaitForChild("ScrollingFrame"):WaitForChild("Leaderstats")
local u11 = u10:WaitForChild("Container")
local u12 = require(script.Team)
local u13 = require(script.Player)
local u14 = require(script.Leaderstats)
local u15 = require(v1.Modules.Shared.Signals.GoodSignal)
require(v1.Modules.Shared.Maids.Maid)
local u16 = {}
u16.__index = u16
local u17 = require(v7.StarterPlayerScripts.InputHandler)
function u16.new() --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u15
        [3] = u14
        [4] = u17
    --]]
    local v18 = u16
    local u19 = setmetatable({}, v18)
    u19.PlayerAdded = u15.new()
    u19.PlayerRemoved = u15.new()
    u19.Leaderstats = u14.new(u19)
    u19.Players = {}
    u19.Teams = {}
    u19.Opened = true
    u19:_main()
    local v20 = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("TopbarPlus"):WaitForChild("Icon"))
    if u17:GetCurrentInput() == "Mobile" then
        warn("MOBILE PLAYER LIST!")
        v20.new():setName("PlayerList"):setCaption("View Player List"):setImage(14899301735):setImageScale(0.7):oneClick():bindEvent("selected", function(_) --[[ Line: 58 ]]
            --[[
            Upvalues:
                [1] = u19
            --]]
            if u19.Opened == true then
                u19:Hide()
            else
                u19:Open()
            end
        end)
    end
    return u19
end
function u16._disableCoreGUI(_) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v21 = os.clock()
    while os.clock() - v21 <= 2 do
        pcall(u5.SetCoreGuiEnabled, u5, Enum.CoreGuiType.PlayerList, false)
        task.wait()
    end
    print("PLAYER LIST DISABLED?")
end
function u16.Initialize() --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u8
        [3] = u16
    --]]
    u16:_disableCoreGUI()
    u16.new()
end
function u16.Open(p22) --[[ Line: 103 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u3
        [3] = u9
    --]]
    p22.Opened = true
    u10.Open.Interactable = false
    u3:Create(u9, TweenInfo.new(0.5), {
        ["AnchorPoint"] = Vector2.new(1, 0)
    }):Play()
    u3:Create(u10.Open, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
        ["TextTransparency"] = 1,
        ["TextStrokeTransparency"] = 1
    }):Play()
end
function u16.Hide(p23) --[[ Line: 121 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u3
        [3] = u9
    --]]
    p23.Opened = false
    u10.Open.Interactable = true
    u3:Create(u9, TweenInfo.new(0.5), {
        ["AnchorPoint"] = Vector2.new(0, 0)
    }):Play()
    u3:Create(u10.Open, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
        ["TextTransparency"] = 0,
        ["TextStrokeTransparency"] = 0
    }):Play()
end
function u16.GetTeam(p24, p25) --[[ Line: 139 ]]
    return p24.Teams[p25]
end
function u16.GetPlayer(p26, p27) --[[ Line: 143 ]]
    return p26.Players[p27]
end
function u16._displayNeutralTitle(p28) --[[ Line: 147 ]]
    local v29 = 0
    for _ in p28.Teams do
        v29 = v29 + 1
        if v29 >= 2 then
            break
        end
    end
    p28.Teams.Neutral:DisplayTitle(v29 >= 2)
end
function u16.SetTeam(p30, p31, p32) --[[ Line: 156 ]]
    local v33 = p32 or "Neutral"
    local v34 = p30:GetTeam(v33)
    if v34 then
        local _ = p31.Player
        local v35 = p31.Team
        if v35 then
            v35:RemoveMember(p31)
        end
        p31.Team = v34
        p31.UI.Parent = v34.UI.Container
        v34:AddMember(p31)
    else
        warn((("[Playerlist]: %* is not a valid team!"):format(v33)))
    end
end
function u16._handleTeams(u36) --[[ Line: 175 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u4
    --]]
    local v37 = u12.new(u36, {
        ["TeamColor"] = BrickColor.White(),
        ["Name"] = "Neutral"
    })
    u36.Teams.Neutral = v37
    local function v39(p38) --[[ Line: 184 ]]
        --[[
        Upvalues:
            [1] = u36
            [2] = u12
        --]]
        if not u36:GetTeam(p38) then
            u36.Teams[p38] = u12.new(u36, p38)
            u36:_displayNeutralTitle()
        end
    end
    local function v41(p40) --[[ Line: 191 ]]
        --[[
        Upvalues:
            [1] = u36
        --]]
        if u36:GetTeam(p40) then
            u36.Teams[p40]:Destroy()
            u36.Teams[p40] = nil
            u36:_displayNeutralTitle()
        end
    end
    for _, v42 in u4:GetTeams() do
        if not u36:GetTeam(v42) then
            u36.Teams[v42] = u12.new(u36, v42)
            u36:_displayNeutralTitle()
        end
    end
    u4.ChildAdded:Connect(v39)
    u4.ChildRemoved:Connect(v41)
end
function u16._handlePlayers(u43) --[[ Line: 207 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u2
    --]]
    local function u51(u44) --[[ Line: 218 ]]
        --[[
        Upvalues:
            [1] = u43
            [2] = u13
            [3] = u51
        --]]
        task.spawn(function() --[[ Line: 219 ]]
            --[[
            Upvalues:
                [1] = u43
                [2] = u44
                [3] = u13
                [4] = u51
            --]]
            if u43:GetPlayer(u44) then
                return
            else
                local v45 = tick()
                if u44.Character == nil then
                    repeat
                        task.wait()
                    until u44.Character ~= nil or tick() - v45 >= 30
                end
                if u44:IsDescendantOf(game.Players) == false then
                    return
                elseif u44:GetAttribute("hidePlayerList") ~= true then
                    local v46 = u13.new(u43, u44)
                    u43.Players[u44] = v46
                    v46:Initialize()
                    u43.PlayerAdded:Fire(v46)
                    local u47 = nil
                    u47 = u44.AttributeChanged:Connect(function(p48) --[[ Line: 244 ]]
                        --[[
                        Upvalues:
                            [1] = u44
                            [2] = u43
                            [3] = u47
                            [4] = u51
                        --]]
                        if p48 == "hidePlayerList" then
                            if u44:GetAttribute("hidePlayerList") then
                                local v49 = u44
                                local v50 = u43:GetPlayer(v49)
                                if v50 then
                                    u43.PlayerRemoved:Fire(v50)
                                    u43.Players[v49]:Remove()
                                    u43.Players[v49] = nil
                                end
                            end
                            u47:Disconnect()
                            u47 = nil
                            u51(u44)
                        end
                    end)
                end
            end
        end)
    end
    u2.PlayerAdded:Connect(u51)
    u2.PlayerRemoving:Connect(function(p52) --[[ Name: RemovePlayer, Line 208 ]]
        --[[
        Upvalues:
            [1] = u43
        --]]
        local v53 = u43:GetPlayer(p52)
        if v53 then
            u43.PlayerRemoved:Fire(v53)
            u43.Players[p52]:Remove()
            u43.Players[p52] = nil
        end
    end)
    for _, u54 in u2:GetPlayers() do
        task.spawn(function() --[[ Line: 219 ]]
            --[[
            Upvalues:
                [1] = u43
                [2] = u54
                [3] = u13
                [4] = u51
            --]]
            if u43:GetPlayer(u54) then
                return
            else
                local v55 = tick()
                if u54.Character == nil then
                    repeat
                        task.wait()
                    until u54.Character ~= nil or tick() - v55 >= 30
                end
                if u54:IsDescendantOf(game.Players) == false then
                    return
                elseif u54:GetAttribute("hidePlayerList") ~= true then
                    local v56 = u13.new(u43, u54)
                    u43.Players[u54] = v56
                    v56:Initialize()
                    u43.PlayerAdded:Fire(v56)
                    local u57 = nil
                    u57 = u54.AttributeChanged:Connect(function(p58) --[[ Line: 244 ]]
                        --[[
                        Upvalues:
                            [1] = u54
                            [2] = u43
                            [3] = u57
                            [4] = u51
                        --]]
                        if p58 == "hidePlayerList" then
                            if u54:GetAttribute("hidePlayerList") then
                                local v59 = u54
                                local v60 = u43:GetPlayer(v59)
                                if v60 then
                                    u43.PlayerRemoved:Fire(v60)
                                    u43.Players[v59]:Remove()
                                    u43.Players[v59] = nil
                                end
                            end
                            u57:Disconnect()
                            u57 = nil
                            u51(u54)
                        end
                    end)
                end
            end
        end)
        task.wait()
    end
end
function u16._handleInputs(u61) --[[ Line: 267 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u10
        [3] = u11
    --]]
    u6.InputBegan:Connect(function(p62, p63) --[[ Line: 276 ]]
        --[[
        Upvalues:
            [1] = u61
        --]]
        if not p63 then
            if p62.KeyCode == Enum.KeyCode.Tab then
                if not u61.Opened then
                    u61:Open()
                    return
                end
                u61:Hide()
            end
        end
    end)
    u10.Open.MouseButton1Down:Connect(function() --[[ Name: Open, Line 268 ]]
        --[[
        Upvalues:
            [1] = u61
        --]]
        u61:Open()
    end)
    u11.Hide.MouseButton1Down:Connect(function() --[[ Name: Hide, Line 272 ]]
        --[[
        Upvalues:
            [1] = u61
        --]]
        u61:Hide()
    end)
end
function u16._main(p64) --[[ Line: 295 ]]
    p64:_handleTeams()
    p64:_handlePlayers()
    p64:_handleInputs()
end
return u16