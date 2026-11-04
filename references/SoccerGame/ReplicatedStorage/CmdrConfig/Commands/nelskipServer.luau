  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1, p2, p3) -- Line: 4
    -- upvalues: Knit (copy)
    local v4, v5 = Knit.GetService("SalaryService"):AdminAdvanceRounds(p2, p3 or 1);

    if v4 then
        return string.format("Advanced %s\'s career by %d round(s)", p2.Name, p3 or 1);
    end;

    return "Failed: " .. tostring(v5);
end;