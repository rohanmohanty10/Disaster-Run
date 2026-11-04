 
 

require(game.ReplicatedStorage.util.Util);

return {
    [0] = function(p1, p2, p3) -- Line: 4
        local _ = p1.Meshes;
        local HumanoidRootPart = p1.Character.HumanoidRootPart;

        for _, v in p3.All do
            if v:IsA("Beam") or v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;

        for _, descendant in HumanoidRootPart.Cam:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [7] = function(p4, p5, p6) -- Line: 23
        local _ = p4.Meshes;

        for _, descendant in p4.Character.HumanoidRootPart.Cam:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [10.533] = function(p7, p8, p9) -- Line: 35
        local _ = p7.Character;

        for _, descendant in p7.Meshes.chigiriawksparkemit:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [11.08] = function(p10, p11, p12) -- Line: 46
        local _ = p10.Meshes;
        local HumanoidRootPart = p10.Character.HumanoidRootPart;

        for _, v in p12.All do
            if v:IsA("Beam") then
                v.Enabled = true;
            elseif v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;

        for _, descendant in pairs(HumanoidRootPart.Cam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [11.2] = function(p13, p14, p15) -- Line: 66
        local _ = p13.Meshes;

        for _, descendant in pairs(p13.Character.HumanoidRootPart.Cam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, v in p15["Right Leg"] do
            if v:IsA("Beam") then
                v.Enabled = false;
            end;
        end;
    end,

    [11.25] = function(p16, p17, p18) -- Line: 83
        local _ = p16.Character;

        for _, descendant in pairs(p16.Meshes.chigiriawkemit1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [12.167] = function(p19, p20, p21) -- Line: 93
        local _ = p19.Character;

        for _, descendant in pairs(p19.Meshes.chigiriawkemit2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [12.2] = function(p22, p23, p24) -- Line: 104
        local _ = p22.Character;

        for _, descendant in pairs(p22.Meshes.chigiriwindbeams1:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [12.583] = function(p25, p26, p27) -- Line: 114
        local _ = p25.Character;

        for _, descendant in pairs(p25.Meshes.chigiriawkemit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [12.967] = function(p28, p29, p30) -- Line: 124
        local _ = p28.Character;

        for _, descendant in pairs(p28.Meshes.chigiriawkemit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.75;
            end;
        end;
    end,

    [13.833] = function(p31, p32, p33) -- Line: 134
        local _ = p31.Character;

        for _, descendant in pairs(p31.Meshes.chigiriwindbeams1:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [13.95] = function(p34, p35, p36) -- Line: 144
        local _ = p34.Meshes;

        for _, descendant in pairs(p34.Character.HumanoidRootPart.Cam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [13.967] = function(p37, p38, p39) -- Line: 156
        local _ = p37.Character;
        local Meshes = p37.Meshes;

        for _, descendant in pairs(Meshes.chigiriwindbeams1:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Meshes.chigiriwindbeams2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(Meshes.chigiriwindbeams3:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [14] = function(p40, p41, p42) -- Line: 177
        local _ = p40.Character;

        for _, descendant in pairs(p40.Meshes.chigiriawkemit4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [14.067] = function(p43, p44, p45) -- Line: 187
        local _ = p43.Character;

        for _, descendant in pairs(p43.Meshes.chigiriawkemit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end,

    [14.233] = function(p46, p47, p48) -- Line: 197
        local _ = p46.Character;

        for _, descendant in pairs(p46.Meshes.chigiriawkemit4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.45;
            end;
        end;
    end,

    [15.817] = function(p49, p50, p51) -- Line: 208
        local _ = p49.Character;

        for _, descendant in pairs(p49.Meshes.chigiriawkemit4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end,

    [17.3] = function(p52, p53, p54) -- Line: 218
        local _ = p52.Character;
        local Meshes = p52.Meshes;

        for _, descendant in pairs(Meshes.chigiriwindbeams2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(Meshes.chigiriwindbeams3:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [17.31] = function(p55, p56, p57) -- Line: 233
        local _ = p55.Meshes;

        for _, descendant in pairs(p55.Character.HumanoidRootPart.Cam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, v in p57.All do
            if v:IsA("Beam") then
                v.Enabled = false;
            end;
        end;
    end
};