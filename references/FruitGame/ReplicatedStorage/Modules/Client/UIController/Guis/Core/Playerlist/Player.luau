 

local u1 = game:GetService("TweenService")
local v2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Shared.Maids.Maid)
require(game.ReplicatedStorage.Modules.Titles)
local u4 = game.Players.LocalPlayer
local u5 = {}
u5.__index = u5
local u6 = v2:FindFirstChild("tradingHUB") ~= nil
function u5.new(p7, p8) --[[ Line: 66 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u3
    --]]
    local v9 = u5
    local v10 = setmetatable({}, v9)
    v10.Player = p8
    v10.Playerlist = p7
    v10.Team = nil
    v10.Cleaner = u3.new()
    v10.UI = v10:_createUI()
    v10.MainLeaderstat = v10.UI.Main.LeaderStats
    return v10
end
function u5._createUI(p11) --[[ Line: 80 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v12 = script.UI:Clone()
    v12.Name = p11.Player.DisplayName
    local v13 = v12.Main.TextLabel
    local v14 = p11.Player
    local v15
    if u6 == true then
        v15 = v14.Name
    else
        v15 = v14.DisplayName
    end
    v13.Text = v15
    return v12
end
function u5._load(p16) --[[ Line: 87 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v17 = p16.UI
    v17.Size = UDim2.fromOffset()
    u1:Create(v17, TweenInfo.new(0.5), {
        ["Size"] = UDim2.fromOffset(0, 20)
    }):Play()
end
function u5.Remove(p18) --[[ Line: 98 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p18.Team then
        p18.Team:RemoveMember(p18)
    end
    local v19 = u1:Create(p18.UI, TweenInfo.new(0.5), {
        ["Size"] = UDim2.fromScale(0, 0)
    })
    v19:Play()
    task.delay(v19.TweenInfo.Time, p18.Destroy, p18)
end
function u5._handleTeams(u20) --[[ Line: 111 ]]
    local u21 = u20.Player
    local u22 = u20.Playerlist
    u22:SetTeam(u20, u21.Team)
    u21:GetPropertyChangedSignal("Team"):Connect(function() --[[ Name: OnTeamChanged, Line 115 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u22
            [3] = u20
        --]]
        u22:SetTeam(u20, u21.Team)
    end)
end
function u5._handleLeaderstats(u23) --[[ Line: 124 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u4
    --]]
    local u24 = u23.Player
    local v25 = u23.Playerlist
    local u26 = u23.Cleaner
    local u27 = v25.Leaderstats
    local u28 = nil
    local function u40(u29) --[[ Line: 132 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u23
            [3] = u26
        --]]
        if u27:IsValidStat(u29) then
            local u30 = u29.Name
            u27:AddStat(u23, u30, u29:GetAttribute("Priority"))
            local function v32() --[[ Line: 138 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u27
                    [3] = u23
                --]]
                local v31 = u29.Value
                u27.StatChanged:Fire(u23)
                u27:UpdateStat(u23, u29.Name, v31)
            end
            local function v35() --[[ Line: 144 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u30
                    [3] = u27
                    [4] = u23
                --]]
                local v33 = u29.Name
                if u30 ~= v33 then
                    u27:RemoveStat(u23, u30)
                    u27:AddStat(u23, v33)
                    local v34 = u29.Value
                    u27.StatChanged:Fire(u23)
                    u27:UpdateStat(u23, u29.Name, v34)
                    u30 = v33
                end
            end
            local function v36() --[[ Line: 155 ]]
                --[[
                Upvalues:
                    [1] = u27
                    [2] = u29
                --]]
                u27:SetPriority(u29.Name, u29:GetAttribute("Priority"))
            end
            local v37 = u29.Value
            u27.StatChanged:Fire(u23)
            u27:UpdateStat(u23, u29.Name, v37)
            local v38 = u29.Name
            if u30 ~= v38 then
                u27:RemoveStat(u23, u30)
                u27:AddStat(u23, v38)
                local v39 = u29.Value
                u27.StatChanged:Fire(u23)
                u27:UpdateStat(u23, u29.Name, v39)
                u30 = v38
            end
            u26[("%*Changed"):format(u29)] = u29.Changed:Connect(v32)
            u26[("%*NameChanged"):format(u29)] = u29:GetPropertyChangedSignal("Name"):Connect(v35)
            u26[("%*PriorityChanged"):format(u29)] = u29:GetAttributeChangedSignal("Priority"):Connect(v36)
        end
    end
    local function u42(p41) --[[ Line: 167 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u23
            [3] = u26
        --]]
        if u27:IsValidStat(p41) then
            u27:RemoveStat(u23, p41.Name)
            u26[("%*Changed"):format(p41)] = nil
            u26[("%*NameChanged"):format(p41)] = nil
            u26[("%*PriorityChanged"):format(p41)] = nil
        end
    end
    local function u46(p43) --[[ Line: 184 ]]
        --[[
        Upvalues:
            [1] = u28
            [2] = u27
            [3] = u23
            [4] = u26
            [5] = u40
            [6] = u42
        --]]
        if p43.Name == "leaderstats" then
            if not u28 then
                u28 = p43
                for _, v44 in p43:GetChildren() do
                    u40(v44)
                end
                u26.LeaderstatsChildAdded = p43.ChildAdded:Connect(u40)
                u26.LeaderstatsChildRemoved = p43.ChildRemoved:Connect(u42)
            end
        else
            if u28 == p43 then
                for _, v45 in u28:GetChildren() do
                    if u27:IsValidStat(v45) then
                        u27:RemoveStat(u23, v45.Name)
                        u26[("%*Changed"):format(v45)] = nil
                        u26[("%*NameChanged"):format(v45)] = nil
                        u26[("%*PriorityChanged"):format(v45)] = nil
                    end
                end
                u26.LeaderstatsChildAdded = nil
                u26.LeaderstatsChildRemoved = nil
            end
            return
        end
    end
    local function v49(p47) --[[ Line: 212 ]]
        --[[
        Upvalues:
            [1] = u26
            [2] = u28
            [3] = u27
            [4] = u23
        --]]
        if p47:IsA("Folder") then
            u26[("%*NameChanged"):format(p47)] = nil
            if u28 == p47 then
                for _, v48 in u28:GetChildren() do
                    if u27:IsValidStat(v48) then
                        u27:RemoveStat(u23, v48.Name)
                        u26[("%*Changed"):format(v48)] = nil
                        u26[("%*NameChanged"):format(v48)] = nil
                        u26[("%*PriorityChanged"):format(v48)] = nil
                    end
                end
                u26.LeaderstatsChildAdded = nil
                u26.LeaderstatsChildRemoved = nil
            end
        end
    end
    local function v52(u50) --[[ Line: 201 ]]
        --[[
        Upvalues:
            [1] = u46
            [2] = u26
        --]]
        if u50:IsA("Folder") then
            local function v51() --[[ Line: 204 ]]
                --[[
                Upvalues:
                    [1] = u46
                    [2] = u50
                --]]
                u46(u50)
            end
            u26[("%*NameChanged"):format(u50)] = u50:GetPropertyChangedSignal("Name"):Connect(v51)
            u46(u50)
        end
    end
    local u53 = nil
    for _, v54 in u24:GetChildren() do
        v52(v54)
    end
    u24.ChildAdded:Connect(v52)
    u24.ChildRemoved:Connect(v49)
    task.defer(function() --[[ Line: 224 ]]
        --[[
        Upvalues:
            [1] = u53
            [2] = u24
            [3] = u23
            [4] = u6
        --]]
        u53 = game.ReplicatedStorage:WaitForChild("Stats" .. u24.Name, 600)
        u53:WaitForChild("Stats"):WaitForChild("Crew")
        u53:WaitForChild("Titles")
        local u55 = game.ReplicatedStorage:WaitForChild("CrewsInServer")
        local u56 = u23.UI.Main.TextLabel
        local function u65() --[[ Line: 231 ]]
            --[[
            Upvalues:
                [1] = u53
                [2] = u23
                [3] = u55
                [4] = u56
                [5] = u24
                [6] = u6
            --]]
            if u53:FindFirstChild("Stats") == nil then
                return
            end
            local v57 = u53.Stats.Crew.Value
            local v58 = u23.UI.Crew.Icon
            if v57 == "" then
                u23.UI.Crew.Visible = false
            else
                v58.Image = "https://www.roblox.com/asset-thumbnail/image?assetId=" .. game.ReplicatedStorage.CrewRemote:InvokeServer({
                    ["Method"] = "GetImage",
                    ["CrewName"] = v57
                }) .. "&width=420&height=420&format=png"
                u23.UI.Crew.CrewName.Text = u53.Stats.Crew.Value
                if u55 and u55:GetAttribute("CurrentTop50") then
                    local v59 = game:GetService("HttpService"):JSONDecode(u55:GetAttribute("CurrentTop50"))
                    for v60, v61 in pairs(v59) do
                        if v61.CrewName == v57 then
                            u23.UI.Crew.CrewName.Text = "<b><font color=\"rgb(255,176,0)\">" .. "[#" .. v60 .. "] " .. "</font></b>" .. v57
                            break
                        end
                    end
                end
                u23.UI.Crew.Visible = true
            end
            local v62 = u56
            local v63 = u24
            local v64
            if u6 == true then
                v64 = v63.Name
            else
                v64 = v63.DisplayName
            end
            v62.Text = v64
        end
        u65()
        local u66 = nil
        u66 = u55.AttributeChanged:Connect(function(p67) --[[ Line: 265 ]]
            --[[
            Upvalues:
                [1] = u24
                [2] = u66
                [3] = u65
            --]]
            if u24:IsDescendantOf(game.Players) == false then
                u66:Disconnect()
            elseif p67 == "CurrentTop50" then
                u65()
            end
        end)
        u53.Stats.Crew.Changed:Connect(u65)
        u53.Titles.EquipedTitle.Changed:Connect(function() --[[ Line: 276 ]]
            --[[
            Upvalues:
                [1] = u56
                [2] = u24
                [3] = u6
            --]]
            local v68 = u56
            local v69 = u24
            local v70
            if u6 == true then
                v70 = v69.Name
            else
                v70 = v69.DisplayName
            end
            v68.Text = v70
        end)
        while true do
            task.wait(60)
            if u24:IsDescendantOf(game.Players) == false then
                break
            end
            u65()
        end
    end)
    task.defer(function() --[[ Line: 288 ]]
        --[[
        Upvalues:
            [1] = u23
            [2] = u4
            [3] = u24
        --]]
        local u71 = u23.UI.Main.TextLabel.friendIcon
        while u24:IsDescendantOf(game.Players) ~= false do
            pcall(function() --[[ Line: 302 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u24
                    [3] = u71
                --]]
                if u4:IsFriendsWith(u24.UserId) then
                    u71.Visible = true
                else
                    u71.Visible = false
                end
            end)
            task.wait(60)
        end
    end)
end
function u5._hoverName(p72) --[[ Line: 311 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local u73 = p72.Player
    local v74 = p72.UI
    local u75 = v74.Main.TextLabel
    v74.MouseEnter:Connect(function() --[[ Line: 316 ]]
        --[[
        Upvalues:
            [1] = u75
            [2] = u73
        --]]
        u75.Text = u73.Name
    end)
    v74.MouseLeave:Connect(function() --[[ Line: 320 ]]
        --[[
        Upvalues:
            [1] = u75
            [2] = u73
            [3] = u6
        --]]
        local v76 = u75
        local v77 = u73
        local v78
        if u6 == true then
            v78 = v77.Name
        else
            v78 = v77.DisplayName
        end
        v76.Text = v78
    end)
end
function u5.Initialize(p79) --[[ Line: 325 ]]
    p79:_load()
    p79:_handleTeams()
    p79:_handleLeaderstats()
    p79:_hoverName()
end
function u5.Destroy(p80) --[[ Line: 332 ]]
    p80.UI:Destroy()
    setmetatable(p80, nil)
end
return u5