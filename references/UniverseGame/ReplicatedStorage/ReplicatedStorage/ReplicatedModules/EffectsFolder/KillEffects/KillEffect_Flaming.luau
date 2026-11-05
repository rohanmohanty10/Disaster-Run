  

 

local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 5
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy)
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    EffectsHandler.CallEffect("UberOni_Bezier", {
        Radius = 6,
        Amount = 5,
        Curve = 16,
        Duration = 0.5,
        Object = AssetHandler.GetAsset("Flaming/Trail", {
            AbilityName = "KillEffects"
        }),
        Positions = {
            Start = TargetCharacter.Torso,
            End = TargetCharacter.Torso
        }
    });
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(TargetCharacter.HumanoidRootPart.Position)
    });
    task.delay(0.5, function() -- Line: 26
        -- upvalues: EffectsHandler (ref), TargetCharacter (copy), AssetHandler (ref), ParticleHandler (ref)
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Flaming/Enable",
            AbilityName = "KillEffects",
            AutoSerialize = true,
            Origin = TargetCharacter.HumanoidRootPart.CFrame
        });

        for _, child in TargetCharacter:GetChildren() do
            if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
                local v2 = AssetHandler.CloneAsset("Flaming/Aura", {
                    AbilityName = "KillEffects"
                });
                v2.Parent = TargetCharacter;
                ParticleHandler.AttachTo(v2, {
                    Part = child
                });
                task.delay(1.5, ParticleHandler.EnableAllParticles, v2, false);
            end;
        end;
    end);
end;