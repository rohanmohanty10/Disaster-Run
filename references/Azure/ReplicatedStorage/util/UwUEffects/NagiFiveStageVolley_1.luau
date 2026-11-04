 
 

local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MeshEmit = require(ReplicatedStorage.MeshEmit);

return {
    [0] = function(p1, p2, p3) -- Line: 7
        local Meshes = p1.Meshes;

        for _, descendant in p1.Character.HumanoidRootPart.Cam:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            elseif descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in p2.Head.firestuff1:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in p2.Head.firestuff15:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in Meshes["5stagevolley"].effects.ballwind:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [2.167] = function(p4, p5, p6) -- Line: 43
        local _ = p4.Character;

        for _, descendant in p4.Meshes["5stagevolley"].effects.ballwind:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [2.867] = function(p7, p8, p9) -- Line: 58
        local _ = p7.Character;

        for _, descendant in p7.Meshes.nagi5stageemit1:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [3.6] = function(p10, p11, p12) -- Line: 69
        local _ = p10.Character;
        local _ = p10.Meshes;

        for _, v in p12.Ball do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;
    end,

    [3.85] = function(p13, p14, p15) -- Line: 80
        local _ = p13.Character;

        for _, descendant in p13.Meshes.nagilight:GetDescendants() do
            if descendant:IsA("PointLight") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [3.867] = function(p16, p17, p18) -- Line: 90
        -- upvalues: MeshEmit (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
        local _ = p16.Character;
        local effects = p16.Meshes["5stagevolley"].effects;
        local galaxywhirl = effects.galaxywhirl;

        for _, descendant in galaxywhirl:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in galaxywhirl:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in effects.meshes.galaxywhirl:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, true);
            end;
        end;

        for _, descendant in effects.kicksmoke:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        local u19 = ReplicatedStorage.Resources.nagi.galaxywhirlCC:Clone();
        u19.Parent = Lighting;
        local u20 = TweenService:Create(u19, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u20:Play();
        task.spawn(function() -- Line: 134
            -- upvalues: u20 (copy), u19 (copy)
            u20.Completed:Wait();
            u20:Destroy();
            u19:Destroy();
        end);
        Lighting.ExposureCompensation = 1;
        local u21 = TweenService:Create(Lighting, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ExposureCompensation = 0
        });
        u21:Play();
        task.spawn(function() -- Line: 145
            -- upvalues: u21 (copy)
            u21.Completed:Wait();
            u21:Destroy();
        end);
    end,

    [3.883] = function(p22, p23, p24) -- Line: 150
        local _ = p22.Character;
        local _ = p22.Meshes;

        for _, v in p24.Ball do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;
    end,

    [3.9] = function(p25, p26, p27) -- Line: 161
        local _ = p25.Meshes;

        for _, descendant in p25.Character.HumanoidRootPart.Cam:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [4.217] = function(p28, p29, p30) -- Line: 173
        local _ = p28.Character;

        for _, descendant in p28.Meshes["5stagevolley"].effects.galaxywhirl:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [4.717] = function(p31, p32, p33) -- Line: 188
        local _ = p31.Character;
        local _ = p31.Meshes;

        for _, descendant in p32.Head.soccerballatt:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [5.75] = function(p34, p35, p36) -- Line: 199
        local _ = p34.Character;

        for _, descendant in p34.Meshes.nagilight:GetDescendants() do
            if descendant:IsA("PointLight") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [5.767] = function(p37, p38, p39) -- Line: 209
        local _ = p37.Character;
        local Meshes = p37.Meshes;

        for _, descendant in Meshes.nagilight2:GetDescendants() do
            if descendant:IsA("PointLight") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in Meshes.nagilight3:GetDescendants() do
            if descendant:IsA("PointLight") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [5.833] = function(p40, p41, p42) -- Line: 224
        local _ = p40.Character;

        for _, descendant in p40.Meshes["5stagevolley"].effects.galaxywhirl:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [5.983] = function(p43, p44, p45) -- Line: 239
        local _ = p43.Character;
        local _ = p43.Meshes;

        for _, descendant in p44.Head.soccerballatt:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.225;
            end;
        end;
    end,

    [6.133] = function(p46, p47, p48) -- Line: 250
        local _ = p46.Character;

        for _, descendant in p46.Meshes["5stagevolley"].effects.lilcosmo:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [6.15] = function(p49, p50, p51) -- Line: 265
        local Character = p49.Character;
        local Cache = p49.Cache;

        for _, descendant in p49.Meshes["5stagevolley"].effects.aura:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                local v52 = descendant:Clone();
                v52.Enabled = true;
                table.insert(Cache, v52);
                v52.Parent = Character[descendant.Parent.Name];
            end;
        end;
    end,

    [6.683] = function(p53, p54, p55) -- Line: 284
        local _ = p53.Character;
        local _ = p53.Meshes;

        for _, descendant in p54.Head.soccerballatt:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in p54.Head.soccerballatt:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end,

    [8.65] = function(p56, p57, p58) -- Line: 301
        local _ = p56.Character;

        for _, descendant in p56.Meshes.nagilight:GetDescendants() do
            if descendant:IsA("PointLight") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [8.667] = function(p59, p60, p61) -- Line: 311
        local _ = p59.Character;

        for _, descendant in p59.Meshes["5stagevolley"].effects.lilcosmo:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [8.683] = function(p62, p63, p64) -- Line: 326
        local _ = p62.Character;
        local Meshes = p62.Meshes;

        for _, descendant in Meshes.nagilight2:GetDescendants() do
            if descendant:IsA("PointLight") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in Meshes.nagilight3:GetDescendants() do
            if descendant:IsA("PointLight") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [9.467] = function(p65, p66, p67) -- Line: 341
        local _ = p65.Character;

        for _, descendant in p65.Meshes["5stagevolley"].effects.jump:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [9.533] = function(p68, p69, p70) -- Line: 356
        local _ = p68.Character;

        for _, descendant in p68.Meshes["5stagevolley"].effects:WaitForChild("cold"):GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [9.55] = function(p71, p72, p73) -- Line: 371
        -- upvalues: MeshEmit (copy)
        local _ = p71.Character;
        local effects = p71.Meshes["5stagevolley"].effects;

        for _, descendant in effects.meshes.jump:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, true);
            end;
        end;

        for _, descendant in effects.inair:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [9.567] = function(p74, p75, p76) -- Line: 395
        -- upvalues: TweenService (copy)
        local _ = p74.Character;

        for _, descendant in ipairs(p74.Meshes["5stagevolley"].effects.ballbeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Brightness = 1;
                descendant.TextureSpeed = 3;
                descendant.CurveSize0 = -7;
                descendant.CurveSize1 = 8;
                local u77 = TweenService:Create(descendant, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    TextureSpeed = 0.5,
                    Brightness = 0,
                    CurveSize0 = 4,
                    CurveSize1 = -2
                });
                u77:Play();
                task.spawn(function() -- Line: 415
                    -- upvalues: u77 (copy)
                    u77.Completed:Wait();
                    u77:Destroy();
                end);
            end;
        end;
    end,

    [10.65] = function(p78, p79, p80) -- Line: 423
        local _ = p78.Character;
        local _ = p78.Meshes;

        for _, descendant in p79.Ball.friction:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [10.667] = function(p81, p82, p83) -- Line: 434
        local _ = p81.Character;

        for _, descendant in p81.Meshes["5stagevolley"].effects.ballhit:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [11] = function(p84, p85, p86) -- Line: 449
        local _ = p84.Character;

        for _, descendant in ipairs(p84.Meshes["5stagevolley"].effects.speedbars:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [11.017] = function(p87, p88, p89) -- Line: 464
        -- upvalues: TweenService (copy)
        local _ = p87.Character;
        local effects = p87.Meshes["5stagevolley"].effects;

        for _, v in p87.Cache do
            v.Enabled = false;
        end;

        for _, descendant in effects.cold:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in effects.coolkick:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        local coolkickbeams = effects.coolkickbeams;
        coolkickbeams.CFrame = effects.coolkick.CFrame * CFrame.Angles(0, 3.141592653589793, 1.5707963267948966);
        local u90 = TweenService:Create(coolkickbeams, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = coolkickbeams.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, -180)
        });
        u90:Play();
        task.spawn(function() -- Line: 499
            -- upvalues: u90 (copy)
            u90.Completed:Wait();
            u90:Destroy();
        end);

        for _, descendant in ipairs(coolkickbeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Brightness = 6;
                descendant.TextureSpeed = 9;
                local u91 = TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    TextureSpeed = 0.5,
                    Brightness = 0
                });
                u91:Play();
                task.spawn(function() -- Line: 513
                    -- upvalues: u91 (copy)
                    u91.Completed:Wait();
                    u91:Destroy();
                end);
            end;
        end;
    end,

    [11.117] = function(p92, p93, p94) -- Line: 521
        local _ = p92.Character;
        local _ = p92.Meshes;

        for _, descendant in p93.Ball.friction:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [12.883] = function(p95, p96, p97) -- Line: 532
        local _ = p95.Character;

        for _, descendant in ipairs(p95.Meshes["5stagevolley"].effects.speedbars:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [12.9] = function(p98, p99, p100) -- Line: 547
        local _ = p98.Character;

        for _, descendant in p98.Meshes["5stagevolley"].effects.cosmotrail:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [13.017] = function(p101, p102, p103) -- Line: 562
        -- upvalues: MeshEmit (copy)
        local _ = p101.Character;

        for _, descendant in p101.Meshes["5stagevolley"].effects.meshes.ball:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, true);
            end;
        end;
    end,

    [13.5] = function(p104, p105, p106) -- Line: 578
        -- upvalues: MeshEmit (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
        local _ = p104.Character;
        local effects = p104.Meshes["5stagevolley"].effects;

        for _, descendant in effects.follow:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in effects.meshes.follow:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, true);
            end;
        end;

        local u107 = ReplicatedStorage.Resources.nagi.goalCC:Clone();
        u107.Parent = Lighting;
        local u108 = TweenService:Create(u107, TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u108:Play();
        task.spawn(function() -- Line: 608
            -- upvalues: u108 (copy), u107 (copy)
            u108.Completed:Wait();
            u108:Destroy();
            u107:Destroy();
        end);
        Lighting.ExposureCompensation = 0.6;
        local u109 = TweenService:Create(Lighting, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ExposureCompensation = 0
        });
        u109:Play();
        task.spawn(function() -- Line: 619
            -- upvalues: u109 (copy)
            u109.Completed:Wait();
            u109:Destroy();
        end);
    end,

    [16] = function(p110, p111, p112) -- Line: 624
        -- upvalues: Lighting (copy)
        local galaxywhirlCC = Lighting:FindFirstChild("galaxywhirlCC");
        local goalCC = Lighting:FindFirstChild("goalCC");

        if galaxywhirlCC then
            galaxywhirlCC:Destroy();
        end;

        if goalCC then
            goalCC:Destroy();
        end;

        Lighting.ExposureCompensation = 1.5;
    end
};