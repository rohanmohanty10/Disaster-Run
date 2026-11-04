  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local BattlepassEventData = require(ReplicatedStorage.Shared.Configs.BattlepassEventData);
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1, p2) -- Line: 6
    -- upvalues: ProfileManager (copy), BattlepassEventData (copy), Knit (copy)
    local v3 = ProfileManager.Get(p2, true).Data.AdditionalEventData[BattlepassEventData.DATA_NAME];
    local Service = Knit.GetService("BattlepassEventService");

    if v3.DailyQuests and v3.DailyQuests.Quests then
        for i, v in v3.DailyQuests.Quests do
            v.Progress = v.Goal;
            Service.Client.UpdateQuest:Fire(p2, i, v);
        end;
    end;

    if v3.WeeklyQuests and v3.WeeklyQuests.Quests then
        for i, v in v3.WeeklyQuests.Quests do
            v.Progress = v.Goal;
            Service.Client.UpdateWeeklyQuest:Fire(p2, i, v);
        end;
    end;
end;