 
 

return {
    [6.48] = function(p1) -- Line: 2
        for _, v in p1.VFX.Wind:QueryDescendants("ParticleEmitter") do
            v:Emit(v:GetAttribute("EmitCount") or 5);
        end;
    end,

    [4.22] = function(p2) -- Line: 7
        for _, v in p2.VFX.Grass2:QueryDescendants("ParticleEmitter") do
            v:Emit(v:GetAttribute("EmitCount") or 5);
        end;
    end,

    [3.67] = function(p3) -- Line: 12
        for _, v in p3.VFX.Grass1:QueryDescendants("ParticleEmitter") do
            v:Emit(v:GetAttribute("EmitCount") or 5);
        end;
    end
};