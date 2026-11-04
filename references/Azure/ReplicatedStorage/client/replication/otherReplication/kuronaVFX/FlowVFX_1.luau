 
 

return {
    { 0, function(p1, p2, p3, p4, p5) -- Line: 3
            for _, descendant in ipairs(p3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 1, function(p6, p7, p8, p9, p10) -- Line: 13
            for _, descendant in ipairs(p9.Lines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 2, function(p11, p12, p13, p14, p15) -- Line: 23
            for _, descendant in ipairs(p11:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "Aura" then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 6, function(p16, p17, p18, p19, p20) -- Line: 33
            for _, descendant in ipairs(p17.Steps.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 7, function(p21, p22, p23, p24, p25) -- Line: 43
            for _, descendant in ipairs(p25.HumanoidRootPart.Steps.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 47, function(p26, p27, p28, p29, p30) -- Line: 53
            for _, descendant in ipairs(p27.Steps.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 48, function(p31, p32, p33, p34, p35) -- Line: 63
            for _, descendant in ipairs(p35.HumanoidRootPart.Steps.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 131, function(p36, p37, p38, p39, p40) -- Line: 73
            for _, descendant in ipairs(p37.Steps.Three:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 132, function(p41, p42, p43, p44, p45) -- Line: 83
            for _, descendant in ipairs(p45.HumanoidRootPart.Steps.Three:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 155, function(p46, p47, p48, p49, p50) -- Line: 93
            for _, descendant in ipairs(p47.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 157, function(p51, p52, p53, p54, p55) -- Line: 103
            for _, descendant in ipairs(p54.Lines:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 166, function(p56, p57, p58, p59, p60) -- Line: 113
            for _, descendant in ipairs(p58:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 170, function(p61, p62, p63, p64, p65) -- Line: 123
            for _, descendant in ipairs(p65.HumanoidRootPart.Two:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 189, function(p66, p67, p68, p69, p70) -- Line: 133
            for _, descendant in ipairs(p69.One:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 205, function(p71, p72, p73, p74, p75) -- Line: 143
            for _, descendant in ipairs(p74.Lines2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 218, function(p76, p77, p78, p79, p80) -- Line: 153
            for _, descendant in ipairs(p77.Three:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 219, function(p81, p82, p83, p84, p85) -- Line: 163
            for _, descendant in ipairs(p85.Torso.Slide:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 228, function(p86, p87, p88, p89, p90) -- Line: 173
            for _, descendant in ipairs(p89.Lines2.Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 236, function(p91, p92, p93, p94, p95) -- Line: 183
            for _, descendant in ipairs(p95.HumanoidRootPart.Four:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 241, function(p96, p97, p98, p99, p100) -- Line: 193
            for _, descendant in ipairs(p100.Torso.Slide:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 289, function(p101, p102, p103, p104, p105) -- Line: 203
            for _, descendant in ipairs(p105.HumanoidRootPart.Five:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 305, function(p106, p107, p108, p109, p110) -- Line: 213
            for _, descendant in ipairs(p106.Torso:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name ~= "Aura" then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 312, function(p111, p112, p113, p114, p115) -- Line: 223
            for _, descendant in ipairs(p114.Lines2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 339, function(p116, p117, p118, p119, p120) -- Line: 233
            for _, descendant in ipairs(p116.Torso:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name ~= "Aura" then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 342, function(p121, p122, p123, p124, p125) -- Line: 243
            for _, descendant in ipairs(p122.Steps.Four:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 374, function(p126, p127, p128, p129, p130) -- Line: 253
            for _, descendant in ipairs(p127.Six:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 393, function(p131, p132, p133, p134, p135) -- Line: 263
            for _, descendant in ipairs(p132.Steps.Four:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 415, function(p136, p137, p138, p139, p140) -- Line: 273
            for _, descendant in ipairs(p136.Torso:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name ~= "Aura" then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 440, function(p141, p142, p143, p144, p145) -- Line: 283
            for _, descendant in ipairs(p141.Torso:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name ~= "Aura" then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 459, function(p146, p147, p148, p149, p150) -- Line: 293
            for _, descendant in ipairs(p147.Seven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 480, function(p151, p152, p153, p154, p155) -- Line: 303
            for _, descendant in ipairs(p151.Torso:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name ~= "Aura" then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 507, function(p156, p157, p158, p159, p160) -- Line: 313
            for _, descendant in ipairs(p157.Circle:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 566, function(p161, p162, p163, p164, p165) -- Line: 323
            for _, descendant in ipairs(p162.Circle:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 568, function(p166, p167, p168, p169, p170) -- Line: 333
            for _, descendant in ipairs(p167.Blitz:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 570, function(p171, p172, p173, p174, p175) -- Line: 343
            for _, descendant in ipairs(p172.Eight:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 573, function(p176, p177, p178, p179, p180) -- Line: 353
            for _, descendant in ipairs(p177.Nine:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 575, function(p181, p182, p183, p184, p185) -- Line: 363
            for _, descendant in ipairs(p182.Ten:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 576, function(p186, p187, p188, p189, p190) -- Line: 373
            for _, descendant in ipairs(p187.Eleven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 577, function(p191, p192, p193, p194, p195) -- Line: 383
            for _, descendant in ipairs(p192.Ten:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 580, function(p196, p197, p198, p199, p200) -- Line: 393
            for _, descendant in ipairs(p197.Nine:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 584, function(p201, p202, p203, p204, p205) -- Line: 403
            for _, descendant in ipairs(p202.Twelve:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 587, function(p206, p207, p208, p209, p210) -- Line: 413
            for _, descendant in ipairs(p207.Twelve:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 588, function(p211, p212, p213, p214, p215) -- Line: 423
            for _, descendant in ipairs(p212.Thirteen:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 589, function(p216, p217, p218, p219, p220) -- Line: 433
            for _, descendant in ipairs(p217.Eleven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 594, function(p221, p222, p223, p224, p225) -- Line: 443
            for _, descendant in ipairs(p222.Eleven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 597, function(p226, p227, p228, p229, p230) -- Line: 453
            for _, descendant in ipairs(p227.Twelve:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 600, function(p231, p232, p233, p234, p235) -- Line: 463
            for _, descendant in ipairs(p232.Eleven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 602, function(p236, p237, p238, p239, p240) -- Line: 473
            for _, descendant in ipairs(p237.Nine:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 603, function(p241, p242, p243, p244, p245) -- Line: 483
            for _, descendant in ipairs(p242.Nine:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 604, function(p246, p247, p248, p249, p250) -- Line: 493
            for _, descendant in ipairs(p247.Thirteen:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 606, function(p251, p252, p253, p254, p255) -- Line: 503
            for _, descendant in ipairs(p252.Thirteen:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 609, function(p256, p257, p258, p259, p260) -- Line: 513
            for _, descendant in ipairs(p257.Ten:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 611, function(p261, p262, p263, p264, p265) -- Line: 523
            for _, descendant in ipairs(p262.Ten:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 615, function(p266, p267, p268, p269, p270) -- Line: 533
            for _, descendant in ipairs(p267.Eleven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 618, function(p271, p272, p273, p274, p275) -- Line: 543
            for _, descendant in ipairs(p272.Eight:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 622, function(p276, p277, p278, p279, p280) -- Line: 553
            for _, descendant in ipairs(p277.Thirteen:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 623, function(p281, p282, p283, p284, p285) -- Line: 563
            for _, descendant in ipairs(p282.Eleven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 625, function(p286, p287, p288, p289, p290) -- Line: 573
            for _, descendant in ipairs(p287.Nine:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 628, function(p291, p292, p293, p294, p295) -- Line: 583
            for _, descendant in ipairs(p292.Eleven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 633, function(p296, p297, p298, p299, p300) -- Line: 593
            for _, descendant in ipairs(p297.Thirteen:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 634, function(p301, p302, p303, p304, p305) -- Line: 603
            for _, descendant in ipairs(p302.Eleven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 635, function(p306, p307, p308, p309, p310) -- Line: 613
            for _, descendant in ipairs(p307.Nine:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 636, function(p311, p312, p313, p314, p315) -- Line: 623
            for _, descendant in ipairs(p312.Nine:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 637, function(p316, p317, p318, p319, p320) -- Line: 633
            for _, descendant in ipairs(p317.Nine:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 638, function(p321, p322, p323, p324, p325) -- Line: 643
            for _, descendant in ipairs(p322.Thirteen:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 640, function(p326, p327, p328, p329, p330) -- Line: 653
            for _, descendant in ipairs(p327.Thirteen:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 643, function(p331, p332, p333, p334, p335) -- Line: 663
            for _, descendant in ipairs(p332.Ten:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 644, function(p336, p337, p338, p339, p340) -- Line: 673
            for _, descendant in ipairs(p337.Eleven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 645, function(p341, p342, p343, p344, p345) -- Line: 683
            for _, descendant in ipairs(p342.Ten:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 649, function(p346, p347, p348, p349, p350) -- Line: 693
            for _, descendant in ipairs(p347.Eleven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 652, function(p351, p352, p353, p354, p355) -- Line: 703
            for _, descendant in ipairs(p352.Eight:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 653, function(p356, p357, p358, p359, p360) -- Line: 713
            for _, descendant in ipairs(p357.Eleven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 656, function(p361, p362, p363, p364, p365) -- Line: 723
            for _, descendant in ipairs(p362.Thirteen:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 662, function(p366, p367, p368, p369, p370) -- Line: 733
            for _, descendant in ipairs(p367.Eleven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 665, function(p371, p372, p373, p374, p375) -- Line: 743
            for _, descendant in ipairs(p372.Twelve:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 667, function(p376, p377, p378, p379, p380) -- Line: 753
            for _, descendant in ipairs(p377.Ten:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 668, function(p381, p382, p383, p384, p385) -- Line: 763
            for _, descendant in ipairs(p382.Eleven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 669, function(p386, p387, p388, p389, p390) -- Line: 773
            for _, descendant in ipairs(p387.Nine:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 670, function(p391, p392, p393, p394, p395) -- Line: 783
            for _, descendant in ipairs(p391.Torso:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name ~= "Aura" then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 672, function(p396, p397, p398, p399, p400) -- Line: 793
            for _, descendant in ipairs(p397.Blitz:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 690, function(p401, p402, p403, p404, p405) -- Line: 803
            for _, descendant in ipairs(p402.Steps.Five:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 698, function(p406, p407, p408, p409, p410) -- Line: 813
            for _, descendant in ipairs(p407.Steps.Six:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 711, function(p411, p412, p413, p414, p415) -- Line: 823
            for _, descendant in ipairs(p412.Steps.Seven:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 725, function(p416, p417, p418, p419, p420) -- Line: 833
            for _, descendant in ipairs(p417.Steps.Eight:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 770, function(p421, p422, p423, p424, p425) -- Line: 843
            for _, descendant in ipairs(p425.HumanoidRootPart.Fourteen:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 771, function(p426, p427, p428, p429, p430) -- Line: 853
            for _, descendant in ipairs(p426:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "Aura" then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 792, function(p431, p432, p433, p434, p435) -- Line: 863
            for _, descendant in ipairs(p432.Fifteen:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;
        end },
    { 806, function(p436, p437, p438, p439, p440) -- Line: 873
            for _, descendant in ipairs(p438:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};