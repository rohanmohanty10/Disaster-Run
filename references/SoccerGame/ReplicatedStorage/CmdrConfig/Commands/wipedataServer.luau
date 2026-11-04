  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
require(game.ServerScriptService.Profile.ProfileService);
require(game.ServerScriptService.CheaterYeeter);

return function(p1, u2) -- Line: 5
    -- upvalues: ProfileManager (copy)
    u2:SetAttribute("WipingData", true);
    local v3 = ProfileManager.Profiles[u2];
    table.clear(v3.Data);
    v3.Data._has_checked_onboarding = false;

    if not v3 then
        u2:Kick("Data wipe");

        return;
    end;

    v3.Teleporting = true;
    v3:ListenToHopReady(function() -- Line: 14
        -- upvalues: u2 (copy)
        u2:Kick("Data wipe");
    end);
    v3:Release();
end;