 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).Ranked ~= true then
    return;
end;

local RankedRemote = ChickenOrHero:WaitForChild("Game"):WaitForChild("RankedRemote", 60);

if not RankedRemote then
    return;
end;

local ArmoryEvent = ChickenOrHero:WaitForChild("Weapons"):WaitForChild("ArmoryEvent");
local RankedConfig = require(ChickenOrHero.Game:WaitForChild("RankedConfig"));
local RankedRanks = require(ChickenOrHero.Game:WaitForChild("RankedRanks"));
local Skin = require(ChickenOrHero:WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local Palette = Skin.Palette;
local HudNavigation = require(ChickenOrHero.Presentation.HudNavigation);
local MapLocator = require(ChickenOrHero.Game:WaitForChild("MapLocator"));
local u1 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled;

local function px(p2) -- Line: 38
    -- upvalues: u1 (copy)
    if u1 then
        return math.round(p2 * 1.2);
    end;

    return p2;
end;

local u3 = {
    title = u1 and 38 or 32,
    big = u1 and 34 or 28,
    head = u1 and 23 or 19,
    tab = u1 and 20 or 17,
    body = u1 and 19 or 16,
    small = u1 and 17 or 14,
    button = u1 and 29 or 24
};
local text = Palette.text;
local textBody = Palette.textBody;
local gold = Palette.gold;
local green = Palette.green;
local GothamMedium = Enum.Font.GothamMedium;
local GothamBold = Enum.Font.GothamBold;
local GothamBlack = Enum.Font.GothamBlack;
local u4 = nil;

local function localDate(u5) -- Line: 80
    local success, result = pcall(function() -- Line: 81
        -- upvalues: u5 (copy)
        return DateTime.fromUnixTimestamp(u5):FormatLocalTime("MMM D, h:mm A", "en-us");
    end);

    return not success and "" or result;
end;

local function seasonEnds() -- Line: 86
    -- upvalues: u4 (ref), RankedRanks (copy)
    if u4 and u4.endsAt then
        return u4.endsAt;
    end;

    return RankedRanks.seasonEnds(os.time());
end;

local function seasonId() -- Line: 89
    -- upvalues: u4 (ref), RankedRanks (copy)
    if u4 and u4.season then
        return u4.season;
    end;

    return RankedRanks.season(os.time());
end;

local function label(p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16) -- Line: 93
    -- upvalues: Panels (copy), text (copy), GothamMedium (copy)
    local v17 = Panels.text(p6, p7, p8, p9, p10, p11, p12, p13, p14 or text);
    v17.Font = p15 or GothamMedium;
    v17.TextScaled = false;
    v17.TextWrapped = true;

    if p16 then
        v17.TextXAlignment = Enum.TextXAlignment[p16];
    end;

    return v17;
end;

local function middle(p18) -- Line: 103
    p18.TextYAlignment = Enum.TextYAlignment.Center;

    return p18;
end;

local function top(p19) -- Line: 107
    p19.TextYAlignment = Enum.TextYAlignment.Top;

    return p19;
end;

local function skinButton(p20, p21, p22) -- Line: 111
    -- upvalues: Skin (copy), GothamBlack (copy), text (copy)
    Skin.button(p20, p21, {
        shimmer = false
    });
    p20.Font = GothamBlack;
    p20.TextScaled = false;
    p20.TextSize = p22;
    p20.TextColor3 = text;
end;

local u23 = Panels.screen(LocalPlayer, "RankedMenu", 68);
u23:SetAttribute("SelfManagedText", true);
local u24, v25, v26 = Panels.panel(u23, "RankedPanel", 880, 480);
local v27 = Panels.make("Frame", v25, "Header", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(20, 14),
    Size = UDim2.fromOffset(780, 58)
});
Skin.header(v27, {
    decoration = false,
    transparency = 0.2
});
local v28 = Panels.text(v27, "Title", "RANKED", 18, 0, 200, 58, u3.title, text or text);
v28.Font = GothamBlack or GothamMedium;
v28.TextScaled = false;
v28.TextWrapped = true;
v28.TextYAlignment = Enum.TextYAlignment.Center;
local u29 = Panels.text(v27, "Season", "", 214, 0, 240, 58, u3.head, gold or text);
u29.Font = GothamBlack or GothamMedium;
u29.TextScaled = false;
u29.TextWrapped = true;
u29.TextYAlignment = Enum.TextYAlignment.Center;
local u30 = Panels.text(v27, "Ends", "", 462, 0, 300, 58, u3.body, text or text);
u30.Font = GothamBold or GothamMedium;
u30.TextScaled = false;
u30.TextWrapped = true;
u30.TextXAlignment = Enum.TextXAlignment.Right;
u30.TextYAlignment = Enum.TextYAlignment.Center;
local u31 = Panels.make("Frame", v25, "Rank", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(20, 84),
    Size = UDim2.fromOffset(330, 288)
});
Skin.card(u31, nil);
local u32 = Panels.make("ImageLabel", u31, "Icon", {
    BackgroundTransparency = 1,
    ZIndex = 2,
    Visible = false,
    Position = UDim2.fromOffset(109, 12),
    Size = UDim2.fromOffset(112, 112),
    ScaleType = Enum.ScaleType.Fit
});
local u33 = Panels.text(u31, "PlaceMark", "?", 109, 12, 112, 112, 80, textBody or text);
u33.Font = GothamBlack or GothamMedium;
u33.TextScaled = false;
u33.TextWrapped = true;
u33.TextXAlignment = Enum.TextXAlignment.Center;
u33.TextYAlignment = Enum.TextYAlignment.Center;
local u34 = Panels.text(u31, "Tier", "LOADING...", 10, 128, 310, 36, u3.big, text or text);
u34.Font = GothamBlack or GothamMedium;
u34.TextScaled = false;
u34.TextWrapped = true;
u34.TextXAlignment = Enum.TextXAlignment.Center;
u34.TextYAlignment = Enum.TextYAlignment.Center;
local u35 = Panels.text(u31, "RP", "", 10, 166, 310, 24, u3.body, text or text);
u35.Font = GothamBold or GothamMedium;
u35.TextScaled = false;
u35.TextWrapped = true;
u35.TextXAlignment = Enum.TextXAlignment.Center;
u35.TextYAlignment = Enum.TextYAlignment.Center;
local v36 = Panels.make("Frame", u31, "Track", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(24, 196),
    Size = UDim2.fromOffset(282, 14)
});
local u37 = Panels.make("Frame", v36, "Fill", {
    BorderSizePixel = 0,
    Size = UDim2.fromScale(0, 1)
});
Skin.bar(v36, u37, "gold");
local u38 = Panels.text(u31, "Detail", "", 14, 220, 302, 62, u3.small, textBody or text);
u38.Font = GothamBold or GothamMedium;
u38.TextScaled = false;
u38.TextWrapped = true;
u38.TextXAlignment = Enum.TextXAlignment.Center;
u38.TextYAlignment = Enum.TextYAlignment.Top;
local v39 = 366;
local u40 = {};

local function comma(p41) -- Line: 63
    local math_floor_ret = math.floor(p41);
    local v42 = tostring(math_floor_ret);
    local v43;

    repeat
        v42, v43 = v42:gsub("^(-?%d+)(%d%d%d)", "%1,%2");
    until v43 == 0;

    return v42;
end;

local u44 = {};

