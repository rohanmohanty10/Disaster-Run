  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy)
    local TargetCharacter = (p1 or {}).TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local _ = HumanoidRootPart.CFrame;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });

    local function tweendeb(p2, p3) -- Line: 28
        p2:Play();
        p2.Completed:Wait();

        if p3 then
            p3:Destroy();
        end;

        return true;
    end;

    local v4 = AssetHandler.CloneAsset("Sovereign Execution/SovereignFX", {
        AbilityName = "KillEffects"
    });

    for _, descendant in ipairs(v4:GetDescendants()) do
        if (descendant:IsA("Beam") or descendant:IsA("ParticleEmitter")) and descendant.Name ~= "Smoke" then
            descendant.Color = ColorSequence.new(Color3.fromRGB(255, 85, 255));
        end;
    end;

    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter, 3);
    local Start = v4.Start;
    local End = v4.End;
    local Smoke = v4.Smoke;
    Start:WaitForChild("Core");
    End:WaitForChild("Core");
    local v5 = CFrame.Angles(0, 0, -1.5707963267948966);
    local v6 = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * v5;
    Start.Core.CFrame = v6;
    Start.Core2.CFrame = v6;
    End.Core.CFrame = v6;
    End.Core2.CFrame = v6;
    Smoke.CFrame = Start:GetBoundingBox() * CFrame.new(-Start.Core.Size.X / 2, 0, 0) * v5;
    v4.Parent = workspace.Effects;

    for _, descendant in ipairs(v4:GetDescendants()) do
        if descendant.ClassName == "ParticleEmitter" or descendant.ClassName == "Beam" then
            descendant.Enabled = true;
        end;
    end;

    local v7 = HumanoidRootPart.CFrame * CFrame.new(0, 200, 0) * v5;
    game.TweenService:Create(End.Core, TweenInfo.new(3, Enum.EasingStyle.Sine), {
        CFrame = v7
    }):Play();
    local v8 = game.TweenService:Create(End.Core2, TweenInfo.new(3, Enum.EasingStyle.Sine), {
        CFrame = v7
    });
    v8:Play();
    v8.Completed:Wait();

    for _, descendant in ipairs(v4:GetDescendants()) do
        if descendant.ClassName == "ParticleEmitter" then
            descendant.Enabled = false;
        end;
    end;

    game.TweenService:Create(Start.Core, TweenInfo.new(3, Enum.EasingStyle.Sine), {
        CFrame = v7
    }):Play();
    local v9 = game.TweenService:Create(Start.Core2, TweenInfo.new(3, Enum.EasingStyle.Sine), {
        CFrame = v7
    });
    v9:Play();
    v9.Completed:Wait();
    task.delay(0.5, v4.Destroy, v4);
end;