  

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
    { 58, function() -- Line: 17
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.yes);
        end },
    { 70, function() -- Line: 20
            -- upvalues: findRig (copy)
            shared.vfx.emit(findRig("Rekysui"));
        end },
    { 78, function() -- Line: 23
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple);
        end },
    { 96, function() -- Line: 26
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple);
        end },
    { 167, function() -- Line: 29
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple1);
        end },
    { 210, function() -- Line: 32
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple2);
        end },
    { 240, function() -- Line: 35
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple3);
        end },
    { 279, function() -- Line: 38
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple4);
        end },
    { 317, function() -- Line: 41
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple5);
        end },
    { 349, function() -- Line: 44
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple6);
        end },
    { 375, function() -- Line: 47
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple7);
        end },
    { 503, function() -- Line: 50
            shared.vfx.emit(workspace.VFX.YoMichaelVFX:FindFirstChild("StartupSimple10"));
        end },
    { 511, function() -- Line: 53
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple8);
        end },
    { 585, function() -- Line: 56
            shared.vfx.emit(workspace.VFX.lines);
        end },
    { 599, function() -- Line: 59
            shared.vfx.emit(workspace.VFX.lines2);
        end },
    { 709, function() -- Line: 62
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple9);
        end },
    { 799, function() -- Line: 65
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple10);
        end },
    { 817, function() -- Line: 68
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple11);
        end },
    { 836, function() -- Line: 71
            shared.vfx.emit(workspace.VFX.YoMichaelVFX:FindFirstChild("StartupSimple12"));
        end },
    { 848, function() -- Line: 74
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.basepart);
        end },
    { 850, function() -- Line: 77
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple13);
        end },
    { 853, function() -- Line: 80
            shared.vfx.emit(workspace.VFX.YoMichaelVFX.StartupSimple9);
        end }
};

return function(u3) -- Line: 85
    -- upvalues: u2 (copy)
    task.spawn(function() -- Line: 86
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