 

 

local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local Parent = script.Parent.Parent;
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local Theme = Skin.Theme;
local ValleyToast = require(Parent.Presentation.ValleyToast);
local ShopConfig = require(script.Parent.ShopConfig);
local EmoteStoreClient = require(script.Parent.EmoteStoreClient);
local CurrencyTopUp = require(script.Parent.CurrencyTopUp);
local GiftClient = require(script.Parent.GiftClient);
local EmoteCatalog = require(Parent.Emotes.EmoteCatalog);
local DailyEmotes = require(Parent.Emotes.DailyEmotes);
local CharacterPreview = require(Parent.Interface.CharacterPreview);
local EmoteSound = require(Parent.Interface.EmoteSound);
local LocalPlayer = Players.LocalPlayer;
local Emotes = Parent.Emotes;
local u1 = {};
u1.__index = u1;
local utf8_char_ret = utf8.char(57346);
local u2 = ShopConfig.storeUniverse(game.GameId);
local u3 = {
    Coins = "DailyCoins",
    Gems = "DailyGems",
    Robux = "DailyRobux"
};
local u4 = {
    coins = Color3.fromRGB(81, 67, 39),
    gems = Color3.fromRGB(43, 70, 65)
};
local Color3_fromRGB_ret = Color3.fromRGB(36, 64, 71);

local function comma(p5) -- Line: 34
    local math_floor_ret = math.floor(p5);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local function box(p6, p7, p8, p9, p10) -- Line: 38
    p6.Position = UDim2.fromOffset(p7, p8);
    p6.Size = UDim2.fromOffset(p9, p10);
end;

local function robuxOffer(p11) -- Line: 44
    -- upvalues: u2 (copy)
    local v12;

    if p11 == nil or (type(p11.ProductId) ~= "number" or p11.ProductId <= 0) then
        v12 = false;
    else
        v12 = u2 == (p11.ProductUniverse or 10764627709);
    end;

    return v12;
end;

local function todays(p13) -- Line: 52
    -- upvalues: Emotes (copy), u3 (copy), EmoteCatalog (copy), DailyEmotes (copy)
    if Emotes:GetAttribute("DailyDay") == nil then
        return DailyEmotes.pick(p13, DailyEmotes.day(DailyEmotes.now()));
    end;

    local Attribute = Emotes:GetAttribute(u3[p13]);

    if type(Attribute) ~= "string" or not (EmoteCatalog.get(Attribute) and Attribute) then
        Attribute = nil;
    end;

    return Attribute;
end;

local function countdown() -- Line: 61
    -- upvalues: DailyEmotes (copy)
    local v14 = DailyEmotes.secondsLeft(DailyEmotes.now());
    local v15 = v14 // 3600;
    local v16 = v14 % 3600 // 60;

    return v15 > 0 and string.format("ENDS IN %dh %dm", v15, v16) or string.format("ENDS IN %dm %ds", v16, v14 % 60);
end;

local function button(p17, p18, p19) -- Line: 68
    -- upvalues: Panels (copy)
    local v20 = Panels.button(p17, p18, "", 0, 0, 10, 10, p19);
    v20.TextSize = 18;
    v20.TextScaled = true;
    Panels.make("UITextSizeConstraint", v20, "TextLimit", {
        MaxTextSize = 14
    });
    Panels.make("UIPadding", v20, "Padding", {
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8)
    });

    return v20;
end;

local u21 = setmetatable({}, {
    __mode = "k"
});
local u22 = setmetatable({}, {
    __mode = "k"
});

local function look(p23, p24) -- Line: 81
    -- upvalues: u21 (copy), u22 (copy), Skin (copy)
    local v25 = p24 and (u21[p23] or "secondary") or "secondary";

    if u22[p23] ~= v25 then
        u22[p23] = v25;
        Skin.button(p23, v25);
    end;
end;

