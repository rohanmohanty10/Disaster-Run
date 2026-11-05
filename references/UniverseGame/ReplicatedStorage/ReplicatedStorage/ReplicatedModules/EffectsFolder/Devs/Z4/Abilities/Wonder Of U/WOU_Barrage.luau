  

 

local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1) -- Line: 9
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy), CollectionService (copy), TweenService (copy)
    local Stand = p1.Stand;
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local HumanoidRootPart2 = Stand.HumanoidRootPart;
    local v2 = CFrame.new(0, 0, -1.6);
    task.spawn(EffectsHandler.CallEffect, "WOU_BarrageArms", Stand, {
        DistanceScale = 1.55,
        UseOneArm = "Right",
        FadeOut = 0.075,
        Offset = v2
    });
    local v3 = AssetHandler.CloneAsset("Particles/RapidBlows/Barrage", {
        AbilityName = "The Vessel"
    });
    v3.Parent = p1;
    ParticleHandler.AttachTo(v3, {
        Part = HumanoidRootPart,
        Offset = CFrame.new(0, 0, 2.35)
    });
    ParticleHandler.EnableAllParticles(v3, true);

    while p1.Parent and CollectionService:HasTag(p1, "Barraging") do
        task.spawn(function() -- Line: 37
            -- upvalues: HumanoidRootPart2 (copy), TweenService (ref)
            local v4 = script.Mesh:Clone();
            v4.Parent = workspace.Effects;
            v4.CFrame = HumanoidRootPart2.CFrame * CFrame.new(0, -1.5, -2.5) * CFrame.Angles(1.5707963267948966, 0, 0);
            local v5 = TweenService:Create(v4, TweenInfo.new(0.1, Enum.EasingStyle.Cubic), {
                Transparency = 0.95,
                CFrame = v4.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(0, 3.141592653589793, 0)
            });
            v5:Play();
            v5.Completed:Wait();
            local v6 = TweenService:Create(v4, TweenInfo.new(0.1, Enum.EasingStyle.Cubic), {
                Transparency = 1,
                CFrame = v4.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0, 3.141592653589793, 0)
            });
            v6:Play();
            v6.Completed:Wait();
            v4:Destroy();
        end);
        task.wait(0.1);
    end;

    ParticleHandler.DestroyEmit(v3);
    ParticleHandler.EnableAllParticles(v3, false);
end;