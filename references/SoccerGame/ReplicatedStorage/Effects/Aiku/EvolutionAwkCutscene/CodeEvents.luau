  

local u1 = {
    { 1, function() -- Line: 3
            local Atmosphere = workspace.VFX:FindFirstChild("Atmosphere");

            if Atmosphere then
                Atmosphere.Parent = game:GetService("Lighting");
            end;
        end },
    { 1, function() -- Line: 8
        end },
    { 95, function() -- Line: 12
            shared.vfx.emit(workspace.VFX.CamZoom);
            shared.vfx.emit(workspace.VFX.MetavisionTunnel);
        end }
};

return function(u2) -- Line: 19
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 20
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