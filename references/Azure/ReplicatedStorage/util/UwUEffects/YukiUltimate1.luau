 

 

game:GetService("Lighting");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0] = function(p1, p2, p3) -- Line: 6
        local _ = p1.Meshes;
        local _ = p1.Cache;
        local HumanoidRootPart = p1.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;
    end,

    [0.11666666666666667] = function(p4, p5, p6) -- Line: 16
        local _ = p4.Meshes;
        local _ = p4.Cache;
        local HumanoidRootPart = p4.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(p5.HumanoidRootPart["1"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [0.55] = function(p7, p8, p9) -- Line: 26
        local _ = p7.Meshes;
        local _ = p7.Cache;
        local HumanoidRootPart = p7.Character.HumanoidRootPart;
        local v10 = HumanoidRootPart:FindFirstChild("Cam") or HumanoidRootPart:FindFirstChild("blenderCam");

        for _, descendant in pairs(p8.HumanoidRootPart["2"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(p8.HumanoidRootPart["ground beam"]:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(v10.CamPart.BeamHolder1:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.7333333333333333] = function(p11, p12, p13) -- Line: 52
        local _ = p11.Meshes;
        local _ = p11.Cache;
        local HumanoidRootPart = p11.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(p12.HumanoidRootPart["2"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [0.9666666666666667] = function(p14, p15, p16) -- Line: 62
        local _ = p14.Meshes;
        local _ = p14.Cache;
        local HumanoidRootPart = p14.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(p15.HumanoidRootPart["3"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [1.0666666666666667] = function(p17, p18, p19) -- Line: 72
        local _ = p17.Meshes;
        local _ = p17.Cache;
        local HumanoidRootPart = p17.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(p18.HumanoidRootPart["4"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [1.75] = function(p20, p21, p22) -- Line: 82
        local _ = p20.Meshes;
        local _ = p20.Cache;
        local HumanoidRootPart = p20.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(p21.HumanoidRootPart["5"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [1.9] = function(p23, p24, p25) -- Line: 92
        local _ = p23.Meshes;
        local _ = p23.Cache;
        local HumanoidRootPart = p23.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(p24.HumanoidRootPart["ground beam"]:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = false;
            end;
        end;
    end,

    [1.9166666666666667] = function(p26, p27, p28) -- Line: 108
        local _ = p26.Meshes;
        local _ = p26.Cache;
        local HumanoidRootPart = p26.Character.HumanoidRootPart;
        local v29 = HumanoidRootPart:FindFirstChild("Cam") or HumanoidRootPart:FindFirstChild("blenderCam");

        for _, descendant in pairs(v29.CamPart.BeamHolder1:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = false;
            end;
        end;
    end,

    [2.15] = function(p30, p31, p32) -- Line: 124
        local _ = p30.Meshes;
        local _ = p30.Cache;
        local HumanoidRootPart = p30.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(p31.HumanoidRootPart["6"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [2.45] = function(p33, p34, p35) -- Line: 134
        local _ = p33.Meshes;
        local _ = p33.Cache;
        local HumanoidRootPart = p33.Character.HumanoidRootPart;

        if not HumanoidRootPart:FindFirstChild("Cam") then
            HumanoidRootPart:FindFirstChild("blenderCam");
        end;

        for _, descendant in pairs(p34.HumanoidRootPart["7"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [3.517] = function() -- Line: 144
    end
};