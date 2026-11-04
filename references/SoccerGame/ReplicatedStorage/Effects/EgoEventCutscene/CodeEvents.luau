  

local u1 = {
    { 1, function() -- Line: 1
            for _, descendant in pairs(workspace.VFX["Ego Rocket VFX"].snowingVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 90, function() -- Line: 9
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egoemitVFX2);
        end },
    { 148, function() -- Line: 12
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egoemitVFX3);
        end },
    { 217, function() -- Line: 15
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egoemitVFX4);
        end },
    { 959, function() -- Line: 18
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egoemitVFX);
        end },
    { 1097, function() -- Line: 21
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egorocketemit1);
        end },
    { 1100, function() -- Line: 24
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egorocketemit1);
        end },
    { 1109, function() -- Line: 27
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egorocketemit1);
        end },
    { 1124, function() -- Line: 30
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egofireworkemitYELLOW);
        end },
    { 1138, function() -- Line: 33
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egofireworkemitRED);
        end },
    { 1153, function() -- Line: 36
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egofireworkemitPURPLE);
        end },
    { 1167, function() -- Line: 39
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egofireworkemitORANGE);
        end },
    { 1174, function() -- Line: 42
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egorocketemit2);
        end },
    { 1180, function() -- Line: 45
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egofireworkemitGREEN);
        end },
    { 1191, function() -- Line: 48
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egofireworkemitBLUE);
        end },
    { 1200, function() -- Line: 51
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egofireworkemitYELLOW);
        end },
    { 1214, function() -- Line: 54
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egofireworkemitRED);
        end },
    { 1221, function() -- Line: 57
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egorocketemit3);
        end },
    { 1229, function() -- Line: 60
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egofireworkemitPURPLE);
        end },
    { 1243, function() -- Line: 63
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egofireworkemitORANGE);
        end },
    { 1256, function() -- Line: 66
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egofireworkemitGREEN);
        end },
    { 1267, function() -- Line: 69
            shared.vfx.emit(workspace.VFX["Ego Rocket VFX"].egofireworkemitBLUE);
        end },
    { 1645, function() -- Line: 72
            for _, descendant in pairs(workspace.VFX["Ego Rocket VFX"].snowingVFX:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};

return function(u2) -- Line: 81
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 82
        -- upvalues: u2 (copy), u1 (ref)
        local v3 = 0;

        while u2:IsPlaying() do
            local CurrentFrame = u2.CurrentFrame;

            for _, v in u1 do
                local v4 = v[1];
                local v5 = v[2];

                if v4 <= CurrentFrame and v3 < v4 then
                    task.spawn(v5);
                end;
            end;

            task.wait();
            v3 = CurrentFrame;
        end;
    end);
end;