  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local environment = require(ReplicatedStorage.Shared.environment);

return function(p1, u2, u3) -- Line: 5
    -- upvalues: environment (copy), ProfileManager (copy)
    local success, result = pcall(function() -- Line: 6
        -- upvalues: u2 (copy)
        return game.Players:GetUserIdFromNameAsync(u2);
    end);

    if not (success and result) then
        return `{u2} is not a valid player name.`;
    end;

    ProfileManager.GameProfileStore:GlobalUpdateProfileAsync(environment.env == "Main" and "Player" .. result or "Player" .. result .. "_v7", function(p4) -- Line: 15
        -- upvalues: u3 (copy)
        p4:AddActiveUpdate({
            Type = "cardglobal",
            Name = u3
        });
    end);

    return `Queued card "{u3}" for {u2}`;
end;