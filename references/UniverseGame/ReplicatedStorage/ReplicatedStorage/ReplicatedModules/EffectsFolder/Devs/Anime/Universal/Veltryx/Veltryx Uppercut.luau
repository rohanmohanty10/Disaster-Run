  

 

game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 18
    -- upvalues: EffectsHandler (copy), LocalPlayer (copy), AssetHandler (copy), ParticleHandler (copy)
    local HumanoidRootPart = p1.HumanoidRootPart;
    local v2 = CFrame.new(1.2, 0.5, -7) * CFrame.Angles(1.5707963267948966, 0.5235987755982988, 0);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/IncalculableSpeed/Line",
        AutoSerialize = true,
        Offset = v2,
        Origin = HumanoidRootPart,
        Player = LocalPlayer
    });
    local v3 = AssetHandler.CloneAsset("Particles/IncalculableSpeed/BeamSlash", AssetHandler.GetAbilityData(p1));
    v3.CFrame = HumanoidRootPart.CFrame * v2 * CFrame.Angles(1.5707963267948966, 0, 1.5707963267948966);
    ParticleHandler.Unusualify(v3, {
        Character = p1
    });
    v3.Parent = workspace.Effects;
    task.delay(5, v3.Destroy, v3);
    task.delay(0.1, ParticleHandler.Emit, v3, ParticleHandler.GenerateEmitInfo(v3));
    EffectsHandler.CallEffect("FadeBeams", v3, {
        Time = 0.3
    });
    EffectsHandler.CallEffect("FlipbookSlash", {
        Time = 0.25,
        Size = Vector3.new(0.13, 0.19500001, 0.13),
        SurfaceDirection = "Bottom",
        SlashMesh = AssetHandler.GetAsset("Particles/RadioKnife/SlashMesh", {
            AbilityName = "Ope"
        }),
        Flipbook = AssetHandler.GetAsset("Particles/RadioKnife/SlashBook", {
            AbilityName = "Ope"
        }),
        Origin = HumanoidRootPart.CFrame * CFrame.new(0, 0.5, -1) * CFrame.Angles(2.0943951023931953, 0.5235987755982988, 1.5707963267948966),
        EndCFrame = CFrame.Angles(0, -1.6580627893946132, 0),
        Color = Color3.fromRGB(210, 265, 450)
    });
end;