 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {};
local Color3_fromHex = Color3.fromHex;
local Color3_new_ret = Color3.new(0, 0, 0);
local Color3_new_ret2 = Color3.new(1, 1, 1);
local Border = Enum.ApplyStrokeMode.Border;
local Contextual = Enum.ApplyStrokeMode.Contextual;
local FixedSize = Enum.StrokeSizingMode.FixedSize;
local Round = Enum.LineJoinMode.Round;
local Inner = Enum.BorderStrokePosition.Inner;
local Outer = Enum.BorderStrokePosition.Outer;
local Global = Enum.ZIndexBehavior.Global;
local Fit = Enum.ScaleType.Fit;
local table_freeze_ret = table.freeze({});
u1.Assets = table.freeze({
    Checker = "rbxassetid://140022482252277",
    Coin = "rbxassetid://78008558948307",
    GemWallet = "rbxassetid://137046122108742",
    GemPrice = "rbxassetid://137046122108742",
    GemLarge = "rbxassetid://137046122108742",
    Gear = "rbxassetid://120975496530042",
    Decoration = "rbxassetid://110634171608077",
    DecorationWide = "rbxassetid://126123908738735",
    Sunray = "rbxassetid://129028976496842",
    GlowGold = "rbxassetid://101867007295297",
    GlowWhite = "rbxassetid://120639974824188",
    Emote = "rbxassetid://117630660259402",
    Eye = "rbxassetid://3422318786",
    MapPin = "rbxassetid://93940402858085",
    Person = "rbxassetid://72729299014135",
    List = "rbxassetid://15567843390",
    Scroll = "rbxassetid://112957131627213",
    Sound = "rbxassetid://131542353379801",
    SoundMuted = "rbxassetid://130344237995259",
    Music = "rbxassetid://134448347476578",
    DoubleXP = "rbxassetid://115625186768119",
    VIP = "rbxassetid://87074524380839",
    StarterPack = "rbxassetid://129768808533257",
    Mouse = "rbxassetid://93091589699191",
    Cloak = "rbxassetid://134839019713281",
    Dagger = "rbxassetid://111671278699403",
    Portrait = "rbxassetid://79160656753755",
    Quests = "rbxassetid://109697384592866",
    Shop = "rbxassetid://123533013343628",
    AFK = "rbxassetid://82246120761300",
    AFKOff = "rbxassetid://111649034594254",
    EmoteButton = "rbxassetid://125247002833803",
    Journey = "rbxassetid://111238582328278",
    Spectate = "rbxassetid://81936886775429"
});
local Assets = u1.Assets;
u1.Icons = table.freeze({
    coin = Assets.Coin,
    coins = Assets.Coin,
    gem = Assets.GemWallet,
    gems = Assets.GemWallet,
    gemWallet = Assets.GemWallet,
    gemPrice = Assets.GemPrice,
    gemLarge = Assets.GemLarge,
    gear = Assets.Gear,
    settings = Assets.Gear,
    emote = Assets.Emote,
    eye = Assets.Eye,
    spectate = Assets.Spectate,
    pin = Assets.MapPin,
    map = Assets.MapPin,
    person = Assets.Person,
    votes = Assets.Person,
    list = Assets.List,
    servers = Assets.List,
    scroll = Assets.Scroll,
    updates = Assets.Scroll,
    sound = Assets.Sound,
    mute = Assets.SoundMuted,
    music = Assets.Music,
    xp2 = Assets.DoubleXP,
    vip = Assets.VIP,
    starterPack = Assets.StarterPack,
    mouse = Assets.Mouse,
    cloak = Assets.Cloak,
    dagger = Assets.Dagger,
    chaser = Assets.Dagger,
    portrait = Assets.Portrait,
    quests = Assets.Quests,
    sunray = Assets.Sunray,
    glow = Assets.GlowGold,
    glowWhite = Assets.GlowWhite,
    checker = Assets.Checker,
    shop = Assets.Shop,
    afk = Assets.AFK,
    afkOff = Assets.AFKOff,
    emoteButton = Assets.EmoteButton,
    journey = Assets.Journey
});
local table_freeze_ret2 = table.freeze({
    surface = Color3_fromHex("171719"),
    row = Color3_fromHex("1E1E21"),
    input = Color3_fromHex("0F0F11"),
    button = Color3_fromHex("26262A"),
    track = Color3_fromHex("373737"),
    trackThin = Color3_fromHex("37373C"),
    reel = Color3_fromHex("0E0E10"),
    avatar = Color3_fromHex("2D2D31"),
    header = Color3_new_ret,
    outline = Color3_new_ret,
    neutral = Color3_fromHex("4C4C51"),
    barRing = Color3_fromHex("5D5D5D"),
    greyRing = Color3_fromHex("BDBDBD"),
    knobRing = Color3_fromHex("BEBEBE"),
    text = Color3_new_ret2,
    textSecondary = Color3_fromHex("DEDEDE"),
    textBody = Color3_fromHex("CDCDD2"),
    textMuted = Color3_fromHex("898989"),
    gold = Color3_fromHex("FFCA3A"),
    goldDark = Color3_fromHex("E6A100"),
    gem = Color3_fromHex("A36EFF"),
    gemText = Color3_fromHex("57EB9F"),
    green = Color3_fromHex("50FF64"),
    greenDark = Color3_fromHex("11D528"),
    danger = Color3_fromHex("FF5050"),
    dangerDark = Color3_fromHex("D51111"),
    close = Color3_fromHex("FD3C55"),
    notice = Color3_fromHex("EB2D2D"),
    noticeRing = Color3_fromHex("121216"),
    robux = Color3_fromHex("DF50FF"),
    robuxDark = Color3_fromHex("A811D5"),
    robuxRing = Color3_fromHex("ED50FF"),
    unequip = Color3_fromHex("EB5252"),
    unequipDark = Color3_fromHex("962026"),
    unequipRing = Color3_fromHex("FF7878"),
    grey = Color3_fromHex("9E9E9E"),
    greyDark = Color3_fromHex("888888"),
    disabled = Color3_fromHex("7D7D7D"),
    disabledDark = Color3_fromHex("505050"),
    disabledRing = Color3_fromHex("6E6E6E"),
    blue = Color3_fromHex("0077FF"),
    blueLight = Color3_fromHex("00BBFF"),
    meter = Color3_fromHex("00AAFF"),
    xp = Color3_fromHex("FF9500"),
    xpLight = Color3_fromHex("FFA600"),
    xpRing = Color3_fromHex("FFD900"),
    timer = Color3_fromHex("FF0000"),
    round = Color3_fromHex("FD3C55"),
    boost = Color3_fromHex("6BE2BA"),
    runner = Color3_fromHex("9ED9EE"),
    hero = Color3_fromHex("FFCA56"),
    chicken = Color3_fromHex("5CADEE"),
    mvp = Color3_fromHex("FFCD70"),
    survival = Color3_fromHex("6BE2BA"),
    catches = Color3_fromHex("FF8288"),
    error = Color3_fromHex("FF5C5C"),
    unlocked = Color3_fromHex("97EBBB"),
    emoteOffer = Color3_fromHex("FF78C8")
});
u1.Palette = table_freeze_ret2;
u1.Rarity = table.freeze({
    Common = Color3_fromHex("AFB9C0"),
    Rare = Color3_fromHex("5CADEE"),
    Epic = Color3_fromHex("B77BF4"),
    Legendary = Color3_fromHex("F2BF59"),
    Mythical = Color3_fromHex("FF4860")
});
u1.Places = table.freeze({ Color3_fromHex("FFCA3A"), Color3_fromHex("A9A9A9"), Color3_fromHex("8E683B") });
u1.HudAccents = table.freeze({
    ability = table.freeze({ Color3_fromHex("AA96F5"), Color3_fromHex("685D92") }),
    chaser = table.freeze({ Color3_fromHex("FFB462"), Color3_fromHex("976D41") }),
    item = table.freeze({ Color3_fromHex("F2CF69"), Color3_fromHex("8F7C45") }),
    clone = table.freeze({ Color3_fromHex("68ACFF"), Color3_fromHex("446997") }),
    ghost = table.freeze({ Color3_fromHex("A6F2E8"), Color3_fromHex("668F8B") })
});
u1.Stroke = table.freeze({
    header = 1.5,
    badge = 1.5,
    text = 1.5,
    panel = table.freeze({ 3, 2 }),
    button = table.freeze({ 2, 2 }),
    card = table.freeze({ 2, 2 }),
    slot = table.freeze({ 2, 2 }),
    pill = table.freeze({ 2, 1.5 }),
    bar = table.freeze({ 1.5, 1 })
});
local u2 = {
    primary = table_freeze_ret2.text,
    secondary = table_freeze_ret2.textSecondary,
    body = table_freeze_ret2.textBody,
    muted = table_freeze_ret2.textMuted,
    gold = table_freeze_ret2.gold,
    coins = table_freeze_ret2.gold,
    gem = table_freeze_ret2.gemText,
    gems = table_freeze_ret2.gemText,
    green = table_freeze_ret2.green,
    success = table_freeze_ret2.green,
    danger = table_freeze_ret2.error,
    error = table_freeze_ret2.error,
    timer = table_freeze_ret2.timer,
    boost = table_freeze_ret2.boost,
    runner = table_freeze_ret2.runner,
    hero = table_freeze_ret2.hero,
    close = table_freeze_ret2.close
};

local function variant(p3, p4, p5, p6, p7) -- Line: 216
    -- upvalues: table_freeze_ret (copy)
    local v8 = {
        top = p3,
        bottom = p4,
        ring = p5,
        fade = p6 or 0,
        colors = ColorSequence.new(p3, p4),
        fades = NumberSequence.new(p6 or 0)
    };

    for i, v in p7 or table_freeze_ret do
        v8[i] = v;
    end;

    return table.freeze(v8);
end;

local u9 = {
    primary = variant(table_freeze_ret2.green, table_freeze_ret2.greenDark, table_freeze_ret2.green, 0.2),
    secondary = variant(table_freeze_ret2.grey, table_freeze_ret2.greyDark, table_freeze_ret2.greyRing, 0),
    danger = variant(table_freeze_ret2.danger, table_freeze_ret2.dangerDark, table_freeze_ret2.danger, 0.2),
    unequip = variant(table_freeze_ret2.unequip, table_freeze_ret2.unequipDark, table_freeze_ret2.unequipRing, 0),
    robux = variant(table_freeze_ret2.robux, table_freeze_ret2.robuxDark, table_freeze_ret2.robuxRing, 0),
    disabled = variant(table_freeze_ret2.disabled, table_freeze_ret2.disabledDark, table_freeze_ret2.disabledRing, 0, {
        dim = true
    }),
    dark = variant(table_freeze_ret2.surface, table_freeze_ret2.surface, table_freeze_ret2.neutral, 0, {
        flat = true
    }),
    close = table.freeze({
        glyph = true
    }),
    ["buy-coins"] = variant(table_freeze_ret2.gold, table_freeze_ret2.goldDark, table_freeze_ret2.gold, 0.2, {
        icon = "coin"
    }),
    ["buy-gems"] = variant(table_freeze_ret2.green, table_freeze_ret2.greenDark, table_freeze_ret2.green, 0.2, {
        icon = "gemPrice"
    })
};
u9["buy-robux"] = u9.robux;
u9.equip = u9.primary;
u9.green = u9.primary;
u9.grey = u9.secondary;
u9.locked = u9.secondary;
u9.premium = u9.robux;
u9.red = u9.danger;
u9.tertiary = u9.dark;
u1.Variants = table.freeze(u9);
local u10 = setmetatable({}, {
    __mode = "k"
});
local u11 = setmetatable({}, {
    __mode = "k"
});
local u12 = setmetatable({}, {
    __mode = "k"
});
local u13 = setmetatable({}, {
    __mode = "k"
});
local u14 = setmetatable({}, {
    __mode = "k"
});
local u15 = setmetatable({}, {
    __mode = "k"
});

