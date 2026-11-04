 

 

local MarketplaceService = game:GetService("MarketplaceService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local ShopConfig = require(script.Parent.ShopConfig);
local OfferRules = require(script.Parent.OfferRules);
local Bundles = require(script.Parent.Bundles);
local u1 = Bundles.shopList();
local BundlePanel = require(script.Parent.BundlePanel);
local KnifeIconCopy = require(script.Parent.KnifeIconCopy);
local CurrencyTopUp = require(script.Parent.CurrencyTopUp);
local GiftClient = require(script.Parent.GiftClient);
local ArmoryStyle = require(script.Parent.Parent.Presentation.ArmoryStyle);
local PreviewButton = require(script.Parent.Parent.Interface.PreviewButton);
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local EventKnivesOffer = require(script.Parent.EventKnivesOffer);
local u2 = {};
u2.__index = u2;

local function giftLook(p3, p4) -- Line: 24
    -- upvalues: Skin (copy)
    Skin.button(p3, p4 and "buy-coins" or "secondary");
    p3.BackgroundTransparency = 0;
end;

local u5 = { "Featured", "GhostFeatured", "FootballFeatured", "FutbolFeatured" };
local u6 = {
    Featured = "Flagship",
    GhostFeatured = "GhostFlagship",
    FootballFeatured = "FootballFlagship",
    FutbolFeatured = "FutbolFlagship"
};

local function show(p7, p8) -- Line: 38
    if p7.Visible == p8 then
        return false;
    end;

    p7.Visible = p8;

    return true;
end;

local function comma(p9) -- Line: 45
    local math_floor_ret = math.floor(p9);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local function box(p10, p11, p12, p13, p14) -- Line: 48
    p10.Position = UDim2.fromOffset(p11, p12);
    p10.Size = UDim2.fromOffset(p13, p14);
end;

local function paint(p15) -- Line: 55
    -- upvalues: Skin (copy)
    local button = p15.button;
    local v16;

    if p15.kind == "Gem" then
        v16 = string.find(button.Text, "^[%d,]+$") ~= nil;
    else
        v16 = false;
    end;

    local v17;

    if button.Active then
        v17 = (p15.kind == "Pass" or (p15.kind == "Product" or p15.kind == "Bundle")) and "buy-robux" or (v16 and "buy-gems" or "primary");
    else
        v17 = string.find(button.Text, "✓", 1, true) and "primary" or "secondary";
    end;

    if p15.look ~= v17 then
        p15.look = v17;
        Skin.button(button, v17);
        button.BackgroundTransparency = 0;
    end;

    Skin.price(button, v16 and "gems" or nil, {
        dim = not button.Active
    });
end;

function u2.new(p18, u19, u20, u21, u22, p23) -- Line: 72
    -- upvalues: ShopConfig (copy), u2 (copy), TweenService (copy), Bundles (copy), GiftClient (copy), giftLook (copy), PreviewButton (copy), KnifeIconCopy (copy), Panels (copy), Skin (copy), u1 (copy), ArmoryStyle (copy), UserInputService (copy), MarketplaceService (copy)
    local v24 = p23 or function() -- Line: 73
    end;
    local v25 = {
        open = false,
        canvas = p18,
        root = p18.Storefront,
        player = u22,
        state = {
            owned = {}
        },
        offers = {},
        connections = {},
        prices = {},
        binding = ShopConfig.binding(game.GameId),
        catalog = u20,
        previews = {},
        pendingPreviews = {},
        sections = {},
        flagshipEntry = {},
        pace = v24
    };
    local u26 = setmetatable(v25, u2);
    local root = u26.root;
    root.Coins.Description.Text = "Stock up on supplies. Larger bundles give more coins per Robux.";
    root.Gems.Description.Text = "Buy supplies and gem items. Larger bundles give more gems per Robux.";

    for _, descendant in root:GetDescendants() do
        if descendant:IsA("GuiObject") and not (descendant:IsA("GuiButton") or descendant:IsA("ScrollingFrame")) then
            descendant.Active = false;
            descendant.Selectable = false;
        end;
    end;

    v24();

    local function connect(p27, p28) -- Line: 102
        -- upvalues: u26 (copy)
        table.insert(u26.connections, p27:Connect(p28));
    end;

    local function animateButton(u29) -- Line: 105
        -- upvalues: TweenService (ref), u26 (copy)
        local u30 = u29:FindFirstChild("ShopPressScale") or Instance.new("UIScale");
        u30.Name = "ShopPressScale";
        u30.Parent = u29;
        local u31 = nil;

        local function set(p32) -- Line: 110
            -- upvalues: u31 (ref), TweenService (ref), u30 (copy), u29 (copy)
            if u31 then
                u31:Cancel();
            end;

            u31 = TweenService:Create(u30, TweenInfo.new(0.17, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = u29.Active and p32 and p32 or 1
            });
            u31:Play();
        end;

        table.insert(u26.connections, u29.MouseEnter:Connect(function() -- Line: 121
            -- upvalues: set (copy)
            set(1.025);
        end));
        table.insert(u26.connections, u29.MouseLeave:Connect(function() -- Line: 124
            -- upvalues: set (copy)
            set(1);
        end));
        table.insert(u26.connections, u29.SelectionGained:Connect(function() -- Line: 127
            -- upvalues: set (copy)
            set(1.025);
        end));
        table.insert(u26.connections, u29.SelectionLost:Connect(function() -- Line: 130
            -- upvalues: set (copy)
            set(1);
        end));
        table.insert(u26.connections, u29.MouseButton1Down:Connect(function() -- Line: 133
            -- upvalues: set (copy)
            set(0.95);
        end));
        table.insert(u26.connections, u29.MouseButton1Up:Connect(function() -- Line: 136
            -- upvalues: set (copy)
            set(1);
        end));
    end;

    local function offer(p33, p34, p35, p36) -- Line: 140
        -- upvalues: animateButton (copy), u26 (copy), Bundles (ref), GiftClient (ref), giftLook (ref)
        animateButton(p33);
        local u37 = {
            button = p33,
            key = p34,
            kind = p35,
            id = p35 == "Pass" and u26.binding.PassIds[p34] or p35 == "Product" and u26.binding.ProductIds[p34] or (p35 == "Bundle" and Bundles.get(p34) and (Bundles.productId(Bundles.get(p34)) or 0) or 0) or 0,
            pack = p36
        };
        table.insert(u26.offers, u37);

        if p35 == "Pass" and (p34 == "Football" or p34 == "Futbol") then
            u26.flagshipEntry[p34] = u37;
        end;

        if p35 == "Pass" or (p35 == "Product" or p35 == "Bundle") then
            GiftClient.attach(p33, p34, giftLook);
        end;

        table.insert(u26.connections, p33.Activated:Connect(function() -- Line: 155
            -- upvalues: u26 (ref), u37 (copy)
            u26:purchase(u37);
        end));
    end;

    local function feature(u38, u39, p40) -- Line: 159
        -- upvalues: u20 (copy), offer (copy), animateButton (copy), u21 (copy), u26 (copy), PreviewButton (ref), u19 (copy), KnifeIconCopy (ref)
        local u41 = u20.get(u39.SkinId);

        for _, v in { "Eyebrow", "Title", "Tagline", "Description", "Footnote" } do
            u38[v].Text = u39[v] or "";
        end;

        if p40 == "Gem" and u41 then
            u38.Title.Text = u41.Name;
            u38.Tagline.Text = u41.Subtitle;
            u38.Description.Text = u41.Description;
        end;

        offer(u38.Buy, (p40 == "Gem" or p40 == "Reward") and u39.SkinId or u39.OfferKey, p40);

        for _, v in { "Equip", "Swing", "Hit" } do
            animateButton(u38.Sounds[v]);
            u38.Sounds[v].Active = u41 ~= nil;
            table.insert(u26.connections, u38.Sounds[v].Activated:Connect(function() -- Line: 173
                -- upvalues: u41 (copy), u21 (ref), u39 (copy), v (copy)
                if u41 then
                    u21:Fire("KnifePreview", u39.SkinId, v);
                end;
            end));
        end;

        PreviewButton.row(u38.Sounds, u21):set(u39.SkinId);

        if u41 then
            u41 = u19.Models:FindFirstChild(u41.Model);
        end;

        local u42;

        if u41 then
            u42 = u41:FindFirstChild("Blade");
        else
            u42 = u41;
        end;

        if not u42 then
            u38.Loading.Text = p40 == "Gem" and "NEXT GEM KNIFE" or "PREVIEW UNAVAILABLE";
            u38.Loading.Visible = true;
            u38.Sounds.Visible = false;

            return;
        end;

        u38.Sounds.Visible = true;
        local u43 = {
            extent = 1,
            rotation = 0,
            dragging = false,
            card = u38
        };

        function u43.build() -- Line: 193
            -- upvalues: u42 (copy), u41 (copy), KnifeIconCopy (ref), u38 (copy), u43 (copy)
            local WorldModel = Instance.new("WorldModel");
            local Model = Instance.new("Model");
            Model.Name = "ShopPreview";
            Model.Parent = WorldModel;
            local v44 = u42:Clone();
            local v45 = {};

            for _, descendant in v44:GetDescendants() do
                if descendant:IsA("LuaSourceContainer") or (descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint")) then
                    descendant:Destroy();
                elseif descendant:IsA("BasePart") then
                    v45[descendant] = v44.CFrame:ToObjectSpace(descendant.CFrame);
                    descendant.Anchored = true;
                    descendant.CanCollide = false;
                    descendant.CanTouch = false;
                    descendant.CanQuery = false;
                end;
            end;

            v44.Anchored = true;
            v44.CanCollide = false;
            v44.CanTouch = false;
            v44.CanQuery = false;
            v44.Transparency = 0;
            v44.CFrame = u41:GetAttribute("PreviewRotation") or CFrame.Angles(-0.4363323129985824, -0.20943951023931956, -0.5585053606381855);

            for i, v in v45 do
                i.CFrame = v44.CFrame * v;
            end;

            v44.Parent = Model;
            Model.PrimaryPart = v44;
            KnifeIconCopy.cross(Model, u41, function(p46, p47) -- Line: 224
                return p47:GetAttribute("PreviewRotation") or CFrame.Angles(-0.4363323129985824, -0.20943951023931956, -0.5585053606381855);
            end, Vector3.new(0, 1, 0), v44);
            local BoundingBox, v48 = Model:GetBoundingBox();
            Model:PivotTo(Model:GetPivot() - BoundingBox.Position);
            local Camera = Instance.new("Camera");
            Camera.FieldOfView = 33;
            Camera.Parent = u38.Weapon;
            WorldModel.Parent = u38.Weapon;
            u38.Weapon.CurrentCamera = Camera;
            local v49 = tonumber(u41:GetAttribute("PreviewZoom")) or 1;
            local math_clamp_ret = math.clamp(v49, 0.5, 3);
            u43.extent = math.max(v48.X, v48.Y, v48.Z) / math_clamp_ret;
            u43.camera = Camera;
            u38.Loading.Visible = false;
        end;

        table.insert(u26.previews, u43);
        table.insert(u26.pendingPreviews, u43);
        u38.Loading.Visible = true;
        table.insert(u26.connections, u38.Weapon.InputBegan:Connect(function(p50) -- Line: 243
            -- upvalues: u43 (copy)
            if p50.UserInputType == Enum.UserInputType.MouseButton1 then
                u43.dragging = true;
                u43.lastX = p50.Position.X;
            end;
        end));
    end;

    local v51 = Panels.make("Frame", root, "QuestProgress", {
        BorderSizePixel = 0,
        Visible = false,
        BackgroundColor3 = Color3.fromRGB(21, 38, 48)
    });
    Panels.corner(v51, 13);
    Panels.stroke(v51, Panels.Gold, 0.5);
    Skin.card(v51, Panels.Gold);
    local v52 = Panels.text(v51, "Heading", "NEXT FREE KNIFE", 18, 10, 360, 20, 15, Panels.Gold);
    v52.Font = Enum.Font.GothamBold;
    Skin.textStroke(v52, 1.5);
    v52.TextXAlignment = Enum.TextXAlignment.Left;
    local v53 = Panels.text(v51, "KnifeName", "Loading quests...", 18, 32, 400, 27, 19, Panels.Paper);
    v53.Font = Enum.Font.GothamBold;
    v53.TextXAlignment = Enum.TextXAlignment.Left;
    local v54 = Panels.text(v51, "Status", "0% complete", 18, 66, 360, 20, 14, Panels.Muted);
    v54.Font = Enum.Font.GothamMedium;
    Skin.textStroke(v54, 2);
    v54.TextXAlignment = Enum.TextXAlignment.Left;
    local v55 = Panels.make("Frame", v51, "Track", {
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(55, 69, 77)
    });
    Panels.corner(v55, 5);
    local v56 = Panels.make("Frame", v55, "Fill", {
        BorderSizePixel = 0,
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = Panels.Gold
    });
    Panels.corner(v56, 5);
    Skin.bar(v55, v56, "green");
    local v57 = Panels.button(v51, "OpenQuests", "VIEW QUESTS  ›", 0, 0, 150, 43, Color3.fromRGB(77, 112, 94));
    v57.TextScaled = true;
    Skin.button(v57, "primary");
    animateButton(v57);
    table.insert(u26.connections, v57.Activated:Connect(function() -- Line: 287
        -- upvalues: u22 (copy)
        u22:SetAttribute("QuestOpenRequestedAt", os.clock());
    end));
    u26.questCard = v51;
    v24();
    u26.questRemote = game.ReplicatedStorage.ChickenOrHero.Quests:WaitForChild("QuestEvent");
    table.insert(u26.connections, u26.questRemote.OnClientEvent:Connect(function(p58, p59) -- Line: 293
        -- upvalues: u26 (copy)
        if p58 ~= "State" or type(p59) ~= "table" then
            return;
        end;

        u26.questState = p59;
        u26:refreshQuest();
    end));
    local v60 = root.Featured:Clone();
    v60.Name = "GhostFeatured";
    v60.Visible = false;
    v60.Parent = root;
    local v61 = root.Featured:Clone();
    v61.Name = "FootballFeatured";
    v61.Visible = false;
    v61.Parent = root;
    local v62 = root.Featured:Clone();
    v62.Name = "FutbolFeatured";
    v62.Visible = false;
    v62.Parent = root;
    u26.bundleCards = {};

    for i, v in u1 do
        local v63 = root.Featured:Clone();
        v63.Name = i == 1 and "LimitedBundle" or "LimitedBundle" .. i;
        v63.Visible = false;
        v63.Parent = root;
        table.insert(u26.bundleCards, {
            card = v63,
            bundle = v
        });
    end;

    local v64 = Panels.text(root, "LimitedHeading", "LIMITED", 0, 0, 10, 10, 27, Panels.Paper);
    v64.Font = Enum.Font.GothamBold;
    v64.Visible = false;
    v24();
    feature(root.Featured, ShopConfig.Flagship, "Pass");
    v24();
    feature(v60, ShopConfig.GhostFlagship, "Pass");
    v24();
    feature(v61, ShopConfig.FootballFlagship, "Pass");
    v24();
    feature(v62, ShopConfig.FutbolFlagship, "Pass");
    v24();
    u26.eventFrame = Panels.make("Frame", root, "EventKnives", {
        BackgroundTransparency = 1,
        Visible = false
    });
    u26.eventOptions = {
        status = function(p65) -- Line: 338, Name: status
            -- upvalues: u26 (copy)
            local v66 = u26.flagshipEntry[p65];

            return v66.button.Text, v66.button.Active;
        end,

        purchase = function(p67) -- Line: 342, Name: purchase
            -- upvalues: u26 (copy)
            u26:purchase(u26.flagshipEntry[p67]);
        end,

        owned = function(p68) -- Line: 345, Name: owned
            -- upvalues: u26 (copy)
            return (u26.state.owned or {})[p68] == true;
        end,

        notice = function(p69) -- Line: 348, Name: notice
            -- upvalues: u26 (copy)
            u26:notice(p69);
        end,

        cues = u21
    };

    for _, v in u26.bundleCards do
        local bundle = v.bundle;
        local card = v.card;
        local v70 = u20.get(bundle.SkinId);
        ArmoryStyle.card(card, v70 and v70.Accent or Color3.fromRGB(255, 86, 108));
        card.Index.Text = "LIMITED  /  ROBUX BUNDLE";
        feature(card, {
            Eyebrow = "LIMITED BUNDLE",
            Footnote = "Limited time · exclusive knife",
            SkinId = bundle.SkinId,
            OfferKey = bundle.Key,
            Title = bundle.Title,
            Tagline = v70 and v70.Subtitle or "",
            Description = bundle.Blurb
        }, "Bundle");
        card.Description.RichText = true;
        v24();
    end;

    for _, v in ShopConfig.AdditionalKnives or {} do
        v24();
        local v71 = root:FindFirstChild(v.SkinId);

        if not v71 then
            v71 = root.Featured:Clone();
            v71.Name = v.SkinId;
            v71.Parent = root;
            v71.Weapon:ClearAllChildren();
            v71.Timer.Text = "";
            v71.Timer.Visible = false;
        end;

        v71.Index.Text = "ROBUX EXCLUSIVE";
        v71:SetAttribute("TitleTextSize", v.TitleTextSize);
        feature(v71, v, "Pass");
    end;

    root.Earnable.Visible = false;

    for _, v in { "BalloonDagger", "TopWinsDagger" } do
        local v72 = u20.get(v);
        local v73 = root:FindFirstChild(v);

        if v73 then
            v24();
            feature(v73, {
                Footnote = "Earn once. Keep forever.",
                SkinId = v,
                Eyebrow = v72.Collection,
                Title = v72.Name,
                Tagline = v72.Subtitle,
                Description = v72.Description
            }, "Reward");
        end;
    end;

    v24();
    offer(root.Perks.DoubleXP.Buy, "DoubleXP", "Pass");
    offer(root.Perks.VIP.Buy, "VIP", "Pass");
    local v74 = {
        coins = 0,
        gems = 0
    };

    for _, v in ShopConfig.Packs do
        local Currency = v.Currency;
        v74[Currency] = v74[Currency] + 1;
        local v75 = root[v.Currency == "coins" and "Coins" or "Gems"].Packs["Pack" .. v74[v.Currency]];
        local Amount = v75.Amount;
        local math_floor_ret = math.floor(v.Amount);
        Amount.Text = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
        v75.Caption.Text = v.Label;
        local v76;

        if v.Icon then
            v76 = v;

            for _, child in v75.Art:GetChildren() do
                if child:IsA("GuiObject") and string.sub(child.Name, 1, 5) == "Token" then
                    child.Visible = false;
                end;
            end;

            local v77 = v75.Art:FindFirstChild("PackIcon") or Instance.new("ImageLabel");
            v77.Name = "PackIcon";
            v77.BackgroundTransparency = 1;
            v77.Image = v76.Icon;
            v77.ScaleType = Enum.ScaleType.Fit;
            v77.AnchorPoint = Vector2.new(0.5, 1);
            v77.Position = UDim2.fromScale(0.5, 1);
            v77.Size = UDim2.fromScale(1, 1.2);
            v77.ZIndex = v75.Art.ZIndex + 1;
            v77.Parent = v75.Art;
        else
            v76 = v;
        end;

        local Buy = v75.Buy;
        local Key = v76.Key;
        animateButton(Buy);
        local u78 = {
            kind = "Product",
            button = Buy,
            key = Key,
            id = u26.binding.ProductIds[Key] or 0 or 0,
            pack = v76
        };
        table.insert(u26.offers, u78);
        GiftClient.attach(Buy, Key, giftLook);
        table.insert(u26.connections, Buy.Activated:Connect(function() -- Line: 155
            -- upvalues: u26 (copy), u78 (copy)
            u26:purchase(u78);
        end));
    end;

    v24();
    table.insert(u26.connections, UserInputService.InputChanged:Connect(function(p79) -- Line: 433
        -- upvalues: u26 (copy)
        if not u26.open then
            return;
        end;

        for _, v in u26.previews do
            if v.dragging and p79.UserInputType == Enum.UserInputType.MouseMovement then
                v.rotation = v.rotation + (p79.Position.X - v.lastX) * 0.012;
                v.lastX = p79.Position.X;
            end;
        end;
    end));
    table.insert(u26.connections, UserInputService.InputEnded:Connect(function(p80) -- Line: 444
        -- upvalues: u26 (copy)
        if p80.UserInputType == Enum.UserInputType.MouseButton1 then
            for _, v in u26.previews do
                v.dragging = false;
            end;
        end;
    end));
    table.insert(u26.connections, GiftClient.changed:Connect(function() -- Line: 451
        -- upvalues: u26 (copy)
        u26:refresh();

        if u26.layoutWidth then
            u26:layout(u26.layoutWidth, u26.layoutPortrait);
        end;
    end));

    for _, v in { "HasVIP", "HasDoubleXP", "EconomyLoaded", "GiftOpen" } do
        local AttributeChangedSignal = u22:GetAttributeChangedSignal(v);
        table.insert(u26.connections, AttributeChangedSignal:Connect(function() -- Line: 458
            -- upvalues: u26 (copy)
            u26:refresh();
        end));
    end;

    table.insert(u26.connections, MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(p81, p82, p83) -- Line: 462
        -- upvalues: u22 (copy), u26 (copy)
        if p81 == u22 and p83 then
            u26:notice("Verifying your new perk…");
        end;
    end));

    if u26.binding.PurchasesEnabled == false then
        root.Footer.Text = "TEST EXPERIENCE · Robux purchases open in the live game. Owned passes still apply.";
    end;

    v24();
    u26.gear = require(script.Parent.Parent.Gear.GearStoreClient).new(u26, "Ability");
    u26.abilityRoot = u26.root:Clone();
    u26.abilityRoot:ClearAllChildren();
    u26.abilityRoot.Name = "Abilities";
    u26.abilityRoot.Visible = false;
    u26.abilityRoot.Parent = p18;
    u26.gear.root.Parent = u26.abilityRoot;
    v24();
    u26.items = require(script.Parent.Parent.Gear.GearStoreClient).new(u26, "Item");
    u26.itemRoot = u26.abilityRoot:Clone();
    u26.itemRoot:ClearAllChildren();
    u26.itemRoot.Name = "Items";
    u26.itemRoot.Parent = p18;
    u26.items.root.Parent = u26.itemRoot;
    v24();
    u26.emotes = require(script.Parent.EmoteStoreClient).new(u26);
    v24();
    u26.daily = require(script.Parent.DailyEmoteOffers).new(u26);
    v24();
    u26.pace = nil;
    u26:refresh();

    return u26;
end;

function u2.refreshQuest(p84) -- Line: 495
    local questCard = p84.questCard;

    if not questCard then
        return;
    end;

    local questState = p84.questState;
    local v85;

    if questState then
        v85 = questState.event;
    else
        v85 = questState;
    end;

    if questState then
        if questState.mode == "Event" then
            if v85 then
                questState = v85.phase == "Active";
            else
                questState = v85;
            end;
        else
            questState = false;
        end;
    end;

    local v86 = nil;

    if questState then
        for _, v in v85.weapons or {} do
            if v.id == v85.activeWeapon then
                v86 = v;
                break;
            end;
        end;
    end;

    local Visible = questCard.Visible;

    if questState then
        questState = v86 ~= nil;
    end;

    questCard.Visible = questState;

    if Visible ~= questCard.Visible and p84.layoutWidth then
        p84:layout(p84.layoutWidth, p84.layoutPortrait);
    end;

    if not questCard.Visible then
        return;
    end;

    questCard.KnifeName.Text = v86.name;
    local v87 = #v86.quests;
    local v88 = 0;
    local v89 = 0;

    for _, v in v86.quests do
        local v90 = v.progress / math.max(v.target, 1);
        local math_clamp_ret = math.clamp(v90, 0, 1);

        if v.alternateTarget then
            local math_clamp_ret2 = math.clamp((v.alternateProgress or 0) / v.alternateTarget, 0, 1);
            math_clamp_ret = math.max(math_clamp_ret, math_clamp_ret2);
        end;

        v88 = v88 + math_clamp_ret;

        if v.complete then
            v89 = v89 + 1;
        end;
    end;

    local v91 = v87 > 0 and (v88 / v87 or 0) or 0;
    questCard.Status.Text = string.format("%d%% COMPLETE  ·  %d/%d QUESTS", math.floor(v91 * 100 + 0.5), v89, v87);
    questCard.Track.Fill.Size = UDim2.fromScale(v91, 1);
    questCard.OpenQuests.Text = v86.claimable and "CLAIM KNIFE  ›" or "VIEW QUESTS  ›";
end;

function u2.notice(p92, p93) -- Line: 540
    p92.canvas.Notice.Text = p93;
    p92.noticeUntil = os.clock() + 7;
end;

function u2.eligible(p94, p95) -- Line: 544
    -- upvalues: ShopConfig (copy)
    if p95.kind == "Reward" then
        return p94.catalog.get(p95.key) ~= nil;
    end;

    if p95.kind == "Bundle" then
        return p95.id > 0;
    end;

    if p95.kind == "Gem" then
        local v96 = p94.catalog.get(p95.key);
        local v97;

        if v96 then
            v97 = v96.Offer;
        else
            v97 = v96;
        end;

        local v98;

        if v96 == nil or (v96.EquipReady == false or (v96.Available ~= true or (v97 == nil or (v97.Currency ~= "gems" or type(v97.Price) ~= "number")))) then
            v98 = false;
        else
            v98 = v97.Price > 0;
        end;

        return v98;
    end;

    if p95.id <= 0 then
        return false;
    end;

    if p95.kind ~= "Pass" then
        local v99 = ShopConfig.ProductGrants[p95.id];
        local v100;

        if v99 == nil or (v99.UniverseId ~= game.GameId or v99.Currency ~= p95.pack.Currency) then
            v100 = false;
        else
            v100 = v99.Amount == p95.pack.Amount;
        end;

        return v100;
    end;

    local v101 = ShopConfig.Passes[p95.key];

    if not (v101 and v101.SkinId) then
        return v101 ~= nil;
    end;

    local v102 = p94.catalog.get(v101.SkinId);
    local v103;

    if v102 == nil then
        v103 = false;
    else
        v103 = v102.EquipReady ~= false;
    end;

    return v103;
end;

function u2.owned(p104, p105) -- Line: 579
    -- upvalues: Bundles (copy), ShopConfig (copy)
    if p105.kind == "Reward" then
        return p104.state.owned[p105.key] == true;
    end;

    if p105.kind == "Gem" then
        return p104.state.owned[p105.key] == true;
    end;

    if p105.kind == "Bundle" then
        return Bundles.purchased(Bundles.get(p105.key), p104.state);
    end;

    if p105.kind ~= "Pass" then
        return false;
    end;

    local v106 = ShopConfig.Passes[p105.key];
    local v107;

    if p105.key == "VIP" and p104.player:GetAttribute("HasVIP") == true or p105.key == "DoubleXP" and p104.player:GetAttribute("HasDoubleXP") == true then
        v107 = true;
    else
        v107 = v106 and v106.SkinId and p104.state.owned[v106.SkinId] == true;
    end;

    return v107;
end;

function u2.refresh(p108) -- Line: 598
    -- upvalues: ShopConfig (copy), EventKnivesOffer (copy), u5 (copy), u6 (copy), OfferRules (copy), Bundles (copy), GiftClient (copy), paint (copy)
    if p108.daily then
        p108.daily:refresh();
    end;

    if p108.items then
        p108.items:refresh();
    end;

    if p108.gear then
        p108.gear:refresh();
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    local v109 = ShopConfig.featuredAll(ServerTimeNow);
    local v110 = p108.state.owned or {};
    local v111 = EventKnivesOffer.active(ServerTimeNow);
    local v112 = false;

    for _, v in u5 do
        local v113 = p108.root[v];
        local v114;

        if table.find(v109, ShopConfig[u6[v]]) == nil then
            v114 = false;
        else
            local v115;

            if v111 then
                v115 = v == "FootballFeatured" and true or v == "FutbolFeatured";
            else
                v115 = v111;
            end;

            v114 = not v115;
        end;

        local v116;

        if v113.Visible == v114 then
            v116 = false;
        else
            v113.Visible = v114;
            v116 = true;
        end;

        v112 = v116 or v112;
    end;

    local eventFrame = p108.eventFrame;
    local v117 = EventKnivesOffer.shown(p108.state, ServerTimeNow, p108.eventOptions.owned);
    local v118;

    if eventFrame.Visible == v117 then
        v118 = false;
    else
        eventFrame.Visible = v117;
        v118 = true;
    end;

    local v119 = v118 or v112;

    for _, v in p108.bundleCards do
        local card = v.card;
        local v120 = OfferRules.active(v.bundle, ServerTimeNow);
        local v121;

        if card.Visible == v120 then
            v121 = false;
        else
            card.Visible = v120;
            v121 = true;
        end;

        v119 = v121 or v119;
    end;

    for _, v in ShopConfig.AdditionalKnives or {} do
        local v122 = p108.root:FindFirstChild(v.SkinId);

        if v122 then
            local v123;

            if v122.Visible == true then
                v123 = false;
            else
                v122.Visible = true;
                v123 = true;
            end;

            v119 = v123 or v119;
        end;
    end;

    local v124;

    if v110[ShopConfig.FootballFlagship.SkinId] == true then
        v124 = v110[ShopConfig.FutbolFlagship.SkinId] == true;
    else
        v124 = false;
    end;

    if v124 ~= p108.ghostFirst then
        p108.ghostFirst = v124;
        v119 = true;
    end;

    if v119 and p108.layoutWidth then
        p108:layout(p108.layoutWidth, p108.layoutPortrait);
    end;

    for _, v in { "Featured", "GhostFeatured", "FootballFeatured", "FutbolFeatured", "Earnable" } do
        local v125 = u6[v] and ShopConfig[u6[v]] or ShopConfig.Earnable;
        local Timer = p108.root[v]:FindFirstChild("Timer");

        if Timer then
            Timer.Text = OfferRules.countdown(v125, ServerTimeNow);
            Timer.Visible = Timer.Text ~= "";
        end;
    end;

    for _, v in p108.bundleCards do
        local Timer = v.card:FindFirstChild("Timer");

        if Timer then
            Timer.Text = OfferRules.countdown(v.bundle, ServerTimeNow);
            Timer.Visible = Timer.Text ~= "";
        end;
    end;

    for _, v in p108.offers do
        local v126 = p108:eligible(v);
        local v127 = p108:owned(v);

        if v.kind == "Reward" then
            local v128 = p108.state.equipped == v.key;
            v.button.Text = p108.state.loaded and (v128 and "EQUIPPED  ✓" or (v127 and "OWNED · EQUIP" or (v.key == "BalloonDagger" and "GET IT FREE · INVITE A FRIEND" or "REACH #1 GLOBAL WINS"))) or "LOADING COLLECTION…";
            local v129;

            if p108.state.loaded == true then
                v129 = not (p108.state.pending or v128) and (v127 or v.key == "BalloonDagger");
            else
                v129 = false;
            end;

            v.button.Active = v129;
        elseif v.kind == "Gem" then
            local v130 = p108.catalog.get(v.key);
            local v131 = p108.state.equipped == v.key;
            local v132;

            if v130 then
                v132 = v130.Offer;
            else
                v132 = v130;
            end;

            local v133 = OfferRules.status(v132, ServerTimeNow);
            local v134 = v133 == "Active";
            local button = v.button;
            local v135;

            if v126 then
                if p108.state.loaded then
                    if v131 then
                        v135 = "EQUIPPED  ✓";
                    elseif v127 then
                        v135 = "OWNED · EQUIP";
                    elseif v134 then
                        local math_floor_ret = math.floor(v130.Offer.Price);
                        v135 = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
                    else
                        v135 = v133 == "Expired" and "OFFER ENDED" or "NOT AVAILABLE YET";
                    end;
                else
                    v135 = "LOADING COLLECTION…";
                end;
            else
                v135 = "COMING SOON";
            end;

            button.Text = v135;

            if v126 then
                if p108.state.loaded == true then
                    v126 = not v131 and (not p108.state.pending and (v127 or v134));
                else
                    v126 = false;
                end;
            end;

            v.button.Active = v126;
        else
            local v136 = p108.prices[v.kind .. v.id];
            local v137 = v.kind == "Pass" and ShopConfig.flagship(v.key);

            if not v137 then
                if v.kind == "Bundle" then
                    v137 = Bundles.get(v.key);
                else
                    v137 = false;
                end;
            end;

            local v138 = not v137 or OfferRules.active(v137, ServerTimeNow);
            local v139;

            if type(v136) == "table" and (type(v136.PriceInRobux) == "number" and v136.PriceInRobux == v136.PriceInRobux) then
                v139 = v136.PriceInRobux >= 0;
            else
                v139 = false;
            end;

            local button = v.button;
            local v140;

            if v127 then
                v140 = "OWNED  ✓";
            elseif v138 then
                if v126 then
                    if v136 == false then
                        v140 = "PRICE UNAVAILABLE";
                    elseif type(v136) == "table" then
                        if v136.IsForSale then
                            if v139 then
                                local utf8_char_ret = utf8.char(57346);
                                local math_floor_ret = math.floor(v136.PriceInRobux);
                                v140 = utf8_char_ret .. " " .. tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
                            else
                                v140 = "PRICE UNAVAILABLE";
                            end;
                        else
                            v140 = "NOT ON SALE";
                        end;
                    else
                        v140 = "CHECKING PRICE…";
                    end;
                else
                    v140 = "COMING SOON";
                end;
            else
                v140 = OfferRules.status(v137, ServerTimeNow) == "Expired" and "OFFER ENDED" or "NOT AVAILABLE YET";
            end;

            button.Text = v140;
            local button2 = v.button;

            if p108.binding.PurchasesEnabled == false then
                v139 = false;
            else
                local v141 = v126 and not v127;

                if v141 then
                    if v139 then
                        if v136.IsForSale == true and p108.state.loaded == true then
                            v139 = not p108.state.pending;

                            if v139 then
                                if p108.player:GetAttribute("InMatch") == true then
                                    v139 = false;
                                else
                                    v139 = v138;
                                end;
                            end;
                        else
                            v139 = false;
                        end;
                    end;
                else
                    v139 = v141;
                end;
            end;

            button2.Active = v139;
            local sync = GiftClient.sync;
            local button3 = v.button;

            if v126 then
                if v138 then
                    if p108.binding.PurchasesEnabled == false then
                        v138 = false;
                    else
                        local v142;

                        if type(v136) == "table" then
                            v142 = v136.IsForSale ~= true;
                        else
                            v142 = false;
                        end;

                        v138 = not v142;
                    end;
                end;
            else
                v138 = v126;
            end;

            local v143;

            if p108.state.loaded == true then
                v143 = not p108.state.pending and p108.player:GetAttribute("InMatch") ~= true;
            else
                v143 = false;
            end;

            sync(button3, v138, v143);
        end;

        v.button.AutoButtonColor = v.button.Active;
        v.button.TextTransparency = v.button.Active and 0 or 0.3;
        paint(v);
    end;

    p108:syncEventCard();

    if p108.eventCard then
        p108.eventCard:refresh(p108.state);
    end;
end;

function u2.syncEventCard(p144) -- Line: 732
    -- upvalues: EventKnivesOffer (copy)
    local open = p144.open;

    if open then
        if p144.section == "Shop" then
            open = p144.eventFrame.Visible;
        else
            open = false;
        end;
    end;

    if open and not p144.eventCard then
        p144.eventCard = EventKnivesOffer.card(p144.eventFrame, p144.eventOptions);

        return;
    end;

    if not open and p144.eventCard then
        p144.eventCard:destroy();
        p144.eventCard = nil;
    end;
end;

function u2.fetchPrices(u145) -- Line: 741
    -- upvalues: MarketplaceService (copy)
    for _, v in u145.offers do
        local u146 = v.kind .. v.id;

        if v.kind ~= "Gem" and (v.kind ~= "Reward" and (u145:eligible(v) and (not u145:owned(v) and u145.prices[u146] == nil))) then
            u145.prices[u146] = "loading";
            task.spawn(function() -- Line: 752
                -- upvalues: MarketplaceService (ref), v (copy), u145 (copy), u146 (copy)
                local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, v.id, v.kind == "Pass" and Enum.InfoType.GamePass or Enum.InfoType.Product);

                if u145.destroyed then
                    return;
                end;

                u145.prices[u146] = success and result and result or false;
                u145:refresh();
            end);
        end;
    end;

    u145:refresh();
