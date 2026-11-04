  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local NELQuests = require(ReplicatedStorage.Shared.Configs.NELQuests);

return function(p1: any, p2: string) -- Line: 7, Name: countStyleMastery
    -- upvalues: NELQuests (copy)
    if not NELQuests[p2] then
        return 0, 0;
    end;

    local v3 = 0;

    if p1.BonusMasteryXP[p2] then
        v3 = v3 + p1.BonusMasteryXP[p2];
    end;

    for i, v in NELQuests[p2].Quests do
        if p1.StyleQuestData[i].completed and v.StyleRequired == p2 then
            v3 = v3 + v.XP;
        end;
    end;

    local v4 = 0;

    for i = 1, 4 do
        if NELQuests[p2].RewardLine[i].XP > v3 then
            break;
        end;

        v4 = i;
        local v5 = v4;
        local v6 = v4;
        v4 = v5;
        v6 = v5;
    end;

    return v4, v3;
end;