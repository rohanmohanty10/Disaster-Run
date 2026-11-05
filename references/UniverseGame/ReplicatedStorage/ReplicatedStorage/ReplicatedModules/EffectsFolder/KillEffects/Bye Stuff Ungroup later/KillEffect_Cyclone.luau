  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: TweenService (copy), AssetHandler (copy), ParticleHandler (copy)
    local TargetCharacter = (p1 or {}).TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    TweenService:Create(HumanoidRootPart, TweenInfo.new(5, Enum.EasingStyle.Linear), {
        CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, 100)
    }):Play();
    local v2 = AssetHandler.CloneAsset("Cyclone/Tornado", {
        AbilityName = "KillEffects"
    });
    v2.CFrame = CFrame2;
    v2.Parent = workspace.Effects;
    local v3 = AssetHandler.CloneAsset("Cyclone/Sound", {
        AbilityName = "KillEffects"
    });
    v3.Parent = v2;
    v3.Looped = true;
    v3:Play();

    repeat
        v2.Position = v2.Position:Lerp(HumanoidRootPart.Position, 0.5);
        task.wait();
    until not TargetCharacter:IsDescendantOf(game);

    TweenService:Create(v3, TweenInfo.new(1.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Volume = 0
    }):Play();
    ParticleHandler.EnableAllParticles(v2, false);
    ParticleHandler.DestroyEmit(v2);
end;