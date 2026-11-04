 
 

return {
    { 48, function(p1, p2, p3, p4) -- Line: 3
            shared.vfx.emit(p4.Head["1"], p4.Head["0"]);
        end },
    { 49, function(p5, p6, p7, p8) -- Line: 8
            if p7 then
                shared.vfx.emit(p7.camera.CamVFX.CameraShotIntensity);
            end;
        end },
    { 50, function(p9, p10, p11, p12) -- Line: 15
            shared.vfx.emit(p10.ScreenEffect);
        end },
    { 64, function(p13, p14, p15, p16) -- Line: 20
            shared.vfx.emit(p16.Head["0"], p16.Head["1"]);
        end },
    { 264, function(p17, p18, p19, p20) -- Line: 25
            shared.vfx.emit(p18.ScreenEffect3);
        end },
    { 265, function(p21, p22, p23, p24) -- Line: 30
            if p23 then
                shared.vfx.emit(p23.camera.CamVFX.CameraShotIntensity2);
            end;
        end },
    { 273, function(p25, p26, p27, p28) -- Line: 37
            shared.vfx.emit(p28.Head.Burst);
        end },
    { 298, function(p29, p30, p31, p32) -- Line: 42
            shared.vfx.emit(p32.Head.Burst);
        end },
    { 316, function(p33, p34, p35, p36) -- Line: 47
            shared.vfx.emit(p36.Head.Burst);
        end },
    { 342, function(p37, p38, p39, p40) -- Line: 52
            shared.vfx.emit(p40.Head.Burst);
        end },
    { 403, function(p41, p42, p43, p44) -- Line: 57
            shared.vfx.emit(p41);
        end },
    { 404, function(p45, p46, p47, p48) -- Line: 62
            if p47 then
                shared.vfx.emit(p47.camera.CamVFX.CameraLines2, p47.camera.CamVFX.CameraLines);
            end;
        end },
    { 405, function(p49, p50, p51, p52) -- Line: 69
            if p51 then
                shared.vfx.emit(p51.camera.CamVFX.CameraWind.ParticleEmitter);
            end;
        end },
    { 406, function(p53, p54, p55, p56) -- Line: 76
            shared.vfx.emit(p56.HumanoidRootPart.Attachment);

            if p55 then
                shared.vfx.emit(p55.camera.cam1glaredlight2.Flare321New);
            end;
        end },
    { 466, function(p57, p58, p59, p60) -- Line: 84
            shared.vfx.emit(p58.ScreenEffect5);
        end },
    { 467, function(p61, p62, p63, p64) -- Line: 89
            shared.vfx.emit(p62.ScreenEffect4);
        end },
    { 468, function(p65, p66, p67, p68) -- Line: 94
            shared.vfx.emit(p68.Head["1"], p68.Head["0"]);
        end },
    { 586, function(p69, p70, p71, p72) -- Line: 99
            shared.vfx.emit(p72["Right Arm"].Attachment2);
        end },
    { 587, function(p73, p74, p75, p76) -- Line: 104
            shared.vfx.emit(p74.Burst);
        end },
    { 647, function(p77, p78, p79, p80) -- Line: 109
            shared.vfx.emit(p78.Burst);
        end },
    { 648, function(p81, p82, p83, p84) -- Line: 114
            shared.vfx.emit(p82.ScreenEffect2);
        end },
    { 649, function(p85, p86, p87, p88) -- Line: 119
            shared.vfx.emit(p86.Atmosphere);
        end },
    { 650, function(p89, p90, p91, p92) -- Line: 124
            shared.vfx.emit(p89);
        end },
    { 651, function(p93, p94, p95, p96) -- Line: 129
            shared.vfx.emit(p96.Torso.TingleAura6, p96.Torso.TingleAura5, p96.Torso.TingleAura4, p96.Torso.TingleAura3, p96.Torso.TingleAura2, p96.Torso.TingleAura1, p96.Torso.Aura5, p96.Torso.Aura4, p96.Torso.Aura3, p96.Torso.Aura2, p96.Torso.Aura1, p96["Right Leg"].Aura1, p96["Right Leg"].Aura2, p96["Right Leg"].Aura3, p96["Right Leg"].Aura4, p96["Right Leg"].Aura5, p96["Right Leg"].TingleAura1, p96["Right Leg"].TingleAura2, p96["Right Leg"].TingleAura3, p96["Right Leg"].TingleAura4, p96["Right Leg"].TingleAura5, p96["Right Leg"].TingleAura6, p96["Right Arm"].Aura1, p96["Right Arm"].Aura2, p96["Right Arm"].Aura3, p96["Right Arm"].Aura4, p96["Right Arm"].Aura5, p96["Right Arm"].TingleAura1, p96["Right Arm"].TingleAura2, p96["Right Arm"].TingleAura3, p96["Right Arm"].TingleAura4, p96["Right Arm"].TingleAura5, p96["Right Arm"].TingleAura6, p96["Left Leg"].Aura1, p96["Left Leg"].Aura2, p96["Left Leg"].Aura3, p96["Left Leg"].Aura4, p96["Left Leg"].Aura5, p96["Left Leg"].TingleAura1, p96["Left Leg"].TingleAura2, p96["Left Leg"].TingleAura3, p96["Left Leg"].TingleAura4, p96["Left Leg"].TingleAura5, p96["Left Leg"].TingleAura6, p96["Left Arm"].Aura1, p96["Left Arm"].Aura2, p96["Left Arm"].Aura3, p96["Left Arm"].Aura4, p96["Left Arm"].Aura5, p96["Left Arm"].TingleAura1, p96["Left Arm"].TingleAura2, p96["Left Arm"].TingleAura3, p96["Left Arm"].TingleAura4, p96["Left Arm"].TingleAura5, p96["Left Arm"].TingleAura6, p96.Head.Aura1, p96.Head.Aura2, p96.Head.Aura3, p96.Head.Aura4, p96.Head.Aura5, p96.Head.TingleAura1, p96.Head.TingleAura2, p96.Head.TingleAura3, p96.Head.TingleAura4, p96.Head.TingleAura5, p96.Head.TingleAura6);
        end },
    { 652, function(p97, p98, p99, p100) -- Line: 134
            shared.vfx.emit(p100.Torso.Wings);
        end },
    { 654, function(p101, p102, p103, p104) -- Line: 139
            shared.vfx.emit(p104.Torso.FX);
        end },
    { 655, function(p105, p106, p107, p108) -- Line: 144
            if p107 then
                shared.vfx.emit(p107.camera.CamVFX.ShidouCameraShot.Attachment);
                shared.vfx.emit(p107.camera.cam1glaredlight2.Flare321New);
            end;
        end }
};