end;

function u2.productPrice(u147, u148) -- Line: 770
    -- upvalues: MarketplaceService (copy)
    local u149 = "Product" .. u148;
    local v150 = u147.prices[u149];

    if v150 ~= nil then
        return v150;
    end;

    local prices = u147.prices;
    prices[u149] = "loading";
    task.spawn(function() -- Line: 778
        -- upvalues: MarketplaceService (ref), u148 (copy), u147 (copy), prices (copy), u149 (copy)
        local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, u148, Enum.InfoType.Product);

        if u147.destroyed or prices ~= u147.prices then
            return;
        end;

        prices[u149] = success and result and result or false;
        u147:refresh();
    end);

    return "loading";
end;

function u2.purchase(u151, u152) -- Line: 788
    -- upvalues: CurrencyTopUp (copy), BundlePanel (copy), ShopConfig (copy), OfferRules (copy), GiftClient (copy), MarketplaceService (copy)
    if not (u151.open and (u152.button.Active and u151:eligible(u152))) then
        return;
    end;

    if u151.player:GetAttribute("InMatch") == true or not u151.state.loaded then
        return;
    end;

    if u152.kind == "Reward" then
        if u151:owned(u152) then
            script.Parent.ArmoryEvent:FireServer("Equip", u152.key);

            return;
        end;

        if u152.key == "BalloonDagger" then
            script.Parent.ArmoryNavigation:Fire("Balloon");
        end;

        return;
    end;

    if u152.kind == "Gem" then
        if not (u151:owned(u152) or u151.catalog.canBuy(u152.key, workspace:GetServerTimeNow())) then
            u151:refresh();
            u151:notice("This offer has ended or is not available yet.");

            return;
        end;

        local Price = u151.catalog.get(u152.key).Offer.Price;
        local v153 = u151.state.gems or 0;

        if not u151:owned(u152) and v153 < Price then
            if not CurrencyTopUp.prompt("gems", Price, v153) then
                u151:notice("Collect more gems during crossings to claim this knife.");
            end;

            return;
        end;

        script.Parent.ArmoryEvent:FireServer(u151:owned(u152) and "Equip" or "Buy", u152.key);
        u151:notice(u151:owned(u152) and "Equipping your knife…" or "Adding this knife to your collection…");

        return;
    end;

    if u152.kind == "Bundle" then
        BundlePanel.open(u151:owned(u152), u152.key, "shop_ui");

        return;
    end;

    if u151.binding.PurchasesEnabled == false then
        u151:notice("Robux purchases are available in the live game.");

        return;
    end;

    if u151:owned(u152) then
        return;
    end;

    local v154;

    if u152.kind == "Pass" then
        v154 = ShopConfig.flagship(u152.key);
    else
        v154 = false;
    end;

    if v154 and not OfferRules.active(v154, workspace:GetServerTimeNow()) then
        u151:refresh();

        return;
    end;

    if GiftClient.busy() then
        u151:notice("Finish your gift first.");

        return;
    end;

    if not pcall(function() -- Line: 843
        -- upvalues: u152 (copy), MarketplaceService (ref), u151 (copy)
        if u152.kind == "Pass" then
            MarketplaceService:PromptGamePassPurchase(u151.player, u152.id);

            return;
        end;

        MarketplaceService:PromptProductPurchase(u151.player, u152.id);
    end) then
        u151:notice("The purchase window could not open. Please try again.");
    end;
