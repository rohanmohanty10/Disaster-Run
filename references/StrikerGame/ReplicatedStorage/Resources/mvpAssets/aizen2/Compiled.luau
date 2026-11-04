 

 

return {
    { 25, function(p1) -- Line: 3
            shared.vfx.emit(p1.step);
        end },
    { 150, function(p2) -- Line: 8
            shared.vfx.emit(p2.air, p2.Room, p2.AuraWindMeshes);
        end },
    { 480, function(p3, p4) -- Line: 13
            shared.vfx.emit(p4.Ball);
        end },
    { 521, function(p5) -- Line: 18
            shared.vfx.emit(p5["ball glass "]);
        end },
    { 740, function(p6) -- Line: 23
            shared.vfx.emit(p6.ScreenEffect);
        end },
    { 744, function(p7) -- Line: 28
            shared.vfx.emit(p7.background);
        end },
    { 951, function(p8) -- Line: 33
            shared.vfx.emit(p8["background go small "]);
        end }
};