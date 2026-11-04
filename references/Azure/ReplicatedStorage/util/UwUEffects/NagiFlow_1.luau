 
 

return {
    [0] = function(p1, p2, p3) -- Line: 2
        local _ = p1.Character;
        local Meshes = p1.Meshes;

        for _, descendant in pairs(Meshes.nagiflowauraspecs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.nagiflowskullaura1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.nagiflowskullaura2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.017] = function(p4, p5, p6) -- Line: 25
        local _ = p4.Character;
        local Meshes = p4.Meshes;

        for _, descendant in pairs(Meshes.nagiflowskullaura3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.nagiflowskullaura4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.033] = function(p7, p8, p9) -- Line: 42
        local _ = p7.Meshes;

        for _, descendant in pairs(p7.Character.Skull:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.083] = function(p10, p11, p12) -- Line: 53
        local _ = p10.Character;
        local Meshes = p10.Meshes;

        for _, v in p12.All do
            if v:IsA("Beam") then
                v.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.nagiflowskullaurawind:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.1] = function(p13, p14, p15) -- Line: 69
        local _ = p13.Character;

        for _, descendant in pairs(p13.Meshes.nagiawkskullmouthshading:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.8] = function(p16, p17, p18) -- Line: 80
        local _ = p16.Character;

        for _, descendant in pairs(p16.Meshes.nagiflowauraspecs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.015;
            end;
        end;
    end,

    [1.817] = function(p19, p20, p21) -- Line: 91
        local _ = p19.Character;

        for _, descendant in pairs(p19.Meshes.nagiawkmpactthing:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [2.05] = function(p22, p23, p24) -- Line: 102
        local _ = p22.Character;
        local Meshes = p22.Meshes;

        for _, descendant in pairs(Meshes.nagiflowskullaura3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.25;
            end;
        end;

        for _, descendant in pairs(Meshes.nagiflowskullaura4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.25;
            end;
        end;

        for _, descendant in pairs(Meshes.nagiflowskullaura2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.25;
            end;
        end;
    end,

    [2.25] = function(p25, p26, p27) -- Line: 125
        local _ = p25.Character;
        local _ = p25.Meshes;

        for _, v in p27.Head do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;
    end,

    [2.267] = function(p28, p29, p30) -- Line: 135
        local _ = p28.Character;
        local _ = p28.Meshes;

        for _, v in p30.Ball do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;
    end,

    [2.5] = function(p31, p32, p33) -- Line: 146
        local _ = p31.Character;

        for _, descendant in pairs(p31.Meshes.nagiawkskullmouthshading:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [2.617] = function(p34, p35, p36) -- Line: 157
        local _ = p34.Character;
        local _ = p34.Meshes;

        for _, v in p36.Ball do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;
    end,

    [2.633] = function(p37, p38, p39) -- Line: 168
        local _ = p37.Character;

        for _, descendant in pairs(p37.Meshes.nagiawkwindburst:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [6.433] = function(p40, p41, p42) -- Line: 179
        local _ = p40.Character;
        local _ = p40.Meshes;

        for _, v in p42.Head do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;
    end,

    [6.9] = function(p43, p44, p45) -- Line: 190
        local _ = p43.Character;
        local Meshes = p43.Meshes;

        for _, descendant in pairs(Meshes.nagiflowauraspecs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in pairs(Meshes.nagiflowskullaura1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in pairs(Meshes.nagiflowskullaura2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in pairs(Meshes.nagiflowskullaura3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in pairs(Meshes.nagiflowskullaura4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end,

    [7.25] = function() -- Line: 225
    end
};