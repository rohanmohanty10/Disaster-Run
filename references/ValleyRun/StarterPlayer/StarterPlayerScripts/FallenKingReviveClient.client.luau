 

 

local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local FallenKingBossConfig = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("FallenKingBossConfig"));
local Respawn = FallenKingBossConfig.Respawn;

if type(Respawn) ~= "table" or Respawn.Enabled ~= true then
    return;
end;

local u1;

if game.GameId == 10764627709 then
    u1 = Respawn.ProductId;
else
    u1 = Respawn.TestProductId;
end;

if type(u1) ~= "number" then
    return;
end;

local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "FallenKingRevive";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.DisplayOrder = 25;
ScreenGui.Enabled = false;
ScreenGui:SetAttribute("SelfManagedText", true);
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local Font_new_ret = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold);
local utf8_char_ret = utf8.char(57346);
local Color3_fromRGB_ret = Color3.fromRGB(120, 255, 120);
local Color3_fromRGB_ret2 = Color3.fromRGB(20, 170, 80);
local Color3_fromRGB_ret3 = Color3.fromRGB(150, 156, 152);
local Color3_fromRGB_ret4 = Color3.fromRGB(90, 96, 92);
local Frame = Instance.new("Frame");
Frame.Name = "Panel";
Frame.AnchorPoint = Vector2.new(0.5, 0);
Frame.Position = UDim2.fromScale(0.5, 0.66);
Frame.Size = UDim2.fromScale(0.32, 0.24);
Frame.BackgroundTransparency = 1;
Frame.Parent = ScreenGui;
local UISizeConstraint = Instance.new("UISizeConstraint");
UISizeConstraint.MinSize = Vector2.new(260, 130);
UISizeConstraint.MaxSize = Vector2.new(440, 210);
UISizeConstraint.Parent = Frame;

local function text(p2, p3, p4, p5, p6, p7) -- Line: 58
    -- upvalues: Frame (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p2;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0);
    TextLabel.Position = UDim2.fromScale(0.5, p4);
    TextLabel.Size = UDim2.fromScale(1, p5);
    TextLabel.FontFace = p7;
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = p6;
    TextLabel.TextStrokeTransparency = 0.35;
    TextLabel.Text = p3;
    TextLabel.Parent = Frame;

    return TextLabel;
end;

local u8 = text("Title", "YOU\'RE DOWN", 0, 0.17, Color3.fromRGB(255, 80, 90), Font_new_ret);
local u9 = text("Timer", "", 0.17, 0.11, Color3.fromRGB(245, 236, 225), Font_new_ret2);
local TextButton = Instance.new("TextButton");
TextButton.Name = "Revive";
TextButton.AnchorPoint = Vector2.new(0.5, 0);
TextButton.Position = UDim2.fromScale(0.5, 0.33);
TextButton.Size = UDim2.fromScale(0.94, 0.5);
TextButton.BackgroundColor3 = Color3.new(1, 1, 1);
TextButton.AutoButtonColor = false;
TextButton.Text = "";
TextButton.ClipsDescendants = true;
TextButton.Parent = Frame;
local UICorner = Instance.new("UICorner");
UICorner.CornerRadius = UDim.new(0.3, 0);
UICorner.Parent = TextButton;
local UIGradient = Instance.new("UIGradient");
UIGradient.Rotation = 90;
UIGradient.Color = ColorSequence.new(Color3_fromRGB_ret, Color3_fromRGB_ret2);
UIGradient.Parent = TextButton;
local UIStroke = Instance.new("UIStroke");
UIStroke.Thickness = 3;
UIStroke.Color = Color3.fromRGB(200, 255, 170);
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
UIStroke.Parent = TextButton;
local UIScale = Instance.new("UIScale");
UIScale.Parent = TextButton;
local Frame2 = Instance.new("Frame");
Frame2.Name = "Shine";
Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
Frame2.Position = UDim2.fromScale(-0.3, 0.5);
Frame2.Size = UDim2.fromScale(0.22, 2);
Frame2.Rotation = 20;
Frame2.BackgroundColor3 = Color3.new(1, 1, 1);
Frame2.BorderSizePixel = 0;
Frame2.ZIndex = 3;
Frame2.Parent = TextButton;
local UIGradient2 = Instance.new("UIGradient");
UIGradient2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.55), NumberSequenceKeypoint.new(1, 1) });
UIGradient2.Parent = Frame2;
local ImageLabel = Instance.new("ImageLabel");
ImageLabel.Name = "Heart";
ImageLabel.BackgroundTransparency = 1;
ImageLabel.AnchorPoint = Vector2.new(0, 0.5);
ImageLabel.Position = UDim2.fromScale(0.04, 0.5);
ImageLabel.Size = UDim2.fromScale(0.8, 0.8);
ImageLabel.SizeConstraint = Enum.SizeConstraint.RelativeYY;
ImageLabel.Image = "rbxassetid://77000589962060";
ImageLabel.ImageRectSize = Vector2.new(128, 128);
ImageLabel.ImageRectOffset = Vector2.new(0, 384);
ImageLabel.ZIndex = 2;
ImageLabel.Parent = TextButton;
local UIScale2 = Instance.new("UIScale");
UIScale2.Parent = ImageLabel;

