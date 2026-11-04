 

 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p2);
        end },
    { 26, function(p4, p5, p6) -- Line: 9
            p4:PivotTo(p6.CFrame);
            shared.vfx.emit(p4);
        end }
};