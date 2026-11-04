 

local v1 = game:GetService("ReplicatedStorage")
local _ = game:GetService("Players").LocalPlayer
local u2 = script.Parent
local v3 = require(v1.Modules.Client.Slider)
local v4 = u2:WaitForChild("Main")
local v5 = v4:WaitForChild("OptionsFrame")
local u6 = u2:WaitForChild("RemoteEvent")
local u7 = u2:GetAttribute("isServer")
local u8 = u2:WaitForChild("clientEvent")
local u9
if _G.UIEnabled == true then
    _G.hideUI(true)
    u9 = true
else
    u9 = false
end
script.Roblox_UI_Indicator:Play()
_G.tween(script.Parent.Main.UIStroke, {
    0.4,
    Enum.EasingStyle.Sine,
    Enum.EasingDirection.Out,
    -1,
    true,
    0
}, {
    ["Thickness"] = 0
})
local v10 = v4:WaitForChild("Slider")
local v11 = v10:WaitForChild("Bar")
local u12 = v11:WaitForChild("UIGradient")
local u13 = v10:WaitForChild("Value")
local u14 = Color3.fromRGB(179, 179, 179)
local u15 = Color3.fromRGB(100, 100, 100)
local u16 = v3.new(v11, {
    ["Start"] = v10:GetAttribute("Start"),
    ["End"] = v10:GetAttribute("End"),
    ["Increment"] = v10:GetAttribute("Increment") or 1,
    ["Default"] = 0
}, TweenInfo.new(0, Enum.EasingStyle.Linear), "X", 0.25)
u16:Track()
local u17 = v10:GetAttribute("DisplayText")
local function u27() --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u16
        [3] = u17
        [4] = u12
        [5] = u14
        [6] = u15
    --]]
    u13.Text = u16:GetValue() .. " " .. u17
    local v18 = u12
    local v19 = ColorSequence.new
    local v20 = {}
    local v21 = ColorSequenceKeypoint.new(0, u14)
    local v22 = ColorSequenceKeypoint.new
    local v23 = u16._percent + 0.001
    local v24 = v22(math.clamp(v23, 0.001, 0.998), u14)
    local v25 = ColorSequenceKeypoint.new
    local v26 = u16._percent + 0.002
    __set_list(v20, 1, {v21, v24, v25(math.clamp(v26, 0.002, 0.999), u15), ColorSequenceKeypoint.new(1, u15)})
    v18.Color = v19(v20)
end
u16.Changed:Connect(function(_) --[[ Line: 61 ]]
    --[[
    Upvalues:
        [1] = u27
    --]]
    u27()
end)
u16.Released:Connect(function(_) --[[ Line: 66 ]]
    --[[
    Upvalues:
        [1] = u27
    --]]
    u27()
end)
u16.OnClick:Connect(function(_) --[[ Line: 71 ]]
    --[[
    Upvalues:
        [1] = u27
    --]]
    u27()
end)
u16:OverrideValue(v10:GetAttribute("Start"))
local v28 = v5:GetChildren()
for v29 = 1, #v28 do
    if v28[v29]:IsA("ImageButton") then
        local u30 = v28[v29].Name
        v28[v29].MouseButton1Click:Connect(function() --[[ Line: 82 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u30
                [3] = u6
                [4] = u16
                [5] = u8
                [6] = u9
                [7] = u2
            --]]
            if u7 == true then
                if u30 == "Accept" then
                    u6:FireServer(u16:GetValue())
                else
                    u6:FireServer(false)
                end
            elseif u30 == "Accept" then
                u8:Fire(u16:GetValue())
            else
                u8:Fire(false)
            end
            if u9 == true then
                _G.hideUI(false)
            end
            u2:Destroy()
        end)
    end
end