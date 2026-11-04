  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
require(game.ServerScriptService.Profile.ProfileService);
local ItemQuestData = require(ReplicatedStorage.Shared.Configs.ItemQuestData);
require(ReplicatedStorage.Packages.Knit);

return function(p1, p2, p3) -- Line: 8
    -- upvalues: ProfileManager (copy), ItemQuestData (copy)
    for _, v in ProfileManager.Get(p2, true).Data.ItemQuest[ItemQuestData.EVENT].Quests do
        v.Progress = v.Goal;
    end;
end;