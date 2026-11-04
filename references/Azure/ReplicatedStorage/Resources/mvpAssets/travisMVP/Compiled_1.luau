 
 

return {
    { 0, function(p1, p2) -- Line: 5
            for _, descendant in pairs(p2:FindFirstChild("Right Arm"):FindFirstChild("RightGripAttachment2"):GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("PointLight")) then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p1:FindFirstChild("welcomestars"):GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 157, function(p3, p4) -- Line: 22
            for _, descendant in pairs(p4:FindFirstChild("Right Arm"):FindFirstChild("RightGripAttachment2"):GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("PointLight")) then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 354, function(p5, p6) -- Line: 33
            for _, descendant in pairs(p6:FindFirstChild("Left Arm"):FindFirstChild("LeftGripAttachment2"):GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("PointLight")) then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 630, function(p7, p8) -- Line: 44
            local TweenService = game:GetService("TweenService");
            TweenService:Create(game.Lighting, TweenInfo.new(1), {
                ClockTime = 0
            }):Play();
            TweenService:Create(game.Lighting, TweenInfo.new(1.25), {
                Ambient = Color3.new(0, 0, 0)
            }):Play();
            TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(1.25), {
                Density = 0.7,
                Color = Color3.new(0, 0, 0)
            }):Play();
        end },
    { 678, function(p9, p10) -- Line: 54
            for _, descendant in pairs(p10:FindFirstChild("Left Arm"):FindFirstChild("LeftGripAttachment2"):GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("PointLight")) then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(p10:FindFirstChild("Right Arm"):FindFirstChild("RightGripAttachment2"):GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("PointLight")) then
                    descendant.Enabled = false;
                end;
            end;

            local StarExplosion = p9:FindFirstChild("StarExplosion");

            for _, descendant in pairs(StarExplosion:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                end;
            end;

            local PointLight = p9:FindFirstChild("StarExplosion"):FindFirstChild("Attachment"):FindFirstChild("PointLight");
            local TweenService = game:GetService("TweenService");
            PointLight.Brightness = 40;
            PointLight.Color = Color3.fromRGB(255, 255, 255);
            PointLight.Range = 20;
            TweenService:Create(PointLight, TweenInfo.new(5), {
                Brightness = 0,
                Range = 15
            }):Play();
        end },
    { 849, function(p11, p12) -- Line: 88
            local PointLight = p11:FindFirstChild("StarExplosion"):FindFirstChild("Attachment2"):FindFirstChild("PointLight");
            local TweenService = game:GetService("TweenService");
            PointLight.Brightness = 23;
            PointLight.Range = 120;
            PointLight.Color = Color3.fromRGB(255, 102, 0);
            TweenService:Create(PointLight, TweenInfo.new(2), {
                Brightness = 0,
                Range = 70
            }):Play();
        end },
    { 1054, function(p13, p14) -- Line: 102
            local fireworks = p13:FindFirstChild("fireworks");

            for _, descendant in pairs(fireworks:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                end;
            end;

            for _, descendant in pairs(p14:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant.Name == "tpSmoke" then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 2);
                end;
            end;
        end }
};