local function giftLook(p26, p27) -- Line: 90
    -- upvalues: Skin (copy)
    Skin.button(p26, p27 and "buy-coins" or "secondary");
    p26.BackgroundTransparency = 0;
end;

local function setButton(p28, p29, p30) -- Line: 94
    -- upvalues: EmoteStoreClient (copy), u21 (copy), u22 (copy), Skin (copy)
    if p28.Text ~= p29 then
        p28.Text = p29;
    end;

    EmoteStoreClient.setEnabled(p28, p30);
    local v31 = p30 == true and (u21[p28] or "secondary") or "secondary";

    if u22[p28] ~= v31 then
        u22[p28] = v31;
        Skin.button(p28, v31);
    end;
end;

function u1.new(u32) -- Line: 102
    -- upvalues: Panels (copy), u1 (copy), Theme (copy), countdown (copy), Skin (copy), DailyEmotes (copy), button (copy), u4 (copy), Color3_fromRGB_ret (copy), u21 (copy), u22 (copy), EmoteStoreClient (copy), EmoteSound (copy), EmoteCatalog (copy), CurrencyTopUp (copy), LocalPlayer (copy), GiftClient (copy), ValleyToast (copy), MarketplaceService (copy), giftLook (copy), Emotes (copy)
    local v33 = Panels.make("Frame", u32.root, "DailyEmotes", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    });
    local v34 = {
        shown = false,
        untilTick = 0,
        store = u32,
        frame = v33,
        remote = script.Parent:WaitForChild("ArmoryEvent"),
        items = {},
        connections = {}
    };
    local u35 = setmetatable(v34, u1);

    local function connect(p36, p37) -- Line: 113
        -- upvalues: u35 (copy)
        table.insert(u35.connections, p36:Connect(p37));
    end;

    u35.heading = Panels.text(v33, "Heading", "DAILY EMOTES", 0, 0, 10, 10, 27, Theme.Paper);
    u35.heading.Font = Enum.Font.GothamBold;
    u35.timer = Panels.text(v33, "Timer", countdown(), 0, 0, 10, 10, 13, Theme.Gold);
    u35.timer.Font = Enum.Font.GothamBold;
    u35.timer.TextXAlignment = Enum.TextXAlignment.Right;
    u35.description = Panels.text(v33, "Description", "Three new emotes every day at 00:00 UTC. Every emote loops until you move.", 0, 0, 10, 10, 15, Theme.Muted);
    u35.description.Font = Enum.Font.GothamMedium;
    Skin.textStroke(u35.description, 2);
    u35.cardsFrame = Panels.make("Frame", v33, "Cards", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    });

    for i, v in DailyEmotes.Cards do
        local v38 = Panels.make("Frame", u35.cardsFrame, v, {
            BorderSizePixel = 0,
            Visible = false,
            LayoutOrder = i
        });
        Theme.surface(v38, Theme.Ink, Theme.Muted, 8, 0.5);
        Skin.card(v38, nil);
        local u39 = {
            card = v,
            frame = v38,
            bar = Panels.make("Frame", v38, "Accent", {
                BorderSizePixel = 0,
                BackgroundColor3 = Theme.Muted
            }),
            rarity = Panels.text(v38, "Rarity", "", 0, 0, 10, 10, 11, Theme.Muted),
            viewport = Panels.make("ViewportFrame", v38, "Preview", {
                BackgroundTransparency = 1,
                LightDirection = Vector3.new(-1, -1, -1),
                Ambient = Color3.fromRGB(205, 210, 220),
                LightColor = Color3.new(1, 1, 1)
            }),
            name = Panels.text(v38, "NameLabel", "", 0, 0, 10, 10, 19, Theme.Paper),
            buy = button(v38, "Buy", u4.coins),
            robux = button(v38, "Robux", Color3_fromRGB_ret)
        };
        u39.rarity.Font = Enum.Font.GothamBold;
        Skin.textStroke(u39.rarity, 1.5);
        u39.name.Font = Enum.Font.GothamBold;
        u39.name.TextWrapped = false;
        u39.name.TextTruncate = Enum.TextTruncate.AtEnd;
        local robux = u39.robux;
        u21[u39.buy] = "buy-coins";
        u21[robux] = "buy-robux";
        local buy = u39.buy;
        local v40 = u21[buy] or "secondary";

        if u22[buy] ~= v40 then
            u22[buy] = v40;
            Skin.button(buy, v40);
        end;

        local robux2 = u39.robux;
        local v41 = u21[robux2] or "secondary";

        if u22[robux2] ~= v41 then
            u22[robux2] = v41;
            Skin.button(robux2, v41);
        end;

        u39.soundButton = EmoteStoreClient.soundButton(v38, Theme.Paper);
        u39.sound = EmoteSound.new(u39.soundButton);
        table.insert(u35.connections, u39.buy.Activated:Connect(function() -- Line: 165
            -- upvalues: u35 (copy), u39 (copy), EmoteCatalog (ref), EmoteStoreClient (ref), u32 (copy), CurrencyTopUp (ref)
            if not (u35.shown and u39.id) then
                return;
            end;

            if EmoteCatalog.ComingSoon then
                EmoteStoreClient.comingSoon();

                return;
            end;

            if not u39.buy.Active then
                return;
            end;

            local v42 = u32.state or {};
            local v43;

            if u39.currency == "coins" then
                v43 = v42.coins;
            else
                v43 = v42.gems;
            end;

            local v44 = v43 or 0;

            if v44 < u39.amount then
                CurrencyTopUp.prompt(u39.currency, u39.amount, v44);

                return;
            end;

            u35.remote:FireServer("BuyEmote", u39.id);
            u32:notice("Adding this emote to your collection…");
        end));
        table.insert(u35.connections, u39.robux.Activated:Connect(function() -- Line: 186
            -- upvalues: u35 (copy), u39 (copy), EmoteCatalog (ref), EmoteStoreClient (ref), LocalPlayer (ref), GiftClient (ref), ValleyToast (ref), MarketplaceService (ref)
            if not (u35.shown and u39.entry) then
                return;
            end;

            if EmoteCatalog.ComingSoon then
                EmoteStoreClient.comingSoon();

                return;
            end;

            if not u39.robux.Active or LocalPlayer:GetAttribute("InMatch") == true then
                return;
            end;

            if GiftClient.busy() then
                ValleyToast.show("Finish your gift first.");

                return;
            end;

            if not pcall(MarketplaceService.PromptProductPurchase, MarketplaceService, LocalPlayer, u39.entry.ProductId) then
                ValleyToast.show("The purchase window could not open. Please try again.");
            end;
        end));
        GiftClient.attach(u39.robux, function() -- Line: 206
            -- upvalues: u39 (copy)
            return u39.id and "Emote:" .. u39.id or nil;
        end, giftLook);
        table.insert(u35.items, u39);
    end;

    u35:assign();
    table.insert(u35.connections, Emotes.AttributeChanged:Connect(function(p45) -- Line: 213
        -- upvalues: u35 (copy), u32 (copy)
        if string.sub(p45, 1, 5) == "Daily" and u35:assign() then
            if u32.layoutWidth then
                u32:layout(u32.layoutWidth, u32.layoutPortrait);
            end;

            u35:refresh();
        end;
    end));

    return u35;
