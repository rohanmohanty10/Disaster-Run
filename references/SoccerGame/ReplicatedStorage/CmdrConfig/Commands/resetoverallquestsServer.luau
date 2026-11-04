  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1, p2) -- Line: 4
    -- upvalues: Knit (copy)
    local v3, v4 = Knit.GetService("SalaryService"):AdminResetOverallQuests(p2);

    if v3 then
        return string.format("Reset %s\'s overall quests", p2.Name);
    end;

    return "Failed: " .. tostring(v4);
end;