 

 

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
local LocalHide = require(Presentation:WaitForChild("LocalHide"));
local LocalLooks = require(Presentation:WaitForChild("LocalLooks"));
local Session = Game:WaitForChild("Session");
local LocalPlayer = Players.LocalPlayer;
local u1 = {
    Brightness = -0.07,
    Contrast = 0.15,
    Saturation = -0.3,
    TintColor = Color3.fromRGB(212, 200, 240)
};
local Vector2_new_ret = Vector2.new(0.45, 0.42);
local u2 = { 0.22, 0.98, 0.11, 0.63 };
local u3 = 46;
local u4 = {
    KEY_FLIGHT = 0.55,
    IMPACT_PUNCH = 0.22,
    IMPACT_PUNCH_SECONDS = 0.34,
    IMPACT_FLASH = 3.5,
    IMPACT_FLASH_SECONDS = 0.45,
    IMPACT_RING = 4.2,
    IMPACT_RING_SECONDS = 0.45,
    IMPACT_RING_THICKNESS = 26,
    IMPACT_SPARKS = 36,
    IMPACT_WISPS = 14,
    SCREEN_FLASH = 0.45,
    SCREEN_FLASH_SECONDS = 0.28,
    VIGNETTE = 0.45,
    VIGNETTE_SECONDS = 0.6,
    NUDGE = 0.07,
    NUDGE_SECONDS = 0.26,
    BUILD_SECONDS = 0.6,
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
    PRESENT_AT = Vector2.new(0.5, 0.48),
    PRESENT_HEIGHT = 0.5,
    PRESENT_DEPTH = 3,
    PRESENT_IN = 0.32,
    PRESENT_BOB = 0.035,
    PRESENT_BOB_SPEED = 2.2,
    PRESENT_OUT = 0.45,
    RAYS = false,
    PRESENT_RAYS = 0.4,
    INSPECT_TILT = 0.20943951023931956,
    INSPECT_GROW = 0.03,
    INSPECT_EASE = 8,
    INSPECT_EDGE = 1.1,
    SLAM_SECONDS = 0.14,
    REVEAL_HOLD = 1.4,
    CONTINUE_AFTER = 0.9,
    CONTINUE_TIMEOUT = 20,
    MYTHIC_RINGS = { 1.3, 1.6 },
    MYTHIC_GLOW = { 0.1, 3.5 },
    MYTHIC_RAYS = 16,
    MYTHIC_RAY_LENGTH = 4.5,
    MYTHIC_PILLAR = 1.4,
    MYTHIC_WASH = 0.22,
    MYTHIC_HOLD = 4,
    MYTHIC_CONTINUE_AFTER = 3,
    DEAL_PAUSE = 1.8
};
local u5 = {
    PLACARD_GAP = 0.008,
    PLACARD_BOTTOM = 0.975,
    PLACARD_RIGHT = 0.985,
    PLACARD_SHRINK = 0.7,
    PIXELS = 220,
    PLACARD = Vector2.new(0.14, 0.072),
    PLACARD_LEFT = { Vector2.new(1.3333333333333333, 0.661), Vector2.new(2.29, 0.613) },
    BANNER = Vector2.new(0.34, 0.125),
    HINT = Vector2.new(0.44, 0.05)
};
local u6 = {
    PAD = 0.45,
    TITLE = 1.3,
    COST = 0.85,
    DIVIDER = 0.18,
    ROW = 1.12,
    DOT = 0.42,
    ROW_PAD = 0.3,
    GAP = 0.8,
    GUTTER = 1,
    BAND = 0.93,
    RULE = 0.6,
    CHASE_TINT = 0.3,
    CANVAS = 1024,
    MIN_PIXELS = 10,
    MOST_PIXELS = 30,
    MOST = 0.022,
    FLOOR = 14,
    UNDER = 0.012,
    PANEL_GAP = 0.02,
    LEAST = 0.3,
    MORE_COLUMNS = 1.15,
    POP = 0.16,
    POP_FROM = 0.9,
    FOLDED = "Coins · Candy · Gems · Keys · Crate Keys",
    COLUMNS = { 2, 3 },
    BOX = { 0.45, 0.85 },
    NAMES = {
        Coins750 = "750 Coins",
        Coins2000 = "2,000 Coins",
        Candy300 = "300 Candy",
        Candy1000 = "1,000 Candy",
        Gems50 = "50 Gems",
        Gems150 = "150 Gems",
        Keys2 = "+2 Keys",
        Keys3 = "+3 Keys",
        TrickOrTreatKey = "Trick/Treat Key",
        EmoteCrateKey = "Emote Crate Key",
        Keyholder = "Keyholder Title",
        CardTrick = "Card Trick",
        SkeletonKey = "Skeleton Key",
        Ghostlock = "Ghostlock",
        LastDoor = "The Last Door"
    },
    ORDER = {
        Mythical = 1,
        Legendary = 2,
        Epic = 3,
        Rare = 4,
        Common = 5
    },
    WON = {
        ICON = 3.3,
        TILE = 0.82,
        GAP = 0.8,
        LABEL = 0.8,
        LABEL_TEXT = "YOU GOT",
        NAME = 1.6,
        SPACE = 0.3,
        PILL = 1.05,
        PILL_TEXT = 0.68,
        PILL_PAD = 0.45,
        AFTER_PILL = 0.5,
        NOTE = 0.8,
        BODY = 3.95
    }
};
local u7 = {
    IN = 0.35,
    OUT = 0.5,
    TOWARD = 0.15,
    SIDE = 0.3,
    UP = 0.1
};
local u8 = {
    Enter = { "rbxassetid://9113080525", 0.22, 0.25, 0.8, 0 },
    Hover = { "rbxassetid://9117188688", 0.25, 0.02, 0.3, 0 },
    KeyIn = { "rbxassetid://9116169563", 0.45, 0.4, 0.55, 0.25 },
    Lock = { "rbxassetid://9114144270", 0.8, 0.52, 0.5, 0.23 },
    Build = { "rbxassetid://9048834006", 0.3, 2.4, 0.85, 0 },
    Flip = { "rbxassetid://9113818686", 0.45, 0.03, 0.25, 0.02 },
    Reveal = { "rbxassetid://9116384762", 0.45, 0.18, 1.6, 0.02 },
    RevealBig = { "rbxassetid://1841354419", 0.75, 0.15, 3, 0.3 },
    Mythical = { "rbxassetid://1846886773", 0.5, 0.1, 3.5, 0.3 },
    Chuckle = { "rbxassetid://9116239118", 0.35, 0.1, 1.4, 0 },
    Leave = { "rbxassetid://9118158113", 0.35, 0.1, 0.45, 0 }
};
local Color3_fromRGB_ret = Color3.fromRGB(120, 255, 170);
local Color3_fromRGB_ret2 = Color3.fromRGB(70, 170, 120);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 60, 70);
Color3.fromRGB(176, 98, 255);
local Color3_fromRGB_ret4 = Color3.fromRGB(12, 16, 18);
local Color3_fromRGB_ret5 = Color3.fromRGB(240, 255, 246);
local Font_fromEnum_ret = Font.fromEnum(Enum.Font.GothamBlack);
local Font_fromEnum_ret2 = Font.fromEnum(Enum.Font.GothamBold);
local u9 = {
    DEEP = Color3.fromRGB(150, 0, 32),
    RED = Color3.fromRGB(255, 72, 96),
    HOT = Color3.fromRGB(255, 175, 185)
};
u9.SHIMMER = ColorSequence.new({
    ColorSequenceKeypoint.new(0, u9.DEEP),
    ColorSequenceKeypoint.new(0.3, u9.RED),
    ColorSequenceKeypoint.new(0.5, u9.HOT),
    ColorSequenceKeypoint.new(0.7, u9.RED),
    ColorSequenceKeypoint.new(1, u9.DEEP)
});
local u10 = {
    Common = Color3.fromRGB(175, 185, 192),
    Rare = Color3.fromRGB(92, 173, 238),
    Epic = Color3.fromRGB(183, 123, 244),
    Legendary = Color3.fromRGB(242, 191, 89),
    Mythical = Color3.fromRGB(255, 72, 96)
};
local u11 = {
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
        cursed = {
            art = "Red Card",
            drop = 0.05,
            ink = Color3.fromHex("FFE0E6"),
            accent = Color3.fromHex("FF99AA"),
            glow = Color3.fromHex("FA0131"),
            stroke = Color3.fromHex("2A0818")
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
    REWARD_ICONS = {
        SkeletonKey = "rbxassetid://72714213418096",
        Ghostlock = "rbxassetid://93547760427672",
        LastDoor = "rbxassetid://100555721233304"
    },
    KINDS = {
        Knife = "KNIFE",
        Emote = "EMOTE",
        Title = "TITLE"
    }
};
local CFrame_fromMatrix_ret = CFrame.fromMatrix(Vector3.new(0, 0, 0), Vector3.new(-0, -0, 1), Vector3.new(0, 1, 0));
local CFrame_Angles_ret = CFrame.Angles(0, 3.141592653589793, 0);
local u12 = {
    Off = "This feature is currently not available.",
    InMatch = "You can\'t trade keys during a match.",
    TooFar = "Walk up to the Ghost Key Trader first.",
    NoKeys = "You need a Ghost Key to flip a card.",
    Cooldown = "Your next card isn\'t ready yet.",
    Opened = "That card is already flipped.",
    Busy = "One moment, the trader is still dealing.",
    Saving = "That could not be saved. Please try again.",
    Restricted = "Skips aren\'t available on your account.",
    NoProduct = "Skips aren\'t available yet."
};
local u13 = {
    UNAVAILABLE = "This feature is currently not available."
};
local u14 = false;
local u15 = false;
local u16 = {
    send = function() -- Line: 389, Name: send
    end
};
local u17 = nil;
local u18 = setmetatable({}, {
    __mode = "k"
});
local u19 = setmetatable({}, {
    __mode = "k"
});
local u20 = {
    camera = nil,
    controls = nil,
    visibility = nil
};

local function flat(p21) -- Line: 396
    return Vector3.new(p21.X, 0, p21.Z);
end;

local function unitOr(p22, p23) -- Line: 399
    if p22.Magnitude > 0.0001 then
        return p22.Unit;
    end;

    return p23;
end;

local function smooth(p24) -- Line: 402
    local math_clamp_ret = math.clamp(p24, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

local u27 = {
    body = function(p25) -- Line: 413, Name: body
        local v26 = p25:FindFirstAncestorOfClass("Model");

        while v26 do
            if v26:FindFirstChildOfClass("Humanoid") or v26:GetAttribute("IsBot") == true then
                return v26;
            end;

            v26 = v26:FindFirstAncestorOfClass("Model");
        end;

        return nil;
    end
};

function u27.cast(p28, p29, p30) -- Line: 424
    -- upvalues: u27 (copy)
    for i = 1, 8 do
        local v31 = workspace:Raycast(p28, p29, p30);
        local v32;

        if v31 then
            v32 = u27.body(v31.Instance);
        else
            v32 = v31;
        end;

        if not v32 then
            return v31;
        end;

        p30:AddToFilter(v32);
        local _ = i;
    end;

    return nil;
end;

function u27.fade(p33, p34) -- Line: 436
    p33.othersK = p34;

    for i, v in p33.hide.saved do
        local u35 = v + (1 - v) * p34;

        if i.LocalTransparencyModifier ~= u35 then
            pcall(function() -- Line: 441
                -- upvalues: i (copy), u35 (copy)
                i.LocalTransparencyModifier = u35;
            end);
        end;
    end;
end;

function u27.step(p36, p37) -- Line: 449
    -- upvalues: u27 (copy)
    local othersFade = p36.othersFade;

    if not othersFade then
        return;
    end;

    local math_clamp_ret = math.clamp((p37 - othersFade.start) / othersFade.seconds, 0, 1);
    local fade = u27.fade;
    local from = othersFade.from;
    local v38 = othersFade.to - othersFade.from;
    local math_clamp_ret2 = math.clamp(math_clamp_ret, 0, 1);
    fade(p36, from + v38 * (math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2)));

    if math_clamp_ret >= 1 then
        p36.othersFade = nil;
    end;
end;

local function backOut(p39) -- Line: 460
    local math_clamp_ret = math.clamp(p39, 0, 1);

    return 1 + 2.2 * (math_clamp_ret - 1) ^ 3 + 1.2 * (math_clamp_ret - 1) ^ 2;
end;

local function make(p40, p41, p42, p43) -- Line: 464
    local Instance_new_ret = Instance.new(p40);
    Instance_new_ret.Name = p42;

    for i, v in p43 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p41;

    return Instance_new_ret;
end;

local function quiet(p44) -- Line: 473
    p44.Anchored = true;
    p44.CanCollide = false;
    p44.CanTouch = false;
    p44.CanQuery = false;
    p44.CastShadow = false;

    return p44;
end;

local function alive() -- Line: 477
    -- upvalues: LocalPlayer (ref)
    local v45 = LocalPlayer and LocalPlayer.Character;
    local v46;

    if v45 then
        v46 = v45:FindFirstChildOfClass("Humanoid");
    else
        v46 = v45;
    end;

    local v47;

    if v45 then
        v47 = v45:FindFirstChild("HumanoidRootPart");
    else
        v47 = v45;
    end;

    local v48;

    if v46 == nil or v46.Health <= 0 then
        v48 = false;
    else
        v48 = v47 ~= nil;
    end;

    return v45, v46, v47, v48;
end;

local function clock(p49) -- Line: 483
    local math_ceil_ret = math.ceil(p49);
    local math_max_ret = math.max(0, math_ceil_ret);

    return string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60);
end;

local u50 = {};
local TextService = game:GetService("TextService");
local Vector2_new_ret2 = Vector2.new(100000, 1000);

function u50.width(p51, p52) -- Line: 493
    -- upvalues: TextService (copy), Vector2_new_ret2 (copy)
    local v53;

    if p52 then
        v53 = Enum.Font.GothamBlack;
    else
        v53 = Enum.Font.GothamBold;
    end;

    local success, result = pcall(TextService.GetTextSize, TextService, p51, 100, v53, Vector2_new_ret2);

    if success then
        return result.X / 100 * 1.02;
    end;

    return utf8.len(p51) * 0.65;
end;

local function heavy(p54) -- Line: 498
    return p54.FontFace.Weight.Value >= 800;
end;

function u50.line(p55, p56, p57, p58, p59) -- Line: 502
    -- upvalues: u50 (copy)
    p55.Text = p56;
    p55.TextScaled = false;
    p55.TextWrapped = false;
    local v60 = u50.width(p56, p55.FontFace.Weight.Value >= 800);
    local v61 = p57 / math.max(v60, 0.5);
    local math_min_ret = math.min(p59 or p58, p58, v61);
    local math_floor_ret = math.floor(math_min_ret);
    p55.TextSize = math.max(8, math_floor_ret);
end;

function u50.fit(p62, p63, p64, p65, p66) -- Line: 510
    -- upvalues: u50 (copy)
    local v67 = p62.FontFace.Weight.Value >= 800;
    local v68 = u50.width(p63, v67);
    local v69 = p64 / math.max(v68, 0.5);
    local math_min_ret = math.min(p66, p65 * 0.85, v69);
    local v70 = p63;
    local v71 = (1 / 0);
    local v72 = nil;

    for i in string.gmatch(p63, "() ") do
        local v73 = u50.width(string.sub(p63, 1, i - 1), v67);
        local width = u50.width;
        local string_sub_ret = string.sub(p63, i + 1);
        local math_max_ret = math.max(v73, width(string_sub_ret, v67));

        if math_max_ret < v71 then
            v72 = i;
            v71 = math_max_ret;
        end;
    end;

    local v74;

    if v72 then
        local v75 = p64 / math.max(v71, 0.5);
        v74 = math.min(p66, p65 / 2.3, v75);

        if math_min_ret * 1.15 < v74 then
            v70 = string.sub(p63, 1, v72 - 1) .. "\n" .. string.sub(p63, v72 + 1);
        else
            v74 = math_min_ret;
        end;
    else
        v74 = math_min_ret;
    end;

    p62.Text = v70;
    p62.TextScaled = false;
    p62.TextWrapped = false;
    local math_floor_ret = math.floor(v74);
    p62.TextSize = math.max(8, math_floor_ret);
end;

local u85 = {
    warm = function(p76) -- Line: 534, Name: warm
        -- upvalues: u8 (copy)
        p76.sounds = {};

        for i, v in u8 do
            local sounds = p76.sounds;
            local folder = p76.folder;
            local v77 = {
                Volume = 0,
                SoundId = v[1]
            };
            local Sound = Instance.new("Sound");
            Sound.Name = "Warm" .. i;

            for i2, v2 in v77 or {} do
                Sound[i2] = v2;
            end;

            Sound.Parent = folder;
            sounds[i] = Sound;
        end;
    end,

    play = function(p78, p79, u80, p81) -- Line: 541, Name: play
        -- upvalues: u8 (copy), TweenService (copy)
        local u82 = u8[p79];
        local v83 = p78.sounds and p78.sounds[p79];

        if not (u82 and (v83 and (p78.folder and p78.folder.Parent))) then
            return nil;
        end;

        local u84 = v83:Clone();
        u84.Name = p79;
        u84.Volume = p81 or u82[2];
        u84.PlaybackSpeed = u80 or 1;
        u84.Parent = p78.folder;
        local os_clock_ret = os.clock();

        local function go() -- Line: 552
            -- upvalues: u84 (copy), u82 (copy), u80 (copy), TweenService (ref)
            if not u84.Parent then
                return;
            end;

            u84.TimePosition = u82[3];
            u84:Play();
            task.delay(u82[4] / (u80 or 1), function() -- Line: 558
                -- upvalues: u84 (ref), TweenService (ref)
                if u84.Parent then
                    TweenService:Create(u84, TweenInfo.new(0.08), {
                        Volume = 0
                    }):Play();
                    task.delay(0.1, function() -- Line: 561
                        -- upvalues: u84 (ref)
                        u84:Destroy();
                    end);
                end;
            end);
        end;

        if not u84.IsLoaded then
            u84.Loaded:Once(function() -- Line: 571
                -- upvalues: os_clock_ret (copy), u84 (copy), u82 (copy), u80 (copy), TweenService (ref)
                if os.clock() - os_clock_ret >= 0.5 then
                    u84:Destroy();

                    return;
                end;

                if not u84.Parent then
                    return;
                end;

                u84.TimePosition = u82[3];
                u84:Play();
                task.delay(u82[4] / (u80 or 1), function() -- Line: 558
                    -- upvalues: u84 (ref), TweenService (ref)
                    if u84.Parent then
                        TweenService:Create(u84, TweenInfo.new(0.08), {
                            Volume = 0
                        }):Play();
                        task.delay(0.1, function() -- Line: 561
                            -- upvalues: u84 (ref)
                            u84:Destroy();
                        end);
                    end;
                end);
            end);
            task.delay(3, function() -- Line: 578
                -- upvalues: u84 (copy)
                if u84.Parent and not u84.IsPlaying then
                    u84:Destroy();
                end;
            end);

            return u84;
        end;

        if not u84.Parent then
            return u84;
        end;

        u84.TimePosition = u82[3];
        u84:Play();
        task.delay(u82[4] / (u80 or 1), function() -- Line: 558
            -- upvalues: u84 (copy), TweenService (ref)
            if u84.Parent then
                TweenService:Create(u84, TweenInfo.new(0.08), {
                    Volume = 0
                }):Play();
                task.delay(0.1, function() -- Line: 561
                    -- upvalues: u84 (ref)
                    u84:Destroy();
                end);
            end;
        end);

        return u84;
    end
};

function u85.cue(u86, u87, p88, u89) -- Line: 587
    -- upvalues: u8 (copy), u85 (copy), u17 (ref)
    local v90 = u8[u87];

    if not v90 then
        return;
    end;

    local v91 = p88 - os.clock() - (v90[5] or 0) / (u89 or 1);

    if v91 <= 0.01 then
        u85.play(u86, u87, u89);

        return;
    end;

    task.delay(v91, function() -- Line: 596
        -- upvalues: u17 (ref), u86 (copy), u85 (ref), u87 (copy), u89 (copy)
        if u17 == u86 and not u86.finishing then
            u85.play(u86, u87, u89);
        end;
    end);
end;

local u92 = nil;

local function config() -- Line: 606
    -- upvalues: u92 (ref), Game (copy)
    if u92 == nil then
        local GhostTraderConfig = Game:FindFirstChild("GhostTraderConfig");

        if not GhostTraderConfig then
            return nil;
        end;

        local success, result = pcall(require, GhostTraderConfig);

        if not success then
            warn("[GhostTrader] Game.GhostTraderConfig didn\'t load: " .. tostring(result));
        end;

        if not success or type(result) ~= "table" then
            result = false;
        end;

        u92 = result;
    end;

    return u92 or nil;
end;

local function rarityColor(p93) -- Line: 620
    -- upvalues: config (copy), u10 (copy), Color3_fromRGB_ret (copy)
    local v94 = config();

    if v94 then
        if type(v94.RarityColors) == "table" then
            v94 = v94.RarityColors[p93];
        else
            v94 = false;
        end;
    end;

    if typeof(v94) == "Color3" then
        return v94;
    end;

    return u10[p93] or Color3_fromRGB_ret;
end;

function u13.notice(u95) -- Line: 628
    -- upvalues: u17 (ref), ChickenOrHero (copy), Presentation (copy)
    task.spawn(function() -- Line: 629
        -- upvalues: u17 (ref), ChickenOrHero (ref), Presentation (ref), u95 (copy)
        local os_clock_ret = os.clock();

        while u17 and os.clock() - os_clock_ret < 4 do
            task.wait(0.1);
        end;

        local success, result = pcall(function() -- Line: 635
            -- upvalues: ChickenOrHero (ref), Presentation (ref), u95 (ref)
            local v96;

            if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).awaitUIVersion() == "NewGui" then
                v96 = ChickenOrHero:WaitForChild("Interface"):WaitForChild("Toasts", 5);
            else
                v96 = Presentation:WaitForChild("ValleyToast", 5);
            end;

            require(v96).show(u95);
        end);

        if not success then
            warn("[GhostTrader] notice: " .. tostring(result));
        end;
    end);
end;

local u97 = {
    checked = false,
    ok = false,
    folder = nil
};

local function checkArt() -- Line: 653
    -- upvalues: u97 (copy), ReplicatedStorage (copy), ContentProvider (copy)
    if u97.checked then
        return;
    end;

    u97.checked = true;
    task.spawn(function() -- Line: 658
        -- upvalues: ReplicatedStorage (ref), ContentProvider (ref), u97 (ref)
        local GhostTraderAssets = ReplicatedStorage:FindFirstChild("GhostTraderAssets");

        if GhostTraderAssets then
            GhostTraderAssets = GhostTraderAssets:FindFirstChild("Cards");
        end;

        if not GhostTraderAssets then
            warn("[GhostTrader] ReplicatedStorage.GhostTraderAssets.Cards is missing: plain glowing cards instead");

            return;
        end;

        local u98 = { GhostTraderAssets };

        for _, descendant in GhostTraderAssets:GetDescendants() do
            if descendant:IsA("SurfaceAppearance") then
                local success, result = pcall(function() -- Line: 669
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
                    table.insert(u98, ImageLabel);
                end;
            end;
        end;

        local u99 = {};
        local success, result = pcall(function() -- Line: 678
            -- upvalues: ContentProvider (ref), u98 (copy), u99 (copy)
            ContentProvider:PreloadAsync(u98, function(p100, p101) -- Line: 679
                -- upvalues: u99 (ref)
                if p101 ~= Enum.AssetFetchStatus.Success then
                    local v102 = tostring(p100) .. " " .. p101.Name;
                    table.insert(u99, v102);
                end;
            end);
        end);

        for _, v in u98 do
            if v:IsA("ImageLabel") then
                v:Destroy();
            end;
        end;

        if success and #u99 == 0 then
            u97.folder = GhostTraderAssets;
            u97.ok = true;

            return;
        end;

        local l_warn = warn;
        local v103;

        if success then
            v103 = table.concat(u99, ", ");
        else
            v103 = tostring(result);
        end;

        l_warn("[GhostTrader] the card art didn\'t load (" .. v103 .. "); plain glowing cards instead");
    end);
end;

local function slotPose(p104, p105, p106, p107, p108) -- Line: 703
    local v109 = (p107 - 1) / 2;
    local v110 = v109 <= 0 and 0 or (p106 - 1 - v109) / v109;
    local RightVector = p105.RightVector;
    local UpVector = p105.UpVector;
    local v111 = p104 + RightVector * (v110 * v109 * 0.8 * p108) - UpVector * (v110 * v110 * 0.24 * p108);
    local v112 = p105.Position - v111;
    local v113 = -p105.LookVector;

    if v112.Magnitude > 0.0001 then
        v113 = v112.Unit;
    end;

    local v114 = UpVector * math.cos(0.15707963267948966 * v110) + RightVector * math.sin(0.15707963267948966 * v110);

    return CFrame.lookAt(v111, v111 + v113, v114);
end;

local function arc(p115, p116) -- Line: 713
    local v117 = p115:Cross(p116);
    local v118 = p115:Dot(p116);
    local math_clamp_ret = math.clamp(v118, -1, 1);

    if v117.Magnitude >= 1e-6 then
        return CFrame.fromAxisAngle(v117.Unit, (math.acos(math_clamp_ret)));
    end;

    if math_clamp_ret > 0 then
        return CFrame.identity;
    end;

    local v119 = math.abs(p115.X) < 0.9 and Vector3.new(1, 0, 0) or Vector3.new(0, 0, 1);

    return CFrame.fromAxisAngle(p115:Cross(v119).Unit, 3.141592653589793);
end;

local function aimC0(p120, p121, p122, p123, p124, p125) -- Line: 727
    -- upvalues: arc (copy)
    if p125 <= 0 then
        return p120;
    end;

    local v126 = p123:VectorToObjectSpace(p124 - (p123 * p120).Position);
    local v127 = (p120 * p121:Inverse()):VectorToWorldSpace(p122 - p121.Position);

    if v126.Magnitude < 0.05 or v127.Magnitude < 0.05 then
        return p120;
    end;

    return p120:Lerp(CFrame.new(p120.Position) * arc(v127.Unit, v126.Unit) * p120.Rotation, (math.clamp(p125, 0, 1)));
end;

local function aimArm(p128, p129, p130, p131) -- Line: 743
    -- upvalues: aimC0 (copy)
    local C1 = p128.motor.C1;
    local v132 = (p129 * aimC0(p128.c0, C1, p128.hand, p129, p130, 1) * C1:Inverse()):VectorToWorldSpace(p128.side or Vector3.new(0, 0, 0));

    return aimC0(p128.c0, C1, p128.hand, p129, p130 - v132, p131);
end;

local function topOf(p133) -- Line: 750
    local CFrame2 = p133.CFrame;
    local Size = p133.Size;

    local function extent(p134) -- Line: 752
        -- upvalues: CFrame2 (copy), Size (copy)
        local v135 = CFrame2.XVector:Dot(p134);
        local v136 = math.abs(v135) * Size.X;
        local v137 = CFrame2.YVector:Dot(p134);
        local v138 = v136 + math.abs(v137) * Size.Y;
        local v139 = CFrame2.ZVector:Dot(p134);

        return v138 + math.abs(v139) * Size.Z;
    end;

    local v140 = p133.Position + Vector3.new(0, 1, 0) * (extent(Vector3.new(0, 1, 0)) / 2);
    local v141 = extent(Vector3.new(1, 0, 0));
    local v142 = extent(Vector3.new(0, 0, 1));

    return v140, math.min(v141, v142) / 2;
end;

local function project(p143, p144, p145, p146) -- Line: 758
    local v147 = p143:PointToObjectSpace(p146);
    local v148 = -v147.Z;
    local math_rad_ret = math.rad(p144 / 2);
    local math_tan_ret = math.tan(math_rad_ret);

    return Vector2.new(0.5 + v147.X / v148 / (math_tan_ret * p145) / 2, 0.5 - v147.Y / v148 / math_tan_ret / 2), v148;
end;

local function unproject(p149, p150, p151, p152, p153) -- Line: 765
    -- upvalues: u3 (ref)
    local math_rad_ret = math.rad(u3 / 2);
    local math_tan_ret = math.tan(math_rad_ret);

    return p149.Position + p149:VectorToWorldSpace((Vector3.new((p151 * 2 - 1) * math_tan_ret * p150, (1 - p152 * 2) * math_tan_ret, -1))) * p153;
end;

local function onScreen(p154, p155, p156) -- Line: 770
    -- upvalues: u3 (ref)
    local math_rad_ret = math.rad(u3 / 2);
    local math_tan_ret = math.tan(math_rad_ret);

    return Vector2.new(p156.X / (p155 * 2 * math_tan_ret * p154), p156.Y / (p155 * 2 * math_tan_ret));
end;

local function panelAt(p157, p158, p159, p160, p161) -- Line: 775
    -- upvalues: u3 (ref)
    local math_rad_ret = math.rad(u3 / 2);
    local math_tan_ret = math.tan(math_rad_ret);
    local v162 = p157.Position + p157:VectorToWorldSpace((Vector3.new((p159 * 2 - 1) * math_tan_ret * p158, (1 - p160 * 2) * math_tan_ret, -1))) * p161;

    return CFrame.lookAt(v162, v162 - p157.LookVector, p157.UpVector);
end;

local function outline(p163, p164, p165, p166) -- Line: 780
    -- upvalues: project (copy), u3 (ref)
    local v167 = { (1 / 0), (-1 / 0), (1 / 0), (-1 / 0) };
    local v168 = true;

    for _, v in { -1, 1 } do
        local v169 = v;

        for _, v2 in { -1, 1 } do
            local v170 = v2;

            for _, v3 in { -1, 1 } do
                local v171, v172 = project(p163, u3, p164, (p165 * CFrame.new(p166.X * v169, p166.Y * v170, p166.Z * v3)).Position);

                if v168 then
                    v168 = v172 > 0.2;
                end;

                local math_min_ret = math.min(v167[1], v171.X);
                local math_max_ret = math.max(v167[2], v171.X);
                v167[1] = math_min_ret;
                v167[2] = math_max_ret;
                local math_min_ret2 = math.min(v167[3], v171.Y);
                local math_max_ret2 = math.max(v167[4], v171.Y);
                v167[3] = math_min_ret2;
                v167[4] = math_max_ret2;
            end;
        end;
    end;

    return v167, v168;
end;

local function covered(p173, p174) -- Line: 795
    local v175 = math.min(p173[2], p174[2]) - math.max(p173[1], p174[1]);
    local math_max_ret = math.max(0, v175);
    local v176 = math.min(p173[4], p174[4]) - math.max(p173[3], p174[3]);

    return math_max_ret * math.max(0, v176);
end;

local function fanEnvelope(p177, p178, p179, p180, p181) -- Line: 801
    -- upvalues: slotPose (copy), outline (copy)
    local v182 = Vector3.new(0.6179481, 0.70225, 0.05) * p181;
    local v183 = { (1 / 0), (-1 / 0), (1 / 0), (-1 / 0) };

    for i = 1, 6 do
        local v184 = slotPose(p180, p179, i, 6, p181);
        local CFrame_lookAt_ret = CFrame.lookAt(v184.Position, p177.Position, v184.UpVector);
        local _ = i;

        for _, v in { CFrame_lookAt_ret, CFrame_lookAt_ret + CFrame_lookAt_ret.LookVector * (0.48 * p181) + Vector3.new(0, 1, 0) * (0.15 * p181) } do
            local v185 = outline(p177, p178, v, v182);
            v183 = {
                math.min(v183[1], v185[1]),
                math.max(v183[2], v185[2]),
                math.min(v183[3], v185[3]),
                (math.max(v183[4], v185[4]))
            };
        end;
    end;

    return v183;
end;

local function areaOf(p186) -- Line: 814
    return math.max(1e-6, (p186[2] - p186[1]) * (p186[4] - p186[3]));
end;

local function outside(p187) -- Line: 817
    return math.max(0, 0.015 - p187[1]) + math.max(0, p187[2] - 0.985) + math.max(0, 0.015 - p187[3]) + math.max(0, p187[4] - 0.985);
end;

local function bodyBoxes(p188, p189, p190) -- Line: 825
    -- upvalues: outline (copy)
    local v191 = {};

    for _, v in p190 do
        local v192, v193 = outline(p188, p189, v[1], v[2] / 2);

        if v193 then
            table.insert(v191, v192);
        end;
    end;

    return v191;
end;

local function clearOf(p194, p195, p196) -- Line: 842
    local v197 = 0;

    for _, v in p194 do
        if p195 < v[4] and v[3] < p196 then
            v197 = math.max(v197, v[2]);
        end;
    end;

    return v197 <= 0 and 0 or v197 + 0.012;
end;

local function studsFor(p198, p199, p200, p201) -- Line: 852
    -- upvalues: u3 (ref)
    local math_rad_ret = math.rad(u3 / 2);
    local math_tan_ret = math.tan(math_rad_ret);

    return Vector3.new(p200 * p199 * 2 * math_tan_ret * p198, p201 * p199 * 2 * math_tan_ret, 0.03);
end;

local function placardLayout(p202, p203) -- Line: 860
    -- upvalues: u5 (copy)
    local PLACARD_RIGHT = u5.PLACARD_RIGHT;
    local v204 = u5.PLACARD_LEFT[1];
    local v205 = u5.PLACARD_LEFT[2];
    local v206 = PLACARD_RIGHT - (v204.Y + (v205.Y - v204.Y) * math.clamp((p203 - v204.X) / (v205.X - v204.X), 0, 1));
    local X = u5.PLACARD.X;
    local Y = u5.PLACARD.Y;
    local PLACARD_GAP = u5.PLACARD_GAP;
    local v207;

    if v206 / (p202 * X + (p202 - 1) * PLACARD_GAP) < u5.PLACARD_SHRINK then
        v207 = math.ceil(p202 / 2);
    else
        v207 = p202;
    end;

    local math_ceil_ret = math.ceil(p202 / v207);
    local v208 = v207 * X + (v207 - 1) * PLACARD_GAP;
    local math_min_ret = math.min(1, v206 / v208);
    local v209 = X * math_min_ret;
    local v210 = Y * math_min_ret;
    local v211 = PLACARD_GAP * math_min_ret;
    local v212 = v208 * math_min_ret;
    local v213 = u5.PLACARD_BOTTOM - math_ceil_ret * v210 - (math_ceil_ret - 1) * v211;
    local v214 = {};

    for i = 1, p202 do
        local v215 = PLACARD_RIGHT - v212 + (i - 1) % v207 * (v209 + v211);
        local v216 = v213 + (i - 1) // v207 * (v210 + v211);
        v214[i] = {
            box = {
                v215,
                v215 + v209,
                v216,
                v216 + v210
            }
        };
        local _ = i;
    end;

    return v214, v213;
end;

local function composeShot(p217, p218, u219, u220, p221) -- Line: 897
    -- upvalues: u27 (copy), u3 (ref), project (copy), Vector2_new_ret (copy)
    local v222 = u219 - p218;
    local Vector3_new_ret = Vector3.new(v222.X, 0, v222.Z);
    local v223 = Vector3_new_ret.Magnitude <= 0.0001 and Vector3.new(1, 0, 0) or Vector3_new_ret.Unit;
    local v224 = v223:Cross(Vector3.new(0, 1, 0));
    local v225 = p218 - v223 * 1 + v224 * 3.4 + Vector3.new(0, 2.8, 0);

    if p217.camera then
        v225 = p217.camera.WorldPosition;
    end;

    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = p221;

    for i = 1, 3 do
        local _ = i;
        local v226 = nil;

        for _, v in { u219, p218 + Vector3.new(0, 1.5, 0) } do
            local v227 = u27.cast(v225, v - v225, RaycastParams_new_ret);

            if v227 and v227.Instance.Transparency < 0.95 then
                v226 = v227;
                break;
            end;
        end;

        if not v226 then
            break;
        end;

        warn("[GhostTrader] " .. v226.Instance:GetFullName() .. " blocks the card view\'s camera; moving it in front");
        v225 = v226.Position + (u219 - v225).Unit * 0.5;
    end;

    u3 = 46;

    return (function(p228) -- Line: 925, Name: aim
        -- upvalues: u3 (ref), u219 (copy), project (ref), u220 (copy), Vector2_new_ret (ref)
        local math_rad_ret = math.rad(u3 / 2);
        local math_tan_ret = math.tan(math_rad_ret);
        local CFrame_lookAt_ret = CFrame.lookAt(p228, u219);

        for i = 1, 4 do
            local v229 = project(CFrame_lookAt_ret, u3, u220, u219);
            local v230 = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), (math.atan((Vector2_new_ret.X - v229.X) * 2 * math_tan_ret * u220))) * CFrame.fromAxisAngle(CFrame_lookAt_ret.RightVector, (math.atan((Vector2_new_ret.Y - v229.Y) * 2 * math_tan_ret)));
            CFrame_lookAt_ret = CFrame.lookAt(p228, p228 + v230:VectorToWorldSpace(CFrame_lookAt_ret.LookVector));
            local _ = i;
        end;

        return CFrame_lookAt_ret;
    end)(v225), v223;
