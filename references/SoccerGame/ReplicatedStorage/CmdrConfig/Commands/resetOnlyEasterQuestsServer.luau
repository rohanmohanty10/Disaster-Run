  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local EasterQuests = require(ReplicatedStorage.Shared.Configs.EasterQuests);

return function(p1, p2) -- Line: 5
    -- upvalues: ProfileManager (copy), EasterQuests (copy)
    ProfileManager.Get(p2, true).Data.EasterQuests.Quests = EasterQuests.GetRandomQuests();
end;