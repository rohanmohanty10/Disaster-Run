  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
require(Knit.Util.Trove);
require(PathShortcuts.ReplicatedModules.Classes.Ragdoll);
local v1 = {};

if Core.Context ~= "Client" then
    return v1;
end;

function v1.Init(p2) -- Line: 24
    function p2.IsRagdolled(p3) -- Line: 25
        return p3:GetAttribute("Ragdolled");
    end;
end;

function v1.Start(p4) -- Line: 30
    -- upvalues: PathShortcuts (copy)
    require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
end;

return v1;