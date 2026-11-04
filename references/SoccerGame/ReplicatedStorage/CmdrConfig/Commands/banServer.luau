  

game:GetService("ReplicatedStorage");
require(game.ServerScriptService.Profile.ProfileManager);
require(game.ServerScriptService.Profile.ProfileService);
require(game.ServerScriptService.CheaterYeeter);

return function(u1, u2, u3, u4) -- Line: 7
    local success, result = pcall(function() -- Line: 8
        -- upvalues: u2 (copy)
        return game.Players:GetUserIdFromNameAsync(u2);
    end);

    if not (success and result) then
        return `{u2} is not a valid player name.`;
    end;

    local success2, result2 = pcall(function() -- Line: 17
        -- upvalues: result (copy), u3 (copy), u4 (copy), u1 (copy)
        local game_Players = game.Players;
        local v5 = {
            UserIds = { result },
            Duration = u3,
            DisplayReason = string.sub(u4, 1, 400)
        };
        local v6 = `[MANUAL BAN BY {u1.Executor.Name}] {u4}`;
        v5.PrivateReason = string.sub(v6, 1, 1000);
        game_Players:BanAsync(v5);
    end);

    if not success2 then
        return `Ban failed: {result2}`;
    end;

    local v7;

    if u3 == -1 then
        v7 = "permanently";
    elseif u3 < 3600 then
        v7 = `for {u3 // 60} minutes`;
    elseif u3 < 86400 then
        v7 = `for {u3 // 3600} hours`;
    else
        v7 = `for {u3 // 86400} days`;
    end;

    return `Banned {u2} {v7}. Reason: {u4}`;
end;