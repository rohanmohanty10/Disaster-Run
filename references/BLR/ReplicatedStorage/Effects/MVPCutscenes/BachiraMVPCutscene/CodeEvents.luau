  

local u2 = {
    { 4, function() -- Line: 2
            shared.vfx.emit(workspace.VFX.VFX.Spinning);
        end },
    { 92, function() -- Line: 5
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.VFX.Land);
            shared.vfx.emit(v1.Highlight);
        end }
};

return function(u3) -- Line: 19
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 20
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