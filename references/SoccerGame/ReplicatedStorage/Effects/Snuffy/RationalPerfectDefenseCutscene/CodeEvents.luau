  

local u1 = {
    { 1, function() -- Line: 2
            shared.vfx.emit(workspace.VFX.RationalPerfectDefenseVFX.CamVFX);
        end },
    { 91, function() -- Line: 5
            shared.vfx.emit(workspace.VFX.RationalPerfectDefenseVFX.Dash);
        end }
};

return function(u2) -- Line: 10
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 11
        -- upvalues: u2 (copy), u1 (ref)
        local v3 = 0;

        while u2:IsPlaying() do
            local CurrentFrame = u2.CurrentFrame;

            for _, v in u1 do
                if v[1] <= CurrentFrame and v3 < v[1] then
                    task.spawn(v[2]);
                end;
            end;

            task.wait();
            v3 = CurrentFrame;
        end;
    end);
end;