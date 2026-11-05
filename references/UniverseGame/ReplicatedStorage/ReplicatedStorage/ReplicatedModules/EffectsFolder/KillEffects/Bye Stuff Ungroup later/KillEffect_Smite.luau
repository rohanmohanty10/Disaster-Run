  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy)
    local v2 = p1 or {};
    local TargetCharacter = v2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local _ = { v2.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    local v3 = AssetHandler.CloneAsset("Smite/Cloud", {
        AbilityName = "KillEffects"
    });
    v3.CFrame = CFrame2 * CFrame.new(0, 25, 0);
    v3.Parent = workspace.Effects;
    EffectsHandler.Wait(0.25);
    local v4 = AssetHandler.CloneAsset("Smite/Ground", {
        AbilityName = "KillEffects"
    });
    v4.CFrame = CFrame2;
    v4.Parent = workspace.Effects;

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Attachment0 = v3.B1;
            local Transparency = descendant.Transparency;
            descendant.Transparency = NumberSequence.new(1);
            EffectsHandler.CallEffect("Boat Tween", descendant, {
                Time = 0.75,
                EasingStyle = "EntranceExpressive",
                EasingDirection = "Out",
                StepType = "RenderStepped",
                Goal = {
                    Transparency = Transparency
                }
            });
        end;
    end;

    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
    EffectsHandler.Wait(1.25);

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("Beam") then
            EffectsHandler.CallEffect("Boat Tween", descendant, {
                Time = 0.5,
                EasingStyle = "EntranceExpressive",
                EasingDirection = "Out",
                StepType = "RenderStepped",
                Goal = {
                    Transparency = NumberSequence.new(1)
                }
            });
        end;

        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    ParticleHandler.EnableAllParticles(v3, false);
    task.delay(5, v3.Destroy, v3);
    task.delay(5, v4.Destroy, v4);
end;