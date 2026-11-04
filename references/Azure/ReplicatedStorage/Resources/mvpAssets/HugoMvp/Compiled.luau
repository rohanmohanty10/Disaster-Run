 
 

return {
    { 0, function(p1, p2) -- Line: 3
            for _, descendant in pairs(p2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p2.Parent:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 117, function(p3, p4) -- Line: 18
            for _, descendant in pairs(p4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and (descendant.Parent.Name ~= "Finger.003.R" and descendant.Name == "Black Smoke 31") or (descendant.Name == "Growing Smoke FX4" or (descendant.Name == "Growing Smoke FX5" or (descendant.Name == "Growing Smoke FX6" or descendant.Name == "Smoke3217"))) then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 347, function(p5, p6) -- Line: 28
            for _, descendant in pairs(p6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and (descendant.Parent.Name ~= "Finger.003.R" and descendant.Name == "Black Smoke 31") or (descendant.Name == "Growing Smoke FX4" or (descendant.Name == "Growing Smoke FX5" or (descendant.Name == "Growing Smoke FX6" or descendant.Name == "Smoke3217"))) then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 505, function(p7, p8) -- Line: 38
            for _, descendant in pairs(p8:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Parent.Name ~= "Finger.003.R" then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 549, function(p9, p10) -- Line: 48
            for _, descendant in pairs(p10:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p10.Parent.LeftHand:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(p10.Parent.RightHand:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 566, function(p11, p12) -- Line: 68
            shared.vfx.emit(p11.CamPart:FindFirstChild("Attachment").WindScene.AtmosphereWind.CameraGlow2);
        end }
};