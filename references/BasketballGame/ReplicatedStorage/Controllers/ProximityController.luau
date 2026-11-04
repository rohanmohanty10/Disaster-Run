 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProximityPromptService = game:GetService("ProximityPromptService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local v1 = require(ReplicatedStorage.Packages.Knit).CreateController({
    Name = "ProximityController"
});
local script_BillboardGui = script.BillboardGui;
local Color3_fromRGB_ret = Color3.fromRGB(58, 237, 29);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 255, 255);
local u2 = {};

local function getOrCreateScale(p3: userdata) -- Line: 23
    local v4 = p3:FindFirstChildOfClass("UIScale");

    if v4 then
        return v4;
    end;

    local UIScale = Instance.new("UIScale");
    UIScale.Scale = 1;
    UIScale.Parent = p3;

    return UIScale;
end;

local function tweenScale(p5: userdata, p6: number, p7: number, p8: any, p9: any) -- Line: 37
    -- upvalues: TweenService (copy)
    local v10 = TweenService:Create(p5, TweenInfo.new(p7, p8 or Enum.EasingStyle.Back, p9 or Enum.EasingDirection.Out), {
        Scale = p6
    });
    v10:Play();

    return v10;
end;

local function createHardFillSequence(p11: number) -- Line: 55
    local math_clamp_ret = math.clamp(p11, 0, 1);

    if math_clamp_ret >= 1 then
        return NumberSequence.new(0);
    end;

    return NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(math_clamp_ret, 0),
        NumberSequenceKeypoint.new(math.min(math_clamp_ret + 0.001, 1), 1),
        NumberSequenceKeypoint.new(1, 1)
    });
end;

local function setupPrice(p12: any, p13: string, p14: number) -- Line: 70
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    local v15 = p13 == "Cash";
    p12.cashIcon.Visible = v15;
    p12.robuxIcon.Visible = not v15;
    p12.priceLabel.Text = tostring(p14);
    p12.priceLabel.TextColor3 = v15 and Color3_fromRGB_ret or Color3_fromRGB_ret2;
end;

local function tweenKeyBindScale(p16: any, p17: number, p18: number, p19: any, p20: any) -- Line: 79
    -- upvalues: tweenScale (copy)
    if p16.keyBindScaleTween then
        p16.keyBindScaleTween:Cancel();
    end;

    p16.keyBindScaleTween = tweenScale(p16.keyBindScale, p17, p18, p19, p20);
end;

local function resetFill(p21) -- Line: 93
    if p21.holdTween then
        p21.holdTween:Cancel();
        p21.holdTween = nil;
    end;

    p21.fillProgress.Value = 0;
    p21.holdCompleted = false;
end;

local function updateKeybindDisplay(p22, p23) -- Line: 103
    -- upvalues: UserInputService (copy)
    local prompt = p22.prompt;

    if p23 == Enum.ProximityPromptInputType.Touch then
        p22.keyBindText.Visible = false;
        p22.tapIcon.Visible = true;

        return;
    end;

    p22.tapIcon.Visible = false;
    p22.keyBindText.Visible = true;
    local v24;

    if p23 == Enum.ProximityPromptInputType.Gamepad then
        v24 = prompt.GamepadKeyCode;
    else
        v24 = prompt.KeyboardKeyCode;
    end;

    p22.keyBindText.Text = UserInputService:GetStringForKeyCode(v24);
end;

