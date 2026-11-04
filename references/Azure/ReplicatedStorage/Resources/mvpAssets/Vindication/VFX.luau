 
 

return {
    { 297, function(p1) -- Line: 3
            for _, descendant in p1["Right Leg"].Step:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                end;
            end;
        end },
    { 333, function(p2) -- Line: 15
            for _, descendant in p2["Left Leg"].Step:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                end;
            end;
        end },
    { 360, function(p3) -- Line: 27
            for _, descendant in p3.Torso.BlackWhip:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in p3.Head.Eye:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in p3.HumanoidRootPart.Start:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                end;
            end;
        end },
    { 366, function(p4) -- Line: 55
            for _, descendant in p4["Right Leg"].Step:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                end;
            end;
        end },
    { 400, function(p5) -- Line: 67
            for _, descendant in p5["Left Leg"].Step:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                end;
            end;
        end },
    { 438, function(p6) -- Line: 79
            for _, descendant in p6["Right Leg"].Step:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                end;
            end;
        end },
    { 471, function(p7) -- Line: 91
            for _, descendant in p7["Left Leg"].Step:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                end;
            end;
        end },
    { 507, function(p8) -- Line: 103
            for _, descendant in p8["Right Leg"].Step:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                end;
            end;
        end },
    { 544, function(p9) -- Line: 115
            for _, descendant in p9["Left Leg"]:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                end;
            end;
        end },
    { 581, function(p10) -- Line: 127
            for _, descendant in p10.HumanoidRootPart.Start:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                end;
            end;
        end },
    { 584, function(p11) -- Line: 139
            for _, descendant in p11["Left Leg"].FinalStep:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                    descendant.TimeScale = 0.7;
                    task.delay(0.2, function() -- Line: 147
                        -- upvalues: descendant (copy)
                        descendant.TimeScale = 0.05;
                    end);
                end;
            end;
        end }
};