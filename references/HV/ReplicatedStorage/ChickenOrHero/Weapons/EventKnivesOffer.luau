 

 

local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local GamepadService = game:GetService("GamepadService");
local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local Interface = Parent.Interface;
local ShopConfig = require(script_Parent.ShopConfig);
local OfferRules = require(script_Parent.OfferRules);
local SkinCatalog = require(script_Parent.SkinCatalog);
local KnifeAbilities = require(script_Parent.KnifeAbilities);
local GiftClient = require(script_Parent.GiftClient);
local EmoteCatalog = require(Parent.Emotes.EmoteCatalog);
local Preview = require(Interface.Shop.Preview);
local EmotePose = require(Interface.EmotePose);
local Cursor = require(Interface.Cursor);
local LocalPlayer = Players.LocalPlayer;
local ArmoryEvent = script_Parent:WaitForChild("ArmoryEvent");
local u1 = ShopConfig.binding(game.GameId);
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy);
local utf8_char_ret = utf8.char(57346);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local Color3_fromRGB_ret = Color3.fromRGB(23, 23, 25);
local Color3_fromRGB_ret2 = Color3.fromRGB(12, 12, 14);
local Color3_fromRGB_ret3 = Color3.fromRGB(76, 76, 81);
local Color3_fromRGB_ret4 = Color3.fromRGB(222, 222, 228);
local Color3_fromRGB_ret5 = Color3.fromRGB(170, 170, 178);
local Color3_fromRGB_ret6 = Color3.fromRGB(255, 202, 58);
local Color3_fromRGB_ret7 = Color3.fromRGB(230, 161, 0);
local Color3_fromRGB_ret8 = Color3.fromRGB(80, 255, 100);
local Color3_fromRGB_ret9 = Color3.fromRGB(17, 213, 40);
local Color3_fromRGB_ret10 = Color3.fromRGB(125, 125, 125);
local Color3_fromRGB_ret11 = Color3.fromRGB(80, 80, 80);
local Color3_fromRGB_ret12 = Color3.fromRGB(96, 222, 128);
local Color3_fromRGB_ret13 = Color3.fromRGB(253, 60, 85);
local Vector2_new_ret = Vector2.new(0.5, 0.5);
local Vector2_new_ret2 = Vector2.new(960, 500);
local Vector2_new_ret3 = Vector2.new(480, 1048);
local Vector2_new_ret4 = Vector2.new(456, 392);
local Vector2_new_ret5 = Vector2.new(1040, 640);
local u2 = Enum.ContextActionPriority.High.Value + 200;
local NumberSequence_new_ret = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.4, 1),
    NumberSequenceKeypoint.new(0.5, 0.7),
    NumberSequenceKeypoint.new(0.6, 1),
    NumberSequenceKeypoint.new(1, 1)
});
local u3 = {
    {
        name = "FOOTBALL",
        icon = "🏈",
        power = "💥",
        offer = ShopConfig.FootballFlagship,
        color = Color3.fromRGB(196, 46, 52)
    },
    {
        name = "FÚTBOL",
        icon = "⚽",
        power = "⚡",
        offer = ShopConfig.FutbolFlagship,
        color = Color3.fromRGB(44, 92, 196)
    }
};
local u4 = {};
local u5 = {};

for _, v in u3 do
    v.key = v.offer.OfferKey;
    v.skin = v.offer.SkinId;
    v.light = v.color:Lerp(Color3_new_ret, 0.55);
    v.deep = v.color:Lerp(Color3_new_ret2, 0.5);
    u4[v.skin] = v;
end;

local color = u3[1].color;
local color2 = u3[2].color;
local u6 = {
    StartsAt = 0,
    EndsAt = 0
};

for _, v in u3 do
    u6.StartsAt = math.max(u6.StartsAt, v.offer.StartsAt or 0);
    local v7 = v.offer.EndsAt or 0;

    if v7 > 0 and (u6.EndsAt == 0 or v7 < u6.EndsAt) then
        u6.EndsAt = v7;
    end;
end;

local u8 = nil;
local u9 = {};
local u10 = nil;
local u11 = {};
local u12 = nil;
local u13 = nil;
local u14 = false;
local u15 = (-1 / 0);
local u16 = (-1 / 0);

local function comma(p17) -- Line: 128
    local math_floor_ret = math.floor(p17);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local function hex(p18) -- Line: 132
    return string.format("#%02X%02X%02X", math.round(p18.R * 255), math.round(p18.G * 255), (math.round(p18.B * 255)));
end;

local function trouble(p19, p20) -- Line: 137
    -- upvalues: u16 (ref)
    if os.clock() - u16 >= 30 then
        u16 = os.clock();
        warn("[EventKnivesOffer] " .. p19 .. ": " .. tostring(p20));
    end;
end;

local function sound(p21) -- Line: 144
    -- upvalues: SoundService (copy)
    local GameAudio = SoundService:FindFirstChild("GameAudio");

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("04_UI");
    end;

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild(p21);
    end;

    if GameAudio and GameAudio:IsA("Sound") then
        require(game:GetService("ReplicatedFirst"):WaitForChild("LazySound")).playLocal(GameAudio);
    end;
end;

local function repaintAll() -- Line: 154
    -- upvalues: u9 (copy)
    for i in u9 do
        i:paint();
    end;
end;

local function watch(p22) -- Line: 160
    -- upvalues: u9 (copy), u10 (ref), ArmoryEvent (copy), u8 (ref)
    u9[p22] = true;

    if not u10 then
        u10 = ArmoryEvent.OnClientEvent:Connect(function(p23, p24) -- Line: 163
            -- upvalues: u8 (ref), u9 (ref)
            if p23 == "State" and type(p24) == "table" then
                u8 = p24;

                for i in u9 do
                    i:paint();
                end;
            end;
        end);
    end;
end;

local function unwatch(p25) -- Line: 172
    -- upvalues: u9 (copy), u10 (ref), u8 (ref), u11 (copy)
    u9[p25] = nil;

    if u10 and next(u9) == nil then
        u10:Disconnect();
        u10 = nil;
        u8 = nil;
        table.clear(u11);
    end;
end;

local function ability(p26) -- Line: 183
    -- upvalues: SkinCatalog (copy), KnifeAbilities (copy)
    local v27 = SkinCatalog.get(p26.skin);
    local v28 = v27 and string.match(v27.Description or "", "^[^%.!]*[%.!]") or "";
    local string_gsub_ret = string.gsub(v28, "^[^:]*:%s*", "");

    return KnifeAbilities.forSkin(p26.skin), string.gsub(string_gsub_ret, "^%l", string.upper);
end;

local function emoteOf(p29) -- Line: 191
    -- upvalues: EmoteCatalog (copy)
    for _, v in EmoteCatalog.bundle(p29.skin) do
        if v.Knife == p29.skin then
            return v;
        end;
    end;

    return nil;
end;

local function passId(p30) -- Line: 202
    -- upvalues: u1 (copy)
    local v31 = u1.PassIds[p30.key];

    return type(v31) ~= "number" and 0 or v31;
end;

local function ready(p32) -- Line: 208
    -- upvalues: SkinCatalog (copy), u1 (copy)
    local v33 = SkinCatalog.get(p32.skin);
    local v34 = u1.PassIds[p32.key];
    local v35;

    if (type(v34) ~= "number" and 0 or v34) > 0 and v33 ~= nil then
        v35 = v33.EquipReady ~= false;
    else
        v35 = false;
    end;

    return v35;
end;

local function free() -- Line: 214
    -- upvalues: u8 (ref), LocalPlayer (copy)
    local v36;

    if u8 == nil or (u8.loaded ~= true or u8.pending == true) then
        v36 = false;
    else
        v36 = LocalPlayer:GetAttribute("InMatch") ~= true;
    end;

    return v36;
end;

local function ownedShared(p37) -- Line: 221
    -- upvalues: u8 (ref)
    local v38;

    if u8 == nil or type(u8.owned) ~= "table" then
        v38 = false;
    else
        v38 = u8.owned[p37] == true;
    end;

    return v38;
end;

local function price(u39) -- Line: 225
    -- upvalues: u11 (copy), MarketplaceService (copy), u16 (ref), u9 (copy)
    local v40 = u11[u39];

    if v40 ~= nil then
        return v40;
    end;

    u11[u39] = "loading";
    task.spawn(function() -- Line: 231
        -- upvalues: MarketplaceService (ref), u39 (copy), u16 (ref), u11 (ref), u9 (ref)
        local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, u39, Enum.InfoType.GamePass);

        if not success and os.clock() - u16 >= 30 then
            u16 = os.clock();
            warn("[EventKnivesOffer] " .. "price unavailable" .. ": " .. tostring(result));
        end;

        if u11[u39] == "loading" then
            if not (success and (type(result) == "table" and result)) then
                result = false;
            end;

            u11[u39] = result;

            for i in u9 do
                i:paint();
            end;
        end;
    end);

    return u11[u39];
end;

local function statusShared(p41, p42, p43) -- Line: 246
    -- upvalues: OfferRules (copy), SkinCatalog (copy), u1 (copy), u11 (copy), MarketplaceService (copy), u16 (ref), u9 (copy), utf8_char_ret (copy), u8 (ref), LocalPlayer (copy)
    if p41.hooks.owned(p42.skin) then
        return "OWNED  ✓", false;
    end;

    local v44 = OfferRules.status(p42.offer, p43);

    if v44 ~= "Active" then
        return v44 == "Expired" and "OFFER ENDED" or "NOT AVAILABLE YET", false;
    end;

    local v45 = SkinCatalog.get(p42.skin);
    local v46 = u1.PassIds[p42.key];
    local v47;

    if (type(v46) ~= "number" and 0 or v46) > 0 and v45 ~= nil then
        v47 = v45.EquipReady ~= false;
    else
        v47 = false;
    end;

    if not v47 then
        return "COMING SOON", false;
    end;

    local v48 = u1.PassIds[p42.key];
    local u49 = type(v48) ~= "number" and 0 or v48;
    local v50 = u11[u49];

    if v50 == nil then
        u11[u49] = "loading";
        task.spawn(function() -- Line: 231
            -- upvalues: MarketplaceService (ref), u49 (copy), u16 (ref), u11 (ref), u9 (ref)
            local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, u49, Enum.InfoType.GamePass);

            if not success and os.clock() - u16 >= 30 then
                u16 = os.clock();
                warn("[EventKnivesOffer] " .. "price unavailable" .. ": " .. tostring(result));
            end;

            if u11[u49] == "loading" then
                if not (success and (type(result) == "table" and result)) then
                    result = false;
                end;

                u11[u49] = result;

                for i in u9 do
                    i:paint();
                end;
            end;
        end);
        v50 = u11[u49];
    end;

    if v50 == "loading" then
        return "CHECKING PRICE…", false;
    end;

    if not (v50 and (type(v50.PriceInRobux) == "number" and v50.PriceInRobux == v50.PriceInRobux)) then
        return "PRICE UNAVAILABLE", false;
    end;

    if not v50.IsForSale then
        return "NOT ON SALE", false;
    end;

    local math_floor_ret = math.floor(v50.PriceInRobux);
    local v51 = utf8_char_ret .. " " .. tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    local v52;

    if u1.PurchasesEnabled == false or (u8 == nil or (u8.loaded ~= true or u8.pending == true)) then
        v52 = false;
    else
        v52 = LocalPlayer:GetAttribute("InMatch") ~= true;
    end;

    return v51, v52;
end;

local function say(p53, p54) -- Line: 267
    -- upvalues: Color3_fromRGB_ret6 (copy)
    if p53.hooks.notice then
        p53.hooks.notice(p54);

        return;
    end;

    if p53.message then
        p53.message.Text = p54;
        p53.message.TextColor3 = Color3_fromRGB_ret6;
        p53.messageUntil = os.clock() + 5;
    end;
end;

