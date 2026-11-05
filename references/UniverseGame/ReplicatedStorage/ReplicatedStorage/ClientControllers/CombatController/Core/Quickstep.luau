  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Signal = require(Knit.Util.Signal);

return {
    Init = function(u1) -- Line: 18, Name: Init
        -- upvalues: Signal (copy)
        u1.StunTable = {};
        u1.Stunned = Signal.new();
        u1.StunEnded = Signal.new();

        function u1.GetStunTable(p2) -- Line: 23
            -- upvalues: u1 (copy)
            return u1.StunTable[p2];
        end;
    end,

    Start = function(u3) -- Line: 28, Name: Start
        -- upvalues: PathShortcuts (copy), Signal (copy)
        require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
        u3.QuickstepInterrupted = Signal.new();

        function u3.InterruptQuickstep() -- Line: 32
            -- upvalues: u3 (copy)
            u3.QuickstepInterrupted:Fire();
        end;
    end
};