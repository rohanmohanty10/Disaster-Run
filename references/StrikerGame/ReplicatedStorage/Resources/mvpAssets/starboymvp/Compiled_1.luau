 
 

return {
    { 143, function(p1) -- Line: 3
            local Hit = p1.MVPVFXROOTPART.Hit;

            for _, descendant in pairs(Hit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            task.wait(0.1);

            for _, descendant in pairs(Hit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 331, function(p2, p3) -- Line: 24
            local Lineas = p3.CamPart.Lineas;

            for _, descendant in pairs(Lineas:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            task.wait(3);

            for _, descendant in pairs(Lineas:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 332, function(p4) -- Line: 45
            local XO = p4.MVPVFXROOTPART.XO;

            for _, descendant in pairs(XO:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            task.wait(0.1);

            for _, descendant in pairs(XO:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 333, function(p5, p6) -- Line: 66
            local CamVFXS1 = p6.CamPart.CamVFXS1;

            for _, descendant in pairs(CamVFXS1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            task.wait(2.4);

            for _, descendant in pairs(CamVFXS1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 503, function(p7, p8, p9) -- Line: 87
            local Eyelight = p9.Head.Eyelight;

            for _, descendant in pairs(Eyelight:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            task.wait(1.6);

            for _, descendant in pairs(Eyelight:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};