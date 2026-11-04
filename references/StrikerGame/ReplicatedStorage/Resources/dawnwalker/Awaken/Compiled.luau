 

 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p2.Beams1);
            shared.vfx.emit(p2.CamVFX.Winds);

            for _, descendant in pairs(p1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "AuraDawnwalker" then
                    descendant.Enabled = false;
                end;
            end;

            p2.Charge.Large.Center.Attachment.PointLight.Enabled = false;
            p2.PointLight.A1.PointLight.Enabled = false;
            p2.PointLight.Back.PointLight.Enabled = false;
        end },
    { 31, function(p3, p4) -- Line: 23
            shared.vfx.emit(p4.Stomp);

            for _, descendant in pairs(p3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "AuraDawnwalker" then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 60, function(p5, p6) -- Line: 34
            for _, descendant in pairs(p5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "AuraDawnwalker" then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 97, function(p7, p8) -- Line: 44
            shared.vfx.emit(p8.Charge);
            p8.Charge.Large.Center.Attachment.PointLight.Enabled = true;
            p8.PointLight.A1.PointLight.Enabled = true;
            shared.vfx.emit(p8.CamVFX.smth);
        end },
    { 148, function(p9, p10) -- Line: 55
            p10.PointLight.Back.PointLight.Enabled = true;
            p10.Charge.Large.Center.Attachment.PointLight.Enabled = false;
        end },
    { 232, function(p11, p12) -- Line: 64
            shared.vfx.emit(p12.CamVFX.Center);
        end },
    { 314, function(p13, p14) -- Line: 69
            for _, descendant in pairs(p13:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "AuraDawnwalker" then
                    descendant.Enabled = true;
                end;
            end;

            shared.vfx.emit(p14.FakeHead.Eyes);
            p14.PointLight.A1.PointLight.Enabled = false;
            p14.PointLight.Back.PointLight.Enabled = false;
        end }
};