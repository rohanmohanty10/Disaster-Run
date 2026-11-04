  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local RankedData = require(ReplicatedStorage.Shared.Ranked.RankedData);

return function(p1, p2, p3, p4) -- Line: 5
    -- upvalues: Knit (copy), RankedData (copy)
    local v5 = p4 or "5v5";

    if v5 ~= "5v5" and v5 ~= "2v2" then
        return "Invalid mode. Use 5v5 or 2v2.";
    end;

    local SeasonData = Knit.GetService("RankedService"):GetSeasonData(p2, v5);

    if not SeasonData then
        return "No season data found for " .. p2.Name;
    end;

    SeasonData.Elo = p3;
    SeasonData.HighestElo = p3;
    local Rank, v6 = RankedData.GetRank(p3);

    return "Set " .. p2.Name .. " Elo to " .. p3 .. " (" .. Rank .. " Div " .. v6 .. ") in " .. v5;
end;