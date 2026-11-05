  

 

local v1 = {};
local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
require(Core.ReplicatedLibraries.Classes.Trove);
require(Core.ReplicatedServices.TagService);

function v1.Init(p2) -- Line: 8
    -- upvalues: Core (copy)
    if Core.Context == "Server" then
        p2.ProjectileModel = Instance.new("Model");
        p2.ProjectileModel.Name = "ProjectileModel";
        p2.ProjectileModel.Archivable = true;
        p2.ProjectileModel.Parent = game.ReplicatedStorage;
    elseif Core.Context == "Client" then
        p2.ProjectileModel = game.ReplicatedStorage:WaitForChild("ProjectileModel");
    end;

    if Core.Context == "Client" then
    end;
end;

return v1;