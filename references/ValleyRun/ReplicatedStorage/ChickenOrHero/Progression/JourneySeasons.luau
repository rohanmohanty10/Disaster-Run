 

 

local v1 = {
    ActiveSeason = "season_1",
    Seasons = {
        season_1 = {
            Number = 1,
            Name = "THE FIRST CROSSING",
            TrackId = "valley_journey_1",
            PremiumPassId = 1988852667,
            RewardsModule = "JourneySeason1Rewards",
            MaxTier = 30,
            FirstTierXP = 150,
            TierStepXP = 25,
            EndsAt = 1792256400
        },
        season_2 = {
            Number = 2,
            Name = "HAUNTED HARVEST",
            TrackId = "valley_journey_2",
            PremiumPassId = 2037321030,
            RewardsModule = "JourneySeason2Rewards",
            MaxTier = 30,
            FirstTierXP = 150,
            TierStepXP = 25,
            EndsAt = 1794074400
        }
    }
};

if game.PlaceId == 130574217370467 or (game:GetService("RunService"):IsStudio() or os.time() >= v1.Seasons.season_1.EndsAt) then
    v1.ActiveSeason = "season_2";
end;

local v2 = {};
local v3 = {};

for _, v in v1.Seasons do
    local v4;

    if type(v.TrackId) == "string" then
        v4 = not v2[v.TrackId];
    else
        v4 = false;
    end;

    assert(v4, "Every Journey season needs a unique TrackId");
    v2[v.TrackId] = true;
    local v5;

    if type(v.PremiumPassId) == "number" and v.PremiumPassId >= 0 then
        v5 = v.PremiumPassId % 1 == 0;
    else
        v5 = false;
    end;

    assert(v5, "Invalid season pass");

    if v.PremiumPassId > 0 then
        assert(not v3[v.PremiumPassId], "Each season needs its own premium pass");
        v3[v.PremiumPassId] = true;
    end;

    local v6;

    if v.MaxTier >= 1 and v.MaxTier <= 100 then
        v6 = v.MaxTier % 1 == 0;
    else
        v6 = false;
    end;

    assert(v6, "Invalid season tier count");
    local v7;

    if v.FirstTierXP > 0 then
        v7 = v.TierStepXP >= 0;
    else
        v7 = false;
    end;

    assert(v7, "Invalid season XP curve");
end;

assert(v1.Seasons[v1.ActiveSeason], "Unknown active Journey season");

return v1;