local function clock(p45) -- Line: 71
    local math_floor_ret = math.floor(p45);
    local math_max_ret = math.max(0, math_floor_ret);

    return ("%d:%02d"):format(math_max_ret // 60, math_max_ret % 60);
end;

local function span(p46) -- Line: 75
    local math_floor_ret = math.floor(p46);
    local math_max_ret = math.max(0, math_floor_ret);
    local v47 = math_max_ret // 86400;
    local v48 = math_max_ret % 86400 // 3600;
    local v49 = math_max_ret % 3600 // 60;

    if v47 > 0 then
        return ("%dd %dh"):format(v47, v48);
    end;

    if v48 > 0 then
        return ("%dh %dm"):format(v48, v49);
    end;

    return ("%dm"):format(v49);
end;

local u50 = "Season";

for _, v in { { "Season", "SEASON", 120 }, { "Rewards", "REWARDS", 130 }, { "Help", "?  HOW IT WORKS", 220 } } do
    u40[v[1]] = Panels.button(v25, v[1] .. "Tab", v[2], v39, 84, v[3], 40);
    v39 = v39 + (v[3] + 12);
end;

local u51 = Panels.make("Frame", v25, "Body", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(366, 136),
    Size = UDim2.fromOffset(494, 236)
});
local u52 = Panels.make("Frame", u51, "Season", {
    BorderSizePixel = 0,
    Size = UDim2.fromScale(1, 1)
});
Skin.card(u52, nil);
local u53 = Panels.text(u52, "Name", "", 18, 10, 458, 30, u3.head + 2, gold or text);
u53.Font = GothamBlack or GothamMedium;
u53.TextScaled = false;
u53.TextWrapped = true;
u53.TextYAlignment = Enum.TextYAlignment.Center;
local u54 = Panels.text(u52, "Ends", "", 18, 42, 458, 24, u3.body, text or text);
u54.Font = GothamBold or GothamMedium;
u54.TextScaled = false;
u54.TextWrapped = true;
u54.TextYAlignment = Enum.TextYAlignment.Center;
local u55 = Panels.text(u52, "Stats", "", 18, 68, 458, 24, u3.body, text or text);
u55.Font = GothamBold or GothamMedium;
u55.TextScaled = false;
u55.TextWrapped = true;
u55.TextYAlignment = Enum.TextYAlignment.Center;
local u56 = Panels.text(u52, "Note", "", 18, 104, 458, 122, u3.body, textBody or text);
u56.Font = GothamMedium;
u56.TextScaled = false;
u56.TextWrapped = true;
u56.TextYAlignment = Enum.TextYAlignment.Top;

local function scroller(p57) -- Line: 167
    -- upvalues: Panels (copy), u51 (copy), Skin (copy)
    local v58 = Panels.make("ScrollingFrame", u51, p57, {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 6,
        Visible = false,
        Size = UDim2.fromScale(1, 1),
        VerticalScrollBarInset = Enum.ScrollBarInset.Always,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new()
    });
    Skin.scroll(v58);
    Panels.make("UIListLayout", v58, "Layout", {
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    });
    Panels.make("UIPadding", v58, "Padding", {
        PaddingTop = UDim.new(0, 2),
        PaddingBottom = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 2),
        PaddingRight = UDim.new(0, 8)
    });

    return v58;
end;

local function heading(p59, p60, p61) -- Line: 183
    -- upvalues: u1 (copy), u3 (copy), gold (copy), GothamBlack (copy), Panels (copy), text (copy), GothamMedium (copy)
    local v62 = Panels.text(p59, "Heading", p60, 0, 0, 480, u1 and 36 or 30, u3.small, gold or text);
    v62.Font = GothamBlack or GothamMedium;
    v62.TextScaled = false;
    v62.TextWrapped = true;
    v62.TextYAlignment = Enum.TextYAlignment.Bottom;
    v62.LayoutOrder = p61;

    return v62;
end;

local u63 = scroller("Rewards");
local u64 = u1 and 55 or 46;

local function rewardRow(p65, p66, p67) -- Line: 193
    -- upvalues: Panels (copy), u63 (copy), u64 (copy), Skin (copy), RankedConfig (copy), u3 (copy), RankedRanks (copy), GothamBlack (copy), text (copy), GothamMedium (copy), GothamBold (copy), green (copy)
    local v68 = Panels.make("Frame", u63, "Row" .. p65, {
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(480, u64),
        LayoutOrder = p65
    });
    Skin.card(v68, nil, {
        radius = UDim.new(0, 8)
    });
    local v69 = RankedConfig.TierIcons[p66];
    local v70;

    if v69 then
        local v71 = u64 - 10;
        Panels.make("ImageLabel", v68, "Icon", {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(8, 5),
            Size = UDim2.fromOffset(v71, v71),
            ScaleType = Enum.ScaleType.Fit,
            Image = v69
        });
        v70 = 8 + v71 + 6;
    else
        v70 = 14;
    end;

    local body = u3.body;
    local v72 = RankedRanks.color(p66);
    local v73 = Panels.text(v68, "Name", p66, v70, 0, 176 - v70, u64, body, v72 or text);
    v73.Font = GothamBlack or GothamMedium;
    v73.TextScaled = false;
    v73.TextWrapped = true;
    v73.TextYAlignment = Enum.TextYAlignment.Center;
    local v74 = Panels.text(v68, "Reward", p67, 182, 0, 198, u64, u3.small, text or text);
    v74.Font = GothamBold or GothamMedium;
    v74.TextScaled = false;
    v74.TextWrapped = true;
    v74.TextYAlignment = Enum.TextYAlignment.Center;
    local v75 = Panels.text(v68, "Tag", "", 376, 0, 92, u64, u3.small, green or text);
    v75.Font = GothamBlack or GothamMedium;
    v75.TextScaled = false;
    v75.TextWrapped = true;
    v75.TextXAlignment = Enum.TextXAlignment.Right;
    v75.TextYAlignment = Enum.TextYAlignment.Center;

    return v68, v75;
end;

local v76 = Panels.text(u63, "Heading", "RANK-UP REWARDS: once a season, when you rank up", 0, 0, 480, u1 and 36 or 30, u3.small, gold or text);
v76.Font = GothamBlack or GothamMedium;
v76.TextScaled = false;
v76.TextWrapped = true;
v76.TextYAlignment = Enum.TextYAlignment.Bottom;
v76.LayoutOrder = 1;
rewardRow(2, "Division", ("+%s coins for each new division"):format((comma(RankedConfig.DivisionReward.Coins or 0))));
local u77 = {};
local u78 = {};

for i, v in RankedConfig.Tiers do
    local v79 = RankedConfig.TierRewards[v.Name];

    if v79 then
        local _, v80 = rewardRow(2 + i, v.Name, ("+%s coins"):format((comma(v79.Coins or 0))));
        u77[i] = v80;
    end;
end;

local v81 = Panels.text(u63, "Heading", "SEASON REWARDS: by your peak tier, when the season ends", 0, 0, 480, u1 and 36 or 30, u3.small, gold or text);
v81.Font = GothamBlack or GothamMedium;
v81.TextScaled = false;
v81.TextWrapped = true;
v81.TextYAlignment = Enum.TextYAlignment.Bottom;
v81.LayoutOrder = 20;

for i, v in RankedConfig.Tiers do
    local v82 = RankedConfig.SeasonRewards[v.Name];

    if v82 then
        local v83, v84 = rewardRow(20 + i, v.Name, ("+%s coins, %s"):format(comma(v82.Coins or 0), v82.Exclusive or ""));
        u78[i] = {
            row = v83,
            tag = v84
        };
    end;
end;

local u85 = nil;

