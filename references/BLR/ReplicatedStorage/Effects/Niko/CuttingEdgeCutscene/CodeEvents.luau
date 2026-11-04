  

local u3 = {
    { 1, function() -- Line: 2
            shared.vfx.emit(workspace.VFX.VFX.StepGroup1);
            shared.vfx.emit(workspace.VFX.VFX.RunZoom);
        end },
    { 12, function() -- Line: 7
            shared.vfx.emit(workspace.VFX.VFX.StepGroup2);
        end },
    { 23, function() -- Line: 10
            shared.vfx.emit(workspace.VFX.VFX.StepGroup3);
        end },
    { 35, function() -- Line: 13
            shared.vfx.emit(workspace.VFX.VFX.StepGroup4);
        end },
    { 52, function() -- Line: 16
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.VFX.Startup);
            shared.vfx.emit(workspace.VFX.Ball.Highlight:FindFirstChild("OutlineTransparency"), v1.Highlight:FindFirstChild("OutlineTransparency"));
            shared.vfx.emit(workspace.VFX.VFX.CamZoom);
        end },
    { 122, function() -- Line: 34
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            shared.vfx.emit(workspace.VFX.VFX.BlockShot);
            shared.vfx.emit(workspace.VFX.Ball.Highlight, v2.Highlight);
            shared.vfx.emit(workspace.VFX.VFX.CamZoom2);
        end }
};

return function(u4) -- Line: 51
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 52
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