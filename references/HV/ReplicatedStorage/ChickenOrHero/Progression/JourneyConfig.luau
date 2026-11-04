 

 

local JourneySeasons = require(script.Parent.JourneySeasons);
local v1 = JourneySeasons.Seasons[JourneySeasons.ActiveSeason];
local u2 = {
    Enabled = true,
    Visible = true,
    Name = "VALLEY JOURNEY",
    RebirthProductId = 3717354092,
    RebirthCoins = 5000,
    SeasonId = JourneySeasons.ActiveSeason,
    SeasonNumber = v1.Number,
    SeasonName = v1.Name,
    TrackId = v1.TrackId,
    PremiumPassId = v1.PremiumPassId,
    MaxTier = v1.MaxTier,
    MaxLevel = v1.MaxTier,
    FirstTierXP = v1.FirstTierXP,
    TierStepXP = v1.TierStepXP,
    EndsAt = v1.EndsAt or 0,
    PurchasesEnabledUniverses = {
        [10764627709] = true,
        [10768621983] = true
    },
    Badges = {
        FirstSteps = {
            Name = "FIRST STEPS",
            Icon = "I",
            Color = Color3.fromRGB(123, 199, 217)
        },
        QuickFeet = {
            Name = "QUICK FEET",
            Icon = "II",
            Color = Color3.fromRGB(107, 214, 176)
        },
        CornerArtist = {
            Name = "CORNER ARTIST",
            Icon = "III",
            Color = Color3.fromRGB(114, 176, 242)
        },
        Untouchable = {
            Name = "UNTOUCHABLE",
            Icon = "IV",
            Color = Color3.fromRGB(179, 145, 234)
        },
        ValleyVeteran = {
            Name = "VALLEY VETERAN",
            Icon = "V",
            Color = Color3.fromRGB(227, 188, 116)
        },
        ValleyElite = {
            Name = "VALLEY ELITE",
            Icon = "VI",
            Color = Color3.fromRGB(247, 214, 133)
        },
        NightRunner = {
            Name = "NIGHT RUNNER",
            Icon = "🌑",
            Color = Color3.fromRGB(196, 157, 255)
        },
        CrownChaser = {
            Name = "CROWN CHASER",
            Icon = "👑",
            Color = Color3.fromRGB(244, 207, 119)
        },
        ValleyRoyalty = {
            Name = "VALLEY ROYALTY",
            Icon = "👑",
            Color = Color3.fromRGB(249, 199, 145)
        },
        First = {
            Name = "FIRST",
            Icon = "1",
            Color = Color3.fromRGB(255, 172, 72)
        },
        PatientZero = {
            Name = "PATIENT ZERO",
            Icon = "☣",
            Hidden = true,
            Event = "Outbreak2026",
            Color = Color3.fromRGB(140, 255, 90)
        },
        PlagueBearer = {
            Name = "PLAGUE BEARER",
            Icon = "☣",
            Hidden = true,
            Event = "Outbreak2026",
            Color = Color3.fromRGB(110, 220, 70)
        },
        HeadlessHorseman = {
            Name = "HEADLESS HORSEMAN",
            Icon = "🎃",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(255, 132, 28)
        },
        CandyCollector = {
            Name = "CANDY COLLECTOR",
            Icon = "🍬",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(255, 120, 200)
        },
        Boo = {
            Name = "BOO!",
            Icon = "👻",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(235, 235, 255)
        },
        Cobweb = {
            Name = "COBWEB",
            Icon = "🕸",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(200, 200, 215)
        },
        BatOutOfHell = {
            Name = "BAT OUT OF HELL",
            Icon = "🦇",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(150, 90, 210)
        },
        MonsterMash = {
            Name = "MONSTER MASH",
            Icon = "🧟",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(120, 220, 110)
        },
        GraveRobber = {
            Name = "GRAVE ROBBER",
            Icon = "⚰️",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(160, 170, 180)
        },
        Hexed = {
            Name = "HEXED",
            Icon = "🔮",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(176, 98, 255)
        },
        VampireLord = {
            Name = "VAMPIRE LORD",
            Icon = "🧛",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(210, 30, 50)
        },
        PumpkinKing = {
            Name = "PUMPKIN KING",
            Icon = "🎃",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(255, 150, 20)
        },
        TheUndying = {
            Name = "THE UNDYING",
            Icon = "💀",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(90, 230, 255)
        },
        Keyholder = {
            Name = "KEYHOLDER",
            Icon = "🗝",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(110, 230, 190)
        },
        FallenSubject = {
            Name = "FALLEN SUBJECT",
            Icon = "🦴",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(225, 215, 190)
        },
        CrownedInBone = {
            Name = "CROWNED IN BONE",
            Icon = "👑",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(255, 220, 110)
        },
        Kingslayer = {
            Name = "KINGSLAYER",
            Icon = "⚔️",
            Hidden = true,
            Event = "Halloween2026",
            Color = Color3.fromRGB(255, 70, 70)
        },
        TeamFootball = {
            Name = "TEAM FOOTBALL",
            Icon = "🏈",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(196, 46, 52)
        },
        TeamFutbol = {
            Name = "TEAM FÚTBOL",
            Icon = "⚽",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(44, 92, 196)
        },
        FootballMvp = {
            Name = "FOOTBALL MVP",
            Icon = "🏈",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(255, 202, 58)
        },
        FutbolMvp = {
            Name = "FÚTBOL MVP",
            Icon = "⚽",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(255, 202, 58)
        },
        FootballChampion = {
            Name = "FOOTBALL CHAMPION",
            Icon = "🏈",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(255, 202, 58)
        },
        FutbolChampion = {
            Name = "FÚTBOL CHAMPION",
            Icon = "⚽",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(255, 202, 58)
        },
        FootballLegend = {
            Name = "FOOTBALL LEGEND",
            Icon = "🏈",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(170, 90, 255)
        },
        FutbolLegend = {
            Name = "FÚTBOL LEGEND",
            Icon = "⚽",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(170, 90, 255)
        },
        FootballGoat = {
            Name = "#1 FOOTBALL GOAT",
            Icon = "🏈",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(255, 215, 64)
        },
        FutbolGoat = {
            Name = "#1 FÚTBOL GOAT",
            Icon = "⚽",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(255, 215, 64)
        },
        FootballElite = {
            Name = "FOOTBALL ELITE",
            Icon = "🏈",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(255, 128, 64)
        },
        FutbolElite = {
            Name = "FÚTBOL ELITE",
            Icon = "⚽",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(255, 128, 64)
        },
        FootballAllStar = {
            Name = "FOOTBALL ALL-STAR",
            Icon = "🏈",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(80, 200, 255)
        },
        FutbolAllStar = {
            Name = "FÚTBOL ALL-STAR",
            Icon = "⚽",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(80, 200, 255)
        },
        FootballTeam1 = {
            Name = "FIRST DOWN",
            Icon = "🏈",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(196, 46, 52)
        },
        FootballTeam3 = {
            Name = "END ZONE",
            Icon = "🏈",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(255, 104, 104)
        },
        FootballTeam5 = {
            Name = "GRIDIRON GREAT",
            Icon = "🏈",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(255, 202, 58)
        },
        FutbolTeam1 = {
            Name = "KICKOFF",
            Icon = "⚽",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(44, 92, 196)
        },
        FutbolTeam3 = {
            Name = "GOLAZO",
            Icon = "⚽",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(104, 160, 255)
        },
        FutbolTeam5 = {
            Name = "HAT TRICK",
            Icon = "⚽",
            Hidden = true,
            Event = "FvF2026",
            Color = Color3.fromRGB(255, 202, 58)
        },
        TrickOrTreater = {
            Name = "TRICK OR TREATER",
            Icon = "🎃",
            Event = "Halloween2026",
            Color = Color3.fromRGB(255, 140, 40)
        },
        CornCollector = {
            Name = "CORN COLLECTOR",
            Icon = "🍬",
            Event = "Halloween2026",
            Color = Color3.fromRGB(255, 196, 70)
        },
        NightStalker = {
            Name = "NIGHT STALKER",
            Icon = "🌙",
            Event = "Halloween2026",
            Color = Color3.fromRGB(150, 110, 255)
        },
        Spooky = {
            Name = "SPOOKY",
            Icon = "👻",
            Event = "Halloween2026",
            Color = Color3.fromRGB(176, 98, 255)
        },
        GhostHunter = {
            Name = "GHOST HUNTER",
            Icon = "👻",
            Event = "Halloween2026",
            Color = Color3.fromRGB(170, 230, 255)
        },
        GraveyardShift = {
            Name = "GRAVEYARD SHIFT",
            Icon = "⚰️",
            Event = "Halloween2026",
            Color = Color3.fromRGB(160, 170, 180)
        },
        WitchingHour = {
            Name = "WITCHING HOUR",
            Icon = "🧙",
            Event = "Halloween2026",
            Color = Color3.fromRGB(120, 220, 110)
        },
        CandySnatcher = {
            Name = "CANDY SNATCHER",
            Icon = "🍬",
            Event = "Halloween2026",
            Color = Color3.fromRGB(255, 120, 200)
        },
        Haunted = {
            Name = "HAUNTED",
            Icon = "👻",
            Event = "Halloween2026",
            Color = Color3.fromRGB(190, 150, 255)
        },
        BoneCollector = {
            Name = "BONE COLLECTOR",
            Icon = "💀",
            Event = "Halloween2026",
            Color = Color3.fromRGB(230, 225, 210)
        },
        Cursed = {
            Name = "CURSED",
            Icon = "🕸",
            Event = "Halloween2026",
            Color = Color3.fromRGB(140, 60, 200)
        },
        Nightmare = {
            Name = "NIGHTMARE",
            Icon = "😱",
            Event = "Halloween2026",
            Color = Color3.fromRGB(210, 40, 60)
        },
        Headless = {
            Name = "HEADLESS",
            Icon = "🎃",
            Event = "Halloween2026",
            Color = Color3.fromRGB(255, 110, 30)
        },
        SoulReaper = {
            Name = "SOUL REAPER",
            Icon = "💀",
            Event = "Halloween2026",
            Color = Color3.fromRGB(90, 200, 255)
        },
        PumpkinHunter = {
            Name = "PUMPKIN HUNTER",
            Icon = "🎃",
            Event = "Halloween2026",
            Color = Color3.fromRGB(255, 150, 30)
        },
        SoulBearer = {
            Name = "SOUL BEARER",
            Icon = "👻",
            Event = "Halloween2026",
            Color = Color3.fromRGB(150, 110, 255)
        },
        Soulkeeper = {
            Name = "SOULKEEPER",
            Icon = "🕯",
            Event = "Halloween2026",
            Color = Color3.fromRGB(120, 230, 160)
        }
    },
    Rewards = require(script.Parent:WaitForChild(v1.RewardsModule))
};

