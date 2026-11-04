 

 

return {
    { 10, function(p1, p2) -- Line: 3
            shared.vfx.emit(p2.Handle.EnableFX);
        end },
    { 80, function(p3) -- Line: 8
            shared.vfx.emit(p3["Megumin MVP"].Pre, p3["Megumin MVP"].Fire);
        end },
    { 90, function(p4) -- Line: 13
            shared.vfx.emit(p4["Megumin MVP"].Enabled);
        end },
    { 170, function(p5, p6) -- Line: 18
            shared.vfx.emit(p6.Handle.EnableFX2);
        end },
    { 190, function(p7) -- Line: 23
            shared.vfx.emit(p7["Megumin MVP"].Slam);
        end }
};