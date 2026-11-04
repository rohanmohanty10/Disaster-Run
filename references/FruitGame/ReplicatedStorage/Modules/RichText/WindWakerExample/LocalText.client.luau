 

local u1 = require(script.Parent:FindFirstChild("RichText") or script.Parent.Parent)
script.Parent.Enabled = true
local v2 = game:GetService("TweenService")
local v3 = script.Parent.Dialogue
local u4 = v3.TextFrame
local u5 = v3.Button
v3.Visible = false
u5.Visible = false
local u6 = v2:Create(u5, TweenInfo.new(0.1), {
    ["ImageTransparency"] = 0
})
local u7 = v2:Create(u5, TweenInfo.new(0.1), {
    ["ImageTransparency"] = 1
})
local u8 = v2:Create(u5, TweenInfo.new(0.05, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
    ["Size"] = UDim2.new(0.25, 0, 0.25, 0)
})
local v9 = v2:Create(v3, TweenInfo.new(0.4), {
    ["Size"] = v3.Size,
    ["ImageTransparency"] = 0
})
local v10 = v2:Create(v3, TweenInfo.new(0.4), {
    ["ImageTransparency"] = 1
})
wait(2)
v3.Size = UDim2.new(0.4, 0, 0.1, 0)
v3.ImageTransparency = 1
v3.Visible = true
v9:Play()
wait(v9.TweenInfo.Time)
local function v14(p11, p12) --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u4
        [3] = u5
        [4] = u6
        [5] = u8
        [6] = u7
    --]]
    local v13 = u1:New(u4, p11, {
        ["Font"] = "Cartoon"
    })
    v13:Animate(true)
    u5.Size = UDim2.new(0.3, 0, 0.3, 0)
    u5.Visible = true
    u6:Play()
    wait(u6.TweenInfo.Time)
    wait(p12)
    u8:Play()
    wait(u8.TweenInfo.Time)
    u7:Play()
    wait(u7.TweenInfo.Time)
    u5.Visible = false
    v13:Hide()
end
for _, v15 in pairs({
    {
        ["Text"] = "I just saw a <Color=Red>wild<Color=/>...a <AnimateStyle=Wiggle><Color=Red>wild pig\240\159\144\183<Color=/>!<AnimateYield=1><AnimateStyle=/>\nOoh! See? Look! That black one there...<AnimateYield=1>\nDon\'t you see him?",
        ["Delay"] = 1.5
    },
    {
        ["Text"] = "<AnimateYield=0.3>This is perfect! My wife was just telling me how she really wanted a pet...",
        ["Delay"] = 2.7
    },
    {
        ["Text"] = "You ready to go grab it, Link?<AnimateYield=0.3>\n Now, you can\'t just run up on it!\nPigs are too alert to their surroundings for you to just jog up and capture one.",
        ["Delay"] = 3.5
    },
    {
        ["Text"] = "If you want to get close to one, you have to hold <Img=1014975764> to crouch and tilt <Img=1014975761> to crawl slowly up behind it. <AnimateYield=1.5>Slow<AnimateYield=1>ly...",
        ["Delay"] = 3
    },
    {
        ["Text"] = "You could also distract it with bait, I guess.",
        ["Delay"] = 1.5
    }
}) do
    v14(v15.Text, v15.Delay)
end
v10:Play()
wait(v10.TweenInfo.Time)
v3.Visible = false