local function isSkin(p16) -- Line: 257
    return string.sub(p16.Name, 1, 4) == "Skin";
end;

local function isText(p17) -- Line: 261
    return p17:IsA("TextLabel") or (p17:IsA("TextButton") or p17:IsA("TextBox"));
end;

local function isImage(p18) -- Line: 265
    return p18:IsA("ImageLabel") or p18:IsA("ImageButton");
end;

local function canGradient(p19) -- Line: 270
    if p19:IsA("Frame") or p19:IsA("CanvasGroup") then
        return true;
    end;

    local v20 = (p19:IsA("ImageLabel") or p19:IsA("ImageButton")) and p19.Image == "";

    return v20;
end;

local function get(p21, p22, p23) -- Line: 277
    local v24 = p21:FindFirstChild(p23);

    if v24 and v24.ClassName == p22 then
        return v24, false;
    end;

    local Instance_new_ret = Instance.new(p22);
    Instance_new_ret.Name = p23;

    return Instance_new_ret, true;
end;

local function skinZ(p25) -- Line: 288
    -- upvalues: Global (copy)
    local v26 = p25:FindFirstAncestorWhichIsA("LayerCollector");

    if v26 and v26.ZIndexBehavior == Global then
        return p25.ZIndex;
    end;

    local v27 = nil;

    for _, child in p25:GetChildren() do
        if child:IsA("GuiObject") and (string.sub(child.Name, 1, 4) ~= "Skin" and (v27 == nil or child.ZIndex < v27)) then
            v27 = child.ZIndex;
        end;
    end;

    return (v27 or 1) - 1;
end;

local function topZ(p28) -- Line: 303
    local ZIndex = p28.ZIndex;

    for _, child in p28:GetChildren() do
        if child:IsA("GuiObject") and (string.sub(child.Name, 1, 4) ~= "Skin" and ZIndex < child.ZIndex) then
            ZIndex = child.ZIndex;
        end;
    end;

    return ZIndex + 1;
end;

local function decor(p29, p30) -- Line: 313
    p29.AnchorPoint = Vector2.zero;
    p29.Position = UDim2.new();
    p29.Size = UDim2.fromScale(1, 1);
    p29.SizeConstraint = Enum.SizeConstraint.RelativeXY;
    p29.BackgroundTransparency = 1;
    p29.BorderSizePixel = 0;
    p29.Active = false;
    p29.Selectable = false;
    p29.Interactable = false;
    p29.ZIndex = p30;
    p29.Visible = true;
end;

local function style(p31, p32, p33, p34, p35) -- Line: 327
    -- upvalues: Border (copy), FixedSize (copy), Round (copy)
    p31.ApplyStrokeMode = Border;
    p31.StrokeSizingMode = FixedSize;
    p31.LineJoinMode = Round;
    p31.BorderStrokePosition = p34;
    p31.Color = p32;
    p31.Thickness = p33;
    p31.Transparency = p35 or 0;

    return p31;
end;

local function noOutline(p36) -- Line: 348
    local SkinOutline = p36:FindFirstChild("SkinOutline");

    if SkinOutline then
        SkinOutline.Enabled = false;
    end;
end;

local function findRing(p37) -- Line: 356
    -- upvalues: Border (copy)
    local Border2 = p37:FindFirstChild("Border");

    if Border2 and Border2:IsA("UIStroke") then
        return Border2;
    end;

    local Outline = p37:FindFirstChild("Outline");
    local v38 = p37:IsA("TextLabel") or (p37:IsA("TextButton") or p37:IsA("TextBox"));

    if Outline and (Outline:IsA("UIStroke") and (not v38 or Outline.ApplyStrokeMode == Border)) then
        return Outline;
    end;

    for _, child in p37:GetChildren() do
        if child:IsA("UIStroke") and (string.sub(child.Name, 1, 4) ~= "Skin" and (not v38 or child.ApplyStrokeMode == Border)) then
            return child;
        end;
    end;

    return nil;
end;

local function currentRing(p39) -- Line: 374
    -- upvalues: findRing (copy)
    return findRing(p39) or p39:FindFirstChild("SkinStroke");
end;

local function ring(p40, p41, p42, p43) -- Line: 378
    -- upvalues: findRing (copy), u14 (copy), Inner (copy), Border (copy), FixedSize (copy), Round (copy), u11 (copy)
    local v44 = findRing(p40);
    local SkinStroke = p40:FindFirstChild("SkinStroke");

    if v44 then
        if SkinStroke then
            SkinStroke.Enabled = false;
        end;

        if u14[p40] == v44 then
            u14[p40] = nil;
            v44.Enabled = true;
        end;
    else
        v44 = p40:FindFirstChild("SkinStroke");
        local v45;

        if v44 and v44.ClassName == "UIStroke" then
            v45 = false;
        else
            v44 = Instance.new("UIStroke");
            v44.Name = "SkinStroke";
            v45 = true;
        end;

        v44.Enabled = true;

        if v45 then
            v44.Parent = p40;
        end;
    end;

    v44.ApplyStrokeMode = Border;
    v44.StrokeSizingMode = FixedSize;
    v44.LineJoinMode = Round;
    v44.BorderStrokePosition = Inner;
    v44.Color = p41;
    v44.Thickness = p42 or 2;
    v44.Transparency = p43 or 0;
    u11[p40] = p41;

    return v44;
end;

local function applyCorner(p46, p47, p48) -- Line: 417
    if p47 == false then
        return;
    end;

    if p47 then
        local v49 = p46:FindFirstChildOfClass("UICorner");

        if not v49 then
            local UICorner = Instance.new("UICorner");
            UICorner.Name = "SkinCorner";
            UICorner.CornerRadius = p47 or UDim.new(0, 8);
            UICorner.Parent = p46;

            return;
        end;

        if p47 then
            v49.CornerRadius = p47;
        end;
    elseif not p46:FindFirstChildOfClass("UICorner") then
        local v50 = p46:FindFirstChildOfClass("UICorner");

        if v50 then
            if p48 then
                v50.CornerRadius = p48;
            end;
        else
            local UICorner = Instance.new("UICorner");
            UICorner.Name = "SkinCorner";
            UICorner.CornerRadius = p48 or UDim.new(0, 8);
            UICorner.Parent = p46;
        end;
    end;
end;

local function quietGradients(p51) -- Line: 428
    for _, child in p51:GetChildren() do
        if child:IsA("UIGradient") and child.Name ~= "SkinGradient" then
            child.Enabled = false;
        end;
    end;
end;

local function fill(p52, p53, p54, p55, p56, p57, p58) -- Line: 437
    -- upvalues: quietGradients (copy), Color3_new_ret2 (copy), u10 (copy)
    quietGradients(p52);
    p52.BorderSizePixel = 0;
    local SkinGradient = p52:FindFirstChild("SkinGradient");

    if p53 == p54 then
        if SkinGradient and SkinGradient:IsA("UIGradient") then
            SkinGradient.Enabled = false;
        end;

        p52.BackgroundColor3 = p53:Lerp(p54, p58 or 0.5);
    else
        local v59;

        if p52:IsA("Frame") or p52:IsA("CanvasGroup") then
            v59 = true;
        else
            v59 = (p52:IsA("ImageLabel") or p52:IsA("ImageButton")) and p52.Image == "";
        end;

        if v59 then
            local v60;

            if SkinGradient and SkinGradient:IsA("UIGradient") then
                v60 = false;
            else
                SkinGradient = Instance.new("UIGradient");
                SkinGradient.Name = "SkinGradient";
                v60 = true;
            end;

            SkinGradient.Color = p55 or ColorSequence.new(p53, p54);
            SkinGradient.Transparency = p56 or NumberSequence.new(0);
            SkinGradient.Rotation = p57 or 90;
            SkinGradient.Offset = Vector2.zero;
            SkinGradient.Enabled = true;

            if v60 then
                SkinGradient.Parent = p52;
            end;

            p52.BackgroundColor3 = Color3_new_ret2;
        else
            if SkinGradient and SkinGradient:IsA("UIGradient") then
                SkinGradient.Enabled = false;
            end;

            p52.BackgroundColor3 = p53:Lerp(p54, p58 or 0.5);
        end;
    end;

    u10[p52] = p52.BackgroundColor3;
end;

local function textStroke(p61, p62, p63) -- Line: 466
    -- upvalues: Contextual (copy), FixedSize (copy), Round (copy), Color3_new_ret (copy), u1 (copy)
    if not (p61:IsA("TextLabel") or (p61:IsA("TextButton") or p61:IsA("TextBox"))) then
        return nil;
    end;

    for _, child in p61:GetChildren() do
        if child:IsA("UIStroke") and (string.sub(child.Name, 1, 4) ~= "Skin" and child.ApplyStrokeMode == Contextual) then
            return child;
        end;
    end;

    local SkinTextStroke = p61:FindFirstChild("SkinTextStroke");
    local v64;

    if SkinTextStroke and SkinTextStroke.ClassName == "UIStroke" then
        v64 = false;
    else
        SkinTextStroke = Instance.new("UIStroke");
        SkinTextStroke.Name = "SkinTextStroke";
        v64 = true;
    end;

    SkinTextStroke.ApplyStrokeMode = Contextual;
    SkinTextStroke.StrokeSizingMode = FixedSize;
    SkinTextStroke.LineJoinMode = Round;
    SkinTextStroke.Color = Color3_new_ret;
    SkinTextStroke.Thickness = p62 or u1.Stroke.text;
    SkinTextStroke.Transparency = p63 or 0;
    SkinTextStroke.Enabled = true;

    if v64 then
        SkinTextStroke.Parent = p61;
    end;

    return SkinTextStroke;
end;

local u65 = {
    button = {
        tile = 0.27,
        alpha = 0.8
    },
    hud = {
        perShort = 2.56,
        alpha = 0
    }
};
local NumberSequence_new_ret = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 0) });

