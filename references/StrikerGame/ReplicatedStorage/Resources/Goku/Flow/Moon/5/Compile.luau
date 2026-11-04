 

 

return {
    { 0, function() -- Line: 2
            local BackDrop = workspace.UltraInstinct.Scene1FreeFall.BackDrop;

            for _, descendant in pairs(BackDrop:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(BackDrop:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.UltraInstinct.Space:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 75, function() -- Line: 24
            local BackDrop = workspace.UltraInstinct.Scene1FreeFall.BackDrop;

            for _, descendant in pairs(BackDrop:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(BackDrop:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 90, function() -- Line: 40
            require(workspace.UltraInstinct.Scene2SpinFall.RandomSpin.SpinSpin)(workspace.TuffCharacterRig.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 100, function() -- Line: 44
            require(workspace.UltraInstinct.Scene2SpinFall.RandomSpin.SpinSpin)(workspace.TuffCharacterRig.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 110, function() -- Line: 48
            require(workspace.UltraInstinct.Scene2SpinFall.RandomSpin.SpinSpin)(workspace.TuffCharacterRig.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 120, function() -- Line: 52
            require(workspace.UltraInstinct.Scene2SpinFall.RandomSpin.SpinSpin)(workspace.TuffCharacterRig.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 127, function() -- Line: 56
            require(workspace.UltraInstinct.Scene2SpinFall.FlyMesh.ModuleMesh)(workspace.TuffCharacterRig.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 132, function() -- Line: 60
            require(workspace.UltraInstinct.Scene2SpinFall.FlyMesh.ModuleMesh)(workspace.TuffCharacterRig.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 137, function() -- Line: 64
            require(workspace.UltraInstinct.Scene2SpinFall.FlyMesh.ModuleMesh)(workspace.TuffCharacterRig.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 141, function() -- Line: 68
            require(workspace.UltraInstinct.Scene2SpinFall.FlyMesh.ModuleMesh)(workspace.TuffCharacterRig.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 145, function() -- Line: 72
            for _, descendant in pairs(workspace.UltraInstinct.Scene3Slam.BeamBack:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 146, function() -- Line: 80
            require(workspace.UltraInstinct.Scene2SpinFall.FlyMesh.ModuleMesh)(workspace.TuffCharacterRig.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 151, function() -- Line: 84
            require(workspace.UltraInstinct.Scene2SpinFall.FlyMesh.ModuleMesh)(workspace.TuffCharacterRig.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 156, function() -- Line: 88
            require(workspace.UltraInstinct.Scene2SpinFall.FlyMesh.ModuleMesh)(workspace.TuffCharacterRig.Torso.CFrame * CFrame.new(0, 0, 0));
        end },
    { 160, function() -- Line: 92
            require(workspace.Part_Icles):AbsoluteEmit(workspace.UltraInstinct.Scene3Slam);
        end },
    { 201, function() -- Line: 97
            require(workspace.Part_Icles):AbsoluteEmit(workspace.UltraInstinct.Scene4Awakening.Ink1);
        end },
    { 220, function() -- Line: 102
            require(workspace.Part_Icles):AbsoluteEmit(workspace.UltraInstinct.Scene4Awakening.Ink2);
        end },
    { 240, function() -- Line: 107
            require(workspace.Part_Icles):AbsoluteEmit(workspace.UltraInstinct.Scene4Awakening.Ink3);
        end },
    { 255, function() -- Line: 112
            require(workspace.Part_Icles):AbsoluteEmit(workspace.UltraInstinct.Scene4Awakening.Ink4);

            for _, descendant in pairs(workspace.Cam.CamPart.Paint3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 266, function() -- Line: 123
            require(workspace.Part_Icles):AbsoluteEmit(workspace.UltraInstinct.Scene4Awakening.Ink5);

            for _, descendant in pairs(workspace.Cam.CamPart.Paint1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 283, function() -- Line: 134
            require(workspace.Part_Icles):AbsoluteEmit(workspace.UltraInstinct.Scene4Awakening.Ink6);

            for _, descendant in pairs(workspace.Cam.CamPart.Paint2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 295, function() -- Line: 145
            require(workspace.Part_Icles):AbsoluteEmit(workspace.UltraInstinct.Scene4Awakening.Ink7);
        end },
    { 325, function() -- Line: 150
            for _, descendant in pairs(workspace.UltraInstinct.Scene3Slam.BeamBack:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 455, function() -- Line: 158
            require(workspace.Part_Icles):AbsoluteEmit(workspace.UltraInstinct.Scene5Rage.BuildUp);

            for _, descendant in pairs(workspace.TuffCharacterRig:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 515, function() -- Line: 169
            require(workspace.Part_Icles):AbsoluteEmit(workspace.UltraInstinct.Scene5Rage.StartGround);
        end },
    { 556, function() -- Line: 174
            local workspace_Part_Icles = require(workspace.Part_Icles);
            local Beam1 = workspace.UltraInstinct.Scene5Rage.Beam1;
            workspace_Part_Icles:AbsoluteEmit(Beam1);

            for _, descendant in pairs(Beam1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 670, function() -- Line: 187
            local workspace_Part_Icles = require(workspace.Part_Icles);
            local Beam1 = workspace.UltraInstinct.Scene5Rage.Beam1;
            workspace_Part_Icles:AbsoluteEmit(workspace.UltraInstinct.Scene5Rage.Beam2);

            for _, descendant in pairs(workspace.TuffCharacterRig:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(Beam1:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 809, function() -- Line: 206
            local workspace_Part_Icles = require(workspace.Part_Icles);
            local HeavenlyAh = workspace.UltraInstinct.HeavenlyAh;
            workspace_Part_Icles:AbsoluteEmit(HeavenlyAh);

            for _, descendant in pairs(HeavenlyAh:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 931, function() -- Line: 219
            local workspace_R6 = workspace.R6;

            for _, descendant in pairs(workspace_R6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace_R6:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.UltraInstinct.HeavenlyAh:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 1180, function() -- Line: 241
            for _, descendant in pairs(workspace.UltraInstinct.Scene6UltraInstinct.Step1Fx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1234, function() -- Line: 249
            for _, descendant in pairs(workspace.UltraInstinct.Scene6UltraInstinct.Step2Fx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1286, function() -- Line: 257
            for _, descendant in pairs(workspace.UltraInstinct.Scene6UltraInstinct.Step3Fx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1344, function() -- Line: 265
            for _, descendant in pairs(workspace.UltraInstinct.Scene6UltraInstinct.Step4Fx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1396, function() -- Line: 273
            for _, descendant in pairs(workspace.UltraInstinct.Scene6UltraInstinct.Step5Fx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1468, function() -- Line: 281
            local Scene67 = workspace.UltraInstinct.Scene67;

            for _, descendant in pairs(Scene67:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(Scene67:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1627, function() -- Line: 297
            local workspace_R6 = workspace.R6;

            for _, descendant in pairs(workspace_R6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace_R6:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.TuffCharacterRig:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.TuffCharacterRig:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};