 
 

return {
    { 30, function(p1, p2, p3, p4) -- Line: 3
            shared.vfx.emit(p2.Head.MainBurst, p4.MeshesBK);
        end },
    { 66, function(p5, p6, p7, p8, p9) -- Line: 8
            shared.vfx.emit(p9);
        end },
    { 151, function(p10, p11, p12, p13) -- Line: 13
            shared.vfx.emit(p13["bAROU Idk"], p12.Head.lefteye, p12.Head.righteye, p13.camEffectAwk);
        end },
    { 297, function(p14, p15, p16, p17) -- Line: 18
            shared.vfx.emit(p17.camEffectAwk);
        end },
    { 338, function(p18, p19, p20, p21) -- Line: 23
            shared.vfx.emit(p21.Thing);
        end },
    { 379, function(p22, p23, p24, p25) -- Line: 28
            shared.vfx.emit(p25.Slam);
        end },
    { 410, function(p26, p27, p28, p29) -- Line: 33
            shared.vfx.emit(p29.wind0);
        end },
    { 422, function(p30, p31, p32, p33) -- Line: 38
            shared.vfx.emit(p30.Ball.Attachment);
        end },
    { 488, function(p34, p35, p36, p37) -- Line: 43
            shared.vfx.emit(p34.Ball.Attachment);
        end },
    { 518, function(p38, p39, p40, p41) -- Line: 48
            shared.vfx.emit(p41.Mesh6);
        end },
    { 584, function(p42, p43, p44, p45) -- Line: 53
            shared.vfx.emit(p42.Ball.oml, p42.Ball.Attachment);
        end },
    { 612, function(p46, p47, p48, p49) -- Line: 58
            shared.vfx.emit(p49.Kick);
        end }
};