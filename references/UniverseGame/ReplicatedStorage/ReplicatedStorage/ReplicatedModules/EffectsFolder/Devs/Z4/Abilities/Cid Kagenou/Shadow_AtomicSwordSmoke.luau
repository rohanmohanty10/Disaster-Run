  

 

game:GetService("TweenService");
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedModules.EffectsHandler);

return function(p1, p2) -- Line: 12
    -- upvalues: AssetHandler (copy), ParticleHandler (copy)
    if not (p1 and p1:IsDescendantOf(workspace)) then
        return;
    end;

    local v3 = AssetHandler.GetAsset("Particles/AtomicSword/FloorSmokeRotate", p2):Clone();
    v3.Anchored = true;
    v3.CFrame = p1.CFrame;
    v3.Parent = workspace.Effects;
    ParticleHandler.EnableParticle(v3, true);
    local v4 = 0;

    while v4 < 95 do
        local v5 = task.wait();
        v4 = v4 + v5 * 60;
        v3.CFrame = v3.CFrame * CFrame.Angles(0, math.rad(180 * v5), 0);
    end;

    ParticleHandler.EnableParticle(v3, false);
    ParticleHandler.DestroyEmit(v3);
end;