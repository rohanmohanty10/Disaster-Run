  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), TweenService (copy), ParticleHandler (copy)
    local v2 = p1 or {};
    local TargetCharacter = v2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local _ = { v2.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.25, 0);
    local CFrame2 = HumanoidRootPart.CFrame;
    EffectsHandler.Wait(0.2);
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    local v3 = AssetHandler.CloneAsset("Electric Chamber/Chamber", {
        AbilityName = "KillEffects"
    });
    v3.Parent = workspace.Effects;
    v3:PivotTo(CFrame2 * CFrame.Angles(0, 0, -1.5707963267948966));
    local v4 = v3:GetExtentsSize();
    local u5 = AssetHandler.CloneAsset("Electric Chamber/Creation", {
        AbilityName = "KillEffects"
    });
    u5.CFrame = CFrame2 * CFrame.new(0, v4.X / 2 + 0.2, 0) * CFrame.Angles(0, 0, -1.5707963267948966);
    u5.Parent = workspace.Effects;
    local v6 = TweenService:Create(u5, TweenInfo.new(v4.X / 10, Enum.EasingStyle.Linear), {
        Position = u5.Position - Vector3.new(0, v4.X + 0.2, 0)
    });
    v6:Play();
    v6.Completed:Connect(function() -- Line: 45
        -- upvalues: ParticleHandler (ref), u5 (copy), TweenService (ref)
        ParticleHandler.DestroyEmit(u5);
        ParticleHandler.EnableAllParticles(u5, false);
        TweenService:Create(u5, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = Vector3.new(0, 1, 1) * u5.Size
        }):Play();
    end);

    for i = 1, 5 do
        local v7 = v3[tostring(i)];
        local X = v7.Size.X;
        v7.Size = v7.Size * Vector3.new(0, 1, 1);
        v7.Position = v7.Position + Vector3.new(0, X / 2, 0);
        v7.Transparency = i == 3 and 0.85 or 0;
        local v8 = TweenService:Create(v7, TweenInfo.new(X / 10, Enum.EasingStyle.Linear), {
            Size = v7.Size + Vector3.new(X, 0, 0),
            Position = v7.Position - Vector3.new(0, X / 2, 0)
        });
        v8:Play();
        v8.Completed:Wait();
    end;

    if TargetCharacter and TargetCharacter:IsDescendantOf(game) then
        TargetCharacter.AncestryChanged:Wait();
    end;

    for _, child in v3:GetChildren() do
        TweenService:Create(child, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
    end;

    task.delay(0.5, v3.Destroy, v3);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Electric Chamber/Burst",
        AbilityName = "KillEffects",
        PlaySounds = true,
        Origin = CFrame2
    });
end;