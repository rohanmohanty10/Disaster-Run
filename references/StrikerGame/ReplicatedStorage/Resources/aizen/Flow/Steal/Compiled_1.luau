 
 

return {
    { 10, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p1.Ball.DribbleDust);
            shared.vfx.emit(p2.RunMesh2);
        end },
    { 24, function(p4, p5, p6) -- Line: 10
            shared.vfx.emit(p5["Right Leg"].RightStep);
        end },
    { 45, function(p7, p8, p9) -- Line: 15
            shared.vfx.emit(p8["Left Leg"].LeftStep);
        end },
    { 59, function(p10, p11, p12) -- Line: 20
            shared.vfx.emit(p11["Right Leg"].RightStep);
        end },
    { 65, function(p13, p14, p15) -- Line: 25
            shared.vfx.emit(p14.Spin);
        end },
    { 87, function(p16, p17, p18) -- Line: 30
            shared.vfx.emit(p18.Dribble);
            local Lighting = game:GetService("Lighting");
            shared.vfx.emit(Lighting.ColorCorrection);
        end },
    { 114, function(p19, p20, p21) -- Line: 41
            shared.vfx.emit(p20["Left Leg"].LeftStep);
        end },
    { 116, function(p22, p23, p24) -- Line: 46
            shared.vfx.emit(p23.RunMesh1);
        end },
    { 135, function(p25, p26, p27) -- Line: 51
            shared.vfx.emit(p26["Right Leg"].RightStep);
        end },
    { 150, function(p28, p29, p30) -- Line: 56
            shared.vfx.emit(p29["Left Leg"].LeftStep);
        end },
    { 171, function(p31, p32, p33) -- Line: 61
            shared.vfx.emit(p32["Right Leg"].RightStep);
        end },
    { 193, function(p34, p35, p36) -- Line: 66
            shared.vfx.emit(p35["Left Leg"].LeftStep);
        end },
    { 217, function(p37, p38, p39) -- Line: 71
            shared.vfx.emit(p38["Right Leg"].RightStep);
        end },
    { 224, function(p40, p41, p42) -- Line: 76
            shared.vfx.emit(p40["Right Arm"]["kyoka green"].Shine);
            local Lighting = game:GetService("Lighting");
            shared.vfx.emit(Lighting.ColorCorrectionStartup);
        end },
    { 265, function(p43, p44, p45) -- Line: 84
            shared.vfx.emit(p44.Torso.Stab);
        end },
    { 372, function(p46, p47, p48) -- Line: 89
            shared.vfx.emit(p48.Glass.GlassShards);
        end },
    { 756, function(p49, p50, p51) -- Line: 94
            shared.vfx.emit(p50.Torso.StabPullOut);
        end }
};