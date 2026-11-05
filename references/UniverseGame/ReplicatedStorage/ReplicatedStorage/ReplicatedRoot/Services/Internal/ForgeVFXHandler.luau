  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);

return {
    _Start = function() -- Line: 6, Name: _Start
        -- upvalues: Core (copy), ReplicatedRoot (copy)
        if Core.Context ~= "Client" then
            return;
        end;

        require(ReplicatedRoot.Libraries.FX.ForgeVFX).init();
    end
};