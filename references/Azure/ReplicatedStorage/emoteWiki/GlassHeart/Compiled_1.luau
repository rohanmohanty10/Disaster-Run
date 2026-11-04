 
 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.Stars1);
            shared.vfx.emit(p1.Bubbles, p1.circles);
        end },
    { 1040, function(p2) -- Line: 9
            shared.vfx.emit(p2.Star);
        end },
    { 1085, function(p3) -- Line: 14
            shared.vfx.emit(p3.Stars2);
        end }
};