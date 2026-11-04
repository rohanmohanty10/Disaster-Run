 
 

return {
    { 16, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.windup);
        end },
    { 37, function(p3, p4) -- Line: 8
            shared.vfx.emit(p3.shot);
        end },
    { 95, function(p5, p6) -- Line: 13
            if p6 and p6.Parent then
                shared.vfx.emit(p6);
            end;
        end },
    { 98, function(p7, p8) -- Line: 20
            shared.vfx.emit(p7.prewindup);
        end }
};