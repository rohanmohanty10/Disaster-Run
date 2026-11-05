  

 

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
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 17
    -- upvalues: AssetHandler (copy), EffectsHandler (copy)
    local v2 = p1 or {};
    local Mesh = v2.Mesh;
    local Time = v2.Time;
    local v3 = `Particles/DissolveFlipbooks/{v2.Flipbook}`;
    local v4 = AssetHandler.GetAsset(v3, {
        AbilityName = "Hie"
    });
    Mesh.Transparency = 0.99;

    for i = 1, #v4:GetChildren() do
        if not (Mesh and Mesh:FindFirstChild("Decal")) then
            return;
        end;

        Mesh.Decal.Texture = v4[i].Texture;
        EffectsHandler.Wait(Time);
    end;

    Mesh:Destroy();
end;