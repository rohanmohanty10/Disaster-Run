 
 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.dashf);
        end },
    { 51, function(p3, p4) -- Line: 8
            shared.vfx.emit(p3.bounce);
        end },
    { 79, function(p5, p6) -- Line: 13
            shared.vfx.emit(p5.trap);
        end },
    { 124, function(p7, p8) -- Line: 18
            shared.vfx.emit(p7.step);
        end },
    { 153, function(p9, p10) -- Line: 23
            shared.vfx.emit(p9.DashF);
        end }
};