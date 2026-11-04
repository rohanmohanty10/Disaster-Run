  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local ItemType = require(ReplicatedStorage.Shared.Configs.ItemType);
local environment = require(ReplicatedStorage.Shared.environment);
local u1 = {
    Enabled = true,
    EVENT_NAME = "U20 World Tournament",
    DATA_NAME = "U20BlueLockCupEvent_Knockout2026",
    WeeklyApiEvent = "U20BlueLockCupEvent_Knockout2026_R32",
    ApiEvents = {
        R32 = "U20BlueLockCupEvent_Knockout2026_R32",
        R16 = "U20BlueLockCupEvent_Knockout2026_R16"
    },
    PhaseLabel = "Knockout Week",
    PredictionSpinsPerCorrect = {
        R32 = 1,
        R16 = 2
    },
    LegacyWeeklyReward = {
        Id = "GroupStage2026FinalWeek",
        Event = "U20BlueLockCupEvent",
        LegacyWeekIndex = "1",
        WeekKeys = { "2026-07-04" }
    },
    TestMode = {
        DayLength = 600,
        GraceSeconds = 0,
        UseRealApi = true,
        UseRealSchedule = true,
        SkipToFinalStage = true
    },
    PointsPerAction = {
        Goal = 100,
        Assist = 70,
        Save = 50,
        Steal = 8
    },
    Days = { {
            Date = "2026-07-11",
            Round = "R32",
            MatchCount = 4
        }, {
            Date = "2026-07-12",
            Round = "R32",
            MatchCount = 4
        }, {
            Date = "2026-07-13",
            Round = "R32",
            MatchCount = 4
        }, {
            Date = "2026-07-14",
            Round = "R32",
            MatchCount = 4
        }, {
            Date = "2026-07-15",
            Round = "R16",
            MatchCount = 3
        }, {
            Date = "2026-07-16",
            Round = "R16",
            MatchCount = 3
        }, {
            Date = "2026-07-17",
            Round = "R16",
            MatchCount = 2
        } },
    Weeks = { {
            Start = "2026-07-11",
            End = "2026-07-17"
        } },
    Groups = {
        A = { {
                Name = "Japan",
                Code = "JP",
                Emoji = "🇯🇵",
                Flag = "rbxassetid://0"
            }, {
                Name = "France",
                Code = "FR",
                Emoji = "🇫🇷",
                Flag = "rbxassetid://75661130599891"
            }, {
                Name = "England",
                Code = "GB-ENG",
                Emoji = "🏴󠁧󠁢󠁥󠁮󠁧󠁿",
                Flag = "rbxassetid://0"
            }, {
                Name = "Nigeria",
                Code = "NG",
                Emoji = "🇳🇬",
                Flag = "rbxassetid://0"
            } },
        O = { {
                Name = "Mexico",
                Code = "MX",
                Emoji = "🇲🇽",
                Flag = "rbxassetid://0"
            }, {
                Name = "Poland",
                Code = "PL",
                Emoji = "🇵🇱",
                Flag = "rbxassetid://0"
            }, {
                Name = "Mali",
                Code = "ML",
                Emoji = "🇲🇱",
                Flag = "rbxassetid://0"
            }, {
                Name = "Hungary",
                Code = "HU",
                Emoji = "🇭🇺",
                Flag = "rbxassetid://0"
            } },
        F = { {
                Name = "Switzerland",
                Code = "CH",
                Emoji = "🇨🇭",
                Flag = "rbxassetid://0"
            }, {
                Name = "China",
                Code = "CN",
                Emoji = "🇨🇳",
                Flag = "rbxassetid://0"
            }, {
                Name = "Panama",
                Code = "PA",
                Emoji = "🇵🇦",
                Flag = "rbxassetid://0"
            }, {
                Name = "Côte d\'Ivoire",
                Code = "CI",
                Emoji = "🇨🇮",
                Flag = "rbxassetid://0"
            } },
        J = { {
                Name = "Croatia",
                Code = "HR",
                Emoji = "🇭🇷",
                Flag = "rbxassetid://0"
            }, {
                Name = "Canada",
                Code = "CA",
                Emoji = "🇨🇦",
                Flag = "rbxassetid://0"
            }, {
                Name = "Ghana",
                Code = "GH",
                Emoji = "🇬🇭",
                Flag = "rbxassetid://0"
            }, {
                Name = "Bahrain",
                Code = "BH",
                Emoji = "🇧🇭",
                Flag = "rbxassetid://0"
            } },
        B = { {
                Name = "Brazil",
                Code = "BR",
                Emoji = "🇧🇷",
                Flag = "rbxassetid://110026114854885"
            }, {
                Name = "Senegal",
                Code = "SN",
                Emoji = "🇸🇳",
                Flag = "rbxassetid://0"
            }, {
                Name = "Czech Republic",
                Code = "CZ",
                Emoji = "🇨🇿",
                Flag = "rbxassetid://0"
            }, {
                Name = "Uzbekistan",
                Code = "UZ",
                Emoji = "🇺🇿",
                Flag = "rbxassetid://0"
            } },
        K = { {
                Name = "Saudi Arabia",
                Code = "SA",
                Emoji = "🇸🇦",
                Flag = "rbxassetid://0"
            }, {
                Name = "Scotland",
                Code = "GB-SCT",
                Emoji = "🏴󠁧󠁢󠁳󠁣󠁴󠁿",
                Flag = "rbxassetid://0"
            }, {
                Name = "Algeria",
                Code = "DZ",
                Emoji = "🇩🇿",
                Flag = "rbxassetid://0"
            }, {
                Name = "Chile",
                Code = "CL",
                Emoji = "🇨🇱",
                Flag = "rbxassetid://0"
            } },
        L = { {
                Name = "Morocco",
                Code = "MA",
                Emoji = "🇲🇦",
                Flag = "rbxassetid://0"
            }, {
                Name = "Ukraine",
                Code = "UA",
                Emoji = "🇺🇦",
                Flag = "rbxassetid://0"
            }, {
                Name = "Venezuela",
                Code = "VE",
                Emoji = "🇻🇪",
                Flag = "rbxassetid://0"
            }, {
                Name = "Iraq",
                Code = "IQ",
                Emoji = "🇮🇶",
                Flag = "rbxassetid://0"
            } },
        E = { {
                Name = "Italy",
                Code = "IT",
                Emoji = "🇮🇹",
                Flag = "rbxassetid://0"
            }, {
                Name = "Iran",
                Code = "IR",
                Emoji = "🇮🇷",
                Flag = "rbxassetid://0"
            }, {
                Name = "Cameroon",
                Code = "CM",
                Emoji = "🇨🇲",
                Flag = "rbxassetid://0"
            }, {
                Name = "Honduras",
                Code = "HN",
                Emoji = "🇭🇳",
                Flag = "rbxassetid://0"
            } },
        C = { {
                Name = "Argentina",
                Code = "AR",
                Emoji = "🇦🇷",
                Flag = "rbxassetid://70804620778928"
            }, {
                Name = "Denmark",
                Code = "DK",
                Emoji = "🇩🇰",
                Flag = "rbxassetid://0"
            }, {
                Name = "Tunisia",
                Code = "TN",
                Emoji = "🇹🇳",
                Flag = "rbxassetid://0"
            }, {
                Name = "UAE",
                Code = "AE",
                Emoji = "🇦🇪",
                Flag = "rbxassetid://0"
            } },
        H = { {
                Name = "Peru",
                Code = "PE",
                Emoji = "🇵🇪",
                Flag = "rbxassetid://0"
            }, {
                Name = "Austria",
                Code = "AT",
                Emoji = "🇦🇹",
                Flag = "rbxassetid://0"
            }, {
                Name = "Wales",
                Code = "GB-WLS",
                Emoji = "🏴󠁧󠁢󠁷󠁬󠁳󠁿",
                Flag = "rbxassetid://0"
            }, {
                Name = "Jordan",
                Code = "JO",
                Emoji = "🇯🇴",
                Flag = "rbxassetid://0"
            } },
        N = { {
                Name = "USA",
                Code = "US",
                Emoji = "🇺🇸",
                Flag = "rbxassetid://0"
            }, {
                Name = "Norway",
                Code = "NO",
                Emoji = "🇳🇴",
                Flag = "rbxassetid://106362848537446"
            }, {
                Name = "South Africa",
                Code = "ZA",
                Emoji = "🇿🇦",
                Flag = "rbxassetid://0"
            }, {
                Name = "Bolivia",
                Code = "BO",
                Emoji = "🇧🇴",
                Flag = "rbxassetid://0"
            } },
        D = { {
                Name = "Spain",
                Code = "ES",
                Emoji = "🇪🇸",
                Flag = "rbxassetid://76984452060327"
            }, {
                Name = "Ecuador",
                Code = "EC",
                Emoji = "🇪🇨",
                Flag = "rbxassetid://0"
            }, {
                Name = "Indonesia",
                Code = "ID",
                Emoji = "🇮🇩",
                Flag = "rbxassetid://0"
            }, {
                Name = "Sweden",
                Code = "SE",
                Emoji = "🇸🇪",
                Flag = "rbxassetid://0"
            } },
        G = { {
                Name = "Netherlands",
                Code = "NL",
                Emoji = "🇳🇱",
                Flag = "rbxassetid://0"
            }, {
                Name = "Colombia",
                Code = "CO",
                Emoji = "🇨🇴",
                Flag = "rbxassetid://0"
            }, {
                Name = "Egypt",
                Code = "EG",
                Emoji = "🇪🇬",
                Flag = "rbxassetid://0"
            }, {
                Name = "New Zealand",
                Code = "NZ",
                Emoji = "🇳🇿",
                Flag = "rbxassetid://0"
            } },
        I = { {
                Name = "Australia",
                Code = "AU",
                Emoji = "🇦🇺",
                Flag = "rbxassetid://0"
            }, {
                Name = "Portugal",
                Code = "PT",
                Emoji = "🇵🇹",
                Flag = "rbxassetid://72614303550249"
            }, {
                Name = "Belgium",
                Code = "BE",
                Emoji = "🇧🇪",
                Flag = "rbxassetid://0"
            }, {
                Name = "Paraguay",
                Code = "PY",
                Emoji = "🇵🇾",
                Flag = "rbxassetid://0"
            } },
        M = { {
                Name = "Uruguay",
                Code = "UY",
                Emoji = "🇺🇾",
                Flag = "rbxassetid://0"
            }, {
                Name = "Turkey",
                Code = "TR",
                Emoji = "🇹🇷",
                Flag = "rbxassetid://0"
            }, {
                Name = "Cape Verde",
                Code = "CV",
                Emoji = "🇨🇻",
                Flag = "rbxassetid://96493858338622"
            }, {
                Name = "Vietnam",
                Code = "VN",
                Emoji = "🇻🇳",
                Flag = "rbxassetid://0"
            } },
        P = { {
                Name = "Germany",
                Code = "DE",
                Emoji = "🇩🇪",
                Flag = "rbxassetid://134876129292280"
            }, {
                Name = "Korea",
                Code = "KR",
                Emoji = "🇰🇷",
                Flag = "rbxassetid://0"
            }, {
                Name = "Serbia",
                Code = "RS",
                Emoji = "🇷🇸",
                Flag = "rbxassetid://0"
            }, {
                Name = "Costa Rica",
                Code = "CR",
                Emoji = "🇨🇷",
                Flag = "rbxassetid://0"
            } }
    },
    DailyWinnerRewards = {
        {
            Amount = 3,
            Category = ItemType.LuckyStyleSpins
        }
    },
    DailyQualifierRewards = {
        {
            Amount = 1,
            Category = ItemType.LuckyStyleSpins
        }
    },
    WeeklyBrackets = {
        {
            TopPercent = 1,
            Rewards = {
                {
                    Reward = "World Cup Team Aura",
                    Category = ItemType.Cosmetic
                }
            }
        },
        {
            TopPercent = 10,
            Rewards = {
                {
                    Reward = "World Cup Flag",
                    Category = ItemType.Emote
                }
            }
        },
        {
            TopPercent = 25,
            Rewards = {
                {
                    Amount = 10,
                    Category = ItemType.LuckyStyleSpins
                }
            }
        },
        {
            TopPercent = 50,
            Rewards = {
                {
                    Amount = 5,
                    Category = ItemType.LuckyFlowSpins
                }
            }
        },
        {
            TopPercent = 75,
            Rewards = { {
                    Category = "TeamChatTag"
                } }
        }
    },
    CalendarRewards = {
        {
            Date = "2026-07-11",
            Name = "1 Lucky Spin",
            Rewards = {
                {
                    Amount = 1,
                    Category = ItemType.LuckyStyleSpins
                }
            }
        },
        {
            Date = "2026-07-12",
            Name = "2 Lucky Spins",
            Rewards = {
                {
                    Amount = 2,
                    Category = ItemType.LuckyStyleSpins
                }
            }
        },
        {
            Date = "2026-07-13",
            Name = "3 Lucky Spins",
            Rewards = {
                {
                    Amount = 3,
                    Category = ItemType.LuckyStyleSpins
                }
            }
        },
        {
            Date = "2026-07-14",
            Name = "4 Lucky Spins",
            Rewards = {
                {
                    Amount = 4,
                    Category = ItemType.LuckyStyleSpins
                }
            }
        },
        {
            Date = "2026-07-15",
            Name = "5 Lucky Spins",
            Rewards = {
                {
                    Amount = 5,
                    Category = ItemType.LuckyStyleSpins
                }
            }
        },
        {
            Date = "2026-07-16",
            Name = "8 Lucky Spins",
            Rewards = {
                {
                    Amount = 8,
                    Category = ItemType.LuckyStyleSpins
                }
            }
        },
        {
            Date = "2026-07-17",
            Name = "10 Lucky Spins",
            Rewards = {
                {
                    Amount = 10,
                    Category = ItemType.LuckyStyleSpins
                }
            }
        }
    }
};
local os_time_ret = os.time();

