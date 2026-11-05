  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), TweenService (copy)
    local TargetCharacter = (p1 or {}).TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    local v2 = AssetHandler.CloneAsset("Falling Anvil/Anvil", {
        AbilityName = "KillEffects"
    });
    v2.CFrame = CFrame2 * CFrame.new(0, 100, 0) * CFrame.Angles(0, 0, 3.141592653589793);
    v2.Parent = workspace.Effects;
    local v3 = TweenService:Create(v2, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
        CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.35, 0) * CFrame.Angles(0, 0, 3.141592653589793)
    });
    v3:Play();
    v3.Completed:Wait();
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Falling Anvil/Explosion",
        AbilityName = "KillEffects",
        Origin = HumanoidRootPart.CFrame * CFrame.new(0, -2.9, 0)
    });
    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);

    for _, descendant in v2:GetDescendants() do
        if descendant:IsA("BasePart") then
            TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 2), {
                Transparency = 1
            }):Play();
        end;
    end;

    task.delay(3, v2.Destroy, v2);
end;