  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local SpinWheelData = require(ReplicatedStorage.Shared.Configs.SpinWheelData);

return function(p1, p2) -- Line: 5
    -- upvalues: ProfileManager (copy), SpinWheelData (copy)
    local v3 = ProfileManager.Get(p2, true);
    local WheelName = SpinWheelData.WheelName;
    v3.Data.WheelOfFortune[WheelName].Quests = nil;
    local RandomQuests = SpinWheelData.GetRandomQuests();
    v3.Data.WheelOfFortune[WheelName].Quests = RandomQuests;
end;