local function buildHelp() -- Line: 235
    -- upvalues: u85 (ref), scroller (copy), u3 (copy), textBody (copy), Panels (copy), text (copy), GothamMedium (copy), u1 (copy), Skin (copy), GothamBold (copy), GothamBlack (copy), RankedConfig (copy), gold (copy), RankedRanks (copy), comma (copy)
    u85 = scroller("Help");
    local u86 = 0;

    local function nextOrder() -- Line: 238
        -- upvalues: u86 (ref)
        u86 = u86 + 1;

        return u86;
    end;

    local function para(p87) -- Line: 242
        -- upvalues: u85 (ref), u3 (ref), textBody (ref), Panels (ref), text (ref), GothamMedium (ref), u86 (ref)
        local v88 = Panels.text(u85, "Text", p87, 0, 0, 480, 0, u3.body, textBody or text);
        v88.Font = GothamMedium;
        v88.TextScaled = false;
        v88.TextWrapped = true;
        v88.TextYAlignment = Enum.TextYAlignment.Top;
        v88.AutomaticSize = Enum.AutomaticSize.Y;
        u86 = u86 + 1;
        v88.LayoutOrder = u86;
    end;

    local u89 = u1 and 40 or 28;

    if u1 then
        u89 = math.round(u89 * 1.2);
    end;

    local function rows(p90) -- Line: 249
        -- upvalues: Panels (ref), u85 (ref), u89 (copy), u86 (ref), Skin (ref), u3 (ref), textBody (ref), GothamBold (ref), text (ref), GothamMedium (ref), GothamBlack (ref)
        local make = Panels.make;
        local v91 = {
            BorderSizePixel = 0,
            Size = UDim2.fromOffset(480, 12 + #p90 * u89)
        };
        u86 = u86 + 1;
        v91.LayoutOrder = u86;
        local v92 = make("Frame", u85, "Rows", v91);
        Skin.card(v92, nil, {
            radius = UDim.new(0, 8)
        });

        for i, v in p90 do
            local v93 = 6 + (i - 1) * u89;
            local v94 = Panels.text(v92, "Label", v[1], 14, v93, 218, u89, u3.small, textBody or text);
            v94.Font = GothamBold or GothamMedium;
            v94.TextScaled = false;
            v94.TextWrapped = true;
            v94.TextYAlignment = Enum.TextYAlignment.Center;
            local v95 = Panels.text(v92, "Value", v[2], 232, v93, 234, u89, u3.small, text or text);
            v95.Font = GothamBlack or GothamMedium;
            v95.TextScaled = false;
            v95.TextWrapped = true;
            v95.TextXAlignment = Enum.TextXAlignment.Right;
            v95.TextYAlignment = Enum.TextYAlignment.Center;
        end;
    end;

    local Runner = RankedConfig.Runner;
    local Chaser = RankedConfig.Chaser;
    local v96 = {};

    for _, v in RankedConfig.Tiers do
        table.insert(v96, ("%s %d"):format(v.Name, v.Entry));
    end;

    local v97 = RankedConfig.Tiers[#RankedConfig.Tiers];
    local v98 = 0;

    for i = 1, #RankedConfig.Tiers - 1 do
        v98 = v98 + RankedConfig.Tiers[i].Divisions * RankedConfig.DivisionRP;
        local _ = i;
    end;

    u86 = u86 + 1;
    local v99 = Panels.text(u85, "Heading", "HOW RANKS WORK", 0, 0, 480, u1 and 36 or 30, u3.small, gold or text);
    v99.Font = GothamBlack or GothamMedium;
    v99.TextScaled = false;
    v99.TextWrapped = true;
    v99.TextYAlignment = Enum.TextYAlignment.Bottom;
    v99.LayoutOrder = u86;
    local make = Panels.make;
    local v100 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(480, (u1 and 31 or 26) + 62)
    };
    u86 = u86 + 1;
    v100.LayoutOrder = u86;
    local v101 = make("Frame", u85, "Tiers", v100);
    local v102 = 480 // #RankedConfig.Tiers;

    for i, v in RankedConfig.Tiers do
        local v103 = (i - 1) * v102;
        Panels.make("ImageLabel", v101, v.Name, {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(v103 + (v102 - 58) // 2, 0),
            Size = UDim2.fromOffset(58, 58),
            ScaleType = Enum.ScaleType.Fit,
            Image = RankedConfig.TierIcons[v.Name] or ""
        });
        local v104 = v.Name .. "Name";
        local Name = v.Name;
        local v105 = RankedRanks.color(v.Name);
        local v106 = Panels.text(v101, v104, Name, v103 - 4, 60, v102 + 8, u1 and 31 or 26, u1 and 13 or 11, v105 or text);
        v106.Font = GothamBlack or GothamMedium;
        v106.TextScaled = false;
        v106.TextWrapped = true;
        v106.TextXAlignment = Enum.TextXAlignment.Center;
        v106.TextWrapped = false;
    end;

    local v107 = ("Each tier has 4 divisions, IV to I, of %d RP each. %s has no divisions and starts at %s RP. The top %d %s players this season are Champions, with their place shown by their name."):format(RankedConfig.DivisionRP, v97.Name, comma(v98), RankedConfig.ChampionTop, v97.Name);
    local v108 = Panels.text(u85, "Text", v107, 0, 0, 480, 0, u3.body, textBody or text);
    v108.Font = GothamMedium;
    v108.TextScaled = false;
    v108.TextWrapped = true;
    v108.TextYAlignment = Enum.TextYAlignment.Top;
    v108.AutomaticSize = Enum.AutomaticSize.Y;
    u86 = u86 + 1;
    v108.LayoutOrder = u86;
    local v109 = ("Your first %d matches are placements: your average match points places you, up to %s IV."):format(RankedConfig.Placements, RankedConfig.PlacementCap);
    local v110 = Panels.text(u85, "Text", v109, 0, 0, 480, 0, u3.body, textBody or text);
    v110.Font = GothamMedium;
    v110.TextScaled = false;
    v110.TextWrapped = true;
    v110.TextYAlignment = Enum.TextYAlignment.Top;
    v110.AutomaticSize = Enum.AutomaticSize.Y;
    u86 = u86 + 1;
    v110.LayoutOrder = u86;
    local v111 = ("Losses stop at 0 RP in a division: the first loss there is free, the next drops you a division. After reaching a new tier, you can\'t drop out of it for %d matches."):format(RankedConfig.TierShieldMatches);
    local v112 = Panels.text(u85, "Text", v111, 0, 0, 480, 0, u3.body, textBody or text);
    v112.Font = GothamMedium;
    v112.TextScaled = false;
    v112.TextWrapped = true;
    v112.TextYAlignment = Enum.TextYAlignment.Top;
    v112.AutomaticSize = Enum.AutomaticSize.Y;
    u86 = u86 + 1;
    v112.LayoutOrder = u86;
    local PreSeasonEndsUTC = RankedConfig.PreSeasonEndsUTC;
    local success, result = pcall(function() -- Line: 81
        -- upvalues: PreSeasonEndsUTC (copy)
        return DateTime.fromUnixTimestamp(PreSeasonEndsUTC):FormatLocalTime("MMM D, h:mm A", "en-us");
    end);
    local v113 = ("Seasons: a pre-season until %s, then a new season every month. Each new season, Season 1 included, drops you one tier to division IV (%s to Master I). Rank-up rewards pay once a season; season rewards go by your peak tier."):format(not success and "" or result, v97.Name);
    local v114 = Panels.text(u85, "Text", v113, 0, 0, 480, 0, u3.body, textBody or text);
    v114.Font = GothamMedium;
    v114.TextScaled = false;
    v114.TextWrapped = true;
    v114.TextYAlignment = Enum.TextYAlignment.Top;
    v114.AutomaticSize = Enum.AutomaticSize.Y;
    u86 = u86 + 1;
    v114.LayoutOrder = u86;
    u86 = u86 + 1;
    local v115 = Panels.text(u85, "Heading", "HOW POINTS WORK", 0, 0, 480, u1 and 36 or 30, u3.small, gold or text);
    v115.Font = GothamBlack or GothamMedium;
    v115.TextScaled = false;
    v115.TextWrapped = true;
    v115.TextYAlignment = Enum.TextYAlignment.Bottom;
    v115.LayoutOrder = u86;
    local v116 = ("Every ranked match earns match points. When it ends, your RP changes by your match points minus your tier\'s entry cost: %s."):format(table.concat(v96, ", "));
    local v117 = Panels.text(u85, "Text", v116, 0, 0, 480, 0, u3.body, textBody or text);
    v117.Font = GothamMedium;
    v117.TextScaled = false;
    v117.TextWrapped = true;
    v117.TextYAlignment = Enum.TextYAlignment.Top;
    v117.AutomaticSize = Enum.AutomaticSize.Y;
    u86 = u86 + 1;
    v117.LayoutOrder = u86;
    rows({
        { "Crossing (once a round)", ("%d, +1 per %d chasers (max %d)"):format(Runner.Crossing, Runner.CrossingPerChasers, Runner.CrossingMax) },
        { "Hero crossing", ("%d, +%d per chaser (max %d)"):format(Runner.Hero, Runner.HeroPerChaser, Runner.HeroMax) },
        { "End-event round", ("%d"):format(Runner.EndEventRound) },
        { "Runners win", ("%d"):format(Runner.Win) },
        { "Last 3 caught (chasers win)", ("%d / %d / %d"):format(Runner.LastCaught[1], Runner.LastCaught[2], Runner.LastCaught[3]) },
        { "Catch", ("%d + bounty (max +%d)"):format(Chaser.Catch, Chaser.BountyMax) },
        { "Catch in the end event", ("+%d"):format(Chaser.EndEventCatch) },
        { "Final catch (chasers win)", ("%d"):format(Chaser.FinalCatch) }
    });
    local v118 = ("A hero crossing replaces that round\'s crossing. Bounty: +1 for each crossing the runner made. Catching someone you caught in your last %d matches only pays %d. A runner still in the safe zone %d seconds into a crossing is caught, and nobody gets the points."):format(RankedConfig.RepeatCatchMatches, Chaser.Catch, RankedConfig.LeaveSafeSeconds);
    local v119 = Panels.text(u85, "Text", v118, 0, 0, 480, 0, u3.body, textBody or text);
    v119.Font = GothamMedium;
    v119.TextScaled = false;
    v119.TextWrapped = true;
    v119.TextYAlignment = Enum.TextYAlignment.Top;
    v119.AutomaticSize = Enum.AutomaticSize.Y;
    u86 = u86 + 1;
    v119.LayoutOrder = u86;
    local v120 = Panels.text(u85, "Text", "The starting chaser is scored on the runners\' scale: the best chaser gets what the best runner got, the worst what the worst runner got.", 0, 0, 480, 0, u3.body, textBody or text);
    v120.Font = GothamMedium;
    v120.TextScaled = false;
    v120.TextWrapped = true;
    v120.TextYAlignment = Enum.TextYAlignment.Top;
    v120.AutomaticSize = Enum.AutomaticSize.Y;
    u86 = u86 + 1;
    v120.LayoutOrder = u86;
    local v121 = ("Drafted as chaser because the last one left? That match can\'t lose you RP, but a gain still counts. Leaving mid-match loses the entry cost plus %d RP."):format(RankedConfig.LeaverRP);
    local v122 = Panels.text(u85, "Text", v121, 0, 0, 480, 0, u3.body, textBody or text);
    v122.Font = GothamMedium;
    v122.TextScaled = false;
    v122.TextWrapped = true;
    v122.TextYAlignment = Enum.TextYAlignment.Top;
    v122.AutomaticSize = Enum.AutomaticSize.Y;
    u86 = u86 + 1;
    v122.LayoutOrder = u86;
    u86 = u86 + 1;
    local v123 = Panels.text(u85, "Heading", "HOW QUEUING WORKS", 0, 0, 480, u1 and 36 or 30, u3.small, gold or text);
    v123.Font = GothamBlack or GothamMedium;
    v123.TextScaled = false;
    v123.TextWrapped = true;
    v123.TextYAlignment = Enum.TextYAlignment.Bottom;
    v123.LayoutOrder = u86;
    local v124 = ("Ranked is solo queue for level %d+ accounts at least %d days old, from a public server. Press QUEUE to search every server for players within one tier of you. The search widens by a tier every %d seconds you wait. Master and Grandmaster queue together."):format(RankedConfig.MinLevel, RankedConfig.AccountAgeDays, RankedConfig.BandWidenSeconds);
    local v125 = Panels.text(u85, "Text", v124, 0, 0, 480, 0, u3.body, textBody or text);
    v125.Font = GothamMedium;
    v125.TextScaled = false;
    v125.TextWrapped = true;
    v125.TextYAlignment = Enum.TextYAlignment.Top;
    v125.AutomaticSize = Enum.AutomaticSize.Y;
    u86 = u86 + 1;
    v125.LayoutOrder = u86;
    local v126 = ("A match is %d players, or %d once someone has waited %d seconds. While queued you sit out this server\'s matches, and you can cancel any time."):format(RankedConfig.LobbySize, RankedConfig.MinLobby, RankedConfig.QueueFillSeconds);
    local v127 = Panels.text(u85, "Text", v126, 0, 0, 480, 0, u3.body, textBody or text);
    v127.Font = GothamMedium;
    v127.TextScaled = false;
    v127.TextWrapped = true;
    v127.TextYAlignment = Enum.TextYAlignment.Top;
    v127.AutomaticSize = Enum.AutomaticSize.Y;
    u86 = u86 + 1;
    v127.LayoutOrder = u86;
    local v128 = ("When a match is found, you\'re teleported to a ranked server with no bots. It starts once everyone arrives (at most %d seconds). Afterwards, QUEUE AGAIN or go back to the lobby. You\'re sent back on your own after %d seconds."):format(RankedConfig.ArriveSeconds, RankedConfig.AfterMatchSeconds);
    local v129 = Panels.text(u85, "Text", v128, 0, 0, 480, 0, u3.body, textBody or text);
    v129.Font = GothamMedium;
    v129.TextScaled = false;
    v129.TextWrapped = true;
    v129.TextYAlignment = Enum.TextYAlignment.Top;
    v129.AutomaticSize = Enum.AutomaticSize.Y;
    u86 = u86 + 1;
    v129.LayoutOrder = u86;
end;

local v130 = Panels.make("Frame", v25, "Footer", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(20, 384),
    Size = UDim2.fromOffset(840, 80)
});
Skin.footer(v130, {
    transparency = 0.2,
    radius = UDim.new(0, 10)
});
local u131 = Panels.text(v130, "Status", "", 18, 0, 498, 80, u3.body, text or text);
u131.Font = GothamBold or GothamMedium;
u131.TextScaled = false;
u131.TextWrapped = true;
u131.TextYAlignment = Enum.TextYAlignment.Center;
local u132 = Panels.button(v130, "Queue", "QUEUE", 528, 12, 300, 56);
local u133 = Panels.button(v130, "Lobby", "BACK TO LOBBY", 296, 12, 220, 56);
local body = u3.body;
Skin.button(u133, "secondary", {
    shimmer = false
});
u133.Font = GothamBlack;
u133.TextScaled = false;
u133.TextSize = body;
u133.TextColor3 = text;
u133.Visible = false;
local u134 = Panels.make("TextButton", u23, "QueuePill", {
    Text = "",
    AutoButtonColor = false,
    BorderSizePixel = 0,
    Visible = false,
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 64),
    Size = UDim2.fromOffset(u1 and 456 or 380, u1 and 55 or 46)
});
Skin.pill(u134, nil, {
    shimmer = false
});
local u135 = Panels.text(u134, "Text", "", 12, 0, (u1 and 456 or 380) - 24, u1 and 55 or 46, u3.body, text or text);
u135.Font = GothamBlack or GothamMedium;
u135.TextScaled = false;
u135.TextWrapped = true;
u135.TextXAlignment = Enum.TextXAlignment.Center;
u135.TextYAlignment = Enum.TextYAlignment.Center;
local u136 = nil;

