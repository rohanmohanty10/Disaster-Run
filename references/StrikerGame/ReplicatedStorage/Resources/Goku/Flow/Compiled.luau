 

 

return {
    { 0, function(p1, p2) -- Line: 3
            for _, descendant in pairs(p1.Scene1FreeFall.BackDrop:GetDescendants()) do
                if descendant:isA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p1.Scene1FreeFall.BackDrop:GetDescendants()) do
                if descendant:isA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p1.Space:GetDescendants()) do
                if descendant:isA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 75, function(p3, p4) -- Line: 35
            for _, descendant in pairs(p3.Scene1FreeFall.BackDrop:GetDescendants()) do
                if descendant:isA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p3.Scene1FreeFall.BackDrop:GetDescendants()) do
                if descendant:isA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 90, function(p5, p6) -- Line: 56
            require(p5.Scene2SpinFall.RandomSpin.SpinSpin)(p6.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 100, function(p7, p8) -- Line: 61
            require(p7.Scene2SpinFall.RandomSpin.SpinSpin)(p8.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 110, function(p9, p10) -- Line: 66
            require(p9.Scene2SpinFall.RandomSpin.SpinSpin)(p10.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 120, function(p11, p12) -- Line: 71
            require(p11.Scene2SpinFall.RandomSpin.SpinSpin)(p12.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 127, function(p13, p14) -- Line: 76
            require(p13.Scene2SpinFall.FlyMesh.ModuleMesh)(p14.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 132, function(p15, p16) -- Line: 81
            require(p15.Scene2SpinFall.FlyMesh.ModuleMesh)(p16.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 137, function(p17, p18) -- Line: 86
            require(p17.Scene2SpinFall.FlyMesh.ModuleMesh)(p18.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 141, function(p19, p20) -- Line: 91
            require(p19.Scene2SpinFall.FlyMesh.ModuleMesh)(p20.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 145, function(p21, p22) -- Line: 96
            for _, descendant in pairs(p21.Scene3Slam.BeamBack:GetDescendants()) do
                if descendant:isA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 146, function(p23, p24) -- Line: 107
            require(p23.Scene2SpinFall.FlyMesh.ModuleMesh)(p24.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 151, function(p25, p26) -- Line: 112
            require(p25.Scene2SpinFall.FlyMesh.ModuleMesh)(p26.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 156, function(p27, p28) -- Line: 117
            require(p27.Scene2SpinFall.FlyMesh.ModuleMesh)(p28.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 160, function(p29, p30) -- Line: 122
            require(game.ReplicatedStorage.Part_Icles):AbsoluteEmit(p29.Scene3Slam);
        end },
    { 201, function(p31, p32) -- Line: 131
            require(game.ReplicatedStorage.Part_Icles):AbsoluteEmit(p31.Scene4Awakening.Ink1);
        end },
    { 220, function(p33, p34) -- Line: 140
            require(game.ReplicatedStorage.Part_Icles):AbsoluteEmit(p33.Scene4Awakening.Ink2);
        end },
    { 240, function(p35, p36) -- Line: 149
            require(game.ReplicatedStorage.Part_Icles):AbsoluteEmit(p35.Scene4Awakening.Ink3);
        end },
    { 255, function(p37, p38) -- Line: 158
            require(game.ReplicatedStorage.Part_Icles):AbsoluteEmit(p37.Scene4Awakening.Ink4);
        end },
    { 266, function(p39, p40) -- Line: 173
            require(game.ReplicatedStorage.Part_Icles):AbsoluteEmit(p39.Scene4Awakening.Ink5);
        end },
    { 283, function(p41, p42) -- Line: 189
            require(game.ReplicatedStorage.Part_Icles):AbsoluteEmit(p41.Scene4Awakening.Ink6);
        end },
    { 295, function(p43, p44) -- Line: 206
            require(game.ReplicatedStorage.Part_Icles):AbsoluteEmit(p43.Scene4Awakening.Ink7);
        end },
    { 325, function(p45, p46) -- Line: 215
            for _, descendant in pairs(p45.Scene3Slam.BeamBack:GetDescendants()) do
                if descendant:isA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 455, function(p47, p48) -- Line: 226
            require(game.ReplicatedStorage.Part_Icles):AbsoluteEmit(p47.Scene5Rage.BuildUp);

            for _, descendant in pairs(p48:GetDescendants()) do
                if descendant:isA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 515, function(p49, p50) -- Line: 244
            require(game.ReplicatedStorage.Part_Icles):AbsoluteEmit(p49.Scene5Rage.StartGround);
        end },
    { 556, function(p51, p52) -- Line: 253
            require(game.ReplicatedStorage.Part_Icles):AbsoluteEmit(p51.Scene5Rage.Beam1);

            for _, descendant in pairs(p51.Scene5Rage.Beam1:GetDescendants()) do
                if descendant:isA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 670, function(p53, p54) -- Line: 271
            require(game.ReplicatedStorage.Part_Icles):AbsoluteEmit(p53.Scene5Rage.Beam2);

            for _, descendant in pairs(p54:GetDescendants()) do
                if descendant:isA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p53.Scene5Rage.Beam1:GetDescendants()) do
                if descendant:isA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 809, function(p55, p56) -- Line: 297
            require(game.ReplicatedStorage.Part_Icles):AbsoluteEmit(p55.HeavenlyAh);

            for _, descendant in pairs(p55.HeavenlyAh:GetDescendants()) do
                if descendant:isA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 931, function(p57, p58, p59) -- Line: 315
            for _, descendant in pairs(p59:GetDescendants()) do
                if descendant:isA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p59:GetDescendants()) do
                if descendant:isA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p57.HeavenlyAh:GetDescendants()) do
                if descendant:isA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 1180, function(p60, p61) -- Line: 338
            for _, descendant in pairs(p60.Scene6UltraInstinct.Step1Fx:GetDescendants()) do
                if descendant:isA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1234, function(p62, p63) -- Line: 347
            for _, descendant in pairs(p62.Scene6UltraInstinct.Step2Fx:GetDescendants()) do
                if descendant:isA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1286, function(p64, p65) -- Line: 356
            for _, descendant in pairs(p64.Scene6UltraInstinct.Step3Fx:GetDescendants()) do
                if descendant:isA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1344, function(p66, p67) -- Line: 365
            for _, descendant in pairs(p66.Scene6UltraInstinct.Step4Fx:GetDescendants()) do
                if descendant:isA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1396, function(p68, p69) -- Line: 374
            for _, descendant in pairs(p68.Scene6UltraInstinct.Step5Fx:GetDescendants()) do
                if descendant:isA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1468, function(p70, p71) -- Line: 383
            for _, descendant in pairs(p70.Scene67:GetDescendants()) do
                if descendant:isA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p70.Scene67:GetDescendants()) do
                if descendant:isA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1627, function(p72, p73, p74) -- Line: 406
            for _, descendant in pairs(p73:GetDescendants()) do
                if descendant:isA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p74:GetDescendants()) do
                if descendant:isA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p73:GetDescendants()) do
                if descendant:isA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p74:GetDescendants()) do
                if descendant:isA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};