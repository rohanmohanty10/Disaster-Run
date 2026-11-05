  

 

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
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    local v2 = AssetHandler.CloneAsset("Chains Of Chaos/Model", {
        AbilityName = "KillEffects"
    });
    v2.Parent = workspace.Effects;

    for _, child in v2:GetChildren() do
        ParticleHandler.AttachTo(child, {
            Part = TargetCharacter[child.Name]
        });
    end;

    TargetCharacter.Humanoid:LoadAnimation(AssetHandler.GetAsset("Chains Of Chaos/Animation", {
        AbilityName = "KillEffects"
    })):Play();
    local CFrame2 = HumanoidRootPart.CFrame;

    local function Transform(p3) -- Line: 33
        -- upvalues: EffectsHandler (ref), CFrame2 (copy)
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Chains Of Chaos/Transform",
            AbilityName = "KillEffects",
            Origin = CFrame2,
            PlaySounds = p3
        });
    end;

    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Chains Of Chaos/Transform",
        AbilityName = "KillEffects",
        PlaySounds = nil,
        Origin = CFrame2
    });
    TargetCharacter.AncestryChanged:Wait();
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Chains Of Chaos/Transform",
        AbilityName = "KillEffects",
        PlaySounds = true,
        Origin = CFrame2
    });
    v2:Destroy();
end;