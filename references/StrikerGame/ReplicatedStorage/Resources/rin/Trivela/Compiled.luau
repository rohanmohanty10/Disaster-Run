 
 

return {
    { 9, function(p1) -- Line: 3
            shared.vfx.emit(p1.TuffCharacterRig2.HumanoidRootPart.Attachment);
        end },
    { 121, function(p2) -- Line: 8
            shared.vfx.emit(p2.TuffCharacterRig2.Head.EyeFlash2);
        end },
    { 180, function(p3) -- Line: 13
            for _, descendant in ipairs(p3.TuffCharacterRig2.HumanoidRootPart.balleffect:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = true;
                    task.delay(2.65, function() -- Line: 17
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;

            for _, descendant in ipairs(p3.TuffCharacterRig2.HumanoidRootPart["ground beam"]:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                    task.delay(2.65, function() -- Line: 24
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 347, function(p4) -- Line: 30
            shared.vfx.emit(p4.TuffCharacterRig2.HumanoidRootPart.catch);
            shared.vfx.emit(p4.TuffCharacterRig2.Head.EyeFlash2);
        end },
    { 378, function(p5) -- Line: 36
            for _, descendant in ipairs(p5.TuffCharacterRig2.Ball:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = true;
                    task.delay(1.66, function() -- Line: 40
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;

            shared.vfx.emit(p5.TuffCharacterRig2.HumanoidRootPart.catch);
        end },
    { 426, function(p6) -- Line: 47
            shared.vfx.emit(p6.TuffCharacterRig2.HumanoidRootPart.catch);
            local SurfaceLight = p6.TuffCharacterRig2.HumanoidRootPart.ShotLight.SurfaceLight;
            SurfaceLight.Enabled = true;
            task.delay(0.71666, function() -- Line: 54
                -- upvalues: SurfaceLight (copy)
                SurfaceLight.Enabled = false;
            end);
        end }
};