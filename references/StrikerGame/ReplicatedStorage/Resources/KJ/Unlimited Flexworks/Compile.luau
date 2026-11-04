 
 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p1.StartBeams);
        end },
    { 92, function(p4, p5, p6) -- Line: 8
            shared.vfx.emit(p4.Stomp);
        end },
    { 209, function(p7, p8, p9) -- Line: 13
            shared.vfx.emit(p7.BallPoseBeams);
        end },
    { 316, function(p10, p11, p12) -- Line: 18
            shared.vfx.emit(p12.Blur);
        end },
    { 354, function(p13, p14, p15, p16) -- Line: 23
            shared.vfx.emit(p16);
        end },
    { 439, function(p17, p18, p19) -- Line: 28
            shared.vfx.emit(p18.Head.EyeGlow);
        end },
    { 485, function(p20, p21, p22) -- Line: 33
            local ClapEffect = p20.ClapEffect;
            ClapEffect.Parent = workspace.Effects;
            shared.vfx.emit(ClapEffect);
            task.delay(5, function() -- Line: 37
                -- upvalues: ClapEffect (copy)
                pcall(game.Destroy, ClapEffect);
            end);
            shared.vfx.emit(p20.ClapRoom);
        end },
    { 573, function(p23, p24, p25) -- Line: 44
            shared.vfx.emit(p23.DanceRoom);
        end },
    { 677, function(p26, p27, p28) -- Line: 49
            shared.vfx.emit(p26.DanceClapRoom);
        end },
    { 758, function(p29, p30, p31) -- Line: 54
            shared.vfx.emit(p29.Step2);
        end },
    { 777, function(p32, p33, p34) -- Line: 59
            shared.vfx.emit(p32.Step1);
        end },
    { 941, function(p35, p36, p37) -- Line: 64
            shared.vfx.emit(p35.KickRoom, p35.PreKickSpeed);
        end },
    { 991, function(p38, p39, p40) -- Line: 69
            shared.vfx.emit(p38.Kick1);
        end },
    { 1119, function(p41, p42, p43) -- Line: 74
            shared.vfx.emit(p41.BallStar);
        end },
    { 1156, function(p44, p45, p46) -- Line: 79
            shared.vfx.emit(p44.BallTeleportPre);
        end },
    { 1161, function(p47, p48, p49) -- Line: 84
            shared.vfx.emit(p47.BallTeleport1);
        end },
    { 1279, function(p50, p51, p52) -- Line: 89
            shared.vfx.emit(p50.StarDash);
        end },
    { 1410, function(p53, p54, p55) -- Line: 94
            shared.vfx.emit(p53.BallShapes);
        end },
    { 1641, function(p56, p57, p58) -- Line: 99
            shared.vfx.emit(p56.SpaceExplosion);
        end },
    { 1718, function(p59, p60, p61) -- Line: 104
            shared.vfx.emit(p59.EndScene);
        end }
};