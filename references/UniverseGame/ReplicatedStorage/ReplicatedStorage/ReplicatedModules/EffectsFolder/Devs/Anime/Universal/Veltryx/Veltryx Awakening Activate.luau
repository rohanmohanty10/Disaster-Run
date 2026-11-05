  

 

game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 18
    -- upvalues: EffectsHandler (copy), LocalPlayer (copy)
    local v2 = p1 or {};
    local v3 = v2.Character or error("No character data");
    local _ = v2.HSVData;
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Blessing/Activate",
        AutoSerialize = true,
        MaxRenderDistance = 1000000,
        Origin = v3.HumanoidRootPart,
        Offset = CFrame.new(0, -2.65, 0),
        Player = LocalPlayer
    });
    EffectsHandler.CallEffect("Flying Debris", {
        Lifetime = 9,
        Collision = true,
        Inconsistent = true,
        Size = 5.15,
        Force = Vector3.new(30.000002, 50, 30.000002),
        Amount = 9,
        TweenDelay = 7,
        Origin = v3.HumanoidRootPart.CFrame,
        Tween = {
            Transparency = 1,
            Size = Vector3.new(1, 1, 1)
        }
    });
    EffectsHandler.CallEffect("Kars_Debris", {
        Radius = 22,
        RockCount = 19,
        SizeMultiplier = 1.35,
        Lifetime = 5,
        TweenTime = 0.5,
        Origin = v3.HumanoidRootPart.CFrame
    });
end;