local function isTestMode() -- Line: 190
    -- upvalues: RunService (copy), environment (copy)
    return RunService:IsStudio() and true or environment.env ~= "Main";
end;

local function useFakeClock() -- Line: 195
    -- upvalues: RunService (copy), environment (copy), u1 (copy)
    local v2 = (RunService:IsStudio() and true or environment.env ~= "Main") and not u1.TestMode.UseRealSchedule;

    return v2;
end;

local function parseDate(p3) -- Line: 199
    local string_match_ret, v4, v5 = string.match(p3 or "", "^(%d+)-(%d+)-(%d+)$");

    if not string_match_ret then
        return nil;
    end;

    local os_time_ret2 = os.time({
        hour = 0,
        min = 0,
        sec = 0,
        year = tonumber(string_match_ret),
        month = tonumber(v4),
        day = tonumber(v5)
    });

    return os_time_ret2 - (os.time(os.date("!*t", os_time_ret2)) - os_time_ret2);
end;

u1.WinnerResolutionGraceSeconds = 0;

function u1.IsTestMode() -- Line: 209
    -- upvalues: RunService (copy), environment (copy)
    return RunService:IsStudio() and true or environment.env ~= "Main";
end;

function u1.RestartTestClock() -- Line: 213
    -- upvalues: RunService (copy), environment (copy), u1 (copy), os_time_ret (ref)
    local v6 = (RunService:IsStudio() and true or environment.env ~= "Main") and not u1.TestMode.UseRealSchedule;

    if not v6 then
        return false;
    end;

    os_time_ret = os.time();

    return true;