end;

function u1.assign(p46) -- Line: 225
    -- upvalues: todays (copy), EmoteCatalog (copy), EmoteStoreClient (copy), Theme (copy), Skin (copy), u21 (copy), u2 (copy), GiftClient (copy), CharacterPreview (copy)
    local v47 = false;
    local v48 = false;

    for _, v in p46.items do
        local v49 = todays(v.card);

        if v49 ~= v.id then
            v48 = true;
            v.id = v49;
            local v50;

            if v49 then
                v50 = EmoteCatalog.get(v49) or nil;
            else
                v50 = nil;
            end;

            v.entry = v50;
            v.sound:set(v49);
            v.currency = nil;
            v.amount = nil;
            v.priceInfo = nil;
            v.priceText = nil;

            if v49 then
                local v51, v52 = EmoteCatalog.price(v49);
                v.currency = v51;
                v.amount = v52;
                local v53 = EmoteCatalog.rarity(v49);
                local v54 = EmoteStoreClient.RARITY[v53 or ""] or Theme.Purple;
                v.name.Text = v.entry.Name;
                v.rarity.Text = string.upper(v53 or "");
                v.rarity.TextColor3 = v54;
                v.bar.BackgroundColor3 = v54;
                Skin.card(v.frame, v54, {
                    glow = true
                });
            end;

            local v55;

            if v.currency then
                local math_floor_ret = math.floor(v.amount);
                v55 = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") or nil;
            else
                v55 = nil;
            end;

            v.amountText = v55;
            u21[v.buy] = v.currency == "gems" and "buy-gems" or "buy-coins";
            v.buy.Visible = v.currency ~= nil;
            local robux = v.robux;
            local entry = v.entry;
            local v56;

            if entry == nil or (type(entry.ProductId) ~= "number" or entry.ProductId <= 0) then
                v56 = false;
            else
                v56 = u2 == (entry.ProductUniverse or 10764627709);
            end;

            robux.Visible = v56;
            GiftClient.sync(v.robux, v.robux.Visible and not EmoteCatalog.ComingSoon, false);
            local v57;

            if v49 == nil then
                v57 = false;
            else
                v57 = v.buy.Visible or v.robux.Visible;
            end;

            v.frame.Visible = v57;

            if v.preview then
                v.preview:destroy();
                v.preview = nil;
            end;

            if p46.shown and v.frame.Visible then
                v.preview = CharacterPreview.new(v.viewport);
                v.preview:play(v49);
            end;
        end;

        v47 = v47 or v.frame.Visible;
    end;

    p46.frame.Visible = v47;

    return v48;
