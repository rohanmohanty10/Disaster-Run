  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local SpinWheelData = require(ReplicatedStorage.Shared.Configs.SpinWheelData);

return function(p1, p2) -- Line: 5
    -- upvalues: ProfileManager (copy), SpinWheelData (copy)
    local Quests = ProfileManager.Get(p2, true).Data.WheelOfFortune[SpinWheelData.WheelName].Quests;

    if not Quests then
        return;
    end;

    for _, v in Quests do
        v.Progress = v.Goal;
    end;
end;