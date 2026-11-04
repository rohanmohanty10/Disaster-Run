  

local u2 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX["demon header VFX"].ConstantCameraIs2, workspace.VFX["demon header VFX"].ConstantCameraIs, workspace.VFX["demon header VFX"].AwkConstantCameraIs2, workspace.VFX["demon header VFX"].AwkConstantCameraIs);
        end },
    { 1, function() -- Line: 4
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v1.Torso);
        end },
    { 69, function() -- Line: 14
            shared.vfx.emit(workspace.VFX["demon header VFX"]:FindFirstChild("Shot2"));
        end },
    { 148, function() -- Line: 17
            shared.vfx.emit(workspace.VFX["demon header VFX"].Shot1);
        end },
    { 152, function() -- Line: 20
            shared.vfx.emit(workspace.VFX["demon header VFX"].Shot3);
        end }
};

return function(u3) -- Line: 24
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 25
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