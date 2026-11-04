  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);

return function(p1, p2, p3) -- Line: 3
    -- upvalues: ProfileManager (copy)
    require(game.ServerScriptService.Modules.utils.giveItem)(ProfileManager.Get(p2, true).Data, "MVPCutscene", p3);
end;