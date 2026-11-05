  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy)
    local TargetCharacter = (p1 or {}).TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    EffectsHandler.Wait(0.1);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Smokebloom/Summon",
        AbilityName = "KillEffects",
        Origin = CFrame2
    });
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter, 0.5);
    local u2 = AssetHandler.CloneAsset("Smokebloom/Cloud", {
        AbilityName = "KillEffects"
    });
    u2.CFrame = CFrame2;
    u2.Parent = workspace.Effects;
    task.delay(3, function() -- Line: 37
        -- upvalues: ParticleHandler (ref), u2 (copy)
        ParticleHandler.DestroyEmit(u2);
        ParticleHandler.EnableAllParticles(u2, false);
    end);
end;