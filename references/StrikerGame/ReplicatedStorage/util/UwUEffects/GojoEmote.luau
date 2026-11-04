 

 

return {
    [0.4] = function(p1, p2, p3) -- Line: 2
        local _ = p1.Character;
        local _ = p1.Cache;

        for _, descendant in p1.Meshes.Part.vfx1:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [0.867] = function(p4, p5, p6) -- Line: 14
        local _ = p4.Character;
        local _ = p4.Cache;

        for _, descendant in p4.Meshes.Part.vfx2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [1.567] = function(p7, p8, p9) -- Line: 26
        local _ = p7.Character;
        local _ = p7.Cache;

        for _, descendant in p7.Meshes.Part.vfx3:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [3.783] = function(p10, p11, p12) -- Line: 38
        local _ = p10.Character;
        local _ = p10.Cache;

        for _, descendant in p10.Meshes.Part.vfx4:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [9000000000] = function() -- Line: 50
    end
};