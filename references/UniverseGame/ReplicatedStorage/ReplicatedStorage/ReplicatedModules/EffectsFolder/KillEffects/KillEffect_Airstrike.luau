  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();

return function(p2) -- Line: 10
    -- upvalues: AssetHandler (copy), u1 (copy), EffectsHandler (copy), TweenService (copy), ParticleHandler (copy)
    local TargetCharacter = p2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local u3 = AssetHandler.CloneAsset("Airstrike/Aimer", {
        AbilityName = "KillEffects"
    });
    u3.CFrame = HumanoidRootPart.CFrame * CFrame.new(u1:NextNumber(-5, 5), u1:NextNumber(-5, 5), 0);
    u3.Parent = workspace.Effects;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    task.delay(3, u3.Destroy, u3);
    TweenService:Create(u3, TweenInfo.new(0.9, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = Vector3.new(5, 5, 0)
    }):Play();
    TweenService:Create(u3.Front, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Transparency = 0.3,
        Color3 = Color3.fromRGB(1000, 50, 100)
    }):Play();
    TweenService:Create(u3.Back, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Transparency = 0.3,
        Color3 = Color3.fromRGB(1000, 50, 100)
    }):Play();

    for i = 1, 4 do
        local v4 = 8 - i * 2;
        local v5 = i == 4 and CFrame.identity or CFrame.new(u1:NextNumber(-v4, v4), u1:NextNumber(-v4, v4), 0);
        local v6 = TweenService:Create(u3, TweenInfo.new(i == 4 and 0.4 or 0.2, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * v5
        });
        v6:Play();
        v6.Completed:Wait();
    end;

    TweenService:Create(u3.Front, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Transparency = 0
    }):Play();
    TweenService:Create(u3.Back, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Transparency = 0
    }):Play();
    TweenService:Create(u3, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Size = Vector3.new(5.5, 5.5, 0)
    }):Play();
    task.delay(0.1, function() -- Line: 55
        -- upvalues: u3 (copy), HumanoidRootPart (copy), ParticleHandler (ref), TweenService (ref), EffectsHandler (ref), TargetCharacter (copy), AssetHandler (ref), u1 (ref)
        u3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
        ParticleHandler.Emit(u3, ParticleHandler.GenerateEmitInfo(u3));
        task.delay(0.2, function() -- Line: 63
            -- upvalues: TweenService (ref), u3 (ref), EffectsHandler (ref), TargetCharacter (ref), AssetHandler (ref), HumanoidRootPart (ref), u1 (ref), ParticleHandler (ref)
            TweenService:Create(u3, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                Size = Vector3.new(0, 0, 0)
            }):Play();
            task.delay(0.55, EffectsHandler.CallEffect, "SK_VANISH", {
                AffectStands = true,
                Transparency = 1,
                Character = TargetCharacter
            });

            for _ = 1, 8 do
                local u7 = AssetHandler.CloneAsset("Airstrike/Rocket", {
                    AbilityName = "KillEffects"
                });
                local new = CFrame.new;
                local Position = HumanoidRootPart.Position;
                local v8 = u1:NextNumber(-10, 10);
                local v9 = u1:NextNumber(35, 55);
                u7.CFrame = new(Position + Vector3.new(v8, v9, u1:NextNumber(-10, 10)), HumanoidRootPart.Position);
                u7.Parent = workspace.Effects;
                TweenService:Create(u7, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Size = Vector3.new(2, 2, 10)
                }):Play();
                task.wait(0.05);
                local Position2 = HumanoidRootPart.Position;
                local v10 = u1:NextNumber(-5, 5);
                local v11 = u1:NextNumber(-4, 2);
                local u12 = Position2 + Vector3.new(v10, v11, u1:NextNumber(-5, 5));
                local v13 = TweenService:Create(u7, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Transparency = 1,
                    Position = u12
                });
                v13:Play();
                v13.Completed:Connect(function() -- Line: 93
                    -- upvalues: ParticleHandler (ref), u7 (copy), EffectsHandler (ref), u12 (copy)
                    ParticleHandler.EnableAllParticles(u7, false);
                    ParticleHandler.DestroyEmit(u7);
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        Path = "Airstrike/Explosion",
                        AbilityName = "KillEffects",
                        PlaySounds = true,
                        Origin = u12
                    });
                end);
            end;
        end);
    end);
end;