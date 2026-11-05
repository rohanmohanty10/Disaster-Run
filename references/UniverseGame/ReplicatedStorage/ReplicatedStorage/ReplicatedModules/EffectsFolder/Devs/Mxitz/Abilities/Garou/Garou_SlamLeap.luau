  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 12
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.ReplicatedModules.EffectsHandler);
end);

return function(p2) -- Line: 16
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u1 (ref)
    local v3 = p2 or {};
    local v4 = v3.Origin or error("No Origin");
    local v5 = v3.AbilityData or {
        AbilityName = "Garou"
    };
    v5.AbilityName = "Garou";
    local v6 = AssetHandler.CloneAsset("Particles/SlamMove/Leap/Emit", v5);
    v6.WorldCFrame = v4 * v6.CFrame;
    v6.Parent = workspace.Terrain;
    local v7 = ParticleHandler.GetUnusualHSVData({
        Character = v3.Character
    });

    if v7 ~= nil then
        ParticleHandler.Unusualify(v6, {
            HSVData = v7
        });
    end;

    ParticleHandler.Emit(v6, ParticleHandler.GenerateEmitInfo(v6));
    task.delay(ParticleHandler.GetMaxLifetime(v6), v6.Destroy, v6);

    for _, descendant in AssetHandler.GetAsset("Particles/SlamMove/Leap/Meshes", v5):GetDescendants() do
        if descendant.Name == "Start" then
            local v8 = descendant.Parent:Clone();
            v8.Start.CFrame = v4 * v8:GetAttribute("Spawn_Offset");
            v8.Parent = workspace.Effects;
            u1.CallEffect("Arc_MeshEmit", v8.Start, true);
            task.delay(v8:GetAttribute("Duration") or 1, v8.Destroy, v8);
        end;
    end;
end;