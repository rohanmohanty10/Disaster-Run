  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
game:GetService("ReplicatedStorage");

return function(p1, p2, p3) -- Line: 4
    -- upvalues: ProfileManager (copy)
    local v4 = ProfileManager.Profiles[p2];

    if require(game.ReplicatedStorage.Shared.Emotes.Emotes)[p3] then
        local v5 = false;

        for _, v in v4.Data.Customization.Emotes do
            if v == p3 then
                v5 = true;
            end;
        end;

        if v5 == false then
            table.insert(v4.Data.Customization.Emotes, p3);
        end;

        return "Gave emote";
    end;
end;