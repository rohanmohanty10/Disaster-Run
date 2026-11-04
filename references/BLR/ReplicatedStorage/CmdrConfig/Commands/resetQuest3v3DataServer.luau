  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
require(ReplicatedStorage.Packages.Knit);
local Quests3v3 = require(ReplicatedStorage.Shared.Configs.Quests3v3);

return function(p1, p2) -- Line: 6
    -- upvalues: ProfileManager (copy), Quests3v3 (copy)
    local v3 = ProfileManager.Get(p2, true);
    v3.Data.Quests3V3.Quests = nil;
    v3.Data.Quests3V3.Xp = 0;
    v3.Data.Quests3V3.QuestResetTimer = 0;
    v3.Data.Quests3V3.ClaimedRewards = {};
    local RandomQuests = Quests3v3.GetRandomQuests();
    v3.Data.Quests3V3.Quests = RandomQuests;
end;