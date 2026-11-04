 

 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.Scene);
            shared.vfx.emit(p1.Screen);
            shared.vfx.emit(p1.Viget);
        end },
    { 316, function(p2) -- Line: 10
            shared.vfx.emit(p2.Floor1);
            shared.vfx.emit(p2.Floor2);
        end },
    { 324, function(p3) -- Line: 16
            shared.vfx.emit(p3.Screen2);
        end },
    { 325, function(p4, p5, p6) -- Line: 21
            shared.vfx.emit(p6["H.F. Blade 2"].Model.VFX);
        end },
    { 588, function(p7, p8, p9) -- Line: 26
            shared.vfx.emit(p9["raiden mask"]["raiden mask close"].MaskVFX1);
        end }
};