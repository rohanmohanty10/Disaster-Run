 

 

game:GetService("Lighting");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0.383] = function(p1, p2, p3) -- Line: 6
        local _ = p1.Meshes;
        local _ = p1.Cache;
        local _ = p1.Character.HumanoidRootPart;

        for _, descendant in pairs(p2.HumanoidRootPart.VFXRonaldoMvp.Steps.n1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant:GetAttribute("EmitCount") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [0.683] = function(p4, p5, p6) -- Line: 23
        local _ = p4.Meshes;
        local _ = p4.Cache;
        local _ = p4.Character.HumanoidRootPart;

        for _, descendant in pairs(p5.HumanoidRootPart.VFXRonaldoMvp.Steps.n2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant:GetAttribute("EmitCount") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [0.867] = function(p7, p8, p9) -- Line: 41
        local _ = p7.Meshes;
        local _ = p7.Cache;
        local _ = p7.Character.HumanoidRootPart;

        for _, descendant in pairs(p8.HumanoidRootPart.VFXRonaldoMvp.Steps.n3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant:GetAttribute("EmitCount") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [1.683] = function(p10, p11, p12) -- Line: 58
        local _ = p10.Cache;
        local _ = p10.Character.HumanoidRootPart;

        for _, descendant in pairs(p10.Meshes.StarFlash:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant:GetAttribute("EmitDuration") then
                descendant.Enabled = true;
                task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 71
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end,

    [2.317] = function(p13, p14, p15) -- Line: 78
        local _ = p13.Meshes;
        local _ = p13.Cache;
        local _ = p13.Character.HumanoidRootPart;

        for _, descendant in pairs(p14.HumanoidRootPart.VFXRonaldoMvp.RainbowEnd:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant:GetAttribute("EmitCount") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [7] = function() -- Line: 95
    end
};