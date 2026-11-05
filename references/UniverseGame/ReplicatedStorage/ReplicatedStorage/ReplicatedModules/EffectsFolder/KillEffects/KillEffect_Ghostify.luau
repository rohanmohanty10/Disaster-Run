  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
Random.new();

return function(p1) -- Line: 10
    -- upvalues: AssetHandler (copy), TweenService (copy), EffectsHandler (copy), ParticleHandler (copy)
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u2 = AssetHandler.CloneAsset("Ghostify/Ghost", {
        AbilityName = "KillEffects"
    });
    u2.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
    u2.Parent = workspace.Effects;
    u2.AnimationController.Animator:LoadAnimation(AssetHandler.GetAsset("Ghostify/Animation", {
        AbilityName = "KillEffects"
    })):Play(0);

    for _, descendant in u2:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Parent ~= u2 then
            TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 0.8
            }):Play();
        end;
    end;

    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Ghostify/SoulEmit",
        AbilityName = "KillEffects",
        AutoSerialize = true,
        Origin = HumanoidRootPart
    });
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    TweenService:Create(u2.PrimaryPart, TweenInfo.new(3.5, Enum.EasingStyle.Linear), {
        CFrame = u2.PrimaryPart.CFrame * CFrame.new(0, 7, 0)
    }):Play();
    task.delay(3, function() -- Line: 47
        -- upvalues: u2 (copy), TweenService (ref), ParticleHandler (ref)
        for _, descendant in u2:GetDescendants() do
            if descendant:IsA("BasePart") and descendant.Parent ~= u2 then
                TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;

        ParticleHandler.EnableAllParticles(u2, false);
        ParticleHandler.DestroyEmit(u2);
    end);
end;