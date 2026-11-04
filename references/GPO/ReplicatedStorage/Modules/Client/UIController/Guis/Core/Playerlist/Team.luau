 

game:GetService("ReplicatedStorage")
local u1 = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Playerlist"):WaitForChild("Main"):WaitForChild("ScrollingFrame")
local u2 = {}
u2.__index = u2
function u2.new(p3, p4) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = u2
    local v6 = setmetatable({}, v5)
    v6.Playerlist = p3
    v6.Team = p4
    v6.Members = {}
    v6.UI = v6:_createUI()
    v6:_main()
    return v6
end
function u2._createUI(_) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v7 = script.UI:Clone()
    v7.Visible = false
    v7.Parent = u1
    return v7
end
function u2.DisplayTitle(p8, p9) --[[ Line: 38 ]]
    p8.UI.Container.Title.Visible = p9
end
function u2.AddMember(p10, p11) --[[ Line: 42 ]]
    p10.Members[p11.Player] = p11
    p10.UI.Visible = true
    p10:SortMembers()
end
function u2.RemoveMember(p12, p13) --[[ Line: 48 ]]
    p12.Members[p13.Player] = nil
    p12.UI.Visible = next(p12.Members) ~= nil
    p12:SortMembers()
end
function u2.SortMembers(p14) --[[ Line: 54 ]]
    local u15 = p14.Playerlist.Leaderstats.PrimaryStat
    local v16 = {}
    for v17 in p14.Members do
        table.insert(v16, v17)
    end
    table.sort(v16, function(p18, p19) --[[ Line: 62 ]]
        --[[
        Upvalues:
            [1] = u15
        --]]
        local v20 = p18:FindFirstChild("leaderstats")
        local v21 = p19:FindFirstChild("leaderstats")
        if v20 then
            if v21 then
                local v22 = v20:FindFirstChild(u15)
                local v23 = v21:FindFirstChild(u15)
                if v22 then
                    return not v23 and true or v22.Value > v23.Value
                else
                    return false
                end
            else
                return true
            end
        else
            return false
        end
    end)
    for v24, v25 in v16 do
        p14.Members[v25].UI.LayoutOrder = v24
    end
end
function u2._main(u26) --[[ Line: 91 ]]
    local _ = u26.UI
    local u27 = u26.Team
    local function v28() --[[ Line: 95 ]]
        --[[
        Upvalues:
            [1] = u26
            [2] = u27
        --]]
        u26.UI.Name = u27.Name
        u26.UI.Container.Title.TextLabel.Text = u27.Name
    end
    local function v29() --[[ Line: 100 ]]
        --[[
        Upvalues:
            [1] = u26
            [2] = u27
        --]]
        u26.UI.Background.ImageColor3 = u27.TeamColor.Color
        u26.UI.Container.Title.Divider.Background.ImageColor3 = u27.TeamColor.Color
    end
    u26.UI.Name = u27.Name
    u26.UI.Container.Title.TextLabel.Text = u27.Name
    u26.UI.Background.ImageColor3 = u27.TeamColor.Color
    u26.UI.Container.Title.Divider.Background.ImageColor3 = u27.TeamColor.Color
    if typeof(u27) == "Instance" and u27:IsA("Team") then
        u27:GetPropertyChangedSignal("Name"):Connect(v28)
        u27:GetPropertyChangedSignal("TeamColor"):Connect(v29)
    end
end
function u2.Destroy(p30) --[[ Line: 115 ]]
    p30.UI:Destroy()
    setmetatable(p30, nil)
end
return u2