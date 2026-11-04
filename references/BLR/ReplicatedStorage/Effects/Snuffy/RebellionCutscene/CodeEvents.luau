  

local u1 = {
    { 1, function() -- Line: 2
            shared.vfx.emit(workspace.VFX.RebellionVFX.AwkConstantCameraIs2);
        end },
    { 94, function() -- Line: 5
            shared.vfx.emit(workspace.VFX.RebellionVFX.shotcharge1);
        end },
    { 100, function() -- Line: 8
            shared.vfx.emit(workspace.VFX.RebellionVFX.CamZoom2);
        end },
    { 281, function() -- Line: 11
            shared.vfx.emit(workspace.VFX.RebellionVFX.shot);
        end },
    { 285, function() -- Line: 14
            for _, descendant in pairs(workspace.VFX.RebellionVFX.BallTrail:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 308, function() -- Line: 21
            for _, descendant in pairs(workspace.VFX.RebellionVFX.BallTrail:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 491, function() -- Line: 28
            for _, descendant in pairs(workspace.VFX.RebellionVFX.BallTrail:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 532, function() -- Line: 35
            shared.vfx.emit(workspace.VFX.RebellionVFX.Leap1);
        end },
    { 600, function() -- Line: 38
            for _, descendant in pairs(workspace.VFX.RebellionVFX.BallTrail:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 47
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 48
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