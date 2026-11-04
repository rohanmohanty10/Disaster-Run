  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit);

return function(p1, p2, p3) -- Line: 4
    -- upvalues: ProfileManager (copy), Knit (copy)
    local v4 = ProfileManager.Profiles[p2];

    if not v4 then
        return `{p2.Name} has no loaded profile.`;
    end;

    local v5 = v4.Data.Gamepasses[p3] ~= nil;

    if not Knit.GetService("MarketService"):RemoveGamepass(p2, p3) then
        return `Could not remove {p3} from {p2.Name}.`;
    end;

    if v5 then
        return `Removed {p3} from {p2.Name}.`;
    end;

    return `{p2.Name} didn't own {p3} (nothing to remove).`;
end;