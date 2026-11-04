 

 

return {
    { 3, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p1.struggl);
        end },
    { 61, function(p4, p5, p6) -- Line: 8
            shared.vfx.emit(p4.slap);
        end },
    { 102, function(p7, p8, p9) -- Line: 13
            shared.vfx.emit(p7.kick);
            shared.vfx.emit(p7.shot);
        end },
    { 131, function(p10, p11, p12) -- Line: 19
            shared.vfx.emit(p10.SpinMesh);
        end },
    { 156, function(p13, p14, p15) -- Line: 24
            shared.vfx.emit(p13.throw);
        end }
};