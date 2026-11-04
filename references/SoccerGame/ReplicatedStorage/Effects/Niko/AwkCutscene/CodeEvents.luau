  

local u3 = {
    { 1, function() -- Line: 2
            shared.vfx.emit(workspace.VFX.VFX.NikoConstantCamera, workspace.VFX.VFX.ConstantCamera);
        end },
    { 36, function() -- Line: 5
            shared.vfx.emit(workspace.VFX.VFX.StartupSimple1);
        end },
    { 41, function() -- Line: 8
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v1.Highlight);
        end },
    { 216, function() -- Line: 18
            shared.vfx.emit(workspace.VFX.VFX.Zone);
        end },
    { 218, function() -- Line: 21
            shared.vfx.emit(workspace.VFX.VFX.StartupSimple);
        end },
    { 606, function() -- Line: 24
            shared.vfx.emit(workspace.VFX.VFX.eye1);
        end },
    { 617, function() -- Line: 27
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v2.Highlight);
        end },
    { 618, function() -- Line: 37
            shared.vfx.emit(workspace.VFX.VFX.Flames);
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