local function showEntry(p25) -- Line: 123
    -- upvalues: tweenScale (copy)
    if p25.visibilityTween then
        p25.visibilityTween:Cancel();
    end;

    p25.billboardGui.Enabled = true;
    p25.container.Visible = true;
    p25.interactionButton.Visible = true;
    p25.containerScale.Scale = 0;
    p25.keyBind.Image = "rbxassetid://88408257160395";
    p25.visibilityTween = tweenScale(p25.containerScale, 1, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
end;

local function hideEntry(u26) -- Line: 137
    -- upvalues: tweenScale (copy)
    if u26.holdTween then
        u26.holdTween:Cancel();
        u26.holdTween = nil;
    end;

    u26.fillProgress.Value = 0;
    u26.holdCompleted = false;
    u26.keyBind.Image = "rbxassetid://88408257160395";

    if u26.visibilityTween then
        u26.visibilityTween:Cancel();
    end;

    u26.visibilityTween = tweenScale(u26.containerScale, 0, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In);
    u26.visibilityTween.Completed:Once(function() -- Line: 148
        -- upvalues: u26 (copy)
        u26.container.Visible = false;
        u26.interactionButton.Visible = false;
        u26.billboardGui.Enabled = false;
    end);
end;

local function cleanupEntry(p27: userdata) -- Line: 155
    -- upvalues: u2 (copy)
    local v28 = u2[p27];

    if not v28 then
        return;
    end;

    if v28.holdTween then
        v28.holdTween:Cancel();
    end;

    if v28.visibilityTween then
        v28.visibilityTween:Cancel();
    end;

    if v28.keyBindScaleTween then
        v28.keyBindScaleTween:Cancel();
    end;

    v28.billboardGui:Destroy();
    u2[p27] = nil;
end;

local function buildEntry(u29: userdata) -- Line: 178
    -- upvalues: script_BillboardGui (copy), Players (copy), createHardFillSequence (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), cleanupEntry (copy)
    local v30 = script_BillboardGui:Clone();
    v30.Adornee = u29.Parent;
    v30.Enabled = false;
    v30.Parent = Players.LocalPlayer:WaitForChild("PlayerGui");
    local Container = v30:WaitForChild("Container");
    local ImageButton = v30:WaitForChild("ImageButton");
    local PriceFrame = Container:WaitForChild("PriceFrame");
    local Icon = PriceFrame:WaitForChild("Icon");
    local RobuxIcon = PriceFrame:WaitForChild("RobuxIcon");
    local AmountLabel = PriceFrame:WaitForChild("AmountLabel");
    local UIGradient = Container:WaitForChild("Fill"):WaitForChild("UIGradient");
    local KeyBind = Container:WaitForChild("KeyBind");
    local KeybindText = KeyBind:WaitForChild("KeybindText");
    local TapIcon = KeyBind:WaitForChild("TapIcon");
    local v31 = Container:FindFirstChildOfClass("UIScale");

    if not v31 then
        v31 = Instance.new("UIScale");
        v31.Scale = 1;
        v31.Parent = Container;
    end;

    local v32 = KeyBind:FindFirstChildOfClass("UIScale");

    if not v32 then
        v32 = Instance.new("UIScale");
        v32.Scale = 1;
        v32.Parent = KeyBind;
    end;

    v31.Scale = 0;
    v32.Scale = 1;
    KeyBind.Image = "rbxassetid://88408257160395";
    ImageButton.Active = true;
    ImageButton.AutoButtonColor = false;
    Container.Visible = false;
    ImageButton.Visible = false;
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 0;
    local u33 = {
        holdCompleted = false,
        holdTween = nil,
        keyBindScaleTween = nil,
        visibilityTween = nil,
        prompt = u29,
        billboardGui = v30,
        container = Container,
        interactionButton = ImageButton,
        cashIcon = Icon,
        robuxIcon = RobuxIcon,
        priceLabel = AmountLabel,
        fillGradient = UIGradient,
        keyBind = KeyBind,
        keyBindText = KeybindText,
        tapIcon = TapIcon,
        containerScale = v31,
        keyBindScale = v32,
        fillProgress = NumberValue
    };
    NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 232
        -- upvalues: NumberValue (copy), u33 (copy), createHardFillSequence (ref)
        u33.fillGradient.Transparency = createHardFillSequence(0.2 + NumberValue.Value * 0.8);
    end);
    Container.ActionText.Text = u29.ActionText;
    Container.ObjectText.Text = u29.ObjectText;

    if u29:GetAttribute("CurrencyType") then
        PriceFrame.Visible = true;
        Container.ActionText.Visible = false;
        local v34 = u29:GetAttribute("CurrencyType") or "Robux";
        local v35 = u29:GetAttribute("Price") or 0;
        local v36 = v34 == "Cash";
        u33.cashIcon.Visible = v36;
        u33.robuxIcon.Visible = not v36;
        u33.priceLabel.Text = tostring(v35);
        u33.priceLabel.TextColor3 = v36 and Color3_fromRGB_ret or Color3_fromRGB_ret2;
    end;

    u29.Destroying:Connect(function() -- Line: 247
        -- upvalues: cleanupEntry (ref), u29 (copy)
        cleanupEntry(u29);
    end);

    return u33;
