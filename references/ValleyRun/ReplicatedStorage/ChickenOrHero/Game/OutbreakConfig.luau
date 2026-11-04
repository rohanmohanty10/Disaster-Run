 

 

local u1 = {
    Knife = "InfectedKnife",
    TEST_PLACE = 130574217370467,
    StartsAt = DateTime.fromUniversalTime(2026, 10, 20, 19, 0, 0).UnixTimestamp,
    TestStartsAt = DateTime.fromUniversalTime(2026, 10, 19, 0, 0, 0).UnixTimestamp,
    Days = 11,
    FullAfterDays = 10,
    Curve = 1.6,
    Milestones = { {
            at = 0.25,
            id = "Candy",
            name = "500 Candy Corn",
            detail = "For everyone infected",
            reward = {
                candy = 500
            }
        }, {
            at = 0.5,
            id = "Title",
            name = "Patient Zero title",
            detail = "For everyone infected",
            reward = {
                title = "PatientZero"
            }
        }, {
            at = 0.8,
            id = "Knife",
            name = "Knife VFX",
            detail = "The Infected Knife\'s particles come alive"
        }, {
            at = 1,
            id = "Emote",
            name = "Infected emote",
            detail = "Patient Zero emote",
            reward = {
                emote = "PatientZero"
            }
        } },
    Emote = "PatientZero",
    Title = "PatientZero",
    Tiers = { {
            kills = 1,
            name = "100 Candy Corn",
            reward = {
                candy = 100
            }
        }, {
            kills = 5,
            name = "Free Treat Crate",
            reward = {
                crate = "HalloweenTreat"
            }
        }, {
            kills = 10,
            name = "1,000 Candy Corn",
            reward = {
                candy = 1000
            }
        }, {
            kills = 25,
            name = "Plague Bearer title",
            reward = {
                title = "PlagueBearer"
            }
        }, {
            kills = 50,
            name = "All Halloween Crates x2",
            reward = {
                count = 2,
                crates = { "HalloweenTrick", "HalloweenTreat", "HalloweenEmote" }
            }
        } }
};

local function startsAt() -- Line: 43
    -- upvalues: u1 (copy)
    if game.PlaceId == u1.TEST_PLACE then
        return u1.TestStartsAt;
    end;

    return u1.StartsAt;
end;

function u1.startsAt() -- Line: 46
    -- upvalues: u1 (copy)
    if game.PlaceId == u1.TEST_PLACE then
        return u1.TestStartsAt;
    end;

    return u1.StartsAt;
end;

function u1.endsAt() -- Line: 49
    -- upvalues: u1 (copy)
    local v2;

    if game.PlaceId == u1.TEST_PLACE then
        v2 = u1.TestStartsAt;
    else
        v2 = u1.StartsAt;
    end;

    return v2 + u1.Days * 86400;
end;

function u1.active(p3) -- Line: 53
    -- upvalues: u1 (copy)
    local v4 = false;
    local v5;

    if game.PlaceId == u1.TEST_PLACE then
        v5 = u1.TestStartsAt;
    else
        v5 = u1.StartsAt;
    end;

    if v5 <= p3 then
        v4 = p3 < u1.endsAt();
    end;

    return v4;
end;

function u1.progress(p6) -- Line: 58
    -- upvalues: u1 (copy)
    if game.PlaceId == u1.TEST_PLACE then
        local Attribute = script.Parent:GetAttribute("OutbreakTestPercent");

        if type(Attribute) == "number" then
            return math.clamp(Attribute / 100, 0, 1);
        end;
    end;

    local v7;

    if game.PlaceId == u1.TEST_PLACE then
        v7 = u1.TestStartsAt;
    else
        v7 = u1.StartsAt;
    end;

    return math.clamp((p6 - v7) / (u1.FullAfterDays * 86400), 0, 1) ^ u1.Curve;
end;

function u1.reached(p8, p9) -- Line: 69
    -- upvalues: u1 (copy)
    for _, v in u1.Milestones do
        if v.id == p8 then
            return u1.progress(p9) >= v.at - 1e-9;
        end;
    end;

    return false;
end;

return u1;