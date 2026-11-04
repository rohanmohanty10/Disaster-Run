  

local u2 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.VFX["24/7Wind"], workspace.VFX.VFX.CamZoom);
        end },
    { 94, function() -- Line: 4
            shared.vfx.emit(workspace.VFX.VFX.WindGust2);
        end },
    { 99, function() -- Line: 7
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.VFX.Jump);
            shared.vfx.emit(v1:FindFirstChild("Highlight"), workspace.VFX.Ball.Highlight);
        end }
};

return function(u3) -- Line: 21
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 22
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