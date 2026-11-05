  

 

game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy)
    local Player = p1.Player;
    local ID = p1.ID;
    local v2 = os.clock();
    local v3;

    repeat
        v3 = workspace.Effects:FindFirstChild(ID);
        task.wait();
    until v3 or os.clock() - v2 >= 3;

    if not v3 then
        return;
    end;

    local v4 = AssetHandler.GetAbilityData(Player);
    local v5 = AssetHandler.CloneAsset("Particles/AirType/Projectile", v4);
    ParticleHandler.Unusualify(v5, p1);
    v5.CFrame = v3.CFrame;
    v5.Parent = workspace.Effects;
    local CFrame2 = v5.CFrame;
    local v6 = AssetHandler.CloneAsset("Particles/AirType/CircleTrail", v4);
    v6:SetAttribute("Lifetime", 2);
    ParticleHandler.Unusualify(v6, p1);
    v6.CFrame = v5.CFrame;
    v6.Parent = v5;
    local v7 = 0;

    while v3.Parent ~= nil do
        local v8 = task.wait();
        local v9 = v5.CFrame:Lerp(v3.CFrame, (math.min(v8 * 7, 1)));
        v5.CFrame = v9;
        v7 = v7 + 12.566370614359172 * v8;
        v6.CFrame = v9 * CFrame.new(0, 0, -2) * CFrame.Angles(0, 0, v7);

        if (CFrame2.Position - v9.Position).Magnitude > 4 then
            local CallEffect = EffectsHandler.CallEffect;
            local v10 = {
                Effect = "Akaza Shockwave Meshes"
            };
            local v11 = v9 * CFrame.new(0, 0, -5);
            local Angles = CFrame.Angles;
            local v12 = math.random(-180, 180);
            v10.Origin = v11 * Angles(0, 0, (math.rad(v12)));
            CallEffect("Mesh Emit", v10);
        else
            v9 = CFrame2;
        end;

        CFrame2 = v9;
    end;

    ParticleHandler.EnableAllParticles(v5, false);
    ParticleHandler.DestroyEmit(v5);
end;