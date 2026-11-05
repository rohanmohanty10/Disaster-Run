  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);

return {
    From = {
        BaseAbility = {
            ["@All"] = true
        }
    },
    Import = { script:WaitForChild("Assets") }
};