  

local u3 = {
    { 1, function() -- Line: 1
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.ConstantCamera);
            shared.vfx.emit(v1.Highlight);
            shared.vfx.emit(workspace.VFX.FakeBall);
        end },
    { 201, function() -- Line: 15
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.Jump1);
            shared.vfx.emit(v2.Highlight);
        end },
    { 252, function() -- Line: 27
            shared.vfx.emit(workspace.VFX.BallAura);
        end },
    { 270, function() -- Line: 30
            shared.vfx.emit(workspace.VFX.Shot);
        end }
};

return function(u4) -- Line: 34
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 35
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