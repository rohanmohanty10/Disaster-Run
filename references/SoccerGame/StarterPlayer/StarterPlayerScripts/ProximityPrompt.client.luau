  

local UserInputService = game:GetService("UserInputService");
local ProximityPromptService = game:GetService("ProximityPromptService");
local TweenService = game:GetService("TweenService");
local TextService = game:GetService("TextService");
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local u1 = {
    [Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png",
    [Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png",
    [Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png",
    [Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png",
    [Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png",
    [Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png",
    [Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png",
    [Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png",
    [Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu.png",
    [Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLS.png",
    [Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRS.png"
};
local u2 = {
    [Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
    [Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
    [Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
};
local u3 = {
    ["\'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
    [","] = "rbxasset://textures/ui/Controls/comma.png",
    ["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
    ["."] = "rbxasset://textures/ui/Controls/period.png",
    [" "] = "rbxasset://textures/ui/Controls/spacebar.png"
};
local u4 = {
    [Enum.KeyCode.LeftControl] = "Ctrl",
    [Enum.KeyCode.RightControl] = "Ctrl",
    [Enum.KeyCode.LeftAlt] = "Alt",
    [Enum.KeyCode.RightAlt] = "Alt",
    [Enum.KeyCode.F1] = "F1",
    [Enum.KeyCode.F2] = "F2",
    [Enum.KeyCode.F3] = "F3",
    [Enum.KeyCode.F4] = "F4",
    [Enum.KeyCode.F5] = "F5",
    [Enum.KeyCode.F6] = "F6",
    [Enum.KeyCode.F7] = "F7",
    [Enum.KeyCode.F8] = "F8",
    [Enum.KeyCode.F9] = "F9",
    [Enum.KeyCode.F10] = "F10",
    [Enum.KeyCode.F11] = "F11",
    [Enum.KeyCode.F12] = "F12"
};

local function getScreenGui() -- Line: 60
    -- upvalues: PlayerGui (copy)
    local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts");

    if ProximityPrompts == nil then
        ProximityPrompts = Instance.new("ScreenGui");
        ProximityPrompts.Name = "ProximityPrompts";
        ProximityPrompts.ResetOnSpawn = false;
        ProximityPrompts.Parent = PlayerGui;
    end;

    return ProximityPrompts;
end;

local function createProgressBarGradient(p5, p6) -- Line: 71
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(0.5, 1);
    Frame.Position = UDim2.fromScale(p6 and 0 or 0.5, 0);
    Frame.BackgroundTransparency = 1;
    Frame.ClipsDescendants = true;
    Frame.Parent = p5;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.fromScale(2, 1);
    ImageLabel.Position = UDim2.fromScale(p6 and 0 or -1, 0);
    ImageLabel.Image = "rbxasset://textures/ui/Controls/RadialFill.png";
    ImageLabel.Parent = Frame;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.4999, 0),
        NumberSequenceKeypoint.new(0.5, 1),
        NumberSequenceKeypoint.new(1, 1)
    });
    UIGradient.Rotation = p6 and 180 or 0;
    UIGradient.Parent = ImageLabel;

    return UIGradient;
end;

local function createCircularProgressBar() -- Line: 99
    -- upvalues: createProgressBarGradient (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "CircularProgressBar";
    Frame.Size = UDim2.fromOffset(58, 58);
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.BackgroundTransparency = 1;
    local u7 = createProgressBarGradient(Frame, true);
    local u8 = createProgressBarGradient(Frame, false);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Name = "Progress";
    NumberValue.Parent = Frame;
    NumberValue.Changed:Connect(function(p9) -- Line: 113
        -- upvalues: u7 (copy), u8 (copy)
        local math_clamp_ret = math.clamp(p9 * 360, 0, 360);
        u7.Rotation = math.clamp(math_clamp_ret, 180, 360);
        u8.Rotation = math.clamp(math_clamp_ret, 0, 180);
    end);

    return Frame;
end;

local function createPrompt(u10, p11, p12) -- Line: 122
    -- upvalues: TweenService (copy), u1 (copy), UserInputService (copy), u2 (copy), u3 (copy), u4 (copy), createCircularProgressBar (copy), TextService (copy)
    local u13 = {};
    local u14 = {};
    local u15 = {};
    local u16 = {};
    local TweenInfo_new_ret = TweenInfo.new(u10.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local TweenInfo_new_ret3 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local TweenInfo_new_ret4 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "Prompt";
    BillboardGui.AlwaysOnTop = true;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Image = "rbxassetid://115789466235547";
    ImageLabel.Size = UDim2.fromScale(0.5, 1);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.BackgroundColor3 = Color3.new(0.07, 0.07, 0.07);
    ImageLabel.Parent = BillboardGui;
    Instance.new("UICorner").Parent = ImageLabel;
    local Frame = Instance.new("Frame");
    Frame.Name = "InputFrame";
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundTransparency = 1;
    Frame.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    Frame.Parent = ImageLabel;
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.fromScale(1, 1);
    Frame2.Position = UDim2.fromScale(0.5, 0.5);
    Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame2.BackgroundTransparency = 1;
    Frame2.Parent = Frame;
    local UIScale = Instance.new("UIScale");
    UIScale.Parent = Frame2;
    table.insert(u13, TweenService:Create(UIScale, TweenInfo_new_ret3, {
        Scale = p11 == Enum.ProximityPromptInputType.Touch and 1.6 or 1.33
    }));
    table.insert(u14, TweenService:Create(UIScale, TweenInfo_new_ret3, {
        Scale = 1
    }));
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "ActionText";
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.Font = Enum.Font.Montserrat;
    TextLabel.TextSize = 19;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextTransparency = 1;
    TextLabel.TextColor3 = Color3.new(1, 1, 1);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = ImageLabel;
    table.insert(u13, TweenService:Create(TextLabel, TweenInfo_new_ret3, {
        TextTransparency = 1
    }));
    table.insert(u14, TweenService:Create(TextLabel, TweenInfo_new_ret3, {
        TextTransparency = 0
    }));
    table.insert(u15, TweenService:Create(TextLabel, TweenInfo_new_ret3, {
        TextTransparency = 1
    }));
    table.insert(u16, TweenService:Create(TextLabel, TweenInfo_new_ret3, {
        TextTransparency = 0
    }));
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Name = "ObjectText";
    TextLabel2.Size = UDim2.fromScale(1, 1);
    TextLabel2.Font = Enum.Font.Montserrat;
    TextLabel2.TextSize = 14;
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.TextTransparency = 1;
    TextLabel2.TextColor3 = Color3.new(0.7, 0.7, 0.7);
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Parent = ImageLabel;
    table.insert(u13, TweenService:Create(TextLabel2, TweenInfo_new_ret3, {
        TextTransparency = 1
    }));
    table.insert(u14, TweenService:Create(TextLabel2, TweenInfo_new_ret3, {
        TextTransparency = 0
    }));
    table.insert(u15, TweenService:Create(TextLabel2, TweenInfo_new_ret3, {
        TextTransparency = 1
    }));
    table.insert(u16, TweenService:Create(TextLabel2, TweenInfo_new_ret3, {
        TextTransparency = 0
    }));
    local v17 = {
        ImageTransparency = 0,
        Size = UDim2.fromScale(0.5, 1)
    };
    table.insert(u13, TweenService:Create(ImageLabel, TweenInfo_new_ret3, v17));
    local v18 = {
        ImageTransparency = 0,
        Size = UDim2.fromScale(1, 1)
    };
    table.insert(u14, TweenService:Create(ImageLabel, TweenInfo_new_ret3, v18));
    local v19 = {
        ImageTransparency = 1,
        Size = UDim2.fromScale(0.5, 1)
    };
    table.insert(u15, TweenService:Create(ImageLabel, TweenInfo_new_ret3, v19));
    local v20 = {
        ImageTransparency = 0,
        Size = UDim2.fromScale(1, 1)
    };
    table.insert(u16, TweenService:Create(ImageLabel, TweenInfo_new_ret3, v20));
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "RoundFrame";
    Frame3.Size = UDim2.fromOffset(48, 48);
    Frame3.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame3.Position = UDim2.fromScale(0.5, 0.5);
    Frame3.BackgroundTransparency = 1;
    Frame3.Parent = Frame2;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0.5, 0);
    UICorner.Parent = Frame3;
    table.insert(u15, TweenService:Create(Frame3, TweenInfo_new_ret4, {
        BackgroundTransparency = 1
    }));
    table.insert(u16, TweenService:Create(Frame3, TweenInfo_new_ret4, {
        BackgroundTransparency = 1
    }));

    if p11 == Enum.ProximityPromptInputType.Gamepad then
        if u1[u10.GamepadKeyCode] then
            local ImageLabel2 = Instance.new("ImageLabel");
            ImageLabel2.Name = "ButtonImage";
            ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
            ImageLabel2.Size = UDim2.fromOffset(24, 24);
            ImageLabel2.Position = UDim2.fromScale(0.5, 0.5);
            ImageLabel2.BackgroundTransparency = 1;
            ImageLabel2.ImageTransparency = 1;
            ImageLabel2.Image = u1[u10.GamepadKeyCode];
            ImageLabel2.Parent = Frame2;
            table.insert(u15, TweenService:Create(ImageLabel2, TweenInfo_new_ret4, {
                ImageTransparency = 1
            }));
            table.insert(u16, TweenService:Create(ImageLabel2, TweenInfo_new_ret4, {
                ImageTransparency = 0
            }));
        end;
    elseif p11 == Enum.ProximityPromptInputType.Touch then
        local ImageLabel2 = Instance.new("ImageLabel");
        ImageLabel2.Name = "ButtonImage";
        ImageLabel2.BackgroundTransparency = 1;
        ImageLabel2.ImageTransparency = 1;
        ImageLabel2.Size = UDim2.fromOffset(25, 31);
        ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel2.Position = UDim2.fromScale(0.5, 0.5);
        ImageLabel2.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png";
        ImageLabel2.Parent = Frame2;
        table.insert(u15, TweenService:Create(ImageLabel2, TweenInfo_new_ret4, {
            ImageTransparency = 1
        }));
        table.insert(u16, TweenService:Create(ImageLabel2, TweenInfo_new_ret4, {
            ImageTransparency = 0
        }));
    else
        local ImageLabel2 = Instance.new("ImageLabel");
        ImageLabel2.Name = "ButtonImage";
        ImageLabel2.BackgroundTransparency = 1;
        ImageLabel2.ImageTransparency = 1;
        ImageLabel2.Size = UDim2.fromOffset(28, 30);
        ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel2.Position = UDim2.fromScale(0.5, 0.5);
        ImageLabel2.Image = "rbxasset://textures/ui/Controls/key_single.png";
        ImageLabel2.Parent = Frame2;
        table.insert(u15, TweenService:Create(ImageLabel2, TweenInfo_new_ret4, {
            ImageTransparency = 1
        }));
        table.insert(u16, TweenService:Create(ImageLabel2, TweenInfo_new_ret4, {
            ImageTransparency = 0
        }));
        local StringForKeyCode = UserInputService:GetStringForKeyCode(u10.KeyboardKeyCode);
        local v21 = u2[u10.KeyboardKeyCode];

        if v21 == nil then
            v21 = u3[StringForKeyCode];
        end;

        if v21 == nil then
            StringForKeyCode = u4[u10.KeyboardKeyCode] or StringForKeyCode;
        end;

        if v21 then
            local ImageLabel3 = Instance.new("ImageLabel");
            ImageLabel3.Name = "ButtonImage";
            ImageLabel3.AnchorPoint = Vector2.new(0.5, 0.5);
            ImageLabel3.Size = UDim2.fromOffset(36, 36);
            ImageLabel3.Position = UDim2.fromScale(0.5, 0.5);
            ImageLabel3.BackgroundTransparency = 1;
            ImageLabel3.ImageTransparency = 1;
            ImageLabel3.Image = v21;
            ImageLabel3.Parent = Frame2;
            table.insert(u15, TweenService:Create(ImageLabel3, TweenInfo_new_ret4, {
                ImageTransparency = 1
            }));
            table.insert(u16, TweenService:Create(ImageLabel3, TweenInfo_new_ret4, {
                ImageTransparency = 0
            }));
        elseif StringForKeyCode == nil or StringForKeyCode == "" then
            error("ProximityPrompt \'" .. u10.Name .. "\' has an unsupported keycode for rendering UI: " .. tostring(u10.KeyboardKeyCode));
        else
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.Name = "ButtonText";
            TextLabel3.Position = UDim2.fromOffset(0, -1);
            TextLabel3.Size = UDim2.fromScale(1, 1);
            TextLabel3.Font = Enum.Font.Montserrat;
            TextLabel3.TextSize = 14;

            if string.len(StringForKeyCode) > 2 then
                TextLabel3.TextSize = 12;
            end;

            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.TextTransparency = 1;
            TextLabel3.TextColor3 = Color3.new(1, 1, 1);
            TextLabel3.TextXAlignment = Enum.TextXAlignment.Center;
            TextLabel3.Text = StringForKeyCode;
            TextLabel3.Parent = Frame2;
            table.insert(u15, TweenService:Create(TextLabel3, TweenInfo_new_ret4, {
                TextTransparency = 1
            }));
            table.insert(u16, TweenService:Create(TextLabel3, TweenInfo_new_ret4, {
                TextTransparency = 0
            }));
        end;
    end;

    if p11 == Enum.ProximityPromptInputType.Touch or u10.ClickablePrompt then
        local TextButton = Instance.new("TextButton");
        TextButton.BackgroundTransparency = 1;
        TextButton.TextTransparency = 1;
        TextButton.Size = UDim2.fromScale(1, 1);
        TextButton.Parent = BillboardGui;
        local u22 = false;
        TextButton.InputBegan:Connect(function(p23) -- Line: 318
            -- upvalues: u10 (copy), u22 (ref)
            if (p23.UserInputType == Enum.UserInputType.Touch or p23.UserInputType == Enum.UserInputType.MouseButton1) and p23.UserInputState ~= Enum.UserInputState.Change then
                u10:InputHoldBegin();
                u22 = true;
            end;
        end);
        TextButton.InputEnded:Connect(function(p24) -- Line: 325
            -- upvalues: u22 (ref), u10 (copy)
            if (p24.UserInputType == Enum.UserInputType.Touch or p24.UserInputType == Enum.UserInputType.MouseButton1) and u22 then
                u22 = false;
                u10:InputHoldEnd();
            end;
        end);
        BillboardGui.Active = true;
    end;

    if u10.HoldDuration > 0 then
        local v25 = createCircularProgressBar();
        v25.Parent = Frame2;
        table.insert(u13, TweenService:Create(v25.Progress, TweenInfo_new_ret, {
            Value = 1
        }));
        table.insert(u14, TweenService:Create(v25.Progress, TweenInfo_new_ret2, {
            Value = 0
        }));
    end;

    local u26, u27;

    if u10.HoldDuration > 0 then
        u26 = u10.PromptButtonHoldBegan:Connect(function() -- Line: 350
            -- upvalues: u13 (copy)
            for _, v in ipairs(u13) do
                v:Play();
            end;
        end);
        u27 = u10.PromptButtonHoldEnded:Connect(function() -- Line: 356
            -- upvalues: u14 (copy)
            for _, v in ipairs(u14) do
                v:Play();
            end;
        end);
    else
        u26 = nil;
        u27 = nil;
    end;

    local u28 = u10.Triggered:Connect(function() -- Line: 363
        -- upvalues: u15 (copy)
        for _, v in ipairs(u15) do
            v:Play();
        end;
    end);
    local u29 = u10.TriggerEnded:Connect(function() -- Line: 369
        -- upvalues: u16 (copy)
        for _, v in ipairs(u16) do
            v:Play();
        end;
    end);

    local function updateUIFromPrompt() -- Line: 375
        -- upvalues: TextService (ref), u10 (copy), TextLabel (copy), TextLabel2 (copy), ImageLabel (copy), BillboardGui (copy)
        local TextSize = TextService:GetTextSize(u10.ActionText, 19, Enum.Font.Montserrat, Vector2.new(1000, 1000));
        local TextSize2 = TextService:GetTextSize(u10.ObjectText, 14, Enum.Font.Montserrat, Vector2.new(1000, 1000));
        local math_max_ret = math.max(TextSize.X, TextSize2.X);
        local v30 = (u10.ActionText == nil or u10.ActionText == "") and (u10.ObjectText == nil or u10.ObjectText == "") and 72 or math_max_ret + 72 + 24;
        TextLabel.Position = UDim2.new(0.5, 72 - v30 / 2, 0, (u10.ObjectText == nil or u10.ObjectText == "") and 0 or 9);
        TextLabel2.Position = UDim2.new(0.5, 72 - v30 / 2, 0, -10);
        TextLabel.Text = u10.ActionText;
        TextLabel2.Text = u10.ObjectText;
        TextLabel.AutoLocalize = u10.AutoLocalize;
        TextLabel.RootLocalizationTable = u10.RootLocalizationTable;

        if u10.ActionText:match("R") or u10:GetAttribute("Second") then
            ImageLabel.Image = "rbxassetid://115789466235547";
        else
            ImageLabel.Image = "rbxassetid://89426684482295";
        end;

        TextLabel2.AutoLocalize = u10.AutoLocalize;
        TextLabel2.RootLocalizationTable = u10.RootLocalizationTable;
        BillboardGui.Size = UDim2.fromOffset(v30, 72);
        BillboardGui.SizeOffset = Vector2.new(u10.UIOffset.X / BillboardGui.Size.Width.Offset, u10.UIOffset.Y / BillboardGui.Size.Height.Offset);
    end;

    local u31 = u10.Changed:Connect(updateUIFromPrompt);
    updateUIFromPrompt();
    BillboardGui.Adornee = u10.Parent;
    BillboardGui.Parent = p12;

    for _, v in ipairs(u16) do
        v:Play();
    end;

    return function() -- Line: 424, Name: cleanup
        -- upvalues: u26 (ref), u27 (ref), u28 (ref), u29 (ref), u31 (copy), u15 (copy), BillboardGui (copy)
        if u26 then
            u26:Disconnect();
        end;

        if u27 then
            u27:Disconnect();
        end;

        u28:Disconnect();
        u29:Disconnect();
        u31:Disconnect();

        for _, v in ipairs(u15) do
            v:Play();
        end;

        wait(0.2);
        BillboardGui.Parent = nil;
    end;
end;

local function onLoad() -- Line: 449
    -- upvalues: ProximityPromptService (copy), PlayerGui (copy), createPrompt (copy)
    ProximityPromptService.PromptShown:Connect(function(p32, p33) -- Line: 451
        -- upvalues: PlayerGui (ref), createPrompt (ref)
        if p32.Style == Enum.ProximityPromptStyle.Default then
            return;
        end;

        if p32:GetAttribute("Hidden") then
            return;
        end;

        local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts");

        if ProximityPrompts == nil then
            ProximityPrompts = Instance.new("ScreenGui");
            ProximityPrompts.Name = "ProximityPrompts";
            ProximityPrompts.ResetOnSpawn = false;
            ProximityPrompts.Parent = PlayerGui;
        end;

        local v34 = createPrompt(p32, p33, ProximityPrompts);
        p32.PromptHidden:Wait();
        v34();
    end);
end;

ProximityPromptService.PromptShown:Connect(function(p35, p36) -- Line: 451
    -- upvalues: PlayerGui (copy), createPrompt (copy)
    if p35.Style == Enum.ProximityPromptStyle.Default then
        return;
    end;

    if p35:GetAttribute("Hidden") then
        return;
    end;

    local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts");

    if ProximityPrompts == nil then
        ProximityPrompts = Instance.new("ScreenGui");
        ProximityPrompts.Name = "ProximityPrompts";
        ProximityPrompts.ResetOnSpawn = false;
        ProximityPrompts.Parent = PlayerGui;
    end;

    local v37 = createPrompt(p35, p36, ProximityPrompts);
    p35.PromptHidden:Wait();
    v37();
end);