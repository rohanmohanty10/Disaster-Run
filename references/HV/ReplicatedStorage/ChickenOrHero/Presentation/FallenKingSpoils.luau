 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local ContentProvider = game:GetService("ContentProvider");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ChickenOrHero = ReplicatedStorage:WaitForChild("ChickenOrHero");
local Presentation = ChickenOrHero:WaitForChild("Presentation");
local Game = ChickenOrHero:WaitForChild("Game");
local HudNavigation = require(Presentation:WaitForChild("HudNavigation"));
local Session = Game:WaitForChild("Session");
local LocalPlayer = Players.LocalPlayer;
local u1 = {
    ROW_Y = 0.42,
    TALLEST = 0.44,
    ACROSS = 0.88,
    GAP = 0.4,
    BANNER_GAP = 0.018,
    BANNER_WIDTH = 1.08,
    BANNER_SHAPE = 4.8,
    BANNER_LEAST = 0.045,
    KING_SHAPE = 3.2,
    KING_TALLEST = 0.13,
    KING_GAP = 0.03,
    GLOOM = 0.45,
    KING_WIDTH = { 0.42, 0.86 },
    DEPTH = { 1.5, 8 }
};
local u2 = {
    ENTER = 0.5,
    STAGGER = 0.07,
    FIRST = 1.75,
    NEXT = 1.25,
    IMPACT_PUNCH = 0.22,
    IMPACT_PUNCH_SECONDS = 0.34,
    IMPACT_FLASH = 3.5,
    IMPACT_FLASH_SECONDS = 0.45,
    IMPACT_RING = 4.2,
    IMPACT_RING_SECONDS = 0.45,
    IMPACT_RING_THICKNESS = 26,
    IMPACT_SPARKS = 36,
    IMPACT_WISPS = 14,
    IMPACT_SCREEN = 0.5,
    SCREEN_FLASH = 0.45,
    SCREEN_FLASH_SECONDS = 0.28,
    VIGNETTE = 0.45,
    VIGNETTE_SECONDS = 0.6,
    NUDGE = 0.07,
    NUDGE_SECONDS = 0.26,
    BUILD_SECONDS = 0.45,
    BUILD_SHAKE = { 0.03, 0.16 },
    BUILD_TILT = 0.15707963267948966,
    AFTERIMAGE_EVERY = 0.022,
    AFTERIMAGE_SECONDS = 0.24,
    TELL_FROM = 0.5,
    TELL_SECONDS = 0.8,
    TELL_FLASH = 4,
    TELL_SPARKS = 40,
    TELL_PUNCH = 0.12,
    FLIP_SECONDS = 0.3,
    REVEAL_PUNCH = 0.3,
    REVEAL_PUNCH_SECONDS = 0.45,
    REVEAL_FLASH = 5.5,
    REVEAL_FLASH_SECONDS = 0.7,
    REVEAL_RING = 4.6,
    REVEAL_RING_SECONDS = 0.5,
    REVEAL_RING_THICKNESS = 22,
    BURST = {
        Common = 30,
        Rare = 40,
        Epic = 55,
        Legendary = 70,
        Mythical = 100
    },
    MYTHIC_RINGS = { 1.3, 1.6 },
    MYTHIC_GLOW = { 0.1, 3.5 },
    MYTHIC_PILLAR = 1.4,
    MYTHIC_WASH = 0.22,
    MYTHIC_HOLD = 4,
    INSPECT_TILT = 0.20943951023931956,
    INSPECT_GROW = 0.03,
    INSPECT_EASE = 8,
    INSPECT_EDGE = 1.1,
    SLAM_SECONDS = 0.14,
    BOB = 0.02,
    BOB_SPEED = 1.7,
    KING_AFTER = 1.9,
    HOLD = 1.2,
    OUTRO = 0.45,
    PACE_LEAST = 0.4
};
local u3 = {
    Enter = { "rbxassetid://9113080525", 0.22, 0.25, 0.8, 0 },
    Hover = { "rbxassetid://9117188688", 0.25, 0.02, 0.3, 0 },
    Lock = { "rbxassetid://9114144270", 0.8, 0.52, 0.5, 0.23 },
    Build = { "rbxassetid://9048834006", 0.3, 2.4, 0.85, 0 },
    Flip = { "rbxassetid://9113818686", 0.45, 0.03, 0.25, 0.02 },
    Reveal = { "rbxassetid://9116384762", 0.45, 0.18, 1.6, 0.02 },
    RevealBig = { "rbxassetid://1841354419", 0.75, 0.15, 3, 0.3 },
    Mythical = { "rbxassetid://1846886773", 0.5, 0.1, 3.5, 0.3 },
    Leave = { "rbxassetid://9118158113", 0.35, 0.1, 0.45, 0 }
};
local Color3_fromRGB_ret = Color3.fromRGB(120, 255, 170);
local Color3_fromRGB_ret2 = Color3.fromRGB(12, 16, 18);
local Color3_fromRGB_ret3 = Color3.fromRGB(240, 255, 246);
local Color3_fromRGB_ret4 = Color3.fromRGB(206, 226, 216);
local Font_fromEnum_ret = Font.fromEnum(Enum.Font.GothamBlack);
local Font_fromEnum_ret2 = Font.fromEnum(Enum.Font.GothamBold);
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local u4 = {
    DEEP = Color3.fromRGB(150, 0, 32),
    RED = Color3.fromRGB(255, 72, 96),
    HOT = Color3.fromRGB(255, 175, 185)
};
u4.SHIMMER = ColorSequence.new({
    ColorSequenceKeypoint.new(0, u4.DEEP),
    ColorSequenceKeypoint.new(0.3, u4.RED),
    ColorSequenceKeypoint.new(0.5, u4.HOT),
    ColorSequenceKeypoint.new(0.7, u4.RED),
    ColorSequenceKeypoint.new(1, u4.DEEP)
});
local u5 = {
    Common = Color3.fromRGB(175, 185, 192),
    Rare = Color3.fromRGB(92, 173, 238),
    Epic = Color3.fromRGB(183, 123, 244),
    Legendary = Color3.fromRGB(242, 191, 89),
    Mythical = Color3.fromRGB(255, 72, 96)
};
local u6 = {
    PRINT_PIXELS = 300,
    STYLES = {
        normal = {
            art = "Green Card Key",
            drop = 0,
            ink = Color3.fromHex("D8FFF4"),
            accent = Color3.fromHex("7FFFF5"),
            glow = Color3.fromHex("00F6B6"),
            stroke = Color3.fromHex("00281A")
        },
        gold = {
            art = "Gold Card",
            drop = 0,
            ink = Color3.fromHex("FFF4D6"),
            accent = Color3.fromHex("FFD36A"),
            glow = Color3.fromHex("FFC21A"),
            stroke = Color3.fromHex("2A1600")
        }
    },
    RARITY = {
        Common = {
            halo = 1
        },
        Rare = {
            ink = "accent",
            halo = 1.3
        },
        Epic = {
            halo = 1.3,
            ink = Color3.fromHex("E7B8FF"),
            glow = Color3.fromHex("B77BF4")
        },
        Legendary = {
            halo = 1.6,
            ink = Color3.fromHex("FFFA08"),
            glow = Color3.fromHex("FFE600")
        },
        Mythical = {
            halo = 1.8,
            shimmer = true,
            ink = Color3.fromHex("FFFFFF"),
            glow = Color3.fromHex("FF4860")
        }
    },
    ICONS = {
        Coins = "rbxassetid://78008558948307",
        Gems = "rbxassetid://137046122108742",
        Candy = "rbxassetid://119759573303359",
        CrateKey = "rbxassetid://115583741443536",
        Knife = "rbxassetid://127106171586822",
        Emote = "rbxassetid://117630660259402",
        Keys = "rbxassetid://99826093535691"
    },
    REWARD_ICONS = {},
    KINDS = {
        Knife = "KNIFE",
        Emote = "EMOTE",
        Title = "TITLE"
    }
};
local CFrame_fromMatrix_ret = CFrame.fromMatrix(Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), Vector3.new(0, 1, 0));
local CFrame_Angles_ret = CFrame.Angles(0, 3.141592653589793, 0);
local u7 = {
    Mythical = 1,
    Legendary = 2,
    Epic = 3,
    Rare = 4,
    Common = 5
};
local u8 = {
    Coins = true,
    Gems = true,
    Keys = true,
    CrateKey = true,
    Title = true,
    Emote = true,
    Knife = true,
    Candy = true
};
local v9 = {};
local u10 = nil;
local u11 = 0;
local u12 = 0;
local u13 = false;

local function unitOr(p14, p15) -- Line: 233
    if p14.Magnitude > 0.0001 then
        return p14.Unit;
    end;

    return p15;
end;

