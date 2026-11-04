  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.Util);
local TableUtil = require(ReplicatedStorage.Packages.TableUtil);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Configs.StyleEventData);
local ItemType = require(ReplicatedStorage.Shared.Configs.ItemType);
local u1 = {
    Enabled = false,
    EVENT_NAME = "NEL Battlepass",
    TOKEN_DISPLAY_NAME = "NEO Token",
    TOKEN_IMAGE = "rbxassetid://93218788558890",
    SPIN_DISPLAY_NAME = "NEO",
    CRATE_COST = 100,
    PremiumId = 3467362071,
    PremiumGiftId = 3467362275,
    PremiumPlusId = 3560596732,
    PremiumPlusTierSkips = 20,
    TierSkipProducts = {
        3560627270,
        3560627279,
        3560627275,
        3560627284,
        3560627272,
        3560627278,
        3560627274,
        3560627271,
        3560627304,
        3560627301,
        3560627283,
        3560627276,
        3560627281,
        3560627303,
        3560627282,
        3560627280,
        3560627273,
        3560627302,
        3560627277,
        3560627300,
        3560627816,
        3560627814,
        3560627847,
        3560627815,
        3560627824,
        3560627819,
        3560627827,
        3560627825,
        3560627823,
        3560627821,
        3560627818,
        3560627845,
        3560627846,
        3560627813,
        3560627817,
        3560627843,
        3560627848,
        3560627820,
        3560627844,
        3560627822,
        3560628116,
        3560628117,
        3560628098,
        3560628102,
        3560628095,
        3560628104,
        3560628113,
        3560628103,
        3560628119,
        3560628118,
        3560628094,
        3560628100,
        3560628097,
        3560628099,
        3560628105,
        3560628115,
        3560628093,
        3560628101,
        3560628114,
        3560628096,
        3560628898,
        3560628919,
        3560628920,
        3560628901,
        3560628908,
        3560628909,
        3560628904,
        3560628922,
        3560628921,
        3560628902,
        3560628910,
        3560628905,
        3560628923,
        3560628899,
        3560628906,
        3560628925,
        3560628900,
        3560628924,
        3560628907,
        3560628903,
        3560629308,
        3560629326,
        3560629303,
        3560629324,
        3560629304,
        3560629306,
        3560629310,
        3560631066,
        3560629302,
        3560629327,
        3560629311,
        3560629301,
        3560629328,
        3560629323,
        3560629312,
        3560629307,
        3560629325,
        3560629305,
        3560629309,
        3560629313
    },
    TierSkipProductLookup = {}
};

for i, v in u1.TierSkipProducts do
    u1.TierSkipProductLookup[v] = i;
end;

