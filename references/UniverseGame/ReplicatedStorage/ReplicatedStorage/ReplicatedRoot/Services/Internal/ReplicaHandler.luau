  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
local v1 = {
    Name = "ReplicaHandler"
};
local Replica = require(Core.ReplicatedLibraries.Networking.Replica);

function v1._Start() -- Line: 8
    -- upvalues: Core (copy), Replica (copy)
    if Core.Context ~= "Client" then
        return;
    end;

    task.defer(Replica.RequestData);
end;

return v1;