end;

function u1.SkipTestDay() -- Line: 219
    -- upvalues: RunService (copy), environment (copy), u1 (copy), os_time_ret (ref)
    local v7 = (RunService:IsStudio() and true or environment.env ~= "Main") and not u1.TestMode.UseRealSchedule;

    if not v7 then
        return nil, "fake clock disabled (UseRealSchedule is on)";
    end;

    local CurrentDay = u1.GetCurrentDay();

    if not CurrentDay then
        return nil, "event is over";
    end;

    local _, v8 = u1.GetDayWindow(CurrentDay);
    local v9 = v8 - os.time();

    if v9 > 0 then
        os_time_ret = os_time_ret - v9;
    end;

    return u1.GetCurrentDay();
end;

function u1.GetResolutionGraceSeconds() -- Line: 231
    -- upvalues: RunService (copy), environment (copy), u1 (copy)
    if RunService:IsStudio() and true or environment.env ~= "Main" then
        return u1.TestMode.UseRealApi and 2 or u1.TestMode.GraceSeconds;
    end;

    return u1.WinnerResolutionGraceSeconds;
end;

function u1.GetDayWindow(p10) -- Line: 239
    -- upvalues: u1 (copy), RunService (copy), environment (copy), os_time_ret (ref), parseDate (copy)
    local v11 = u1.Days[p10];

    if not v11 then
        return nil;
    end;

    local v12 = (RunService:IsStudio() and true or environment.env ~= "Main") and not u1.TestMode.UseRealSchedule;

    if v12 then
        local DayLength = u1.TestMode.DayLength;
        local v13 = os_time_ret + (p10 - 1) * DayLength;

        return v13, v13 + DayLength;
    end;

    local v14 = parseDate(v11.Date);

    if v14 then
        return v14, v14 + 86400;
    end;

    return nil;