local function shimmer(p66, p67) -- Line: 503
    -- upvalues: u65 (copy), decor (copy), skinZ (copy), Color3_new_ret2 (copy), NumberSequence_new_ret (copy), Assets (copy)
    local SkinShimmer = p66:FindFirstChild("SkinShimmer");

    if p66:IsA("TextLabel") or (p66:IsA("TextButton") or p66:IsA("TextBox")) then
        if SkinShimmer then
            SkinShimmer.Visible = false;
        end;

        return nil;
    end;

    local v68 = u65[p67 or "button"] or u65.button;
    local SkinShimmer2 = p66:FindFirstChild("SkinShimmer");
    local v69;

    if SkinShimmer2 and SkinShimmer2.ClassName == "CanvasGroup" then
        v69 = false;
    else
        SkinShimmer2 = Instance.new("CanvasGroup");
        SkinShimmer2.Name = "SkinShimmer";
        v69 = true;
    end;

    decor(SkinShimmer2, (skinZ(p66)));
    SkinShimmer2.GroupTransparency = 0;
    SkinShimmer2.GroupColor3 = Color3_new_ret2;
    local v70 = p66:FindFirstChildOfClass("UICorner");
    local Corner = SkinShimmer2:FindFirstChild("Corner");
    local v71;

    if Corner and Corner.ClassName == "UICorner" then
        v71 = false;
    else
        Corner = Instance.new("UICorner");
        Corner.Name = "Corner";
        v71 = true;
    end;

    Corner.CornerRadius = v70 and v70.CornerRadius or UDim.new();

    if v71 then
        Corner.Parent = SkinShimmer2;
    end;

    local Fade = SkinShimmer2:FindFirstChild("Fade");
    local v72;

    if Fade and Fade.ClassName == "UIGradient" then
        v72 = false;
    else
        Fade = Instance.new("UIGradient");
        Fade.Name = "Fade";
        v72 = true;
    end;

    Fade.Color = ColorSequence.new(Color3_new_ret2);
    Fade.Transparency = NumberSequence_new_ret;
    Fade.Rotation = 90;

    if v72 then
        Fade.Parent = SkinShimmer2;
    end;

    local Tile = SkinShimmer2:FindFirstChild("Tile");
    local v73;

    if Tile and Tile.ClassName == "ImageLabel" then
        v73 = false;
    else
        Tile = Instance.new("ImageLabel");
        Tile.Name = "Tile";
        v73 = true;
    end;

    local Offset = p66.Size.X.Offset;
    local Offset2 = p66.Size.Y.Offset;

    if Offset <= 0 or Offset2 <= 0 then
        Offset = p66.AbsoluteSize.X;
        Offset2 = p66.AbsoluteSize.Y;
    end;

    Tile.SizeConstraint = Offset < Offset2 and Offset > 0 and Enum.SizeConstraint.RelativeYY or Enum.SizeConstraint.RelativeXX;
    Tile.AnchorPoint = Vector2.new(0.5, 0.5);
    Tile.Position = UDim2.fromScale(0.5, 0.5);
    Tile.Size = UDim2.fromScale(1.5, 1.5);
    Tile.Rotation = 45;
    Tile.BackgroundTransparency = 1;
    Tile.BorderSizePixel = 0;
    Tile.Active = false;
    Tile.Selectable = false;
    Tile.Interactable = false;
    Tile.Image = Assets.Checker;
    Tile.ScaleType = Enum.ScaleType.Tile;
    local tile = v68.tile;

    if v68.perShort then
        local math_max_ret = math.max(Offset, Offset2);
        local math_min_ret = math.min(Offset, Offset2);

        if math_max_ret > 0 then
            tile = v68.perShort * math_min_ret / (math_max_ret * 1.5);
        else
            tile = u65.button.tile;
        end;
    end;

    Tile.TileSize = UDim2.fromScale(tile, tile);
    Tile.ImageTransparency = v68.alpha;

    if v73 then
        Tile.Parent = SkinShimmer2;
    end;

    if v69 then
        SkinShimmer2.Parent = p66;
    end;

    return SkinShimmer2;
end;

local function hideShimmer(p74) -- Line: 562
    local SkinShimmer = p74:FindFirstChild("SkinShimmer");

    if SkinShimmer then
        SkinShimmer.Visible = false;
    end;
end;

local function glow(p75, p76, p77) -- Line: 569
    -- upvalues: decor (copy), skinZ (copy), Fit (copy), Assets (copy), Color3_new_ret2 (copy), table_freeze_ret2 (copy)
    local SkinGlow = p75:FindFirstChild("SkinGlow");
    local v78;

    if SkinGlow and SkinGlow.ClassName == "ImageLabel" then
        v78 = false;
    else
        SkinGlow = Instance.new("ImageLabel");
        SkinGlow.Name = "SkinGlow";
        v78 = true;
    end;

    decor(SkinGlow, (skinZ(p75)));
    SkinGlow.ScaleType = Fit;

    if p77 == "coins" or p77 == "coin" then
        SkinGlow.Image = Assets.GlowGold;
        SkinGlow.ImageColor3 = Color3_new_ret2;
        SkinGlow.ImageTransparency = 0;
    elseif p77 == "gems" or p77 == "gem" then
        SkinGlow.Image = Assets.GlowWhite;
        SkinGlow.ImageColor3 = table_freeze_ret2.gem;
        SkinGlow.ImageTransparency = 0;
    else
        SkinGlow.Image = Assets.Sunray;
        SkinGlow.ImageColor3 = p76 or Color3_new_ret2;
        SkinGlow.ImageTransparency = 0.55;
    end;

    if v78 then
        SkinGlow.Parent = p75;
    end;

    return SkinGlow;
end;

local function resolveIcon(p79) -- Line: 592
    -- upvalues: u1 (copy), Assets (copy)
    if type(p79) ~= "string" then
        return nil;
    end;

    if u1.Icons[p79] then
        return u1.Icons[p79];
    end;

    if Assets[p79] then
        return Assets[p79];
    end;

    if string.find(p79, "^rbxasset") then
        return p79;
    end;

    if string.find(p79, "^%d+$") then
        return "rbxassetid://" .. p79;
    end;

    return nil;
end;

local function accentOf(p80) -- Line: 611
    -- upvalues: u1 (copy), table_freeze_ret2 (copy)
    if typeof(p80) == "Color3" then
        return p80;
    end;

    if type(p80) == "string" then
        return u1.Rarity[p80] or table_freeze_ret2[p80];
    end;

    return nil;
end;

function u1.outline(p81, p82, p83) -- Line: 338
    -- upvalues: Color3_new_ret (copy), Outer (copy), Border (copy), FixedSize (copy), Round (copy)
    local SkinOutline = p81:FindFirstChild("SkinOutline");
    local v84;

    if SkinOutline and SkinOutline.ClassName == "UIStroke" then
        v84 = false;
    else
        SkinOutline = Instance.new("UIStroke");
        SkinOutline.Name = "SkinOutline";
        v84 = true;
    end;

    SkinOutline.ApplyStrokeMode = Border;
    SkinOutline.StrokeSizingMode = FixedSize;
    SkinOutline.LineJoinMode = Round;
    SkinOutline.BorderStrokePosition = Outer;
    SkinOutline.Color = Color3_new_ret;
    SkinOutline.Thickness = p82 or 2;
    SkinOutline.Transparency = p83 or 0;
    SkinOutline.Enabled = true;

    if v84 then
        SkinOutline.Parent = p81;
    end;

    return SkinOutline;
end;

u1.ring = ring;

function u1.corner(p85, p86) -- Line: 402
    local v87 = p85:FindFirstChildOfClass("UICorner");

    if v87 then
        if p86 then
            v87.CornerRadius = p86;
        end;

        return v87;
    end;

    local UICorner = Instance.new("UICorner");
    UICorner.Name = "SkinCorner";
    UICorner.CornerRadius = p86 or UDim.new(0, 8);
    UICorner.Parent = p85;

    return UICorner;
end;

u1.textStroke = textStroke;
u1.shimmer = shimmer;
u1.glow = glow;

function u1.strokeTransparency(p88, p89) -- Line: 631
    for _, v in { "SkinOutline", "SkinStroke", "SkinTextStroke" } do
        local v90 = p88:FindFirstChild(v);

        if v90 then
            v90.Transparency = p89;
        end;
    end;
end;

function u1.clone(p91) -- Line: 640
    local v92 = script.Parent and script.Parent:FindFirstChild("SkinKit");

    if v92 then
        v92 = v92:FindFirstChild(p91);
    end;

    return v92 and v92:Clone() or nil;
end;

local function dimOne(p93, p94) -- Line: 651
    -- upvalues: u12 (copy)
    local v95 = (p93:IsA("TextLabel") or (p93:IsA("TextButton") or p93:IsA("TextBox"))) and "TextTransparency" or ((p93:IsA("ImageLabel") or p93:IsA("ImageButton")) and "ImageTransparency" or nil);

    if not v95 then
        return;
    end;

    if p94 then
        if u12[p93] == nil then
            local v96 = p93[v95];
            u12[p93] = v96;
            p93[v95] = 1 - (1 - v96) * 0.45;
        end;
    else
        local v97 = u12[p93];

        if v97 ~= nil then
            u12[p93] = nil;
            p93[v95] = v97;
        end;
    end;
end;

function u1.dim(p98, p99) -- Line: 671
    -- upvalues: dimOne (copy)
    local v100 = p99 ~= false;
    dimOne(p98, v100);

    for _, descendant in p98:GetDescendants() do
        dimOne(descendant, v100);
    end;

    return p98;
end;

function u1.setEnabled(p101, p102) -- Line: 680
    -- upvalues: u1 (copy)
    return u1.dim(p101, not p102);
end;

function u1.hover(p103, p104) -- Line: 687
    -- upvalues: u10 (copy), Color3_new_ret2 (copy), Color3_new_ret (copy)
    local v105 = u10[p103];

    if not v105 then
        return;
    end;

    if not p104 then
        p103.BackgroundColor3 = v105;

        return;
    end;

    if v105 == Color3_new_ret2 then
        p103.BackgroundColor3 = v105:Lerp(Color3_new_ret, 0.1);

        return;
    end;

    p103.BackgroundColor3 = v105:Lerp(Color3_new_ret2, 0.08);
end;

function u1.press(p106, p107) -- Line: 701
    -- upvalues: u10 (copy), Color3_new_ret (copy)
    local v108 = u10[p106];

    if v108 then
        if p107 then
            v108 = v108:Lerp(Color3_new_ret, 0.2) or v108;
        end;

        p106.BackgroundColor3 = v108;
    end;
end;

function u1.select(p109, p110, p111) -- Line: 708
    -- upvalues: findRing (copy), Color3_new_ret2 (copy), u11 (copy)
    local v112 = findRing(p109) or p109:FindFirstChild("SkinStroke");

    if not v112 then
        return;
    end;

    if p110 then
        v112.Color = p111 or Color3_new_ret2;

        return;
    end;

    if u11[p109] then
        v112.Color = u11[p109];
    end;
