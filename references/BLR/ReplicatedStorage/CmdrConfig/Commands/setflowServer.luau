  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local DebugUtil = require(ReplicatedStorage.Shared.DebugUtil);
local Popup = require(ReplicatedStorage.Shared.Popup);

return function(p1, p2, p3, p4) -- Line: 7
    -- upvalues: DebugUtil (copy), Popup (copy), ProfileManager (copy)
    local v5 = "Slot" .. p3;

    if p4 == "Homeless Man" and not DebugUtil.isAdmin(p2) then
        Popup.Popup(p2, "insufficnept mierrisosns!! (talk to a dev to get this)");

        return;
    end;

    local v6 = ProfileManager.Profiles[p2];
    v6.Data.FlowSlots[v5] = p4;

    if v6.Data.FlowSlots.SlotEquipped == v5 then
        v6.Data.Flow = p4;
        p2.PlayerStats.Flow.Value = p4;
    end;
end;