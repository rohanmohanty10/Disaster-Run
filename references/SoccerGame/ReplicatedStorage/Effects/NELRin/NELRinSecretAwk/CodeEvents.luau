  

local VfxManager = require(game.ReplicatedStorage.VfxManager);
local u5 = {
    { 341, function() -- Line: 3
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.NO);
        end },
    { 415, function() -- Line: 7
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CutsceneVFX.Zone);
        end },
    { 563, function() -- Line: 11
            (function(p1) -- Line: 12, Name: Emit
                for _, descendant in ipairs(p1:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                        local u2 = descendant:GetAttribute("EmitDelay") or 0;
                        local u3 = descendant:GetAttribute("EmitCount") or 1;
                        local u4 = descendant:GetAttribute("EmitDuration") or 0;
                        task.spawn(function() -- Line: 18
                            -- upvalues: u2 (copy), descendant (copy), u3 (copy), u4 (copy)
                            task.wait(u2);

                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(u3);
                            end;

                            if u4 > 0 then
                                descendant.Enabled = true;
                                task.wait(u4);
                                descendant.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end)(workspace.VFX.CutsceneVFX.Trap);
        end },
    { 593, function() -- Line: 36
            local TweenService = game:GetService("TweenService");
            (function() -- Line: 40, Name: TweenHighlights
                -- upvalues: TweenService (copy)
                for _, child in ipairs(workspace.VFX:GetChildren()) do
                    if child:IsA("Model") and child:FindFirstChild("Highlight") then
                        local Highlight = child.Highlight;
                        Highlight.FillTransparency = 0;
                        Highlight.OutlineTransparency = 0;
                        TweenService:Create(Highlight, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            FillTransparency = 1,
                            OutlineTransparency = 1
                        }):Play();
                    end;
                end;
            end)();
        end },
    { 779, function() -- Line: 72
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.CamVFX.RightLines);
        end },
    { 781, function() -- Line: 76
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.Trail);
        end },
    { 782, function() -- Line: 80
            -- upvalues: VfxManager (copy)
            VfxManager.Emit(workspace.VFX.mOVING);
        end }
};

return function(u6) -- Line: 85
    -- upvalues: u5 (copy)
    task.spawn(function() -- Line: 86
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