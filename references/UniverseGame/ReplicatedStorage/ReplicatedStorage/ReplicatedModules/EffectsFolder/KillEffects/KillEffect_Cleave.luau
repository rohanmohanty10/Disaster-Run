  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1) -- Line: 8
    -- upvalues: AssetHandler (copy), EffectsHandler (copy)
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local v2 = {
        Blood = CFrame.new(0, -2.5, 0),
        Contact = CFrame.new(0, 2, 0)
    };

    for _, child in AssetHandler.GetAsset("Cleave", {
        AbilityName = "KillEffects"
    }):GetChildren() do
        EffectsHandler.CallEffect("Emit Particle V3", {
            AbilityName = "Cleave",
            PlaySounds = true,
            Origin = HumanoidRootPart,
            Particle = child,
            Offset = v2[child.Name]
        });
    end;

    task.delay(0.75, EffectsHandler.CallEffect, "Kuro_Wind", {
        Frequency = 0.1,
        Duration = 1,
        Transparency = 0.8,
        Size = Vector3.new(4.1666665, 0.8333333, 4.1666665),
        Scale = 8,
        Origin = HumanoidRootPart,
        Offset = CFrame.new(0, -1.5, 0),
        TweenData = { 0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out },
        Id = os.clock()
    });
end;