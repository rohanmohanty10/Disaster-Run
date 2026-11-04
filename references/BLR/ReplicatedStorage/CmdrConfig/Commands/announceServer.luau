  

require(game.ServerScriptService.Profile.ProfileManager);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1, p2) -- Line: 5
    -- upvalues: Knit (copy)
    Knit.GetService("GlobalService"):Broadcast(`{p2}`, p1.Executor.UserId);
end;