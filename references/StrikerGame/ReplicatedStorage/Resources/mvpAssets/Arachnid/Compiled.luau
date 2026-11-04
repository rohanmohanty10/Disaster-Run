 
 

return {
    { 0, function(p1, p2) -- Line: 3
            for _, descendant in pairs(p1.Storm:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p1.Storm:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1, function(p3, p4) -- Line: 20
            if p4 then
                for _, descendant in pairs(p4.CamPart.CameraLines:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;
            end;
        end },
    { 2, function(p5, p6) -- Line: 32
            for _, descendant in pairs(p5.FogStarts:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 3, function(p7, p8) -- Line: 42
            if p8 then
                for _, descendant in pairs(p8.CamPart.CameraLines1:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;
            end;
        end },
    { 114, function(p9, p10) -- Line: 54
            for _, descendant in pairs(p9.impact:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.spawn(function() -- Line: 57
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end);
                end;
            end;
        end },
    { 116, function(p11, p12) -- Line: 65
            for _, descendant in pairs(p11.Proooo:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.spawn(function() -- Line: 68
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end);
                end;
            end;
        end },
    { 200, function(p13, p14) -- Line: 76
            for _, descendant in pairs(p13.Part:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 212, function(p15, p16) -- Line: 86
            for _, descendant in pairs(p15.Storm:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 236, function(p17, p18) -- Line: 96
            for _, descendant in pairs(p17.webshooter:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.spawn(function() -- Line: 99
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end);
                end;
            end;
        end },
    { 239, function(p19, p20) -- Line: 107
            for _, descendant in pairs(p19.Part2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 281, function(p21, p22) -- Line: 117
            for _, descendant in pairs(p21.FogStarts:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 282, function(p23, p24) -- Line: 127
            for _, descendant in pairs(p23.webshooter2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.spawn(function() -- Line: 130
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end);
                end;
            end;
        end },
    { 283, function(p25, p26) -- Line: 138
            for _, descendant in pairs(p25.Part3:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 312, function(p27, p28) -- Line: 148
            for _, descendant in pairs(p27.Part3:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 315, function(p29, p30) -- Line: 158
            for _, descendant in pairs(p29.Part2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 316, function(p31, p32) -- Line: 168
            for _, descendant in pairs(p31.Part:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p31.Storm2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 319, function(p33, p34) -- Line: 185
            if p34 then
                for _, descendant in pairs(p34.CamPart.CameraLines:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end;
        end },
    { 320, function(p35, p36) -- Line: 197
            for _, descendant in pairs(p35["bc flat speedlines"]:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 321, function(p37, p38) -- Line: 207
            if p38 then
                for _, descendant in pairs(p38.CamPart.CameraLines1:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end;
        end },
    { 322, function(p39, p40) -- Line: 219
            for _, descendant in pairs(p39.Storm2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p39.Storm:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            if p40 then
                shared.vfx.emit(p40.CamPart.color);
            end;
        end },
    { 358, function(p41, p42) -- Line: 239
            for _, descendant in pairs(p41.Ground1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.spawn(function() -- Line: 242
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end);
                end;
            end;

            for _, descendant in pairs(p41.Light["2"]:GetDescendants()) do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 404, function(p43, p44) -- Line: 257
            for _, descendant in pairs(p43.Ground2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.spawn(function() -- Line: 260
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end);
                end;
            end;
        end },
    { 444, function(p45, p46) -- Line: 268
            for _, descendant in pairs(p45.Ground3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.spawn(function() -- Line: 271
                        -- upvalues: descendant (copy)
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end);
                end;
            end;
        end },
    { 588, function(p47, p48) -- Line: 279
            for _, descendant in pairs(p47["bc flat speedlines"]:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p47.Storm2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p47.Light["2"]:GetDescendants()) do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};