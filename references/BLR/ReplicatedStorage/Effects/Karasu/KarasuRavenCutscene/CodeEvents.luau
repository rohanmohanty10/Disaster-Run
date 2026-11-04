  

local u1 = {
    { 1, function() -- Line: 2
            print(workspace.VFX.VFXFolder.camvfx2);
            shared.vfx.emit(workspace.VFX.VFXFolder.wisps, workspace.VFX.VFXFolder.camvfx2);
            shared.vfx.emit(workspace.VFX.VFXFolder.GroundFX);
        end },
    { 175, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.VFXFolder.Dash1);
        end },
    { 189, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.VFXFolder.Dash2);
        end },
    { 322, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.VFXFolder.LastDash);
            task.wait(1);
        end }
};

return function(u2) -- Line: 24
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 25
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