  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local environment = require(ReplicatedStorage.Shared.environment);

return function(p1, u2, u3, u4) -- Line: 5
    -- upvalues: environment (copy), ProfileManager (copy)
    local success, result = pcall(function() -- Line: 6
        -- upvalues: u2 (copy)
        return game.Players:GetUserIdFromNameAsync(u2);
    end);

    if not (success and result) then
        return `{u2} is not a valid player name.`;
    end;

    ProfileManager.GameProfileStore:GlobalUpdateProfileAsync(environment.env == "Main" and "Player" .. result or "Player" .. result .. "_v7", function(p5) -- Line: 15
        -- upvalues: u3 (copy), u4 (copy)
        p5:AddActiveUpdate({
            Type = "setstyleglobal",
            Slot = u3,
            Style = u4
        });
    end);

    return `Queued style "{u4}" (Slot{u3}) for {u2}`;
end;