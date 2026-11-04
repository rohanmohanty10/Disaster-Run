 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local MarketplaceService = game:GetService("MarketplaceService");
local GuiService = game:GetService("GuiService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local StarterPackConfig = require(ChickenOrHero.Gear.StarterPackConfig);
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local HudNavigation = require(ChickenOrHero.Presentation.HudNavigation);
local EquipmentHudLayoutLegacy = require(ChickenOrHero.Presentation:WaitForChild("EquipmentHudLayoutLegacy"));
local StarterPackEvent = ChickenOrHero.Gear:WaitForChild("StarterPackEvent");
local u1 = Panels.screen(LocalPlayer, "StarterPack", 67);
local u2 = {};

local function connect(p3, p4) -- Line: 18
    -- upvalues: u2 (copy)
    table.insert(u2, p3:Connect(p4));
end;

local u5 = Panels.button(u1, "Open", "", 0, 0, 86, 96, Panels.Ink);
u5.Visible = false;
u5.AnchorPoint = Vector2.new(1, 0.5);
u5.Position = UDim2.new(1, -20, 0.31, 0);
u5.BackgroundTransparency = 1;
local u6 = Panels.make("UIScale", u5, "Scale", {});
local u7 = Panels.make("Frame", u5, "SunRays", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(43, 36),
    Size = UDim2.fromOffset(72, 72),
    AnchorPoint = Vector2.new(0.5, 0.5)
});
local u8 = true;

for i = 1, 12 do
    local v9 = Panels.make("Frame", u7, "Ray" .. i, {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Rotation = i * 30
    });
    Panels.make("Frame", v9, "Glow", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.fromOffset(10, 28),
        BackgroundColor3 = Panels.Gold
    });
    Panels.make("UIGradient", v9.Glow, "Fade", {
        Rotation = 90
    }).Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.05) });
    local _ = i;
end;

Skin.glow(u7, Panels.Gold);
Panels.make("ImageLabel", u5, "PackIcon", {
    BackgroundTransparency = 1,
    Image = "rbxassetid://129768808533257",
    ZIndex = 3,
    Position = UDim2.fromOffset(8, 0),
    Size = UDim2.fromOffset(70, 70),
    ScaleType = Enum.ScaleType.Fit
});
local u10 = Panels.text(u5, "Timer", "10:00", -13, 74, 112, 22, 15.6, Panels.Gold);
u10.TextXAlignment = Enum.TextXAlignment.Center;
u10.Font = Enum.Font.GothamBold;
Panels.make("UIStroke", u10, "TimerStroke", {
    Thickness = 1.5,
    Transparency = 0,
    Color = Color3.new(0, 0, 0),
    ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
});
local Palette = Skin.Palette;
local GearCatalog = require(ChickenOrHero.Gear.GearCatalog);
local u11, u12, u13 = Panels.panel(u1, "Offer", 384, 372);
u12.ClipsDescendants = true;
u13.Position = UDim2.fromOffset(338, 14);
u13.Size = UDim2.fromOffset(32, 30);
u13.TextSize = 22;
u13.ZIndex = 6;
local PropertyChangedSignal = u1:GetPropertyChangedSignal("AbsoluteSize");
table.insert(u2, PropertyChangedSignal:Connect(function() -- Line: 83, Name: fitOffer
    -- upvalues: u1 (copy), u12 (copy)
    local AbsoluteSize = u1.AbsoluteSize;
    u12.Scale.Scale = math.min(1, AbsoluteSize.X * 0.92 / 384, AbsoluteSize.Y * 0.88 / 372);
end));
local AbsoluteSize = u1.AbsoluteSize;
u12.Scale.Scale = math.min(1, AbsoluteSize.X * 0.92 / 384, AbsoluteSize.Y * 0.88 / 372);

