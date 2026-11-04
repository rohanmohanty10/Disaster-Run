 

local v1 = game:GetService("Players")
local u2 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v3 = u2:WaitForChild("Modules"):WaitForChild("Shared")
require(v3:WaitForChild("SoundUtils"))
local u4 = {
    ["UIClient"] = {}
}
local u5 = require(script:WaitForChild("UIButton"))
local u6 = require(script:WaitForChild("UIFrame"))
local u7 = require(script:WaitForChild("UIClient"))
local u8 = v1.LocalPlayer
local v9 = u8:WaitForChild("PlayerGui"):WaitForChild("Crews", 360):WaitForChild("Main")
local u10 = v9:WaitForChild("Buttons")
local u11 = v9:WaitForChild("Frames")
v9:WaitForChild("Loading")
local v12 = u11:WaitForChild("Default")
local u13 = v12:WaitForChild("Crew")
local u14 = v12:WaitForChild("NoCrew")
local v15 = u11:WaitForChild("Invites")
local u16 = v15:WaitForChild("Invite")
local u17 = v15:WaitForChild("Invited")
local u18 = v9:WaitForChild("Notfications")
u4.Buttons = {}
u4.Frames = {}
u4.Selected = nil
local u19 = {
    ["Information"] = Color3.fromRGB(0, 170, 255),
    ["Success"] = Color3.fromRGB(85, 170, 0),
    ["Error"] = Color3.fromRGB(170, 0, 0)
}
local u20 = 0
local u21 = {}
function u4.RemoveNotification(u22, p23) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u21
    --]]
    if u21[u22] then
        if p23 == nil then
            u21[u22]:TweenSize(UDim2.fromScale(1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true, function() --[[ Line: 54 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u22
                --]]
                u21[u22]:Destroy()
                u21[u22] = nil
            end)
            return
        end
        u21[u22]:Destroy()
        u21[u22] = nil
    end
end
function u4.Notify(p24, p25, p26) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u20
        [2] = u19
        [3] = u18
        [4] = u21
        [5] = u4
    --]]
    u20 = u20 + 1
    local u27 = u20
    local v28 = u19[p24] or Color3.fromRGB(0, 170, 255)
    local v29 = script.MessageTemplate:Clone()
    v29.Name = u27
    v29.BackgroundColor3 = v28
    v29.Parent = u18
    u21[u27] = v29
    v29.TextLabel.Text = p25
    v29:TweenSize(UDim2.fromScale(1, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
    task.delay(p26 or 3, function() --[[ Line: 81 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u27
        --]]
        u4.RemoveNotification(u27)
    end)
    return u27
end
function u4.OpenFrame(_, p30) --[[ Line: 89 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u10
    --]]
    if u4.Selected ~= nil then
        u4.Frames[u4.Selected.Name]:SetVisible(false)
    end
    local v31 = u10.Frames:GetChildren()
    for v32 = 1, #v31 do
        if v31[v32].Name ~= p30 and v31[v32]:IsA("ImageButton") then
            v31[v32].Text.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
    u10.Frames[p30].Text.TextColor3 = Color3.fromRGB(247, 202, 24)
    u4.Frames[p30]:SetVisible(true)
end
function u4.GetSelectedButton(_) --[[ Line: 108 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    return u4.Selected
end
function u4.SelectButton(_, p33) --[[ Line: 112 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    u4.Selected = p33
end
function u4.GetButton(_, p34) --[[ Line: 116 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    return u4.Buttons[p34]
end
local u35 = nil
local u36 = nil
local u37 = nil
local function u43() --[[ Line: 125 ]]
    --[[
    Upvalues:
        [1] = u36
        [2] = u35
        [3] = u37
        [4] = u13
        [5] = u14
        [6] = u16
        [7] = u17
        [8] = u4
    --]]
    u36 = u36 or u35:WaitForChild("Stats")
    u37 = u37 or u36:WaitForChild("Crew")
    if u37.Value == "" then
        u13.Visible = false
        u14.Visible = true
        u16.Visible = false
        u17.Visible = true
        local v38 = u4.Frames.Default
        v38:RemoveAllConfigureMembers()
        v38:RemoveAllViewPageObjects()
        v38:UpdateCachedData({})
        local v39 = {
            ["Default"] = true,
            ["Invites"] = true,
            ["Leaderboards"] = true
        }
        for v40, v41 in pairs(u4.Buttons) do
            if v39[v40] == true then
                v41:EnableButton()
            else
                v41:DisableButton()
            end
        end
    else
        u13.Visible = true
        u14.Visible = false
        u16.Visible = true
        u17.Visible = false
        for _, v42 in pairs(u4.Buttons) do
            v42:EnableButton()
        end
    end
end
function u4.Initialize(_, p44) --[[ Line: 179 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u11
        [3] = u6
        [4] = u10
        [5] = u5
        [6] = u35
        [7] = u2
        [8] = u8
        [9] = u36
        [10] = u37
        [11] = u43
        [12] = u7
    --]]
    u4.UIController = p44
    for _, v45 in ipairs(u11:GetChildren()) do
        if v45:IsA("Frame") then
            u4.Frames[v45.Name] = u6.new(u4, v45)
            u4.Frames[v45.Name]:SetVisible(v45.Name == "Default")
        end
    end
    for _, v46 in ipairs(u10.Frames:GetChildren()) do
        if v46:IsA("ImageButton") then
            u4.Buttons[v46.Name] = u5.new(u4, v46)
            if v46.Name == "Default" then
                u4:SelectButton(v46)
            end
        end
    end
    u35 = u2:WaitForChild("Stats" .. u8.Name, 600)
    if u35 == nil then
        warn("Data Folder did not load after 10 minutes!")
    else
        u36 = u35:WaitForChild("Stats")
        u37 = u36:WaitForChild("Crew")
        u43()
        u37:GetPropertyChangedSignal("Value"):Connect(u43)
        u4.UIClient = u7:Initialize(u4)
    end
end
return u4