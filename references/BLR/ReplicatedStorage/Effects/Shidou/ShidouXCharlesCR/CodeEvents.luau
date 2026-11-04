  

local u3 = {
    { 1, function() -- Line: 1
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v1, workspace.VFX["chemical reaction VFX"].ConstantCameraIs, workspace.VFX["chemical reaction VFX"].ConstantCameraIs2, workspace.VFX["chemical reaction VFX"].AwkConstantCameraIs2, workspace.VFX["chemical reaction VFX"].AwkConstantCameraIs);
        end },
    { 267, function() -- Line: 11
            shared.vfx.emit(workspace.VFX["chemical reaction VFX"].Shot2);
        end },
    { 373, function() -- Line: 14
            shared.vfx.emit(workspace.VFX["chemical reaction VFX"].Shot3);
        end },
    { 381, function() -- Line: 17
            for _, descendant in pairs(workspace.VFX["chemical reaction VFX"].Shot3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0.01;
                end;
            end;
        end },
    { 436, function() -- Line: 22
            for _, descendant in pairs(workspace.VFX["chemical reaction VFX"].Shot3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 1;
                end;
            end;
        end },
    { 442, function() -- Line: 27
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v2.Torso);
        end },
    { 443, function() -- Line: 37
            shared.vfx.emit(workspace.VFX["chemical reaction VFX"].Shot1);
        end }
};

return function(u4) -- Line: 41
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 42
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