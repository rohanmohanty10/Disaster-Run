  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local ForgeVFX = require(ReplicatedRoot.Libraries.FX.ForgeVFX);
local Promise = require(ReplicatedRoot.Libraries.Classes.Promise);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), TableUtil (copy), ParticleHandler (copy), ForgeVFX (copy), Promise (copy)
    local v2 = EffectsHandler.CallEffect("Emit Particle V3", TableUtil.Reconcile(p1, {
        VFXForgeEmit = false,
        Destroy = false
    }));

    if v2 and v2.Particle then
        local Particle = v2.Particle;
        local v3 = ParticleHandler.GetMaxLifetime(Particle);

        local function Destroy() -- Line: 17
            -- upvalues: Particle (ref)
            if Particle then
                Particle:Destroy();
                Particle = nil;
            end;
        end;

        local v4 = {};
        local Finished = ForgeVFX.emit(Particle).Finished;
        table.insert(v4, Finished);

        if v3 then
            table.insert(v4, Promise.delay(v3));
        end;

        Promise.all(v4):finally(function() -- Line: 29
            -- upvalues: Destroy (copy)
            task.defer(Destroy);
        end);
    end;
end;