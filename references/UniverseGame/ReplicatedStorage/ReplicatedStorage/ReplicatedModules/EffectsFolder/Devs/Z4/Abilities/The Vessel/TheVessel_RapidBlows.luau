  

 

local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2) -- Line: 9
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy), CollectionService (copy), TweenService (copy)
    local v3 = p2 or {};
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v4 = CFrame.new(0, 0, -1.6);
    task.spawn(EffectsHandler.CallEffect, "Character Arm Barrage", p1, {
        DistanceScale = 1.55,
        FadeOut = 0.075,
        Offset = v4
    });
    local v5 = v3.BarrageParticle and v3.BarrageParticle:Clone() or AssetHandler.CloneAsset("Particles/RapidBlows/Barrage", {
        AbilityName = "The Vessel"
    });

    if v3.HSVData then
        ParticleHandler.Unusualify(v5, {
            HSVData = v3.HSVData
        });
    end;

    v5.Parent = p1;
    ParticleHandler.AttachTo(v5, {
        Part = HumanoidRootPart,
        Offset = CFrame.new(0, 0, 2.35)
    });
    ParticleHandler.EnableAllParticles(v5, true);

    while p1.Parent and CollectionService:HasTag(p1, "Barraging") do
        task.spawn(function() -- Line: 38
            -- upvalues: HumanoidRootPart (copy), TweenService (ref)
            local v6 = script.Mesh:Clone();
            v6.Parent = workspace.Effects;
            v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -1.5, -2.5) * CFrame.Angles(1.5707963267948966, 0, 0);
            local v7 = TweenService:Create(v6, TweenInfo.new(0.1, Enum.EasingStyle.Cubic), {
                Transparency = 0.95,
                CFrame = v6.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(0, 3.141592653589793, 0)
            });
            v7:Play();
            v7.Completed:Wait();
            local v8 = TweenService:Create(v6, TweenInfo.new(0.1, Enum.EasingStyle.Cubic), {
                Transparency = 1,
                CFrame = v6.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0, 3.141592653589793, 0)
            });
            v8:Play();
            v8.Completed:Wait();
            v6:Destroy();
        end);
        task.wait(0.1);
    end;

    ParticleHandler.DestroyEmit(v5);
    ParticleHandler.EnableAllParticles(v5, false);
end;