  

local u3 = {
    { 1, function() -- Line: 1
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX["dragon drive VFX"].AwkConstantCameraIs, workspace.VFX["dragon drive VFX"].AwkConstantCameraIs2, workspace.VFX["dragon drive VFX"].ConstantCameraIs, workspace.VFX["dragon drive VFX"].ConstantCameraIs2);
            shared.vfx.emit(v1.Head);
            shared.vfx.emit(workspace.VFX["dragon drive VFX"].splashenable1);
        end },
    { 170, function() -- Line: 13
            shared.vfx.emit(workspace.VFX["dragon drive VFX"].shot1);
        end },
    { 221, function() -- Line: 16
            shared.vfx.emit(workspace.VFX["dragon drive VFX"].shot1);
        end },
    { 258, function() -- Line: 19
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v2.Torso.FX);
        end },
    { 260, function() -- Line: 29
            shared.vfx.emit(workspace.VFX["dragon drive VFX"].trailsandsuch);
        end },
    { 491, function() -- Line: 32
            shared.vfx.emit(workspace.VFX["dragon drive VFX"].shot2);
        end },
    { 573, function() -- Line: 35
            shared.vfx.emit(workspace.VFX["dragon drive VFX"].shot3);
        end },
    { 593, function() -- Line: 38
            shared.vfx.emit(workspace.VFX["dragon drive VFX"].shot4);
        end }
};

return function(u4) -- Line: 42
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 43
        -- upvalues: u4 (copy), u3 (ref)
        local v5 = 0;

        while u4:IsPlaying() do
            local CurrentFrame = u4.CurrentFrame;

            for _, v in u3 do
                local v6 = v[1];
                local v7 = v[2];

                if v6 <= CurrentFrame and v5 < v6 then
                    task.spawn(v7);
                end;
            end;

            task.wait();
            v5 = CurrentFrame;
        end;
    end);
end;