 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local v1 = Knit.CreateController({
    Name = "FeatureFlagController"
});

function v1.GetFeatureFlag(p2, p3) -- Line: 9
    if typeof(p3) ~= "string" then
        error((`{p3} is not a string!`));
    end;

    if p2.featureFlags == nil then
        return false;
    end;

    local v4 = p2.featureFlags[p3];

    if v4 ~= nil then
        return v4;
    end;

    warn((`There is no feature flag named "{p3}"!`));

    return false;
end;

function v1.Observe(p5, p6, p7) -- Line: 27
    if p5.subscriptions[p6] == nil then
        p5.subscriptions[p6] = {};
    end;

    table.insert(p5.subscriptions[p6], p7);
    p7(p5.featureFlags[p6]);
end;

function v1.KnitStart(u8) -- Line: 37
    -- upvalues: Knit (copy)
    u8.FeatureFlagService = Knit.GetService("FeatureFlagService");
    u8.featureFlags = {};
    u8.subscriptions = {};
    u8.FeatureFlagService.FFlags:Observe(function(p9) -- Line: 43
        -- upvalues: u8 (copy)
        local table_clone_ret = table.clone(u8.featureFlags);
        u8.featureFlags = p9;

        for i, v in p9 do
            if v ~= table_clone_ret[i] and u8.subscriptions[i] ~= nil then
                local v10 = i;

                for _, v2 in u8.subscriptions[i] do
                    v2(p9[v10]);
                end;
            end;
        end;
    end);
end;

return v1;