local function label(p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25) -- Line: 91
    -- upvalues: Panels (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p15;
    TextLabel:SetAttribute("SelfManagedText", true);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Position = UDim2.fromOffset(p17, p18);
    TextLabel.Size = UDim2.fromOffset(p19, p20);
    TextLabel.Text = p16;
    TextLabel.TextColor3 = p22;
    TextLabel.Font = p23 or Enum.Font.GothamBold;
    TextLabel.TextScaled = false;
    TextLabel.TextSize = p21;
    TextLabel.TextWrapped = p25 == true;
    TextLabel.TextXAlignment = p24 or Enum.TextXAlignment.Left;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel.ZIndex = 3;
    Panels.make("UIStroke", TextLabel, "TextStroke", {
        Thickness = 1.5,
        Color = Color3.new(0, 0, 0),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    });
    TextLabel.Parent = p14;

    return TextLabel;
end;

label(u12, "Eyebrow", "NEW PLAYER EXCLUSIVE", 24, 26, 290, 16, 13, Palette.gold);
local v26 = label(u12, "Heading", "STARTER PACK", 24, 44, 300, 44, 40, Palette.text, Enum.Font.GothamBlack);
Panels.make("UIGradient", v26, "Shine", {
    Rotation = 90
}).Color = ColorSequence.new(Palette.text, Palette.gold);
label(u12, "Description", "Everything you need for your first chases.", 24, 92, 336, 46, 19, Palette.text, Enum.Font.GothamBold, nil, true);
local v27 = {};

for _, v in { "BananaPeel", "RescueKit", "Adrenaline" } do
    local v28 = GearCatalog.get(v);
    local v29 = {
        icon = v28 and (v28.IconImage or "") or "",
        amount = "x" .. StarterPackConfig.AmountEach
    };
    local v30;

    if v28 then
        v30 = v28.Name or v;
    else
        v30 = v;
    end;

    v29.name = v30;
    v29.accent = v28 and v28.Accent or Palette.gold;
    table.insert(v27, v29);
end;

table.insert(v27, {
    name = "COINS",
    icon = Skin.Assets.Coin,
    amount = "+" .. StarterPackConfig.Coins,
    accent = Palette.gold
});
local u31 = {};

for i, v in v27 do
    local v32 = Panels.make("Frame", u12, "Card" .. i, {
        BorderSizePixel = 0,
        ZIndex = 2,
        Position = UDim2.fromOffset(24 + (i - 1) * 86, 146),
        Size = UDim2.fromOffset(78, 104),
        BackgroundColor3 = Palette.row
    });
    Panels.corner(v32, 10);
    Skin.card(v32, v.accent);
    table.insert(u31, Panels.make("UIScale", v32, "Pop", {}));
    Panels.make("ImageLabel", v32, "Icon", {
        BackgroundTransparency = 1,
        ZIndex = 3,
        Position = UDim2.fromOffset(13, 8),
        Size = UDim2.fromOffset(52, 52),
        Image = v.icon,
        ScaleType = Enum.ScaleType.Fit
    });
    label(v32, "Amount", v.amount, 0, 60, 78, 24, 22, Palette.gold, Enum.Font.GothamBlack, Enum.TextXAlignment.Center);
    label(v32, "ItemName", v.name, 4, 85, 70, 13, 11, Palette.textSecondary, Enum.Font.GothamBold, Enum.TextXAlignment.Center);
end;

local v33 = Panels.make("Frame", u12, "StatusPill", {
    BackgroundTransparency = 0.45,
    BorderSizePixel = 0,
    ZIndex = 2,
    Position = UDim2.fromOffset(24, 262),
    Size = UDim2.fromOffset(336, 30),
    BackgroundColor3 = Color3.new(0, 0, 0)
});
Panels.corner(v33, 14);
local u34 = label(v33, "Status", "", 10, 6, 316, 18, 16, Palette.danger, Enum.Font.GothamBold, Enum.TextXAlignment.Center);
local u35 = Panels.button(u12, "Buy", "CHECKING PRICE", 24, 304, 336, 50, Color3.fromRGB(81, 67, 39));
u35.TextSize = 24;
u35.Font = Enum.Font.GothamBlack;
u35.ZIndex = 4;
local TweenService = game:GetService("TweenService");

local function popIn() -- Line: 174
    -- upvalues: u31 (copy), TweenService (copy)
    for i, v in u31 do
        v.Scale = 0.4;
        TweenService:Create(v, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.1 + i * 0.07), {
            Scale = 1
        }):Play();
    end;
