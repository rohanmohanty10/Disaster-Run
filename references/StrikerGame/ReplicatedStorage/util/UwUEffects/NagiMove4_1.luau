 
 

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

    [0.417] = function(p4, p5, p6) -- Line: 16
        local _ = p4.Character;
        local Meshes = p4.Meshes;
        local _ = p4.Cache;

        for _, descendant in pairs(Meshes.nagizrtstomp:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(Meshes.nagizrtstomp2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [0.433] = function(p7, p8, p9) -- Line: 34
        local _ = p7.Character;
        local _ = p7.Meshes;
        local _ = p7.Cache;

        for _, v in p9.All do
            if v.Name == "Aura" then
                v.Enabled = false;
            end;
        end;
    end,

    [2] = function() -- Line: 44
    end
};