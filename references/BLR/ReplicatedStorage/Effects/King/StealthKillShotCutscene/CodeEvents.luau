  

local u1 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX["Stealth Kill Shot VFX"].CamVFX, workspace.VFX["Stealth Kill Shot VFX"].AwkConstantCameraIs2);
        end },
    { 1, function() -- Line: 4
            shared.vfx.emit(workspace.VFX["Stealth Kill Shot VFX"].CamVFX, workspace.VFX["Stealth Kill Shot VFX"].AwkConstantCameraIs2);
        end },
    { 28, function() -- Line: 7
            shared.vfx.emit(workspace.VFX["Stealth Kill Shot VFX"].Step1Startup1);
        end },
    { 56, function() -- Line: 10
            shared.vfx.emit(workspace.VFX["Stealth Kill Shot VFX"].Step1Startup);
        end },
    { 87, function() -- Line: 13
            shared.vfx.emit(workspace.VFX["Stealth Kill Shot VFX"].Step1Startup2);
        end },
    { 103, function() -- Line: 16
            shared.vfx.emit(workspace.VFX["Stealth Kill Shot VFX"].StartupSimple2);
        end },
    { 184, function() -- Line: 19
            shared.vfx.emit(workspace.VFX["Stealth Kill Shot VFX"].Step1Startup4);
        end },
    { 206, function() -- Line: 22
            shared.vfx.emit(workspace.VFX["Stealth Kill Shot VFX"].StartupSimple3);
        end },
    { 960, function() -- Line: 25
            shared.vfx.emit(workspace.VFX["Stealth Kill Shot VFX"].EndDash1);
        end },
    { 980, function() -- Line: 28
            shared.vfx.emit(workspace.VFX["Stealth Kill Shot VFX"].shotcharge1);
        end },
    { 1060, function() -- Line: 31
            shared.vfx.emit(workspace.VFX["Stealth Kill Shot VFX"].CamZoom2);
        end },
    { 1061, function() -- Line: 34
            shared.vfx.emit(workspace.VFX["Stealth Kill Shot VFX"].shot);
        end }
};

return function(u2) -- Line: 38
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 39
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