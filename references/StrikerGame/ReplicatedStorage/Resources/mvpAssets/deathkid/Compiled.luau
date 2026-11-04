 

 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p1.right.spinnysmear);
        end },
    { 64, function(p4, p5, p6) -- Line: 8
            shared.vfx.emit(p4.left.spinnysmear);
        end },
    { 136, function(p7, p8, p9) -- Line: 13
            shared.vfx.emit(p8.cloud1);
            shared.vfx.emit(p8.moon.midnightgamer);
            shared.vfx.emit(p9.zhong);
        end },
    { 173, function(p10, p11, p12) -- Line: 19
            shared.vfx.emit(p10.right["soul eater gun"].MainGun.Attachment);
            shared.vfx.emit(p12.Attachment);
        end }
};