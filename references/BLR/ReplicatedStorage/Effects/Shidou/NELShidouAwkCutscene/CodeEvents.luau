  

local u5 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX["Shidou Awakening VFX"].ConstantCameraIs2, workspace.VFX["Shidou Awakening VFX"].ConstantCameraIs, workspace.VFX["Shidou Awakening VFX"].AwkConstantCameraIs2, workspace.VFX["Shidou Awakening VFX"].AwkConstantCameraIs);
        end },
    { 13, function() -- Line: 4
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v1.Torso, workspace.VFX["Shidou Awakening VFX"].Shot1);
        end },
    { 14, function() -- Line: 14
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v2.Torso.FX.Beams:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 270, function() -- Line: 28
            local v3 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v3 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v3.Torso.FX.Beams:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 271, function() -- Line: 42
            shared.vfx.emit(workspace.VFX["Shidou Awakening VFX"].enablepassive1);
        end },
    { 272, function() -- Line: 45
            shared.vfx.emit(workspace.VFX["Shidou Awakening VFX"].shidoubgsmall);
        end },
    { 273, function() -- Line: 48
            shared.vfx.emit(workspace.VFX["Shidou Awakening VFX"].enable11);
        end },
    { 275, function() -- Line: 51
            shared.vfx.emit(workspace.VFX["Shidou Awakening VFX"].you);
        end },
    { 330, function() -- Line: 54
            shared.vfx.emit(workspace.VFX["Shidou Awakening VFX"].Shot3);
        end },
    { 419, function() -- Line: 57
            shared.vfx.emit(workspace.VFX["Shidou Awakening VFX"].enable12);
        end },
    { 420, function() -- Line: 60
            shared.vfx.emit(workspace.VFX["Shidou Awakening VFX"].keep);
        end },
    { 438, function() -- Line: 63
            shared.vfx.emit(workspace.VFX["Shidou Awakening VFX"].me);
        end },
    { 643, function() -- Line: 66
            shared.vfx.emit(workspace.VFX["Shidou Awakening VFX"].Shot3);
        end },
    { 723, function() -- Line: 69
            shared.vfx.emit(workspace.VFX["Shidou Awakening VFX"].shidoubg);
        end },
    { 724, function() -- Line: 72
            local v4 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v4 = child;
                    break;
                end;
            end;

            for _, descendant in pairs(v4.Torso.FX.Beams:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 725, function() -- Line: 86
            shared.vfx.emit(workspace.VFX["Shidou Awakening VFX"].Dash1, workspace.VFX["Shidou Awakening VFX"].Dash2Ground, workspace.VFX["Shidou Awakening VFX"].auraVFX, workspace.VFX["Shidou Awakening VFX"].Shot2);
        end }
};

return function(u6) -- Line: 90
    -- upvalues: u5 (copy)
    task.spawn(function() -- Line: 91
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