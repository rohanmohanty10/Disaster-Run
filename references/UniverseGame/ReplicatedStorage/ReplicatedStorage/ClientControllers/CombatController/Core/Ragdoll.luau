  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
require(Knit.ReplicatedModules.Classes.Ragdoll);

return {
    Init = function(p1) -- Line: 19, Name: Init
        function p1.IsRagdolled(p2) -- Line: 20
            return p2:GetAttribute("Ragdolled");
        end;
    end,

    Start = function(p3) -- Line: 25, Name: Start
        -- upvalues: PathShortcuts (copy)
        require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    end
};