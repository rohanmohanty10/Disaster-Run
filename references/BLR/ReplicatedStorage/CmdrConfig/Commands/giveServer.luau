  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
require(game.ServerScriptService.Profile.ProfileService);

return function(p1, u2, p3, p4) -- Line: 4
    -- upvalues: ProfileManager (copy)
    local success, result = pcall(function() -- Line: 5
        -- upvalues: u2 (copy)
        return game.Players:GetUserIdFromNameAsync(u2);
    end);
    print(success, result);

    if not (success and result) then
        return `{u2} is not a valid player name.`;
    end;

    local v5 = ProfileManager.Profiles[u2];

    if p3 == "styleSlot" then
        v5.Data.StyleSlots.MaxSlot = math.clamp(v5.Data.StyleSlots.MaxSlot + 1, 1, 8);

        return;
    end;

    if p3 == "flowSlot" then
        v5.Data.FlowSlots.MaxSlot = math.clamp(v5.Data.FlowSlots.MaxSlot + 1, 1, 7);

        return;
    end;

    if p3 == "luckyStyleSpins" then
        local Data = v5.Data;
        Data.LuckySpins = Data.LuckySpins + p4;

        return;
    end;

    if p3 == "luckyFlowSpins" then
        local Data = v5.Data;
        Data.LuckyFlowSpins = Data.LuckyFlowSpins + p4;

        return;
    end;

    if p3 == "styleSpins" then
        local Data = v5.Data;
        Data.Spins = Data.Spins + p4;
        u2.ProfileStats.Spins.Value = v5.Data.Spins;

        return;
    end;

    if p3 ~= "flowSpins" then
        warn((`invalid item for give {p3}`));

        return;
    end;

    local Data = v5.Data;
    Data.FlowSpins = Data.FlowSpins + p4;
    u2.ProfileStats.FlowSpins.Value = v5.Data.FlowSpins;
end;