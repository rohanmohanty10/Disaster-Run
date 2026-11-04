 
 

game:GetService("Lighting");
game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.MeshEmit);

return {
    [0] = function(p1, p2, p3) -- Line: 7
        local _ = p1.Meshes;
        local _ = p1.Cache;

        for _, descendant in pairs(p1.Character.HumanoidRootPart.blenderCam:GetDescendants()) do
            if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, v in p3.All do
            if v.Name == "Aura" then
                v.Enabled = true;
            end;
        end;
    end,

    [0.1] = function(p4, p5, p6) -- Line: 25
        local _ = p4.Character;
        local _ = p4.Cache;

        for _, descendant in pairs(p4.Meshes.nagirouletteambience:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.133] = function(p7, p8, p9) -- Line: 37
        local _ = p7.Character;
        local _ = p7.Cache;

        for _, descendant in pairs(p7.Meshes.nagiroulettevolleyemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [0.25] = function(p10, p11, p12) -- Line: 49
        local _ = p10.Character;
        local _ = p10.Cache;

        for _, descendant in pairs(p10.Meshes.nagiroulettevolleyemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.4;
            end;
        end;

        for _, v in p12.All do
            if v.Name == "Aura" then
                v.Enabled = false;
            end;
        end;
    end,

    [0.367] = function(p13, p14, p15) -- Line: 65
        local _ = p13.Character;
        local _ = p13.Cache;

        for _, descendant in pairs(p13.Meshes.nagirouletteambiencemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [2.2] = function(p16, p17, p18) -- Line: 77
        local _ = p16.Character;
        local _ = p16.Cache;

        for _, descendant in pairs(p16.Meshes.nagiroulettevolleyemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end,

    [3.05] = function(p19, p20, p21) -- Line: 89
        local _ = p19.Character;
        local _ = p19.Cache;

        for _, descendant in pairs(p19.Meshes.nagiroulettevolleyemit2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, v in p21.All do
            if v.Name == "Aura" then
                v.Enabled = true;
            end;
        end;

        for _, descendant in pairs(p20.Ball.nagiroulettetorso:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [4.033] = function(p22, p23, p24) -- Line: 113
        local _ = p22.Character;
        local _ = p22.Cache;

        for _, descendant in pairs(p22.Meshes.nagiroulettevolleyemit25:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [4.117] = function(p25, p26, p27) -- Line: 125
        local _ = p25.Character;
        local _ = p25.Meshes;
        local _ = p25.Cache;

        for _, v in p27.Ball do
            if v:IsA("ParticleEmitter") then
                v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [4.133] = function(p28, p29, p30) -- Line: 137
        local _ = p28.Character;
        local _ = p28.Cache;

        for _, descendant in pairs(p28.Meshes.nagiroulettevolleyemit25:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.6;
            end;
        end;
    end,

    [6.633] = function(p31, p32, p33) -- Line: 149
        local _ = p31.Character;
        local _ = p31.Meshes;
        local _ = p31.Cache;

        for _, descendant in pairs(p32.Ball.nagiroulettetorso:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [6.65] = function(p34, p35, p36) -- Line: 161
        local _ = p34.Character;
        local _ = p34.Cache;

        for _, descendant in pairs(p34.Meshes.nagirouletteballhit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [6.683] = function(p37, p38, p39) -- Line: 173
        local _ = p37.Character;
        local _ = p37.Cache;

        for _, descendant in pairs(p37.Meshes.nagiroulettevolleyemit25:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end,

    [7.533] = function(p40, p41, p42) -- Line: 185
        local _ = p40.Character;
        local _ = p40.Cache;

        for _, descendant in pairs(p40.Meshes.nagirouletteletgo:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [7.783] = function(p43, p44, p45) -- Line: 197
        local _ = p43.Character;
        local _ = p43.Meshes;
        local _ = p43.Cache;

        for _, v in p45.All do
            if v.Name == "Aura" then
                v.Enabled = false;
            end;
        end;
    end,

    [7.8] = function(p46, p47, p48) -- Line: 207
        local _ = p46.Character;
        local _ = p46.Cache;

        for _, descendant in pairs(p46.Meshes.nagiroulettevolleyemit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [8.35] = function() -- Line: 219
    end
};