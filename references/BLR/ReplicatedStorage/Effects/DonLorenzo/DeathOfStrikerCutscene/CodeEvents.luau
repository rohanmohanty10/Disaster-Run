  

local VfxManager = require(game.ReplicatedStorage.VfxManager);
local u5 = {
    { 1, function() -- Line: 3
            for _, descendant in ipairs(workspace.VFX.VFX.Steps.Step1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 14, function() -- Line: 10
            for _, descendant in ipairs(workspace.VFX.VFX.Steps.Step2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 28, function() -- Line: 17
            for _, descendant in ipairs(workspace.VFX.VFX.Steps.Step3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 41, function() -- Line: 24
            for _, descendant in ipairs(workspace.VFX.VFX.Steps.Step4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 155, function() -- Line: 31
            for _, descendant in ipairs(workspace.VFX.VFX.trails:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = true;
                    task.delay(2.7, function() -- Line: 35
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 307, function() -- Line: 39
            local Looper = require(script.Parent.Looper);
            local afterimageOLDD = require(script.Parent.afterimageOLDD);
            task.spawn(function() -- Line: 43
                -- upvalues: Looper (copy), afterimageOLDD (copy)
                Looper.LoopForTime(0.2, function() -- Line: 44
                    -- upvalues: afterimageOLDD (ref)
                    task.spawn(function() -- Line: 46
                        -- upvalues: afterimageOLDD (ref)
                        local v1 = nil;

                        for _, child in workspace:GetChildren() do
                            if child:GetAttribute("CutsceneChar") then
                                v1 = child;
                                break;
                            end;
                        end;

                        afterimageOLDD.new(v1, 0.1, 0.2, Color3.new(0.627451, 0.172549, 1), 0.4);
                    end);
                end);
            end);
        end },
    { 433, function() -- Line: 61
            local TweenService = game:GetService("TweenService");
            local v2 = workspace.VFX.VFX.Beams:Clone();
            v2.Parent = workspace.Camera;

            for _, descendant in pairs(v2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                    local NumberValue = Instance.new("NumberValue");
                    NumberValue.Parent = workspace.Camera;
                    NumberValue.Changed:Connect(function(p3) -- Line: 73
                        -- upvalues: descendant (copy)
                        descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1, p3), NumberSequenceKeypoint.new(1, 1) });
                    end);
                    local v4 = TweenService:Create(NumberValue, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Value = 1
                    });
                    v4:Play();
                    v4.Completed:Connect(function() -- Line: 86
                        -- upvalues: NumberValue (copy), descendant (copy)
                        NumberValue:Destroy();
                        descendant.Enabled = false;
                    end);
                end;
            end;

            task.wait(2);
            v2:Destroy();
        end },
    { 495, function() -- Line: 95
            for _, descendant in ipairs(workspace.VFX.VFX.EndImpact:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(0.7, function() -- Line: 99
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;

            for _, descendant in pairs(workspace.VFX.VFX.CamFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                    descendant:Clear();
                end;
            end;

            for _, descendant in pairs(workspace.VFX.VFX.CamFX:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 611, function() -- Line: 115
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX.Kick);
        end },
    { 613, function() -- Line: 118
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX["Death of a striker"].BALL);
        end },
    { 646, function() -- Line: 121
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX["2"]);
        end }
};

return function(u6) -- Line: 125
    -- upvalues: u5 (copy)
    task.spawn(function() -- Line: 126
        -- upvalues: u6 (copy), u5 (ref)
        local v7 = 0;

        while u6:IsPlaying() do
            local CurrentFrame = u6.CurrentFrame;

            for _, v in u5 do
                local v8 = v[1];
                local v9 = v[2];

                if v8 <= CurrentFrame and v7 < v8 then
                    task.spawn(v9);
                end;
            end;

            task.wait();
            v7 = CurrentFrame;
        end;
    end);
end;