end;

local u36 = {};
local u37 = nil;
local u38 = nil;
local u39 = nil;
local u40 = false;
local u41 = { "ArmoryOpen", "JourneyOpen", "EmoteWheelOpen", "SettingsOpen", "UpdateLogOpen", "ServerBrowserOpen", "LikeRewardOpen", "MapVoteOpen", "MatchSummaryVisible", "AdminConsoleActive", "ScreenPresentationActive", "TutorialRouting", "TutorialActive", "TutorialFinishing", "TutorialSession", "EventRsvpOpen" };

local function lobby() -- Line: 207
    -- upvalues: LocalPlayer (copy)
    local v42;

    if LocalPlayer:GetAttribute("ClientReady") == true then
        v42 = LocalPlayer:GetAttribute("InMatch") ~= true;
    else
        v42 = false;
    end;

    return v42;
end;

local u43 = false;
local u44 = false;

local function remaining() -- Line: 213
    -- upvalues: u36 (ref)
    local v45 = (u36.starterOfferEndsAt or 0) - workspace:GetServerTimeNow();
    local math_ceil_ret = math.ceil(v45);

    return math.max(0, math_ceil_ret);
end;

local function hide() -- Line: 216
    -- upvalues: u11 (copy), u44 (ref), StarterPackEvent (copy), LocalPlayer (copy), GuiService (copy), u1 (copy), u39 (ref)
    u11.Visible = false;

    if u44 then
        u44 = false;
        StarterPackEvent:FireServer("Release");
    end;

    LocalPlayer:SetAttribute("StarterPackOpen", nil);

    if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u1) then
        GuiService.SelectedObject = u39 and (u39.Parent and u39) or nil;
    end;
end;

local function render() -- Line: 227
    -- upvalues: u8 (ref), u36 (ref), u10 (copy), u11 (copy), u44 (ref), StarterPackEvent (copy), u37 (ref), u35 (copy), u40 (ref), LocalPlayer (copy), u38 (ref), Skin (copy), u34 (copy), Palette (copy)
    if not u8 then
        return;
    end;

    local v46 = (u36.starterOfferEndsAt or 0) - workspace:GetServerTimeNow();
    local math_ceil_ret = math.ceil(v46);
    local math_max_ret = math.max(0, math_ceil_ret);
    local v47 = ("%d:%02d"):format(math.floor(math_max_ret / 60), math_max_ret % 60);
    u10.Text = v47;

    if u11.Visible and (math_max_ret <= 0 and not (u44 or (not u36.starterFirstMatch or u36.starterPurchased))) then
        u44 = true;
        StarterPackEvent:FireServer("Hold");
    end;

    local v48 = math_max_ret > 0 and true or u44;
    local v49;

    if type(u37) == "table" then
        v49 = u37.PriceInRobux;
    else
        v49 = false;
    end;

    local v50;

    if type(v49) == "number" then
        v50 = v49 >= 0;
    else
        v50 = false;
    end;

    u35.Text = u36.starterPurchased and "CLAIMED  ✓" or (v48 and (u40 and "OPENING…" or (v50 and " " .. v49 or (u37 == false and "PRICE UNAVAILABLE" or (type(u37) == "table" and "NOT ON SALE" or "CHECKING PRICE")))) or "OFFER ENDED");
    local v51;

    if LocalPlayer:GetAttribute("ClientReady") == true then
        v51 = LocalPlayer:GetAttribute("InMatch") ~= true;
    else
        v51 = false;
    end;

    if v51 then
        if u36.loaded == true then
            local v52 = not u36.starterPurchased;

            if v52 then
                if v48 then
                    if v50 then
                        if u37.IsForSale == true then
                            v50 = not u40;
                        else
                            v50 = false;
                        end;
                    end;
                else
                    v50 = v48;
                end;
            else
                v50 = v52;
            end;
        else
            v50 = false;
        end;
    else
        v50 = v51;
    end;

    u35.Active = v50;
    u35.AutoButtonColor = u35.Active;
    u35.TextTransparency = u35.Active and 0 or 0.35;
    local v53 = u36.starterPurchased and "dark" or (u35.Active and "robux" or "secondary");

    if v53 ~= u38 then
        u38 = v53;
        Skin.button(u35, v53);

        if v53 == "dark" then
            Skin.select(u35, true, Skin.Palette.green);
        end;
    end;

    u34.Text = u36.starterPurchased and "Your starter pack is in your inventory." or (math_max_ret > 0 and "OFFER ENDS IN " .. v47 or (u44 and "LAST CHANCE: GONE WHEN YOU CLOSE THIS" or "This starter offer has ended."));
    local v54;

    if u36.starterPurchased then
        v54 = Palette.green;
    elseif v48 then
        v54 = Palette.danger;
    else
        v54 = Palette.textSecondary;
    end;

    u34.TextColor3 = v54;
