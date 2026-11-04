  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFXFolder:FindFirstChild("ConstantCamera"));
            shared.vfx.emit(workspace.VFX.VFXFolder.IntensityLines);
        end },
    { 107, function() -- Line: 6
            shared.vfx.emit(workspace.VFX.VFXFolder.FallEmit);
        end },
    { 131, function() -- Line: 9
            shared.vfx.emit(workspace.VFX.VFXFolder.Transition);
        end },
    { 256, function() -- Line: 12
            shared.vfx.emit(workspace.VFX.VFXFolder.FakeHead.Breath.Attachment.Steam2);
        end },
    { 335, function() -- Line: 15
            shared.vfx.emit(workspace.VFX.VFXFolder.VictoryShine);
            shared.vfx.emit(workspace.VFX.VFXFolder.Flames);
        end },
    { 566, function() -- Line: 20
            shared.vfx.emit(workspace.VFX.VFXFolder.FakeHead.Breath.Attachment.Attachment.Steam2);
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