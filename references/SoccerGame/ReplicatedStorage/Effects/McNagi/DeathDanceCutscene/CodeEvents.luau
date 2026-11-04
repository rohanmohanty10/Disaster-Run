  

local u6 = {
    { 0, function() -- Line: 1
            for _, descendant in pairs(workspace:FindFirstChild("VFX").Cam:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            local Cam = workspace:FindFirstChild("VFX").Cam;

            for _, descendant in pairs(Cam:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 31, function() -- Line: 14
            local nagidanceemit9 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidanceemit9;

            for _, descendant in pairs(nagidanceemit9:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 50, function() -- Line: 22
            local nagidanceemit7 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidanceemit7;

            for _, descendant in pairs(nagidanceemit7:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 67, function() -- Line: 30
            local nagidanceemit8 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidanceemit8;

            for _, descendant in pairs(nagidanceemit8:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 117, function() -- Line: 38
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 118, function() -- Line: 55
            local TweenService = game:GetService("TweenService");
            local nagidancebeamsend1 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidancebeamsend1;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Parent = nagidancebeamsend1;
            NumberValue.Value = 1;
            local NumberSequence_new_ret = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.85), NumberSequenceKeypoint.new(1, 1) });
            TweenService:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
            task.spawn(function() -- Line: 72
                -- upvalues: nagidancebeamsend1 (copy), NumberSequence_new_ret (copy), TweenService (copy), NumberValue (copy)
                for _, descendant in pairs(nagidancebeamsend1:GetDescendants()) do
                    task.spawn(function() -- Line: 74
                        -- upvalues: descendant (copy), NumberSequence_new_ret (ref), TweenService (ref), NumberValue (ref)
                        if descendant:IsA("Beam") then
                            descendant.Enabled = true;
                            descendant.Transparency = NumberSequence_new_ret;
                            descendant.TextureSpeed = 10;
                            TweenService:Create(descendant, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                TextureSpeed = 0.01
                            }):Play();
                            local u2 = nil;
                            local u3 = NumberValue.Changed:Connect(function() -- Line: 84
                                -- upvalues: descendant (ref), NumberValue (ref)
                                descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.85 + NumberValue.Value * 0.15), NumberSequenceKeypoint.new(1, 1) });
                            end);
                            task.delay(1, function() -- Line: 92
                                -- upvalues: u3 (ref), u2 (ref), NumberValue (ref), descendant (ref)
                                u3:Disconnect();
                                u2 = NumberValue.Changed:Connect(function() -- Line: 94
                                    -- upvalues: descendant (ref), NumberValue (ref)
                                    descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9 + NumberValue.Value * 0.1), NumberSequenceKeypoint.new(1, 1) });
                                end);
                                task.wait(1);
                                descendant.Enabled = false;

                                if u2 then
                                    u2:Disconnect();
                                end;

                                NumberValue:Destroy();
                            end);
                        end;
                    end);
                end;
            end);
            task.delay(1, function() -- Line: 111
                -- upvalues: TweenService (copy), NumberValue (copy)
                TweenService:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Value = 1
                }):Play();
            end);
        end },
    { 119, function() -- Line: 115
            local nagidanceemit1 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidanceemit1;

            for _, descendant in pairs(nagidanceemit1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 196, function() -- Line: 123
            local nagidanceemit6 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidanceemit6;

            for _, descendant in pairs(nagidanceemit6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 200, function() -- Line: 131
            local nagidanceemit5 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidanceemit5;

            for _, descendant in pairs(nagidanceemit5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 222, function() -- Line: 139
            local nagidanceemit12 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidanceemit12;

            for _, descendant in pairs(nagidanceemit12:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 305, function() -- Line: 147
            local nagidanceemit12 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidanceemit12;

            for _, descendant in pairs(nagidanceemit12:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 431, function() -- Line: 155
            local nagidanceemit2 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidanceemit2;

            for _, descendant in pairs(nagidanceemit2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 524, function() -- Line: 163
            local nagidanceemit3 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidanceemit3;

            for _, descendant in pairs(nagidanceemit3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 631, function() -- Line: 171
            local nagidanceenabled2 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidanceenabled2;

            for _, descendant in pairs(nagidanceenabled2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 635, function() -- Line: 179
            local nagidanceemit10 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidanceemit10;

            for _, descendant in pairs(nagidanceemit10:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 659, function() -- Line: 187
            local nagidanceemit11 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidanceemit11;

            for _, descendant in pairs(nagidanceemit11:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 661, function() -- Line: 195
            local TweenService = game:GetService("TweenService");
            local nagidancebeamsend2 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidancebeamsend2;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Parent = nagidancebeamsend2;
            NumberValue.Value = 1;
            local NumberSequence_new_ret = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.85), NumberSequenceKeypoint.new(1, 1) });
            TweenService:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
            task.spawn(function() -- Line: 212
                -- upvalues: nagidancebeamsend2 (copy), NumberSequence_new_ret (copy), TweenService (copy), NumberValue (copy)
                for _, descendant in pairs(nagidancebeamsend2:GetDescendants()) do
                    task.spawn(function() -- Line: 214
                        -- upvalues: descendant (copy), NumberSequence_new_ret (ref), TweenService (ref), NumberValue (ref)
                        if descendant:IsA("Beam") then
                            descendant.Enabled = true;
                            descendant.Transparency = NumberSequence_new_ret;
                            descendant.TextureSpeed = 10;
                            TweenService:Create(descendant, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                TextureSpeed = 0.01
                            }):Play();
                            local u4 = nil;
                            local u5 = NumberValue.Changed:Connect(function() -- Line: 224
                                -- upvalues: descendant (ref), NumberValue (ref)
                                descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.85 + NumberValue.Value * 0.15), NumberSequenceKeypoint.new(1, 1) });
                            end);
                            task.delay(1.5, function() -- Line: 232
                                -- upvalues: u5 (ref), u4 (ref), NumberValue (ref), descendant (ref)
                                u5:Disconnect();
                                u4 = NumberValue.Changed:Connect(function() -- Line: 234
                                    -- upvalues: descendant (ref), NumberValue (ref)
                                    descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9 + NumberValue.Value * 0.1), NumberSequenceKeypoint.new(1, 1) });
                                end);
                                task.wait(1);
                                descendant.Enabled = false;

                                if u4 then
                                    u4:Disconnect();
                                end;

                                NumberValue:Destroy();
                            end);
                        end;
                    end);
                end;
            end);
            task.delay(1.5, function() -- Line: 251
                -- upvalues: TweenService (copy), NumberValue (copy)
                TweenService:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Value = 1
                }):Play();
            end);
        end },
    { 724, function() -- Line: 255
            local nagidanceenabled2 = workspace:FindFirstChild("VFX")["Nagi Death Dance VFX"].nagidanceenabled2;

            for _, descendant in pairs(nagidanceenabled2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace:FindFirstChild("VFX").Cam:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;

            local Cam = workspace:FindFirstChild("VFX").Cam;

            for _, descendant in pairs(Cam:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    return;
                end;
            end;
        end }
};

return function(u7) -- Line: 289
    -- upvalues: u6 (copy)
    task.spawn(function() -- Line: 290
        -- upvalues: u7 (copy), u6 (ref)
        local v8 = 0;

        while u7:IsPlaying() do
            local CurrentFrame = u7.CurrentFrame;

            for _, v in u6 do
                local v9 = v[1];
                local v10 = v[2];

                if v9 <= CurrentFrame and v8 < v9 then
                    task.spawn(v10);
                end;
            end;

            task.wait();
            v8 = CurrentFrame;
        end;
    end);
end;