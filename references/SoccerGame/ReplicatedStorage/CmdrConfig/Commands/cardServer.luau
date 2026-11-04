  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1, p2, p3) -- Line: 4
    -- upvalues: ProfileManager (copy), ReplicatedStorage (copy)
    local v4 = ProfileManager.Profiles[p2];
    ReplicatedStorage.Assets.Customization.Cards:GetChildren();

    if game.ReplicatedStorage.Assets.Customization.Cards:FindFirstChild(p3) then
        local v5 = false;

        for _, v in v4.Data.Customization.Cards do
            if v == p3 then
                v5 = true;
            end;
        end;

        if v5 == false then
            table.insert(v4.Data.Customization.Cards, p3);
        end;

        return "Gave Card";
    end;
end;