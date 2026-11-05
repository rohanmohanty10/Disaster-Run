  

 

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
    local v4 = v3.Arm or error("No Arm");
    local u5 = AssetHandler.CloneAsset("Particles/RockThrow/Charge/Arm", v3.AbilityData or {
        AbilityName = "Garou"
    });
    u5.Parent = v4;
    local v6 = ParticleHandler.GetUnusualHSVData({
        Character = v3.Character
    });

    if v6 ~= nil then
        ParticleHandler.Unusualify(u5, {
            HSVData = v6
        });
    end;

    ParticleHandler.Emit(u5, ParticleHandler.GenerateEmitInfo(u5));
    ParticleHandler.EnableParticle(u5, true);
    task.delay(0.2, function() -- Line: 36
        -- upvalues: ParticleHandler (ref), u5 (copy)
        ParticleHandler.EnableParticle(u5, false);
        task.delay(ParticleHandler.GetMaxLifetime(u5), u5.Destroy, u5);
    end);
end;