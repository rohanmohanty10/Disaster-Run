 
 

return {
    { 2, function(p1, p2) -- Line: 3
            shared.vfx.emit(p2.HumanoidRootPart.Jump);
        end },
    { 54, function(p3, p4, p5, p6) -- Line: 8
            shared.vfx.emit(p6.Cut3.Attachment);
        end },
    { 195, function(p7, p8, p9, p10) -- Line: 13
            shared.vfx.emit(p8.HumanoidRootPart.Tap1);
            shared.vfx.emit(p9.Ball.Fast);
            shared.vfx.emit(p10.Blast2);
        end },
    { 200, function(p11, p12) -- Line: 20
            shared.vfx.emit(p12.HumanoidRootPart.Tap2);
        end },
    { 217, function(p13, p14, p15, p16) -- Line: 25
            shared.vfx.emit(p14.Torso.Aura);
            shared.vfx.emit(p15.Ball.Attachment);
            shared.vfx.emit(p16.Cut3.Attachment);
            shared.vfx.emit(p16.Cut4.Attachment["Erica Water Wave Blur 8x8"]);
            shared.vfx.emit(p14.Head);
            shared.vfx.emit(p16.Blast3);
        end },
    { 482, function(p17, p18) -- Line: 35
            shared.vfx.emit(p17.nagirouletteambience);
        end },
    { 611, function(p19, p20, p21, p22) -- Line: 40
            shared.vfx.emit(p20.Head);
            shared.vfx.emit(p22.Blast2);
        end },
    { 707, function(p23, p24, p25, p26) -- Line: 46
            shared.vfx.emit(p24.HumanoidRootPart.Tap3);
            shared.vfx.emit(p25.Ball.Fast);
            shared.vfx.emit(p26.Blast);
        end },
    { 719, function(p27, p28, p29) -- Line: 53
            shared.vfx.emit(p29.Ball.Attachment);
            shared.vfx.emit(p29.Ball.Lift2);
            shared.vfx.emit(p28.Torso.Aura2);
        end },
    { 952, function(p30, p31, p32, p33) -- Line: 60
            shared.vfx.emit(p31.HumanoidRootPart.Shot);
            shared.vfx.emit(p32.Ball.Lift2, p32.Ball.Fast);
            shared.vfx.emit(p33.Blast);
        end }
};