  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local PolicyChecker = require(game.ServerScriptService.Modules.utils.PolicyChecker);
local environment = require(ReplicatedStorage.Shared.environment);

return function(p1, p2, p3) -- Line: 8
    -- upvalues: environment (copy), RunService (copy), ProfileManager (copy), PolicyChecker (copy)
    if environment.env == "Main" and not RunService:IsStudio() then
        return "rollmode is only available in test environments";
    end;

    if p3 ~= "normal" and (p3 ~= "preroll" and p3 ~= "auto") then
        return "invalid mode (use normal, preroll or auto)";
    end;

    local v4 = ProfileManager.Profiles[p2];

    if not v4 then
        return p2.Name .. " has no loaded profile.";
    end;

    local v5;

    if p3 == "auto" or not p3 then
        v5 = nil;
    else
        v5 = p3;
    end;

    v4.Data.TestRollMode = v5;
    PolicyChecker.Check(p2, v4.Data.TestRollMode);
    local v6 = p2:GetAttribute("RNGRestricted") == true;

    return ("%s rollmode=%s (now %s) - REJOIN to update the spin UI"):format(p2.Name, p3, v6 and "preroll/free-buy" or "normal RNG");
end;