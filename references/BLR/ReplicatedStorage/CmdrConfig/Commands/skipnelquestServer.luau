  

local ServerScriptService = game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(ServerScriptService.Profile.ProfileManager);
local NELQuests = require(ReplicatedStorage.Shared.Configs.NELQuests);

return function(p1, p2, p3) -- Line: 7
    -- upvalues: ProfileManager (copy), NELQuests (copy)
    local v4 = ProfileManager.Get(p2, true);

    if not v4 then
        return "Profile not loaded for target";
    end;

    local v5 = nil;

    for _, v in NELQuests do
        if v.Quests and v.Quests[p3] then
            v5 = v.Quests[p3];
            break;
        end;
    end;

    if not v5 then
        return ("Unknown NEL quest id: %s"):format((tostring(p3)));
    end;

    v4.Data.StyleQuestData = v4.Data.StyleQuestData or {};
    v4.Data.StyleQuestData[p3] = {
        completed = true,
        progress = v5.internal and v5.internal.goal or 1
    };

    return ("Skipped NEL quest \'%s\' for %s"):format(p3, p2.Name);
end;