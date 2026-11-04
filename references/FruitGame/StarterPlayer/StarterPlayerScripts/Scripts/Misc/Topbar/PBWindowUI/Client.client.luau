 

local v1 = game:GetService("ReplicatedStorage")
local _ = game:GetService("Players").LocalPlayer
local u2 = script.Parent
local v3 = require(v1.Modules.Client.Slider)
local v4 = u2:WaitForChild("Main")
local v5 = v4:WaitForChild("OptionsFrame")
local u6 = u2:WaitForChild("RemoteEvent")
u2:GetAttribute("isServer")
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
local v7 = v4:WaitForChild("Slider")
local v8 = v7:WaitForChild("Bar")
local u9 = v8:WaitForChild("UIGradient")
local u10 = v7:WaitForChild("Value")
local u11 = Color3.fromRGB(179, 179, 179)
local u12 = Color3.fromRGB(100, 100, 100)
script.CustomValue.Value = 0.1
local u13 = v3.new(v8, {
    ["Start"] = 0,
    ["End"] = 1,
    ["Increment"] = 0.01,
    ["Default"] = 0.1
}, TweenInfo.new(0, Enum.EasingStyle.Linear), "X", 0.25)
u13:Track()
local function u23() --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u13
        [3] = u9
        [4] = u11
        [5] = u12
    --]]
    u10.Text = "Custom PB Window: " .. u13:GetValue() .. " Seconds"
    local v14 = u9
    local v15 = ColorSequence.new
    local v16 = {}
    local v17 = ColorSequenceKeypoint.new(0, u11)
    local v18 = ColorSequenceKeypoint.new
    local v19 = u13._percent + 0.001
    local v20 = v18(math.clamp(v19, 0.001, 0.998), u11)
    local v21 = ColorSequenceKeypoint.new
    local v22 = u13._percent + 0.002
    __set_list(v16, 1, {v17, v20, v21(math.clamp(v22, 0.002, 0.999), u12), ColorSequenceKeypoint.new(1, u12)})
    v14.Color = v15(v16)
end
u13.Changed:Connect(function(_) --[[ Line: 52 ]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    u23()
end)
u13.Released:Connect(function(_) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    u23()
end)
u13.OnClick:Connect(function(_) --[[ Line: 62 ]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    u23()
end)
u13:OverrideValue(0.1)
local u24 = script.CustomValue
local v25 = v5:GetChildren()
for v26 = 1, #v25 do
    if v25[v26]:IsA("ImageButton") then
        local u27 = v25[v26].Name
        v25[v26].MouseButton1Click:Connect(function() --[[ Line: 73 ]]
            --[[
            Upvalues:
                [1] = u27
                [2] = u24
                [3] = u13
                [4] = u2
                [5] = u6
            --]]
            if u27 == "Accept" then
                u24.Value = u13:GetValue()
                u2.Enabled = false
            else
                u6:FireServer(false)
                u2.Enabled = false
            end
        end)
    end
end