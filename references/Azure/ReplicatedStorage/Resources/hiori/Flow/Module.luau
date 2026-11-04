 
 

return {
    { 12, function(p1, p2, p3, p4) -- Line: 3
            shared.vfx.emit(p1:FindFirstChild("Kick2"));
        end },
    { 15, function(p5, p6, p7, p8) -- Line: 8
            shared.vfx.emit(p5.Step);
        end },
    { 36, function(p9, p10, p11, p12) -- Line: 13
            shared.vfx.emit(p9.Step5);
        end },
    { 73, function(p13, p14, p15, p16) -- Line: 18
            shared.vfx.emit(p13.Step3, p13.Step2);
        end },
    { 108, function(p17, p18, p19, p20) -- Line: 23
            shared.vfx.emit(p17.Kick);
        end },
    { 124, function(p21, p22, p23, p24) -- Line: 28
            shared.vfx.emit(p21.Step4);
        end },
    { 150, function(p25, p26, p27, p28) -- Line: 33
            if p27 then
                shared.vfx.emit(p27, p26.Head.Eyes, p25.ScreenEffect);
            end;
        end },
    { 241, function(p29, p30, p31, p32) -- Line: 40
            shared.vfx.emit(p29.Land);
        end },
    { 329, function(p33, p34, p35, p36) -- Line: 45
            shared.vfx.emit(p33.ScreenEffect2);
        end },
    { 351, function(p37, p38, p39, p40) -- Line: 50
            shared.vfx.emit(p37.SnowImpact, p40.Atmosphere);
        end },
    { 534, function(p41, p42, p43, p44) -- Line: 55
            shared.vfx.emit(p41.ScreenEffect);
        end },
    { 577, function(p45, p46, p47, p48) -- Line: 60
            shared.vfx.emit(p46.Head.Attachment, p46.Head.Eyes);
        end }
};