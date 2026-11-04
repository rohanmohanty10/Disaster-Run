  

local u4 = {
    { 1, function() -- Line: 1
            shared.vfx.emit(workspace.VFX.awakeningVFX.ConstantCameraBa, workspace.VFX.awakeningVFX.AwkConstantCameraBa);
            shared.vfx.emit(workspace.VFX.awakeningVFX.Transition1);
        end },
    { 13, function() -- Line: 5
            shared.vfx.emit(workspace.VFX.awakeningVFX.bachiraemit1);
        end },
    { 206, function() -- Line: 8
            shared.vfx.emit(workspace.VFX.awakeningVFX.ScreenZoom1);
        end },
    { 207, function() -- Line: 11
            shared.vfx.emit(workspace.VFX.awakeningVFX.TransitionPuzzle);
        end },
    { 222, function() -- Line: 14
            local v1 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v1 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v1);
        end },
    { 223, function() -- Line: 24
            shared.vfx.emit(workspace.VFX.awakeningVFX.ConstantCameraIs, workspace.VFX.awakeningVFX.AwkConstantCameraIs);
        end },
    { 224, function() -- Line: 27
            shared.vfx.emit(workspace.VFX.awakeningVFX.isagibg);
        end },
    { 408, function() -- Line: 30
            shared.vfx.emit(workspace.VFX.awakeningVFX.bachirabg);
        end },
    { 409, function() -- Line: 33
            shared.vfx.emit(workspace.VFX.awakeningVFX.ConstantCameraBa, workspace.VFX.awakeningVFX.AwkConstantCameraBa);
        end },
    { 564, function() -- Line: 36
            shared.vfx.emit(workspace.VFX.awakeningVFX.Transition1);
        end },
    { 566, function() -- Line: 39
            shared.vfx.emit(workspace.VFX.awakeningVFX.AuraVFX);
        end },
    { 584, function() -- Line: 42
            shared.vfx.emit(workspace.VFX.awakeningVFX.bachiraemit3);
        end },
    { 653, function() -- Line: 45
            shared.vfx.emit(workspace.VFX.awakeningVFX.bachiraemit2);
        end },
    { 665, function() -- Line: 48
            shared.vfx.emit(workspace.VFX.awakeningVFX.bachiraemit2);
        end },
    { 671, function() -- Line: 51
            shared.vfx.emit(workspace.VFX.awakeningVFX.FakeBall);
        end },
    { 700, function() -- Line: 54
            shared.vfx.emit(workspace.VFX.awakeningVFX.isagiemit4);
        end },
    { 739, function() -- Line: 57
            shared.vfx.emit(workspace.VFX.awakeningVFX.TransitionPuzzle);
        end },
    { 741, function() -- Line: 60
            shared.vfx.emit(workspace.VFX.awakeningVFX.ConstantCameraIs2, workspace.VFX.awakeningVFX.AwkConstantCameraIs2);
        end },
    { 742, function() -- Line: 63
            local v2 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v2 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v2["Left Arm"].s, v2["Left Arm"]:FindFirstChild("s"), v2["Left Arm"]:FindFirstChild("s"), v2["Left Arm"]:FindFirstChild("s"), v2["Left Arm"]:FindFirstChild("s"), v2["Left Arm"]:FindFirstChild("s"), v2["Left Arm"]:FindFirstChild("s"), v2["Left Arm"]:FindFirstChild("s"));
        end },
    { 830, function() -- Line: 73
            shared.vfx.emit(workspace.VFX.awakeningVFX.isagiemit4);
        end },
    { 831, function() -- Line: 76
            shared.vfx.emit(workspace.VFX.awakeningVFX.ScreenZoom2);
        end },
    { 832, function() -- Line: 79
            local v3 = nil;

            for _, child in workspace:GetChildren() do
                if child:IsA("Model") and child:GetAttribute("CutsceneChar") then
                    v3 = child;
                    break;
                end;
            end;

            shared.vfx.emit(v3);
        end },
    { 925, function() -- Line: 89
            shared.vfx.emit(workspace.VFX.awakeningVFX.isagiemit3);
        end },
    { 961, function() -- Line: 92
            shared.vfx.emit(workspace.VFX.awakeningVFX.beampart.start["BeamLens again"], workspace.VFX.awakeningVFX.beampart.start["BeamWave 4"]);
        end },
    { 962, function() -- Line: 95
            shared.vfx.emit(workspace.VFX.awakeningVFX.shockwaveend);
        end },
    { 963, function() -- Line: 98
            shared.vfx.emit(workspace.VFX.awakeningVFX.isagiemit2);
        end },
    { 964, function() -- Line: 101
            shared.vfx.emit(workspace.VFX.awakeningVFX.isagigrass);
        end }
};

return function(u5) -- Line: 105
    -- upvalues: u4 (copy)
    task.spawn(function() -- Line: 106
        -- upvalues: u5 (copy), u4 (ref)
        local v6 = 0;

        while u5:IsPlaying() do
            local CurrentFrame = u5.CurrentFrame;

            for _, v in u4 do
                local v7 = v[1];
                local v8 = v[2];

                if v7 <= CurrentFrame and v6 < v7 then
                    task.spawn(v8);
                end;
            end;

            task.wait();
            v6 = CurrentFrame;
        end;
    end);
end;