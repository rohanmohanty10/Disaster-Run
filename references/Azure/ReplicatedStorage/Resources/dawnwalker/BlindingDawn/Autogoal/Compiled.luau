 

 

return {
    { 0, function(p1) -- Line: 5
            shared.vfx.emit(p1.CamVFX.Winds);
        end },
    { 84, function(p2) -- Line: 12
            shared.vfx.emit(p2.Dash1);
        end },
    { 107, function(p3) -- Line: 19
            shared.vfx.emit(p3.Dash2);
        end },
    { 168, function(p4) -- Line: 26
            shared.vfx.emit(p4.CamVFX.lines, p4.CamVFX.liness);
        end },
    { 180, function(p5) -- Line: 33
            shared.vfx.emit(p5.Parry);
        end },
    { 225, function(p6) -- Line: 40
            shared.vfx.emit(p6.SpinBeam);
            shared.vfx.emit(p6.SpinVfx);
        end },
    { 309, function(p7, p8) -- Line: 48
            shared.vfx.emit(p7.Hit);
            shared.vfx.emit(p7.KickHit);
        end },
    { 335, function(p9) -- Line: 57
            shared.vfx.emit(p9.smth3);
        end },
    { 362, function(p10) -- Line: 64
            shared.vfx.emit(p10.smth);
        end },
    { 384, function(p11) -- Line: 71
            shared.vfx.emit(p11.Feint);
            shared.vfx.emit(p11.FakeRleg);
            shared.vfx.emit(p11.Windbig);
        end },
    { 428, function(p12) -- Line: 80
            shared.vfx.emit(p12.Lines);
            shared.vfx.emit(p12.CamVFX.Impact612, p12.CamVFX:FindFirstChild("Impact612"));
        end },
    { 448, function(p13, p14) -- Line: 88
            shared.vfx.emit(p13.Kick);
        end },
    { 460, function(p15) -- Line: 96
            shared.vfx.emit(p15.smth2);
        end }
};