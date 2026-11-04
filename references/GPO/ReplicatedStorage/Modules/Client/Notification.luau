 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = v1:WaitForChild("Modules")
local u4 = require(v3:WaitForChild("RichText"))
local u5 = game:GetService("TweenService")
local v6 = v3.Shared
local u7 = require(v6.GameUtils)
require(v6.DebrisService)
local u8 = v2.LocalPlayer
local u9 = u8.PlayerGui
local u10 = u9:WaitForChild("Notifications")
local v11 = {}
local v12 = u8:WaitForChild("PlayerScripts")
if require(v12:WaitForChild("InputHandler"):WaitForChild("GetPreferredInput")).Current == "Mobile" then
    local v13 = u10.Frame.Size
    local v14 = u10.Frame.Position
    local v15 = UDim2.new(v13.X.Scale * 1.5, 0, v13.Y.Scale * 1.5, 0)
    local v16 = UDim2.new(v14.X.Scale, 0, v14.Y.Scale + v13.Y.Scale * 1.5 / 4, 0)
    u10.Frame.Size = v15
    u10.Frame2.Size = v15
    u10.Frame.Position = v16
    u10.Frame2.Position = v16
end
local u17 = {}
function hasOnlyOnePattern(p18)
    local v19, v20 = string.find(p18, "<Color=")
    if v19 then
        return string.find(p18, "<Color=", v20 + 1) == nil
    else
        return false
    end
end
local function u43(u21, _, _) --[[ Line: 101 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u17
        [3] = u4
        [4] = u5
    --]]
    local v22 = false
    local v23
    if string.len(u21) >= 11 then
        v23 = string.sub(u21, 1, 11) == "<Color=Red>"
    else
        v23 = false
    end
    if v23 == true and hasOnlyOnePattern(u21) == true then
        script.RedText4:Play()
        v22 = true
    end
    local v24 = u10.Frame
    if u17[u21] == nil then
        local u25 = script.TextLabel:Clone()
        u25.Parent = v24
        u25.Visible = true
        local v26 = #v24:GetChildren() - 1
        u25.Position = UDim2.new(0, 0, v26 * 0.1 - 1, 0)
        u25:TweenPosition(UDim2.new(0, 0, v26 * 0.1, 0), "Out", "Quad", 0.25, true)
        u4:New(u25, "<AnimateStyle=Appear><ContainerHorizontalAlignment=Center><TextStrokeTransparency=0>" .. u21, {
            ["ZIndex"] = 10,
            ["TextScale"] = 1,
            ["AnimateStepFrequency"] = 3
        }):ShowFast()
        local v27 = #u25:GetChildren()
        local v28 = v27 < 3 and 0 or u25.AbsoluteSize.Y * (v27 - 2)
        u25.Size = UDim2.new(1, 0, 0.1, v28)
        local v29 = string.len(u21) * 0.15
        local v30 = v29 >= 10 and 10 or v29
        local v31 = task.delay(v30, function() --[[ Line: 146 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u17
                [3] = u21
            --]]
            u25:Destroy()
            u17[u21] = nil
        end)
        if u17[u21] == nil then
            u17[u21] = {
                ["NotificationLabel"] = u25,
                ["DestroyTask"] = v31
            }
        end
        local v32 = u25:GetDescendants()
        for v33 = 1, #v32 do
            local v34 = v32[v33]
            if v34:IsA("TextLabel") and (v34.Visible == true and (v34.Text ~= "" and v34.TextTransparency < 1)) then
                script.UIStroke:Clone().Parent = v34
            end
        end
        return u25
    end
    local u35 = u17[u21].NotificationLabel
    local v36 = u17[u21].DestroyTask
    task.cancel(v36)
    local v37 = string.len(u21) * 0.15
    local v38 = v37 >= 10 and 10 or v37
    local v39 = task.delay(v38, function() --[[ Line: 176 ]]
        --[[
        Upvalues:
            [1] = u35
            [2] = u17
            [3] = u21
        --]]
        u35:Destroy()
        u17[u21] = nil
    end)
    local v40 = u35:FindFirstChild("BoomScale")
    if v40 then
        v40:Destroy()
    end
    local v41 = Instance.new("UIScale")
    v41.Name = "BoomScale"
    v41.Scale = 1
    v41.Parent = u35
    u5:Create(v41, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true, 0), {
        ["Scale"] = 1.25
    }):Play()
    _G.destroy(v41, 0.2)
    if v22 == false then
        local v42 = script["Notification Warning"]:Clone()
        v42.Parent = script
        v42.Name = "sfx"
        v42:Play()
        _G.destroy(v42, 3)
    end
    u17[u21] = {
        ["NotificationLabel"] = u35,
        ["DestroyTask"] = v39
    }
end
function v11.DisplayMessage(u44, u45, u46) --[[ Line: 204 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u8
        [3] = u10
        [4] = u9
        [5] = u43
    --]]
    local v47 = u7.GetStatsFolder(u8)
    if u46 == nil or v47.Settings.ShowShouts.Value ~= false then
        if not u10 then
            u10 = u9:WaitForChild("Notifications", 600)
        end
        _G.bindableExcu(function() --[[ Line: 216 ]]
            --[[
            Upvalues:
                [1] = u43
                [2] = u44
                [3] = u45
                [4] = u46
            --]]
            u43(u44, u45, u46)
        end)
    end
end
_G.displayMessage = v11.DisplayMessage
function _G.displayMessageWithButton(p48, p49, p50) --[[ Line: 223 ]]
    --[[
    Upvalues:
        [1] = u43
    --]]
    local v51 = u43(p48)
    if v51 then
        local v52 = p49:Clone()
        v52.Parent = v51
        v52.MouseButton1Click:Connect(p50)
    end
end
return v11