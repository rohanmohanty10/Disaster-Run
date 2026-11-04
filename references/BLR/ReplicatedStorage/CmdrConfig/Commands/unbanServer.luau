  

require(game.ServerScriptService.Profile.ProfileManager);
require(game.ServerScriptService.Profile.ProfileService);
require(game.ServerScriptService.CheaterYeeter);

return function(p1, u2, p3) -- Line: 5
    local success, result = pcall(function() -- Line: 6
        -- upvalues: u2 (copy)
        return game.Players:GetUserIdFromNameAsync(u2);
    end);

    if not (success and result) then
        return `{u2} is not a valid player name.`;
    end;

    local success2, result2 = pcall(function() -- Line: 12
        -- upvalues: result (copy)
        game.Players:UnbanAsync({
            ApplyToUniverse = true,
            UserIds = { result }
        });
    end);

    if success2 then
        return `Unbanned {u2}.`;
    end;

    return `Unban failed: {result2}`;
end;