local function serverNow() -- Line: 338
    return workspace:GetServerTimeNow();
end;

local function renderSeason() -- Line: 342
    -- upvalues: u4 (ref), RankedRanks (copy), u29 (copy), u30 (copy), span (copy), u53 (copy), u54 (copy), RankedConfig (copy), u55 (copy), u56 (copy)
    local v137;

    if u4 and u4.season then
        v137 = u4.season;
    else
        v137 = RankedRanks.season(os.time());
    end;

    local u138;

    if u4 and u4.endsAt then
        u138 = u4.endsAt;
    else
        u138 = RankedRanks.seasonEnds(os.time());
    end;

    local v139 = u138 - os.time();
    u29.Text = RankedRanks.seasonName(v137);
    u30.Text = "Ends in " .. span(v139);
    u53.Text = RankedRanks.seasonName(v137);
    local v140 = span(v139);
    local success, result = pcall(function() -- Line: 81
        -- upvalues: u138 (copy)
        return DateTime.fromUnixTimestamp(u138):FormatLocalTime("MMM D, h:mm A", "en-us");
    end);
    u54.Text = ("Ends in %s  (%s)"):format(v140, not success and "" or result);
    local v141 = u4;

    if v141 then
        local v142 = { ("%d ranked match%s played"):format(v141.matches, v141.matches == 1 and "" or "es") };

        if v141.peak > 0 and RankedConfig.Tiers[v141.peak] then
            table.insert(v142, "Peak: " .. RankedConfig.Tiers[v141.peak].Name);
        end;

        u55.Text = table.concat(v142, "   |   ");
    else
        u55.Text = "";
    end;

    if RankedRanks.numbered(v137) then
        local success2, result2 = pcall(function() -- Line: 81
            -- upvalues: u138 (copy)
            return DateTime.fromUnixTimestamp(u138):FormatLocalTime("MMM D, h:mm A", "en-us");
        end);
        u56.Text = ("When this season ends you drop one tier into division IV, and your peak tier pays its season reward (see REWARDS). The next season starts %s."):format(not success2 and "" or result2);

        return;
    end;

    local success2, result2 = pcall(function() -- Line: 81
        -- upvalues: u138 (copy)
        return DateTime.fromUnixTimestamp(u138):FormatLocalTime("MMM D, h:mm A", "en-us");
    end);
    u56.Text = ("The pre-season counts: play, rank up and earn rank-up rewards now. Season 1 starts %s, and the seasons run monthly from then. When it starts you drop one tier into division IV, and your pre-season peak tier pays its season reward."):format(not success2 and "" or result2);
