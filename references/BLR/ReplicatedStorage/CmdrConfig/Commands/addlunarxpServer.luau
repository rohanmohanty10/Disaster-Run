  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
game:GetService("ReplicatedStorage");

return function(p1, p2, p3) -- Line: 4
    -- upvalues: ProfileManager (copy)
    local EventXP = ProfileManager.Profiles[p2].Data.EventXP;
    EventXP.Lunar = EventXP.Lunar + p3;
end;