end;

local function show() -- Line: 273
    -- upvalues: u36 (ref), LocalPlayer (copy), HudNavigation (copy), u39 (ref), GuiService (copy), u11 (copy), u43 (ref), StarterPackEvent (copy), popIn (copy), render (copy), UserInputService (copy), u35 (copy), u13 (copy), MarketplaceService (copy), StarterPackConfig (copy), u8 (ref), u37 (ref)
    if u36.starterFirstMatch then
        local v55;

        if LocalPlayer:GetAttribute("ClientReady") == true then
            v55 = LocalPlayer:GetAttribute("InMatch") ~= true;
        else
            v55 = false;
        end;

        if v55 then
            local v56 = (u36.starterOfferEndsAt or 0) - workspace:GetServerTimeNow();
            local math_ceil_ret = math.ceil(v56);

            if math.max(0, math_ceil_ret) > 0 and not u36.starterPurchased then
                HudNavigation.opening("StarterPack");
                u39 = GuiService.SelectedObject;
                u11.Visible = true;
                LocalPlayer:SetAttribute("StarterPackOpen", true);
                u43 = true;
                StarterPackEvent:FireServer("Presented");
                popIn();
                render();
                StarterPackEvent:FireServer("Get");

                if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
                    GuiService.SelectedObject = u35.Active and u35 or u13;
                end;

                task.spawn(function() -- Line: 289
                    -- upvalues: MarketplaceService (ref), StarterPackConfig (ref), u8 (ref), u37 (ref), render (ref)
                    local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, StarterPackConfig.ProductId, Enum.InfoType.Product);

                    if u8 then
                        u37 = success and result and result or false;
                        render();
                    end;
                end);
            end;
        end;
    end;
end;

