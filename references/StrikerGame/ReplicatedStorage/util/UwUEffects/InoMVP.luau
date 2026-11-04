 

 

game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0.733] = function(p1, p2, p3) -- Line: 6
        -- upvalues: TweenService (copy)
        local _ = p1.Meshes;
        local _ = p1.Cache;

        for _, descendant in ipairs(p1.Character.HumanoidRootPart.blenderCam:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Brightness = 0;
                descendant.TextureSpeed = 1;
                local u4 = TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Brightness = 1,
                    TextureSpeed = 3
                });
                u4:Play();
                task.spawn(function() -- Line: 19
                    -- upvalues: u4 (copy)
                    u4.Completed:Wait();
                    u4:Destroy();
                end);
            end;
        end;
    end,

    [1.4] = function(p5, p6, p7) -- Line: 26
        -- upvalues: TweenService (copy)
        local _ = p5.Meshes;
        local _ = p5.Cache;

        for _, descendant in ipairs(p5.Character.HumanoidRootPart.blenderCam:GetDescendants()) do
            if descendant:IsA("Beam") then
                local u8 = TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Brightness = 0
                });
                u8:Play();
                task.spawn(function() -- Line: 38
                    -- upvalues: u8 (copy)
                    u8.Completed:Wait();
                    u8:Destroy();
                end);
            end;
        end;
    end,

    [2.15] = function(p9, p10, p11) -- Line: 45
        -- upvalues: TweenService (copy)
        local _ = p9.Cache;
        local _ = p9.Character.HumanoidRootPart;
        local effects = p9.Meshes.effects;

        for _, descendant in ipairs(effects.soundwave:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        for i = 1, 2 do
            task.wait(0.1);
            local u12 = script.distortion:Clone();
            u12.Parent = workspace.Camera;
            u12.CFrame = effects.soundwave.CFrame;
            local u13 = TweenService:Create(u12, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Size = Vector3.new(5, 5, 5),
                Transparency = 1
            });
            u13:Play();
            task.spawn(function() -- Line: 67
                -- upvalues: u13 (copy), u12 (copy)
                u13.Completed:Wait();
                u13:Destroy();
                u12:Destroy();
            end);
            local _ = i;
        end;
    end,

    [2.383] = function(p14, p15, p16) -- Line: 74
        local _ = p14.Cache;
        local _ = p14.Character.HumanoidRootPart;

        for _, descendant in ipairs(p14.Meshes.effects.soundwave_end:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [5.2] = function(p17, p18, p19) -- Line: 90
        local _ = p17.Cache;
        local _ = p17.Character.HumanoidRootPart;

        for _, descendant in ipairs(p17.Meshes.effects.blink:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [7] = function() -- Line: 106
    end
};