local function smooth(p16) -- Line: 236
    local math_clamp_ret = math.clamp(p16, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

local function backOut(p17) -- Line: 240
    local math_clamp_ret = math.clamp(p17, 0, 1);

    return 1 + 2.2 * (math_clamp_ret - 1) ^ 3 + 1.2 * (math_clamp_ret - 1) ^ 2;
end;

local function make(p18, p19, p20, p21) -- Line: 244
    local Instance_new_ret = Instance.new(p18);
    Instance_new_ret.Name = p20;

    for i, v in p21 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p19;

    return Instance_new_ret;
end;

local function quiet(p22) -- Line: 253
    p22.Anchored = true;
    p22.CanCollide = false;
    p22.CanTouch = false;
    p22.CanQuery = false;
    p22.CastShadow = false;

    return p22;
end;

local function still(p23) -- Line: 257
    -- upvalues: u10 (ref)
    local v24;

    if u10 == p23 then
        v24 = not p23.done and not p23.outroFrom;
    else
        v24 = false;
    end;

    return v24;
end;

local function isHigh(p25) -- Line: 260
    -- upvalues: u7 (copy)
    if p25 then
        p25 = p25.rarity;
    end;

    return (u7[p25] or 6) <= 2;
end;

local u26 = {};
local TextService = game:GetService("TextService");
local Vector2_new_ret = Vector2.new(100000, 1000);

function u26.width(p27, p28) -- Line: 270
    -- upvalues: TextService (copy), Vector2_new_ret (copy)
    local v29;

    if p28 then
        v29 = Enum.Font.GothamBlack;
    else
        v29 = Enum.Font.GothamBold;
    end;

    local success, result = pcall(TextService.GetTextSize, TextService, p27, 100, v29, Vector2_new_ret);

    if success then
        return result.X / 100 * 1.02;
    end;

    return (utf8.len(p27) or #p27) * 0.65;
end;

local function heavy(p30) -- Line: 275
    return p30.FontFace.Weight.Value >= 800;
end;

function u26.line(p31, p32, p33, p34, p35) -- Line: 279
    -- upvalues: u26 (copy)
    p31.Text = p32;
    p31.TextScaled = false;
    p31.TextWrapped = false;
    local v36 = u26.width(p32, p31.FontFace.Weight.Value >= 800);
    local v37 = p33 / math.max(v36, 0.5);
    local math_min_ret = math.min(p35 or p34, p34, v37);
    local math_floor_ret = math.floor(math_min_ret);
    p31.TextSize = math.max(8, math_floor_ret);
end;

function u26.fit(p38, p39, p40, p41, p42) -- Line: 286
    -- upvalues: u26 (copy)
    local v43 = p38.FontFace.Weight.Value >= 800;
    local v44 = u26.width(p39, v43);
    local v45 = p40 / math.max(v44, 0.5);
    local math_min_ret = math.min(p42, p41 * 0.85, v45);
    local v46 = p39;
    local v47 = (1 / 0);
    local v48 = nil;

    for i in string.gmatch(p39, "() ") do
        local v49 = u26.width(string.sub(p39, 1, i - 1), v43);
        local width = u26.width;
        local string_sub_ret = string.sub(p39, i + 1);
        local math_max_ret = math.max(v49, width(string_sub_ret, v43));

        if math_max_ret < v47 then
            v48 = i;
            v47 = math_max_ret;
        end;
    end;

    local v50;

    if v48 then
        local v51 = p40 / math.max(v47, 0.5);
        v50 = math.min(p42, p41 / 2.3, v51);

        if math_min_ret * 1.15 < v50 then
            v46 = string.sub(p39, 1, v48 - 1) .. "\n" .. string.sub(p39, v48 + 1);
        else
            v50 = math_min_ret;
        end;
    else
        v50 = math_min_ret;
    end;

    p38.Text = v46;
    p38.TextScaled = false;
    p38.TextWrapped = false;
    local math_floor_ret = math.floor(v50);
    p38.TextSize = math.max(8, math_floor_ret);
end;

local u61 = {
    warm = function(p52) -- Line: 310, Name: warm
        -- upvalues: u3 (copy)
        p52.sounds = {};

        for i, v in u3 do
            local sounds = p52.sounds;
            local folder = p52.folder;
            local v53 = {
                Volume = 0,
                SoundId = v[1]
            };
            local Sound = Instance.new("Sound");
            Sound.Name = "Warm" .. i;

            for i2, v2 in v53 or {} do
                Sound[i2] = v2;
            end;

            Sound.Parent = folder;
            sounds[i] = Sound;
        end;
    end,

    play = function(p54, p55, u56, p57) -- Line: 317, Name: play
        -- upvalues: u3 (copy), TweenService (copy)
        local u58 = u3[p55];
        local v59 = p54.sounds and p54.sounds[p55];

        if not (u58 and (v59 and (p54.folder and p54.folder.Parent))) then
            return nil;
        end;

        local u60 = v59:Clone();
        u60.Name = p55;
        u60.Volume = p57 or u58[2];
        u60.PlaybackSpeed = u56 or 1;
        u60.Parent = p54.folder;
        local os_clock_ret = os.clock();

        local function go() -- Line: 328
            -- upvalues: u60 (copy), u58 (copy), u56 (copy), TweenService (ref)
            if not u60.Parent then
                return;
            end;

            u60.TimePosition = u58[3];
            u60:Play();
            task.delay(u58[4] / (u56 or 1), function() -- Line: 334
                -- upvalues: u60 (ref), TweenService (ref)
                if u60.Parent then
                    TweenService:Create(u60, TweenInfo.new(0.08), {
                        Volume = 0
                    }):Play();
                    task.delay(0.1, function() -- Line: 337
                        -- upvalues: u60 (ref)
                        u60:Destroy();
                    end);
                end;
            end);
        end;

        if not u60.IsLoaded then
            u60.Loaded:Once(function() -- Line: 347
                -- upvalues: os_clock_ret (copy), u60 (copy), u58 (copy), u56 (copy), TweenService (ref)
                if os.clock() - os_clock_ret >= 0.5 then
                    u60:Destroy();

                    return;
                end;

                if not u60.Parent then
                    return;
                end;

                u60.TimePosition = u58[3];
                u60:Play();
                task.delay(u58[4] / (u56 or 1), function() -- Line: 334
                    -- upvalues: u60 (ref), TweenService (ref)
                    if u60.Parent then
                        TweenService:Create(u60, TweenInfo.new(0.08), {
                            Volume = 0
                        }):Play();
                        task.delay(0.1, function() -- Line: 337
                            -- upvalues: u60 (ref)
                            u60:Destroy();
                        end);
                    end;
                end);
            end);
            task.delay(3, function() -- Line: 354
                -- upvalues: u60 (copy)
                if u60.Parent and not u60.IsPlaying then
                    u60:Destroy();
                end;
            end);

            return u60;
        end;

        if not u60.Parent then
            return u60;
        end;

        u60.TimePosition = u58[3];
        u60:Play();
        task.delay(u58[4] / (u56 or 1), function() -- Line: 334
            -- upvalues: u60 (copy), TweenService (ref)
            if u60.Parent then
                TweenService:Create(u60, TweenInfo.new(0.08), {
                    Volume = 0
                }):Play();
                task.delay(0.1, function() -- Line: 337
                    -- upvalues: u60 (ref)
                    u60:Destroy();
                end);
            end;
        end);

        return u60;
    end
};

function u61.cue(u62, u63, p64, u65) -- Line: 363
    -- upvalues: u3 (copy), u61 (copy), u10 (ref)
    local v66 = u3[u63];

    if not v66 then
        return;
    end;

    local v67 = p64 - os.clock() - (v66[5] or 0) / (u65 or 1);

    if v67 <= 0.01 then
        u61.play(u62, u63, u65);

        return;
    end;

    task.delay(v67, function() -- Line: 372
        -- upvalues: u10 (ref), u62 (copy), u61 (ref), u63 (copy), u65 (copy)
        if u10 == u62 and not u62.done then
            u61.play(u62, u63, u65);
        end;
    end);
end;

local u68 = nil;

local function rarityColor(p69) -- Line: 382
    -- upvalues: u68 (ref), Game (copy), u5 (copy), Color3_fromRGB_ret (copy)
    if u68 == nil then
        local GhostTraderConfig = Game:FindFirstChild("GhostTraderConfig");
        local v70, v71;

        if GhostTraderConfig then
            v70, v71 = pcall(require, GhostTraderConfig);
        else
            v70 = false;
            v71 = nil;
        end;

        if not v70 or type(v71) ~= "table" then
            v71 = false;
        end;

        u68 = v71;
    end;

    local v72 = u68;

    if v72 then
        if type(u68.RarityColors) == "table" then
            v72 = u68.RarityColors;
        else
            v72 = false;
        end;
    end;

    if v72 then
        v72 = v72[p69];
    end;

    if typeof(v72) == "Color3" then
        return v72;
    end;

    return u5[p69] or Color3_fromRGB_ret;
end;

local u73 = {
    checked = false,
    pending = false,
    ok = false,
    folder = nil
};

local function checkArt() -- Line: 402
    -- upvalues: u73 (copy), ReplicatedStorage (copy), ContentProvider (copy)
    if u73.checked then
        return;
    end;

    u73.checked = true;
    u73.pending = true;
    task.spawn(function() -- Line: 407
        -- upvalues: ReplicatedStorage (ref), u73 (ref), ContentProvider (ref)
        local GhostTraderAssets = ReplicatedStorage:FindFirstChild("GhostTraderAssets");

        if GhostTraderAssets then
            GhostTraderAssets = GhostTraderAssets:FindFirstChild("Cards");
        end;

        if not GhostTraderAssets then
            u73.pending = false;
            warn("[FallenKingSpoils] ReplicatedStorage.GhostTraderAssets.Cards is missing: plain glowing cards instead");

            return;
        end;

        local u74 = { GhostTraderAssets };

        for _, descendant in GhostTraderAssets:GetDescendants() do
            if descendant:IsA("SurfaceAppearance") then
                local success, result = pcall(function() -- Line: 419
                    -- upvalues: descendant (copy)
                    return descendant.ColorMap;
                end);

                if success and (type(result) == "string" and result ~= "") then
                    local ImageLabel = Instance.new("ImageLabel");
                    ImageLabel.Name = "Probe";

                    for i, v in {
                        Image = result
                    } or {} do
                        ImageLabel[i] = v;
                    end;

                    ImageLabel.Parent = nil;
                    table.insert(u74, ImageLabel);
                end;
            end;
        end;

        local u75 = {};
        local success, result = pcall(function() -- Line: 428
            -- upvalues: ContentProvider (ref), u74 (copy), u75 (copy)
            ContentProvider:PreloadAsync(u74, function(p76, p77) -- Line: 429
                -- upvalues: u75 (ref)
                if p77 ~= Enum.AssetFetchStatus.Success then
                    local v78 = tostring(p76) .. " " .. p77.Name;
                    table.insert(u75, v78);
                end;
            end);
        end);

        for _, v in u74 do
            if v:IsA("ImageLabel") then
                v:Destroy();
            end;
        end;

        if success and #u75 == 0 then
            u73.folder = GhostTraderAssets;
            u73.ok = true;
        else
            local l_warn = warn;
            local v79;

            if success then
                v79 = table.concat(u75, ", ");
            else
                v79 = tostring(result);
            end;

            l_warn("[FallenKingSpoils] the card art didn\'t load (" .. v79 .. "); plain glowing cards instead");
        end;

        u73.pending = false;
    end);
end;

local function unproject(p80, p81, p82, p83, p84, p85) -- Line: 454
    return p80.Position + p80:VectorToWorldSpace((Vector3.new((p83 * 2 - 1) * p82 * p81, (1 - p84 * 2) * p82, -1))) * p85;
end;

local function layoutFor(p86, p87, p88) -- Line: 459
    -- upvalues: u1 (copy)
    local math_max_ret = math.max(p86, 1);
    local math_min_ret = math.min(u1.TALLEST, u1.ACROSS * p87 / ((math_max_ret + u1.GAP * (math_max_ret - 1)) * 0.5951557093425606));
    local v89 = math_min_ret * 0.5951557093425606 / p87;
    local v90 = {
        tall = math_min_ret,
        wide = v89,
        y = u1.ROW_Y,
        xs = {}
    };

    for i = 1, math_max_ret do
        v90.xs[i] = 0.5 + (i - (math_max_ret + 1) / 2) * v89 * (1 + u1.GAP);
        local _ = i;
    end;

    local v91 = 2 * p88;
    v90.depth = math.clamp(1.25 / (math_min_ret * v91), u1.DEPTH[1], u1.DEPTH[2]);
    v90.scale = math_min_ret * v91 * v90.depth / 1.25;
    v90.drop = (1 - v90.y + math_min_ret / 2 + 0.03) * v91 * v90.depth;
    v90.bannerW = v89 * u1.BANNER_WIDTH;
    v90.bannerH = math.max(v90.bannerW * p87 / u1.BANNER_SHAPE, u1.BANNER_LEAST);
    v90.bannerY = v90.y + math_min_ret / 2 + u1.BANNER_GAP + v90.bannerH / 2;
    local v92;

    if p87 < 1 then
        v92 = u1.KING_WIDTH[2];
    else
        v92 = u1.KING_WIDTH[1];
    end;

    v90.kingW = v92;
    v90.kingH = math.min(u1.KING_TALLEST, v90.kingW * p87 / u1.KING_SHAPE);
    v90.kingY = math.max(v90.kingH / 2 + 0.03, v90.y - math_min_ret / 2 - u1.KING_GAP - v90.kingH / 2);

    return v90;
end;

local function cardSize() -- Line: 484
    return Vector3.new(0.74394464, 1.25, 0.02);
end;

local function addLayer(p93, p94, p95) -- Line: 487
    p94.Anchored = true;
    p94.CanCollide = false;
    p94.CanTouch = false;
    p94.CanQuery = false;
    p94.CastShadow = false;
    p94.Parent = p93.model;
    local v96 = {
        part = p94,
        offset = p95,
        size = p94.Size
    };
    table.insert(p93.layers, v96);
    p93.scale = nil;

    return v96;
end;

local function dropLayer(p97, p98) -- Line: 495
    if not p98 then
        return;
    end;

    local table_find_ret = table.find(p97.layers, p98);

    if table_find_ret then
        table.remove(p97.layers, table_find_ret);
    end;

    p98.part:Destroy();
end;

local function place(p99, p100, p101) -- Line: 505
    local v102 = p99.scale ~= p101;
    local v103 = {};
    local v104 = {};

    for _, v in p99.layers do
        local offset = v.offset;
        table.insert(v103, v.part);
        local v105 = p100 * CFrame.new(offset.Position * p101) * offset.Rotation;
        table.insert(v104, v105);

        if v102 then
            v.part.Size = v.size * p101;
        end;
    end;

    p99.scale = p101;
    p99.frame = p100;
    workspace:BulkMoveTo(v103, v104, Enum.BulkMoveMode.FireCFrameChanged);
end;

local function surface(p106, p107, p108, p109, p110) -- Line: 522
    local SurfaceGui = Instance.new("SurfaceGui");
    SurfaceGui.Name = p109;
    SurfaceGui.Face = p108 or Enum.NormalId.Front;
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    SurfaceGui.PixelsPerStud = 220;
    SurfaceGui.LightInfluence = 0;
    SurfaceGui.Brightness = p110 or 1.2;
    SurfaceGui:SetAttribute("CreatorCaptureExempt", true);
    SurfaceGui.AlwaysOnTop = false;
    SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    SurfaceGui.ResetOnSpawn = false;
    SurfaceGui.ClipsDescendants = true;
    SurfaceGui.Adornee = p107;
    SurfaceGui.Parent = p107;
    table.insert(p106.guis, SurfaceGui);

    return SurfaceGui;
end;

local function textStroke(p111, p112, p113) -- Line: 540
    local v114 = {
        Color = p112,
        Thickness = p113,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "TextStroke";

    for i, v in v114 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p111;

    return UIStroke;
end;

local function artPart(p115) -- Line: 544
    -- upvalues: u73 (copy)
    local v116 = u73.ok and u73.folder and u73.folder:FindFirstChild(p115);

    if v116 then
        v116 = v116:FindFirstChildWhichIsA("MeshPart", true);
    end;

    if not v116 then
        return nil;
    end;

    local v117 = v116:Clone();
    v117.Size = v116.Size * (1.25 / math.max(v116.Size.Y, 0.01));

    return v117;
end;

local function plainPart(p118, p119, p120) -- Line: 555
    -- upvalues: Color3_fromRGB_ret2 (copy), surface (copy)
    local v121 = {
        Size = Vector3.new(0.74394464, 1.25, 0.02),
        Material = Enum.Material.SmoothPlastic,
        Color = Color3_fromRGB_ret2
    };
    local Part = Instance.new("Part");
    Part.Name = "Plain";

    for i, v in v121 or {} do
        Part[i] = v;
    end;

    Part.Parent = nil;
    local v122 = surface(p118, Part, Enum.NormalId.Front, "Plain");
    v122.PixelsPerStud = 300;
    local v123 = {
        BackgroundColor3 = Color3.fromRGB(10, 26, 20):Lerp(p119, 0.12),
        Size = UDim2.new(1, -12, 1, -12),
        Position = UDim2.fromOffset(6, 6)
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Plate";

    for i, v in v123 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = v122;
    local v124 = {
        CornerRadius = UDim.new(0, 14)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v124 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v125 = {
        Thickness = 5,
        Color = p119,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";

    for i, v in v125 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;

    if p120 then
        local v126 = {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.44),
            Size = UDim2.fromScale(0.3, 0.3),
            BackgroundColor3 = p119
        };
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "Keyhole";

        for i, v in v126 or {} do
            Frame2[i] = v;
        end;

        Frame2.Parent = Frame;
        local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
        UIAspectRatioConstraint.Name = "Aspect";

        for i, v in {
            AspectRatio = 1
        } or {} do
            UIAspectRatioConstraint[i] = v;
        end;

        UIAspectRatioConstraint.Parent = Frame2;
        local v127 = {
            CornerRadius = UDim.new(0.5, 0)
        };
        local UICorner2 = Instance.new("UICorner");
        UICorner2.Name = "UICorner";

        for i, v in v127 or {} do
            UICorner2[i] = v;
        end;

        UICorner2.Parent = Frame2;
        local v128 = {
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromScale(0.5, 0.48),
            Size = UDim2.fromScale(0.1, 0.2),
            BackgroundColor3 = p119
        };
        local Frame3 = Instance.new("Frame");
        Frame3.Name = "Slot";

        for i, v in v128 or {} do
            Frame3[i] = v;
        end;

        Frame3.Parent = Frame;
    end;

    return Part;
end;

local function setFace(p129, p130) -- Line: 585
    -- upvalues: plainPart (copy), CFrame_Angles_ret (copy)
    if p130.plain and not p130.face then
        local v131 = plainPart(p129, p130.style.glow, false);
        local v132 = CFrame.new(0, 0, 0.012) * CFrame_Angles_ret;
        v131.Anchored = true;
        v131.CanCollide = false;
        v131.CanTouch = false;
        v131.CanQuery = false;
        v131.CastShadow = false;
        v131.Parent = p130.model;
        local v133 = {
            part = v131,
            offset = v132,
            size = v131.Size
        };
        table.insert(p130.layers, v133);
        p130.scale = nil;
        p130.face = v133;
    end;
end;

local function faceGlow(p134, p135) -- Line: 591
    -- upvalues: u6 (copy)
    local v136 = u6.RARITY[p135];

    return v136 and v136.glow or p134.style.glow;
end;

local function setLabel(p137, p138, p139) -- Line: 597
    -- upvalues: u6 (copy), CFrame_Angles_ret (copy), surface (copy), Font_fromEnum_ret (copy), u26 (copy), u4 (copy), Font_fromEnum_ret2 (copy)
    local label = p138.label;

    if label then
        local table_find_ret = table.find(p138.layers, label);

        if table_find_ret then
            table.remove(p138.layers, table_find_ret);
        end;

        label.part:Destroy();
    end;

    p138.label = nil;

    if type(p139) ~= "table" then
        return;
    end;

    local style = p138.style;
    local v140 = u6.RARITY[p139.rarity] or u6.RARITY.Common;
    local v141;

    if v140.ink == "accent" then
        v141 = style.accent;
    elseif v140.ink then
        v141 = v140.ink;
    else
        v141 = style.ink;
    end;

    local v142 = v140.glow or style.glow;
    local v143 = Vector3.new(0.74394464, 1.25, 0.02);
    local v144 = v143.X * 0.84;
    local v145 = v143.Y * 0.84;
    local v146 = {
        Transparency = 1,
        Size = Vector3.new(v144, v145, 0.002)
    };
    local Part = Instance.new("Part");
    Part.Name = "Print";

    for i, v in v146 or {} do
        Part[i] = v;
    end;

    Part.Parent = nil;
    local v147 = CFrame.new(0, 0, p138.reverse) * CFrame_Angles_ret;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    Part.Parent = p138.model;
    local v148 = {
        part = Part,
        offset = v147,
        size = Part.Size
    };
    table.insert(p138.layers, v148);
    p138.scale = nil;
    p138.label = v148;
    local u149 = surface(p137, Part, Enum.NormalId.Front, "Print", 1.3);
    u149.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
    local PRINT_PIXELS = u6.PRINT_PIXELS;
    local math_floor_ret = math.floor(PRINT_PIXELS * v145 / v144 + 0.5);
    u149.CanvasSize = Vector2.new(PRINT_PIXELS, math_floor_ret);

    local function line(p150, p151, p152, p153, p154, p155) -- Line: 616
        -- upvalues: u149 (copy), PRINT_PIXELS (copy), math_floor_ret (copy), style (copy)
        local v156 = {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(PRINT_PIXELS * 0.04, math_floor_ret * (p153 + style.drop)),
            Size = UDim2.fromOffset(PRINT_PIXELS * 0.92, math_floor_ret * p154),
            FontFace = p151,
            TextColor3 = p152
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = p150;

        for i, v in v156 or {} do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = u149;

        if p155 then
            local v157 = {
                Color = style.stroke,
                Thickness = p155,
                LineJoinMode = Enum.LineJoinMode.Round
            };
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Name = "Edge";

            for i, v in v157 or {} do
                UIStroke[i] = v;
            end;

            UIStroke.Parent = TextLabel;
        end;

        return TextLabel;
    end;

    local v158 = tostring(p139.kind or "");
    local v159 = (v158 == "Coins" or (v158 == "Candy" or v158 == "Gems")) and true or v158 == "Keys";
    local v160 = u6.REWARD_ICONS[p139.id] or u6.ICONS[v158];
    local v161 = line("Rarity", Font_fromEnum_ret, style.accent, 0.08, 0.09, 2.5);
    u26.line(v161, string.upper((tostring(p139.rarity or ""))), PRINT_PIXELS * 0.92, math_floor_ret * 0.09, math_floor_ret * 0.08);

    if v160 then
        local v162 = {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromOffset(PRINT_PIXELS / 2, math_floor_ret * (0.19 + style.drop)),
            Size = UDim2.fromOffset(math_floor_ret * 0.27, math_floor_ret * 0.27),
            Image = v160
        };
        local v163;

        if u6.REWARD_ICONS[p139.id] then
            v163 = Color3.new(1, 1, 1);
        else
            v163 = Color3.new(1, 1, 1):Lerp(v141, 0.35);
        end;

        v162.ImageColor3 = v163;
        v162.ScaleType = Enum.ScaleType.Fit;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Icon";

        for i, v in v162 or {} do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = u149;
    end;

    local v164 = tostring(p139.name or "Reward");

    if v159 then
        v164 = string.gsub(v164, "^%+?[%d,]+%s+", "");
    end;

    if v158 == "Title" then
        v164 = string.gsub(v164, "%s+[Tt]itle$", "");
    end;

    local v165 = tonumber(p139.amount);
    local v166 = u6.KINDS[v158];
    local v167 = type(p139.duplicateGems) == "number";

    if v167 then
        v166 = "+" .. p139.duplicateGems .. " GEMS";
    end;

    if v159 and v165 then
        local math_floor_ret2 = math.floor(v165);
        local v168 = tostring(math_floor_ret2);
        local string_reverse_ret = string.reverse((string.gsub(string.reverse(v168), "(%d%d%d)", "%1,")));
        v166 = "+" .. string.gsub(string_reverse_ret, "^,", "");
    end;

    local v169 = v160 and 0.47 or 0.33;
    local v170 = v160 and 0.25 or 0.32;
    local v171 = v169 + v170 + 0.02;

    if not v160 and v166 then
        v169 = (v171 + 0.055 + 0.125) / 2 - v170 / 2;
    end;

    local v172 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(PRINT_PIXELS * 0.04, math_floor_ret * (v169 + style.drop)),
        Size = UDim2.fromOffset(PRINT_PIXELS * 0.92, math_floor_ret * v170),
        FontFace = Font_fromEnum_ret,
        TextColor3 = v142
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Glow";

    for i, v in v172 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = u149;
    TextLabel.TextTransparency = 0.4;
    local v173 = {
        Transparency = 0.55,
        Color = v142,
        Thickness = 5 * v140.halo,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Halo";

    for i, v in v173 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    if v140.shimmer then
        local v174 = {
            Color = u4.SHIMMER
        };
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Name = "Shimmer";

        for i, v in v174 or {} do
            UIGradient[i] = v;
        end;

        UIGradient.Parent = TextLabel;
    end;

    local v175 = line("Name", Font_fromEnum_ret, v141, v169, v170, 3);
    u26.fit(v175, string.upper(v164), PRINT_PIXELS * 0.92, math_floor_ret * v170, math_floor_ret * 0.15);
    local TextSize = v175.TextSize;
    TextLabel.Text = v175.Text;
    TextLabel.TextSize = TextSize;
    TextLabel.TextScaled = false;
    TextLabel.TextWrapped = false;

    if v166 then
        local v176 = line("Amount", Font_fromEnum_ret, style.accent, v171, 0.11, 2.5);
        u26.line(v176, v166, PRINT_PIXELS * 0.92, math_floor_ret * 0.11, math_floor_ret * ((v159 or v167) and 0.1 or 0.08));
    end;

    if v167 then
        local v177 = line("Duplicate", Font_fromEnum_ret2, style.accent, v171 + 0.11, 0.07, 2);
        u26.line(v177, "ALREADY OWNED", PRINT_PIXELS * 0.92, math_floor_ret * 0.07, math_floor_ret * 0.07);
    end;
end;

local function newCard(p178, p179) -- Line: 692
    -- upvalues: surface (copy), Color3_fromRGB_ret (copy), u6 (copy), artPart (copy), CFrame_fromMatrix_ret (copy), plainPart (copy), CFrame_Angles_ret (copy)
    local folder = p178.folder;
    local Model = Instance.new("Model");
    Model.Name = "Card" .. p179;
    local v180 = {
        flip = 0,
        slot = p179,
        layers = {},
        glowImages = {}
    };

    for i, v in {} do
        Model[i] = v;
    end;

    Model.Parent = folder;
    v180.model = Model;
    local v181 = Vector3.new(0.74394464, 1.25, 0.02);
    local v182 = {
        Transparency = 1,
        Size = Vector3.new(v181.X, v181.Y, 0.1)
    };
    local Part = Instance.new("Part");
    Part.Name = "Hit";

    for i, v in v182 or {} do
        Part[i] = v;
    end;

    Part.Parent = nil;
    local CFrame_identity = CFrame.identity;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    Part.Parent = v180.model;
    local v183 = {
        part = Part,
        offset = CFrame_identity,
        size = Part.Size
    };
    table.insert(v180.layers, v183);
    v180.scale = nil;
    v180.hit = v183.part;

    for _, v in {
        { Enum.NormalId.Front, 0.025 },
        { Enum.NormalId.Back, -0.025 }
    } do
        local v184 = {
            Transparency = 1,
            Size = Vector3.new(v181.X * 1.9, v181.Y * 1.6, 0.006)
        };
        local Part2 = Instance.new("Part");
        Part2.Name = "Glow";
        local v185 = v;

        for i, v2 in v184 or {} do
            Part2[i] = v2;
        end;

        Part2.Parent = nil;
        local CFrame_new_ret = CFrame.new(0, 0, -0.012 + v185[2]);
        Part2.Anchored = true;
        Part2.CanCollide = false;
        Part2.CanTouch = false;
        Part2.CanQuery = false;
        Part2.CastShadow = false;
        Part2.Parent = v180.model;
        local v186 = {
            part = Part2,
            offset = CFrame_new_ret,
            size = Part2.Size
        };
        table.insert(v180.layers, v186);
        v180.scale = nil;
        local v187 = surface(p178, v186.part, v185[1], "Glow");
        v187.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
        v187.CanvasSize = Vector2.new(190, 160);
        v187.Brightness = 2;
        v187.ClipsDescendants = false;
        local glowImages = v180.glowImages;
        local v188 = {
            BackgroundTransparency = 1,
            Image = "rbxassetid://129028976496842",
            ImageTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            ImageColor3 = Color3_fromRGB_ret
        };
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Glow";

        for i, v2 in v188 or {} do
            ImageLabel[i] = v2;
        end;

        ImageLabel.Parent = v187;
        table.insert(glowImages, ImageLabel);
    end;

    v180.style = u6.STYLES.normal;
    local v189 = artPart(v180.style.art);

    if v189 then
        local v190 = CFrame.new(0, 0, -0.012) * CFrame_fromMatrix_ret;
        v189.Anchored = true;
        v189.CanCollide = false;
        v189.CanTouch = false;
        v189.CanQuery = false;
        v189.CastShadow = false;
        v189.Parent = v180.model;
        local v191 = {
            part = v189,
            offset = v190,
            size = v189.Size
        };
        table.insert(v180.layers, v191);
        v180.scale = nil;
        v180.art = v191;
        v180.reverse = -0.012 + v189.Size.X / 2 + 0.003;
    else
        v180.plain = true;
        local v192 = plainPart(p178, Color3_fromRGB_ret, true);
        local CFrame_new_ret = CFrame.new(0, 0, -0.012);
        v192.Anchored = true;
        v192.CanCollide = false;
        v192.CanTouch = false;
        v192.CanQuery = false;
        v192.CastShadow = false;
        v192.Parent = v180.model;
        table.insert(v180.layers, {
            part = v192,
            offset = CFrame_new_ret,
            size = v192.Size
        });
        v180.scale = nil;
        v180.reverse = 0.025;
    end;

    if v180.plain and not v180.face then
        local v193 = plainPart(p178, v180.style.glow, false);
        local v194 = CFrame.new(0, 0, 0.012) * CFrame_Angles_ret;
        v193.Anchored = true;
        v193.CanCollide = false;
        v193.CanTouch = false;
        v193.CanQuery = false;
        v193.CastShadow = false;
        v193.Parent = v180.model;
        local v195 = {
            part = v193,
            offset = v194,
            size = v193.Size
        };
        table.insert(v180.layers, v195);
        v180.scale = nil;
        v180.face = v195;
    end;

    return v180;
end;

local function turnGold(p196) -- Line: 726
    -- upvalues: u6 (copy), artPart (copy), CFrame_fromMatrix_ret (copy), place (copy)
    if p196.gold then
        return;
    end;

    p196.gold = true;
    p196.style = u6.STYLES.gold;
    local v197 = p196.art and artPart(p196.style.art);

    if v197 then
        local scale = p196.scale;
        local art = p196.art;

        if art then
            local table_find_ret = table.find(p196.layers, art);

            if table_find_ret then
                table.remove(p196.layers, table_find_ret);
            end;

            art.part:Destroy();
        end;

        local v198 = CFrame.new(0, 0, -0.012) * CFrame_fromMatrix_ret;
        v197.Anchored = true;
        v197.CanCollide = false;
        v197.CanTouch = false;
        v197.CanQuery = false;
        v197.CastShadow = false;
        v197.Parent = p196.model;
        local v199 = {
            part = v197,
            offset = v198,
            size = v197.Size
        };
        table.insert(p196.layers, v199);
        p196.scale = nil;
        p196.art = v199;

        if p196.frame and scale then
            place(p196, p196.frame, scale);
        end;
    end;

    for _, v in p196.glowImages do
        v.ImageColor3 = p196.style.glow;
    end;
end;

local function cardFx(p200) -- Line: 752
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy)
    if p200.fx then
        return p200.fx;
    end;

    local hit = p200.hit;
    local v201 = {
        Brightness = 0,
        Range = 7,
        Shadows = false,
        Color = Color3_fromRGB_ret
    };
    local PointLight = Instance.new("PointLight");
    PointLight.Name = "Flash";
    local v202 = {};

    for i, v in v201 or {} do
        PointLight[i] = v;
    end;

    PointLight.Parent = hit;
    v202.light = PointLight;
    local hit2 = p200.hit;
    local v203 = {
        Texture = "rbxasset://textures/particles/sparkles_main.dds",
        LightEmission = 1,
        LightInfluence = 0,
        Drag = 4,
        LockedToPart = true,
        Enabled = false,
        Color = ColorSequence.new(Color3_fromRGB_ret, Color3_fromRGB_ret3),
        Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0) }),
        Lifetime = NumberRange.new(0.4, 0.9),
        Speed = NumberRange.new(4, 10),
        SpreadAngle = Vector2.new(180, 180)
    };
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Name = "Sparks";

    for i, v in v203 or {} do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = hit2;
    v202.sparks = ParticleEmitter;
    local hit3 = p200.hit;
    local v204 = {
        Texture = "rbxasset://textures/particles/smoke_main.dds",
        LightEmission = 0.8,
        LightInfluence = 0,
        Acceleration = Vector3.new(0, 1.8, 0),
        LockedToPart = true,
        Rate = 0,
        Enabled = false,
        Color = ColorSequence.new(Color3_fromRGB_ret),
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.25, 0.45), NumberSequenceKeypoint.new(1, 1) }),
        Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0.9) }),
        Lifetime = NumberRange.new(0.6, 1.1),
        Speed = NumberRange.new(0.4, 1.4),
        Rotation = NumberRange.new(0, 360),
        RotSpeed = NumberRange.new(-70, 70),
        SpreadAngle = Vector2.new(70, 70)
    };
    local ParticleEmitter2 = Instance.new("ParticleEmitter");
    ParticleEmitter2.Name = "Wisps";

    for i, v in v204 or {} do
        ParticleEmitter2[i] = v;
    end;

    ParticleEmitter2.Parent = hit3;
    v202.wisps = ParticleEmitter2;
    p200.fx = v202;

    return v202;