end;

function u1.GetCurrentDay() -- Line: 252
    -- upvalues: u1 (copy)
    local os_time_ret2 = os.time();

    for i = 1, #u1.Days do
        local DayWindow, v15 = u1.GetDayWindow(i);

        if DayWindow and (DayWindow <= os_time_ret2 and os_time_ret2 < v15) then
            return i;
        end;

        local _ = i;
    end;

    return nil;
end;

function u1.IsDayOver(p16) -- Line: 263
    -- upvalues: u1 (copy)
    local _, v17 = u1.GetDayWindow(p16);
    local v18;

    if v17 == nil then
        v18 = false;
    else
        v18 = v17 <= os.time();
    end;

    return v18;
end;

function u1.GetWeekWindow(p19) -- Line: 268
    -- upvalues: u1 (copy), RunService (copy), environment (copy), os_time_ret (ref), parseDate (copy)
    local v20 = u1.Weeks[p19];

    if not v20 then
        return nil;
    end;

    local v21 = (RunService:IsStudio() and true or environment.env ~= "Main") and not u1.TestMode.UseRealSchedule;

    if v21 then
        local v22 = u1.TestMode.DayLength * #u1.Days;
        local v23 = os_time_ret + (p19 - 1) * v22;

        return v23, v23 + v22;
    end;

    local v24 = parseDate(v20.Start);
    local v25 = parseDate(v20.End);

    if v24 and v25 then
        return v24, v25 + 86400;
    end;

    return nil;
end;

function u1.GetCurrentWeek() -- Line: 282
    -- upvalues: u1 (copy)
    local os_time_ret2 = os.time();

    for i = 1, #u1.Weeks do
        local WeekWindow, v26 = u1.GetWeekWindow(i);

        if WeekWindow and (WeekWindow <= os_time_ret2 and os_time_ret2 < v26) then
            return i;
        end;

        local _ = i;
    end;

    return nil;
end;

function u1.IsWeekOver(p27) -- Line: 293
    -- upvalues: u1 (copy)
    local _, v28 = u1.GetWeekWindow(p27);
    local v29;

    if v28 == nil then
        v29 = false;
    else
        v29 = v28 <= os.time();
    end;

    return v29;
end;

function u1.GetCalendarWindow(p30) -- Line: 298
    -- upvalues: u1 (copy), RunService (copy), environment (copy), parseDate (copy)
    local v31 = u1.CalendarRewards[p30];

    if not v31 then
        return nil;
    end;

    local v32 = (RunService:IsStudio() and true or environment.env ~= "Main") and not u1.TestMode.UseRealSchedule;

    if v32 then
        return u1.GetDayWindow(p30 + 1);
    end;

    local v33 = parseDate(v31.Date);

    if v33 then
        return v33, v33 + 86400;
    end;

    return nil;
end;

function u1.GetCurrentCalendarDay() -- Line: 309
    -- upvalues: u1 (copy)
    local os_time_ret2 = os.time();

    for i = 1, #u1.CalendarRewards do
        local CalendarWindow, v34 = u1.GetCalendarWindow(i);

        if CalendarWindow and (CalendarWindow <= os_time_ret2 and os_time_ret2 < v34) then
            return i;
        end;

        local _ = i;
    end;

    return nil;
end;

function u1.GetDayGroups(p35) -- Line: 320
    -- upvalues: u1 (copy)
    local v36 = u1.Days[p35];

    return v36 and v36.Groups or {};
