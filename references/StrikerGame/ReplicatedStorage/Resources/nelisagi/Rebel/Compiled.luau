 
 

return {
    { 0, function(p1, p2) -- Line: 5
            shared.vfx.emit(p1.dash);
        end },
    { 213, function(p3, p4) -- Line: 12
            shared.vfx.emit(p3.puzzle);
        end },
    { 426, function(p5, p6) -- Line: 19
            shared.vfx.emit(p6["Right Leg"]);
        end },
    { 444, function(p7, p8) -- Line: 26
            shared.vfx.emit(p8["Left Leg"]);
        end },
    { 470, function(p9, p10) -- Line: 33
            shared.vfx.emit(p10["Right Leg"]);
            shared.vfx.emit(p10["Left Arm"]);
            shared.vfx.emit(p9.puzzle2);
        end },
    { 555, function(p11, p12) -- Line: 42
            shared.vfx.emit(p11.slam);
            shared.vfx.emit(p11.beamwindfinal);
        end }
};