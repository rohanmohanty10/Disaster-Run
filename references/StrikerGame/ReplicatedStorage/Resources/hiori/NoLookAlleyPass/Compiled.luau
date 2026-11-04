 
 

return {
    { 3, function(p1, p2) -- Line: 3
            for _, descendant in pairs(p1.HumanoidRootPart.CutsceneVFX.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 42, function(p3, p4) -- Line: 12
            for _, descendant in pairs(p3.HumanoidRootPart.CutsceneVFX.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 222, function(p5, p6) -- Line: 21
            for _, descendant in pairs(p6.NoLookTransition:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 225, function(p7, p8) -- Line: 30
            for _, descendant in pairs(p8.Highlight:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p8.NoLookTransition:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 228, function(p9, p10) -- Line: 44
            for _, descendant in pairs(p10.NoLookTransition:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 231, function(p11, p12) -- Line: 53
            for _, descendant in pairs(p12.NoLookTransition:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 234, function(p13, p14) -- Line: 62
            for _, descendant in pairs(p14.NoLookTransition:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 237, function(p15, p16) -- Line: 71
            for _, descendant in pairs(p15.HumanoidRootPart.CutsceneVFX.Three:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 270, function(p17, p18) -- Line: 80
            for _, descendant in pairs(p18.Highlight:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};