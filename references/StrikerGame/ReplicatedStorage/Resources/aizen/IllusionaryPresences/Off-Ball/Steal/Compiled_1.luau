 
 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.wind);
            shared.vfx.emit(p2.Handle.kyokag);
        end },
    { 30, function(p3) -- Line: 9
            shared.vfx.emit(p3.slashes);
        end },
    { 144, function(p4) -- Line: 14
            shared.vfx.emit(p4.final);
        end }
};