end;

function u1.bindStates(u113) -- Line: 720
    -- upvalues: u15 (copy), u1 (copy)
    if u15[u113] then
        return u15[u113];
    end;

    local u114 = false;
    local u115 = {
        u113.MouseEnter:Connect(function() -- Line: 726
            -- upvalues: u114 (ref), u1 (ref), u113 (copy)
            u114 = true;
            u1.hover(u113, true);
        end),
        u113.MouseLeave:Connect(function() -- Line: 730
            -- upvalues: u114 (ref), u1 (ref), u113 (copy)
            u114 = false;
            u1.hover(u113, false);
        end),
        u113.SelectionGained:Connect(function() -- Line: 734
            -- upvalues: u1 (ref), u113 (copy)
            u1.hover(u113, true);
        end),
        u113.SelectionLost:Connect(function() -- Line: 737
            -- upvalues: u1 (ref), u113 (copy), u114 (ref)
            u1.hover(u113, u114);
        end)
    };

    if u113:IsA("GuiButton") then
        table.insert(u115, u113.MouseButton1Down:Connect(function() -- Line: 742
            -- upvalues: u1 (ref), u113 (copy)
            u1.press(u113, true);
        end));
        table.insert(u115, u113.MouseButton1Up:Connect(function() -- Line: 745
            -- upvalues: u1 (ref), u113 (copy), u114 (ref)
            u1.hover(u113, u114);
        end));
    end;

    local function disconnect() -- Line: 749
        -- upvalues: u115 (copy), u15 (ref), u113 (copy)
        for _, v in u115 do
            v:Disconnect();
        end;

        table.clear(u115);
        u15[u113] = nil;
    end;

    u15[u113] = disconnect;

    return disconnect;
end;

local ColorSequence_new_ret = ColorSequence.new(Color3_new_ret);

function u1.shade(p116) -- Line: 765
    -- upvalues: Color3_new_ret (copy), ColorSequence_new_ret (copy)
    p116.BackgroundColor3 = Color3_new_ret;
    p116.BorderSizePixel = 0;

    for _, child in p116:GetChildren() do
        if child:IsA("UIGradient") and string.sub(child.Name, 1, 4) ~= "Skin" then
            child.Color = ColorSequence_new_ret;
        end;
    end;

    return p116;
end;

function u1.panel(p117, p118) -- Line: 776
    -- upvalues: table_freeze_ret (copy), table_freeze_ret2 (copy), fill (copy), u1 (copy), Color3_new_ret (copy), Outer (copy), Border (copy), FixedSize (copy), Round (copy), ring (copy)
    local v119 = p118 or table_freeze_ret;
    local v120 = v119.color or table_freeze_ret2.surface;
    fill(p117, v120, v120);

    if v119.transparency then
        p117.BackgroundTransparency = v119.transparency;
    end;

    local radius = v119.radius;
    local UDim_new_ret = UDim.new(0, 12);

    if radius ~= false then
        if radius then
            local v121 = p117:FindFirstChildOfClass("UICorner");

            if v121 then
                if radius then
                    v121.CornerRadius = radius;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = radius or UDim.new(0, 8);
                UICorner.Parent = p117;
            end;
        elseif not p117:FindFirstChildOfClass("UICorner") then
            local v122 = p117:FindFirstChildOfClass("UICorner");

            if v122 then
                if UDim_new_ret then
                    v122.CornerRadius = UDim_new_ret;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = UDim_new_ret or UDim.new(0, 8);
                UICorner.Parent = p117;
            end;
        end;
    end;

    local v123 = u1.Stroke.panel[1];
    local SkinOutline = p117:FindFirstChild("SkinOutline");
    local v124;

    if SkinOutline and SkinOutline.ClassName == "UIStroke" then
        v124 = false;
    else
        SkinOutline = Instance.new("UIStroke");
        SkinOutline.Name = "SkinOutline";
        v124 = true;
    end;

    SkinOutline.ApplyStrokeMode = Border;
    SkinOutline.StrokeSizingMode = FixedSize;
    SkinOutline.LineJoinMode = Round;
    SkinOutline.BorderStrokePosition = Outer;
    SkinOutline.Color = Color3_new_ret;
    SkinOutline.Thickness = v123 or 2;
    SkinOutline.Transparency = 0;
    SkinOutline.Enabled = true;

    if v124 then
        SkinOutline.Parent = p117;
    end;

    local accent = v119.accent;

    if typeof(accent) ~= "Color3" then
        if type(accent) == "string" then
            accent = u1.Rarity[accent] or table_freeze_ret2[accent];
        else
            accent = nil;
        end;
    end;

    ring(p117, accent or table_freeze_ret2.neutral, u1.Stroke.panel[2]);

    return p117;
end;

function u1.header(p125, p126) -- Line: 789
    -- upvalues: table_freeze_ret (copy), fill (copy), Color3_new_ret (copy), ring (copy), table_freeze_ret2 (copy), u1 (copy), decor (copy), skinZ (copy), Assets (copy), Fit (copy), Color3_new_ret2 (copy)
    local v127 = p126 or table_freeze_ret;
    fill(p125, Color3_new_ret, Color3_new_ret);
    p125.BackgroundTransparency = v127.transparency or 0.5;
    local radius = v127.radius;
    local UDim_new_ret = UDim.new(0, 8);

    if radius ~= false then
        if radius then
            local v128 = p125:FindFirstChildOfClass("UICorner");

            if v128 then
                if radius then
                    v128.CornerRadius = radius;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = radius or UDim.new(0, 8);
                UICorner.Parent = p125;
            end;
        elseif not p125:FindFirstChildOfClass("UICorner") then
            local v129 = p125:FindFirstChildOfClass("UICorner");

            if v129 then
                if UDim_new_ret then
                    v129.CornerRadius = UDim_new_ret;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = UDim_new_ret or UDim.new(0, 8);
                UICorner.Parent = p125;
            end;
        end;
    end;

    local SkinOutline = p125:FindFirstChild("SkinOutline");

    if SkinOutline then
        SkinOutline.Enabled = false;
    end;

    ring(p125, table_freeze_ret2.neutral, u1.Stroke.header);
    local SkinDecoration = p125:FindFirstChild("SkinDecoration");

    if v127.decoration == false then
        if SkinDecoration then
            SkinDecoration.Visible = false;
        end;
    else
        local SkinDecoration2 = p125:FindFirstChild("SkinDecoration");
        local v130;

        if SkinDecoration2 and SkinDecoration2.ClassName == "ImageLabel" then
            v130 = false;
        else
            SkinDecoration2 = Instance.new("ImageLabel");
            SkinDecoration2.Name = "SkinDecoration";
            v130 = true;
        end;

        decor(SkinDecoration2, (skinZ(p125)));
        SkinDecoration2.Image = v127.decoration == "wide" and Assets.DecorationWide or Assets.Decoration;
        SkinDecoration2.ScaleType = Fit;
        SkinDecoration2.ImageTransparency = 0;
        SkinDecoration2.ImageColor3 = Color3_new_ret2;

        if v130 then
            SkinDecoration2.Parent = p125;
        end;
    end;

    if v127.icon then
        u1.icon(v127.icon, v127.iconName or "gear");
    end;

    if v127.title then
        u1.text(v127.title, "primary");
    end;

    if v127.info then
        u1.text(v127.info, "secondary");
    end;

    return p125;
end;

function u1.footer(p131, p132) -- Line: 825
    -- upvalues: table_freeze_ret (copy), u1 (copy)
    local v133 = p132 or table_freeze_ret;

    return u1.header(p131, {
        decoration = false,
        radius = v133.radius or false,
        transparency = v133.transparency
    });
end;

local NumberSequence_new_ret2 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.5), NumberSequenceKeypoint.new(1, 1) });

function u1.band(p134, p135) -- Line: 836
    -- upvalues: table_freeze_ret (copy), Color3_new_ret (copy), quietGradients (copy), NumberSequence_new_ret2 (copy), Color3_new_ret2 (copy), u10 (copy), fill (copy), table_freeze_ret2 (copy)
    local v136 = p135 or table_freeze_ret;
    local v137 = v136.color or Color3_new_ret;
    local v138;

    if p134:IsA("Frame") or p134:IsA("CanvasGroup") then
        v138 = true;
    else
        v138 = (p134:IsA("ImageLabel") or p134:IsA("ImageButton")) and p134.Image == "";
    end;

    if not v138 then
        fill(p134, v136.color or table_freeze_ret2.neutral, v136.color or table_freeze_ret2.neutral);

        return p134;
    end;

    quietGradients(p134);
    local SkinGradient = p134:FindFirstChild("SkinGradient");
    local v139;

    if SkinGradient and SkinGradient.ClassName == "UIGradient" then
        v139 = false;
    else
        SkinGradient = Instance.new("UIGradient");
        SkinGradient.Name = "SkinGradient";
        v139 = true;
    end;

    SkinGradient.Color = ColorSequence.new(v137);
    SkinGradient.Transparency = NumberSequence_new_ret2;
    SkinGradient.Rotation = 0;
    SkinGradient.Offset = Vector2.zero;
    SkinGradient.Enabled = true;

    if v139 then
        SkinGradient.Parent = p134;
    end;

    p134.BackgroundColor3 = Color3_new_ret2;
    p134.BorderSizePixel = 0;
    u10[p134] = Color3_new_ret2;

    return p134;
end;

local NumberSequence_new_ret3 = NumberSequence.new(0.2, 0.6);