end;

local function renderRank() -- Line: 367
    -- upvalues: u4 (ref), Skin (copy), u31 (copy), u32 (copy), u33 (copy), u34 (copy), text (copy), u35 (copy), u37 (copy), u38 (copy), RankedRanks (copy), RankedConfig (copy), comma (copy), LocalPlayer (copy), u77 (copy), u78 (copy), renderSeason (copy)
    local v143 = u4;

    if not v143 then
        Skin.card(u31, nil);
        u32.Visible = false;
        u33.Visible = false;
        u34.Text = "LOADING...";
        u34.TextColor3 = text;
        u35.Text = "";
        u37.Size = UDim2.fromScale(0, 1);
        u38.Text = "";

        return;
    end;

    local v144 = RankedRanks.color(v143.name);
    local v145;

    if v143.placing then
        v145 = nil;
    else
        v145 = v144;
    end;

    Skin.card(u31, v145);
    u32.Visible = not v143.placing;
    u33.Visible = v143.placing == true;
    u32.Image = RankedConfig.TierIcons[v143.name] or "";

    if v143.placing then
        u34.Text = "PLACEMENTS";
        u34.TextColor3 = text;
        u35.Text = ("%d / %d matches played"):format(v143.placed, RankedConfig.Placements);
        u37.Size = UDim2.fromScale(v143.placed / RankedConfig.Placements, 1);
        u38.Text = ("Your average match points over %d matches places you, up to %s IV."):format(RankedConfig.Placements, RankedConfig.PlacementCap);
    else
        u34.Text = (v143.name .. (v143.division <= 0 and "" or " " .. v143.divisionName)):upper();
        u34.TextColor3 = v144;

        if v143.span > 0 then
            u35.Text = ("%d / %d RP"):format(v143.into, v143.span);
            u37.Size = UDim2.fromScale(math.clamp(v143.into / v143.span, 0, 1), 1);
        else
            u35.Text = comma(v143.into) .. " RP above Grandmaster";
            u37.Size = UDim2.fromScale(1, 1);
        end;

        local v146 = {};
        local Attribute = LocalPlayer:GetAttribute("RankChampion");

        if type(Attribute) == "number" then
            table.insert(v146, ("CHAMPION #%d"):format(Attribute));
        end;

        table.insert(v146, ("Entry cost: %d RP a match"):format(v143.entry));

        if v143.guard > 0 then
            table.insert(v146, ("Tier shield: %d match%s left"):format(v143.guard, v143.guard == 1 and "" or "es"));
        elseif v143.shield then
            table.insert(v146, "Division shield used");
        end;

        u38.Text = table.concat(v146, "\n");
    end;

    for i, v in u77 do
        v.Text = v143.paid["T:" .. i] and "PAID" or "";
    end;

    for i, v in u78 do
        local v147 = v143.peak == i;
        local card = Skin.card;
        local row = v.row;
        local v148;

        if v147 then
            v148 = RankedRanks.color(RankedConfig.Tiers[i].Name);
        else
            v148 = nil;
        end;

        card(row, v148, {
            radius = UDim.new(0, 8)
        });
        v.tag.Text = v147 and "YOUR PEAK" or "";
    end;

    renderSeason();
end;

