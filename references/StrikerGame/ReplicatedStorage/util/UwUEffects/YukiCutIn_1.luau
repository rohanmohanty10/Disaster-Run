 
 

game:GetService("Lighting");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");
local script_mesh_emit = require(script.mesh_emit);
local script_beam_emit = require(script.beam_emit);

return {
    [0.16] = function(p1, p2, p3) -- Line: 9
        -- upvalues: script_mesh_emit (copy)
        local _ = p1.Direction;
        local _ = p1.Meshes;
        local _ = p1.Cache;
        local HumanoidRootPart = p1.Character.HumanoidRootPart;

        for _, descendant in pairs(p2.HumanoidRootPart.f10:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        local v4 = script.Fake.Mesh.ImpactShockwave:Clone();
        script_mesh_emit.new(v4):Emit(HumanoidRootPart.CFrame * CFrame.new(v4:GetAttribute("Offset")));
        local v5 = script.Fake.Mesh.RingMesh:Clone();
        script_mesh_emit.new(v5):Emit(HumanoidRootPart.CFrame * CFrame.new(v5:GetAttribute("Offset")));
    end,

    [0.5] = function(p6, p7, p8) -- Line: 28
        -- upvalues: script_beam_emit (copy), script_mesh_emit (copy)
        local _ = p6.Meshes;
        local _ = p6.Cache;
        local HumanoidRootPart = p7.HumanoidRootPart;
        local HumanoidRootPart2 = p6.Character.HumanoidRootPart;
        local RunBeams = script.SideDash.Mesh.RunBeams;
        RunBeams.CFrame = HumanoidRootPart2.CFrame * CFrame.new(0, -0.5, -0) * CFrame.Angles(0, 0.6108652381980153, 0);

        for _, descendant in pairs(HumanoidRootPart.f30:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(HumanoidRootPart.f30Enabled:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant.Enabled = true;
            end;
        end;

        script_beam_emit(RunBeams, {
            RotationSpeed = 2,
            Rotation = true,
            Duration = 0.7,
            Easing = "Sine",
            EasingDirection = "Out",
            Properties = {
                Brightness = 0,
                LightEmission = 1,
                TextureSpeed = 0.5,
                Width0 = 2,
                Width1 = 8
            },
            Offset = CFrame.new(0, 0, -4)
        });
        local v9 = script.SideDash.Mesh.ImpactShockwave:Clone();
        script_mesh_emit.new(v9):Emit(HumanoidRootPart2.CFrame * CFrame.new(v9:GetAttribute("Offset")));
        local v10 = script.SideDash.Mesh.WindDecal1:Clone();
        script_mesh_emit.new(v10):Emit(HumanoidRootPart2.CFrame * CFrame.new(v10:GetAttribute("Offset")));
        local v11 = script.SideDash.Mesh.WindDecal2:Clone();
        script_mesh_emit.new(v11):Emit(HumanoidRootPart2.CFrame * CFrame.new(v11:GetAttribute("Offset")));
        local v12 = script.SideDash.Mesh.WindStraight:Clone();
        script_mesh_emit.new(v12):Emit(HumanoidRootPart2.CFrame * CFrame.new(v12:GetAttribute("Offset")));
        local v13 = script.SideDash.Mesh.SwirlMesh:Clone();
        script_mesh_emit.new(v13):Emit(HumanoidRootPart2.CFrame * CFrame.new(v13:GetAttribute("Offset")));
    end,

    [1.23] = function(p14, p15, p16) -- Line: 79
        local _ = p14.Meshes;
        local _ = p14.Cache;
        local _ = p14.Character.HumanoidRootPart;

        for _, descendant in pairs(p15.HumanoidRootPart.f30Enabled:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant.Enabled = false;
            end;
        end;
    end,

    [5] = function() -- Line: 90
    end
};