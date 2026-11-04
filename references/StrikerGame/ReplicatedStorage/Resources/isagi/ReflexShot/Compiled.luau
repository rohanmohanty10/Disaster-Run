 

 

return {
    { 0, function(p1) -- Line: 3
            for _, descendant in ipairs(p1.TuffCharacterRig0.HumanoidRootPart.Fall:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(2, function() -- Line: 7
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 133, function(p2) -- Line: 13
            p2.TuffCharacterRig0.HumanoidRootPart["Light 3"].SurfaceLight.Enabled = true;
        end },
    { 230, function(p3) -- Line: 18
            shared.vfx.emit(p3.TuffCharacterRig0.HumanoidRootPart.Grass);
            p3.TuffCharacterRig0.HumanoidRootPart["Light 3"].SurfaceLight.Enabled = false;
        end },
    { 534, function(p4) -- Line: 24
            shared.vfx.emit(p4.TuffCharacterRig0.HumanoidRootPart.Breakthrough);
        end },
    { 545, function(p5) -- Line: 29
            for _, descendant in ipairs(p5.puzzlesphere:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(2.5, function() -- Line: 33
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;

            for _, descendant in ipairs(p5.Puzzles:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(2.5, function() -- Line: 40
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;

            p5["Plane.130"].PointLight.Enabled = true;
        end },
    { 807, function(p6) -- Line: 48
            shared.vfx.emit(p6["Plane.130"].Shine);
        end },
    { 900, function(p7) -- Line: 53
            shared.vfx.emit(p7.yukipaintsplatter);
        end },
    { 966, function(p8) -- Line: 58
            shared.vfx.emit(p8["Plane.130"]["0"]);
        end },
    { 996, function(p9) -- Line: 63
            shared.vfx.emit(p9.TuffCharacterRig0.HumanoidRootPart.Crush);
        end },
    { 1003, function(p10) -- Line: 68
            shared.vfx.emit(p10.TuffCharacterRig0.Head);
        end },
    { 1009, function(p11) -- Line: 73
            p11.TuffCharacterRig0.HumanoidRootPart["Light 2"].SurfaceLight.Enabled = true;
            p11["Plane.130"].PointLight.Enabled = false;
            shared.vfx.emit(p11.TuffCharacterRig0["Right Arm"]["Crush 2"]);
        end },
    { 1088, function(p12) -- Line: 81
            p12.TuffCharacterRig0.HumanoidRootPart["Light 2"].SurfaceLight.Enabled = false;
        end }
};