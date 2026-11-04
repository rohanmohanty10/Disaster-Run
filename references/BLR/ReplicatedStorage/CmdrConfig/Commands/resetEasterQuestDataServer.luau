  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local EasterQuests = require(ReplicatedStorage.Shared.Configs.EasterQuests);

return function(p1, p2) -- Line: 5
    -- upvalues: ProfileManager (copy), EasterQuests (copy)
    local v3 = ProfileManager.Get(p2, true);
    v3.Data.EasterQuests.Quests = nil;
    v3.Data.EasterQuests.Xp = 0;
    v3.Data.EasterQuests.QuestResetTimer = 0;
    v3.Data.EasterQuests.ClaimedRewards = {};
    local RandomQuests = EasterQuests.GetRandomQuests();
    v3.Data.EasterQuests.Quests = RandomQuests;
end;