function u1.card(p140, p141, p142) -- Line: 861
    -- upvalues: table_freeze_ret (copy), u1 (copy), table_freeze_ret2 (copy), fill (copy), NumberSequence_new_ret3 (copy), Color3_new_ret (copy), Outer (copy), Border (copy), FixedSize (copy), Round (copy), ring (copy), glow (copy)
    local v143 = p142 or table_freeze_ret;

    if typeof(p141) ~= "Color3" then
        if type(p141) == "string" then
            p141 = u1.Rarity[p141] or table_freeze_ret2[p141];
        else
            p141 = nil;
        end;
    end;

    if p141 then
        fill(p140, table_freeze_ret2.surface, p141, ColorSequence.new(table_freeze_ret2.surface, p141), NumberSequence_new_ret3, 90, 0.18);
    else
        fill(p140, table_freeze_ret2.surface, table_freeze_ret2.surface);
    end;

    if v143.transparency then
        p140.BackgroundTransparency = v143.transparency;
    end;

    local radius = v143.radius;
    local UDim_new_ret = UDim.new(0, 10);

    if radius ~= false then
        if radius then
            local v144 = p140:FindFirstChildOfClass("UICorner");

            if v144 then
                if radius then
                    v144.CornerRadius = radius;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = radius or UDim.new(0, 8);
                UICorner.Parent = p140;
            end;
        elseif not p140:FindFirstChildOfClass("UICorner") then
            local v145 = p140:FindFirstChildOfClass("UICorner");

            if v145 then
                if UDim_new_ret then
                    v145.CornerRadius = UDim_new_ret;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = UDim_new_ret or UDim.new(0, 8);
                UICorner.Parent = p140;
            end;
        end;
    end;

    local v146 = u1.Stroke.card[1];
    local SkinOutline = p140:FindFirstChild("SkinOutline");
    local v147;

    if SkinOutline and SkinOutline.ClassName == "UIStroke" then
        v147 = false;
    else
        SkinOutline = Instance.new("UIStroke");
        SkinOutline.Name = "SkinOutline";
        v147 = true;
    end;

    SkinOutline.ApplyStrokeMode = Border;
    SkinOutline.StrokeSizingMode = FixedSize;
    SkinOutline.LineJoinMode = Round;
    SkinOutline.BorderStrokePosition = Outer;
    SkinOutline.Color = Color3_new_ret;
    SkinOutline.Thickness = v146 or 2;
    SkinOutline.Transparency = 0;
    SkinOutline.Enabled = true;

    if v147 then
        SkinOutline.Parent = p140;
    end;

    ring(p140, p141 or table_freeze_ret2.neutral, u1.Stroke.card[2]);

    if not v143.glow then
        local SkinGlow = p140:FindFirstChild("SkinGlow");

        if SkinGlow then
            SkinGlow.Visible = false;
        end;

        return p140;
    end;

    local v148;

    if v143.glow == true then
        v148 = nil;
    else
        v148 = v143.glow or nil;
    end;

    glow(p140, p141, v148);

    return p140;
end;

function u1.slot(p149, p150, p151) -- Line: 886
    -- upvalues: table_freeze_ret (copy), u1 (copy), table_freeze_ret2 (copy), findRing (copy), Color3_new_ret2 (copy)
    local v152 = p151 or table_freeze_ret;

    if p150 == "equipped" then
        u1.card(p149, table_freeze_ret2.green, v152);

        return p149;
    end;

    u1.card(p149, nil, v152);
    local v153 = findRing(p149) or p149:FindFirstChild("SkinStroke");

    if p150 == "selected" then
        v153.Color = Color3_new_ret2;

        return p149;
    end;

    if p150 == "active" or (p150 == "playing" or p150 == "collected") then
        v153.Color = table_freeze_ret2.green;
    end;

    return p149;
end;

function u1.pill(p154, p155, p156) -- Line: 902
    -- upvalues: table_freeze_ret (copy), fill (copy), table_freeze_ret2 (copy), u1 (copy), Color3_new_ret (copy), Outer (copy), Border (copy), FixedSize (copy), Round (copy), ring (copy), shimmer (copy)
    local v157 = p156 or table_freeze_ret;
    fill(p154, table_freeze_ret2.surface, table_freeze_ret2.surface);
    local radius = v157.radius;
    local UDim_new_ret = UDim.new(0.1667, 0);

    if radius ~= false then
        if radius then
            local v158 = p154:FindFirstChildOfClass("UICorner");

            if v158 then
                if radius then
                    v158.CornerRadius = radius;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = radius or UDim.new(0, 8);
                UICorner.Parent = p154;
            end;
        elseif not p154:FindFirstChildOfClass("UICorner") then
            local v159 = p154:FindFirstChildOfClass("UICorner");

            if v159 then
                if UDim_new_ret then
                    v159.CornerRadius = UDim_new_ret;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = UDim_new_ret or UDim.new(0, 8);
                UICorner.Parent = p154;
            end;
        end;
    end;

    local v160 = u1.Stroke.pill[1];
    local SkinOutline = p154:FindFirstChild("SkinOutline");
    local v161;

    if SkinOutline and SkinOutline.ClassName == "UIStroke" then
        v161 = false;
    else
        SkinOutline = Instance.new("UIStroke");
        SkinOutline.Name = "SkinOutline";
        v161 = true;
    end;

    SkinOutline.ApplyStrokeMode = Border;
    SkinOutline.StrokeSizingMode = FixedSize;
    SkinOutline.LineJoinMode = Round;
    SkinOutline.BorderStrokePosition = Outer;
    SkinOutline.Color = Color3_new_ret;
    SkinOutline.Thickness = v160 or 2;
    SkinOutline.Transparency = 0;
    SkinOutline.Enabled = true;

    if v161 then
        SkinOutline.Parent = p154;
    end;

    ring(p154, table_freeze_ret2.neutral, u1.Stroke.pill[2]);

    if v157.shimmer == false then
        local SkinShimmer = p154:FindFirstChild("SkinShimmer");

        if SkinShimmer then
            SkinShimmer.Visible = false;
        end;
    else
        shimmer(p154, "hud");
    end;

    if v157.icon then
        u1.icon(v157.icon, p155 == "gems" and "gemWallet" or "coin");
    end;

    if v157.amount then
        u1.text(v157.amount, p155 == "gems" and "gem" or (p155 == "coins" and "gold" or "primary"));
    end;

    return p154;
end;

local ColorSequence_new_ret2 = ColorSequence.new(Color3_new_ret2, Color3_fromHex("B4B4B4"));
local u162 = {
    blue = { table_freeze_ret2.blue, table_freeze_ret2.blueLight, 0 },
    xp = { table_freeze_ret2.xp, table_freeze_ret2.xpLight, 0 },
    green = { table_freeze_ret2.green, table_freeze_ret2.greenDark, 90 }
};

function u1.bar(p163, p164, p165, p166) -- Line: 929
    -- upvalues: table_freeze_ret (copy), fill (copy), table_freeze_ret2 (copy), u1 (copy), Color3_new_ret (copy), Outer (copy), Border (copy), FixedSize (copy), Round (copy), ring (copy), u162 (copy), quietGradients (copy), ColorSequence_new_ret2 (copy)
    local v167 = p166 or table_freeze_ret;
    local v168 = v167.radius == nil and UDim.new(1, 0) or v167.radius;
    fill(p163, table_freeze_ret2.track, table_freeze_ret2.track);

    if v168 ~= false then
        if v168 then
            local v169 = p163:FindFirstChildOfClass("UICorner");

            if v169 then
                if v168 then
                    v169.CornerRadius = v168;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = v168 or UDim.new(0, 8);
                UICorner.Parent = p163;
            end;
        elseif not (p163:FindFirstChildOfClass("UICorner") or p163:FindFirstChildOfClass("UICorner")) then
            local UICorner = Instance.new("UICorner");
            UICorner.Name = "SkinCorner";
            UICorner.CornerRadius = UDim.new(0, 8);
            UICorner.Parent = p163;
        end;
    end;

    local v170 = u1.Stroke.bar[1];
    local SkinOutline = p163:FindFirstChild("SkinOutline");
    local v171;

    if SkinOutline and SkinOutline.ClassName == "UIStroke" then
        v171 = false;
    else
        SkinOutline = Instance.new("UIStroke");
        SkinOutline.Name = "SkinOutline";
        v171 = true;
    end;

    SkinOutline.ApplyStrokeMode = Border;
    SkinOutline.StrokeSizingMode = FixedSize;
    SkinOutline.LineJoinMode = Round;
    SkinOutline.BorderStrokePosition = Outer;
    SkinOutline.Color = Color3_new_ret;
    SkinOutline.Thickness = v170 or 2;
    SkinOutline.Transparency = 0;
    SkinOutline.Enabled = true;

    if v171 then
        SkinOutline.Parent = p163;
    end;

    ring(p163, table_freeze_ret2.barRing, u1.Stroke.bar[2]);

    if p164 then
        if v168 ~= false then
            if v168 then
                local v172 = p164:FindFirstChildOfClass("UICorner");

                if v172 then
                    if v168 then
                        v172.CornerRadius = v168;
                    end;
                else
                    local UICorner = Instance.new("UICorner");
                    UICorner.Name = "SkinCorner";
                    UICorner.CornerRadius = v168 or UDim.new(0, 8);
                    UICorner.Parent = p164;
                end;
            elseif not (p164:FindFirstChildOfClass("UICorner") or p164:FindFirstChildOfClass("UICorner")) then
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = UDim.new(0, 8);
                UICorner.Parent = p164;
            end;
        end;

        p164.BorderSizePixel = 0;
        local v173;

        if type(p165) == "string" then
            v173 = u162[p165];
        else
            v173 = false;
        end;

        if v173 then
            fill(p164, v173[1], v173[2], nil, nil, v173[3]);

            return p163;
        end;

        if p165 == "gold" then
            fill(p164, table_freeze_ret2.gold, table_freeze_ret2.gold);

            return p163;
        end;

        if typeof(p165) == "Color3" then
            fill(p164, p165, p165);

            return p163;
        end;

        quietGradients(p164);
        local v174;

        if p164:IsA("Frame") or p164:IsA("CanvasGroup") then
            v174 = true;
        else
            v174 = (p164:IsA("ImageLabel") or p164:IsA("ImageButton")) and p164.Image == "";
        end;

        if v174 then
            local SkinGradient = p164:FindFirstChild("SkinGradient");
            local v175;

            if SkinGradient and SkinGradient.ClassName == "UIGradient" then
                v175 = false;
            else
                SkinGradient = Instance.new("UIGradient");
                SkinGradient.Name = "SkinGradient";
                v175 = true;
            end;

            SkinGradient.Color = ColorSequence_new_ret2;
            SkinGradient.Transparency = NumberSequence.new(0);
            SkinGradient.Rotation = 90;
            SkinGradient.Offset = Vector2.zero;
            SkinGradient.Enabled = true;

            if v175 then
                SkinGradient.Parent = p164;
            end;
        end;
    end;

    return p163;
end;

function u1.toast(p176, p177) -- Line: 965
    -- upvalues: table_freeze_ret (copy), fill (copy), table_freeze_ret2 (copy), ring (copy), Color3_new_ret (copy), Outer (copy), Border (copy), FixedSize (copy), Round (copy), textStroke (copy), u1 (copy)
    fill(p176, table_freeze_ret2.surface, table_freeze_ret2.surface);
    local radius = (p177 or table_freeze_ret).radius;
    local UDim_new_ret = UDim.new(0, 8);

    if radius ~= false then
        if radius then
            local v178 = p176:FindFirstChildOfClass("UICorner");

            if v178 then
                if radius then
                    v178.CornerRadius = radius;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = radius or UDim.new(0, 8);
                UICorner.Parent = p176;
            end;
        elseif not p176:FindFirstChildOfClass("UICorner") then
            local v179 = p176:FindFirstChildOfClass("UICorner");

            if v179 then
                if UDim_new_ret then
                    v179.CornerRadius = UDim_new_ret;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = UDim_new_ret or UDim.new(0, 8);
                UICorner.Parent = p176;
            end;
        end;
    end;

    local v180 = ring(p176, table_freeze_ret2.neutral, 2);
    local SkinOutline = p176:FindFirstChild("SkinOutline");
    local v181;

    if SkinOutline and SkinOutline.ClassName == "UIStroke" then
        v181 = false;
    else
        SkinOutline = Instance.new("UIStroke");
        SkinOutline.Name = "SkinOutline";
        v181 = true;
    end;

    SkinOutline.ApplyStrokeMode = Border;
    SkinOutline.StrokeSizingMode = FixedSize;
    SkinOutline.LineJoinMode = Round;
    SkinOutline.BorderStrokePosition = Outer;
    SkinOutline.Color = Color3_new_ret;
    SkinOutline.Thickness = 2;
    SkinOutline.Transparency = 0;
    SkinOutline.Enabled = true;

    if v181 then
        SkinOutline.Parent = p176;
    end;

    local v182;

    if p176:IsA("TextLabel") or (p176:IsA("TextButton") or p176:IsA("TextBox")) then
        p176.TextColor3 = table_freeze_ret2.text;
        v182 = textStroke(p176, u1.Stroke.text);
    else
        v182 = nil;
    end;

    return p176, v180, SkinOutline, v182;
