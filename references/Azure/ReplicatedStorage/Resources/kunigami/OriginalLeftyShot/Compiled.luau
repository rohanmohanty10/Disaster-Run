 

 

return {
    { 0, function(p1, p2) -- Line: 4
            for _, descendant in pairs(p2.e1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 42, function(p3, p4) -- Line: 14
            for _, descendant in pairs(p3["1"]:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 65, function(p5, p6) -- Line: 24
            for _, descendant in pairs(p5["2"]:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p5["3"]:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 143, function(p7, p8) -- Line: 40
            for _, descendant in pairs(p7["4"]:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 206, function(p9, p10) -- Line: 50
            for _, descendant in pairs(p9["5"]:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p10.flare:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p10.e1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 272, function(p11, p12) -- Line: 72
            for _, descendant in pairs(p11["6"]:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 368, function(p13, p14) -- Line: 82
            for _, descendant in pairs(p13["7"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 416, function(p15, p16) -- Line: 92
            for _, descendant in pairs(p15["7"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p15["8"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p15["8"]:GetDescendants()) do
                if descendant.ClassName == "Beam" then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 616, function(p17, p18, p19) -- Line: 116
            for _, descendant in pairs(p17["8"]:GetDescendants()) do
                if descendant.ClassName == "Beam" then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p17["8"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p17["9"]:GetDescendants()) do
                if descendant.ClassName == "Beam" then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p19.e:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 691, function(p20, p21, p22) -- Line: 148
            for _, descendant in pairs(p20["8"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p20["9"]:GetDescendants()) do
                if descendant.ClassName == "Beam" then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p22.e:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p20["10"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p20["10"]:GetDescendants()) do
                if descendant.ClassName == "Beam" then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 793, function(p23, p24) -- Line: 186
            for _, descendant in pairs(p23["10"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p23["10"]:GetDescendants()) do
                if descendant.ClassName == "Beam" then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 796, function(p25, p26) -- Line: 204
            for _, descendant in pairs(p25["11"]:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 821, function(p27, p28) -- Line: 214
            for _, descendant in pairs(p27["12"]:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end }
};