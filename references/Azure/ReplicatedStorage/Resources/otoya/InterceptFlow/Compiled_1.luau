 
 

return {
    { 20, function(p1) -- Line: 3
            shared.vfx.emit(p1.TuffCharacterRig0.Ball.Hit);
        end },
    { 54, function(p2) -- Line: 8
            shared.vfx.emit(p2.TuffCharacterRig0.Head.Eyes);
        end },
    { 55, function(p3, p4) -- Line: 13
            if p4 then
                shared.vfx.emit(p4.camera.CamVFX.CamShot2, p4.camera.CamVFX.CamShot1);
            end;
        end },
    { 56, function(p5) -- Line: 20
            shared.vfx.emit(p5.CamVFX.CameraShot);
        end },
    { 57, function(p6) -- Line: 25
            shared.vfx.emit(p6.TuffCharacterRig0.HumanoidRootPart.Debri);
        end },
    { 132, function(p7) -- Line: 30
            shared.vfx.emit(p7.TuffCharacterRig0.Head.Attachment);
        end }
};