end;

function u1.GetTeam(p37, p38) -- Line: 325
    -- upvalues: u1 (copy)
    local v39 = u1.Groups[p37];

    return v39 and v39[p38] or nil;
end;

function u1.FindTeam(p40, p41) -- Line: 330
    -- upvalues: u1 (copy)
    local v42 = u1.Groups[p40];

    if not v42 then
        return nil;
    end;

    for _, v in v42 do
        if v.Name == p41 then
            return v;
        end;
    end;

    return nil;
end;

function u1.GetTeamByName(p43) -- Line: 341
    -- upvalues: u1 (copy)
    for i, v in u1.Groups do
        local v44 = i;

        for _, v2 in v do
            if v2.Name == p43 then
                return v2, v44;
            end;
        end;
    end;

    return nil;
end;

function u1.GetTeamChatTag(p45) -- Line: 352
    -- upvalues: u1 (copy)
    local TeamByName = u1.GetTeamByName(p45);

    return TeamByName and TeamByName.Name .. " Team" or nil;
end;

function u1.GetDayMatches(p46) -- Line: 357
    -- upvalues: u1 (copy)
    local v47 = u1.Days[p46];

    return v47 and v47.Matches or {};
end;

function u1.GetDayRound(p48) -- Line: 362
    -- upvalues: u1 (copy)
    local v49 = u1.Days[p48];

    return v49 and v49.Round or nil;
end;

local u50 = nil;

function u1.GetEmojiForCode(p51) -- Line: 369
    -- upvalues: u50 (ref), u1 (copy)
    if not u50 then
        u50 = {};

        for _, v in u1.Groups do
            for _, v2 in v do
                u50[v2.Code] = v2.Emoji;
            end;
        end;
    end;

    return u50[p51];
end;

u1.FinalRounds = {
    DataName = "U20BlueLockCupEvent_FinalRounds2026",
    WeeklyApiEvent = "U20BlueLockCupEvent_FinalRounds2026_Weekly",
    WeekKey = "2026-07-25",
    StageOrder = { "QF", "SF", "F" },
    StageReward = {
        Amount = 5,
        Category = ItemType.LuckyStyleSpins
    },
    Stages = {
        QF = {
            Index = 1,
            Name = "Quarter Finals",
            ApiEvent = "U20BlueLockCupEvent_FinalRounds2026_QF",
            DayKey = "2026-07-25",
            MatchCount = 4,
            StartTime = DateTime.fromUniversalTime(2026, 7, 25, 17, 0, 0, 0).UnixTimestamp,
            EndTime = DateTime.fromUniversalTime(2026, 7, 28, 17, 0, 0, 0).UnixTimestamp
        },
        SF = {
            Index = 2,
            Name = "Semi Finals",
            ApiEvent = "U20BlueLockCupEvent_FinalRounds2026_SF",
            DayKey = "2026-07-28",
            MatchCount = 2,
            StartTime = DateTime.fromUniversalTime(2026, 7, 28, 17, 0, 0, 0).UnixTimestamp,
            EndTime = DateTime.fromUniversalTime(2026, 7, 31, 17, 0, 0, 0).UnixTimestamp
        },
        F = {
            Index = 3,
            Name = "The Final",
            ApiEvent = "U20BlueLockCupEvent_FinalRounds2026_F",
            DayKey = "2026-08-01",
            MatchCount = 1,
            StartTime = DateTime.fromUniversalTime(2026, 8, 1, 17, 0, 0, 0).UnixTimestamp,
            EndTime = DateTime.fromUniversalTime(2026, 8, 8, 17, 0, 0, 0).UnixTimestamp
        }
    }
};

local function finalTestAnchorStart() -- Line: 420
    -- upvalues: u1 (copy)
    local os_time_ret2 = os.time();

    if u1.TestMode.SkipToFinalStage then
        os_time_ret2 = os_time_ret2 - u1.TestMode.DayLength * 2;
    end;

    return os_time_ret2;
end;

local os_time_ret2 = os.time();

if u1.TestMode.SkipToFinalStage then
    os_time_ret2 = os_time_ret2 - u1.TestMode.DayLength * 2;
end;

local u52 = 0;

local function currentScheduleOffset() -- Line: 431
    -- upvalues: RunService (copy), environment (copy), u52 (ref)
    return (not RunService:IsStudio() and environment.env == "Main" and true or false) and 0 or u52;
end;

function u1.GetFinalStageWindow(p53) -- Line: 436
    -- upvalues: u1 (copy), RunService (copy), environment (copy), os_time_ret2 (ref), u52 (ref)
    local v54 = u1.FinalRounds.Stages[p53];

    if not v54 then
        return nil;
    end;

    local v55 = (RunService:IsStudio() and true or environment.env ~= "Main") and not u1.TestMode.UseRealSchedule;

    if not v55 then
        return v54.StartTime - ((not RunService:IsStudio() and environment.env == "Main" and true or false) and 0 or u52), v54.EndTime - ((not RunService:IsStudio() and environment.env == "Main" and true or false) and 0 or u52);
    end;

    local DayLength = u1.TestMode.DayLength;
    local v56 = os_time_ret2 + (v54.Index - 1) * DayLength;

    return v56, v56 + DayLength;
end;

