  

local u14 = {
    { 0, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotshards2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 86, function() -- Line: 9
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotshards2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotshards3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 165, function() -- Line: 23
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotshards1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotshards3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 176, function() -- Line: 37
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 189, function() -- Line: 53
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 199, function() -- Line: 69
            local v3 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v3 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 212, function() -- Line: 85
            local v4 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v4 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 221, function() -- Line: 101
            local v5 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v5 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 232, function() -- Line: 117
            local v6 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v6 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 241, function() -- Line: 133
            local v7 = nil;

            for _, child in workspace:GetChildren() do
                if child:GetAttribute("CutsceneChar") then
                    v7 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v7:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 264, function() -- Line: 149
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotshards1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 267, function() -- Line: 157
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotemit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 294, function() -- Line: 165
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotemit2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 380, function() -- Line: 173
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotemit3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceareavfx1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 381, function() -- Line: 187
            local TweenService = game:GetService("TweenService");
            local nagispaceshotbeamsend3 = workspace.VFX["Nagi Space Shot VFX"].nagispaceshotbeamsend3;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Parent = nagispaceshotbeamsend3;
            NumberValue.Value = 1;
            local NumberSequence_new_ret = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.85), NumberSequenceKeypoint.new(1, 1) });
            TweenService:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
            task.spawn(function() -- Line: 204
                -- upvalues: nagispaceshotbeamsend3 (copy), NumberSequence_new_ret (copy), TweenService (copy), NumberValue (copy)
                for _, descendant in pairs(nagispaceshotbeamsend3:GetDescendants()) do
                    task.spawn(function() -- Line: 206
                        -- upvalues: descendant (copy), NumberSequence_new_ret (ref), TweenService (ref), NumberValue (ref)
                        if descendant:IsA("Beam") then
                            descendant.Enabled = true;
                            descendant.Transparency = NumberSequence_new_ret;
                            descendant.TextureSpeed = 2.5;
                            TweenService:Create(descendant, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                TextureSpeed = 1
                            }):Play();
                            local u8 = nil;
                            local u9 = NumberValue.Changed:Connect(function() -- Line: 216
                                -- upvalues: descendant (ref), NumberValue (ref)
                                descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.85 + NumberValue.Value * 0.15), NumberSequenceKeypoint.new(1, 1) });
                            end);
                            task.delay(1, function() -- Line: 224
                                -- upvalues: u9 (ref), u8 (ref), NumberValue (ref), descendant (ref)
                                u9:Disconnect();
                                u8 = NumberValue.Changed:Connect(function() -- Line: 226
                                    -- upvalues: descendant (ref), NumberValue (ref)
                                    descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9 + NumberValue.Value * 0.1), NumberSequenceKeypoint.new(1, 1) });
                                end);
                                task.wait(1);
                                descendant.Enabled = false;

                                if u8 then
                                    u8:Disconnect();
                                end;

                                NumberValue:Destroy();
                            end);
                        end;
                    end);
                end;
            end);
            task.delay(1, function() -- Line: 243
                -- upvalues: TweenService (copy), NumberValue (copy)
                TweenService:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Value = 1
                }):Play();
            end);
        end },
    { 384, function() -- Line: 247
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotshards4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 508, function() -- Line: 255
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotshards4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 545, function() -- Line: 263
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotemit5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 572, function() -- Line: 271
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotshards5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 573, function() -- Line: 279
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotemit7:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 283
                        -- upvalues: descendant (copy)
                        descendant:Emit(descendant:GetAttribute("EmitCount"));
                    end);
                end;
            end;
        end },
    { 574, function() -- Line: 289
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotemit4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 575, function() -- Line: 297
            local TweenService = game:GetService("TweenService");
            local nagispaceshotbeamsend2 = workspace.VFX["Nagi Space Shot VFX"].nagispaceshotbeamsend2;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Parent = nagispaceshotbeamsend2;
            NumberValue.Value = 1;
            local NumberSequence_new_ret = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.85), NumberSequenceKeypoint.new(1, 1) });
            TweenService:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
            task.spawn(function() -- Line: 314
                -- upvalues: nagispaceshotbeamsend2 (copy), NumberSequence_new_ret (copy), TweenService (copy), NumberValue (copy)
                for _, descendant in pairs(nagispaceshotbeamsend2:GetDescendants()) do
                    task.spawn(function() -- Line: 316
                        -- upvalues: descendant (copy), NumberSequence_new_ret (ref), TweenService (ref), NumberValue (ref)
                        if descendant:IsA("Beam") then
                            descendant.Enabled = true;
                            descendant.Transparency = NumberSequence_new_ret;
                            descendant.TextureSpeed = 5;
                            TweenService:Create(descendant, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                TextureSpeed = 1
                            }):Play();
                            local u10 = nil;
                            local u11 = NumberValue.Changed:Connect(function() -- Line: 326
                                -- upvalues: descendant (ref), NumberValue (ref)
                                descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.85 + NumberValue.Value * 0.15), NumberSequenceKeypoint.new(1, 1) });
                            end);
                            task.delay(1.84, function() -- Line: 334
                                -- upvalues: u11 (ref), u10 (ref), NumberValue (ref), descendant (ref)
                                u11:Disconnect();
                                u10 = NumberValue.Changed:Connect(function() -- Line: 336
                                    -- upvalues: descendant (ref), NumberValue (ref)
                                    descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9 + NumberValue.Value * 0.1), NumberSequenceKeypoint.new(1, 1) });
                                end);
                                task.wait(1);
                                descendant.Enabled = false;

                                if u10 then
                                    u10:Disconnect();
                                end;

                                NumberValue:Destroy();
                            end);
                        end;
                    end);
                end;
            end);
            task.delay(1.84, function() -- Line: 353
                -- upvalues: TweenService (copy), NumberValue (copy)
                TweenService:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Value = 1
                }):Play();
            end);
        end },
    { 577, function() -- Line: 357
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotenabled1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 635, function() -- Line: 365
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotenabled1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0.15;
                end;
            end;
        end },
    { 663, function() -- Line: 373
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotenabled1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0.05;
                end;
            end;
        end },
    { 681, function() -- Line: 381
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotshards5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 683, function() -- Line: 389
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceareavfx2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 697, function() -- Line: 397
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotemit8:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 401
                        -- upvalues: descendant (copy)
                        descendant:Emit(descendant:GetAttribute("EmitCount"));
                    end);
                end;
            end;
        end },
    { 701, function() -- Line: 407
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotenabled1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0.25;
                end;
            end;
        end },
    { 702, function() -- Line: 415
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotenabled1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 795, function() -- Line: 423
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotenabled1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 820, function() -- Line: 431
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotshards6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 828, function() -- Line: 439
            local TweenService = game:GetService("TweenService");
            local nagispaceshotbeamsend1 = workspace.VFX["Nagi Space Shot VFX"].nagispaceshotbeamsend1;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Parent = nagispaceshotbeamsend1;
            NumberValue.Value = 1;
            local NumberSequence_new_ret = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.85), NumberSequenceKeypoint.new(1, 1) });
            TweenService:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
            task.spawn(function() -- Line: 456
                -- upvalues: nagispaceshotbeamsend1 (copy), NumberSequence_new_ret (copy), TweenService (copy), NumberValue (copy)
                for _, descendant in pairs(nagispaceshotbeamsend1:GetDescendants()) do
                    task.spawn(function() -- Line: 458
                        -- upvalues: descendant (copy), NumberSequence_new_ret (ref), TweenService (ref), NumberValue (ref)
                        if descendant:IsA("Beam") then
                            descendant.Enabled = true;
                            descendant.Transparency = NumberSequence_new_ret;
                            descendant.TextureSpeed = 10;
                            TweenService:Create(descendant, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                TextureSpeed = 0.01
                            }):Play();
                            local u12 = nil;
                            local u13 = NumberValue.Changed:Connect(function() -- Line: 468
                                -- upvalues: descendant (ref), NumberValue (ref)
                                descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.85 + NumberValue.Value * 0.15), NumberSequenceKeypoint.new(1, 1) });
                            end);
                            task.delay(0.6, function() -- Line: 476
                                -- upvalues: u13 (ref), u12 (ref), NumberValue (ref), descendant (ref)
                                u13:Disconnect();
                                u12 = NumberValue.Changed:Connect(function() -- Line: 478
                                    -- upvalues: descendant (ref), NumberValue (ref)
                                    descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.9 + NumberValue.Value * 0.1), NumberSequenceKeypoint.new(1, 1) });
                                end);
                                task.wait(1);
                                descendant.Enabled = false;

                                if u12 then
                                    u12:Disconnect();
                                end;

                                NumberValue:Destroy();
                            end);
                        end;
                    end);
                end;
            end);
            task.delay(0.6, function() -- Line: 495
                -- upvalues: TweenService (copy), NumberValue (copy)
                TweenService:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Value = 1
                }):Play();
            end);
        end },
    { 831, function() -- Line: 499
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotemit6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 832, function() -- Line: 507
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceareavfx3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 890, function() -- Line: 515
            for _, descendant in pairs(workspace.VFX["Nagi Space Shot VFX"].nagispaceshotshards6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u15) -- Line: 524
    -- upvalues: u14 (copy)
    task.spawn(function() -- Line: 525
        -- upvalues: u15 (copy), u14 (ref)
        local v16 = 0;

        while u15:IsPlaying() do
            local CurrentFrame = u15.CurrentFrame;

            for _, v in u14 do
                local v17 = v[1];
                local v18 = v[2];

                if v17 <= CurrentFrame and v16 < v17 then
                    task.spawn(v18);
                end;
            end;

            task.wait();
            v16 = CurrentFrame;
        end;
    end);
end;