end;

function u2.update(p155, p156) -- Line: 854
    p155.state = p156;
    p155:refresh();

    if p155.emotes then
        p155.emotes:refresh();
    end;

    if p156.message and p155.open then
        p155:notice(p156.message);
    end;
end;

function u2.setOpen(p157, p158, p159) -- Line: 864
    -- upvalues: EventKnivesOffer (copy)
    p157.section = p159 or (p157.section or "Shop");
    local open = p157.open;
    p157.open = p158;

    if p157.gear then
        local v160;

        if p158 then
            v160 = p157.section == "Abilities";
        else
            v160 = p158;
        end;

        p157.gear:setOpen(v160);
    end;

    local v161;

    if p158 then
        v161 = p157.section == "Items";
    else
        v161 = p158;
    end;

    p157.items:setOpen(v161);
    local v162;

    if p158 then
        v162 = p157.section == "Items";
    else
        v162 = p158;
    end;

    p157.itemRoot.Visible = v162;
    local v163;

    if p158 then
        v163 = p157.section == "Shop";
    else
        v163 = p158;
    end;

    p157.root.Visible = v163;

    if p158 and (p157.section == "Shop" and (not open or p157.previousSection ~= "Shop")) then
        p157.questRemote:FireServer("Get");
    end;

    p157.previousSection = p157.section;
    local v164;

    if p158 then
        v164 = p157.section == "Abilities";
    else
        v164 = p158;
    end;

    p157.abilityRoot.Visible = v164;
    p157.canvas.Notice.Visible = p158;

    if p158 and not open then
        p157.prices = {};
        p157:fetchPrices();
    end;

    local v165;

    if p158 then
        v165 = p157.section == "Emotes";
    else
        v165 = p158;
    end;

    p157.emotes:setOpen(v165);
    local v166;

    if p158 then
        v166 = p157.section == "Shop";
    else
        v166 = p158;
    end;

    p157.daily:setShown(v166);

    if not p158 then
        for _, v in p157.previews do
            v.dragging = false;
        end;

        p157.canvas.ScrollHint.Visible = false;
    end;

    p157:syncEventCard();

    if open and not p158 then
        EventKnivesOffer.close();
    end;
