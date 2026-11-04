 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local TextService = game:GetService("TextService");
game:GetService("ContentProvider");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local SkinCatalog = require(Weapons:WaitForChild("SkinCatalog"));
local KnifeIconCopy = require(Weapons:WaitForChild("KnifeIconCopy"));
local CrateCatalog = require(ChickenOrHero:WaitForChild("Crates"):WaitForChild("CrateCatalog"));
local u1 = nil;
local u2 = nil;
local u3 = nil;

local function poseModule() -- Line: 60
    -- upvalues: u1 (ref), ChickenOrHero (copy), u2 (ref), u3 (ref)
    if u1 == nil then
        local l_require = require;
        local Interface = ChickenOrHero:WaitForChild("Interface");
        local success, result = pcall(l_require, Interface:WaitForChild("EmotePose"));

        if not success then
            result = false;
        end;

        u1 = result;
        local l_require2 = require;
        local Interface2 = ChickenOrHero:WaitForChild("Interface");
        local success2, result2 = pcall(l_require2, Interface2:WaitForChild("EmoteSound"));

        if not success2 then
            result2 = false;
        end;

        u2 = result2;
        local l_require3 = require;
        local Interface3 = ChickenOrHero:WaitForChild("Interface");
        local success3, result3 = pcall(l_require3, Interface3:WaitForChild("CharacterFrame"));
        u3 = not success3 and {
            fit = function() -- Line: 67, Name: fit
            end
        } or result3;
    end;

    return u1 or nil;
end;

local LocalPlayer = Players.LocalPlayer;
local u4 = {};
u4.__index = u4;
u4.UNAVAILABLE = "This feature is currently not available.";
u4.COINS = {
    name = "Coins",
    icon = "rbxassetid://78008558948307",
    color = Color3.fromRGB(255, 202, 58)
};
local u5 = {
    Pumpkin = "rbxassetid://122172980164834",
    Bat = "rbxassetid://70771941159898",
    Moon = "rbxassetid://108163343124811",
    Web = "rbxassetid://77897902869831",
    Spider = "rbxassetid://100826167291348",
    Ghost = "rbxassetid://121891052662054",
    Tombstone = "rbxassetid://109374624586738",
    WitchHat = "rbxassetid://78688261007229",
    Cauldron = "rbxassetid://83317730984861",
    Graveyard = "rbxassetid://126547294477184",
    Sunray = "rbxassetid://129028976496842",
    GlowGold = "rbxassetid://101867007295297",
    Soft = "rbxassetid://120639974824188",
    Stripes = "rbxassetid://140022482252277",
    Dagger = "rbxassetid://111671278699403"
};
local u6 = {
    night = Color3.fromRGB(34, 16, 48),
    deep = Color3.fromRGB(11, 6, 17),
    pumpkin = Color3.fromRGB(255, 132, 28),
    ember = Color3.fromRGB(255, 184, 72),
    witch = Color3.fromRGB(176, 98, 255),
    mist = Color3.fromRGB(196, 170, 255),
    fog = Color3.fromRGB(120, 78, 170),
    moon = Color3.fromRGB(255, 238, 196),
    web = Color3.fromRGB(226, 220, 240),
    gold = Color3.fromRGB(255, 202, 58),
    ink = Color3.fromRGB(23, 14, 32),
    edge = Color3.fromRGB(86, 60, 110),
    white = Color3.new(1, 1, 1),
    black = Color3.new(0, 0, 0),
    titleStroke = Color3.fromRGB(40, 8, 30)
};
local u7 = {
    COMMON = Color3.fromRGB(175, 185, 192),
    RARE = Color3.fromRGB(92, 173, 238),
    EPIC = Color3.fromRGB(183, 123, 244),
    LEGENDARY = Color3.fromRGB(242, 191, 89)
};
local u8 = {
    pumpkin = { Color3.fromRGB(255, 176, 70), Color3.fromRGB(226, 92, 8), Color3.fromRGB(255, 150, 50) },
    grey = { Color3.fromRGB(110, 100, 120), Color3.fromRGB(70, 62, 80), Color3.fromRGB(110, 100, 120) },
    close = { Color3.fromRGB(255, 106, 128), Color3.fromRGB(224, 33, 61), Color3.fromRGB(255, 152, 166) },
    robux = { Color3.fromRGB(108, 226, 118), Color3.fromRGB(30, 148, 62), Color3.fromRGB(150, 240, 160) }
};
local Font_fromEnum_ret = Font.fromEnum(Enum.Font.Creepster);
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold);
local utf8_char_ret = utf8.char(57346);

local function make(p9, p10, p11, p12) -- Line: 141
    local Instance_new_ret = Instance.new(p9);
    Instance_new_ret.Name = p11;

    for i, v in p12 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p10;

    return Instance_new_ret;
end;

local function merge(p13, p14) -- Line: 150
    local v15 = {};

    for i, v in p13 do
        v15[i] = v;
    end;

    for i, v in p14 do
        v15[i] = v;
    end;

    return v15;
end;

local function sp(p16, p17, p18, p19) -- Line: 162
    return {
        w = p16,
        h = p17,
        ox = p18 or 0,
        oy = p19 or 0
    };
end;

local function at(p20, p21, p22) -- Line: 165
    return UDim2.fromScale((p21 - p20.ox) / p20.w, (p22 - p20.oy) / p20.h);
end;

local function tl(p23, p24, p25, p26, p27) -- Line: 168
    return {
        AnchorPoint = Vector2.zero,
        Position = UDim2.fromScale((p24 - p23.ox) / p23.w, (p25 - p23.oy) / p23.h),
        Size = UDim2.fromScale(p26 / p23.w, p27 / p23.h)
    };
end;

local function ct(p28, p29, p30, p31, p32) -- Line: 171
    return {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale((p29 - p28.ox) / p28.w, (p30 - p28.oy) / p28.h),
        Size = UDim2.fromScale(p31 / p28.w, p32 / p28.h)
    };
end;

