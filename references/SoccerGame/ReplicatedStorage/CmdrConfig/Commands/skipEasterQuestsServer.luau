  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);

return function(p1, p2) -- Line: 3
    -- upvalues: ProfileManager (copy)
    local Quests = ProfileManager.Get(p2, true).Data.EasterQuests.Quests;

    if not Quests then
        return;
    end;

    for _, v in Quests do
        v.Progress = v.Goal;
    end;
end;