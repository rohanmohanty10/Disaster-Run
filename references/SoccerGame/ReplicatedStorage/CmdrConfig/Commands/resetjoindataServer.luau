  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
require(game.ServerScriptService.Profile.ProfileService);
require(game.ServerScriptService.CheaterYeeter);

return function(p1) -- Line: 5
    -- upvalues: ProfileManager (copy)
    local Executor = p1.Executor;
    local u2 = ProfileManager.Profiles[Executor];
    u2.Data.JoinedBefore = nil;
    u2:ListenToRelease(function() -- Line: 10
        -- upvalues: u2 (copy)
        u2.Data.JoinedBefore = nil;
    end);
    Executor:Kick("rejoin");
end;