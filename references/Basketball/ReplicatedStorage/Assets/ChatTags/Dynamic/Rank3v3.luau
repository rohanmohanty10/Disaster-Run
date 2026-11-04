 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local RankingBrackets = require(ReplicatedStorage.Shared.Tables.RankingBrackets);

return function(p1: userdata) -- Line: 9
    -- upvalues: Knit (copy), RankingBrackets (copy)
    local Service = Knit.GetService("StatsService");

    while not Service.Players[p1.Name] do
        if not p1:IsDescendantOf(game) then
            return;
        end;

        task.wait();
    end;

    local v2 = Service.Players[p1.Name];
    local _ = v2.Ranked["3v3"].RR;
    local v3, v4;

    if v2.Ranked["3v3"].MatchesUntilPlacement == 0 then
        v3, v4 = RankingBrackets:GetRankFromRR(v2.Ranked["3v3"].RR);
    else
        v3 = "Unplaced";
        v4 = nil;
    end;

    local v5 = RankingBrackets.ChatTags[v3];
    local v6 = {};
    local v7;

    if v4 then
        v7 = `{v5[1]}-{string.rep("I", v4)}`;
    else
        v7 = v5[1];
    end;

    v6.tag = `3v3 {v7}`;
    v6.color = ColorSequence.new(Color3.fromHex(v5[2]));

    return v6;
end;