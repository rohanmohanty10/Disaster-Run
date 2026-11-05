  

 

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
        AbilityName = "KillEffects",
        Origin = HumanoidRootPart,
        Offset = CFrame.new(0, -2.8, 0),
        Path = p1.Name .. "/Fog"
    });
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(p1.Name .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    task.delay(0.35, EffectsHandler.CallEffect, "SK_VANISH", {
        AffectStands = true,
        Transparency = 1,
        Character = TargetCharacter,
        TweenInfo = { 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut }
    });
end;