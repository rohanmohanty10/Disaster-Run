  

 

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
    local v5 = AssetHandler.CloneAsset("Particles/Counter/Clone Stomp/Emit", v3.AbilityData or {
        AbilityName = "Garou"
    });
    v5.WorldCFrame = v4 * v5.CFrame;
    v5.Parent = workspace.Terrain;
    local v6 = ParticleHandler.GetUnusualHSVData({
        Character = v3.Character
    });

    if v6 ~= nil then
        ParticleHandler.Unusualify(v5, {
            HSVData = v6
        });
    end;

    ParticleHandler.Emit(v5, ParticleHandler.GenerateEmitInfo(v5));
    task.delay(ParticleHandler.GetMaxLifetime(v5), v5.Destroy, v5);
end;