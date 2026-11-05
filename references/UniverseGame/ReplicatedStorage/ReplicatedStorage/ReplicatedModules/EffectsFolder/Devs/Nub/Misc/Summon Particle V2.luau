  

 

local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local TableUtil = require(game.ReplicatedStorage.ReplicatedModules.KnitPackage.TableUtil);

return function(p1) -- Line: 4
    -- upvalues: ParticleHandler (copy), TableUtil (copy)
    if not (p1.Part and p1.Part:IsDescendantOf(workspace)) then
        return;
    end;

    local Part = p1.Part;
    local v2 = Part:Clone();
    v2.Parent = Part.Parent;
    local v3 = p1.ParticleName or p1.Part.name;
    local v4 = ParticleHandler.GetParticleInfo(p1.ParticleName) or {};
    local v5 = v4.Particles or (v4.ParticleInfo or ParticleHandler.GenerateEmitInfo(v2));
    local v6 = ParticleHandler.GetSkinInfo(p1.SkinName);
    local v7;

    if v6 and v6[v3] then
        local v8 = TableUtil.Copy(v6[v3], true);

        if v8.HueShift then
            ParticleHandler.HueShiftParticles(v2, v8.HueShift);
        end;

        if v8.HSVShift then
            ParticleHandler.HSVShiftParticles(v2, v8.HSVShift);
        end;

        if v8.Particles then
            v7 = v8.Particles;

            if v8.Reconcile then
                v7 = TableUtil.Reconcile(v7, v5);
            end;
        else
            v7 = v5;
        end;
    elseif v6 and v6.Metadata then
        if v6.Metadata.HueShift then
            ParticleHandler.HueShiftParticles(v2, v6.Metadata.HueShift);
        end;

        if v6.Metadata.HSVShift then
            ParticleHandler.HSVShiftParticles(v2, v6.Metadata.HSVShift);
            v7 = v5;
        else
            v7 = v5;
        end;
    else
        v7 = v5;
    end;

    if p1.HSVData then
        ParticleHandler.Unusualify(v2, {
            HSVData = p1.HSVData
        });
    end;

    ParticleHandler.Emit(v2, v7);
    ParticleHandler.DestroyEmit(v2);
end;