end;

local function follow(u205, p206) -- Line: 796
    local u207 = u205.view:ToObjectSpace(p206);

    return function() -- Line: 798
        -- upvalues: u205 (copy), u207 (copy)
        return u205.view * u207;
    end;
end;

local function shockwave(u208, p209, u210, u211, u212, u213) -- Line: 804
    -- upvalues: surface (copy)
    local u214 = u208.view:ToObjectSpace(p209);

    local function u215() -- Line: 798
        -- upvalues: u208 (copy), u214 (copy)
        return u208.view * u214;
    end;

    local folder = u208.folder;
    local Part = Instance.new("Part");
    Part.Name = "Shockwave";

    for i, v in {
        Size = Vector3.new(0.3, 0.3, 0.02),
        Transparency = 1,
        CFrame = p209
    } or {} do
        Part[i] = v;
    end;

    Part.Parent = folder;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    local u216 = surface(u208, Part, Enum.NormalId.Front, "Shockwave");
    u216.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
    u216.CanvasSize = Vector2.new(256, 256);
    u216.Brightness = 3;
    u216.ClipsDescendants = false;

    local function ring(p217, p218) -- Line: 812
        -- upvalues: u216 (copy), u210 (copy), u213 (copy)
        local v219 = {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(p218, p218)
        };
        local Frame = Instance.new("Frame");
        Frame.Name = p217;

        for i, v in v219 or {} do
            Frame[i] = v;
        end;

        Frame.Parent = u216;
        local v220 = {
            CornerRadius = UDim.new(0.5, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i, v in v220 or {} do
            UICorner[i] = v;
        end;

        UICorner.Parent = Frame;
        local v221 = {
            Color = u210,
            Thickness = u213
        };
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Name = "Edge";

        for i, v in v221 or {} do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = Frame;

        return UIStroke;
    end;

    local u222 = ring("Ring", 0.86);
    local u223 = ring("Inner", 0.62);
    u223.Color = u210:Lerp(Color3.new(1, 1, 1), 0.5);
    local os_clock_ret = os.clock();
    table.insert(u208.anims, function(p224) -- Line: 825
        -- upvalues: os_clock_ret (copy), u212 (copy), Part (copy), u211 (copy), u215 (copy), u222 (copy), u213 (copy), u223 (copy)
        local v225 = (p224 - os_clock_ret) / u212;

        if v225 >= 1 or not Part.Parent then
            Part:Destroy();

            return true;
        end;

        local math_max_ret = math.max(v225, 0);
        local v226 = 0.3 + (u211 - 0.3) * (1 - (1 - math_max_ret) ^ 3);
        Part.Size = Vector3.new(v226, v226, 0.02);
        Part.CFrame = u215();
        u222.Thickness = u213 * (1 - math_max_ret * 0.8) + 2;
        u222.Transparency = math_max_ret ^ 1.6;
        u223.Thickness = u213 * 0.4 * (1 - math_max_ret) + 1;
        u223.Transparency = math.min(1, math_max_ret * 1.4);

        return false;
    end);
end;

local function pillar(u227, u228, u229) -- Line: 844
    -- upvalues: u4 (copy), u2 (copy)
    local folder = u227.folder;
    local Part = Instance.new("Part");
    Part.Name = "Pillar";

    for i, v in {
        Size = Vector3.new(0.1, 0.1, 0.1),
        Transparency = 1
    } or {} do
        Part[i] = v;
    end;

    Part.Parent = folder;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "Low";

    for i, v in {} do
        Attachment[i] = v;
    end;

    Attachment.Parent = Part;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Name = "High";

    for i, v in {} do
        Attachment2[i] = v;
    end;

    Attachment2.Parent = Part;

    local function beam(p230, p231, p232, p233, p234) -- Line: 848
        -- upvalues: Part (copy), Attachment (copy), Attachment2 (copy), u4 (ref)
        local v235 = {
            LightEmission = 1,
            LightInfluence = 0,
            FaceCamera = true,
            Segments = 10,
            Attachment0 = Attachment,
            Attachment1 = Attachment2,
            Color = u4.SHIMMER,
            Texture = p233,
            TextureMode = Enum.TextureMode.Static,
            TextureLength = p231 * 1.2,
            TextureSpeed = p232,
            Width0 = p231,
            Width1 = p231 * 0.7,
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.12, p234),
                NumberSequenceKeypoint.new(0.8, p234),
                NumberSequenceKeypoint.new(1, 1)
            })
        };
        local Beam = Instance.new("Beam");
        Beam.Name = p230;

        for i, v in v235 or {} do
            Beam[i] = v;
        end;

        Beam.Parent = Part;

        return Beam;
    end;

    local u236 = { beam("Sparkles", u2.MYTHIC_PILLAR, 1.6, "rbxasset://textures/particles/sparkles_main.dds", 0), (beam("Mist", u2.MYTHIC_PILLAR * 1.5, 0.6, "rbxasset://textures/particles/smoke_main.dds", 0.35)) };
    local os_clock_ret = os.clock();
    table.insert(u227.anims, function(p237) -- Line: 876
        -- upvalues: os_clock_ret (copy), u229 (copy), u228 (copy), Part (copy), u227 (copy), Attachment (copy), Attachment2 (copy), u236 (copy), u2 (ref)
        local v238 = (p237 - os_clock_ret) / u229;

        if v238 >= 1 or not u228.model.Parent then
            Part:Destroy();

            return true;
        end;

        local math_max_ret = math.max(v238, 0);
        local v239 = u228.scale or 1;
        local view = u227.view;
        local v240 = (u228.frame or view).Position + view.LookVector * (0.15 * v239);
        Part.CFrame = CFrame.lookAt(v240, v240 + view.LookVector, view.UpVector);
        Attachment.Position = Vector3.new(0, -2 * v239, 0);
        Attachment2.Position = Vector3.new(0, 2.75 * v239, 0);
        local math_min_ret = math.min(1, math_max_ret * 8);
        local math_clamp_ret = math.clamp((math_max_ret - 0.7) / 0.3, 0, 1);
        local math_max_ret2 = math.max(math_clamp_ret, u227.fade);

        for i, v in u236 do
            local v241 = u2.MYTHIC_PILLAR * (i == 1 and 1 or 1.5) * u227.layout.scale * math_min_ret * (1 - math_max_ret2 * 0.8);
            v.Width0 = v241;
            v.Width1 = v241 * 0.7;
        end;

        u236[1].Brightness = (1 - math_max_ret2) * 2;

        return false;
    end);
