  

local u1 = {
    { 1, function() -- Line: 3
            local BlackBox = workspace.VFX.crushingbloomVFX:FindFirstChild("BlackBox");

            if BlackBox then
                shared.vfx.emit(BlackBox);
            end;
        end },
    { 1, function() -- Line: 8
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.ScreenEffect2);
        end },
    { 2, function() -- Line: 11
            for _, descendant in pairs(workspace.VFX.crushingbloomVFX.gridfloor:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 19, function() -- Line: 18
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.aim);
        end },
    { 20, function() -- Line: 21
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.chances);
        end },
    { 94, function() -- Line: 24
            shared.vfx.emit(workspace.VFX.crushingbloomVFX["dash!"]);
        end },
    { 159, function() -- Line: 27
            for _, descendant in pairs(workspace.VFX.crushingbloomVFX.gridfloor:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 160, function() -- Line: 34
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.Start2);
        end },
    { 188, function() -- Line: 37
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.sHOT);
        end },
    { 189, function() -- Line: 40
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.WindGust1);
        end },
    { 228, function() -- Line: 43
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.CamZoom2);
        end },
    { 229, function() -- Line: 46
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.aikuemit1);
        end },
    { 231, function() -- Line: 49
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.aikuemit1.Ground.MeshFlip);
        end },
    { 232, function() -- Line: 52
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.WindGust2);
        end },
    { 233, function() -- Line: 55
            shared.vfx.emit(workspace.VFX.crushingbloomVFX.WindGust2);
        end }
};

return function(u2) -- Line: 60
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 61
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