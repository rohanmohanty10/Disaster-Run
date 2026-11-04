 
 

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");
ReplicatedStorage:WaitForChild("Resources");
local script_Whitelist = require(script.Whitelist);
local emoteWiki = require(ReplicatedStorage.emoteWiki);
local v1 = {};

for i, v in pairs(emoteWiki) do
    if not v.limited then
        table.insert(v1, i);
    end;
end;

local script_cloths = require(script.cloths);
local u2 = {
    shoulder_bash_window = 0.1,
    style_new = { "kaiser" },
    style_updated = {},
    ownerlists = script_Whitelist.owner,
    dasslists = script_Whitelist.ronaldo,
    dastlists = script_Whitelist.exe,
    allowAcctype = {
        Enum.AccessoryType.Face,
        Enum.AccessoryType.Hair,
        Enum.AccessoryType.Hat,
        Enum.AccessoryType.Neck,
        Enum.AccessoryType.Waist
    },
    questSettings = {
        britishaikuevil = "british aiku quest 2"
    },
    walkspeed = 25,
    jumppower = 50,
    gkjumppower = 65,
    runwalkspeed = 40,
    testServerId = 121877399209259,
    groupId = 35316274,
    maxEmotePages = 2,
    Achievements = require(script.Achievements),
    dailyQuests = require(script.dailyQuests),
    mvp_anim = require(script.mvpAnimations),
    cctitle = require(script.CreatorTitleOverlay),
    styles = require(script.styles),
    title = require(script.titles),
    commentators = require(script.Commentators),
    goal_effects = require(script.GoalEffects),
    ["limited&emotes"] = { "deathcounter", "WallyWest" },
    ["limited&mvps"] = { "isagiDemon", "explosion", "executedCelebration", "bambiettaMVP", "hitMVP" },
    rolestypes = {
        herogame = { "CF", "RW", "LW", "CM", "GK" },
        onemoregame = { "CF", "RW", "LW", "LM", "GK", "RM" },
        realsoccer = { "CF", "RW", "RF", "LW", "GK", "LF", "CM", "LCB", "LB", "RCB", "RB" }
    },
    teams = {
        {
            { "A", Color3.fromRGB(255, 255, 255) },
            { "B", Color3.fromRGB(0, 0, 0) }
        }
    },
    legacycloth = script_cloths.legacy,
    cloth = script_cloths.normal,
    goal_rarity = {
        {
            5,
            "Mythic",
            { "Frost Fall", "Kaiser", "Rin" },
            ReplicatedStorage.Resources.rarityEff.mystic,
            ReplicatedStorage.Resources.rarityEff.mysticS,
            Color3.fromRGB(255, 32, 255)
        },
        {
            20,
            "Legendary",
            { "Kunigami", "Shidou", "Yukimiya" },
            ReplicatedStorage.Resources.rarityEff.mystic,
            ReplicatedStorage.Resources.rarityEff.mysticS,
            Color3.fromRGB(255, 255, 0)
        },
        {
            30,
            "Rare",
            { "Acid" },
            ReplicatedStorage.Resources.rarityEff.legendary,
            ReplicatedStorage.Resources.rarityEff.legendaryS,
            Color3.fromRGB(0, 0, 255)
        },
        {
            35,
            "Common",
            { "default", "greenboom", "yellowboom", "orangeboom", "pinkboom", "purpleboom", "redboom" },
            ReplicatedStorage.Resources.rarityEff.common,
            ReplicatedStorage.Resources.rarityEff.commonS,
            Color3.fromRGB(255, 255, 255)
        }
    },
    style_rarity = {
        {
            5,
            { "kaiser", "rin", "donlorenzo", "reo" },
            ReplicatedStorage.Resources.rarityEff.wcEff,
            ReplicatedStorage.Resources.rarityEff.wcS,
            Color3.fromRGB(255, 255, 255)
        },
        {
            20,
            { "sae", "aiku", "barou", "yukimiya", "kunigami", "kiyora", "karasu", "otoya" },
            ReplicatedStorage.Resources.rarityEff.mystic,
            ReplicatedStorage.Resources.rarityEff.mysticS,
            Color3.fromRGB(255, 32, 255)
        },
        {
            50,
            { "kurona" },
            ReplicatedStorage.Resources.rarityEff.legendary,
            ReplicatedStorage.Resources.rarityEff.legendaryS,
            Color3.fromRGB(255, 255, 0)
        },
        {
            100,
            { "shidou", "nagi", "bachira", "chigiri" },
            ReplicatedStorage.Resources.rarityEff.legendary,
            ReplicatedStorage.Resources.rarityEff.legendaryS,
            Color3.fromRGB(0, 251, 255)
        },
        {
            1000,
            { "isagi", "gagamaru" },
            ReplicatedStorage.Resources.rarityEff.common,
            ReplicatedStorage.Resources.rarityEff.commonS,
            Color3.fromRGB(192, 255, 121)
        }
    },
    lucky_style_rarity = {
        {
            1,
            { "kaiser", "rin", "donlorenzo", "reo" },
            ReplicatedStorage.Resources.rarityEff.wcEff,
            ReplicatedStorage.Resources.rarityEff.wcS,
            Color3.fromRGB(255, 255, 255)
        },
        {
            10,
            { "sae", "aiku", "barou", "yukimiya", "kunigami", "kiyora", "karasu", "otoya" },
            ReplicatedStorage.Resources.rarityEff.mystic,
            ReplicatedStorage.Resources.rarityEff.mysticS,
            Color3.fromRGB(255, 32, 255)
        },
        {
            25,
            { "kurona" },
            ReplicatedStorage.Resources.rarityEff.legendary,
            ReplicatedStorage.Resources.rarityEff.legendaryS,
            Color3.fromRGB(255, 255, 0)
        },
        {
            64,
            { "shidou", "nagi", "bachira", "chigiri" },
            ReplicatedStorage.Resources.rarityEff.legendary,
            ReplicatedStorage.Resources.rarityEff.legendaryS,
            Color3.fromRGB(0, 251, 255)
        }
    },
    mvp_rarity = { "specialGoal", "firstFlow", "kaiserTriumph", "rinTriumph", "nagiSeishiro", "chigiriTriumph", "Dopamine", "king", "isagiTriumph", "FieldKing", "u20", "nagiMvp", "ronaldoMvp", "kunigamiMvp", "saeMvp", "saeGlory", "kiyoraMvp", "nelisagiMVP", "yukimiyaMVP", "bachiraMVP", "contractMVP", "crushedDreams", "thanksgivingMVP", "watchOutMVP", "oiiTensai", "shidouXCharles", "amazingFeeling", "isagixhioriMVP", "ReoMVP", "saeXShidou", "rinTriumphV2", "hugoMvp", "kiyoraappraisal", "otoyakarasu", "saemvp2", "Ubers", "barouHeadToHead", "egoists_or_something", "listenupMVP", "talentedlearners", "chigirimvp", "bunnymvp" },
    emote_rarity = v1,
    special_emotes = {
        [{ 1147190599, 568225745, 167499574, 1414863362, 9248296813, 619213444, 335614502, 144335594, 4640746451, 225469691, 366074287, 863701520, 260526009 }] = {
            name = "NESS!!!",
            image = 140656788073303,
            sound = "disciples_ness"
        },
        [{ 4678987333, 179841008, 850512411 }] = {
            name = "POWER!!",
            image = 101794474238550,
            sound = "where_is_he"
        },
        [{ 10072479640, 1250526085, 2527751273 }] = {
            name = "hello neighbor",
            image = 104283933480735,
            sound = "gurky_turkey"
        },
        [{ 139232224, 885268917, 4348260626, 912182517, 47838711, 2608219493, 312582604 }] = {
            name = "danieldere",
            image = 119899933100169,
            sound = "zane_is_a_tsundere"
        },
        [2447122302] = {
            name = "ITADORIYUJIII",
            image = 111823690366320,
            sound = "itadori_scream"
        },
        [{ 4166416054, 1974243283, 1172470680 }] = {
            name = "tung",
            image = 84943239102297,
            sound = "tung"
        },
        [{ 103548428 }] = {
            name = "WHAT!!!",
            image = 606680422,
            sound = "WHAT"
        },
        [{ 2912663972, 11207915501, 1770854870, 2685280233, 482731209, 4001072658, 2200943671 }] = {
            name = "RED MIST",
            image = 138868313141102,
            sound = "red_mist"
        }
    },
    highroletitile = {
        [255] = {
            tagText = "twi (owner)",
            tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.690196, 0.396078, 0.627451)), ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.435294, 0.819608)), ColorSequenceKeypoint.new(1, Color3.new(0.690196, 0.403922, 0.662745)) })
        },
        [254] = {
            tagText = "Manager",
            tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(4, 3, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 55, 23)) })
        },
        [253] = {
            tagText = "Developer (High)",
            tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(21, 145, 221)), ColorSequenceKeypoint.new(1, Color3.fromRGB(36, 100, 221)) })
        },
        [10] = {
            tagText = "Developer",
            tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(36, 86, 221)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 184, 221)) })
        },
        [8] = {
            tagText = "Administrator",
            tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 0)) })
        },
        [7] = {
            tagText = "Senior Moderator",
            tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 70, 180)), ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 80, 200)) })
        },
        [5] = {
            tagText = "Contributor",
            tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(221, 129, 189)), ColorSequenceKeypoint.new(1, Color3.fromRGB(221, 88, 123)) })
        },
        [6] = {
            tagText = "Moderator",
            tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(51, 71, 116)), ColorSequenceKeypoint.new(1, Color3.fromRGB(67, 94, 153)) })
        },
        [4] = {
            tagText = "Tester",
            tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 179, 48)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 124, 58)) })
        },
        [3] = {
            tagText = "Trial Tester",
            tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 179, 48)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 124, 58)) })
        },
        [2] = {
            tagText = "Content Creator",
            tagColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(79, 48, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(162, 0, 255)) })
        }
    },
    shopprice = {
        style = 250,
        mvpanimation = 5000,
        title = 10000,
        emote = 250,
        commentators = 20000,
        luckystyle = 15000,
        goaleffect = 750
    },
    datacantchangeinvipserver = { "goals", "saves2", "assists", "wins", "money", "HRE", "style_currency", "candy_canes" },
    places = {
        regular = 94647229517154,
        test_regular = 121877399209259,
        beginner = 94647229517154,
        test_beginner = 121877399209259,
        ["11v11"] = 85946466968831,
        test_11v11 = 71334037343939,
        ["6v6"] = 110601443400671,
        test_6v6 = 74444420878081,
        rankedlobby = 87164643764860,
        test_rankedlobby = 130818863858715,
        chaos = 99229654141898,
        test_chaos = 111737497259478,
        legacy = 139609232261520,
        test_legacy = 112411377699045,
        ["5expanded_regular"] = 116393332100516,
        ["5expanded_test"] = 96246407384074,
        ["6expanded_regular"] = 107756419246502,
        ["6expanded_test"] = 84215204734996,
        ["11expanded_regular"] = 82024535780807,
        ["11expanded_test"] = 129819107732043,
        afk = 79009957757101,
        test_afk = 74830306618626
    },
    vaultedMvps = {},
    vaultedEmotes = {},
    rankedRegions = { "Northwest America", "Northeast America", "Central America", "South America", "Europe", "Asia", "Asia West", "Australia" },
    gameModes = { { "RANKED", "probably the closest thing to dying if you dont sugarcoat it", "rbxassetid://13041301654", "rankedlobby", "serverList" }, { "6V6", "one more person on each team", "rbxassetid://116091400265128", "6v6", "serverList" }, { "MAIN GAME", "where you like play soccer to practice & stuff", "rbxassetid://95411210937707", "Regular" }, { "AFK CHAMBER", "rest up, gain some money on the side", "rbxassetid://109078029595020", "AFK" }, { "11V11", "actual soccer", "rbxassetid://89543702525186", "11v11", "serverList" }, { "LEGACY", "back with the old", "rbxassetid://14693444112", "legacy", "serverList" }, { "TUTORIAL", "learn to play the game", "rbxassetid://87707341775351", "Tutorial" }, { "BEGINNER", "newbies", "rbxassetid://12659046297", "beginner", "serverList" } },
    new_gamemodes = { "RANKED" },
    actualmodifiers = { { "urf", "rapid fire", "really low cooldowns", "rbxassetid://96691122" }, { "randomizer", "randomizer", "spawn with a random moveset, sort of like that one mode from jujutsu shenanigans, you feel me? no? what, was this too long of a description? how about you just read better.", "rbxassetid://18241333056" } },
    PassInfo = {
        Winter25 = { "Christmas 2025 Pass", "rbxassetid://6020941207", "Candy Canes" }
    },
    ball_pickups = {
        player = 7,
        gk = 12.5,
        max = 25
    },
    auto_compensation = {
        mvps = {
            executedCelebration = { "executedOLD", false }
        }
    },
    move_tags = {
        iframe = "I-Frames",
        volley = "Volleyable",
        volleyonly = "Volley-Only",
        cutscene = "Cutscene",
        cam_aim = "Camera-Aimed",
        movement = "Movement",
        penalty = "Penalty Box",
        gk = "Goalkeeper",
        qte = "QTE",
        teammate = "Teammate",
        teammates = "Teammates",
        flow = "Flow",
        endsflow = "Ends Flow",
        stylespecific = "Style-Specific",
        onball = "On-Ball",
        offball = "Off-Ball",
        autogoal = "Auto Goal",
        overtime = "Overtime",
        awaken = "Awakening",
        steal = "Steal",
        trap = "Trap",
        counter = "Counter",
        metavision = "Metavision",
        buff = "Buff",
        debuff = "Debuff",
        usetwice = "Use Twice",
        usethrice = "Use Thrice"
    },
    move_stats = {
        shotpower = "Shot Power",
        shotpowergk = "Shot Power (GK)",
        range = "Range",
        shot_mod = "Shot Mod",
        speed_mod = "Speed Mod",
        defense_mod = "Defense Mod",
        speed = "Speed",
        cooldown = "Cooldown",
        uses = "Usage Cap"
    }
};