function u1.GetCurrentFinalStage() -- Line: 447
    -- upvalues: u1 (copy)
    local os_time_ret3 = os.time();

    for _, v in u1.FinalRounds.StageOrder do
        local FinalStageWindow, v57 = u1.GetFinalStageWindow(v);

        if FinalStageWindow and (FinalStageWindow <= os_time_ret3 and os_time_ret3 < v57) then
            return v;
        end;
    end;

    return nil;
end;

function u1.GetNextFinalStage() -- Line: 458
    -- upvalues: u1 (copy)
    local os_time_ret3 = os.time();

    for _, v in u1.FinalRounds.StageOrder do
        local FinalStageWindow = u1.GetFinalStageWindow(v);

        if FinalStageWindow and os_time_ret3 < FinalStageWindow then
            return v, FinalStageWindow - os_time_ret3;
        end;
    end;

    return nil;
end;

function u1.IsFinalStageOver(p58) -- Line: 469
    -- upvalues: u1 (copy)
    local _, v59 = u1.GetFinalStageWindow(p58);
    local v60;

    if v59 == nil then
        v60 = false;
    else
        v60 = v59 <= os.time();
    end;

    return v60;
end;

function u1.GetFinalTestAnchor() -- Line: 474
    -- upvalues: os_time_ret2 (ref)
    return os_time_ret2;
end;

function u1.SetFinalTestAnchor(p61) -- Line: 478
    -- upvalues: os_time_ret2 (ref)
    if type(p61) ~= "number" then
        return false;
    end;

    os_time_ret2 = p61;

    return true;
end;

function u1.RestartFinalTestClock() -- Line: 484
    -- upvalues: RunService (copy), environment (copy), u1 (copy), os_time_ret2 (ref)
    local v62 = (RunService:IsStudio() and true or environment.env ~= "Main") and not u1.TestMode.UseRealSchedule;

    if not v62 then
        return false;
    end;

    local os_time_ret3 = os.time();

    if u1.TestMode.SkipToFinalStage then
        os_time_ret3 = os_time_ret3 - u1.TestMode.DayLength * 2;
    end;

    os_time_ret2 = os_time_ret3;

    return true;
end;

function u1.SkipFinalTestStage() -- Line: 490
    -- upvalues: RunService (copy), environment (copy), u1 (copy), os_time_ret2 (ref)
    local v63 = (RunService:IsStudio() and true or environment.env ~= "Main") and not u1.TestMode.UseRealSchedule;

    if not v63 then
        return nil, "fake clock disabled (UseRealSchedule is on)";
    end;

    local CurrentFinalStage = u1.GetCurrentFinalStage();

    if not CurrentFinalStage then
        return nil, "event is over";
    end;

    local _, v64 = u1.GetFinalStageWindow(CurrentFinalStage);
    local v65 = (v64 or os.time()) - os.time();
    os_time_ret2 = os_time_ret2 - math.max(v65, 0);

    return u1.GetCurrentFinalStage();
end;

function u1.SkipFinalTestDay() -- Line: 499
    -- upvalues: RunService (copy), environment (copy), u1 (copy), os_time_ret2 (ref), u52 (ref)
    if not RunService:IsStudio() and environment.env == "Main" then
        return nil, "test mode only";
    end;

    local CurrentFinalDay = u1.GetCurrentFinalDay();

    if not CurrentFinalDay then
        return nil, "no active final day";
    end;

    local _, v66 = u1.GetFinalDayWindow(CurrentFinalDay);
    local v67 = (v66 or os.time()) - os.time();
    local v68 = math.max(v67, 0) + 1;
    local v69 = (RunService:IsStudio() and true or environment.env ~= "Main") and not u1.TestMode.UseRealSchedule;

    if v69 then
        os_time_ret2 = os_time_ret2 - v68;
    else
        u52 = u52 + v68;
    end;

    return u1.GetCurrentFinalDay();
end;

function u1.GetFinalScheduleOffset() -- Line: 513
    -- upvalues: u52 (ref)
    return u52;
end;

function u1.SetFinalScheduleOffset(p70) -- Line: 517
    -- upvalues: u52 (ref)
    if type(p70) ~= "number" then
        return false;
    end;

    u52 = p70;

    return true;
end;

function u1.AlignFinalStartToNow() -- Line: 523
    -- upvalues: RunService (copy), environment (copy), u1 (copy), u52 (ref)
    local v71 = (RunService:IsStudio() and true or environment.env ~= "Main") and not u1.TestMode.UseRealSchedule;

    if v71 or not RunService:IsStudio() and environment.env == "Main" then
        return false;
    end;

    u52 = u1.FinalRounds.Stages.F.StartTime - os.time();

    return true;
end;

function u1.GetFinalWeekWindow() -- Line: 529
    -- upvalues: RunService (copy), environment (copy), u1 (copy), os_time_ret2 (ref), u52 (ref)
    local v72 = (RunService:IsStudio() and true or environment.env ~= "Main") and not u1.TestMode.UseRealSchedule;

    if v72 then
        return os_time_ret2, os_time_ret2 + u1.TestMode.DayLength * 2;
    end;

    return u1.FinalRounds.Stages.QF.StartTime - ((not RunService:IsStudio() and environment.env == "Main" and true or false) and 0 or u52), u1.FinalRounds.Stages.SF.EndTime - ((not RunService:IsStudio() and environment.env == "Main" and true or false) and 0 or u52);