end;

function u1.robuxText(p58, p59) -- Line: 270
    -- upvalues: utf8_char_ret (copy)
    local v60 = p58.store:productPrice(p59.entry.ProductId);

    if v60 == false then
        return "PRICE UNAVAILABLE", false;
    end;

    if type(v60) ~= "table" then
        return "CHECKING PRICE…", false;
    end;

    if not v60.IsForSale then
        return "NOT ON SALE", false;
    end;

    local PriceInRobux = v60.PriceInRobux;

    if type(PriceInRobux) ~= "number" or (PriceInRobux ~= PriceInRobux or PriceInRobux < 0) then
        return "PRICE UNAVAILABLE", false;
    end;

    if p59.priceInfo ~= v60 then
        p59.priceInfo = v60;
        local math_floor_ret = math.floor(PriceInRobux);
        p59.priceText = utf8_char_ret .. " " .. tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    end;

    return p59.priceText, true;
end;

function u1.refresh(p61) -- Line: 290
    -- upvalues: EmoteCatalog (copy), LocalPlayer (copy), EmoteStoreClient (copy), u21 (copy), u22 (copy), Skin (copy), GiftClient (copy)
    local v62 = p61.store.state or {};
    local v63 = v62.emotes or {};
    local v64 = v62.loaded == true;
    local ComingSoon = EmoteCatalog.ComingSoon;
    local v65 = p61.shown and (v64 and not (v62.pending or ComingSoon)) and LocalPlayer:GetAttribute("InMatch") ~= true;

    for _, v in p61.items do
        if v.frame.Visible then
            local v66 = v63[v.id] == true;

            if v.currency then
                local v67 = ComingSoon and "SOON" or (v66 and "OWNED" or (not v64 and "…" or v.amountText));
                local v68;

                if v65 then
                    v68 = not v66;
                else
                    v68 = v65;
                end;

                local buy = v.buy;

                if buy.Text ~= v67 then
                    buy.Text = v67;
                end;

                EmoteStoreClient.setEnabled(buy, v68);
                local v69 = v68 == true and (u21[buy] or "secondary") or "secondary";

                if u22[buy] ~= v69 then
                    u22[buy] = v69;
                    Skin.button(buy, v69);
                end;

                local v70;

                if v67 == v.amountText then
                    v70 = v.currency or nil;
                else
                    v70 = nil;
                end;

                Skin.price(v.buy, v70, {
                    dim = not v68
                });
            end;

            if v.robux.Visible then
                local v71 = "OWNED";
                local v72 = false;

                if ComingSoon then
                    v71 = "SOON";
                elseif not v66 then
                    if p61.shown then
                        v71, v72 = p61:robuxText(v);
                    else
                        v71 = v.robux.Text;
                    end;
                end;

                local robux = v.robux;

                if v65 then
                    local v73 = not v66;

                    if not v73 then
                        v72 = v73;
                    end;
                else
                    v72 = v65;
                end;

                if robux.Text ~= v71 then
                    robux.Text = v71;
                end;

                EmoteStoreClient.setEnabled(robux, v72);
                local v74 = v72 == true and (u21[robux] or "secondary") or "secondary";

                if u22[robux] ~= v74 then
                    u22[robux] = v74;
                    Skin.button(robux, v74);
                end;

                local v75 = p61.shown and p61.store:productPrice(v.entry.ProductId);
                local sync = GiftClient.sync;
                local robux2 = v.robux;
                local v76 = not ComingSoon;

                if v76 then
                    local v77;

                    if type(v75) == "table" then
                        v77 = v75.IsForSale ~= true;
                    else
                        v77 = false;
                    end;

                    v76 = not v77;
                end;

                sync(robux2, v76, v65);
            end;

            if ComingSoon then
                v.buy.Active = true;
                v.robux.Active = true;
            end;
        end;
    end;
