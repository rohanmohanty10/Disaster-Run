  

local u1 = {};

for _, child in script:GetChildren() do
    local v2 = require(child);
    v2.__rankName = child.Name;
    table.insert(u1, v2);
end;

table.sort(u1, function(p3, p4) -- Line: 61
    return p3.Tiers[#p3.Tiers] < p4.Tiers[#p4.Tiers];
end);
local u5 = {
    Season = 1,
    DefaultElo = 1000,
    DisplayMinElo = 1000,
    AbandonPenalty = 50,
    MinimumElo = 1000,
    MVPEloBonus = 5,
    BaseEloPerWin = 20,
    BaseEloPerLoss = 12,
    MaxEloGain = 95,
    PlacementMatches = 5,
    MaxPlacementElo = 3000,
    MinPlacementElo = 1000,
    MatchHistoryLimit = 50,
    ExpiresAt = DateTime.fromUniversalTime(2026, 7, 18, 17).UnixTimestamp,
    DivisionEloRanges = { 150, 150, 200 },
    Ranks = u1
};

function u5.GetRank(p6: number) -- Line: 92
    -- upvalues: u5 (copy), u1 (copy)
    local v7 = u5.DivisionEloRanges[1];
    local v8 = u5.DivisionEloRanges[2];
    local v9 = u5.DivisionEloRanges[3];

    for _, v in pairs(u5.Ranks) do
        local MinElo = v.MinElo;

        if MinElo <= p6 and p6 <= (v.MaxElo or MinElo + v7 + v8 + v9) then
            local v10 = p6 - (v.__rankName == "Rookie" and (u5.DisplayMinElo or 1000) or MinElo);

            if v10 < v7 then
                return v.__rankName, 1, v;
            end;

            if v10 < v7 + v8 then
                return v.__rankName, 2, v;
            end;

            return v.__rankName, 3, v;
        end;
    end;

    return "Rookie", 1, u1[1];
end;

function u5.GetDivisionProgress(p11: number) -- Line: 123
    -- upvalues: u5 (copy)
    local Rank, v12, v13 = u5.GetRank(p11);
    local v14 = Rank == "Rookie" and (u5.DisplayMinElo or 1000) or v13.MinElo;
    local v15 = u5.DivisionEloRanges[1];
    local v16 = u5.DivisionEloRanges[2];
    local v17 = u5.DivisionEloRanges[3];

    if v12 == 1 then
        v17 = v15;
    elseif v12 == 2 then
        v14 = v14 + v15;
        v17 = v16;
    else
        v14 = v14 + v15 + v16;
    end;

    return math.clamp((p11 - v14) / v17, 0, 1);
end;

function u5.GetNextRank(p18: number) -- Line: 150
    -- upvalues: u5 (copy)
    local Rank, v19, v20 = u5.GetRank(p18);

    if v19 < 3 then
        return Rank, v19 + 1, v20;
    end;

    local v21 = nil;

    for i, v in u5.Ranks do
        if v.__rankName == Rank then
            v21 = i;
        end;
    end;

    if not v21 then
        return Rank, v19, v20;
    end;

    local v22 = u5.Ranks[v21 + 1];

    if v22 then
        return v22.__rankName, 1, v22;
    end;
end;

function u5.GetRankFromName(p23: table, p24: string) -- Line: 176
    -- upvalues: u1 (copy)
    for i, v in u1 do
        if v.__rankName == p24 then
            return v, i;
        end;
    end;
end;

function u5.GetMilestoneInfo(p25: string, p26: number) -- Line: 184
    -- upvalues: u1 (copy)
    for _, v in u1 do
        if v.__rankName == p25 then
            return v.Milestones[p26];
        end;
    end;
end;

function u5.GetSeason(p27) -- Line: 192
    -- upvalues: u5 (copy)
    return "Season" .. u5.Season;
end;

function u5.PopulateMilestones(p28) -- Line: 197
    -- upvalues: u1 (copy)
    local v29 = {};

    for _, v in u1 do
        v29[v.__rankName] = {};
        local v30 = v;

        for _, _ in v.Milestones do
            table.insert(v29[v30.__rankName], {
                Tracker = 0,
                Claimed = false,
                CanClaim = false
            });
        end;
    end;

    return v29;
end;

function u5.GetRankOrder(p31: string, p32: number) -- Line: 221
    -- upvalues: u5 (copy)
    for i, v in u5.Ranks do
        if v.__rankName == p31 then
            return i * 10 + (p32 or 1);
        end;
    end;

    return 0;
end;

function u5.GetRewardSlots() -- Line: 234
    -- upvalues: u5 (copy)
    local v33 = {};

    for _, v in u5.Ranks do
        if v.__rankName ~= "Rookie" then
            local RankRewards = v.RankRewards;

            if RankRewards then
                if v.LastRank then
                    table.insert(v33, {
                        Division = 1,
                        RankName = v.__rankName,
                        Reward = RankRewards[1],
                        BadgeImage = v.DivisionImages and v.DivisionImages[1] or ""
                    });
                else
                    local v34 = v;

                    for i = 1, 3 do
                        local v35;

                        if RankRewards[i] then
                            table.insert(v33, {
                                RankName = v34.__rankName,
                                Division = i,
                                Reward = RankRewards[i],
                                BadgeImage = v34.DivisionImages and (v34.DivisionImages[i] or "") or ""
                            });
                            v35 = i;
                        else
                            v35 = i;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v33;
end;

return u5;