function u2.endsIn(p3) -- Line: 100
    -- upvalues: u2 (copy)
    local EndsAt = u2.EndsAt;

    if type(EndsAt) ~= "number" or EndsAt <= 0 then
        return nil;
    end;

    local math_floor_ret = math.floor(EndsAt - p3);

    if math_floor_ret <= 0 then
        return false;
    end;

    local v4 = math_floor_ret // 86400;
    local v5 = math_floor_ret % 86400 // 3600;
    local v6 = math_floor_ret % 3600 // 60;

    return v4 > 0 and ("%dd %dh"):format(v4, v5) or (v5 > 0 and ("%dh %dm"):format(v5, v6) or ("%dm %ds"):format(v6, math_floor_ret % 60));
end;

function u2.effective(p7, p8, p9) -- Line: 111
    if not p7 or (p8 or 0) < 1 then
        return p7;
    end;

    local table_clone_ret = table.clone(p7);
    local v10;

    if p7.SkinId and (p9.skins or {})[p7.SkinId] == true then
        table_clone_ret.SkinId = nil;
        table_clone_ret.KnifeIcon = nil;
        v10 = true;
    else
        v10 = false;
    end;

    if p7.EmoteId and (p9.emotes or {})[p7.EmoteId] == true then
        table_clone_ret.EmoteId = nil;
        v10 = true;
    end;

    if p7.Badge and (p9.badges or {})[p7.Badge] == true then
        table_clone_ret.Badge = nil;
        v10 = true;
    end;

    if v10 then
        table_clone_ret.Icon = nil;
        table_clone_ret.Owned = true;
    end;

    return table_clone_ret;
end;

function u2.reward(p11) -- Line: 120
    -- upvalues: u2 (copy)
    for i, v in u2.Rewards do
        local v12 = i;

        for i2, v2 in v do
            if v2.Key == p11 then
                return v2, v12, i2;
            end;
        end;
    end;
end;

return u2;