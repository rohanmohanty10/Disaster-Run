 
 

game:GetService("Lighting");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0] = function(p1, p2, p3) -- Line: 6
        local _ = p1.Meshes;
        local _ = p1.Cache;
        local HumanoidRootPart = p1.Character.HumanoidRootPart;
        local v4 = HumanoidRootPart:FindFirstChild("Cam") or HumanoidRootPart:FindFirstChild("blenderCam");

        for _, v in pairs(p3.Victim.Head) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;

        for _, v in pairs(p3.Victim.Head) do
            if v:IsA("ParticleEmitter") then
                v.TimeScale = 1;
            end;
        end;

        for _, v in pairs(p3.Head) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;

        for _, descendant in pairs(v4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(v4:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.16666666666666666] = function(p5, p6, p7) -- Line: 45
        local _ = p5.Meshes;
        local _ = p5.Cache;
        local HumanoidRootPart = p5.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, v in pairs(p7.Victim["Right Leg"]) do
            if v:IsA("ParticleEmitter") then
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [0.38333333333333336] = function(p8, p9, p10) -- Line: 60
        local _ = p8.Meshes;
        local _ = p8.Cache;
        local HumanoidRootPart = p8.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, v in pairs(p10.Victim["Left Leg"]) do
            if v:IsA("ParticleEmitter") then
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [0.6] = function(p11, p12, p13) -- Line: 74
        local _ = p11.Meshes;
        local _ = p11.Cache;
        local HumanoidRootPart = p11.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, v in pairs(p13.Victim["Right Leg"]) do
            if v:IsA("ParticleEmitter") then
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [0.7166666666666667] = function(p14, p15, p16) -- Line: 88
        local _ = p14.Meshes;
        local _ = p14.Cache;
        local HumanoidRootPart = p14.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, v in p16.Victim.Head do
            if v:IsA("ParticleEmitter") then
                v.TimeScale = 0.15;
            end;
        end;
    end,

    [0.8333333333333334] = function(p17, p18, p19) -- Line: 103
        local _ = p17.Meshes;
        local _ = p17.Cache;
        local HumanoidRootPart = p17.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, v in pairs(p19.Victim["Left Leg"]) do
            if v:IsA("ParticleEmitter") then
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [1.05] = function(p20, p21, p22) -- Line: 117
        local _ = p20.Meshes;
        local _ = p20.Cache;
        local HumanoidRootPart = p20.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, v in pairs(p22.Victim["Right Leg"]) do
            if v:IsA("ParticleEmitter") then
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [2.533333333333333] = function(p23, p24, p25) -- Line: 131
        local Meshes = p23.Meshes;
        local _ = p23.Cache;
        local HumanoidRootPart = p23.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarchargething:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [3.566666666666667] = function(p26, p27, p28) -- Line: 145
        local _ = p26.Meshes;
        local _ = p26.Cache;
        local HumanoidRootPart = p26.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, v in pairs(p28.Ball) do
            if v:IsA("Trail") then
                v.Enabled = true;
            end;
        end;
    end,

    [4.75] = function(p29, p30, p31) -- Line: 158
        local Meshes = p29.Meshes;
        local _ = p29.Cache;
        local HumanoidRootPart = p29.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarflashimpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [4.95] = function(p32, p33, p34) -- Line: 172
        local Meshes = p32.Meshes;
        local _ = p32.Cache;
        local HumanoidRootPart = p32.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarchargething:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [5.316666666666666] = function(p35, p36, p37) -- Line: 186
        local Meshes = p35.Meshes;
        local _ = p35.Cache;
        local HumanoidRootPart = p35.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarbackgroundcrack:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [5.35] = function(p38, p39, p40) -- Line: 200
        local Meshes = p38.Meshes;
        local _ = p38.Cache;
        local HumanoidRootPart = p38.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarfirstimpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [5.766666666666667] = function(p41, p42, p43) -- Line: 214
        local Meshes = p41.Meshes;
        local _ = p41.Cache;
        local HumanoidRootPart = p41.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarsecondimpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(Meshes.superstarthirdimpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [5.783333333333333] = function(p44, p45, p46) -- Line: 234
        local Meshes = p44.Meshes;
        local _ = p44.Cache;
        local HumanoidRootPart = p44.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarbackgroundcrack:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [5.8] = function(p47, p48, p49) -- Line: 248
        local Meshes = p47.Meshes;
        local _ = p47.Cache;
        local HumanoidRootPart = p47.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarrinimpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [5.85] = function(p50, p51, p52) -- Line: 262
        local Meshes = p50.Meshes;
        local _ = p50.Cache;
        local HumanoidRootPart = p50.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarthirdimpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.15;
            end;
        end;
    end,

    [5.866666666666666] = function(p53, p54, p55) -- Line: 276
        local Meshes = p53.Meshes;
        local _ = p53.Cache;
        local HumanoidRootPart = p53.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstargroundimpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [6.116666666666666] = function(p56, p57, p58) -- Line: 290
        local Meshes = p56.Meshes;
        local _ = p56.Cache;
        local HumanoidRootPart = p56.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarrinimpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.5;
            end;
        end;
    end,

    [6.883333333333334] = function(p59, p60, p61) -- Line: 304
        local _ = p59.Meshes;
        local _ = p59.Cache;
        local HumanoidRootPart = p59.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, v in pairs(p61.Ball) do
            if v:IsA("Trail") then
                v.Enabled = false;
            end;
        end;
    end,

    [7.266666666666667] = function(p62, p63, p64) -- Line: 317
        local Meshes = p62.Meshes;
        local _ = p62.Cache;
        local HumanoidRootPart = p62.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarrinimpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end,

    [7.316666666666666] = function(p65, p66, p67) -- Line: 331
        local Meshes = p65.Meshes;
        local _ = p65.Cache;
        local HumanoidRootPart = p65.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarthirdimpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end,

    [7.366666666666666] = function(p68, p69, p70) -- Line: 345
        local Meshes = p68.Meshes;
        local _ = p68.Cache;
        local HumanoidRootPart = p68.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarfinalambience2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [7.566666666666666] = function(p71, p72, p73) -- Line: 359
        local Meshes = p71.Meshes;
        local _ = p71.Cache;
        local HumanoidRootPart = p71.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarfourthimpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [7.583333333333333] = function(p74, p75, p76) -- Line: 373
        local Meshes = p74.Meshes;
        local _ = p74.Cache;
        local HumanoidRootPart = p74.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarfinalambience1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [7.6] = function(p77, p78, p79) -- Line: 387
        local Meshes = p77.Meshes;
        local _ = p77.Cache;
        local HumanoidRootPart = p77.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarkaiserimpactwindthing:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [7.616666666666666] = function(p80, p81, p82) -- Line: 401
        local _ = p80.Meshes;
        local _ = p80.Cache;
        local HumanoidRootPart = p80.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, v in pairs(p82["Left Leg"]) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;
    end,

    [7.633333333333334] = function(p83, p84, p85) -- Line: 415
        local Meshes = p83.Meshes;
        local _ = p83.Cache;
        local HumanoidRootPart = p83.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarambiencespecs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.superstarambiencespecs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end,

    [7.65] = function(p86, p87, p88) -- Line: 435
        local Meshes = p86.Meshes;
        local _ = p86.Cache;
        local HumanoidRootPart = p86.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarpointlight:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [7.766666666666667] = function(p89, p90, p91) -- Line: 448
        local Meshes = p89.Meshes;
        local _ = p89.Cache;
        local HumanoidRootPart = p89.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarkaiserimpactwindthing:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.15;
            end;
        end;
    end,

    [8.2] = function(p92, p93, p94) -- Line: 462
        local Meshes = p92.Meshes;
        local _ = p92.Cache;
        local HumanoidRootPart = p92.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarambiencespecs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.025;
            end;
        end;
    end,

    [9.633333333333333] = function(p95, p96, p97) -- Line: 476
        local Meshes = p95.Meshes;
        local _ = p95.Cache;
        local HumanoidRootPart = p95.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarpointlight:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [9.65] = function(p98, p99, p100) -- Line: 489
        local Meshes = p98.Meshes;
        local _ = p98.Cache;
        local HumanoidRootPart = p98.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarballlines:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [10.066666666666666] = function(p101, p102, p103) -- Line: 503
        local _ = p101.Meshes;
        local _ = p101.Cache;
        local HumanoidRootPart = p101.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, v in pairs(p103["Left Leg"]) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;
    end,

    [10.1] = function(p104, p105, p106) -- Line: 517
        local Meshes = p104.Meshes;
        local _ = p104.Cache;
        local HumanoidRootPart = p104.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarambiencespecs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Meshes.superstarambiencespecs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end,

    [10.233333333333333] = function(p107, p108, p109) -- Line: 537
        local Meshes = p107.Meshes;
        local _ = p107.Cache;
        local HumanoidRootPart = p107.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarimpactend:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [10.266666666666667] = function(p110, p111, p112) -- Line: 551
        local Meshes = p110.Meshes;
        local _ = p110.Cache;
        local HumanoidRootPart = p110.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarkaiserimpactwindthing:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end,

    [10.283333333333333] = function(p113, p114, p115) -- Line: 565
        local Meshes = p113.Meshes;
        local _ = p113.Cache;
        local HumanoidRootPart = p113.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarballlines:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [10.3] = function(p116, p117, p118) -- Line: 579
        local Meshes = p116.Meshes;
        local _ = p116.Cache;
        local HumanoidRootPart = p116.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarwindoff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 589
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end,

    [10.55] = function(p119, p120, p121) -- Line: 595
        local Meshes = p119.Meshes;
        local _ = p119.Cache;
        local HumanoidRootPart = p119.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarimpactend:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.5;
            end;
        end;
    end,

    [12.1] = function(p122, p123, p124) -- Line: 609
        local Meshes = p122.Meshes;
        local _ = p122.Cache;
        local HumanoidRootPart = p122.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.superstarambiencespecs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Meshes.superstarambiencespecs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end,

    [12.7] = function(p125, p126, p127) -- Line: 629
        local Meshes = p125.Meshes;
        local _ = p125.Cache;
        local HumanoidRootPart = p125.Character.HumanoidRootPart;
        local Head = p127.Victim.Head;

        for _, v in pairs(Head) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;

        for _, v in pairs(Head) do
            if v:IsA("ParticleEmitter") then
                v.TimeScale = 1;
            end;
        end;

        for _, v in pairs(p127.Head) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;

        local superstarimpactend = Meshes.superstarimpactend;

        for _, descendant in pairs(superstarimpactend:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        local v128 = HumanoidRootPart:FindFirstChild("Cam") or HumanoidRootPart:FindFirstChild("blenderCam");

        if v128 then
            for _, descendant in pairs(v128:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end;

        for _, descendant in pairs(superstarimpactend:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end
};