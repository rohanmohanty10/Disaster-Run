  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1, p2, p3, p4) -- Line: 4
    -- upvalues: Knit (copy)
    local v5, v6 = Knit.GetService("SalaryService"):AdminSetTeamLifetime(p2, p3, p4);

    if v5 then
        return string.format("Set %s\'s lifetime yen on %s to %d", p2.Name, p3, p4);
    end;

    return "Failed: " .. tostring(v6);
end;