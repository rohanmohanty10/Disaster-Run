  

 

local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 3
    -- upvalues: EffectsHandler (copy)
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    TargetCharacter:FindFirstChild("HumanoidRootPart");
    EffectsHandler.CallEffect("SK_VANISH", {
        Transparency = 1,
        Character = TargetCharacter
    });
    EffectsHandler.CallEffect("Petrify", TargetCharacter, nil, 1);
end;