local function renderFooter() -- Line: 426
    -- upvalues: u44 (ref), u133 (copy), u131 (copy), u132 (copy), u3 (copy), Skin (copy), GothamBlack (copy), text (copy), RankedConfig (copy), clock (copy), gold (copy)
    local v149 = u44;
    local v150 = v149.rankedServer and v149.done;
    u133.Visible = v150 == true;
    u131.Size = UDim2.fromOffset((not v150 and 528 or u133.Position.X.Offset) - 30, 80);

    if v149.going then
        u132.Text = "TELEPORTING...";
        local v151 = u132;
        local button = u3.button;
        Skin.button(v151, "dark", {
            shimmer = false
        });
        v151.Font = GothamBlack;
        v151.TextScaled = false;
        v151.TextSize = button;
        v151.TextColor3 = text;
    elseif v149.queued then
        u132.Text = "CANCEL";
        local v152 = u132;
        local button = u3.button;
        Skin.button(v152, "secondary", {
            shimmer = false
        });
        v152.Font = GothamBlack;
        v152.TextScaled = false;
        v152.TextSize = button;
        v152.TextColor3 = text;
    else
        u132.Text = v149.reason and "LOCKED" or (v150 and "QUEUE AGAIN" or "QUEUE");
        local v153 = u132;
        local button = u3.button;
        Skin.button(v153, v149.reason and "dark" or "primary", {
            shimmer = false
        });
        v153.Font = GothamBlack;
        v153.TextScaled = false;
        v153.TextSize = button;
        v153.TextColor3 = text;
    end;

    local v154;

    if v149.going then
        v154 = "Match found! Teleporting...";
    elseif v149.queued then
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v155 = v149.since or workspace:GetServerTimeNow();
        local math_floor_ret = math.floor(ServerTimeNow - v155);
        local math_max_ret = math.max(0, math_floor_ret);
        v154 = ("Searching %s   |   %d in queue\n%d-%d players a match"):format(("%d:%02d"):format(math_max_ret // 60, math_max_ret % 60), v149.count or 1, RankedConfig.MinLobby, RankedConfig.LobbySize);
    elseif v149.message then
        v154 = v149.message;
    elseif v149.reason then
        v154 = v149.reason;
    elseif v150 and v149.leaveAt then
        v154 = ("Back to the lobby in %s unless you queue again."):format(clock(v149.leaveAt - workspace:GetServerTimeNow()));
    else
        v154 = ("Solo queue   |   %d-%d players   |   Level %d+"):format(RankedConfig.MinLobby, RankedConfig.LobbySize, RankedConfig.MinLevel);
    end;

    u131.Text = v154;
    local v156;

    if v149.going or v149.queued then
        v156 = gold;
    else
        v156 = text;
    end;

    u131.TextColor3 = v156;
end;

local function renderPill() -- Line: 459
    -- upvalues: u136 (ref), u134 (copy), u135 (copy), u44 (ref), u24 (copy)
    if u136 and os.clock() < u136.untilAt then
        u134.Visible = true;
        u135.Text = u136.text;

        return;
    end;

    local v157;

    if (u44.queued or u44.going) == true then
        v157 = not u24.Visible;
    else
        v157 = false;
    end;

    u134.Visible = v157;

    if u134.Visible then
        local v158;

        if u44.going then
            v158 = "RANKED: MATCH FOUND!";
        else
            local ServerTimeNow = workspace:GetServerTimeNow();
            local v159 = u44.since or workspace:GetServerTimeNow();
            local math_floor_ret = math.floor(ServerTimeNow - v159);
            local math_max_ret = math.max(0, math_floor_ret);
            v158 = ("RANKED QUEUE  %s  |  %d searching"):format(("%d:%02d"):format(math_max_ret // 60, math_max_ret % 60), u44.count or 1);
        end;

        u135.Text = v158;
    end;
end;

local function showTab(p160) -- Line: 473
    -- upvalues: u50 (ref), u85 (ref), buildHelp (copy), u52 (copy), u63 (copy), u40 (copy), Skin (copy), GothamBlack (copy), u3 (copy), text (copy)
    u50 = p160;

    if p160 == "Help" and not u85 then
        buildHelp();
    end;

    u52.Visible = p160 == "Season";
    u63.Visible = p160 == "Rewards";

    if u85 then
        u85.Visible = p160 == "Help";
    end;

    for i, v in u40 do
        Skin.tab(v, i == p160, {
            shimmer = false
        });
        v.Font = GothamBlack;
        v.TextScaled = false;
        v.TextSize = u3.tab;
        v.TextColor3 = text;
    end;
end;

showTab("Season");

for i, v in u40 do
    v.Activated:Connect(function() -- Line: 493
        -- upvalues: showTab (copy), i (copy)
        showTab(i);
    end);
end;

local function setOpen(p161) -- Line: 498
    -- upvalues: u24 (copy), HudNavigation (copy), ArmoryEvent (copy), RankedRemote (copy), renderRank (copy), renderSeason (copy), renderFooter (copy), renderPill (copy)
    u24.Visible = p161;

    if p161 then
        HudNavigation.opening("Ranked");
        ArmoryEvent:FireServer("Get");
        RankedRemote:FireServer("Open");
        renderRank();
        renderSeason();
        renderFooter();
    end;

    renderPill();
end;

local function open() -- Line: 510
    -- upvalues: LocalPlayer (copy), u24 (copy), HudNavigation (copy), ArmoryEvent (copy), RankedRemote (copy), renderRank (copy), renderSeason (copy), renderFooter (copy), renderPill (copy)
    if LocalPlayer:GetAttribute("InMatch") == true then
        return;
    end;

    u24.Visible = true;
    HudNavigation.opening("Ranked");
    ArmoryEvent:FireServer("Get");
    RankedRemote:FireServer("Open");
    renderRank();
    renderSeason();
    renderFooter();
    renderPill();
end;

v26.Activated:Connect(function() -- Line: 516
    -- upvalues: u24 (copy), renderPill (copy)
    u24.Visible = false;
    renderPill();
end);
u134.Activated:Connect(open);
u132.Activated:Connect(function() -- Line: 520
    -- upvalues: u44 (ref), RankedRemote (copy)
    if u44.going then
        return;
    end;

    RankedRemote:FireServer(u44.queued and "Cancel" or "Queue");
end);
u133.Activated:Connect(function() -- Line: 526
    -- upvalues: RankedRemote (copy)
    RankedRemote:FireServer("Lobby");
end);
HudNavigation.Opening.Event:Connect(function(p162) -- Line: 529
    -- upvalues: u24 (copy), renderPill (copy)
    if p162 ~= "Ranked" and u24.Visible then
        u24.Visible = false;
        renderPill();
    end;
end);
LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 534
    -- upvalues: LocalPlayer (copy), u24 (copy), renderPill (copy)
    if LocalPlayer:GetAttribute("InMatch") == true and u24.Visible then
        u24.Visible = false;
        renderPill();
    end;
end);
LocalPlayer:GetAttributeChangedSignal("RankChampion"):Connect(function() -- Line: 539
    -- upvalues: u24 (copy), renderRank (copy)
    if u24.Visible then
        renderRank();
    end;
end);
local v163 = u1 and 264 or 220;
local u164 = u1 and 74 or 62;
local u165 = Panels.make("Frame", u23, "MatchPoints", {
    BorderSizePixel = 0,
    Visible = false,
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -16, 0, 120),
    Size = UDim2.fromOffset(v163, u164)
});
Skin.pill(u165, nil, {
    shimmer = false
});
local v166 = Panels.text(u165, "Title", "MATCH POINTS", 14, 6, v163 - 28, u1 and 22 or 18, u3.small, gold or text);
v166.Font = GothamBlack or GothamMedium;
v166.TextScaled = false;
v166.TextWrapped = true;
local u167 = Panels.text(u165, "Value", "0", 14, 6 + (u1 and 22 or 18), v163 - 28, u164 - 12 - (u1 and 22 or 18), u1 and 34 or 28, text or text);
u167.Font = GothamBlack or GothamMedium;
u167.TextScaled = false;
u167.TextWrapped = true;
LocalPlayer:GetAttributeChangedSignal("RankedPoints"):Connect(function() -- Line: 557, Name: renderLive
    -- upvalues: LocalPlayer (copy), u165 (copy), u167 (copy), comma (copy)
    local Attribute = LocalPlayer:GetAttribute("RankedPoints");
    u165.Visible = type(Attribute) == "number";

    if u165.Visible then
        u167.Text = comma(Attribute);
    end;
end);
local u168 = 0;

local function popup(p169) -- Line: 566
    -- upvalues: u168 (ref), u23 (copy), u1 (copy), u3 (copy), green (copy), GothamBlack (copy), Panels (copy), text (copy), GothamMedium (copy), u164 (copy), TweenService (copy)
    u168 = u168 + 1;
    local u170 = Panels.text(u23, "PointPopup", p169, 0, 0, u1 and 336 or 280, u1 and 31 or 26, u3.body, green or text);
    u170.Font = GothamBlack or GothamMedium;
    u170.TextScaled = false;
    u170.TextWrapped = true;
    u170.TextXAlignment = Enum.TextXAlignment.Right;
    u170.AnchorPoint = Vector2.new(1, 0);
    u170.Position = UDim2.new(1, -18, 0, 120 + u164 + 8 + (u168 - 1) % 3 * (u1 and 31 or 26));
    TweenService:Create(u170, TweenInfo.new(1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.9), {
        TextTransparency = 1,
        Position = u170.Position - UDim2.fromOffset(0, 18)
    }):Play();
    task.delay(2.6, function() -- Line: 575
        -- upvalues: u170 (copy), u168 (ref)
        u170:Destroy();
        u168 = math.max(0, u168 - 1);
    end);
end;

local u171 = u1 and 29 or 24;
local math_floor_ret = math.floor(174 / u171);
local u172, v173, v174 = Panels.panel(u23, "RankedResultPanel", 600, 500);
local v175 = Panels.make("Frame", v173, "Header", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(20, 14),
    Size = UDim2.fromOffset(500, 58)
});
Skin.header(v175, {
    decoration = false,
    transparency = 0.2
});
local v176 = Panels.text(v175, "Title", "RANKED RESULT", 18, 0, 464, 58, u3.title - 4, text or text);
v176.Font = GothamBlack or GothamMedium;
v176.TextScaled = false;
v176.TextWrapped = true;
v176.TextYAlignment = Enum.TextYAlignment.Center;
local u177 = Panels.make("Frame", v173, "Lines", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(24, 84),
    Size = UDim2.fromOffset(552, 174)
});
Panels.make("UIListLayout", u177, "Layout", {
    SortOrder = Enum.SortOrder.LayoutOrder
});
local u178 = Panels.make("Frame", v173, "Totals", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(20, 266),
    Size = UDim2.fromOffset(560, 92)
});
Skin.card(u178, nil);

