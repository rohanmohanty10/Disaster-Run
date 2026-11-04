  

local u2 = {
    { 3, function() -- Line: 2
            shared.vfx.emit(workspace.VFX.VFX.Jump);
        end },
    { 4, function() -- Line: 5
            shared.vfx.emit(workspace.VFX.VFX["24/7Wind"]);
        end },
    { 7, function() -- Line: 8
            shared.vfx.emit(workspace.VFX.VFX.CamZoom);
        end },
    { 11, function() -- Line: 11
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            if v1 and v1:FindFirstChild("Highlight") then
                shared.vfx.emit(v1.Highlight);
            end;
        end },
    { 139, function() -- Line: 23
            shared.vfx.emit(workspace.VFX.VFX.Shot);
            shared.vfx.emit(workspace.VFX.VFX.WindGust2);
        end },
    { 162, function() -- Line: 27
            shared.vfx.emit(workspace.VFX.VFX.Ground);
        end }
};

return function(u3) -- Line: 32
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 33
        -- upvalues: u3 (copy), u2 (ref)
        local v4 = 0;

        while u3:IsPlaying() do
            local CurrentFrame = u3.CurrentFrame;

            for _, v in u2 do
                local v5 = v[1];

                if v5 <= CurrentFrame and v4 < v5 then
                    task.spawn(v[2]);
                end;
            end;

            task.wait();
            v4 = CurrentFrame;
        end;
    end);
end;