end;

u1.FinalRounds.Final = {
    DayCount = 7,
    RollHourUTC = 17,
    CatchUpStep = 0.25,
    GamemodePointMultiplier = 2,
    ShopEnabled = true,
    WeeklyApiEvent = "U20BlueLockCupEvent_FinalRounds2026_FinalWeekly",
    WeekKey = "2026-08-01",
    DayApiEventPrefix = "U20BlueLockCupEvent_FinalRounds2026_F_D",
    Teams = { "Brazil", "Spain" },
    TeamBySide = {
        Home = "Brazil",
        Away = "Spain"
    },
    CoinRewards = {
        Play = 1,
        Win = 3,
        MVP = 4
    },
    ChampionReward = {
        Reward = "WorldCupMVP",
        Category = ItemType.MVPCutscene
    }
};
u1.FinalRounds.Final.Quests = {
    {
        Id = "Goals50",
        Title = "Globally Recognized - Score 50 Goals In World Tournament Gamemode",
        Stat = "Goals",
        Goal = 50,
        Unit = "Goals",
        Image = "rbxassetid://100191070149284",
        Reward = {
            Reward = "Globe Puffer Jacket",
            Category = ItemType.Cosmetic
        }
    },
    {
        Id = "Mvp50",
        Title = "Worldwide Champion - Win 50 MVPS In World Tournament Gamemode",
        Stat = "Mvps",
        Goal = 50,
        Unit = "MVPS",
        Image = "",
        Reward = {
            Reward = "Globe Aura",
            Category = ItemType.Cosmetic
        }
    },
    {
        Id = "Streak10",
        Title = "Win 10 World Tournament Games In A Row",
        Stat = "Streak",
        Goal = 10,
        Unit = "Wins",
        Repeatable = true,
        Image = "rbxassetid://125339871021518",
        Reward = {
            Amount = 5,
            Category = ItemType.LuckyFlowSpins
        }
    },
    {
        Id = "Games25",
        Title = "Play 25 World Tournament Games",
        Stat = "Games",
        Goal = 25,
        Unit = "Games",
        Image = "rbxassetid://125339871021518",
        Reward = {
            Amount = 5,
            Category = ItemType.LuckyStyleSpins
        }
    },
    {
        Id = "Playtime90",
        Title = "Play For 90 Minutes",
        Stat = "PlaytimeMinutes",
        Goal = 90,
        Unit = "Minutes",
        Image = "rbxassetid://80347094730676",
        Reward = {
            Category = "WorldCoins",
            Amount = 5
        }
    }
};
u1.FinalRounds.Final.ShopItems = {
    {
        Id = "BrazilFlow",
        Name = "Brazil Flow",
        Reward = "Brazil",
        Price = 75,
        Featured = true,
        Image = "",
        Category = ItemType.Flow
    },
    {
        Id = "SpainFlow",
        Name = "Spain Flow",
        Reward = "Spain",
        Price = 75,
        Featured = true,
        Image = "",
        Category = ItemType.Flow
    },
    {
        Id = "ForExampleNothing",
        Name = "For example, Nothing Emote",
        Reward = "For example, Nothing",
        Price = 50,
        RobuxPrice = 200,
        RobuxProductId = 3612568734,
        Image = "rbxassetid://99503121942623",
        Category = ItemType.Emote
    },
    {
        Id = "CalmDown",
        Name = "Calm Down Emote",
        Reward = "Calm Down",
        Price = 40,
        RobuxPrice = 175,
        RobuxProductId = 3612568770,
        Image = "rbxassetid://88972693923487",
        Category = ItemType.Emote
    },
    {
        Id = "WTBallSkin",
        Name = "World Tournament Ball Skin",
        Reward = "World Tournament",
        Price = 10,
        RobuxPrice = 50,
        RobuxProductId = 3612568778,
        Image = "rbxassetid://129449765579475",
        Category = ItemType.BallSkin
    },
    {
        Id = "WTWinnerCard",
        Name = "World Tournament Winner Playercard",
        Reward = "World Tournament Winner",
        Price = 35,
        RobuxPrice = 150,
        RobuxProductId = 3612568783,
        Image = "rbxassetid://118697729252700",
        Category = ItemType.PlayerCard
    },
    {
        Id = "WorldDestruction",
        Name = "World Destruction Goal Effect",
        Reward = "World Destruction",
        Price = 50,
        RobuxPrice = 200,
        RobuxProductId = 3612568786,
        Image = "",
        Category = ItemType.GoalEffect
    },
    {
        Id = "MexicoCard",
        Name = "Team Mexico Playercard",
        Reward = "Team Mexico",
        Price = 25,
        RobuxPrice = 100,
        RobuxProductId = 3612568788,
        Image = "rbxassetid://104180310577249",
        Category = ItemType.PlayerCard
    },
    {
        Id = "EnglandCard",
        Name = "Team England Playercard",
        Reward = "Team England",
        Price = 25,
        RobuxPrice = 100,
        RobuxProductId = 3612568791,
        Image = "rbxassetid://136068339980769",
        Category = ItemType.PlayerCard
    },
    {
        Id = "SpainJacket",
        Name = "Team Spain Puffer Jacket",
        Reward = "Team Spain Puffer Jacket",
        Price = 50,
        RobuxPrice = 200,
        RobuxProductId = 3612568796,
        Image = "rbxassetid://94031161953076",
        Category = ItemType.Cosmetic
    },
    {
        Id = "ArgentinaJacket",
        Name = "Team Argentina Puffer Jacket",
        Reward = "Team Argentina Puffer Jacket",
        Price = 50,
        RobuxPrice = 200,
        RobuxProductId = 3612568809,
        Image = "rbxassetid://83741511651143",
        Category = ItemType.Cosmetic
    },
    {
        Id = "BrazilJacket",
        Name = "Team Brazil Puffer Jacket",
        Reward = "Team Brazil Puffer Jacket",
        Price = 50,
        RobuxPrice = 200,
        RobuxProductId = 3612568814,
        Image = "rbxassetid://71302326547997",
        Category = ItemType.Cosmetic
    },
    {
        Id = "ArgentinaAura",
        Name = "Argentina Team Aura",
        Reward = "Argentina Team Aura",
        Price = 50,
        RobuxPrice = 150,
        RobuxProductId = 3612568817,
        Image = "rbxassetid://116800003050021",
        Category = ItemType.Cosmetic
    },
    {
        Id = "PortugalAura",
        Name = "Portugal Team Aura",
        Reward = "Portugal Team Aura",
        Price = 50,
        RobuxPrice = 150,
        RobuxProductId = 3612568828,
        Image = "rbxassetid://89547350211182",
        Category = ItemType.Cosmetic
    },
    {
        Id = "FranceAura",
        Name = "France Team Aura",
        Reward = "France Team Aura",
        Price = 50,
        RobuxPrice = 150,
        RobuxProductId = 3612568842,
        Image = "rbxassetid://85596765847638",
        Category = ItemType.Cosmetic
    },
    {
        Id = "LuckySpins10",
        Name = "10 Lucky Spins",
        Amount = 10,
        Price = 75,
        MaxPurchases = 3,
        Image = "",
        Category = ItemType.LuckyStyleSpins
    },
    {
        Id = "LuckyFlowSpins10",
        Name = "10 Lucky Flow Spins",
        Amount = 10,
        Price = 75,
        MaxPurchases = 3,
        Image = "",
        Category = ItemType.LuckyFlowSpins
    },
    {
        Id = "StrikerTag",
        Name = "[STRIKER] Chat Tag",
        Category = "ChatTag",
        Reward = "Striker Tag",
        Price = 10,
        Image = ""
    },
    {
        Id = "DefenderTag",
        Name = "[DEFENDER] Chat Tag",
        Category = "ChatTag",
        Reward = "Defender Tag",
        Price = 10,
        Image = ""
    },
    {
        Id = "KeeperTag",
        Name = "[KEEPER] Chat Tag",
        Category = "ChatTag",
        Reward = "Keeper Tag",
        Price = 10,
        Image = ""
    }
};

