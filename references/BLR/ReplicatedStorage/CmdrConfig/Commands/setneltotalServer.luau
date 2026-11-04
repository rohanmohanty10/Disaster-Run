  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1, p2, p3) -- Line: 4
    -- upvalues: Knit (copy)
    local v4, v5 = Knit.GetService("SalaryService"):AdminSetTotal(p2, p3);

    if not v4 then
        return "Failed: " .. tostring(v5);
    end;

    if p3 < 0 then
        return string.format("Cleared %s\'s skill Total override", p2.Name);
    end;

    return string.format("Set %s\'s skill Total to %d", p2.Name, (math.clamp(p3, 0, 100)));
end;