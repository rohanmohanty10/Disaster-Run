  

local u2 = {
    { 61, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFX.stomp1);
        end },
    { 77, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.VFX.stomp2);
        end },
    { 93, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.VFX.stomp3);
        end },
    { 154, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.VFX.StartupSimple1);
        end },
    { 183, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.VFX.StartupSimple2);
        end },
    { 252, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.VFX.Jump);
        end },
    { 253, function() -- Line: 19
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.Ball, v1);
        end },
    { 345, function() -- Line: 29
            shared.vfx.emit(workspace.VFX.VFX.Zone);
        end },
    { 451, function() -- Line: 32
            shared.vfx.emit(workspace.VFX.VFX.Jump);
        end },
    { 540, function() -- Line: 35
            shared.vfx.emit(workspace.VFX.VFX.CamZoom);
        end }
};

return function(u3) -- Line: 39
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 40
        -- upvalues: u3 (copy), u2 (ref)
        local v4 = 0;

        while u3:IsPlaying() do
            local CurrentFrame = u3.CurrentFrame;

            for _, v in u2 do
                local v5 = v[1];
                local v6 = v[2];

                if v5 <= CurrentFrame and v4 < v5 then
                    task.spawn(v6);
                end;
            end;

            task.wait();
            v4 = CurrentFrame;
        end;
    end);
end;