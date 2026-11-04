  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
require(game.ServerScriptService.Profile.ProfileService);
local environment = require(ReplicatedStorage.Shared.environment);

return function(p1, u2, u3) -- Line: 6
    -- upvalues: environment (copy), ProfileManager (copy)
    local success, result = pcall(function() -- Line: 7
        -- upvalues: u2 (copy)
        return game.Players:GetUserIdFromNameAsync(u2);
    end);
    print(success, result, u3);

    if not (success and result) then
        return `{u2} is not a valid player name.`;
    end;

    ProfileManager.GameProfileStore:GlobalUpdateProfileAsync(environment.env == "Main" and "Player" .. result or "Player" .. result .. "_v7", function(p4) -- Line: 17
        -- upvalues: u3 (copy)
        p4:AddActiveUpdate({
            Type = "gamepassv2",
            ID = u3
        });
    end);
end;