  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local FXService = require(ReplicatedRoot.Services.FXService);
local Types = FXService.Types;
local CombatService = require(ReplicatedRoot.Services.CombatService);

return FXService.DefineEffect({
    Type = "Reliable",
    Identifier = script:GetFullName(),
    Reference = script.Reference,
    Definition = Types.Struct({}),

    Run = function(p1) -- Line: 17, Name: Run
        -- upvalues: CombatService (copy)
        p1.Collector:Construct(CombatService.CreateHover, {
            Character = p1.Character,
            Reference = p1.Reference
        });
    end
});