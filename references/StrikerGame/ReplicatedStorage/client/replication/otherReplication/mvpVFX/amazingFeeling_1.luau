 
 

return {
    { 25, function(p1, p2) -- Line: 3
            for _, descendant in ipairs(p2.Nose:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "Enable1" then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 141, function(p3, p4) -- Line: 14
            for _, descendant in ipairs(p3.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 150, function(p5, p6) -- Line: 23
            for _, descendant in ipairs(p5.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 151, function(p7, p8) -- Line: 32
            for _, descendant in ipairs(p7.Blood:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 157, function(p9, p10) -- Line: 43
            for _, descendant in ipairs(p10.Nose:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 239, function(p11, p12) -- Line: 52
            for _, descendant in ipairs(p12.Nose:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "Enable2" then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 240, function(p13, p14) -- Line: 63
            for _, descendant in ipairs(p13.Lines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 247, function(p15, p16) -- Line: 74
            for _, descendant in ipairs(p16.Nose:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 543, function(p17, p18) -- Line: 83
            for _, descendant in ipairs(workspace["2"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                    descendant:Clear();
                end;
            end;
        end }
};