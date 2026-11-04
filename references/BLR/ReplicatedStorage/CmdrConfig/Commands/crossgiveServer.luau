  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
require(game.ServerScriptService.Profile.ProfileService);
local environment = require(game:GetService("ReplicatedStorage").Shared.environment);

return function(p1, u2, u3, u4) -- Line: 5
    -- upvalues: environment (copy), ProfileManager (copy)
    local success, result = pcall(function() -- Line: 6
        -- upvalues: u2 (copy)
        return game.Players:GetUserIdFromNameAsync(u2);
    end);
    print(success, result);

    if not (success and result) then
        return `{u2} is not a valid player name.`;
    end;

    ProfileManager.GameProfileStore:GlobalUpdateProfileAsync(environment.env == "Dev" and "Player" .. result .. "_v7" or "Player" .. result, function(p5) -- Line: 15
        -- upvalues: u3 (copy), u4 (copy)
        p5:AddActiveUpdate({
            Type = "crossgive",
            Item = u3,
            Amount = u4
        });
    end);

    return `Queued {u4} {u3} for {u2}`;
end;