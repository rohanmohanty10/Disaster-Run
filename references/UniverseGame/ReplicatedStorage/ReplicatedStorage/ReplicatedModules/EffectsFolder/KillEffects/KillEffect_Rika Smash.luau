  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: AssetHandler (copy), TweenService (copy), EffectsHandler (copy)
    local v2 = p1 or {};
    local TargetCharacter = v2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local _ = { v2.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    local u3 = AssetHandler.CloneAsset("Rika Smash/Rika", {
        AbilityName = "KillEffects"
    });
    u3.Parent = workspace.Effects;
    u3:PivotTo(CFrame2 * CFrame.new(0, -10, 14));

    for _, descendant in u3:GetDescendants() do
        if descendant:IsA("Sound") then
            descendant:Play();
        end;
    end;

    TweenService:Create(u3.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        CFrame = u3.PrimaryPart.CFrame * CFrame.new(0, 10, 0)
    }):Play();
    u3.AnimationController:LoadAnimation(AssetHandler.GetAsset("Rika Smash/Animation", {
        AbilityName = "KillEffects"
    })):Play(0);

    for _, descendant in u3:GetDescendants() do
        if descendant:IsA("BasePart") then
            local Transparency = descendant.Transparency;
            descendant.Transparency = 1;
            TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = Transparency
            }):Play();
        end;
    end;

    EffectsHandler.Wait(1.3833333333333333);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Rika Smash/Slam",
        AbilityName = "KillEffects",
        Origin = HumanoidRootPart.CFrame
    });
    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
    task.delay(0.3, function() -- Line: 56
        -- upvalues: u3 (copy), TweenService (ref)
        task.delay(1, u3.Destroy, u3);

        for _, descendant in u3:GetDescendants() do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;
    end);
end;