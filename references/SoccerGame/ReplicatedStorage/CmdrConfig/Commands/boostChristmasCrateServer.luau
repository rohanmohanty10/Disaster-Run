  

local ServerScriptService = game:GetService("ServerScriptService");
require(game.ServerScriptService.Profile.ProfileManager);
require(game.ServerScriptService.Profile.ProfileService);
require(game.ServerScriptService.CheaterYeeter);
local GlobalService = require(ServerScriptService.KnitServer.Services.GlobalService);

return function(p1, p2) -- Line: 8
    -- upvalues: GlobalService (copy)
    GlobalService:BoostChristmasCrate((math.clamp(p2, 0, 3600)));
end;