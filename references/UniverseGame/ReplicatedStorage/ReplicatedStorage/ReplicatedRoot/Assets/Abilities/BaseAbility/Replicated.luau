  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);
local v1 = {
    Import = { script:WaitForChild("Assets") },
    Moves = {}
};
v1.Moves.Dash = {
    From = {
        ["Actions/Moves/DashReplicated"] = {
            ["@All"] = true,
            ["@Context"] = "Client"
        }
    },
    Indicator = {
        Enabled = true
    }
};
v1.Moves.Block = {
    Indicator = {
        Enabled = true
    }
};

return v1;