 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local Debris = game:GetService("Debris");
local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));
local HudNavigation = require(Parent.Presentation.HudNavigation);
local CutsceneScreen = require(Parent.Presentation.CutsceneScreen);
local ClaimPop = require(script_Parent.ClaimPop);
local EmotePose = require(script_Parent.EmotePose);
local Preview = require(script_Parent.Shop.Preview);
local Widgets = require(script_Parent.Widgets);
local TeamEventConfig = require(Parent.Progression.TeamEventConfig);
local JourneyConfig = require(Parent.Progression.JourneyConfig);
local CrateCatalog = require(Parent.Crates.CrateCatalog);
local SkinCatalog = require(Parent.Weapons.SkinCatalog);
local EmoteCatalog = require(Parent.Emotes.EmoteCatalog);
local GearCatalog = require(Parent.Gear.GearCatalog);
local u1 = {};
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy);
local u2 = TeamEventConfig.Team.Football.Name .. " vs " .. TeamEventConfig.Team.Futbol.Name;
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local Color3_fromRGB_ret = Color3.fromRGB(23, 23, 25);
local GOLD = ClaimPop.GOLD;
local Color3_fromRGB_ret2 = Color3.fromRGB(228, 228, 232);
local Color3_fromRGB_ret3 = Color3.fromRGB(80, 255, 100);
local Color3_fromRGB_ret4 = Color3.fromRGB(17, 213, 40);
local Color3_fromRGB_ret5 = Color3.fromRGB(110, 112, 122);
local Color3_fromRGB_ret6 = Color3.fromRGB(58, 60, 68);
local Color3_fromRGB_ret7 = Color3.fromRGB(240, 188, 110);
local u3 = {
    Common = Color3.fromRGB(175, 185, 192),
    Rare = Color3.fromRGB(92, 173, 238),
    Epic = Color3.fromRGB(183, 123, 244),
    Legendary = Color3.fromRGB(242, 191, 89),
    Mythical = Color3.fromRGB(255, 72, 96)
};
local ColorSequence_new_ret = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3_new_ret),
    ColorSequenceKeypoint.new(0.42, Color3_new_ret),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 226, 120)),
    ColorSequenceKeypoint.new(0.58, Color3_new_ret),
    ColorSequenceKeypoint.new(1, Color3_new_ret)
});
local NumberSequence_new_ret = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.4, 1),
    NumberSequenceKeypoint.new(0.5, 0.5),
    NumberSequenceKeypoint.new(0.6, 1),
    NumberSequenceKeypoint.new(1, 1)
});
local NumberSequence_new_ret2 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.55, 0.85), NumberSequenceKeypoint.new(1, 0.45) });
local NumberSequence_new_ret3 = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.18, 0.5),
    NumberSequenceKeypoint.new(0.82, 0.5),
    NumberSequenceKeypoint.new(1, 1)
});
local NumberSequence_new_ret4 = NumberSequence.new(0.15, 0.55);
local Vector2_new_ret = Vector2.new(0.5, 0.5);
local Back = Enum.EasingStyle.Back;
local Quad = Enum.EasingStyle.Quad;
local In = Enum.EasingDirection.In;
local Out = Enum.EasingDirection.Out;
local Vector2_new_ret2 = Vector2.new(1280, 720);
local u4 = Enum.ContextActionPriority.High.Value + 100;
local u5 = { 0.05, 0.3, 0.95, 1.65, 2.5, 3.4, 4.5 };
local u6 = {
    Frame = { "BackgroundTransparency" },
    TextLabel = { "TextTransparency", "BackgroundTransparency" },
    TextButton = { "TextTransparency", "BackgroundTransparency" },
    ImageLabel = { "ImageTransparency", "BackgroundTransparency" },
    ViewportFrame = { "ImageTransparency", "BackgroundTransparency" },
    UIStroke = { "Transparency" }
};
local u7 = nil;
local u8 = nil;

local function ease(p9, p10, p11) -- Line: 136
    -- upvalues: TweenService (copy), Out (copy)
    return TweenService:GetValue(math.clamp(p9, 0, 1), p10, p11 or Out);
end;

local function make(p12, p13, p14) -- Line: 140
    local Instance_new_ret = Instance.new(p12);

    for i, v in p14 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p13;

    return Instance_new_ret;
end;

