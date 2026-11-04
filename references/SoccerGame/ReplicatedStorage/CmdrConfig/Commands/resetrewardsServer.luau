  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Ranked.RankedData);

return function(p1, p2) -- Line: 5
    -- upvalues: Knit (copy)
    local SeasonData = Knit.GetService("RankedService"):GetSeasonData(p2);

    if not SeasonData then
        return "No season data found for " .. p2.Name;
    end;

    SeasonData.RankRewards = {};

    return "Reset all claimed rank rewards for " .. p2.Name;
end;