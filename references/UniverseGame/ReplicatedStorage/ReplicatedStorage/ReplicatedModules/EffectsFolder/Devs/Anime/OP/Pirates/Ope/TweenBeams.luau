  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
require(PathShortcuts.KnitPath.Knit);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1, p2) -- Line: 8
    -- upvalues: EffectsHandler (copy)
    if not (p1 and p1:IsDescendantOf(game)) then
        return;
    end;

    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("Beam") then
            EffectsHandler.CallEffect("Boat Tween", descendant, p2);
        end;
    end;
end;