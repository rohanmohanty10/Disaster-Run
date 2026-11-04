 
 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p2.camera.camfx.cam1g);
            shared.vfx.emit(p1.Step1);
        end },
    { 16, function(p3) -- Line: 9
            shared.vfx.emit(p3.Step2);
        end },
    { 30, function(p4, p5) -- Line: 14
            shared.vfx.emit(p5.camera.Attachment);
        end },
    { 72, function(p6, p7) -- Line: 19
            shared.vfx.emit(p7.camera.camfx.line2);
        end },
    { 78, function(p8) -- Line: 24
            shared.vfx.emit(p8.TuffCharacterRig0.HumanoidRootPart.DirtDrag);
            shared.vfx.emit(p8.Main);
        end },
    { 120, function(p9, p10) -- Line: 30
            shared.vfx.emit(p10.camera.camfx.cambeamlast);
            shared.vfx.emit(p9.TuffCharacterRig0.Ball.Hit);
            shared.vfx.emit(p9.Dribble);
            shared.vfx.emit(p9.Mesh1);
            shared.vfx.emit(p10.camera.camfx.snuf1);
        end },
    { 149, function(p11) -- Line: 39
            shared.vfx.emit(p11.Mesh2);
            shared.vfx.emit(p11.aurawind);
        end },
    { 220, function(p12, p13) -- Line: 45
            shared.vfx.emit(p13.camera.Attachment);
        end },
    { 256, function(p14, p15) -- Line: 50
            shared.vfx.emit(p15.camera.camfx.line3);
        end }
};