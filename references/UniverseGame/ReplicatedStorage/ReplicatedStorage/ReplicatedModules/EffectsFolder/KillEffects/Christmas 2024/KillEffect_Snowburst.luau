  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1) -- Line: 5
    -- upvalues: EffectsHandler (copy), AssetHandler (copy)
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Snowburst/Snowburst",
        AbilityName = "KillEffects",
        Origin = HumanoidRootPart,
        Offset = CFrame.new(0, 0, 0)
    });
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(p1.Name .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    task.delay(0.1, EffectsHandler.CallEffect, "SK_VANISH", {
        AffectStands = true,
        Transparency = 1,
        Character = TargetCharacter
    });
end;