end;

local function onPromptShown(p37: userdata, p38: any) -- Line: 254
    -- upvalues: u2 (copy), buildEntry (copy), updateKeybindDisplay (copy), showEntry (copy)
    if p37.Style ~= Enum.ProximityPromptStyle.Custom then
        return;
    end;

    local v39 = u2[p37];

    if not v39 then
        v39 = buildEntry(p37);
        u2[p37] = v39;
    end;

    updateKeybindDisplay(v39, p38);
    showEntry(v39);
end;

local function onPromptHidden(p40: userdata) -- Line: 270
    -- upvalues: u2 (copy), hideEntry (copy)
    local v41 = u2[p40];

    if not v41 then
        return;
    end;

    hideEntry(v41);
end;

local function onPromptButtonHoldBegan(p42: userdata) -- Line: 280
    -- upvalues: u2 (copy), tweenScale (copy), TweenService (copy)
    local v43 = u2[p42];

    if not v43 then
        return;
    end;

    v43.holdCompleted = false;
    local Quad = Enum.EasingStyle.Quad;
    local Out = Enum.EasingDirection.Out;

    if v43.keyBindScaleTween then
        v43.keyBindScaleTween:Cancel();
    end;

    v43.keyBindScaleTween = tweenScale(v43.keyBindScale, 0.9, 0.1, Quad, Out);
    v43.keyBind.Image = "rbxassetid://118823003534031";
    v43.fillProgress.Value = 0;

    if v43.holdTween then
        v43.holdTween:Cancel();
    end;

    v43.holdTween = TweenService:Create(v43.fillProgress, TweenInfo.new(math.max(p42.HoldDuration, 0.01), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 1
    });
    v43.holdTween:Play();
end;

local function onPromptButtonHoldEnded(p44: userdata) -- Line: 307
    -- upvalues: u2 (copy), tweenScale (copy)
    local v45 = u2[p44];

    if not v45 then
        return;
    end;

    local Back = Enum.EasingStyle.Back;
    local Out = Enum.EasingDirection.Out;

    if v45.keyBindScaleTween then
        v45.keyBindScaleTween:Cancel();
    end;

    v45.keyBindScaleTween = tweenScale(v45.keyBindScale, 1, 0.18, Back, Out);
    v45.keyBind.Image = "rbxassetid://88408257160395";

    if not v45.holdCompleted then
        if v45.holdTween then
            v45.holdTween:Cancel();
            v45.holdTween = nil;
        end;

        v45.fillProgress.Value = 0;
        v45.holdCompleted = false;
    end;
end;

local function onPromptTriggered(p46: userdata, p47: userdata) -- Line: 323
    -- upvalues: Players (copy), u2 (copy)
    if p47 ~= Players.LocalPlayer then
        return;
    end;

    local v48 = u2[p46];

    if not v48 then
        return;
    end;

    v48.holdCompleted = true;
end;

function v1.KnitInit(p49) -- Line: 337
end;

function v1.KnitStart(p50) -- Line: 341
    -- upvalues: ProximityPromptService (copy), onPromptShown (copy), onPromptHidden (copy), onPromptButtonHoldBegan (copy), onPromptButtonHoldEnded (copy), onPromptTriggered (copy)
    ProximityPromptService.PromptShown:Connect(onPromptShown);
    ProximityPromptService.PromptHidden:Connect(onPromptHidden);
    ProximityPromptService.PromptButtonHoldBegan:Connect(onPromptButtonHoldBegan);
    ProximityPromptService.PromptButtonHoldEnded:Connect(onPromptButtonHoldEnded);
    ProximityPromptService.PromptTriggered:Connect(onPromptTriggered);
end;

return v1;