  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
require(game.ServerScriptService.Profile.ProfileService);

return function(p1, u2, u3) -- Line: 4
    -- upvalues: ProfileManager (copy)
    local success, result = pcall(function() -- Line: 5
        -- upvalues: u2 (copy)
        return game.Players:GetUserIdFromNameAsync(u2);
    end);
    print(success, result, u3);

    if not (success and result) then
        return `{u2} is not a valid player name.`;
    end;

    ProfileManager.GameProfileStore:GlobalUpdateProfileAsync("Player" .. result, function(p4) -- Line: 12
        -- upvalues: u3 (copy)
        p4:AddActiveUpdate({
            Type = "cosmetic",
            ID = u3
        });
    end);
end;