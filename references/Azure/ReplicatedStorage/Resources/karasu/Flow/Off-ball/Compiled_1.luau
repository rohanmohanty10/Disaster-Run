 
 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.camfx3, p1.camfx, p1.HitFX, p1.cam1g);
        end },
    { 36, function(p3, p4) -- Line: 8
            shared.vfx.emit(p3.Dribble1);
        end },
    { 62, function(p5, p6) -- Line: 13
            shared.vfx.emit(p5.Dribble);
        end },
    { 96, function(p7, p8) -- Line: 18
            shared.vfx.emit(p7.KokuriSpinMesh);
        end },
    { 114, function(p9, p10) -- Line: 23
            shared.vfx.emit(p9.camfx2);
        end },
    { 138, function(p11, p12) -- Line: 28
            shared.vfx.emit(p12["Left Arm"].sw, p12["Left Arm"].Touch);
        end },
    { 164, function(p13, p14) -- Line: 33
            shared.vfx.emit(p14.Head.nagieyes1, p14.Head.nagieyes2);
        end },
    { 278, function(p15, p16) -- Line: 38
            shared.vfx.emit(p15.camfx4, p15.cam1g2, p15.camfx, p16.Ball.Attachment);
        end }
};