end;

function u2.focus(p167, p168) -- Line: 898
    local v169 = (p167.sections[p168] or 0) * (p167.root.AbsoluteSize.X / (p167.layoutWidth or p167.root.AbsoluteSize.X));
    local root = p167.root;
    local Vector2_new = Vector2.new;
    local math_max_ret = math.max(0, p167.root.AbsoluteCanvasSize.Y - p167.root.AbsoluteWindowSize.Y);
    root.CanvasPosition = Vector2_new(0, (math.clamp(v169, 0, math_max_ret)));
end;

function u2.layout(u170, u171, u172) -- Line: 904
    -- upvalues: ShopConfig (copy), GiftClient (copy), EventKnivesOffer (copy), u5 (copy)
    u170.layoutWidth = u171;
    u170.layoutPortrait = u172;
    local root = u170.root;
    root.Coins.Description.Text = "Stock up on supplies. Larger bundles give more coins per Robux.";
    root.Gems.Description.Text = "Buy supplies and gem items. Larger bundles give more gems per Robux.";
    local v173 = ShopConfig.promotionActive(os.time());
    root.Promotion.Visible = v173;
    root.Promotion.Text = ShopConfig.Promotion.Text;
    local Promotion = root.Promotion;
    Promotion.Position = UDim2.fromOffset(0, 0);
    Promotion.Size = UDim2.fromOffset(u171, 28);
    local u174 = v173 and 38 or 0;

    local function u183(p175) -- Line: 916
        -- upvalues: u174 (ref), u171 (copy), u172 (copy), GiftClient (ref)
        p175.Position = UDim2.fromOffset(1, u174);
        p175.Size = UDim2.fromOffset(u171 - 9, u172 and 578 or 338);
        local v176 = u171 - 9;
        local v177 = u172 and 24 or math.floor(v176 * 0.51);
        local v178 = u172 and v176 - 48 or v176 - v177 - 28;
        local Index = p175.Index;
        Index.Position = UDim2.fromOffset(24, 19);
        Index.Size = UDim2.fromOffset(230, 22);
        local Timer = p175.Timer;
        Timer.Position = UDim2.fromOffset(v176 - 244, 19);
        Timer.Size = UDim2.fromOffset(220, 22);
        local Pitch = p175.Pitch;
        Pitch.Position = UDim2.fromOffset(24, 55);
        Pitch.Size = UDim2.fromOffset(u172 and v176 - 48 or v177 - 52, u172 and 180 or 225);
        local Weapon = p175.Weapon;
        Weapon.Position = UDim2.fromOffset(10, 35);
        Weapon.Size = UDim2.fromOffset(u172 and v176 - 20 or v177 - 15, u172 and 190 or 256);
        local Loading = p175.Loading;
        Loading.Position = UDim2.fromOffset(24, u172 and 132 or 151);
        Loading.Size = UDim2.fromOffset(u172 and v176 - 48 or v177 - 52, 30);
        local v179 = u172 and 240 or 27;
        local Eyebrow = p175.Eyebrow;
        Eyebrow.Position = UDim2.fromOffset(v177, v179);
        Eyebrow.Size = UDim2.fromOffset(v178, 20);
        local Title = p175.Title;
        Title.Position = UDim2.fromOffset(v177, v179 + 27);
        Title.Size = UDim2.fromOffset(v178, 58);
        p175.Title.TextSize = p175:GetAttribute("TitleTextSize") or (u172 and 40 or 46);
        local Tagline = p175.Tagline;
        Tagline.Position = UDim2.fromOffset(v177, v179 + 86);
        Tagline.Size = UDim2.fromOffset(v178, 29);
        local Description = p175.Description;
        Description.Position = UDim2.fromOffset(v177, v179 + 126);
        Description.Size = UDim2.fromOffset(v178, 50);
        GiftClient.box(p175.Buy, v177, v179 + 181, v178, 47);
        local Footnote = p175.Footnote;
        Footnote.Position = UDim2.fromOffset(v177, v179 + 236);
        Footnote.Size = UDim2.fromOffset(v178, 34);
        local Sounds = p175.Sounds;
        Sounds.Position = UDim2.fromOffset(24, u172 and 530 or 290);
        Sounds.Size = UDim2.fromOffset(u172 and v176 - 48 or v177 - 52, 34);
        p175.Hint.Visible = false;
        p175.Sounds.Label.Visible = not u172;
        local v180 = u172 and 0 or 100;
        local v181 = ((u172 and v176 - 48 or v177 - 52) - v180 - 12) / 3;
        local Label = p175.Sounds.Label;
        Label.Position = UDim2.fromOffset(0, 0);
        Label.Size = UDim2.fromOffset(96, 34);

        for i, v in { "Equip", "Swing", "Hit" } do
            local v182 = p175.Sounds[v];
            v182.Position = UDim2.fromOffset(v180 + (i - 1) * (v181 + 6), 0);
            v182.Size = UDim2.fromOffset(v181, 34);
            p175.Sounds[v].TextSize = 14;
        end;

        u174 = u174 + (p175.Size.Y.Offset + 30);
    end;

    u170.sections.Gear = u174;

    if u170.gear then
        u170.abilityRoot.Position = u170.root.Position;
        u170.abilityRoot.Size = u170.root.Size;
        u170.abilityRoot.CanvasSize = UDim2.fromOffset(0, u170.gear:layout(u171, u172, 0) + 20);
    end;

    u170.itemRoot.Position = u170.root.Position;
    u170.itemRoot.Size = u170.root.Size;
    u170.itemRoot.CanvasSize = UDim2.fromOffset(0, u170.items:layout(u171, u172, 0) + 20);
    u170.emotes:layout(u170.root.Position, u170.root.Size, u171, u170.canvas.Size.Y.Offset * u170.root.Size.Y.Scale + u170.root.Size.Y.Offset, u172);
    u170.sections.Featured = u174;

    local function stack(p184) -- Line: 966
        -- upvalues: u174 (ref), u170 (copy), u183 (copy), root (copy)
        local v185 = u174;
        u170.sections[p184] = v185;
        u183(root[p184]);

        if not root[p184].Visible then
            u174 = v185;
        end;
    end;

    if u170.ghostFirst then
        local v186 = u174;
        u170.sections.GhostFeatured = v186;
        u183(root.GhostFeatured);

        if not root.GhostFeatured.Visible then
            u174 = v186;
        end;
    end;

    if root.EventKnives.Visible then
        local v187 = EventKnivesOffer.height(u171 - 9, u172);
        local EventKnives = root.EventKnives;
        EventKnives.Position = UDim2.fromOffset(1, u174);
        EventKnives.Size = UDim2.fromOffset(u171 - 9, v187);
        u170.sections.EventKnives = u174;
        u174 = u174 + (v187 + 30);
    end;

    for _, v in u5 do
        if not u170.ghostFirst or v ~= "GhostFeatured" then
            local v188 = u174;
            u170.sections[v] = v188;
            u183(root[v]);

            if not root[v].Visible then
                u174 = v188;
            end;
        end;
    end;

    local v189 = false;

    for _, v in u170.bundleCards do
        v189 = v189 or v.card.Visible;
    end;

    root.LimitedHeading.Visible = v189;

    if v189 then
        u170.sections.Limited = u174;
        local LimitedHeading = root.LimitedHeading;
        LimitedHeading.Position = UDim2.fromOffset(0, u174);
        LimitedHeading.Size = UDim2.fromOffset(u171, 32);
        root.LimitedHeading.TextSize = u172 and 23 or 27;
        u174 = u174 + 44;

        for _, v in u170.bundleCards do
            if v.card.Visible then
                u183(v.card);
            end;
        end;
    end;

    u170.sections.Emotes = u174;
    u174 = u170.daily:layout(u171, u172, u174);
    local QuestProgress = root.QuestProgress;

    if QuestProgress.Visible then
        QuestProgress.Position = UDim2.fromOffset(1, u174);
        QuestProgress.Size = UDim2.fromOffset(u171 - 9, u172 and 184 or 112);
        local v190 = u171 - 9;
        local Heading = QuestProgress.Heading;
        Heading.Position = UDim2.fromOffset(18, 10);
        Heading.Size = UDim2.fromOffset(u172 and v190 - 36 or v190 - 206, 20);
        local KnifeName = QuestProgress.KnifeName;
        KnifeName.Position = UDim2.fromOffset(18, 32);
        KnifeName.Size = UDim2.fromOffset(u172 and v190 - 36 or v190 - 206, 27);
        local Status = QuestProgress.Status;
        Status.Position = UDim2.fromOffset(18, u172 and 69 or 66);
        Status.Size = UDim2.fromOffset(u172 and v190 - 36 or v190 - 206, 20);
        local Track = QuestProgress.Track;
        Track.Position = UDim2.fromOffset(18, u172 and 99 or 93);
        Track.Size = UDim2.fromOffset(u172 and v190 - 36 or v190 - 206, 8);
        local OpenQuests = QuestProgress.OpenQuests;
        OpenQuests.Position = UDim2.fromOffset(u172 and 18 or v190 - 179, u172 and 125 or 34);
        OpenQuests.Size = UDim2.fromOffset(u172 and v190 - 36 or 160, u172 and 43 or 44);
        u174 = u174 + (QuestProgress.Size.Y.Offset + 20);
    end;

    for _, v in ShopConfig.AdditionalKnives or {} do
        local v191 = root:FindFirstChild(v.SkinId);

        if v191 and v191.Visible then
            u170.sections[v.SkinId] = u174;
            u183(v191);
        end;
    end;

    u170.sections.Earnable = u174;

    for _, v in { "BalloonDagger", "TopWinsDagger" } do
        if root:FindFirstChild(v) then
            u170.sections[v] = u174;
            u183(root[v]);
        end;
    end;

    local PerksHeading = root.PerksHeading;
    PerksHeading.Position = UDim2.fromOffset(0, u174);
    PerksHeading.Size = UDim2.fromOffset(u171, 24);
    u174 = u174 + 36;
    u170.sections.VIP = u174;
    local v192 = u172 and 277 or 260;
    local Perks = root.Perks;
    Perks.Position = UDim2.fromOffset(0, u174);
    Perks.Size = UDim2.fromOffset(u171 - 8, v192);
    local v193 = (u171 - 8 - 16) / 2;

    for i, v in { "DoubleXP", "VIP" } do
        local v194 = root.Perks[v];
        v194.Position = UDim2.fromOffset((i - 1) * (v193 + 16), 0);
        v194.Size = UDim2.fromOffset(v193, v192);
        local Index = v194.Index;
        Index.Position = UDim2.fromOffset(20, 17);
        Index.Size = UDim2.fromOffset(v193 - 40, 19);
        v194.Index.TextSize = u172 and 10 or 12;
        local Title = v194.Title;
        Title.Position = UDim2.fromOffset(20, 45);
        Title.Size = UDim2.fromOffset(v193 - 40, 53);
        local Description = v194.Description;
        Description.Position = UDim2.fromOffset(20, 105);
        Description.Size = UDim2.fromOffset(v193 - 40, u172 and 88 or 76);
        v194.Description.TextSize = u172 and 16 or 17;
        GiftClient.box(v194.Buy, 20, v192 - 65, v193 - 40, 44);
    end;

    u174 = u174 + (v192 + 10);
    local Stacking = root.Stacking;
    Stacking.Position = UDim2.fromOffset(4, u174);
    Stacking.Size = UDim2.fromOffset(u171 - 16, u172 and 42 or 26);
    u174 = u174 + (u172 and 69 or 56);

    for _, v in { "Coins", "Gems" } do
        local v195 = root[v];
        local v196 = u172 and 2 or 3;
        local v197 = 6 / v196;
        local v198 = u172 and 175 or 180;
        local v199 = u171 - 8;
        local v200 = (v199 - 16 * (v196 - 1)) / v196;
        local v201 = u172 and 88 or 70;
        local v202 = v201 + v197 * v198 + (v197 - 1) * 16;
        v195.Position = UDim2.fromOffset(0, u174);
        v195.Size = UDim2.fromOffset(v199, v202);
        local Heading = v195.Heading;
        Heading.Position = UDim2.fromOffset(0, 0);
        Heading.Size = UDim2.fromOffset(v199, 32);
        local Description = v195.Description;
        Description.Position = UDim2.fromOffset(0, 38);
        Description.Size = UDim2.fromOffset(v199, u172 and 43 or 26);
        local Packs = v195.Packs;
        Packs.Position = UDim2.fromOffset(0, v201);
        Packs.Size = UDim2.fromOffset(v199, v202 - v201);

        for i = 1, 6 do
            local v203 = v195.Packs["Pack" .. i];
            local v204 = math.floor((i - 1) / v196) * (v198 + 16);
            v203.Position = UDim2.fromOffset((i - 1) % v196 * (v200 + 16), v204);
            v203.Size = UDim2.fromOffset(v200, v198);
            local Art = v203.Art;
            Art.Position = UDim2.fromOffset(0, 9);
            Art.Size = UDim2.fromOffset(v200, 43);
            local Amount = v203.Amount;
            Amount.Position = UDim2.fromOffset(0, 54);
            Amount.Size = UDim2.fromOffset(v200, 39);
            local Caption = v203.Caption;
            Caption.Position = UDim2.fromOffset(8, 97);
            Caption.Size = UDim2.fromOffset(v200 - 16, 18);
            GiftClient.box(v203.Buy, 16, v198 - 53, v200 - 32, 38);
            v203.Buy.TextSize = 18;
            local _ = i;
        end;

        u174 = u174 + (v202 + 38);
    end;

    local Footer = root.Footer;
    Footer.Position = UDim2.fromOffset(0, u174);
    Footer.Size = UDim2.fromOffset(u171, 32);
    root.CanvasSize = UDim2.fromOffset(0, u174 + 40);
