 
 

return {
    { 0, function(p1, p2) -- Line: 3
            if p2 then
                p2.CamPart:FindFirstChild("Atmosphere");
            end;
        end },
    { 377, function(p3, p4) -- Line: 8
            if p4 then
                p4 = p4.CamPart:FindFirstChild("Atmosphere");
            end;

            if not p4 then
                return;
            end;

            for _, descendant in ipairs(p4:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 378, function(p5, p6) -- Line: 20
            if p6 then
                shared.vfx.emit(p6.CamPart.Impact);
            end;
        end },
    { 427, function(p7, p8) -- Line: 29
            if p8 then
                shared.vfx.emit(p8.CamPart.Manga["1"].ParticleEmitter);
            end;
        end },
    { 514, function(p9, p10) -- Line: 37
            if p10 then
                shared.vfx.emit(p10.CamPart.Y2.WindScene.AtmosphereWind.CameraGlow);
            end;
        end },
    { 519, function(p11, p12) -- Line: 44
            shared.vfx.emit(p11.BlackSphere.FirstGlows);

            if p12 then
                p12 = p12.CamPart:FindFirstChild("Atmosphere");
            end;

            if not p12 then
                return;
            end;

            for _, descendant in ipairs(p12:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 536, function(p13, p14) -- Line: 60
            if p14 then
                shared.vfx.emit(p14.CamPart.Manga["2"]);
            end;
        end },
    { 627, function(p15, p16) -- Line: 69
            shared.vfx.emit(p15.EnvironmentWind);
        end },
    { 739, function(p17, p18) -- Line: 74
            shared.vfx.emit(p17.BlackSphere.LastGlows);
            local v19;

            if p18 then
                v19 = p18.CamPart:FindFirstChild("Lines");
            else
                v19 = p18;
            end;

            if not v19 then
                return;
            end;

            for _, descendant in ipairs(v19:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            shared.vfx.emit(p18.CamPart.Manga["4"]);
            shared.vfx.emit(p18.CamPart.Manga["3"]);
        end },
    { 975, function(p20, p21) -- Line: 93
            if p21 then
                p21 = p21.CamPart:FindFirstChild("Lines");
            end;

            if not p21 then
                return;
            end;

            for _, descendant in ipairs(p21:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};