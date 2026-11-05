  

 

local u1 = require(script.Parent:FindFirstChild("RichText") or script.Parent.Parent);
script.Parent.Enabled = true;
local TweenService = game:GetService("TweenService");
local Dialogue = script.Parent.Dialogue;
local TextFrame = Dialogue.TextFrame;
local Button = Dialogue.Button;
Dialogue.Visible = false;
Button.Visible = false;
local u2 = TweenService:Create(Button, TweenInfo.new(0.1), {
    ImageTransparency = 0
});
local u3 = TweenService:Create(Button, TweenInfo.new(0.1), {
    ImageTransparency = 1
});
local u4 = TweenService:Create(Button, TweenInfo.new(0.05, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
    Size = UDim2.new(0.25, 0, 0.25, 0)
});
local u5 = TweenService:Create(Dialogue, TweenInfo.new(0.4), {
    ImageTransparency = 0,
    Size = Dialogue.Size
});
local u6 = TweenService:Create(Dialogue, TweenInfo.new(0.4), {
    ImageTransparency = 1
});

local function showButton() -- Line: 21
    -- upvalues: Button (copy), u2 (copy)
    Button.Size = UDim2.new(0.3, 0, 0.3, 0);
    Button.Visible = true;
    u2:Play();
    wait(u2.TweenInfo.Time);
end;

local function clickButton() -- Line: 28
    -- upvalues: u4 (copy), u3 (copy), Button (copy)
    u4:Play();
    wait(u4.TweenInfo.Time);
    u3:Play();
    wait(u3.TweenInfo.Time);
    Button.Visible = false;
end;

local function showFrame() -- Line: 36
    -- upvalues: Dialogue (copy), u5 (copy)
    Dialogue.Size = UDim2.new(0.4, 0, 0.1, 0);
    Dialogue.ImageTransparency = 1;
    Dialogue.Visible = true;
    u5:Play();
    wait(u5.TweenInfo.Time);
end;

local function hideFrame() -- Line: 44
    -- upvalues: u6 (copy), Dialogue (copy)
    u6:Play();
    wait(u6.TweenInfo.Time);
    Dialogue.Visible = false;
end;

wait(2);
Dialogue.Size = UDim2.new(0.4, 0, 0.1, 0);
Dialogue.ImageTransparency = 1;
Dialogue.Visible = true;
u5:Play();
wait(u5.TweenInfo.Time);

local function showDialogue(p7, p8) -- Line: 50
    -- upvalues: u1 (copy), TextFrame (copy), Button (copy), u2 (copy), u4 (copy), u3 (copy)
    local v9 = u1:New(TextFrame, p7, {
        Font = "Cartoon"
    });
    v9:Animate(true);
    Button.Size = UDim2.new(0.3, 0, 0.3, 0);
    Button.Visible = true;
    u2:Play();
    wait(u2.TweenInfo.Time);
    wait(p8);
    u4:Play();
    wait(u4.TweenInfo.Time);
    u3:Play();
    wait(u3.TweenInfo.Time);
    Button.Visible = false;
    v9:Hide();
end;

for _, v in pairs({ {
        Text = "I just saw a <Color=Red>wild<Color=/>...a <AnimateStyle=Wiggle><Color=Red>wild pig🐷<Color=/>!<AnimateYield=1><AnimateStyle=/>\nOoh! See? Look! That black one there...<AnimateYield=1>\nDon\'t you see him?",
        Delay = 1.5
    }, {
        Text = "<AnimateYield=0.3>This is perfect! My wife was just telling me how she really wanted a pet...",
        Delay = 2.7
    }, {
        Text = "You ready to go grab it, Link?<AnimateYield=0.3>\n Now, you can\'t just run up on it!\nPigs are too alert to their surroundings for you to just jog up and capture one.",
        Delay = 3.5
    }, {
        Text = "If you want to get close to one, you have to hold <Img=1014975764> to crouch and tilt <Img=1014975761> to crawl slowly up behind it. <AnimateYield=1.5>Slow<AnimateYield=1>ly...",
        Delay = 3
    }, {
        Text = "You could also distract it with bait, I guess.",
        Delay = 1.5
    } }) do
    showDialogue(v.Text, v.Delay);
end;

u6:Play();
wait(u6.TweenInfo.Time);
Dialogue.Visible = false;