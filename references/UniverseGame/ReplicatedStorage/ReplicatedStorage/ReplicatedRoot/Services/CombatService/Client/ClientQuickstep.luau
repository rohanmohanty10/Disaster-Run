  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local Signal = require(Knit.Util.Signal);
local v1 = {};

if Core.Context ~= "Client" then
    return v1;
end;

function v1.Init(p2) -- Line: 23
end;

function v1.Start(u3) -- Line: 27
    -- upvalues: Signal (copy)
    u3.QuickstepInterrupted = Signal.new();

    function u3.InterruptQuickstep() -- Line: 29
        -- upvalues: u3 (copy)
        u3.QuickstepInterrupted:Fire();
    end;
end;

return v1;