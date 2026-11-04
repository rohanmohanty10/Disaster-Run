  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1, p2) -- Line: 4
    -- upvalues: Knit (copy)
    local success, result = pcall(Knit.GetService, "BlueLockCupService");

    return not (success and result) and "BlueLockCupService not available" or result:AdminResetTopRewardTest(p2);
end;