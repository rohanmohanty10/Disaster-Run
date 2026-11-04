  

local u1 = {
    { 432, function() -- Line: 1
        end },
    { 495, function() -- Line: 3
        end },
    { 118, function() -- Line: 5
        end },
    { 122, function() -- Line: 7
        end },
    { 222, function() -- Line: 9
        end },
    { 118, function() -- Line: 11
            local TweenService = game:GetService("TweenService");
            local FXPart = workspace.VFX.FXPart;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Parent = FXPart;
            NumberValue.Value = 1;
            local NumberSequence_new_ret = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) });
            TweenService:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
            task.spawn(function() -- Line: 28
                -- upvalues: FXPart (copy), NumberSequence_new_ret (copy), TweenService (copy), NumberValue (copy)
                for _, descendant in pairs(FXPart:GetDescendants()) do
                    task.spawn(function() -- Line: 30
                        -- upvalues: descendant (copy), NumberSequence_new_ret (ref), TweenService (ref), NumberValue (ref)
                        if descendant:IsA("Beam") then
                            descendant.Enabled = true;
                            descendant.Transparency = NumberSequence_new_ret;
                            descendant.TextureSpeed = 6;
                            TweenService:Create(descendant, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                TextureSpeed = 0.01
                            }):Play();
                            NumberValue.Changed:Connect(function() -- Line: 38
                                -- upvalues: descendant (ref), NumberValue (ref)
                                task.spawn(function() -- Line: 39
                                    -- upvalues: descendant (ref), NumberValue (ref)
                                    descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                                end);
                            end);
                            task.delay(0.7, function() -- Line: 47
                                -- upvalues: NumberValue (ref), descendant (ref)
                                NumberValue.Changed:Connect(function() -- Line: 48
                                    -- upvalues: descendant (ref), NumberValue (ref)
                                    task.spawn(function() -- Line: 49
                                        -- upvalues: descendant (ref), NumberValue (ref)
                                        descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                                    end);
                                end);
                                task.wait(1);
                                descendant.Enabled = false;
                                NumberValue:Destroy();
                            end);
                        end;
                    end);
                end;
            end);
            task.delay(0.7, function() -- Line: 65
                -- upvalues: TweenService (copy), NumberValue (copy)
                TweenService:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Value = 1
                }):Play();
            end);
        end },
    { 118, function() -- Line: 69
            for _, descendant in pairs(workspace.VFX.VFX.BReath:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 118, function() -- Line: 77
            for _, descendant in pairs(workspace.VFX.VFX.ShineEmit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 432, function() -- Line: 85
            for _, descendant in pairs(workspace.VFX.VFX.Aura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 495, function() -- Line: 93
            for _, descendant in pairs(workspace.VFX.VFX.Aura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 795, function() -- Line: 101
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1023, function() -- Line: 109
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1121, function() -- Line: 117
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1140, function() -- Line: 125
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1154, function() -- Line: 133
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1167, function() -- Line: 141
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1177, function() -- Line: 149
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1183, function() -- Line: 157
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1191, function() -- Line: 165
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1198, function() -- Line: 173
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1205, function() -- Line: 181
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1212, function() -- Line: 189
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1219, function() -- Line: 197
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1226, function() -- Line: 205
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1233, function() -- Line: 213
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1240, function() -- Line: 221
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1247, function() -- Line: 229
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1254, function() -- Line: 237
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1261, function() -- Line: 245
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1268, function() -- Line: 253
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1275, function() -- Line: 261
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1282, function() -- Line: 269
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1289, function() -- Line: 277
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1296, function() -- Line: 285
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1303, function() -- Line: 293
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1310, function() -- Line: 301
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1317, function() -- Line: 309
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1324, function() -- Line: 317
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1331, function() -- Line: 325
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1338, function() -- Line: 333
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1344, function() -- Line: 341
            for _, descendant in pairs(workspace.VFX.ipad.VFXPart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1428, function() -- Line: 349
            for _, descendant in pairs(workspace.VFX.CashEmitLast:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1060, function() -- Line: 357
            for _, descendant in pairs(workspace.VFX.oneEmit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 1431, function() -- Line: 365
            for _, descendant in pairs(workspace.VFX.CashEmitEnable:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 1640, function() -- Line: 373
            for _, descendant in pairs(workspace.VFX.CashEmitEnable:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 382
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 383
        -- upvalues: u2 (copy), u1 (ref)
        local v3 = 0;

        while u2:IsPlaying() do
            local CurrentFrame = u2.CurrentFrame;

            for _, v in u1 do
                local v4 = v[1];
                local v5 = v[2];

                if v4 <= CurrentFrame and v3 < v4 then
                    task.spawn(v5);
                end;
            end;

            task.wait();
            v3 = CurrentFrame;
        end;
    end);
end;