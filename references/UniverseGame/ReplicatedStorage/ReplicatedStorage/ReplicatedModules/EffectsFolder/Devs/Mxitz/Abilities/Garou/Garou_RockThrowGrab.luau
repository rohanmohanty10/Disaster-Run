  

 

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
    local v5 = v3.Arm or error("No Arm");
    local v6 = v3.AbilityData or {
        AbilityName = "Garou"
    };
    local v7 = AssetHandler.CloneAsset("Particles/RockThrow/Grab/Emit", v6);
    v7.WorldCFrame = v4 * v7.CFrame;
    v7.Parent = workspace.Terrain;
    local v8 = ParticleHandler.GetUnusualHSVData({
        Character = v3.Character
    });

    if v8 ~= nil then
        ParticleHandler.Unusualify(v7, {
            HSVData = v8
        });
    end;

    ParticleHandler.Emit(v7, ParticleHandler.GenerateEmitInfo(v7));
    task.delay(ParticleHandler.GetMaxLifetime(v7), v7.Destroy, v7);

    for _, descendant in AssetHandler.GetAsset("Particles/RockThrow/Grab/Meshes", v6):GetDescendants() do
        if descendant.Name == "Start" then
            local v9 = descendant.Parent:Clone();
            v9.Start.CFrame = v4 * v9:GetAttribute("Spawn_Offset");
            v9.Parent = workspace.Effects;

            if v8 ~= nil then
                ParticleHandler.Unusualify(v7, {
                    IncludeParts = true,
                    IncludeTextures = true,
                    IncludeSurfaces = true,
                    HSVData = v8
                });
            end;

            u1.CallEffect("Arc_MeshEmit", v9.Start, true);
            task.delay(v9:GetAttribute("Duration") or 1, v9.Destroy, v9);
        end;
    end;

    local u10 = AssetHandler.CloneAsset("Particles/RockThrow/Grab/Arm", v6);
    u10.Parent = v5;

    if v8 ~= nil then
        ParticleHandler.Unusualify(u10, {
            HSVData = v8
        });
    end;

    ParticleHandler.Emit(u10, ParticleHandler.GenerateEmitInfo(u10));
    ParticleHandler.EnableParticle(u10, true);
    task.delay(0.2, function() -- Line: 66
        -- upvalues: ParticleHandler (ref), u10 (copy)
        ParticleHandler.EnableParticle(u10, false);
        task.delay(ParticleHandler.GetMaxLifetime(u10), u10.Destroy, u10);
    end);
end;