 

 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");

return {
    { 3, function(p1) -- Line: 9
            -- upvalues: TweenService (copy)
            local Terrain = workspace:FindFirstChild("Terrain");

            if not Terrain then
                return;
            end;

            local v2 = Terrain:FindFirstChildOfClass("Clouds");

            if not v2 then
                return;
            end;

            TweenService:Create(v2, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                Cover = 1
            }):Play();
        end },
    { 16, function(p3, p4) -- Line: 26
            -- upvalues: RunService (copy)
            local CamPart = p4:FindFirstChild("CamPart");

            if not CamPart then
                return;
            end;

            local Wind = CamPart:FindFirstChild("Wind");

            if not Wind then
                return;
            end;

            for _, descendant in pairs(Wind:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                    descendant.TextureSpeed = 1;
                    descendant.Transparency = NumberSequence.new(1);
                    task.spawn(function() -- Line: 44
                        -- upvalues: RunService (ref), descendant (copy)
                        local v5 = 0;

                        while v5 < 2 do
                            v5 = v5 + RunService.Heartbeat:Wait();
                            local v6 = math.clamp(v5 / 2, 0, 1) * -0.09999999999999998 + 1;
                            descendant.Transparency = NumberSequence.new(v6);
                        end;

                        descendant.Transparency = NumberSequence.new(0.9);
                    end);
                end;
            end;
        end },
    { 116, function(p7) -- Line: 61
            local SmokeBG = p7:FindFirstChild("SmokeBG");

            if not SmokeBG then
                return;
            end;

            for _, descendant in pairs(SmokeBG:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 290, function(p8) -- Line: 75
            -- upvalues: Lighting (copy)
            local DragonAtmos = p8:FindFirstChild("DragonAtmos");

            if not DragonAtmos then
                return;
            end;

            DragonAtmos.Parent = Lighting;
        end },
    { 297, function(p9) -- Line: 86
            local SliferCard = p9:FindFirstChild("SliferCard");

            if not SliferCard then
                return;
            end;

            for _, descendant in pairs(SliferCard:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 299, function(p10) -- Line: 100
            local FlashingScene1 = p10:FindFirstChild("FlashingScene1");

            if not FlashingScene1 then
                return;
            end;

            for _, descendant in pairs(FlashingScene1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                elseif descendant:IsA("PointLight") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 305, function(p11) -- Line: 116
            local Terrain = workspace:FindFirstChild("Terrain");

            if not Terrain then
                return;
            end;

            local v12 = Terrain:FindFirstChildOfClass("Clouds");

            if not v12 then
                return;
            end;

            v12.Color = Color3.fromRGB(177, 75, 255);
        end },
    { 381, function(p13) -- Line: 129
            local SliferCard = p13:FindFirstChild("SliferCard");

            if SliferCard then
                for _, descendant in pairs(SliferCard:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end;

            local LightningBG = p13:FindFirstChild("LightningBG");

            if LightningBG then
                for _, descendant in pairs(LightningBG:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    elseif descendant:IsA("PointLight") then
                        descendant.Enabled = true;
                    end;
                end;
            end;

            local LightningCloud = p13:FindFirstChild("LightningCloud");

            if LightningCloud then
                for _, descendant in pairs(LightningCloud:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = true;
                    end;
                end;
            end;
        end },
    { 495, function(p14) -- Line: 163
            local LightningBG = p14:FindFirstChild("LightningBG");

            if not LightningBG then
                return;
            end;

            for _, descendant in pairs(LightningBG:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                elseif descendant:IsA("PointLight") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 501, function(p15) -- Line: 179
            local background1 = p15:FindFirstChild("background1");

            if not background1 then
                return;
            end;

            background1.Transparency = 0;
        end },
    { 504, function(p16) -- Line: 189
            for _, descendant in pairs(p16.Shine2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 506, function(p17) -- Line: 201
            local LightningCloud = p17:FindFirstChild("LightningCloud");

            if not LightningCloud then
                return;
            end;

            for _, descendant in pairs(LightningCloud:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 509, function(p18, p19, p20) -- Line: 215
            -- upvalues: RunService (copy)
            local DragonAuraShine = p18:FindFirstChild("DragonAuraShine");

            if not DragonAuraShine then
                return;
            end;

            local u21 = nil;

            for _, descendant in pairs(DragonAuraShine:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;

                    if descendant.Name == "StarGaze" then
                        u21 = descendant;
                    end;
                end;
            end;

            if not u21 then
                return;
            end;

            local v22 = p20 and p20:FindFirstChildOfClass("Highlight");

            if v22 then
                v22.Enabled = true;
            end;

            u21.Size = NumberSequence.new(5);
            task.spawn(function() -- Line: 246
                -- upvalues: RunService (ref), u21 (ref)
                local v23 = 0;

                while v23 < 0.7 do
                    v23 = v23 + RunService.Heartbeat:Wait();
                    local v24 = math.clamp(v23 / 0.7, 0, 1) * 495 + 5;
                    u21.Size = NumberSequence.new(v24);
                end;

                u21.Size = NumberSequence.new(500);
            end);
        end },
    { 540, function(p25, p26, p27) -- Line: 261
            local DragonAuraShine = p25:FindFirstChild("DragonAuraShine");

            if DragonAuraShine then
                for _, descendant in pairs(DragonAuraShine:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end;

            local v28 = p27 and p27:FindFirstChildOfClass("Highlight");

            if v28 then
                v28.Enabled = false;
            end;
        end },
    { 542, function(p29) -- Line: 282
            shared.vfx.emit(p29.FristUP);
        end },
    { 543, function(p30) -- Line: 289
            local UserAura = p30:FindFirstChild("UserAura");

            if not UserAura then
                return;
            end;

            local Shine = UserAura:FindFirstChild("Shine", true);

            for _, descendant in pairs(UserAura:GetDescendants()) do
                if not (Shine and descendant:IsDescendantOf(Shine)) and descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 544, function(p31) -- Line: 309
            local background1 = p31:FindFirstChild("background1");

            if not background1 then
                return;
            end;

            background1.Transparency = 1;
        end },
    { 546, function(p32) -- Line: 319
            for _, descendant in pairs(p32.GroundB:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 576, function(p33) -- Line: 331
            for _, descendant in pairs(p33.TrailWind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 584, function(p34) -- Line: 343
            local UserAura = p34:FindFirstChild("UserAura");

            if not UserAura then
                return;
            end;

            local v35 = nil;

            for _, descendant in pairs(UserAura:GetDescendants()) do
                if descendant.Name == "Shine" and descendant:IsA("Attachment") then
                    v35 = descendant;
                    break;
                end;
            end;

            if not v35 then
                return;
            end;

            for _, descendant in pairs(v35:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 592, function(p36) -- Line: 368
            for _, descendant in pairs(p36.GroundE:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 704, function(p37) -- Line: 380
            local UserAura = p37:FindFirstChild("UserAura");

            if not UserAura then
                return;
            end;

            for _, descendant in pairs(UserAura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 706, function(p38) -- Line: 394
            for _, descendant in pairs(p38.GroundB:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 720, function(p39) -- Line: 406
            local background2 = p39:FindFirstChild("background2");

            if not background2 then
                return;
            end;

            background2.Transparency = 0;
        end },
    { 725, function(p40) -- Line: 416
            for _, descendant in pairs(p40.TrailWind:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 731, function(p41) -- Line: 428
            for _, descendant in pairs(p41.GroundE:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 732, function(p42) -- Line: 440
            local Roar = p42:FindFirstChild("Roar");

            if not Roar then
                return;
            end;

            for _, descendant in pairs(Roar:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            task.wait(0.8);

            for _, descendant in pairs(Roar:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 747, function(p43) -- Line: 462
            for _, descendant in pairs(p43.Shine2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 748, function(p44) -- Line: 474
            for _, descendant in pairs(p44.Roar2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 749, function(p45, p46) -- Line: 486
            for _, descendant in pairs(p46.CamPart.CameraLines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 751, function(p47, p48) -- Line: 498
            for _, descendant in pairs(p48.CamPart.CameraLines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 752, function(p49, p50) -- Line: 510
            for _, descendant in pairs(p50.CamPart.CameraLines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 780, function(p51, p52) -- Line: 522
            for _, descendant in pairs(p52.CamPart.CameraLines1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 781, function(p53) -- Line: 534
            local SliferRigs = workspace:FindFirstChild("SliferRigs");

            if not SliferRigs then
                return;
            end;

            local v54 = SliferRigs:FindFirstChild("1_030_eye_obj");

            if not v54 then
                return;
            end;

            local Scene1Eye = v54:FindFirstChild("Scene1Eye");

            if not Scene1Eye then
                return;
            end;

            for _, descendant in pairs(Scene1Eye:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            task.wait(1);

            for _, descendant in pairs(Scene1Eye:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 800, function(p55) -- Line: 562
            for _, descendant in pairs(p55.Roar2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 852, function(p56) -- Line: 575
            local background2 = p56:FindFirstChild("background2");

            if not background2 then
                return;
            end;

            background2.Transparency = 1;
        end },
    { 862, function(p57) -- Line: 585
            local SickClouds = p57:FindFirstChild("SickClouds");

            if not SickClouds then
                return;
            end;

            for _, descendant in pairs(SickClouds:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 875, function(p58, p59, p60) -- Line: 599
            local v61 = p60:FindFirstChild("1_030_eye_obj");

            if not v61 then
                return;
            end;

            local Scene2Eye = v61:FindFirstChild("Scene2Eye");

            if not Scene2Eye then
                return;
            end;

            for _, descendant in pairs(Scene2Eye:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            task.wait(2);

            for _, descendant in pairs(Scene2Eye:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 876, function(p62, p63) -- Line: 626
            local CamPart = p63:FindFirstChild("CamPart");

            if not CamPart then
                return;
            end;

            local Wind = CamPart:FindFirstChild("Wind");

            if not Wind then
                return;
            end;

            for _, descendant in pairs(Wind:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.TextureSpeed = 0.05;
                end;
            end;
        end },
    { 877, function(p64, p65) -- Line: 644
            local CamPart = p65:FindFirstChild("CamPart");

            if not CamPart then
                return;
            end;

            local Glitter = CamPart:FindFirstChild("Glitter");

            if not Glitter then
                return;
            end;

            for _, descendant in pairs(Glitter:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 992, function(p66) -- Line: 662
            local Cloud = p66:FindFirstChild("Cloud");

            if not Cloud then
                return;
            end;

            for _, descendant in pairs(Cloud:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1022, function(p67) -- Line: 676
            local SickCloudsButBigger = p67:FindFirstChild("SickCloudsButBigger");

            if not SickCloudsButBigger then
                return;
            end;

            for _, descendant in pairs(SickCloudsButBigger:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1023, function(p68) -- Line: 690
            local Terrain = workspace:FindFirstChild("Terrain");

            if not Terrain then
                return;
            end;

            local v69 = Terrain:FindFirstChildOfClass("Clouds");

            if not v69 then
                return;
            end;

            v69.Color = Color3.fromRGB(255, 255, 255);
        end },
    { 1048, function(p70) -- Line: 703
            for _, descendant in pairs(p70.LBeams:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1049, function(p71) -- Line: 715
            for _, descendant in pairs(p71.Shine3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1050, function(p72) -- Line: 727
            for _, descendant in pairs(p72.Shine3:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1135, function(p73) -- Line: 739
            for _, descendant in pairs(p73.Shine3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 1138, function(p74) -- Line: 751
            for _, descendant in pairs(p74.Shine3:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 1156, function(p75) -- Line: 763
            for _, descendant in pairs(p75.LBeams:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 1193, function(p76) -- Line: 775
            -- upvalues: Lighting (copy)
            local DragonAtmos = Lighting:FindFirstChild("DragonAtmos");

            if DragonAtmos then
                DragonAtmos:Destroy();
            end;

            local Terrain = workspace:FindFirstChild("Terrain");
            local v77 = Terrain and Terrain:FindFirstChildOfClass("Clouds");

            if v77 then
                v77.Cover = 0;
                v77.Color = Color3.fromRGB(255, 255, 255);
            end;
        end }
};