 

local v1 = game:GetService("ReplicatedStorage")
local u2 = {
    ["StringValue"] = true,
    ["IntValue"] = true,
    ["BoolValue"] = true,
    ["NumberValue"] = true,
    ["DoubleConstrainedValue"] = true,
    ["IntConstrainedValue"] = true
}
local u3 = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Playerlist"):WaitForChild("Main"):WaitForChild("ScrollingFrame"):WaitForChild("Leaderstats"):WaitForChild("Container"):WaitForChild("Title"):WaitForChild("LeaderStats")
local u4 = require(v1.Modules.Shared.Signals.GoodSignal)
local u5 = {}
u5.__index = u5
function u5.new(p6) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
    --]]
    local v7 = u5
    local v8 = setmetatable({}, v7)
    v8.StatAdded = u4.new()
    v8.StatRemoved = u4.new()
    v8.StatChanged = u4.new()
    v8.PrimaryStat = nil
    v8.Cache = {}
    v8.Playerlist = p6
    v8.Stats = {}
    v8.SortedPlayers = {}
    v8:_main()
    return v8
end
function u5.UpdatePrimaryStat(p9) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v10 = (1 / 0)
    local v11 = nil
    for _, v12 in u3:GetChildren() do
        if v12:IsA("TextLabel") then
            local v13 = v12.Name
            local v14 = p9.Stats[v13].Priority
            if v14 < v10 then
                v11 = v13
                v10 = v14
            end
        end
    end
    if v11 ~= p9.PrimaryStat then
        p9.PrimaryStat = v11
        for _, v15 in p9.Playerlist.Teams do
            v15:SortMembers()
        end
    end
