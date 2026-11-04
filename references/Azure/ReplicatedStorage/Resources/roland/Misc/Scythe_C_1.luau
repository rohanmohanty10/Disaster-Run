 
 

return {
    { 11, function(p1, p2) -- Line: 3
            shared.vfx.emit(p2["Right Arm"].handleappear);
        end },
    { 14, function(p3) -- Line: 8
            shared.vfx.emit(p3.Preappear);
        end },
    { 25, function(p4) -- Line: 13
            shared.vfx.emit(p4.Appear);
            shared.vfx.emit(p4.Spin);
        end }
};