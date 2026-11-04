  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Popup = require(ReplicatedStorage.Shared.Popup);

return function(p1, p2, p3) -- Line: 5
    -- upvalues: ProfileManager (copy), Popup (copy)
    local v4 = ProfileManager.Profiles[p2];
    local Easter = v4.Data.Easter;
    Easter.KaiserFreeSpinPacksOpened = Easter.KaiserFreeSpinPacksOpened + (p3 or 1);

    if v4.Data.Easter.KaiserFreeSpinPacksOpened >= 25 then
        v4.Data.Easter.KaiserFreeSpinPacksOpened = 0;
        local Easter2 = v4.Data.Easter;
        Easter2.FreePremiumSpins = Easter2.FreePremiumSpins + 1;
        Popup.Popup(p2, "You earned 3 premium spins!");
    end;

    p2.ProfileStats.Easter.FreePremiumSpins.Value = v4.Data.Easter.FreePremiumSpins;
    p2.ProfileStats.Easter.KaiserFreeSpinPacksOpened.Value = v4.Data.Easter.KaiserFreeSpinPacksOpened;
end;