local function totalRow(p179, p180) -- Line: 593
    -- upvalues: u178 (copy), u3 (copy), textBody (copy), GothamBold (copy), Panels (copy), text (copy), GothamMedium (copy), GothamBlack (copy)
    local v181 = Panels.text(u178, p179 .. "Label", "", 16, p180, 300, 28, u3.body, textBody or text);
    v181.Font = GothamBold or GothamMedium;
    v181.TextScaled = false;
    v181.TextWrapped = true;
    v181.TextYAlignment = Enum.TextYAlignment.Center;
    local v182 = Panels.text(u178, p179 .. "Value", "", 324, p180, 220, 28, u3.head, text or text);
    v182.Font = GothamBlack or GothamMedium;
    v182.TextScaled = false;
    v182.TextWrapped = true;
    v182.TextXAlignment = Enum.TextXAlignment.Right;
    v182.TextYAlignment = Enum.TextYAlignment.Center;

    return v181, v182;
end;

local u183, u184 = totalRow("Points", 4);
local u185, u186 = totalRow("Entry", 32);
local u187, u188 = totalRow("Change", 60);
local u189 = Panels.text(v173, "Rank", "", 20, 366, 560, 34, u3.big, text or text);
u189.Font = GothamBlack or GothamMedium;
u189.TextScaled = false;
u189.TextWrapped = true;
u189.TextXAlignment = Enum.TextXAlignment.Center;
u189.TextYAlignment = Enum.TextYAlignment.Center;
local u190 = Panels.make("Frame", v173, "Track", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(40, 404),
    Size = UDim2.fromOffset(520, 12)
});
local u191 = Panels.make("Frame", u190, "Fill", {
    BorderSizePixel = 0,
    Size = UDim2.fromScale(0, 1)
});
Skin.bar(u190, u191, "gold");
local u192 = Panels.text(v173, "Note", "", 20, 422, 560, 36, u3.small, gold or text);
u192.Font = GothamBold or GothamMedium;
u192.TextScaled = false;
u192.TextWrapped = true;
u192.TextXAlignment = Enum.TextXAlignment.Center;
u192.TextYAlignment = Enum.TextYAlignment.Top;
local v193 = Panels.button(v173, "Continue", "CONTINUE", 190, 448, 220, 42);
local head = u3.head;
Skin.button(v193, "primary", {
    shimmer = false
});
v193.Font = GothamBlack;
v193.TextScaled = false;
v193.TextSize = head;
v193.TextColor3 = text;

local function closeResult() -- Line: 608
    -- upvalues: u172 (copy), LocalPlayer (copy)
    u172.Visible = false;
    LocalPlayer:SetAttribute("RankedResultOpen", nil);
end;

v174.Activated:Connect(closeResult);
v193.Activated:Connect(closeResult);

local function resultLine(p194, p195, p196) -- Line: 615
    -- upvalues: Panels (copy), u177 (copy), u171 (copy), u3 (copy), textBody (copy), GothamBold (copy), text (copy), GothamMedium (copy), comma (copy), GothamBlack (copy)
    local v197 = Panels.make("Frame", u177, "Line" .. p194, {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, u171),
        LayoutOrder = p194
    });
    local v198 = Panels.text(v197, "Label", p195, 4, 0, 420, u171, u3.body, textBody or text);
    v198.Font = GothamBold or GothamMedium;
    v198.TextScaled = false;
    v198.TextWrapped = true;
    v198.TextYAlignment = Enum.TextYAlignment.Center;
    local v199 = (p196 > 0 and "+" or "") .. comma(p196);
    local v200 = Panels.text(v197, "Pts", v199, 420, 0, 124, u171, u3.body, text or text);
    v200.Font = GothamBlack or GothamMedium;
    v200.TextScaled = false;
    v200.TextWrapped = true;
    v200.TextXAlignment = Enum.TextXAlignment.Right;
    v200.TextYAlignment = Enum.TextYAlignment.Center;
end;

