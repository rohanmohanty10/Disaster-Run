  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFXFolder.AtmosphereBox1);
            shared.vfx.emit(workspace.VFX.VFXFolder.AwkConstantCameraGagamaru);
        end },
    { 639, function() -- Line: 6
            shared.vfx.emit(workspace.VFX.VFXFolder.AtmosphereBox2);
            shared.vfx.emit(workspace.VFX.VFXFolder.AwkConstantCameraGagamaru2);
        end },
    { 860, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.VFXFolder.AtmosphereBox3);
            shared.vfx.emit(workspace.VFX.VFXFolder.CamZoom);
        end },
    { 959, function() -- Line: 15
            shared.vfx.emit(workspace.VFX.VFXFolder.Drop1);
        end },
    { 985, function() -- Line: 18
            shared.vfx.emit(workspace.VFX.VFXFolder.Drop2);
        end }
};

return function(u2) -- Line: 22
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 23
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