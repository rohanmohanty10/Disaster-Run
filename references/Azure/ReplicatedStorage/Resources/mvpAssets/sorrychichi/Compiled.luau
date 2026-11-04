 

 

return {
    { 0, function(p1, p2) -- Line: 4
            shared.vfx.emit(p1.wind);
        end },
    { 18, function(p3, p4) -- Line: 10
            for _, descendant in pairs(p4.HumanoidRootPart.CutsceneVFX.Step2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 33, function(p5, p6) -- Line: 20
            for _, descendant in pairs(p6.HumanoidRootPart.CutsceneVFX.Step3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 153, function(p7, p8) -- Line: 30
            shared.vfx.emit(p7.a);
        end },
    { 303, function(p9, p10) -- Line: 36
            for _, descendant in pairs(p10.HumanoidRootPart.CutsceneVFX.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;

            shared.vfx.emit(p9.mesh["3"]);
        end },
    { 900, function(p11, p12) -- Line: 47
            for _, descendant in pairs(p12.HumanoidRootPart.CutsceneVFX.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 993, function(p13, p14) -- Line: 57
            shared.vfx.emit(p13.mesh["4"]);
        end },
    { 1020, function(p15, p16) -- Line: 63
            shared.vfx.emit(p15.spin);
        end },
    { 1077, function(p17, p18) -- Line: 69
            local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));
            Part_Icles:Activate();
            Part_Icles:AbsoluteEmit(p17.mesh["1"]);
        end },
    { 1234, function(p19, p20) -- Line: 79
            shared.vfx.emit(p19.mesh["5"]);
        end },
    { 1290, function(p21, p22) -- Line: 85
            for _, descendant in pairs(p21.Throw:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;

            shared.vfx.emit(p21.mesh["6"]);
        end },
    { 1356, function(p23, p24, p25) -- Line: 97
            for _, descendant in pairs(p23.Throw:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p25.Torso.ThrownEnable:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            shared.vfx.emit(p23.thrown);
            local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));
            Part_Icles:Activate();
            Part_Icles:AbsoluteEmit(p23.mesh["7"]);
        end },
    { 1702, function(p26, p27) -- Line: 120
            shared.vfx.emit(p26.mesh["2"]);
        end },
    { 1764, function(p28, p29, p30) -- Line: 126
            for _, descendant in pairs(p30.Torso.ThrownEnable:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 1781, function(p31, p32) -- Line: 136
            shared.vfx.emit(p31.b);
        end },
    { 1888, function(p33, p34) -- Line: 143
            local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));
            Part_Icles:Activate();
            Part_Icles:AbsoluteEmit(p33.mesh.text);
            local firework = p33.final.firework;
            wait(1);
            Part_Icles:AbsoluteEmit(firework);
            Part_Icles:AbsoluteEmit(firework);
        end }
};