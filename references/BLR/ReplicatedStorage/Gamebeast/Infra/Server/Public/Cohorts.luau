  

local v1 = {};
game:GetService("ReplicatedStorage");
local InternalCohorts = require(script.Parent.Parent.Modules.InternalCohorts);

function v1.GetCohortMembershipStatusAsync(p2: table, p3: string, p4: table) -- Line: 36
    -- upvalues: InternalCohorts (copy)
    return InternalCohorts:GetCohortMembershipStatusAsync(p3, p4);
end;

return v1;