u1.DATA_NAME = "NELBattlepassEvent";
u1.InventoryItems = { "Emotes", "GoalEffects", "Cards", "Cosmetics" };
u1.Tiers = 100;
u1.XpMultiplier = 25;
u1.XpExponent = 0.5;
u1.XpPerDailyQuest = 125;
u1.XpPerWeeklyQuest = 500;
u1.DailyFreeCount = 3;
u1.DailyPremiumCount = 2;
u1.WeeklyFreeCount = 4;
u1.WeeklyPremiumCount = 1;
u1.DailyRefreshTime = 86400;
u1.WeeklyRefreshTime = 604800;
u1.Sections = { { 1, 40 }, { 41, 60 }, { 61, 80 }, { 81, 100 } };
u1.RefreshPrices = { 49, 99, 399, 799 };
u1.Quests = {
    Match = {
        Display = "Play X Matches",
        Goal = {
            Min = 2,
            Max = 10
        }
    },
    Goal = {
        Display = "Score X Goals",
        Goal = {
            Min = 2,
            Max = 10
        }
    },
    Assist = {
        Display = "Get X Assists",
        Goal = {
            Min = 2,
            Max = 10
        }
    },
    Ankle = {
        Display = "Break X Ankles",
        Goal = {
            Min = 2,
            Max = 10
        }
    },
    Steal = {
        Display = "Steal X Balls",
        Goal = {
            Min = 2,
            Max = 10
        }
    },
    Header = {
        Display = "Get X Headers",
        Goal = {
            Min = 2,
            Max = 10
        }
    },
    Wins = {
        Display = "Win X Games",
        Goal = {
            Min = 2,
            Max = 3
        }
    },
    Saves = {
        Display = "Save X Goals",
        Goal = {
            Min = 2,
            Max = 10
        }
    },
    Hatrick = {
        Display = "Get X Hatricks",
        Goal = {
            Min = 1,
            Max = 2
        }
    }
};
u1.WeeklyQuests = {
    Goal = {
        Display = "Score X Goals",
        Goal = {
            Min = 15,
            Max = 20
        }
    },
    Match = {
        Display = "Play X Matches",
        Goal = {
            Min = 10,
            Max = 15
        }
    },
    Awaken = {
        Display = "Awaken X Times",
        Goal = {
            Min = 4,
            Max = 6
        }
    },
    Ankle = {
        Display = "Break X Ankles",
        Goal = {
            Min = 30,
            Max = 40
        }
    },
    Saves = {
        Display = "Save X Goals",
        Goal = {
            Min = 15,
            Max = 25
        }
    },
    Wins = {
        Display = "Win X Games",
        Goal = {
            Min = 3,
            Max = 10
        }
    },
    Assist = {
        Display = "Get X Assists",
        Goal = {
            Min = 2,
            Max = 10
        }
    },
    AwakenGoals = {
        Display = "Score X Goals while awakened",
        Goal = {
            Min = 5,
            Max = 15
        }
    },
    OvertimeGoal = {
        Display = "Score X Goals during overtime",
        Goal = {
            Min = 3,
            Max = 5
        }
    },
    Flows = {
        Display = "Activate flow X times",
        Goal = {
            Min = 15,
            Max = 20
        }
    }
};
u1.Icons = {
    Money = "rbxassetid://18883459904",
    Spins = "rbxassetid://125339871021518",
    [ItemType.EventTokens] = u1.TOKEN_IMAGE,
    [ItemType.LuckyStyleSpins] = "rbxassetid://125339871021518",
    [ItemType.StyleSpins] = "rbxassetid://125339871021518",
    [ItemType.LuckyFlowSpins] = "rbxassetid://133558083095603",
    [ItemType.FlowSpins] = "rbxassetid://133558083095603",
    Emotes = "rbxassetid://117292274298443",
    GoalEffects = "rbxassetid://77099796060909",
    Cards = "rbxassetid://123457362696177",
    None = "rbxassetid://71873528065567",
    Cosmetics = "rbxassetid://115576802447546",
    [ItemType.WheelToken] = "rbxassetid://102146440935893",
    [ItemType.Cosmetic] = "rbxassetid://115576802447546",
    [ItemType.Emote] = "rbxassetid://117292274298443",
    [ItemType.GoalEffect] = "rbxassetid://77099796060909",
    [ItemType.PlayerCard] = "rbxassetid://123457362696177",
    [ItemType.BallSkin] = "rbxassetid://71873528065567",
    [ItemType.Cash] = "rbxassetid://18883459904"
};
u1.Display = {
    Money = "$=",
    [ItemType.StyleSpins] = "x= Spins",
    [ItemType.LuckyStyleSpins] = "x= Lucky Spins",
    [ItemType.FlowSpins] = "x= Flow Spins",
    [ItemType.LuckyFlowSpins] = "x= Lucky Flow Spins",
    [ItemType.EventTokens] = "x= Tokens",
    [ItemType.WheelToken] = "x= Wheel Spin",
    [ItemType.Cash] = "$= Yen"
};
u1.Free = {
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 250,
        Category = ItemType.Cash
    },
    {
        Amount = 120,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 80,
        Category = ItemType.EventTokens
    },
    {
        Amount = 200,
        Category = ItemType.Cash
    },
    {
        Reward = "Munchen Players",
        Image = "rbxassetid://116757390909347",
        Category = ItemType.PlayerCard
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 500,
        Category = ItemType.Cash
    },
    {
        Reward = "Low Cortisol",
        Image = "rbxassetid://80850818712900",
        Category = ItemType.Emote
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 125,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Flame Aura",
        Image = "rbxassetid://78383140700061",
        Category = ItemType.Cosmetic
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.Cash
    },
    {
        Amount = 115,
        Category = ItemType.EventTokens
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 300,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Soccer Game Cape",
        Image = "rbxassetid://99390587554262",
        Category = ItemType.Cosmetic
    },
    {
        Amount = 200,
        Category = ItemType.EventTokens
    },
    {
        Amount = 200,
        Category = ItemType.Cash
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.Cash
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 55,
        Category = ItemType.EventTokens
    },
    {
        Amount = 1,
        Category = ItemType.WheelToken
    },
    {
        Amount = 400,
        Category = ItemType.Cash
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 300,
        Category = ItemType.Cash
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 250,
        Category = ItemType.Cash
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Chibi Rin Chain",
        Image = "rbxassetid://130431899746834",
        Category = ItemType.Cosmetic
    },
    {
        Reward = "Chris Prince",
        Image = "rbxassetid://107542619022060",
        Category = ItemType.Emote
    },
    {},
    {
        Reward = "Chibi Isagi Chain",
        Image = "rbxassetid://81661602266538",
        Category = ItemType.Cosmetic
    },
    {
        Amount = 1,
        Category = ItemType.WheelToken
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 300,
        Category = ItemType.Cash
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 300,
        Category = ItemType.Cash
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Reward = "RAGE Table Flip",
        Image = "rbxassetid://89737858723532",
        Category = ItemType.Emote
    },
    {
        Amount = 200,
        Category = ItemType.Cash
    },
    {
        Amount = 1,
        Category = ItemType.WheelToken
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Chromatic Hollow",
        Image = "rbxassetid://116293940251147",
        Category = ItemType.GoalEffect
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {},
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Soccer Game Players",
        Image = "rbxassetid://95427439763158",
        Category = ItemType.PlayerCard
    },
    {
        Amount = 300,
        Category = ItemType.Cash
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 1,
        Category = ItemType.WheelToken
    },
    {
        Reward = "Hiori Ice Compass",
        Image = "rbxassetid://99169539956718",
        Category = ItemType.Cosmetic
    },
    {
        Amount = 300,
        Category = ItemType.Cash
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 500,
        Category = ItemType.Cash
    },
    {
        Amount = 60,
        Category = ItemType.EventTokens
    },
    {
        Amount = 300,
        Category = ItemType.Cash
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Elemental Aura",
        Image = "rbxassetid://108663331544218",
        Category = ItemType.Cosmetic
    },
    {
        Amount = 750,
        Category = ItemType.Cash
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 300,
        Category = ItemType.Cash
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {},
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 750,
        Category = ItemType.Cash
    },
    {
        Amount = 75,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Isagi Headband",
        Image = "rbxassetid://86416046435637",
        Category = ItemType.Cosmetic
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 500,
        Category = ItemType.Cash
    },
    {
        Amount = 75,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 300,
        Category = ItemType.Cash
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 1,
        Category = ItemType.WheelToken
    },
    {
        Amount = 75,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 500,
        Category = ItemType.Cash
    },
    {
        Amount = 75,
        Category = ItemType.EventTokens
    },
    {
        Amount = 300,
        Category = ItemType.Cash
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {}
};
u1.Premium = {
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 500,
        Category = ItemType.Cash
    },
    {
        Amount = 120,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Ego Glasses",
        Image = "rbxassetid://72033244449739",
        Category = ItemType.Cosmetic
    },
    {
        Amount = 120,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 1,
        Category = ItemType.WheelToken
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 750,
        Category = ItemType.Cash
    },
    {
        Amount = 900,
        Category = ItemType.Cash
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 1250,
        Category = ItemType.Cash
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 800,
        Category = ItemType.Cash
    },
    {
        Amount = 1,
        Category = ItemType.WheelToken
    },
    {
        Reward = "Niko Watchtower",
        Image = "rbxassetid://70686534313451",
        Category = ItemType.GoalEffect
    },
    {
        Amount = 250,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.Cash
    },
    {
        Amount = 200,
        Category = ItemType.EventTokens
    },
    {
        Amount = 300,
        Category = ItemType.Cash
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 500,
        Category = ItemType.Cash
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 1,
        Category = ItemType.WheelToken
    },
    {
        Reward = "4D Prism",
        Image = "rbxassetid://137938622129971",
        Category = ItemType.BallSkin
    },
    {
        Amount = 200,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 250,
        Category = ItemType.Cash
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 250,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 50,
        Category = ItemType.Cash
    },
    {
        Reward = "4D Metavision",
        Image = "rbxassetid://77607017729416",
        Category = ItemType.BallSkin
    },
    {},
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 1,
        Category = ItemType.WheelToken
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 1,
        Category = ItemType.WheelToken
    },
    {
        Amount = 750,
        Category = ItemType.Cash
    },
    {
        Reward = "Crowd Laugh",
        Image = "rbxassetid://75360205163289",
        Category = ItemType.GoalEffect
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Kiyora Balance",
        Image = "rbxassetid://79401840174812",
        Category = ItemType.Cosmetic
    },
    {
        Amount = 50,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 300,
        Category = ItemType.Cash
    },
    {
        Reward = "Metavision Suit",
        Image = "rbxassetid://122200433130128",
        Category = ItemType.Cosmetic
    },
    {
        Amount = 250,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Hugo Gear Flow",
        Image = "rbxassetid://88897781025992",
        Category = ItemType.Emote
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Barou Pose",
        Image = "rbxassetid://111092410794015",
        Category = ItemType.Emote
    },
    {},
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 125,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 300,
        Category = ItemType.Cash
    },
    {
        Amount = 1000,
        Category = ItemType.Cash
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Bang Shield",
        Image = "rbxassetid://93727923707029",
        Category = ItemType.Emote
    },
    {
        Amount = 500,
        Category = ItemType.EventTokens
    },
    {
        Amount = 125,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 150,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Reo Wings",
        Image = "rbxassetid://138229994714109",
        Category = ItemType.Cosmetic
    },
    {
        Amount = 1,
        Category = ItemType.WheelToken
    },
    {
        Reward = "Crash Out",
        Image = "rbxassetid://74652714000994",
        Category = ItemType.Emote
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {},
    {
        Amount = 1,
        Category = ItemType.WheelToken
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 150,
        Category = ItemType.EventTokens
    },
    {
        Amount = 1500,
        Category = ItemType.Cash
    },
    {
        Amount = 200,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Emperor",
        Display = "Emperor Ball",
        Image = "rbxassetid://111248698153571",
        Category = ItemType.BallSkin
    },
    {
        Amount = 150,
        Category = ItemType.EventTokens
    },
    {
        Amount = 1,
        Category = ItemType.WheelToken
    },
    {
        Amount = 500,
        Category = ItemType.Cash
    },
    {
        Amount = 200,
        Category = ItemType.EventTokens
    },
    {
        Amount = 100,
        Category = ItemType.EventTokens
    },
    {
        Amount = 250,
        Category = ItemType.EventTokens
    },
    {
        Amount = 300,
        Category = ItemType.Cash
    },
    {
        Amount = 200,
        Category = ItemType.EventTokens
    },
    {
        Amount = 150,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Soccer Game Flag",
        Image = "rbxassetid://121843711703267",
        Category = ItemType.Cosmetic
    },
    {
        Amount = 200,
        Category = ItemType.EventTokens
    },
    {
        Reward = "Kaiser Throne",
        Image = "rbxassetid://93280607301880",
        Category = ItemType.Emote
    },
    {}
};
u1.SectionRewards = {
    [40] = {
        Reward = "Lavinho Suit",
        Image = "rbxassetid://74443370659803",
        Category = ItemType.Cosmetic
    },
    [60] = {
        Reward = "NEL Teams",
        Display = "NEL Teams Ball",
        Image = "rbxassetid://81842848074632",
        Category = ItemType.BallSkin
    },
    [80] = {
        Reward = "Sae Metavision",
        Image = "rbxassetid://90504343650725",
        Category = ItemType.GoalEffect
    },
    [100] = {
        Reward = "Kunigami Pose",
        Image = "rbxassetid://88809259818913",
        Category = ItemType.Emote
    }
};

