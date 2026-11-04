 

 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.FullShot.Spin);
        end },
    { 5, function(p2) -- Line: 8
            shared.vfx.emit(p2.FullShot.Tap);
        end },
    { 33, function(p3) -- Line: 13
            shared.vfx.emit(p3.FullShot.Tap1);
        end },
    { 52, function(p4) -- Line: 18
            shared.vfx.emit(p4.FullShot.Tap2);
        end },
    { 76, function(p5) -- Line: 23
            shared.vfx.emit(p5.FullShot.Tap3);
        end },
    { 106, function(p6) -- Line: 28
            shared.vfx.emit(p6.FullShot.Tap4);
        end },
    { 130, function(p7) -- Line: 33
            shared.vfx.emit(p7.FullShot.Boom);
        end }
};