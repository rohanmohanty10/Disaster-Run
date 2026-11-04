 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");
local wiki = require(ReplicatedStorage.wiki);
local styles = wiki.styles;
local u1 = {
    score = { "Scoring a Goal", 20 },
    dribble = { "Dribbling an Enemy", 15 },
    tackle = { "Tackling an Enemy", 10 },
    assist = { "Assisting a Teammate in Scoring", 10 },
    save = { "Saving the Ball", 10 },
    volley_goal = { "Volleying and Scoring from a Pass", 30 }
};
local u8 = {
    CommonTasks = u1,
    TierSkips = {
        [1] = 3611380962,
        [5] = 3611381098,
        [10] = 3611381143
    },

    CanAddXP = function() -- Line: 27, Name: CanAddXP
        -- upvalues: ReplicatedStorage (copy)
        return ReplicatedStorage:GetAttribute("PS_USED_CMDS") ~= true;
    end,

    GetTierForXP = function(p2, p3) -- Line: 31, Name: GetTierForXP
        local v4 = 0;

        for i, v in ipairs(p2) do
            if v.XP > p3 then
                break;
            end;

            p3 = p3 - v.XP;
            v4 = i;
        end;

        return v4, p3;
    end,

    GetMaxXP = function(p5) -- Line: 46, Name: GetMaxXP
        local v6 = 0;

        for _, v in ipairs(p5) do
            v6 = v6 + v.XP;
        end;

        return v6;
    end,

    GetProfile = function(p7) -- Line: 54, Name: GetProfile
        -- upvalues: ServerStorage (copy)
        if type(p7) == "table" then
            p7 = p7.player or p7;
        end;

        if not p7 then
            return;
        end;

        local Data = require(ServerStorage.profile).getData(p7);

        if Data then
            return Data, Data.profile.Data, p7;
        end;
    end
};

function u8.AddXP(p9, p10, p11, p12) -- Line: 64
    -- upvalues: u8 (copy), wiki (copy), ReplicatedStorage (copy)
    if not (p10 and p11) then
        return;
    end;

    local Profile, v13, v14 = u8.GetProfile(p9);

    if not Profile then
        return;
    end;

    if not (p12 or u8.CanAddXP()) then
        return;
    end;

    local Tiers = wiki.styles[p10].mastery_info.Tiers;

    if not p12 then
        if ReplicatedStorage.vipserverownerid.Value ~= 0 then
            p11 = p11 * 0.8;
        end;

        if v14:GetAttribute("vip") then
            p11 = p11 * 1.25;
        end;
    end;

    local xp = v13.mastery[p10].xp;
    local math_min_ret = math.min(xp + p11, u8.GetMaxXP(Tiers));

    if xp == math_min_ret then
        return;
    end;

    local TierForXP = u8.GetTierForXP(Tiers, math_min_ret);
    Profile:change(`mastery.{p10}.xp`, math_min_ret, {
        force = true
    });
    Profile:change(`mastery.{p10}.tier`, TierForXP, {
        force = true
    });
end;

function u8.DailyWork(p15, p16) -- Line: 96
    -- upvalues: u8 (copy)
    local style = p15.style;

    if not style then
        return;
    end;

    local Profile, v17 = u8.GetProfile(p15);

    if not Profile then
        return;
    end;

    u8.DailyRefresh(p15);

    if not u8.CanAddXP() then
        return;
    end;

    for _, v in ipairs(v17.mastery[style].daily) do
        local Daily = u8.GetDaily(style, v.i);

        if not v.f and Daily[2] == p16 then
            v.v = v.v + 1;

            if v.v >= Daily[3] then
                v.f = true;
                u8.AddXP(p15, style, Daily[4]);
            end;
        end;
    end;
end;

function u8.AddFromCommonTask(p18, p19) -- Line: 119
    -- upvalues: styles (copy), u8 (copy), u1 (copy)
    local style = p18.style;

    if not style then
        return;
    end;

    local v20 = styles[style];

    if not (v20 and v20.mastery_info) then
        return;
    end;

    u8.DailyWork(p18, p19);

    if not u8.CanAddXP() then
        return;
    end;

    local v21 = u1[p19];

    if not v21 then
        return;
    end;

    u8.AddXP(p18, style, v21[2]);
end;

function u8.AddFromTask(p22, p23) -- Line: 136
    -- upvalues: styles (copy), u8 (copy)
    local style = p22.style;

    if not style then
        return;
    end;

    local v24 = styles[style];

    if not (v24 and v24.mastery_info) then
        return;
    end;

    local mastery_info = v24.mastery_info;
    u8.DailyWork(p22, p23);

    if not u8.CanAddXP() then
        return;
    end;

    local v25 = mastery_info.XP.Normal[p23];

    if not v25 then
        return;
    end;

    u8.AddXP(p22, style, v25[2]);
end;

function u8.GetDate() -- Line: 155
    return os.date("!%Y-%m-%d");
end;

function u8.DailyRefresh(p26) -- Line: 160
    -- upvalues: u8 (copy)
    local Profile, v27 = u8.GetProfile(p26);

    if not Profile then
        return;
    end;

    if u8.GetDate() == v27.mastery_daily_refresh then
        u8.BackfillDailies(p26);

        return;
    end;

    u8.RefreshDailies(p26);
end;

function u8.SeedDailies(p28, p29) -- Line: 171
    -- upvalues: u8 (copy)
    local v30 = {};

    for i = 1, 3 do
        local v31 = u8.ReturnDaily(p29, v30);
        p28.mastery[p29].daily[i] = v31;
        table.insert(v30, v31.i);
        local _ = i;
    end;
end;

function u8.GetDailies(p32) -- Line: 180
    -- upvalues: styles (copy)
    local v33 = styles[p32];

    if v33 and v33.mastery_info then
        return v33.mastery_info.XP.Daily;
    end;
end;

function u8.ReturnDaily(p34, p35) -- Line: 187
    -- upvalues: u8 (copy)
    local v36 = p35 or {};
    local v37 = {};

    for i in u8.GetDailies(p34) do
        if not table.find(v36, i) then
            table.insert(v37, i);
        end;
    end;

    return {
        v = 0,
        f = false,
        i = v37[math.random(#v37)]
    };
end;

function u8.RefreshDailies(p38) -- Line: 205
    -- upvalues: u8 (copy)
    local Profile, v39 = u8.GetProfile(p38);

    if not Profile then
        return;
    end;

    local v40 = {};

    for i, v in v39.mastery do
        if v.daily then
            table.insert(v40, i);
        end;
    end;

    for _, v in v40 do
        u8.SeedDailies(v39, v);
    end;

    v39.mastery_daily_refresh = u8.GetDate();
end;

function u8.BackfillDailies(p41) -- Line: 224
    -- upvalues: u8 (copy)
    local Profile, v42 = u8.GetProfile(p41);

    if not Profile then
        return;
    end;

    for i, v in v42.mastery do
        if v.daily and next(v.daily) == nil then
            u8.SeedDailies(v42, i);
        end;
    end;
end;

function u8.GetDaily(p43, p44) -- Line: 236
    -- upvalues: u8 (copy)
    return u8.GetDailies(p43)[p44];
end;

return u8;