function u1.GetXpForTier(p2) -- Line: 365
    -- upvalues: u1 (copy)
    return p2 <= 1 and 0 or math.floor(u1.XpMultiplier * (p2 - 1) ^ u1.XpExponent);
end;

function u1.GetSectionForTier(p3) -- Line: 370
    -- upvalues: u1 (copy)
    for i, v in u1.Sections do
        if v[1] <= p3 and p3 <= v[2] then
            return i;
        end;
    end;

    return #u1.Sections;
end;

function u1.GetRandomQuests(p4) -- Line: 379
    -- upvalues: u1 (copy), TableUtil (copy)
    local v5 = {};

    for i, _ in u1.Quests do
        table.insert(v5, i);
    end;

    local v6 = TableUtil.Shuffle(TableUtil.Copy(v5));
    local v7 = {};

    for i = 1, p4 do
        local v8 = v6[i];
        local v9 = u1.Quests[v8];
        v7[v8] = {
            Progress = 0,
            Claimed = false,
            Goal = typeof(v9.Goal) == "number" and v9.Goal or math.random(v9.Goal.Min, v9.Goal.Max)
        };
        local _ = i;
    end;

    return v7;
end;

function u1.GetRandomWeeklyQuests(p10) -- Line: 398
    -- upvalues: u1 (copy), TableUtil (copy)
    local v11 = {};

    for i, _ in u1.WeeklyQuests do
        table.insert(v11, i);
    end;

    local v12 = TableUtil.Shuffle(TableUtil.Copy(v11));
    local v13 = {};

    for i = 1, p10 do
        local v14 = v12[i];
        local v15 = u1.WeeklyQuests[v14];
        v13[v14] = {
            Progress = 0,
            Claimed = false,
            Goal = typeof(v15.Goal) == "number" and v15.Goal or math.random(v15.Goal.Min, v15.Goal.Max)
        };
        local _ = i;
    end;

    return v13;
end;

return u1;