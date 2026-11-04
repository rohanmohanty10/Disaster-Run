 

 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.Spin);
        end },
    { 13, function(p2) -- Line: 8
            shared.vfx.emit(p2.Tap);
        end },
    { 37, function(p3) -- Line: 13
            shared.vfx.emit(p3.Boom);
        end }
};