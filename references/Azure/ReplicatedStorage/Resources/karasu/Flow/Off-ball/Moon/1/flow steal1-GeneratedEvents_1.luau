 
 

return {
    { 0, function() -- Line: 3
            shared.vfx.emit(workspace.Effects.camfx3, workspace.Effects.camfx, workspace.Effects.HitFX, workspace.Effects.cam1g);
        end },
    { 36, function() -- Line: 8
            shared.vfx.emit(workspace.Effects.Dribble1);
        end },
    { 62, function() -- Line: 13
            shared.vfx.emit(workspace.Effects.Dribble);
        end },
    { 96, function() -- Line: 18
            shared.vfx.emit(workspace.Effects.KokuriSpinMesh);
        end },
    { 114, function() -- Line: 23
            shared.vfx.emit(workspace.Effects.camfx2, workspace.azl.HumanoidRootPart.Effects);
        end },
    { 138, function() -- Line: 28
            shared.vfx.emit(workspace["azlball\'"]["Left Arm"].sw, workspace["azlball\'"]["Left Arm"].Touch);
        end },
    { 164, function() -- Line: 33
            shared.vfx.emit(workspace["azlball\'"].Head.nagieyes1, workspace["azlball\'"].Head.nagieyes2);
        end },
    { 278, function() -- Line: 38
            shared.vfx.emit(workspace.Effects.camfx4, workspace.Effects.cam1g2, workspace.Effects.camfx, workspace["azlball\'"].Ball.Attachment);
        end }
};