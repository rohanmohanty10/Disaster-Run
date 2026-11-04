  

local v1 = {};
game:GetService("ReplicatedStorage");
local GBRequests = require(script.Parent.GBRequests);
require(script.Parent.Utilities);

function v1.GetCohortMembershipStatusAsync(p2: table, p3: string, p4: table) -- Line: 37
    -- upvalues: GBRequests (copy)
    local v5, v6 = GBRequests:GBRequestAsync("v1/cohorts/membership", {
        cohortName = p3,
        userIds = p4
    });

    if not v5 then
        error("Failed to get cohort membership status: " .. tostring(v6));

        return;
    end;

    if v6.cohortExists ~= false then
        local v7 = {};

        for _, v in v6.users do
            v7[v.userId] = v.isMember;
        end;

        return v7;
    end;

    error("Cohort \'" .. p3 .. "\' does not exist.", 3);
end;

function v1.Init(p8) -- Line: 61
end;

return v1;