local function showResult(p201) -- Line: 621
    -- upvalues: u177 (copy), math_floor_ret (copy), resultLine (copy), u171 (copy), u3 (copy), textBody (copy), GothamBold (copy), Panels (copy), text (copy), GothamMedium (copy), u183 (copy), u184 (copy), comma (copy), RankedRanks (copy), u185 (copy), u186 (copy), u187 (copy), u188 (copy), u192 (copy), RankedConfig (copy), gold (copy), green (copy), Palette (copy), u189 (copy), u190 (copy), u191 (copy), ChickenOrHero (copy), LocalPlayer (copy), u24 (copy), renderPill (copy), HudNavigation (copy), u172 (copy)
    for _, child in u177:GetChildren() do
        if child:IsA("GuiObject") then
            child:Destroy();
        end;
    end;

    local v202 = p201.lines or {};
    local v203 = 0;

    for i, v in v202 do
        local v204 = tonumber(v.pts) or 0;

        if i < math_floor_ret or i == math_floor_ret and #v202 == math_floor_ret then
            resultLine(i, tostring(v.label) .. ((v.n or 0) <= 1 and "" or ("  x%d"):format(v.n)), v204);
        else
            v203 = v203 + v204;
        end;
    end;

    if math_floor_ret < #v202 then
        resultLine(math_floor_ret, "Other", v203);
    end;

    if #v202 == 0 then
        local v205 = Panels.text(u177, "None", "No points this match.", 4, 0, 540, u171, u3.body, textBody or text);
        v205.Font = GothamBold or GothamMedium;
        v205.TextScaled = false;
        v205.TextWrapped = true;
        v205.TextYAlignment = Enum.TextYAlignment.Center;
    end;

    u183.Text = "MATCH POINTS";
    u184.Text = comma(p201.points or 0);
    u184.TextColor3 = text;
    local v206 = tonumber(p201.after);

    if v206 then
        v206 = RankedRanks.place(v206);
    end;

    if p201.saved then
        if p201.result == "RankedPlacement" then
            u185.Text = "";
            u186.Text = "";
            u187.Text = "PLACEMENT";
            u188.Text = ("%d / %d"):format(tonumber(p201.placed) or 0, RankedConfig.Placements);
            u188.TextColor3 = gold;
            local v207 = RankedConfig.Placements - (tonumber(p201.placed) or 0);
            u192.Text = ("%d more match%s to place you."):format(v207, v207 == 1 and "" or "es");
        else
            local v208 = tonumber(p201.change) or 0;
            local v209 = p201.result == "RankedPlaced";
            u185.Text = v209 and "" or "ENTRY COST";
            u186.Text = v209 and "" or ("-%d"):format(tonumber(p201.entry) or 0);
            u186.TextColor3 = text;
            u187.Text = v209 and "PLACED" or "RP CHANGE";
            local v210;

            if v209 then
                v210 = RankedRanks.label(v206):upper();
            else
                v210 = (v208 >= 0 and "+" or "") .. comma(v208);
            end;

            u188.Text = v210;
            local v211;

            if v209 then
                v211 = RankedRanks.color(v206.name);
            elseif v208 >= 0 then
                v211 = green;
            else
                v211 = Palette.danger;
            end;

            u188.TextColor3 = v211;
            local v212 = {};

            for _, v in p201.ranks or {} do
                table.insert(v212, "RANKED UP: " .. v);
            end;

            if (tonumber(p201.coins) or 0) > 0 then
                local v213 = comma(p201.coins);
                table.insert(v212, ("+%s coins"):format(v213));
            end;

            if p201.starter then
                table.insert(v212, "Starting chaser: scored like a runner who did as well");
            end;

            if p201.drafted then
                table.insert(v212, "Drafted as chaser: no RP lost this match");
            end;

            u192.Text = table.concat(v212, "   |   ");
        end;
    else
        u185.Text = "";
        u186.Text = "";
        u187.Text = "RP";
        u188.Text = "NOT SAVED";
        u188.TextColor3 = textBody;
        u192.Text = "Your result couldn\'t be saved yet. It will be when the save goes through.";
    end;

    if v206 and p201.result ~= "RankedPlacement" then
        u189.Text = RankedRanks.label(v206):upper();
        u189.TextColor3 = RankedRanks.color(v206.name);
        u190.Visible = true;
        u191.Size = UDim2.fromScale(not v206.span and 1 or math.clamp(v206.into / v206.span, 0, 1), 1);
    else
        u189.Text = p201.result == "RankedPlacement" and "PLACEMENTS" or "";
        u189.TextColor3 = text;
        u190.Visible = false;
    end;

    local Session = ChickenOrHero.Game:FindFirstChild("Session");
    local v214 = os.clock() + 45;
    task.wait(1);

    while (LocalPlayer:GetAttribute("MatchSummaryVisible") == true or Session and Session:GetAttribute("Phase") == "Results") and os.clock() < v214 do
        task.wait(0.5);
    end;

    if u24.Visible then
        u24.Visible = false;
        renderPill();
    end;

    LocalPlayer:SetAttribute("RankedResultOpen", true);
    HudNavigation.opening("RankedResult");
    u172.Visible = true;
end;

RankedRemote.OnClientEvent:Connect(function(p215, p216) -- Line: 712
    -- upvalues: u44 (ref), renderFooter (copy), renderPill (copy), u24 (copy), LocalPlayer (copy), HudNavigation (copy), ArmoryEvent (copy), RankedRemote (copy), renderRank (copy), renderSeason (copy), popup (copy), showResult (copy), u136 (ref), RankedRanks (copy), comma (copy)
    if p215 == "State" and type(p216) == "table" then
        local v217 = u44.rankedServer and u44.done;
        u44 = p216;
        renderFooter();
        renderPill();

        if p216.rankedServer and (p216.done and not (v217 or u24.Visible)) then
            task.spawn(function() -- Line: 720
                -- upvalues: LocalPlayer (ref), u24 (ref), HudNavigation (ref), ArmoryEvent (ref), RankedRemote (ref), renderRank (ref), renderSeason (ref), renderFooter (ref), renderPill (ref)
                local v218 = os.clock() + 30;

                while (LocalPlayer:GetAttribute("MatchSummaryVisible") == true or LocalPlayer:GetAttribute("RankedResultOpen") == true) and os.clock() < v218 do
                    task.wait(0.5);
                end;

                if LocalPlayer:GetAttribute("InMatch") == true then
                    return;
                end;

                u24.Visible = true;
                HudNavigation.opening("Ranked");
                ArmoryEvent:FireServer("Get");
                RankedRemote:FireServer("Open");
                renderRank();
                renderSeason();
                renderFooter();
                renderPill();
            end);
        end;
    else
        if p215 == "Found" then
            u44.queued = false;
            u44.going = true;
            renderFooter();
            renderPill();

            return;
        end;

        if p215 == "Going" then
            u44.going = true;
            renderFooter();
            renderPill();

            return;
        end;

        if p215 == "Point" and type(p216) == "table" then
            popup(("+%d %s"):format(tonumber(p216.pts) or 0, (tostring(p216.label or ""))));

            return;
        end;

        if p215 == "Result" and type(p216) == "table" then
            task.spawn(showResult, p216);

            return;
        end;

        if p215 == "SeasonReward" and type(p216) == "table" then
            u136 = {
                text = ("%s REWARD: +%s coins"):format(RankedRanks.seasonName(p216.season), (comma(tonumber(p216.coins) or 0))),
                untilAt = os.clock() + 10
            };
            renderPill();
        end;
    end;
end);
ArmoryEvent.OnClientEvent:Connect(function(p219, p220) -- Line: 748
    -- upvalues: u4 (ref), u24 (copy), renderRank (copy)
    if p219 == "State" and (type(p220) == "table" and type(p220.ranked) == "table") then
        u4 = p220.ranked;

        if u24.Visible then
            renderRank();
        end;
    end;
end);
local u221 = nil;
local u222 = nil;

local function standStatus() -- Line: 759
    -- upvalues: u221 (ref), LocalPlayer (copy), RankedConfig (copy), u4 (ref)
    local v223 = u221 and u221:FindFirstChild("Status", true);

    if not (v223 and v223:IsA("TextLabel")) then
        return;
    end;

    if (tonumber(LocalPlayer:GetAttribute("Level")) or 0) < RankedConfig.MinLevel then
        v223.Text = ("Level %d+"):format(RankedConfig.MinLevel);

        return;
    end;

    if u4 and not u4.placing then
        v223.Text = u4.name .. (u4.division <= 0 and "" or " " .. u4.divisionName);

        return;
    end;

    v223.Text = "Play ranked";
end;

local function found(p224) -- Line: 772
    -- upvalues: u221 (ref), u222 (ref), open (copy), standStatus (copy)
    if p224.Name ~= "RankedStand" or not p224:IsA("Model") then
        return;
    end;

    u221 = p224;

    if u222 then
        u222:Disconnect();
    end;

    local Base = p224:WaitForChild("Base", 10);

    if Base then
        Base = Base:FindFirstChild("RankedPrompt", true);
    end;

    if Base and u221 == p224 then
        u222 = Base.Triggered:Connect(open);
    end;

    standStatus();
end;

local v225 = MapLocator.interactables(10);
v225.ChildAdded:Connect(found);
v225.ChildRemoved:Connect(function(p226) -- Line: 789
    -- upvalues: u221 (ref), u222 (ref)
    if p226 == u221 then
        u221 = nil;

        if u222 then
            u222:Disconnect();
            u222 = nil;
        end;
    end;
end);
local RankedStand = v225:FindFirstChild("RankedStand");

if RankedStand then
    task.spawn(found, RankedStand);
end;

LocalPlayer:GetAttributeChangedSignal("Level"):Connect(standStatus);
renderSeason();
task.spawn(function() -- Line: 806
    -- upvalues: u24 (copy), renderFooter (copy), renderSeason (copy), renderPill (copy), standStatus (copy)
    while true do
        task.wait(1);

        if u24.Visible then
            renderFooter();
            renderSeason();
        end;

        renderPill();
        standStatus();
    end;
end);
RankedRemote:FireServer("Open");
ArmoryEvent:FireServer("Get");