  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
require(game.ServerScriptService.Profile.ProfileService);

return function(p1, p2, p3) -- Line: 4
    -- upvalues: ProfileManager (copy)
    require(game.ServerScriptService.Modules.utils.giveItem)(ProfileManager.Get(p2, true).Data, "Cosmetic", p3);
end;