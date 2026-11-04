  

local u2 = {
    { 1, function() -- Line: 2
            shared.vfx.emit(workspace.VFX.VFX.VictimScene1);
        end },
    { 108, function() -- Line: 5
            shared.vfx.emit(workspace.VFX.VFX.ScreenEffect);
        end },
    { 109, function() -- Line: 8
            shared.vfx.emit(workspace.VFX.VFX.Scene1);
        end },
    { 323, function() -- Line: 11
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.VFX.Clear);

            if v1 and v1:FindFirstChild("Highlight") then
                shared.vfx.emit(v1.Highlight:FindFirstChild("OutlineTransparency"));
            end;

            shared.vfx.emit(workspace.VFX.VFX.Scene2);
        end },
    { 429, function() -- Line: 25
            shared.vfx.emit(workspace.VFX.VFX.Drop);
        end },
    { 444, function() -- Line: 28
            shared.vfx.emit(workspace.VFX.VFX.Scene3);
        end }
};

return function(u3) -- Line: 33
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 34
        -- upvalues: u3 (copy), u2 (ref)
        local v4 = 0;

        while u3:IsPlaying() do
            local CurrentFrame = u3.CurrentFrame;

            for _, v in u2 do
                if v[1] <= CurrentFrame and v4 < v[1] then
                    task.spawn(v[2]);
                end;
            end;

            task.wait();
            v4 = CurrentFrame;
        end;
    end);
end;