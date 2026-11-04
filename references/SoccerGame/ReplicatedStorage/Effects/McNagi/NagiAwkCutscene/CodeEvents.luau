  

local u1 = {
    { 32, function() -- Line: 1
            require(game.ReplicatedStorage.VfxManager).Emit(workspace.VFX["Nagi Breathe"]);
        end },
    { 575, function() -- Line: 6
            require(game.ReplicatedStorage.VfxManager).Emit(workspace.VFX.Alert);
        end },
    { 631, function() -- Line: 11
            require(game.ReplicatedStorage.VfxManager).Emit(workspace.VFX.Enable);
        end },
    { 704, function() -- Line: 16
            require(game.ReplicatedStorage.VfxManager).Emit(workspace.VFX.Flick);
        end },
    { 711, function() -- Line: 21
            require(game.ReplicatedStorage.VfxManager).Emit(workspace.VFX.Enable2);
        end },
    { 759, function() -- Line: 26
            require(game.ReplicatedStorage.VfxManager).Emit(workspace.VFX.Enable3);
        end },
    { 786, function() -- Line: 31
            require(game.ReplicatedStorage.VfxManager).Emit(workspace.VFX.Enable4);
        end },
    { 837, function() -- Line: 36
            require(game.ReplicatedStorage.VfxManager).Emit(workspace.VFX.Slam);
        end },
    { 737, function() -- Line: 41
            require(game.ReplicatedStorage.VfxManager).Emit(workspace.VFX.Trap1);
        end },
    { 755, function() -- Line: 46
            require(game.ReplicatedStorage.VfxManager).Emit(workspace.VFX.Trap2);
        end },
    { 777, function() -- Line: 51
            require(game.ReplicatedStorage.VfxManager).Emit(workspace.VFX.Trap3);
        end },
    { 956, function() -- Line: 56
            require(game.ReplicatedStorage.VfxManager).Emit(workspace.VFX.Catch);
        end }
};

return function(u2) -- Line: 62
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 63
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