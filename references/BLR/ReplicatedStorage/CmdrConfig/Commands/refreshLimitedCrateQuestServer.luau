  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1, p2) -- Line: 5
    -- upvalues: ProfileManager (copy), Knit (copy)
    local _ = ProfileManager.Profiles[p2];
    Knit.GetService("LimitedCrateService"):RefreshQuests(p2);
end;