local function buttonText(p10, p11, p12, p13, p14, p15) -- Line: 135
    -- upvalues: TextButton (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p10;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Position = UDim2.fromScale(0.26, p12);
    TextLabel.Size = UDim2.fromScale(0.7, p13);
    TextLabel.FontFace = p14;
    TextLabel.TextScaled = true;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextColor3 = p15;
    TextLabel.TextStrokeTransparency = 0.45;
    TextLabel.TextStrokeColor3 = Color3.fromRGB(10, 60, 25);
    TextLabel.Text = p11;
    TextLabel.ZIndex = 2;
    TextLabel.Parent = TextButton;

    return TextLabel;
end;

local u16 = buttonText("Label", "REVIVE NOW", 0.12, 0.46, Font_new_ret, Color3.new(1, 1, 1));
local u17 = buttonText("Sub", "", 0.58, 0.28, Font_new_ret2, Color3.fromRGB(235, 255, 225));
local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "Badge";
TextLabel.AnchorPoint = Vector2.new(1, 0.5);
TextLabel.Position = UDim2.fromScale(0.97, 0.5);
TextLabel.Size = UDim2.fromScale(0.42, 0.42);
TextLabel.SizeConstraint = Enum.SizeConstraint.RelativeYY;
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 205, 40);
TextLabel.FontFace = Font_new_ret;
TextLabel.TextScaled = true;
TextLabel.TextColor3 = Color3.fromRGB(40, 30, 0);
TextLabel.Text = "Y";
TextLabel.ZIndex = 2;
TextLabel.Visible = false;
TextLabel.Parent = TextButton;
local UICorner2 = Instance.new("UICorner");
UICorner2.CornerRadius = UDim.new(1, 0);
UICorner2.Parent = TextLabel;
local Frame3 = Instance.new("Frame");
Frame3.Name = "Track";
Frame3.AnchorPoint = Vector2.new(0.5, 0);
Frame3.Position = UDim2.fromScale(0.5, 0.88);
Frame3.Size = UDim2.fromScale(0.86, 0.045);
Frame3.BackgroundColor3 = Color3.fromRGB(30, 18, 22);
Frame3.BackgroundTransparency = 0.2;
Frame3.BorderSizePixel = 0;
Frame3.Parent = Frame;
local UICorner3 = Instance.new("UICorner");
UICorner3.CornerRadius = UDim.new(1, 0);
UICorner3.Parent = Frame3;
local Frame4 = Instance.new("Frame");
Frame4.Name = "Bar";
Frame4.Size = UDim2.fromScale(1, 1);
Frame4.BackgroundColor3 = Color3.fromRGB(255, 70, 80);
Frame4.BorderSizePixel = 0;
Frame4.Parent = Frame3;
local UICorner4 = Instance.new("UICorner");
UICorner4.CornerRadius = UDim.new(1, 0);
UICorner4.Parent = Frame4;
local u18 = false;
local u19 = false;
TextButton.MouseEnter:Connect(function() -- Line: 198
    -- upvalues: u18 (ref)
    u18 = true;
end);
TextButton.MouseLeave:Connect(function() -- Line: 201
    -- upvalues: u18 (ref), u19 (ref)
    u18 = false;
    u19 = false;
end);
TextButton.MouseButton1Down:Connect(function() -- Line: 204
    -- upvalues: u19 (ref)
    u19 = true;
end);
TextButton.MouseButton1Up:Connect(function() -- Line: 207
    -- upvalues: u19 (ref)
    u19 = false;
end);
local u20 = "19";
task.spawn(function() -- Line: 213
    -- upvalues: MarketplaceService (copy), u1 (copy), u20 (ref)
    local success, result = pcall(MarketplaceService.GetProductInfo, MarketplaceService, u1, Enum.InfoType.Product);

    if success and (type(result) == "table" and type(result.PriceInRobux) == "number") then
        u20 = tostring(result.PriceInRobux);
    end;
end);
local u21 = nil;
local u22 = 0;

local function waiting() -- Line: 223
    -- upvalues: u21 (ref), LocalPlayer (copy), u22 (ref)
    local v23;

    if u21 == nil or LocalPlayer:GetAttribute("BossDownedUntil") ~= u21 then
        v23 = false;
    else
        v23 = os.clock() - u22 < 15;
    end;

    return v23;
end;

