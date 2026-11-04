 
 

return {
    { 0, function(p1, p2, p3, p4) -- Line: 3
            shared.vfx.emit(p2.Primary.BallSpin);
        end },
    { 30, function(p5, p6, p7, p8) -- Line: 8
            shared.vfx.emit(p5.Impact);
        end },
    { 31, function(p9, p10, p11, p12) -- Line: 13
            shared.vfx.emit(p9.ImpactEmit);
        end },
    { 34, function(p13, p14, p15, p16) -- Line: 18
            shared.vfx.emit(p13.BounceLetters);
        end },
    { 60, function(p17, p18, p19, p20) -- Line: 23
            shared.vfx.emit(p17.Impact2);
        end },
    { 94, function(p21, p22, p23, p24) -- Line: 28
            shared.vfx.emit(p21.Impact3);
        end },
    { 103, function(p25, p26, p27, p28) -- Line: 33
            shared.vfx.emit(p28.SonicLines);
        end },
    { 111, function(p29, p30, p31, p32) -- Line: 38
            shared.vfx.emit(p29.Tp1);
        end },
    { 211, function(p33, p34, p35, p36) -- Line: 43
            shared.vfx.emit(p33.wind3);
        end },
    { 230, function(p37, p38, p39, p40) -- Line: 48
            shared.vfx.emit(p37.SonicBreakdanceMesh);
        end },
    { 332, function(p41, p42, p43, p44) -- Line: 53
            shared.vfx.emit(p41.Mesh2);
        end },
    { 345, function(p45, p46, p47, p48) -- Line: 58
            if p47 then
                shared.vfx.emit(p47.CamPart.CamBeam);
            end;
        end },
    { 346, function(p49, p50, p51, p52) -- Line: 65
            shared.vfx.emit(p49.DiamondAppear);
        end },
    { 347, function(p53, p54, p55, p56) -- Line: 70
            shared.vfx.emit(p53.LastSmoke);
        end },
    { 348, function(p57, p58, p59, p60) -- Line: 75
            shared.vfx.emit(p57.Wave);
        end },
    { 349, function(p61, p62, p63, p64) -- Line: 80
            shared.vfx.emit(p61.Star);
        end }
};