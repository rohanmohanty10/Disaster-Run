  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
game:GetService("ReplicatedStorage");

return function(p1, p2, p3) -- Line: 4
    -- upvalues: ProfileManager (copy)
    local v4 = ProfileManager.Profiles[p2];

    for i, _ in v4.Data.BundlePurchases do
        v4.Data.BundlePurchases[i] = 0;
    end;
end;