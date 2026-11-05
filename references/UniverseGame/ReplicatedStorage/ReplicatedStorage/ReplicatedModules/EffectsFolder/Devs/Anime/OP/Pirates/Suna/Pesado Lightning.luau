  

 

game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local LightningBolt = require(ReplicatedStorage.ClientModules.LightningBolt);
require(ReplicatedStorage.ClientModules.LightningBolt.LightningSparks);
local u1 = Random.new();

return function(p2) -- Line: 18
    -- upvalues: u1 (copy), LightningBolt (copy)
    u1:NextNumber(0, 6.283185307179586);

    for _ = 1, 28 do
        local v3 = 0.7 * u1:NextNumber(0.9, 1.3);
        local v4 = u1:NextNumber(0, 6.283185307179586);
        local v5 = u1:NextNumber(30, 60) * v3;
        local v6 = u1:NextNumber(-v5, v5);
        local v7 = {
            WorldAxis = Vector3.new(0, 0, 0),
            WorldPosition = p2
        };
        local v8 = math.sin(v4);
        local v9 = math.cos(v4);
        v7.WorldAxis = Vector3.new(v8, 0, v9);
        local v10 = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(-0, -1, -0));
        local v11 = CFrame.Angles(0, 0, u1:NextNumber(0, 6.283185307179586));
        local Angles = CFrame.Angles;
        local v12 = u1:NextNumber(0.3420201433256688, -0.3420201433256687);
        local v13 = Angles(math.acos(v12), 0, 0);
        local v14 = {
            WorldAxis = Vector3.new(0, 0, 0),
            WorldPosition = p2 + v7.WorldAxis * v5 + Vector3.new(0, v6, 0),
            WorldAxis = (v10 * v11 * v13).LookVector
        };
        local v15 = LightningBolt.new(v7, v14, 13);
        v15.Thickness = u1:NextNumber(0.85, 1.15);
        v15.MaxRadius = u1:NextNumber(5, 10);
        v15.AnimationSpeed = u1:NextNumber(8, 10);
        v15.Color = Color3.fromRGB(148, 121, 255);
        v15.PulseLength = u1:NextNumber(1.9, 2.3);
        v15.Frequency = 1;
        v15.CurveSize0 = 0;
        v15.CurveSize1 = v15.MaxRadius * 5;
        v15.FadeLength = 0.25;
        v15.PulseSpeed = 5;
        task.wait(u1:NextNumber(0.02, 0.025));
    end;
end;