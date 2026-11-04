 
 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p2["Right Arm"].flash);
        end },
    { 19, function(p3) -- Line: 8
            shared.vfx.emit(p3.spin);
        end },
    { 36, function(p4, p5) -- Line: 13
            shared.vfx.emit(p4.Final);
            shared.vfx.emit(p5.Highlight);
        end }
};