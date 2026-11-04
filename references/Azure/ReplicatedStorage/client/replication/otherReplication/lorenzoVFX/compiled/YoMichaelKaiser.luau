 

 

return {
    { 0, function(p1, p2, p3, p4, p5, p6) -- Line: 3
            shared.vfx.emit(p6.FX);

            for _, descendant in p5.yomichealtruee:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 151, function(p7, p8, p9, p10, p11, p12) -- Line: 14
            for _, descendant in p11.yomichealtruee:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 190, function(p13, p14, p15, p16, p17, p18) -- Line: 23
            shared.vfx.emit(p13.Torso, p13["Right Leg"], p13["Right Arm"], p13["Left Leg"], p13["Left Arm"], p13.Head);
        end },
    { 192, function(p19, p20, p21, p22, p23, p24) -- Line: 28
            shared.vfx.emit(p21.Burst);
        end },
    { 197, function(p25, p26, p27, p28, p29, p30) -- Line: 33
            shared.vfx.emit(p27.Dribble);
        end },
    { 224, function(p31, p32, p33, p34, p35, p36) -- Line: 38
            shared.vfx.emit(p33.Dribble2);
        end },
    { 225, function(p37, p38, p39, p40, p41, p42) -- Line: 43
            shared.vfx.emit(p39["Vfx Jump"]);
        end },
    { 226, function(p43, p44, p45, p46, p47, p48) -- Line: 48
            shared.vfx.emit(p45.Jump);
        end },
    { 238, function(p49, p50, p51, p52, p53, p54) -- Line: 53
            shared.vfx.emit(p51.Dust);
        end },
    { 239, function(p55, p56, p57, p58, p59, p60) -- Line: 58
            shared.vfx.emit(p57.Land2);
        end },
    { 243, function(p61, p62, p63, p64, p65, p66) -- Line: 63
            shared.vfx.emit(p63["Vfx Land"]);
        end },
    { 250, function(p67, p68, p69, p70, p71, p72) -- Line: 68
            shared.vfx.emit(p69.Land);
        end },
    { 285, function(p73, p74, p75, p76, p77, p78) -- Line: 73
            shared.vfx.emit(p75.Dust2);
        end },
    { 299, function(p79, p80, p81, p82, p83, p84) -- Line: 78
            shared.vfx.emit(p81["Effect 3"]);
        end },
    { 328, function(p85, p86, p87, p88, p89, p90) -- Line: 83
            shared.vfx.emit(p87["Ground Impact"]);
        end },
    { 329, function(p91, p92, p93, p94, p95, p96) -- Line: 88
            shared.vfx.emit(p93.Burst2);
        end },
    { 330, function(p97, p98, p99, p100, p101, p102) -- Line: 93
            shared.vfx.emit(p100.Impact);
        end },
    { 389, function(p103, p104, p105, p106, p107, p108) -- Line: 98
            shared.vfx.emit(p105["Big Dust"]);
        end },
    { 410, function(p109, p110, p111, p112, p113, p114) -- Line: 103
            shared.vfx.emit(p111["Big Dust2"]);
        end },
    { 448, function(p115, p116, p117, p118, p119, p120) -- Line: 108
            shared.vfx.emit(p117["Omg screenie"]);
        end },
    { 449, function(p121, p122, p123, p124, p125, p126) -- Line: 113
            shared.vfx.emit(p121.Torso, p121["Right Leg"], p121["Right Arm"], p121["Left Leg"], p121["Left Arm"], p121.Head);
        end },
    { 498, function(p127, p128, p129, p130, p131, p132) -- Line: 118
            shared.vfx.emit(p132.FX);
        end },
    { 499, function(p133, p134, p135, p136, p137, p138) -- Line: 123
            shared.vfx.emit(p135["Effect 3"]);
        end },
    { 500, function(p139, p140, p141, p142, p143, p144) -- Line: 128
            shared.vfx.emit(p141.Burst4);
        end },
    { 539, function(p145, p146, p147, p148, p149, p150) -- Line: 133
            shared.vfx.emit(p146.Attachment.Kick);
        end },
    { 540, function(p151, p152, p153, p154, p155, p156) -- Line: 138
            shared.vfx.emit(p153["Omg screenie3"]);
        end },
    { 544, function(p157, p158, p159, p160, p161, p162) -- Line: 143
            shared.vfx.emit(p159.Burst3);
        end },
    { 563, function(p163, p164, p165, p166, p167, p168) -- Line: 148
            shared.vfx.emit(p165.ScreenEffect);
        end },
    { 564, function(p169, p170, p171, p172, p173, p174) -- Line: 153
            shared.vfx.emit(p170.Attachment);
        end },
    { 565, function(p175, p176, p177, p178, p179, p180) -- Line: 158
            shared.vfx.emit(p177["Effect 3"]);
        end },
    { 670, function(p181, p182, p183, p184, p185, p186) -- Line: 163
            shared.vfx.emit(p183["Omg screenie3"]);
        end }
};