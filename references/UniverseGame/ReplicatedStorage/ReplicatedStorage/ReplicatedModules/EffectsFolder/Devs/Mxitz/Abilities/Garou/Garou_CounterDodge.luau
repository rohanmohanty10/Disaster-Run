  

 

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
    -- upvalues: AssetHandler (copy), ParticleHandler (copy)
    local v3 = p2 or {};
    local v4 = v3.Origin or error("No Origin");
    local v5 = v3.AbilityData or {
        AbilityName = "Garou"
    };
    local v6 = AssetHandler.CloneAsset("Particles/Counter/Dodge/Emit", v5);
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
    local v8 = AssetHandler.CloneAsset("Particles/Counter/Dodge/Emit", v5);
    v8.WorldCFrame = v4 * v8.CFrame;
    v8.Parent = workspace.Terrain;

    if v7 ~= nil then
        ParticleHandler.Unusualify(v8, {
            HSVData = v7
        });
    end;

    ParticleHandler.Emit(v8, ParticleHandler.GenerateEmitInfo(v8));
    local v9 = ParticleHandler.EnableAllParticles(v8, true) + 0.5;
    task.delay(0.5, ParticleHandler.EnableAllParticles, v8, false);
    task.delay(v9, v8.Destroy, v8);
end;