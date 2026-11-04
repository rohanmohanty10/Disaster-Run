 

 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p1.Decals);
        end },
    { 11, function(p4, p5, p6) -- Line: 8
            shared.vfx.emit(p4.dive);
        end },
    { 227, function(p7, p8, p9) -- Line: 13
            shared.vfx.emit(p8.Ball);
        end },
    { 238, function(p10, p11, p12) -- Line: 18
            shared.vfx.emit(p11.Ball);
        end },
    { 246, function(p13, p14, p15) -- Line: 23
            shared.vfx.emit(p14.Ball);
        end },
    { 250, function(p16, p17, p18) -- Line: 28
            shared.vfx.emit(p17.Ball);
        end },
    { 251, function(p19, p20, p21) -- Line: 33
            shared.vfx.emit(p19.smoke);
        end },
    { 275, function(p22, p23, p24) -- Line: 38
            shared.vfx.emit(p22.what);
        end },
    { 286, function(p25, p26, p27) -- Line: 43
            shared.vfx.emit(p25.CameraShake);
            shared.vfx.emit(p27.Head.VictimFX);
        end },
    { 346, function(p28, p29, p30) -- Line: 49
            shared.vfx.emit(p28.ScreenEffect);
        end },
    { 367, function(p31, p32, p33) -- Line: 54
            shared.vfx.emit(p31.pressure);
            shared.vfx.emit(p31.Domain);
        end },
    { 500, function(p34, p35, p36) -- Line: 60
            shared.vfx.emit(p34.namedrop);
            shared.vfx.emit(p34.CameraShake);
        end }
};