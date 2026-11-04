 

 

return {
    { 0, function(p1, p2, p3, p4) -- Line: 3
            shared.vfx.emit(p3.aikuawkgreengrid);
            shared.vfx.emit(p1.camera.RightArrow, p1.camera.LeftArrow);
        end },
    { 128, function(p5, p6, p7, p8) -- Line: 9
            shared.vfx.emit(p5.camera.Dash);
            shared.vfx.emit(p5.camera["Cam light"]);
        end },
    { 192, function(p9, p10, p11, p12) -- Line: 15
            shared.vfx.emit(p12.HumanoidRootPart.Deflect);
        end },
    { 235, function(p13, p14, p15, p16) -- Line: 20
            shared.vfx.emit(p14.BallVFX);
            shared.vfx.emit(p16.HumanoidRootPart.DeflectSustain);
        end },
    { 328, function(p17, p18, p19, p20) -- Line: 26
            shared.vfx.emit(p20.Head.EyeFX);
        end }
};