end;

function u2.step(p205, p206) -- Line: 1085
    -- upvalues: UserInputService (copy)
    if not p205.open then
        return;
    end;

    if p205.gear then
        p205.gear:step(p206);
    end;

    p205.items:step(p206);

    if p205.section == "Emotes" then
        p205.emotes:step(p206);
    elseif p205.section == "Shop" then
        p205.daily:step(p206);
    end;

    local v207 = p205.section == "Abilities" and p205.abilityRoot or p205.section == "Items" and p205.itemRoot or (p205.section == "Emotes" and p205.emotes.list or p205.root);
    local v208;

    if v207.AbsoluteCanvasSize.Y - v207.AbsoluteWindowSize.Y - v207.CanvasPosition.Y > 12 then
        v208 = p205.canvas.Notice.Text == "";
    else
        v208 = false;
    end;

    p205.canvas.ScrollHint.Visible = v208;
    p205.canvas.ScrollHint.Text = UserInputService.TouchEnabled and "SWIPE UP · MORE IN STORE  ↓" or "SCROLL FOR MORE  ↓";
    p205.timerElapsed = (p205.timerElapsed or 0) + p206;

    if p205.timerElapsed >= 0.2 then
        p205.timerElapsed = 0;
        p205:refresh();
    end;

    if p205.section == "Shop" then
        for i, v in p205.pendingPreviews do
            if v.card.Visible then
                table.remove(p205.pendingPreviews, i);
                v.build();
                v.build = nil;
                break;
            end;
        end;
    end;

    for _, v in p205.previews do
        if v.camera then
            if not v.dragging then
                v.rotation = v.rotation + math.min(p206, 0.1) * 0.15;
            end;

            local v209 = v.extent * 2;
            local camera = v.camera;
            local CFrame_lookAt = CFrame.lookAt;
            local v210 = math.sin(v.rotation) * v209;
            local v211 = 0.1 * v.extent;
            local v212 = math.cos(v.rotation) * v209;
            camera.CFrame = CFrame_lookAt(Vector3.new(v210, v211, v212), Vector3.new(0, 0, 0));
        end;
    end;

    if p205.noticeUntil and os.clock() > p205.noticeUntil then
        p205.canvas.Notice.Text = "";
        p205.noticeUntil = nil;
    end;
end;

function u2.destroy(p213) -- Line: 1138
    -- upvalues: EventKnivesOffer (copy)
    p213.destroyed = true;

    if p213.eventCard then
        p213.eventCard:destroy();
        p213.eventCard = nil;
    end;

    EventKnivesOffer.close();

    if p213.daily then
        p213.daily:destroy();
    end;

    if p213.emotes then
        p213.emotes:destroy();
    end;

    if p213.items then
        p213.items:destroy();
    end;

    if p213.gear then
        p213.gear:destroy();
    end;

    for _, v in p213.connections do
        v:Disconnect();
    end;
end;

return u2;