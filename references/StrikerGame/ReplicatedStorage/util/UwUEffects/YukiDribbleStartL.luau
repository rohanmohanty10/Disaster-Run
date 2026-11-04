 

 

game:GetService("Lighting");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0] = function(p1, p2, p3) -- Line: 6
        local _ = p1.Direction;
        local _ = p1.Character;
        local _ = p1.Meshes;
        local _ = p1.Cache;

        for _, descendant in pairs(p2.HumanoidRootPart["0"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [0.167] = function(p4, p5, p6) -- Line: 16
        local _ = p4.Character;
        local _ = p4.Meshes;
        local _ = p4.Cache;

        for _, descendant in pairs(p5.HumanoidRootPart["0.5"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [0.3] = function(p7, p8, p9) -- Line: 25
        local _ = p7.Character;
        local _ = p7.Meshes;
        local _ = p7.Cache;
        local HumanoidRootPart = p8.HumanoidRootPart;

        for _, descendant in pairs(HumanoidRootPart["1"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(HumanoidRootPart["1.5"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.5] = function(p10, p11, p12) -- Line: 36
        local _ = p10.Character;
        local _ = p10.Meshes;
        local _ = p10.Cache;
        local HumanoidRootPart = p11.HumanoidRootPart;

        for _, descendant in pairs(HumanoidRootPart["2"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(HumanoidRootPart["1.5"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [0.583] = function(p13, p14, p15) -- Line: 47
        local _ = p13.Character;
        local _ = p13.Meshes;
        local _ = p13.Cache;

        for _, descendant in pairs(p14.HumanoidRootPart["2.5"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.7] = function(p16, p17, p18) -- Line: 56
        local _ = p16.Character;
        local _ = p16.Meshes;
        local _ = p16.Cache;

        for _, descendant in pairs(p17.HumanoidRootPart["2.5"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [0.817] = function(p19, p20, p21) -- Line: 65
        local _ = p19.Character;
        local _ = p19.Meshes;
        local _ = p19.Cache;
        local HumanoidRootPart = p20.HumanoidRootPart;

        for _, descendant in pairs(HumanoidRootPart["3"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(HumanoidRootPart["3.5"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [1.5] = function(p22, p23, p24) -- Line: 76
        local _ = p22.Character;
        local _ = p22.Meshes;
        local _ = p22.Cache;
        local HumanoidRootPart = p23.HumanoidRootPart;

        for _, v in p24.All do
            if v:IsA("Trail") then
                v.Enabled = false;
            end;
        end;

        for _, descendant in pairs(HumanoidRootPart["3.5"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [3] = function() -- Line: 92
    end
};