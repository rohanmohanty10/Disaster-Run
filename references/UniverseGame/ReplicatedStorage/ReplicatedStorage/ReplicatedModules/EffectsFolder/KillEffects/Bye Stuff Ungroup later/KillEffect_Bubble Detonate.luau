  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    local TargetCharacter = (p1 or {}).TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local _ = HumanoidRootPart.CFrame * CFrame.new(0, 25, 0) * CFrame.fromEulerAnglesXYZ(1.5707963267948966, 0, 1.5707963267948966);
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    local u2 = AssetHandler.CloneAsset("Bubble Detonate/Bubble", {
        AbilityName = "KillEffects"
    });
    u2.Transparency = 1;
    u2.Parent = workspace.Effects;
    ParticleHandler.AttachTo(u2, {
        Part = HumanoidRootPart
    });
    task.delay(0.1, function() -- Line: 29
        -- upvalues: ParticleHandler (ref), u2 (copy), TweenService (ref)
        ParticleHandler.Emit(u2, ParticleHandler.GenerateEmitInfo(u2));
        TweenService:Create(u2, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Transparency = 0.65
        }):Play();
    end);
    EffectsHandler.Wait(0.75);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Bubble Detonate/Explosion",
        AbilityName = "KillEffects",
        PlaySounds = true,
        Origin = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
    });
    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
    u2:Destroy();
end;