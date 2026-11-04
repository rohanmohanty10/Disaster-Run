 

 

local u1 = {
    EventId = "Halloween2026",
    EndsAt = DateTime.fromUniversalTime(2026, 11, 7, 18, 0, 0).UnixTimestamp,
    Max = 1000000,
    Icon = "rbxassetid://119759573303359",
    KillDrop = table.freeze({ 2, 4 }),
    QuestMin = 100,
    QuestMax = 200,
    QuestJourneyXP = 200,
    Round = table.freeze({
        Base = 5,
        Safe = 10,
        Rescue = 5,
        Catch = 5,
        Max = 25
    })
};

local function whole(p2, p3) -- Line: 28
    local v4;

    if type(p2) == "number" and (p2 == p2 and (p2 % 1 == 0 and p2 >= 0)) then
        v4 = p2 <= p3;
    else
        v4 = false;
    end;

    return v4;
end;

function u1.active(p5) -- Line: 33
    -- upvalues: u1 (copy)
    return (p5 or os.time()) < u1.EndsAt;
end;

function u1.balance(p6, p7) -- Line: 38
    -- upvalues: u1 (copy)
    if type(p6) ~= "table" or (p6.candyCornEvent ~= u1.EventId or not u1.active(p7)) then
        return 0;
    end;

    local candyCorn = p6.candyCorn;
    local Max = u1.Max;
    local v8;

    if type(candyCorn) == "number" and (candyCorn == candyCorn and (candyCorn % 1 == 0 and candyCorn >= 0)) then
        v8 = candyCorn <= Max;
    else
        v8 = false;
    end;

    return not v8 and 0 or p6.candyCorn;
end;

function u1.add(p9, p10, p11) -- Line: 46
    -- upvalues: u1 (copy)
    if u1.active(p11) then
        local Max = u1.Max;
        local v12;

        if type(p10) == "number" and (p10 == p10 and (p10 % 1 == 0 and p10 >= 0)) then
            v12 = p10 <= Max;
        else
            v12 = false;
        end;

        if v12 then
            local Max2 = u1.Max;
            local v13 = u1.balance(p9, p11) + p10;
            p9.candyCorn = math.min(Max2, v13);
            p9.candyCornEvent = u1.EventId;

            return true;
        end;
    end;

    return false;
end;

function u1.spend(p14, p15, p16) -- Line: 56
    -- upvalues: u1 (copy)
    local v17 = u1.balance(p14, p16);
    local Max = u1.Max;
    local v18;

    if type(p15) == "number" and (p15 == p15 and (p15 % 1 == 0 and p15 >= 0)) then
        v18 = p15 <= Max;
    else
        v18 = false;
    end;

    if not v18 or v17 < p15 then
        return false;
    end;

    p14.candyCorn = v17 - p15;
    p14.candyCornEvent = u1.EventId;

    return true;
end;

function u1.normalize(p19, p20) -- Line: 67
    -- upvalues: u1 (copy)
    if p19.candyCorn == nil and p19.candyCornEvent == nil then
        return p19;
    end;

    if p19.candyCornEvent == u1.EventId and u1.active(p20) then
        local candyCorn = p19.candyCorn;
        local Max = u1.Max;
        local v21;

        if type(candyCorn) == "number" and (candyCorn == candyCorn and (candyCorn % 1 == 0 and candyCorn >= 0)) then
            v21 = candyCorn <= Max;
        else
            v21 = false;
        end;

        if not v21 then
            p19.candyCorn = nil;
            p19.candyCornEvent = nil;
        end;
    else
        p19.candyCorn = nil;
        p19.candyCornEvent = nil;
    end;

    return p19;
end;

return table.freeze(u1);