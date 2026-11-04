 

 

game:GetService("Lighting");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0] = function(p1, p2, p3) -- Line: 6
        local _ = p1.Character;
        local _ = p1.Meshes;
        local _ = p1.Cache;

        for _, v in p3.All do
            if v.Name == "Aura" then
                v.Enabled = true;
            end;
        end;
    end,

    [0.067] = function(p4, p5, p6) -- Line: 16
        local _ = p4.Character;
        local _ = p4.Cache;

        for _, descendant in pairs(p4.Meshes.nagigroundcontrol1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [1] = function(p7, p8, p9) -- Line: 28
        local _ = p7.Character;
        local _ = p7.Cache;

        for _, descendant in pairs(p7.Meshes.nagigroundcontrol2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [1.567] = function(p10, p11, p12) -- Line: 40
        local _ = p10.Character;
        local _ = p10.Meshes;
        local _ = p10.Cache;

        for _, v in p12.All do
            if v.Name == "Aura" then
                v.Enabled = false;
            end;
        end;
    end,

    [2.567] = function() -- Line: 50
    end
};