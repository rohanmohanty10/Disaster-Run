  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX["Super Reflexes VFX"].emit1);
            shared.vfx.emit(workspace.VFX["Super Reflexes VFX"].ConstantCameraGagamaru);
        end },
    { 118, function() -- Line: 5
            shared.vfx.emit(workspace.VFX["Super Reflexes VFX"].emit2);
        end },
    { 256, function() -- Line: 8
            shared.vfx.emit(workspace.VFX["Super Reflexes VFX"].emit3);
        end },
    { 352, function() -- Line: 11
            shared.vfx.emit(workspace.VFX["Super Reflexes VFX"].roarVFX);
        end },
    { 390, function() -- Line: 14
            shared.vfx.emit(workspace.VFX["Super Reflexes VFX"].emit4, workspace.VFX["Super Reflexes VFX"].emit5, workspace.VFX["Super Reflexes VFX"].emit6);
        end }
};

return function(u2) -- Line: 18
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 19
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