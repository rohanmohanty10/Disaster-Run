 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("ReplicatedFirst")
local u3 = require(v2.OpenTextChatService)
repeat
    task.wait()
until game.Players.LocalPlayer ~= nil and game.Players.LocalPlayer.Character ~= nil
local u4 = game:GetService("Chat")
local u5 = {}
local function u8() --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v6 = u4
    local v7 = {
        ["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
        ["TextColor3"] = Color3.fromRGB(48, 48, 48),
        ["MaxDistance"] = 80,
        ["CornerRadius"] = UDim.new(1, 0),
        ["CornerEnabled"] = true,
        ["AdorneeName"] = "HumanoidRootPart",
        ["LocalPlayerStudsOffset"] = Vector3.new(0, 1, 0),
        ["VerticalStudsOffset"] = 1,
        ["SizeAnimation"] = {
            ["SpringDampingRatio"] = 0.25
        },
        ["TransparencyAnimation"] = {
            ["SpringFrequency"] = 2
        },
        ["UserSpecificSettings"] = u5
    }
    v6:SetBubbleChatSettings(v7)
end
game.Players.PlayerAdded:Connect(function(u9) --[[ Line: 71 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u8
    --]]
    task.spawn(function() --[[ Line: 37 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u5
        --]]
        local u10 = game.ReplicatedStorage:WaitForChild("Stats" .. u9.Name, 600)
        if u10 then
            u10:WaitForChild("Stats", 10):WaitForChild("DF")
            local function v13() --[[ Line: 41 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u9
                    [3] = u5
                --]]
                if u10:FindFirstChild("Stats") ~= nil then
                    local v11 = 1
                    local v12 = u10.Stats.DF.Value == "Tori-Tori" and Vector3.new(0, 1, -25) or Vector3.new(0, 1, 1)
                    if u9 ~= game.Players.LocalPlayer then
                        v11 = v11 + 2
                    end
                    if u5[u9.UserId] == nil then
                        u5[u9.UserId] = {
                            ["VerticalStudsOffset"] = v11
                        }
                    end
                    u5[u9.UserId].LocalPlayerStudsOffset = v12
                    u5[u9.UserId].VerticalStudsOffset = v11
                end
            end
            v13()
            u10.Stats.DF.Changed:Connect(v13)
        end
    end)
    u8()
end)
game.Players.PlayerRemoving:Connect(function(p14) --[[ Line: 76 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u8
    --]]
    if u5[p14.UserId] then
        u5[p14.UserId] = nil
    end
    u8()
end)
local v15 = game.Players:GetPlayers()
for v16 = 1, #v15 do
    local u17 = v15[v16]
    task.spawn(function() --[[ Line: 37 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u5
        --]]
        local u18 = game.ReplicatedStorage:WaitForChild("Stats" .. u17.Name, 600)
        if u18 then
            u18:WaitForChild("Stats", 10):WaitForChild("DF")
            local function v21() --[[ Line: 41 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u17
                    [3] = u5
                --]]
                if u18:FindFirstChild("Stats") ~= nil then
                    local v19 = 1
                    local v20 = u18.Stats.DF.Value == "Tori-Tori" and Vector3.new(0, 1, -25) or Vector3.new(0, 1, 1)
                    if u17 ~= game.Players.LocalPlayer then
                        v19 = v19 + 2
                    end
                    if u5[u17.UserId] == nil then
                        u5[u17.UserId] = {
                            ["VerticalStudsOffset"] = v19
                        }
                    end
                    u5[u17.UserId].LocalPlayerStudsOffset = v20
                    u5[u17.UserId].VerticalStudsOffset = v19
                end
            end
            v21()
            u18.Stats.DF.Changed:Connect(v21)
        end
    end)
end
u8()
u3.MessageReceived:Connect(function(p22) --[[ Line: 89 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v23 = p22.TextSource
    local v24 = p22.Text
    if v23 and v23.Name == game.Players.LocalPlayer.Name then
        if v24 == "/hideChat" then
            u3.ChatWindowConfiguration.Enabled = false
            return
        end
        if v24 == "/showChat" then
            u3.ChatWindowConfiguration.Enabled = true
        end
    end
end)
local u25 = game:GetService("Players")
local u26 = require(game.ReplicatedStorage.Modules.Titles)
local u27 = v1:FindFirstChild("tradingHUB") ~= nil
function u3.OnIncomingMessage(p28) --[[ Line: 106 ]]
    --[[
    Upvalues:
        [1] = u25
        [2] = u27
        [3] = u26
    --]]
    local v29 = Instance.new("TextChatMessageProperties")
    if p28.TextSource then
        local v30 = u25:GetPlayerByUserId(p28.TextSource.UserId)
        local v31 = game.ReplicatedStorage:FindFirstChild("Stats" .. v30.Name)
        local v32 = v30:GetAttribute("partyChat") and (v30.Party.Value == game.Players.LocalPlayer.Party.Value and v30.Party.Value ~= nil) and "<b>[PARTY]</b> " or ""
        if u27 ~= nil then
            p28.PrefixText = v30.Name .. ":"
        end
        if v31 and v31.Titles.EquipedTitle.Value ~= "" then
            local v33 = v31.Titles.EquipedTitle.Value
            local v34 = Color3.fromRGB(0, 0, 0)
            if u26[v33] then
                v34 = u26[v33].RoleColor
            end
            local v35 = ""
            local v36 = ""
            if u26[v33] and u26[v33].StartText ~= nil then
                local _ = u26[v33].StartText .. v35
                local _ = v36 .. u26[v33].EndText
            end
            v29.PrefixText = v32 .. ("<font color=\"#" .. tostring(v34:ToHex()) .. "\"><b>" .. "[" .. v33 .. "]</b></font>") .. " " .. p28.PrefixText
            return v29
        end
        v29.PrefixText = v32 .. p28.PrefixText
    end
    return v29
end