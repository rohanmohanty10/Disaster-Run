  

local function findRig(p1) -- Line: 2
    local VFX = workspace:FindFirstChild("VFX");

    if VFX then
        VFX = VFX:FindFirstChild(p1);
    end;

    if VFX then
        return VFX;
    end;

    for _, child in workspace:GetChildren() do
        if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
            return child;
        end;
    end;

    error("Cutscene rig not found: " .. p1);
end;

local u2 = {
    { 1, function() -- Line: 17
            shared.vfx.emit(workspace.VFX.AwkVariantVFX.Trail);
        end },
    { 100, function() -- Line: 20
            shared.vfx.emit(workspace.VFX.AwkVariantVFX.StartupSimple);
        end },
    { 103, function() -- Line: 23
            shared.vfx.emit(workspace.VFX.AwkVariantVFX.yes);
        end }
};

return function(u3) -- Line: 28
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 29
        -- upvalues: u3 (copy), u2 (ref)
        local v4 = 0;

        while u3:IsPlaying() do
            local CurrentFrame = u3.CurrentFrame;

            for _, v in u2 do
                if v4 < v[1] and v[1] <= CurrentFrame then
                    task.spawn(v[2]);
                end;
            end;

            task.wait();
            v4 = CurrentFrame;
        end;
    end);
end;