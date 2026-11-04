 

 

return {
    { 0, function(p1, p2, p3, p4, p5, p6) -- Line: 3
            shared.vfx.emit(p1.realfirst);
        end },
    { 36, function(p7, p8, p9, p10, p11, p12) -- Line: 8
            shared.vfx.emit(p7.first);
        end },
    { 76, function(p13, p14, p15, p16, p17, p18) -- Line: 13
            shared.vfx.emit(p13.charge);
        end },
    { 160, function(p19, p20, p21, p22, p23, p24) -- Line: 18
            shared.vfx.emit(p19.powerup);
        end },
    { 161, function(p25, p26, p27, p28, p29, p30) -- Line: 23
            shared.vfx.emit(p30["Left Arm"].aura1, p30["Left Arm"].aura2, p30["Left Arm"].aura3, p30["Left Arm"].aura4, p30["Left Arm"].aura5, p30["Right Arm"].aura1, p30["Right Arm"].aura2, p30["Right Arm"].aura3, p30["Right Arm"].aura4, p30["Right Arm"].aura5, p29["Left Arm"].aura1, p29["Left Arm"].aura2, p29["Left Arm"].aura3, p29["Left Arm"].aura4, p29["Left Arm"].aura5, p29["Right Arm"].aura1, p29["Right Arm"].aura2, p29["Right Arm"].aura3, p29["Right Arm"].aura4, p29["Right Arm"].aura5, p30["Right Arm"].heiance2, p30["Left Arm"].heiance1);
        end },
    { 204, function(p31, p32, p33, p34, p35, p36) -- Line: 28
            shared.vfx.emit(p33["yuta katana"], p33["Left Arm"].ytce, p31.windup);
        end },
    { 297, function(p37, p38, p39, p40, p41, p42) -- Line: 33
            shared.vfx.emit(p37.run);
        end },
    { 336, function(p43, p44, p45, p46, p47, p48) -- Line: 38
            shared.vfx.emit(p46["Left Arm"].ce2, p46["Right Arm"].ce1);
        end },
    { 416, function(p49, p50, p51, p52, p53, p54) -- Line: 43
            shared.vfx.emit(p49.stomptodo);
        end },
    { 419, function(p55, p56, p57, p58, p59, p60) -- Line: 48
            shared.vfx.emit(p55.yutajump);
        end },
    { 449, function(p61, p62, p63, p64, p65, p66) -- Line: 53
            shared.vfx.emit(p62.Camera.ry, p63["yuta katana"]);
        end },
    { 523, function(p67, p68, p69, p70, p71, p72) -- Line: 58
            shared.vfx.emit(p67.powerup);
        end }
};