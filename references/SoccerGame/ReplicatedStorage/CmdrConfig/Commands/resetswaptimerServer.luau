  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1, p2) -- Line: 4
    -- upvalues: Knit (copy)
    local success, result = pcall(Knit.GetService, "SalaryService");

    return not (success and result) and "SalaryService not available" or result:AdminResetTeamSwapCooldown(p2);
end;