end;

local function nudge(p242, p243, p244) -- Line: 900
    p242.nudge = {
        start = os.clock(),
        amount = p243,
        seconds = p244
    };
end;

local function screenPulse(p245, p246, p247, p248) -- Line: 904
    -- upvalues: u2 (copy)
    local os_clock_ret = os.clock();
    p245.screenFlash = {
        start = os_clock_ret,
        color = p246,
        peak = p247,
        seconds = u2.SCREEN_FLASH_SECONDS
    };
    p245.vignettePulse = {
        start = os_clock_ret,
        amount = p248,
        seconds = u2.VIGNETTE_SECONDS
    };
end;

local function afterimage(u249, p250, p251) -- Line: 910
    -- upvalues: u2 (copy)
    local frame = p250.frame;
    local v252 = p250.scale or 1;

    if not frame then
        return;
    end;

    local u253 = u249.view:ToObjectSpace(frame);

    local function u254() -- Line: 798
        -- upvalues: u249 (copy), u253 (copy)
        return u249.view * u253;
    end;

    local v255 = Vector3.new(0.74394464, 1.25, 0.02);
    local folder = u249.folder;
    local v256 = {
        Transparency = 0.35,
        Size = Vector3.new(v255.X * v252, v255.Y * v252, 0.01),
        Material = Enum.Material.Neon,
        Color = p251,
        CFrame = frame
    };
    local Part = Instance.new("Part");
    Part.Name = "Afterimage";

    for i, v in v256 or {} do
        Part[i] = v;
    end;

    Part.Parent = folder;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    local os_clock_ret = os.clock();
    table.insert(u249.anims, function(p257) -- Line: 925
        -- upvalues: os_clock_ret (copy), u2 (ref), Part (copy), u254 (copy)
        local v258 = (p257 - os_clock_ret) / u2.AFTERIMAGE_SECONDS;

        if v258 >= 1 or not Part.Parent then
            Part:Destroy();

            return true;
        end;

        Part.CFrame = u254();
        Part.Transparency = math.max(v258, 0) * 0.65 + 0.35;

        return false;
    end);
end;