end;

u13._math = {
    composeShot = composeShot,
    slotPose = slotPose,
    aimC0 = aimC0,
    topOf = topOf,
    placardLayout = placardLayout,

    panelBetween = function(p231, p232, p233, p234, p235, p236, p237, p238, p239) -- Line: 885, Name: panelBetween
        -- upvalues: u3 (ref)
        local math_max_ret = math.max(0.025, p239 or 0);
        local math_max_ret2 = math.max(0.3, 0.975 - math_max_ret);
        local math_min_ret = math.min(p236, math_max_ret2);
        local math_min_ret2 = math.min(math_max_ret, 0.975 - math_min_ret);
        local math_max_ret3 = math.max(math_min_ret2 + math_min_ret / 2, 0.975 - math_min_ret / 2);
        local math_clamp_ret = math.clamp(p233, math_min_ret2 + math_min_ret / 2, math_max_ret3);
        local math_max_ret4 = math.max(0.03, p235 - 0.012 - p237);
        local math_clamp_ret2 = math.clamp(p234 + 0.012, 0.03, math_max_ret4);
        local math_rad_ret = math.rad(u3 / 2);
        local math_tan_ret = math.tan(math_rad_ret);
        local v240 = p231.Position + p231:VectorToWorldSpace((Vector3.new((math_clamp_ret * 2 - 1) * math_tan_ret * p232, (1 - (math_clamp_ret2 + p237 / 2) * 2) * math_tan_ret, -1))) * p238;
        local CFrame_lookAt_ret = CFrame.lookAt(v240, v240 - p231.LookVector, p231.UpVector);
        local math_rad_ret2 = math.rad(u3 / 2);
        local math_tan_ret2 = math.tan(math_rad_ret2);

        return CFrame_lookAt_ret, Vector3.new(math_min_ret * p238 * 2 * math_tan_ret2 * p232, p237 * p238 * 2 * math_tan_ret2, 0.03), {
            math_clamp_ret - math_min_ret / 2,
            math_clamp_ret + math_min_ret / 2,
            math_clamp_ret2,
            math_clamp_ret2 + p237
        };
    end,

    bodyBoxes = bodyBoxes,

    behindBody = function(p241, p242) -- Line: 835, Name: behindBody
        local v243 = 0;

        for _, v in p241 do
            local v244 = math.min(p242[2], v[2]) - math.max(p242[1], v[1]);
            local math_max_ret = math.max(0, v244);
            local v245 = math.min(p242[4], v[4]) - math.max(p242[3], v[3]);
            v243 = v243 + math_max_ret * math.max(0, v245);
        end;

        local v246 = v243 / math.max(1e-6, (p242[2] - p242[1]) * (p242[4] - p242[3]));

        return math.min(1, v246);
    end,

    clearOf = clearOf,
    project = project,
    outline = outline
};

local function spotsOf(u247) -- Line: 955
    local function find(p248, p249) -- Line: 956
        -- upvalues: u247 (copy)
        local v250 = u247:FindFirstChild(p248, true);

        if v250 and v250:IsA(p249) then
            return v250;
        end;

        return nil;
    end;

    local Table = u247:FindFirstChild("Table", true);

    if not (Table and Table:IsA("BasePart")) then
        Table = nil;
    end;

    local Lantern = u247:FindFirstChild("Lantern", true);

    if not (Lantern and Lantern:IsA("BasePart")) then
        Lantern = nil;
    end;

    local CardAnchor = u247:FindFirstChild("CardAnchor", true);

    if not (CardAnchor and CardAnchor:IsA("Attachment")) then
        CardAnchor = nil;
    end;

    if not (Table and Lantern) then
        return nil;
    end;

    local Trader = u247:FindFirstChild("Trader");

    if Trader then
        Trader = Trader:FindFirstChild("Head");
    end;

    local v251 = {
        model = u247,
        table = Table,
        lantern = Lantern,
        anchor = CardAnchor
    };
    local StandSpot = u247:FindFirstChild("StandSpot", true);

    if not (StandSpot and StandSpot:IsA("Attachment")) then
        StandSpot = nil;
    end;

    v251.stand = StandSpot;
    local CameraSpot = u247:FindFirstChild("CameraSpot", true);

    if not (CameraSpot and CameraSpot:IsA("Attachment")) then
        CameraSpot = nil;
    end;

    v251.camera = CameraSpot;

    if not (Trader and Trader:IsA("BasePart")) then
        Trader = nil;
    end;

    v251.face = Trader;

    return v251;
end;

local function fanCentre(p252, p253) -- Line: 980
    -- upvalues: topOf (copy)
    if p252.anchor then
        return p252.anchor.WorldPosition + Vector3.new(0, 0.8, 0);
    end;

    local v254 = topOf(p252.table);
    local v255 = p253 - v254;
    local Vector3_new_ret = Vector3.new(v255.X, 0, v255.Z);

    return v254 + (Vector3_new_ret.Magnitude <= 0.0001 and Vector3.new(0, 0, 1) or Vector3_new_ret.Unit) * 1.1 + Vector3.new(0, 2.25, 0);
end;

local function standFor(p256, p257, p258) -- Line: 991
    -- upvalues: topOf (copy), u27 (copy)
    local Position = p258.Position;
    local v259;

    if p256.anchor then
        v259 = p256.anchor.WorldPosition + Vector3.new(0, 0.8, 0);
    else
        local v260 = topOf(p256.table);
        local v261 = Position - v260;
        local Vector3_new_ret = Vector3.new(v261.X, 0, v261.Z);
        v259 = v260 + (Vector3_new_ret.Magnitude <= 0.0001 and Vector3.new(0, 0, 1) or Vector3_new_ret.Unit) * 1.1 + Vector3.new(0, 2.25, 0);
    end;

    local stand = p256.stand;

    if not stand then
        local CFrame_lookAt = CFrame.lookAt;
        local Position2 = p258.Position;
        local Position3 = p258.Position;
        local v262 = v259 - p258.Position;
        local Vector3_new_ret = Vector3.new(v262.X, 0, v262.Z);
        local LookVector = p258.CFrame.LookVector;

        if Vector3_new_ret.Magnitude > 0.0001 then
            LookVector = Vector3_new_ret.Unit;
        end;

        return CFrame_lookAt(Position2, Position3 + LookVector);
    end;

    local v263 = p257:FindFirstChildOfClass("Humanoid");
    local v264 = p257:FindFirstChild("Left Leg") or p257:FindFirstChild("Right Leg");
    local v265;

    if v263 and v263.RigType == Enum.HumanoidRigType.R15 then
        v265 = v263.HipHeight + p258.Size.Y / 2;
    elseif v263 and (v264 and v264:IsA("BasePart")) then
        v265 = p258.Size.Y / 2 + v264.Size.Y + v263.HipHeight;
    else
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { p257 };
        local v266 = u27.cast(p258.Position, Vector3.new(0, -12, 0), RaycastParams_new_ret);
        v265 = not v266 and 3 or p258.Position.Y - v266.Position.Y;
    end;

    local math_clamp_ret = math.clamp(v265, 1.5, 6);
    local v267 = stand.WorldPosition + Vector3.new(0, 1, 0) * math_clamp_ret;
    local CFrame_lookAt = CFrame.lookAt;
    local v268 = v259 - v267;
    local Vector3_new_ret = Vector3.new(v268.X, 0, v268.Z);
    local LookVector = stand.WorldCFrame.LookVector;

    if Vector3_new_ret.Magnitude > 0.0001 then
        LookVector = Vector3_new_ret.Unit;
    end;

    return CFrame_lookAt(v267, v267 + LookVector);
end;

