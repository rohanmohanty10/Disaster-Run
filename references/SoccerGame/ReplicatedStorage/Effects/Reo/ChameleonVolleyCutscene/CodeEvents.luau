  

local u2 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.ConstantCamera);
        end },
    { 97, function() -- Line: 4
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.StartupSimple);
            shared.vfx.emit(v1.Highlight);
            shared.vfx.emit(workspace.VFX["blr reo rig"].Highlight);
        end },
    { 119, function() -- Line: 18
            shared.vfx.emit(workspace.VFX.Zone);
        end },
    { 203, function() -- Line: 21
            shared.vfx.emit(workspace.VFX.EndDash);
        end },
    { 252, function() -- Line: 24
            shared.vfx.emit(workspace.VFX.EndDash2);
            shared.vfx.emit(workspace.VFX.Aura);
        end },
    { 310, function() -- Line: 29
            shared.vfx.emit(workspace.VFX.Jump);
        end },
    { 644, function() -- Line: 32
            shared.vfx.emit(workspace.VFX.Shot);
        end }
};

return function(u3) -- Line: 36
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 37
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