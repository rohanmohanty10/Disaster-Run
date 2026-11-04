 

 

game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0.167] = function(p1, p2, p3) -- Line: 6
        local _ = p1.Cache;
        local _ = p1.Character.HumanoidRootPart;

        for _, descendant in pairs(p1.Meshes.nagimvpemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [2.5] = function(p4, p5, p6) -- Line: 20
        local _ = p4.Cache;
        local _ = p4.Character.HumanoidRootPart;

        for _, descendant in pairs(p4.Meshes.nagimvpsweat:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [2.583] = function(p7, p8, p9) -- Line: 34
        local Meshes = p7.Meshes;
        local _ = p7.Cache;

        for _, descendant in p7.Character.HumanoidRootPart.Cam:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, v in p9.All do
            if v:IsA("ParticleEmitter") or v:IsA("Beam") then
                v.Enabled = true;
            end;
        end;

        for _, descendant in Meshes.nagimvpspeedlines:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [2.6] = function(p10, p11, p12) -- Line: 60
        -- upvalues: TweenService (copy)
        local _ = p10.Cache;
        local _ = p10.Character.HumanoidRootPart;
        local windbachira = p10.Meshes.windbachira;
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Parent = windbachira;
        NumberValue.Value = 1;
        local NumberSequence_new_ret = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.8), NumberSequenceKeypoint.new(1, 1) });
        TweenService:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Value = 0.8
        }):Play();

        for _, descendant in windbachira:GetDescendants() do
            task.defer(function() -- Line: 83
                -- upvalues: descendant (copy), NumberSequence_new_ret (copy), TweenService (ref), NumberValue (copy)
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                    descendant.Transparency = NumberSequence_new_ret;
                    descendant.TextureSpeed = 7;
                    TweenService:Create(descendant, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        TextureSpeed = 0.43
                    }):Play();
                    NumberValue.Changed:Connect(function() -- Line: 91
                        -- upvalues: descendant (ref), NumberValue (ref)
                        descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                    end);
                    task.delay(3, function() -- Line: 98
                        -- upvalues: NumberValue (ref), descendant (ref)
                        NumberValue.Changed:Connect(function() -- Line: 99
                            -- upvalues: descendant (ref), NumberValue (ref)
                            descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                        end);
                        task.wait(1);
                        descendant.Enabled = false;
                        NumberValue:Destroy();
                    end);
                end;
            end);
        end;

        task.delay(3, function() -- Line: 113
            -- upvalues: TweenService (ref), NumberValue (copy)
            TweenService:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = 1
            }):Play();
        end);
    end,

    [2.65] = function(p13, p14, p15) -- Line: 117
        local _ = p13.Cache;
        local _ = p13.Character.HumanoidRootPart;

        for _, descendant in p13.Meshes.nagimvpemit2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end,

    [2.667] = function(p16, p17, p18) -- Line: 131
        local _ = p16.Cache;
        local _ = p16.Character.HumanoidRootPart;

        for _, descendant in pairs(p16.Meshes.nagimvpemit2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.25;
            end;
        end;
    end,

    [7] = function() -- Line: 145
    end
};