for i, v in u2.special_emotes do
    if typeof(i) == "table" then
        local v3 = v;

        for _, v2 in i do
            u2.special_emotes[v2] = v3;
        end;

        u2.special_emotes[i] = nil;
    end;
end;

u2.teamroles = u2.rolestypes.herogame;
u2.rolestypes.chaos = { "CF", "LF", "P0", "P1", "GK" };

for i = 2, 96 do
    local chaos = u2.rolestypes.chaos;
    local v4 = `P{i}`;
    table.insert(chaos, v4);
    local _ = i;
end;

local v5 = {
    jerseyNumber = 1542628535,
    awakeningOutfitId = 1144171085,
    ps = 1201920755,
    vip = 1415212834,
    VFXRecolor = 1732197145,
    HideStats = 1415212834,
    extraPages = 1486909263,
    soundChanger = 1530073516,
    dribbleSound = 1732063859,
    Wheel = 1168206289,
    dubVoicelines = 1672150010,
    SpecificJersey = 1874582763,
    flowMusicId = 1882571482
};
u2.gamepassId = v5;
u2.giftedPasses = {
    [3371852565] = { v5.awakeningOutfitId, "Awakening Outfits", 200 },
    [3378103760] = { v5.vip, "VIP", 550 },
    [3371852778] = { v5.ps, "PS+", 300 },
    [3371853209] = { v5.Wheel, "Extra Emote Slots", 150 },
    [3514642560] = { v5.dubVoicelines, "Dub Voicelines", 299 },
    [3551804746] = { v5.VFXRecolor, "VFX Recolor", 249 },
    [3551814449] = { v5.dribbleSound, "Custom Dribble Sound", 119 },
    [3604722176] = { v5.SpecificJersey, "Choice of Jersey", 99 },
    [3605741787] = { v5.flowMusicId, "Custom Flow Music", 150 }
};
u2.consumableGiftProducts = {
    cash = { {
            id = 3237362546,
            amount = 100000
        }, {
            id = 3237340278,
            amount = 25000
        }, {
            id = 3237361801,
            amount = 10000
        }, {
            id = 3237362069,
            amount = 1000
        } },
    style_currency = { {
            id = 3467829718,
            amount = 100000
        }, {
            id = 3467830465,
            amount = 25000
        }, {
            id = 3467830196,
            amount = 10000
        }, {
            id = 3467830693,
            amount = 1000
        } },
    spin_luck = { {
            id = 3455902297
        } }
};
u2.otherGamemodes = {
    [u2.places["6v6"]] = "6v6",
    [u2.places.test_6v6] = "6v6",
    [u2.places["11v11"]] = "11v11",
    [u2.places.test_11v11] = "11v11",
    [u2.places.chaos] = "chaos",
    [u2.places.test_chaos] = "chaos",
    [u2.places["6expanded_regular"]] = "6v6",
    [u2.places["6expanded_test"]] = "6v6",
    [u2.places["11expanded_regular"]] = "11v11",
    [u2.places["11expanded_test"]] = "11v11"
};

