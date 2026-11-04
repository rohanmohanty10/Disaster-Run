  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1, p2, p3, p4) -- Line: 5
    -- upvalues: Knit (copy)
    local success, result = pcall(Knit.GetService, "BlueLockCupService");

    return not (success and result) and "BlueLockCupService not available" or result:AdminForcePick(p2, string.upper(p3), p4);
end;