end;

function u1.badge(p183, p184) -- Line: 979
    -- upvalues: table_freeze_ret (copy), table_freeze_ret2 (copy), fill (copy), findRing (copy), ring (copy), u1 (copy), Outer (copy), textStroke (copy)
    local v185 = p184 or table_freeze_ret;
    local v186 = v185.kind == "tag";
    local v187 = v185.color or (v186 and table_freeze_ret2.green or table_freeze_ret2.notice);
    fill(p183, v187, v187);
    local v188 = v185.radius == nil and UDim.new(1, 0) or v185.radius;

    if v188 ~= false then
        if v188 then
            local v189 = p183:FindFirstChildOfClass("UICorner");

            if v189 then
                if v188 then
                    v189.CornerRadius = v188;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = v188 or UDim.new(0, 8);
                UICorner.Parent = p183;
            end;
        elseif not (p183:FindFirstChildOfClass("UICorner") or p183:FindFirstChildOfClass("UICorner")) then
            local UICorner = Instance.new("UICorner");
            UICorner.Name = "SkinCorner";
            UICorner.CornerRadius = UDim.new(0, 8);
            UICorner.Parent = p183;
        end;
    end;

    local SkinOutline = p183:FindFirstChild("SkinOutline");

    if SkinOutline then
        SkinOutline.Enabled = false;
    end;

    if v186 then
        local v190 = findRing(p183) or p183:FindFirstChild("SkinStroke");

        if v190 then
            v190.Enabled = false;
        end;
    else
        ring(p183, table_freeze_ret2.noticeRing, u1.Stroke.badge, 0.2).BorderStrokePosition = Outer;
    end;

    if p183:IsA("TextLabel") or (p183:IsA("TextButton") or p183:IsA("TextBox")) then
        p183.TextColor3 = v186 and table_freeze_ret2.surface or table_freeze_ret2.text;

        if not v186 then
            textStroke(p183, 1);
        end;
    end;

    return p183;
end;

function u1.input(p191, p192) -- Line: 1004
    -- upvalues: table_freeze_ret (copy), fill (copy), table_freeze_ret2 (copy), Color3_new_ret (copy), Outer (copy), Border (copy), FixedSize (copy), Round (copy), ring (copy)
    fill(p191, table_freeze_ret2.input, table_freeze_ret2.input);
    local radius = (p192 or table_freeze_ret).radius;
    local UDim_new_ret = UDim.new(0, 6);

    if radius ~= false then
        if radius then
            local v193 = p191:FindFirstChildOfClass("UICorner");

            if v193 then
                if radius then
                    v193.CornerRadius = radius;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = radius or UDim.new(0, 8);
                UICorner.Parent = p191;
            end;
        elseif not p191:FindFirstChildOfClass("UICorner") then
            local v194 = p191:FindFirstChildOfClass("UICorner");

            if v194 then
                if UDim_new_ret then
                    v194.CornerRadius = UDim_new_ret;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = UDim_new_ret or UDim.new(0, 8);
                UICorner.Parent = p191;
            end;
        end;
    end;

    local SkinOutline = p191:FindFirstChild("SkinOutline");
    local v195;

    if SkinOutline and SkinOutline.ClassName == "UIStroke" then
        v195 = false;
    else
        SkinOutline = Instance.new("UIStroke");
        SkinOutline.Name = "SkinOutline";
        v195 = true;
    end;

    SkinOutline.ApplyStrokeMode = Border;
    SkinOutline.StrokeSizingMode = FixedSize;
    SkinOutline.LineJoinMode = Round;
    SkinOutline.BorderStrokePosition = Outer;
    SkinOutline.Color = Color3_new_ret;
    SkinOutline.Thickness = 2;
    SkinOutline.Transparency = 0;
    SkinOutline.Enabled = true;

    if v195 then
        SkinOutline.Parent = p191;
    end;

    ring(p191, table_freeze_ret2.neutral, 2);

    if p191:IsA("TextLabel") or (p191:IsA("TextButton") or p191:IsA("TextBox")) then
        p191.TextColor3 = table_freeze_ret2.text;

        if p191:IsA("TextBox") then
            p191.PlaceholderColor3 = table_freeze_ret2.textMuted;
        end;
    end;

    return p191;
end;

function u1.scroll(p196) -- Line: 1019
    -- upvalues: table_freeze_ret2 (copy)
    if p196:IsA("ScrollingFrame") then
        p196.ScrollBarImageColor3 = table_freeze_ret2.neutral;
        p196.ScrollBarImageTransparency = 0;
    end;

    return p196;
end;

function u1.text(p197, p198, p199) -- Line: 1030
    -- upvalues: table_freeze_ret (copy), u2 (copy), table_freeze_ret2 (copy), textStroke (copy), u1 (copy)
    local v200 = p199 or table_freeze_ret;

    if not (p197:IsA("TextLabel") or (p197:IsA("TextButton") or p197:IsA("TextBox"))) then
        return p197;
    end;

    p197.TextColor3 = typeof(p198) == "Color3" and p198 and p198 or (u2[p198 or "primary"] or (table_freeze_ret2[p198] or table_freeze_ret2.text));

    if v200.stroke ~= false then
        textStroke(p197, v200.stroke or u1.Stroke.text);
    end;

    return p197;
end;

function u1.icon(p201, p202, p203) -- Line: 1043
    -- upvalues: table_freeze_ret (copy), resolveIcon (copy), Fit (copy), Color3_new_ret2 (copy), decor (copy), topZ (copy)
    local v204 = p203 or table_freeze_ret;
    local v205 = resolveIcon(p202);
    local v206 = "Skin.icon: unknown icon " .. tostring(p202);
    assert(v205, v206);

    if p201:IsA("ImageLabel") or p201:IsA("ImageButton") then
        p201.Image = v205;
        p201.ScaleType = Fit;
        p201.ImageRectOffset = Vector2.zero;
        p201.ImageRectSize = Vector2.zero;
        p201.ImageColor3 = v204.color or Color3_new_ret2;

        return p201;
    end;

    if p201:IsA("TextLabel") or (p201:IsA("TextButton") or p201:IsA("TextBox")) then
        p201.TextTransparency = 1;
        p201.TextStrokeTransparency = 1;
        local SkinTextStroke = p201:FindFirstChild("SkinTextStroke");

        if SkinTextStroke then
            SkinTextStroke.Enabled = false;
        end;
    else
        p201.BackgroundTransparency = 1;

        for _, descendant in p201:GetDescendants() do
            local v207 = descendant;
            local v208 = v207;
            local v209 = v207;
            v207 = v208;
            v209 = v208;
            local v210 = false;

            while v208 and v208 ~= p201 do
                if string.sub(v208.Name, 1, 4) == "Skin" then
                    v210 = true;
                    break;
                end;

                v208 = v208.Parent;
            end;

            if not v210 then
                if v207:IsA("GuiObject") then
                    v207.BackgroundTransparency = 1;

                    if v207:IsA("TextLabel") or (v207:IsA("TextButton") or v207:IsA("TextBox")) then
                        v207.TextTransparency = 1;
                    elseif v207:IsA("ImageLabel") or v207:IsA("ImageButton") then
                        v207.ImageTransparency = 1;
                    end;
                elseif v207:IsA("UIStroke") then
                    v207.Enabled = false;
                end;
            end;
        end;

        for _, child in p201:GetChildren() do
            if child:IsA("UIStroke") and string.sub(child.Name, 1, 4) ~= "Skin" then
                child.Enabled = false;
            end;
        end;
    end;

    local SkinIcon = p201:FindFirstChild("SkinIcon");
    local v211;

    if SkinIcon and SkinIcon.ClassName == "ImageLabel" then
        v211 = false;
    else
        SkinIcon = Instance.new("ImageLabel");
        SkinIcon.Name = "SkinIcon";
        v211 = true;
    end;

    decor(SkinIcon, (topZ(p201)));
    SkinIcon.Image = v205;
    SkinIcon.ScaleType = Fit;
    SkinIcon.ImageColor3 = v204.color or Color3_new_ret2;
    SkinIcon.ImageTransparency = 0;

    if v211 then
        SkinIcon.Parent = p201;
    end;

    return SkinIcon;
end;

local function bigCloseGlyph(p212) -- Line: 1112
    -- upvalues: table_freeze_ret2 (copy), textStroke (copy)
    p212.TextTransparency = 1;
    local SkinTextStroke = p212:FindFirstChild("SkinTextStroke");

    if SkinTextStroke then
        SkinTextStroke.Enabled = false;
    end;

    local SkinCloseGlyph = p212:FindFirstChild("SkinCloseGlyph");
    local v213;

    if SkinCloseGlyph and SkinCloseGlyph.ClassName == "TextLabel" then
        v213 = false;
    else
        SkinCloseGlyph = Instance.new("TextLabel");
        SkinCloseGlyph.Name = "SkinCloseGlyph";
        v213 = true;
    end;

    SkinCloseGlyph.BackgroundTransparency = 1;
    SkinCloseGlyph.AnchorPoint = Vector2.new(0.5, 0.5);
    SkinCloseGlyph.Position = UDim2.fromScale(0.5, 0.44);
    SkinCloseGlyph.Size = UDim2.fromScale(0.9, 1.25);
    SkinCloseGlyph.Text = "x";
    SkinCloseGlyph.FontFace = Font.new(p212.FontFace.Family, Enum.FontWeight.Heavy);
    SkinCloseGlyph.TextScaled = true;
    SkinCloseGlyph.TextColor3 = table_freeze_ret2.close;
    SkinCloseGlyph.Active = false;
    SkinCloseGlyph.Selectable = false;
    SkinCloseGlyph.ZIndex = p212.ZIndex + 1;
    SkinCloseGlyph:SetAttribute("SelfManagedText", true);
    textStroke(SkinCloseGlyph, 2);

    if v213 then
        SkinCloseGlyph.Parent = p212;
    end;

    return SkinCloseGlyph;
end;

