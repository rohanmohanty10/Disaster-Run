  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Popup = require(ReplicatedStorage.Shared.Popup);

return function(p1, p2, p3) -- Line: 5
    -- upvalues: ProfileManager (copy), Popup (copy)
    local v4 = ProfileManager.Profiles[p2];

    if not v4 then
        return "Player data not loaded";
    end;

    local Data = v4.Data;
    Data.Exp = Data.Exp + p3;

    while v4.Data.Exp >= v4.Data.Level * 80 do
        local Data2 = v4.Data;
        Data2.Exp = Data2.Exp - v4.Data.Level * 80;
        local Data3 = v4.Data;
        Data3.Level = Data3.Level + 1;
    end;

    p2.ProfileStats.Level.Value = v4.Data.Level;
    Popup.Popup(p2, "+" .. p3 .. " XP (Level " .. v4.Data.Level .. ")");

    return "Gave " .. p3 .. " XP to " .. p2.Name .. " (now level " .. v4.Data.Level .. ")";
end;