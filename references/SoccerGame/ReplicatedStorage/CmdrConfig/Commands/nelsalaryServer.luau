  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1, p2, p3) -- Line: 4
    -- upvalues: Knit (copy)
    local v4, v5 = Knit.GetService("SalaryService"):AdminSetCareerYen(p2, p3);

    if v4 then
        return string.format("Set %s\'s career yen to %d", p2.Name, p3);
    end;

    return "Failed: " .. tostring(v5);
end;