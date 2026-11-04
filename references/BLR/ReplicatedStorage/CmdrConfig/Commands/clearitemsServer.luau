  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
game:GetService("ReplicatedStorage");

return function(p1, p2, p3) -- Line: 4
    -- upvalues: ProfileManager (copy)
    for _, v in ProfileManager.Profiles[p2].Data.Customization do
        if type(v) == "table" then
            table.clear(v);
        end;
    end;
end;