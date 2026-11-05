  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
require(ReplicatedRoot.Services.Gameplay.WorldService);

return {
    Name = "Hook",
    Type = "Inbound",
    Priority = 0,

    Function = function(p1) -- Line: 10, Name: Function
        return true;
    end
};