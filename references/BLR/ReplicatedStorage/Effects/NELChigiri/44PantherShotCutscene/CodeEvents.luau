  

local u2 = {
    { 188, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.vgfx.Stomp);
        end },
    { 206, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.vgfx.Stomp1);
        end },
    { 228, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.vgfx.Stomp2);
        end },
    { 363, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.vgfx.DashPart);
        end },
    { 390, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.vgfx.stop);
        end },
    { 399, function() -- Line: 16
            shared.vfx.emit(workspace.VFX.vgfx.Steam);
        end },
    { 505, function() -- Line: 19
            shared.vfx.emit(workspace.VFX.vgfx.DashPart);
        end },
    { 571, function() -- Line: 22
            shared.vfx.emit(workspace.VFX.vgfx["2dash"]);
        end },
    { 595, function() -- Line: 25
            shared.vfx.emit(workspace.VFX.vgfx.stop);
        end },
    { 599, function() -- Line: 28
            shared.vfx.emit(workspace.VFX.vgfx.RunFx);
        end },
    { 846, function() -- Line: 31
            shared.vfx.emit(workspace.VFX.vgfx.footstep);
        end },
    { 901, function() -- Line: 34
            shared.vfx.emit(workspace.VFX.vgfx.dash3);
        end },
    { 915, function() -- Line: 37
            shared.vfx.emit(workspace.VFX.vgfx.stop2);
        end },
    { 939, function() -- Line: 40
            shared.vfx.emit(workspace.VFX.vgfx.Stomp3);
        end },
    { 983, function() -- Line: 43
            shared.vfx.emit(workspace.VFX.vgfx.StompMini);
        end },
    { 1036, function() -- Line: 46
            shared.vfx.emit(workspace.VFX.vgfx.trap);
        end },
    { 1080, function() -- Line: 49
            shared.vfx.emit(workspace.VFX.vgfx.footste2);
        end },
    { 1194, function() -- Line: 52
            shared.vfx.emit(workspace.VFX.GroundAuraSit);
        end },
    { 1195, function() -- Line: 55
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v1.Head.FX);
        end },
    { 1202, function() -- Line: 65
            shared.vfx.emit(workspace.VFX.vgfx.Stomp4);
        end },
    { 1209, function() -- Line: 68
            shared.vfx.emit(workspace.VFX.vgfx.Scope);
        end },
    { 1391, function() -- Line: 71
            shared.vfx.emit(workspace.VFX.GroundAuraSit);
        end },
    { 1471, function() -- Line: 74
            shared.vfx.emit(workspace.VFX.vgfx.Stomp4);
        end },
    { 1490, function() -- Line: 77
            shared.vfx.emit(workspace.VFX.vgfx.Shoot);
        end }
};

return function(u3) -- Line: 81
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 82
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