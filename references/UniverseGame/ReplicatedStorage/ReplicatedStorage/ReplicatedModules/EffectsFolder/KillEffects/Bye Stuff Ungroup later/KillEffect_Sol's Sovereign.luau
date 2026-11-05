  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), ParticleHandler (copy), TweenService (copy)
    local TargetCharacter = (p1 or {}).TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local v2 = HumanoidRootPart.CFrame * CFrame.new(0, 25, 0) * CFrame.fromEulerAnglesXYZ(1.5707963267948966, 0, 1.5707963267948966);
    local v3 = AssetHandler.CloneAsset("Sol\'s Sovereign/Sword", {
        AbilityName = "KillEffects"
    });
    v3.Parent = workspace.Effects;
    v3:PivotTo(v2);
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    task.delay(8, v3.Destroy, v3);
    task.delay(0.1, ParticleHandler.Emit, v3.SummonDesummonVFXhere, ParticleHandler.GenerateEmitInfo(v3.SummonDesummonVFXhere));
    local v4 = TweenService:Create(v3.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 30, 0) * CFrame.fromEulerAnglesXYZ(1.5707963267948966, 0, 1.5707963267948966)
    });
    v4:Play();
    v4.Completed:Wait();
    local v5 = TweenService:Create(v3.PrimaryPart, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 8, 0) * CFrame.fromEulerAnglesXYZ(1.5707963267948966, 0, 1.5707963267948966)
    });
    v5:Play();
    v5.Completed:Wait();
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Sol\'s Sovereign/Explosion",
        AbilityName = "KillEffects",
        Origin = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
    });
    EffectsHandler.CallEffect("Rock Debris", {
        Lifetime = 2.5,
        Size = Vector3.new(2.2, 2.2, 2.2),
        Radius = 12,
        Amount = 15,
        Origin = HumanoidRootPart.CFrame
    });
    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);

    for _, descendant in v3:GetDescendants() do
        if descendant:IsA("BasePart") then
            TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end;
    end;

    ParticleHandler.EnableAllParticles(v3, false);
end;