  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local BattlepassEventData = require(ReplicatedStorage.Shared.Configs.BattlepassEventData);

return function(p1, p2, p3) -- Line: 5
    -- upvalues: ProfileManager (copy), BattlepassEventData (copy)
    local EventSpins = ProfileManager.Profiles[p2].Data.EventSpins;
    local EVENT_NAME = BattlepassEventData.EVENT_NAME;
    EventSpins[EVENT_NAME] = EventSpins[EVENT_NAME] + p3;
end;