function u1.button(p214, p215, p216) -- Line: 1140
    -- upvalues: table_freeze_ret (copy), u9 (copy), quietGradients (copy), findRing (copy), u14 (copy), bigCloseGlyph (copy), fill (copy), u1 (copy), Color3_new_ret (copy), Outer (copy), Border (copy), FixedSize (copy), Round (copy), ring (copy), table_freeze_ret2 (copy), textStroke (copy), shimmer (copy), u13 (copy)
    local v217 = p216 or table_freeze_ret;
    local v218 = u9[p215 or "primary"];
    local v219 = "Skin.button: unknown variant " .. tostring(p215);
    assert(v218, v219);

    if v218.glyph then
        p214.BackgroundTransparency = 1;
        quietGradients(p214);
        local SkinGradient = p214:FindFirstChild("SkinGradient");

        if SkinGradient then
            SkinGradient.Enabled = false;
        end;

        local SkinOutline = p214:FindFirstChild("SkinOutline");

        if SkinOutline then
            SkinOutline.Enabled = false;
        end;

        local SkinStroke = p214:FindFirstChild("SkinStroke");

        if SkinStroke then
            SkinStroke.Enabled = false;
        end;

        local v220 = findRing(p214);

        if v220 and v220.Enabled then
            v220.Enabled = false;
            u14[p214] = v220;
        end;

        local SkinShimmer = p214:FindFirstChild("SkinShimmer");

        if SkinShimmer then
            SkinShimmer.Visible = false;
        end;

        if p214:IsA("TextLabel") or (p214:IsA("TextButton") or p214:IsA("TextBox")) then
            bigCloseGlyph(p214);
        end;

        if v217.label then
            bigCloseGlyph(v217.label);
        end;

        return p214;
    end;

    local SkinCloseGlyph = p214:FindFirstChild("SkinCloseGlyph");

    if SkinCloseGlyph then
        SkinCloseGlyph:Destroy();
        p214.TextTransparency = 0;
    end;

    fill(p214, v218.top, v218.bottom, v218.colors, v218.fades, 90);
    local radius = v217.radius;
    local UDim_new_ret = UDim.new(0.1667, 0);

    if radius ~= false then
        if radius then
            local v221 = p214:FindFirstChildOfClass("UICorner");

            if v221 then
                if radius then
                    v221.CornerRadius = radius;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = radius or UDim.new(0, 8);
                UICorner.Parent = p214;
            end;
        elseif not p214:FindFirstChildOfClass("UICorner") then
            local v222 = p214:FindFirstChildOfClass("UICorner");

            if v222 then
                if UDim_new_ret then
                    v222.CornerRadius = UDim_new_ret;
                end;
            else
                local UICorner = Instance.new("UICorner");
                UICorner.Name = "SkinCorner";
                UICorner.CornerRadius = UDim_new_ret or UDim.new(0, 8);
                UICorner.Parent = p214;
            end;
        end;
    end;

    local v223 = u1.Stroke.button[1];
    local SkinOutline = p214:FindFirstChild("SkinOutline");
    local v224;

    if SkinOutline and SkinOutline.ClassName == "UIStroke" then
        v224 = false;
    else
        SkinOutline = Instance.new("UIStroke");
        SkinOutline.Name = "SkinOutline";
        v224 = true;
    end;

    SkinOutline.ApplyStrokeMode = Border;
    SkinOutline.StrokeSizingMode = FixedSize;
    SkinOutline.LineJoinMode = Round;
    SkinOutline.BorderStrokePosition = Outer;
    SkinOutline.Color = Color3_new_ret;
    SkinOutline.Thickness = v223 or 2;
    SkinOutline.Transparency = 0;
    SkinOutline.Enabled = true;

    if v224 then
        SkinOutline.Parent = p214;
    end;

    ring(p214, v218.ring, u1.Stroke.button[2]);

    if p214:IsA("TextLabel") or (p214:IsA("TextButton") or p214:IsA("TextBox")) then
        p214.TextColor3 = table_freeze_ret2.text;
        textStroke(p214, u1.Stroke.text);
    end;

    if v217.label then
        v217.label.TextColor3 = table_freeze_ret2.text;
        textStroke(v217.label, u1.Stroke.text);
    end;

    if v217.shimmer == false or v218.flat then
        local SkinShimmer = p214:FindFirstChild("SkinShimmer");

        if SkinShimmer then
            SkinShimmer.Visible = false;
        end;
    else
        shimmer(p214, v217.shimmerKind or "button");
    end;

    if v218.icon and v217.icon then
        u1.icon(v217.icon, v218.icon);
    end;

    if v218.dim then
        if not u13[p214] then
            u13[p214] = true;
            u1.dim(p214, true);

            return p214;
        end;
    elseif u13[p214] then
        u13[p214] = nil;
        u1.dim(p214, false);
    end;

    return p214;
end;

function u1.tab(p225, p226, p227) -- Line: 1210
    -- upvalues: u1 (copy)
    return u1.button(p225, p226 and "primary" or "secondary", p227);
end;

local u228 = setmetatable({}, {
    __mode = "k"
});

local function priceIconSize(p229) -- Line: 1219
    local v230 = p229:FindFirstChildWhichIsA("UITextSizeConstraint");
    local math_floor_ret = math.floor((p229.TextScaled and (v230 and v230.MaxTextSize or p229.AbsoluteSize.Y * 0.5) or p229.TextSize) * 1.3 + 0.5);

    return math.max(10, math_floor_ret);
end;

function u1.price(u231, p232, p233) -- Line: 1224
    -- upvalues: table_freeze_ret (copy), u228 (copy), Fit (copy), topZ (copy), resolveIcon (copy), table_freeze_ret2 (copy), Color3_new_ret2 (copy)
    local v234 = u228[u231];

    if p232 ~= "coins" and p232 ~= "gems" then
        if v234 then
            u228[u231] = nil;

            for _, v in v234.connections do
                v:Disconnect();
            end;

            v234.icon:Destroy();

            if v234.own then
                v234.padding:Destroy();

                return u231;
            end;

            if v234.padding.Parent then
                v234.padding.PaddingLeft = v234.original;
            end;
        end;

        return u231;
    end;

    if not v234 then
        v234 = {
            connections = {}
        };
        local v235 = u231:FindFirstChildWhichIsA("UIPadding");

        if v235 then
            local PaddingLeft = v235.PaddingLeft;
            v234.padding = v235;
            v234.original = PaddingLeft;
        else
            local UIPadding = Instance.new("UIPadding");
            UIPadding.Name = "SkinPricePadding";
            UIPadding.Parent = u231;
            local UDim_new_ret = UDim.new(0, 0);
            v234.padding = UIPadding;
            v234.original = UDim_new_ret;
            v234.own = true;
        end;

        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "SkinPriceIcon";
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.BorderSizePixel = 0;
        ImageLabel.AnchorPoint = Vector2.new(1, 0.5);
        ImageLabel.ScaleType = Fit;
        ImageLabel.Active = false;
        ImageLabel.Selectable = false;
        ImageLabel.Interactable = false;
        ImageLabel.ZIndex = topZ(u231);
        ImageLabel.Parent = u231;
        v234.icon = ImageLabel;

        local function place() -- Line: 1266
            -- upvalues: ImageLabel (copy), u231 (copy)
            ImageLabel.Position = UDim2.new(0.5, -math.floor(u231.TextBounds.X / 2) - 5, 0.5, 0);
            ImageLabel.ImageTransparency = u231.TextTransparency;
        end;

        local connections = v234.connections;
        local PropertyChangedSignal = u231:GetPropertyChangedSignal("TextBounds");
        table.insert(connections, PropertyChangedSignal:Connect(place));
        local connections2 = v234.connections;
        local PropertyChangedSignal2 = u231:GetPropertyChangedSignal("TextTransparency");
        table.insert(connections2, PropertyChangedSignal2:Connect(place));
        v234.place = place;
        u228[u231] = v234;
    end;

    local v236 = u231:FindFirstChildWhichIsA("UITextSizeConstraint");
    local math_floor_ret = math.floor((u231.TextScaled and (v236 and v236.MaxTextSize or u231.AbsoluteSize.Y * 0.5) or u231.TextSize) * 1.3 + 0.5);
    local math_max_ret = math.max(10, math_floor_ret);
    local v237 = (p233 or table_freeze_ret).dim == true;

    if v234.currency ~= p232 or (v234.size ~= math_max_ret or v234.dim ~= v237) then
        v234.currency = p232;
        v234.size = math_max_ret;
        v234.dim = v237;
        v234.icon.Image = resolveIcon(p232 == "gems" and "gemPrice" or "coin");
        v234.icon.Size = UDim2.fromOffset(math_max_ret, math_max_ret);
        v234.icon.ImageColor3 = v237 and table_freeze_ret2.grey or Color3_new_ret2;
        v234.padding.PaddingLeft = UDim.new(v234.original.Scale, v234.original.Offset + math_max_ret + 5);
    end;

    v234.place();

    return u231;
end;

local u238 = {
    Ink = table_freeze_ret2.surface,
    InventoryInk = table_freeze_ret2.row,
    Paper = table_freeze_ret2.text,
    Muted = table_freeze_ret2.textSecondary,
    Gold = table_freeze_ret2.gold,
    Mint = table_freeze_ret2.green,
    Blue = table_freeze_ret2.chicken,
    Purple = table_freeze_ret2.gem,
    Gem = table_freeze_ret2.gemText,
    Border = table_freeze_ret2.neutral
};

