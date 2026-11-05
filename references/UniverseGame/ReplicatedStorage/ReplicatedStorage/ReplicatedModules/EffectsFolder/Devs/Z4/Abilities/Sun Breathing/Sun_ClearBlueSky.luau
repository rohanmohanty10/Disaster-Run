  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: AssetHandler (copy), TweenService (copy), ParticleHandler (copy)
    local HumanoidRootPart = p1.HumanoidRootPart;
    local v2 = AssetHandler.CloneAsset("Particles/ClearBlueSky/BigSlash", {
        AbilityName = "Sun Breathing"
    });
    v2.Parent = workspace.Effects;
    v2.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, -3);
    local CFrame2 = v2.CFrame;
    local v3 = 6;

    for _ = 1, 15 do
        v3 = v3 + 2.5;
        TweenService:Create(v2, TweenInfo.new(0.025), {
            Size = Vector3.new(6, 6, v3),
            CFrame = CFrame2 * CFrame.new(0, 0, -v3 / 2)
        }):Play();
        task.wait(0.025);
    end;

    ParticleHandler.EnableAllParticles(v2, false);
    ParticleHandler.DestroyEmit(v2);
end;