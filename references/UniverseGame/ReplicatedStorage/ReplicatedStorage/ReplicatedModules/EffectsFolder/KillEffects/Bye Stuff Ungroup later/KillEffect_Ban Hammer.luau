  

 

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
    local u3 = AssetHandler.CloneAsset("Ban Hammer/Hammer", {
        AbilityName = "KillEffects"
    });
    u3.Anchored = true;
    u3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 2.85, 3.25) * CFrame.Angles(0.5235987755982988, 0, 0);
    u3.Parent = workspace.Effects;
    local v4 = u3.Size * 1.5;
    u3.Size = Vector3.new(0, 0, 0);
    local v5 = TweenService:Create(u3, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Size = v4
    });
    v5:Play();
    v5.Completed:Wait();
    TweenService:Create(u3, TweenInfo.new(0.5), {
        CFrame = u3.CFrame * CFrame.Angles(0.6981317007977318, 0, 0)
    }):Play();
    EffectsHandler.Wait(0.5);
    TweenService:Create(u3, TweenInfo.new(0.1, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
        CFrame = u3.CFrame * CFrame.Angles(-2.792526803190927, 0, 0)
    }):Play();
    EffectsHandler.Wait(0.08);
    u3.Bonk:Play();
    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
    local v6 = AssetHandler.CloneAsset("Ban Hammer/Moderated", {
        AbilityName = "KillEffects"
    });
    v6.CFrame = CFrame2;
    v6.Parent = workspace.Effects;

    for _, child in v6:GetChildren() do
        TweenService:Create(child, TweenInfo.new(0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 1), {
            Transparency = 1
        }):Play();
    end;

    task.delay(2, v6.Destroy, v6);
    local v7 = TweenService:Create(u3, TweenInfo.new(0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 1), {
        Transparency = 1
    });
    v7:Play();
    v7.Completed:Connect(function() -- Line: 68
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;