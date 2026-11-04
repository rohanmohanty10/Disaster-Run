 

 

return {
    { 0, function(p1) -- Line: 3
            for _, descendant in pairs(p1.threeballs:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    descendant.Enabled = true;
                    task.delay(0.15, function() -- Line: 10
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 10, function(p2) -- Line: 18
            for _, descendant in pairs(p2.grandhyaat["Right Arm"].emit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 14, function(p3) -- Line: 29
            for _, descendant in pairs(p3.footy2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 38, function(p4) -- Line: 40
            for _, descendant in pairs(p4.grandhyaat["Right Arm"].emit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p4.grandhyaat["Right Arm"].Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    descendant.Enabled = true;
                    task.delay(0.317, function() -- Line: 55
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 56, function(p5) -- Line: 63
            for _, descendant in pairs(p5.grandhyaat["Left Arm"].emit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p5.grandhyaat["Left Arm"].Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    descendant.Enabled = true;
                    task.delay(0.6, function() -- Line: 78
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 102, function(p6) -- Line: 86
            for _, descendant in pairs(p6.grandhyaat.Torso.Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 122, function(p7) -- Line: 97
            for _, descendant in pairs(p7.grandhyaat["Left Leg"].Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p7.grandhyaat["Right Leg"].Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 140, function(p8) -- Line: 116
            for _, descendant in pairs(p8.grandhyaat.Torso.Attachmentquick:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 154, function(p9) -- Line: 127
            for _, descendant in pairs(p9.grandhyaat["Left Leg"].Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p9.grandhyaat["Right Leg"].Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 162, function(p10) -- Line: 146
            for _, descendant in pairs(p10.bingbong:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    descendant.Enabled = true;
                    task.delay(0.483, function() -- Line: 153
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 194, function(p11) -- Line: 161
            for _, descendant in pairs(p11.grandhyaat["Left Arm"].emit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 212, function(p12) -- Line: 172
            for _, descendant in pairs(p12.grandhyaat["Right Leg"].Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 234, function(p13) -- Line: 183
            for _, descendant in pairs(p13.grandhyaat.Torso.Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 264, function(p14) -- Line: 194
            for _, descendant in pairs(p14.grandhyaat["Left Leg"].Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 280, function(p15) -- Line: 205
            for _, descendant in pairs(p15.bingbong:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    descendant.Enabled = true;
                    task.delay(0.417, function() -- Line: 212
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 322, function(p16) -- Line: 220
            for _, descendant in pairs(p16.End.emit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 372, function(p17) -- Line: 231
            for _, descendant in pairs(p17.threeballs:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    descendant.Enabled = true;
                    task.delay(0.9, function() -- Line: 238
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end }
};