local function surface(p239, p240, p241, p242, p243, p244) -- Line: 1307
    -- upvalues: table_freeze_ret2 (copy), Inner (copy), Border (copy), FixedSize (copy), Round (copy), Color3_new_ret (copy), Outer (copy), u11 (copy), u10 (copy)
    p239.BackgroundColor3 = p240;
    p239.BorderSizePixel = 0;

    for _, child in p239:GetChildren() do
        if child:IsA("UIGradient") then
            child.Enabled = false;
        end;
    end;

    local Corner = p239:FindFirstChild("Corner");

    if not (Corner and Corner:IsA("UICorner")) then
        Corner = p239:FindFirstChildOfClass("UICorner");
    end;

    local v245 = Corner or Instance.new("UICorner");

    if string.sub(v245.Name, 1, 4) ~= "Skin" then
        v245.Name = "Corner";
    end;

    v245.CornerRadius = UDim.new(0, p242 or 5);
    v245.Parent = p239;
    local Border2 = p239:FindFirstChild("Border");

    if not (Border2 and Border2:IsA("UIStroke")) then
        Border2 = nil;

        for _, child in p239:GetChildren() do
            if child:IsA("UIStroke") and string.sub(child.Name, 1, 4) ~= "Skin" then
                Border2 = child;
                break;
            end;
        end;
    end;

    local v246 = Border2 or Instance.new("UIStroke");
    v246.Name = "Border";
    local v247 = p243 or 0.62;
    local math_clamp_ret = math.clamp(p244 or (1 - v247) * (1 - v247), 0, 1);
    local v248 = v247 >= 0.999;
    local v249 = table_freeze_ret2.neutral:Lerp(p241 or table_freeze_ret2.neutral, math_clamp_ret);
    v246.ApplyStrokeMode = Border;
    v246.StrokeSizingMode = FixedSize;
    v246.LineJoinMode = Round;
    v246.BorderStrokePosition = Inner;
    v246.Color = v249;
    v246.Thickness = 2;
    v246.Transparency = v248 and 1 or 0 or 0;
    v246.Parent = p239;
    local SkinStroke = p239:FindFirstChild("SkinStroke");

    if SkinStroke then
        SkinStroke.Enabled = false;
    end;

    local SkinOutline = p239:FindFirstChild("SkinOutline");
    local v250;

    if SkinOutline and SkinOutline.ClassName == "UIStroke" then
        v250 = false;
    else
        SkinOutline = Instance.new("UIStroke");
        SkinOutline.Name = "SkinOutline";
        v250 = true;
    end;

    SkinOutline.ApplyStrokeMode = Border;
    SkinOutline.StrokeSizingMode = FixedSize;
    SkinOutline.LineJoinMode = Round;
    SkinOutline.BorderStrokePosition = Outer;
    SkinOutline.Color = Color3_new_ret;
    SkinOutline.Thickness = (p242 or 5) >= 10 and 3 or 2 or 2;
    SkinOutline.Transparency = v248 and 1 or 0 or 0;
    SkinOutline.Enabled = true;

    if v250 then
        SkinOutline.Parent = p239;
    end;

    u11[p239] = v246.Color;
    u10[p239] = p240;
end;

function u238.surface(p251, p252, p253, p254, p255) -- Line: 1353
    -- upvalues: surface (copy)
    surface(p251, p252, p253, p254, p255);
end;

function u238.button(p256, p257, p258) -- Line: 1357
    -- upvalues: surface (copy), u238 (copy), textStroke (copy), u1 (copy)
    surface(p256, p258 or u238.Ink:Lerp(p257, 0.1), p257, 5, 0.62, 0.65);
    p256.TextColor3 = u238.Paper;
    p256.Font = Enum.Font.GothamBold;
    textStroke(p256, u1.Stroke.text);
end;

u1.Theme = u238;
local u259 = {
    Ink = table_freeze_ret2.surface,
    Paper = table_freeze_ret2.text,
    Muted = table_freeze_ret2.textSecondary,
    Gold = table_freeze_ret2.gold,
    Blue = table_freeze_ret2.chicken,
    Purple = table_freeze_ret2.gem,
    Gem = table_freeze_ret2.gemText
};
local u260 = nil;

local function original() -- Line: 1380
    -- upvalues: u260 (ref), ReplicatedStorage (copy)
    if not u260 then
        u260 = require(ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("ValleyPanels"));
    end;

    return u260;
end;

function u259.make(p261, p262, p263, p264) -- Line: 1388
    -- upvalues: table_freeze_ret (copy)
    local Instance_new_ret = Instance.new(p261);
    Instance_new_ret.Name = p263;

    for i, v in p264 or table_freeze_ret do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p262;

    return Instance_new_ret;
end;

function u259.fullscreenShade(p265, p266) -- Line: 1398
    -- upvalues: u260 (ref), ReplicatedStorage (copy)
    if not u260 then
        u260 = require(ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("ValleyPanels"));
    end;

    return u260.fullscreenShade(p265, p266);
end;

function u259.cursorWhileVisible(p267) -- Line: 1402
    -- upvalues: u260 (ref), ReplicatedStorage (copy)
    if not u260 then
        u260 = require(ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("ValleyPanels"));
    end;

    return u260.cursorWhileVisible(p267);
end;

function u259.screen(p268, p269, p270) -- Line: 1406
    -- upvalues: u260 (ref), ReplicatedStorage (copy)
    if not u260 then
        u260 = require(ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("ValleyPanels"));
    end;

    return u260.screen(p268, p269, p270);
end;

function u259.corner(p271, p272) -- Line: 1410
    -- upvalues: u259 (copy)
    u259.make("UICorner", p271, "Corner", {
        CornerRadius = UDim.new(0, p272 or 10)
    });
end;

function u259.stroke(p273, p274, p275) -- Line: 1414
    -- upvalues: u259 (copy), Color3_new_ret (copy), table_freeze_ret2 (copy), Inner (copy), Border (copy), FixedSize (copy), Round (copy), Outer (copy), u11 (copy)
    local v276 = p275 or 0.6;

    if p273:IsA("TextLabel") or (p273:IsA("TextButton") or p273:IsA("TextBox")) then
        u259.make("UIStroke", p273, "Outline", {
            Thickness = 1,
            Color = p274 or Color3_new_ret,
            Transparency = v276
        });

        return;
    end;

    local v277 = v276 >= 0.999;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Outline";
    local v278 = table_freeze_ret2.neutral:Lerp(p274 or table_freeze_ret2.neutral, (math.clamp((1 - v276) * (1 - v276), 0, 1)));
    UIStroke.ApplyStrokeMode = Border;
    UIStroke.StrokeSizingMode = FixedSize;
    UIStroke.LineJoinMode = Round;
    UIStroke.BorderStrokePosition = Inner;
    UIStroke.Color = v278;
    UIStroke.Thickness = 2;
    UIStroke.Transparency = v277 and 1 or 0 or 0;
    UIStroke.Parent = p273;
    local SkinOutline = p273:FindFirstChild("SkinOutline");
    local v279;

    if SkinOutline and SkinOutline.ClassName == "UIStroke" then
        v279 = false;
    else
        SkinOutline = Instance.new("UIStroke");
        SkinOutline.Name = "SkinOutline";
        v279 = true;
    end;

    SkinOutline.ApplyStrokeMode = Border;
    SkinOutline.StrokeSizingMode = FixedSize;
    SkinOutline.LineJoinMode = Round;
    SkinOutline.BorderStrokePosition = Outer;
    SkinOutline.Color = Color3_new_ret;
    SkinOutline.Thickness = 2;
    SkinOutline.Transparency = v277 and 1 or 0 or 0;
    SkinOutline.Enabled = true;

    if v279 then
        SkinOutline.Parent = p273;
    end;

    u11[p273] = UIStroke.Color;
end;

function u259.text(p280, p281, p282, p283, p284, p285, p286, p287, p288) -- Line: 1430
    -- upvalues: u259 (copy), textStroke (copy)
    local v289 = u259.make("TextLabel", p280, p281, {
        BackgroundTransparency = 1,
        TextWrapped = true,
        Position = UDim2.fromOffset(p283, p284),
        Size = UDim2.fromOffset(p285, p286),
        Text = p282,
        TextColor3 = p288 or u259.Paper,
        Font = Enum.Font.Gotham,
        TextSize = p287 or 16,
        TextXAlignment = Enum.TextXAlignment.Left
    });
    textStroke(v289, 1);

    return v289;
end;

function u259.button(p290, p291, p292, p293, p294, p295, p296, p297) -- Line: 1440
    -- upvalues: u259 (copy), table_freeze_ret2 (copy), u1 (copy), Color3_new_ret (copy), Outer (copy), Border (copy), FixedSize (copy), Round (copy), ring (copy), textStroke (copy), u10 (copy)
    local v298 = u259.make("TextButton", p290, p291, {
        TextSize = 14,
        BorderSizePixel = 0,
        AutoButtonColor = true,
        Position = UDim2.fromOffset(p293, p294),
        Size = UDim2.fromOffset(p295, p296),
        Text = p292,
        BackgroundColor3 = p297 or table_freeze_ret2.button,
        TextColor3 = u259.Paper,
        Font = Enum.Font.GothamBold
    });
    u259.corner(v298, 8);
    local v299 = u1.Stroke.button[1];
    local SkinOutline = v298:FindFirstChild("SkinOutline");
    local v300;

    if SkinOutline and SkinOutline.ClassName == "UIStroke" then
        v300 = false;
    else
        SkinOutline = Instance.new("UIStroke");
        SkinOutline.Name = "SkinOutline";
        v300 = true;
    end;

    SkinOutline.ApplyStrokeMode = Border;
    SkinOutline.StrokeSizingMode = FixedSize;
    SkinOutline.LineJoinMode = Round;
    SkinOutline.BorderStrokePosition = Outer;
    SkinOutline.Color = Color3_new_ret;
    SkinOutline.Thickness = v299 or 2;
    SkinOutline.Transparency = 0;
    SkinOutline.Enabled = true;

    if v300 then
        SkinOutline.Parent = v298;
    end;

    ring(v298, table_freeze_ret2.neutral, u1.Stroke.button[2]);
    textStroke(v298, u1.Stroke.text);
    u10[v298] = v298.BackgroundColor3;

    return v298;
end;

function u259.panel(p301, p302, p303, p304) -- Line: 1456
    -- upvalues: u260 (ref), ReplicatedStorage (copy), u1 (copy), u259 (copy), u10 (copy), table_freeze_ret2 (copy), Inner (copy), Border (copy), FixedSize (copy), Round (copy), Color3_new_ret (copy), Outer (copy), u11 (copy)
    if not u260 then
        u260 = require(ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("ValleyPanels"));
    end;

    local v305, v306, v307 = u260.panel(p301, p302, p303, p304);
    u1.shade(v305);
    v306.BackgroundColor3 = u259.Ink;
    u10[v306] = u259.Ink;
    local Outline = v306:FindFirstChild("Outline");

    if Outline and Outline:IsA("UIStroke") then
        local neutral = table_freeze_ret2.neutral;
        local v308 = u1.Stroke.panel[2];
        Outline.ApplyStrokeMode = Border;
        Outline.StrokeSizingMode = FixedSize;
        Outline.LineJoinMode = Round;
        Outline.BorderStrokePosition = Inner;
        Outline.Color = neutral;
        Outline.Thickness = v308;
        Outline.Transparency = 0;
    end;

    local v309 = u1.Stroke.panel[1];
    local SkinOutline = v306:FindFirstChild("SkinOutline");
    local v310;

    if SkinOutline and SkinOutline.ClassName == "UIStroke" then
        v310 = false;
    else
        SkinOutline = Instance.new("UIStroke");
        SkinOutline.Name = "SkinOutline";
        v310 = true;
    end;

    SkinOutline.ApplyStrokeMode = Border;
    SkinOutline.StrokeSizingMode = FixedSize;
    SkinOutline.LineJoinMode = Round;
    SkinOutline.BorderStrokePosition = Outer;
    SkinOutline.Color = Color3_new_ret;
    SkinOutline.Thickness = v309 or 2;
    SkinOutline.Transparency = 0;
    SkinOutline.Enabled = true;

    if v310 then
        SkinOutline.Parent = v306;
    end;

    u11[v306] = table_freeze_ret2.neutral;
    u1.button(v307, "close");

    return v305, v306, v307;
end;

u1.Panels = u259;

return table.freeze(u1);