end;

function u1.setShown(p78, p79) -- Line: 332
    -- upvalues: CharacterPreview (copy)
    local v80 = p79 == true;

    if v80 == p78.shown then
        return;
    end;

    p78.shown = v80;

    if v80 then
        p78.untilTick = 0;

        for _, v in p78.items do
            if v.frame.Visible and not v.preview then
                v.preview = CharacterPreview.new(v.viewport);
                v.preview:play(v.id);
            end;
        end;
    else
        for _, v in p78.items do
            v.sound:stop();

            if v.preview then
                v.preview:destroy();
                v.preview = nil;
            end;
        end;
    end;

    p78:refresh();
end;

function u1.layout(p81, p82, p83, p84) -- Line: 358
    -- upvalues: GiftClient (copy)
    if not p81.frame.Visible then
        return p84;
    end;

    local v85 = p82 - 8;
    local v86 = p83 and 92 or 70;
    local v87 = p83 and 330 or 312;
    local frame = p81.frame;
    frame.Position = UDim2.fromOffset(0, p84);
    frame.Size = UDim2.fromOffset(v85, v86 + v87);
    local heading = p81.heading;
    heading.Position = UDim2.fromOffset(0, 0);
    heading.Size = UDim2.fromOffset(p83 and v85 and v85 or v85 - 280, 32);
    p81.heading.TextSize = p83 and 23 or 27;
    local timer = p81.timer;
    timer.Position = UDim2.fromOffset(p83 and 0 or v85 - 270, p83 and 34 or 6);
    timer.Size = UDim2.fromOffset(p83 and v85 and v85 or 270, 20);
    p81.timer.TextXAlignment = p83 and Enum.TextXAlignment.Left or Enum.TextXAlignment.Right;
    local description = p81.description;
    description.Position = UDim2.fromOffset(0, p83 and 56 or 38);
    description.Size = UDim2.fromOffset(v85, p83 and 34 or 24);
    p81.description.TextSize = p83 and 13 or 15;
    local cardsFrame = p81.cardsFrame;
    cardsFrame.Position = UDim2.fromOffset(0, v86);
    cardsFrame.Size = UDim2.fromOffset(v85, v87);
    local v88 = (v85 - 28) / 3;
    local v89 = p83 and 78 or 40;
    local v90 = v87 - 44 - 6 - 26 - 10 - v89 - 14;
    local v91 = 0;

    for _, v in p81.items do
        if v.frame.Visible then
            local frame2 = v.frame;
            frame2.Position = UDim2.fromOffset(v91 * (v88 + 14), 0);
            frame2.Size = UDim2.fromOffset(v88, v87);
            v91 = v91 + 1;
            local bar = v.bar;
            bar.Position = UDim2.fromOffset(16, 14);
            bar.Size = UDim2.fromOffset(v88 - 32, 2);
            local rarity = v.rarity;
            rarity.Position = UDim2.fromOffset(16, 22);
            rarity.Size = UDim2.fromOffset(v88 - 32, 16);
            local viewport = v.viewport;
            viewport.Position = UDim2.fromOffset(10, 44);
            viewport.Size = UDim2.fromOffset(v88 - 20, v90);
            local soundButton = v.soundButton;
            soundButton.Position = UDim2.fromOffset(v88 - 16 - 36, 50);
            soundButton.Size = UDim2.fromOffset(36, 36);
            local v92 = 44 + v90 + 6;
            local name = v.name;
            name.Position = UDim2.fromOffset(16, v92);
            name.Size = UDim2.fromOffset(v88 - 32, 26);
            v.name.TextSize = p83 and 16 or 19;
            local v93 = v92 + 36;
            local v94 = v.buy.Visible and v.robux.Visible;
            local v95 = v88 - 32;

            if v94 and not p83 then
                local v96 = (v95 - 8) / 2;
                local buy = v.buy;
                buy.Position = UDim2.fromOffset(16, v93);
                buy.Size = UDim2.fromOffset(v96, 40);
                GiftClient.box(v.robux, 16 + v96 + 8, v93, v96, 40);
            elseif v94 then
                local buy = v.buy;
                buy.Position = UDim2.fromOffset(16, v93);
                buy.Size = UDim2.fromOffset(v95, 36);
                GiftClient.box(v.robux, 16, v93 + 42, v95, 36);
            else
                local v97 = p83 and 36 or 40;
                GiftClient.box(v.buy.Visible and v.buy or v.robux, 16, v93 + v89 - v97, v95, v97);
            end;
        end;
    end;

    return p84 + v86 + v87 + 30;
end;

function u1.step(p98, p99) -- Line: 410
    -- upvalues: LocalPlayer (copy), countdown (copy)
    if not p98.shown then
        return;
    end;

    local Character = LocalPlayer.Character;
    local Attribute = LocalPlayer:GetAttribute("EquippedKnife");

    for _, v in p98.items do
        local preview = v.preview;

        if preview then
            if preview.model then
                if preview.source ~= Character or preview.knife ~= Attribute then
                    preview:play(v.id);
                end;
            elseif v.id and os.clock() >= (v.retryAt or 0) then
                v.retryAt = os.clock() + 1;
                preview:play(v.id);
            end;

            preview:step(p99);
        end;
    end;

    p98.untilTick = p98.untilTick - p99;

    if p98.untilTick <= 0 then
        p98.untilTick = 1;
        p98.timer.Text = countdown();
    end;
end;

function u1.destroy(p100) -- Line: 439
    p100.shown = false;

    for _, v in p100.connections do
        v:Disconnect();
    end;

    table.clear(p100.connections);

    for _, v in p100.items do
        v.sound:destroy();

        if v.preview then
            v.preview:destroy();
            v.preview = nil;
        end;
    end;

    p100.frame:Destroy();
end;

return u1;