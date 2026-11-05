  

 

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
    local v2 = AssetHandler.CloneAsset("TNT/Tnt", {
        AbilityName = "KillEffects"
    });
    v2.CFrame = CFrame2;
    v2.Parent = workspace.Effects;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(0, 10000, 0);
    BodyVelocity.Velocity = Vector3.new(0, 20, 0);
    BodyVelocity.Parent = v2;
    task.delay(0.1, BodyVelocity.Destroy, BodyVelocity);
    local Highlight = Instance.new("Highlight");
    Highlight.OutlineTransparency = 1;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillTransparency = 1;
    Highlight.FillColor = Color3.fromRGB(255, 255, 255);
    Highlight.Parent = v2;

    for i = 1, 9 do
        Highlight.FillTransparency = Highlight.FillTransparency == 1 and 0 or 1;

        if i == 9 then
            TweenService:Create(v2, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0.2), {
                Size = v2.Size * 1.15
            }):Play();
            task.delay(0.3, v2.Destroy, v2);
        end;

        EffectsHandler.Wait(0.3);
    end;

    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "TNT/Explosion",
        AbilityName = "KillEffects",
        Origin = v2.CFrame
    });
    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
end;