 

 

local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Theme = Skin.Theme;
local Palette = Skin.Palette;
local v1 = {};
local GothamBold = Enum.Font.GothamBold;
local text = Palette.text;
local textSecondary = Palette.textSecondary;
local gold = Palette.gold;
local chicken = Palette.chicken;
local gem = Palette.gem;
local green = Palette.green;
local UDim_new_ret = UDim.new(0, 12);

local function u7(p2, p3, p4, p5) -- Line: 15
    -- upvalues: Skin (copy)
    local v6 = p2:FindFirstChild(p3);

    if v6 and v6:IsA("TextLabel") then
        v6.TextColor3 = p4;
        v6.Font = p5 and Enum.Font.GothamBold or Enum.Font.GothamMedium;
        Skin.textStroke(v6, p5 and 1.5 or 2);
    end;
end;

local function button(p8, p9) -- Line: 24
    -- upvalues: GothamBold (copy), Skin (copy)
    p8.Font = GothamBold;
    Skin.button(p8, p9);
    p8.BackgroundTransparency = p9 == "dark" and 0.2 or 0;
end;

local function sounds(p10, p11) -- Line: 29
    -- upvalues: GothamBold (copy), Skin (copy), textSecondary (copy)
    for _, v in { "Equip", "Swing", "Hit" } do
        local v12 = p10[v];
        v12.Font = GothamBold;
        Skin.button(v12, "dark");
        v12.BackgroundTransparency = 0.2;
    end;

    local v13 = textSecondary;
    local Label = p10:FindFirstChild("Label");

    if Label and Label:IsA("TextLabel") then
        Label.TextColor3 = v13;
        Label.Font = Enum.Font.GothamMedium;
        Skin.textStroke(Label, 2);
    end;
end;

local function stage(p14, p15) -- Line: 36
    -- upvalues: Skin (copy)
    local Line = p14:FindFirstChild("Line");

    if Line and Line:IsA("UIStroke") then
        Line.Transparency = 1;
    end;

    local Circle = p14:FindFirstChild("Circle");

    if Circle then
        Circle = Circle:FindFirstChild("Line");
    end;

    if Circle and Circle:IsA("UIStroke") then
        Circle.Transparency = 1;
    end;

    local Halfway = p14:FindFirstChild("Halfway");

    if Halfway then
        Halfway.BackgroundTransparency = 1;
    end;

    Skin.glow(p14, p15);
end;

local function card(p16, p17, p18, p19) -- Line: 52
    -- upvalues: Skin (copy), UDim_new_ret (copy), stage (copy), text (copy), textSecondary (copy), GothamBold (copy), sounds (copy)
    Skin.card(p16, p17, {
        radius = UDim_new_ret,
        glow = p19
    });
    local Pitch = p16:FindFirstChild("Pitch");

    if Pitch then
        stage(Pitch, p17);
    end;

    local v20 = p17:Lerp(text, 0.35);
    local Index = p16:FindFirstChild("Index");

    if Index and Index:IsA("TextLabel") then
        Index.TextColor3 = v20;
        Index.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
        Skin.textStroke(Index, 1.5);
    end;

    local Eyebrow = p16:FindFirstChild("Eyebrow");

    if Eyebrow and Eyebrow:IsA("TextLabel") then
        Eyebrow.TextColor3 = v20;
        Eyebrow.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
        Skin.textStroke(Eyebrow, 1.5);
    end;

    local v21 = text;
    local Title = p16:FindFirstChild("Title");

    if Title and Title:IsA("TextLabel") then
        Title.TextColor3 = v21;
        Title.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
        Skin.textStroke(Title, 1.5);
    end;

    local v22 = text;
    local Tagline = p16:FindFirstChild("Tagline");

    if Tagline and Tagline:IsA("TextLabel") then
        Tagline.TextColor3 = v22;
        Tagline.Font = Enum.Font.GothamMedium;
        Skin.textStroke(Tagline, 2);
    end;

    local v23 = text;
    local Description = p16:FindFirstChild("Description");

    if Description and Description:IsA("TextLabel") then
        Description.TextColor3 = v23;
        Description.Font = Enum.Font.GothamMedium;
        Skin.textStroke(Description, 2);
    end;

    for _, v in { "Footnote", "Hint", "Loading" } do
        local v24 = textSecondary;
        local v25 = p16:FindFirstChild(v);

        if v25 and v25:IsA("TextLabel") then
            v25.TextColor3 = v24;
            v25.Font = Enum.Font.GothamMedium;
            Skin.textStroke(v25, 2);
        end;
    end;

    local Timer = p16:FindFirstChild("Timer");

    if Timer then
        Skin.text(Timer, "timer");
    end;

    local Buy = p16.Buy;
    local v26 = p18 or "buy-robux";
    Buy.Font = GothamBold;
    Skin.button(Buy, v26);
    Buy.BackgroundTransparency = v26 == "dark" and 0.2 or 0;

    if p16:FindFirstChild("Sounds") then
        sounds(p16.Sounds, p17);
    end;