end
function u5.IsValidStat(_, p16) --[[ Line: 76 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return u2[p16.ClassName]
end
function u5.UpdateStat(p17, p18, p19, p20) --[[ Line: 80 ]]
    local v21 = p18.MainLeaderstat:FindFirstChild(p19)
    if v21 then
        v21.Text = p17:_filter(p20)
    end
end
function u5.SetPriority(p22, p23, p24) --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v25 = p22:_getStat(p23)
    if v25 then
        local v26 = p24 or 0
        v25.Priority = v26
        local v27 = p22:_findChildUI(u3, p23)
        if v27 then
            v27.LayoutOrder = v26
        end
        for _, v28 in p22.Playerlist.Players do
            local v29 = p22:_findChildUI(v28.MainLeaderstat, p23)
            if v29 then
                v29.LayoutOrder = v26
            end
        end
        p22:UpdatePrimaryStat()
    end
end
function u5._getStat(p30, p31) --[[ Line: 105 ]]
    return p30.Stats[p31]
end
function u5._filter(_, p32) --[[ Line: 109 ]]
    if typeof(p32) == "number" then
        if p32 >= 1000000000 then
            return string.format("%.1fB", p32 / 1000000000)
        elseif p32 >= 1000000 then
            return string.format("%.1fM", p32 / 1000000)
        elseif p32 >= 1000 then
            return string.format("%.1fK", p32 / 1000)
        else
            return tostring(p32)
        end
    else
        return p32
    end
end
function u5._createStatUI(p33, p34) --[[ Line: 126 ]]
    local v35 = p34.Name
    local v36 = p34.Parent
    if not p33:_findChildUI(v36, v35) then
        local v37 = p34.Text
        local v38 = script.UI:Clone()
        v38.Name = v35
        v38.Text = p33:_filter(v37) or "-"
        v38.LayoutOrder = p33.Stats[v35].Priority
        v38.Parent = v36
    end
end
function u5._createStat(p39, p40, p41) --[[ Line: 140 ]]
    p39.Stats[p40] = {
        ["Priority"] = p41 or 0,
        ["Stacks"] = 0
    }
    p39.StatAdded:Fire(p40)
    p39:UpdatePrimaryStat()
    return p39.Stats[p40]
end
function u5._removeStat(p42, p43) --[[ Line: 153 ]]
    p42.StatRemoved:Fire(p43)
    p42.Stats[p43] = nil
end
function u5.AddStat(p44, _, p45, p46) --[[ Line: 158 ]]
    local v47 = p44:_getStat(p45) or p44:_createStat(p45, p46)
    v47.Stacks = v47.Stacks + 1
end
function u5.RemoveStat(p48, _, p49) --[[ Line: 163 ]]
    local v50 = p48:_getStat(p49)
    if v50 then
        v50.Stacks = v50.Stacks - 1
        if v50.Stacks <= 0 then
            p48:_removeStat(p49)
        end
    else
        return
    end
end
function u5._findChildUI(_, p51, p52) --[[ Line: 174 ]]
    return p51:FindFirstChild(p52)
end
function u5._main(u53) --[[ Line: 178 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local function v61(p54) --[[ Line: 181 ]]
        --[[
        Upvalues:
            [1] = u53
            [2] = u3
        --]]
        u53:_createStatUI({
            ["Name"] = p54,
            ["Parent"] = u3,
            ["Text"] = p54
        })
        for v55, v56 in u53.Playerlist.Players do
            local v57 = v55:FindFirstChild("leaderstats")
            if v57 then
                v57 = v57:FindFirstChild(p54)
            end
            local v58 = u53
            local v59 = {
                ["Name"] = p54,
                ["Parent"] = v56.MainLeaderstat
            }
            if v57 then
                v57 = v57.Value
            end
            v59.Text = v57
            v58:_createStatUI(v59)
        end
        for _, v60 in u53.Playerlist.Teams do
            u53:_createStatUI({
                ["Name"] = p54,
                ["Parent"] = v60.UI.Container.Title.LeaderStats,
                ["Text"] = ""
            })
        end
    end
    local function v69(u62) --[[ Line: 196 ]]
        --[[
        Upvalues:
            [1] = u53
            [2] = u3
        --]]
        local v63 = u53:_findChildUI(u3, u62)
        if v63 then
            v63:Destroy()
        end
        for _, v64 in u53.Playerlist.Players do
            local u65 = v64.MainLeaderstat
            task.spawn(function() --[[ Line: 202 ]]
                --[[
                Upvalues:
                    [1] = u65
                    [2] = u62
                --]]
                local v66 = u65
                if v66 then
                    v66 = u65:WaitForChild(u62, 1)
                end
                if v66 then
                    v66:Destroy()
                end
            end)
        end
        for _, v67 in u53.Playerlist.Teams do
            local v68 = u53:_findChildUI(v67.UI.Container.Title.LeaderStats, u62)
            if v68 then
                v68:Destroy()
            end
        end
    end
    local function v77(p70) --[[ Line: 222 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u53
        --]]
        local v71 = p70.Player
        for _, v72 in u3:GetChildren() do
            if u53.Stats[v72.Name] and v72:IsA("TextLabel") then
                local v73 = v72.Name
                local v74 = v71:WaitForChild("leaderstats", 3)
                if v74 then
                    if v74 then
                        v74 = u53:_findChildUI(v74, v73)
                    end
                    if v74 then
                        local v75 = v74.Value
                        u53:_createStatUI({
                            ["Name"] = v73,
                            ["Parent"] = p70.MainLeaderstat,
                            ["Text"] = v75
                        })
                    end
                end
            end
        end
        local v76 = p70.Team
        if v76 then
            v76:SortMembers()
        end
    end
    u53.StatAdded:Connect(v61)
    u53.StatRemoved:Connect(v69)
    u53.StatChanged:Connect(function(p78) --[[ Name: OnStatChanged, Line 215 ]]
        local v79 = p78.Team
        if v79 then
            v79:SortMembers()
        end
    end)
    u53.Playerlist.PlayerAdded:Connect(v77)
    u53.Playerlist.PlayerRemoved:Connect(function(p80) --[[ Name: OnPlayerRemoved, Line 248 ]]
        local v81 = p80.Team
        if v81 then
            v81:SortMembers()
        end
    end)
end
return u5