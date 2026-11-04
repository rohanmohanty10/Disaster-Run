 
 

return {
    { 100, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.Glow1);
        end },
    { 220, function(p3, p4) -- Line: 8
            shared.vfx.emit(p4.Smoke);
        end },
    { 255, function(p5, p6) -- Line: 13
            shared.vfx.emit(p6.Slash1);
        end },
    { 308, function(p7, p8) -- Line: 18
            shared.vfx.emit(p8.Slash2);
        end },
    { 335, function(p9, p10) -- Line: 23
            shared.vfx.emit(p10.PreFlash);
        end },
    { 343, function(p11, p12) -- Line: 28
            shared.vfx.emit(p12.PreFlash);
        end },
    { 352, function(p13, p14) -- Line: 33
            shared.vfx.emit(p14.PreFlash2);
        end },
    { 359, function(p15, p16) -- Line: 38
            shared.vfx.emit(p16.Star);
        end },
    { 495, function(p17, p18) -- Line: 43
            shared.vfx.emit(p17.Flash2);
        end }
};