local function corner(p33, p34) -- Line: 174
    local v35 = {
        CornerRadius = UDim.new(p34, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v35 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = p33;
end;

local function rings(p36, p37, p38, p39) -- Line: 178
    -- upvalues: u6 (copy)
    local v40 = {
        ZIndex = 1,
        Color = u6.black,
        Thickness = p38,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Outline";

    for i, v in v40 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p36;
    local v41 = {
        ZIndex = 2,
        Color = p37,
        Thickness = p39,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Name = "Ring";

    for i, v in v41 or {} do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = p36;

    return UIStroke2;
end;

local function cssBox(p42, p43, p44, p45, p46, p47, p48, p49, p50) -- Line: 197
    -- upvalues: tl (copy), rings (copy)
    local v51 = p50.border or 0;
    local v52 = tl(p45, p46 + v51, p47 + v51, p48 - 2 * v51, p49 - 2 * v51);
    local v53 = p50.props or {};
    local v54 = {};

    for i, v in v52 do
        v54[i] = v;
    end;

    for i, v in v53 do
        v54[i] = v;
    end;

    local Instance_new_ret = Instance.new(p42);
    Instance_new_ret.Name = p44;

    for i, v in v54 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p43;
    local math_min_ret = math.min(p48 - 2 * v51, p49 - 2 * v51);

    if p50.radius and p50.radius > 0 then
        local v55 = math.max(p50.radius - v51, 0) / math_min_ret;
        local v56 = {
            CornerRadius = UDim.new(v55, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i, v in v56 or {} do
            UICorner[i] = v;
        end;

        UICorner.Parent = Instance_new_ret;
    end;

    if p50.ring then
        rings(Instance_new_ret, p50.ring, (v51 + (p50.outer or 0)) / math_min_ret, v51 / math_min_ret);
    end;

    return Instance_new_ret, {
        w = p48 - 2 * v51,
        h = p49 - 2 * v51,
        ox = v51 or 0,
        oy = v51 or 0
    }, math_min_ret;
end;

local function label(p57, p58, p59, p60, p61, p62) -- Line: 209
    -- upvalues: Font_new_ret (copy), u6 (copy)
    local v63 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        TextWrapped = true,
        Active = false,
        Interactable = false,
        FontFace = p62 or Font_new_ret,
        Text = p59,
        TextColor3 = u6.white
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p58;

    for i, v in v63 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p57;

    for i, v in p60 or {} do
        TextLabel[i] = v;
    end;

    local v64 = {
        Color = u6.black,
        Thickness = p61 or 0.1,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";

    for i, v in v64 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    return TextLabel;
end;

local function deco(p65, p66, p67, p68) -- Line: 231
    p68.BorderSizePixel = 0;
    p68.Active = false;
    p68.Interactable = false;

    if p65 ~= "Frame" and p65 ~= "CanvasGroup" then
        p68.BackgroundTransparency = 1;
    end;

    local Instance_new_ret = Instance.new(p65);
    Instance_new_ret.Name = p67;

    for i, v in p68 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p66;

    return Instance_new_ret;
end;

local function picture(p69, p70, p71, p72) -- Line: 240
    -- upvalues: u5 (copy)
    p72.Image = u5[p71] or p71;
    p72.ScaleType = p72.ScaleType or Enum.ScaleType.Fit;
    p72.BorderSizePixel = 0;
    p72.Active = false;
    p72.Interactable = false;
    p72.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = p70;

    for i, v in p72 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = p69;

    return ImageLabel;
end;

local function gradient(p73, p74, p75, p76, p77) -- Line: 245
    local v78 = {
        Rotation = 90,
        Color = ColorSequence.new(p74, p75),
        Transparency = NumberSequence.new(p76 or 0, p77 or 0)
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in v78 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = p73;

    return UIGradient;
end;

local function commas(p79) -- Line: 252
    local string_format = string.format;
    local v80 = tonumber(p79) or 0;
    local v81 = string_format("%.0f", (math.abs(v80)));
    local string_reverse_ret = string.reverse((string.gsub(string.reverse(v81), "(%d%d%d)", "%1,")));
    local string_gsub_ret = string.gsub(string_reverse_ret, "^,", "");

    return ((tonumber(p79) or 0) < 0 and "-" or "") .. string_gsub_ret;
end;

local function mute(p82, p83) -- Line: 258
    return p82:Lerp(Color3.fromRGB(120, 112, 132), p83);
end;

local u84 = {};

local function textWidth(u85, u86, p87) -- Line: 269
    -- upvalues: u84 (copy), TextService (copy)
    local v88 = u85 .. "\0" .. u86.Family .. "\0" .. u86.Weight.Value;
    local v89 = u84[v88];

    if not v89 then
        local success, result = pcall(function() -- Line: 273
            -- upvalues: u85 (copy), u86 (copy), TextService (ref)
            local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
            GetTextBoundsParams.Text = u85;
            GetTextBoundsParams.Font = u86;
            GetTextBoundsParams.Size = 100;
            GetTextBoundsParams.Width = 100000;

            return TextService:GetTextBoundsAsync(GetTextBoundsParams);
        end);

        if success then
            v89 = result.X;
        else
            v89 = #u85 * 62;
        end;

        u84[v88] = v89;
    end;

    return v89 * p87 / 100;
end;

local function breaks(u90, p91) -- Line: 287
    local v92 = {};
    local v93 = #u90;

    local function join(p94, p95) -- Line: 290
        -- upvalues: u90 (copy)
        return table.concat(u90, " ", p94, p95);
    end;

    if p91 == 1 then
        local v96 = { join(1, v93) };
        table.insert(v92, v96);

        return v92;
    end;

    if p91 == 2 then
        for i = 1, v93 - 1 do
            local v97 = { table.concat(u90, " ", 1, i), join(i + 1, v93) };
            table.insert(v92, v97);
            local _ = i;
        end;

        return v92;
    end;

    for i = 1, v93 - 2 do
        local v98 = i;

        for i2 = i + 1, v93 - 1 do
            local v99 = { table.concat(u90, " ", 1, v98), table.concat(u90, " ", v98 + 1, i2), join(i2 + 1, v93) };
            table.insert(v92, v99);
            local _ = i2;
        end;
    end;

    return v92;
end;

local function wrap(p100, p101, p102, p103, p104, p105, p106, p107) -- Line: 310
    -- upvalues: breaks (copy), textWidth (copy)
    local v108 = {};

    for i in string.gmatch(p100, "%S+") do
        table.insert(v108, i);
    end;

    if #v108 == 0 then
        return { "" }, p102;
    end;

    local v109 = -1;
    local v110 = nil;
    local v111 = 0;

    for i = math.min(p107 or 1, #v108), math.min(p104, #v108) do
        local v112 = i;

        for _, v in breaks(v108, i) do
            local v113 = v;
            local v114 = 0;

            for _, v2 in v do
                local v115 = textWidth(v2, p101, p102);
                v114 = math.max(v114, v115);
            end;

            local v116;

            if p103 < v114 then
                v116 = p102 * p103 / v114;
            else
                v116 = p102;
            end;

            if p105 then
                v116 = math.min(v116, p105 / (1 + (v112 - 1) * p106));
            end;

            local v117 = v116 * 0.93 ^ (v112 - 1) - v114 * 0.0001;

            if v109 < v117 then
                v111 = v116;
                v110 = v113;
                v109 = v117;
            end;
        end;
    end;

    return v110, v111;
end;

local function slot(p118, p119, p120, p121, p122, p123) -- Line: 340
    -- upvalues: Font_new_ret (copy), label (copy)
    p121.space = p120;
    p121.font = p121.font or Font_new_ret;
    p121.lines = p121.lines or 1;
    p121.lh = p121.lh or 1;
    p121.align = p121.align or Enum.TextXAlignment.Center;
    local v124 = {};
    local v125 = p122 or {};

    for i, v in {
        TextXAlignment = p121.align,
        LineHeight = p121.lh
    } do
        v124[i] = v;
    end;

    for i, v in v125 do
        v124[i] = v;
    end;

    p121.label = label(p118, p119, "", v124, p123, p121.font);

    return p121;
end;

local function put(p126, p127) -- Line: 349
    -- upvalues: wrap (copy)
    local v128, v129 = wrap(p127, p126.font, p126.size, p126.w, p126.lines, p126.maxH, p126.lh, p126.minLines);
    local v130 = #v128;
    local v131 = v129 * (1 + (v130 - 1) * p126.lh);
    local label2 = p126.label;
    local space = p126.space;
    local v132 = p126.align == Enum.TextXAlignment.Left and 0 or (p126.align == Enum.TextXAlignment.Right and 1 or 0.5);
    local v133 = p126.x or p126.cx;
    label2.Text = table.concat(v128, "\n");
    label2.AnchorPoint = Vector2.new(v132, p126.by and 1 or 0.5);
    label2.Position = UDim2.fromScale((v133 - space.ox) / space.w, ((p126.by or p126.cy) - space.oy) / space.h);
    label2.Size = UDim2.fromScale(p126.w * 1.06 / space.w, v131 / space.h);
    p126.shownSize = v129;
    p126.shownLines = v130;

    return v129;
end;

local function glow(p134, p135, p136, p137, p138, p139, p140, p141, p142, p143) -- Line: 370
    -- upvalues: ct (copy), u5 (copy)
    local v144 = ct(p136, p137, p138, p139, p140);
    local v145 = {
        ImageColor3 = p141,
        ImageTransparency = p142,
        ScaleType = Enum.ScaleType.Stretch,
        ZIndex = p143
    };
    local v146 = {};

    for i, v in v144 do
        v146[i] = v;
    end;

    for i, v in v145 do
        v146[i] = v;
    end;

    v146.Image = u5.Soft or "Soft";
    v146.ScaleType = v146.ScaleType or Enum.ScaleType.Fit;
    v146.BorderSizePixel = 0;
    v146.Active = false;
    v146.Interactable = false;
    v146.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = p135;

    for i, v in v146 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = p134;

    return ImageLabel;
end;

local function sparkle(p147, p148, p149, p150, p151, p152, p153, p154) -- Line: 374
    -- upvalues: ct (copy), u6 (copy)
    local v155 = {};
    local v156 = {
        BackgroundTransparency = 1,
        ZIndex = p154
    };

    for i, v in ct(p149, p150, p151, p152, p152) do
        v155[i] = v;
    end;

    for i, v in v156 do
        v155[i] = v;
    end;

    v155.BorderSizePixel = 0;
    v155.Active = false;
    v155.Interactable = false;
    local Frame = Instance.new("Frame");
    Frame.Name = p148;

    for i, v in v155 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = p147;
    local UIScale = Instance.new("UIScale");
    UIScale.Name = "Twinkle";

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;

    for i, v in { { 0.16, 1 }, { 1, 0.16 } } do
        local v157 = {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(v[1], v[2]),
            BackgroundColor3 = p153,
            ZIndex = p154,
            BorderSizePixel = 0,
            Active = false,
            Interactable = false
        };
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "Ray" .. i;

        for i2, v2 in v157 or {} do
            Frame2[i2] = v2;
        end;

        Frame2.Parent = Frame;
        local v158 = {
            CornerRadius = UDim.new(0.5, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i2, v2 in v158 or {} do
            UICorner[i2] = v2;
        end;

        UICorner.Parent = Frame2;
        local v159 = {
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 0.9) }),
            Rotation = i == 1 and 90 or 0
        };
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Name = "UIGradient";

        for i2, v2 in v159 or {} do
            UIGradient[i2] = v2;
        end;

        UIGradient.Parent = Frame2;
    end;

    local v160 = {
        Rotation = 45,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.3, 0.3),
        BackgroundColor3 = u6.white,
        ZIndex = p154,
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Core";

    for i, v in v160 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v161 = {
        CornerRadius = UDim.new(0.2, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v161 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame2;

    return {
        root = Frame,
        scale = UIScale
    };
end;

local function bar(p162, p163, p164, p165, p166, p167, p168, p169, p170, p171) -- Line: 403
    local v172 = math.sqrt((p167 - p165) ^ 2 + (p168 - p166) ^ 2) + p169;
    local v173 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(((p165 + p167) / 2 - p164.ox) / p164.w, ((p166 + p168) / 2 - p164.oy) / p164.h),
        Size = UDim2.fromScale(v172 / p164.w, p169 / p164.h)
    };
    local math_atan2_ret = math.atan2(p168 - p166, p167 - p165);
    v173.Rotation = math.deg(math_atan2_ret);
    v173.BackgroundColor3 = p170;
    v173.ZIndex = p171;
    v173.BorderSizePixel = 0;
    v173.Active = false;
    v173.Interactable = false;
    local Frame = Instance.new("Frame");
    Frame.Name = p163;

    for i, v in v173 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = p162;
    local v174 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v174 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;

    return Frame;
end;

local function checkMark(p175, p176, p177, p178) -- Line: 417
    -- upvalues: u6 (copy), bar (copy)
    local v179 = {};
    local v180 = {
        BackgroundTransparency = 1,
        ZIndex = p178
    };

    for i, v in p177 do
        v179[i] = v;
    end;

    for i, v in v180 do
        v179[i] = v;
    end;

    v179.BorderSizePixel = 0;
    v179.Active = false;
    v179.Interactable = false;
    local Frame = Instance.new("Frame");
    Frame.Name = p176;

    for i, v in v179 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = p175;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.Name = "Square";

    for i, v in {
        AspectRatio = 1
    } or {} do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = Frame;
    local v181 = {
        w = 30,
        h = 30,
        ox = 0,
        oy = 0
    };

    for i, v in { u6.black, u6.white } do
        local v182 = i == 1 and 9 or 5;
        bar(Frame, "Short" .. i, v181, 6, 16, 12, 22, v182, v, p178 + i);
        bar(Frame, "Long" .. i, v181, 12, 22, 25, 8, v182, v, p178 + i);
    end;

    return Frame;
end;

local function priceButton(p183, p184, p185, p186, p187, p188, p189, p190) -- Line: 431
    -- upvalues: cssBox (copy), u8 (copy), u6 (copy), tl (copy), u4 (copy), ct (copy), u5 (copy), label (copy), utf8_char_ret (copy), Font_new_ret2 (copy), checkMark (copy)
    local border = p190.border;
    local v191, v192 = cssBox("ImageButton", p183, p184, p185, p186, p187, p188, p189, {
        border = border,
        radius = p190.radius,
        ring = u8.pumpkin[3],
        outer = p190.outer,
        props = {
            AutoButtonColor = true,
            BorderSizePixel = 0,
            BackgroundColor3 = u6.white,
            ZIndex = p190.z
        }
    });
    local Ring = v191:FindFirstChild("Ring");
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in {
        Rotation = 90
    } or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = v191;
    local v193 = {
        BackgroundTransparency = 1,
        Active = false,
        Interactable = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.93),
        ZIndex = p190.z + 1
    };
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "Texture";

    for i, v in v193 or {} do
        CanvasGroup[i] = v;
    end;

    CanvasGroup.Parent = v191;
    local v194 = {
        CornerRadius = UDim.new(0.2, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v194 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = CanvasGroup;
    local v195 = {
        Rotation = 45,
        BackgroundTransparency = 1,
        Image = "rbxassetid://140022482252277",
        ImageTransparency = 0.82,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.87, 8),
        ScaleType = Enum.ScaleType.Tile,
        TileSize = UDim2.fromScale(0.35, 0.35),
        ZIndex = p190.z + 1
    };
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Stripes";

    for i, v in v195 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = CanvasGroup;
    local v196 = {
        Rotation = 90,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 0) })
    };
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Name = "UIGradient";

    for i, v in v196 or {} do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = ImageLabel;
    local v197 = tl(v192, border + 6, border + 3, p188 - 2 * border - 12, (p189 - 2 * border) * 0.38);
    local v198 = {
        BackgroundColor3 = u6.white,
        ZIndex = p190.z + 2
    };
    local v199 = {};

    for i, v in v197 do
        v199[i] = v;
    end;

    for i, v in v198 do
        v199[i] = v;
    end;

    v199.BorderSizePixel = 0;
    v199.Active = false;
    v199.Interactable = false;
    local Frame = Instance.new("Frame");
    Frame.Name = "Gloss";

    for i, v in v199 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = v191;
    local v200 = {
        CornerRadius = UDim.new(0.4, 0)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v200 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame;
    local v201 = {
        Rotation = 90,
        Transparency = NumberSequence.new(0.62, 1)
    };
    local UIGradient3 = Instance.new("UIGradient");
    UIGradient3.Name = "UIGradient";

    for i, v in v201 or {} do
        UIGradient3[i] = v;
    end;

    UIGradient3.Parent = Frame;
    local v202 = {
        button = v191,
        space = v192,
        ring = Ring,
        gradient = UIGradient,
        texture = CanvasGroup,
        w = p188,
        h = p189,
        border = border,
        size = p190.size,
        coinSize = p190.coin,
        gap = p190.gap,
        z = p190.z + 3
    };
    local icon = u4.COINS.icon;
    local v203 = ct(v192, p188 / 2, p189 / 2, p190.coin, p190.coin);
    local v204 = {
        Visible = false,
        ZIndex = v202.z
    };
    local v205 = {};

    for i, v in v203 do
        v205[i] = v;
    end;

    for i, v in v204 do
        v205[i] = v;
    end;

    v205.Image = u5[icon] or icon;
    v205.ScaleType = v205.ScaleType or Enum.ScaleType.Fit;
    v205.BorderSizePixel = 0;
    v205.Active = false;
    v205.Interactable = false;
    v205.BackgroundTransparency = 1;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "Coin";

    for i, v in v205 or {} do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = v191;
    v202.coin = ImageLabel2;
    local v206 = ct(v192, p188 / 2, p189 / 2, p190.coin, p190.coin);
    local v207 = {
        Visible = false,
        ZIndex = v202.z
    };
    local v208 = {};

    for i, v in v206 do
        v208[i] = v;
    end;

    for i, v in v207 do
        v208[i] = v;
    end;

    v202.robux = label(v191, "Robux", utf8_char_ret, v208, 0.08, Font_new_ret2);
    v202.amount = label(v191, "Amount", "", {
        Visible = false,
        ZIndex = v202.z
    }, 0.1);
    v202.word = label(v191, "Word", "", {
        Visible = false,
        ZIndex = v202.z
    }, 0.1);
    v202.check = checkMark(v191, "Check", ct(v192, p188 / 2, p189 / 2, 30, 30), v202.z);
    v202.check.Visible = false;

    return v202;
end;

local function setLook(p209, p210) -- Line: 494
    -- upvalues: u8 (copy), u6 (copy)
    local v211 = u8[p210];
    p209.gradient.Color = ColorSequence.new(v211[1], v211[2]);
    p209.ring.Color = v211[3];
    p209.texture.Visible = p210 == "pumpkin";
    local v212;

    if p210 == "grey" then
        v212 = Color3.fromRGB(190, 182, 200);
    else
        v212 = u6.white;
    end;

    p209.word.TextColor3 = v212;
    p209.amount.TextColor3 = v212;
    p209.robux.TextColor3 = v212;
end;

local function layoutRow(p213, p214) -- Line: 506
    -- upvalues: textWidth (copy), Font_new_ret (copy)
    local v215 = 0;
    local v216 = 0;
    local v217 = {};

    for _, v in p214 do
        local v218 = {
            kind = v[1],
            text = v[2]
        };

        if v218.kind == "coin" or v218.kind == "robux" then
            v218.w = p213.coinSize;
            v215 = v215 + v218.w;
        elseif v218.kind == "check" then
            v218.w = 30 * p213.size / 39;
            v215 = v215 + v218.w;
        else
            v218.w = textWidth(v218.text, Font_new_ret, p213.size);
            v216 = v216 + v218.w;
        end;

        table.insert(v217, v218);
    end;

    local v219 = v215 + p213.gap * (#v217 - 1);
    local v220 = p213.w - 2 * p213.border - 16;
    local v221;

    if v220 < v219 + v216 then
        local v222 = (v220 - v219) / math.max(v216, 1);
        v221 = math.max(0.2, v222);
    else
        v221 = 1;
    end;

    local v223 = (p213.w - (v219 + v216 * v221)) / 2;
    local robux = p213.robux;
    local amount = p213.amount;
    local word = p213.word;
    local check = p213.check;
    p213.coin.Visible = false;
    robux.Visible = false;
    amount.Visible = false;
    word.Visible = false;
    check.Visible = false;
    local space = p213.space;

    for _, v in v217 do
        local v224;

        if v.kind == "coin" or (v.kind == "robux" or v.kind == "check") then
            v224 = v.w;
        else
            v224 = v.w * v221;
        end;

        local v225 = v223 + v224 / 2;

        if v.kind == "coin" then
            p213.coin.Visible = true;
            p213.coin.Position = UDim2.fromScale((v225 - space.ox) / space.w, (p213.h / 2 - space.oy) / space.h);
        elseif v.kind == "robux" then
            p213.robux.Visible = true;
            p213.robux.Position = UDim2.fromScale((v225 - space.ox) / space.w, (p213.h / 2 - space.oy) / space.h);
            p213.robux.Size = UDim2.fromScale(v.w / space.w, v.w / space.h);
        elseif v.kind == "check" then
            p213.check.Visible = true;
            p213.check.Position = UDim2.fromScale((v225 - space.ox) / space.w, (p213.h / 2 - space.oy) / space.h);
            p213.check.Size = UDim2.fromScale(v.w / space.w, v.w / space.h);
        else
            local v226;

            if v.kind == "amount" then
                v226 = p213.amount;
            else
                v226 = p213.word;
            end;

            local v227 = p213.size * v221;
            v226.Visible = true;
            v226.Text = v.text;
            v226.AnchorPoint = Vector2.new(0.5, 0.5);
            v226.Position = UDim2.fromScale((v225 - space.ox) / space.w, (p213.h / 2 - space.oy) / space.h);
            v226.Size = UDim2.fromScale((v224 * 1.12 + 6) / space.w, v227 / space.h);
        end;

        v223 = v223 + (v224 + p213.gap);
    end;
end;

local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(1, 1, 0.35));

local function bladeOf(p228) -- Line: 560
    -- upvalues: SkinCatalog (copy), Weapons (copy)
    local v229 = SkinCatalog.get(p228);
    local Models = Weapons:FindFirstChild("Models");

    if Models then
        if v229 then
            Models = Models:FindFirstChild(v229.Model);
        else
            Models = v229;
        end;
    end;

    if Models then
        Models = Models:FindFirstChild("Blade") or Models:FindFirstChildWhichIsA("BasePart", true);
    end;

    return Models, v229;
end;

local function drawKnife(p230, p231) -- Line: 566
    -- upvalues: bladeOf (copy), KnifeIconCopy (copy), CFrame_lookAt_ret (copy)
    for _, child in p230:GetChildren() do
        if child:IsA("WorldModel") or child:IsA("Camera") then
            child:Destroy();
        end;
    end;

    local v232, v233 = bladeOf(p231);

    if not v232 then
        return nil;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "World";

    for i, v in {} do
        WorldModel[i] = v;
    end;

    WorldModel.Parent = p230;
    local v234, _, v235, v236 = KnifeIconCopy.new(v232);
    v234.Parent = WorldModel;
    local Size = v234.Size;
    local v237;

    if Size.Z >= Size.X and Size.Z >= Size.Y then
        v237 = CFrame_lookAt_ret;
    elseif Size.X >= Size.Y then
        v237 = CFrame_lookAt_ret * CFrame.Angles(0, 1.5707963267948966, 0);
    else
        v237 = CFrame_lookAt_ret * CFrame.Angles(-1.5707963267948966, 0, 0);
    end;

    local v238 = CFrame.new(-v237:VectorToWorldSpace(v236)) * v237;
    v234.CFrame = v238;
    local math_max_ret = math.max(v235.X, v235.Y, v235.Z);
    local Camera = Instance.new("Camera");
    Camera.Name = "Camera";

    for i, v in {
        FieldOfView = 35
    } or {} do
        Camera[i] = v;
    end;

    Camera.Parent = p230;
    Camera.CFrame = CFrame.lookAt(Vector3.new(0, 0, math_max_ret * 1.3), Vector3.new(0, 0, 0));
    p230.CurrentCamera = Camera;
    local v239 = {
        part = v234,
        base = v238,
        camera = Camera
    };

    if v233 then
        v233 = v233.Name;
    end;

    v239.name = v233;

    return v239;
end;

local u240 = {
    SpecialMesh = true,
    SurfaceAppearance = true,
    Decal = true,
    Texture = true
};

local function drawModel(p241, p242) -- Line: 596
    -- upvalues: u240 (copy)
    for _, child in p241:GetChildren() do
        if child:IsA("WorldModel") or child:IsA("Camera") then
            child:Destroy();
        end;
    end;

    if typeof(p242) ~= "Instance" then
        return nil;
    end;

    local Model = Instance.new("Model");
    local v243 = 0;

    for _, v in p242:IsA("BasePart") and { p242 } or p242:GetDescendants() do
        if v:IsA("BasePart") and v.Transparency < 0.95 then
            local success, result = pcall(v.Clone, v);

            if success and result then
                for _, child in result:GetChildren() do
                    if not u240[child.ClassName] then
                        child:Destroy();
                    end;
                end;

                result.Anchored = true;
                result.Parent = Model;
                v243 = v243 + 1;
            end;
        end;
    end;

    if v243 == 0 then
        Model:Destroy();

        return nil;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "World";

    for i, v in {} do
        WorldModel[i] = v;
    end;

    WorldModel.Parent = p241;
    Model.Parent = WorldModel;
    local BoundingBox, v244 = Model:GetBoundingBox();
    Model.WorldPivot = CFrame.new(BoundingBox.Position);
    Model:PivotTo(CFrame.new());
    local math_max_ret = math.max(v244.X, v244.Y, v244.Z);
    local Camera = Instance.new("Camera");
    Camera.Name = "Camera";

    for i, v in {
        FieldOfView = 35
    } or {} do
        Camera[i] = v;
    end;

    Camera.Parent = p241;
    Camera.CFrame = CFrame.lookAt(Vector3.new(0, math_max_ret * 0.3, math_max_ret * 2.05), Vector3.new(0, 0, 0));
    p241.CurrentCamera = Camera;

    return {
        model = Model
    };
end;

local u245 = { { 58, 454, 4, 0.6 }, { 156, 668, 5, 0.85 }, { 249, 322, 3, 0.44 }, { 336, 536, 4, 0.69, true }, { 416, 750, 5, 0.94 }, { 492, 404, 3, 0.54 }, { 564, 617, 4, 0.79 }, { 634, 271, 5, 0.39, true }, { 706, 485, 3, 0.63 }, { 782, 699, 4, 0.88 }, { 864, 353, 5, 0.48 }, { 952, 567, 3, 0.73, true }, { 1046, 781, 4, 0.98 }, { 1145, 435, 5, 0.58 } };
local u246 = { { 14, 770, 4, 0.9 }, { 96, 790, 3, 0.8, true }, { 404, 514, 4, 0.8 }, { 748, 520, 3, 0.7 }, { 1105, 515, 4, 0.8, true }, { 1120, 770, 4, 0.85 }, { 388, 790, 3, 0.75 }, { 60, 604, 3, 0.7 }, { 372, 575, 3, 0.65, true }, { 738, 622, 4, 0.7 }, { 1186, 640, 4, 0.8 }, { 1182, 760, 3, 0.8, true }, { 770, 786, 3, 0.75 }, { 14, 480, 3, 0.6 }, { 1188, 300, 3, 0.55 } };
local u247 = { { 688, 30, 50, -8, 1.6, 0 }, { 810, 84, 36, 10, 2.1, 1.7 }, { 630, 100, 38, 6, 1.8, 3.1 } };
local u248 = {
    w = 1200,
    h = 800,
    ox = 0,
    oy = 0
};

local function embers(p249, p250, p251, p252, p253) -- Line: 658
    -- upvalues: u6 (copy), u5 (copy)
    for i, v in p251 do
        local v254;

        if v[5] then
            v254 = u6.witch;
        else
            v254 = u6.ember;
        end;

        local v255 = {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale((v[1] - p250.ox) / p250.w, (v[2] - p250.oy) / p250.h),
            Size = UDim2.fromScale(v[3] / p250.w, v[3] / p250.h),
            BackgroundColor3 = v254,
            ZIndex = p252,
            BorderSizePixel = 0,
            Active = false,
            Interactable = false
        };
        local Frame = Instance.new("Frame");
        Frame.Name = "Ember" .. i;
        local v256 = i;
        local v257 = v;

        for i2, v2 in v255 or {} do
            Frame[i2] = v2;
        end;

        Frame.Parent = p249;
        local v258 = {
            CornerRadius = UDim.new(1, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i2, v2 in v258 or {} do
            UICorner[i2] = v2;
        end;

        UICorner.Parent = Frame;
        local v259 = {
            ImageTransparency = 0.8,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(6, 6),
            ImageColor3 = v254,
            ZIndex = p252,
            Image = u5.Soft or "Soft"
        };
        v259.ScaleType = v259.ScaleType or Enum.ScaleType.Fit;
        v259.BorderSizePixel = 0;
        v259.Active = false;
        v259.Interactable = false;
        v259.BackgroundTransparency = 1;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Halo";

        for i2, v2 in v259 or {} do
            ImageLabel[i2] = v2;
        end;

        ImageLabel.Parent = Frame;
        table.insert(p253, {
            frame = Frame,
            halo = ImageLabel,
            x = v257[1],
            y = v257[2],
            alpha = v257[4],
            period = 7 + v256 * 37 % 40 / 10,
            phase = v256 * 0.618 % 1,
            sway = 4 + v256 % 4 * 2,
            space = p250
        });
    end;
end;

function u4.new() -- Line: 691
    -- upvalues: u4 (copy), glow (copy), u248 (copy), u6 (copy), cssBox (copy), gradient (copy), tl (copy), ct (copy), u5 (copy), u247 (copy), embers (copy), u245 (copy), slot (copy), Font_fromEnum_ret (copy), put (copy), u8 (copy), bar (copy), rings (copy), u246 (copy)
    local u260 = setmetatable({
        tiles = {},
        byId = {},
        owned = {},
        busy = {},
        locked = {},
        free = {},
        embers = {},
        bats = {},
        sparkles = {},
        items = {},
        whoLabels = {}
    }, u4);
    local v261 = {
        BackgroundTransparency = 1,
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1)
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "HalloweenShop";

    for i, v in v261 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = nil;
    Frame:SetAttribute("SelfManagedText", true);
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.Name = "FixedAspectRatio";

    for i, v in {
        AspectRatio = 1.7777777777777777
    } or {} do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = Frame;
    local UIScale = Instance.new("UIScale");
    UIScale.Name = "Pop";

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    u260.pop = UIScale;
    u260.frame = Frame;
    Frame.Destroying:Connect(function() -- Line: 705
        -- upvalues: u260 (copy)
        u260.frame = nil;

        if u260.animation then
            u260.animation:Disconnect();
            u260.animation = nil;
        end;
    end);
    local v262 = {
        BackgroundTransparency = 0.28,
        ZIndex = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(3, 3),
        BackgroundColor3 = Color3.fromRGB(15, 8, 24),
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Dim";

    for i, v in v262 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v263 = {
        BackgroundTransparency = 1,
        ZIndex = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.70875, 0.84),
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "Stage";

    for i, v in v263 or {} do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint2.Name = "FixedAspectRatio";

    for i, v in {
        AspectRatio = 1.5
    } or {} do
        UIAspectRatioConstraint2[i] = v;
    end;

    UIAspectRatioConstraint2.Parent = Frame3;
    Frame3.Interactable = true;
    u260.stage = Frame3;
    glow(Frame3, "PanelGlow", u248, 600, 400, 1464, 1040, u6.pumpkin, 0.8, 1);
    gradient(cssBox("Frame", Frame3, "Panel", u248, 0, 0, 1200, 800, {
        border = 3,
        radius = 15,
        outer = 4,
        ring = u6.pumpkin,
        props = {
            BorderSizePixel = 0,
            ZIndex = 2,
            BackgroundColor3 = u6.white
        }
    }), u6.night, u6.deep);
    local v264 = {};
    local v265 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 3,
        Active = false,
        Interactable = false
    };

    for i, v in tl(u248, 3, 3, 1194, 794) do
        v264[i] = v;
    end;

    for i, v in v265 do
        v264[i] = v;
    end;

    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "Night";

    for i, v in v264 or {} do
        CanvasGroup[i] = v;
    end;

    CanvasGroup.Parent = Frame3;
    local v266 = {
        CornerRadius = UDim.new(0.015113350125944584, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v266 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = CanvasGroup;
    local v267 = {
        w = 1194,
        h = 794,
        ox = 3,
        oy = 3
    };

    for i, v in { { 250, 0.91 }, { 204, 0.83 } } do
        local v268 = ct(v267, 752, 38, v[1], v[1]);
        local v269 = {
            ZIndex = 3,
            BackgroundColor3 = u6.moon,
            BackgroundTransparency = v[2]
        };
        local v270 = {};

        for i2, v2 in v268 do
            v270[i2] = v2;
        end;

        for i2, v2 in v269 do
            v270[i2] = v2;
        end;

        v270.BorderSizePixel = 0;
        v270.Active = false;
        v270.Interactable = false;
        local Frame4 = Instance.new("Frame");
        Frame4.Name = "MoonHalo" .. i;

        for i2, v2 in v270 or {} do
            Frame4[i2] = v2;
        end;

        Frame4.Parent = CanvasGroup;
        local v271 = {
            CornerRadius = UDim.new(1, 0)
        };
        local UICorner2 = Instance.new("UICorner");
        UICorner2.Name = "UICorner";

        for i2, v2 in v271 or {} do
            UICorner2[i2] = v2;
        end;

        UICorner2.Parent = Frame4;
    end;

    local v272 = {};
    local v273 = {
        ZIndex = 4
    };

    for i, v in ct(v267, 752, 38, 164, 164) do
        v272[i] = v;
    end;

    for i, v in v273 do
        v272[i] = v;
    end;

    v272.Image = u5.Moon or "Moon";
    v272.ScaleType = v272.ScaleType or Enum.ScaleType.Fit;
    v272.BorderSizePixel = 0;
    v272.Active = false;
    v272.Interactable = false;
    v272.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Moon";

    for i, v in v272 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = CanvasGroup;
    u260.moon = ImageLabel;
    local v274 = tl(v267, 0, -140, 1200, 300);
    local v275 = {
        ImageTransparency = 0.3,
        ZIndex = 5,
        ScaleType = Enum.ScaleType.Stretch
    };
    local v276 = {};

    for i, v in v274 do
        v276[i] = v;
    end;

    for i, v in v275 do
        v276[i] = v;
    end;

    v276.Image = u5.Graveyard or "Graveyard";
    v276.ScaleType = v276.ScaleType or Enum.ScaleType.Fit;
    v276.BorderSizePixel = 0;
    v276.Active = false;
    v276.Interactable = false;
    v276.BackgroundTransparency = 1;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "Graveyard";

    for i, v in v276 or {} do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = CanvasGroup;
    local Graveyard = CanvasGroup.Graveyard;
    local v277 = {
        Rotation = 90,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.62, 0), NumberSequenceKeypoint.new(1, 1) })
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in v277 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Graveyard;
    local v278 = {};
    local v279 = {
        ImageTransparency = 0.5,
        ZIndex = 6
    };

    for i, v in ct(v267, 52, 52, 104, 104) do
        v278[i] = v;
    end;

    for i, v in v279 do
        v278[i] = v;
    end;

    v278.Image = u5.Web or "Web";
    v278.ScaleType = v278.ScaleType or Enum.ScaleType.Fit;
    v278.BorderSizePixel = 0;
    v278.Active = false;
    v278.Interactable = false;
    v278.BackgroundTransparency = 1;
    local ImageLabel3 = Instance.new("ImageLabel");
    ImageLabel3.Name = "WebLeft";

    for i, v in v278 or {} do
        ImageLabel3[i] = v;
    end;

    ImageLabel3.Parent = CanvasGroup;
    local v280 = {};
    local v281 = {
        ImageTransparency = 0.45,
        Rotation = 90,
        ZIndex = 6
    };

    for i, v in ct(v267, 1145, 55, 110, 110) do
        v280[i] = v;
    end;

    for i, v in v281 do
        v280[i] = v;
    end;

    v280.Image = u5.Web or "Web";
    v280.ScaleType = v280.ScaleType or Enum.ScaleType.Fit;
    v280.BorderSizePixel = 0;
    v280.Active = false;
    v280.Interactable = false;
    v280.BackgroundTransparency = 1;
    local ImageLabel4 = Instance.new("ImageLabel");
    ImageLabel4.Name = "WebRight";

    for i, v in v280 or {} do
        ImageLabel4[i] = v;
    end;

    ImageLabel4.Parent = CanvasGroup;
    local v282 = {
        BackgroundTransparency = 0.5,
        Rotation = -6,
        ZIndex = 6,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale((847 - v267.ox) / v267.w, (20 - v267.oy) / v267.h),
        Size = UDim2.fromScale(2 / v267.w, 40 / v267.h),
        BackgroundColor3 = u6.web,
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "Thread";

    for i, v in v282 or {} do
        Frame4[i] = v;
    end;

    Frame4.Parent = CanvasGroup;
    u260.thread = Frame4;
    local v283 = {};
    local v284 = {
        Rotation = 6,
        ZIndex = 7
    };

    for i, v in ct(v267, 851, 58, 40, 40) do
        v283[i] = v;
    end;

    for i, v in v284 do
        v283[i] = v;
    end;

    v283.Image = u5.Spider or "Spider";
    v283.ScaleType = v283.ScaleType or Enum.ScaleType.Fit;
    v283.BorderSizePixel = 0;
    v283.Active = false;
    v283.Interactable = false;
    v283.BackgroundTransparency = 1;
    local ImageLabel5 = Instance.new("ImageLabel");
    ImageLabel5.Name = "Spider";

    for i, v in v283 or {} do
        ImageLabel5[i] = v;
    end;

    ImageLabel5.Parent = CanvasGroup;
    u260.spider = ImageLabel5;
    u260.nightSpace = v267;

    for i, v in u247 do
        local v285 = ct(v267, v[1], v[2], v[3], v[3]);
        local v286 = {
            ZIndex = 7,
            Rotation = v[4]
        };
        local v287 = v;
        local v288 = {};

        for i2, v2 in v285 do
            v288[i2] = v2;
        end;

        for i2, v2 in v286 do
            v288[i2] = v2;
        end;

        v288.Image = u5.Bat or "Bat";
        v288.ScaleType = v288.ScaleType or Enum.ScaleType.Fit;
        v288.BorderSizePixel = 0;
        v288.Active = false;
        v288.Interactable = false;
        v288.BackgroundTransparency = 1;
        local ImageLabel6 = Instance.new("ImageLabel");
        ImageLabel6.Name = "Bat" .. i;

        for i2, v2 in v288 or {} do
            ImageLabel6[i2] = v2;
        end;

        ImageLabel6.Parent = CanvasGroup;
        table.insert(u260.bats, {
            image = ImageLabel6,
            x = v287[1],
            y = v287[2],
            size = v287[3],
            rot = v287[4],
            speed = v287[5],
            phase = v287[6]
        });
    end;

    local v289 = tl(v267, 0, 528, 1200, 272);
    local v290 = {
        ZIndex = 8,
        BackgroundColor3 = u6.fog
    };
    local v291 = {};

    for i, v in v289 do
        v291[i] = v;
    end;

    for i, v in v290 do
        v291[i] = v;
    end;

    v291.BorderSizePixel = 0;
    v291.Active = false;
    v291.Interactable = false;
    local Frame5 = Instance.new("Frame");
    Frame5.Name = "Fog";

    for i, v in v291 or {} do
        Frame5[i] = v;
    end;

    Frame5.Parent = CanvasGroup;
    local v292 = {
        Rotation = 90,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.6, 0.85), NumberSequenceKeypoint.new(1, 0.66) })
    };
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Name = "UIGradient";

    for i, v in v292 or {} do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = Frame5;
    glow(CanvasGroup, "FogLeft", v267, 190, 772, 560, 150, Color3.fromRGB(190, 150, 255), 0.74, 8);
    glow(CanvasGroup, "FogRight", v267, 1000, 770, 620, 160, Color3.fromRGB(190, 150, 255), 0.76, 8);
    embers(CanvasGroup, v267, u245, 9, u260.embers);
    u260.title = slot(Frame3, "Title", u248, {
        x = 36,
        cy = 50,
        w = 548,
        size = 82,
        align = Enum.TextXAlignment.Left,
        font = Font_fromEnum_ret
    }, {
        ZIndex = 12,
        TextColor3 = u6.pumpkin
    }, 0.06);
    u260.title.label.UIStroke.Color = u6.titleStroke;
    put(u260.title, "PUMPKIN MERCHANT");
    local v293 = {};
    local v294 = {
        BackgroundTransparency = 1,
        ZIndex = 12
    };

    for i, v in ct(u248, 600, 52, 62, 62) do
        v293[i] = v;
    end;

    for i, v in v294 do
        v293[i] = v;
    end;

    v293.BorderSizePixel = 0;
    v293.Active = false;
    v293.Interactable = false;
    local Frame6 = Instance.new("Frame");
    Frame6.Name = "Lantern";

    for i, v in v293 or {} do
        Frame6[i] = v;
    end;

    Frame6.Parent = Frame3;
    u260.lanternGlow = glow(Frame6, "Glow", {
        w = 62,
        h = 62,
        ox = 0,
        oy = 0
    }, 31, 36, 170, 170, u6.pumpkin, 0.4, 12);
    local v295 = {
        Rotation = -5,
        ZIndex = 13,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        Image = u5.Pumpkin or "Pumpkin"
    };
    v295.ScaleType = v295.ScaleType or Enum.ScaleType.Fit;
    v295.BorderSizePixel = 0;
    v295.Active = false;
    v295.Interactable = false;
    v295.BackgroundTransparency = 1;
    local ImageLabel6 = Instance.new("ImageLabel");
    ImageLabel6.Name = "Pumpkin";

    for i, v in v295 or {} do
        ImageLabel6[i] = v;
    end;

    ImageLabel6.Parent = Frame6;
    u260.lanternPumpkin = ImageLabel6;
    u260.subtitle = slot(Frame3, "Subtitle", u248, {
        x = 40,
        cy = 100,
        w = 580,
        size = 28,
        align = Enum.TextXAlignment.Left
    }, {
        ZIndex = 12,
        TextColor3 = u6.mist
    });
    u260.timerAt = 0;
    u260:refreshEnds();
    local v296 = cssBox("Frame", Frame3, "Balance", u248, 908, 24, 188, 58, {
        border = 2,
        radius = 12,
        outer = 2,
        ring = u6.edge,
        props = {
            BorderSizePixel = 0,
            ZIndex = 12,
            BackgroundColor3 = u6.white
        }
    });
    gradient(v296, Color3.fromRGB(29, 20, 40), Color3.fromRGB(19, 12, 27));
    u260.pill = v296;
    local icon = u4.COINS.icon;
    local v297 = {
        ZIndex = 13,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = u5[icon] or icon
    };
    v297.ScaleType = v297.ScaleType or Enum.ScaleType.Fit;
    v297.BorderSizePixel = 0;
    v297.Active = false;
    v297.Interactable = false;
    v297.BackgroundTransparency = 1;
    local ImageLabel7 = Instance.new("ImageLabel");
    ImageLabel7.Name = "Coin";

    for i, v in v297 or {} do
        ImageLabel7[i] = v;
    end;

    ImageLabel7.Parent = v296;
    u260.pillCoin = ImageLabel7;
    u260.pillAmount = slot(v296, "Amount", {
        w = 184,
        h = 54,
        ox = 2,
        oy = 2
    }, {
        x = 62,
        cy = 29,
        w = 100,
        size = 37.8,
        align = Enum.TextXAlignment.Left
    }, {
        ZIndex = 13,
        TextColor3 = u6.gold
    });
    u260.balance = 0;
    local v298, v299 = cssBox("ImageButton", Frame3, "CloseButton", u248, 1118, 23, 56, 56, {
        border = 3,
        radius = 14,
        outer = 3,
        ring = u8.close[3],
        props = {
            AutoButtonColor = true,
            BorderSizePixel = 0,
            ZIndex = 12,
            BackgroundColor3 = u6.white
        }
    });
    local v300 = {
        Rotation = 90,
        Color = ColorSequence.new(u8.close[1], u8.close[2])
    };
    local UIGradient3 = Instance.new("UIGradient");
    UIGradient3.Name = "UIGradient";

    for i, v in v300 or {} do
        UIGradient3[i] = v;
    end;

    UIGradient3.Parent = v298;

    for i, v in { u6.black, u6.white } do
        local v301 = i == 1 and 11 or 6;
        bar(v298, "X1_" .. i, v299, 18, 18, 38, 38, v301, v, 13 + i);
        bar(v298, "X2_" .. i, v299, 38, 18, 18, 38, v301, v, 13 + i);
    end;

    u260.closeButton = v298;
    local v302 = ct(u248, 0, 53, 50, 50);
    local v303 = {
        AutoButtonColor = true,
        BorderSizePixel = 0,
        ZIndex = 12,
        Image = "",
        BackgroundColor3 = u6.white
    };
    local v304 = {};

    for i, v in v302 do
        v304[i] = v;
    end;

    for i, v in v303 do
        v304[i] = v;
    end;

    local ImageButton = Instance.new("ImageButton");
    ImageButton.Name = "AddCurrency";

    for i, v in v304 or {} do
        ImageButton[i] = v;
    end;

    ImageButton.Parent = Frame3;
    local v305 = {
        CornerRadius = UDim.new(0.24, 0)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v305 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = ImageButton;
    rings(ImageButton, u8.robux[3], 0.1, 0.06);
    local v306 = {
        Rotation = 90,
        Color = ColorSequence.new(u8.robux[1], u8.robux[2])
    };
    local UIGradient4 = Instance.new("UIGradient");
    UIGradient4.Name = "UIGradient";

    for i, v in v306 or {} do
        UIGradient4[i] = v;
    end;

    UIGradient4.Parent = ImageButton;
    local v307 = {
        w = 50,
        h = 50,
        ox = 0,
        oy = 0
    };

    for i, v in { u6.black, u6.white } do
        local v308 = i == 1 and 11 or 6;
        bar(ImageButton, "H_" .. i, v307, 15, 25, 35, 25, v308, v, 13 + i);
        bar(ImageButton, "V_" .. i, v307, 25, 15, 25, 35, v308, v, 13 + i);
    end;

    ImageButton.Activated:Connect(function() -- Line: 848
        -- upvalues: u260 (copy)
        u260:showPacks(true);
    end);
    u260.plusButton = ImageButton;
    table.insert(u260.tiles, u260:crateTile(0, 28, 132));
    table.insert(u260.tiles, u260:crateTile(1, 271, 132));
    table.insert(u260.tiles, u260:crateTile(2, 514, 132));
    table.insert(u260.tiles, u260:titleTile(0, 28, 522));
    table.insert(u260.tiles, u260:titleTile(1, 392.5, 522));
    u260.hero = u260:heroTile(760, 132);
    local v309 = tl(u248, 3, 610, 1194, 187);
    local v310 = {
        ZIndex = 30,
        BackgroundColor3 = Color3.new(1, 1, 1)
    };
    local v311 = {};

    for i, v in v309 do
        v311[i] = v;
    end;

    for i, v in v310 do
        v311[i] = v;
    end;

    v311.BorderSizePixel = 0;
    v311.Active = false;
    v311.Interactable = false;
    local Frame7 = Instance.new("Frame");
    Frame7.Name = "Haze";

    for i, v in v311 or {} do
        Frame7[i] = v;
    end;

    Frame7.Parent = Frame3;
    local v312 = {
        CornerRadius = UDim.new(0.06417112299465241, 0)
    };
    local UICorner3 = Instance.new("UICorner");
    UICorner3.Name = "UICorner";

    for i, v in v312 or {} do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = Frame7;
    local v313 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3.fromRGB(150, 105, 215), Color3.fromRGB(170, 120, 235)),
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.55, 0.88), NumberSequenceKeypoint.new(1, 0.7) })
    };
    local UIGradient5 = Instance.new("UIGradient");
    UIGradient5.Name = "UIGradient";

    for i, v in v313 or {} do
        UIGradient5[i] = v;
    end;

    UIGradient5.Parent = Frame7;
    embers(Frame3, u248, u246, 31, u260.embers);
    local v314 = {
        BackgroundTransparency = 1,
        ZIndex = 50,
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame8 = Instance.new("Frame");
    Frame8.Name = "Edge";

    for i, v in v314 or {} do
        Frame8[i] = v;
    end;

    Frame8.Parent = Frame3;
    local v315 = {};
    local v316 = {
        Rotation = -6,
        ZIndex = 50
    };

    for i, v in ct(u248, -64, 766, 104, 104) do
        v315[i] = v;
    end;

    for i, v in v316 do
        v315[i] = v;
    end;

    v315.Image = u5.Tombstone or "Tombstone";
    v315.ScaleType = v315.ScaleType or Enum.ScaleType.Fit;
    v315.BorderSizePixel = 0;
    v315.Active = false;
    v315.Interactable = false;
    v315.BackgroundTransparency = 1;
    local ImageLabel8 = Instance.new("ImageLabel");
    ImageLabel8.Name = "Tombstone";

    for i, v in v315 or {} do
        ImageLabel8[i] = v;
    end;

    ImageLabel8.Parent = Frame8;
    u260.cornerGlow = glow(Frame8, "PumpkinGlow", u248, -26, 798, 190, 190, u6.pumpkin, 0.75, 50);
    local v317 = {};
    local v318 = {
        ZIndex = 51
    };

    for i, v in ct(u248, -26, 796, 92, 92) do
        v317[i] = v;
    end;

    for i, v in v318 do
        v317[i] = v;
    end;

    v317.Image = u5.Pumpkin or "Pumpkin";
    v317.ScaleType = v317.ScaleType or Enum.ScaleType.Fit;
    v317.BorderSizePixel = 0;
    v317.Active = false;
    v317.Interactable = false;
    v317.BackgroundTransparency = 1;
    local ImageLabel9 = Instance.new("ImageLabel");
    ImageLabel9.Name = "Pumpkin";

    for i, v in v317 or {} do
        ImageLabel9[i] = v;
    end;

    ImageLabel9.Parent = Frame8;
    local v319 = {};
    local v320 = {
        ZIndex = 50
    };

    for i, v in ct(u248, 1234, 794, 112, 112) do
        v319[i] = v;
    end;

    for i, v in v320 do
        v319[i] = v;
    end;

    v319.Image = u5.Cauldron or "Cauldron";
    v319.ScaleType = v319.ScaleType or Enum.ScaleType.Fit;
    v319.BorderSizePixel = 0;
    v319.Active = false;
    v319.Interactable = false;
    v319.BackgroundTransparency = 1;
    local ImageLabel10 = Instance.new("ImageLabel");
    ImageLabel10.Name = "Cauldron";

    for i, v in v319 or {} do
        ImageLabel10[i] = v;
    end;

    ImageLabel10.Parent = Frame8;
    u260.cauldron = ImageLabel10;
    local v321 = {};
    local v322 = {
        Rotation = 16,
        ZIndex = 50
    };

    for i, v in ct(u248, 1194, -32, 88, 88) do
        v321[i] = v;
    end;

    for i, v in v322 do
        v321[i] = v;
    end;

    v321.Image = u5.WitchHat or "WitchHat";
    v321.ScaleType = v321.ScaleType or Enum.ScaleType.Fit;
    v321.BorderSizePixel = 0;
    v321.Active = false;
    v321.Interactable = false;
    v321.BackgroundTransparency = 1;
    local ImageLabel11 = Instance.new("ImageLabel");
    ImageLabel11.Name = "WitchHat";

    for i, v in v321 or {} do
        ImageLabel11[i] = v;
    end;

    ImageLabel11.Parent = Frame8;
    u260.hat = ImageLabel11;
    local v323 = {};
    local v324 = {
        ImageTransparency = 0.08,
        ZIndex = 50
    };

    for i, v in ct(u248, 1236, 368, 104, 104) do
        v323[i] = v;
    end;

    for i, v in v324 do
        v323[i] = v;
    end;

    v323.Image = u5.Ghost or "Ghost";
    v323.ScaleType = v323.ScaleType or Enum.ScaleType.Fit;
    v323.BorderSizePixel = 0;
    v323.Active = false;
    v323.Interactable = false;
    v323.BackgroundTransparency = 1;
    local ImageLabel12 = Instance.new("ImageLabel");
    ImageLabel12.Name = "Ghost";

    for i, v in v323 or {} do
        ImageLabel12[i] = v;
    end;

    ImageLabel12.Parent = Frame8;
    u260.ghost = ImageLabel12;
    u260:buildPacks();
    u260:buildOdds();
    u260:setCurrency(u4.COINS);
    u260:setBalance(0);

    return u260;
end;

local function tileCard(p325, p326, p327, p328, p329, p330, p331, p332, p333, p334) -- Line: 887
    -- upvalues: cssBox (copy), u6 (copy), gradient (copy)
    local v335, v336 = cssBox("Frame", p325, p326, p327, p328, p329, p330, p331, {
        border = 3,
        radius = 16,
        outer = 3,
        ring = p332,
        props = {
            BorderSizePixel = 0,
            ZIndex = 10,
            BackgroundColor3 = u6.white
        }
    });
    gradient(v335, Color3.fromRGB(25, 15, 36), p333, 0.07, p334);

    return v335, v336;
end;

function u4.crateTile(u337, p338, p339, p340) -- Line: 899
    -- upvalues: tileCard (copy), u248 (copy), u6 (copy), glow (copy), ct (copy), u5 (copy), tl (copy), Font_new_ret (copy), slot (copy), priceButton (copy)
    local v341, v342 = tileCard(u337.stage, "Crate" .. p338 + 1, u248, p339, p340, 228, 374, u6.pumpkin, Color3.fromRGB(66, 36, 30), 0.45);
    local u343 = {
        kind = "Crate",
        frame = v341,
        space = v342,
        halo = glow(v341, "Glow", v342, 114, 135, 270, 320, u6.pumpkin, 0.5, 11),
        aura = glow(v341, "Aura", v342, 114, 140, 210, 180, u6.pumpkin, 0.8, 11)
    };
    local v344 = {};
    local v345 = {
        ZIndex = 12
    };

    for i, v in ct(v342, 114, 134, 224, 224) do
        v344[i] = v;
    end;

    for i, v in v345 do
        v344[i] = v;
    end;

    v344.Image = u5[""] or "";
    v344.ScaleType = v344.ScaleType or Enum.ScaleType.Fit;
    v344.BorderSizePixel = 0;
    v344.Active = false;
    v344.Interactable = false;
    v344.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Crate";

    for i, v in v344 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = v341;
    u343.icon = ImageLabel;
    local v346 = ct(v342, 114, 134, 224, 236);
    local v347 = {
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-0.4, -0.8, -1),
        ZIndex = 12,
        Visible = false,
        Ambient = Color3.fromRGB(190, 180, 205),
        LightColor = Color3.fromRGB(255, 240, 220)
    };
    local v348 = {};

    for i, v in v346 do
        v348[i] = v;
    end;

    for i, v in v347 do
        v348[i] = v;
    end;

    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Name = "Model";

    for i, v in v348 or {} do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = v341;
    u343.viewport = ViewportFrame;
    local v349 = {};
    local v350 = {
        Rotation = -8,
        ZIndex = 14
    };

    for i, v in tl(v342, 182, 6, 38, 38) do
        v349[i] = v;
    end;

    for i, v in v350 do
        v349[i] = v;
    end;

    v349.Image = u5.Pumpkin or "Pumpkin";
    v349.ScaleType = v349.ScaleType or Enum.ScaleType.Fit;
    v349.BorderSizePixel = 0;
    v349.Active = false;
    v349.Interactable = false;
    v349.BackgroundTransparency = 1;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "Mark";

    for i, v in v349 or {} do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = v341;
    local v351 = tl(v342, 10, 10, 40, 40);
    local v352 = {
        BorderSizePixel = 0,
        AutoButtonColor = true,
        Text = "?",
        TextScaled = true,
        ZIndex = 15,
        BackgroundColor3 = u6.night,
        FontFace = Font_new_ret,
        TextColor3 = u6.white
    };
    local v353 = {};

    for i, v in v351 do
        v353[i] = v;
    end;

    for i, v in v352 do
        v353[i] = v;
    end;

    local TextButton = Instance.new("TextButton");
    TextButton.Name = "Odds";

    for i, v in v353 or {} do
        TextButton[i] = v;
    end;

    TextButton.Parent = v341;
    local v354 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v354 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = TextButton;
    local v355 = {
        Thickness = 0.08,
        Color = u6.pumpkin,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Ring";

    for i, v in v355 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextButton;
    local v356 = {
        PaddingTop = UDim.new(0.14, 0),
        PaddingBottom = UDim.new(0.14, 0)
    };
    local UIPadding = Instance.new("UIPadding");
    UIPadding.Name = "Pad";

    for i, v in v356 or {} do
        UIPadding[i] = v;
    end;

    UIPadding.Parent = TextButton;
    TextButton.Activated:Connect(function() -- Line: 929
        -- upvalues: u343 (copy), u337 (copy)
        if u343.item and u337.onOdds then
            u337.onOdds(u343.item.id);
        end;
    end);
    u343.name = slot(v341, "Name", v342, {
        cx = 114,
        by = 291,
        w = 212,
        size = 30.5,
        lines = 3,
        maxH = 76,
        lh = 0.86
    }, {
        ZIndex = 13
    });
    u343.price = priceButton(v341, "Buy", v342, 15, 299, 198, 60, {
        radius = 14,
        border = 3,
        outer = 3,
        size = 39,
        coin = 36,
        gap = 9,
        z = 13
    });
    u343.art = u343.icon;
    u343.dim = { u343.icon, u343.viewport };
    u337:wire(u343);

    return u343;
end;

function u4.titleTile(p357, p358, p359, p360) -- Line: 942
    -- upvalues: tileCard (copy), u248 (copy), u6 (copy), glow (copy), tl (copy), label (copy), slot (copy), u5 (copy), put (copy), LocalPlayer (copy), ct (copy), priceButton (copy)
    local v361, v362 = tileCard(p357.stage, "Title" .. p358 + 1, u248, p359, p360, 349.5, 250, u6.witch, Color3.fromRGB(52, 30, 74), 0.42);
    local v363 = {
        kind = "Title",
        frame = v361,
        space = v362,
        halo = glow(v361, "Glow", v362, 174.75, 96, 320, 170, u6.pumpkin, 0.6, 11)
    };
    local v364 = tl(v362, 11, 8, 100, 34);
    local v365 = {
        BackgroundTransparency = 0.3,
        ZIndex = 14,
        BackgroundColor3 = Color3.fromRGB(14, 6, 22)
    };
    local v366 = {};

    for i, v in v364 do
        v366[i] = v;
    end;

    for i, v in v365 do
        v366[i] = v;
    end;

    v366.BorderSizePixel = 0;
    v366.Active = false;
    v366.Interactable = false;
    local Frame = Instance.new("Frame");
    Frame.Name = "Chip";

    for i, v in v366 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = v361;
    local v367 = {
        CornerRadius = UDim.new(0.2647058823529412, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v367 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v368 = {
        Thickness = 0.058823529411764705,
        Color = u6.witch,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Ring";

    for i, v in v368 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    v363.chipText = label(Frame, "Text", "TITLE", {
        ZIndex = 15,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.86, 0.8235294117647058),
        TextColor3 = u6.mist
    }, 0.1);
    v363.timer = slot(v361, "Timer", v362, {
        cx = 207,
        cy = 25,
        w = 170,
        size = 24
    }, {
        ZIndex = 15,
        TextColor3 = u6.ember
    }, 0.1);
    local v369 = {};
    local v370 = {
        Rotation = 12,
        ZIndex = 14
    };

    for i, v in tl(v362, 303.5, 6, 38, 38) do
        v369[i] = v;
    end;

    for i, v in v370 do
        v369[i] = v;
    end;

    v369.Image = u5.WitchHat or "WitchHat";
    v369.ScaleType = v369.ScaleType or Enum.ScaleType.Fit;
    v369.BorderSizePixel = 0;
    v369.Active = false;
    v369.Interactable = false;
    v369.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Mark";

    for i, v in v369 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = v361;
    v363.tag = slot(v361, "Tag", v362, {
        cx = 174.75,
        cy = 82,
        w = 306,
        size = 50,
        lines = 3,
        minLines = 2,
        maxH = 88,
        lh = 0.8
    }, {
        ZIndex = 13
    }, 0.14);
    v363.who = slot(v361, "Who", v362, {
        cx = 174.75,
        cy = 141,
        w = 300,
        size = 28
    }, {
        ZIndex = 13,
        TextTransparency = 0.25
    }, 0.1);
    put(v363.who, not LocalPlayer and "Player" or LocalPlayer.DisplayName);
    table.insert(p357.whoLabels, v363.who);
    local v371 = ct(v362, 84, 106, 150, 128);
    local v372 = {
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-0.4, -0.8, -1),
        ZIndex = 13,
        Visible = false,
        Ambient = Color3.fromRGB(190, 180, 205),
        LightColor = Color3.fromRGB(255, 240, 220)
    };
    local v373 = {};

    for i, v in v371 do
        v373[i] = v;
    end;

    for i, v in v372 do
        v373[i] = v;
    end;

    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Name = "Emote";

    for i, v in v373 or {} do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = v361;
    v363.emoteView = ViewportFrame;
    local v374 = tl(v362, 126, 46, 34, 34);
    local v375 = {
        BorderSizePixel = 0,
        AutoButtonColor = true,
        ZIndex = 15,
        Visible = false,
        BackgroundColor3 = u6.night
    };
    local v376 = {};

    for i, v in v374 do
        v376[i] = v;
    end;

    for i, v in v375 do
        v376[i] = v;
    end;

    local ImageButton = Instance.new("ImageButton");
    ImageButton.Name = "SoundButton";

    for i, v in v376 or {} do
        ImageButton[i] = v;
    end;

    ImageButton.Parent = v361;
    v363.soundButton = ImageButton;
    local soundButton = v363.soundButton;
    local v377 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v377 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = soundButton;
    local soundButton2 = v363.soundButton;
    local v378 = {
        Thickness = 0.08,
        Color = u6.witch,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Name = "Ring";

    for i, v in v378 or {} do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = soundButton2;
    local soundButton3 = v363.soundButton;
    local v379 = {
        BackgroundTransparency = 1,
        ZIndex = 16,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.62, 0.62),
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "Icon";

    for i, v in v379 or {} do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = soundButton3;
    v363.emoteName = slot(v361, "EmoteName", v362, {
        cx = 248,
        cy = 92,
        w = 180,
        size = 26,
        lines = 2,
        maxH = 56,
        lh = 0.86
    }, {
        ZIndex = 13,
        Visible = false
    }, 0.12);
    v363.emoteRarity = slot(v361, "EmoteRarity", v362, {
        cx = 248,
        cy = 138,
        w = 180,
        size = 20
    }, {
        ZIndex = 13,
        Visible = false,
        TextTransparency = 0.15
    }, 0.1);
    v363.price = priceButton(v361, "Buy", v362, 15, 175, 319.5, 60, {
        radius = 14,
        border = 3,
        outer = 3,
        size = 39,
        coin = 36,
        gap = 9,
        z = 13
    });
    v363.dim = { v363.tag.label, v363.who.label, v363.halo };
    p357:wire(v363);

    return v363;
end;

function u4.heroTile(p380, p381, p382) -- Line: 985
    -- upvalues: cssBox (copy), u248 (copy), u7 (copy), u6 (copy), gradient (copy), ct (copy), u5 (copy), label (copy), sparkle (copy), slot (copy), priceButton (copy)
    local v383, v384 = cssBox("Frame", p380.stage, "Knife", u248, p381, p382, 412, 640, {
        border = 4,
        radius = 18,
        outer = 3,
        ring = u7.LEGENDARY,
        props = {
            BorderSizePixel = 0,
            ZIndex = 10,
            BackgroundColor3 = u6.white
        }
    });
    gradient(v383, Color3.fromRGB(26, 15, 38), Color3.fromRGB(84, 46, 16), 0.05, 0.18).Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 15, 38)), ColorSequenceKeypoint.new(0.62, Color3.fromRGB(44, 24, 28)), ColorSequenceKeypoint.new(1, Color3.fromRGB(84, 46, 16)) });
    local v385 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 11,
        Active = false,
        Interactable = false,
        Size = UDim2.fromScale(1, 1)
    };
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "Clip";
    local v386 = {
        kind = "Knife",
        frame = v383,
        space = v384
    };

    for i, v in v385 or {} do
        CanvasGroup[i] = v;
    end;

    CanvasGroup.Parent = v383;
    local v387 = {
        CornerRadius = UDim.new(0.022151898734177215, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v387 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = CanvasGroup;
    local v388 = ct(v384, 206, 234, 620, 620);
    local v389 = {
        ImageTransparency = 0.5,
        Rotation = 8,
        ZIndex = 11,
        ImageColor3 = Color3.fromRGB(255, 176, 64)
    };
    local v390 = {};

    for i, v in v388 do
        v390[i] = v;
    end;

    for i, v in v389 do
        v390[i] = v;
    end;

    v390.Image = u5.Sunray or "Sunray";
    v390.ScaleType = v390.ScaleType or Enum.ScaleType.Fit;
    v390.BorderSizePixel = 0;
    v390.Active = false;
    v390.Interactable = false;
    v390.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Rays";

    for i, v in v390 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = CanvasGroup;
    v386.rays = ImageLabel;
    local v391 = ct(v384, 206, 232, 380, 380);
    local v392 = {
        ImageTransparency = 0.42,
        ZIndex = 12,
        ImageColor3 = Color3.fromRGB(255, 176, 76)
    };
    local v393 = {};

    for i, v in v391 do
        v393[i] = v;
    end;

    for i, v in v392 do
        v393[i] = v;
    end;

    v393.Image = u5.GlowGold or "GlowGold";
    v393.ScaleType = v393.ScaleType or Enum.ScaleType.Fit;
    v393.BorderSizePixel = 0;
    v393.Active = false;
    v393.Interactable = false;
    v393.BackgroundTransparency = 1;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "Warmth";

    for i, v in v393 or {} do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = CanvasGroup;
    v386.blob = ImageLabel2;
    local v394 = ct(v384, 62, 65, 246, 48);
    local v395 = {
        Rotation = -45,
        ZIndex = 13,
        BackgroundColor3 = u6.black
    };
    local v396 = {};

    for i, v in v394 do
        v396[i] = v;
    end;

    for i, v in v395 do
        v396[i] = v;
    end;

    v396.BorderSizePixel = 0;
    v396.Active = false;
    v396.Interactable = false;
    local Frame = Instance.new("Frame");
    Frame.Name = "Ribbon";

    for i, v in v396 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = CanvasGroup;
    local v397 = {
        ZIndex = 14,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.975609756097561, 0.875),
        BackgroundColor3 = u6.white,
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Face";

    for i, v in v397 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    gradient(Frame2, Color3.fromRGB(255, 98, 119), Color3.fromRGB(212, 26, 58));
    local v398 = {
        ZIndex = 15,
        Size = UDim2.fromScale(1, 0.07142857142857142),
        BackgroundColor3 = Color3.fromRGB(255, 160, 172),
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "Top";

    for i, v in v398 or {} do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame2;
    local v399 = {
        ZIndex = 15,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.fromScale(1, 0.07142857142857142),
        BackgroundColor3 = Color3.fromRGB(142, 16, 40),
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "Bottom";

    for i, v in v399 or {} do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame2;
    v386.ribbonText = label(Frame2, "Text", "", {
        ZIndex = 16,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.8, 0.6666666666666666)
    }, 0.1);
    v386.ribbon = Frame;
    local v400 = ct(v384, 206, 244, 356, 356);
    local v401 = {
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-0.4, -0.8, -1),
        Rotation = -4,
        ZIndex = 15,
        Ambient = Color3.fromRGB(200, 200, 210),
        LightColor = Color3.fromRGB(255, 250, 235)
    };
    local v402 = {};

    for i, v in v400 do
        v402[i] = v;
    end;

    for i, v in v401 do
        v402[i] = v;
    end;

    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Name = "Knife";

    for i, v in v402 or {} do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = v383;
    v386.viewport = ViewportFrame;
    local v403 = {};
    local v404 = {
        Rotation = -4,
        ZIndex = 15,
        Visible = false
    };

    for i, v in ct(v384, 206, 244, 330, 330) do
        v403[i] = v;
    end;

    for i, v in v404 do
        v403[i] = v;
    end;

    v403.Image = u5.Dagger or "Dagger";
    v403.ScaleType = v403.ScaleType or Enum.ScaleType.Fit;
    v403.BorderSizePixel = 0;
    v403.Active = false;
    v403.Interactable = false;
    v403.BackgroundTransparency = 1;
    local ImageLabel3 = Instance.new("ImageLabel");
    ImageLabel3.Name = "Flat";

    for i, v in v403 or {} do
        ImageLabel3[i] = v;
    end;

    ImageLabel3.Parent = v383;
    v386.flat = ImageLabel3;

    for i, v in { { 90, 134, 40, "FFF3C0" }, { 368, 210, 28, "FFE08A" }, { 360, 396, 30, "FFFFFF" }, { 76, 390, 22, "FFE08A" } } do
        local sparkles = p380.sparkles;
        local v405 = sparkle(v383, "Sparkle" .. i, v384, v[1], v[2], v[3], Color3.fromHex(v[4]), 16);
        table.insert(sparkles, v405);
    end;

    v386.rarity = slot(v383, "Rarity", v384, {
        cx = 206,
        cy = 46,
        w = 330,
        size = 28
    }, {
        ZIndex = 17,
        TextColor3 = u7.LEGENDARY
    }, 0.1);
    v386.ends = slot(v383, "EndsTimer", v384, {
        cx = 206,
        cy = 78,
        w = 300,
        size = 22
    }, {
        ZIndex = 17,
        TextColor3 = Color3.fromRGB(255, 58, 58)
    }, 0.1);
    v386.name = slot(v383, "Name", v384, {
        cx = 206,
        by = 487.8,
        w = 372,
        size = 58.5,
        lines = 2,
        maxH = 104,
        lh = 0.86
    }, {
        ZIndex = 17
    }, 0.08);
    v386.subtitle = slot(v383, "Subtitle", v384, {
        cx = 206,
        cy = 498,
        w = 372,
        size = 28
    }, {
        ZIndex = 17,
        TextColor3 = u6.mist
    }, 0.1);
    v386.price = priceButton(v383, "Buy", v384, 24, 526, 364, 88, {
        radius = 20,
        border = 3,
        outer = 3,
        size = 56,
        coin = 52,
        gap = 14,
        z = 17
    });
    v386.dim = { v386.viewport, v386.flat };
    p380:wire(v386);

    return v386;
end;

function u4.wire(u406, u407) -- Line: 1034
    u407.price.button.Activated:Connect(function() -- Line: 1035
        -- upvalues: u407 (copy), u406 (copy)
        local item = u407.item;

        if item then
            u406:press(item.id);
        end;
    end);
end;

function u4.press(p408, p409) -- Line: 1045
    local v410 = p408.byId[p409];

    if v410 and (v410.state == "buy" and p408.onBuy) then
        p408.onBuy(p409);

        return true;
    end;

    if not (v410 and (v410.state == "locked" and p408.onLocked)) then
        return false;
    end;

    p408.onLocked(p409);

    return true;
end;

function u4.setCurrency(p411, p412) -- Line: 1061
    -- upvalues: u4 (copy), u6 (copy)
    local v413 = p412 or u4.COINS;
    p411.currency = v413;
    local v414 = v413.icon or u4.COINS.icon;
    p411.pillCoin.Image = v414;
    p411.pillAmount.label.TextColor3 = v413.color or u6.gold;
    p411.pill:SetAttribute("Currency", v413.name);

    for _, v in p411.tiles do
        v.price.coin.Image = v414;
    end;

    p411.hero.price.coin.Image = v414;

    for _, v in p411.packs or {} do
        v.icon.Image = v414;

        for _, v2 in v.extras do
            v2.Image = v414;
        end;
    end;

    p411:setBalance(p411.balance);
end;

function u4.setBalance(p415, p416) -- Line: 1082
    -- upvalues: commas (copy), textWidth (copy), Font_new_ret (copy), u248 (copy), put (copy)
    p415.balance = tonumber(p416) or 0;
    local v417 = commas(p415.balance);
    local v418 = textWidth(v417, Font_new_ret, 37.8) * 1.04 + 86;
    local math_clamp_ret = math.clamp(v418, 130, 420);
    local v419 = {
        h = 54,
        ox = 2,
        oy = 2,
        w = math_clamp_ret - 4
    };
    local v420 = u248;
    p415.pill.Position = UDim2.fromScale((1096 - math_clamp_ret + 2 - v420.ox) / v420.w, (26 - v420.oy) / v420.h);
    p415.pill.Size = UDim2.fromScale((math_clamp_ret - 4) / u248.w, 54 / u248.h);
    p415.pillCoin.Position = UDim2.fromScale((32 - v419.ox) / v419.w, (29 - v419.oy) / v419.h);
    p415.pillCoin.Size = UDim2.fromScale(40 / v419.w, 40 / v419.h);
    p415.pillAmount.space = v419;
    p415.pillAmount.w = math_clamp_ret - 80;
    put(p415.pillAmount, v417);

    if p415.plusButton then
        local v421 = u248;
        p415.plusButton.Position = UDim2.fromScale((1096 - math_clamp_ret - 8 - 25 - v421.ox) / v421.w, (53 - v421.oy) / v421.h);
    end;
end;

local function timeLeft(p422) -- Line: 1100
    local v423 = p422 // 86400;
    local v424 = p422 % 86400 // 3600;
    local v425 = p422 % 3600 // 60;

    if v423 > 0 then
        return string.format("%dd %dh", v423, v424);
    end;

    if v424 > 0 then
        return string.format("%dh %dm", v424, v425);
    end;

    return string.format("%dm %ds", v425, p422 % 60);
end;

function u4.setEndsAt(p426, p427) -- Line: 1105
    if type(p427) ~= "number" or p427 <= 0 then
        p427 = nil;
    end;

    p426.endsAt = p427;
    p426:refreshEnds();
end;

function u4.refreshEnds(p428) -- Line: 1112
    -- upvalues: u6 (copy), timeLeft (copy), put (copy)
    local mist = u6.mist;
    local v429;

    if p428.endsAt then
        local v430 = p428.endsAt - workspace:GetServerTimeNow();
        local math_floor_ret = math.floor(v430);
        v429 = math_floor_ret <= 0 and "ENDED" or "Gone in " .. timeLeft(math_floor_ret);
        mist = u6.ember;
    else
        v429 = "Spooky loot, gone when the night ends!";
    end;

    if v429 == p428.endsText then
        if p428.subtitle.label.TextColor3 ~= mist then
            p428.subtitle.label.TextColor3 = mist;
        end;
    else
        p428.endsText = v429;
        p428.subtitle.label.TextColor3 = mist;
        put(p428.subtitle, v429);
    end;

    local hero = p428.hero;

    if hero and hero.ends then
        local v431 = hero.item and hero.item.endsAt;
        local v432;

        if type(v431) == "number" then
            local v433 = v431 - workspace:GetServerTimeNow();
            local math_floor_ret = math.floor(v433);
            local v434 = math_floor_ret // 86400;
            local v435 = math_floor_ret % 86400 // 3600;
            local v436 = math_floor_ret % 3600 // 60;
            local v437 = math_floor_ret % 60;

            if math_floor_ret <= 0 then
                v432 = "ENDED";
            elseif v434 > 0 then
                v432 = ("Ends in %dd %dh %dm %ds"):format(v434, v435, v436, v437);
            elseif v435 > 0 then
                v432 = ("Ends in %dh %dm %ds"):format(v435, v436, v437);
            else
                v432 = ("Ends in %dm %ds"):format(v436, v437);
            end;
        else
            v432 = "";
        end;

        if v432 ~= hero.endsText then
            local v438 = hero.endsText == "ENDED";
            hero.endsText = v432;
            hero.ends.label.Visible = v432 ~= "";
            put(hero.ends, v432);

            if v432 == "ENDED" ~= v438 then
                p428:paint(hero);
            end;
        end;
    end;

    for _, v in p428.tiles do
        if v.timer then
            local v439 = v.item and v.item.rotatesAt;
            local v440;

            if type(v439) == "number" then
                local v441 = v439 - workspace:GetServerTimeNow();
                local math_floor_ret = math.floor(v441);
                v440 = math_floor_ret <= 0 and "NEW SOON" or "NEW IN " .. timeLeft(math_floor_ret);
            else
                v440 = "";
            end;

            if v440 ~= v.timerText then
                v.timerText = v440;
                put(v.timer, v440);
            end;
        end;
    end;
end;

local function nameOf(p442) -- Line: 1168
    -- upvalues: CrateCatalog (copy)
    if p442.name then
        return string.upper(p442.name);
    end;

    local v443 = p442.crate and CrateCatalog.get(p442.crate);

    return not v443 and "" or string.upper(v443.Name);
end;

function u4.dropPose(p444, p445) -- Line: 1177
    if p445.pose then
        pcall(p445.pose.destroy, p445.pose);
    end;

    p445.pose = nil;
    p445.poseId = nil;

    if p445.sound then
        p445.sound:set(nil);
    end;
end;

function u4.setItems(p446, p447) -- Line: 1187
    -- upvalues: drawModel (copy), CrateCatalog (copy), u6 (copy), put (copy), nameOf (copy), u7 (copy), poseModule (copy), u3 (ref), u2 (ref), LocalPlayer (copy), commas (copy), SkinCatalog (copy), drawKnife (copy)
    p446.items = {};
    local v448 = {};
    local v449 = nil;
    local v450 = {};

    for _, v in ipairs(p447 or {}) do
        p446.items[v.id] = v;

        if v.kind == "Crate" and #v450 < 3 then
            table.insert(v450, v);
        elseif (v.kind == "Title" or v.kind == "Emote") and #v448 < 2 then
            table.insert(v448, v);
        elseif v.kind == "Knife" and not v449 then
            v449 = v;
        end;
    end;

    p446.byId = {};

    for i, v in p446.tiles do
        local v451;

        if v.kind == "Crate" then
            v451 = v450[i];
        else
            v451 = v448[i - 3];
        end;

        v.item = v451;
        v.frame.Visible = v451 ~= nil;

        if v.kind == "Crate" then
            local v452;

            if v451 then
                v452 = v451.model;
            else
                v452 = v451;
            end;

            v.drawn = drawModel(v.viewport, v452);
            v.viewport.Visible = v.drawn ~= nil;
            v.icon.Visible = v.drawn == nil;
        end;

        if v451 then
            p446.byId[v451.id] = v;

            if v.kind == "Crate" then
                local v453 = v451.crate and CrateCatalog.get(v451.crate);
                v.icon.Image = v451.icon or (v453 and (v453.Icon or "") or "");
                v.aura.ImageColor3 = v451.color or (v453 and v453.Accent or u6.pumpkin);
                put(v.name, nameOf(v451));
            else
                local v454 = v451.kind == "Emote";
                local string_upper_ret = string.upper(v451.rarity or "COMMON");
                local v455;

                if v454 then
                    v455 = u7[string_upper_ret] or u6.pumpkin;
                else
                    v455 = v451.color or u6.pumpkin;
                end;

                v.color = v455;
                v.halo.ImageColor3 = v455;
                v.chipText.Text = v454 and "EMOTE" or "TITLE";
                v.tag.label.Visible = not v454;
                v.who.label.Visible = not v454;
                v.emoteView.Visible = v454;
                v.emoteName.label.Visible = v454;
                v.emoteRarity.label.Visible = v454;

                if v454 then
                    v.emoteName.label.TextColor3 = v455;
                    put(v.emoteName, string.upper(v451.name or ""));
                    v.emoteRarity.label.TextColor3 = v455;
                    put(v.emoteRarity, string_upper_ret);

                    if v.poseId ~= v451.emote then
                        p446:dropPose(v);
                        local v456 = poseModule();
                        local v457, v458;

                        if v456 and v451.emote then
                            v457, v458 = pcall(v456.new, v.emoteView, v451.emote);
                        else
                            v457 = false;
                            v458 = nil;
                        end;

                        if not v457 then
                            v458 = nil;
                        end;

                        v.pose = v458;
                        v.poseId = v451.emote;

                        if v.pose then
                            local pose = v.pose;
                            task.spawn(function() -- Line: 1247
                                -- upvalues: v (copy), pose (copy), u3 (ref)
                                local v459 = false;

                                while v.pose == pose do
                                    if not pose.playing then
                                        local success, result = pcall(pose.play, pose);

                                        if success and (result and not v459) then
                                            v459 = true;
                                            task.wait(0.15);

                                            if v.pose == pose and (pose.clone and pose.clone.Parent) then
                                                pcall(u3.fit, pose.camera, pose.clone, v.emoteView, 1.6);
                                            end;
                                        end;
                                    end;

                                    task.wait(0.4);
                                end;
                            end);
                        end;

                        if u2 then
                            v.sound = v.sound or u2.new(v.soundButton);
                            v.sound:set(v451.emote);
                        end;
                    end;
                else
                    p446:dropPose(v);
                    v.tag.label.TextColor3 = v455;
                    put(v.tag, string.upper(v451.title or (v451.name or "")));
                    put(v.who, not LocalPlayer and "Player" or LocalPlayer.DisplayName);
                end;

                v.timerText = nil;
            end;

            v.price.amountText = commas(v451.price or 0);
        elseif v.kind == "Title" then
            p446:dropPose(v);
        end;
    end;

    local hero = p446.hero;
    hero.item = v449;
    hero.frame.Visible = v449 ~= nil;

    if v449 then
        p446.byId[v449.id] = hero;
        local v460 = SkinCatalog.get(v449.knife);
        local string_upper_ret = string.upper(v449.rarity or (v460 and (v460.Rarity or "LEGENDARY") or "LEGENDARY"));
        local v461 = u7[string_upper_ret] or u7.LEGENDARY;
        hero.color = v461;
        hero.frame.Ring.Color = v461;
        put(hero.rarity, string_upper_ret);
        hero.rarity.label.TextColor3 = v461;
        hero.ribbon.Visible = v449.badge ~= nil;
        hero.ribbonText.Text = string.upper(v449.badge or "");
        local v462 = drawKnife(hero.viewport, v449.knife) or drawKnife(hero.viewport, "Moonfang");
        p446.knife = v462;
        hero.viewport.Visible = v462 ~= nil;
        hero.flat.Visible = v462 == nil;
        put(hero.name, string.upper(v449.name or v460 and v460.Name or (v449.knife or "")));
        put(hero.subtitle, string.upper(v449.subtitle or "ONLY DURING THE EVENT"));
        hero.price.amountText = commas(v449.price or 0);
    end;

    for _, v in p446.tiles do
        p446:paint(v);
    end;

    p446:paint(hero);
    p446:refreshEnds();
end;

function u4.paint(p463, p464) -- Line: 1314
    -- upvalues: setLook (copy), layoutRow (copy), u6 (copy)
    local item = p464.item;

    if not item then
        return;
    end;

    local price = p464.price;
    local v465 = p463.owned[item.id] and "owned" or (type(item.endsAt) == "number" and workspace:GetServerTimeNow() >= item.endsAt and "ended" or (p463.locked[item.id] and "locked" or (p463.busy[item.id] and "busy" or "buy")));
    p464.state = v465;

    if v465 == "buy" and p463.free[item.id] then
        setLook(price, "robux");
        layoutRow(price, {
            { "word", "FREE: " .. p463.free[item.id] .. "x" }
        });
    elseif v465 == "buy" then
        setLook(price, "pumpkin");

        if p464.kind == "Knife" then
            layoutRow(price, {
                { "word", "BUY" },
                { "coin" },
                { "amount", price.amountText }
            });
        else
            layoutRow(price, {
                { "coin" },
                { "amount", price.amountText }
            });
        end;
    elseif v465 == "owned" then
        setLook(price, "grey");
        layoutRow(price, { { "check" }, { "word", "OWNED" } });
    elseif v465 == "locked" then
        setLook(price, "grey");
        layoutRow(price, { { "word", "LOCKED" } });
    elseif v465 == "ended" then
        setLook(price, "grey");
        layoutRow(price, { { "word", "ENDED" } });
    else
        setLook(price, "grey");
        layoutRow(price, { { "word", "..." } });
    end;

    price.button.Interactable = v465 == "buy" and true or v465 == "locked";
    price.button.AutoButtonColor = v465 == "buy";
    local v466 = (v465 == "owned" or v465 == "locked") and true or v465 == "ended";

    if p464.kind ~= "Crate" then
        if p464.kind == "Title" then
            local emoteView = p464.emoteView;
            local v467;

            if v466 then
                v467 = Color3.fromRGB(150, 140, 160);
            else
                v467 = u6.white;
            end;

            emoteView.ImageColor3 = v467;
            local label2 = p464.emoteName.label;
            local v468;

            if v466 then
                v468 = (p464.color or u6.pumpkin):Lerp(Color3.fromRGB(120, 112, 132), 0.55);
            else
                v468 = p464.color or u6.pumpkin;
            end;

            label2.TextColor3 = v468;
            local label3 = p464.tag.label;
            local v469;

            if v466 then
                v469 = (p464.color or u6.pumpkin):Lerp(Color3.fromRGB(120, 112, 132), 0.55);
            else
                v469 = p464.color or u6.pumpkin;
            end;

            label3.TextColor3 = v469;
            p464.halo.ImageTransparency = v466 and 0.9 or 0.6;
            local v470;

            if v466 then
                v470 = u6.witch;
            else
                v470 = p464.color or u6.pumpkin;
            end;

            p464.halo.ImageColor3 = v470;
            p464.tag.label.UIStroke.Transparency = v466 and 0.15 or 0;
        end;

        return;
    end;

    local icon = p464.icon;
    local v471;

    if v466 then
        v471 = Color3.fromRGB(150, 140, 160);
    else
        v471 = u6.white;
    end;

    icon.ImageColor3 = v471;
    local viewport = p464.viewport;
    local v472;

    if v466 then
        v472 = Color3.fromRGB(150, 140, 160);
    else
        v472 = u6.white;
    end;

    viewport.ImageColor3 = v472;
    p464.halo.ImageTransparency = v466 and 0.85 or 0.5;
end;

function u4.setOwned(p473, p474, p475) -- Line: 1368
    p473.owned[p474] = p475 and true or nil;
    local v476 = p473.byId[p474];

    if v476 then
        p473:paint(v476);
    end;
end;

function u4.setBusy(p477, p478, p479) -- Line: 1376
    p477.busy[p478] = p479 and true or nil;
    local v480 = p477.byId[p478];

    if v480 then
        p477:paint(v480);
    end;
end;

function u4.setLocked(p481, p482, p483) -- Line: 1384
    p481.locked[p482] = p483 and true or nil;
    local v484 = p481.byId[p482];

    if v484 then
        p481:paint(v484);
    end;
end;

function u4.animate(p485, p486) -- Line: 1395
    -- upvalues: u248 (copy)
    local os_clock_ret = os.clock();

    if os_clock_ret - p485.timerAt >= 1 then
        p485.timerAt = os_clock_ret;
        p485:refreshEnds();
    end;

    local nightSpace = p485.nightSpace;

    for _, v in p485.bats do
        local v487 = os_clock_ret * v.speed + v.phase;
        local math_sin_ret = math.sin(v487 * 4);
        local v488 = math.abs(math_sin_ret) * 0.38 + 0.62;
        local image = v.image;
        local v489 = v.x + math.sin(v487 * 0.5) * 14;
        local v490 = v.y + math.sin(v487) * 7;
        image.Position = UDim2.fromScale((v489 - nightSpace.ox) / nightSpace.w, (v490 - nightSpace.oy) / nightSpace.h);
        v.image.Size = UDim2.fromScale(v.size / nightSpace.w, v.size * v488 / nightSpace.h);
        v.image.Rotation = v.rot + math.sin(v487 * 0.9) * 10;
    end;

    local v491 = math.sin(os_clock_ret * 0.9) * 8 + -6;
    local v492 = math.sin(os_clock_ret * 0.6) * 8 + 40;
    local math_rad_ret = math.rad(v491);
    local math_sin_ret = math.sin(math_rad_ret);
    local math_rad_ret2 = math.rad(v491);
    local math_cos_ret = math.cos(math_rad_ret2);
    p485.thread.Rotation = v491;
    p485.thread.Size = UDim2.fromScale(2 / nightSpace.w, v492 / nightSpace.h);
    p485.thread.Position = UDim2.fromScale((847 - v492 / 2 * math_sin_ret - nightSpace.ox) / nightSpace.w, (v492 / 2 * math_cos_ret - nightSpace.oy) / nightSpace.h);
    p485.spider.Position = UDim2.fromScale((847 - (v492 + 18) * math_sin_ret - nightSpace.ox) / nightSpace.w, ((v492 + 18) * math_cos_ret - nightSpace.oy) / nightSpace.h);
    p485.spider.Rotation = v491;
    local v493 = math.sin(os_clock_ret * 9.1) * 0.5 * math.sin(os_clock_ret * 3.7 + 1.3) + 0.5;
    p485.lanternGlow.ImageTransparency = 0.5 - v493 * 0.2;
    p485.lanternPumpkin.Rotation = math.sin(os_clock_ret * 1.4) * 6 + -5;
    p485.cornerGlow.ImageTransparency = 0.82 - (math.sin(os_clock_ret * 7.3 + 2) * 0.5 * math.sin(os_clock_ret * 2.9) + 0.5) * 0.14;
    p485.moon.Rotation = math.sin(os_clock_ret * 0.2) * 2;
    p485.hat.Rotation = math.sin(os_clock_ret * 1.1) * 4 + 16;
    p485.cauldron.Rotation = math.sin(os_clock_ret * 5.3) * 1.5;
    local ghost = p485.ghost;
    local v494 = u248;
    local v495 = math.sin(os_clock_ret * 0.7) * 8 + 1236;
    local v496 = math.sin(os_clock_ret * 1.3) * 10 + 368;
    ghost.Position = UDim2.fromScale((v495 - v494.ox) / v494.w, (v496 - v494.oy) / v494.h);
    p485.ghost.ImageTransparency = (math.sin(os_clock_ret * 0.5) * 0.5 + 0.5) * 0.3 + 0.08;

    for _, v in p485.embers do
        local v497 = (os_clock_ret / v.period + v.phase) % 1;
        local frame = v.frame;
        local space = v.space;
        local v498 = v.x + math.sin(os_clock_ret * 0.8 + v.phase * 6) * v.sway;
        frame.Position = UDim2.fromScale((v498 - space.ox) / space.w, (810 - v497 * 520 - space.oy) / space.h);
        local v499 = v.alpha * math.min(1, v497 / 0.12) * math.min(1, (1 - v497) / 0.3);
        v.frame.BackgroundTransparency = 1 - v499;
        v.halo.ImageTransparency = 1 - 0.25 * v499;
    end;

    local hero = p485.hero;
    hero.rays.Rotation = 8 + os_clock_ret * 5;
    hero.blob.ImageTransparency = math.sin(os_clock_ret * 1.6) * 0.06 + 0.42;
    local v500 = math.sin(os_clock_ret * 1.3) * 5;
    local space = hero.space;
    hero.viewport.Position = UDim2.fromScale((206 - space.ox) / space.w, (v500 + 244 - space.oy) / space.h);
    hero.viewport.Rotation = math.sin(os_clock_ret * 0.8) * 2.5 + -4;
    hero.flat.Position = UDim2.fromScale((206 - space.ox) / space.w, (v500 + 244 - space.oy) / space.h);
    hero.flat.Rotation = hero.viewport.Rotation;
    local knife = p485.knife;

    if knife then
        knife.part.CFrame = CFrame.Angles(0, math.sin(os_clock_ret * 0.9) * 0.3, 0) * knife.base;
    end;

    for i, v in p485.tiles do
        local drawn = v.drawn;

        if drawn and drawn.model.Parent then
            drawn.model:PivotTo(CFrame.Angles(0, os_clock_ret * 0.6 + i * 2.1, 0));
        end;
    end;

    for i, v in p485.sparkles do
        v.scale.Scale = (math.sin(os_clock_ret * 2.1 + i * 1.7) * 0.5 + 0.5) * 0.45 + 0.55;
    end;

    local string_rep_ret = string.rep(".", math.floor(os_clock_ret * 3) % 3 + 1);

    for _, v in p485.tiles do
        if v.state == "busy" then
            v.price.word.Text = string_rep_ret;
        end;
    end;

    if p485.hero.state == "busy" then
        p485.hero.price.word.Text = string_rep_ret;
    end;
end;

function u4.opened(u501) -- Line: 1474
    -- upvalues: TweenService (copy), RunService (copy)
    local frame = u501.frame;

    if not frame then
        return;
    end;

    frame.Visible = true;
    u501.timerAt = os.clock();
    u501:refreshEnds();
    u501.pop.Scale = 0.92;
    TweenService:Create(u501.pop, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();

    if not u501.animation then
        u501.animation = RunService.RenderStepped:Connect(function(p502) -- Line: 1486
            -- upvalues: u501 (copy)
            u501:animate(p502);
        end);
    end;
end;

function u4.closed(p503) -- Line: 1492
    p503:showPacks(false);
    p503:showOdds(nil);

    if p503.animation then
        p503.animation:Disconnect();
        p503.animation = nil;
    end;
end;

local u504 = { 92, 118, 150 };
local u505 = { {}, { { -58, 30, 46, -18 }, { 60, 34, 42, 16 } }, { { -72, 26, 54, -20 }, { 74, 30, 50, 18 }, { -40, -50, 40, -30 }, { 46, -46, 38, 28 } } };

function u4.buildPacks(u506) -- Line: 1507
    -- upvalues: u6 (copy), glow (copy), u248 (copy), cssBox (copy), gradient (copy), slot (copy), Font_fromEnum_ret (copy), put (copy), u8 (copy), bar (copy), tileCard (copy), u504 (copy), u505 (copy), ct (copy), u5 (copy), rings (copy), label (copy), priceButton (copy)
    local stage = u506.stage;
    local v507 = {
        BackgroundTransparency = 1,
        ZIndex = 60,
        Visible = false,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "CandyShop";

    for i, v in v507 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = stage;
    u506.packLayer = Frame;
    local v508 = {
        BackgroundTransparency = 0.4,
        AutoButtonColor = false,
        Image = "",
        ZIndex = 1,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = u6.black
    };
    local ImageButton = Instance.new("ImageButton");
    ImageButton.Name = "Shade";

    for i, v in v508 or {} do
        ImageButton[i] = v;
    end;

    ImageButton.Parent = Frame;
    local v509 = {
        CornerRadius = UDim.new(0.01875, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v509 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = ImageButton;
    ImageButton.Activated:Connect(function() -- Line: 1520
        -- upvalues: u506 (copy)
        u506:showPacks(false);
    end);
    glow(Frame, "Glow", u248, 600, 410, 1000, 680, u6.pumpkin, 0.82, 2);
    gradient(cssBox("Frame", Frame, "Card", u248, 186, 132, 828, 548, {
        border = 3,
        radius = 18,
        outer = 4,
        ring = u6.pumpkin,
        props = {
            BorderSizePixel = 0,
            ZIndex = 3,
            BackgroundColor3 = u6.white
        }
    }), u6.night, u6.deep);
    local v510 = slot(Frame, "Title", u248, {
        cx = 600,
        cy = 190,
        w = 560,
        size = 70,
        font = Font_fromEnum_ret
    }, {
        ZIndex = 5,
        TextColor3 = u6.pumpkin
    }, 0.06);
    v510.label.UIStroke.Color = u6.titleStroke;
    put(v510, "CANDY CORN");
    put(slot(Frame, "Subtitle", u248, {
        cx = 600,
        cy = 240,
        w = 600,
        size = 28
    }, {
        ZIndex = 5,
        TextColor3 = u6.mist
    }), "Stock up before the night ends!");
    local v511, v512 = cssBox("ImageButton", Frame, "Close", u248, 948, 150, 48, 48, {
        border = 3,
        radius = 12,
        outer = 3,
        ring = u8.close[3],
        props = {
            AutoButtonColor = true,
            BorderSizePixel = 0,
            ZIndex = 6,
            BackgroundColor3 = u6.white
        }
    });
    local v513 = {
        Rotation = 90,
        Color = ColorSequence.new(u8.close[1], u8.close[2])
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in v513 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = v511;

    for i, v in { u6.black, u6.white } do
        local v514 = i == 1 and 9 or 5;
        bar(v511, "X1_" .. i, v512, 15, 15, 33, 33, v514, v, 6 + i);
        bar(v511, "X2_" .. i, v512, 33, 15, 15, 33, v514, v, 6 + i);
    end;

    v511.Activated:Connect(function() -- Line: 1550
        -- upvalues: u506 (copy)
        u506:showPacks(false);
    end);
    u506.packs = {};

    for i = 1, 3 do
        local v515, v516 = tileCard(Frame, "Pack" .. i, u248, (i - 1) * 262 + 214, 272, 248, 380, u6.pumpkin, Color3.fromRGB(66, 36, 30), 0.45);
        v515.ZIndex = 4;
        local u517 = {
            frame = v515,
            space = v516,
            extras = {},
            halo = glow(v515, "Glow", v516, 124, 104, 240, 220, u6.pumpkin, 0.55, 11)
        };
        local v518 = u504[i];

        for i2, v in u505[i] do
            local extras = u517.extras;
            local v519 = ct(v516, 124 + v[1], 104 + v[2], v[3], v[3]);
            local v520 = {
                ZIndex = 12,
                Rotation = v[4]
            };
            local v521 = {};

            for i3, v2 in v519 do
                v521[i3] = v2;
            end;

            for i3, v2 in v520 do
                v521[i3] = v2;
            end;

            v521.Image = u5[""] or "";
            v521.ScaleType = v521.ScaleType or Enum.ScaleType.Fit;
            v521.BorderSizePixel = 0;
            v521.Active = false;
            v521.Interactable = false;
            v521.BackgroundTransparency = 1;
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Name = "Extra" .. i2;

            for i3, v2 in v521 or {} do
                ImageLabel[i3] = v2;
            end;

            ImageLabel.Parent = v515;
            table.insert(extras, ImageLabel);
        end;

        local v522 = {};
        local v523 = {
            ZIndex = 13
        };

        for i2, v in ct(v516, 124, 104, v518, v518) do
            v522[i2] = v;
        end;

        for i2, v in v523 do
            v522[i2] = v;
        end;

        v522.Image = u5[""] or "";
        v522.ScaleType = v522.ScaleType or Enum.ScaleType.Fit;
        v522.BorderSizePixel = 0;
        v522.Active = false;
        v522.Interactable = false;
        v522.BackgroundTransparency = 1;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Candy";

        for i2, v in v522 or {} do
            ImageLabel[i2] = v;
        end;

        ImageLabel.Parent = v515;
        u517.icon = ImageLabel;
        u517.amount = slot(v515, "Amount", v516, {
            cx = 124,
            cy = 206,
            w = 224,
            size = 52
        }, {
            ZIndex = 13,
            TextColor3 = u6.gold
        }, 0.1);
        u517.name = slot(v515, "Name", v516, {
            cx = 124,
            cy = 244,
            w = 224,
            size = 24
        }, {
            ZIndex = 13,
            TextColor3 = u6.mist
        }, 0.1);
        local v524 = ct(v516, 124, 0, 176, 40);
        local v525 = {
            ZIndex = 15,
            Visible = false,
            BackgroundColor3 = u6.white
        };
        local v526 = {};

        for i2, v in v524 do
            v526[i2] = v;
        end;

        for i2, v in v525 do
            v526[i2] = v;
        end;

        v526.BorderSizePixel = 0;
        v526.Active = false;
        v526.Interactable = false;
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "BestDeal";

        for i2, v in v526 or {} do
            Frame2[i2] = v;
        end;

        Frame2.Parent = v515;
        local v527 = {
            CornerRadius = UDim.new(0.35, 0)
        };
        local UICorner2 = Instance.new("UICorner");
        UICorner2.Name = "UICorner";

        for i2, v in v527 or {} do
            UICorner2[i2] = v;
        end;

        UICorner2.Parent = Frame2;
        rings(Frame2, Color3.fromRGB(255, 236, 150), 0.1, 0.05);
        gradient(Frame2, Color3.fromRGB(255, 214, 92), Color3.fromRGB(226, 140, 18));
        label(Frame2, "Text", "BEST DEAL", {
            ZIndex = 16,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.86, 0.72)
        }, 0.12);
        u517.ribbon = Frame2;
        u517.bonus = slot(v515, "Bonus", v516, {
            cx = 124,
            cy = 274,
            w = 224,
            size = 21
        }, {
            ZIndex = 13,
            TextColor3 = u8.robux[1]
        }, 0.1);
        u517.price = priceButton(v515, "Buy", v516, 14, 296, 220, 66, {
            radius = 14,
            border = 3,
            outer = 3,
            size = 38,
            coin = 36,
            gap = 8,
            z = 13
        });
        u517.price.button.Activated:Connect(function() -- Line: 1576
            -- upvalues: u517 (copy), u506 (copy)
            if u517.item and u506.onBuyPack then
                u506.onBuyPack(u517.item.id);
            end;
        end);
        u506.packs[i] = u517;
    end;
end;

function u4.setPacks(p528, p529) -- Line: 1584
    -- upvalues: put (copy), commas (copy), u6 (copy), setLook (copy), layoutRow (copy)
    local v530 = nil;

    for _, v in p529 or {} do
        if type(v.robux) == "number" and (v.robux > 0 and (not v530 or v.robux < v530.robux)) then
            v530 = v;
        end;
    end;

    for i, v in p528.packs do
        local v531;

        if p529 then
            v531 = p529[i];
        else
            v531 = p529;
        end;

        v.item = v531;
        v.frame.Visible = v531 ~= nil;

        if v531 then
            put(v.amount, (commas(v531.amount or 0)));
            put(v.name, string.upper(v531.name or "CANDY CORN"));
            v.ribbon.Visible = v531.best == true;
            local v532;

            if v531.best then
                v532 = u6.gold;
            else
                v532 = u6.pumpkin;
            end;

            v.frame.Ring.Color = v532;
            local v533;

            if v531.best then
                v533 = u6.gold;
            else
                v533 = u6.pumpkin;
            end;

            v.halo.ImageColor3 = v533;
            local v534 = "";

            if v531.best and (v530 and (v530 ~= v531 and (type(v531.robux) == "number" and v531.robux > 0))) then
                local v535 = v531.amount / v531.robux / (v530.amount / v530.robux) - 1;

                if v535 > 0.005 then
                    v534 = ("+%d%% MORE CANDY"):format((math.floor(v535 * 100 + 0.5)));
                end;
            end;

            put(v.bonus, v534);
            local price = v.price;
            setLook(price, "robux");
            layoutRow(price, {
                { "robux" },
                { "amount", type(v531.robux) ~= "number" and "SOON" or commas(v531.robux) }
            });
        end;
    end;
end;

function u4.showPacks(p536, p537) -- Line: 1616
    if p536.packLayer then
        p536.packLayer.Visible = p537 == true;
    end;
end;

function u4.buildOdds(u538) -- Line: 1623
    -- upvalues: u6 (copy), glow (copy), u248 (copy), cssBox (copy), gradient (copy), slot (copy), Font_fromEnum_ret (copy), put (copy), u8 (copy), bar (copy), tl (copy)
    local stage = u538.stage;
    local v539 = {
        BackgroundTransparency = 1,
        ZIndex = 70,
        Visible = false,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Odds";

    for i, v in v539 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = stage;
    u538.oddsLayer = Frame;
    local v540 = {
        BackgroundTransparency = 0.4,
        AutoButtonColor = false,
        Image = "",
        ZIndex = 1,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = u6.black
    };
    local ImageButton = Instance.new("ImageButton");
    ImageButton.Name = "Shade";

    for i, v in v540 or {} do
        ImageButton[i] = v;
    end;

    ImageButton.Parent = Frame;
    local v541 = {
        CornerRadius = UDim.new(0.01875, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v541 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = ImageButton;
    ImageButton.Activated:Connect(function() -- Line: 1635
        -- upvalues: u538 (copy)
        u538:showOdds(nil);
    end);
    glow(Frame, "Glow", u248, 600, 410, 1000, 680, u6.pumpkin, 0.82, 2);
    gradient(cssBox("Frame", Frame, "Card", u248, 236, 132, 728, 548, {
        border = 3,
        radius = 18,
        outer = 4,
        ring = u6.pumpkin,
        props = {
            BorderSizePixel = 0,
            ZIndex = 3,
            BackgroundColor3 = u6.white
        }
    }), u6.night, u6.deep);
    local v542 = slot(Frame, "Title", u248, {
        cx = 600,
        cy = 186,
        w = 560,
        size = 56,
        font = Font_fromEnum_ret
    }, {
        ZIndex = 5,
        TextColor3 = u6.pumpkin
    }, 0.06);
    v542.label.UIStroke.Color = u6.titleStroke;
    u538.oddsTitle = v542;
    put(slot(Frame, "Subtitle", u248, {
        cx = 600,
        cy = 230,
        w = 600,
        size = 24
    }, {
        ZIndex = 5,
        TextColor3 = u6.mist
    }), "The chance of each item in one opening");
    local v543, v544 = cssBox("ImageButton", Frame, "Close", u248, 898, 150, 48, 48, {
        border = 3,
        radius = 12,
        outer = 3,
        ring = u8.close[3],
        props = {
            AutoButtonColor = true,
            BorderSizePixel = 0,
            ZIndex = 6,
            BackgroundColor3 = u6.white
        }
    });
    local v545 = {
        Rotation = 90,
        Color = ColorSequence.new(u8.close[1], u8.close[2])
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in v545 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = v543;

    for i, v in { u6.black, u6.white } do
        local v546 = i == 1 and 9 or 5;
        bar(v543, "X1_" .. i, v544, 15, 15, 33, 33, v546, v, 6 + i);
        bar(v543, "X2_" .. i, v544, 33, 15, 15, 33, v546, v, 6 + i);
    end;

    v543.Activated:Connect(function() -- Line: 1665
        -- upvalues: u538 (copy)
        u538:showOdds(nil);
    end);
    local v547 = tl(u248, 268, 258, 664, 396);
    local v548 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 6,
        ZIndex = 6,
        ScrollBarImageColor3 = u6.pumpkin,
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y
    };
    local v549 = {};

    for i, v in v547 do
        v549[i] = v;
    end;

    for i, v in v548 do
        v549[i] = v;
    end;

    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "List";

    for i, v in v549 or {} do
        ScrollingFrame[i] = v;
    end;

    ScrollingFrame.Parent = Frame;
    local v550 = {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    };
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Name = "Layout";

    for i, v in v550 or {} do
        UIListLayout[i] = v;
    end;

    UIListLayout.Parent = ScrollingFrame;
    u538.oddsList = ScrollingFrame;
end;

function u4.showOdds(p551, p552) -- Line: 1681
    -- upvalues: put (copy), u6 (copy), label (copy)
    local oddsLayer = p551.oddsLayer;
    local oddsList = p551.oddsList;

    if not oddsLayer then
        return;
    end;

    for _, child in oddsList:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    if type(p552) ~= "table" then
        oddsLayer.Visible = false;

        return;
    end;

    put(p551.oddsTitle, string.upper(p552.title or "CRATE"));
    oddsLayer.Visible = true;
    local math_floor_ret = math.floor(oddsList.AbsoluteSize.X / 13);
    local math_max_ret = math.max(22, math_floor_ret);
    local Layout = oddsList:FindFirstChild("Layout");
    local UDim_new = UDim.new;
    local math_floor_ret2 = math.floor(math_max_ret * 0.15);
    Layout.Padding = UDim_new(0, (math.max(3, math_floor_ret2)));

    for i, v in p552.rows or {} do
        local v553 = v.color or u6.mist;
        local v554 = {
            BackgroundTransparency = 0.45,
            BorderSizePixel = 0,
            ZIndex = 7,
            Size = UDim2.new(1, -10, 0, math_max_ret),
            BackgroundColor3 = u6.black,
            LayoutOrder = i
        };
        local Frame = Instance.new("Frame");
        Frame.Name = "Row" .. i;
        local v555 = v;

        for i2, v2 in v554 or {} do
            Frame[i2] = v2;
        end;

        Frame.Parent = oddsList;
        local v556 = {
            CornerRadius = UDim.new(0.25, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i2, v2 in v556 or {} do
            UICorner[i2] = v2;
        end;

        UICorner.Parent = Frame;
        local v557 = {
            Thickness = 2,
            Transparency = 0.2,
            Color = v553,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Name = "Ring";

        for i2, v2 in v557 or {} do
            UIStroke[i2] = v2;
        end;

        UIStroke.Parent = Frame;
        local v558 = {
            BorderSizePixel = 0,
            ZIndex = 8,
            Size = UDim2.fromScale(0.012, 0.7),
            Position = UDim2.fromScale(0.02, 0.15),
            BackgroundColor3 = v553
        };
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "Rarity";

        for i2, v2 in v558 or {} do
            Frame2[i2] = v2;
        end;

        Frame2.Parent = Frame;
        local v559 = {
            CornerRadius = UDim.new(1, 0)
        };
        local UICorner2 = Instance.new("UICorner");
        UICorner2.Name = "UICorner";

        for i2, v2 in v559 or {} do
            UICorner2[i2] = v2;
        end;

        UICorner2.Parent = Frame2;
        label(Frame, "Name", tostring(v555.name or "?"), {
            ZIndex = 8,
            Position = UDim2.fromScale(0.05, 0.18),
            Size = UDim2.fromScale(0.5, 0.64),
            TextXAlignment = Enum.TextXAlignment.Left
        }, 0.08);
        label(Frame, "Tier", string.upper((tostring(v555.rarity or ""))), {
            ZIndex = 8,
            Position = UDim2.fromScale(0.56, 0.24),
            Size = UDim2.fromScale(0.22, 0.52),
            TextColor3 = v553
        }, 0.08);
        label(Frame, "Chance", tostring(v555.percent or ""), {
            ZIndex = 8,
            Position = UDim2.fromScale(0.8, 0.18),
            Size = UDim2.fromScale(0.17, 0.64),
            TextXAlignment = Enum.TextXAlignment.Right,
            TextColor3 = u6.gold
        }, 0.08);
    end;

    oddsList.CanvasPosition = Vector2.zero;
    oddsLayer.Visible = true;
end;

function u4.setFree(p560, p561, p562) -- Line: 1724
    local free = p560.free;
    local v563;

    if type(p562) == "number" and p562 >= 1 then
        v563 = math.floor(p562);
    else
        v563 = nil;
    end;

    free[p561] = v563;
    local v564 = p560.byId[p561];

    if v564 then
        p560:paint(v564);
    end;
end;

function u4.notice(u565) -- Line: 1733
    -- upvalues: ChickenOrHero (copy)
    task.spawn(function() -- Line: 1734
        -- upvalues: ChickenOrHero (ref), u565 (copy)
        local success, result = pcall(function() -- Line: 1735
            -- upvalues: ChickenOrHero (ref), u565 (ref)
            local v566;

            if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).awaitUIVersion() == "NewGui" then
                v566 = ChickenOrHero:WaitForChild("Interface"):WaitForChild("Toasts", 5);
            else
                v566 = ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyToast", 5);
            end;

            require(v566).show(u565);
        end);

        if not success then
            warn("HalloweenShop notice: " .. tostring(result));
        end;
    end);
end;

local v567 = {};
local v568 = {
    id = "HeadlessHorseman",
    kind = "Title",
    title = "HEADLESS HORSEMAN",
    price = 2500,
    color = Color3.fromRGB(255, 132, 28)
};
local ServerTimeNow = workspace:GetServerTimeNow();
v568.rotatesAt = math.floor(ServerTimeNow) + 172800 + 3600;
local v569 = {
    id = "Emote:PoltergeistThrow",
    kind = "Emote",
    name = "Poltergeist Throw",
    rarity = "Legendary",
    price = 4000
};
local ServerTimeNow2 = workspace:GetServerTimeNow();
v569.rotatesAt = math.floor(ServerTimeNow2) + 18000;
v567[1], v567[2], v567[3], v567[4], v567[5], v567[6] = {
    id = "Emote",
    kind = "Crate",
    crate = "Emote",
    price = 750
}, {
    id = "Treat",
    kind = "Crate",
    crate = "Ember",
    name = "TREAT CRATE",
    price = 750
}, {
    id = "Trick",
    kind = "Crate",
    crate = "Celestial",
    name = "TRICK CRATE",
    price = 750
}, v568, v569, {
    id = "Moonfang",
    kind = "Knife",
    knife = "Moonfang",
    badge = "LIMITED",
    subtitle = "ONLY DURING THE EVENT",
    price = 15000
};
v567.balance = 12450;
local ServerTimeNow3 = workspace:GetServerTimeNow();
v567.endsAt = math.floor(ServerTimeNow3) + 568800 + 1800;
u4.SAMPLE = v567;

return u4;