table.insert(u2, u5.Activated:Connect(show));
table.insert(u2, u13.Activated:Connect(hide));
table.insert(u2, u35.Activated:Connect(function() -- Line: 299
    -- upvalues: u35 (copy), u40 (ref), render (copy), StarterPackEvent (copy)
    if u35.Active then
        u40 = true;
        render();
        StarterPackEvent:FireServer("Prompt");
    end;
end));
table.insert(u2, StarterPackEvent.OnClientEvent:Connect(function(p57, p58) -- Line: 306
    -- upvalues: u40 (ref), render (copy), u34 (copy)
    if p57 == "Notice" then
        u40 = false;
        render();
        u34.Text = p58;
    end;
end));
table.insert(u2, MarketplaceService.PromptProductPurchaseFinished:Connect(function(p59, p60) -- Line: 313
    -- upvalues: LocalPlayer (copy), StarterPackConfig (copy), u40 (ref), render (copy), ChickenOrHero (copy)
    if p59 == LocalPlayer.UserId and p60 == StarterPackConfig.ProductId then
        u40 = false;
        render();
        ChickenOrHero.Weapons.ArmoryEvent:FireServer("Get");
    end;
end));
table.insert(u2, ChickenOrHero.Weapons.ArmoryEvent.OnClientEvent:Connect(function(p61, p62) -- Line: 320
    -- upvalues: u36 (ref), render (copy)
    if p61 == "State" then
        u36 = p62;
        render();
    end;
end));
table.insert(u2, HudNavigation.Opening.Event:Connect(function(p63) -- Line: 326
    -- upvalues: hide (copy)
    if p63 ~= "StarterPack" then
        hide();
    end;
end));
table.insert(u2, UserInputService.InputBegan:Connect(function(p64) -- Line: 331
    -- upvalues: u11 (copy), hide (copy)
    if u11.Visible and (p64.KeyCode == Enum.KeyCode.Escape or p64.KeyCode == Enum.KeyCode.ButtonB) then
        hide();
    end;
end));
local u65 = 0;
table.insert(u2, RunService.Heartbeat:Connect(function(p66) -- Line: 337
    -- upvalues: u65 (ref), u7 (copy), u41 (copy), LocalPlayer (copy), u11 (copy), hide (copy), StarterPackConfig (copy), u36 (ref), u5 (copy), u43 (ref), show (copy), u1 (copy), u12 (copy), u6 (copy), UserInputService (copy), EquipmentHudLayoutLegacy (copy), render (copy)
    u65 = u65 + p66;
    u7.Rotation = (u7.Rotation + p66 * 12) % 360;

    if u65 < 0.1 then
        return;
    end;

    u65 = 0;
    local v67 = false;

    for _, v in u41 do
        if LocalPlayer:GetAttribute(v) then
            v67 = true;
            break;
        end;
    end;

    if u11.Visible then
        local v68;

        if LocalPlayer:GetAttribute("ClientReady") == true then
            v68 = LocalPlayer:GetAttribute("InMatch") ~= true;
        else
            v68 = false;
        end;

        if not v68 or v67 then
            hide();
        end;
    end;

    local Enabled = StarterPackConfig.Enabled;

    if Enabled then
        if game.GameId == StarterPackConfig.UniverseId then
            if LocalPlayer:GetAttribute("ClientReady") == true then
                Enabled = LocalPlayer:GetAttribute("InMatch") ~= true;
            else
                Enabled = false;
            end;

            if Enabled then
                if u36.loaded == true and u36.starterFirstMatch == true then
                    Enabled = not (v67 or (u11.Visible or u36.starterPurchased));

                    if Enabled then
                        local v69 = (u36.starterOfferEndsAt or 0) - workspace:GetServerTimeNow();
                        local math_ceil_ret = math.ceil(v69);
                        Enabled = math.max(0, math_ceil_ret) > 0;
                    end;
                else
                    Enabled = false;
                end;
            end;
        else
            Enabled = false;
        end;
    end;

    local v70;

    if Enabled then
        v70 = u43 or u36.starterPresented == true;
    else
        v70 = Enabled;
    end;

    u5.Visible = v70;

    if u36.starterFirstMatch and not (u36.starterPresented or (u43 or not Enabled)) then
        show();
    end;

    local AbsoluteSize2 = u1.AbsoluteSize;
    u12.Scale.Scale = math.min(1, AbsoluteSize2.X * 0.92 / 384, AbsoluteSize2.Y * 0.88 / 372);
    local AbsoluteSize3 = u1.AbsoluteSize;
    local math_min_ret = math.min(AbsoluteSize3.X / 1000, AbsoluteSize3.Y / 650);
    u6.Scale = math.clamp(math_min_ret, 0.72, 1) * 1.3;
    local v71 = UserInputService.TouchEnabled and EquipmentHudLayoutLegacy.touchStack;

    if v71 and v71.left then
        local AbsolutePosition = u1.AbsolutePosition;
        u5.Position = UDim2.fromOffset(v71.left - v71.gap - AbsolutePosition.X, (v71.top + v71.bottom) / 2 - AbsolutePosition.Y);
    else
        u5.Position = UDim2.new(1, -20, 0.31, 0);
    end;

    render();
end));
script.Destroying:Connect(function() -- Line: 381
    -- upvalues: u8 (ref), u2 (copy), hide (copy), u1 (copy)
    u8 = false;

    for _, v in u2 do
        v:Disconnect();
    end;

    hide();
    u1:Destroy();
end);
StarterPackEvent:FireServer("Get");