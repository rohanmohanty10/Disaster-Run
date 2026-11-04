 

 

return {
    [0] = function(p1, p2) -- Line: 2
        local Character = p1.Character;
        local _ = p1.Cache;

        for _, descendant in pairs(p1.Meshes.VFX["0"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Character.HumanoidRootPart.Cam["1"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.7666666666666667] = function(p3, p4) -- Line: 10
        local _ = p3.Character;
        local Meshes = p3.Meshes;
        local _ = p3.Cache;

        for _, descendant in pairs(Meshes.VFX["0"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Meshes.VFX["0.5"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [1.3] = function(p5, p6) -- Line: 18
        local _ = p5.Character;
        local _ = p5.Cache;

        for _, descendant in pairs(p5.Meshes.Pre1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [2.0166666666666666] = function(p7, p8) -- Line: 29
        local _ = p7.Character;
        local Meshes = p7.Meshes;
        local _ = p7.Cache;

        for _, descendant in pairs(Meshes.Pre1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Meshes.Pre2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [3.25] = function(p9, p10) -- Line: 47
        local Character = p9.Character;
        local Meshes = p9.Meshes;
        local _ = p9.Cache;

        for _, descendant in pairs(Meshes.VFX["0.5"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Meshes.VFX["0.7"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(Character.HumanoidRootPart.Cam["1"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Character.HumanoidRootPart.Cam["2"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [9.566666666666666] = function(p11, p12) -- Line: 59
        local Character = p11.Character;
        local _ = p11.Meshes;
        local _ = p11.Cache;

        for _, descendant in pairs(Character.HumanoidRootPart.Cam["2"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Character.HumanoidRootPart.Cam["1"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [10.216666666666667] = function(p13, p14) -- Line: 67
        local _ = p13.Character;
        local _ = p13.Meshes;
        local _ = p13.Cache;

        for _, descendant in pairs(p14.Head.breath1:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [12.483333333333333] = function(p15, p16) -- Line: 73
        local _ = p15.Character;
        local _ = p15.Meshes;
        local _ = p15.Cache;

        for _, descendant in pairs(p16.Head.breath2:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [15] = function() -- Line: 79
    end
};