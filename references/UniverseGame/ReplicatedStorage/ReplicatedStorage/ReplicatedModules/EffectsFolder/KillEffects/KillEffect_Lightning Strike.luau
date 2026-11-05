  

 

local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1) -- Line: 6
    -- upvalues: EffectsHandler (copy), AssetHandler (copy)
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local v2 = TargetCharacter:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, -2.5, 0);
    EffectsHandler.CallEffect("Rock Debris", {
        Lifetime = 2.5,
        Radius = 7,
        Amount = 14,
        Origin = v2
    });
    EffectsHandler.CallEffect("Blood Rays", {
        Part = TargetCharacter.Torso,
        TrailRange = NumberRange.new(5, 10)
    });
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset("Global/Impact", {
            AbilityName = "The World: Over Heaven"
        }),
        Origin = v2
    });
    EffectsHandler.CallEffect("Q_RADIAL", {
        Distance = 40,
        Effect = "Camera Shake Preset",
        Origin = v2,
        Arguments = { "Explosion" }
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Global/Lightning/Explosion",
        AutoSerialize = true,
        AbilityName = "The World: Over Heaven",
        Origin = v2
    });
end;