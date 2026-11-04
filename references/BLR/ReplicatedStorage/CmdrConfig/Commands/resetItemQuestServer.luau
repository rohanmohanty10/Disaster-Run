  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
require(game.ServerScriptService.Profile.ProfileService);
local ItemQuestData = require(ReplicatedStorage.Shared.Configs.ItemQuestData);
require(ReplicatedStorage.Packages.Knit);

return function(p1, p2, p3) -- Line: 8
    -- upvalues: ProfileManager (copy), ItemQuestData (copy)
    local v4 = ProfileManager.Get(p2, true);

    for _, v in v4.Data.ItemQuest[ItemQuestData.EVENT].Quests do
        v.Progress = 0;
    end;

    v4.Data.ItemQuest[ItemQuestData.EVENT].Claimed = nil;
    v4.Data.ItemQuest[ItemQuestData.EVENT].StartAnimation = nil;
end;