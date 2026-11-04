  

require(game.ServerScriptService.Profile.ProfileManager);
local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1, p2) -- Line: 4
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.GameValues.Timer.Value = p2;
end;