end;

v1.card = card;

local function tokens(p27, p28) -- Line: 82
    -- upvalues: Skin (copy)
    for _, child in p27:GetChildren() do
        if child:IsA("Frame") and string.sub(child.Name, 1, 5) == "Token" then
            if not child:GetAttribute("SkinTokenScaled") then
                child:SetAttribute("SkinTokenScaled", true);
                local Size = child.Size;
                local Position = child.Position;
                child.Size = UDim2.new(Size.X.Scale, math.round(Size.X.Offset * 1.6), Size.Y.Scale, (math.round(Size.Y.Offset * 1.6)));
                child.Position = UDim2.new(Position.X.Scale, math.round(Position.X.Offset * 1.6), Position.Y.Scale, Position.Y.Offset);
            end;

            Skin.icon(child, p28);
        end;
    end;
end;

local function dock(p29) -- Line: 95
    -- upvalues: Skin (copy), gold (copy), green (copy)
    Skin.icon(p29.CoinIcon, "coin");
    Skin.icon(p29.GemIcon, "gemWallet");
    Skin.text(p29.Coins, "gold");
    Skin.text(p29.Gems, "gem");

    for i, v in {
        Shop = gold,
        Inventory = green
    } do
        local v30 = p29[i];
        Skin.button(v30, "dark");
        v30.BackgroundTransparency = 0.2;
        v30.Accent.BackgroundColor3 = v;
    end;
end;