function u1.GetFinalDayWindow(p73) -- Line: 587
    -- upvalues: u1 (copy), RunService (copy), environment (copy)
    local Final = u1.FinalRounds.Final;

    if p73 < 1 or Final.DayCount < p73 then
        return nil;
    end;

    local FinalStageWindow, v74 = u1.GetFinalStageWindow("F");

    if not FinalStageWindow then
        return nil;
    end;

    local v75 = (RunService:IsStudio() and true or environment.env ~= "Main") and not u1.TestMode.UseRealSchedule;

    if not v75 then
        local v76 = FinalStageWindow + (p73 - 1) * 86400;

        return v76, v76 + 86400;
    end;

    local v77 = (v74 - FinalStageWindow) / Final.DayCount;
    local v78 = FinalStageWindow + (p73 - 1) * v77;

    return v78, v78 + v77;
end;

function u1.GetCurrentFinalDay() -- Line: 601
    -- upvalues: u1 (copy)
    local os_time_ret3 = os.time();

    for i = 1, u1.FinalRounds.Final.DayCount do
        local FinalDayWindow, v79 = u1.GetFinalDayWindow(i);

        if FinalDayWindow and (FinalDayWindow <= os_time_ret3 and os_time_ret3 < v79) then
            return i;
        end;

        local _ = i;
    end;

    return nil;
end;

function u1.IsFinalDayOver(p80) -- Line: 610
    -- upvalues: u1 (copy)
    local _, v81 = u1.GetFinalDayWindow(p80);
    local v82;

    if v81 == nil then
        v82 = false;
    else
        v82 = v81 <= os.time();
    end;

    return v82;
end;

function u1.GetFinalDayApiEvent(p83) -- Line: 615
    -- upvalues: u1 (copy)
    return u1.FinalRounds.Final.DayApiEventPrefix .. tostring(p83);
end;

function u1.GetFinalDayKey(p84) -- Line: 619
    -- upvalues: u1 (copy)
    return os.date("!%Y-%m-%d", u1.FinalRounds.Stages.F.StartTime + (p84 - 1) * 86400);
end;

function u1.GetFinalTeam(p85) -- Line: 624
    -- upvalues: u1 (copy)
    return u1.FinalRounds.Final.TeamBySide[p85];
end;

return u1;