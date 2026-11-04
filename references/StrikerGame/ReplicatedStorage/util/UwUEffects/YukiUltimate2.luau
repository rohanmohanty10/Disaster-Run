 

 

game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local MeshEmit = require(ReplicatedStorage.MeshEmit);

return {
    [0] = function(p1, p2, p3) -- Line: 9
        local _ = p1.Meshes;
        local _ = p1.Cache;
        local HumanoidRootPart = p1.Character.HumanoidRootPart;
        local speed = (HumanoidRootPart:FindFirstChild("Cam") or HumanoidRootPart:FindFirstChild("blenderCam")).CamPart:WaitForChild("speed");

        for _, descendant in ipairs(speed:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [2.0833333333333335] = function(p4, p5, p6) -- Line: 25
        local _ = p4.Meshes;
        local _ = p4.Cache;
        local HumanoidRootPart = p4.Character.HumanoidRootPart;
        local speed = (HumanoidRootPart:FindFirstChild("Cam") or HumanoidRootPart:FindFirstChild("blenderCam")).CamPart:WaitForChild("speed");

        for _, descendant in ipairs(speed:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [2.4833333333333334] = function(p7, p8, p9) -- Line: 41
        local _ = p7.Meshes;
        local _ = p7.Cache;
        local HumanoidRootPart = p7.Character.HumanoidRootPart;
        local camfly = (HumanoidRootPart:FindFirstChild("Cam") or HumanoidRootPart:FindFirstChild("blenderCam")).CamPart:WaitForChild("camfly");

        for _, descendant in ipairs(camfly:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [2.716666666666667] = function(p10, p11, p12) -- Line: 57
        -- upvalues: TweenService (copy)
        local Meshes = p10.Meshes;
        local _ = p10.Cache;
        local HumanoidRootPart = p10.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        local startsmoke = Meshes:WaitForChild("yukimiya"):WaitForChild("effects"):WaitForChild("startsmoke");

        for _, descendant in ipairs(startsmoke:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                descendant.TimeScale = 1;
                local u13 = TweenService:Create(descendant, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    TimeScale = 0.1
                });
                task.delay(0.1, function() -- Line: 78
                    -- upvalues: u13 (copy)
                    u13:Play();
                end);
                task.spawn(function() -- Line: 82
                    -- upvalues: u13 (copy)
                    u13.Completed:Wait();
                    u13:Destroy();
                end);
            end;
        end;
    end,

    [3.183333333333333] = function(p14, p15, p16) -- Line: 90
        -- upvalues: TweenService (copy), Debris (copy)
        local Meshes = p14.Meshes;
        local _ = p14.Cache;
        local HumanoidRootPart = p14.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        local background = Meshes:WaitForChild("yukimiya"):WaitForChild("effects"):WaitForChild("background");
        background.Transparency = 1;
        local u17 = TweenService:Create(background, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 0
        });
        u17:Play();
        task.spawn(function() -- Line: 108
            -- upvalues: u17 (copy)
            u17.Completed:Wait();
            u17:Destroy();
        end);
        local v18 = script.dust:Clone();
        table.insert(p14.Cache, v18);
        v18.CFrame = HumanoidRootPart.CFrame;
        v18.Parent = workspace.Effects;
        Debris:AddItem(v18, 1.32);
        local PointLight = background:WaitForChild("Attachment").PointLight;
        PointLight.Brightness = 0;
        local u19 = TweenService:Create(PointLight, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = 2
        });
        u19:Play();
        task.spawn(function() -- Line: 126
            -- upvalues: u19 (copy)
            u19.Completed:Wait();
            u19:Destroy();
        end);
    end,

    [3.4166666666666665] = function(p20, p21, p22) -- Line: 131
        local _ = p20.Meshes;
        local _ = p20.Cache;
        local HumanoidRootPart = p20.Character.HumanoidRootPart;
        local camfly = (HumanoidRootPart:FindFirstChild("Cam") or HumanoidRootPart:FindFirstChild("blenderCam")).CamPart:WaitForChild("camfly");

        for _, descendant in ipairs(camfly:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [3.9166666666666665] = function(p23, p24, p25) -- Line: 147
        -- upvalues: TweenService (copy)
        local Meshes = p23.Meshes;
        local _ = p23.Cache;
        local HumanoidRootPart = p23.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        local startsmoke = Meshes:WaitForChild("yukimiya"):WaitForChild("effects"):WaitForChild("startsmoke");

        for _, descendant in ipairs(startsmoke:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
                local u26 = TweenService:Create(descendant, TweenInfo.new(4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    TimeScale = 1
                });
                u26:Play();
                task.spawn(function() -- Line: 168
                    -- upvalues: u26 (copy)
                    u26.Completed:Wait();
                    u26:Destroy();
                end);
            end;
        end;
    end,

    [4.533333333333333] = function(p27, p28, p29) -- Line: 176
        local _ = p27.Meshes;
        local _ = p27.Cache;
        local HumanoidRootPart = p27.Character.HumanoidRootPart;
        local camlights = (HumanoidRootPart:FindFirstChild("Cam") or HumanoidRootPart:FindFirstChild("blenderCam")).CamPart:WaitForChild("camlights");

        for _, descendant in ipairs(camlights:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [4.55] = function(p30, p31, p32) -- Line: 192
        local Meshes = p30.Meshes;
        local _ = p30.Cache;
        local HumanoidRootPart = p30.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        local background = Meshes:WaitForChild("yukimiya"):WaitForChild("effects"):WaitForChild("background");
        background.Transparency = 1;
        background:WaitForChild("Attachment").PointLight.Brightness = 0;
    end,

    [5.316666666666666] = function(p33, p34, p35) -- Line: 209
        -- upvalues: TweenService (copy)
        local Meshes = p33.Meshes;
        local _ = p33.Cache;
        local HumanoidRootPart = p33.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        local effects = Meshes:WaitForChild("yukimiya"):WaitForChild("effects");
        local v36 = effects:WaitForChild("crosshairs")["1"];

        for _, descendant in ipairs(v36:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
                local u37 = TweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    TimeScale = 0
                });
                task.delay(0.15, function() -- Line: 228
                    -- upvalues: u37 (copy)
                    u37:Play();
                end);
                task.spawn(function() -- Line: 232
                    -- upvalues: u37 (copy)
                    u37.Completed:Wait();
                    u37:Destroy();
                end);
            end;
        end;

        local v38 = effects:WaitForChild("crosshairs")["1_emit"];

        for _, descendant in ipairs(v38:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [5.766666666666667] = function(p39, p40, p41) -- Line: 248
        -- upvalues: TweenService (copy)
        local Meshes = p39.Meshes;
        local _ = p39.Cache;
        local HumanoidRootPart = p39.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        local effects = Meshes:WaitForChild("yukimiya"):WaitForChild("effects");
        local v42 = effects:WaitForChild("crosshairs")["2"];

        for _, descendant in ipairs(v42:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
                local u43 = TweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    TimeScale = 0
                });
                task.delay(0.15, function() -- Line: 267
                    -- upvalues: u43 (copy)
                    u43:Play();
                end);
                task.spawn(function() -- Line: 271
                    -- upvalues: u43 (copy)
                    u43.Completed:Wait();
                    u43:Destroy();
                end);
            end;
        end;

        local v44 = effects:WaitForChild("crosshairs")["2_emit"];

        for _, descendant in ipairs(v44:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [5.9] = function(p45, p46, p47) -- Line: 287
        -- upvalues: TweenService (copy)
        local Meshes = p45.Meshes;
        local _ = p45.Cache;
        local HumanoidRootPart = p45.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        local effects = Meshes:WaitForChild("yukimiya"):WaitForChild("effects");
        local v48 = effects:WaitForChild("crosshairs")["3"];

        for _, descendant in ipairs(v48:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
                local u49 = TweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    TimeScale = 0
                });
                task.delay(0.15, function() -- Line: 306
                    -- upvalues: u49 (copy)
                    u49:Play();
                end);
                task.spawn(function() -- Line: 310
                    -- upvalues: u49 (copy)
                    u49.Completed:Wait();
                    u49:Destroy();
                end);
            end;
        end;

        local v50 = effects:WaitForChild("crosshairs")["3_emit"];

        for _, descendant in ipairs(v50:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [7.016666666666667] = function(p51, p52, p53) -- Line: 326
        local eye_crosshair = p51.Character:WaitForChild("eye_crosshair");

        for _, descendant in ipairs(eye_crosshair:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [7.016666666666667] = function(p54, p55, p56) -- Line: 337
        local _ = p54.Meshes;
        local _ = p54.Cache;
        local HumanoidRootPart = p54.Character.HumanoidRootPart;
        local camlights = (HumanoidRootPart:FindFirstChild("Cam") or HumanoidRootPart:FindFirstChild("blenderCam")).CamPart:WaitForChild("camlights");

        for _, descendant in ipairs(camlights:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [7.033333333333333] = function(p57, p58, p59) -- Line: 353
        local Meshes = p57.Meshes;
        local _ = p57.Cache;
        local HumanoidRootPart = p57.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        local crosshairs = Meshes:WaitForChild("yukimiya"):WaitForChild("effects"):WaitForChild("crosshairs");

        for _, descendant in ipairs(crosshairs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
                descendant.TimeScale = 1;
            end;
        end;
    end,

    [8.85] = function(p60, p61, p62) -- Line: 373
        local eye_flame = p60.Character:WaitForChild("eye_flame");

        for _, descendant in ipairs(eye_flame:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [8.933333333333334] = function(p63, p64, p65) -- Line: 384
        local eye_crosshair = p63.Character:WaitForChild("eye_crosshair");

        for _, descendant in ipairs(eye_crosshair:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [9.016666666666667] = function(p66, p67, p68) -- Line: 395
        local flameappear = p66.Character:WaitForChild("flameappear");

        for _, descendant in ipairs(flameappear:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [11.633333333333333] = function(p69, p70, p71) -- Line: 406
        -- upvalues: MeshEmit (copy)
        local Character = p69.Character;
        local effects = p69.Meshes:WaitForChild("yukimiya"):WaitForChild("effects");
        local eye_flame = Character:WaitForChild("eye_flame");

        for _, descendant in ipairs(eye_flame:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        local balltrail = effects:WaitForChild("balltrail");

        for _, descendant in ipairs(balltrail:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        local kick = effects:WaitForChild("kick");

        for _, descendant in ipairs(kick:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in effects:WaitForChild("meshes"):WaitForChild("kick"):GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, true);
            end;
        end;

        local ballspeed = Character:WaitForChild("ballspeed");

        for _, descendant in ipairs(ballspeed:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [11.65] = function(p72, p73, p74) -- Line: 454
        local _ = p72.Meshes;
        local _ = p72.Cache;
        local HumanoidRootPart = p72.Character.HumanoidRootPart;
        local v75 = HumanoidRootPart:FindFirstChild("Cam") or HumanoidRootPart:FindFirstChild("blenderCam");
        local kickscreen = v75.CamPart:WaitForChild("kickscreen");

        for _, descendant in ipairs(kickscreen:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        local speedbars = v75.CamPart:WaitForChild("speedbars");

        for _, descendant in ipairs(speedbars:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [14.75] = function(p76, p77, p78) -- Line: 478
        local _ = p76.Meshes;
        local _ = p76.Cache;
        local HumanoidRootPart = p76.Character.HumanoidRootPart;
        local kickscreen = (HumanoidRootPart:FindFirstChild("Cam") or HumanoidRootPart:FindFirstChild("blenderCam")).CamPart:WaitForChild("kickscreen");

        for _, descendant in ipairs(kickscreen:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [14.816666666666666] = function(p79, p80, p81) -- Line: 494
        local Character = p79.Character;
        local Meshes = p79.Meshes;
        local _ = p79.Cache;
        local HumanoidRootPart = Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        local balltrail = Meshes:WaitForChild("yukimiya"):WaitForChild("effects"):WaitForChild("balltrail");

        for _, descendant in ipairs(balltrail:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        local ballwind = Character:WaitForChild("ballwind");

        for _, descendant in ipairs(ballwind:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [14.816666666666666] = function(p82, p83, p84) -- Line: 520
        local _ = p82.Meshes;
        local _ = p82.Cache;
        local HumanoidRootPart = p82.Character.HumanoidRootPart;
        local speedbars = (HumanoidRootPart:FindFirstChild("Cam") or HumanoidRootPart:FindFirstChild("blenderCam")).CamPart:WaitForChild("speedbars");

        for _, descendant in ipairs(speedbars:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [15.483333333333333] = function(p85, p86, p87) -- Line: 536
        local Character = p85.Character;
        local Meshes = p85.Meshes;
        local _ = p85.Cache;
        local HumanoidRootPart = Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        Meshes:WaitForChild("yukimiya"):WaitForChild("effects");
        local ballwind = Character:WaitForChild("ballwind");

        for _, descendant in ipairs(ballwind:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        local ballspeed = Character:WaitForChild("ballspeed");

        for _, descendant in ipairs(ballspeed:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [21.533] = function() -- Line: 562
    end
};