local function uiLabel(p259, p260, p261, p262) -- Line: 938
    -- upvalues: Font_new_ret (copy), Color3_fromRGB_ret3 (copy)
    local v263 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        Text = "",
        FontFace = Font_new_ret,
        TextColor3 = Color3_fromRGB_ret3
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p260;

    for i, v in v263 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p259;

    for i, v in p261 or {} do
        TextLabel[i] = v;
    end;

    local v264 = {
        Color = Color3.new(0, 0, 0),
        Thickness = p262 or 0.1,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";

    for i, v in v264 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    return TextLabel;
end;

local function plate(u265, p266, p267, u268) -- Line: 959
    -- upvalues: Color3_fromRGB_ret2 (copy), u2 (copy)
    local uiRoot = u265.uiRoot;
    local v269 = {
        BackgroundTransparency = 1,
        GroupTransparency = 1,
        ZIndex = 8,
        AnchorPoint = Vector2.new(0.5, 0.5)
    };
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = p266;

    for i, v in v269 or {} do
        CanvasGroup[i] = v;
    end;

    CanvasGroup.Parent = uiRoot;
    local v270 = {
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.97, 0.9),
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Plate";

    for i, v in v270 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = CanvasGroup;
    local v271 = {
        CornerRadius = UDim.new(0.22, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v271 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v272 = {
        Thickness = 0.04,
        Color = p267,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Ring";

    for i, v in v272 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local os_clock_ret = os.clock();
    local u273 = nil;
    table.insert(u265.anims, function(p274) -- Line: 977
        -- upvalues: CanvasGroup (copy), os_clock_ret (copy), u2 (ref), u268 (copy), u265 (copy), u273 (ref)
        if not CanvasGroup.Parent then
            return true;
        end;

        local math_clamp_ret = math.clamp((p274 - os_clock_ret) / u2.SLAM_SECONDS, 0, 1);
        local math_clamp_ret2 = math.clamp(math_clamp_ret, 0, 1);
        local v275 = 1.7 - 0.7 * (1 + 2.2 * (math_clamp_ret2 - 1) ^ 3 + 1.2 * (math_clamp_ret2 - 1) ^ 2);
        local v276, v277, v278, v279 = u268();
        CanvasGroup.Position = UDim2.fromScale(v276, v277);
        CanvasGroup.Size = UDim2.fromScale(v278 * v275, v279 * v275);
        local v280 = math.max(1 - math_clamp_ret * 1.6, 0) + u265.fade;
        CanvasGroup.GroupTransparency = math.min(1, v280);

        if u273 then
            u273(v276, v277, v278 * v275, v279 * v275, CanvasGroup.GroupTransparency);
        end;

        return false;
    end);

    return Frame, function(p281) -- Line: 992
        -- upvalues: u273 (ref)
        u273 = p281;
    end;
end;

local function banner(u282, u283, p284) -- Line: 997
    -- upvalues: plate (copy), rarityColor (copy), uiLabel (copy)
    local v285 = plate(u282, "Banner" .. u283.slot, rarityColor(p284.rarity), function() -- Line: 998
        -- upvalues: u282 (copy), u283 (copy)
        local layout = u282.layout;

        return layout.xs[u283.slot] or 0.5, layout.bannerY, layout.bannerW, layout.bannerH;
    end);
    uiLabel(v285, "Rarity", {
        Position = UDim2.fromScale(0.05, 0.08),
        Size = UDim2.fromScale(0.9, 0.3),
        Text = string.upper(p284.rarity),
        TextColor3 = rarityColor(p284.rarity)
    }, 0.1);
    uiLabel(v285, "Name", {
        Position = UDim2.fromScale(0.04, 0.4),
        Size = UDim2.fromScale(0.92, 0.5),
        Text = string.upper(p284.name) .. (not p284.duplicateGems and "" or "  +" .. p284.duplicateGems .. " GEMS")
    }, 0.1);
end;

local function impact(p286, p287) -- Line: 1010
    -- upvalues: cardFx (copy), u2 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy), shockwave (copy), screenPulse (copy)
    local v288 = cardFx(p287);
    local os_clock_ret = os.clock();
    p287.punch = {
        start = os_clock_ret,
        amount = u2.IMPACT_PUNCH,
        seconds = u2.IMPACT_PUNCH_SECONDS
    };
    p287.flash = {
        start = os_clock_ret,
        peak = u2.IMPACT_FLASH,
        seconds = u2.IMPACT_FLASH_SECONDS
    };
    v288.light.Color = Color3_fromRGB_ret;
    v288.sparks.Color = ColorSequence.new(Color3_fromRGB_ret, Color3_fromRGB_ret3);
    v288.wisps.Color = ColorSequence.new(Color3_fromRGB_ret);
    v288.sparks:Emit(u2.IMPACT_SPARKS);
    v288.wisps:Emit(u2.IMPACT_WISPS);
    local Position = ((p287.frame or p286.view) * CFrame.new(0, -0.22499999999999998 * (p287.scale or 1), 0)).Position;
    shockwave(p286, CFrame.lookAt(Position, Position - p286.view.LookVector, p286.view.UpVector), Color3_fromRGB_ret, u2.IMPACT_RING * p286.layout.scale, u2.IMPACT_RING_SECONDS, u2.IMPACT_RING_THICKNESS);
    screenPulse(p286, Color3_fromRGB_ret, u2.SCREEN_FLASH * u2.IMPACT_SCREEN, u2.VIGNETTE);
    local NUDGE = u2.NUDGE;
    local NUDGE_SECONDS = u2.NUDGE_SECONDS;
    p286.nudge = {
        start = os.clock(),
        amount = NUDGE,
        seconds = NUDGE_SECONDS
    };
end;

local function tellShow(p289, p290, p291) -- Line: 1029
    -- upvalues: u7 (copy), turnGold (copy), cardFx (copy), Color3_fromRGB_ret3 (copy), u2 (copy), screenPulse (copy), u61 (copy)
    if p291 then
        p291 = p291.rarity;
    end;

    if (u7[p291] or 6) > u7.Legendary then
        return nil;
    end;

    turnGold(p290);
    local glow = p290.style.glow;
    local os_clock_ret = os.clock();
    p290.tell = glow;

    for _, v in p290.glowImages do
        v.ImageColor3 = glow;
    end;

    local v292 = cardFx(p290);
    v292.light.Color = glow;
    v292.wisps.Color = ColorSequence.new(glow);
    v292.sparks.Color = ColorSequence.new(glow, Color3_fromRGB_ret3);
    v292.sparks:Emit(u2.TELL_SPARKS);
    p290.flash = {
        start = os_clock_ret,
        peak = u2.TELL_FLASH,
        seconds = u2.IMPACT_FLASH_SECONDS
    };
    p290.punch = {
        start = os_clock_ret,
        amount = u2.TELL_PUNCH,
        seconds = u2.IMPACT_PUNCH_SECONDS
    };
    screenPulse(p289, glow, u2.SCREEN_FLASH * 0.6, u2.VIGNETTE * 0.5);
    local NUDGE = u2.NUDGE;
    local NUDGE_SECONDS = u2.NUDGE_SECONDS;
    p289.nudge = {
        start = os.clock(),
        amount = NUDGE,
        seconds = NUDGE_SECONDS
    };
    u61.play(p289, "Reveal", 1.25);

    return {
        endAt = os_clock_ret + u2.TELL_SECONDS * p289.pace
    };
end;

local function reveal(u293, u294, p295) -- Line: 1053
    -- upvalues: rarityColor (copy), u7 (copy), cardFx (copy), u2 (copy), u6 (copy), u4 (copy), Color3_fromRGB_ret3 (copy), shockwave (copy), u10 (ref), pillar (copy), screenPulse (copy), banner (copy)
    local rarity = p295.rarity;
    local v296 = rarityColor(rarity);
    local v297 = rarity == "Mythical";
    local v298;

    if p295 then
        v298 = p295.rarity;
    else
        v298 = p295;
    end;

    local v299 = (u7[v298] or 6) <= u7.Legendary;
    local v300 = cardFx(u294);
    local os_clock_ret = os.clock();
    local scale = u293.layout.scale;
    u294.punch = {
        start = os_clock_ret,
        amount = u2.REVEAL_PUNCH * (v297 and 1.3 or 1),
        seconds = u2.REVEAL_PUNCH_SECONDS
    };
    u294.flash = {
        start = os_clock_ret,
        peak = u2.REVEAL_FLASH * (v297 and 1.4 or 1),
        seconds = u2.REVEAL_FLASH_SECONDS
    };
    local v301 = u6.RARITY[rarity];
    local v302 = v301 and v301.glow or u294.style.glow;
    u294.lingering = v302;

    for _, v in u294.glowImages do
        v.ImageColor3 = v302;

        if v297 and (v.Parent and v.Parent:IsA("SurfaceGui")) then
            v.Parent.Brightness = u2.MYTHIC_GLOW[2];
        end;
    end;

    local v303;

    if v297 then
        v303 = u2.MYTHIC_GLOW[1];
    else
        v303 = nil;
    end;

    u294.glowFull = v303;
    v300.light.Color = v302;
    v300.wisps.Color = ColorSequence.new(v302);
    local Position = (u294.frame or u293.view).Position;
    local v304 = u293.view.Position - Position;
    local v305 = -u293.view.LookVector;

    if v304.Magnitude > 0.0001 then
        v305 = v304.Unit;
    end;

    local v306 = Position + v305 * (0.1 * scale);
    local CFrame_lookAt_ret = CFrame.lookAt(v306, v306 - u293.view.LookVector, u293.view.UpVector);

    if v297 then
        local v307 = {
            u4.DEEP,
            u4.RED,
            u4.HOT,
            u4.RED,
            u4.DEEP,
            u4.HOT
        };

        for i = 1, 6 do
            v300.sparks.Color = ColorSequence.new(v307[i], Color3_fromRGB_ret3);
            v300.sparks:Emit((math.ceil(u2.BURST.Mythical / 6)));
            v300.wisps.Color = ColorSequence.new(v307[i]);
            v300.wisps:Emit(4);
            local _ = i;
        end;

        v300.wisps.Color = ColorSequence.new(v302);
        shockwave(u293, CFrame_lookAt_ret, u4.RED, u2.REVEAL_RING * scale, u2.REVEAL_RING_SECONDS, u2.REVEAL_RING_THICKNESS);

        for i, v in { u4.HOT, u4.DEEP } do
            task.delay(i * 0.14, function() -- Line: 1091
                -- upvalues: u293 (copy), u10 (ref), u294 (copy), shockwave (ref), CFrame_lookAt_ret (copy), v (copy), u2 (ref), i (copy), scale (copy)
                local v308 = u293;
                local v309;

                if u10 == v308 then
                    v309 = not v308.done and not v308.outroFrom;
                else
                    v309 = false;
                end;

                if v309 and u294.model.Parent then
                    shockwave(u293, CFrame_lookAt_ret, v, u2.REVEAL_RING * u2.MYTHIC_RINGS[i] * scale, u2.REVEAL_RING_SECONDS * 1.5, u2.REVEAL_RING_THICKNESS);
                end;
            end);
        end;

        pillar(u293, u294, u2.MYTHIC_HOLD);
        u293.wash = {
            start = os_clock_ret,
            seconds = u2.MYTHIC_HOLD
        };
    else
        v300.sparks.Color = ColorSequence.new(v296, Color3_fromRGB_ret3);
        v300.sparks:Emit(u2.BURST[rarity] or u2.BURST.Common);
        v300.wisps:Emit(v299 and 16 or 10);
        shockwave(u293, CFrame_lookAt_ret, v296, u2.REVEAL_RING * scale, u2.REVEAL_RING_SECONDS, u2.REVEAL_RING_THICKNESS);
    end;

    screenPulse(u293, v296, u2.SCREEN_FLASH * (v297 and 1.3 or 0.9), u2.VIGNETTE * 0.8);
    local v310 = u2.NUDGE * (v297 and 2.2 or (v299 and 1.6 or 1.3));
    local v311 = u2.NUDGE_SECONDS * (v297 and 1.8 or 1.2);
    u293.nudge = {
        start = os.clock(),
        amount = v310,
        seconds = v311
    };
    banner(u293, u294, p295);
end;

local function kingslayer(u312, p313) -- Line: 1111
    -- upvalues: u4 (copy), rarityColor (copy), plate (copy), uiLabel (copy), Color3_fromRGB_ret4 (copy), u2 (copy), screenPulse (copy)
    local v314;

    if p313.rarity == "Mythical" then
        v314 = u4.RED;
    else
        v314 = rarityColor(p313.rarity);
    end;

    local uiRoot = u312.uiRoot;
    local v315 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://129028976496842",
        ImageTransparency = 1,
        ZIndex = 7,
        AnchorPoint = Vector2.new(0.5, 0.5),
        ImageColor3 = v314
    };
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "KingslayerGlow";

    for i, v in v315 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = uiRoot;
    local v316, v317 = plate(u312, "Kingslayer", v314, function() -- Line: 1121
        -- upvalues: u312 (copy)
        local layout = u312.layout;

        return 0.5, layout.kingY, layout.kingW, layout.kingH;
    end);
    v317(function(p318, p319, p320, p321, p322) -- Line: 1125
        -- upvalues: ImageLabel (copy)
        ImageLabel.Position = UDim2.fromScale(p318, p319);
        ImageLabel.Size = UDim2.fromScale(p320 * 1.5, p321 * 2.4);
        ImageLabel.ImageTransparency = 1 - 0.6 * (1 - p322);
    end);
    local string_upper_ret = string.upper((string.gsub(p313.name, "%s+[Tt]itle$", "")));
    uiLabel(v316, "Top", {
        Text = "TOP 3 DAMAGE",
        Position = UDim2.fromScale(0.05, 0.07),
        Size = UDim2.fromScale(0.9, 0.22),
        TextColor3 = v314
    }, 0.1);
    local v323 = uiLabel(v316, "Name", {
        Position = UDim2.fromScale(0.04, 0.29),
        Size = UDim2.fromScale(0.92, 0.44),
        Text = string_upper_ret
    }, 0.1);

    if p313.rarity == "Mythical" then
        local v324 = {
            Color = u4.SHIMMER
        };
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Name = "Shimmer";

        for i, v in v324 or {} do
            UIGradient[i] = v;
        end;

        UIGradient.Parent = v323;
    end;

    uiLabel(v316, "Under", {
        Position = UDim2.fromScale(0.1, 0.74),
        Size = UDim2.fromScale(0.8, 0.18),
        Text = not p313.duplicateGems and "NEW TITLE" or "ALREADY OWNED  +" .. p313.duplicateGems .. " GEMS",
        TextColor3 = Color3_fromRGB_ret4
    }, 0.1);
    local os_clock_ret = os.clock();

    for _, v in u312.cards do
        v.punch = {
            amount = 0.08,
            start = os_clock_ret,
            seconds = u2.IMPACT_PUNCH_SECONDS
        };
    end;

    screenPulse(u312, v314, u2.SCREEN_FLASH * 0.9, u2.VIGNETTE * 0.8);
    local v325 = u2.NUDGE * 1.6;
    local v326 = u2.NUDGE_SECONDS * 1.2;
    u312.nudge = {
        start = os.clock(),
        amount = v325,
        seconds = v326
    };
end;

local function buildOverlay(u327, p328) -- Line: 1155
    -- upvalues: Color3_fromRGB_ret3 (copy), u4 (copy), Font_fromEnum_ret (copy), Font_fromEnum_ret2 (copy), Color3_fromRGB_ret4 (copy), rarityColor (copy)
    local v329 = {
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 66,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "FallenKingSpoilsUI";

    for i, v in v329 or {} do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = nil;
    ScreenGui:SetAttribute("CreatorCaptureExempt", true);
    ScreenGui:SetAttribute("SelfManagedText", true);
    local u330 = {
        gui = ScreenGui,
        edges = {},
        words = {}
    };

    for _, v in {
        {
            "Top",
            UDim2.fromScale(1, 0.32),
            UDim2.fromScale(0, 0),
            90
        },
        {
            "Bottom",
            UDim2.fromScale(1, 0.32),
            UDim2.fromScale(0, 0.68),
            270
        },
        {
            "Left",
            UDim2.fromScale(0.24, 1),
            UDim2.fromScale(0, 0),
            0
        },
        {
            "Right",
            UDim2.fromScale(0.24, 1),
            UDim2.fromScale(0.76, 0),
            180
        }
    } do
        local v331 = v[1];
        local v332 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = v[2],
            Position = v[3],
            BackgroundColor3 = Color3.new(0, 0, 0)
        };
        local Frame = Instance.new("Frame");
        Frame.Name = v331;

        for i, v2 in v332 or {} do
            Frame[i] = v2;
        end;

        Frame.Parent = ScreenGui;
        local v333 = {
            Rotation = v[4],
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
        };
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Name = "Fade";

        for i, v2 in v333 or {} do
            UIGradient[i] = v2;
        end;

        UIGradient.Parent = Frame;
        table.insert(u330.edges, Frame);
    end;

    local v334 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_fromRGB_ret3
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Wash";

    for i, v in v334 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    u330.wash = Frame;
    local wash = u330.wash;
    local v335 = {
        Color = u4.SHIMMER
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "Shimmer";

    for i, v in v335 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = wash;
    u330.washGradient = UIGradient;
    local v336 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_fromRGB_ret3
    };
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Flash";

    for i, v in v336 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = ScreenGui;
    u330.flash = Frame2;

    local function words(p337, p338, p339, p340, p341, p342, p343, p344, p345) -- Line: 1189
        -- upvalues: ScreenGui (copy), Font_fromEnum_ret (ref), u330 (copy)
        local v346 = {
            BackgroundTransparency = 1,
            TextTransparency = 1,
            TextScaled = true,
            ZIndex = 20,
            AnchorPoint = Vector2.new(0.5, 1),
            Position = UDim2.fromScale(0.5, p341),
            Size = UDim2.fromScale(p342, p343),
            FontFace = p339,
            Text = p338,
            TextColor3 = p340
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = p337;

        for i, v in v346 or {} do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = ScreenGui;
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
        UITextSizeConstraint.Name = "Limit";

        for i, v in {
            MinTextSize = p344,
            MaxTextSize = p345
        } or {} do
            UITextSizeConstraint[i] = v;
        end;

        UITextSizeConstraint.Parent = TextLabel;
        local v347 = {
            Color = Color3.new(0, 0, 0),
            Thickness = p339 == Font_fromEnum_ret and 2.5 or 2,
            LineJoinMode = Enum.LineJoinMode.Round
        };
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Name = "TextStroke";

        for i, v in v347 or {} do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = TextLabel;
        UIStroke.Transparency = 1;
        table.insert(u330.words, {
            label = TextLabel,
            edge = UIStroke
        });
    end;

    words("Title", "THE KING\'S SPOILS", Font_fromEnum_ret, Color3_fromRGB_ret3, 0.925, 0.8, 0.065, 16, 44);
    words("Line", "Your rewards are already saved", Font_fromEnum_ret2, Color3_fromRGB_ret4, 0.968, 0.8, 0.035, 12, 22);

    if u327.data.top then
        words("Top", "TOP 10 DAMAGE · BETTER ODDS", Font_fromEnum_ret2, rarityColor("Legendary"), 0.858, 0.7, 0.03, 11, 20);
    end;

    for _, descendant in ScreenGui:GetDescendants() do
        if descendant:IsA("GuiObject") then
            descendant.Active = false;
            pcall(function() -- Line: 1216
                -- upvalues: descendant (copy)
                descendant.Interactable = false;
            end);
        end;
    end;

    local v348 = {
        BackgroundTransparency = 1,
        ZIndex = 10,
        Active = false,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "UI";

    for i, v in v348 or {} do
        Frame3[i] = v;
    end;

    Frame3.Parent = ScreenGui;
    u327.uiRoot = Frame3;
    pcall(function() -- Line: 1223
        -- upvalues: u327 (copy)
        u327.uiRoot.Interactable = false;
    end);
    ScreenGui.Parent = p328;
    table.insert(u327.guis, ScreenGui);
    u327.overlay = u330;
end;

local function stepOverlay(p349, p350) -- Line: 1231
    -- upvalues: u2 (copy), u1 (copy)
    local overlay = p349.overlay;

    if not overlay then
        return;
    end;

    local screenFlash = p349.screenFlash;
    local v351 = 0;

    if screenFlash then
        local v352 = (p350 - screenFlash.start) / screenFlash.seconds;

        if v352 >= 1 then
            p349.screenFlash = nil;
        else
            v351 = screenFlash.peak * (1 - math.max(v352, 0)) ^ 2;
            overlay.flash.BackgroundColor3 = screenFlash.color:Lerp(Color3.new(1, 1, 1), 0.35);
        end;
    end;

    overlay.flash.BackgroundTransparency = 1 - v351;
    local v353 = math.clamp((p350 - p349.openedAt) / u2.ENTER, 0, 1) * (1 - p349.fade);
    local v354 = 0;
    local vignettePulse = p349.vignettePulse;

    if vignettePulse then
        local v355 = (p350 - vignettePulse.start) / vignettePulse.seconds;

        if v355 >= 1 then
            p349.vignettePulse = nil;
        else
            v354 = vignettePulse.amount * (1 - math.max(v355, 0)) ^ 2;
        end;
    end;

    for _, v in overlay.edges do
        v.BackgroundTransparency = 1 - math.min(0.95, v354 + (v.Name ~= "Bottom" and 0 or u1.GLOOM * v353));
    end;

    local wash = p349.wash;
    local v356 = 0;

    if wash then
        local v357 = (p350 - wash.start) / wash.seconds;

        if v357 >= 1 then
            p349.wash = nil;
        else
            v356 = u2.MYTHIC_WASH * math.min(1, v357 * 6) * (1 - math.clamp((v357 - 0.75) / 0.25, 0, 1)) * (1 - p349.fade);
            overlay.washGradient.Rotation = p350 * 60 % 360;
        end;
    end;

    overlay.wash.BackgroundTransparency = 1 - v356;
    local v358 = math.clamp((p350 - p349.openedAt - 0.25) / 0.4, 0, 1) * (1 - p349.fade);

    for _, v in overlay.words do
        v.label.TextTransparency = 1 - v358;
        v.edge.Transparency = 1 - v358 * 0.8;
    end;
end;

local function cursorOn(p359, p360, p361) -- Line: 1287
    local cursor = p359.cursor;
    local frame = p360.frame;
    local v362 = cursor.Direction:Dot(frame.LookVector);

    if math.abs(v362) < 0.0001 then
        return Vector2.zero, false;
    end;

    local v363 = (frame.Position - cursor.Origin):Dot(frame.LookVector) / v362;
    local v364 = cursor.Origin + cursor.Direction * v363 - frame.Position;
    local v365 = Vector3.new(0.74394464, 1.25, 0.02) * (p360.scale or 1);
    local v366 = v364:Dot(p359.view.RightVector) / (v365.X / 2);
    local v367 = v364:Dot(p359.view.UpVector) / (v365.Y / 2);
    local v368;

    if v363 > 0 and math.abs(v366) <= (p361 or 1) then
        v368 = math.abs(v367) <= (p361 or 1);
    else
        v368 = false;
    end;

    return Vector2.new(math.clamp(v366, -1, 1), (math.clamp(v367, -1, 1))), v368;
end;

local function buildLevel(p369, p370) -- Line: 1301
    local show = p369.show;

    return not (show and (show.buildFrom and not show.flipFrom)) and 0 or math.clamp((p370 - show.buildFrom) / show.buildFor, 0, 1);
end;

local function cardPose(p371, p372, p373) -- Line: 1311
    -- upvalues: u2 (copy), cursorOn (copy), place (copy), afterimage (copy), Color3_fromRGB_ret (copy)
    local layout = p371.layout;
    local view = p371.view;
    local slot = p372.slot;
    local scale = layout.scale;
    local tanY = p371.tanY;
    local depth = layout.depth;
    local v374 = view.Position + view:VectorToWorldSpace((Vector3.new((layout.xs[slot] * 2 - 1) * tanY * p371.aspect, (1 - layout.y * 2) * tanY, -1))) * depth + view.UpVector * (math.sin(p373 * u2.BOB_SPEED + slot) * u2.BOB * scale);
    local CFrame_lookAt_ret = CFrame.lookAt(v374, v374 - view.LookVector, view.UpVector);
    local math_clamp_ret = math.clamp((p373 - p371.openedAt - (slot - 1) * u2.STAGGER) / u2.ENTER, 0, 1);
    local math_clamp_ret2 = math.clamp(math_clamp_ret, 0, 1);
    local v375 = math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2) * (1 - p371.fade);
    p372.shown = v375;

    if v375 < 1 then
        CFrame_lookAt_ret = CFrame_lookAt_ret - view.UpVector * ((1 - v375) * layout.drop);
        scale = scale * (0.12 + 0.88 * v375);
    end;

    if math_clamp_ret < 1 then
        local CFrame_Angles = CFrame.Angles;
        local math_clamp_ret3 = math.clamp(math_clamp_ret, 0, 1);
        CFrame_lookAt_ret = CFrame_lookAt_ret * CFrame_Angles(0, (1 - (1 + 2.2 * (math_clamp_ret3 - 1) ^ 3 + 1.2 * (math_clamp_ret3 - 1) ^ 2)) * 3.141592653589793 / 2 * (slot <= #p371.cards / 2 and -1 or 1), 0);
    end;

    local punch = p372.punch;

    if punch then
        local v376 = (p373 - punch.start) / punch.seconds;

        if v376 >= 1 then
            p372.punch = nil;
        elseif v376 >= 0 then
            local amount = punch.amount;
            local v377 = math.min(1, v376 * 4) * 3.141592653589793 / 2;
            local v378 = amount * math.sin(v377) * math.exp(-4 * v376);
            local v379 = math.max(0, v376 - 0.25) * 11;
            scale = scale * (1 + v378 * math.cos(v379));
        end;
    end;

    local show = p372.show;
    local v380 = not (show and (show.buildFrom and not show.flipFrom)) and 0 or math.clamp((p373 - show.buildFrom) / show.buildFor, 0, 1);

    if v380 > 0 then
        local v381 = (u2.BUILD_SHAKE[1] + (u2.BUILD_SHAKE[2] - u2.BUILD_SHAKE[1]) * v380 ^ 1.5) * layout.scale;
        local v382 = 30 + 45 * v380;
        CFrame_lookAt_ret = CFrame_lookAt_ret * CFrame.new(math.sin(p373 * v382) * v381, math.sin(p373 * v382 * 0.83) * v381 * 0.6, math.sin(p373 * v382 * 0.61) * v381 * 0.5) * CFrame.Angles(math.sin(p373 * v382 * 0.71) * u2.BUILD_TILT * 0.4 * v380, 0, math.sin(p373 * v382 * 1.13) * u2.BUILD_TILT * v380);
        local math_sin_ret = math.sin(p373 * v382 * 0.5);
        scale = scale * (1 + 0.05 * v380 * math.abs(math_sin_ret));
    end;

    local show2 = p372.show;

    if show2 and show2.flipFrom then
        local math_clamp_ret3 = math.clamp((p373 - show2.flipFrom) / u2.FLIP_SECONDS, 0, 1);
        local v383;

        if math_clamp_ret3 >= 1 then
            v383 = 1;
        else
            local math_clamp_ret4 = math.clamp(math_clamp_ret3, 0, 1);
            v383 = 1 + 2.2 * (math_clamp_ret4 - 1) ^ 3 + 1.2 * (math_clamp_ret4 - 1) ^ 2;
        end;

        p372.flip = v383;
    end;

    if p372.flip > 0 then
        local v384 = math.clamp(p372.flip, 0, 1) * 3.141592653589793;
        local math_sin_ret = math.sin(v384);
        CFrame_lookAt_ret = CFrame_lookAt_ret * CFrame.new(0, math_sin_ret * 0.45 * layout.scale, -math_sin_ret * 0.3 * layout.scale) * CFrame.Angles(0, 3.141592653589793 * p372.flip, 0);
    end;

    local Vector2_zero = Vector2.zero;
    local v385;

    if p371.hover == p372 and (p371.cursor and p372.frame) then
        local v386;
        v385, v386 = cursorOn(p371, p372, u2.INSPECT_EDGE);

        if not v386 then
            v385 = Vector2_zero;
        end;
    else
        v385 = Vector2_zero;
    end;

    p372.inspect = (p372.inspect or Vector2.zero):Lerp(v385, (math.min(1, p371.dt * u2.INSPECT_EASE)));

    if p372.inspect.Magnitude > 0.001 then
        local v387 = CFrame.fromAxisAngle(view.UpVector, p372.inspect.X * u2.INSPECT_TILT) * CFrame.fromAxisAngle(view.RightVector, -p372.inspect.Y * u2.INSPECT_TILT);
        CFrame_lookAt_ret = CFrame.new(CFrame_lookAt_ret.Position) * v387 * CFrame_lookAt_ret.Rotation;
        scale = scale * (1 + u2.INSPECT_GROW * math.min(1, p372.inspect.Magnitude));
    end;

    local v388 = 0;

    if p372.flash then
        local v389 = (p373 - p372.flash.start) / p372.flash.seconds;

        if v389 >= 1 then
            p372.flash = nil;
        elseif v389 >= 0 then
            v388 = p372.flash.peak * (1 - v389) ^ 2;
        end;
    end;

    local v390;

    if p372.lingering then
        v390 = p372.glowFull or 0.3;
    else
        v390 = p372.tell and 0.15 or 0.5;
    end;

    local v391 = v390 - math.min(0.35, v388 * 0.05) + math.sin(p373 * 2.2 + slot) * 0.06;
    local v392 = 1 - (1 - math.clamp(v391, 0, 1)) * v375;

    if p372.glowShown ~= v392 then
        p372.glowShown = v392;

        for _, v in p372.glowImages do
            v.ImageTransparency = v392;
        end;
    end;

    local fx = p372.fx;

    if fx then
        local v393 = v388 + (v380 <= 0 and 0 or (0.5 + math.random() * 1.8) * v380);

        if p372.lingering then
            v393 = math.max(v393, 0.7);
        end;

        fx.light.Brightness = v393 * v375;
        local v394;

        if v380 > 0 or p372.lingering ~= nil then
            v394 = p371.fade == 0;
        else
            v394 = false;
        end;

        fx.wisps.Rate = v380 <= 0 and 2 or 8 + 32 * v380;

        if fx.wisps.Enabled ~= v394 then
            fx.wisps.Enabled = v394;
        end;
    end;

    place(p372, CFrame_lookAt_ret, (math.max(scale, 0.05)));

    if (v380 > 0.3 or show2 and show2.flipFrom and p373 - show2.flipFrom < u2.FLIP_SECONDS + 0.05) and (p372.nextGhost or 0) <= p373 then
        p372.nextGhost = p373 + u2.AFTERIMAGE_EVERY;
        afterimage(p371, p372, Color3_fromRGB_ret);
    end;
end;

local function step(p395, p396) -- Line: 1413
    -- upvalues: u2 (copy), layoutFor (copy), UserInputService (copy), cursorOn (copy), u61 (copy), cardPose (copy), stepOverlay (copy)
    local os_clock_ret = os.clock();
    p395.dt = p396;
    local v397;

    if p395.outroFrom then
        local math_clamp_ret = math.clamp((os_clock_ret - p395.outroFrom) / u2.OUTRO, 0, 1);
        v397 = math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
    else
        v397 = 0;
    end;

    p395.fade = v397;
    local camera = p395.camera;
    local CFrame_identity = CFrame.identity;
    local nudge2 = p395.nudge;

    if nudge2 then
        local v398 = (os_clock_ret - nudge2.start) / nudge2.seconds;

        if v398 >= 1 then
            p395.nudge = nil;
        else
            local v399 = nudge2.amount * (1 - v398) ^ 2;
            CFrame_identity = CFrame.new(math.sin(os_clock_ret * 71) * v399, math.sin(os_clock_ret * 53) * v399 * 0.7, 0) * CFrame.Angles(0, 0, math.sin(os_clock_ret * 61) * v399 * 0.12);
        end;
    end;

    p395.view = camera.CFrame * CFrame_identity;
    local v400 = math.clamp(camera.FieldOfView, 1, 120) / 2;
    local math_rad_ret = math.rad(v400);
    p395.tanY = math.tan(math_rad_ret);
    local ViewportSize = camera.ViewportSize;
    p395.aspect = (ViewportSize.X <= 0 or ViewportSize.Y <= 0) and 1.7777777777777777 or ViewportSize.X / ViewportSize.Y;

    if not (p395.layout and (p395.layout.aspect == p395.aspect and p395.layout.tanY == p395.tanY)) then
        p395.layout = layoutFor(#p395.cards, p395.aspect, p395.tanY);
        local layout = p395.layout;
        local tanY = p395.tanY;
        p395.layout.aspect = p395.aspect;
        layout.tanY = tanY;
    end;

    p395.cursor = nil;
    local v401 = nil;

    if UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse and not p395.outroFrom then
        local MouseLocation = UserInputService:GetMouseLocation();
        p395.cursor = camera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y);

        for _, v in p395.cards do
            if v.frame and not (v.busy or (v.shown ~= 1 or not select(2, cursorOn(p395, v, u2.INSPECT_EDGE)))) then
                v401 = v;
                break;
            end;
        end;
    end;

    if v401 ~= p395.hover then
        p395.hover = v401;

        if v401 and os_clock_ret - (p395.hoverSoundAt or 0) > 0.12 then
            p395.hoverSoundAt = os_clock_ret;
            u61.play(p395, "Hover");
        end;
    end;

    for _, v in p395.cards do
        cardPose(p395, v, os_clock_ret);
    end;

    for i = #p395.anims, 1, -1 do
        local v402;

        if p395.anims[i](os_clock_ret, p396) then
            table.remove(p395.anims, i);
            v402 = i;
        else
            v402 = i;
        end;
    end;

    stepOverlay(p395, os_clock_ret);
end;

local function cleanup(u403) -- Line: 1474
    -- upvalues: u10 (ref), RunService (copy), LocalPlayer (copy)
    if u403.done then
        return;
    end;

    u403.done = true;

    if u10 == u403 then
        u10 = nil;
    end;

    pcall(RunService.UnbindFromRenderStep, RunService, u403.bind);

    for _, v in u403.connections do
        pcall(function() -- Line: 1484
            -- upvalues: v (copy)
            v:Disconnect();
        end);
    end;

    table.clear(u403.connections);
    pcall(function() -- Line: 1489
        -- upvalues: u403 (copy)
        if u403.visibility then
            local visibility = u403.visibility;
            u403.visibility = nil;
            visibility:destroy();
        end;
    end);
    pcall(function() -- Line: 1496
        -- upvalues: u403 (copy)
        for _, v in u403.guis do
            v:Destroy();
        end;
    end);
    pcall(function() -- Line: 1501
        -- upvalues: u403 (copy)
        if u403.folder then
            u403.folder:Destroy();
        end;
    end);
    table.clear(u403.anims);

    if u10 == nil then
        pcall(function() -- Line: 1508
            -- upvalues: LocalPlayer (ref)
            LocalPlayer:SetAttribute("FallenKingSpoilsOpen", nil);
        end);
    end;
end;

local function closeSoon(p404) -- Line: 1514
    -- upvalues: u61 (copy), u2 (copy), cleanup (copy)
    if p404.done or p404.outroFrom then
        return;
    end;

    p404.outroFrom = os.clock();
    u61.play(p404, "Leave");
    task.delay(u2.OUTRO, cleanup, p404);
end;

local function flipCard(p405, p406, p407) -- Line: 1524
    -- upvalues: u61 (copy), u10 (ref), impact (copy), u2 (copy), tellShow (copy), plainPart (copy), CFrame_Angles_ret (copy), setLabel (copy), u7 (copy), reveal (copy)
    u61.cue(p405, "Lock", p407);

    while true do
        local v408;

        if true then
            if u10 == p405 then
                v408 = not p405.done and not p405.outroFrom;
            else
                v408 = false;
            end;
        end;

        if not v408 or os.clock() >= p407 then
            break;
        end;

        task.wait();
    end;

    local v409;

    if u10 == p405 then
        v409 = not p405.done and not p405.outroFrom;
    else
        v409 = false;
    end;

    if not v409 then
        return false;
    end;

    p406.busy = true;
    impact(p405, p406);
    local v410 = {
        buildFrom = os.clock(),
        buildFor = u2.BUILD_SECONDS * p405.pace
    };
    p406.show = v410;
    u61.play(p405, "Build");
    local v411 = nil;

    while true do
        local v412;

        if true then
            if u10 == p405 then
                v412 = not p405.done and not p405.outroFrom;
            else
                v412 = false;
            end;
        end;

        if not v412 or os.clock() - v410.buildFrom >= v410.buildFor then
            break;
        end;

        if v411 == nil and os.clock() - v410.buildFrom >= v410.buildFor * u2.TELL_FROM then
            v411 = tellShow(p405, p406, p406.reward) or false;
        end;

        task.wait();
    end;

    if v411 == nil then
        local v413;

        if u10 == p405 then
            v413 = not p405.done and not p405.outroFrom;
        else
            v413 = false;
        end;

        if v413 then
            v411 = tellShow(p405, p406, p406.reward) or false;
        end;
    end;

    while true do
        local v414;

        if true then
            if u10 == p405 then
                v414 = not p405.done and not p405.outroFrom;
            else
                v414 = false;
            end;
        end;

        if not (v414 and (v411 and os.clock() < v411.endAt)) then
            break;
        end;

        task.wait();
    end;

    local v415;

    if u10 == p405 then
        v415 = not p405.done and not p405.outroFrom;
    else
        v415 = false;
    end;

    if not v415 then
        return false;
    end;

    if p406.plain and not p406.face then
        local v416 = plainPart(p405, p406.style.glow, false);
        local v417 = CFrame.new(0, 0, 0.012) * CFrame_Angles_ret;
        v416.Anchored = true;
        v416.CanCollide = false;
        v416.CanTouch = false;
        v416.CanQuery = false;
        v416.CastShadow = false;
        v416.Parent = p406.model;
        local v418 = {
            part = v416,
            offset = v417,
            size = v416.Size
        };
        table.insert(p406.layers, v418);
        p406.scale = nil;
        p406.face = v418;
    end;

    setLabel(p405, p406, p406.reward);
    v410.flipFrom = os.clock();
    u61.play(p405, "Flip");
    local rarity = p406.reward.rarity;
    local v419 = v410.flipFrom + u2.FLIP_SECONDS;

    if rarity == "Epic" then
        u61.cue(p405, "RevealBig", v419);

        if rarity == "Mythical" then
            u61.cue(p405, "Mythical", v419);
        end;
    else
        local reward = p406.reward;

        if reward then
            reward = reward.rarity;
        end;

        if (u7[reward] or 6) <= u7.Legendary then
            u61.cue(p405, "RevealBig", v419);

            if rarity == "Mythical" then
                u61.cue(p405, "Mythical", v419);
            end;
        else
            u61.cue(p405, "Reveal", v419);
        end;
    end;

    task.wait(u2.FLIP_SECONDS);
    local v420;

    if u10 == p405 then
        v420 = not p405.done and not p405.outroFrom;
    else
        v420 = false;
    end;

    if not v420 then
        return false;
    end;

    p406.opened = true;
    reveal(p405, p406, p406.reward);
    p406.busy = false;

    return true;
end;

local function sequence(p421) -- Line: 1582
    -- upvalues: u7 (copy), u2 (copy), u61 (copy), flipCard (copy), u10 (ref), kingslayer (copy)
    local data = p421.data;
    local v422 = 0;

    for _, v in p421.cards do
        local reward = v.reward;

        if reward then
            reward = reward.rarity;
        end;

        if (u7[reward] or 6) <= u7.Legendary then
            v422 = v422 + 1;
        end;
    end;

    p421.pace = math.clamp((data.seconds - u2.OUTRO - u2.HOLD - #p421.cards * u2.FLIP_SECONDS) / (u2.FIRST + #p421.cards * (u2.BUILD_SECONDS + u2.NEXT) + v422 * u2.TELL_SECONDS + (not data.kingslayer and 0 or u2.KING_AFTER)), u2.PACE_LEAST, 1);
    u61.play(p421, "Enter");
    local v423 = p421.openedAt + u2.FIRST * p421.pace;

    for _, v in p421.cards do
        if not flipCard(p421, v, v423) then
            return;
        end;

        v423 = os.clock() + u2.NEXT * p421.pace;
    end;

    local kingslayer2 = data.kingslayer;

    if kingslayer2 then
        local v424 = os.clock() + u2.KING_AFTER * p421.pace;
        local v425 = p421.cards[#p421.cards] and p421.cards[#p421.cards].reward;
        local v426;

        if v425 == nil then
            v426 = false;
        elseif v425.rarity == "Epic" then
            v426 = true;
        else
            if v425 then
                v425 = v425.rarity;
            end;

            v426 = (u7[v425] or 6) <= u7.Legendary;
        end;

        local v427;

        if kingslayer2.rarity == "Epic" then
            v427 = not v426;
        else
            local v428;

            if kingslayer2 then
                v428 = kingslayer2.rarity;
            else
                v428 = kingslayer2;
            end;

            v427 = (u7[v428] or 6) <= u7.Legendary and not v426;
        end;

        u61.cue(p421, v427 and "RevealBig" or "Reveal", v424);

        if v427 and kingslayer2.rarity == "Mythical" then
            u61.cue(p421, "Mythical", v424);
        end;

        while true do
            local v429;

            if true then
                if u10 == p421 then
                    v429 = not p421.done and not p421.outroFrom;
                else
                    v429 = false;
                end;
            end;

            if not v429 or os.clock() >= v424 then
                break;
            end;

            task.wait();
        end;

        local v430;

        if u10 == p421 then
            v430 = not p421.done and not p421.outroFrom;
        else
            v430 = false;
        end;

        if v430 then
            kingslayer(p421, kingslayer2);
        end;
    end;
end;

local function hideHud(u431) -- Line: 1623
    -- upvalues: LocalPlayer (copy), Presentation (copy)
    local success, result = pcall(function() -- Line: 1624
        -- upvalues: LocalPlayer (ref), Presentation (ref), u431 (copy)
        if LocalPlayer:GetAttribute("CreatorUIHidden") == true then
            return;
        end;

        local v432 = require(Presentation:WaitForChild("CreatorVisibility", 5)).new(LocalPlayer);

        if u431.done then
            return;
        end;

        u431.visibility = v432;
        v432:setHidden(true);
    end);

    if not success then
        warn("[FallenKingSpoils] couldn\'t hide the UI: " .. tostring(result));
    end;
end;

local function watch(u433) -- Line: 1640
    -- upvalues: cleanup (copy), LocalPlayer (copy), Session (copy)
    local function stop() -- Line: 1641
        -- upvalues: cleanup (ref), u433 (copy)
        cleanup(u433);
    end;

    local Character = LocalPlayer.Character;
    local v434;

    if Character then
        v434 = Character:FindFirstChildOfClass("Humanoid");
    else
        v434 = Character;
    end;

    if v434 then
        table.insert(u433.connections, v434.Died:Connect(stop));
    end;

    if Character then
        table.insert(u433.connections, Character.AncestryChanged:Connect(function() -- Line: 1650
            -- upvalues: Character (copy), cleanup (ref), u433 (copy)
            if not Character:IsDescendantOf(workspace) then
                cleanup(u433);
            end;
        end));
    end;

    table.insert(u433.connections, LocalPlayer.CharacterAdded:Connect(stop));
    local connections = u433.connections;
    local AttributeChangedSignal = Session:GetAttributeChangedSignal("MapChanging");
    table.insert(connections, AttributeChangedSignal:Connect(function() -- Line: 1657
        -- upvalues: Session (ref), cleanup (ref), u433 (copy)
        if Session:GetAttribute("MapChanging") == true then
            cleanup(u433);
        end;
    end));
    local connections2 = u433.connections;
    local PropertyChangedSignal = workspace:GetPropertyChangedSignal("CurrentCamera");
    table.insert(connections2, PropertyChangedSignal:Connect(stop));
end;

local function open(p435) -- Line: 1664
    -- upvalues: u11 (ref), u10 (ref), LocalPlayer (copy), HudNavigation (copy), u61 (copy), buildOverlay (copy), newCard (copy), step (copy), watch (copy), RunService (copy), cleanup (copy), u2 (copy), Presentation (copy), sequence (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return nil, "no camera";
    end;

    u11 = u11 + 1;
    local os_clock_ret = os.clock();
    local u436 = {
        dt = 0,
        fade = 0,
        pace = 1,
        data = p435,
        camera = workspace_CurrentCamera,
        bind = "FallenKingSpoils" .. u11,
        openedAt = os_clock_ret,
        closeAt = os_clock_ret + p435.seconds,
        cards = {},
        anims = {},
        guis = {},
        connections = {}
    };
    u10 = u436;
    LocalPlayer:SetAttribute("FallenKingSpoilsOpen", true);
    pcall(HudNavigation.opening, "FallenKingSpoils");
    local Folder = Instance.new("Folder");
    Folder.Name = "FallenKingSpoils";

    for i, v in {} do
        Folder[i] = v;
    end;

    Folder.Parent = workspace_CurrentCamera;
    u436.folder = Folder;
    u61.warm(u436);
    buildOverlay(u436, LocalPlayer:FindFirstChildOfClass("PlayerGui"));

    for i, v in p435.cards do
        local v437 = newCard(u436, i);
        v437.reward = v;
        u436.cards[i] = v437;
    end;

    step(u436, 0);
    watch(u436);
    RunService:BindToRenderStep(u436.bind, Enum.RenderPriority.Last.Value + 25, function(p438) -- Line: 1702
        -- upvalues: u436 (copy), step (ref), cleanup (ref), u2 (ref), u61 (ref)
        if u436.done then
            return;
        end;

        local success, result = pcall(step, u436, p438);

        if success then
            if not u436.outroFrom and os.clock() >= u436.closeAt - u2.OUTRO then
                local v439 = u436;

                if not v439.done then
                    if v439.outroFrom then
                        return;
                    end;

                    v439.outroFrom = os.clock();
                    u61.play(v439, "Leave");
                    task.delay(u2.OUTRO, cleanup, v439);
                end;
            end;

            return;
        end;

        warn("[FallenKingSpoils] the screen failed: " .. tostring(result));
        cleanup(u436);
    end);
    task.delay(p435.seconds + 1, cleanup, u436);
    local success, result = pcall(function() -- Line: 1624
        -- upvalues: LocalPlayer (ref), Presentation (ref), u436 (copy)
        if LocalPlayer:GetAttribute("CreatorUIHidden") == true then
            return;
        end;

        local v440 = require(Presentation:WaitForChild("CreatorVisibility", 5)).new(LocalPlayer);

        if u436.done then
            return;
        end;

        u436.visibility = v440;
        v440:setHidden(true);
    end);

    if not success then
        warn("[FallenKingSpoils] couldn\'t hide the UI: " .. tostring(result));
    end;

    task.spawn(function() -- Line: 1717
        -- upvalues: sequence (ref), u436 (copy)
        local success2, result2 = pcall(sequence, u436);

        if not success2 then
            warn("[FallenKingSpoils] the show failed: " .. tostring(result2));
        end;
    end);

    return u436;
end;

local function cleanText(p441, p442) -- Line: 1730
    if type(p441) ~= "string" or utf8.len(p441) == nil then
        return nil;
    end;

    local string_gsub_ret = string.gsub(p441, "%c", " ");

    if p442 < utf8.len(string_gsub_ret) then
        local v443 = utf8.offset(string_gsub_ret, p442 + 1) - 1;
        string_gsub_ret = string.sub(string_gsub_ret, 1, v443);
    end;

    local string_match_ret = string.match(string_gsub_ret, "^%s*(.-)%s*$");

    if string_match_ret == "" then
        return nil;
    end;

    return string_match_ret;
end;

local function cleanCount(p444) -- Line: 1741
    if type(p444) ~= "number" or (p444 ~= p444 or (p444 == (1 / 0) or p444 == (-1 / 0))) then
        return nil;
    end;

    local math_floor_ret = math.floor(p444);

    return math.clamp(math_floor_ret, 0, 1000000000);
end;

local function cleanView(p445) -- Line: 1748
    -- upvalues: cleanText (copy), u8 (copy), u7 (copy)
    if type(p445) ~= "table" then
        return nil;
    end;

    local v446 = cleanText(p445.name, 40);

    if not v446 then
        return nil;
    end;

    local v447 = {
        id = cleanText(p445.id, 64) or ""
    };
    local v448;

    if type(p445.kind) == "string" and u8[p445.kind] then
        v448 = p445.kind;
    else
        v448 = nil;
    end;

    v447.kind = v448;
    v447.name = v446;
    v447.rarity = (type(p445.rarity) ~= "string" or not u7[p445.rarity]) and "Common" or p445.rarity;
    local amount = p445.amount;
    local v449;

    if type(amount) == "number" and (amount == amount and (amount ~= (1 / 0) and amount ~= (-1 / 0))) then
        local math_floor_ret = math.floor(amount);
        v449 = math.clamp(math_floor_ret, 0, 1000000000);
    else
        v449 = nil;
    end;

    v447.amount = v449;
    local duplicateGems = p445.duplicateGems;
    local v450;

    if type(duplicateGems) == "number" and (duplicateGems == duplicateGems and (duplicateGems ~= (1 / 0) and duplicateGems ~= (-1 / 0))) then
        local math_floor_ret = math.floor(duplicateGems);
        v450 = math.clamp(math_floor_ret, 0, 1000000000);
    else
        v450 = nil;
    end;

    v447.duplicateGems = v450;
    v447.crate = cleanText(p445.crate, 64);

    return v447;
end;

local function validate(p451) -- Line: 1767
    -- upvalues: cleanView (copy)
    if type(p451) ~= "table" then
        return nil, "the payload isn\'t a table";
    end;

    local v452 = {};

    if type(p451.cards) == "table" then
        for i = 1, 3 do
            local v453 = cleanView(p451.cards[i]);
            local v454;

            if v453 then
                table.insert(v452, v453);
                v454 = i;
            elseif p451.cards[i] == nil then
                v454 = i;
            else
                warn("[FallenKingSpoils] card " .. i .. " isn\'t a prize; it isn\'t shown");
                v454 = i;
            end;
        end;

        if p451.cards[4] ~= nil then
            warn("[FallenKingSpoils] more than " .. 3 .. " cards; only the first " .. 3 .. " are shown");
        end;
    end;

    if #v452 == 0 then
        return nil, "no cards";
    end;

    local seconds = p451.seconds;
    local v455;

    if type(seconds) == "number" and (seconds == seconds and (seconds ~= (1 / 0) and seconds ~= (-1 / 0))) then
        local math_floor_ret = math.floor(seconds);
        v455 = math.clamp(math_floor_ret, 0, 1000000000);
    else
        v455 = nil;
    end;

    return {
        cards = v452,
        kingslayer = cleanView(p451.kingslayer),
        top = p451.top == true,
        seconds = math.clamp(v455 or 9, 4, 30)
    };
end;

function v9.show(p456) -- Line: 1801
    -- upvalues: validate (copy), u12 (ref), u73 (copy), ReplicatedStorage (copy), ContentProvider (copy), u10 (ref), cleanup (copy), open (copy)
    local v457, v458 = validate(p456);

    if not v457 then
        warn("[FallenKingSpoils] not shown: " .. tostring(v458));

        return false;
    end;

    u12 = u12 + 1;

    if not u73.checked then
        u73.checked = true;
        u73.pending = true;
        task.spawn(function() -- Line: 407
            -- upvalues: ReplicatedStorage (ref), u73 (ref), ContentProvider (ref)
            local GhostTraderAssets = ReplicatedStorage:FindFirstChild("GhostTraderAssets");

            if GhostTraderAssets then
                GhostTraderAssets = GhostTraderAssets:FindFirstChild("Cards");
            end;

            if not GhostTraderAssets then
                u73.pending = false;
                warn("[FallenKingSpoils] ReplicatedStorage.GhostTraderAssets.Cards is missing: plain glowing cards instead");

                return;
            end;

            local u459 = { GhostTraderAssets };

            for _, descendant in GhostTraderAssets:GetDescendants() do
                if descendant:IsA("SurfaceAppearance") then
                    local success, result = pcall(function() -- Line: 419
                        -- upvalues: descendant (copy)
                        return descendant.ColorMap;
                    end);

                    if success and (type(result) == "string" and result ~= "") then
                        local ImageLabel = Instance.new("ImageLabel");
                        ImageLabel.Name = "Probe";

                        for i, v in {
                            Image = result
                        } or {} do
                            ImageLabel[i] = v;
                        end;

                        ImageLabel.Parent = nil;
                        table.insert(u459, ImageLabel);
                    end;
                end;
            end;

            local u460 = {};
            local success, result = pcall(function() -- Line: 428
                -- upvalues: ContentProvider (ref), u459 (copy), u460 (copy)
                ContentProvider:PreloadAsync(u459, function(p461, p462) -- Line: 429
                    -- upvalues: u460 (ref)
                    if p462 ~= Enum.AssetFetchStatus.Success then
                        local v463 = tostring(p461) .. " " .. p462.Name;
                        table.insert(u460, v463);
                    end;
                end);
            end);

            for _, v in u459 do
                if v:IsA("ImageLabel") then
                    v:Destroy();
                end;
            end;

            if success and #u460 == 0 then
                u73.folder = GhostTraderAssets;
                u73.ok = true;
            else
                local l_warn = warn;
                local v464;

                if success then
                    v464 = table.concat(u460, ", ");
                else
                    v464 = tostring(result);
                end;

                l_warn("[FallenKingSpoils] the card art didn\'t load (" .. v464 .. "); plain glowing cards instead");
            end;

            u73.pending = false;
        end);
    end;

    local v465 = os.clock() + 1.5;

    while u73.pending and os.clock() < v465 do
        task.wait(0.05);
    end;

    if u12 ~= u12 then
        return false;
    end;

    if u10 then
        cleanup(u10);
    end;

    local v466, v467, v467 = pcall(open, v457);

    if v466 and v467 then
        return true;
    end;

    warn("[FallenKingSpoils] couldn\'t open: " .. tostring(v467));

    if u10 then
        cleanup(u10);
    end;

    return false;
end;

function v9.close() -- Line: 1833
    -- upvalues: u10 (ref), cleanup (copy)
    if u10 then
        cleanup(u10);
    end;
end;

function v9.isOpen() -- Line: 1838
    -- upvalues: u10 (ref)
    return u10 ~= nil;
end;

function v9.preload() -- Line: 1842
    -- upvalues: u73 (copy), ReplicatedStorage (copy), ContentProvider (copy), u13 (ref), u3 (copy), u6 (copy)
    if not u73.checked then
        u73.checked = true;
        u73.pending = true;
        task.spawn(function() -- Line: 407
            -- upvalues: ReplicatedStorage (ref), u73 (ref), ContentProvider (ref)
            local GhostTraderAssets = ReplicatedStorage:FindFirstChild("GhostTraderAssets");

            if GhostTraderAssets then
                GhostTraderAssets = GhostTraderAssets:FindFirstChild("Cards");
            end;

            if not GhostTraderAssets then
                u73.pending = false;
                warn("[FallenKingSpoils] ReplicatedStorage.GhostTraderAssets.Cards is missing: plain glowing cards instead");

                return;
            end;

            local u468 = { GhostTraderAssets };

            for _, descendant in GhostTraderAssets:GetDescendants() do
                if descendant:IsA("SurfaceAppearance") then
                    local success, result = pcall(function() -- Line: 419
                        -- upvalues: descendant (copy)
                        return descendant.ColorMap;
                    end);

                    if success and (type(result) == "string" and result ~= "") then
                        local ImageLabel = Instance.new("ImageLabel");
                        ImageLabel.Name = "Probe";

                        for i, v in {
                            Image = result
                        } or {} do
                            ImageLabel[i] = v;
                        end;

                        ImageLabel.Parent = nil;
                        table.insert(u468, ImageLabel);
                    end;
                end;
            end;

            local u469 = {};
            local success, result = pcall(function() -- Line: 428
                -- upvalues: ContentProvider (ref), u468 (copy), u469 (copy)
                ContentProvider:PreloadAsync(u468, function(p470, p471) -- Line: 429
                    -- upvalues: u469 (ref)
                    if p471 ~= Enum.AssetFetchStatus.Success then
                        local v472 = tostring(p470) .. " " .. p471.Name;
                        table.insert(u469, v472);
                    end;
                end);
            end);

            for _, v in u468 do
                if v:IsA("ImageLabel") then
                    v:Destroy();
                end;
            end;

            if success and #u469 == 0 then
                u73.folder = GhostTraderAssets;
                u73.ok = true;
            else
                local l_warn = warn;
                local v473;

                if success then
                    v473 = table.concat(u469, ", ");
                else
                    v473 = tostring(result);
                end;

                l_warn("[FallenKingSpoils] the card art didn\'t load (" .. v473 .. "); plain glowing cards instead");
            end;

            u73.pending = false;
        end);
    end;

    if u13 then
        return;
    end;

    u13 = true;
    task.spawn(function() -- Line: 1848
        -- upvalues: u3 (ref), u6 (ref), ContentProvider (ref)
        local v474 = {};

        for _, v in u3 do
            local v475 = {
                SoundId = v[1]
            };
            local Sound = Instance.new("Sound");
            Sound.Name = "Probe";

            for i, v2 in v475 or {} do
                Sound[i] = v2;
            end;

            Sound.Parent = nil;
            table.insert(v474, Sound);
        end;

        for _, v in u6.ICONS do
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Name = "Probe";

            for i, v2 in {
                Image = v
            } or {} do
                ImageLabel[i] = v2;
            end;

            ImageLabel.Parent = nil;
            table.insert(v474, ImageLabel);
        end;

        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Probe";

        for i, v in {
            Image = "rbxassetid://129028976496842"
        } or {} do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = nil;
        table.insert(v474, ImageLabel);
        pcall(ContentProvider.PreloadAsync, ContentProvider, v474);

        for _, v in v474 do
            v:Destroy();
        end;
    end);
end;

v9._test = {
    validate = validate,
    layout = layoutFor
};

return v9;