  

require(game.ServerScriptService.Profile.ProfileManager);
local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit);

return function(p1, p2, p3, p4) -- Line: 4
    -- upvalues: Knit (copy)
    Knit.GetService("StyleService"):GiveStyleSkin(p2, p3, p4, true);
end;