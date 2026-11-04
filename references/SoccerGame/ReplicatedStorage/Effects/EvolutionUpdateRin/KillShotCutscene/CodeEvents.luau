  

local u2 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFXCutscene["24/7Wind"]);
            shared.vfx.emit(workspace.VFX.VFXCutscene.StartupReall);
        end },
    { 160, function() -- Line: 6
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.VFXCutscene.Shot);
            shared.vfx.emit(workspace.VFX.VFXCutscene.CamZoom);
            shared.vfx.emit(workspace.VFX.VFXCutscene.cameraemit1);
            shared.vfx.emit(v1.Highlight);
        end }
};

return function(u3) -- Line: 20
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 21
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