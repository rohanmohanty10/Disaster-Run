  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AdvanceUbersRules = require(ReplicatedStorage.Shared.AdvanceUbersRules);
local getActiveFlowStats = require(ReplicatedStorage.Shared.utils.getActiveFlowStats);

local function getCooldownSpeed(p1: any, p2: string, p3: string, p4: string?) -- Line: 5
    -- upvalues: getActiveFlowStats (copy)
    local v5, v6 = getActiveFlowStats(p1);
    local v7 = v6 and v6.Stats or {};

    if v7.AbilityCooldown then
        return v7.AbilityCooldown;
    end;

    if v5 == "Trap" then
        if p3 == "AirDribble" or p3 == "AirDash" then
            return 0.5;
        end;
    else
        if v5 == "Godspeed" then
            return 0.65;
        end;

        if v5 == "Emperor" then
            return 0.8;
        end;
    end;

    return 1;
end;

return function(p8, p9, p10, p11) -- Line: 25
    -- upvalues: getCooldownSpeed (copy), AdvanceUbersRules (copy)
    return getCooldownSpeed(p8, p9, p10, p11) * AdvanceUbersRules.multiplier(p8.Character, "Cooldown");
end;