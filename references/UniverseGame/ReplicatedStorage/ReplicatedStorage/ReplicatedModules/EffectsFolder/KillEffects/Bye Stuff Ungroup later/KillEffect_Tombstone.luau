  

 

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
    local u2 = AssetHandler.CloneAsset("Tombstone/Tombstone", {
        AbilityName = "KillEffects"
    });
    u2.CFrame = CFrame2 * CFrame.new(0, 100, 0) * CFrame.Angles(0, 0, 3.141592653589793);
    u2.Parent = workspace.Effects;
    u2.Sign.SurfaceGui.Label.Text = "Here lies " .. TargetCharacter.Name;
    local v3 = TweenService:Create(u2, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
        CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -0.7, 0) * CFrame.Angles(0, 0, 3.141592653589793)
    });
    v3:Play();
    v3.Completed:Wait();
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Tombstone/Explosion",
        AbilityName = "KillEffects",
        Origin = HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0)
    });
    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
    TweenService:Create(u2.Sign.SurfaceGui.Label, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 2), {
        TextTransparency = 1
    }):Play();
    local v4 = TweenService:Create(u2, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 2), {
        Transparency = 1
    });
    v4:Play();
    v4.Completed:Connect(function() -- Line: 54
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
end;