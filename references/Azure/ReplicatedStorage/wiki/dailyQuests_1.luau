 
 

game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage:WaitForChild("types"));
local u1 = 0;
local u2 = 0;

local function new(p3) -- Line: 10
    -- upvalues: u2 (ref), u1 (ref)
    u2 = u2 + 1;
    local u4 = {
        Weight = 0,
        Corrupted = false,
        Title = p3,
        Id = u2,
        Requirements = {},
        Rewards = {}
    };

    function u4.SetWeight(p5) -- Line: 30
        -- upvalues: u1 (ref), u4 (copy)
        u1 = u1 + p5;
        u4.setWeight = nil;

        return u4;
    end;

    function u4.Requirement(p6, p7) -- Line: 36
        -- upvalues: u4 (copy)
        table.insert(u4.Requirements, {
            Type = p6,
            Amount = p7
        });

        return u4;
    end;

    function u4.Reward(p8, p9) -- Line: 45
        -- upvalues: u4 (copy)
        table.insert(u4.Rewards, {
            Type = p8,
            Value = p9
        });

        return u4;
    end;

    return u4;
end;

local u10 = {
    list = {}
};
(function() -- Line: 62, Name: init
    -- upvalues: u10 (copy), u1 (ref)
    for _, v in u10.list do
        if v.Weight then
            v.Corrupted = true;
            warn((`[DailyQuest] There's a quest named "{v.Title}" didn't initialize the weight properly`));
        end;

        if #v.Requirements <= 0 then
            v.Corrupted = true;
            warn((`[DailyQuest] There's a quest named "{v.Title}" didn't set the requirement properly`));
        end;

        if #v.Rewards <= 0 then
            v.Corrupted = true;
            warn((`[DailyQuest] There's a quest named "{v.Title}" didn't have any reward`));
        end;
    end;

    function u10.getNextCycleTime(p11) -- Line: 84
        local os_date_ret = os.date("!*t", p11);
        os_date_ret.min = 0;
        os_date_ret.sec = 0;

        if os_date_ret.hour < 12 then
            os_date_ret.hour = 12;
        else
            os_date_ret.hour = 0;
            local v12 = os.time(os_date_ret) + 86400;
            os_date_ret = os.date("!*t", v12);
        end;

        return os.time(os_date_ret);
    end;

    function u10.formatTime(p13) -- Line: 101
        local math_floor_ret = math.floor(p13 / 3600);
        local math_floor_ret2 = math.floor(p13 % 3600 / 60);

        return string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, p13 % 60);
    end;

    function u10.getTotalWeight() -- Line: 108
        -- upvalues: u1 (ref)
        return u1;
    end;

    local function rollWithLuck(p14, p15) -- Line: 112
        local v16 = {};

        for i, v in pairs(p14) do
            table.insert(v16, {
                key = i,
                w = v
            });
        end;

        table.sort(v16, function(p17, p18) -- Line: 117
            return p17.w < p18.w;
        end);
        local v19 = #v16;
        local v20 = {};

        for i, v in ipairs(v16) do
            v20[v.key] = v16[v19 - i + 1].w;
        end;

        local v21 = {};
        local v22 = 0;

        for _, v in ipairs(v16) do
            local v23 = v.w * (1 - p15) + v20[v.key] * p15;
            v21[v.key] = v23;
            v22 = v22 + v23;
        end;

        for _, v in ipairs(v16) do
            local _ = v21[v.key] / v22 * 100;
        end;

        local v24 = math.random() * v22;
        local v25 = 0;

        for _, v in ipairs(v16) do
            v25 = v25 + v21[v.key];

            if v24 <= v25 then
                return v.key;
            end;
        end;

        return v16[1].key;
    end;

    function u10.random(p26: number) -- Line: 154
        -- upvalues: u1 (ref), u10 (ref)
        local v27 = math.random() * u1 * (p26 or 1);

        for _, v in u10.list do
            if v.Weight < v27 and not v.Corrupted then
                return v;
            end;
        end;
    end;

    function u10.RandomBatch(p28: number, p29: boolean, p30: number) -- Line: 164
        -- upvalues: u10 (ref), u1 (ref)
        local table_clone_ret = table.clone(u10.list);
        local v31 = {};

        if not p29 and #table_clone_ret < p28 then
            error("batch size is larger than total quests; while duplicatedOutput is disabled");
        end;

        for i = 1, p28 do
            local v32 = math.random() * u1 * (p30 or 1);
            local _ = i;

            for _, v in table_clone_ret do
                if v.Weight < v32 and not v.Corrupted then
                    table.insert(v31, v);

                    if not p29 then
                        table.remove(table_clone_ret, table.find(table_clone_ret, v));
                    end;

                    break;
                end;
            end;
        end;

        return v31;
    end;

    function u10.GeneratePlayerDailyQuest(p33: table, p34: number, p35: boolean, p36: number) -- Line: 188
        local v37 = {};

        for _, v in p33.RandomBatch(p34, p35, p36) do
            local v38 = {
                Claimed = false,
                Id = v.Id,
                Progress = table.create(#v.Requirements, 0)
            };
            table.insert(v37, v38);
        end;

        return v37;
    end;
end)();
u10.list = {
    new("Score 5 times").Requirement("Score", 5).Reward("Cash", 300).SetWeight(5),
    new("Score 8 times").Requirement("Score", 8).Reward("Cash", 500).SetWeight(2.5),
    new("Successfully dribble someone 15 times").Requirement("DribbleSuccess", 15).Reward("Cash", 300).SetWeight(6),
    new("Successfully dribble someone 30 times").Requirement("DribbleSuccess", 30).Reward("Cash", 600).SetWeight(2),
    new("Awaken 3 times").Requirement("Awaken", 3).Reward("Cash", 300).SetWeight(6.5),
    new("Awaken 5 times").Requirement("Awaken", 5).Reward("Cash", 500).SetWeight(3.5),
    new("Win a round 3 times").Requirement("Win", 3).Reward("Cash", 300).SetWeight(4.5),
    new("Win a round 6 times").Requirement("Win", 6).Reward("Cash", 600).SetWeight(3)
};

return u10;