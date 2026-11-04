  

local ServerScriptService = game:GetService("ServerScriptService");
require(game.ServerScriptService.Profile.ProfileManager);
require(game.ServerScriptService.Profile.ProfileService);
require(game.ServerScriptService.CheaterYeeter);
local GlobalService = require(ServerScriptService.KnitServer.Services.GlobalService);

return function(p1, p2, p3, p4, p5) -- Line: 8
    -- upvalues: GlobalService (copy)
    print(p2, p3, p4, p5);
    GlobalService:BoostRarityChances(p2, p3, math.clamp(p4, 0, 3600), p5, p1.Executor.UserId);
end;