MarketplaceService.PromptProductPurchaseFinished:Connect(function(p24, p25, p26) -- Line: 226
    -- upvalues: LocalPlayer (copy), u1 (copy), u21 (ref), u22 (ref)
    if p24 == LocalPlayer.UserId and (p25 == u1 and p26) then
        local Attribute = LocalPlayer:GetAttribute("BossDownedUntil");
        local os_clock_ret = os.clock();
        u21 = Attribute;
        u22 = os_clock_ret;
    end;
end);
TextButton.Activated:Connect(function() -- Line: 232, Name: buy
    -- upvalues: ScreenGui (copy), u21 (ref), LocalPlayer (copy), u22 (ref), MarketplaceService (copy), u1 (copy)
    if ScreenGui.Enabled then
        local v27;

        if u21 == nil or LocalPlayer:GetAttribute("BossDownedUntil") ~= u21 then
            v27 = false;
        else
            v27 = os.clock() - u22 < 15;
        end;

        if not v27 then
            MarketplaceService:PromptProductPurchase(LocalPlayer, u1);
        end;
    end;
end);
UserInputService.InputBegan:Connect(function(p28) -- Line: 240
    -- upvalues: ScreenGui (copy), u21 (ref), LocalPlayer (copy), u22 (ref), MarketplaceService (copy), u1 (copy)
    if p28.KeyCode == Enum.KeyCode.ButtonY and ScreenGui.Enabled then
        local v29;

        if u21 == nil or LocalPlayer:GetAttribute("BossDownedUntil") ~= u21 then
            v29 = false;
        else
            v29 = os.clock() - u22 < 15;
        end;

        if not v29 then
            MarketplaceService:PromptProductPurchase(LocalPlayer, u1);
        end;
    end;
end);
local u30 = FallenKingBossConfig.Revive and FallenKingBossConfig.Revive.DownSeconds or 60;
RunService.Heartbeat:Connect(function() -- Line: 247
    -- upvalues: LocalPlayer (copy), ScreenGui (copy), u9 (copy), Frame4 (copy), u30 (copy), u8 (copy), u21 (ref), u22 (ref), UIGradient (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), UIStroke (copy), u16 (copy), u17 (copy), utf8_char_ret (copy), u20 (ref), TextLabel (copy), UserInputService (copy), u19 (ref), u18 (ref), UIScale (copy), UIScale2 (copy), Frame2 (copy)
    local Attribute = LocalPlayer:GetAttribute("BossDownedUntil");
    local v31 = type(Attribute) ~= "number" and 0 or Attribute - workspace:GetServerTimeNow();

    if v31 <= 0 then
        if ScreenGui.Enabled then
            ScreenGui.Enabled = false;
        end;

        return;
    end;

    ScreenGui.Enabled = true;
    local os_clock_ret = os.clock();
    u9.Text = ("Out in %ds"):format((math.ceil(v31)));
    Frame4.Size = UDim2.fromScale(math.clamp(v31 / u30, 0, 1), 1);
    local v32 = v31 <= 10;
    local v33 = not v32 and 1 or math.sin(os_clock_ret * 10) * 0.5 + 0.5;
    u8.TextTransparency = not v32 and 0 or (1 - v33) * 0.4;
    Frame4.BackgroundColor3 = Color3.fromRGB(255, 70, 80):Lerp(Color3.fromRGB(255, 220, 220), not v32 and 0 or v33 * 0.5);
    local v34;

    if u21 == nil or LocalPlayer:GetAttribute("BossDownedUntil") ~= u21 then
        v34 = false;
    else
        v34 = os.clock() - u22 < 15;
    end;

    local v35;

    if v34 then
        v35 = ColorSequence.new(Color3_fromRGB_ret3, Color3_fromRGB_ret4);
    else
        v35 = ColorSequence.new(Color3_fromRGB_ret, Color3_fromRGB_ret2);
    end;

    UIGradient.Color = v35;
    UIStroke.Transparency = v34 and 0.6 or (math.sin(os_clock_ret * 4) * 0.5 + 0.5) * 0.35 + 0.15;
    u16.Text = v34 and "REVIVING…" or "REVIVE NOW";
    u17.Text = v34 and "Hold on..." or ("%s %s  ·  back up, full hearts"):format(utf8_char_ret, u20);
    local v36;

    if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
        v36 = not v34;
    else
        v36 = false;
    end;

    TextLabel.Visible = v36;
    local v37 = v34 and 1 or (u19 and 0.94 or (u18 and 1.08 or math.sin(os_clock_ret * 4) * 0.03 + 1));
    local v38 = UIScale;
    v38.Scale = v38.Scale + (v37 - UIScale.Scale) * 0.25;
    local v39;

    if v34 then
        v39 = 1;
    else
        local math_sin_ret = math.sin(os_clock_ret * 7);
        v39 = math.max(0, math_sin_ret) ^ 3 * 0.12 + 1;
    end;

    UIScale2.Scale = v39;
    local v40 = os_clock_ret % 2.2 / 0.7;
    Frame2.Visible = not v34 and v40 <= 1;
    Frame2.Position = UDim2.fromScale(math.min(v40, 1) * 1.6 + -0.3, 0.5);
end);