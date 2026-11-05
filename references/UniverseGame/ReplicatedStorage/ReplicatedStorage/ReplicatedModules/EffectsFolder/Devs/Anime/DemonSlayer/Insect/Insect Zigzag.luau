  

 

game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 17
    -- upvalues: EffectsHandler (copy)
    local v2 = p1 or {};
    local Player = v2.Player;
    local Character = v2.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local v3 = Character.Torso.Position * Vector3.new(1, 0, 1) + Vector3.new(0, HumanoidRootPart.Position.Y, 0);
    local v4 = CFrame.new(v3, v3 + HumanoidRootPart.CFrame.LookVector);
    EffectsHandler.CallEffect("Kars_Debris", {
        Radius = 1,
        RockCount = 7,
        SizeMultiplier = 2.2,
        Lifetime = 0.3,
        TweenTime = 0.3,
        Origin = v4
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Zigzag/Step",
        Origin = v4,
        Player = Player
    });
    EffectsHandler.CallEffect("Byee_Afterimage", {
        Lifetime = 0.95,
        IsHighlight = true,
        FillTransparency = 0.35,
        OutlineTransparency = 0.27,
        Character = Character,
        FillColor = Color3.fromRGB(145, 67, 255),
        OutlineColor = Color3.fromRGB(99, 14, 168),
        DepthMode = Enum.HighlightDepthMode.Occluded
    });
end;