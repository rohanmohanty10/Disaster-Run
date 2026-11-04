  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
require(game.ServerScriptService.Profile.ProfileService);
local BattlepassEventData = require(ReplicatedStorage.Shared.Configs.BattlepassEventData);
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1, p2, p3) -- Line: 8
    -- upvalues: ProfileManager (copy), BattlepassEventData (copy), Knit (copy)
    local v4 = ProfileManager.Get(p2, true);
    v4.Data.AdditionalEventData[BattlepassEventData.DATA_NAME].Battlepass.Premium = true;
    v4.Data.AdditionalEventData[BattlepassEventData.DATA_NAME].Battlepass.Tier = BattlepassEventData.Tiers;
    local Service = Knit.GetService("BattlepassEventService");

    for i = 1, BattlepassEventData.Tiers do
        Service.Client.TierUp:Fire(p2, i, 0);
        local _ = i;
    end;

    Service.Client.PremiumUnlocked:Fire(p2);
end;