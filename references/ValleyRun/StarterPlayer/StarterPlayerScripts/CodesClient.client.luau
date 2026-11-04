 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local HudNavigation = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("HudNavigation"));
local Cursor = require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("Cursor"));
local CodeEvent = ChickenOrHero.Presentation:WaitForChild("CodeEvent");
local Interface = ChickenOrHero:WaitForChild("Interface");
local LocalPlayer = Players.LocalPlayer;
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Color3_fromRGB_ret = Color3.fromRGB(23, 23, 25);
local Color3_fromRGB_ret2 = Color3.fromRGB(76, 76, 81);
local Color3_fromRGB_ret3 = Color3.fromRGB(80, 255, 100);
local Color3_fromRGB_ret4 = Color3.fromRGB(17, 213, 40);
local Color3_fromRGB_ret5 = Color3.fromRGB(222, 222, 222);
local Color3_fromRGB_ret6 = Color3.fromRGB(253, 60, 85);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local u1 = nil;
local u2 = 0;

local function make(p3, p4, p5) -- Line: 31
    local Instance_new_ret = Instance.new(p3);

    for i, v in p5 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p4;

    return Instance_new_ret;
end;

local function stroke(p6, p7, p8) -- Line: 39
    local v9 = {
        Color = p7,
        Thickness = p8,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v9 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p6;

    return UIStroke;
end;

local function label(p10, p11, p12, p13, p14) -- Line: 42
    -- upvalues: Font_new_ret (copy)
    local v15 = {
        BackgroundTransparency = 1,
        FontFace = Font_new_ret,
        Text = p11,
        TextSize = p12,
        TextColor3 = p13,
        TextXAlignment = Enum.TextXAlignment.Left
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v15 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p10;

    for i, v in p14 do
        TextLabel[i] = v;
    end;

    return TextLabel;
end;

local function setStatus(p16, p17) -- Line: 59
    -- upvalues: u1 (ref), Color3_fromRGB_ret5 (copy)
    if u1 then
        u1.status.Text = p16 == "" and "Redeem a code for free rewards" or p16;
        local v18;

        if p16 == "" then
            v18 = Color3_fromRGB_ret5;
        else
            v18 = p17 or Color3_fromRGB_ret5;
        end;

        u1.status.TextColor3 = v18;
    end;
end;

local function setBusy(p19) -- Line: 65
    -- upvalues: u1 (ref)
    if u1 then
        u1.redeemLabel.Text = p19 and "CHECKING..." or "REDEEM";
        u1.redeem.AutoButtonColor = not p19;
    end;
end;

local function close() -- Line: 72
    -- upvalues: u1 (ref), Cursor (copy), LocalPlayer (copy)
    local v20 = u1;

    if not v20 then
        return;
    end;

    u1 = nil;

    for _, v in v20.connections do
        v:Disconnect();
    end;

    Cursor.release(v20.gui);
    v20.gui:Destroy();
    LocalPlayer:SetAttribute("CodesOpen", nil);
end;

local function submit() -- Line: 86
    -- upvalues: u1 (ref), u2 (ref), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret5 (copy), CodeEvent (copy)
    local v21 = u1;

    if not (v21 and (u2 <= 0 or os.clock() - u2 >= 20)) then
        return;
    end;

    local string_gsub_ret = string.gsub(v21.box.Text, "^%s+", "");
    local string_gsub_ret2 = string.gsub(string_gsub_ret, "%s+$", "");

    if string_gsub_ret2 == "" then
        local v22 = Color3_fromRGB_ret6;

        if u1 then
            u1.status.Text = "Type a code first.";
            u1.status.TextColor3 = v22 or Color3_fromRGB_ret5;
        end;

        return;
    end;

    u2 = os.clock();

    if u1 then
        u1.redeemLabel.Text = "CHECKING...";
        u1.redeem.AutoButtonColor = false;
    end;

    if u1 then
        u1.status.Text = "Redeem a code for free rewards";
        u1.status.TextColor3 = Color3_fromRGB_ret5;
    end;

    CodeEvent:FireServer("Redeem", string_gsub_ret2);
end;

local function open() -- Line: 103
    -- upvalues: u1 (ref), HudNavigation (copy), LocalPlayer (copy), Cursor (copy), Color3_new_ret2 (copy), close (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), label (copy), Color3_new_ret (copy), Color3_fromRGB_ret5 (copy), Font_new_ret (copy), Color3_fromRGB_ret6 (copy), u2 (ref), Color3_fromRGB_ret3 (copy), submit (copy), Color3_fromRGB_ret4 (copy), UserInputService (copy)
    if u1 then
        return;
    end;

    HudNavigation.opening("Codes");
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local v23 = {
        Name = "CodesPanel",
        DisplayOrder = 900,
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local ScreenGui = Instance.new("ScreenGui");

    for i, v in v23 do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = PlayerGui;
    ScreenGui:SetAttribute("SelfManagedText", true);
    local v24 = {
        gui = ScreenGui,
        connections = {}
    };
    u1 = v24;
    Cursor.request(ScreenGui);
    local v25 = {
        Name = "Shade",
        BackgroundTransparency = 0.35,
        AutoButtonColor = false,
        Selectable = false,
        Text = "",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret2
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v25 do
        TextButton[i] = v;
    end;

    TextButton.Parent = ScreenGui;
    table.insert(v24.connections, TextButton.Activated:Connect(close));
    local v26 = {
        Name = "Panel",
        BackgroundTransparency = 0.2,
        Active = true,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(420, 244),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v26 do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    local v27 = {
        CornerRadius = UDim.new(0, 14)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v27 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v28 = {
        Thickness = 3,
        Color = Color3_new_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v28 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local v29 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v29 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame;
    local UIScale = Instance.new("UIScale");

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    local u30 = nil;

    local function fitScreen() -- Line: 145
        -- upvalues: ScreenGui (copy), UIScale (copy), u30 (ref)
        local AbsoluteSize = ScreenGui.AbsoluteSize;

        if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
            local v31 = AbsoluteSize.Y < 500;
            UIScale.Scale = math.min(AbsoluteSize.X * 0.92 / 420, AbsoluteSize.Y * 0.8 / 244, 1.25) * (v31 and 0.75 or 1);

            if u30 then
                local v32;

                if v31 then
                    v32 = UDim2.fromOffset(64, 64);
                else
                    v32 = UDim2.fromOffset(40, 40);
                end;

                u30.Size = v32;
                u30.TextSize = v31 and 50 or 30;
            end;
        end;
    end;

    local connections = v24.connections;
    local PropertyChangedSignal = ScreenGui:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(connections, PropertyChangedSignal:Connect(fitScreen));
    fitScreen();
    local v33 = {
        Name = "Header",
        BackgroundTransparency = 0.5,
        Position = UDim2.fromOffset(10, 10),
        Size = UDim2.new(1, -20, 0, 72),
        BackgroundColor3 = Color3_new_ret2
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v33 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v34 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v34 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v35 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v35 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = Frame2;
    local v36 = {
        Name = "Icon",
        BackgroundTransparency = 1,
        Image = "rbxassetid://100627084510770",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 12, 0.5, 0),
        Size = UDim2.fromOffset(48, 48),
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v36 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame2;
    label(Frame2, "CODES", 28, Color3_new_ret, {
        Name = "Title",
        Position = UDim2.fromOffset(70, 8),
        Size = UDim2.new(1, -130, 0, 32)
    });
    v24.status = label(Frame2, "Redeem a code for free rewards", 16, Color3_fromRGB_ret5, {
        Name = "Info",
        Position = UDim2.fromOffset(70, 42),
        Size = UDim2.new(1, -130, 0, 22),
        TextTruncate = Enum.TextTruncate.AtEnd
    });
    local v37 = {
        Name = "CloseButton",
        BackgroundTransparency = 1,
        Text = "x",
        TextSize = 30,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(40, 40),
        FontFace = Font_new_ret,
        TextColor3 = Color3_fromRGB_ret6
    };
    local TextButton2 = Instance.new("TextButton");

    for i, v in v37 do
        TextButton2[i] = v;
    end;

    TextButton2.Parent = Frame2;
    table.insert(v24.connections, TextButton2.Activated:Connect(close));
    u30 = TextButton2;
    fitScreen();
    local v38 = {
        Name = "Field",
        BackgroundTransparency = 0.5,
        Position = UDim2.fromOffset(10, 94),
        Size = UDim2.new(1, -20, 0, 72),
        BackgroundColor3 = Color3_new_ret2
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v38 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    local v39 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v39 do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = Frame3;
    local v40 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke4 = Instance.new("UIStroke");

    for i, v in v40 do
        UIStroke4[i] = v;
    end;

    UIStroke4.Parent = Frame3;
    local v41 = {
        Name = "Code",
        BackgroundTransparency = 1,
        ClearTextOnFocus = false,
        PlaceholderText = "ENTER CODE",
        Text = "",
        TextSize = 28,
        Position = UDim2.fromOffset(16, 0),
        Size = UDim2.new(1, -32, 1, 0),
        FontFace = Font_new_ret,
        PlaceholderColor3 = Color3.fromRGB(130, 130, 136),
        TextColor3 = Color3_new_ret,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd
    };
    local TextBox = Instance.new("TextBox");

    for i, v in v41 do
        TextBox[i] = v;
    end;

    TextBox.Parent = Frame3;
    v24.box = TextBox;
    local connections2 = v24.connections;
    local PropertyChangedSignal2 = TextBox:GetPropertyChangedSignal("Text");
    table.insert(connections2, PropertyChangedSignal2:Connect(function() -- Line: 227
        -- upvalues: TextBox (copy), u2 (ref), u1 (ref), Color3_fromRGB_ret5 (ref)
        if #TextBox.Text > 32 then
            TextBox.Text = string.sub(TextBox.Text, 1, 32);
        end;

        if u2 == 0 and u1 then
            u1.status.Text = "Redeem a code for free rewards";
            u1.status.TextColor3 = Color3_fromRGB_ret5;
        end;
    end));
    table.insert(v24.connections, TextBox.Focused:Connect(function() -- Line: 237
        -- upvalues: UIStroke4 (copy), Color3_fromRGB_ret3 (ref)
        UIStroke4.Color = Color3_fromRGB_ret3;
    end));
    table.insert(v24.connections, TextBox.FocusLost:Connect(function(p42) -- Line: 240
        -- upvalues: UIStroke4 (copy), Color3_fromRGB_ret2 (ref), submit (ref)
        UIStroke4.Color = Color3_fromRGB_ret2;

        if p42 then
            submit();
        end;
    end));
    local v43 = {
        Name = "Redeem",
        AutoButtonColor = true,
        Text = "",
        Position = UDim2.fromOffset(10, 178),
        Size = UDim2.new(1, -20, 0, 56),
        BackgroundColor3 = Color3_new_ret
    };
    local TextButton3 = Instance.new("TextButton");

    for i, v in v43 do
        TextButton3[i] = v;
    end;

    TextButton3.Parent = Frame;
    local v44 = {
        CornerRadius = UDim.new(0.2, 0)
    };
    local UICorner4 = Instance.new("UICorner");

    for i, v in v44 do
        UICorner4[i] = v;
    end;

    UICorner4.Parent = TextButton3;
    local v45 = {
        Thickness = 3,
        Color = Color3_new_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke5 = Instance.new("UIStroke");

    for i, v in v45 do
        UIStroke5[i] = v;
    end;

    UIStroke5.Parent = TextButton3;
    local v46 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret3,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke6 = Instance.new("UIStroke");

    for i, v in v46 do
        UIStroke6[i] = v;
    end;

    UIStroke6.Parent = TextButton3;
    local v47 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret3, Color3_fromRGB_ret4)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v47 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = TextButton3;
    v24.redeem = TextButton3;
    v24.redeemLabel = label(TextButton3, "REDEEM", 22, Color3_new_ret, {
        Name = "TextLabel",
        ZIndex = 2,
        Size = UDim2.fromScale(1, 1),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    local redeemLabel = v24.redeemLabel;
    local v48 = {
        Thickness = 2,
        Color = Color3_new_ret2
    };
    local UIStroke7 = Instance.new("UIStroke");

    for i, v in v48 do
        UIStroke7[i] = v;
    end;

    UIStroke7.Parent = redeemLabel;
    table.insert(v24.connections, TextButton3.Activated:Connect(submit));

    if u2 > 0 and (os.clock() - u2 < 20 and u1) then
        u1.redeemLabel.Text = "CHECKING...";
        u1.redeem.AutoButtonColor = false;
    end;

    table.insert(v24.connections, UserInputService.InputBegan:Connect(function(p49) -- Line: 276
        -- upvalues: close (ref)
        if p49.KeyCode == Enum.KeyCode.Escape or p49.KeyCode == Enum.KeyCode.ButtonB then
            close();
        end;
    end));
    LocalPlayer:SetAttribute("CodesOpen", true);

    if UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled then
        TextBox:CaptureFocus();
    end;
end;

local function celebrate(p50, p51) -- Line: 290
    -- upvalues: Interface (copy)
    local success, result = pcall(require, Interface:FindFirstChild("ClaimPop"));

    if success then
        if result == nil then
            success = false;
        else
            success = result.given(p50, p51, {
                heading = "CODE REDEEMED!"
            });
        end;
    end;

    return success;
end;

HudNavigation.Opening.Event:Connect(function(p52) -- Line: 296
    -- upvalues: close (copy)
    if p52 ~= "Codes" then
        close();
    end;
end);
CodeEvent.OnClientEvent:Connect(function(p53, p54, p55, p56) -- Line: 301
    -- upvalues: u2 (ref), u1 (ref), celebrate (copy), close (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret5 (copy), HudNavigation (copy), Color3_fromRGB_ret6 (copy)
    if p53 ~= "Result" or type(p55) ~= "string" then
        return;
    end;

    u2 = 0;

    if p54 == true then
        local v57;

        if u1 then
            local redeem = u1.redeem;
            v57 = redeem.AbsolutePosition + redeem.AbsoluteSize * 0.5;
        else
            v57 = nil;
        end;

        if celebrate(p56, v57) then
            close();

            return;
        end;

        if not u1 then
            HudNavigation.Notice:Fire(p55);

            return;
        end;

        if u1 then
            u1.redeemLabel.Text = "REDEEM";
            u1.redeem.AutoButtonColor = true;
        end;

        u1.box.Text = "";
        local v58 = Color3_fromRGB_ret3;

        if u1 then
            u1.status.Text = p55 == "" and "Redeem a code for free rewards" or p55;
            local v59;

            if p55 == "" then
                v59 = Color3_fromRGB_ret5;
            else
                v59 = v58 or Color3_fromRGB_ret5;
            end;

            u1.status.TextColor3 = v59;
        end;
    elseif u1 then
        if u1 then
            u1.redeemLabel.Text = "REDEEM";
            u1.redeem.AutoButtonColor = true;
        end;

        local v60 = Color3_fromRGB_ret6;

        if u1 then
            u1.status.Text = p55 == "" and "Redeem a code for free rewards" or p55;
            local v61;

            if p55 == "" then
                v61 = Color3_fromRGB_ret5;
            else
                v61 = v60 or Color3_fromRGB_ret5;
            end;

            u1.status.TextColor3 = v61;
        end;
    else
        HudNavigation.Notice:Fire(p55);
    end;
end);
HudNavigation.register("Codes", function() -- Line: 330
    -- upvalues: u1 (ref), close (copy), open (copy)
    if u1 then
        close();

        return;
    end;

    open();
end);
HudNavigation.setAvailable("Codes", true);