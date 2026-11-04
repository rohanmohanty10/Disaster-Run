 

 

return {
    { 400, function(p1, p2) -- Line: 4
            shared.vfx.emit(p1.Jump);
            shared.vfx.emit(p2);
        end },
    { 1170, function(p3) -- Line: 12
            shared.vfx.emit(p3.impactsmoke);
        end },
    { 1501, function(p4) -- Line: 18
            shared.vfx.emit(p4.wind);
            shared.vfx.emit(p4.wind2);
        end },
    { 1623, function(p5) -- Line: 25
            shared.vfx.emit(p5.wind3);
        end }
};