function v1.apply(p31) -- Line: 107
    -- upvalues: Skin (copy), text (copy), Palette (copy), green (copy), GothamBold (copy), Theme (copy), textSecondary (copy), sounds (copy), chicken (copy), UDim_new_ret (copy), gold (copy), dock (copy), card (copy), gem (copy), u7 (copy), tokens (copy)
    local Canvas = p31.Overlay.Canvas;
    Skin.panel(Canvas, {
        transparency = 0.2,
        radius = UDim.new(0, 14)
    });
    Canvas.Brand.Font = Enum.Font.GothamBold;
    Canvas.Brand.TextColor3 = text;
    Skin.textStroke(Canvas.Brand);
    Skin.textStroke(Canvas.Edition);
    Canvas.TopRule.BackgroundTransparency = 1;
    Skin.band(Canvas.HeaderRule, {
        color = Palette.neutral
    });
    Canvas.HeaderRule.BackgroundTransparency = 0;
    Canvas.Tabs.ActiveLine.BackgroundColor3 = green;
    Skin.corner(Canvas.Tabs.ActiveLine, UDim.new(1, 0));
    Canvas.Close.Font = GothamBold;
    Skin.button(Canvas.Close, "close");
    Theme.button(Canvas.Details.Action, green);
    Canvas.Details.Title.Font = Enum.Font.GothamBold;
    Canvas.Details.Title.TextColor3 = text;
    Skin.textStroke(Canvas.Details.Title);
    Skin.textStroke(Canvas.Details.Collection);
    local v32 = text;
    local Subtitle = Canvas.Details:FindFirstChild("Subtitle");

    if Subtitle and Subtitle:IsA("TextLabel") then
        Subtitle.TextColor3 = v32;
        Subtitle.Font = Enum.Font.GothamMedium;
        Skin.textStroke(Subtitle, 2);
    end;

    local v33 = text;
    local Description = Canvas.Details:FindFirstChild("Description");

    if Description and Description:IsA("TextLabel") then
        Description.TextColor3 = v33;
        Description.Font = Enum.Font.GothamMedium;
        Skin.textStroke(Description, 2);
    end;

    local v34 = textSecondary;
    local Status = Canvas:FindFirstChild("Status");

    if Status and Status:IsA("TextLabel") then
        Status.TextColor3 = v34;
        Status.Font = Enum.Font.GothamMedium;
        Skin.textStroke(Status, 2);
    end;

    local v35 = textSecondary;
    local Notice = Canvas:FindFirstChild("Notice");

    if Notice and Notice:IsA("TextLabel") then
        Notice.TextColor3 = v35;
        Notice.Font = Enum.Font.GothamMedium;
        Skin.textStroke(Notice, 2);
    end;

    local v36 = textSecondary;
    local ScrollHint = Canvas:FindFirstChild("ScrollHint");

    if ScrollHint and ScrollHint:IsA("TextLabel") then
        ScrollHint.TextColor3 = v36;
        ScrollHint.Font = Enum.Font.GothamMedium;
        Skin.textStroke(ScrollHint, 2);
    end;

    local v37 = textSecondary;
    local PreviewHint = Canvas.Hero:FindFirstChild("PreviewHint");

    if PreviewHint and PreviewHint:IsA("TextLabel") then
        PreviewHint.TextColor3 = v37;
        PreviewHint.Font = Enum.Font.GothamMedium;
        Skin.textStroke(PreviewHint, 2);
    end;

    sounds(Canvas.Sounds, chicken);
    local Field = Canvas.Hero.Field;
    Skin.card(Field, green, {
        transparency = 0,
        glow = true,
        radius = UDim_new_ret
    });
    Field.CentreLine.BackgroundTransparency = 1;
    Field.CentreCircle.Outline.Transparency = 1;
    Skin.text(Canvas.Wallet.Coins, "gold");
    Skin.text(Canvas.Wallet.Gems, "gem");
    Skin.scroll(Canvas.Selection);
    Skin.slot(p31.SkinTile, "idle", {
        radius = UDim.new(0, 8)
    });
    local v38 = text;
    local NameLabel = p31.SkinTile:FindFirstChild("NameLabel");

    if NameLabel and NameLabel:IsA("TextLabel") then
        NameLabel.TextColor3 = v38;
        NameLabel.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
        Skin.textStroke(NameLabel, 1.5);
    end;

    local v39 = gold;
    local Index = p31.SkinTile:FindFirstChild("Index");

    if Index and Index:IsA("TextLabel") then
        Index.TextColor3 = v39;
        Index.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
        Skin.textStroke(Index, 1.5);
    end;

    local v40 = textSecondary;
    local State = p31.SkinTile:FindFirstChild("State");

    if State and State:IsA("TextLabel") then
        State.TextColor3 = v40;
        State.Font = Enum.Font.GothamMedium;
        Skin.textStroke(State, 2);
    end;

    dock(p31.Dock);
    local Storefront = Canvas.Storefront;
    Skin.scroll(Storefront);
    card(Storefront.Featured, gem);
    card(Storefront.Earnable, chicken, "primary");
    card(Storefront.BalloonDagger, Palette.emoteOffer, "primary");
    card(Storefront.TopWinsDagger, gold, "primary");
    card(Storefront.Perks.DoubleXP, Color3.fromHex("4395FF"), "buy-robux", true);
    card(Storefront.Perks.VIP, gold, "buy-robux", true);
    Skin.text(Storefront.Promotion, "gold");

    for _, v in { "PerksHeading", "Stacking", "Footer" } do
        u7(Storefront, v, v == "PerksHeading" and text or textSecondary, v == "PerksHeading");
    end;

    for _, v in { "Coins", "Gems" } do
        local v41 = Storefront[v];
        local v42 = v == "Coins";
        local v43 = v42 and gold or gem;
        local v44 = text;
        local Heading = v41:FindFirstChild("Heading");

        if Heading and Heading:IsA("TextLabel") then
            Heading.TextColor3 = v44;
            Heading.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
            Skin.textStroke(Heading, 1.5);
        end;

        local v45 = text;
        local Description2 = v41:FindFirstChild("Description");

        if Description2 and Description2:IsA("TextLabel") then
            Description2.TextColor3 = v45;
            Description2.Font = Enum.Font.GothamMedium;
            Skin.textStroke(Description2, 2);
        end;

        for _, child in v41.Packs:GetChildren() do
            if child:IsA("Frame") then
                Skin.card(child, v43, {
                    radius = UDim_new_ret
                });
                Skin.glow(child.Art, nil, v42 and "coins" or "gems");
                tokens(child.Art, v42 and "coin" or "gemLarge");
                local v46 = v42 and v43:Lerp(text, 0.35) or Palette.gemText;
                local Amount = child:FindFirstChild("Amount");

                if Amount and Amount:IsA("TextLabel") then
                    Amount.TextColor3 = v46;
                    Amount.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
                    Skin.textStroke(Amount, 1.5);
                end;

                local v47 = textSecondary;
                local Caption = child:FindFirstChild("Caption");

                if Caption and Caption:IsA("TextLabel") then
                    Caption.TextColor3 = v47;
                    Caption.Font = Enum.Font.GothamMedium;
                    Skin.textStroke(Caption, 2);
                end;

                local Buy = child.Buy;
                Buy.Font = GothamBold;
                Skin.button(Buy, "buy-robux");
                Buy.BackgroundTransparency = 0;
            end;
        end;
    end;