local function frameFor(p269, p270, p271) -- Line: 1018
    -- upvalues: standFor (copy), topOf (copy), composeShot (copy), project (copy), u3 (ref), fanEnvelope (copy), u2 (copy), outline (copy)
    local HumanoidRootPart = p270:FindFirstChild("HumanoidRootPart");
    local v272 = standFor(p269.spots, p270, HumanoidRootPart);
    p269.stand = v272;
    local spots = p269.spots;
    local Position = v272.Position;
    local v273;

    if spots.anchor then
        v273 = spots.anchor.WorldPosition + Vector3.new(0, 0.8, 0);
    else
        local v274 = topOf(spots.table);
        local v275 = Position - v274;
        local Vector3_new_ret = Vector3.new(v275.X, 0, v275.Z);
        v273 = v274 + (Vector3_new_ret.Magnitude <= 0.0001 and Vector3.new(0, 0, 1) or Vector3_new_ret.Unit) * 1.1 + Vector3.new(0, 2.25, 0);
    end;

    local v276, v277 = topOf(p269.spots.table);
    local v278 = { p270, p269.spots.table.Parent };

    if p269.folder then
        table.insert(v278, p269.folder);
    end;

    local v279, v280 = composeShot(p269.spots, v272.Position, v273, p271, v278);
    local _, v281 = project(v279, u3, p271, v273);
    local v282 = 1;

    for i = 1, 3 do
        local v283 = fanEnvelope(v279, p271, v279, v273, v282);
        local v284 = v282 * math.min((u2[2] - u2[1]) / (v283[2] - v283[1]), (u2[4] - u2[3]) / (v283[4] - v283[3]));
        v282 = math.clamp(v284, 0.5, 2.5);
        local v285 = fanEnvelope(v279, p271, v279, v273, v282);
        local v286 = project(v279, u3, p271, v273);
        local v287 = v286.X + (u2[1] + u2[2]) / 2 - (v285[1] + v285[2]) / 2;
        local v288 = v286.Y + (u2[3] + u2[4]) / 2 - (v285[3] + v285[4]) / 2;
        local math_rad_ret = math.rad(u3 / 2);
        local math_tan_ret = math.tan(math_rad_ret);
        v273 = v279.Position + v279:VectorToWorldSpace((Vector3.new((v287 * 2 - 1) * math_tan_ret * p271, (1 - v288 * 2) * math_tan_ret, -1))) * v281;
        local _ = i;
    end;

    p269.shot = v279;
    p269.forward = v280;
    p269.fanAt = v273;
    p269.fanScale = v282;
    p269.aspect = p271;
    p269.fov = u3;
    p269.towardFan = -v280;
    local v289 = v279.Position - v276;
    local Vector3_new_ret = Vector3.new(v289.X, 0, v289.Z);
    local v290 = -v280;

    if Vector3_new_ret.Magnitude > 0.0001 then
        v290 = Vector3_new_ret.Unit;
    end;

    p269.towardCamera = v290;
    p269.top = v276;
    p269.radius = v277;
    p269.edge = v276 + p269.towardCamera * v277;
    p269.fanBottom = v273 - Vector3.new(0, 1, 0) * (v282 * 0.865);
    local v291 = HumanoidRootPart.CFrame:Inverse();
    local v292 = {};

    for _, descendant in p270:GetDescendants() do
        if descendant:IsA("BasePart") and (descendant.Transparency < 0.95 and descendant.Name ~= "HumanoidRootPart") then
            local v293;

            if descendant.Name == "Head" and descendant:FindFirstChildOfClass("SpecialMesh") then
                v293 = Vector3.new(1, 1, 1) * math.min(descendant.Size.Y * 1.25, descendant.Size.X);
            else
                v293 = descendant.Size;
            end;

            table.insert(v292, { v272 * v291 * descendant.CFrame, v293, descendant });
        end;
    end;

    local v294 = {};

    for _, v in v292 do
        local _, v295 = outline(v279, p271, v[1], v[2] / 2);

        if not v295 then
            table.insert(v294, v[3]:GetFullName());
        end;
    end;

    if #v294 > 0 then
        warn("[GhostTrader] the odds card doesn\'t keep clear of what reaches the card view\'s camera: " .. table.concat(v294, ", ", 1, (math.min(#v294, 5))));
    end;

    p269.bodyParts = v292;
    local Trader = p269.spots.model:FindFirstChild("Trader");
    local v296 = nil;

    for _, v in not Trader and {} or Trader:GetDescendants() do
        if v:IsA("BasePart") and v.Transparency < 0.9 then
            local v297 = outline(v279, p271, v.CFrame, v.Size / 2);

            if v296 then
                v296 = {
                    math.min(v296[1], v297[1]),
                    math.max(v296[2], v297[2]),
                    math.min(v296[3], v297[3]),
                    (math.max(v296[4], v297[4]))
                };
            else
                v296 = v297;
            end;
        end;
    end;

    p269.ghostBox = v296;
    p269.view = v279;
end;

local function cardSize() -- Line: 1083
    return Vector3.new(0.74394464, 1.25, 0.02);
end;

local function addLayer(p298, p299, p300) -- Line: 1086
    p299.Anchored = true;
    p299.CanCollide = false;
    p299.CanTouch = false;
    p299.CanQuery = false;
    p299.CastShadow = false;
    p299.Parent = p298.model;
    local v301 = {
        part = p299,
        offset = p300,
        size = p299.Size
    };
    table.insert(p298.layers, v301);
    p298.scale = nil;

    return v301;
end;

local function dropLayer(p302, p303) -- Line: 1094
    if not p303 then
        return;
    end;

    local table_find_ret = table.find(p302.layers, p303);

    if table_find_ret then
        table.remove(p302.layers, table_find_ret);
    end;

    p303.part:Destroy();
end;

local function place(p304, p305, p306) -- Line: 1104
    local v307 = p304.scale ~= p306;
    local v308 = {};
    local v309 = {};

    for _, v in p304.layers do
        local offset = v.offset;
        table.insert(v308, v.part);
        local v310 = p305 * CFrame.new(offset.Position * p306) * offset.Rotation;
        table.insert(v309, v310);

        if v307 then
            v.part.Size = v.size * p306;
        end;
    end;

    p304.scale = p306;
    p304.frame = p305;
    workspace:BulkMoveTo(v308, v309, Enum.BulkMoveMode.FireCFrameChanged);
end;

local function surface(p311, p312, p313, p314, p315, p316) -- Line: 1121
    -- upvalues: u5 (copy)
    local SurfaceGui = Instance.new("SurfaceGui");
    SurfaceGui.Name = p314;
    SurfaceGui.Face = p313 or Enum.NormalId.Front;
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    SurfaceGui.PixelsPerStud = u5.PIXELS;
    SurfaceGui.LightInfluence = 0;
    SurfaceGui.Brightness = p316 or 1.2;
    SurfaceGui:SetAttribute("CreatorCaptureExempt", true);
    SurfaceGui.AlwaysOnTop = false;
    SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    SurfaceGui.ResetOnSpawn = false;
    SurfaceGui.ClipsDescendants = true;
    SurfaceGui.Adornee = p312;

    if p311.guiHome and (p315 or p311.allGuisHome) then
        p311.guiHome(SurfaceGui);
    else
        SurfaceGui.Parent = p312;
    end;

    table.insert(p311.guis, SurfaceGui);

    return SurfaceGui;
end;

local function stroke(p317, p318, p319) -- Line: 1145
    local v320 = {
        Color = p318,
        Thickness = p319,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";

    for i, v in v320 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p317;

    return UIStroke;
end;

local function textStroke(p321, p322, p323) -- Line: 1152
    local v324 = {
        Color = p322,
        Thickness = p323,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "TextStroke";

    for i, v in v324 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p321;

    return UIStroke;
end;

local function artPart(p325) -- Line: 1156
    -- upvalues: u97 (copy)
    local v326 = u97.ok and u97.folder and u97.folder:FindFirstChild(p325);

    if v326 then
        v326 = v326:FindFirstChildWhichIsA("MeshPart", true);
    end;

    if not v326 then
        return nil;
    end;

    local v327 = v326:Clone();
    v327.Size = v326.Size * (1.25 / math.max(v326.Size.Y, 0.01));

    return v327;
end;

local function plainPart(p328, p329, p330) -- Line: 1167
    -- upvalues: Color3_fromRGB_ret4 (copy), surface (copy)
    local v331 = {
        Size = Vector3.new(0.74394464, 1.25, 0.02),
        Material = Enum.Material.SmoothPlastic,
        Color = Color3_fromRGB_ret4
    };
    local Part = Instance.new("Part");
    Part.Name = "Plain";

    for i, v in v331 or {} do
        Part[i] = v;
    end;

    Part.Parent = nil;
    local v332 = surface(p328, Part, Enum.NormalId.Front, "Plain");
    v332.PixelsPerStud = 300;
    local v333 = {
        BackgroundColor3 = Color3.fromRGB(10, 26, 20):Lerp(p329, 0.12),
        Size = UDim2.new(1, -12, 1, -12),
        Position = UDim2.fromOffset(6, 6)
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Plate";

    for i, v in v333 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = v332;
    local v334 = {
        CornerRadius = UDim.new(0, 14)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v334 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v335 = {
        Thickness = 5,
        Color = p329,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";

    for i, v in v335 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;

    if p330 then
        local v336 = {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.44),
            Size = UDim2.fromScale(0.3, 0.3),
            BackgroundColor3 = p329
        };
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "Keyhole";

        for i, v in v336 or {} do
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
        local v337 = {
            CornerRadius = UDim.new(0.5, 0)
        };
        local UICorner2 = Instance.new("UICorner");
        UICorner2.Name = "UICorner";

        for i, v in v337 or {} do
            UICorner2[i] = v;
        end;

        UICorner2.Parent = Frame2;
        local v338 = {
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromScale(0.5, 0.48),
            Size = UDim2.fromScale(0.1, 0.2),
            BackgroundColor3 = p329
        };
        local Frame3 = Instance.new("Frame");
        Frame3.Name = "Slot";

        for i, v in v338 or {} do
            Frame3[i] = v;
        end;

        Frame3.Parent = Frame;
    end;

    return Part;
end;

local function setFace(p339, p340) -- Line: 1198
    -- upvalues: plainPart (copy), CFrame_Angles_ret (copy)
    if p340.plain and not p340.face then
        local v341 = plainPart(p339, p340.style.glow, false);
        local v342 = CFrame.new(0, 0, 0.012) * CFrame_Angles_ret;
        v341.Anchored = true;
        v341.CanCollide = false;
        v341.CanTouch = false;
        v341.CanQuery = false;
        v341.CastShadow = false;
        v341.Parent = p340.model;
        local v343 = {
            part = v341,
            offset = v342,
            size = v341.Size
        };
        table.insert(p340.layers, v343);
        p340.scale = nil;
        p340.face = v343;
    end;
end;

local function faceGlow(p344, p345) -- Line: 1204
    -- upvalues: u11 (copy)
    local v346 = u11.RARITY[p345];

    return v346 and v346.glow or p344.style.glow;
end;

local function setLabel(p347, p348, p349) -- Line: 1210
    -- upvalues: u11 (copy), CFrame_Angles_ret (copy), surface (copy), Font_fromEnum_ret (copy), u50 (copy), u6 (copy), u9 (copy), Font_fromEnum_ret2 (copy)
    local label = p348.label;

    if label then
        local table_find_ret = table.find(p348.layers, label);

        if table_find_ret then
            table.remove(p348.layers, table_find_ret);
        end;

        label.part:Destroy();
    end;

    p348.label = nil;

    if type(p349) ~= "table" then
        return;
    end;

    local style = p348.style;
    local v350 = u11.RARITY[p349.rarity] or u11.RARITY.Common;
    local v351;

    if v350.ink == "accent" then
        v351 = style.accent;
    elseif v350.ink then
        v351 = v350.ink;
    else
        v351 = style.ink;
    end;

    local v352 = v350.glow or style.glow;
    local v353 = Vector3.new(0.74394464, 1.25, 0.02);
    local v354 = v353.X * 0.84;
    local v355 = v353.Y * 0.84;
    local v356 = {
        Transparency = 1,
        Size = Vector3.new(v354, v355, 0.002)
    };
    local Part = Instance.new("Part");
    Part.Name = "Print";

    for i, v in v356 or {} do
        Part[i] = v;
    end;

    Part.Parent = nil;
    local v357 = CFrame.new(0, 0, p348.reverse) * CFrame_Angles_ret;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    Part.Parent = p348.model;
    local v358 = {
        part = Part,
        offset = v357,
        size = Part.Size
    };
    table.insert(p348.layers, v358);
    p348.scale = nil;
    p348.label = v358;
    local u359 = surface(p347, Part, Enum.NormalId.Front, "Print", nil, 1.3);
    u359.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
    local PRINT_PIXELS = u11.PRINT_PIXELS;
    local math_floor_ret = math.floor(PRINT_PIXELS * v355 / v354 + 0.5);
    u359.CanvasSize = Vector2.new(PRINT_PIXELS, math_floor_ret);

    local function line(p360, p361, p362, p363, p364, p365) -- Line: 1229
        -- upvalues: u359 (copy), PRINT_PIXELS (copy), math_floor_ret (copy), style (copy)
        local v366 = {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(PRINT_PIXELS * 0.04, math_floor_ret * (p363 + style.drop)),
            Size = UDim2.fromOffset(PRINT_PIXELS * 0.92, math_floor_ret * p364),
            FontFace = p361,
            TextColor3 = p362
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = p360;

        for i, v in v366 or {} do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = u359;

        if p365 then
            local v367 = {
                Color = style.stroke,
                Thickness = p365,
                LineJoinMode = Enum.LineJoinMode.Round
            };
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Name = "Edge";

            for i, v in v367 or {} do
                UIStroke[i] = v;
            end;

            UIStroke.Parent = TextLabel;
        end;

        return TextLabel;
    end;

    local v368 = tostring(p349.kind or "");
    local v369 = (v368 == "Coins" or (v368 == "Candy" or v368 == "Gems")) and true or v368 == "Keys";
    local v370 = u11.REWARD_ICONS[p349.id] or u11.ICONS[v368];
    local v371 = line("Rarity", Font_fromEnum_ret, style.accent, 0.08, 0.09, 2.5);
    u50.line(v371, string.upper((tostring(p349.rarity or ""))), PRINT_PIXELS * 0.92, math_floor_ret * 0.09, math_floor_ret * 0.08);

    if v370 then
        local v372 = {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromOffset(PRINT_PIXELS / 2, math_floor_ret * (0.19 + style.drop)),
            Size = UDim2.fromOffset(math_floor_ret * 0.27, math_floor_ret * 0.27),
            Image = v370
        };
        local v373;

        if u11.REWARD_ICONS[p349.id] then
            v373 = Color3.new(1, 1, 1);
        else
            v373 = Color3.new(1, 1, 1):Lerp(v351, 0.35);
        end;

        v372.ImageColor3 = v373;
        v372.ScaleType = Enum.ScaleType.Fit;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Icon";

        for i, v in v372 or {} do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = u359;
    end;

    local v374 = tostring(p349.name or "Reward");

    if #v374 > 16 and u6.NAMES[p349.id] then
        v374 = u6.NAMES[p349.id];
    end;

    if v369 then
        v374 = string.gsub(v374, "^%+?[%d,]+%s+", "");
    end;

    if v368 == "Title" then
        v374 = string.gsub(v374, "%s+[Tt]itle$", "");
    end;

    local v375 = tonumber(p349.amount);
    local v376 = u11.KINDS[v368];
    local v377 = type(p349.duplicateGems) == "number";

    if v377 then
        v376 = "+" .. p349.duplicateGems .. " GEMS";
    end;

    if v369 and v375 then
        local math_floor_ret2 = math.floor(v375);
        local v378 = tostring(math_floor_ret2);
        local string_reverse_ret = string.reverse((string.gsub(string.reverse(v378), "(%d%d%d)", "%1,")));
        v376 = "+" .. string.gsub(string_reverse_ret, "^,", "");
    end;

    local v379 = v370 and 0.47 or 0.33;
    local v380 = v370 and 0.25 or 0.32;
    local v381 = v379 + v380 + 0.02;

    if not v370 and v376 then
        v379 = (v381 + 0.055 + 0.125) / 2 - v380 / 2;
    end;

    local v382 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(PRINT_PIXELS * 0.04, math_floor_ret * (v379 + style.drop)),
        Size = UDim2.fromOffset(PRINT_PIXELS * 0.92, math_floor_ret * v380),
        FontFace = Font_fromEnum_ret,
        TextColor3 = v352
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Glow";

    for i, v in v382 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = u359;
    TextLabel.TextTransparency = 0.4;
    local v383 = {
        Transparency = 0.55,
        Color = v352,
        Thickness = 5 * v350.halo,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Halo";

    for i, v in v383 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    if v350.shimmer then
        local v384 = {
            Color = u9.SHIMMER
        };
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Name = "Shimmer";

        for i, v in v384 or {} do
            UIGradient[i] = v;
        end;

        UIGradient.Parent = TextLabel;
    end;

    local v385 = line("Name", Font_fromEnum_ret, v351, v379, v380, 3);
    u50.fit(v385, string.upper(v374), PRINT_PIXELS * 0.92, math_floor_ret * v380, math_floor_ret * 0.15);
    local TextSize = v385.TextSize;
    TextLabel.Text = v385.Text;
    TextLabel.TextSize = TextSize;
    TextLabel.TextScaled = false;
    TextLabel.TextWrapped = false;

    if v376 then
        local v386 = line("Amount", Font_fromEnum_ret, style.accent, v381, 0.11, 2.5);
        u50.line(v386, v376, PRINT_PIXELS * 0.92, math_floor_ret * 0.11, math_floor_ret * ((v369 or v377) and 0.1 or 0.08));
    end;

    if v377 then
        local v387 = line("Duplicate", Font_fromEnum_ret2, style.accent, v381 + 0.11, 0.07, 2);
        u50.line(v387, "ALREADY OWNED", PRINT_PIXELS * 0.92, math_floor_ret * 0.07, math_floor_ret * 0.07);
    end;
end;

local function newCard(p388, p389, p390) -- Line: 1307
    -- upvalues: surface (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy), u11 (copy), artPart (copy), CFrame_fromMatrix_ret (copy), plainPart (copy), CFrame_Angles_ret (copy)
    local v391 = {
        h = 0,
        flip = 0,
        opened = false,
        phase = "unfold",
        slot = p389,
        cursed = p390,
        layers = {},
        t0 = os.clock()
    };
    local folder = p388.folder;
    local Model = Instance.new("Model");
    Model.Name = "Card" .. p389;

    for i, v in {} do
        Model[i] = v;
    end;

    Model.Parent = folder;
    v391.model = Model;
    local v392 = Vector3.new(0.74394464, 1.25, 0.02);
    local v393 = {
        Transparency = 1,
        Size = Vector3.new(v392.X, v392.Y, 0.1)
    };
    local Part = Instance.new("Part");
    Part.Name = "Hit";

    for i, v in v393 or {} do
        Part[i] = v;
    end;

    Part.Parent = nil;
    local CFrame_identity = CFrame.identity;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    Part.Parent = v391.model;
    local v394 = {
        part = Part,
        offset = CFrame_identity,
        size = Part.Size
    };
    table.insert(v391.layers, v394);
    v391.scale = nil;
    v391.hit = v394.part;
    v391.hit.CanQuery = true;
    v391.glowImages = {};

    for _, v in {
        { Enum.NormalId.Front, 0.025 },
        { Enum.NormalId.Back, -0.025 }
    } do
        local v395 = {
            Transparency = 1,
            Size = Vector3.new(v392.X * 1.9, v392.Y * 1.6, 0.006)
        };
        local Part2 = Instance.new("Part");
        Part2.Name = "Glow";
        local v396 = v;

        for i, v2 in v395 or {} do
            Part2[i] = v2;
        end;

        Part2.Parent = nil;
        local CFrame_new_ret = CFrame.new(0, 0, -0.012 + v396[2]);
        Part2.Anchored = true;
        Part2.CanCollide = false;
        Part2.CanTouch = false;
        Part2.CanQuery = false;
        Part2.CastShadow = false;
        Part2.Parent = v391.model;
        local v397 = {
            part = Part2,
            offset = CFrame_new_ret,
            size = Part2.Size
        };
        table.insert(v391.layers, v397);
        v391.scale = nil;
        local v398 = surface(p388, v397.part, v396[1], "Glow");
        v398.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
        v398.CanvasSize = Vector2.new(190, 160);
        v398.Brightness = 2;
        v398.ClipsDescendants = false;
        local glowImages = v391.glowImages;
        local v399 = {
            BackgroundTransparency = 1,
            Image = "rbxassetid://129028976496842",
            ImageTransparency = 0.45,
            Size = UDim2.fromScale(1, 1)
        };
        local v400;

        if p390 then
            v400 = Color3_fromRGB_ret3;
        else
            v400 = Color3_fromRGB_ret;
        end;

        v399.ImageColor3 = v400;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Glow";

        for i, v2 in v399 or {} do
            ImageLabel[i] = v2;
        end;

        ImageLabel.Parent = v398;
        table.insert(glowImages, ImageLabel);
    end;

    v391.style = u11.STYLES[p390 and "cursed" or "normal"];
    local v401 = artPart(v391.style.art);

    if v401 then
        local v402 = CFrame.new(0, 0, -0.012) * CFrame_fromMatrix_ret;
        v401.Anchored = true;
        v401.CanCollide = false;
        v401.CanTouch = false;
        v401.CanQuery = false;
        v401.CastShadow = false;
        v401.Parent = v391.model;
        local v403 = {
            part = v401,
            offset = v402,
            size = v401.Size
        };
        table.insert(v391.layers, v403);
        v391.scale = nil;
        v391.art = v403;
        v391.reverse = -0.012 + v401.Size.X / 2 + 0.003;
    else
        v391.plain = true;
        local v404;

        if p390 then
            v404 = Color3_fromRGB_ret3;
        else
            v404 = Color3_fromRGB_ret;
        end;

        local v405 = plainPart(p388, v404, true);
        local CFrame_new_ret = CFrame.new(0, 0, -0.012);
        v405.Anchored = true;
        v405.CanCollide = false;
        v405.CanTouch = false;
        v405.CanQuery = false;
        v405.CastShadow = false;
        v405.Parent = v391.model;
        table.insert(v391.layers, {
            part = v405,
            offset = CFrame_new_ret,
            size = v405.Size
        });
        v391.scale = nil;
        v391.reverse = 0.025;
    end;

    if v391.plain and not v391.face then
        local v406 = plainPart(p388, v391.style.glow, false);
        local v407 = CFrame.new(0, 0, 0.012) * CFrame_Angles_ret;
        v406.Anchored = true;
        v406.CanCollide = false;
        v406.CanTouch = false;
        v406.CanQuery = false;
        v406.CastShadow = false;
        v406.Parent = v391.model;
        local v408 = {
            part = v406,
            offset = v407,
            size = v406.Size
        };
        table.insert(v391.layers, v408);
        v391.scale = nil;
        v391.face = v408;
    end;

    return v391;
end;

local u409 = nil;

local function turnGold(p410, p411) -- Line: 1351
    -- upvalues: u11 (copy), artPart (copy), CFrame_fromMatrix_ret (copy), place (copy)
    if p411.cursed or p411.gold then
        return;
    end;

    p411.gold = true;
    p411.style = u11.STYLES.gold;
    local v412 = p411.art and artPart(p411.style.art);

    if v412 then
        local scale = p411.scale;
        local art = p411.art;

        if art then
            local table_find_ret = table.find(p411.layers, art);

            if table_find_ret then
                table.remove(p411.layers, table_find_ret);
            end;

            art.part:Destroy();
        end;

        local v413 = CFrame.new(0, 0, -0.012) * CFrame_fromMatrix_ret;
        v412.Anchored = true;
        v412.CanCollide = false;
        v412.CanTouch = false;
        v412.CanQuery = false;
        v412.CastShadow = false;
        v412.Parent = p411.model;
        local v414 = {
            part = v412,
            offset = v413,
            size = v412.Size
        };
        table.insert(p411.layers, v414);
        p411.scale = nil;
        p411.art = v414;

        if p411.frame and scale then
            place(p411, p411.frame, scale);
        end;
    end;

    for _, v in p411.glowImages do
        v.ImageColor3 = p411.style.glow;
    end;
end;

local function showOpened(p415, p416, p417) -- Line: 1371
    -- upvalues: u6 (copy), turnGold (copy), plainPart (copy), CFrame_Angles_ret (copy), setLabel (copy), u11 (copy), u409 (ref)
    p416.opened = true;

    if type(p417) ~= "table" then
        p417 = nil;
    end;

    p416.reward = p417;

    if p416.reward and (u6.ORDER[p416.reward.rarity] or 6) <= u6.ORDER.Legendary then
        turnGold(p415, p416);
    end;

    p416.flip = 1;

    if p416.plain and not p416.face then
        local v418 = plainPart(p415, p416.style.glow, false);
        local v419 = CFrame.new(0, 0, 0.012) * CFrame_Angles_ret;
        v418.Anchored = true;
        v418.CanCollide = false;
        v418.CanTouch = false;
        v418.CanQuery = false;
        v418.CastShadow = false;
        v418.Parent = p416.model;
        local v420 = {
            part = v418,
            offset = v419,
            size = v418.Size
        };
        table.insert(p416.layers, v420);
        p416.scale = nil;
        p416.face = v420;
    end;

    setLabel(p415, p416, p416.reward);

    if p416.reward then
        local v421 = u11.RARITY[p416.reward.rarity];
        local v422 = v421 and v421.glow or p416.style.glow;

        for _, v in p416.glowImages do
            v.ImageColor3 = v422;
        end;

        p416.lingering = v422;
        local v423 = u409(p416);
        v423.light.Color = v422;
        v423.wisps.Color = ColorSequence.new(v422);
    end;
end;

u5.LOOKS = {
    info = {
        top = Color3.fromRGB(28, 36, 35),
        bottom = Color3.fromRGB(13, 18, 19),
        ring = Color3_fromRGB_ret2
    },
    buy = {
        stripes = true,
        top = Color3.fromRGB(199, 140, 255),
        bottom = Color3.fromRGB(122, 52, 200),
        ring = Color3.fromRGB(176, 98, 255)
    },
    close = {
        top = Color3.fromRGB(158, 158, 158),
        bottom = Color3.fromRGB(120, 120, 124),
        ring = Color3.fromRGB(189, 189, 189)
    }
};
u5.FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
u5.STRIPES = "rbxassetid://140022482252277";
u5.CALM = Color3.fromRGB(196, 218, 236);
u6.SOFT = Color3.fromRGB(206, 226, 216);

local function uiLabel(p424, p425, p426, p427) -- Line: 1411
    -- upvalues: u5 (copy), Color3_fromRGB_ret5 (copy)
    local v428 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        Text = "",
        FontFace = u5.FONT,
        TextColor3 = Color3_fromRGB_ret5
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p425;

    for i, v in v428 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p424;

    for i, v in p426 or {} do
        TextLabel[i] = v;
    end;

    local v429 = {
        Color = Color3.new(0, 0, 0),
        Thickness = p427 or 0.1,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";

    for i, v in v429 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    return TextLabel;
end;

local u430 = nil;

local function placard(u431, p432, p433) -- Line: 1432
    -- upvalues: u5 (copy), Color3_fromRGB_ret5 (copy), uiLabel (copy), u17 (ref), u430 (ref)
    local v434 = u5.LOOKS[p433];
    local v435 = p433 ~= "info";
    local uiRoot = u431.uiRoot;
    local v436 = {
        BorderSizePixel = 0,
        ZIndex = 5,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3_fromRGB_ret5
    };
    local Instance_new_ret = Instance.new(v435 and "ImageButton" or "Frame");
    Instance_new_ret.Name = "Panel" .. p432;

    for i, v in v436 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = uiRoot;

    if v435 then
        Instance_new_ret.AutoButtonColor = true;
    end;

    local v437 = {
        CornerRadius = UDim.new(0.22, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v437 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Instance_new_ret;
    local v438 = {
        Thickness = 0.05,
        ZIndex = 1,
        Color = Color3.new(0, 0, 0),
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Outline";

    for i, v in v438 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Instance_new_ret;
    local v439 = {
        Thickness = 0.033,
        ZIndex = 2,
        Color = v434.ring,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Name = "Ring";

    for i, v in v439 or {} do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Instance_new_ret;
    local v440 = {
        Rotation = 90,
        Color = ColorSequence.new(v434.top, v434.bottom)
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in v440 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Instance_new_ret;

    if v434.stripes then
        local v441 = {
            BackgroundTransparency = 1,
            ZIndex = 6,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.99, 0.93)
        };
        local CanvasGroup = Instance.new("CanvasGroup");
        CanvasGroup.Name = "Texture";

        for i, v in v441 or {} do
            CanvasGroup[i] = v;
        end;

        CanvasGroup.Parent = Instance_new_ret;
        local v442 = {
            CornerRadius = UDim.new(0.2, 0)
        };
        local UICorner2 = Instance.new("UICorner");
        UICorner2.Name = "UICorner";

        for i, v in v442 or {} do
            UICorner2[i] = v;
        end;

        UICorner2.Parent = CanvasGroup;
        local v443 = {
            Rotation = 45,
            BackgroundTransparency = 1,
            ImageTransparency = 0.82,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.87, 8),
            Image = u5.STRIPES,
            ScaleType = Enum.ScaleType.Tile,
            TileSize = UDim2.fromScale(0.35, 0.35)
        };
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "ImageLabel";

        for i, v in v443 or {} do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = CanvasGroup;
        local v444 = {
            Rotation = 90,
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 0) })
        };
        local UIGradient2 = Instance.new("UIGradient");
        UIGradient2.Name = "UIGradient";

        for i, v in v444 or {} do
            UIGradient2[i] = v;
        end;

        UIGradient2.Parent = ImageLabel;
    end;

    local u445 = {
        shown = true,
        away = false,
        key = p432,
        kind = p433,
        look = v434,
        frame = Instance_new_ret,
        body = uiLabel(Instance_new_ret, "Body", {
            ZIndex = 7,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.86, 0.52)
        }),
        edge = UIStroke2,
        button = v435
    };

    if v435 then
        Instance_new_ret.Activated:Connect(function() -- Line: 1493
            -- upvalues: u17 (ref), u431 (copy), u430 (ref), u445 (copy)
            if u17 == u431 and not u431.finishing then
                u430(u431, u445);
            end;
        end);
    end;

    return u445;
end;

local u450 = {
    text = function(p446, p447) -- Line: 1503, Name: text
        if p446.body.Text ~= p447 then
            p446.body.Text = p447;
        end;
    end,

    apply = function(p448) -- Line: 1509, Name: apply
        local v449 = p448.shown and not p448.away;

        if p448.frame.Visible ~= v449 then
            p448.frame.Visible = v449;
        end;
    end
};

local function setShown(p451, p452) -- Line: 1515
    -- upvalues: u450 (copy)
    if p451.shown == p452 then
        return;
    end;

    p451.shown = p452;
    u450.apply(p451);
end;

local function pulse(p453, p454) -- Line: 1522
    -- upvalues: Color3_fromRGB_ret3 (copy), TweenService (copy)
    if not p453 then
        return;
    end;

    p453.edge.Color = p454 or Color3_fromRGB_ret3;
    TweenService:Create(p453.edge, TweenInfo.new(0.5), {
        Color = p453.look.ring
    }):Play();
end;

local function buildPanels(p455) -- Line: 1534
    -- upvalues: placard (copy), u450 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Font_fromEnum_ret (copy), Font_fromEnum_ret2 (copy), u6 (copy), uiLabel (copy)
    p455.panels = {};
    p455.panels.Keys = placard(p455, "Keys", "info");
    p455.panels.Next = placard(p455, "Next", "info");
    p455.panels.Skip = placard(p455, "Skip", "buy");
    p455.panels.Leave = placard(p455, "Leave", "close");
    u450.text(p455.panels.Leave, "LEAVE");
    local uiRoot = p455.uiRoot;
    local v456 = {
        BackgroundTransparency = 0.02,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 5,
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Color3_fromRGB_ret5
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "OddsCard";

    for i, v in v456 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = uiRoot;
    local UIScale = Instance.new("UIScale");
    UIScale.Name = "Pop";

    for i, v in {
        Scale = 1
    } or {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "Shade";

    for i, v in {
        Rotation = 90
    } or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;
    local v457 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v457 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v458 = {
        Thickness = 4,
        Color = Color3_fromRGB_ret,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";

    for i, v in v458 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Inlay";

    for i, v in {
        BackgroundTransparency = 1,
        ZIndex = 6
    } or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v459 = {
        CornerRadius = UDim.new(0, 8)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v459 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v460 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Name = "UIStroke";

    for i, v in v460 or {} do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame2;
    local v461 = {};

    for i = 1, 6 do
        local v462 = {
            Rotation = 45,
            BorderSizePixel = 0,
            ZIndex = 7,
            AnchorPoint = Vector2.new(0.5, 0.5)
        };
        local Frame3 = Instance.new("Frame");
        Frame3.Name = "Ornament";

        for i2, v in v462 or {} do
            Frame3[i2] = v;
        end;

        Frame3.Parent = Frame;
        v461[i] = Frame3;
    end;

    local function heading(p463, p464, p465, p466) -- Line: 1555
        -- upvalues: Frame (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = p463;

        for i, v in {
            BackgroundTransparency = 1,
            TextWrapped = false,
            ZIndex = 7,
            FontFace = p464,
            TextColor3 = p465,
            TextXAlignment = p466
        } or {} do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = Frame;

        return TextLabel;
    end;

    local v467 = {
        BackgroundTransparency = 1,
        TextWrapped = false,
        ZIndex = 7,
        FontFace = Font_fromEnum_ret,
        TextColor3 = Color3_fromRGB_ret,
        TextXAlignment = Enum.TextXAlignment.Left
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Title";

    for i, v in v467 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = Frame;
    local v468 = {
        BackgroundTransparency = 1,
        TextWrapped = false,
        ZIndex = 7,
        FontFace = Font_fromEnum_ret2,
        TextColor3 = u6.SOFT,
        TextXAlignment = Enum.TextXAlignment.Right
    };
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Name = "Cost";

    for i, v in v468 or {} do
        TextLabel2[i] = v;
    end;

    TextLabel2.Parent = Frame;
    local v469 = {
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        ZIndex = 7,
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "Divider";

    for i, v in v469 or {} do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "Rows";

    for i, v in {
        BackgroundTransparency = 1,
        ZIndex = 7
    } or {} do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame;
    p455.rewards = {
        box = Frame,
        shade = UIGradient,
        corner = UICorner,
        edge = UIStroke,
        inlay = Frame2,
        inlayCorner = UICorner2,
        inlayEdge = UIStroke2,
        gems = v461,
        title = TextLabel,
        cost = TextLabel2,
        divider = Frame3,
        rows = Frame4,
        scale = UIScale
    };
    local v470 = uiLabel(p455.uiRoot, "Hint", {
        TextWrapped = true,
        Visible = false,
        ZIndex = 5,
        AnchorPoint = Vector2.new(0.5, 0.5)
    }, 0.12);
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.Name = "Limit";
    local v471 = {
        text = v470
    };

    for i, v in {
        MaxTextSize = 28,
        MinTextSize = 8
    } or {} do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = v470;
    v471.limit = UITextSizeConstraint;
    p455.hint = v471;
end;

function u450.hint(p472, p473) -- Line: 1579
    if p473 then
        p472.hint.text.Text = p473;
    end;

    local rewards = p472.rewards;

    if rewards and rewards.rowPixels then
        local limit = p472.hint.limit;
        local math_floor_ret = math.floor(rewards.rowPixels * 0.95);
        limit.MaxTextSize = math.max(9, math_floor_ret);
    end;
end;

local u487 = {
    lines = function(u474) -- Line: 1592, Name: lines
        -- upvalues: config (copy), u6 (copy)
        local function percentText(p475) -- Line: 1594
            return string.format("%.1f%%", math.floor(p475 * 1000 + 0.5) / 10);
        end;

        local u476 = config();
        local success, result = pcall(function() -- Line: 1598
            -- upvalues: u476 (copy), u474 (copy)
            return u476 and u476.column(u474.cursed) or {};
        end);
        local v477 = {};

        for _, v in (not success or type(result) ~= "table") and {} or result do
            local v478 = v.row or v[1];
            local v479 = v.chance or v[2];

            if type(v478) == "table" and type(v479) == "number" then
                local v480 = {
                    rarity = v478.Rarity,
                    name = u6.NAMES[v478.Id] or tostring(v478.Name or v478.Id),
                    chance = string.format("%.1f%%", math.floor(v479 * 1000 + 0.5) / 10),
                    value = v479,
                    order = u6.ORDER[v478.Rarity] or 6
                };
                table.insert(v477, v480);
            end;
        end;

        table.sort(v477, function(p481, p482) -- Line: 1615
            if p481.order == p482.order then
                return p481.value > p482.value;
            end;

            return p481.order < p482.order;
        end);

        return #v477 == 0 and { {
                name = "Coins, candy, gems, keys, knives",
                chance = "",
                order = 6
            } } or v477, "1 Ghost Key";
    end,

    fold = function(p483) -- Line: 1627, Name: fold
        -- upvalues: u6 (copy)
        local v484 = {};

        for _, v in p483 do
            if v.order <= 3 then
                table.insert(v484, v);
            end;
        end;

        if #v484 < #p483 then
            table.insert(v484, {
                rarity = "Common",
                chance = "",
                order = 5,
                wide = true,
                name = u6.FOLDED
            });
        end;

        return v484;
    end,

    width = function(p485, p486) -- Line: 1641, Name: width
        -- upvalues: u50 (copy)
        return u50.width(p485, p486) + utf8.len(p485) * 0.04;
    end
};

function u487.size(p488, p489, p490, p491) -- Line: 1646
    -- upvalues: u6 (copy), u487 (copy), u50 (copy)
    local v492 = 0;
    local v493 = 0;
    local v494 = 0;
    local v495 = 0;

    for _, v in p488 do
        if v.wide then
            local v496 = u6.ROW_PAD * 3 + u6.DOT + u487.width(v.name);
            v492 = math.max(v492, v496);
        else
            v493 = v493 + 1;
            v494 = math.max(v494, u487.width(v.name));
            v495 = math.max(v495, u487.width(v.chance));
        end;
    end;

    local math_clamp_ret = math.clamp(v493, 1, p491 or 2);
    local v497 = math_clamp_ret * (u6.ROW_PAD * 3 + u6.DOT + v494 + u6.GAP + v495) + (math_clamp_ret - 1) * u6.GUTTER;
    local v498 = u50.width(p489, true) * u6.TITLE + 1.2 + u50.width(p490) * u6.COST;
    local math_max_ret = math.max(v497, v492, v498);
    local math_ceil_ret = math.ceil(v493 / math_clamp_ret);

    return math_max_ret + u6.PAD * 2, u6.PAD * 2 + u6.TITLE + u6.DIVIDER * 2 + (math_ceil_ret + (v492 > 0 and 1 or 0)) * u6.ROW, v495;
end;

local u499 = {
    cursed = false,
    opened = false
};

function u487.card(p500, p501) -- Line: 1667
    -- upvalues: u6 (copy), u499 (copy), u487 (copy)
    local Y = p500.camera.ViewportSize.Y;
    local v502 = nil;

    for _, v in { false, true } do
        local v503 = v;
        v502 = nil;

        for _, v2 in u6.COLUMNS do
            local v504 = v2;
            local v505 = 0;
            local v506 = 0;
            local v507 = 0;

            for _, v3 in {
                u499,
                {
                    cursed = true,
                    opened = false
                }
            } do
                local v508, v509 = u487.lines(v3);

                if v503 then
                    v508 = u487.fold(v508);
                end;

                local v510, v511, v512 = u487.size(v508, v3.cursed and "CURSED CARD" or "SPIRIT CARD", v509, v504);
                v505 = math.max(v505, v510);
                v506 = math.max(v506, v511);
                v507 = math.max(v507, v512);
            end;

            local math_min_ret = math.min((p501[2] - p501[1]) * p500.aspect / v505, (p501[4] - p501[3]) / v506);

            if Y > 0 then
                local v513 = u6.MOST_PIXELS / Y;
                local math_max_ret = math.max(u6.MOST, u6.FLOOR / Y);
                math_min_ret = math.min(math_min_ret, v513, math_max_ret);
            end;

            if not v502 or v502.k * u6.MORE_COLUMNS < math_min_ret then
                v502 = {
                    fold = v503,
                    columns = v504,
                    k = math_min_ret,
                    width = v505,
                    height = v506,
                    chance = v507
                };
            end;
        end;

        if Y <= 0 or v502.k * Y >= u6.MIN_PIXELS then
            break;
        end;
    end;

    return v502;
end;

function u487.kind(p514) -- Line: 1699
    if not p514.opened then
        return p514.cursed and "cursed" or "normal";
    end;

    return "opened " .. tostring(p514.reward and p514.reward.id);
end;

function u487.won(p515) -- Line: 1709
    -- upvalues: u6 (copy), u11 (copy), config (copy), u10 (copy), Color3_fromRGB_ret (copy), u487 (copy)
    local WON = u6.WON;
    local v516 = type(p515.reward) ~= "table" and {} or p515.reward;
    local v517 = u11.STYLES[p515.cursed and "cursed" or "normal"];
    local v518 = u11.RARITY[v516.rarity] or u11.RARITY.Common;
    local v519 = tostring(v516.kind or "");
    local string_upper_ret = string.upper(u6.NAMES[v516.id] or tostring(v516.name or "A reward"));
    local v520 = u11.KINDS[v519];

    if type(v516.duplicateGems) == "number" then
        v520 = "ALREADY OWNED · +" .. v516.duplicateGems .. " GEMS";
    elseif v520 and string.find(string_upper_ret, v520, 1, true) then
        v520 = nil;
    end;

    local v521 = {
        name = string_upper_ret
    };
    local v522;

    if v518.ink == "accent" then
        v522 = v517.accent;
    elseif v518.ink then
        v522 = v518.ink;
    else
        v522 = v517.ink;
    end;

    v521.ink = v522;
    v521.shimmer = v518.shimmer == true;
    v521.icon = u11.REWARD_ICONS[v516.id] or u11.ICONS[v519];
    local v523;

    if v516.rarity then
        v523 = string.upper((tostring(v516.rarity)));
    else
        v523 = nil;
    end;

    v521.rarity = v523;
    local rarity = v516.rarity;
    local v524 = config();

    if v524 then
        if type(v524.RarityColors) == "table" then
            v524 = v524.RarityColors[rarity];
        else
            v524 = false;
        end;
    end;

    if typeof(v524) ~= "Color3" then
        v524 = u10[rarity] or Color3_fromRGB_ret;
    end;

    v521.color = v524;
    v521.note = v520;
    local v525 = not v521.rarity and 0 or u487.width(v521.rarity) * WON.PILL_TEXT + WON.PILL_PAD * 2;
    local v526 = v525 + (not v520 and 0 or (v525 <= 0 and 0 or WON.AFTER_PILL) + u487.width(v520) * WON.NOTE);
    local v527 = u487.width(string_upper_ret, true) * WON.NAME;
    local v528 = u487.width(WON.LABEL_TEXT) * WON.LABEL;
    v521.text = math.max(v527, v528, v526);
    v521.pill = v525;
    local v529 = (not v521.icon and 0 or WON.ICON + WON.GAP) + v521.text;
    local v530 = u487.width(p515.cursed and "CURSED CARD" or "SPIRIT CARD", true) * u6.TITLE + 1.2 + u487.width("OPENED") * u6.COST;

    return v521, math.max(v529, v530) + u6.PAD * 2, u6.PAD * 2 + u6.TITLE + u6.DIVIDER * 2 + WON.BODY;
end;

function u487.showWon(u531, p532, u533, p534, p535) -- Line: 1741
    -- upvalues: u6 (copy), Font_fromEnum_ret2 (copy), Font_fromEnum_ret (copy), Color3_fromRGB_ret5 (copy), u9 (copy), Color3_fromRGB_ret4 (copy)
    local WON = u6.WON;
    local u536;

    if p532.icon then
        local v537 = WON.ICON * u533;
        local v538 = {
            BorderSizePixel = 0,
            ZIndex = 8,
            Position = UDim2.fromOffset(0, (p535 - v537) / 2),
            Size = UDim2.fromOffset(v537, v537),
            BackgroundColor3 = p532.color,
            BackgroundTransparency = WON.TILE
        };
        local Frame = Instance.new("Frame");
        Frame.Name = "Tile";

        for i, v in v538 or {} do
            Frame[i] = v;
        end;

        Frame.Parent = u531;
        local v539 = {
            CornerRadius = UDim.new(0, (math.floor(v537 * 0.22)))
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i, v in v539 or {} do
            UICorner[i] = v;
        end;

        UICorner.Parent = Frame;
        local v540 = {
            Transparency = 0.35,
            Color = p532.color
        };
        local math_floor_ret = math.floor(u533 * 0.09);
        v540.Thickness = math.max(1, math_floor_ret);
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Name = "Edge";

        for i, v in v540 or {} do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = Frame;
        local v541 = {
            BackgroundTransparency = 1,
            ZIndex = 9,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.74, 0.74),
            Image = p532.icon,
            ScaleType = Enum.ScaleType.Fit
        };
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Icon";

        for i, v in v541 or {} do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = Frame;
        u536 = (WON.ICON + WON.GAP) * u533;
    else
        u536 = 0;
    end;

    local u542 = p534 - u536;
    local v543 = (p535 - (WON.LABEL + WON.NAME + WON.SPACE + WON.PILL) * u533) / 2;

    local function words(p544, p545, p546, p547, p548, p549, p550, p551) -- Line: 1769
        -- upvalues: u531 (copy), u536 (ref), u542 (copy), u533 (copy)
        local v552 = {
            BackgroundTransparency = 1,
            TextWrapped = false,
            ZIndex = 8,
            Position = UDim2.fromOffset(u536, p549),
            Size = UDim2.fromOffset(p551 or u542, p550),
            FontFace = p546,
            Text = p545,
            TextSize = math.floor(p547 * u533),
            TextColor3 = p548,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = p544;

        for i, v in v552 or {} do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = u531;

        return TextLabel;
    end;

    words("Label", WON.LABEL_TEXT, Font_fromEnum_ret2, WON.LABEL, u6.SOFT, v543, WON.LABEL * u533);
    local v553;

    if p532.shimmer then
        v553 = Color3_fromRGB_ret5;
    else
        v553 = p532.ink;
    end;

    local v554 = words("Name", p532.name, Font_fromEnum_ret, WON.NAME, v553, v543 + WON.LABEL * u533, WON.NAME * u533);

    if p532.shimmer then
        local v555 = {
            Color = u9.SHIMMER
        };
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Name = "Shimmer";

        for i, v in v555 or {} do
            UIGradient[i] = v;
        end;

        UIGradient.Parent = v554;
    end;

    local v556 = v543 + (WON.LABEL + WON.NAME + WON.SPACE) * u533;

    if p532.rarity then
        local v557 = {
            BorderSizePixel = 0,
            ZIndex = 8,
            Position = UDim2.fromOffset(u536, v556),
            Size = UDim2.fromOffset(p532.pill * u533, WON.PILL * u533)
        };
        local v558;

        if p532.shimmer then
            v558 = Color3_fromRGB_ret5;
        else
            v558 = p532.color;
        end;

        v557.BackgroundColor3 = v558;
        local Frame = Instance.new("Frame");
        Frame.Name = "Rarity";

        for i, v in v557 or {} do
            Frame[i] = v;
        end;

        Frame.Parent = u531;
        local v559 = {
            CornerRadius = UDim.new(0.5, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i, v in v559 or {} do
            UICorner[i] = v;
        end;

        UICorner.Parent = Frame;

        if p532.shimmer then
            local v560 = {
                Color = u9.SHIMMER
            };
            local UIGradient = Instance.new("UIGradient");
            UIGradient.Name = "Shimmer";

            for i, v in v560 or {} do
                UIGradient[i] = v;
            end;

            UIGradient.Parent = Frame;
        end;

        local v561 = {
            BackgroundTransparency = 1,
            TextWrapped = false,
            ZIndex = 9,
            Size = UDim2.fromScale(1, 1),
            FontFace = Font_fromEnum_ret2,
            Text = p532.rarity,
            TextSize = math.floor(WON.PILL_TEXT * u533),
            TextColor3 = Color3_fromRGB_ret4
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "Text";

        for i, v in v561 or {} do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = Frame;
    end;

    if p532.note then
        local v562 = not p532.rarity and 0 or (p532.pill + WON.AFTER_PILL) * u533;
        words("Note", p532.note, Font_fromEnum_ret2, WON.NOTE, u6.SOFT, v556, WON.PILL * u533, u542 - v562).Position = UDim2.fromOffset(u536 + v562, v556);
    end;
end;

function u487.fill(p563, p564) -- Line: 1822
    -- upvalues: u487 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret4 (copy), u6 (copy), config (copy), u10 (copy), Font_fromEnum_ret2 (copy), Color3_fromRGB_ret5 (copy)
    local rewards = p563.rewards;
    local layout = rewards.layout;

    for _, child in rewards.rows:GetChildren() do
        child:Destroy();
    end;

    local v565 = nil;
    local v566 = nil;
    local v567, v568;

    if p564.opened then
        local v569;
        v566, v567, v569 = u487.won(p564);
        v568 = "OPENED";
        layout = {
            width = v567,
            height = v569
        };
    else
        v565, v568 = u487.lines(p564);

        if layout.fold then
            v565 = u487.fold(v565);
        end;

        v567 = layout.across;
    end;

    local v570 = p564.cursed and "CURSED CARD" or "SPIRIT CARD";
    local X = rewards.pixels.X;
    local Y = rewards.pixels.Y;
    local v571 = X / v567;
    rewards.rowPixels = v571;
    local v572;

    if p564.cursed then
        v572 = Color3_fromRGB_ret3;
    else
        v572 = Color3_fromRGB_ret;
    end;

    local shade = rewards.shade;
    local v573;

    if p564.cursed then
        v573 = ColorSequence.new(Color3.fromRGB(46, 12, 38), Color3.fromRGB(16, 5, 14));
    else
        v573 = ColorSequence.new(Color3.fromRGB(14, 48, 37), Color3.fromRGB(5, 20, 15));
    end;

    shade.Color = v573;
    rewards.edge.Color = v572;
    local edge = rewards.edge;
    local math_floor_ret = math.floor(v571 * 0.13);
    edge.Thickness = math.max(2, math_floor_ret);
    rewards.corner.CornerRadius = UDim.new(0, (math.floor(v571 * 0.7)));
    local v574 = v571 * 0.24;
    rewards.inlay.Position = UDim2.fromOffset(v574, v574);
    rewards.inlay.Size = UDim2.new(1, -v574 * 2, 1, -v574 * 2);
    rewards.inlayCorner.CornerRadius = UDim.new(0, (math.floor(v571 * 0.45)));
    rewards.inlayEdge.Color = v572:Lerp(Color3_fromRGB_ret4, 0.3);
    local inlayEdge = rewards.inlayEdge;
    local math_floor_ret2 = math.floor(v571 * 0.05);
    inlayEdge.Thickness = math.max(2, math_floor_ret2);

    for i, v in {
        { v574, v574 },
        { X - v574, v574 },
        { v574, Y - v574 },
        { X - v574, Y - v574 },
        { X / 2, v574 },
        { X / 2, Y - v574 }
    } do
        local v575 = rewards.gems[i];
        v575.Position = UDim2.fromOffset(v[1], v[2]);
        v575.Size = UDim2.fromOffset(v571 * (i > 4 and 0.34 or 0.26), v571 * (i > 4 and 0.34 or 0.26));
        v575.BackgroundColor3 = v572;
    end;

    local v576 = layout.width * v571;
    local v577 = layout.height * v571;
    local v578 = (X - v576) / 2;
    local v579 = (Y - v577) / 2;
    local v580 = u6.PAD * v571;
    local v581 = v576 - v580 * 2;
    rewards.title.TextColor3 = v572;
    rewards.title.Text = v570;
    rewards.title.TextSize = math.floor(u6.TITLE * v571);
    rewards.title.Position = UDim2.fromOffset(v578 + v580, v579 + v580);
    rewards.title.Size = UDim2.fromOffset(v581, u6.TITLE * v571);
    rewards.cost.Text = v568;
    rewards.cost.TextSize = math.floor(u6.COST * v571);
    rewards.cost.AnchorPoint = Vector2.new(0, 0.5);
    rewards.cost.Position = UDim2.fromOffset(v578 + v580, v579 + v580 + u6.TITLE * 0.5 * v571);
    rewards.cost.Size = UDim2.fromOffset(v581, u6.COST * v571);
    local v582 = v579 + v580 + (u6.TITLE + u6.DIVIDER) * v571;
    rewards.divider.BackgroundColor3 = v572;
    rewards.divider.Position = UDim2.fromOffset(v578 + v580, v582);
    local divider = rewards.divider;
    local UDim2_fromOffset = UDim2.fromOffset;
    local math_floor_ret3 = math.floor(v571 * 0.08);
    divider.Size = UDim2_fromOffset(v581, (math.max(2, math_floor_ret3)));
    local v583 = v582 + u6.DIVIDER * v571;
    local v584 = v579 + v577 - v580 - v583;
    rewards.rows.Position = UDim2.fromOffset(v578 + v580, v583);
    rewards.rows.Size = UDim2.fromOffset(v581, v584);

    if v566 then
        u487.showWon(rewards.rows, v566, v571, v581, v584);

        return;
    end;

    local v585 = 0;

    for _, v in v565 do
        if not v.wide then
            v585 = v585 + 1;
        end;
    end;

    local math_clamp_ret = math.clamp(v585, 1, layout.columns or 2);
    local math_ceil_ret = math.ceil(v585 / math_clamp_ret);
    local math_max_ret = math.max(1, math_ceil_ret);
    local v586 = u6.GUTTER * v571;
    local v587 = (v581 - (math_clamp_ret - 1) * v586) / math_clamp_ret;
    local math_floor_ret4 = math.floor(v571);
    local v588 = u6.ROW * v571;

    for i = 1, math_max_ret - 1, 2 do
        local rows = rewards.rows;
        local v589 = {
            BorderSizePixel = 0,
            BackgroundColor3 = v572,
            BackgroundTransparency = u6.BAND,
            Position = UDim2.fromOffset(0, i * v588),
            Size = UDim2.fromOffset(v581, v588)
        };
        local Frame = Instance.new("Frame");
        Frame.Name = "Band" .. i;
        local _ = i;

        for i2, v in v589 or {} do
            Frame[i2] = v;
        end;

        Frame.Parent = rows;
        local v590 = {
            CornerRadius = UDim.new(0, (math.floor(v571 * 0.25)))
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i2, v in v590 or {} do
            UICorner[i2] = v;
        end;

        UICorner.Parent = Frame;
    end;

    for i = 1, math_clamp_ret - 1 do
        local rows = rewards.rows;
        local v591 = {
            BorderSizePixel = 0,
            BackgroundColor3 = v572,
            BackgroundTransparency = u6.RULE,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromOffset(i * (v587 + v586) - v586 / 2, v588 * 0.15)
        };
        local UDim2_fromOffset2 = UDim2.fromOffset;
        local math_floor_ret5 = math.floor(v571 * 0.07);
        v591.Size = UDim2_fromOffset2(math.max(1, math_floor_ret5), math_max_ret * v588 - v588 * 0.3);
        local Frame = Instance.new("Frame");
        Frame.Name = "Rule" .. i;
        local _ = i;

        for i2, v in v591 or {} do
            Frame[i2] = v;
        end;

        Frame.Parent = rows;
    end;

    local v592 = 0;

    for i, v in v565 do
        local v593, v594, v595;

        if v.wide then
            v593 = math_max_ret;
            v594 = v581;
            v595 = 0;
        else
            v595 = v592 // math_max_ret;
            v593 = v592 % math_max_ret;
            v592 = v592 + 1;
            v594 = v587;
        end;

        local v596 = v.order <= 3;
        local rarity = v.rarity;
        local v597 = config();

        if v597 then
            if type(v597.RarityColors) == "table" then
                v597 = v597.RarityColors[rarity];
            else
                v597 = false;
            end;
        end;

        if typeof(v597) ~= "Color3" then
            v597 = u10[rarity] or Color3_fromRGB_ret;
        end;

        local rows = rewards.rows;
        local v598 = {
            BackgroundTransparency = 1,
            ZIndex = 8,
            Position = UDim2.fromOffset(v595 * (v587 + v586), v593 * v588),
            Size = UDim2.fromOffset(v594, v588)
        };
        local Frame = Instance.new("Frame");
        Frame.Name = "Row" .. i;
        local v599 = v;

        for i2, v2 in v598 or {} do
            Frame[i2] = v2;
        end;

        Frame.Parent = rows;
        local v600 = {
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, u6.ROW_PAD * v571, 0.5, 0),
            Size = UDim2.fromOffset(u6.DOT * v571, u6.DOT * v571)
        };
        local v601;

        if v599.rarity then
            v601 = v597;
        else
            v601 = Color3_fromRGB_ret;
        end;

        v600.BackgroundColor3 = v601;
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "Dot";

        for i2, v2 in v600 or {} do
            Frame2[i2] = v2;
        end;

        Frame2.Parent = Frame;
        local v602 = {
            CornerRadius = UDim.new(0.5, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i2, v2 in v602 or {} do
            UICorner[i2] = v2;
        end;

        UICorner.Parent = Frame2;
        local v603 = (u6.ROW_PAD * 2 + u6.DOT) * v571;
        local v604;

        if v599.wide then
            v604 = u6.ROW_PAD * v571;
        else
            v604 = (u6.GAP + layout.chance + u6.ROW_PAD) * v571;
        end;

        local v605 = {
            BackgroundTransparency = 1,
            TextWrapped = false,
            Position = UDim2.fromOffset(v603, 0),
            Size = UDim2.new(1, -v603 - v604, 1, 0),
            FontFace = Font_fromEnum_ret2,
            Text = v599.name,
            TextSize = math_floor_ret4
        };
        local v606;

        if v599.wide then
            v606 = u6.SOFT;
        elseif v599.rarity and v596 then
            v606 = v597:Lerp(Color3_fromRGB_ret5, u6.CHASE_TINT);
        else
            v606 = Color3_fromRGB_ret5;
        end;

        v605.TextColor3 = v606;
        v605.TextXAlignment = Enum.TextXAlignment.Left;
        v605.TextTruncate = Enum.TextTruncate.AtEnd;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "Name";

        for i2, v2 in v605 or {} do
            TextLabel[i2] = v2;
        end;

        TextLabel.Parent = Frame;

        if not v599.wide then
            local v607 = {
                BackgroundTransparency = 1,
                TextWrapped = false,
                AnchorPoint = Vector2.new(1, 0),
                Position = UDim2.new(1, -u6.ROW_PAD * v571, 0, 0),
                Size = UDim2.new(0, (layout.chance + 0.3) * v571, 1, 0),
                FontFace = Font_fromEnum_ret2,
                Text = v599.chance,
                TextSize = math_floor_ret4,
                TextColor3 = u6.SOFT,
                TextXAlignment = Enum.TextXAlignment.Right
            };
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Name = "Chance";

            for i2, v2 in v607 or {} do
                TextLabel2[i2] = v2;
            end;

            TextLabel2.Parent = Frame;
        end;
    end;
end;

local function say(p608, p609) -- Line: 1983
    -- upvalues: u13 (copy)
    if p608 then
        p608.message = {
            text = p609,
            untilAt = os.clock() + 3.5
        };

        return;
    end;

    u13.notice(p609);
end;

function u450.hintText() -- Line: 1990
    -- upvalues: UserInputService (copy)
    local PreferredInput = UserInputService.PreferredInput;

    return PreferredInput == Enum.PreferredInput.Touch and "Tap a card to point at it. Tap it again to spend a Ghost Key." or (PreferredInput == Enum.PreferredInput.Gamepad and "Left and right to point. A to spend a Ghost Key." or "Point at a card. Click to spend a Ghost Key.");
end;

local function paint(p610) -- Line: 2000
    -- upvalues: u450 (copy), u5 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret5 (copy)
    local v611 = p610.state or {};
    local v612 = type(v611.keys) ~= "number" and 0 or v611.keys;
    u450.text(p610.panels.Keys, "GHOST KEYS · " .. v612);
    local v613 = (type(v611.nextAt) ~= "number" and 0 or v611.nextAt) - workspace:GetServerTimeNow();
    local text = u450.text;
    local Next = p610.panels.Next;
    local v614;

    if v613 > 0 then
        local math_ceil_ret = math.ceil(v613);
        local math_max_ret = math.max(0, math_ceil_ret);
        v614 = "NEXT CARD · " .. string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60);
    else
        v614 = "NEXT CARD: READY";
    end;

    text(Next, v614);
    local v615;

    if v613 > 0 then
        v615 = u5.CALM;
    else
        v615 = Color3_fromRGB_ret;
    end;

    p610.panels.Next.body.TextColor3 = v615;
    local v616;

    if v611.skipAvailable == true and v611.restricted ~= true then
        v616 = v613 > 0;
    else
        v616 = false;
    end;

    u450.text(p610.panels.Skip, "SKIP · " .. tostring(v611.skipPrice or "?") .. " R$");

    if p610.panels.Skip.shown ~= v616 then
        local Skip = p610.panels.Skip;

        if Skip.shown ~= v616 then
            Skip.shown = v616;
            u450.apply(Skip);
        end;
    end;

    local message = p610.message;
    local v617 = u450.hintText();
    local v618 = Color3_fromRGB_ret5;

    if message and os.clock() < message.untilAt then
        v617 = message.text;
        v618 = Color3.fromRGB(255, 130, 130);
    else
        p610.message = nil;
    end;

    if p610.hint.text.Text ~= v617 then
        u450.hint(p610, v617);
    end;

    p610.hint.text.TextColor3 = v618;
end;

local function remember(p619) -- Line: 2029
    -- upvalues: u18 (copy)
    for i, v in p619.saved do
        if u18[i] == nil then
            u18[i] = v;
        end;
    end;
end;

local function sweepLeftovers(p620) -- Line: 2038
    -- upvalues: u17 (ref), u18 (copy), LocalLooks (copy), u19 (copy), u20 (copy), LocalPlayer (ref)
    if u17 then
        return;
    end;

    local v621 = 0;
    local v622 = {};

    for i, v in u18 do
        local success, result = pcall(function() -- Line: 2045
            -- upvalues: i (copy)
            return i.LocalTransparencyModifier;
        end);

        if success and (i.Parent and (result >= 1 and (v < 1 and not LocalLooks.has(i, "LocalTransparencyModifier")))) then
            pcall(function() -- Line: 2049
                -- upvalues: i (copy), v (copy)
                i.LocalTransparencyModifier = v;
            end);
            v621 = v621 + 1;
        end;
    end;

    table.clear(u18);

    if v621 > 0 then
        table.insert(v622, v621 .. " hidden parts");
    end;

    for i, v in u19 do
        if i.Parent and i.C0 ~= v then
            pcall(function() -- Line: 2061
                -- upvalues: i (copy), v (copy)
                i.C0 = v;
            end);
            table.insert(v622, "the pointing arm");
        end;
    end;

    table.clear(u19);
    local camera = u20.camera;

    if camera then
        u20.camera = nil;

        if workspace.CurrentCamera == camera.camera and camera.camera.CameraType == Enum.CameraType.Scriptable then
            pcall(function() -- Line: 2072
                -- upvalues: LocalPlayer (ref), camera (copy)
                local v623 = LocalPlayer and LocalPlayer.Character;
                local v624;

                if v623 then
                    v624 = v623:FindFirstChildOfClass("Humanoid");
                else
                    v624 = v623;
                end;

                if v623 then
                    v623 = v623:FindFirstChild("HumanoidRootPart");
                end;

                if v624 ~= nil and v624.Health > 0 then
                    local _ = v623 == nil;
                end;

                local v625;

                if camera.type == Enum.CameraType.Scriptable then
                    v625 = Enum.CameraType.Custom;
                else
                    v625 = camera.type;
                end;

                camera.camera.CameraType = v625;

                if not (v624 and v624:IsDescendantOf(workspace)) then
                    v624 = camera.subject;
                end;

                if v624 and v624:IsDescendantOf(workspace) then
                    camera.camera.CameraSubject = v624;
                end;

                camera.camera.FieldOfView = camera.fov;
            end);
            table.insert(v622, "the camera");
        end;
    end;

    if u20.controls then
        local controls = u20.controls;
        u20.controls = nil;
        pcall(controls.Enable, controls);
        table.insert(v622, "the controls");
    end;

    if u20.visibility then
        local visibility = u20.visibility;
        u20.visibility = nil;
        pcall(visibility.destroy, visibility);
        table.insert(v622, "the hidden UI");
    end;

    if LocalPlayer and LocalPlayer:GetAttribute("GhostTraderActive") ~= nil then
        LocalPlayer:SetAttribute("GhostTraderActive", nil);
        table.insert(v622, "GhostTraderActive");
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v626;

    if workspace_CurrentCamera then
        v626 = workspace_CurrentCamera:FindFirstChild("GhostTraderView");
    else
        v626 = workspace_CurrentCamera;
    end;

    if v626 then
        v626:Destroy();
        table.insert(v622, "the cards");
    end;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera:FindFirstChild("GhostTraderMood");
    end;

    if workspace_CurrentCamera then
        workspace_CurrentCamera:Destroy();
        table.insert(v622, "the gloom");
    end;

    local v627 = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui");

    for _, v in not v627 and {} or v627:GetChildren() do
        if string.sub(v.Name, 1, 13) == "GhostTraderUI" then
            v:Destroy();
            table.insert(v622, v.Name);
        end;
    end;

    if #v622 > 0 then
        warn("[GhostTrader] not back after the trader (" .. p620 .. "): " .. table.concat(v622, ", ") .. "; put back");
    end;
end;

local function watchPlate(p628, u629) -- Line: 2124
    if p628.plates[u629] or (not u629:IsA("BillboardGui") or string.sub(u629.Name, 1, 15) ~= "PlayerOverhead_") then
        return;
    end;

    local u630 = {
        own = 0,
        wanted = u629.Enabled
    };
    p628.plates[u629] = u630;

    local function suppress() -- Line: 2130
        -- upvalues: u629 (copy), u630 (copy)
        if u629.Enabled then
            local v631 = u630;
            v631.own = v631.own + 1;
            u629.Enabled = false;
        end;
    end;

    u630.connection = u629:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 2136
        -- upvalues: u629 (copy), u630 (copy)
        if u629.Enabled or u630.own <= 0 then
            u630.wanted = u629.Enabled;

            if u629.Enabled then
                local v632 = u630;
                v632.own = v632.own + 1;
                u629.Enabled = false;
            end;

            return;
        end;

        local v633 = u630;
        v633.own = v633.own - 1;
    end);

    if u629.Enabled then
        u630.own = u630.own + 1;
        u629.Enabled = false;
    end;
end;

local function showPlates(p634) -- Line: 2146
    for i, v in p634.plates do
        v.connection:Disconnect();

        if i.Parent then
            pcall(function() -- Line: 2150
                -- upvalues: i (copy), v (copy)
                i.Enabled = v.wanted;
            end);
        end;
    end;

    local v635 = 0;

    for i, v in p634.plates do
        if i.Parent and i.Enabled ~= v.wanted then
            v635 = v635 + 1;
            pcall(function() -- Line: 2159
                -- upvalues: i (copy), v (copy)
                i.Enabled = v.wanted;
            end);
        end;
    end;

    if v635 > 0 then
        warn(("[GhostTrader] %d nameplates weren\'t back after the trader: fixed"):format(v635));
    end;

    table.clear(p634.plates);
end;

local function hideOthers(u636) -- Line: 2169
    -- upvalues: u27 (copy), u18 (copy)
    pcall(function() -- Line: 2170
        -- upvalues: u636 (copy), u27 (ref)
        u636.hide:sweep();

        if u636.othersFade then
            u27.fade(u636, u636.othersK or 0);
        end;
    end);

    for i, v in u636.hide.saved do
        if u18[i] == nil then
            u18[i] = v;
        end;
    end;
end;

local function armOf(p637) -- Line: 2180
    local Torso = p637:FindFirstChild("Torso");

    if Torso then
        Torso = Torso:FindFirstChild("Right Shoulder");
    end;

    if Torso and (Torso:IsA("Motor6D") and (Torso.Part0 and Torso.Part1)) then
        local Part1 = Torso.Part1;
        local Position = Torso.C1.Position;

        return {
            weight = 0,
            motor = Torso,
            c0 = Torso.C0,
            hand = Position + Vector3.new(0, -1, 0),
            side = Vector3.new(-Position.X, 0, -Position.Z),
            handPart = Part1,
            handAt = Vector3.new(0, -Part1.Size.Y / 2, 0)
        };
    end;

    local RightUpperArm = p637:FindFirstChild("RightUpperArm");
    local v638;

    if RightUpperArm then
        v638 = RightUpperArm:FindFirstChild("RightShoulder");
    else
        v638 = RightUpperArm;
    end;

    if not (v638 and (v638:IsA("Motor6D") and (v638.Part0 and v638.Part1))) then
        return nil;
    end;

    local RightHand = p637:FindFirstChild("RightHand");
    local v639;

    if RightHand and RightHand:IsA("BasePart") then
        v639 = RightUpperArm.CFrame:PointToObjectSpace(RightHand.Position);
    else
        v639 = Vector3.new(0, -RightUpperArm.Size.Y, 0);
    end;

    local v640 = {
        handAt = Vector3.new(0, 0, 0),
        weight = 0,
        motor = v638,
        c0 = v638.C0,
        hand = v639
    };

    if RightHand then
        if not RightHand:IsA("BasePart") then
            RightHand = RightUpperArm;
        end;
    else
        RightHand = RightUpperArm;
    end;

    v640.handPart = RightHand;

    return v640;
end;

function u487.fan(p641, p642) -- Line: 2202
    -- upvalues: fanEnvelope (copy)
    return fanEnvelope(p642, p641.aspect, p641.shot, p641.fanAt, p641.fanScale or 1);
end;

function u487.shapes(u643, u644) -- Line: 2209
    -- upvalues: project (copy), u3 (ref), slotPose (copy)
    local v645 = u643.fanScale or 1;
    local u646 = 0.3719723183391004 * v645;
    local u647 = 0.625 * v645;
    local u648 = {};

    local function add(p649, p650) -- Line: 2213
        -- upvalues: project (ref), u644 (copy), u3 (ref), u643 (copy), u646 (copy), u647 (copy), u648 (copy)
        local v651 = {};

        for _, v in { { -1, -1 }, { 1, -1 }, { 1, 1 }, { -1, 1 } } do
            local v652 = project(u644, u3, u643.aspect, (p649 * CFrame.new(v[1] * u646 * p650, v[2] * u647 * p650, 0)).Position);
            table.insert(v651, v652);
        end;

        table.insert(u648, v651);
    end;

    for i = 1, 6 do
        local v653 = slotPose(u643.fanAt, u643.shot, i, 6, v645);
        local CFrame_lookAt_ret = CFrame.lookAt(v653.Position, u644.Position, v653.UpVector);
        local _ = i;

        for i2 = -1, 1 do
            add(CFrame_lookAt_ret + u643.shot.RightVector * (i2 * 0.2 * v645) - Vector3.new(0, 1, 0) * (0.025 * v645), 1);
            local _ = i2;
        end;

        local v654 = CFrame_lookAt_ret + CFrame_lookAt_ret.LookVector * (0.48 * v645) + Vector3.new(0, 1, 0) * (0.095 * v645);

        for i2 = -1, 1 do
            local v655 = i2;

            for i3 = -1, 1 do
                local v656 = CFrame.fromAxisAngle(u644.RightVector, -i3 * 0.12217304763960307) * CFrame.fromAxisAngle(u644.UpVector, v655 * 0.12217304763960307);
                add(CFrame.new(v654.Position) * v656 * v654.Rotation, 1.06);
                local _ = i3;
            end;
        end;
    end;

    return u648;
end;

function u487.under(p657, p658, p659) -- Line: 2238
    -- upvalues: u6 (copy)
    local v660 = 0;

    for _, v in p657 do
        local v661 = v;

        for i = 1, 4 do
            local v662 = v661[i];
            local v663 = v661[i % 4 + 1];
            local _ = i;

            for i2 = 0, 16 do
                local v664 = v662:Lerp(v663, i2 / 16);
                local v665;

                if p658 <= v664.X and v664.X <= p659 then
                    v660 = math.max(v660, v664.Y);
                    v665 = i2;
                else
                    v665 = i2;
                end;
            end;
        end;
    end;

    return math.max(u6.BOX[1], v660 + u6.UNDER);
end;

local function layout(p666) -- Line: 2253
    -- upvalues: placardLayout (copy), u487 (copy), outline (copy), bodyBoxes (copy), clearOf (copy), u6 (copy), u450 (copy), u5 (copy)
    local view = p666.view;
    local aspect = p666.aspect;
    local v667 = {};

    for _, v in { "Keys", "Next", "Leave", "Skip" } do
        local v668 = p666.panels[v];

        if v668 and v668.shown then
            table.insert(v667, v668);
        end;
    end;

    local v669, v670 = placardLayout(#v667, aspect);

    for i, v in v667 do
        local box = v669[i].box;
        v.frame.Position = UDim2.fromScale((box[1] + box[2]) / 2, (box[3] + box[4]) / 2);
        v.frame.Size = UDim2.fromScale(box[2] - box[1], box[4] - box[3]);
    end;

    local v671 = u487.fan(p666, view);
    local v672 = v671[4];
    local face = p666.spots.face;
    local v673;

    if face and face.Parent then
        v673 = outline(view, aspect, face.CFrame, face.Size / 2);
    else
        v673 = nil;
    end;

    p666.faceBox = v673;
    local rewards = p666.rewards;
    local v674 = bodyBoxes(view, aspect, p666.bodyParts or {});
    local v675 = {};
    local v676 = v671[1];
    local v677 = clearOf(v674, u6.BOX[1], u6.BOX[2]);
    v675[1], v675[2], v675[3], v675[4] = math.max(v676, v677, 0.02), math.min(v671[2], 0.98), math.max(u6.BOX[1], v672 + 0.015), math.min(u6.BOX[2], v670 - u6.PANEL_GAP);
    v675[1] = math.min(v675[1], v675[2] - u6.LEAST);
    local v678;

    if p666.ui and p666.ui.AbsoluteSize.X > 0 then
        v678 = p666.ui.AbsoluteSize;
    elseif p666.camera.ViewportSize.X > 0 then
        v678 = p666.camera.ViewportSize;
    else
        v678 = Vector2.new(1920, 1080);
    end;

    local string_format_ret = string.format("%.3f %.3f %.3f %.3f %.2f", v675[1], v675[2], v675[3], v675[4], aspect);

    if rewards.roomKey ~= string_format_ret then
        rewards.roomKey = string_format_ret;
        local v679 = u487.shapes(p666, view);
        local v680 = (v671[1] + v671[2]) / 2;
        v675[3] = u487.under(v679, v680 - 0.01, v680 + 0.01);
        local v681 = nil;
        local v682 = nil;

        for i = 1, 7 do
            v681 = u487.card(p666, v675);
            local v683 = v681.width * v681.k / aspect;
            local v684 = v681.height * v681.k;
            local v685 = v675[1];
            local math_max_ret = math.max(v675[1], v675[2] - v683);
            local math_clamp_ret = math.clamp(v680 - v683 / 2, v685, math_max_ret);
            v682 = {
                math_clamp_ret,
                math_clamp_ret + v683,
                v675[3],
                v675[3] + v684
            };
            local v686 = u487.under(v679, v682[1], v682[2]);

            if v686 <= v675[3] + 0.0001 then
                break;
            end;

            v675[3] = v686;
            local _ = i;
        end;

        v681.across = v681.width;
        local k = v681.k;
        rewards.layout = v681;
        rewards.k = k;
        rewards.plaque = v682;
        rewards.rowPixels = v681.k * v678.Y;
        rewards.kind = nil;
        u450.hint(p666);
    end;

    local plaque = rewards.plaque;
    local math_max_ret = math.max(plaque[2] - plaque[1], u5.HINT.X * 0.7);
    local math_min_ret = math.min(math_max_ret, 0.96);
    local math_min_ret2 = math.min(plaque[4] - plaque[3], rewards.k * 2.8);
    local math_clamp_ret = math.clamp((plaque[1] + plaque[2]) / 2, math_min_ret / 2 + 0.02, 0.98 - math_min_ret / 2);
    local v687 = (plaque[3] + plaque[4]) / 2;
    p666.hint.text.Position = UDim2.fromScale(math_clamp_ret, v687);
    p666.hint.text.Size = UDim2.fromScale(math_min_ret, math_min_ret2);
    p666.hint.box = {
        math_clamp_ret - math_min_ret / 2,
        math_clamp_ret + math_min_ret / 2,
        v687 - math_min_ret2 / 2,
        v687 + math_min_ret2 / 2
    };
    local hover = p666.hover;

    if rewards.box.Visible and hover then
        local v688 = u487.kind(hover);

        if rewards.kind ~= v688 then
            if hover.opened then
                local _, v689, v690 = u487.won(hover);
                rewards.size = Vector2.new(v689 * rewards.k / aspect, v690 * rewards.k);
            else
                rewards.size = Vector2.new(plaque[2] - plaque[1], plaque[4] - plaque[3]);
            end;
        end;

        local size = rewards.size;
        local Vector2_new_ret3 = Vector2.new(math.floor(size.X * v678.X + 0.5), (math.floor(size.Y * v678.Y + 0.5)));

        if rewards.kind ~= v688 or rewards.pixels ~= Vector2_new_ret3 then
            if rewards.kind ~= nil and rewards.kind ~= v688 then
                rewards.popAt = os.clock();
            end;

            rewards.kind = v688;
            rewards.pixels = Vector2_new_ret3;
            u487.fill(p666, hover);
            u450.hint(p666);
        end;

        local v691;

        if rewards.popAt then
            local v692 = (os.clock() - rewards.popAt) / u6.POP;
            v691 = math.clamp(v692, 0, 1);
        else
            v691 = 1;
        end;

        local scale = rewards.scale;
        local POP_FROM = u6.POP_FROM;
        local v693 = 1 - u6.POP_FROM;
        local math_clamp_ret2 = math.clamp(v691, 0, 1);
        scale.Scale = POP_FROM + v693 * (1 + 2.2 * (math_clamp_ret2 - 1) ^ 3 + 1.2 * (math_clamp_ret2 - 1) ^ 2);
        local v694 = (plaque[1] + plaque[2]) / 2;
        rewards.box.Position = UDim2.fromScale(v694, plaque[3]);
        rewards.box.Size = UDim2.fromScale(size.X, size.Y);
        rewards.room = {
            v694 - size.X / 2,
            v694 + size.X / 2,
            plaque[3],
            plaque[3] + size.Y
        };
    end;
end;

function u450.choose(p695) -- Line: 2364
    -- upvalues: u450 (copy)
    local v696;

    if p695.dealt == true and p695.revealing == 0 then
        v696 = not p695.finishing;
    else
        v696 = false;
    end;

    local v697;

    if v696 then
        v697 = p695.hover == nil and true or p695.message ~= nil;
    else
        v697 = v696;
    end;

    if v696 then
        v696 = not v697;
    end;

    if p695.rewards.box.Visible ~= v696 then
        p695.rewards.box.Visible = v696;

        if v696 then
            p695.rewards.popAt = os.clock();
        end;
    end;

    if p695.hint.text.Visible ~= v697 then
        p695.hint.text.Visible = v697;
    end;

    local v698 = p695.awaiting ~= nil and true or p695.finishing == true;

    for _, v in p695.panels do
        if v.away ~= v698 then
            v.away = v698;
            u450.apply(v);
        end;
    end;
end;

local function bannerAt(p699, p700, u701, u702) -- Line: 2387
    -- upvalues: outline (copy)
    local v703 = Vector3.new(0.74394464, 1.25, 0.02) * (p700.scale or 1);
    local v704 = outline(p699.view, p699.aspect, p700.frame or CFrame.identity, (Vector3.new(v703.X / 2, v703.Y / 2, 0.01)));
    local v705 = (v704[1] + v704[2]) / 2;
    local v706 = v704[3] - 0.015 - u702 / 2;

    if p700.present then
        v706 = math.min(v704[4] + 0.015 + u702 / 2, 0.895 - u702 / 2);
    end;

    local faceBox = p699.faceBox;

    if (function(p707, p708) -- Line: 2399, Name: overFace
        -- upvalues: faceBox (copy), u701 (copy), u702 (copy)
        local v709;

        if faceBox == nil then
            v709 = false;
        else
            local v710 = {
                p707 - u701 / 2,
                p707 + u701 / 2,
                p708 - u702 / 2,
                p708 + u702 / 2
            };
            local v711 = faceBox;
            local v712 = math.min(v710[2], v711[2]) - math.max(v710[1], v711[1]);
            local math_max_ret = math.max(0, v712);
            local v713 = math.min(v710[4], v711[4]) - math.max(v710[3], v711[3]);
            v709 = math_max_ret * math.max(0, v713) > 0;
        end;

        return v709;
    end)(v705, v706) then
        if faceBox[2] + 0.015 + u701 <= 0.985 then
            v705 = faceBox[2] + 0.015 + u701 / 2;
        elseif faceBox[1] - 0.015 - u701 >= 0.015 then
            v705 = faceBox[1] - 0.015 - u701 / 2;
        else
            v706 = faceBox[3] - 0.015 - u702 / 2;
        end;
    end;

    return math.clamp(v705, 0.015 + u701 / 2, 0.985 - u701 / 2), math.clamp(v706, 0.015 + u702 / 2, 0.985 - u702 / 2);
end;

local function handPosition(p714) -- Line: 2415
    -- upvalues: LocalPlayer (ref)
    local arm = p714.arm;

    if arm and arm.handPart.Parent then
        return (arm.handPart.CFrame * CFrame.new(arm.handAt)).Position;
    end;

    local v715 = LocalPlayer and LocalPlayer.Character;
    local v716;

    if v715 then
        v716 = v715:FindFirstChildOfClass("Humanoid");
    else
        v716 = v715;
    end;

    if v715 then
        v715 = v715:FindFirstChild("HumanoidRootPart");
    end;

    if v716 ~= nil and v716.Health > 0 then
        local _ = v715 == nil;
    end;

    if v715 then
        return v715.Position + Vector3.new(0, 0.5, 0);
    end;

    return p714.shot.Position;
end;

local function fly(u717, u718, u719, u720, u721) -- Line: 2429
    -- upvalues: RunService (copy), u13 (copy)
    local camera = u717.camera;
    local CFrame2 = camera.CFrame;
    local FieldOfView = camera.FieldOfView;
    local v722 = (CFrame2.Position + u718.Position) / 2;
    local v723 = u717.character and u717.character:FindFirstChild("Head");
    local v724;

    if v723 and v723:IsA("BasePart") then
        local v725 = v722 - v723.Position;
        local Vector3_new_ret = Vector3.new(v725.X, 0, v725.Z);
        v724 = Vector3_new_ret.Magnitude <= 0.0001 and Vector3.new(0, 0, 0) or Vector3_new_ret.Unit;
    else
        v724 = Vector3.new(0, 0, 0);
    end;

    local u726 = v722 + Vector3.new(0, 0.8, 0) + v724 * math.min(1.5, (u718.Position - CFrame2.Position).Magnitude * 0.15);
    local os_clock_ret = os.clock();

    if u717.flight then
        u717.flight:Disconnect();
    end;

    u717.flight = RunService.RenderStepped:Connect(function() -- Line: 2441
        -- upvalues: os_clock_ret (copy), u720 (copy), CFrame2 (copy), u726 (copy), u718 (copy), camera (copy), FieldOfView (copy), u719 (copy), u717 (copy), u721 (copy), u13 (ref)
        local success, result = pcall(function() -- Line: 2442
            -- upvalues: os_clock_ret (ref), u720 (ref), CFrame2 (ref), u726 (ref), u718 (ref), camera (ref), FieldOfView (ref), u719 (ref), u717 (ref), u721 (ref)
            local v727 = (os.clock() - os_clock_ret) / u720;
            local math_clamp_ret = math.clamp(v727, 0, 1);
            local math_clamp_ret2 = math.clamp(math_clamp_ret, 0, 1);
            local v728 = math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2);
            local v729 = CFrame2.Position:Lerp(u726, v728);
            local v730 = u726:Lerp(u718.Position, v728);
            camera.CFrame = CFrame.new(v729:Lerp(v730, v728)) * CFrame2.Rotation:Lerp(u718.Rotation, v728);
            camera.FieldOfView = FieldOfView + (u719 - FieldOfView) * v728;

            if math_clamp_ret >= 1 then
                u717.flight:Disconnect();
                u717.flight = nil;

                if u721 then
                    u721();
                end;
            end;
        end);

        if not success then
            warn("[GhostTrader] camera flight failed: " .. tostring(result));

            if u717.flight then
                u717.flight:Disconnect();
                u717.flight = nil;
            end;

            u13.leave("instant");
        end;
    end);
end;

local function restoreCamera(p731) -- Line: 2467
    -- upvalues: LocalPlayer (ref), u20 (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera ~= p731.camera then
        return;
    end;

    local saved = p731.saved;
    local v732;

    if saved.type == Enum.CameraType.Scriptable then
        v732 = Enum.CameraType.Custom;
    else
        v732 = saved.type;
    end;

    workspace_CurrentCamera.CameraType = v732;
    local v733 = LocalPlayer and LocalPlayer.Character;
    local v734;

    if v733 then
        v734 = v733:FindFirstChildOfClass("Humanoid");
    else
        v734 = v733;
    end;

    if v733 then
        v733 = v733:FindFirstChild("HumanoidRootPart");
    end;

    if v734 ~= nil and v734.Health > 0 then
        local _ = v733 == nil;
    end;

    if v734 and not v734:IsDescendantOf(workspace) then
        v734 = nil;
    end;

    local subject = saved.subject;

    if subject and subject:IsDescendantOf(workspace) then
        if subject:IsA("Humanoid") then
            if subject.Health > 0 then
                v734 = subject;
            end;
        else
            v734 = subject;
        end;
    end;

    if v734 then
        workspace_CurrentCamera.CameraSubject = v734;
    end;

    workspace_CurrentCamera.FieldOfView = saved.fov;
    u20.camera = nil;
end;

local function setHover(p735, p736) -- Line: 2494
    -- upvalues: u85 (copy)
    if p735.hover == p736 then
        return;
    end;

    if p736 and p735.message then
        p735.message = nil;
    end;

    p735.hover = p736;
    p735.armed = false;

    if p736 and (not p736.opened and os.clock() - (p735.hoverSoundAt or 0) > 0.06) then
        p735.hoverSoundAt = os.clock();
        u85.play(p735, "Hover");
    end;
end;

local function refreshHits(p737) -- Line: 2509
    local v738 = {};

    for _, v in p737.cards do
        table.insert(v738, v.hit);
    end;

    p737.hits.FilterDescendantsInstances = v738;
end;

local function deal(p739, p740) -- Line: 2516
    -- upvalues: newCard (copy), showOpened (copy), u85 (copy)
    p739.deal = p740.deal;
    p739.dealt = true;
    p739.cards = {};
    local v741 = type(p740.opened) == "table" and (p740.opened or {}) or {};
    local v742 = type(p740.won) == "table" and (p740.won or {}) or {};
    local os_clock_ret = os.clock();

    for i = 1, 6 do
        local v743 = newCard(p739, i, p740.cursed == i);
        v743.t0 = os_clock_ret + (i - 1) * 0.07;

        if v741[i] == true then
            showOpened(p739, v743, v742[i] or v742[tostring(i)]);
        end;

        p739.cards[i] = v743;
        local _ = i;
    end;

    local v744 = {};

    for _, v in p739.cards do
        table.insert(v744, v.hit);
    end;

    p739.hits.FilterDescendantsInstances = v744;

    if p739.hover ~= nil then
        p739.hover = nil;
        p739.armed = false;
    end;

    u85.play(p739, "Enter");
end;

local function foldAll(p745, p746) -- Line: 2536
    -- upvalues: u85 (copy)
    local v747 = os.clock() + (p746 or 0);

    for i, v in p745.cards do
        if v.phase ~= "fold" then
            v.phase = "fold";
            v.t0 = v747 + (6 - i) * 0.07 * 0.6;
            table.insert(p745.leaving, v);
        end;
    end;

    p745.cards = {};
    p745.dealt = false;
    local v748 = {};

    for _, v in p745.cards do
        table.insert(v748, v.hit);
    end;

    p745.hits.FilterDescendantsInstances = v748;

    if p745.hover ~= nil then
        p745.hover = nil;
        p745.armed = false;
    end;

    p745.hint.text.Visible = false;
    u85.play(p745, "Leave");
end;

local function applyState(p749, p750) -- Line: 2553
    -- upvalues: u13 (copy), paint (copy), foldAll (copy), showOpened (copy)
    if type(p750) ~= "table" then
        return;
    end;

    p749.state = p750;
    p749.answered = true;

    if p750.live == false then
        u13.leave("fly");
        u13.notice("This feature is currently not available.");

        return;
    end;

    if p749.revealing > 0 then
        paint(p749);

        return;
    end;

    if p749.deal == nil or p750.deal == p749.deal then
        if p749.deal ~= nil then
            local v751 = type(p750.won) == "table" and (p750.won or {}) or {};

            for i, v in p749.cards do
                if type(p750.opened) == "table" and (p750.opened[i] == true and not (v.opened or v.revealing)) then
                    showOpened(p749, v, v751[i] or v751[tostring(i)]);
                end;
            end;
        end;
    else
        foldAll(p749);
        p749.deal = nil;
        p749.dealAt = os.clock() + 0.38 + 0.252;
    end;

    paint(p749);
end;

local function lockOf(p752, p753) -- Line: 2605
    local v754 = p753.frame or CFrame.identity;
    local Position = (v754 * CFrame.new(0, -0.22499999999999998 * (p753.scale or 1), 0)).Position;
    local v755 = p752.view.Position - Position;
    local LookVector = v754.LookVector;

    if v755.Magnitude > 0.0001 then
        LookVector = v755.Unit;
    end;

    return CFrame.lookAt(Position, Position + LookVector);
end;

u409 = function(p756) -- Line: 2612, Name: cardFx
    -- upvalues: Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret5 (copy)
    if p756.fx then
        return p756.fx;
    end;

    local v757;

    if p756.cursed then
        v757 = Color3_fromRGB_ret3;
    else
        v757 = Color3_fromRGB_ret;
    end;

    local hit = p756.hit;
    local PointLight = Instance.new("PointLight");
    PointLight.Name = "Flash";
    local v758 = {};

    for i, v in {
        Brightness = 0,
        Range = 7,
        Shadows = false,
        Color = v757
    } or {} do
        PointLight[i] = v;
    end;

    PointLight.Parent = hit;
    v758.light = PointLight;
    local hit2 = p756.hit;
    local v759 = {
        Texture = "rbxasset://textures/particles/sparkles_main.dds",
        LightEmission = 1,
        LightInfluence = 0,
        Drag = 4,
        Enabled = false,
        Color = ColorSequence.new(v757, Color3_fromRGB_ret5),
        Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0) }),
        Lifetime = NumberRange.new(0.4, 0.9),
        Speed = NumberRange.new(4, 10),
        SpreadAngle = Vector2.new(180, 180)
    };
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Name = "Sparks";

    for i, v in v759 or {} do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = hit2;
    v758.sparks = ParticleEmitter;
    local hit3 = p756.hit;
    local v760 = {
        Texture = "rbxasset://textures/particles/smoke_main.dds",
        LightEmission = 0.8,
        LightInfluence = 0,
        Acceleration = Vector3.new(0, 1.8, 0),
        Rate = 0,
        Enabled = false,
        Color = ColorSequence.new(v757),
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

    for i, v in v760 or {} do
        ParticleEmitter2[i] = v;
    end;

    ParticleEmitter2.Parent = hit3;
    v758.wisps = ParticleEmitter2;
    p756.fx = v758;

    return v758;
end;

local function shockwave(p761, p762, u763, u764, u765, u766) -- Line: 2656
    -- upvalues: surface (copy)
    local folder = p761.folder;
    local Part = Instance.new("Part");
    Part.Name = "Shockwave";

    for i, v in {
        Size = Vector3.new(0.3, 0.3, 0.02),
        Transparency = 1,
        CFrame = p762
    } or {} do
        Part[i] = v;
    end;

    Part.Parent = folder;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    local u767 = surface(p761, Part, Enum.NormalId.Front, "Shockwave");
    u767.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
    u767.CanvasSize = Vector2.new(256, 256);
    u767.Brightness = 3;
    u767.ClipsDescendants = false;

    local function ring(p768, p769) -- Line: 2663
        -- upvalues: u767 (copy), u763 (copy), u766 (copy)
        local v770 = {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(p769, p769)
        };
        local Frame = Instance.new("Frame");
        Frame.Name = p768;

        for i, v in v770 or {} do
            Frame[i] = v;
        end;

        Frame.Parent = u767;
        local v771 = {
            CornerRadius = UDim.new(0.5, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i, v in v771 or {} do
            UICorner[i] = v;
        end;

        UICorner.Parent = Frame;
        local v772 = {
            Color = u763,
            Thickness = u766
        };
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Name = "Edge";

        for i, v in v772 or {} do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = Frame;

        return UIStroke;
    end;

    local u773 = ring("Ring", 0.86);
    local u774 = ring("Inner", 0.62);
    u774.Color = u763:Lerp(Color3.new(1, 1, 1), 0.5);
    local os_clock_ret = os.clock();
    table.insert(p761.anims, function(p775) -- Line: 2676
        -- upvalues: os_clock_ret (copy), u765 (copy), Part (copy), u764 (copy), u773 (copy), u766 (copy), u774 (copy)
        local v776 = (p775 - os_clock_ret) / u765;

        if v776 >= 1 or not Part.Parent then
            Part:Destroy();

            return true;
        end;

        local math_max_ret = math.max(v776, 0);
        local v777 = 0.3 + (u764 - 0.3) * (1 - (1 - math_max_ret) ^ 3);
        Part.Size = Vector3.new(v777, v777, 0.02);
        u773.Thickness = u766 * (1 - math_max_ret * 0.8) + 2;
        u773.Transparency = math_max_ret ^ 1.6;
        u774.Thickness = u766 * 0.4 * (1 - math_max_ret) + 1;
        u774.Transparency = math.min(1, math_max_ret * 1.4);

        return false;
    end);
end;

local function rays(u778, u779, p780, u781, u782, u783, u784, u785) -- Line: 2693
    -- upvalues: u9 (copy)
    local u786 = {};

    for i = 1, u781 do
        local folder = u778.folder;
        local v787 = {
            Transparency = 0.15,
            Material = Enum.Material.Neon,
            Color = p780,
            Size = Vector3.new(u785, u785, 0.1)
        };
        local Part = Instance.new("Part");
        Part.Name = "Ray";

        for i2, v in v787 or {} do
            Part[i2] = v;
        end;

        Part.Parent = folder;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanTouch = false;
        Part.CanQuery = false;
        Part.CastShadow = false;
        u786[i] = Part;
    end;

    local os_clock_ret = os.clock();
    table.insert(u778.anims, function(p788) -- Line: 2699
        -- upvalues: os_clock_ret (copy), u783 (copy), u779 (copy), u786 (copy), u778 (copy), u782 (copy), u781 (copy), u785 (copy), u784 (copy), u9 (ref)
        local v789 = (p788 - os_clock_ret) / u783;

        if v789 >= 1 or not u779.model.Parent then
            for _, v in u786 do
                v:Destroy();
            end;

            return true;
        end;

        local math_max_ret = math.max(v789, 0);
        local Position = (u779.frame or CFrame.identity).Position;
        local v790 = u778.view.Position - Position;
        local v791 = v790.Magnitude <= 0.0001 and Vector3.new(0, 0, 1) or v790.Unit;
        local v792 = v791:Cross(Vector3.new(0, 1, 0));
        local v793 = v792.Magnitude <= 0.0001 and Vector3.new(1, 0, 0) or v792.Unit;
        local v794 = v793:Cross(v791);
        local v795 = u782 * (1 - (1 - math.min(1, math_max_ret * 2.5)) ^ 2);

        for i, v in u786 do
            local v796 = i / u781 * 3.141592653589793 * 2 + math_max_ret * 0.9;
            local v797 = v793 * math.cos(v796) + v794 * math.sin(v796);
            local v798 = Position - v791 * 0.15 + v797 * 0.55;
            local math_max_ret2 = math.max(0.05, v795 * (0.7 + 0.3 * (i % 2)));
            v.Size = Vector3.new(u785 * (1 + 0.55 * (i % 2)), u785, math_max_ret2);
            v.CFrame = CFrame.lookAt(v798 + v797 * v.Size.Z / 2, v798 + v797 * (v.Size.Z / 2 + 1));
            v.Transparency = 0.1 + 0.9 * math_max_ret ^ 1.5;

            if u784 then
                local v799 = (math.sin(i / u781 * 3.141592653589793 * 4 + p788 * 5) + 1) / 2;
                local v800;

                if v799 < 0.5 then
                    v800 = u9.DEEP:Lerp(u9.RED, v799 * 2);
                else
                    v800 = u9.RED:Lerp(u9.HOT, (v799 - 0.5) * 2);
                end;

                v.Color = v800;
            end;
        end;

        return false;
    end);
end;

local function pillar(u801, u802, u803) -- Line: 2731
    -- upvalues: u9 (copy), u4 (copy)
    local folder = u801.folder;
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

    local function beam(p804, p805, p806, p807, p808) -- Line: 2735
        -- upvalues: Part (copy), Attachment (copy), Attachment2 (copy), u9 (ref)
        local v809 = {
            LightEmission = 1,
            LightInfluence = 0,
            FaceCamera = true,
            Segments = 10,
            Attachment0 = Attachment,
            Attachment1 = Attachment2,
            Color = u9.SHIMMER,
            Texture = p807,
            TextureMode = Enum.TextureMode.Static,
            TextureLength = p805 * 1.2,
            TextureSpeed = p806,
            Width0 = p805,
            Width1 = p805 * 0.7,
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.12, p808),
                NumberSequenceKeypoint.new(0.8, p808),
                NumberSequenceKeypoint.new(1, 1)
            })
        };
        local Beam = Instance.new("Beam");
        Beam.Name = p804;

        for i, v in v809 or {} do
            Beam[i] = v;
        end;

        Beam.Parent = Part;

        return Beam;
    end;

    local u810 = { beam("Sparkles", u4.MYTHIC_PILLAR, 1.6, "rbxasset://textures/particles/sparkles_main.dds", 0), (beam("Mist", u4.MYTHIC_PILLAR * 1.5, 0.6, "rbxasset://textures/particles/smoke_main.dds", 0.35)) };
    local os_clock_ret = os.clock();
    table.insert(u801.anims, function(p811) -- Line: 2763
        -- upvalues: os_clock_ret (copy), u803 (copy), u802 (copy), Part (copy), u801 (copy), Attachment2 (copy), u810 (copy), u4 (ref)
        local v812 = (p811 - os_clock_ret) / u803;

        if v812 >= 1 or not u802.model.Parent then
            Part:Destroy();

            return true;
        end;

        local math_max_ret = math.max(v812, 0);
        local Position = (u802.rest or (u802.frame or CFrame.identity)).Position;
        local v813;

        if u801.top then
            v813 = u801.top.Y;
        else
            v813 = Position.Y - 1.2;
        end;

        Part.CFrame = CFrame.new(Position.X, v813, Position.Z);
        local math_max_ret2 = math.max(1.5, Position.Y - v813 + 3.4);
        Attachment2.Position = Vector3.new(0, math_max_ret2, 0);
        local math_min_ret = math.min(1, math_max_ret * 8);
        local math_clamp_ret = math.clamp((math_max_ret - 0.7) / 0.3, 0, 1);

        for i, v in u810 do
            local v814 = u4.MYTHIC_PILLAR * (i == 1 and 1 or 1.5) * math_min_ret * (1 - math_clamp_ret * 0.8);
            v.Width0 = v814;
            v.Width1 = v814 * 0.7;
        end;

        u810[1].Brightness = (1 - math_clamp_ret) * 2;

        return false;
    end);
end;

local function nudge(p815, p816, p817) -- Line: 2785
    p815.nudge = {
        start = os.clock(),
        amount = p816,
        seconds = p817
    };
end;

local function screenPulse(p818, p819, p820, p821) -- Line: 2789
    -- upvalues: u4 (copy)
    local os_clock_ret = os.clock();
    p818.screenFlash = {
        start = os_clock_ret,
        color = p819,
        peak = p820,
        seconds = u4.SCREEN_FLASH_SECONDS
    };
    p818.vignettePulse = {
        start = os_clock_ret,
        amount = p821,
        seconds = u4.VIGNETTE_SECONDS
    };
end;

local function afterimage(p822, p823, p824) -- Line: 2795
    -- upvalues: u4 (copy)
    local frame = p823.frame;
    local v825 = p823.scale or 1;

    if not frame then
        return;
    end;

    local v826 = Vector3.new(0.74394464, 1.25, 0.02);
    local folder = p822.folder;
    local v827 = {
        Transparency = 0.35,
        Size = Vector3.new(v826.X * v825, v826.Y * v825, 0.01),
        Material = Enum.Material.Neon,
        Color = p824,
        CFrame = frame
    };
    local Part = Instance.new("Part");
    Part.Name = "Afterimage";

    for i, v in v827 or {} do
        Part[i] = v;
    end;

    Part.Parent = folder;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    local os_clock_ret = os.clock();
    table.insert(p822.anims, function(p828) -- Line: 2809
        -- upvalues: os_clock_ret (copy), u4 (ref), Part (copy)
        local v829 = (p828 - os_clock_ret) / u4.AFTERIMAGE_SECONDS;

        if v829 >= 1 or not Part.Parent then
            Part:Destroy();

            return true;
        end;

        Part.Transparency = math.max(v829, 0) * 0.65 + 0.35;

        return false;
    end);
end;

local function slam(u830, u831, p832, u833) -- Line: 2821
    -- upvalues: config (copy), u10 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret4 (copy), uiLabel (copy), u4 (copy), bannerAt (copy), u5 (copy)
    local v834;

    if p832 then
        v834 = p832.rarity;
    else
        v834 = p832;
    end;

    local v835 = config();

    if v835 then
        if type(v835.RarityColors) == "table" then
            v835 = v835.RarityColors[v834];
        else
            v835 = false;
        end;
    end;

    if typeof(v835) ~= "Color3" then
        v835 = u10[v834] or Color3_fromRGB_ret;
    end;

    local v836 = u830.uiRoot or u830.folder;
    local v837 = {
        BackgroundTransparency = 1,
        GroupTransparency = 1,
        ZIndex = 8,
        AnchorPoint = Vector2.new(0.5, 0.5)
    };
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "RewardName";

    for i, v in v837 or {} do
        CanvasGroup[i] = v;
    end;

    CanvasGroup.Parent = v836;
    local v838 = {
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.97, 0.9),
        BackgroundColor3 = Color3_fromRGB_ret4
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Plate";

    for i, v in v838 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = CanvasGroup;
    local v839 = {
        CornerRadius = UDim.new(0.22, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v839 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v840 = {
        Thickness = 0.04,
        Color = v835,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Ring";

    for i, v in v840 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    uiLabel(Frame, "Rarity", {
        Position = UDim2.fromScale(0.05, 0.08),
        Size = UDim2.fromScale(0.9, 0.3),
        Text = string.upper((tostring(p832 and (p832.rarity or "") or ""))),
        TextColor3 = v835
    }, 0.1);
    uiLabel(Frame, "Name", {
        Position = UDim2.fromScale(0.04, 0.4),
        Size = UDim2.fromScale(0.92, 0.5),
        Text = string.upper((tostring(p832 and (p832.name or "Reward") or "Reward"))) .. ((not p832 or type(p832.duplicateGems) ~= "number") and "" or "  +" .. p832.duplicateGems .. " GEMS")
    }, 0.1);
    local os_clock_ret = os.clock();
    table.insert(u830.anims, function(p841) -- Line: 2847
        -- upvalues: os_clock_ret (copy), u833 (copy), u831 (copy), CanvasGroup (copy), u4 (ref), bannerAt (ref), u830 (copy), u5 (ref)
        local v842 = not u833.releaseAt and -1 or p841 - u833.releaseAt;

        if v842 >= 0.3 or not (u831.model.Parent and CanvasGroup.Parent) then
            CanvasGroup:Destroy();

            return true;
        end;

        local math_clamp_ret = math.clamp((p841 - os_clock_ret) / u4.SLAM_SECONDS, 0, 1);
        local math_clamp_ret2 = math.clamp(math_clamp_ret, 0, 1);
        local v843 = 1.7 - 0.7 * (1 + 2.2 * (math_clamp_ret2 - 1) ^ 3 + 1.2 * (math_clamp_ret2 - 1) ^ 2);
        local math_clamp_ret3 = math.clamp(v842 / 0.3, 0, 1);
        local v844, v845 = bannerAt(u830, u831, u5.BANNER.X, u5.BANNER.Y);
        CanvasGroup.Position = UDim2.fromScale(v844, v845);
        CanvasGroup.Size = UDim2.fromScale(u5.BANNER.X * v843, u5.BANNER.Y * v843);
        local v846 = math.max(1 - math_clamp_ret * 1.6, 0) + math_clamp_ret3;
        CanvasGroup.GroupTransparency = math.min(1, v846);

        return false;
    end);
end;

local function flyKey(u847, u848, u849) -- Line: 2866
    -- upvalues: LocalPlayer (ref), u4 (copy), lockOf (copy)
    local folder = u847.folder;
    local Model = Instance.new("Model");
    Model.Name = "Key";

    for i, v in {} do
        Model[i] = v;
    end;

    Model.Parent = folder;
    local Color3_fromRGB_ret6 = Color3.fromRGB(190, 255, 210);

    local function piece(p850, p851, p852) -- Line: 2869
        -- upvalues: Model (copy), Color3_fromRGB_ret6 (copy)
        local v853 = {
            Size = p851,
            Material = Enum.Material.Neon,
            Color = Color3_fromRGB_ret6
        };
        local Part = Instance.new("Part");
        Part.Name = p850;
        local v854 = {};

        for i, v in v853 or {} do
            Part[i] = v;
        end;

        Part.Parent = Model;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanTouch = false;
        Part.CanQuery = false;
        Part.CastShadow = false;
        v854.part = Part;
        v854.offset = p852;

        return v854;
    end;

    local u855 = {
        piece("Bow", Vector3.new(0.2, 0.2, 0.05), CFrame.new(0, 0.2, 0) * CFrame.Angles(0, 0, 0.7853981633974483)),
        piece("Shaft", Vector3.new(0.05, 0.34, 0.05), CFrame.identity),
        piece("Tooth", Vector3.new(0.11, 0.05, 0.05), CFrame.new(0.05, -0.13, 0)),
        (piece("Tooth", Vector3.new(0.08, 0.05, 0.05), CFrame.new(0.04, -0.05, 0)))
    };
    local part = u855[1].part;
    local PointLight = Instance.new("PointLight");
    PointLight.Name = "Glow";

    for i, v in {
        Range = 4,
        Brightness = 1.5,
        Shadows = false,
        Color = Color3_fromRGB_ret6
    } or {} do
        PointLight[i] = v;
    end;

    PointLight.Parent = part;
    local part2 = u855[2].part;
    local v856 = {
        Texture = "rbxasset://textures/particles/sparkles_main.dds",
        LightEmission = 1,
        LightInfluence = 0,
        Rate = 40,
        Color = ColorSequence.new(Color3_fromRGB_ret6),
        Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 0) }),
        Lifetime = NumberRange.new(0.2, 0.35),
        Speed = NumberRange.new(0, 0.3)
    };
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Name = "Trail";

    for i, v in v856 or {} do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = part2;
    local arm = u847.arm;
    local u857;

    if arm and arm.handPart.Parent then
        u857 = (arm.handPart.CFrame * CFrame.new(arm.handAt)).Position;
    else
        local v858 = LocalPlayer and LocalPlayer.Character;
        local v859;

        if v858 then
            v859 = v858:FindFirstChildOfClass("Humanoid");
        else
            v859 = v858;
        end;

        if v858 then
            v858 = v858:FindFirstChild("HumanoidRootPart");
        end;

        if v859 ~= nil and v859.Health > 0 then
            local _ = v858 == nil;
        end;

        if v858 then
            u857 = v858.Position + Vector3.new(0, 0.5, 0);
        else
            u857 = u847.shot.Position;
        end;
    end;

    local keyAt = u849.keyAt;
    table.insert(u847.anims, function(p860) -- Line: 2891
        -- upvalues: u848 (copy), u849 (copy), Model (copy), keyAt (copy), u4 (ref), lockOf (ref), u847 (copy), u857 (copy), ParticleEmitter (copy), u855 (copy), PointLight (copy)
        if not u848.model.Parent or u848.show ~= u849 then
            Model:Destroy();

            return true;
        end;

        local v861 = (p860 - keyAt) / u4.KEY_FLIGHT;
        local v862 = lockOf(u847, u848);
        local v863;

        if v861 < 1 then
            local v864 = math.max(v861, 0) ^ 2.2;
            local v865 = (u857 + v862.Position) / 2 + Vector3.new(0, 0.55, 0);
            local v866 = u857:Lerp(v865, v864):Lerp(v865:Lerp(v862.Position, v864), v864);
            v863 = CFrame.lookAt(v866, v862.Position) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.Angles(0, v861 * 3.141592653589793 * 4, 0);
        else
            local math_clamp_ret = math.clamp((p860 - keyAt - u4.KEY_FLIGHT) / 0.16, 0, 1);
            ParticleEmitter.Enabled = false;
            v863 = v862 * CFrame.new(0, 0, math_clamp_ret * 0.05) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.Angles(0, math_clamp_ret * 3.141592653589793 / 2, 0);

            for _, v in u855 do
                v.part.Transparency = math_clamp_ret * 0.9;
            end;

            PointLight.Brightness = math_clamp_ret * 4 + 1.5;

            if math_clamp_ret >= 1 then
                Model:Destroy();

                return true;
            end;
        end;

        for _, v in u855 do
            v.part.CFrame = v863 * v.offset;
        end;

        return false;
    end);
end;

local function impact(p867, p868) -- Line: 2925
    -- upvalues: u409 (ref), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy), u4 (copy), Color3_fromRGB_ret5 (copy), shockwave (copy), lockOf (copy), screenPulse (copy)
    local v869 = u409(p868);
    local v870;

    if p868.cursed then
        v870 = Color3_fromRGB_ret3;
    else
        v870 = Color3_fromRGB_ret;
    end;

    local os_clock_ret = os.clock();
    p868.punch = {
        start = os_clock_ret,
        amount = u4.IMPACT_PUNCH,
        seconds = u4.IMPACT_PUNCH_SECONDS
    };
    p868.flash = {
        start = os_clock_ret,
        peak = u4.IMPACT_FLASH,
        seconds = u4.IMPACT_FLASH_SECONDS
    };
    v869.light.Color = v870;
    v869.sparks.Color = ColorSequence.new(v870, Color3_fromRGB_ret5);
    v869.wisps.Color = ColorSequence.new(v870);
    v869.sparks:Emit(u4.IMPACT_SPARKS);
    v869.wisps:Emit(u4.IMPACT_WISPS);
    shockwave(p867, lockOf(p867, p868), v870, u4.IMPACT_RING, u4.IMPACT_RING_SECONDS, u4.IMPACT_RING_THICKNESS);
    screenPulse(p867, v870, u4.SCREEN_FLASH, u4.VIGNETTE);
    local NUDGE = u4.NUDGE;
    local NUDGE_SECONDS = u4.NUDGE_SECONDS;
    p867.nudge = {
        start = os.clock(),
        amount = NUDGE,
        seconds = NUDGE_SECONDS
    };
end;

local function reveal(u871, u872, p873) -- Line: 2941
    -- upvalues: config (copy), u10 (copy), Color3_fromRGB_ret (copy), u4 (copy), u409 (ref), u11 (copy), u9 (copy), Color3_fromRGB_ret5 (copy), shockwave (copy), u17 (ref), rays (copy), pillar (copy), screenPulse (copy), slam (copy), u85 (copy)
    local v874;

    if p873 then
        v874 = p873.rarity;
    else
        v874 = p873;
    end;

    local v875 = config();

    if v875 then
        if type(v875.RarityColors) == "table" then
            v875 = v875.RarityColors[v874];
        else
            v875 = false;
        end;
    end;

    if typeof(v875) ~= "Color3" then
        v875 = u10[v874] or Color3_fromRGB_ret;
    end;

    local v876 = v874 == "Mythical";
    local v877 = v876 or v874 == "Legendary";
    local v878;

    if v876 then
        v878 = u4.MYTHIC_HOLD;
    else
        v878 = u4.REVEAL_HOLD;
    end;

    local v879 = u409(u872);
    local os_clock_ret = os.clock();
    local v880 = {
        start = os_clock_ret
    };
    local v881;

    if v876 then
        v881 = u4.MYTHIC_CONTINUE_AFTER;
    else
        v881 = u4.CONTINUE_AFTER;
    end;

    v880.readyAt = os_clock_ret + v881;
    u872.present = v880;
    u872.punch = {
        start = os_clock_ret,
        amount = u4.REVEAL_PUNCH * (v876 and 1.3 or 1),
        seconds = u4.REVEAL_PUNCH_SECONDS
    };
    u872.flash = {
        start = os_clock_ret,
        peak = u4.REVEAL_FLASH * (v876 and 1.4 or 1),
        seconds = u4.REVEAL_FLASH_SECONDS
    };
    local v882 = u11.RARITY[v874];
    local v883 = v882 and v882.glow or u872.style.glow;
    u872.lingering = v883;

    for _, v in u872.glowImages do
        v.ImageColor3 = v883;

        if v876 and (v.Parent and v.Parent:IsA("SurfaceGui")) then
            v.Parent.Brightness = u4.MYTHIC_GLOW[2];
        end;
    end;

    local v884;

    if v876 then
        v884 = u4.MYTHIC_GLOW[1];
    else
        v884 = nil;
    end;

    u872.glowFull = v884;
    v879.light.Color = v883;
    v879.wisps.Color = ColorSequence.new(v883);
    local v885 = u871.view.Position - (u872.frame or CFrame.identity).Position;
    local v886 = (u872.frame or CFrame.identity).Position + (v885.Magnitude <= 0.0001 and Vector3.new(0, 0, 1) or v885.Unit) * 1.5;
    local CFrame_lookAt_ret = CFrame.lookAt(v886, v886 - u871.view.LookVector);

    if v876 then
        local v887 = {
            u9.DEEP,
            u9.RED,
            u9.HOT,
            u9.RED,
            u9.DEEP,
            u9.HOT
        };

        for i = 1, 6 do
            v879.sparks.Color = ColorSequence.new(v887[i], Color3_fromRGB_ret5);
            v879.sparks:Emit((math.ceil(u4.BURST.Mythical / 6)));
            v879.wisps.Color = ColorSequence.new(v887[i]);
            v879.wisps:Emit(4);
            local _ = i;
        end;

        v879.wisps.Color = ColorSequence.new(v883);
        shockwave(u871, CFrame_lookAt_ret, u9.RED, u4.REVEAL_RING, u4.REVEAL_RING_SECONDS, u4.REVEAL_RING_THICKNESS);

        for i, v in { u9.HOT, u9.DEEP } do
            task.delay(i * 0.14, function() -- Line: 2981
                -- upvalues: u17 (ref), u871 (copy), u872 (copy), shockwave (ref), CFrame_lookAt_ret (copy), v (copy), u4 (ref), i (copy)
                if u17 == u871 and u872.model.Parent then
                    shockwave(u871, CFrame_lookAt_ret, v, u4.REVEAL_RING * u4.MYTHIC_RINGS[i], u4.REVEAL_RING_SECONDS * 1.5, u4.REVEAL_RING_THICKNESS);
                end;
            end);
        end;

        if u4.RAYS then
            rays(u871, u872, v875, u4.MYTHIC_RAYS, u4.MYTHIC_RAY_LENGTH * u4.PRESENT_RAYS, v878, true, 0.09 * u4.PRESENT_RAYS);
        end;

        pillar(u871, u872, v878);
        u871.wash = {
            start = os_clock_ret,
            seconds = v878
        };
    else
        v879.sparks.Color = ColorSequence.new(v875, Color3_fromRGB_ret5);
        v879.sparks:Emit(u4.BURST[v874] or u4.BURST.Common);
        v879.wisps:Emit(v877 and 16 or 10);
        shockwave(u871, CFrame_lookAt_ret, v875, u4.REVEAL_RING, u4.REVEAL_RING_SECONDS, u4.REVEAL_RING_THICKNESS);

        if v877 and u4.RAYS then
            rays(u871, u872, v875, 10, 2.6 * u4.PRESENT_RAYS, v878, false, 0.09 * u4.PRESENT_RAYS);
        end;
    end;

    screenPulse(u871, v875, u4.SCREEN_FLASH * (v876 and 1.3 or 0.9), u4.VIGNETTE * 0.8);
    local v888 = u4.NUDGE * (v876 and 2.2 or (v877 and 1.6 or 1.3));
    local v889 = u4.NUDGE_SECONDS * (v876 and 1.8 or 1.2);
    u871.nudge = {
        start = os.clock(),
        amount = v888,
        seconds = v889
    };
    slam(u871, u872, p873, u872.present);

    if v877 then
        u85.cue(u871, "Chuckle", os_clock_ret + 0.8, 0.88);
    end;
end;

local function goOn(p890) -- Line: 3010
    local awaiting = p890.awaiting;

    if not awaiting or os.clock() < awaiting.readyAt then
        return false;
    end;

    awaiting.gone = true;
    p890.awaiting = nil;

    if awaiting.present and not awaiting.present.releaseAt then
        awaiting.present.releaseAt = os.clock();
    end;

    return true;
end;

local function buildOverlay(p891, p892) -- Line: 3024
    -- upvalues: Color3_fromRGB_ret5 (copy), u9 (copy), Font_fromEnum_ret (copy)
    local v893 = {
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 66,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "GhostTraderUI";

    for i, v in v893 or {} do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = nil;
    ScreenGui:SetAttribute("CreatorCaptureExempt", true);
    ScreenGui:SetAttribute("SelfManagedText", true);
    local v894 = {
        gui = ScreenGui,
        edges = {}
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
        local v895 = v[1];
        local v896 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = v[2],
            Position = v[3],
            BackgroundColor3 = Color3.new(0, 0, 0)
        };
        local Frame = Instance.new("Frame");
        Frame.Name = v895;

        for i, v2 in v896 or {} do
            Frame[i] = v2;
        end;

        Frame.Parent = ScreenGui;
        local v897 = {
            Rotation = v[4],
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
        };
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Name = "Fade";

        for i, v2 in v897 or {} do
            UIGradient[i] = v2;
        end;

        UIGradient.Parent = Frame;
        table.insert(v894.edges, Frame);
    end;

    local v898 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_fromRGB_ret5
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Wash";

    for i, v in v898 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    v894.wash = Frame;
    local wash = v894.wash;
    local v899 = {
        Color = u9.SHIMMER
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "Shimmer";

    for i, v in v899 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = wash;
    v894.washGradient = UIGradient;
    local v900 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_fromRGB_ret5
    };
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Flash";

    for i, v in v900 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = ScreenGui;
    v894.flash = Frame2;
    local v901 = {
        BackgroundTransparency = 1,
        Text = "",
        TextTransparency = 1,
        TextScaled = true,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.fromScale(0.5, 0.965),
        Size = UDim2.fromScale(0.6, 0.055),
        FontFace = Font_fromEnum_ret,
        TextColor3 = Color3_fromRGB_ret5
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Continue";

    for i, v in v901 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = ScreenGui;
    v894.going = TextLabel;
    local going = v894.going;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.Name = "Limit";

    for i, v in {
        MinTextSize = 14,
        MaxTextSize = 30
    } or {} do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = going;
    local going2 = v894.going;
    local v902 = {
        Thickness = 2.5,
        Color = Color3.new(0, 0, 0),
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "TextStroke";

    for i, v in v902 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = going2;
    v894.goingStroke = UIStroke;
    v894.goingStroke.Transparency = 1;
    v894.goingShown = 0;

    for _, descendant in ScreenGui:GetDescendants() do
        if descendant:IsA("GuiObject") then
            descendant.Active = false;
            pcall(function() -- Line: 3078
                -- upvalues: descendant (copy)
                descendant.Interactable = false;
            end);
        end;
    end;

    local v903 = {
        BackgroundTransparency = 1,
        ZIndex = 10,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "UI";

    for i, v in v903 or {} do
        Frame3[i] = v;
    end;

    Frame3.Parent = ScreenGui;
    p891.uiRoot = Frame3;
    v894.going.ZIndex = 20;
    ScreenGui.Parent = p892;
    table.insert(p891.guis, ScreenGui);
    p891.overlay = v894;
    p891.ui = ScreenGui;
end;

local function stepOverlay(p904, p905) -- Line: 3092
    -- upvalues: UserInputService (copy), u4 (copy)
    local overlay = p904.overlay;

    if not overlay then
        return;
    end;

    local screenFlash = p904.screenFlash;
    local v906 = 0;

    if screenFlash then
        local v907 = (p905 - screenFlash.start) / screenFlash.seconds;

        if v907 >= 1 then
            p904.screenFlash = nil;
        else
            v906 = screenFlash.peak * (1 - math.max(v907, 0)) ^ 2;
            overlay.flash.BackgroundColor3 = screenFlash.color:Lerp(Color3.new(1, 1, 1), 0.35);
        end;
    end;

    overlay.flash.BackgroundTransparency = 1 - v906;
    local v908 = math.clamp((p905 - (p904.moodFrom or p905)) / 0.8, 0, 1) * 0.5;
    local v909 = 0;
    local vignettePulse = p904.vignettePulse;

    if vignettePulse then
        local v910 = (p905 - vignettePulse.start) / vignettePulse.seconds;

        if v910 >= 1 then
            p904.vignettePulse = nil;
        else
            v909 = vignettePulse.amount * (1 - math.max(v910, 0)) ^ 2;
        end;
    end;

    for _, v in overlay.edges do
        v.BackgroundTransparency = 1 - math.min(0.95, v909 + (v.Name ~= "Left" and 0 or v908));
    end;

    local awaiting = p904.awaiting;
    local v911 = awaiting and awaiting.readyAt <= p905 and 1 or 0;
    overlay.goingShown = overlay.goingShown + (v911 - overlay.goingShown) * math.min(1, (p904.dt or 0) * 8);

    if v911 > 0 then
        local PreferredInput = UserInputService.PreferredInput;
        overlay.going.Text = PreferredInput == Enum.PreferredInput.Touch and "Tap to continue" or (PreferredInput == Enum.PreferredInput.Gamepad and "Press A to continue" or "Click to continue");
    end;

    local v912 = overlay.goingShown * (math.sin(p905 * 3) * 0.2 + 0.8);
    overlay.going.TextTransparency = 1 - v912;
    overlay.goingStroke.Transparency = 1 - v912 * 0.8;
    local wash = p904.wash;
    local v913 = 0;

    if wash then
        local v914 = (p905 - wash.start) / wash.seconds;

        if v914 >= 1 then
            p904.wash = nil;
        else
            v913 = u4.MYTHIC_WASH * math.min(1, v914 * 6) * (1 - math.clamp((v914 - 0.75) / 0.25, 0, 1));
            overlay.washGradient.Rotation = p905 * 60 % 360;
        end;
    end;

    overlay.wash.BackgroundTransparency = 1 - v913;
end;

local function moodIn(p915, p916) -- Line: 3153
    -- upvalues: TweenService (copy), u1 (copy)
    local v917 = {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.new(1, 1, 1)
    };
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "GhostTraderMood";

    for i, v in v917 or {} do
        ColorCorrectionEffect[i] = v;
    end;

    ColorCorrectionEffect.Parent = nil;
    ColorCorrectionEffect.Parent = p916;
    p915.mood = ColorCorrectionEffect;
    p915.moodFrom = os.clock();
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.8), u1):Play();
end;

local function buildLevel(p918, p919) -- Line: 3161
    -- upvalues: u4 (copy)
    local show = p918.show;

    return not (show and (show.buildFrom and not show.flipFrom)) and 0 or math.clamp((p919 - show.buildFrom) / u4.BUILD_SECONDS, 0, 1);
end;

local function tellShow(p920, p921, p922) -- Line: 3170
    -- upvalues: u6 (copy), turnGold (copy), u409 (ref), Color3_fromRGB_ret5 (copy), u4 (copy), screenPulse (copy), u85 (copy)
    local v923;

    if type(p922) == "table" then
        v923 = u6.ORDER[p922.rarity];
    else
        v923 = false;
    end;

    if not v923 or u6.ORDER.Legendary < v923 then
        return nil;
    end;

    turnGold(p920, p921);
    local glow = p921.style.glow;
    local os_clock_ret = os.clock();
    p921.tell = glow;

    for _, v in p921.glowImages do
        v.ImageColor3 = glow;
    end;

    local v924 = u409(p921);
    v924.light.Color = glow;
    v924.wisps.Color = ColorSequence.new(glow);
    v924.sparks.Color = ColorSequence.new(glow, Color3_fromRGB_ret5);
    v924.sparks:Emit(u4.TELL_SPARKS);
    p921.flash = {
        start = os_clock_ret,
        peak = u4.TELL_FLASH,
        seconds = u4.IMPACT_FLASH_SECONDS
    };
    p921.punch = {
        start = os_clock_ret,
        amount = u4.TELL_PUNCH,
        seconds = u4.IMPACT_PUNCH_SECONDS
    };
    screenPulse(p920, glow, u4.SCREEN_FLASH * 0.6, u4.VIGNETTE * 0.5);
    local NUDGE = u4.NUDGE;
    local NUDGE_SECONDS = u4.NUDGE_SECONDS;
    p920.nudge = {
        start = os.clock(),
        amount = NUDGE,
        seconds = NUDGE_SECONDS
    };
    u85.play(p920, "Reveal", p921.cursed and 0.8 or 1.25);

    return {
        endAt = os_clock_ret + u4.TELL_SECONDS
    };
end;

local function flipShow(u925, u926, p927) -- Line: 3196
    -- upvalues: slotPose (copy), flyKey (copy), u17 (ref), u4 (copy), u85 (copy), impact (copy), tellShow (copy), plainPart (copy), CFrame_Angles_ret (copy), setLabel (copy), reveal (copy), applyState (copy)
    local u928 = {
        keyAt = os.clock(),
        result = p927
    };
    u926.show = u928;
    u925.revealing = u925.revealing + 1;
    u925.pointAt = u926;
    local u929 = {
        start = os.clock(),
        target = slotPose(u925.fanAt, u925.shot, u926.slot, 6, u925.fanScale).Position
    };
    u925.focus = u929;
    flyKey(u925, u926, u928);
    task.spawn(function() -- Line: 3204
        -- upvalues: u17 (ref), u925 (copy), u926 (copy), u928 (copy), u4 (ref), u85 (ref), impact (ref), tellShow (ref), plainPart (ref), CFrame_Angles_ret (ref), setLabel (ref), reveal (ref), u929 (copy), applyState (ref)
        local function still() -- Line: 3205
            -- upvalues: u17 (ref), u925 (ref), u926 (ref), u928 (ref)
            local v930;

            if u17 == u925 then
                v930 = not u925.finishing;

                if v930 then
                    if u926.model.Parent == nil then
                        v930 = false;
                    else
                        v930 = u926.show == u928;
                    end;
                end;
            else
                v930 = false;
            end;

            return v930;
        end;

        local u931 = false;
        local success, result = pcall(function() -- Line: 3209
            -- upvalues: u928 (ref), u4 (ref), u85 (ref), u925 (ref), u17 (ref), u926 (ref), impact (ref), tellShow (ref), plainPart (ref), CFrame_Angles_ret (ref), setLabel (ref), reveal (ref), u931 (ref), u929 (ref)
            local v932 = u928.keyAt + u4.KEY_FLIGHT;
            u85.cue(u925, "KeyIn", v932);
            u85.cue(u925, "Lock", v932 + 0.16);

            while true do
                local v933;

                if u17 == u925 then
                    v933 = not u925.finishing;

                    if v933 then
                        if u926.model.Parent == nil then
                            v933 = false;
                        else
                            v933 = u926.show == u928;
                        end;
                    end;
                else
                    v933 = false;
                end;

                if not v933 or os.clock() >= v932 then
                    break;
                end;

                task.wait();
            end;

            local v934;

            if u17 == u925 then
                v934 = not u925.finishing;

                if v934 then
                    if u926.model.Parent == nil then
                        v934 = false;
                    else
                        v934 = u926.show == u928;
                    end;
                end;
            else
                v934 = false;
            end;

            if not v934 then
                return;
            end;

            impact(u925, u926);
            u928.buildFrom = os.clock();
            u85.play(u925, "Build");

            local function tell() -- Line: 3224
                -- upvalues: u928 (ref), tellShow (ref), u925 (ref), u926 (ref)
                if u928.tell == nil and (not u928.refused and type(u928.result) == "table") then
                    u928.tell = tellShow(u925, u926, u928.result.reward) or false;
                end;
            end;

            while true do
                local v935;

                if u17 == u925 then
                    v935 = not u925.finishing;

                    if v935 then
                        if u926.model.Parent == nil then
                            v935 = false;
                        else
                            v935 = u926.show == u928;
                        end;
                    end;
                else
                    v935 = false;
                end;

                if not (v935 and (os.clock() - u928.buildFrom < u4.BUILD_SECONDS or u928.result == nil and not u928.refused)) then
                    break;
                end;

                if os.clock() - u928.buildFrom >= u4.BUILD_SECONDS * u4.TELL_FROM and (u928.tell == nil and (not u928.refused and type(u928.result) == "table")) then
                    u928.tell = tellShow(u925, u926, u928.result.reward) or false;
                end;

                task.wait();
            end;

            if u928.tell == nil and (not u928.refused and type(u928.result) == "table") then
                u928.tell = tellShow(u925, u926, u928.result.reward) or false;
            end;

            while true do
                local v936;

                if u17 == u925 then
                    v936 = not u925.finishing;

                    if v936 then
                        if u926.model.Parent == nil then
                            v936 = false;
                        else
                            v936 = u926.show == u928;
                        end;
                    end;
                else
                    v936 = false;
                end;

                if not (v936 and (u928.tell and os.clock() < u928.tell.endAt)) then
                    break;
                end;

                task.wait();
            end;

            local v937;

            if u17 == u925 then
                v937 = not u925.finishing;

                if v937 then
                    if u926.model.Parent == nil then
                        v937 = false;
                    else
                        v937 = u926.show == u928;
                    end;
                end;
            else
                v937 = false;
            end;

            if not v937 then
                return;
            end;

            if u928.refused or type(u928.result) ~= "table" then
                u926.show = nil;

                return;
            end;

            local v938;

            if type(u928.result.reward) == "table" then
                v938 = u928.result.reward;
            else
                v938 = nil;
            end;

            u926.opened = true;
            u926.reward = v938;
            local v939 = u925;
            local v940 = u926;

            if v940.plain and not v940.face then
                local v941 = plainPart(v939, v940.style.glow, false);
                local v942 = CFrame.new(0, 0, 0.012) * CFrame_Angles_ret;
                v941.Anchored = true;
                v941.CanCollide = false;
                v941.CanTouch = false;
                v941.CanQuery = false;
                v941.CastShadow = false;
                v941.Parent = v940.model;
                local v943 = {
                    part = v941,
                    offset = v942,
                    size = v941.Size
                };
                table.insert(v940.layers, v943);
                v940.scale = nil;
                v940.face = v943;
            end;

            setLabel(u925, u926, v938);
            u928.flipFrom = os.clock();
            u85.play(u925, "Flip");
            local v944;

            if v938 then
                v944 = v938.rarity;
            else
                v944 = v938;
            end;

            local v945 = u928.flipFrom + u4.FLIP_SECONDS;

            if v944 == "Epic" or (v944 == "Legendary" or v944 == "Mythical") then
                u85.cue(u925, "RevealBig", v945);

                if v944 == "Mythical" then
                    u85.cue(u925, "Mythical", v945);
                end;
            else
                u85.cue(u925, "Reveal", v945);
            end;

            if u925.pointAt == u926 then
                u925.pointAt = nil;
            end;

            task.wait(u4.FLIP_SECONDS);
            local v946;

            if u17 == u925 then
                v946 = not u925.finishing;

                if v946 then
                    if u926.model.Parent == nil then
                        v946 = false;
                    else
                        v946 = u926.show == u928;
                    end;
                end;
            else
                v946 = false;
            end;

            if not v946 then
                return;
            end;

            reveal(u925, u926, v938);
            u931 = true;
            local present = u926.present;
            local v947 = {
                card = u926,
                present = present
            };
            local v948;

            if present then
                v948 = present.readyAt;
            else
                v948 = os.clock();
            end;

            v947.readyAt = v948;
            u925.awaiting = v947;
            local v949 = os.clock() + u4.CONTINUE_TIMEOUT;

            while true do
                local v950;

                if u17 == u925 then
                    v950 = not u925.finishing;

                    if v950 then
                        if u926.model.Parent == nil then
                            v950 = false;
                        else
                            v950 = u926.show == u928;
                        end;
                    end;
                else
                    v950 = false;
                end;

                if not (v950 and (not v947.gone and os.clock() < v949)) then
                    if u925.awaiting == v947 then
                        u925.awaiting = nil;
                    end;

                    if present and not present.releaseAt then
                        present.releaseAt = os.clock();
                    end;

                    if u925.focus == u929 then
                        u929.endAt = os.clock();
                    end;

                    task.wait(u4.PRESENT_OUT);
                    local state = u928.result.state;
                    local v951;

                    if u17 == u925 then
                        v951 = not u925.finishing;

                        if v951 then
                            if u926.model.Parent == nil then
                                v951 = false;
                            else
                                v951 = u926.show == u928;
                            end;
                        end;
                    else
                        v951 = false;
                    end;

                    if v951 and (type(state) == "table" and (u925.deal ~= nil and state.deal ~= u925.deal)) then
                        task.wait(u4.DEAL_PAUSE);
                    end;

                    return;
                end;

                task.wait();
            end;
        end);

        if not success then
            warn("[GhostTrader] the flip\'s show failed: " .. tostring(result));
        end;

        if u926.show == u928 then
            u926.flip = u926.opened and 1 or 0;
        end;

        if u925.focus == u929 and not u929.endAt then
            u929.endAt = os.clock();
        end;

        u925.revealing = math.max(0, u925.revealing - 1);

        if u925.pointAt == u926 then
            u925.pointAt = nil;
        end;

        if u17 == u925 and not u925.finishing then
            local v952;

            if u931 and (type(u928.result) == "table" and type(u928.result.state) == "table") then
                v952 = u928.result.state;
            else
                v952 = u925.state;
            end;

            applyState(u925, v952);
        end;
    end);

    return u928;
end;

local function confirm(u953, p954) -- Line: 3318
    -- upvalues: u13 (copy), pulse (copy), paint (copy), flipShow (copy), u16 (copy), u17 (ref)
    if u953.finishing or not (p954 and (p954.phase ~= "fold" and not (p954.opened or (p954.show or (u953.pending or u953.revealing > 0))))) then
        return;
    end;

    local state = u953.state;

    if not state then
        return;
    end;

    if (state.keys or 0) < 1 then
        if u953 then
            u953.message = {
                text = "You need a Ghost Key to flip a card.",
                untilAt = os.clock() + 3.5
            };
        else
            u13.notice("You need a Ghost Key to flip a card.");
        end;

        pulse(u953.panels.Keys);
        paint(u953);

        return;
    end;

    local v955 = (type(state.nextAt) ~= "number" and 0 or state.nextAt) - workspace:GetServerTimeNow();

    if v955 <= 0 then
        local u956 = flipShow(u953, p954, nil);
        local u957 = {
            card = p954,
            show = u956
        };
        u953.pending = u957;
        u16.send("Flip", p954.slot);
        task.delay(6, function() -- Line: 3343
            -- upvalues: u17 (ref), u953 (copy), u957 (copy), u956 (copy), u13 (ref), u16 (ref)
            if u17 == u953 and u953.pending == u957 then
                u953.pending = nil;
                u956.refused = true;
                local v958 = u953;

                if v958 then
                    v958.message = {
                        text = "The trader didn\'t answer. Try again.",
                        untilAt = os.clock() + 3.5
                    };
                else
                    u13.notice("The trader didn\'t answer. Try again.");
                end;

                u16.send("State");
            end;
        end);

        return;
    end;

    local math_ceil_ret = math.ceil(v955);
    local math_max_ret = math.max(0, math_ceil_ret);
    local v959 = "Your next card is ready in " .. string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60) .. ".";

    if u953 then
        u953.message = {
            text = v959,
            untilAt = os.clock() + 3.5
        };
    else
        u13.notice(v959);
    end;

    pulse(u953.panels.Next);
    paint(u953);
end;

local function skip(u960) -- Line: 3352
    -- upvalues: u13 (copy), paint (copy), u16 (copy), u17 (ref)
    if u960.finishing or (u960.skipPending or not (u960.panels.Skip and u960.panels.Skip.shown)) then
        return;
    end;

    local v961 = u960.state or {};

    if (type(v961.nextAt) ~= "number" and 0 or v961.nextAt) <= workspace:GetServerTimeNow() then
        if u960 then
            u960.message = {
                text = "Your next card is ready. No need to skip!",
                untilAt = os.clock() + 3.5
            };
        else
            u13.notice("Your next card is ready. No need to skip!");
        end;

        paint(u960);

        return;
    end;

    local u962 = {};
    u960.skipPending = u962;
    u16.send("Skip");
    paint(u960);
    task.delay(6, function() -- Line: 3367
        -- upvalues: u17 (ref), u960 (copy), u962 (copy), paint (ref)
        if u17 == u960 and u960.skipPending == u962 then
            u960.skipPending = nil;
            paint(u960);
        end;
    end);
end;

u430 = function(p963, p964) -- Line: 3380, Name: pressPanel
    -- upvalues: skip (copy), u13 (copy)
    if p964.key == "Skip" then
        skip(p963);

        return;
    end;

    if p964.key == "Leave" then
        u13.leave("fly");
    end;
end;

local function rayAt(p965, p966) -- Line: 3388
    local v967 = workspace:Raycast(p966.Origin, p966.Direction * 80, p965.hits);

    if not v967 then
        return nil, nil;
    end;

    if not p965.dealt then
        return nil, nil;
    end;

    for _, v in p965.cards do
        if v.hit == v967.Instance then
            return v, nil;
        end;
    end;

    return nil, nil;
end;

local function guiTakes(p968, u969) -- Line: 3405
    -- upvalues: LocalPlayer (ref)
    local u970 = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not u970 then
        return false;
    end;

    local success, result = pcall(function() -- Line: 3410
        -- upvalues: u970 (copy), u969 (copy)
        return u970:GetGuiObjectsAtPosition(u969.X, u969.Y);
    end);

    for _, v in not success and {} or result do
        if v.Visible and (v:IsA("GuiButton") or v:IsA("TextBox")) then
            return true;
        end;
    end;

    return false;
end;

local function cursorOn(p971, p972, p973) -- Line: 3422
    local cursor = p971.cursor;
    local frame = p972.frame;
    local v974 = cursor.Direction:Dot(frame.LookVector);

    if math.abs(v974) < 0.0001 then
        return Vector2.zero, false;
    end;

    local v975 = (frame.Position - cursor.Origin):Dot(frame.LookVector) / v974;
    local v976 = cursor.Origin + cursor.Direction * v975 - frame.Position;
    local v977 = Vector3.new(0.74394464, 1.25, 0.02) * (p972.scale or 1);
    local v978 = v976:Dot(p971.view.RightVector) / (v977.X / 2);
    local v979 = v976:Dot(p971.view.UpVector) / (v977.Y / 2);
    local v980;

    if v975 > 0 and math.abs(v978) <= (p973 or 1) then
        v980 = math.abs(v979) <= (p973 or 1);
    else
        v980 = false;
    end;

    return Vector2.new(math.clamp(v978, -1, 1), (math.clamp(v979, -1, 1))), v980;
end;

local function cardPose(p981, p982, p983, p984) -- Line: 3435
    -- upvalues: slotPose (copy), cursorOn (copy), u4 (copy), u3 (ref), place (copy), afterimage (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy)
    local v985 = p981.fanScale or 1;
    local v986 = slotPose(p984, p981.shot, p982.slot, 6, v985);
    local CFrame_lookAt_ret = CFrame.lookAt(v986.Position, p981.view.Position, v986.UpVector);
    p982.h = p982.h + ((p981.hover == p982 and (not p982.opened and p982.phase ~= "fold") and 1 or 0) - p982.h) * math.min(1, p981.dt * 12);
    local hover = p981.hover;
    local v987 = not (hover and (hover ~= p982 and hover.h > 0)) and 0 or math.sign(p982.slot - hover.slot) * 0.2 * hover.h;
    local v988 = CFrame_lookAt_ret + CFrame_lookAt_ret.LookVector * ((0.42 * p982.h + (p982.opened and 0.03 or 0)) * v985) + Vector3.new(0, 1, 0) * ((0.12 * p982.h + math.sin(p983 * 1.7 + p982.slot) * 0.025) * v985) + p981.shot.RightVector * (v987 * v985);
    local Vector2_zero = Vector2.zero;

    if p981.hover == p982 and (p981.cursor and (p982.frame and (p982.phase == "idle" and not (p982.show or p982.present)))) then
        Vector2_zero = cursorOn(p981, p982);
    end;

    p982.lean = (p982.lean or Vector2.zero):Lerp(Vector2_zero, (math.min(1, p981.dt * 10)));

    if p982.lean.Magnitude > 0.001 then
        local view = p981.view;
        local v989 = CFrame.fromAxisAngle(view.UpVector, p982.lean.X * 0.12217304763960307) * CFrame.fromAxisAngle(view.RightVector, -p982.lean.Y * 0.12217304763960307);
        local v990 = view.Position - v988.Position;
        local LookVector = v988.LookVector;

        if v990.Magnitude > 0.0001 then
            LookVector = v990.Unit;
        end;

        v988 = CFrame.new(v988.Position + LookVector * 0.06 * v985 * math.min(1, p982.lean.Magnitude)) * v989 * v988.Rotation;
    end;

    p982.rest = v988;
    local v991 = (1 + 0.06 * p982.h) * v985;
    local punch = p982.punch;

    if punch then
        local v992 = (p983 - punch.start) / punch.seconds;

        if v992 >= 1 then
            p982.punch = nil;
        elseif v992 >= 0 then
            local amount = punch.amount;
            local v993 = math.min(1, v992 * 4) * 3.141592653589793 / 2;
            local v994 = amount * math.sin(v993) * math.exp(-4 * v992);
            local v995 = math.max(0, v992 - 0.25) * 11;
            v991 = v991 * (1 + v994 * math.cos(v995));
        end;
    end;

    local show = p982.show;
    local v996 = not (show and (show.buildFrom and not show.flipFrom)) and 0 or math.clamp((p983 - show.buildFrom) / u4.BUILD_SECONDS, 0, 1);

    if v996 > 0 then
        local v997 = u4.BUILD_SHAKE[1] + (u4.BUILD_SHAKE[2] - u4.BUILD_SHAKE[1]) * v996 ^ 1.5;
        local v998 = 30 + 45 * v996;
        v988 = v988 * CFrame.new(math.sin(p983 * v998) * v997, math.sin(p983 * v998 * 0.83) * v997 * 0.6, math.sin(p983 * v998 * 0.61) * v997 * 0.5) * CFrame.Angles(math.sin(p983 * v998 * 0.71) * u4.BUILD_TILT * 0.4 * v996, 0, math.sin(p983 * v998 * 1.13) * u4.BUILD_TILT * v996);
        local math_sin_ret = math.sin(p983 * v998 * 0.5);
        v991 = v991 * (1 + 0.05 * v996 * math.abs(math_sin_ret));
    end;

    local present = p982.present;

    if present then
        local v999 = p983 - present.start;
        local v1000;

        if v999 < u4.PRESENT_IN then
            local math_clamp_ret = math.clamp(v999 / u4.PRESENT_IN, 0, 1);
            v1000 = 1 + 2.2 * (math_clamp_ret - 1) ^ 3 + 1.2 * (math_clamp_ret - 1) ^ 2;
        elseif present.releaseAt and p983 >= present.releaseAt then
            local math_clamp_ret = math.clamp((p983 - present.releaseAt) / u4.PRESENT_OUT, 0, 1);
            v1000 = 1 - math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
        else
            v1000 = 1;
        end;

        if present.releaseAt and present.releaseAt + u4.PRESENT_OUT <= p983 then
            p982.present = nil;
            v1000 = 0;
        end;

        if v1000 > 0 then
            local view = p981.view;
            local v1001 = math.sin(v999 * u4.PRESENT_BOB_SPEED) * u4.PRESENT_BOB;
            local aspect = p981.aspect;
            local X = u4.PRESENT_AT.X;
            local Y = u4.PRESENT_AT.Y;
            local PRESENT_DEPTH = u4.PRESENT_DEPTH;
            local math_rad_ret = math.rad(u3 / 2);
            local math_tan_ret = math.tan(math_rad_ret);
            local v1002 = view.Position + view:VectorToWorldSpace((Vector3.new((X * 2 - 1) * math_tan_ret * aspect, (1 - Y * 2) * math_tan_ret, -1))) * PRESENT_DEPTH + view.UpVector * v1001;
            v988 = v988:Lerp(CFrame.lookAt(v1002, v1002 - view.LookVector, view.UpVector), (math.clamp(v1000, 0, 1)));
            local v1003 = u4.PRESENT_HEIGHT * 2 * u4.PRESENT_DEPTH;
            local math_rad_ret2 = math.rad(u3 / 2);
            v991 = v991 * (1 + (v1003 * math.tan(math_rad_ret2) / 1.25 / v985 - 1) * v1000);
        end;
    end;

    local show2 = p982.show;

    if show2 and show2.flipFrom then
        local math_clamp_ret = math.clamp((p983 - show2.flipFrom) / u4.FLIP_SECONDS, 0, 1);
        local v1004;

        if math_clamp_ret >= 1 then
            v1004 = 1;
        else
            local math_clamp_ret2 = math.clamp(math_clamp_ret, 0, 1);
            v1004 = 1 + 2.2 * (math_clamp_ret2 - 1) ^ 3 + 1.2 * (math_clamp_ret2 - 1) ^ 2;
        end;

        p982.flip = v1004;
    end;

    if p982.flip > 0 then
        local v1005 = math.clamp(p982.flip, 0, 1) * 3.141592653589793;
        local math_sin_ret = math.sin(v1005);
        v988 = v988 * CFrame.new(0, math_sin_ret * 0.45 * v985, -math_sin_ret * 0.3 * v985) * CFrame.Angles(0, 3.141592653589793 * p982.flip, 0);
    end;

    local Vector2_zero2 = Vector2.zero;
    local v1006;

    if present and (p981.cursor and (p982.frame and (p981.awaiting and p981.awaiting.card == p982))) then
        local v1007;
        v1006, v1007 = cursorOn(p981, p982, u4.INSPECT_EDGE);

        if not v1007 then
            v1006 = Vector2_zero2;
        end;
    else
        v1006 = Vector2_zero2;
    end;

    p982.inspect = (p982.inspect or Vector2.zero):Lerp(v1006, (math.min(1, p981.dt * u4.INSPECT_EASE)));

    if p982.inspect.Magnitude > 0.001 then
        local view = p981.view;
        local v1008 = CFrame.fromAxisAngle(view.UpVector, p982.inspect.X * u4.INSPECT_TILT) * CFrame.fromAxisAngle(view.RightVector, -p982.inspect.Y * u4.INSPECT_TILT);
        v988 = CFrame.new(v988.Position) * v1008 * v988.Rotation;
        v991 = v991 * (1 + u4.INSPECT_GROW * math.min(1, p982.inspect.Magnitude));
    end;

    local Position = p981.spots.lantern.Position;

    if p982.phase == "unfold" or p982.phase == "fold" then
        local math_clamp_ret = math.clamp((p983 - p982.t0) / (p982.phase == "unfold" and 0.55 or 0.38), 0, 1);

        if p982.phase == "unfold" and math_clamp_ret >= 1 then
            p982.phase = "idle";
        else
            local v1009;

            if p982.phase == "unfold" then
                local math_clamp_ret2 = math.clamp(math_clamp_ret, 0, 1);
                v1009 = math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2);
            else
                local math_clamp_ret2 = math.clamp(math_clamp_ret, 0, 1);
                v1009 = 1 - math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2);
            end;

            local v1010 = (Position + v988.Position) / 2 + Vector3.new(0, 0.9, 0);
            local v1011 = Position:Lerp(v1010, v1009):Lerp(v1010:Lerp(v988.Position, v1009), v1009);
            local v1012 = v988.Rotation * CFrame.Angles(0, p982.slot <= 3 and -1.5707963267948966 or 1.5707963267948966, 0);
            local CFrame_new_ret = CFrame.new(v1011);
            local Rotation = v988.Rotation;
            local v1013;

            if p982.phase == "unfold" then
                local math_clamp_ret2 = math.clamp(math_clamp_ret, 0, 1);
                v1013 = 1 + 2.2 * (math_clamp_ret2 - 1) ^ 3 + 1.2 * (math_clamp_ret2 - 1) ^ 2;
            else
                v1013 = v1009;
            end;

            v988 = CFrame_new_ret * v1012:Lerp(Rotation, v1013);
            v991 = v991 * (0.12 + 0.88 * v1009);
            local v1014;

            if p982.phase == "fold" then
                v1014 = math_clamp_ret >= 1;
            else
                v1014 = false;
            end;

            p982.gone = v1014;
        end;
    end;

    local v1015 = 0;

    if p982.flash then
        local v1016 = (p983 - p982.flash.start) / p982.flash.seconds;

        if v1016 >= 1 then
            p982.flash = nil;
        elseif v1016 >= 0 then
            v1015 = p982.flash.peak * (1 - v1016) ^ 2;
        end;
    end;

    local v1017;

    if p982.gone then
        v1017 = 1;
    elseif p982.lingering then
        v1017 = p982.glowFull or 0.3;
    else
        v1017 = p982.tell and 0.15 or 0.5;
    end;

    local v1018;

    if p982.gone then
        v1018 = 1;
    else
        local v1019 = v1017 - math.min(0.35, v1015 * 0.05) + math.sin(p983 * 2.2 + p982.slot) * 0.06;
        v1018 = math.clamp(v1019, 0, 1);
    end;

    if p982.glowShown ~= v1018 then
        p982.glowShown = v1018;

        for _, v in p982.glowImages do
            v.ImageTransparency = v1018;
        end;
    end;

    local fx = p982.fx;

    if fx then
        local v1020 = v1015 + (v996 <= 0 and 0 or (0.5 + math.random() * 1.8) * v996);

        if p982.lingering and not p982.gone then
            v1020 = math.max(v1020, 0.7);
        end;

        fx.light.Brightness = p982.gone and 0 or v1020;
        local v1021;

        if v996 > 0 then
            v1021 = true;
        elseif p982.lingering == nil then
            v1021 = false;
        else
            v1021 = not p982.gone and p982.phase ~= "fold";
        end;

        fx.wisps.Rate = v996 <= 0 and 2 or 8 + 32 * v996;

        if fx.wisps.Enabled ~= v1021 then
            fx.wisps.Enabled = v1021;
        end;
    end;

    place(p982, v988, (math.max(v991, 0.05)));

    if (v996 > 0.3 or show2 and show2.flipFrom and p983 - show2.flipFrom < u4.FLIP_SECONDS + 0.05) and (p982.nextGhost or 0) <= p983 then
        p982.nextGhost = p983 + u4.AFTERIMAGE_EVERY;
        local v1022;

        if p982.cursed then
            v1022 = Color3_fromRGB_ret3;
        else
            v1022 = Color3_fromRGB_ret;
        end;

        afterimage(p981, p982, v1022);
    end;
end;

local function focusView(p1023, p1024) -- Line: 3594
    local v1025 = p1023.shot.Position:Lerp(p1024, 0.15) + p1023.shot.RightVector * 0.3 + Vector3.new(0, 0.1, 0);

    return CFrame.lookAt(v1025, p1024:Lerp(p1023.fanAt, 0.5));
end;

local function stepFocus(p1026, p1027) -- Line: 3599
    -- upvalues: u7 (copy)
    local focus = p1026.focus;

    if not focus then
        p1026.view = p1026.shot;

        return;
    end;

    local v1028;

    if focus.endAt and focus.endAt <= p1027 then
        local v1029 = (p1027 - focus.endAt) / 0.5;

        if v1029 >= 1 then
            p1026.focus = nil;
            p1026.view = p1026.shot;

            return;
        end;

        local math_clamp_ret = math.clamp(v1029, 0, 1);
        v1028 = 1 - math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
    else
        local math_clamp_ret = math.clamp((p1027 - focus.start) / 0.35, 0, 1);
        v1028 = math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
    end;

    local shot = p1026.shot;
    local target = focus.target;
    local v1030 = p1026.shot.Position:Lerp(target, u7.TOWARD) + p1026.shot.RightVector * u7.SIDE + Vector3.new(0, 1, 0) * u7.UP;
    p1026.view = shot:Lerp(CFrame.lookAt(v1030, target:Lerp(p1026.fanAt, 0.5)), v1028);
end;

local function stepMove(p1031, p1032) -- Line: 3620
    -- upvalues: LocalPlayer (ref), u16 (copy)
    local move = p1031.move;

    if not move then
        return;
    end;

    local v1033 = LocalPlayer and LocalPlayer.Character;
    local v1034;

    if v1033 then
        v1034 = v1033:FindFirstChildOfClass("Humanoid");
    else
        v1034 = v1033;
    end;

    local v1035;

    if v1033 then
        v1035 = v1033:FindFirstChild("HumanoidRootPart");
    else
        v1035 = v1033;
    end;

    if v1034 ~= nil and v1034.Health > 0 then
        local _ = v1035 == nil;
    end;

    if not v1035 or v1033 ~= p1031.character then
        p1031.move = nil;

        return;
    end;

    local math_clamp_ret = math.clamp((p1032 - move.start) / 0.75, 0, 1);
    local from = move.from;
    local stand = p1031.stand;
    local math_clamp_ret2 = math.clamp(math_clamp_ret, 0, 1);
    v1033:PivotTo(from:Lerp(stand, math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2)) * v1035.CFrame:ToObjectSpace(v1033:GetPivot()));
    v1035.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
    v1035.AssemblyAngularVelocity = Vector3.new(0, 0, 0);

    if math_clamp_ret >= 1 then
        p1031.move = nil;
        u16.send("Moved");
    end;
end;

local function step(p1036, p1037) -- Line: 3640
    -- upvalues: stepMove (copy), u27 (copy), deal (copy), UserInputService (copy), rayAt (copy), setHover (copy), cardPose (copy), stepOverlay (copy), stepFocus (ref), aimArm (copy), paint (copy), u450 (copy), layout (ref)
    local os_clock_ret = os.clock();
    p1036.dt = p1037;
    stepMove(p1036, os_clock_ret);
    u27.step(p1036, os_clock_ret);
    local fanAt = p1036.fanAt;

    if not p1036.dealt and (p1036.state and (p1036.deal == nil and (p1036.dealAt <= os_clock_ret and p1036.revealing == 0))) then
        deal(p1036, p1036.state);
    end;

    p1036.cursor = nil;

    if p1036.testCursor or UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
        local v1038 = p1036.testCursor or UserInputService:GetMouseLocation();
        p1036.cursor = p1036.camera:ViewportPointToRay(v1038.X, v1038.Y);

        if p1036.dealt and not (p1036.pending or p1036.lockHover) then
            local v1039 = rayAt(p1036, p1036.cursor);

            if p1036.revealing == 0 then
                if v1039 then
                    p1036.onCardAt = os_clock_ret;
                end;

                if v1039 or os_clock_ret - (p1036.onCardAt or 0) > 0.18 then
                    setHover(p1036, v1039);
                end;
            end;
        end;
    end;

    for _, v in p1036.cards do
        cardPose(p1036, v, os_clock_ret, fanAt);
    end;

    for i = #p1036.leaving, 1, -1 do
        local v1040 = p1036.leaving[i];
        cardPose(p1036, v1040, os_clock_ret, fanAt);
        local v1041;

        if v1040.gone then
            v1040.model:Destroy();
            table.remove(p1036.leaving, i);
            v1041 = i;
        else
            v1041 = i;
        end;
    end;

    for i = #p1036.anims, 1, -1 do
        local v1042;

        if p1036.anims[i](os_clock_ret, p1037) then
            table.remove(p1036.anims, i);
            v1042 = i;
        else
            v1042 = i;
        end;
    end;

    stepOverlay(p1036, os_clock_ret);
    stepFocus(p1036, os_clock_ret);
    local CFrame_identity = CFrame.identity;
    local nudge2 = p1036.nudge;

    if nudge2 then
        local v1043 = (os_clock_ret - nudge2.start) / nudge2.seconds;

        if v1043 >= 1 then
            p1036.nudge = nil;
        else
            local v1044 = nudge2.amount * (1 - v1043) ^ 2;
            CFrame_identity = CFrame.new(math.sin(os_clock_ret * 71) * v1044, math.sin(os_clock_ret * 53) * v1044 * 0.7, 0) * CFrame.Angles(0, 0, math.sin(os_clock_ret * 61) * v1044 * 0.12);
        end;
    end;

    if not p1036.flight then
        local v1045 = p1036.view * CFrame_identity;

        if p1036.camera.CFrame ~= v1045 then
            p1036.camera.CFrame = v1045;
        end;
    end;

    local arm = p1036.arm;

    if arm and (arm.motor.Parent and arm.motor.Part0) then
        local v1046 = p1036.pointAt or p1036.hover;
        arm.weight = arm.weight + ((v1046 and (v1046.frame and v1046.phase ~= "fold") and 1 or 0) - arm.weight) * math.min(1, p1037 * 9);

        if v1046 and v1046.frame then
            arm.target = v1046.frame.Position - v1046.frame.UpVector * (0.0625 * (v1046.scale or 1));
        end;

        if arm.weight > 0.001 and arm.target then
            arm.motor.C0 = aimArm(arm, arm.motor.Part0.CFrame, arm.target, arm.weight);
        elseif arm.motor.C0 ~= arm.c0 then
            arm.motor.C0 = arm.c0;
        end;
    end;

    if (p1036.nextPaint or 0) <= os_clock_ret then
        p1036.nextPaint = os_clock_ret + 0.25;
        paint(p1036);
    end;

    u450.choose(p1036);
    layout(p1036);
end;

local function finish(u1047) -- Line: 3733
    -- upvalues: u17 (ref), u16 (copy), setHover (copy), LocalPlayer (ref), Session (copy), foldAll (copy), RunService (copy), step (copy), TweenService (copy), fly (copy), u27 (copy), restoreCamera (copy), u20 (copy), showPlates (copy), sweepLeftovers (copy)
    local u1048 = u17;

    if not u1048 then
        return;
    end;

    if u1048.finishing then
        if u1047 ~= "fly" then
            u1048.abort = u1047;
        end;

        return;
    end;

    u1048.finishing = true;
    u1048.awaiting = nil;
    pcall(u16.send, "Leave");

    for _, v in u1048.connections do
        v:Disconnect();
    end;

    table.clear(u1048.connections);

    if u1048.flight then
        u1048.flight:Disconnect();
        u1048.flight = nil;
    end;

    pcall(setHover, u1048, nil);
    pcall(function() -- Line: 3757
        -- upvalues: u1048 (copy)
        u1048.hint.text.Visible = false;
        u1048.rewards.box.Visible = false;

        for _, v in u1048.panels do
            v.frame.Visible = false;
        end;
    end);
    u1048.pointAt = nil;
    local v1049 = {};

    local function urgent(p1050) -- Line: 3767
        -- upvalues: u1048 (copy)
        u1048.abort = p1050;
    end;

    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
    table.insert(v1049, AttributeChangedSignal:Connect(function() -- Line: 3770
        -- upvalues: LocalPlayer (ref), u1048 (copy)
        if LocalPlayer:GetAttribute("InMatch") == true then
            u1048.abort = "instant";
        end;
    end));
    local AttributeChangedSignal2 = Session:GetAttributeChangedSignal("MapChanging");
    table.insert(v1049, AttributeChangedSignal2:Connect(function() -- Line: 3775
        -- upvalues: Session (ref), u1048 (copy)
        if Session:GetAttribute("MapChanging") == true then
            u1048.abort = "instant";
        end;
    end));
    local AttributeChangedSignal3 = LocalPlayer:GetAttributeChangedSignal("CutsceneActive");
    table.insert(v1049, AttributeChangedSignal3:Connect(function() -- Line: 3780
        -- upvalues: LocalPlayer (ref), u1048 (copy)
        if LocalPlayer:GetAttribute("CutsceneActive") == true then
            u1048.abort = "instant";
        end;
    end));
    local success, result = pcall(function() -- Line: 3785
        -- upvalues: u1047 (ref), u1048 (copy), foldAll (ref), RunService (ref), step (ref), TweenService (ref), LocalPlayer (ref), fly (ref), u27 (ref)
        if u1047 ~= "fly" then
            return;
        end;

        local v1051;

        if u1048.spots.lantern.Parent and #u1048.cards > 0 then
            foldAll(u1048);
            v1051 = true;
        else
            v1051 = false;
        end;

        local v1052 = os.clock() + (v1051 and 0.632 or 0.15);

        while not u1048.abort and os.clock() < v1052 do
            local v1053 = RunService.RenderStepped:Wait();
            local success, result = pcall(step, u1048, v1053);

            if not success then
                warn("[GhostTrader] folding the cards failed: " .. tostring(result));
                break;
            end;
        end;

        if u1048.mood then
            TweenService:Create(u1048.mood, TweenInfo.new(0.7), {
                Brightness = 0,
                Contrast = 0,
                Saturation = 0,
                TintColor = Color3.new(1, 1, 1)
            }):Play();
        end;

        local v1054 = LocalPlayer and LocalPlayer.Character;
        local v1055;

        if v1054 then
            v1055 = v1054:FindFirstChildOfClass("Humanoid");
        else
            v1055 = v1054;
        end;

        if v1054 then
            v1054 = v1054:FindFirstChild("HumanoidRootPart");
        end;

        local v1056;

        if v1055 == nil or v1055.Health <= 0 then
            v1056 = false;
        else
            v1056 = v1054 ~= nil;
        end;

        if not u1048.abort and (v1056 and (v1054 and (workspace.CurrentCamera == u1048.camera and u1048.camera.CameraType == Enum.CameraType.Scriptable))) then
            local u1057 = false;
            fly(u1048, v1054.CFrame * u1048.offset, u1048.saved.fov, 0.7, function() -- Line: 3812
                -- upvalues: u1057 (ref)
                u1057 = true;
            end);
            u1048.othersFade = {
                to = 0,
                seconds = 0.7,
                from = u1048.othersK or 1,
                start = os.clock()
            };
            local os_clock_ret = os.clock();

            while not (u1057 or (u1048.abort or os.clock() - os_clock_ret >= 1.7)) do
                RunService.RenderStepped:Wait();
                pcall(u27.step, u1048, os.clock());
            end;

            if u1048.flight then
                u1048.flight:Disconnect();
                u1048.flight = nil;
            end;
        end;

        if u1048.abort == "external" then
            u1047 = "external";
        end;
    end);

    if not success then
        warn("[GhostTrader] the way back failed: " .. tostring(result));
    end;

    for _, v in v1049 do
        v:Disconnect();
    end;

    pcall(function() -- Line: 3839
        -- upvalues: u1048 (copy)
        local arm = u1048.arm;

        if arm and arm.motor.Parent then
            arm.motor.C0 = arm.c0;
        end;
    end);

    if u1047 == "external" then
        u20.camera = nil;
    else
        pcall(restoreCamera, u1048);
    end;

    pcall(function() -- Line: 3850
        -- upvalues: u1048 (copy), u20 (ref)
        if u1048.controls then
            u1048.controls:Enable();

            if u20.controls == u1048.controls then
                u20.controls = nil;
            end;
        end;
    end);
    pcall(function() -- Line: 3858
        -- upvalues: u1048 (copy)
        u1048.hide:restore();
    end);
    pcall(showPlates, u1048);
    pcall(function() -- Line: 3863
        -- upvalues: u1048 (copy), u20 (ref)
        if u1048.visibility then
            local visibility = u1048.visibility;
            u1048.visibility = nil;

            if u20.visibility == visibility then
                u20.visibility = nil;
            end;

            visibility:destroy();
        end;
    end);
    pcall(function() -- Line: 3873
        -- upvalues: u1048 (copy)
        for _, v in u1048.guis do
            v:Destroy();
        end;
    end);
    pcall(function() -- Line: 3878
        -- upvalues: u1048 (copy)
        u1048.folder:Destroy();
    end);
    pcall(function() -- Line: 3881
        -- upvalues: u1048 (copy)
        if u1048.mood then
            u1048.mood:Destroy();
        end;
    end);
    u17 = nil;
    pcall(function() -- Line: 3888
        -- upvalues: LocalPlayer (ref)
        LocalPlayer:SetAttribute("GhostTraderActive", nil);
    end);
    pcall(sweepLeftovers, "after the trader");
end;

local function enter(u1058) -- Line: 3894
    -- upvalues: LocalPlayer (ref), spotsOf (copy), topOf (copy), LocalHide (copy), frameFor (copy), u17 (ref), u20 (copy), u85 (copy), buildOverlay (copy), buildPanels (copy), layout (ref), moodIn (copy), paint (copy), Presentation (copy), u27 (copy), u18 (copy), watchPlate (copy), armOf (ref), u19 (copy), fly (copy), u3 (ref), u13 (copy), Session (copy), UserInputService (copy), guiTakes (copy), rayAt (copy), setHover (copy), confirm (copy), skip (copy), RunService (copy), step (copy)
    local u1059 = LocalPlayer and LocalPlayer.Character;
    local v1060;

    if u1059 then
        v1060 = u1059:FindFirstChildOfClass("Humanoid");
    else
        v1060 = u1059;
    end;

    local v1061;

    if u1059 then
        v1061 = u1059:FindFirstChild("HumanoidRootPart");
    else
        v1061 = u1059;
    end;

    local v1062;

    if v1060 == nil or v1060.Health <= 0 then
        v1062 = false;
    else
        v1062 = v1061 ~= nil;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v1063;

    if u1058 then
        v1063 = spotsOf(u1058);
    else
        v1063 = u1058;
    end;

    if not (v1062 and (workspace_CurrentCamera and (v1063 and u1058:IsDescendantOf(workspace)))) then
        return false;
    end;

    if not v1063.stand then
        local Position = v1061.Position;
        local v1064;

        if v1063.anchor then
            v1064 = v1063.anchor.WorldPosition + Vector3.new(0, 0.8, 0);
        else
            local v1065 = topOf(v1063.table);
            local v1066 = Position - v1065;
            local Vector3_new_ret = Vector3.new(v1066.X, 0, v1066.Z);
            v1064 = v1065 + (Vector3_new_ret.Magnitude <= 0.0001 and Vector3.new(0, 0, 1) or Vector3_new_ret.Unit) * 1.1 + Vector3.new(0, 2.25, 0);
        end;

        local v1067 = v1064 - v1061.Position;
        local Vector3_new_ret = Vector3.new(v1067.X, 0, v1067.Z);

        if Vector3_new_ret.Magnitude > 0.1 then
            v1061.CFrame = CFrame.lookAt(v1061.Position, v1061.Position + Vector3_new_ret.Unit);
        end;
    end;

    local u1068 = {
        revealing = 0,
        dt = 0,
        model = u1058,
        spots = v1063,
        camera = workspace_CurrentCamera,
        character = u1059,
        saved = {
            type = workspace_CurrentCamera.CameraType,
            subject = workspace_CurrentCamera.CameraSubject,
            fov = workspace_CurrentCamera.FieldOfView
        },
        offset = v1061.CFrame:ToObjectSpace(workspace_CurrentCamera.CFrame),
        hide = LocalHide.new(),
        plates = {},
        connections = {},
        guis = {},
        cards = {},
        leaving = {},
        anims = {},
        dealAt = os.clock() + 0.32000000000000006,
        hits = RaycastParams.new()
    };
    u1068.hits.FilterType = Enum.RaycastFilterType.Include;
    u1068.hits.FilterDescendantsInstances = {};
    local ViewportSize = workspace_CurrentCamera.ViewportSize;
    frameFor(u1068, u1059, ViewportSize.Y <= 0 and 1.7777777777777777 or ViewportSize.X / ViewportSize.Y);
    local shot = u1068.shot;
    u17 = u1068;
    LocalPlayer:SetAttribute("GhostTraderActive", true);
    u20.camera = {
        camera = workspace_CurrentCamera,
        type = u1068.saved.type,
        subject = u1068.saved.subject,
        fov = u1068.saved.fov
    };
    local Folder = Instance.new("Folder");
    Folder.Name = "GhostTraderView";

    for i, v in {} do
        Folder[i] = v;
    end;

    Folder.Parent = workspace_CurrentCamera;
    u1068.folder = Folder;
    u85.warm(u1068);
    local u1069 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    function u1068.guiHome(p1070) -- Line: 3941
        -- upvalues: u1069 (copy), u1068 (copy)
        p1070.Parent = u1069 or u1068.folder;
    end;

    buildOverlay(u1068, u1069);
    buildPanels(u1068);
    local v1071 = {};

    for _, v in u1068.cards do
        table.insert(v1071, v.hit);
    end;

    u1068.hits.FilterDescendantsInstances = v1071;
    layout(u1068);
    moodIn(u1068, workspace_CurrentCamera);
    paint(u1068);
    local success, result = pcall(function() -- Line: 3951
        -- upvalues: LocalPlayer (ref), Presentation (ref), u1068 (copy), u20 (ref)
        if LocalPlayer:GetAttribute("CreatorUIHidden") ~= true then
            local v1072 = require(Presentation:WaitForChild("CreatorVisibility", 5)).new(LocalPlayer);
            u1068.visibility = v1072;
            u20.visibility = v1072;
            v1072:setHidden(true);
        end;
    end);

    if not success then
        warn("[GhostTrader] couldn\'t hide the UI: " .. tostring(result));
    end;

    pcall(function() -- Line: 2170
        -- upvalues: u1068 (copy), u27 (ref)
        u1068.hide:sweep();

        if u1068.othersFade then
            u27.fade(u1068, u1068.othersK or 0);
        end;
    end);

    for i, v in u1068.hide.saved do
        if u18[i] == nil then
            u18[i] = v;
        end;
    end;

    u1068.othersFade = {
        from = 0,
        to = 1,
        seconds = 0.8,
        start = os.clock()
    };
    u27.fade(u1068, 0);

    if u1069 then
        for _, child in u1069:GetChildren() do
            watchPlate(u1068, child);
        end;

        table.insert(u1068.connections, u1069.ChildAdded:Connect(function(p1073) -- Line: 3970
            -- upvalues: watchPlate (ref), u1068 (copy)
            watchPlate(u1068, p1073);
        end));
    end;

    u1068.arm = armOf(u1059);

    if u1068.arm then
        u19[u1068.arm.motor] = u19[u1068.arm.motor] or u1068.arm.c0;
    end;

    pcall(function() -- Line: 3979
        -- upvalues: LocalPlayer (ref), u1068 (copy), u20 (ref)
        local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts");

        if PlayerScripts then
            PlayerScripts = PlayerScripts:FindFirstChild("PlayerModule");
        end;

        if PlayerScripts then
            local Controls = require(PlayerScripts):GetControls();
            Controls:Disable();
            u1068.controls = Controls;
            u20.controls = Controls;
        end;
    end);
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    fly(u1068, shot, u3, 0.8, nil);
    local connections = u1068.connections;
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
    table.insert(connections, AttributeChangedSignal:Connect(function() -- Line: 3992
        -- upvalues: LocalPlayer (ref), u13 (ref)
        if LocalPlayer:GetAttribute("InMatch") == true then
            u13.leave("instant");
        end;
    end));
    local connections2 = u1068.connections;
    local AttributeChangedSignal2 = Session:GetAttributeChangedSignal("MapChanging");
    table.insert(connections2, AttributeChangedSignal2:Connect(function() -- Line: 3997
        -- upvalues: Session (ref), u13 (ref)
        if Session:GetAttribute("MapChanging") == true then
            u13.leave("instant");
        end;
    end));
    local connections3 = u1068.connections;
    local AttributeChangedSignal3 = LocalPlayer:GetAttributeChangedSignal("CutsceneActive");
    table.insert(connections3, AttributeChangedSignal3:Connect(function() -- Line: 4004
        -- upvalues: LocalPlayer (ref), u13 (ref)
        if LocalPlayer:GetAttribute("CutsceneActive") == true then
            u13.leave("instant");
        end;
    end));
    table.insert(u1068.connections, u1059.AncestryChanged:Connect(function() -- Line: 4009
        -- upvalues: u1059 (copy), u13 (ref)
        if not u1059:IsDescendantOf(workspace) then
            u13.leave("instant");
        end;
    end));

    if v1060 then
        table.insert(u1068.connections, v1060.Died:Connect(function() -- Line: 4015
            -- upvalues: u13 (ref)
            u13.leave("instant");
        end));
    end;

    local connections4 = u1068.connections;
    local PropertyChangedSignal = workspace_CurrentCamera:GetPropertyChangedSignal("CameraType");
    table.insert(connections4, PropertyChangedSignal:Connect(function() -- Line: 4019
        -- upvalues: workspace_CurrentCamera (copy), u13 (ref)
        if workspace_CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
            u13.leave("external");
        end;
    end));
    local connections5 = u1068.connections;
    local PropertyChangedSignal2 = workspace:GetPropertyChangedSignal("CurrentCamera");
    table.insert(connections5, PropertyChangedSignal2:Connect(function() -- Line: 4024
        -- upvalues: u13 (ref)
        u13.leave("external");
    end));
    table.insert(u1068.connections, u1058.AncestryChanged:Connect(function() -- Line: 4027
        -- upvalues: u1058 (copy), u13 (ref)
        if not u1058:IsDescendantOf(workspace) then
            u13.leave("instant");
        end;
    end));
    table.insert(u1068.connections, UserInputService.InputBegan:Connect(function(p1074, p1075) -- Line: 4033
        -- upvalues: u13 (ref), u1068 (copy), guiTakes (ref), rayAt (ref), setHover (ref), confirm (ref), skip (ref)
        local KeyCode = p1074.KeyCode;

        if KeyCode == Enum.KeyCode.Escape or KeyCode == Enum.KeyCode.ButtonB then
            u13.leave("fly");

            return;
        end;

        if u1068.finishing then
            return;
        end;

        local UserInputType = p1074.UserInputType;

        if u1068.awaiting then
            if (UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch) and guiTakes(u1068, p1074.Position) then
                return;
            end;

            if not (UserInputType ~= Enum.UserInputType.MouseButton1 and (UserInputType ~= Enum.UserInputType.Touch and (KeyCode ~= Enum.KeyCode.ButtonA or p1075)) and (p1075 or KeyCode ~= Enum.KeyCode.Return and KeyCode ~= Enum.KeyCode.KeypadEnter)) then
                local v1076 = u1068;
                local awaiting = v1076.awaiting;

                if awaiting then
                    if os.clock() < awaiting.readyAt then
                        return;
                    end;

                    awaiting.gone = true;
                    v1076.awaiting = nil;

                    if awaiting.present and not awaiting.present.releaseAt then
                        awaiting.present.releaseAt = os.clock();
                    end;
                end;
            end;

            return;
        end;

        if UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch then
            if guiTakes(u1068, p1074.Position) then
                return;
            end;

            local v1077 = rayAt(u1068, u1068.camera:ScreenPointToRay(p1074.Position.X, p1074.Position.Y));

            if u1068.revealing > 0 then
                return;
            end;

            if UserInputType == Enum.UserInputType.MouseButton1 then
                if v1077 then
                    setHover(u1068, v1077);
                    confirm(u1068, v1077);

                    return;
                end;
            else
                if v1077 and (u1068.hover == v1077 and u1068.armed) then
                    confirm(u1068, v1077);

                    return;
                end;

                if v1077 then
                    setHover(u1068, v1077);
                    u1068.armed = true;

                    return;
                end;

                local v1078 = u1068;

                if v1078.hover == nil then
                    return;
                end;

                v1078.hover = nil;
                v1078.armed = false;
            end;

            return;
        end;

        if p1075 or u1068.revealing > 0 then
            return;
        end;

        if KeyCode ~= Enum.KeyCode.DPadLeft and KeyCode ~= Enum.KeyCode.DPadRight then
            if KeyCode == Enum.KeyCode.ButtonA then
                confirm(u1068, u1068.hover);

                return;
            end;

            if KeyCode == Enum.KeyCode.ButtonY then
                skip(u1068);
            end;

            return;
        end;

        local v1079;

        if u1068.hover then
            v1079 = u1068.hover.slot;
        else
            v1079 = KeyCode == Enum.KeyCode.DPadLeft and 4 or 3;
        end;

        local math_clamp_ret = math.clamp(v1079 + (KeyCode == Enum.KeyCode.DPadLeft and -1 or 1), 1, 6);
        setHover(u1068, u1068.cards[math_clamp_ret]);
    end));
    local u1080 = 0;
    table.insert(u1068.connections, UserInputService.InputChanged:Connect(function(p1081) -- Line: 4093
        -- upvalues: u1068 (copy), u1080 (ref), setHover (ref)
        if p1081.KeyCode ~= Enum.KeyCode.Thumbstick1 or (u1068.finishing or u1068.revealing > 0) then
            return;
        end;

        local X = p1081.Position.X;

        if math.abs(X) < 0.7 or os.clock() - u1080 < 0.28 then
            return;
        end;

        u1080 = os.clock();
        local v1082;

        if u1068.hover then
            v1082 = u1068.hover.slot;
        else
            v1082 = X < 0 and 4 or 3;
        end;

        setHover(u1068, u1068.cards[math.clamp(v1082 + (X < 0 and -1 or 1), 1, 6)]);
    end));
    local u1083 = 0;
    table.insert(u1068.connections, RunService.RenderStepped:Connect(function(p1084) -- Line: 4107
        -- upvalues: step (ref), u1068 (copy), u13 (ref)
        local success2, result2 = pcall(step, u1068, p1084);

        if not success2 then
            warn("[GhostTrader] the card view failed: " .. tostring(result2));
            u13.leave("instant");
        end;
    end));
    table.insert(u1068.connections, RunService.Heartbeat:Connect(function() -- Line: 4114
        -- upvalues: u1083 (ref), u1068 (copy), u27 (ref), u18 (ref)
        local os_clock_ret = os.clock();

        if os_clock_ret < u1083 then
            return;
        end;

        u1083 = os_clock_ret + 0.3;
        local u1085 = u1068;
        pcall(function() -- Line: 2170
            -- upvalues: u1085 (copy), u27 (ref)
            u1085.hide:sweep();

            if u1085.othersFade then
                u27.fade(u1085, u1085.othersK or 0);
            end;
        end);

        for i, v in u1085.hide.saved do
            if u18[i] == nil then
                u18[i] = v;
            end;
        end;
    end));

    return true;
end;

function u13.open(p1086) -- Line: 4129
    -- upvalues: u17 (ref), u14 (ref), LocalPlayer (ref), Session (copy), u97 (copy), ReplicatedStorage (copy), ContentProvider (copy), HudNavigation (copy), enter (copy), finish (copy), u16 (copy), u13 (copy)
    if u17 or not u14 then
        return false;
    end;

    if LocalPlayer:GetAttribute("InMatch") == true or (Session:GetAttribute("MapChanging") == true or LocalPlayer:GetAttribute("CutsceneActive") == true) then
        return false;
    end;

    if not u97.checked then
        u97.checked = true;
        task.spawn(function() -- Line: 658
            -- upvalues: ReplicatedStorage (ref), ContentProvider (ref), u97 (ref)
            local GhostTraderAssets = ReplicatedStorage:FindFirstChild("GhostTraderAssets");

            if GhostTraderAssets then
                GhostTraderAssets = GhostTraderAssets:FindFirstChild("Cards");
            end;

            if not GhostTraderAssets then
                warn("[GhostTrader] ReplicatedStorage.GhostTraderAssets.Cards is missing: plain glowing cards instead");

                return;
            end;

            local u1087 = { GhostTraderAssets };

            for _, descendant in GhostTraderAssets:GetDescendants() do
                if descendant:IsA("SurfaceAppearance") then
                    local success, result = pcall(function() -- Line: 669
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
                        table.insert(u1087, ImageLabel);
                    end;
                end;
            end;

            local u1088 = {};
            local success, result = pcall(function() -- Line: 678
                -- upvalues: ContentProvider (ref), u1087 (copy), u1088 (copy)
                ContentProvider:PreloadAsync(u1087, function(p1089, p1090) -- Line: 679
                    -- upvalues: u1088 (ref)
                    if p1090 ~= Enum.AssetFetchStatus.Success then
                        local v1091 = tostring(p1089) .. " " .. p1090.Name;
                        table.insert(u1088, v1091);
                    end;
                end);
            end);

            for _, v in u1087 do
                if v:IsA("ImageLabel") then
                    v:Destroy();
                end;
            end;

            if success and #u1088 == 0 then
                u97.folder = GhostTraderAssets;
                u97.ok = true;

                return;
            end;

            local l_warn = warn;
            local v1092;

            if success then
                v1092 = table.concat(u1088, ", ");
            else
                v1092 = tostring(result);
            end;

            l_warn("[GhostTrader] the card art didn\'t load (" .. v1092 .. "); plain glowing cards instead");
        end);
    end;

    HudNavigation.opening("GhostTrader");
    local success, result = pcall(enter, p1086);

    if not success then
        warn("[GhostTrader] couldn\'t start: " .. tostring(result));
        finish("instant");

        return false;
    end;

    if not result then
        return false;
    end;

    local u1093 = u17;
    u1093.entering = true;
    u16.send("Enter");
    task.delay(8, function() -- Line: 4154
        -- upvalues: u17 (ref), u1093 (copy), u13 (ref)
        if u17 == u1093 and not (u1093.answered or u1093.finishing) then
            u13.notice("The trader didn\'t answer. Try again.");
            u13.leave("fly");
        end;
    end);

    return true;
end;

function u13.leave(p1094) -- Line: 4163
    -- upvalues: u17 (ref), finish (copy)
    if u17 then
        task.spawn(finish, p1094 or "fly");
    end;
end;

function u13.isOpen() -- Line: 4168
    -- upvalues: u17 (ref)
    return u17 ~= nil;
end;

function u13.setState(p1095, p1096) -- Line: 4172
    -- upvalues: u17 (ref), pulse (copy), Color3_fromRGB_ret (copy), applyState (copy)
    local v1097 = u17;

    if not v1097 or v1097.finishing then
        return false;
    end;

    v1097.entering = false;

    if p1096 then
        v1097.skipPending = nil;
        pulse(v1097.panels.Next, Color3_fromRGB_ret);
    end;

    applyState(v1097, p1095);

    return true;
end;

function u13.spot(p1098) -- Line: 4187
    -- upvalues: u17 (ref), LocalPlayer (ref)
    local v1099 = u17;

    if not v1099 or (v1099.finishing or (v1099.move or (v1099.moved or typeof(p1098) ~= "CFrame"))) then
        return false;
    end;

    local v1100 = LocalPlayer and LocalPlayer.Character;
    local v1101;

    if v1100 then
        v1101 = v1100:FindFirstChildOfClass("Humanoid");
    else
        v1101 = v1100;
    end;

    if v1100 then
        v1100 = v1100:FindFirstChild("HumanoidRootPart");
    end;

    if v1101 ~= nil and v1101.Health > 0 then
        local _ = v1100 == nil;
    end;

    if not v1100 then
        return false;
    end;

    v1099.moved = true;
    v1099.move = {
        from = v1100.CFrame,
        start = os.clock()
    };

    return true;
end;

function u13.result(p1102) -- Line: 4202
    -- upvalues: u17 (ref), applyState (copy), flipShow (copy)
    local v1103 = u17;

    if not (v1103 and (not v1103.finishing and type(p1102) == "table")) then
        return false;
    end;

    local v1104 = tonumber(p1102.slot);
    local pending = v1103.pending;
    v1103.pending = nil;
    local v1105;

    if v1104 and v1103.dealt then
        v1105 = v1103.cards[v1104] or nil;
    else
        v1105 = nil;
    end;

    if v1105 and (v1105.show and (v1105.show.result == nil and not v1105.show.refused)) then
        v1105.show.result = p1102;
        applyState(v1103, p1102.state);

        return true;
    end;

    if v1105 and not (v1105.opened or v1105.show) then
        flipShow(v1103, v1105, p1102);
        applyState(v1103, p1102.state);

        return true;
    end;

    if pending and (pending.show and pending.show.result == nil) then
        pending.show.refused = true;
    end;

    applyState(v1103, p1102.state);

    return false;
end;

function u13.refused(p1106) -- Line: 4230
    -- upvalues: u17 (ref), u12 (copy), u13 (copy), pulse (copy), paint (copy)
    local v1107 = u17;

    if not v1107 or v1107.finishing then
        return false;
    end;

    local v1108;

    if type(p1106) == "table" then
        v1108 = p1106.reason or nil;
    else
        v1108 = nil;
    end;

    local v1109 = type(p1106) == "table" and (type(p1106.message) == "string" and p1106.message ~= "") and p1106.message or (u12[v1108] or "The trader didn\'t answer. Try again.");
    v1107.answered = true;

    if v1108 == "Off" then
        u13.leave("fly");
        u13.notice("This feature is currently not available.");

        return true;
    end;

    if v1108 == "InMatch" then
        u13.leave("instant");
        u13.notice(v1109);

        return true;
    end;

    if v1108 == "TooFar" or v1107.entering and v1108 == "Busy" then
        u13.leave("fly");
        u13.notice(v1109);

        return true;
    end;

    local pending = v1107.pending;

    if pending then
        v1107.pending = nil;

        if pending.show and pending.show.result == nil then
            pending.show.refused = true;
        end;
    end;

    v1107.skipPending = nil;

    if v1108 == "NoKeys" then
        pulse(v1107.panels.Keys);
    elseif v1108 == "Cooldown" then
        pulse(v1107.panels.Next);
    end;

    if v1107 then
        v1107.message = {
            text = v1109,
            untilAt = os.clock() + 3.5
        };
    else
        u13.notice(v1109);
    end;

    paint(v1107);

    return true;
end;

function u13.start(p1110) -- Line: 4275
    -- upvalues: u14 (ref), u16 (copy), u97 (copy), ReplicatedStorage (copy), ContentProvider (copy), HudNavigation (copy), u17 (ref), u13 (copy), LocalPlayer (ref), sweepLeftovers (copy), Session (copy), u15 (ref)
    if u14 then
        return;
    end;

    u14 = true;
    u16.send = p1110 and p1110.send or u16.send;

    if not u97.checked then
        u97.checked = true;
        task.spawn(function() -- Line: 658
            -- upvalues: ReplicatedStorage (ref), ContentProvider (ref), u97 (ref)
            local GhostTraderAssets = ReplicatedStorage:FindFirstChild("GhostTraderAssets");

            if GhostTraderAssets then
                GhostTraderAssets = GhostTraderAssets:FindFirstChild("Cards");
            end;

            if not GhostTraderAssets then
                warn("[GhostTrader] ReplicatedStorage.GhostTraderAssets.Cards is missing: plain glowing cards instead");

                return;
            end;

            local u1111 = { GhostTraderAssets };

            for _, descendant in GhostTraderAssets:GetDescendants() do
                if descendant:IsA("SurfaceAppearance") then
                    local success, result = pcall(function() -- Line: 669
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
                        table.insert(u1111, ImageLabel);
                    end;
                end;
            end;

            local u1112 = {};
            local success, result = pcall(function() -- Line: 678
                -- upvalues: ContentProvider (ref), u1111 (copy), u1112 (copy)
                ContentProvider:PreloadAsync(u1111, function(p1113, p1114) -- Line: 679
                    -- upvalues: u1112 (ref)
                    if p1114 ~= Enum.AssetFetchStatus.Success then
                        local v1115 = tostring(p1113) .. " " .. p1114.Name;
                        table.insert(u1112, v1115);
                    end;
                end);
            end);

            for _, v in u1111 do
                if v:IsA("ImageLabel") then
                    v:Destroy();
                end;
            end;

            if success and #u1112 == 0 then
                u97.folder = GhostTraderAssets;
                u97.ok = true;

                return;
            end;

            local l_warn = warn;
            local v1116;

            if success then
                v1116 = table.concat(u1112, ", ");
            else
                v1116 = tostring(result);
            end;

            l_warn("[GhostTrader] the card art didn\'t load (" .. v1116 .. "); plain glowing cards instead");
        end);
    end;

    HudNavigation.Opening.Event:Connect(function(p1117) -- Line: 4282
        -- upvalues: u17 (ref), u13 (ref)
        if p1117 ~= "GhostTrader" and u17 then
            u13.leave("fly");
        end;
    end);
    LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 4289
        -- upvalues: sweepLeftovers (ref)
        task.defer(sweepLeftovers, "match");
    end);
    Session:GetAttributeChangedSignal("MapChanging"):Connect(function() -- Line: 4292
        -- upvalues: sweepLeftovers (ref)
        task.defer(sweepLeftovers, "map change");
    end);
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 4295
        -- upvalues: sweepLeftovers (ref)
        task.defer(sweepLeftovers, "respawn");
    end);
    task.spawn(function() -- Line: 4298
        -- upvalues: u15 (ref), u17 (ref), sweepLeftovers (ref)
        while not u15 do
            task.wait(5);

            if not (u17 or u15) then
                pcall(sweepLeftovers, "check");
            end;
        end;
    end);
end;

function u13._test(p1118, p1119) -- Line: 4309
    -- upvalues: LocalPlayer (ref), u15 (ref), u17 (ref), setHover (copy), confirm (copy), u430 (ref)
    if p1118 == "player" then
        LocalPlayer = p1119;

        return;
    end;

    if p1118 == "stop" then
        u15 = true;

        return;
    end;

    if u17 then
        local v1120 = u17.cards[p1119];

        if p1118 == "hover" then
            u17.lockHover = v1120;
            setHover(u17, v1120);

            return;
        end;

        if p1118 == "confirm" then
            confirm(u17, v1120);

            return;
        end;

        if p1118 == "continue" then
            local v1121 = u17;
            local awaiting = v1121.awaiting;

            if not awaiting or os.clock() < awaiting.readyAt then
                return false;
            end;

            awaiting.gone = true;
            v1121.awaiting = nil;

            if awaiting.present and not awaiting.present.releaseAt then
                awaiting.present.releaseAt = os.clock();
            end;

            return true;
        end;

        if p1118 == "cursor" then
            u17.testCursor = p1119;

            return;
        end;

        if p1118 == "click" then
            local v1122 = u17.panels[p1119];
            local v1123;

            if v1122 == nil then
                v1123 = false;
            else
                v1123 = v1122.button and v1122.frame.Visible;
            end;

            if v1123 then
                u430(u17, v1122);
            end;

            return v1123, nil;
        end;
    end;
end;

function u13.debug() -- Line: 4339
    -- upvalues: u17 (ref), u97 (copy)
    local v1124 = u17;
    local v1125 = {
        open = v1124 ~= nil
    };
    local v1126;

    if v1124 == nil then
        v1126 = false;
    else
        v1126 = v1124.finishing == true;
    end;

    v1125.finishing = v1126;
    local v1127;

    if v1124 == nil then
        v1127 = false;
    else
        v1127 = v1124.dealt == true;
    end;

    v1125.dealt = v1127;
    v1125.cards = v1124 and (#v1124.cards or 0) or 0;
    local v1128;

    if v1124 and v1124.hover then
        v1128 = v1124.hover.slot or nil;
    else
        v1128 = nil;
    end;

    v1125.hover = v1128;
    local v1129;

    if v1124 == nil then
        v1129 = false;
    else
        v1129 = v1124.pending ~= nil;
    end;

    v1125.pending = v1129;
    local v1130;

    if v1124 then
        local v1131 = {};

        for i, v in v1124.cards do
            if v.opened then
                table.insert(v1131, i .. (v.flip >= 1 and "up" or "turning"));
            end;
        end;

        v1130 = table.concat(v1131, ",") or "";
    else
        v1130 = "";
    end;

    v1125.opened = v1130;
    local v1132;

    if v1124 == nil or v1124.arm == nil then
        v1132 = false;
    else
        v1132 = v1124.arm.motor.C0 ~= v1124.arm.c0;
    end;

    v1125.arm = v1132;
    local v1133;

    if v1124 and v1124.message then
        v1133 = v1124.message.text or nil;
    else
        v1133 = nil;
    end;

    v1125.message = v1133;
    local v1134;

    if v1124 == nil then
        v1134 = false;
    else
        v1134 = v1124.awaiting ~= nil;
    end;

    v1125.awaiting = v1134;
    local v1135;

    if v1124 == nil then
        v1135 = false;
    else
        v1135 = v1124.rewards.box.Visible;
    end;

    v1125.odds = v1135;
    local v1136;

    if v1124 == nil then
        v1136 = false;
    else
        v1136 = v1124.hint.text.Visible;
    end;

    v1125.hint = v1136;
    local v1137;

    if v1124 == nil then
        v1137 = false;
    else
        v1137 = v1124.visibility ~= nil;
    end;

    v1125.hidden = v1137;
    v1125.stand = v1124 and v1124.stand or nil;
    v1125.art = u97.ok;

    return v1125;
end;

function u13.preview(p1138, p1139, p1140, p1141) -- Line: 4373
    -- upvalues: ReplicatedStorage (copy), u97 (copy), spotsOf (copy), frameFor (copy), armOf (ref), buildOverlay (copy), buildPanels (copy), newCard (copy), showOpened (copy), paint (copy), cardPose (copy), u450 (copy), u1 (copy), slotPose (copy), u7 (copy), layout (ref), u4 (copy), flyKey (copy), impact (copy), u409 (ref), plainPart (copy), CFrame_Angles_ret (copy), setLabel (copy), reveal (copy), aimArm (copy)
    local v1142 = p1141 or {};
    local GhostTraderAssets = ReplicatedStorage:FindFirstChild("GhostTraderAssets");
    u97.checked = true;

    if GhostTraderAssets then
        GhostTraderAssets = GhostTraderAssets:FindFirstChild("Cards");
    end;

    u97.folder = GhostTraderAssets;
    local v1143;

    if v1142.art == true then
        v1143 = u97.folder ~= nil;
    else
        v1143 = false;
    end;

    u97.ok = v1143;
    local v1144 = spotsOf(p1138);
    local v1145 = {
        revealing = 0,
        dt = 1,
        spots = assert(v1144, "no Table or Lantern"),
        folder = p1139,
        guis = {},
        guiHome = v1142.guiHome,
        allGuisHome = v1142.guiHome ~= nil,
        cards = {},
        leaving = {},
        anims = {},
        hits = RaycastParams.new(),
        camera = {
            ViewportSize = v1142.viewport or Vector2.zero
        },
        state = v1142.state or {
            keys = 12,
            nextAt = 0,
            skipAvailable = true,
            skipPrice = 49
        },
        character = p1140
    };
    frameFor(v1145, p1140, v1142.aspect or 1.7777777777777777);
    local _ = v1145.shot;
    local fanAt = v1145.fanAt;
    local HumanoidRootPart = p1140:FindFirstChild("HumanoidRootPart");
    p1140:PivotTo(v1145.stand * HumanoidRootPart.CFrame:ToObjectSpace(p1140:GetPivot()));
    v1145.arm = armOf(p1140);
    buildOverlay(v1145, v1142.uiParent or game:GetService("CoreGui"));
    v1145.ui.Name = "_GhostTrader_UI";
    buildPanels(v1145);
    v1145.hits.FilterType = Enum.RaycastFilterType.Include;
    local v1146 = {};

    for _, v in v1145.cards do
        table.insert(v1146, v.hit);
    end;

    v1145.hits.FilterDescendantsInstances = v1146;

    for i = 1, 6 do
        local v1147 = newCard(v1145, i, v1142.cursed == i);
        v1147.phase = "idle";
        local v1148 = v1142.opened and v1142.opened[i];

        if v1148 then
            showOpened(v1145, v1147, v1148);
        end;

        v1145.cards[i] = v1147;
        local _ = i;
    end;

    v1145.dealt = true;
    paint(v1145);
    local v1149 = v1142.hovered and v1145.cards[v1142.hovered];
    v1145.hover = v1149;

    if v1149 then
        v1149.h = 1;
    end;

    local os_clock_ret = os.clock();

    for _, v in v1145.cards do
        cardPose(v1145, v, os_clock_ret, fanAt);
    end;

    u450.choose(v1145);

    if v1142.mood then
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Name = "GhostTraderMood";

        for i, v in u1 or {} do
            ColorCorrectionEffect[i] = v;
        end;

        ColorCorrectionEffect.Parent = nil;
        ColorCorrectionEffect.Parent = workspace_CurrentCamera;
    end;

    local moment = v1142.moment;
    local v1150 = true;
    local v1151;

    if moment then
        v1145.hint.text.Visible = false;
        v1145.rewards.box.Visible = false;
        v1145.revealing = 1;
        local v1152 = v1145.cards[moment.slot];
        local reward = moment.reward;
        local Position = slotPose(v1145.fanAt, v1145.shot, v1152.slot, 6, v1145.fanScale).Position;
        local v1153 = v1145.shot.Position:Lerp(Position, u7.TOWARD) + v1145.shot.RightVector * u7.SIDE + Vector3.new(0, 1, 0) * u7.UP;
        v1145.view = CFrame.lookAt(v1153, Position:Lerp(v1145.fanAt, 0.5));
        v1151 = v1152;

        for _, v in v1145.cards do
            cardPose(v1145, v, os_clock_ret, fanAt);
        end;

        layout(v1145);

        if moment.kind == "impact" then
            v1152.show = {
                keyAt = os_clock_ret - u4.KEY_FLIGHT - 0.04
            };
            flyKey(v1145, v1152, v1152.show);
            impact(v1145, v1152);
            v1152.show.buildFrom = os_clock_ret;
            os_clock_ret = os_clock_ret + (moment.at or 0.08);
        elseif moment.kind == "flip" then
            local v1154 = u409(v1152);
            v1152.show = {
                keyAt = os_clock_ret - 2,
                buildFrom = os_clock_ret - u4.BUILD_SECONDS - 0.1
            };
            v1152.opened = true;
            v1152.reward = reward;

            if v1152.plain and not v1152.face then
                local v1155 = plainPart(v1145, v1152.style.glow, false);
                local v1156 = CFrame.new(0, 0, 0.012) * CFrame_Angles_ret;
                v1155.Anchored = true;
                v1155.CanCollide = false;
                v1155.CanTouch = false;
                v1155.CanQuery = false;
                v1155.CastShadow = false;
                v1155.Parent = v1152.model;
                local v1157 = {
                    part = v1155,
                    offset = v1156,
                    size = v1155.Size
                };
                table.insert(v1152.layers, v1157);
                v1152.scale = nil;
                v1152.face = v1157;
            end;

            setLabel(v1145, v1152, reward);
            v1154.wisps.Rate = 40;
            v1154.wisps.Enabled = true;
            local v1158 = u4.FLIP_SECONDS * (moment.at or 0.2);
            v1152.show.flipFrom = os_clock_ret - v1158;
            local v1159 = os_clock_ret;
            os_clock_ret = v1159;

            for i = 5, 1, -1 do
                v1152.nextGhost = 0;
                cardPose(v1145, v1152, os_clock_ret - i * v1158 / 5, fanAt);
                v1159 = os_clock_ret;
                local _ = i;
                os_clock_ret = v1159;
            end;
        elseif moment.kind == "reveal" then
            v1150 = false;
            v1152.opened = true;
            v1152.reward = reward;
            v1152.flip = 1;

            if v1152.plain and not v1152.face then
                local v1160 = plainPart(v1145, v1152.style.glow, false);
                local v1161 = CFrame.new(0, 0, 0.012) * CFrame_Angles_ret;
                v1160.Anchored = true;
                v1160.CanCollide = false;
                v1160.CanTouch = false;
                v1160.CanQuery = false;
                v1160.CastShadow = false;
                v1160.Parent = v1152.model;
                local v1162 = {
                    part = v1160,
                    offset = v1161,
                    size = v1160.Size
                };
                table.insert(v1152.layers, v1162);
                v1152.scale = nil;
                v1152.face = v1162;
            end;

            setLabel(v1145, v1152, reward);
            cardPose(v1145, v1152, os_clock_ret, fanAt);
            reveal(v1145, v1152, reward);
            os_clock_ret = os_clock_ret + (moment.at or 0.12);
        end;

        cardPose(v1145, v1152, os_clock_ret, fanAt);

        for _, v in v1145.anims do
            pcall(v, os_clock_ret, 0);
        end;

        cardPose(v1145, v1152, os_clock_ret, fanAt);
    else
        v1151 = v1149;
    end;

    if v1149 and (v1149.frame and v1145.arm) then
        local motor = v1145.arm.motor;
        motor.C0 = aimArm(v1145.arm, motor.Part0.CFrame, v1149.frame.Position - v1149.frame.UpVector * (0.0625 * (v1149.scale or 1)), 1);
        motor.Part1.CFrame = motor.Part0.CFrame * motor.C0 * motor.C1:Inverse();
        v1145.arm.weight = 1;
    end;

    layout(v1145);
    local arm = v1145.arm;

    if arm and (v1150 and (v1151 and v1151.frame)) then
        local motor = arm.motor;
        motor.C0 = aimArm(arm, motor.Part0.CFrame, v1151.frame.Position - v1151.frame.UpVector * (0.0625 * (v1151.scale or 1)), 1);
        motor.Part1.CFrame = motor.Part0.CFrame * motor.C0 * motor.C1:Inverse();
    end;

    return v1145.view, v1145;
end;

return u13;