local function outline(p15, p16, p17) -- Line: 149
    local v18 = {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        Color = p16,
        Thickness = p17
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v18 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p15;

    return UIStroke;
end;

local function text(p19, p20, p21, p22, p23, p24) -- Line: 159
    -- upvalues: Vector2_new_ret (copy), Font_new_ret (copy), Color3_new_ret2 (copy)
    local v25 = {
        BackgroundTransparency = 1,
        TextWrapped = true,
        Name = p20,
        AnchorPoint = Vector2_new_ret,
        FontFace = Font_new_ret,
        Text = p21,
        TextSize = p22,
        TextColor3 = p23
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v25 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p19;
    local v26 = {
        Thickness = 0.12,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        Color = Color3_new_ret2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v26 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    for i, v in p24 or {} do
        TextLabel[i] = v;
    end;

    return TextLabel, UIStroke;
end;

local function sound(p27) -- Line: 177
    -- upvalues: SoundService (copy)
    local GameAudio = SoundService:FindFirstChild("GameAudio");

    for i in string.gmatch(p27, "[^%.]+") do
        if GameAudio then
            GameAudio = GameAudio:FindFirstChild(i);
        end;
    end;

    if GameAudio and GameAudio:IsA("Sound") then
        require(game:GetService("ReplicatedFirst"):WaitForChild("LazySound")).playLocal(GameAudio);
    end;
end;

local u28 = nil;

local function chime(p29, p30) -- Line: 191
    -- upvalues: u28 (ref), script_Parent (copy), sound (copy)
    if p29.chimedAt == p30 then
        return;
    end;

    p29.chimedAt = p30;
    p29.chimes = p29.chimes + 1;

    if u28 == nil then
        local success, result = pcall(require, script_Parent:FindFirstChild("RewardPop"));

        if not (success and (type(result) == "table" and (type(result.chime) == "function" and result))) then
            result = false;
        end;

        u28 = result;
    end;

    if not (u28 and pcall(u28.chime, p29.chimes)) then
        sound("04_UI.MatchSummary.CountTick");
    end;
end;

local function cue(p31, p32, p33) -- Line: 207
    -- upvalues: SoundService (copy), TweenService (copy)
    local GameAudio = SoundService:FindFirstChild("GameAudio");

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("10_Football");
    end;

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild(p32);
    end;

    if not (GameAudio and GameAudio:IsA("Sound")) then
        return false;
    end;

    local v34 = GameAudio:Clone();
    v34.Parent = p31.gui;

    if p33 then
        v34.Volume = 0;
        TweenService:Create(v34, TweenInfo.new(p33), {
            Volume = GameAudio.Volume
        }):Play();
    end;

    v34:Play();
    table.insert(p31.sounds, v34);

    return true;
end;

local function fadeSet(p35) -- Line: 226
    -- upvalues: u6 (copy)
    local u36 = {
        alpha = -1,
        items = {}
    };

    local function add(p37) -- Line: 228
        -- upvalues: u6 (ref), u36 (copy)
        for _, v in u6[p37.ClassName] or {} do
            if p37[v] < 1 then
                table.insert(u36.items, { p37, v, p37[v] });
            end;
        end;
    end;

    add(p35);

    for _, descendant in p35:GetDescendants() do
        add(descendant);
    end;

    return u36;
end;

local function setAlpha(p38, p39) -- Line: 242
    local math_clamp_ret = math.clamp(p39, 0, 1);

    if p38.alpha == math_clamp_ret then
        return;
    end;

    p38.alpha = math_clamp_ret;

    for _, v in p38.items do
        v[1][v[2]] = 1 - (1 - v[3]) * math_clamp_ret;
    end;
end;

function u1.banner(p40, p41, p42, p43) -- Line: 255
    -- upvalues: TeamEventConfig (copy), u2 (copy)
    local v44 = p43 or p42;
    local v45;

    if p42 == v44 then
        v45 = "LEVEL " .. tostring(v44);
    else
        v45 = "LEVELS " .. tostring(p42) .. "–" .. tostring(v44);
    end;

    if p40 == "Team" then
        local v46 = TeamEventConfig.Team[p41];

        return (not v46 and "" or v46.Label .. " — ") .. v45 .. " REACHED!";
    end;

    if p40 == "Personal" then
        return "PERSONAL " .. v45 .. "!";
    end;

    return p40 == "Champion" and "CHAMPIONS!" or "YOUR " .. u2 .. " REWARDS!";
end;

local function defaultNote(p47, p48, p49) -- Line: 270
    -- upvalues: TeamEventConfig (copy), Widgets (copy), u2 (copy)
    local v50 = TeamEventConfig.Team[p48];

    if p47 == "Personal" then
        return "YOU\'VE EARNED " .. Widgets.number(TeamEventConfig.PersonalLevels[p49] or 0) .. " POINTS FOR YOUR TEAM!";
    end;

    return p47 == "Team" and "YOUR TEAM HIT A NEW MILESTONE!" or (p47 ~= "Champion" and "EVERYTHING YOU EARNED, DELIVERED!" or (not v50 and "YOUR TEAM" or v50.Label) .. " WINS " .. u2 .. "!");
end;

local function list(p51) -- Line: 282
    return type(p51) ~= "table" and {} or p51;
end;

local function owned(p52) -- Line: 285
    return p52 and " (Owned)" or "";
end;

local function duration(p53) -- Line: 289
    local v54 = p53 // 60;
    local v55 = p53 % 60;

    if v54 == 0 then
        return v55 .. "m";
    end;

    return v54 .. "h" .. (v55 <= 0 and "" or " " .. v55 .. "m");
end;

local function emoteRarity(p56) -- Line: 297
    -- upvalues: CrateCatalog (copy)
    for _, v in CrateCatalog.Crates do
        for _, v2 in v.Entries do
            if v2.Emote == p56 then
                return v2.Rarity;
            end;
        end;
    end;

    return nil;
end;

local u87 = {
    knife = function(p57, p58) -- Line: 311, Name: knife
        -- upvalues: SkinCatalog (copy), u3 (copy), ClaimPop (copy), GOLD (copy)
        local v59 = SkinCatalog.get(p57);

        if not v59 then
            return nil;
        end;

        local v60 = u3[v59.Rarity];
        local v61 = {
            image = "rbxassetid://127106171586822",
            big = true,
            key = "Knife:" .. tostring(p57) .. (p58 and " (Owned)" or ""),
            knife = v59,
            name = ClaimPop.titleCase(v59.SourceName or v59.Name) .. (p58 and " (Owned)" or "")
        };
        local v62;

        if typeof(v59.Accent) == "Color3" then
            v62 = v59.Accent;
        else
            v62 = GOLD;
        end;

        v61.color = v62;
        v61.tag = not v60 and "KNIFE" or string.upper(v59.Rarity);
        v61.tagColor = v60 or GOLD;
        local v63;

        if v59.Rarity == "Common" or v59.Rarity == "Rare" then
            v63 = nil;
        else
            v63 = v60 or GOLD;
        end;

        v61.glow = v63;

        return v61;
    end,

    emote = function(p64, p65) -- Line: 329, Name: emote
        -- upvalues: EmoteCatalog (copy), emoteRarity (copy), GOLD (copy), u3 (copy), ClaimPop (copy)
        local v66 = EmoteCatalog.get(p64);

        if not v66 then
            return nil;
        end;

        local v67 = emoteRarity(p64);
        local v68 = v66.Source ~= nil;
        local v69;

        if v68 then
            v69 = GOLD;
        else
            v69 = u3[v67] or GOLD;
        end;

        local v70 = {
            big = true,
            key = "Emote:" .. tostring(p64) .. (p65 and " (Owned)" or ""),
            emote = p64,
            image = ClaimPop.EMOTE_IMAGE,
            name = tostring(v66.Name) .. (p65 and " (Owned)" or " Emote"),
            color = v69,
            tag = v68 and "EXCLUSIVE" or (not v67 and "EMOTE" or string.upper(v67)),
            tagColor = v69
        };

        if not (v68 or (v67 == "Legendary" or v67 == "Epic")) then
            v69 = nil;
        end;

        v70.glow = v69;

        return v70;
    end,

    title = function(p71, p72) -- Line: 349, Name: title
        -- upvalues: JourneyConfig (copy), GOLD (copy)
        local v73 = JourneyConfig.Badges[p71];

        if not v73 then
            return nil;
        end;

        local v74;

        if typeof(v73.Color) == "Color3" then
            v74 = v73.Color;
        else
            v74 = GOLD;
        end;

        return {
            tag = "TITLE",
            key = "Title:" .. tostring(p71) .. (p72 and " (Owned)" or ""),
            badge = {
                icon = tostring(v73.Icon or "★"),
                title = tostring(v73.Name)
            },
            name = "Title" .. (p72 and " (Owned)" or ""),
            color = v74,
            tagColor = v74,
            glow = v74
        };
    end,

    gear = function(p75, p76) -- Line: 366, Name: gear
        -- upvalues: GearCatalog (copy), GOLD (copy), ClaimPop (copy)
        local v77 = GearCatalog.get(p75);

        if not v77 then
            return nil;
        end;

        local v78 = v77.Kind == "Ability";
        local v79;

        if typeof(v77.Accent) == "Color3" then
            v79 = v77.Accent;
        else
            v79 = GOLD;
        end;

        local v80 = ClaimPop.asset(v77.IconImage);
        local v81 = {
            key = "Gear:" .. tostring(p75) .. (p76 and " (Owned)" or ""),
            image = v80
        };
        local v82;

        if v80 then
            v82 = nil;
        else
            v82 = v77;
        end;

        v81.gear = v82;
        v81.emoji = not v80 and "🎒" or nil;
        v81.supply = not v78;
        v81.name = ClaimPop.titleCase(v77.Name) .. (p76 and " (Owned)" or "");
        v81.color = v79;
        v81.tag = v78 and "ABILITY" or nil;
        v81.tagColor = v79;

        if not v78 then
            v79 = nil;
        end;

        v81.glow = v79;

        return v81;
    end,

    crate = function(p83, p84) -- Line: 390, Name: crate
        -- upvalues: CrateCatalog (copy), GOLD (copy)
        local v85 = table.find(CrateCatalog.Order, p83) and CrateCatalog.get(p83);
        local v86 = v85 and typeof(v85.Accent) == "Color3" and v85.Accent or GOLD;

        return v85 and {
            still = true,
            key = "Crate:" .. tostring(p83),
            emote = CrateCatalog.poseEmote(p83),
            image = type(v85.Icon) ~= "string" and "rbxassetid://92637733103392" or v85.Icon,
            name = tostring(v85.Name),
            color = v86,
            tag = p84 and "FREE" or nil,
            tagColor = v86
        };
    end
};

function u1.tiles(p88) -- Line: 412
    -- upvalues: u87 (copy), TeamEventConfig (copy), ClaimPop (copy), GOLD (copy), Color3_fromRGB_ret7 (copy)
    local u89 = {};
    local u90 = {};
    local u91 = {};

    local function _(p92, p93, p94) -- Line: 416
        -- upvalues: u91 (copy)
        if not p93 or p94 <= 0 then
            return;
        end;

        local v95 = u91[p93.key];

        if v95 then
            v95.times = v95.times + p94;

            return;
        end;

        p93.times = p94;
        u91[p93.key] = p93;
        table.insert(p92, p93);
    end;

    local function addGear(p96, p97) -- Line: 430
        -- upvalues: u90 (copy), u89 (copy), u91 (copy)
        local v98;

        if p96 and p96.supply then
            v98 = u90;
        else
            v98 = u89;
        end;

        if p96 then
            if p97 <= 0 then
                return;
            end;

            local v99 = u91[p96.key];

            if v99 then
                v99.times = v99.times + p97;

                return;
            end;

            p96.times = p97;
            u91[p96.key] = p96;
            table.insert(v98, p96);
        end;
    end;

    local v100 = {};
    local v101 = 0;
    local v102 = 0;
    local v103 = 0;
    local v104 = 0;
    local v105 = {};
    local v106 = 0;
    local v107 = {};
    local v108 = {};
    local v109 = 0;

    for _, v in type(p88) ~= "table" and {} or p88 do
        if type(v) == "table" then
            if v.k == nil then
                v101 = v101 + (tonumber(v.Gems) or 0);
                v102 = v102 + (tonumber(v.Coins) or 0);
                v103 = v103 + (tonumber(v.Spins) or 0);
                v109 = v109 + (tonumber(v.GemBoostMinutes) or 0);
                v104 = v104 + (tonumber(v.CoinBoostMinutes) or 0);
                v106 = v106 + (tonumber(v.QuestSkips) or 0);
                local Knives = v.Knives;
                local v110 = v;

                for _, v2 in type(Knives) ~= "table" and {} or Knives do
                    local v111 = u87.knife(v2);

                    if v111 then
                        local v112 = u91[v111.key];

                        if v112 then
                            v112.times = v112.times + 1;
                        else
                            v111.times = 1;
                            u91[v111.key] = v111;
                            table.insert(v100, v111);
                        end;
                    end;
                end;

                local Emotes = v110.Emotes;

                for _, v2 in type(Emotes) ~= "table" and {} or Emotes do
                    local v113 = u87.emote(v2);

                    if v113 then
                        local v114 = u91[v113.key];

                        if v114 then
                            v114.times = v114.times + 1;
                        else
                            v113.times = 1;
                            u91[v113.key] = v113;
                            table.insert(v108, v113);
                        end;
                    end;
                end;

                local Titles = v110.Titles;

                for _, v2 in type(Titles) ~= "table" and {} or Titles do
                    local v115 = u87.title(v2);

                    if v115 then
                        local v116 = u91[v115.key];

                        if v116 then
                            v116.times = v116.times + 1;
                        else
                            v115.times = 1;
                            u91[v115.key] = v115;
                            table.insert(v105, v115);
                        end;
                    end;
                end;

                local Abilities = v110.Abilities;

                for _, v2 in type(Abilities) ~= "table" and {} or Abilities do
                    local v117 = u87.gear(v2);
                    local v118;

                    if v117 and v117.supply then
                        v118 = u90;
                    else
                        v118 = u89;
                    end;

                    if v117 then
                        local v119 = u91[v117.key];

                        if v119 then
                            v119.times = v119.times + 1;
                        else
                            v117.times = 1;
                            u91[v117.key] = v117;
                            table.insert(v118, v117);
                        end;
                    end;
                end;

                local Gear = v110.Gear;

                for i, v2 in type(Gear) ~= "table" and {} or Gear do
                    local v120 = u87.gear(i);
                    local v121 = tonumber(v2) or 0;
                    local v122;

                    if v120 and v120.supply then
                        v122 = u90;
                    else
                        v122 = u89;
                    end;

                    if v120 then
                        if v121 > 0 then
                            local v123 = u91[v120.key];

                            if v123 then
                                v123.times = v123.times + v121;
                            else
                                v120.times = v121;
                                u91[v120.key] = v120;
                                table.insert(v122, v120);
                            end;
                        end;
                    end;
                end;

                local Crates = v110.Crates;

                for i, v2 in type(Crates) ~= "table" and {} or Crates do
                    local v124 = tonumber(v2) or 0;
                    local v125 = u87.crate(i);

                    if v125 then
                        if v125 then
                            if v124 > 0 then
                                local v126 = u91[v125.key];

                                if v126 then
                                    v126.times = v126.times + v124;
                                else
                                    v125.times = v124;
                                    u91[v125.key] = v125;
                                    table.insert(v107, v125);
                                end;
                            end;
                        end;
                    else
                        v101 = v101 + (TeamEventConfig.CrateGems[i] or 0) * v124;
                    end;
                end;
            else
                local v127 = tonumber(v.n) or 0;

                if v.k == "Gems" then
                    v101 = v101 + v127;
                elseif v.k == "Coins" then
                    v102 = v102 + v127;
                elseif v.k == "Spins" then
                    v103 = v103 + v127;
                elseif v.k == "GemBoost" then
                    v109 = v109 + v127;
                elseif v.k == "CoinBoost" then
                    v104 = v104 + v127;
                elseif v.k == "QuestSkips" then
                    v106 = v106 + v127;
                elseif v.k == "Knife" then
                    local v128 = u87.knife(v.id, v.owned);

                    if v128 then
                        local v129 = u91[v128.key];

                        if v129 then
                            v129.times = v129.times + 1;
                        else
                            v128.times = 1;
                            u91[v128.key] = v128;
                            table.insert(v100, v128);
                        end;
                    end;
                elseif v.k == "Emote" then
                    local v130 = u87.emote(v.id, v.owned);

                    if v130 then
                        local v131 = u91[v130.key];

                        if v131 then
                            v131.times = v131.times + 1;
                        else
                            v130.times = 1;
                            u91[v130.key] = v130;
                            table.insert(v108, v130);
                        end;
                    end;
                elseif v.k == "Title" then
                    local v132 = u87.title(v.id, v.owned);

                    if v132 then
                        local v133 = u91[v132.key];

                        if v133 then
                            v133.times = v133.times + 1;
                        else
                            v132.times = 1;
                            u91[v132.key] = v132;
                            table.insert(v105, v132);
                        end;
                    end;
                elseif v.k == "Ability" then
                    local v134 = u87.gear(v.id, v.owned);
                    local v135;

                    if v134 and v134.supply then
                        v135 = u90;
                    else
                        v135 = u89;
                    end;

                    if v134 then
                        local v136 = u91[v134.key];

                        if v136 then
                            v136.times = v136.times + 1;
                        else
                            v134.times = 1;
                            u91[v134.key] = v134;
                            table.insert(v135, v134);
                        end;
                    end;
                elseif v.k == "Gear" then
                    local v137 = u87.gear(v.id);
                    local v138;

                    if v137 and v137.supply then
                        v138 = u90;
                    else
                        v138 = u89;
                    end;

                    if v137 then
                        if v127 > 0 then
                            local v139 = u91[v137.key];

                            if v139 then
                                v139.times = v139.times + v127;
                            else
                                v137.times = v127;
                                u91[v137.key] = v137;
                                table.insert(v138, v137);
                            end;
                        end;
                    end;
                elseif v.k == "Crate" then
                    if v.emote then
                        local v140 = u87.emote(v.emote, v.owned);

                        if v140 then
                            local v141 = u91[v140.key];

                            if v141 then
                                v141.times = v141.times + 1;
                            else
                                v140.times = 1;
                                u91[v140.key] = v140;
                                table.insert(v108, v140);
                            end;
                        end;
                    elseif v.skin then
                        local v142 = u87.knife(v.skin, v.owned);

                        if v142 then
                            local v143 = u91[v142.key];

                            if v143 then
                                v143.times = v143.times + 1;
                            else
                                v142.times = 1;
                                u91[v142.key] = v142;
                                table.insert(v100, v142);
                            end;
                        end;
                    else
                        local v144 = u87.crate(v.id, true);
                        local math_max_ret = math.max(1, v127);

                        if v144 and math_max_ret > 0 then
                            local v145 = u91[v144.key];

                            if v145 then
                                v145.times = v145.times + math_max_ret;
                            else
                                v144.times = math_max_ret;
                                u91[v144.key] = v144;
                                table.insert(v107, v144);
                            end;
                        end;
                    end;

                    v101 = v101 + (tonumber(v.gems) or 0);
                end;
            end;
        end;
    end;

    local v146 = {};

    for _, v in {
        v100,
        v108,
        v105,
        u89,
        v107,
        u90
    } do
        for _, v2 in v do
            if v2.supply then
                v2.amount = "+" .. v2.times;
            elseif v2.times > 1 then
                v2.amount = "×" .. v2.times;
            end;

            table.insert(v146, v2);
        end;
    end;

    if v103 > 0 then
        table.insert(v146, ClaimPop.spins(v103));
    end;

    if v109 > 0 then
        local v147 = {
            tag = "2×",
            name = "Gem Boost",
            image = ClaimPop.GEM_IMAGE
        };
        local v148 = v109 // 60;
        local v149 = v109 % 60;
        local v150;

        if v148 == 0 then
            v150 = v149 .. "m";
        else
            v150 = v148 .. "h" .. (v149 <= 0 and "" or " " .. v149 .. "m");
        end;

        v147.amount = v150;
        v147.amountColor = ClaimPop.GEM_TEXT;
        v147.tagColor = ClaimPop.GEM_TEXT;
        v147.color = ClaimPop.GEM_TEXT;
        table.insert(v146, v147);
    end;

    if v104 > 0 then
        local v151 = {
            tag = "2×",
            name = "Coin Boost",
            image = ClaimPop.COIN_IMAGE
        };
        local v152 = v104 // 60;
        local v153 = v104 % 60;
        local v154;

        if v152 == 0 then
            v154 = v153 .. "m";
        else
            v154 = v152 .. "h" .. (v153 <= 0 and "" or " " .. v153 .. "m");
        end;

        v151.amount = v154;
        v151.tagColor = GOLD;
        table.insert(v146, v151);
    end;

    if v106 > 0 then
        table.insert(v146, {
            image = "rbxassetid://109697384592866",
            count = v106,
            name = v106 == 1 and "Quest Skip" or "Quest Skips",
            color = Color3_fromRGB_ret7
        });
    end;

    if v101 > 0 then
        table.insert(v146, {
            name = "Gems",
            image = ClaimPop.GEM_IMAGE,
            count = v101,
            amountColor = ClaimPop.GEM_TEXT,
            color = ClaimPop.GEM_TEXT
        });
    end;

    if v102 > 0 then
        table.insert(v146, {
            name = "Coins",
            image = ClaimPop.COIN_IMAGE,
            count = v102
        });
    end;

    return v146, #v146;
end;

function u1.notice(p155) -- Line: 548
    -- upvalues: Players (copy), FFlags (copy), HudNavigation (copy), u8 (ref), Color3_new_ret (copy), Color3_new_ret2 (copy), TweenService (copy), Debris (copy)
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer then
        LocalPlayer = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    end;

    local v156 = FFlags.peekUIVersion();

    if not (LocalPlayer and (v156 ~= "NewGui" and (v156 ~= nil or LocalPlayer:FindFirstChild("ValleyHUD")))) then
        HudNavigation.Notice:Fire(p155);

        return;
    end;

    if u8 then
        u8:Destroy();
    end;

    local ScreenGui = Instance.new("ScreenGui");

    for i, v in {
        Name = "TeamEventNotice",
        DisplayOrder = 63,
        ResetOnSpawn = false
    } do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = nil;
    ScreenGui:SetAttribute("SelfManagedText", true);
    local v157 = {
        BackgroundTransparency = 1,
        TextSize = 20,
        TextWrapped = true,
        TextTransparency = 1,
        TextStrokeTransparency = 1,
        AutoLocalize = false,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.22),
        Size = UDim2.new(1, -32, 0, 52),
        Font = Enum.Font.GothamBold,
        Text = tostring(p155),
        TextColor3 = Color3_new_ret,
        TextStrokeColor3 = Color3_new_ret2
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v157 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = ScreenGui;
    ScreenGui.Parent = LocalPlayer;
    u8 = ScreenGui;
    TweenService:Create(TextLabel, TweenInfo.new(0.16), {
        TextTransparency = 0,
        TextStrokeTransparency = 0.4
    }):Play();
    task.delay(4, function() -- Line: 579
        -- upvalues: u8 (ref), ScreenGui (copy), TweenService (ref), TextLabel (copy), Debris (ref)
        if u8 ~= ScreenGui then
            return;
        end;

        u8 = nil;
        TweenService:Create(TextLabel, TweenInfo.new(0.3), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        Debris:AddItem(ScreenGui, 0.3);
    end);
end;

local function tile(p158, p159, p160, p161, p162) -- Line: 593
    -- upvalues: GOLD (copy), Vector2_new_ret (copy), Color3_new_ret (copy), Color3_fromRGB_ret (copy), NumberSequence_new_ret4 (copy), Color3_new_ret2 (copy), text (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy), NumberSequence_new_ret (copy)
    local v163 = p159.color or GOLD;
    local v164 = {
        spec = p159
    };

    if p159.glow then
        local v165 = {
            Name = "Glow",
            BackgroundTransparency = 1,
            Image = "rbxassetid://129028976496842",
            ImageTransparency = 0.3,
            ZIndex = 4,
            AnchorPoint = Vector2_new_ret,
            Size = UDim2.fromOffset(p160 * 2.1, p160 * 2.1),
            ImageColor3 = p159.glow,
            Rotation = math.random(0, 359)
        };
        local ImageLabel = Instance.new("ImageLabel");

        for i, v in v165 do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = p158;
        v164.glow = ImageLabel;
        local glow = v164.glow;
        local UIScale = Instance.new("UIScale");

        for i, v in {
            Scale = 0
        } do
            UIScale[i] = v;
        end;

        UIScale.Parent = glow;
        v164.glowScale = UIScale;
    end;

    local v166 = {
        Name = "Reward",
        BorderSizePixel = 0,
        ZIndex = 5,
        AnchorPoint = Vector2_new_ret,
        Size = UDim2.fromOffset(p160, p160),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v166 do
        Frame[i] = v;
    end;

    Frame.Parent = p158;
    local v167 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret, v163),
        Transparency = NumberSequence_new_ret4
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v167 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;
    local v168 = {
        CornerRadius = UDim.new(0.14, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v168 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v169 = {
        Thickness = 0.07,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        Color = Color3_new_ret2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v169 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    UIStroke.ZIndex = 1;
    local v170 = {
        Thickness = 0.035,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        Color = v163
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v170 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame;
    UIStroke2.ZIndex = 2;
    v164.holder = Frame;
    local UIScale = Instance.new("UIScale");

    for i, v in {
        Scale = 0
    } do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    v164.scale = UIScale;
    local v171 = p159.count and "+0" or p159.amount;
    local UDim2_fromScale_ret = UDim2.fromScale(0.5, v171 and 0.42 or 0.5);
    local v172 = v171 and 0.64 or 0.8;

    if p159.badge then
        local _, v173 = text(Frame, "Icon", p159.badge.icon, math.floor(p160 * 0.3), Color3_new_ret, {
            TextWrapped = false,
            AutoLocalize = false,
            Position = UDim2.fromScale(0.5, 0.36),
            Size = UDim2.fromScale(0.9, 0.42)
        });
        v173.Enabled = string.find(p159.badge.icon, "^[%w%p ]+$") ~= nil;
        local v174 = {
            Name = "Plate",
            ZIndex = 2,
            AnchorPoint = Vector2_new_ret,
            Position = UDim2.fromScale(0.5, 0.75),
            Size = UDim2.fromScale(0.9, 0.3),
            BackgroundColor3 = Color3_new_ret
        };
        local Frame2 = Instance.new("Frame");

        for i, v in v174 do
            Frame2[i] = v;
        end;

        Frame2.Parent = Frame;
        local v175 = {
            Rotation = 90,
            Color = ColorSequence.new(v163:Lerp(Color3_new_ret, 0.3), v163:Lerp(Color3_new_ret2, 0.25))
        };
        local UIGradient2 = Instance.new("UIGradient");

        for i, v in v175 do
            UIGradient2[i] = v;
        end;

        UIGradient2.Parent = Frame2;
        local v176 = {
            CornerRadius = UDim.new(0.3, 0)
        };
        local UICorner2 = Instance.new("UICorner");

        for i, v in v176 do
            UICorner2[i] = v;
        end;

        UICorner2.Parent = Frame2;
        local v177 = {
            Thickness = 0.05,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
            Color = Color3_new_ret2
        };
        local UIStroke3 = Instance.new("UIStroke");

        for i, v in v177 do
            UIStroke3[i] = v;
        end;

        UIStroke3.Parent = Frame2;
        local v178 = text(Frame2, "Title", p159.badge.title, math.floor(p160 * 0.13), Color3_new_ret, {
            TextScaled = true,
            AutoLocalize = false,
            ZIndex = 3,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.92, 0.84),
            FontFace = Font_new_ret2
        });
        local v179 = {
            MaxTextSize = math.floor(p160 * 0.13)
        };
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

        for i, v in v179 do
            UITextSizeConstraint[i] = v;
        end;

        UITextSizeConstraint.Parent = v178;
    elseif p159.more then
        text(Frame, "More", "+" .. p159.more, math.floor(p160 * 0.34), Color3_new_ret, {
            TextWrapped = false,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.9, 0.6),
            FontFace = Font_new_ret2
        });
    elseif p159.emoji then
        local v180, v181 = text(Frame, "Picture", p159.emoji, math.floor(p160 * 0.46), Color3_new_ret, {
            TextWrapped = false,
            Position = UDim2_fromScale_ret,
            Size = UDim2.fromScale(v172, v172)
        });
        v181.Enabled = false;
        v164.picture = v180;
    else
        local v182 = {
            Name = "Picture",
            BackgroundTransparency = 1,
            AnchorPoint = Vector2_new_ret,
            Position = UDim2_fromScale_ret,
            Size = UDim2.fromScale(v172, v172),
            ScaleType = Enum.ScaleType.Fit,
            Image = p159.image or ""
        };
        local ImageLabel = Instance.new("ImageLabel");

        for i, v in v182 do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = Frame;

        if p159.icon then
            local v183 = p159.icon:Clone();
            v183.AnchorPoint = Vector2_new_ret;
            v183.Position = UDim2_fromScale_ret;
            v183.Size = ImageLabel.Size;
            v183.Parent = Frame;
            ImageLabel.Visible = false;
        end;

        v164.picture = ImageLabel;
    end;

    if p159.emote or (p159.knife or p159.gear) then
        local v184 = {
            Name = "View",
            BackgroundTransparency = 1,
            Visible = false,
            AnchorPoint = Vector2_new_ret,
            Position = UDim2.fromScale(0.5, v171 and 0.42 or 0.47),
            Size = UDim2.fromScale(0.94, v171 and 0.74 or 0.84)
        };
        local ViewportFrame = Instance.new("ViewportFrame");

        for i, v in v184 do
            ViewportFrame[i] = v;
        end;

        ViewportFrame.Parent = Frame;
        v164.view = ViewportFrame;
    end;

    if v171 then
        v164.amount = text(Frame, "Amount", v171, math.floor(p160 * 0.2), p159.amountColor or Color3_new_ret, {
            TextWrapped = false,
            ZIndex = 2,
            Position = UDim2.fromScale(0.5, 0.82),
            Size = UDim2.fromScale(0.96, 0.28)
        });
    end;

    if p159.name then
        local v185 = text(Frame, "Caption", p159.name, p162, Color3_fromRGB_ret2, {
            TextWrapped = false,
            TextScaled = true,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromScale(0.5, 1.08),
            Size = UDim2.fromOffset(p161, (math.floor(p162 * 1.3))),
            TextYAlignment = Enum.TextYAlignment.Top
        });
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

        for i, v in {
            MinTextSize = 10,
            MaxTextSize = p162
        } do
            UITextSizeConstraint[i] = v;
        end;

        UITextSizeConstraint.Parent = v185;
    end;

    if p159.tag then
        local v186 = p159.tagColor or v163;
        local v187 = utf8.len(p159.tag) * p160 * 0.085 + p160 * 0.16;
        local math_clamp_ret = math.clamp(v187, p160 * 0.34, p160 * 0.9);
        local v188 = {
            Name = "Tag",
            ZIndex = 4,
            AnchorPoint = Vector2_new_ret,
            Position = UDim2.fromScale(0.5, 0.01),
            Size = UDim2.fromOffset(math.floor(math_clamp_ret), (math.floor(p160 * 0.17))),
            BackgroundColor3 = Color3_new_ret
        };
        local Frame2 = Instance.new("Frame");

        for i, v in v188 do
            Frame2[i] = v;
        end;

        Frame2.Parent = Frame;
        local v189 = {
            Rotation = 90,
            Color = ColorSequence.new(v186:Lerp(Color3_new_ret, 0.45), v186)
        };
        local UIGradient2 = Instance.new("UIGradient");

        for i, v in v189 do
            UIGradient2[i] = v;
        end;

        UIGradient2.Parent = Frame2;
        local v190 = {
            CornerRadius = UDim.new(0.5, 0)
        };
        local UICorner2 = Instance.new("UICorner");

        for i, v in v190 do
            UICorner2[i] = v;
        end;

        UICorner2.Parent = Frame2;
        local v191 = {
            Thickness = 0.1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
            Color = Color3_new_ret2
        };
        local UIStroke3 = Instance.new("UIStroke");

        for i, v in v191 do
            UIStroke3[i] = v;
        end;

        UIStroke3.Parent = Frame2;
        local v192 = {
            Name = "Label",
            BackgroundTransparency = 1,
            TextScaled = true,
            AutoLocalize = false,
            ZIndex = 5,
            AnchorPoint = Vector2_new_ret,
            Position = UDim2.fromScale(0.5, 0.52),
            Size = UDim2.fromScale(0.86, 0.74),
            FontFace = Font_new_ret2,
            Text = p159.tag,
            TextColor3 = Color3_fromRGB_ret
        };
        local TextLabel = Instance.new("TextLabel");

        for i, v in v192 do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = Frame2;
        local v193 = {
            MaxTextSize = math.floor(p160 * 0.13)
        };
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

        for i, v in v193 do
            UITextSizeConstraint[i] = v;
        end;

        UITextSizeConstraint.Parent = TextLabel;
    end;

    local v194 = {
        Name = "Shine",
        BorderSizePixel = 0,
        ZIndex = 3,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v194 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v195 = {
        CornerRadius = UDim.new(0.14, 0)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v195 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v196 = {
        Rotation = 25,
        Transparency = NumberSequence_new_ret,
        Offset = Vector2.new(-1.5, 0)
    };
    local UIGradient2 = Instance.new("UIGradient");

    for i, v in v196 do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = Frame2;
    v164.shine = UIGradient2;
    local v197 = {
        Name = "Glare",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 6,
        BackgroundColor3 = Color3_new_ret,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v197 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    v164.glare = Frame3;
    local glare = v164.glare;
    local v198 = {
        CornerRadius = UDim.new(0.14, 0)
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v198 do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = glare;

    return v164;
end;

local function button(p199, p200, p201, p202, p203, p204, p205, p206, p207) -- Line: 775
    -- upvalues: Vector2_new_ret (copy), Color3_new_ret (copy), Color3_new_ret2 (copy), text (copy), Font_new_ret2 (copy), UserInputService (copy)
    local v208 = {
        AutoButtonColor = true,
        Selectable = false,
        Text = "",
        ZIndex = 7,
        Name = p200,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromOffset(p202, 38),
        Size = UDim2.fromOffset(p203, 76),
        BackgroundColor3 = Color3_new_ret
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v208 do
        TextButton[i] = v;
    end;

    TextButton.Parent = p199;
    local v209 = {
        CornerRadius = UDim.new(0.24, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v209 do
        UICorner[i] = v;
    end;

    UICorner.Parent = TextButton;
    local v210 = {
        Rotation = 90,
        Color = ColorSequence.new(p204, p205)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v210 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = TextButton;
    local v211 = {
        Thickness = 0.08,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        Color = Color3_new_ret2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v211 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextButton;
    UIStroke.ZIndex = 1;
    local v212 = {
        Thickness = 0.04,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        Color = p206
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v212 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = TextButton;
    UIStroke2.ZIndex = 2;
    local v213 = text(TextButton, "Label", p201, 30, Color3_new_ret, {
        ZIndex = 2,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        FontFace = Font_new_ret2
    });

    if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
        local success, result = pcall(UserInputService.GetImageForKeyCode, UserInputService, p207);

        if success and (type(result) == "string" and result ~= "") then
            local v214 = {
                Name = "Key",
                BackgroundTransparency = 1,
                ZIndex = 3,
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 14, 0.5, 0),
                Size = UDim2.fromOffset(40, 40),
                Image = result
            };
            local ImageLabel = Instance.new("ImageLabel");

            for i, v in v214 do
                ImageLabel[i] = v;
            end;

            ImageLabel.Parent = TextButton;
            v213.Position = UDim2.new(0.5, 22, 0.5, 0);
        end;
    end;

    return TextButton;
end;

local function bind(p215, p216, u217) -- Line: 815
    -- upvalues: ContextActionService (copy), u4 (copy)
    ContextActionService:BindActionAtPriority(p215, function(p218, p219) -- Line: 816
        -- upvalues: u217 (copy)
        if p219 == Enum.UserInputState.Begin then
            u217();
        end;

        return Enum.ContextActionResult.Sink;
    end, false, u4, p216);
end;

local function finish(p220) -- Line: 824
    -- upvalues: u7 (ref), SoundService (copy), TweenService (copy), Debris (copy)
    if u7 == p220 then
        u7 = nil;
    end;

    if p220.done then
        return;
    end;

    p220.done = true;

    if p220.step then
        p220.step:Disconnect();
    end;

    for _, v in p220.tiles do
        if v.preview then
            v.preview:destroy();
            v.preview = nil;
        end;
    end;

    for _, v in p220.sounds do
        if v.IsPlaying then
            v.Parent = SoundService;
            TweenService:Create(v, TweenInfo.new(0.7), {
                Volume = 0
            }):Play();
            Debris:AddItem(v, 0.75);
        end;
    end;

    table.clear(p220.sounds);
    table.clear(p220.tiles);
    table.clear(p220.confetti);
    table.clear(p220.sparks);
    table.clear(p220.flares);
    table.clear(p220.beams);
    p220.gui:Destroy();
end;

local function close(p221, p222) -- Line: 859
    -- upvalues: ContextActionService (copy), Players (copy), u7 (ref), finish (copy)
    if not p221.closing then
        p221.closing = p221.clock;
        ContextActionService:UnbindAction("TeamEventCelebrationClaim");
        ContextActionService:UnbindAction("TeamEventCelebrationLater");
        local LocalPlayer = Players.LocalPlayer;

        if u7 == p221 and LocalPlayer then
            LocalPlayer:SetAttribute("TeamEventCelebrating", nil);
        end;

        if p221.onClose then
            task.spawn(p221.onClose);
        end;
    end;

    if p222 then
        finish(p221);
    end;
end;

local function layout(p223, p224) -- Line: 877
    -- upvalues: Vector2_new_ret2 (copy)
    p223.screen = p224;
    p223.k = p224.Y / Vector2_new_ret2.Y;
    p223.stageScale.Scale = math.min(p224.X / Vector2_new_ret2.X, p224.Y / Vector2_new_ret2.Y);
    local v225 = math.max(p224.X, p224.Y) * 1.5;

    for _, v in p223.rays do
        v.image.Size = UDim2.fromOffset(v225 * v.size, v225 * v.size);
    end;

    for i, v in p223.beams do
        v.x = p224.X * (i == 1 and 0.06 or 0.94);
        v.y = p224.Y + 12;
        v.height = p224.Y * 1.5;
        local v226 = v;

        for i2, v2 in v.frames do
            v2.Size = UDim2.fromOffset(p224.Y * (i2 == 1 and 0.34 or 0.12), v226.height);
        end;
    end;

    local math_max_ret = math.max(0.75, p223.k);

    for _, v in p223.confetti do
        v.frame.Size = UDim2.fromOffset(v.width * math_max_ret, v.height * math_max_ret);
    end;

    p223.spark = math.max(3, 5 * p223.k);
end;

local function land(p227) -- Line: 902
    -- upvalues: SoundService (copy), cue (copy), sound (copy)
    local screen = p227.screen;
    local k = p227.k;
    local math_floor_ret = math.floor(#p227.confetti * 2 / 3);

    for i, v in p227.confetti do
        v.live = true;
        v.rotation = math.random(0, 359);
        v.spin = math.random(-540, 540);
        v.frame.Visible = true;

        if i <= math_floor_ret then
            local v228 = i % 2 == 0;
            v.x = v228 and -10 or screen.X + 10;
            v.y = screen.Y * 0.9;
            v.vx = (v228 and 1 or -1) * math.random(250, 900) * k;
            v.vy = -math.random(900, 1550) * k;
        else
            local v229 = math.random() * screen.X;
            local v230 = -math.random(10, 500) * k;
            v.x = v229;
            v.y = v230;
            v.vx = (math.random() * 2 - 1) * 40 * k;
            v.vy = 0;
        end;
    end;

    p227.flash.BackgroundTransparency = 0.3;
    local GameAudio = SoundService:FindFirstChild("GameAudio");

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("10_Football");
    end;

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("CrowdSurge");
    end;

    local v231;

    if GameAudio and GameAudio:IsA("Sound") then
        local v232 = GameAudio:Clone();
        v232.Parent = p227.gui;
        v232:Play();
        table.insert(p227.sounds, v232);
        v231 = true;
    else
        v231 = false;
    end;

    if v231 then
        cue(p227, "CrowdCheer", 0.8);

        return;
    end;

    sound("04_UI.MatchSummary.LevelUp");
end;

local function rain(p233, p234, p235, p236) -- Line: 930
    local screen = p233.screen;
    local k = p233.k;

    for _, v in p233.confetti do
        if v.live then
            local v237 = 0;

            while true do
                if v237 == 0 then
                    v237 = -1;
                    v.vy = math.min(v.vy + 1500 * k * p235, 240 * k);
                    v.vx = v.vx - v.vx * math.min(1, 1.4 * p235);
                    v.x = v.x + (v.vx + math.sin(p234 * v.wobble + v.phase) * 50 * k) * p235;
                    v.y = v.y + v.vy * p235;
                    v.rotation = v.rotation + v.spin * p235;

                    if v.y > screen.Y + 40 then
                        v237 = 2;
                        continue;
                    end;

                    v237 = 1;
                    continue;
                elseif v237 == 1 then
                    v237 = -1;
                    v.frame.Position = UDim2.fromOffset(v.x, v.y);
                    v.frame.Rotation = v.rotation;

                    if p233.closing then
                        v.frame.BackgroundTransparency = 1 - p236;
                    end;

                    v237 = 3;
                    continue;
                elseif v237 == 2 then
                    v237 = -1;

                    if p234 < 5 and not p233.closing then
                        local v238 = math.random() * screen.X;
                        local v239 = -math.random(10, 120) * k;
                        v.x = v238;
                        v.y = v239;
                        v.vx = (math.random() * 2 - 1) * 40 * k;
                        v.vy = 0;
                        v237 = 1;
                        continue;
                    end;

                    v.live = false;
                    v.frame.Visible = false;
                    v237 = 3;
                    continue;
                elseif v237 == 3 then
                    v237 = -1;
                    break;
                else
                    break;
                end;
            end;
        end;
    end;
end;

local function firework(p240, p241) -- Line: 961
    -- upvalues: Color3_new_ret (copy)
    local screen = p240.screen;
    local k = p240.k;
    local v242 = screen.X * ((p241 % 2 == 1 and 0.1 or 0.66) + math.random() * 0.24);
    local v243 = screen.Y * (0.1 + math.random() * 0.3);
    local v244 = p240.palette[p241 % #p240.palette + 1];
    local v245 = math.random() * 3.141592653589793 * 2;
    local v246 = 0;

    for _, v in p240.sparks do
        if not v.live then
            v246 = v246 + 1;
            local v247 = v245 + v246 / 22 * 3.141592653589793 * 2 + (math.random() - 0.5) * 0.25;
            local v248 = (230 + math.random() * 170) * k;
            local v249 = 0.9 + math.random() * 0.5;
            v.live = true;
            v.age = 0;
            v.life = v249;
            v.x = v242;
            v.y = v243;
            local v250 = math.cos(v247) * v248;
            local v251 = math.sin(v247) * v248;
            v.vx = v250;
            v.vy = v251;
            local v252;

            if v246 % 4 == 0 then
                v252 = Color3_new_ret;
            else
                v252 = v244;
            end;

            v.frame.BackgroundColor3 = v252;
            v.frame.Visible = true;

            if v246 >= 22 then
                break;
            end;
        end;
    end;

    local v253 = p240.flares[p241 % 3 + 1];
    v253.age = 0;
    v253.image.Position = UDim2.fromOffset(v242, v243);
    v253.image.ImageColor3 = v244;
    v253.image.Visible = true;
end;

local function sparkle(p254, p255, p256) -- Line: 991
    -- upvalues: Quad (copy), TweenService (copy), Out (copy)
    local k = p254.k;

    for _, v in p254.flares do
        if v.age then
            v.age = v.age + p255;
            local v257 = v.age / 0.55;

            if v257 >= 1 then
                v.age = nil;
                v.image.Visible = false;
            else
                local v258 = (50 + 230 * TweenService:GetValue(math.clamp(v257, 0, 1), Quad, Out)) * k;
                v.image.Size = UDim2.fromOffset(v258, v258);
                v.image.ImageTransparency = 1 - (1 - v257) * 0.75 * p256;
            end;
        end;
    end;

    for _, v in p254.sparks do
        if v.live then
            v.age = v.age + p255;

            if v.age >= v.life then
                v.live = false;
                v.frame.Visible = false;
            else
                local v259 = v.age / v.life;
                v.vx = v.vx - v.vx * math.min(1, 2.4 * p255);
                v.vy = v.vy + (280 * k - v.vy * 2.4) * p255;
                v.x = v.x + v.vx * p255;
                v.y = v.y + v.vy * p255;
                local v260 = p254.spark * (1 - 0.45 * v259);
                v.frame.Position = UDim2.fromOffset(v.x, v.y);
                v.frame.Size = UDim2.fromOffset(v260, v260 + math.sqrt(v.vx * v.vx + v.vy * v.vy) * 0.07);
                local frame = v.frame;
                local math_atan2_ret = math.atan2(v.vy, v.vx);
                frame.Rotation = math.deg(math_atan2_ret) + 90;
                v.frame.BackgroundTransparency = 1 - (1 - v259 * v259) * p256;
            end;
        end;
    end;
end;

local u261 = nil;
local u262 = nil;

local function step(p263, p264) -- Line: 1033
    -- upvalues: finish (copy), close (copy), layout (copy), Quad (copy), TweenService (copy), Out (copy), In (copy), land (copy), u5 (copy), firework (copy), setAlpha (copy), cue (copy), u261 (ref), Vector2_new_ret2 (copy), fadeSet (copy), u262 (ref), chime (copy), sound (copy), Back (copy), Widgets (copy), rain (copy), sparkle (copy)
    local v265 = p263.clock + p264;
    p263.clock = v265;
    local v266 = 1;

    if p263.closing then
        v266 = 1 - math.clamp((v265 - p263.closing) / 0.35, 0, 1);

        if v266 <= 0 then
            finish(p263);

            return;
        end;
    elseif (p263.lifetime or 8) <= v265 then
        close(p263);
    end;

    local AbsoluteSize = p263.gui.AbsoluteSize;

    if AbsoluteSize ~= p263.screen and (AbsoluteSize.X >= 1 and AbsoluteSize.Y >= 1) then
        layout(p263, AbsoluteSize);
    end;

    p263.backdrop.BackgroundTransparency = 1 - 0.72 * TweenService:GetValue(math.clamp(v265 / 0.3, 0, 1), Quad, Out) * v266;
    local v267 = TweenService:GetValue(math.clamp(v265 / 0.5, 0, 1), Quad, Out) * v266;

    for _, v in p263.rays do
        v.image.ImageTransparency = 1 - v.alpha * v267;
        v.image.Rotation = (v.image.Rotation + p264 * v.spin) % 360;
    end;

    for _, v in p263.beams do
        local v268 = v.lean * (math.sin(v265 * 0.9 + v.phase) * 13 + 26);
        local math_rad_ret = math.rad(v268);
        local v269 = v.height / 2;
        local UDim2_fromOffset_ret = UDim2.fromOffset(v.x + math.sin(math_rad_ret) * v269, v.y - math.cos(math_rad_ret) * v269);

        for i, v2 in v.frames do
            v2.Position = UDim2_fromOffset_ret;
            v2.Rotation = math.deg(math_rad_ret);
            v2.BackgroundTransparency = 1 - (i == 1 and 0.2 or 0.28) * v267;
        end;
    end;

    local math_clamp_ret = math.clamp((v265 - 0.15) / 0.27, 0, 1);

    if p263.landed then
        if not p263.settled then
            local v270 = v265 - p263.landed;

            if v270 < 0.4 then
                local v271 = 14 * (1 - v270 / 0.4);
                p263.stage.Position = UDim2.new(0.5, (math.random() * 2 - 1) * v271, 0.5, (math.random() * 2 - 1) * v271);
                p263.flash.BackgroundTransparency = 0.3 + 0.7 * v270 / 0.4;
            else
                p263.settled = true;
                p263.stage.Position = UDim2.fromScale(0.5, 0.5);
                p263.flash.BackgroundTransparency = 1;
            end;
        end;
    else
        p263.bannerScale.Scale = 1 + 2.4 * (1 - TweenService:GetValue(math.clamp(math_clamp_ret, 0, 1), Quad, In or Out));

        if math_clamp_ret >= 1 then
            p263.landed = v265;
            land(p263);
        end;
    end;

    if p263.landed and not (p263.closing or (not u5[p263.burst] or v265 - p263.landed < u5[p263.burst])) then
        firework(p263, p263.burst);
        p263.burst = p263.burst + 1;
    end;

    setAlpha(p263.fades.banner, math.min(1, math_clamp_ret * 2.5) * v266);
    setAlpha(p263.fades.eyebrow, TweenService:GetValue(math.clamp((v265 - 0.42) / 0.3, 0, 1), Quad, Out) * v266);
    setAlpha(p263.fades.note, TweenService:GetValue(math.clamp((v265 - 0.42 - 0.15) / 0.3, 0, 1), Quad, Out) * v266);
    p263.shimmer.Offset = Vector2.new(v265 * 0.8 % 2.6 - 1.3, 0);

    for _, v in p263.icons do
        v.label.Rotation = math.sin(v265 * 4 + v.phase) * 12;
    end;

    if p263.opening then
        local given = p263.given;
        p263.opening = nil;
        p263.given = nil;
        p263.flash.BackgroundTransparency = 0.25;
        p263.flashFrom = v265;
        firework(p263, p263.burst);
        p263.burst = p263.burst + 1;
        cue(p263, "CrowdCheer", 0.3);
        local v272 = u261(p263, given, v265 + 0.08);

        for _, v in p263.words do
            v[1].Position = UDim2.fromOffset(Vector2_new_ret2.X / 2, v[2] - v272);
        end;

        p263.fades.tiles = fadeSet(p263.rewards);
        p263.allIn = nil;
        p263.chime = true;
        p263.lifetime = v265 + 7;
        task.spawn(u262, p263);
    end;

    if p263.flashFrom then
        local v273 = (v265 - p263.flashFrom) / 0.4;
        p263.flash.BackgroundTransparency = math.min(1, v273) * 0.75 + 0.25;

        if v273 >= 1 then
            p263.flashFrom = nil;
        end;
    end;

    local v274 = 0;

    for _, v in p263.tiles do
        local v275 = v265 - v.start;

        if v275 >= 0 then
            if not v.popped then
                v.popped = true;

                if p263.chime then
                    chime(p263, v265);
                else
                    sound("04_UI.MatchSummary.CountTick");
                end;
            end;

            if v275 < 0.45 then
                v.scale.Scale = TweenService:GetValue(math.clamp(v275 / 0.35, 0, 1), Back, Out);
                v.glare.BackgroundTransparency = math.min(1, 0.2 + v275 / 0.45 * 0.8);
            elseif not v.settled then
                v.settled = true;
                v.scale.Scale = 1;
                v.glare.BackgroundTransparency = 1;
            end;

            if v.glow then
                v.glowScale.Scale = v.scale.Scale;
                v.glow.Rotation = (v.glow.Rotation + p264 * 24) % 360;
            end;

            local v276 = (v275 - 0.4) % 2.6;
            v.shine.Offset = Vector2.new((v275 < 0.4 or v276 >= 0.7) and -1.5 or v276 / 0.7 * 2.8 - 1.4, 0);

            if v.amount and (v.spec.count and not v.counted) then
                local v277 = (v275 - 0.1) / 0.6;
                v.counted = v277 >= 1;
                local amount = v.amount;
                local number = Widgets.number;
                local v278 = v.spec.count * TweenService:GetValue(math.clamp(v277, 0, 1), Quad, Out);
                amount.Text = "+" .. number((math.round(v278)));
            end;

            if v275 >= 0.35 then
                v274 = v274 + 1;
            end;
        end;

        if v.preview then
            v.preview:step(p264);

            if v.playAt and (v.playAt <= v265 and v.preview:play()) then
                v.playAt = nil;
            end;
        end;
    end;

    if not (p263.allIn or (not p263.landed or v274 ~= #p263.tiles)) then
        p263.allIn = v265;

        if v274 > 0 then
            sound("04_UI.MatchSummary.CountComplete");
        end;

        for _, v in p263.tiles do
            if v.spec.emote and not v.spec.still then
                v.playAt = v265 + 0.3;
            end;
        end;
    end;

    setAlpha(p263.fades.tiles, v266);
    local Value = TweenService:GetValue(math.clamp((v265 - 1.25) / 0.35, 0, 1), Quad, Out);
    setAlpha(p263.fades.controls, Value * v266);

    if not p263.risen then
        p263.risen = Value >= 1;
        p263.controls.Position = UDim2.fromOffset(Vector2_new_ret2.X / 2, 660 + 36 * (1 - Value));
    end;

    if v265 >= 1.25 and not p263.closing then
        local v279;

        if p263.lifetime == (1 / 0) then
            v279 = 1;
        elseif p263.lifetime then
            v279 = (p263.lifetime - v265) / 7;
        else
            v279 = 1 - (v265 - 1.25) / 6.75;
        end;

        p263.timer.Size = UDim2.fromScale(math.clamp(v279, 0, 1), 1);
    end;

    rain(p263, v265, p264, v266);
    sparkle(p263, p264, v266);
end;

u262 = function(p280) -- Line: 1201, Name: previews
    -- upvalues: Preview (copy), EmotePose (copy), RunService (copy)
    local layGen = p280.layGen;

    for i, v in p280.tiles do
        if p280.done or p280.layGen ~= layGen then
            return;
        end;

        local spec = v.spec;
        local view = v.view;

        if view then
            local success, result = pcall(function() -- Line: 1210
                -- upvalues: spec (copy), Preview (ref), view (copy), i (copy), EmotePose (ref)
                if spec.knife then
                    return Preview.knife(view, spec.knife, nil);
                end;

                if spec.gear then
                    return Preview.gear(view, spec.gear, i);
                end;

                return EmotePose.new(view, spec.emote);
            end);

            if success and result then
                if p280.done or p280.layGen ~= layGen then
                    result:destroy();

                    return;
                end;

                v.preview = result;
                view.Visible = true;

                if v.picture then
                    v.picture.Visible = false;
                end;
            end;

            RunService.Heartbeat:Wait();
        end;
    end;
end;

u261 = function(p281, p282, p283) -- Line: 1238, Name: lay
    -- upvalues: u1 (copy), GOLD (copy), Vector2_new_ret2 (copy), tile (copy), Vector2_new_ret (copy), Color3_new_ret2 (copy), NumberSequence_new_ret3 (copy), Color3_new_ret (copy)
    if p281.rewards then
        for _, v in p281.tiles do
            if v.preview then
                v.preview:destroy();
                v.preview = nil;
            end;
        end;

        p281.rewards:Destroy();
    end;

    p281.tiles = {};
    p281.layGen = (p281.layGen or 0) + 1;
    local v284, v285 = u1.tiles(p282);

    if #v284 > 16 then
        local v286 = #v284 - 16 + 1;

        for i = 1, v286 do
            table.remove(v284, v285);
            v285 = v285 - 1;
            local _ = i;
        end;

        table.insert(v284, v285 + 1, {
            name = "More Rewards",
            more = v286,
            color = GOLD
        });
    end;

    local v287 = #v284;
    local v288 = v287 > 8 and 2 or 1;
    local math_ceil_ret = math.ceil(v287 / v288);
    local v289 = v288 == 1 and { 458 } or { 380, 522 };
    local v290 = 1.9 / math.max(1, v287);
    local math_min_ret = math.min(0.16, v290);
    local stage = p281.stage;
    local v291 = {
        Name = "Rewards",
        BackgroundTransparency = 1,
        ZIndex = 5,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame = Instance.new("Frame");

    for i, v in v291 do
        Frame[i] = v;
    end;

    Frame.Parent = stage;
    p281.rewards = Frame;
    local v292 = 0;

    for i = 1, v288 do
        local v293 = (i - 1) * math_ceil_ret + 1;
        local math_min_ret2 = math.min(v287, i * math_ceil_ret);
        local v294 = (math_min_ret2 - v293) * 0.36;
        local v295 = i;

        for i2 = v293, math_min_ret2 do
            v294 = v294 + (v284[i2].big and v288 == 1 and 1.25 or 1);
            local _ = i2;
        end;

        local math_floor_ret = math.floor(1180 / v294);
        local math_min_ret3 = math.min(v288 == 2 and 104 or 156, math_floor_ret);
        local math_floor_ret2 = math.floor(math_min_ret3 * 0.36);
        local v296 = math_floor_ret2 * (math_min_ret2 - v293);
        local v297 = {};

        for i2 = v293, math_min_ret2 do
            local v298;

            if v284[i2].big and v288 == 1 then
                v298 = math_min_ret3 * 1.25;
            else
                v298 = math_min_ret3;
            end;

            v297[i2] = math.floor(v298);
            v296 = v296 + v297[i2];
            v292 = math.max(v292, v297[i2]);
            local _ = i2;
        end;

        local v299 = (Vector2_new_ret2.X - v296) / 2;

        for i2 = v293, math_min_ret2 do
            local v300 = v297[i2];
            local v301 = tile(Frame, v284[i2], v300, v300 + math.floor(math_floor_ret2 * 0.7), v288 == 1 and math_min_ret3 >= 120 and 22 or 18);
            local UDim2_fromOffset_ret = UDim2.fromOffset(v299 + v300 / 2, v289[v295]);
            v301.holder.Position = UDim2_fromOffset_ret;

            if v301.glow then
                v301.glow.Position = UDim2_fromOffset_ret;
            end;

            v301.start = p283 + (i2 - 1) * math_min_ret;
            table.insert(p281.tiles, v301);
            v299 = v299 + (v300 + math_floor_ret2);
            local _ = i2;
        end;
    end;

    if v287 > 0 then
        local v302 = v289[v288] - v289[1] + v292 + (v288 == 2 and 80 or 92);
        local v303 = (v289[1] + v289[v288]) / 2 + 10;
        local v304 = {
            Name = "Shelf",
            BorderSizePixel = 0,
            ZIndex = 3,
            AnchorPoint = Vector2_new_ret,
            Position = UDim2.fromOffset(Vector2_new_ret2.X / 2, v303),
            Size = UDim2.fromOffset(Vector2_new_ret2.X, v302),
            BackgroundColor3 = Color3_new_ret2
        };
        local Frame2 = Instance.new("Frame");

        for i, v in v304 do
            Frame2[i] = v;
        end;

        Frame2.Parent = Frame;
        local v305 = {
            Transparency = NumberSequence_new_ret3
        };
        local UIGradient = Instance.new("UIGradient");

        for i, v in v305 do
            UIGradient[i] = v;
        end;

        UIGradient.Parent = Frame2;

        for _, v in { v303 - v302 / 2, v303 + v302 / 2 } do
            local v306 = {
                Name = "Edge",
                BorderSizePixel = 0,
                ZIndex = 3,
                AnchorPoint = Vector2_new_ret,
                Position = UDim2.fromOffset(Vector2_new_ret2.X / 2, v),
                Size = UDim2.fromOffset(Vector2_new_ret2.X, 3),
                BackgroundColor3 = p281.color:Lerp(Color3_new_ret, 0.45)
            };
            local Frame3 = Instance.new("Frame");

            for i, v2 in v306 do
                Frame3[i] = v2;
            end;

            Frame3.Parent = Frame;
            local v307 = {
                Transparency = NumberSequence_new_ret3
            };
            local UIGradient2 = Instance.new("UIGradient");

            for i, v2 in v307 do
                UIGradient2[i] = v2;
            end;

            UIGradient2.Parent = Frame3;
        end;
    end;

    return v288 == 2 and 30 or 0;
end;

function u1.show(u308) -- Line: 1332
    -- upvalues: u7 (ref), close (copy), Players (copy), TeamEventConfig (copy), GOLD (copy), CutsceneScreen (copy), Color3_new_ret (copy), Color3_new_ret2 (copy), Vector2_new_ret (copy), NumberSequence_new_ret2 (copy), Vector2_new_ret2 (copy), u261 (ref), text (copy), Font_new_ret2 (copy), u1 (copy), ColorSequence_new_ret (copy), Widgets (copy), u2 (copy), ContextActionService (copy), button (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret6 (copy), fadeSet (copy), setAlpha (copy), layout (copy), u4 (copy), RunService (copy), step (copy), u262 (ref), SoundService (copy)
    if u7 then
        close(u7, true);
    end;

    local LocalPlayer = Players.LocalPlayer;
    local v309;

    if LocalPlayer then
        v309 = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    else
        v309 = LocalPlayer;
    end;

    if not v309 then
        return nil;
    end;

    local kind = u308.kind;
    local team = u308.team;
    local v310 = TeamEventConfig.Team[team];
    local v311;

    if v310 then
        v311 = v310.Color;
    else
        v311 = GOLD;
    end;

    local levels = u308.levels;
    local v312;

    if type(levels) == "table" then
        v312 = levels[1];
    else
        v312 = levels;
    end;

    if type(levels) == "table" then
        levels = levels[2] or levels[1];
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v313 = {
        Name = "TeamEventCelebration",
        DisplayOrder = 950,
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ScreenInsets = Enum.ScreenInsets.None,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local ScreenGui = Instance.new("ScreenGui");

    for i, v in v313 do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = nil;
    CutsceneScreen.apply(ScreenGui);
    ScreenGui:SetAttribute("SelfManagedText", true);
    local u314 = {
        clock = 0,
        burst = 1,
        chimes = 0,
        gui = ScreenGui,
        rays = {},
        beams = {},
        icons = {},
        tiles = {},
        confetti = {},
        sparks = {},
        flares = {},
        sounds = {},
        palette = { v311:Lerp(Color3_new_ret, 0.35), GOLD, v311:Lerp(Color3_new_ret, 0.7) },
        color = v311,
        onClose = u308.onClose,
        chime = kind == "Delivered" and true or kind == "Champion"
    };
    local v315 = {
        Name = "Backdrop",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.5, 1.5),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v315 do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    u314.backdrop = Frame;
    local backdrop = u314.backdrop;
    local v316 = {
        Rotation = 90,
        Color = ColorSequence.new(v311:Lerp(Color3_new_ret2, 0.45), v311:Lerp(Color3_new_ret2, 0.88))
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v316 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = backdrop;

    for i, v in {
        {
            v311:Lerp(Color3_new_ret, 0.3),
            0.55,
            1,
            12
        },
        {
            GOLD,
            0.35,
            0.8,
            -8
        }
    } do
        local v317 = {
            Name = "Rays",
            BackgroundTransparency = 1,
            Image = "rbxassetid://129028976496842",
            ImageTransparency = 1,
            ZIndex = 2,
            AnchorPoint = Vector2_new_ret,
            Position = UDim2.fromScale(0.5, 0.46),
            ImageColor3 = v[1],
            Rotation = i * 20
        };
        local ImageLabel = Instance.new("ImageLabel");
        local v318 = v;

        for i2, v2 in v317 do
            ImageLabel[i2] = v2;
        end;

        ImageLabel.Parent = ScreenGui;
        table.insert(u314.rays, {
            image = ImageLabel,
            alpha = v318[2],
            size = v318[3],
            spin = v318[4]
        });
    end;

    for i = 1, 2 do
        local v319 = {
            lean = i == 1 and 1 or -1,
            phase = i * 2.1,
            frames = {}
        };
        local _ = i;

        for i2 = 1, 2 do
            local v320 = {
                Name = "Floodlight",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ZIndex = 2,
                AnchorPoint = Vector2_new_ret,
                BackgroundColor3 = v311:Lerp(Color3_new_ret, 0.75)
            };
            local Frame2 = Instance.new("Frame");
            local _ = i2;

            for i3, v in v320 do
                Frame2[i3] = v;
            end;

            Frame2.Parent = ScreenGui;
            local v321 = {
                Rotation = 90,
                Transparency = NumberSequence_new_ret2
            };
            local UIGradient2 = Instance.new("UIGradient");

            for i3, v in v321 do
                UIGradient2[i3] = v;
            end;

            UIGradient2.Parent = Frame2;
            local v322 = {
                CornerRadius = UDim.new(0.5, 0)
            };
            local UICorner = Instance.new("UICorner");

            for i3, v in v322 do
                UICorner[i3] = v;
            end;

            UICorner.Parent = Frame2;
            table.insert(v319.frames, Frame2);
        end;

        table.insert(u314.beams, v319);
    end;

    local v323 = {
        Name = "Fireworks",
        BackgroundTransparency = 1,
        ZIndex = 2,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v323 do
        Frame2[i] = v;
    end;

    Frame2.Parent = ScreenGui;

    for i = 1, 88 do
        local v324 = {
            Name = "Spark",
            BorderSizePixel = 0,
            Visible = false,
            AnchorPoint = Vector2_new_ret,
            BackgroundColor3 = Color3_new_ret
        };
        local Frame3 = Instance.new("Frame");
        local _ = i;

        for i2, v in v324 do
            Frame3[i2] = v;
        end;

        Frame3.Parent = Frame2;
        local v325 = {
            CornerRadius = UDim.new(1, 0)
        };
        local UICorner = Instance.new("UICorner");

        for i2, v in v325 do
            UICorner[i2] = v;
        end;

        UICorner.Parent = Frame3;
        table.insert(u314.sparks, {
            frame = Frame3
        });
    end;

    for i = 1, 3 do
        local v326 = {
            Name = "Flare",
            BackgroundTransparency = 1,
            Image = "rbxassetid://129028976496842",
            ImageTransparency = 1,
            Visible = false,
            AnchorPoint = Vector2_new_ret
        };
        local ImageLabel = Instance.new("ImageLabel");
        local _ = i;

        for i2, v in v326 do
            ImageLabel[i2] = v;
        end;

        ImageLabel.Parent = Frame2;
        table.insert(u314.flares, {
            image = ImageLabel
        });
    end;

    local v327 = {
        Name = "Stage",
        BackgroundTransparency = 1,
        ZIndex = 3,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(Vector2_new_ret2.X, Vector2_new_ret2.Y)
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v327 do
        Frame3[i] = v;
    end;

    Frame3.Parent = ScreenGui;
    u314.stage = Frame3;
    local UIScale = Instance.new("UIScale");

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame3;
    u314.stageScale = UIScale;
    local v328 = u261(u314, u308.rewards, 0.85);
    local Football = TeamEventConfig.Team.Football;
    local Futbol = TeamEventConfig.Team.Futbol;
    local v329 = {
        Name = "Eyebrow",
        BorderSizePixel = 0,
        ZIndex = 4,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromOffset(Vector2_new_ret2.X / 2, 92 - v328),
        Size = UDim2.fromOffset(470, 50),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame4 = Instance.new("Frame");

    for i, v in v329 do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame3;
    local v330 = {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Football.Color:Lerp(Color3_new_ret2, 0.25)),
            ColorSequenceKeypoint.new(0.499, Football.Color:Lerp(Color3_new_ret, 0.12)),
            ColorSequenceKeypoint.new(0.501, Futbol.Color:Lerp(Color3_new_ret, 0.12)),
            ColorSequenceKeypoint.new(1, Futbol.Color:Lerp(Color3_new_ret2, 0.25))
        })
    };
    local UIGradient2 = Instance.new("UIGradient");

    for i, v in v330 do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = Frame4;
    local v331 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v331 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame4;
    local v332 = {
        Thickness = 0.08,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        Color = Color3_new_ret2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v332 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame4;
    UIStroke.ZIndex = 1;
    local v333 = {
        Thickness = 0.035,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        Color = GOLD
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v333 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame4;
    UIStroke2.ZIndex = 2;

    for i, v in { Football, Futbol } do
        text(Frame4, "Team", v.Name, 28, Color3_new_ret, {
            TextWrapped = false,
            AutoLocalize = false,
            Position = UDim2.fromScale(i == 1 and 0.25 or 0.75, 0.53),
            Size = UDim2.fromScale(0.4, 0.8),
            FontFace = Font_new_ret2
        });
    end;

    local v334 = {
        Name = "Versus",
        ZIndex = 2,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(64, 64),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame5 = Instance.new("Frame");

    for i, v in v334 do
        Frame5[i] = v;
    end;

    Frame5.Parent = Frame4;
    local v335 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3.fromRGB(255, 230, 130), GOLD:Lerp(Color3_new_ret2, 0.25))
    };
    local UIGradient3 = Instance.new("UIGradient");

    for i, v in v335 do
        UIGradient3[i] = v;
    end;

    UIGradient3.Parent = Frame5;
    local v336 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v336 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame5;
    local v337 = {
        Thickness = 0.07,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        Color = Color3_new_ret2
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v337 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = Frame5;
    text(Frame5, "Label", "VS", 27, Color3_new_ret, {
        TextWrapped = false,
        ZIndex = 3,
        Position = UDim2.fromScale(0.5, 0.53),
        Size = UDim2.fromScale(1, 1),
        FontFace = Font_new_ret2
    });
    local v338 = {
        Name = "Banner",
        Rotation = -2,
        BorderSizePixel = 0,
        ZIndex = 4,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromOffset(Vector2_new_ret2.X / 2, 214 - v328),
        Size = UDim2.fromOffset(1000, 136),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame6 = Instance.new("Frame");

    for i, v in v338 do
        Frame6[i] = v;
    end;

    Frame6.Parent = Frame3;
    local v339 = {
        Rotation = 90,
        Color = ColorSequence.new(v311:Lerp(Color3_new_ret, 0.2), v311:Lerp(Color3_new_ret2, 0.35))
    };
    local UIGradient4 = Instance.new("UIGradient");

    for i, v in v339 do
        UIGradient4[i] = v;
    end;

    UIGradient4.Parent = Frame6;
    local v340 = {
        CornerRadius = UDim.new(0.22, 0)
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v340 do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = Frame6;
    local v341 = {
        Thickness = 0.06,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        Color = Color3_new_ret2
    };
    local UIStroke4 = Instance.new("UIStroke");

    for i, v in v341 do
        UIStroke4[i] = v;
    end;

    UIStroke4.Parent = Frame6;
    UIStroke4.ZIndex = 1;
    local v342;

    if kind == "Champion" then
        v342 = GOLD;
    else
        v342 = Color3_new_ret;
    end;

    local v343 = {
        Thickness = 0.03,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        Color = v342
    };
    local UIStroke5 = Instance.new("UIStroke");

    for i, v in v343 do
        UIStroke5[i] = v;
    end;

    UIStroke5.Parent = Frame6;
    UIStroke5.ZIndex = 2;
    local UIScale2 = Instance.new("UIScale");

    for i, v in {
        Scale = 3.4
    } do
        UIScale2[i] = v;
    end;

    UIScale2.Parent = Frame6;
    u314.bannerScale = UIScale2;
    local v344 = text(Frame6, "Words", u308.banner or u1.banner(kind, team, v312, levels), 72, Color3_new_ret, {
        TextScaled = true,
        AutoLocalize = false,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.9, 0.78),
        FontFace = Font_new_ret2
    });
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 72
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = v344;
    local v345 = {
        Color = ColorSequence_new_ret,
        Offset = Vector2.new(-1.3, 0)
    };
    local UIGradient5 = Instance.new("UIGradient");

    for i, v in v345 do
        UIGradient5[i] = v;
    end;

    UIGradient5.Parent = v344;
    u314.shimmer = UIGradient5;
    local v346 = (kind == "Champion" or not v310) and "🏆" or v310.Icon;

    for i, v in { -0.04, 1.04 } do
        local v347, v348 = text(Frame6, "Icon", v346, 100, Color3_new_ret, {
            TextWrapped = false,
            ZIndex = 5,
            Position = UDim2.fromScale(v, 0.5),
            Size = UDim2.fromOffset(130, 130)
        });
        v348.Enabled = false;
        table.insert(u314.icons, {
            label = v347,
            phase = i * 3.141592653589793
        });
    end;

    local note = u308.note;

    if not note then
        local v349 = TeamEventConfig.Team[team];

        if kind == "Personal" then
            note = "YOU\'VE EARNED " .. Widgets.number(TeamEventConfig.PersonalLevels[levels] or 0) .. " POINTS FOR YOUR TEAM!";
        else
            note = kind == "Team" and "YOUR TEAM HIT A NEW MILESTONE!" or (kind ~= "Champion" and "EVERYTHING YOU EARNED, DELIVERED!" or (not v349 and "YOUR TEAM" or v349.Label) .. " WINS " .. u2 .. "!");
        end;
    end;

    local v350 = text(Frame3, "Note", note, 30, Color3_new_ret, {
        AutoLocalize = false,
        ZIndex = 6,
        Position = UDim2.fromOffset(Vector2_new_ret2.X / 2, 314 - v328),
        Size = UDim2.fromOffset(1000, 40)
    });
    u314.words = {
        { Frame4, 92 },
        { Frame6, 214 },
        { v350, 314 }
    };

    local function claim() -- Line: 1556
        -- upvalues: u314 (copy), u308 (copy), ContextActionService (ref), close (ref)
        if u314.closing or (u314.claiming or u314.claimed) then
            return;
        end;

        if not (u308.claimHere and u314.handle) then
            close(u314);

            if u308.onClaim then
                task.spawn(u308.onClaim);
            end;

            return;
        end;

        u314.claiming = true;
        u314.lifetime = (1 / 0);
        ContextActionService:UnbindAction("TeamEventCelebrationClaim");

        if u314.claimButton then
            u314.claimButton.Interactable = false;
            u314.claimButton.Label.Text = "OPENING…";
        end;

        task.spawn(u308.claimHere, u314.handle);
    end;

    local function later() -- Line: 1577
        -- upvalues: close (ref), u314 (copy)
        close(u314);
    end;

    local v351 = {
        Name = "Controls",
        BackgroundTransparency = 1,
        ZIndex = 6,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromOffset(Vector2_new_ret2.X / 2, 696),
        Size = UDim2.fromOffset(700, 100)
    };
    local Frame7 = Instance.new("Frame");

    for i, v in v351 do
        Frame7[i] = v;
    end;

    Frame7.Parent = Frame3;
    u314.controls = Frame7;

    if u308.onClaim then
        u314.claimButton = button(Frame7, "Claim", "CLAIM NOW", 228, 320, Color3_fromRGB_ret3, Color3_fromRGB_ret4, Color3_fromRGB_ret3, Enum.KeyCode.ButtonY);
        u314.claimButton.Activated:Connect(claim);
        u314.laterButton = button(Frame7, "Later", "LATER", 522, 220, Color3_fromRGB_ret5, Color3_fromRGB_ret6, Color3_fromRGB_ret5, Enum.KeyCode.ButtonB);
        u314.laterButton.Activated:Connect(later);

        if u308.claimHere then
            u314.doneButton = button(Frame7, "Close", "AWESOME!", 350, 320, Color3_fromRGB_ret3, Color3_fromRGB_ret4, Color3_fromRGB_ret3, Enum.KeyCode.ButtonB);
            u314.doneButton.Activated:Connect(later);
            u314.doneButton.Visible = false;
        end;
    else
        button(Frame7, "Close", "AWESOME!", 350, 320, Color3_fromRGB_ret3, Color3_fromRGB_ret4, Color3_fromRGB_ret3, Enum.KeyCode.ButtonB).Activated:Connect(later);
    end;

    local v352 = {
        Name = "Timer",
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromOffset(350, 94),
        Size = UDim2.fromOffset(420, 8),
        BackgroundColor3 = Color3_new_ret2
    };
    local Frame8 = Instance.new("Frame");

    for i, v in v352 do
        Frame8[i] = v;
    end;

    Frame8.Parent = Frame7;
    local v353 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner4 = Instance.new("UICorner");

    for i, v in v353 do
        UICorner4[i] = v;
    end;

    UICorner4.Parent = Frame8;
    local v354 = {
        Name = "Fill",
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = v311:Lerp(Color3_new_ret, 0.5)
    };
    local Frame9 = Instance.new("Frame");

    for i, v in v354 do
        Frame9[i] = v;
    end;

    Frame9.Parent = Frame8;
    u314.timer = Frame9;
    local timer = u314.timer;
    local v355 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner5 = Instance.new("UICorner");

    for i, v in v355 do
        UICorner5[i] = v;
    end;

    UICorner5.Parent = timer;
    local v356 = {
        Name = "Confetti",
        BackgroundTransparency = 1,
        ZIndex = 4,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame10 = Instance.new("Frame");

    for i, v in v356 do
        Frame10[i] = v;
    end;

    Frame10.Parent = ScreenGui;
    local v357 = {
        v311,
        v311:Lerp(Color3_new_ret, 0.45),
        GOLD,
        Color3_new_ret
    };

    for i = 1, 90 do
        local confetti = u314.confetti;
        local v358 = {
            Name = "Piece",
            BorderSizePixel = 0,
            Visible = false,
            AnchorPoint = Vector2_new_ret,
            BackgroundColor3 = v357[i % #v357 + 1]
        };
        local Frame11 = Instance.new("Frame");
        local _ = i;
        local v359 = {};

        for i2, v in v358 do
            Frame11[i2] = v;
        end;

        Frame11.Parent = Frame10;
        v359.frame = Frame11;
        v359.width = math.random(7, 11);
        v359.height = math.random(13, 19);
        v359.phase = math.random() * 3.141592653589793 * 2;
        v359.wobble = 2 + math.random() * 3;
        table.insert(confetti, v359);
    end;

    local v360 = {
        Name = "Flash",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 5,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.5, 1.5),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame11 = Instance.new("Frame");

    for i, v in v360 do
        Frame11[i] = v;
    end;

    Frame11.Parent = ScreenGui;
    u314.flash = Frame11;
    u314.fades = {
        eyebrow = fadeSet(Frame4),
        banner = fadeSet(Frame6),
        note = fadeSet(v350),
        tiles = fadeSet(u314.rewards),
        controls = fadeSet(Frame7)
    };

    for _, v in u314.fades do
        setAlpha(v, 0);
    end;

    local v361;

    if workspace_CurrentCamera then
        v361 = workspace_CurrentCamera.ViewportSize;
    else
        v361 = Vector2_new_ret2;
    end;

    layout(u314, v361);
    ScreenGui.Parent = v309;
    u7 = u314;
    LocalPlayer:SetAttribute("TeamEventCelebrating", true);

    if u308.onClaim then
        ContextActionService:BindActionAtPriority("TeamEventCelebrationClaim", function(p362, p363) -- Line: 816
            -- upvalues: claim (copy)
            if p363 == Enum.UserInputState.Begin then
                claim();
            end;

            return Enum.ContextActionResult.Sink;
        end, false, u4, Enum.KeyCode.ButtonY);
    end;

    ContextActionService:BindActionAtPriority("TeamEventCelebrationLater", function(p364, p365) -- Line: 816
        -- upvalues: later (copy)
        if p365 == Enum.UserInputState.Begin then
            later();
        end;

        return Enum.ContextActionResult.Sink;
    end, false, u4, Enum.KeyCode.ButtonB);
    u314.step = RunService.RenderStepped:Connect(function(p366) -- Line: 1663
        -- upvalues: step (ref), u314 (copy)
        step(u314, p366);
    end);
    task.spawn(u262, u314);
    local GameAudio = SoundService:FindFirstChild("GameAudio");

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("10_Football");
    end;

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("Whistle");
    end;

    if GameAudio and GameAudio:IsA("Sound") then
        local v367 = GameAudio:Clone();
        v367.Parent = u314.gui;
        v367:Play();
        table.insert(u314.sounds, v367);
    end;

    u314.handle = {
        close = function(p368, p369) -- Line: 1669, Name: close
            -- upvalues: close (ref), u314 (copy)
            close(u314, p369);
        end,

        reveal = function(p370, p371) -- Line: 1673, Name: reveal
            -- upvalues: u314 (copy)
            if u314.done or (u314.closing or not u314.claiming) then
                return;
            end;

            u314.claiming = false;
            u314.claimed = true;
            u314.claimButton.Visible = false;
            u314.laterButton.Visible = false;
            u314.doneButton.Visible = true;

            if type(p371) ~= "table" or next(p371) == nil then
                u314.lifetime = u314.clock + 7;

                return;
            end;

            u314.given = p371;
            u314.opening = u314.clock;
        end,

        failed = function() -- Line: 1689, Name: failed
            -- upvalues: u314 (copy), close (ref), u308 (copy)
            if u314.done or (u314.closing or not u314.claiming) then
                return;
            end;

            u314.claiming = false;
            close(u314);

            if u308.onClaim then
                task.spawn(u308.onClaim);
            end;
        end
    };

    return u314.handle;
end;

return u1;