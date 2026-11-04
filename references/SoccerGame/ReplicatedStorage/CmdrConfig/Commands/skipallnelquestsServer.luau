  

local ServerScriptService = game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(ServerScriptService.Profile.ProfileManager);
local NELQuests = require(ReplicatedStorage.Shared.Configs.NELQuests);

return function(p1, p2) -- Line: 7
    -- upvalues: ProfileManager (copy), NELQuests (copy)
    local v3 = ProfileManager.Get(p2, true);

    if not v3 then
        return "Profile not loaded for target";
    end;

    v3.Data.StyleQuestData = v3.Data.StyleQuestData or {};
    local v4 = 0;

    for _, v in NELQuests do
        if v.Quests then
            for i, v2 in v.Quests do
                v3.Data.StyleQuestData[i] = {
                    completed = true,
                    progress = v2.internal and v2.internal.goal or 1
                };
                v4 = v4 + 1;
            end;
        end;
    end;

    return ("Skipped %d NEL quest(s) for %s"):format(v4, p2.Name);
end;