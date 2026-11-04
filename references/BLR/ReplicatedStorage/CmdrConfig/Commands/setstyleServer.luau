  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);

return function(p1, p2, p3, p4) -- Line: 3
    -- upvalues: ProfileManager (copy)
    local v5 = "Slot" .. p3;
    local v6 = ProfileManager.Profiles[p2];

    if p4 == "Miro" and (p2.Name ~= "husaynawesome" and (p2.Name ~= "LexaaThePrincess" and p2.Name ~= "lapras12345678")) then
        print("Not Valid");

        return;
    end;

    local v7 = p4 == "Bunny" and (p2.Name == "husaynawesome" or (p2.Name == "LexaaThePrincess" or p2.Name == "lapras12345678")) and "Miro" or p4;
    v6.Data.StyleSlots[v5] = v7;

    if v6.Data.StyleSlots.SlotEquipped == v5 then
        v6.Data.Style = v7;
        p2.PlayerStats.Style.Value = v7;
    end;
end;