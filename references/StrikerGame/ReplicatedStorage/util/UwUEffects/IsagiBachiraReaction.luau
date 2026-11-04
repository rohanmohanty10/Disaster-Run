 

 

game:GetService("Lighting");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0] = function(p1, p2, p3) -- Line: 6
        local _ = p1.Meshes;
        local _ = p1.Cache;
        local HumanoidRootPart = p1.Character.HumanoidRootPart;
        local v4 = HumanoidRootPart:FindFirstChild("Cam") or HumanoidRootPart:FindFirstChild("blenderCam");

        for _, descendant in pairs(p2.Head.scribbleeye15:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(p2.Head.scribbleeye1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(v4:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(v4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, v in p3.Head do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;
    end,

    [0.016666666666666666] = function(p5, p6, p7) -- Line: 44
        local _ = p5.Victim;
        local _ = p5.Meshes;
        local _ = p5.Cache;
        local HumanoidRootPart = p5.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(p6.Head.firestuff1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(p6.Head.firestuff15:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, v in p7.Victim.Head do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;
    end,

    [4.033333333333333] = function(p8, p9, p10) -- Line: 72
        local _ = p8.Meshes;
        local _ = p8.Cache;
        local HumanoidRootPart = p8.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(p9.Head.firestuff1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(p9.Head.firestuff15:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [7.2] = function(p11, p12, p13) -- Line: 93
        local Meshes = p11.Meshes;
        local _ = p11.Cache;
        local HumanoidRootPart = p11.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.isagitagshotsweat:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [7.3] = function(p14, p15, p16) -- Line: 108
        local _ = p14.Meshes;
        local _ = p14.Cache;
        local HumanoidRootPart = p14.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(p15.Head.scribbleeye15:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(p15.Head.scribbleeye1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [7.316666666666666] = function(p17, p18, p19) -- Line: 129
        local _ = p17.Meshes;
        local _ = p17.Cache;
        local HumanoidRootPart = p17.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(p18.Head.firestuff1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(p18.Head.firestuff15:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [7.35] = function(p20, p21, p22) -- Line: 150
        local Meshes = p20.Meshes;
        local _ = p20.Cache;
        local HumanoidRootPart = p20.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.isagitagshotbeams1:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [7.583333333333333] = function(p23, p24, p25) -- Line: 164
        local _ = p23.Meshes;
        local _ = p23.Cache;
        local HumanoidRootPart = p23.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, v in p25.Ball do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;
    end,

    [8.383333333333333] = function(p26, p27, p28) -- Line: 179
        local Meshes = p26.Meshes;
        local _ = p26.Cache;
        local HumanoidRootPart = p26.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.isagitagshotbeams1:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [8.4] = function(p29, p30, p31) -- Line: 193
        local Meshes = p29.Meshes;
        local _ = p29.Cache;
        local HumanoidRootPart = p29.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.isagitagshotbeams2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.isagitagshotbeams3:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.isagitagshotbeams4:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.isagitagshotbeams5:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [8.416666666666666] = function(p32, p33, p34) -- Line: 222
        local Meshes = p32.Meshes;
        local _ = p32.Cache;
        local HumanoidRootPart = p32.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.isagitagshotvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [8.533333333333333] = function(p35, p36, p37) -- Line: 237
        local Meshes = p35.Meshes;
        local _ = p35.Cache;
        local HumanoidRootPart = p35.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(Meshes.isagitagshotvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.15;
            end;
        end;
    end,

    [8.766666666666667] = function(p38, p39, p40) -- Line: 252
        local _ = p38.Meshes;
        local _ = p38.Cache;
        local HumanoidRootPart = p38.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, v in p40.Ball do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;
    end,

    [10] = function() -- Line: 267
    end
};