end;

function v1.view(p48, p49, p50) -- Line: 179
    -- upvalues: gem (copy), chicken (copy), gold (copy), GothamBold (copy), Skin (copy), green (copy)
    local v51 = p50 == "Emotes";
    p48.Depth.Enabled = false;
    p48.Edition.Text = p49 and "MY KNIVES  /  YOUR COLLECTION" or (v51 and "MY EMOTES  /  YOUR EMOTE WHEEL" or (p50 == "Abilities" and "ABILITIES  /  PERMANENT UNLOCKS" or (p50 == "Items" and "ITEMS  /  CONSUMABLE PACKS" or "THE ARMORY  /  SHOP")));
    p48.Edition.TextColor3 = v51 and gem or (p49 and chicken or gold);

    for _, v in { "Shop", "Abilities", "Items", "Inventory", "Emotes" } do
        local v52 = p48.Tabs:FindFirstChild(v);

        if v52 then
            v52.Font = GothamBold;
            Skin.tab(v52, v == (p50 or (p49 and "Inventory" or "Shop")));
            v52.BackgroundTransparency = 0;
            v52.TextTransparency = v52:GetAttribute("Dimmed") == true and 0.55 or 0;
        end;
    end;

    p48.Tabs.ActiveLine.BackgroundColor3 = green;
    Skin.button(p48.Close, "close");
end;

function v1.action(p53, p54, p55, p56) -- Line: 205
    -- upvalues: GothamBold (copy), Skin (copy)
    local Action = p53.Details.Action;
    Action.Font = GothamBold;
    Skin.button(Action, (p55 or p56 == "equipped") and "primary" or "secondary");
    Action.BackgroundTransparency = 0;
    Action.TextTransparency = p55 and 0 or 0.2;
end;

return v1;