local function purchaseShared(p55, p56) -- Line: 277
    -- upvalues: u1 (copy), Color3_fromRGB_ret6 (copy), u8 (ref), LocalPlayer (copy), OfferRules (copy), GiftClient (copy), MarketplaceService (copy), u16 (ref)
    if u1.PurchasesEnabled ~= false then
        if not p55.hooks.owned(p56.skin) then
            local v57;

            if u8 == nil or (u8.loaded ~= true or u8.pending == true) then
                v57 = false;
            else
                v57 = LocalPlayer:GetAttribute("InMatch") ~= true;
            end;

            if v57 and OfferRules.active(p56.offer, workspace:GetServerTimeNow()) then
                if GiftClient.busy() then
                    if p55.hooks.notice then
                        p55.hooks.notice("Finish your gift first.");

                        return;
                    end;

                    if p55.message then
                        p55.message.Text = "Finish your gift first.";
                        p55.message.TextColor3 = Color3_fromRGB_ret6;
                        p55.messageUntil = os.clock() + 5;
                    end;

                    return;
                end;

                local PromptGamePassPurchase = MarketplaceService.PromptGamePassPurchase;
                local v58 = u1.PassIds[p56.key];
                local v59 = type(v58) ~= "number" and 0 or v58;
                local success, result = pcall(PromptGamePassPurchase, MarketplaceService, LocalPlayer, v59);

                if not success then
                    if os.clock() - u16 >= 30 then
                        u16 = os.clock();
                        warn("[EventKnivesOffer] " .. "purchase prompt failed" .. ": " .. tostring(result));
                    end;

                    if p55.hooks.notice then
                        p55.hooks.notice("The purchase window could not open. Please try again.");

                        return;
                    end;

                    if p55.message then
                        p55.message.Text = "The purchase window could not open. Please try again.";
                        p55.message.TextColor3 = Color3_fromRGB_ret6;
                        p55.messageUntil = os.clock() + 5;
                    end;
                end;

                return;
            end;
        end;

        return;
    end;

    if p55.hooks.notice then
        p55.hooks.notice("Robux purchases are available in the live game.");

        return;
    end;

    if p55.message then
        p55.message.Text = "Robux purchases are available in the live game.";
        p55.message.TextColor3 = Color3_fromRGB_ret6;
        p55.messageUntil = os.clock() + 5;
    end;
end;

local function giftState(p60, p61) -- Line: 299
    -- upvalues: GiftClient (copy), SkinCatalog (copy), u1 (copy), OfferRules (copy), u11 (copy), MarketplaceService (copy), u16 (ref), u9 (copy), u8 (ref), LocalPlayer (copy)
    local v62 = GiftClient.giftable(p60.key);

    if v62 then
        local v63 = SkinCatalog.get(p60.skin);
        local v64 = u1.PassIds[p60.key];

        if (type(v64) ~= "number" and 0 or v64) > 0 and v63 ~= nil then
            v62 = v63.EquipReady ~= false;
        else
            v62 = false;
        end;

        if v62 then
            if u1.PurchasesEnabled == false then
                v62 = false;
            else
                v62 = OfferRules.active(p60.offer, p61);
            end;
        end;
    end;

    if v62 then
        local v65 = u1.PassIds[p60.key];
        local u66 = type(v65) ~= "number" and 0 or v65;
        local v67 = u11[u66];

        if v67 == nil then
            u11[u66] = "loading";
            task.spawn(function() -- Line: 231
                -- upvalues: MarketplaceService (ref), u66 (copy), u16 (ref), u11 (ref), u9 (ref)
                local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, u66, Enum.InfoType.GamePass);

                if not success and os.clock() - u16 >= 30 then
                    u16 = os.clock();
                    warn("[EventKnivesOffer] " .. "price unavailable" .. ": " .. tostring(result));
                end;

                if u11[u66] == "loading" then
                    if not (success and (type(result) == "table" and result)) then
                        result = false;
                    end;

                    u11[u66] = result;

                    for i in u9 do
                        i:paint();
                    end;
                end;
            end);
            v67 = u11[u66];
        end;

        local v68;

        if type(v67) == "table" then
            v68 = v67.IsForSale ~= true;
        else
            v68 = false;
        end;

        v62 = not v68;
    end;

    local v69;

    if v62 then
        if u8 == nil or (u8.loaded ~= true or u8.pending == true) then
            v69 = false;
        else
            v69 = LocalPlayer:GetAttribute("InMatch") ~= true;
        end;

        if v69 then
            v69 = not GiftClient.busy();
        end;
    else
        v69 = v62;
    end;

    return v62, v69;
end;

local function hooks(p70) -- Line: 312
    -- upvalues: ownedShared (copy)
    local v71 = p70 or {};

    return {
        status = v71.status,
        purchase = v71.purchase,
        owned = v71.owned or ownedShared,
        notice = v71.notice,
        cues = v71.cues,
        options = v71
    };
end;

local function cue(p72, p73, p74) -- Line: 326
    -- upvalues: Parent (copy)
    local v75 = p72.hooks.cues or Parent.Audio:FindFirstChild("PresentationCues");

    if v75 then
        v75:Fire("KnifePreview", p73, p74);
    end;
end;

local function make(p76, p77, p78) -- Line: 335
    local Instance_new_ret = Instance.new(p76);

    for i, v in p78 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p77;

    return Instance_new_ret;
end;

local function at(p79, p80, p81, p82, p83, p84) -- Line: 345
    p79.Position = UDim2.fromOffset(p80, p81);
    p79.Size = UDim2.fromOffset(p82, p83);

    if p84 then
        p79.AnchorPoint = p84;
    end;

    return p79;
end;

local function corner(p85, p86) -- Line: 354
    local v87 = {};

    if typeof(p86) ~= "UDim" then
        p86 = UDim.new(0, p86);
    end;

    v87.CornerRadius = p86;
    local UICorner = Instance.new("UICorner");

    for i, v in v87 do
        UICorner[i] = v;
    end;

    UICorner.Parent = p85;
end;

