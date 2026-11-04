  

local u2 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].CamVFX);
        end },
    { 1, function() -- Line: 4
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v1.Head, workspace.VFX.kiyora.Head, workspace.VFX["random person"].Head);
        end },
    { 42, function() -- Line: 14
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].isagiemit4);
        end },
    { 166, function() -- Line: 17
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].kaiseremit1);
        end },
    { 202, function() -- Line: 20
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].kaiseremit2);
        end },
    { 223, function() -- Line: 23
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"]:FindFirstChild("kaiseremit3"));
        end },
    { 246, function() -- Line: 26
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].kaiserchem4);
        end },
    { 418, function() -- Line: 29
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].kiyorashot);
        end },
    { 706, function() -- Line: 32
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].kaiseremit6);
        end },
    { 716, function() -- Line: 35
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].Dash2);
        end },
    { 717, function() -- Line: 38
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].kaiseremit5);
        end },
    { 780, function() -- Line: 41
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].dirt2);
        end },
    { 811, function() -- Line: 44
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].kiyorashot2);
        end },
    { 814, function() -- Line: 47
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].Dash2);
        end },
    { 1073, function() -- Line: 50
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].kaiserchem5);
        end },
    { 1245, function() -- Line: 53
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].Part);
        end },
    { 1285, function() -- Line: 56
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].kaiserchem111);
        end },
    { 1286, function() -- Line: 59
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].Dash3);
        end },
    { 1287, function() -- Line: 62
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].CamZoom2);
        end },
    { 1289, function() -- Line: 65
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].incrediblepart);
        end },
    { 1372, function() -- Line: 68
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].kaiseremit4);
        end },
    { 1488, function() -- Line: 71
            shared.vfx.emit(workspace.VFX["kaiser magnus chem VFX"].kaisershotlast);
        end }
};

return function(u3) -- Line: 75
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 76
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