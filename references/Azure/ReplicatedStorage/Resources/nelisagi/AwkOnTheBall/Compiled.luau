 
 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            for _, descendant in pairs(p1.HumanoidRootPart.CutsceneVFX.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("SurfaceLight") or descendant:IsA("PointLight")) then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p2.Ef1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 57, function(p4, p5, p6) -- Line: 17
            for _, descendant in pairs(p4.HumanoidRootPart.CutsceneVFX.Step:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 114, function(p7, p8, p9) -- Line: 26
            for _, descendant in pairs(p8.Ef2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p8.MetaUnlock:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 237, function(p10, p11, p12) -- Line: 40
            for _, descendant in pairs(p12["Metavision EyeBIG"].Part.FX1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p10.HumanoidRootPart.CutsceneVFX.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("SurfaceLight") or descendant:IsA("PointLight")) then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p10.HumanoidRootPart.CutsceneVFX.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("SurfaceLight") or descendant:IsA("PointLight")) then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p11.Ef1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p11.Ef12:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 421, function(p13, p14, p15) -- Line: 69
            for _, descendant in pairs(p15["Metavision EyeBIG"].Part.FX1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p13.HumanoidRootPart.CutsceneVFX.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("SurfaceLight") or descendant:IsA("PointLight")) then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p15["Metavision EyeBIG"].Part.FX2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 588, function(p16, p17, p18) -- Line: 89
            for _, descendant in pairs(p17.Ef2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 708, function(p19, p20, p21) -- Line: 98
            for _, descendant in pairs(p21["Metavision EyeBIG"].Part.FX2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p20.Ef1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end }
};