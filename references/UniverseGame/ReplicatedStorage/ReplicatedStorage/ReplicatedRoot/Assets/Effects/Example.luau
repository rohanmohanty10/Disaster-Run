  

 

local FXService = require(game.ReplicatedStorage.ReplicatedRoot.Services.FXService);
local Types = FXService.Types;

return FXService.DefineEffect({
    Type = "Reliable",
    Identifier = script:GetFullName(),
    Reference = script.Reference,
    Definition = Types.Struct({
        Origin = Types.CFrame,
        Value = Types.Float32
    }),
    Inbound = {
        Main = {
            Function = function(p1) -- Line: 18, Name: Function
                p1.Parameters.Yes = true;
                print(p1);
            end
        }
    },

    Run = function(p2) -- Line: 25, Name: Run
        local Parameters = p2.Parameters;
        p2.Collector:Add(function() -- Line: 28
            warn("DESTROYED");
        end);
        print(Parameters, p2.Reference);
        task.wait(1);
        warn("END");
    end
});