function u2.init() -- Line: 601
    -- upvalues: u2 (copy), RunService (copy), ServerStorage (copy), ReplicatedStorage (copy)
    local v6 = nil;

    if u2.wasInit then
        return ReplicatedStorage:WaitForChild("workspace", 20).Gamemode.Value;
    end;

    if RunService:IsServer() then
        v6 = u2.otherGamemodes[game.PlaceId] or "Regular";
        ServerStorage.workspacestate.Gamemode.Value = v6;
    elseif RunService:IsClient() then
        v6 = ReplicatedStorage:WaitForChild("workspace", 20).Gamemode.Value;
    end;

    if v6:match("6v6") then
        u2.teamroles = u2.rolestypes.onemoregame;
    end;

    if v6:match("11v11") then
        u2.teamroles = u2.rolestypes.realsoccer;
    end;

    if v6:match("chaos") then
        u2.teamroles = u2.rolestypes.chaos;
    end;

    u2.wasInit = true;

    return v6;
end;

function u2.getGamemode() -- Line: 626
    -- upvalues: u2 (copy)
    return u2.init();
end;

function u2.isTestGame() -- Line: 630
    return game.GameId == 7231744796;
end;

function u2.isJolly() -- Line: 634
    return table.find({}, game.PlaceId) ~= nil;
end;

local u7 = {};

function u2.get_stat(p8: string, p9: string, p10: string) -- Line: 642
    -- upvalues: u7 (copy), u2 (copy)
    local v11 = `{p8}/{p9}`;

    if not u7[v11] then
        local v12 = u2.styles[p8];

        if not (v12 and v12.wiki) then
            return;
        end;

        for _, v in ipairs(v12.wiki) do
            if v.name == p9 then
                u7[v11] = v.stats;
                break;
            end;
        end;
    end;

    local v13 = u7[v11];

    if v13 then
        v13 = v13[p10];
    end;

    return v13;
end;

return u2;