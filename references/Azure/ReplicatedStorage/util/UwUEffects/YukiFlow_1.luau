 
 

game:GetService("Lighting");
game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MeshEmit = require(ReplicatedStorage.MeshEmit);

return {
    [0] = function(p1, p2, p3) -- Line: 8
        local Meshes = p1.Meshes;
        local _ = p1.Cache;
        local HumanoidRootPart = p1.Character.HumanoidRootPart;

        for _, descendant in Meshes.yukicameralighting:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in HumanoidRootPart.blenderCam:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in Meshes.yukicameralighting:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.2] = function(p4, p5, p6) -- Line: 33
        local _ = p4.Character;
        local _ = p4.Cache;

        for _, descendant in ipairs(p4.Meshes.part2.effects.dash1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [0.417] = function(p7, p8, p9) -- Line: 49
        local _ = p7.Character;
        local _ = p7.Cache;

        for _, descendant in p7.Meshes.part2.effects.dash2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [2.033] = function(p10, p11, p12) -- Line: 65
        -- upvalues: MeshEmit (copy)
        local _ = p10.Character;
        local _ = p10.Cache;
        local effects = p10.Meshes.part2.effects;

        for _, descendant in effects.jump:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in effects.meshes.jump:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, true);
            end;
        end;
    end,

    [2.2] = function(p13, p14, p15) -- Line: 90
        local _ = p13.Cache;
        local _ = p13.Meshes.part2.effects;

        for _, descendant in p13.Character.yes:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [2.533] = function(p16, p17, p18) -- Line: 106
        local _ = p16.Character;
        local _ = p16.Cache;

        for _, descendant in p16.Meshes.part2.effects.blink:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [3.117] = function(p19, p20, p21) -- Line: 122
        -- upvalues: ReplicatedStorage (copy)
        local Character = p19.Character;
        local Meshes = p19.Meshes;
        local Cache = p19.Cache;
        local u22 = ReplicatedStorage.Resources.yukimiya.ballslide:Clone();
        Cache.BallSlide = u22;
        u22.CFrame = Character.Ball.CFrame;
        u22.Weld.Part0 = Character.Ball;
        u22.Parent = workspace.Effects;
        task.delay(1.216, function() -- Line: 138
            -- upvalues: u22 (copy)
            for _, descendant in ipairs(u22:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end);
        local _ = Meshes.part2.effects;

        for _, descendant in ipairs(u22:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in Character.yes:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [4.1] = function(p23, p24, p25) -- Line: 165
        local _ = p23.Character;
        local _ = p23.Meshes;
        local BallSlide = p23.Cache.BallSlide;

        if BallSlide then
            for _, descendant in BallSlide:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end;
    end,

    [4.333] = function(p26, p27, p28) -- Line: 179
        local _ = p26.Character;
        local Meshes = p26.Meshes;
        local _ = p26.Cache;

        for _, descendant in Meshes.yukipaintsplatter:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in Meshes.part2.effects:WaitForChild("transition"):GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [6.65] = function(p29, p30, p31) -- Line: 202
        local _ = p29.Character;
        local _ = p29.Cache;

        for _, descendant in pairs(p29.Meshes.yukipaintsplatter:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [9.817] = function(p32, p33, p34) -- Line: 214
        local Meshes = p32.Meshes;
        local _ = p32.Cache;
        local HumanoidRootPart = p32.Character.HumanoidRootPart;

        for _, descendant in Meshes.yukicameralighting:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in HumanoidRootPart.blenderCam:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in Meshes.yukicameralighting:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end
};