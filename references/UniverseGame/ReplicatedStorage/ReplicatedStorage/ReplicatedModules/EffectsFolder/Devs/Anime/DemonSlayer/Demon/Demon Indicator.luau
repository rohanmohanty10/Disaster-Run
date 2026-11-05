  

 

game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
game:GetService("Lighting");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };

return function(p2) -- Line: 22
    -- upvalues: EffectsHandler (copy)
    local Player = (p2 or {}).Player;
    local Character = Player.Character;
    EffectsHandler.CallEffect("HighlightObject", Character, {
        FillTransparency = 0,
        OutlineTransparency = 0,
        Lifetime = 0.8,
        Tween = true,
        DepthMode = Enum.HighlightDepthMode.Occluded,
        FillColor = Color3.fromRGB(255, 110, 110),
        OutlineColor = Color3.fromRGB(120, 0, 0)
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Misc/Indicator",
        Player = Player,
        AttachTo = {
            Part = Character.Torso
        }
    });
end;