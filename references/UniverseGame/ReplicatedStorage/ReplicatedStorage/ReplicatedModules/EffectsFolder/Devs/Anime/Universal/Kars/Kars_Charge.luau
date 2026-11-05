  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = {};

return function(p2) -- Line: 8
    -- upvalues: u1 (copy), ParticleHandler (copy)
    local Parent = p2.Parent;
    local ReferencePart = p2.ReferencePart;
    local Id = p2.Id;
    local Enabled = p2.Enabled;

    if u1[Id] or not Enabled then
        if u1[Id] and not Enabled then
            for _, v in pairs(u1[Id]) do
                ParticleHandler.GetMaxLifetime(v);

                if v and v.Parent then
                    if v:IsA("ParticleEmitter") then
                        local v3 = v.Lifetime.Max / v.TimeScale;
                        v.Enabled = false;
                        task.delay(v3, v.Destroy, v);
                    else
                        ParticleHandler.EnableParticle(v, false);
                        ParticleHandler.DestroyEmit(v);
                    end;
                end;
            end;

            u1[Id] = nil;
        end;

        return;
    end;

    local v4 = {};

    for _, child in pairs(ReferencePart:GetChildren()) do
        local v5 = child:Clone();
        v5.Parent = Parent;

        if child:IsA("ParticleEmitter") then
            child.Enabled = true;
        end;

        table.insert(v4, v5);
    end;

    u1[Id] = v4;
end;