local function ring(p88, p89, p90, p91) -- Line: 359
    -- upvalues: Color3_new_ret2 (copy)
    local v92 = {
        Color = p89,
        Thickness = p90,
        Transparency = p91 or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = p89 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v92 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p88;

    return UIStroke;
end;

local function tint(p93, p94, p95) -- Line: 369
    local v96 = {};

    if typeof(p94) ~= "ColorSequence" then
        p94 = ColorSequence.new(p94[1], p94[2]);
    end;

    v96.Color = p94;
    v96.Rotation = p95 or 90;
    local UIGradient = Instance.new("UIGradient");

    for i, v in v96 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = p93;

    return UIGradient;
end;

local function fall(p97, p98, p99, p100) -- Line: 376
    return ColorSequence.new({ ColorSequenceKeypoint.new(0, p97), ColorSequenceKeypoint.new(p100 or 0.55, p98), ColorSequenceKeypoint.new(1, p99) });
end;

local function text(p101, p102, p103, p104, p105, p106) -- Line: 385
    -- upvalues: Font_new_ret2 (copy), Color3_new_ret (copy), Color3_new_ret2 (copy)
    local v107 = {
        BackgroundTransparency = 1,
        TextWrapped = true,
        Name = p102,
        FontFace = Font_new_ret2,
        Text = p103,
        TextSize = p104,
        TextColor3 = p105 or Color3_new_ret,
        TextXAlignment = Enum.TextXAlignment.Left
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v107 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p101;
    local v108 = {
        Color = Color3_new_ret2,
        Thickness = math.max(1, p104 / 13)
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v108 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    for i, v in p106 or {} do
        TextLabel[i] = v;
    end;

    return TextLabel;
end;

local function fit(p109, p110) -- Line: 404
    p109.TextScaled = true;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = p110
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = p109;

    return p109;
end;

local function glyph(p111, p112, p113, p114) -- Line: 410
    -- upvalues: Font_new_ret2 (copy), Color3_new_ret (copy)
    local v115 = {
        Name = "Icon",
        BackgroundTransparency = 1,
        FontFace = Font_new_ret2,
        Text = p112,
        TextSize = p113,
        TextColor3 = Color3_new_ret
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v115 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p111;

    for i, v in p114 or {} do
        TextLabel[i] = v;
    end;

    return TextLabel;
end;

local function button(p116, p117, p118, p119, p120, p121) -- Line: 426
    -- upvalues: Color3_new_ret (copy), corner (copy), tint (copy), Color3_new_ret2 (copy), text (copy), Vector2_new_ret (copy), Font_new_ret3 (copy)
    local v122 = {
        Text = "",
        AutoButtonColor = true,
        Selectable = false,
        BorderSizePixel = 0,
        ZIndex = 6,
        Name = p117,
        BackgroundColor3 = Color3_new_ret
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v122 do
        TextButton[i] = v;
    end;

    TextButton.Parent = p116;
    corner(TextButton, UDim.new(0.24, 0));
    local v123 = tint(TextButton, p120);
    local v124 = Color3_new_ret2;
    local v125 = {
        Thickness = 3,
        Transparency = 0,
        Color = v124,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v124 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v125 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextButton;
    local v126 = {
        Thickness = 2,
        Transparency = 0,
        Color = p121,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = p121 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v126 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = TextButton;
    local v127 = text(TextButton, "Label", p118, p119, Color3_new_ret, {
        TextWrapped = false,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, -18, 1, -10),
        FontFace = Font_new_ret3,
        TextXAlignment = Enum.TextXAlignment.Center
    });
    v127.TextScaled = true;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = p119
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = v127;

    return {
        button = TextButton,
        fill = v123,
        line = UIStroke2,
        label = v127
    };
end;

local u128 = {
    Buy = {
        ColorSequence.new(Color3_fromRGB_ret8, Color3_fromRGB_ret9),
        Color3_fromRGB_ret8,
        Color3_new_ret,
        true
    },
    Owned = {
        ColorSequence.new(Color3.fromRGB(36, 70, 46), Color3.fromRGB(18, 36, 24)),
        Color3_fromRGB_ret12,
        Color3_fromRGB_ret12,
        false
    },
    Off = {
        ColorSequence.new(Color3_fromRGB_ret10, Color3_fromRGB_ret11),
        Color3_fromRGB_ret3,
        Color3.fromRGB(205, 205, 205),
        false
    },
    Gift = {
        ColorSequence.new(Color3_fromRGB_ret6, Color3_fromRGB_ret7),
        Color3_fromRGB_ret6,
        Color3_new_ret,
        true
    },
    GiftOff = {
        ColorSequence.new(Color3_fromRGB_ret10, Color3_fromRGB_ret11),
        Color3_fromRGB_ret3,
        Color3_new_ret,
        false
    }
};

local function look(p129, p130) -- Line: 458
    -- upvalues: u128 (copy)
    local v131 = u128[p130];
    p129.fill.Color = v131[1];
    p129.line.Color = v131[2];
    p129.label.TextColor3 = v131[3];
    p129.button.AutoButtonColor = v131[4];
end;

local function glow(p132, p133, p134, p135, p136, p137, p138) -- Line: 467
    -- upvalues: Vector2_new_ret (copy)
    local v139 = {
        Name = "Glow",
        BackgroundTransparency = 1,
        Image = "rbxassetid://129028976496842",
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromOffset(p133, p134),
        Size = UDim2.fromOffset(p135, p135),
        ImageColor3 = p136,
        ImageTransparency = p137,
        ZIndex = p138 or 1
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v139 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = p132;

    return ImageLabel;
end;

local function field(p140, p141, p142, p143) -- Line: 482
    -- upvalues: Color3_new_ret (copy), Vector2_new_ret (copy), corner (copy), Color3_new_ret2 (copy)
    local v144 = {
        Name = "Field",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame = Instance.new("Frame");

    for i, v in v144 do
        Frame[i] = v;
    end;

    Frame.Parent = p140;

    local function line(p145) -- Line: 484
        -- upvalues: Frame (copy), Color3_new_ret (ref)
        local v146 = {
            BackgroundTransparency = 0.85,
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(p145 - 1, 0),
            Size = UDim2.new(0, 2, 1, 0),
            BackgroundColor3 = Color3_new_ret
        };
        local Frame2 = Instance.new("Frame");

        for i, v in v146 do
            Frame2[i] = v;
        end;

        Frame2.Parent = Frame;
    end;

    if p141.skin ~= "Futbol" then
        for i = 1, 5 do
            line((math.round(p142 * i / 6)));
            local _ = i;
        end;

        return;
    end;

    line(p142 / 2);
    local v147 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(p143 * 0.62, p143 * 0.62)
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v147 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    corner(Frame2, UDim.new(0.5, 0));
    local v148 = Color3_new_ret;
    local v149 = {
        Thickness = 2,
        Transparency = 0.85,
        Color = v148,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v148 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v149 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame2;
end;

local function shine(p150, p151) -- Line: 511
    -- upvalues: Color3_new_ret (copy), corner (copy), NumberSequence_new_ret (copy)
    local v152 = {
        Name = "Shine",
        BorderSizePixel = 0,
        Interactable = false,
        ZIndex = 5,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v152 do
        Frame[i] = v;
    end;

    Frame.Parent = p150;
    corner(Frame, p151);
    local v153 = {
        Rotation = 18,
        Transparency = NumberSequence_new_ret,
        Offset = Vector2.new(-1, 0)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v153 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;

    return UIGradient;
end;

local function sweep(p154, p155) -- Line: 524
    local v156 = math.min(1, p155 % 4.5 / 0.9) * 2 + -1;

    if p154.Offset.X ~= v156 then
        p154.Offset = Vector2.new(v156, 0);
    end;
end;

local function countdown(p157) -- Line: 533
    -- upvalues: Color3_fromRGB_ret2 (copy), corner (copy), Color3_new_ret2 (copy), tint (copy), Color3_new_ret (copy), color (copy), color2 (copy), Vector2_new_ret (copy), Color3_fromRGB_ret13 (copy), text (copy), Color3_fromRGB_ret6 (copy), Font_new_ret3 (copy)
    local v158 = {
        Name = "Countdown",
        BorderSizePixel = 0,
        ZIndex = 3,
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local Frame = Instance.new("Frame");

    for i, v in v158 do
        Frame[i] = v;
    end;

    Frame.Parent = p157;
    corner(Frame, UDim.new(0.5, 0));
    local v159 = Color3_new_ret2;
    local v160 = {
        Thickness = 4,
        Transparency = 0,
        Color = v159,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v159 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v160 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local v161 = Color3_new_ret;
    local v162 = {
        Thickness = 2.5,
        Transparency = 0,
        Color = v161,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v161 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v162 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame;
    tint(UIStroke2, { color, color2 }, 0);
    local v163 = {
        Name = "Live",
        BorderSizePixel = 0,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.new(0, 28, 0.5, 0),
        Size = UDim2.fromOffset(14, 14),
        BackgroundColor3 = Color3_fromRGB_ret13
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v163 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    corner(Frame2, UDim.new(0.5, 0));
    local v164 = Color3_new_ret2;
    local v165 = {
        Thickness = 1.5,
        Transparency = 0,
        Color = v164,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v164 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v165 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = Frame2;
    local v166 = text(Frame, "Caption", "ENDS IN", 14, Color3_fromRGB_ret6, {
        TextWrapped = false,
        Position = UDim2.new(0, 44, 0.12, 0),
        Size = UDim2.new(1, -66, 0.28, 0),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    local v167 = text(Frame, "Clock", "", 30, Color3_new_ret, {
        TextWrapped = false,
        FontFace = Font_new_ret3,
        Position = UDim2.new(0, 44, 0.38, 0),
        Size = UDim2.new(1, -66, 0.52, 0),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    v167.TextScaled = true;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 30
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = v167;

    return {
        pill = Frame,
        dot = Frame2,
        caption = v166,
        clock = v167
    };
end;

local function setCountdown(p168, p169) -- Line: 565
    -- upvalues: OfferRules (copy), u6 (copy)
    local v170 = OfferRules.countdown(u6, p169);
    local string_match_ret, v171 = string.match(v170, "^(%u+ IN) (.+)$");
    local v172 = string_match_ret or "";
    local v173 = v171 or v170;

    if p168.caption.Text ~= v172 then
        p168.caption.Text = v172;
        p168.caption.Visible = v172 ~= "";
        local clock = p168.clock;
        local v174;

        if v172 == "" then
            v174 = UDim2.new(0, 44, 0.24, 0);
        else
            v174 = UDim2.new(0, 44, 0.38, 0);
        end;

        clock.Position = v174;
    end;

    if p168.clock.Text ~= v173 then
        p168.clock.Text = v173;
    end;
end;

local function versus(p175) -- Line: 580
    -- upvalues: glow (copy), Color3_fromRGB_ret6 (copy), Vector2_new_ret (copy), Color3_new_ret (copy), corner (copy), tint (copy), color (copy), color2 (copy), Color3_new_ret2 (copy), text (copy), Font_new_ret3 (copy)
    local v176 = glow(p175, 0, 0, 230, Color3_fromRGB_ret6, 0.25, 8);
    local v177 = {
        Name = "Versus",
        Rotation = -10,
        ZIndex = 9,
        AnchorPoint = Vector2_new_ret,
        Size = UDim2.fromOffset(100, 100),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v177 do
        Frame[i] = v;
    end;

    Frame.Parent = p175;
    corner(Frame, UDim.new(0.5, 0));
    tint(Frame, ColorSequence.new({
        ColorSequenceKeypoint.new(0, color:Lerp(Color3_new_ret, 0.1)),
        ColorSequenceKeypoint.new(0.5, color),
        ColorSequenceKeypoint.new(0.501, color2),
        ColorSequenceKeypoint.new(1, color2:Lerp(Color3_new_ret, 0.1))
    }), 0);
    local v178 = Color3_new_ret2;
    local v179 = {
        Thickness = 6,
        Transparency = 0,
        Color = v178,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v178 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v179 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local v180 = Color3_fromRGB_ret6;
    local v181 = {
        Thickness = 3.5,
        Transparency = 0,
        Color = v180,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v180 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v181 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame;
    text(Frame, "Label", "VS", 44, Color3_new_ret, {
        TextWrapped = false,
        FontFace = Font_new_ret3,
        Size = UDim2.fromScale(1, 1),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    local UIScale = Instance.new("UIScale");
    local v182 = {
        halo = v176,
        badge = Frame
    };

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    v182.pulse = UIScale;

    return v182;
end;

local function chip(p183, p184, p185, p186, p187, p188, p189) -- Line: 609
    -- upvalues: Color3_new_ret2 (copy), glyph (copy), text (copy), Color3_new_ret (copy), Font_new_ret3 (copy)
    local v190 = {
        BackgroundTransparency = 0.45,
        BorderSizePixel = 0,
        Name = p184,
        BackgroundColor3 = Color3_new_ret2
    };
    local Frame = Instance.new("Frame");

    for i, v in v190 do
        Frame[i] = v;
    end;

    Frame.Parent = p183;
    Frame.Position = UDim2.fromOffset(0, p185);
    Frame.Size = UDim2.fromOffset(198, 56);
    local v191 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v191 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v192 = {
        Thickness = 1.5,
        Transparency = 0.35,
        Color = p189,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = p189 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v192 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    glyph(Frame, p186, 26, {
        Position = UDim2.fromOffset(4, 0),
        Size = UDim2.fromOffset(44, 56)
    });
    local v193 = text(Frame, "Title", p187, 18, Color3_new_ret, {
        TextWrapped = false,
        FontFace = Font_new_ret3
    });
    v193.TextScaled = true;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 18
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = v193;
    v193.Position = UDim2.fromOffset(50, 8);
    v193.Size = UDim2.fromOffset(140, 22);
    local v194 = text(Frame, "Caption", p188, 13, p189, {
        TextWrapped = false
    });
    v194.TextScaled = true;
    local UITextSizeConstraint2 = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 13
    } do
        UITextSizeConstraint2[i] = v;
    end;

    UITextSizeConstraint2.Parent = v194;
    v194.Position = UDim2.fromOffset(50, 31);
    v194.Size = UDim2.fromOffset(140, 17);

    return Frame;
end;

local function buy(p195, p196) -- Line: 627
    -- upvalues: sound (copy), purchaseShared (copy)
    if not p196.enabled then
        return;
    end;

    sound("Click");

    if p195.hooks.purchase then
        p195.hooks.purchase(p196.knife.key);

        return;
    end;

    purchaseShared(p195, p196.knife);
end;

local function gift(p197, p198) -- Line: 640
    -- upvalues: giftState (copy), GiftClient (copy), Color3_fromRGB_ret6 (copy)
    local v199, v200 = giftState(p198.knife, workspace:GetServerTimeNow());

    if v199 and v200 then
        GiftClient.open(p198.knife.key);

        return;
    end;

    if v199 and GiftClient.busy() then
        if p197.hooks.notice then
            p197.hooks.notice("Finish your gift first.");

            return;
        end;

        if p197.message then
            p197.message.Text = "Finish your gift first.";
            p197.message.TextColor3 = Color3_fromRGB_ret6;
            p197.messageUntil = os.clock() + 5;
        end;
    end;
end;

local function buyRow(u201, p202, p203, p204, p205, p206, p207, p208) -- Line: 651
    -- upvalues: button (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret7 (copy), Vector2_new_ret (copy), GiftClient (copy), sound (copy), purchaseShared (copy), gift (copy)
    local u209 = {
        knife = p202,
        buy = button(p203, "Buy", "", p208, { Color3_fromRGB_ret8, Color3_fromRGB_ret9 }, Color3_fromRGB_ret8),
        gift = button(p203, "Gift", "", 10, { Color3_fromRGB_ret6, Color3_fromRGB_ret7 }, Color3_fromRGB_ret6),
        x = p204,
        y = p205,
        width = p206,
        height = p207
    };
    u209.gift.label.Visible = false;
    local button2 = u209.gift.button;
    local v210 = {
        Name = "GiftIcon",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.66, 0.66),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        Image = GiftClient.ICON,
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v210 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = button2;
    u209.gift.button.Visible = false;
    local button3 = u209.buy.button;
    button3.Position = UDim2.fromOffset(p204, p205);
    button3.Size = UDim2.fromOffset(p206, p207);
    local button4 = u209.gift.button;
    button4.Position = UDim2.fromOffset(p204 + p206 - p207, p205);
    button4.Size = UDim2.fromOffset(p207, p207);
    table.insert(u201.rows, u209);
    table.insert(u201.connections, u209.buy.button.Activated:Connect(function() -- Line: 676
        -- upvalues: u201 (copy), u209 (copy), sound (ref), purchaseShared (ref)
        local v211 = u201;
        local v212 = u209;

        if not v212.enabled then
            return;
        end;

        sound("Click");

        if v211.hooks.purchase then
            v211.hooks.purchase(v212.knife.key);

            return;
        end;

        purchaseShared(v211, v212.knife);
    end));
    table.insert(u201.connections, u209.gift.button.Activated:Connect(function() -- Line: 679
        -- upvalues: gift (ref), u201 (copy), u209 (copy)
        gift(u201, u209);
    end));

    return u209;
end;

local function paintRow(p213, p214, p215) -- Line: 685
    -- upvalues: statusShared (copy), u128 (copy), giftState (copy)
    local knife = p214.knife;
    local v216, v217;

    if p213.hooks.status then
        v216, v217 = p213.hooks.status(knife.key);
    else
        v216 = nil;
        v217 = nil;
    end;

    if type(v216) ~= "string" then
        v216, v217 = statusShared(p213, knife, p215);
    end;

    local v218 = v217 == true;
    local string_upper_ret = string.upper(v216);
    local v219 = v218 and "Buy" or (p213.hooks.owned(knife.skin) and "Owned" or "Off");

    if p214.look ~= v219 then
        p214.look = v219;
        local buy2 = p214.buy;
        local v220 = u128[v219];
        buy2.fill.Color = v220[1];
        buy2.line.Color = v220[2];
        buy2.label.TextColor3 = v220[3];
        buy2.button.AutoButtonColor = v220[4];
    end;

    p214.enabled = v218;

    if p214.buy.label.Text ~= string_upper_ret then
        p214.buy.label.Text = string_upper_ret;
    end;

    local v221, v222 = giftState(knife, p215);

    if p214.giftShown ~= v221 then
        p214.giftShown = v221;
        p214.gift.button.Visible = v221;
        local v223;

        if v221 then
            v223 = p214.width - p214.height - 8;
        else
            v223 = p214.width;
        end;

        p214.buy.button.Size = UDim2.fromOffset(v223, p214.height);
    end;

    local v224 = v222 and "Gift" or "GiftOff";

    if p214.giftLook ~= v224 then
        p214.giftLook = v224;
        local gift2 = p214.gift;
        local v225 = u128[v224];
        gift2.fill.Color = v225[1];
        gift2.line.Color = v225[2];
        gift2.label.TextColor3 = v225[3];
        gift2.button.AutoButtonColor = v225[4];
    end;
end;

local function onScreen(p226) -- Line: 719
    while p226 do
        if p226:IsA("GuiObject") then
            if not p226.Visible then
                return false;
            end;
        elseif p226:IsA("LayerCollector") then
            return p226.Enabled;
        end;

        p226 = p226.Parent;
    end;

    return false;
end;

local u227 = {};
u227.__index = u227;

local function panel(u228, p229, u230, p231) -- Line: 740
    -- upvalues: SkinCatalog (copy), ability (copy), EmoteCatalog (copy), Vector2_new_ret4 (copy), Color3_new_ret (copy), tint (copy), fall (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret (copy), glyph (copy), Vector2_new_ret (copy), corner (copy), text (copy), Font_new_ret3 (copy), ShopConfig (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret7 (copy), field (copy), glow (copy), Preview (copy), chip (copy), buyRow (copy), button (copy), Color3_fromRGB_ret2 (copy), sound (copy), u5 (copy), shine (copy)
    local offer = u230.offer;
    local v232 = SkinCatalog.get(u230.skin);
    local v233 = ability(u230);
    local v234 = nil;

    for _, v in EmoteCatalog.bundle(u230.skin) do
        if v.Knife == u230.skin then
            v234 = v;
            break;
        end;
    end;

    local v235 = {
        BorderSizePixel = 0,
        ZIndex = 2,
        Name = u230.key,
        Size = UDim2.fromOffset(Vector2_new_ret4.X, Vector2_new_ret4.Y),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v235 do
        Frame[i] = v;
    end;

    Frame.Parent = p229;
    local v236 = {
        CornerRadius = UDim.new(0, 18)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v236 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    tint(Frame, fall(u230.color:Lerp(Color3_new_ret2, 0.1), u230.color:Lerp(Color3_fromRGB_ret, 0.74), Color3_fromRGB_ret));
    local v237 = Color3_new_ret2;
    local v238 = {
        Thickness = 3,
        Transparency = 0,
        Color = v237,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v237 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v238 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local light = u230.light;
    local v239 = {
        Thickness = 2,
        Transparency = 0,
        Color = light,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = light == Color3_new_ret2 and 1 or 2
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v239 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame;
    glyph(Frame, u230.icon, 150, {
        Name = "Watermark",
        Rotation = 14,
        TextTransparency = 0.86,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromOffset(370, 96),
        Size = UDim2.fromOffset(170, 170)
    });
    local v240 = {
        Name = "Tag",
        BorderSizePixel = 0,
        BackgroundColor3 = u230.color
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v240 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    Frame2.Position = UDim2.fromOffset(16, 14);
    Frame2.Size = UDim2.fromOffset(230, 30);
    corner(Frame2, UDim.new(0.5, 0));
    local v241 = Color3_new_ret2;
    local v242 = {
        Thickness = 2.5,
        Transparency = 0,
        Color = v241,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v241 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v242 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = Frame2;
    local v243 = text(Frame2, "Text", offer.Eyebrow or "LIMITED", 15, Color3_new_ret, {
        TextWrapped = false,
        FontFace = Font_new_ret3,
        Position = UDim2.fromOffset(12, 0),
        Size = UDim2.new(1, -24, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    v243.TextScaled = true;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 15
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = v243;

    if ShopConfig.isNew(offer, p231) then
        local v244 = {
            Name = "New",
            Rotation = 6,
            ZIndex = 3,
            BackgroundColor3 = Color3_new_ret
        };
        local Frame3 = Instance.new("Frame");

        for i, v in v244 do
            Frame3[i] = v;
        end;

        Frame3.Parent = Frame;
        local Vector2_new_ret6 = Vector2.new(1, 0);
        Frame3.Position = UDim2.fromOffset(442, 12);
        Frame3.Size = UDim2.fromOffset(76, 32);

        if Vector2_new_ret6 then
            Frame3.AnchorPoint = Vector2_new_ret6;
        end;

        corner(Frame3, UDim.new(0.5, 0));
        tint(Frame3, { Color3_fromRGB_ret6, Color3_fromRGB_ret7 });
        local v245 = Color3_new_ret2;
        local v246 = {
            Thickness = 2.5,
            Transparency = 0,
            Color = v245,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            ZIndex = v245 == Color3_new_ret2 and 1 or 2
        };
        local UIStroke4 = Instance.new("UIStroke");

        for i, v in v246 do
            UIStroke4[i] = v;
        end;

        UIStroke4.Parent = Frame3;
        text(Frame3, "Text", "NEW!", 18, Color3_new_ret, {
            TextWrapped = false,
            FontFace = Font_new_ret3,
            Size = UDim2.fromScale(1, 1),
            TextXAlignment = Enum.TextXAlignment.Center
        });
    end;

    local v247 = text(Frame, "KnifeName", u230.name, 46, Color3_new_ret, {
        TextWrapped = false,
        FontFace = Font_new_ret3
    });
    v247.Position = UDim2.fromOffset(18, 48);
    v247.Size = UDim2.fromOffset(420, 52);
    tint(v247, { Color3_new_ret, u230.light });
    local v248 = text(Frame, "Tagline", offer.Tagline or "", 19, u230.light, {
        TextWrapped = false
    });
    v248.TextScaled = true;
    local UITextSizeConstraint2 = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 19
    } do
        UITextSizeConstraint2[i] = v;
    end;

    UITextSizeConstraint2.Parent = v248;
    v248.Position = UDim2.fromOffset(18, 100);
    v248.Size = UDim2.fromOffset(420, 26);
    local v249 = {
        Name = "Preview",
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(226, 186),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v249 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    local v250 = {
        CornerRadius = UDim.new(0, 14)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v250 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame3;
    tint(Frame3, { u230.color:Lerp(Color3_new_ret, 0.06), u230.deep });
    local light2 = u230.light;
    local v251 = {
        Thickness = 1.5,
        Transparency = 0.3,
        Color = light2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = light2 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke4 = Instance.new("UIStroke");

    for i, v in v251 do
        UIStroke4[i] = v;
    end;

    UIStroke4.Parent = Frame3;
    field(Frame3, u230, 226, 186);
    local halos = u228.halos;
    local v252 = glow(Frame3, 113, 93, 200, u230.light, 0.35);
    table.insert(halos, v252);
    local v253 = {
        Name = "View",
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-1, -1, -1),
        ZIndex = 2,
        Size = UDim2.fromScale(1, 1),
        Ambient = Color3.fromRGB(205, 205, 210),
        LightColor = Color3_new_ret
    };
    local ViewportFrame = Instance.new("ViewportFrame");

    for i, v in v253 do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = Frame3;
    local v254 = Preview.knife(ViewportFrame, v232, nil);

    if v254 then
        table.insert(u228.previews, v254);
    end;

    local v255 = {
        Name = "Open",
        Text = "",
        BackgroundTransparency = 1,
        Selectable = false,
        ZIndex = 6,
        Size = UDim2.fromScale(1, 1)
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v255 do
        TextButton[i] = v;
    end;

    TextButton.Parent = Frame3;
    local v256 = {
        Name = "Includes",
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(198, 186)
    };
    local Frame4 = Instance.new("Frame");

    for i, v in v256 do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame;
    chip(Frame4, "Ability", 0, u230.power, not v233 and "ABILITY" or string.upper(v233.Label), not v233 and "" or v233.Cooldown .. "s COOLDOWN", u230.light);

    if v234 then
        chip(Frame4, "Emote", 65, "💃", string.upper(v234.Name), "EMOTE INCLUDED", u230.light);
    end;

    if v232 and v232.Show then
        chip(Frame4, "Show", 130, "🎬", "HERO SHOW", string.upper(v232.Collection or "") .. " CUTSCENE", u230.light);
    end;

    buyRow(u228, u230, Frame, 14, 330, 300, 52, 24);
    local v257 = button(Frame, "Details", "DETAILS", 19, { Color3_fromRGB_ret:Lerp(u230.color, 0.3), Color3_fromRGB_ret2 }, u230.light);
    local button2 = v257.button;
    button2.Position = UDim2.fromOffset(322, 330);
    button2.Size = UDim2.fromOffset(120, 52);

    local function open() -- Line: 837
        -- upvalues: sound (ref), u5 (ref), u230 (copy), u228 (copy)
        sound("Click");
        u5.details(u230.skin, u228.hooks.options);
    end;

    table.insert(u228.connections, v257.button.Activated:Connect(open));
    table.insert(u228.connections, TextButton.Activated:Connect(open));
    local shines = u228.shines;
    local v258 = shine(Frame, 18);
    table.insert(shines, v258);

    return {
        frame = Frame,
        preview = Frame3,
        chips = Frame4
    };
end;

local function arrange(p259, p260) -- Line: 848
    -- upvalues: Vector2_new_ret3 (copy), Vector2_new_ret2 (copy)
    p259.tall = p260;
    local v261;

    if p260 then
        v261 = Vector2_new_ret3;
    else
        v261 = Vector2_new_ret2;
    end;

    p259.stage.Size = UDim2.fromOffset(v261.X, v261.Y);
    local v262;

    if p260 then
        v262 = Enum.TextXAlignment.Center;
    else
        v262 = Enum.TextXAlignment.Left;
    end;

    if p260 then
        local title = p259.title;
        title.Position = UDim2.fromOffset(16, 18);
        title.Size = UDim2.fromOffset(448, 40);
        local subtitle = p259.subtitle;
        subtitle.Position = UDim2.fromOffset(16, 60);
        subtitle.Size = UDim2.fromOffset(448, 22);
        local pill = p259.countdown.pill;
        pill.Position = UDim2.fromOffset(98, 88);
        pill.Size = UDim2.fromOffset(284, 56);
    else
        local title = p259.title;
        title.Position = UDim2.fromOffset(28, 16);
        title.Size = UDim2.fromOffset(612, 44);
        local subtitle = p259.subtitle;
        subtitle.Position = UDim2.fromOffset(30, 60);
        subtitle.Size = UDim2.fromOffset(600, 22);
        local pill = p259.countdown.pill;
        pill.Position = UDim2.fromOffset(658, 18);
        pill.Size = UDim2.fromOffset(284, 60);
    end;

    local subtitle = p259.subtitle;
    p259.title.TextXAlignment = v262;
    subtitle.TextXAlignment = v262;

    for i, v in p259.panels do
        local v263 = not p260 and i == 1;
        local frame = v.frame;
        local v264;

        if p260 then
            v264 = UDim2.fromOffset(12, i == 1 and 150 or 642);
        else
            v264 = UDim2.fromOffset(i == 1 and 16 or 488, 96);
        end;

        frame.Position = v264;
        v.preview.Position = UDim2.fromOffset(v263 and 220 or 10, 132);
        v.chips.Position = UDim2.fromOffset(v263 and 12 or 246, 132);
    end;

    local v265;

    if p260 then
        v265 = UDim2.fromOffset(240, 592);
    else
        v265 = UDim2.fromOffset(480, 321);
    end;

    p259.versus.badge.Position = v265;
    p259.versus.halo.Position = v265;
end;

local function inherited(p266) -- Line: 878
    local v267 = 1;

    while p266 and p266:IsA("GuiObject") do
        local v268 = p266:FindFirstChildOfClass("UIScale");

        if v268 then
            v267 = v267 * v268.Scale;
        end;

        p266 = p266.Parent;
    end;

    return math.max(v267, 0.001);
end;

local function fitCard(p269) -- Line: 890
    -- upvalues: inherited (copy), arrange (copy), Vector2_new_ret3 (copy), Vector2_new_ret2 (copy)
    local v270 = p269.root.AbsoluteSize / inherited(p269.root.Parent);

    if v270.X < 1 or v270.Y < 1 then
        return;
    end;

    local v271 = v270.X / v270.Y < 1.2;

    if v271 ~= p269.tall then
        arrange(p269, v271);
    end;

    local v272;

    if v271 then
        v272 = Vector2_new_ret3;
    else
        v272 = Vector2_new_ret2;
    end;

    p269.scale.Scale = math.min(v270.X / v272.X, v270.Y / v272.Y);
end;

local function stepCard(p273, p274) -- Line: 903
    -- upvalues: onScreen (copy)
    if not p273.root.Parent then
        p273:destroy();

        return;
    end;

    p273.clock = p273.clock + p274;
    p273.check = p273.check - p274;

    if p273.check <= 0 then
        p273.check = 0.25;
        p273.shown = onScreen(p273.root);

        if p273.shown then
            p273:paint();
        end;
    end;

    if not p273.shown then
        return;
    end;

    local clock = p273.clock;

    for _, v in p273.previews do
        v:step(p274);
    end;

    for _, v in p273.halos do
        v.Rotation = (v.Rotation + p274 * 14) % 360;
    end;

    p273.versus.halo.Rotation = (p273.versus.halo.Rotation - p274 * 10) % 360;
    p273.versus.pulse.Scale = math.sin(clock * 3) * 0.05 + 1;

    for i, v in p273.shines do
        local v275 = math.min(1, (clock + (i - 1) * 0.7) % 4.5 / 0.9) * 2 + -1;

        if v.Offset.X ~= v275 then
            v.Offset = Vector2.new(v275, 0);
        end;
    end;

    p273.countdown.dot.BackgroundTransparency = 0.45 - math.cos(clock * 4) * 0.45;
end;

function u5.card(p276, p277) -- Line: 936
    -- upvalues: hooks (copy), u227 (copy), Color3_new_ret (copy), tint (copy), fall (copy), color (copy), Color3_fromRGB_ret (copy), color2 (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret6 (copy), Vector2_new_ret (copy), Vector2_new_ret2 (copy), text (copy), u3 (copy), hex (copy), Font_new_ret3 (copy), Color3_fromRGB_ret4 (copy), countdown (copy), panel (copy), versus (copy), arrange (copy), u9 (copy), u10 (ref), ArmoryEvent (copy), u8 (ref), fitCard (copy), RunService (copy), stepCard (copy), GiftClient (copy), LocalPlayer (copy)
    local v278 = {
        clock = 0,
        check = 0,
        shown = true,
        hooks = hooks(p277),
        connections = {},
        previews = {},
        halos = {},
        shines = {},
        rows = {},
        panels = {}
    };
    local u279 = setmetatable(v278, u227);
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v280 = {
        Name = "EventKnives",
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v280 do
        Frame[i] = v;
    end;

    Frame.Parent = nil;
    Frame:SetAttribute("SelfManagedText", true);
    local v281 = {
        CornerRadius = UDim.new(0, 22)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v281 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    tint(Frame, fall(color:Lerp(Color3_fromRGB_ret, 0.55), Color3_fromRGB_ret, color2:Lerp(Color3_fromRGB_ret, 0.55), 0.5), 0);
    local v282 = Color3_new_ret2;
    local v283 = {
        Thickness = 3,
        Transparency = 0,
        Color = v282,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v282 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v283 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local v284 = Color3_fromRGB_ret6;
    local v285 = {
        Thickness = 2,
        Transparency = 0,
        Color = v284,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v284 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v285 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame;
    u279.root = Frame;
    local v286 = {
        Name = "Stage",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(Vector2_new_ret2.X, Vector2_new_ret2.Y)
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v286 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    u279.stage = Frame2;
    local UIScale = Instance.new("UIScale");

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame2;
    u279.scale = UIScale;
    local string_format = string.format;
    local light = u3[1].light;
    local string_format_ret = string.format("#%02X%02X%02X", math.round(light.R * 255), math.round(light.G * 255), (math.round(light.B * 255)));
    local light2 = u3[2].light;
    u279.title = text(Frame2, "Title", string_format("<font color=\"%s\">%s</font> vs <font color=\"%s\">%s</font> <font color=\"%s\">· LIMITED</font>", string_format_ret, u3[1].name, string.format("#%02X%02X%02X", math.round(light2.R * 255), math.round(light2.G * 255), (math.round(light2.B * 255))), u3[2].name, hex(Color3_fromRGB_ret6)), 36, Color3_new_ret, {
        RichText = true,
        TextWrapped = false,
        FontFace = Font_new_ret3
    });
    local title = u279.title;
    title.TextScaled = true;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 36
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = title;
    u279.subtitle = text(Frame2, "Subtitle", "", 17, Color3_fromRGB_ret4, {
        TextWrapped = false
    });
    u279.message = u279.subtitle;
    u279.countdown = countdown(Frame2);

    for _, v in u3 do
        local panels = u279.panels;
        local v287 = panel(u279, Frame2, v, ServerTimeNow);
        table.insert(panels, v287);
    end;

    u279.versus = versus(Frame2);
    arrange(u279, false);
    Frame.Parent = p276;
    u9[u279] = true;

    if not u10 then
        u10 = ArmoryEvent.OnClientEvent:Connect(function(p288, p289) -- Line: 163
            -- upvalues: u8 (ref), u9 (ref)
            if p288 == "State" and type(p289) == "table" then
                u8 = p289;

                for i in u9 do
                    i:paint();
                end;
            end;
        end);
    end;

    local connections = u279.connections;
    local PropertyChangedSignal = Frame:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(connections, PropertyChangedSignal:Connect(function() -- Line: 987
        -- upvalues: fitCard (ref), u279 (copy)
        fitCard(u279);
    end));
    table.insert(u279.connections, RunService.RenderStepped:Connect(function(p290) -- Line: 990
        -- upvalues: stepCard (ref), u279 (copy)
        stepCard(u279, p290);
    end));
    table.insert(u279.connections, GiftClient.changed:Connect(function() -- Line: 993
        -- upvalues: u279 (copy)
        u279:paint();
    end));

    for _, v in { "InMatch", "GiftOpen" } do
        local connections2 = u279.connections;
        local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
        table.insert(connections2, AttributeChangedSignal:Connect(function() -- Line: 997
            -- upvalues: u279 (copy)
            u279:paint();
        end));
    end;

    fitCard(u279);
    u279:paint();

    return u279;
end;

function u227.refresh(p291, p292) -- Line: 1007
    -- upvalues: u8 (ref)
    if type(p292) == "table" then
        u8 = p292;
    end;

    p291:paint();
end;

function u227.paint(p293) -- Line: 1014
    -- upvalues: setCountdown (copy), paintRow (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret4 (copy)
    if p293.dead then
        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    setCountdown(p293.countdown, ServerTimeNow);

    for _, v in p293.rows do
        paintRow(p293, v, ServerTimeNow);
    end;

    if p293.messageUntil and os.clock() > p293.messageUntil then
        p293.messageUntil = nil;
    end;

    local v294 = not p293.messageUntil and "TWO LIMITED KNIVES. ONE DEADLINE." or p293.message.Text;

    if p293.subtitle.Text ~= v294 then
        p293.subtitle.Text = v294;
    end;

    local v295;

    if p293.messageUntil then
        v295 = Color3_fromRGB_ret6;
    else
        v295 = Color3_fromRGB_ret4;
    end;

    p293.subtitle.TextColor3 = v295;
end;

function u227.destroy(p296) -- Line: 1033
    -- upvalues: u9 (copy), u10 (ref), u8 (ref), u11 (copy)
    if p296.dead then
        return;
    end;

    p296.dead = true;

    for _, v in p296.connections do
        v:Disconnect();
    end;

    table.clear(p296.connections);

    for _, v in p296.previews do
        v:destroy();
    end;

    table.clear(p296.previews);
    table.clear(p296.rows);
    u9[p296] = nil;

    if u10 and next(u9) == nil then
        u10:Disconnect();
        u10 = nil;
        u8 = nil;
        table.clear(u11);
    end;

    p296.root:Destroy();
end;

local u297 = {};
u297.__index = u297;

local function overlaid(p298) -- Line: 1057
    -- upvalues: u15 (ref)
    if p298:FindFirstChild("KnifeClipPreview") or os.clock() - u15 < 0.25 then
        return true;
    end;

    local ValleyGift = p298:FindFirstChild("ValleyGift");

    if ValleyGift then
        ValleyGift = ValleyGift:FindFirstChild("Panel");
    end;

    local v299;

    if ValleyGift == nil then
        v299 = false;
    else
        v299 = ValleyGift:IsA("GuiObject") and ValleyGift.Visible;
    end;

    return v299;
end;

local function back(p300, p301) -- Line: 1066
    -- upvalues: u12 (ref), overlaid (copy)
    if p301 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass;
    end;

    local v302 = u12;
    local v303;

    if v302 then
        v303 = v302.gui.Parent;
    else
        v303 = v302;
    end;

    if v303 and not overlaid(v303) then
        v302:close("Back");
    end;

    return Enum.ContextActionResult.Sink;
end;

local function tile(p304, p305, p306, p307, p308, p309, p310) -- Line: 1078
    -- upvalues: Color3_new_ret2 (copy)
    local v311 = {
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Name = p305,
        BackgroundColor3 = Color3_new_ret2
    };
    local Frame = Instance.new("Frame");

    for i, v in v311 do
        Frame[i] = v;
    end;

    Frame.Parent = p304;
    Frame.Position = UDim2.fromOffset(p306, p307);
    Frame.Size = UDim2.fromOffset(p308, p309);
    local v312 = {
        CornerRadius = UDim.new(0, 16)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v312 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v313 = Color3_new_ret2;
    local v314 = {
        Thickness = 2.5,
        Transparency = 0,
        Color = v313,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v313 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v314 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local v315 = {
        Thickness = 1.5,
        Transparency = 0.25,
        Color = p310,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = p310 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v315 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame;

    return Frame;
end;

local function build(u316, u317) -- Line: 1087
    -- upvalues: SkinCatalog (copy), ability (copy), EmoteCatalog (copy), Vector2_new_ret (copy), Vector2_new_ret5 (copy), Color3_new_ret (copy), tint (copy), fall (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), glyph (copy), corner (copy), text (copy), u3 (copy), Color3_fromRGB_ret6 (copy), Font_new_ret3 (copy), countdown (copy), Color3_fromRGB_ret13 (copy), field (copy), glow (copy), Preview (copy), Color3_fromRGB_ret4 (copy), button (copy), shine (copy), Font_new_ret (copy), Color3_fromRGB_ret12 (copy), buyRow (copy), tile (copy), EmotePose (copy), u16 (ref), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret5 (copy), sound (copy), u5 (copy), Parent (copy)
    local offer = u317.offer;
    local u318 = SkinCatalog.get(u317.skin);
    local v319, v320 = ability(u317);
    local u321 = nil;

    for _, v in EmoteCatalog.bundle(u317.skin) do
        if v.Knife == u317.skin then
            u321 = v;
            break;
        end;
    end;

    local gui = u316.gui;
    local v322 = {
        Name = "Panel",
        BorderSizePixel = 0,
        Active = true,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(Vector2_new_ret5.X, Vector2_new_ret5.Y),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v322 do
        Frame[i] = v;
    end;

    Frame.Parent = gui;
    u316.panel = Frame;
    local v323 = {
        CornerRadius = UDim.new(0, 24)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v323 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    tint(Frame, fall(u317.color:Lerp(Color3_new_ret2, 0.2), u317.color:Lerp(Color3_fromRGB_ret, 0.8), Color3_fromRGB_ret2, 0.4));
    local v324 = Color3_new_ret2;
    local v325 = {
        Thickness = 3,
        Transparency = 0,
        Color = v324,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v324 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v325 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local light = u317.light;
    local v326 = {
        Thickness = 2.5,
        Transparency = 0,
        Color = light,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = light == Color3_new_ret2 and 1 or 2
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v326 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame;
    local UIScale = Instance.new("UIScale");

    for i, v in {
        Scale = 0.9
    } do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    u316.scale = UIScale;
    glyph(Frame, u317.icon, 260, {
        Name = "Watermark",
        Rotation = 14,
        TextTransparency = 0.9,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromOffset(880, 120),
        Size = UDim2.fromOffset(300, 300)
    });
    local v327 = {
        Name = "Team",
        BorderSizePixel = 0,
        BackgroundColor3 = Color3_new_ret
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v327 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    Frame2.Position = UDim2.fromOffset(24, 20);
    Frame2.Size = UDim2.fromOffset(64, 64);
    corner(Frame2, UDim.new(0.5, 0));
    tint(Frame2, { u317.color:Lerp(Color3_new_ret, 0.15), u317.deep });
    local v328 = Color3_new_ret2;
    local v329 = {
        Thickness = 3,
        Transparency = 0,
        Color = v328,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v328 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v329 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = Frame2;
    local light2 = u317.light;
    local v330 = {
        Thickness = 2,
        Transparency = 0,
        Color = light2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = light2 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke4 = Instance.new("UIStroke");

    for i, v in v330 do
        UIStroke4[i] = v;
    end;

    UIStroke4.Parent = Frame2;
    glyph(Frame2, u317.icon, 34, {
        Size = UDim2.fromScale(1, 1)
    });
    local string_format = string.format;
    local light3 = u3[1].light;
    local string_format_ret = string.format("#%02X%02X%02X", math.round(light3.R * 255), math.round(light3.G * 255), (math.round(light3.B * 255)));
    local light4 = u3[2].light;
    text(Frame, "Eyebrow", string_format("<font color=\"%s\">%s</font> vs <font color=\"%s\">%s</font> · LIMITED", string_format_ret, u3[1].name, string.format("#%02X%02X%02X", math.round(light4.R * 255), math.round(light4.G * 255), (math.round(light4.B * 255))), u3[2].name), 16, Color3_fromRGB_ret6, {
        RichText = true,
        TextWrapped = false,
        Position = UDim2.fromOffset(102, 20),
        Size = UDim2.fromOffset(520, 20)
    });
    local v331 = text(Frame, "Title", u317.name, 46, Color3_new_ret, {
        TextWrapped = false,
        FontFace = Font_new_ret3
    });
    v331.Position = UDim2.fromOffset(100, 38);
    v331.Size = UDim2.fromOffset(540, 52);
    tint(v331, { Color3_new_ret, u317.light });
    u316.countdown = countdown(Frame);
    local pill = u316.countdown.pill;
    pill.Position = UDim2.fromOffset(668, 24);
    pill.Size = UDim2.fromOffset(284, 58);
    local v332 = {
        Name = "Close",
        Text = "X",
        TextSize = 40,
        BackgroundTransparency = 1,
        Selectable = false,
        ZIndex = 6,
        TextColor3 = Color3_fromRGB_ret13,
        FontFace = Font_new_ret3
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v332 do
        TextButton[i] = v;
    end;

    TextButton.Parent = Frame;
    local v333 = Vector2_new_ret;
    TextButton.Position = UDim2.fromOffset(992, 53);
    TextButton.Size = UDim2.fromOffset(52, 52);

    if v333 then
        TextButton.AnchorPoint = v333;
    end;

    local v334 = {
        Thickness = 3,
        Color = Color3_new_ret2
    };
    local UIStroke5 = Instance.new("UIStroke");

    for i, v in v334 do
        UIStroke5[i] = v;
    end;

    UIStroke5.Parent = TextButton;
    local v335 = {
        Name = "Knife",
        BorderSizePixel = 0,
        BackgroundColor3 = Color3_new_ret
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v335 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    Frame3.Position = UDim2.fromOffset(24, 102);
    Frame3.Size = UDim2.fromOffset(428, 300);
    local v336 = {
        CornerRadius = UDim.new(0, 18)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v336 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame3;
    tint(Frame3, { u317.color:Lerp(Color3_new_ret, 0.06), u317.deep });
    local v337 = Color3_new_ret2;
    local v338 = {
        Thickness = 3,
        Transparency = 0,
        Color = v337,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v337 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke6 = Instance.new("UIStroke");

    for i, v in v338 do
        UIStroke6[i] = v;
    end;

    UIStroke6.Parent = Frame3;
    local light5 = u317.light;
    local v339 = {
        Thickness = 2,
        Transparency = 0,
        Color = light5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = light5 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke7 = Instance.new("UIStroke");

    for i, v in v339 do
        UIStroke7[i] = v;
    end;

    UIStroke7.Parent = Frame3;
    field(Frame3, u317, 428, 300);
    local halos = u316.halos;
    local v340 = glow(Frame3, 214, 150, 330, u317.light, 0.3);
    table.insert(halos, v340);
    local v341 = {
        Name = "View",
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-1, -1, -1),
        ZIndex = 2,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromScale(0.5, 0.56),
        Size = UDim2.fromScale(0.92, 0.82),
        Ambient = Color3.fromRGB(205, 205, 210),
        LightColor = Color3_new_ret
    };
    local ViewportFrame = Instance.new("ViewportFrame");

    for i, v in v341 do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = Frame3;
    local v342 = Preview.knife(ViewportFrame, u318, "Any");

    if v342 then
        table.insert(u316.previews, v342);
    end;

    local v343 = {
        Name = "Tag",
        BorderSizePixel = 0,
        ZIndex = 3,
        BackgroundColor3 = u317.color
    };
    local Frame4 = Instance.new("Frame");

    for i, v in v343 do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame3;
    Frame4.Position = UDim2.fromOffset(14, 14);
    Frame4.Size = UDim2.fromOffset(214, 32);
    corner(Frame4, UDim.new(0.5, 0));
    local v344 = Color3_new_ret2;
    local v345 = {
        Thickness = 2.5,
        Transparency = 0,
        Color = v344,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v344 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke8 = Instance.new("UIStroke");

    for i, v in v345 do
        UIStroke8[i] = v;
    end;

    UIStroke8.Parent = Frame4;
    local v346 = text(Frame4, "Text", offer.Eyebrow or "LIMITED", 16, Color3_new_ret, {
        TextWrapped = false,
        FontFace = Font_new_ret3,
        Position = UDim2.fromOffset(12, 0),
        Size = UDim2.new(1, -24, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    v346.TextScaled = true;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 16
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = v346;
    local v347 = text(Frame3, "Tip", "DRAG TO ROTATE", 13, Color3_fromRGB_ret4, {
        TextWrapped = false,
        TextTransparency = 0.2,
        ZIndex = 3,
        TextXAlignment = Enum.TextXAlignment.Center
    });
    v347.Position = UDim2.fromOffset(0, 270);
    v347.Size = UDim2.fromOffset(428, 20);
    local u348;

    if u317 == u3[1] then
        u348 = u3[2];
    else
        u348 = u3[1];
    end;

    local v349 = button(Frame3, "Other", u348.name .. "  ›", 15, { u348.color:Lerp(Color3_new_ret, 0.1), u348.deep }, u348.light);
    local button2 = v349.button;
    local Vector2_new_ret6 = Vector2.new(1, 0);
    button2.Position = UDim2.fromOffset(414, 14);
    button2.Size = UDim2.fromOffset(146, 32);

    if Vector2_new_ret6 then
        button2.AnchorPoint = Vector2_new_ret6;
    end;

    v349.label.Position = UDim2.new(0.5, 13, 0.5, 0);
    v349.label.Size = UDim2.new(1, -52, 1, -8);
    glyph(v349.button, u348.icon, 18, {
        ZIndex = 2,
        Position = UDim2.fromOffset(8, 0),
        Size = UDim2.fromOffset(28, 32)
    });
    local shines = u316.shines;
    local v350 = shine(Frame3, 18);
    table.insert(shines, v350);
    local v351 = text(Frame, "Tagline", offer.Tagline or "", 23, u317.light, {
        TextWrapped = false,
        FontFace = Font_new_ret3
    });
    v351.TextScaled = true;
    local UITextSizeConstraint2 = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 23
    } do
        UITextSizeConstraint2[i] = v;
    end;

    UITextSizeConstraint2.Parent = v351;
    v351.Position = UDim2.fromOffset(26, 412);
    v351.Size = UDim2.fromOffset(424, 30);
    local v352 = text(Frame, "Description", offer.Description or "", 16, Color3_fromRGB_ret4, {
        FontFace = Font_new_ret,
        TextYAlignment = Enum.TextYAlignment.Top
    });
    v352.Position = UDim2.fromOffset(26, 446);
    v352.Size = UDim2.fromOffset(424, 64);
    local v353 = text(Frame, "Message", "✓  YOURS TO KEEP AFTER THE EVENT", 15, Color3_fromRGB_ret12, {
        TextWrapped = false
    });
    v353.Position = UDim2.fromOffset(26, 516);
    v353.Size = UDim2.fromOffset(424, 22);
    u316.message = v353;
    buyRow(u316, u317, Frame, 24, 546, 428, 70, 30);
    local v354;

    if v319 then
        v354 = v319.Accent;
    else
        v354 = u317.light;
    end;

    local v355 = tile(Frame, "Ability", 476, 102, 540, 150, v354);
    local v356 = {
        Name = "Badge",
        BorderSizePixel = 0,
        BackgroundColor3 = Color3_new_ret
    };
    local Frame5 = Instance.new("Frame");

    for i, v in v356 do
        Frame5[i] = v;
    end;

    Frame5.Parent = v355;
    Frame5.Position = UDim2.fromOffset(14, 14);
    Frame5.Size = UDim2.fromOffset(122, 122);
    local v357 = {
        CornerRadius = UDim.new(0, 18)
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v357 do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = Frame5;
    local v358 = {};
    local v359;

    if v319 then
        v359 = v319.AccentDark;
    else
        v359 = u317.deep;
    end;

    v358[1], v358[2] = v354, v359;
    tint(Frame5, v358);
    local v360 = Color3_new_ret2;
    local v361 = {
        Thickness = 3,
        Transparency = 0,
        Color = v360,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v360 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke9 = Instance.new("UIStroke");

    for i, v in v361 do
        UIStroke9[i] = v;
    end;

    UIStroke9.Parent = Frame5;
    glyph(Frame5, u317.power, 60, {
        Size = UDim2.fromScale(1, 1)
    });
    local v362 = text(v355, "Eyebrow", "KNIFE ABILITY · RUNNERS AND CHASERS", 13, v354, {
        TextWrapped = false
    });
    v362.Position = UDim2.fromOffset(152, 14);
    v362.Size = UDim2.fromOffset(372, 16);
    local v363 = text(v355, "Name", not v319 and "ABILITY" or string.upper(v319.Label), 32, Color3_new_ret, {
        TextWrapped = false,
        FontFace = Font_new_ret3
    });
    v363.TextScaled = true;
    local UITextSizeConstraint3 = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 32
    } do
        UITextSizeConstraint3[i] = v;
    end;

    UITextSizeConstraint3.Parent = v363;
    v363.Position = UDim2.fromOffset(152, 30);
    v363.Size = UDim2.fromOffset(372, 38);
    local v364 = text(v355, "Does", v320, 16, Color3_fromRGB_ret4, {
        FontFace = Font_new_ret,
        TextYAlignment = Enum.TextYAlignment.Top
    });
    v364.Position = UDim2.fromOffset(152, 70);
    v364.Size = UDim2.fromOffset(372, 40);
    local v365 = { "R · L1 · TAP" };

    if v319 then
        table.insert(v365, 1, v319.Cooldown .. "s COOLDOWN");
    end;

    for i, v in v365 do
        local v366 = {
            Name = "Stat",
            BorderSizePixel = 0,
            BackgroundColor3 = Color3_fromRGB_ret2
        };
        local Frame6 = Instance.new("Frame");

        for i2, v2 in v366 do
            Frame6[i2] = v2;
        end;

        Frame6.Parent = v355;
        Frame6.Position = UDim2.fromOffset(152 + (i - 1) * 150, 110);
        Frame6.Size = UDim2.fromOffset(140, 28);
        corner(Frame6, UDim.new(0.5, 0));
        local v367 = {
            Thickness = 1.5,
            Transparency = 0.2,
            Color = v354,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            ZIndex = v354 == Color3_new_ret2 and 1 or 2
        };
        local UIStroke10 = Instance.new("UIStroke");

        for i2, v2 in v367 do
            UIStroke10[i2] = v2;
        end;

        UIStroke10.Parent = Frame6;
        local v368 = text(Frame6, "Text", v, 14, Color3_new_ret, {
            TextWrapped = false,
            Size = UDim2.fromScale(1, 1),
            TextXAlignment = Enum.TextXAlignment.Center
        });
        v368.TextScaled = true;
        local UITextSizeConstraint4 = Instance.new("UITextSizeConstraint");

        for i2, v2 in {
            MaxTextSize = 14
        } do
            UITextSizeConstraint4[i2] = v2;
        end;

        UITextSizeConstraint4.Parent = v368;
    end;

    local v369 = tile(Frame, "Emote", 476, 264, 264, 150, Color3_fromRGB_ret6);
    local v370 = {
        Name = "Pose",
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-0.4, -1, -0.6),
        Ambient = Color3.fromRGB(190, 190, 196),
        LightColor = Color3_new_ret
    };
    local ViewportFrame2 = Instance.new("ViewportFrame");

    for i, v in v370 do
        ViewportFrame2[i] = v;
    end;

    ViewportFrame2.Parent = v369;
    ViewportFrame2.Position = UDim2.fromOffset(6, 6);
    ViewportFrame2.Size = UDim2.fromOffset(112, 138);
    local v371, v372;

    if u321 then
        v371, v372 = pcall(EmotePose.new, ViewportFrame2, u321.Id);

        if not v371 and os.clock() - u16 >= 30 then
            u16 = os.clock();
            warn("[EventKnivesOffer] " .. "emote pose failed" .. ": " .. tostring(v372));
        end;
    else
        v371 = false;
        v372 = nil;
    end;

    if v371 and v372 then
        u316.pose = v372;
        table.insert(u316.previews, v372);
    else
        glyph(v369, "💃", 56, {
            Position = UDim2.fromOffset(6, 6),
            Size = UDim2.fromOffset(112, 138)
        });
    end;

    local TextButton2 = Instance.new("TextButton");

    for i, v in {
        Name = "PlayPose",
        Text = "",
        BackgroundTransparency = 1,
        Selectable = false
    } do
        TextButton2[i] = v;
    end;

    TextButton2.Parent = v369;
    TextButton2.Position = UDim2.fromOffset(6, 6);
    TextButton2.Size = UDim2.fromOffset(112, 138);
    local v373 = text(v369, "Eyebrow", "EMOTE INCLUDED", 13, Color3_fromRGB_ret6, {
        TextWrapped = false
    });
    v373.Position = UDim2.fromOffset(126, 14);
    v373.Size = UDim2.fromOffset(130, 16);
    local v374 = text(v369, "Name", not u321 and "" or string.upper(u321.Name), 22, Color3_new_ret, {
        FontFace = Font_new_ret3
    });
    v374.TextScaled = true;
    local UITextSizeConstraint4 = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 22
    } do
        UITextSizeConstraint4[i] = v;
    end;

    UITextSizeConstraint4.Parent = v374;
    v374.Position = UDim2.fromOffset(126, 32);
    v374.Size = UDim2.fromOffset(128, 56);
    local v375 = button(v369, "WatchEmote", "▶  PLAY", 16, { Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret6, 0.25), Color3_fromRGB_ret2 }, Color3_fromRGB_ret6);
    local button3 = v375.button;
    button3.Position = UDim2.fromOffset(126, 98);
    button3.Size = UDim2.fromOffset(124, 38);
    v375.button.Visible = u321 ~= nil;
    local v376 = tile(Frame, "Show", 752, 264, 264, 150, u317.light);
    local v377 = {
        Name = "Turf",
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame6 = Instance.new("Frame");

    for i, v in v377 do
        Frame6[i] = v;
    end;

    Frame6.Parent = v376;
    local v378 = {
        CornerRadius = UDim.new(0, 16)
    };
    local UICorner4 = Instance.new("UICorner");

    for i, v in v378 do
        UICorner4[i] = v;
    end;

    UICorner4.Parent = Frame6;
    tint(Frame6, { Color3.fromRGB(58, 140, 66), Color3.fromRGB(24, 70, 32) });
    field(Frame6, u317, 264, 150);
    local v379 = text(v376, "Eyebrow", "HERO CUTSCENE", 13, Color3_fromRGB_ret6, {
        TextWrapped = false
    });
    v379.Position = UDim2.fromOffset(16, 14);
    v379.Size = UDim2.fromOffset(232, 16);
    local v380 = text(v376, "Name", string.upper(u318 and (u318.Collection or "") or "") .. " SHOW", 24, Color3_new_ret, {
        TextWrapped = false,
        FontFace = Font_new_ret3
    });
    v380.TextScaled = true;
    local UITextSizeConstraint5 = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 24
    } do
        UITextSizeConstraint5[i] = v;
    end;

    UITextSizeConstraint5.Parent = v380;
    v380.Position = UDim2.fromOffset(16, 32);
    v380.Size = UDim2.fromOffset(232, 30);
    local v381 = text(v376, "Line", string.match(offer.Footnote or "", "%.%s+(.+)$") or "", 14, Color3_fromRGB_ret4, {
        FontFace = Font_new_ret,
        TextYAlignment = Enum.TextYAlignment.Top
    });
    v381.Position = UDim2.fromOffset(16, 66);
    v381.Size = UDim2.fromOffset(232, 72);
    local v382 = button(Frame, "HeroCutscene", "VIEW HERO CUTSCENE", 26, { Color3_fromRGB_ret6, Color3_fromRGB_ret7 }, Color3_fromRGB_ret6);
    local button4 = v382.button;
    button4.Position = UDim2.fromOffset(476, 428);
    button4.Size = UDim2.fromOffset(540, 66);
    v382.label.Position = UDim2.new(0.5, 22, 0.5, 0);
    v382.label.Size = UDim2.new(1, -110, 1, -10);
    glyph(v382.button, "🎬", 30, {
        ZIndex = 2,
        Position = UDim2.fromOffset(22, 0),
        Size = UDim2.fromOffset(52, 66)
    });
    local shines2 = u316.shines;
    local v383 = shine(v382.button, UDim.new(0.24, 0));
    table.insert(shines2, v383);
    local v384;

    if u318 == nil then
        v384 = false;
    else
        v384 = u318.Show ~= nil;
    end;

    v382.button.Visible = v384;
    local v385 = text(Frame, "SoundsCaption", "SOUNDS\n& MOVES", 14, Color3_fromRGB_ret6, {
        TextWrapped = false
    });
    v385.Position = UDim2.fromOffset(478, 508);
    v385.Size = UDim2.fromOffset(108, 44);
    local v386 = {};

    for i, v in { { "Equip", "DRAW" }, { "Swing", "SWING" }, { "Hit", "HIT" } } do
        local v387 = button(Frame, v[1] .. "Preview", v[2], 18, { Color3_fromRGB_ret:Lerp(u317.color, 0.3), Color3_fromRGB_ret2 }, u317.light);
        local button5 = v387.button;
        button5.Position = UDim2.fromOffset(596 + (i - 1) * 142, 506);
        button5.Size = UDim2.fromOffset(134, 48);
        v387.label.Position = UDim2.new(0.5, 14, 0.5, 0);
        v387.label.Size = UDim2.new(1, -56, 1, -10);
        local button6 = v387.button;
        local v388 = {
            Name = "Icon",
            BackgroundTransparency = 1,
            Image = "rbxassetid://131542353379801",
            ZIndex = 2,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 14, 0.5, 0),
            Size = UDim2.fromOffset(24, 24),
            ScaleType = Enum.ScaleType.Fit
        };
        local ImageLabel = Instance.new("ImageLabel");

        for i2, v2 in v388 do
            ImageLabel[i2] = v2;
        end;

        ImageLabel.Parent = button6;
        v386[v387.button] = v[1];
    end;

    local v389 = text(Frame, "Footnote", offer.Footnote or "", 14, Color3_fromRGB_ret5, {
        FontFace = Font_new_ret,
        TextYAlignment = Enum.TextYAlignment.Top
    });
    v389.Position = UDim2.fromOffset(478, 568);
    v389.Size = UDim2.fromOffset(538, 50);

    local function on(p390, p391) -- Line: 1316
        -- upvalues: u316 (copy)
        table.insert(u316.connections, p390:Connect(p391));
    end;

    table.insert(u316.connections, TextButton.Activated:Connect(function() -- Line: 1319
        -- upvalues: u316 (copy)
        u316:close("Button");
    end));
    table.insert(u316.connections, v349.button.Activated:Connect(function() -- Line: 1322
        -- upvalues: sound (ref), u5 (ref), u348 (copy), u316 (copy)
        sound("Click");
        u5.details(u348.skin, u316.hooks.options);
    end));
    table.insert(u316.connections, TextButton2.Activated:Connect(function() -- Line: 1326
        -- upvalues: u316 (copy)
        if u316.pose then
            u316.pose:play();
        end;
    end));
    table.insert(u316.connections, v375.button.Activated:Connect(function() -- Line: 1331
        -- upvalues: u316 (copy), u317 (copy), u321 (copy), Parent (ref)
        local skin = u317.skin;
        local v392 = "Emote:" .. u321.Id;
        local v393 = u316.hooks.cues or Parent.Audio:FindFirstChild("PresentationCues");

        if v393 then
            v393:Fire("KnifePreview", skin, v392);
        end;
    end));
    table.insert(u316.connections, v382.button.Activated:Connect(function() -- Line: 1334
        -- upvalues: sound (ref), u316 (copy), u317 (copy), u318 (copy), Parent (ref)
        sound("Click");
        local skin = u317.skin;
        local Show = u318.Show;
        local v394 = u316.hooks.cues or Parent.Audio:FindFirstChild("PresentationCues");

        if v394 then
            v394:Fire("KnifePreview", skin, Show);
        end;
    end));

    for i, v in v386 do
        table.insert(u316.connections, i.Activated:Connect(function() -- Line: 1339
            -- upvalues: u316 (copy), u317 (copy), v (copy), Parent (ref)
            local skin = u317.skin;
            local v395 = v;
            local v396 = u316.hooks.cues or Parent.Audio:FindFirstChild("PresentationCues");

            if v396 then
                v396:Fire("KnifePreview", skin, v395);
            end;
        end));
    end;
end;

local function fitDetails(p397) -- Line: 1345
    -- upvalues: Vector2_new_ret5 (copy)
    local AbsoluteSize = p397.gui.AbsoluteSize;

    if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
        p397.fit = math.min(AbsoluteSize.X * 0.94 / Vector2_new_ret5.X, AbsoluteSize.Y * 0.94 / Vector2_new_ret5.Y, 1.2);
    end;
end;

local function stepDetails(p398, p399) -- Line: 1352
    -- upvalues: u15 (ref), TweenService (copy)
    if not p398.gui.Parent then
        p398:close("Destroyed");

        return;
    end;

    if p398.gui.Parent:FindFirstChild("KnifeClipPreview") then
        u15 = os.clock();
    end;

    p398.clock = p398.clock + p399;
    local clock = p398.clock;
    local Value = TweenService:GetValue(math.min(1, clock / 0.25), Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    p398.scale.Scale = (p398.fit or 1) * (0.9 + 0.1 * Value);

    for _, v in p398.previews do
        v:step(p399);
    end;

    for _, v in p398.halos do
        v.Rotation = (v.Rotation + p399 * 12) % 360;
    end;

    for i, v in p398.shines do
        local v400 = math.min(1, (clock + (i - 1) * 1.1) % 4.5 / 0.9) * 2 + -1;

        if v.Offset.X ~= v400 then
            v.Offset = Vector2.new(v400, 0);
        end;
    end;

    p398.countdown.dot.BackgroundTransparency = 0.45 - math.cos(clock * 4) * 0.45;
    p398.check = p398.check - p399;

    if p398.check <= 0 then
        p398.check = 0.25;
        p398:paint();
    end;
end;

function u5.details(p401, p402) -- Line: 1383
    -- upvalues: u4 (copy), LocalPlayer (copy), u12 (ref), hooks (copy), u297 (copy), Color3_new_ret2 (copy), build (copy), u9 (copy), u10 (ref), ArmoryEvent (copy), u8 (ref), Vector2_new_ret5 (copy), UserInputService (copy), overlaid (copy), GiftClient (copy), RunService (copy), stepDetails (copy), Cursor (copy), ContextActionService (copy), back (copy), u2 (copy), sound (copy), u14 (ref), GamepadService (copy)
    local v403 = u4[p401];
    local u404 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not (v403 and (u404 and LocalPlayer:GetAttribute("InMatch") ~= true)) then
        return false;
    end;

    if u12 then
        if u12.knife == v403 then
            return true;
        end;

        u12:close("Replaced");
    end;

    local v405 = {
        Name = "EventKnives",
        DisplayOrder = 80,
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local ScreenGui = Instance.new("ScreenGui");

    for i, v in v405 do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = nil;
    ScreenGui:SetAttribute("SelfManagedText", true);
    local v406 = {
        clock = 0,
        check = 0,
        knife = v403,
        gui = ScreenGui,
        hooks = hooks(p402),
        connections = {},
        previews = {},
        halos = {},
        shines = {},
        rows = {}
    };
    local u407 = setmetatable(v406, u297);
    u407.hooks.notice = nil;
    local v408 = {
        Name = "Shade",
        BackgroundTransparency = 0.4,
        AutoButtonColor = false,
        Selectable = false,
        Text = "",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret2
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v408 do
        TextButton[i] = v;
    end;

    TextButton.Parent = ScreenGui;
    build(u407, v403);
    u12 = u407;
    u9[u407] = true;

    if not u10 then
        u10 = ArmoryEvent.OnClientEvent:Connect(function(p409, p410) -- Line: 163
            -- upvalues: u8 (ref), u9 (ref)
            if p409 == "State" and type(p410) == "table" then
                u8 = p410;

                for i in u9 do
                    i:paint();
                end;
            end;
        end);
    end;

    local function _(p411, p412) -- Line: 1431
        -- upvalues: u407 (copy)
        table.insert(u407.connections, p411:Connect(p412));
    end;

    table.insert(u407.connections, TextButton.Activated:Connect(function() -- Line: 1434
        -- upvalues: u407 (copy)
        u407:close("Outside");
    end));
    local PropertyChangedSignal = ScreenGui:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(u407.connections, PropertyChangedSignal:Connect(function() -- Line: 1437
        -- upvalues: u407 (copy), Vector2_new_ret5 (ref)
        local v413 = u407;
        local AbsoluteSize = v413.gui.AbsoluteSize;

        if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
            v413.fit = math.min(AbsoluteSize.X * 0.94 / Vector2_new_ret5.X, AbsoluteSize.Y * 0.94 / Vector2_new_ret5.Y, 1.2);
        end;
    end));
    table.insert(u407.connections, UserInputService.InputBegan:Connect(function(p414, p415) -- Line: 1440
        -- upvalues: overlaid (ref), u404 (copy), u407 (copy)
        if not (p415 or (p414.KeyCode ~= Enum.KeyCode.Escape or overlaid(u404))) then
            u407:close("Back");
        end;
    end));

    if LocalPlayer:GetAttribute("ArmoryOpen") == true then
        local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("ArmoryOpen");
        table.insert(u407.connections, AttributeChangedSignal:Connect(function() -- Line: 1447
            -- upvalues: LocalPlayer (ref), u407 (copy)
            if LocalPlayer:GetAttribute("ArmoryOpen") ~= true then
                u407:close("Shop");
            end;
        end));
    end;

    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
    table.insert(u407.connections, AttributeChangedSignal:Connect(function() -- Line: 1453
        -- upvalues: LocalPlayer (ref), u407 (copy)
        if LocalPlayer:GetAttribute("InMatch") == true then
            u407:close("Match");
        end;
    end));
    local AttributeChangedSignal2 = LocalPlayer:GetAttributeChangedSignal("GiftOpen");
    table.insert(u407.connections, AttributeChangedSignal2:Connect(function() -- Line: 1458
        -- upvalues: u407 (copy)
        u407:paint();
    end));
    table.insert(u407.connections, GiftClient.changed:Connect(function() -- Line: 1461
        -- upvalues: u407 (copy)
        u407:paint();
    end));
    table.insert(u407.connections, RunService.RenderStepped:Connect(function(p416) -- Line: 1464
        -- upvalues: stepDetails (ref), u407 (copy)
        stepDetails(u407, p416);
    end));
    ScreenGui.Parent = u404;
    local AbsoluteSize = u407.gui.AbsoluteSize;

    if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
        u407.fit = math.min(AbsoluteSize.X * 0.94 / Vector2_new_ret5.X, AbsoluteSize.Y * 0.94 / Vector2_new_ret5.Y, 1.2);
    end;

    u407.scale.Scale = (u407.fit or 1) * 0.9;
    Cursor.request(ScreenGui);
    ContextActionService:BindActionAtPriority("EventKnivesBack", back, false, u2, Enum.KeyCode.ButtonB);
    LocalPlayer:SetAttribute("EventKnivesOpen", true);
    sound("PanelOpen");

    if u8 == nil then
        ArmoryEvent:FireServer("Get");
    end;

    u407:paint();
    task.defer(function() -- Line: 1480
        -- upvalues: u12 (ref), u407 (copy), u14 (ref), UserInputService (ref), GamepadService (ref)
        if u12 == u407 and not (u14 or (UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad or GamepadService.GamepadCursorEnabled)) then
            u14 = pcall(GamepadService.EnableGamepadCursor, GamepadService, u407.panel);
        end;
    end);

    return true;
end;

function u297.paint(p417) -- Line: 1493
    -- upvalues: u12 (ref), setCountdown (copy), paintRow (copy), Color3_fromRGB_ret12 (copy)
    if u12 ~= p417 then
        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    setCountdown(p417.countdown, ServerTimeNow);

    for _, v in p417.rows do
        paintRow(p417, v, ServerTimeNow);
    end;

    if p417.messageUntil and os.clock() > p417.messageUntil then
        p417.messageUntil = nil;
        p417.message.Text = "✓  YOURS TO KEEP AFTER THE EVENT";
        p417.message.TextColor3 = Color3_fromRGB_ret12;
    end;
end;

function u297.close(p418, p419) -- Line: 1509
    -- upvalues: u12 (ref), ContextActionService (copy), u9 (copy), u10 (ref), u8 (ref), u11 (copy), Cursor (copy), u14 (ref), GamepadService (copy), LocalPlayer (copy), u13 (ref), sound (copy)
    if u12 ~= p418 then
        return;
    end;

    u12 = nil;
    ContextActionService:UnbindAction("EventKnivesBack");

    for _, v in p418.connections do
        v:Disconnect();
    end;

    table.clear(p418.connections);

    for _, v in p418.previews do
        v:destroy();
    end;

    table.clear(p418.previews);
    table.clear(p418.rows);
    p418.pose = nil;
    u9[p418] = nil;

    if u10 and next(u9) == nil then
        u10:Disconnect();
        u10 = nil;
        u8 = nil;
        table.clear(u11);
    end;

    Cursor.release(p418.gui);

    if u14 then
        u14 = false;

        if GamepadService.GamepadCursorEnabled then
            pcall(GamepadService.DisableGamepadCursor, GamepadService);
        end;
    end;

    p418.gui:Destroy();
    LocalPlayer:SetAttribute("EventKnivesOpen", u13 and true or nil);

    if p419 ~= "Replaced" and p419 ~= "Destroyed" then
        sound("PanelClose");
    end;
end;

function u5.close() -- Line: 1541
    -- upvalues: u12 (ref)
    if u12 then
        u12:close("Closed");
    end;
end;

function u5.isOpen() -- Line: 1547
    -- upvalues: u12 (ref)
    return u12 ~= nil;
end;

function u5.popup(p420) -- Line: 1556
    -- upvalues: LocalPlayer (copy), u13 (ref), u5 (copy), Color3_new_ret2 (copy), Vector2_new_ret (copy), Font_new_ret3 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret13 (copy), ContextActionService (copy), u12 (ref), Cursor (copy), GamepadService (copy), sound (copy), UserInputService (copy), overlaid (copy), u2 (copy), u8 (ref), ArmoryEvent (copy)
    local u421 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if u13 then
        return true;
    end;

    if not (u421 and (LocalPlayer:GetAttribute("InMatch") ~= true and u5.active())) then
        return false;
    end;

    local v422 = {
        Name = "EventKnivesPopup",
        DisplayOrder = 79,
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local ScreenGui = Instance.new("ScreenGui");
    local v423 = p420 or {};

    for i, v in v422 do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = nil;
    ScreenGui:SetAttribute("SelfManagedText", true);
    local v424 = {
        Name = "Shade",
        BackgroundTransparency = 0.35,
        AutoButtonColor = false,
        Selectable = false,
        Text = "",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret2
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v424 do
        TextButton[i] = v;
    end;

    TextButton.Parent = ScreenGui;
    local v425 = {
        Name = "Heading",
        BackgroundTransparency = 1,
        TextScaled = true,
        AutoLocalize = false,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromScale(0.5, 0.075),
        Size = UDim2.fromScale(0.8, 0.075),
        FontFace = Font_new_ret3,
        Text = v423.heading or "GEAR UP FOR GAME DAY!",
        TextColor3 = Color3_fromRGB_ret6
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v425 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = ScreenGui;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 44
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = TextLabel;
    local v426 = {
        Thickness = 3,
        Color = Color3_new_ret2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v426 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;
    local v427 = {
        Name = "Box",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromScale(0.5, 0.555),
        Size = UDim2.fromScale(0.94, 0.8)
    };
    local Frame = Instance.new("Frame");

    for i, v in v427 do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    local v428 = {
        AspectRatio = u5.WIDE_ASPECT
    };
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");

    for i, v in v428 do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = Frame;
    local u429 = {
        gui = ScreenGui,
        connections = {}
    };
    u13 = u429;
    u429.card = u5.card(Frame, v423);
    local v430 = {
        Name = "Close",
        AutoButtonColor = true,
        Text = "X",
        TextSize = 26,
        ZIndex = 20,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.new(1, -6, 0, 6),
        Size = UDim2.fromOffset(46, 46),
        BackgroundColor3 = Color3_fromRGB_ret2,
        FontFace = Font_new_ret3,
        TextColor3 = Color3_fromRGB_ret13
    };
    local TextButton2 = Instance.new("TextButton");

    for i, v in v430 do
        TextButton2[i] = v;
    end;

    TextButton2.Parent = Frame;
    local v431 = {
        CornerRadius = UDim.new(0, 23)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v431 do
        UICorner[i] = v;
    end;

    UICorner.Parent = TextButton2;
    local v432 = Color3_new_ret2;
    local v433 = {
        Thickness = 3,
        Transparency = 0,
        Color = v432,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v432 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v433 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = TextButton2;
    local v434 = Color3_fromRGB_ret6;
    local v435 = {
        Thickness = 1.5,
        Transparency = 0,
        Color = v434,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = v434 == Color3_new_ret2 and 1 or 2
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v435 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = TextButton2;

    local function _(p436, p437) -- Line: 1623
        -- upvalues: u429 (copy)
        table.insert(u429.connections, p436:Connect(p437));
    end;

    local function shut() -- Line: 1626
        -- upvalues: u13 (ref), u429 (copy), ContextActionService (ref), u12 (ref), Cursor (ref), ScreenGui (copy), GamepadService (ref), LocalPlayer (ref), sound (ref)
        if u13 ~= u429 then
            return;
        end;

        u13 = nil;
        ContextActionService:UnbindAction("EventKnivesPopupBack");

        for _, v in u429.connections do
            v:Disconnect();
        end;

        table.clear(u429.connections);

        if u12 then
            u12:close("Closed");
        end;

        u429.card:destroy();
        Cursor.release(ScreenGui);

        if u429.cursorOwned and GamepadService.GamepadCursorEnabled then
            pcall(GamepadService.DisableGamepadCursor, GamepadService);
        end;

        ScreenGui:Destroy();
        LocalPlayer:SetAttribute("EventKnivesOpen", nil);
        sound("PanelClose");
    end;

    u429.close = shut;
    table.insert(u429.connections, TextButton.Activated:Connect(shut));
    table.insert(u429.connections, TextButton2.Activated:Connect(shut));
    table.insert(u429.connections, UserInputService.InputBegan:Connect(function(p438, p439) -- Line: 1651
        -- upvalues: u12 (ref), overlaid (ref), u421 (copy), shut (copy)
        if not (p439 or (p438.KeyCode ~= Enum.KeyCode.Escape or (u12 or overlaid(u421)))) then
            shut();
        end;
    end));
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
    table.insert(u429.connections, AttributeChangedSignal:Connect(function() -- Line: 1656
        -- upvalues: LocalPlayer (ref), shut (copy)
        if LocalPlayer:GetAttribute("InMatch") == true then
            shut();
        end;
    end));
    ScreenGui.Parent = u421;
    Cursor.request(ScreenGui);
    ContextActionService:BindActionAtPriority("EventKnivesPopupBack", function(p440, p441) -- Line: 1664
        -- upvalues: u12 (ref), overlaid (ref), u421 (copy), shut (copy)
        if p441 ~= Enum.UserInputState.Begin or (u12 or overlaid(u421)) then
            return Enum.ContextActionResult.Pass;
        end;

        shut();

        return Enum.ContextActionResult.Sink;
    end, false, u2 - 50, Enum.KeyCode.ButtonB);
    LocalPlayer:SetAttribute("EventKnivesOpen", true);
    sound("PanelOpen");

    if u8 == nil then
        ArmoryEvent:FireServer("Get");
    end;

    task.defer(function() -- Line: 1676
        -- upvalues: u13 (ref), u429 (copy), UserInputService (ref), GamepadService (ref), Frame (copy)
        if u13 == u429 and (UserInputService.PreferredInput == Enum.PreferredInput.Gamepad and not GamepadService.GamepadCursorEnabled) then
            u429.cursorOwned = pcall(GamepadService.EnableGamepadCursor, GamepadService, Frame);
        end;
    end);

    return true;
end;

function u5.closePopup() -- Line: 1688
    -- upvalues: u13 (ref)
    if u13 then
        u13.close();
    end;
end;

function u5.active(p442) -- Line: 1696
    -- upvalues: u3 (copy), OfferRules (copy)
    local v443 = p442 or workspace:GetServerTimeNow();

    for _, v in u3 do
        if not OfferRules.active(v.offer, v443) then
            return false;
        end;
    end;

    return true;
end;

function u5.shown(p444, p445, p446) -- Line: 1708
    -- upvalues: u5 (copy)
    return u5.active(p445);
end;

function u5.height(p447, p448) -- Line: 1712
    -- upvalues: Vector2_new_ret3 (copy), Vector2_new_ret2 (copy)
    local v449;

    if p448 then
        v449 = Vector2_new_ret3;
    else
        v449 = Vector2_new_ret2;
    end;

    return math.floor(p447 * v449.Y / v449.X + 0.5);
end;

u5.WIDE_ASPECT = Vector2_new_ret2.X / Vector2_new_ret2.Y;
u5.TALL_ASPECT = Vector2_new_ret3.X / Vector2_new_ret3.Y;

return u5;