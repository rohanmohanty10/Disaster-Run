  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local removeItem = require(game.ServerScriptService.Modules.utils.removeItem);

return function(p1, p2, p3) -- Line: 4
    -- upvalues: ProfileManager (copy), removeItem (copy)
    local v4 = ProfileManager.Profiles[p2];

    if v4 then
        return removeItem(v4.Data, p3);
    end;

    return `{p2.Name} has no loaded profile.`;
end;