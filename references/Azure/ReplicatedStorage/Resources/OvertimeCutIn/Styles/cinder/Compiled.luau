 
 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.CamVFX.smth.Beam1);
            shared.vfx.emit(p1.FakeHead.Eyes1);
            shared.vfx.emit(p1.EyeLightning2, p1.EyeLightning1);
            shared.vfx.emit(p1.FakeHead.Sigh);
        end },
    { 127, function(p2) -- Line: 11
            shared.vfx.emit(p2.CamVFX.smth.ColorBeam);
            shared.vfx.emit(p2.CamVFX.lines);
            shared.vfx.emit(p2.CamVFX.Winds);
        end },
    { 133, function(p3) -- Line: 18
            shared.vfx.emit(p3.BallVfx.Hit);
        end },
    { 136, function(p4) -- Line: 23
            shared.vfx.emit(p4.Steps.Step1);
        end },
    { 147, function(p5) -- Line: 28
            shared.vfx.emit(p5.BallVfx.Hit);
        end },
    { 157, function(p6) -- Line: 33
            shared.vfx.emit(p6.Steps.Step2);
        end },
    { 167, function(p7) -- Line: 38
            shared.vfx.emit(p7.BallVfx.Hit);
        end },
    { 179, function(p8) -- Line: 43
            shared.vfx.emit(p8.Steps.Step3);
        end },
    { 189, function(p9) -- Line: 48
            shared.vfx.emit(p9.RightArmFire);
            shared.vfx.emit(p9.BallVfx.Hit);
        end },
    { 197, function(p10) -- Line: 54
            shared.vfx.emit(p10.Steps.Step4);
        end },
    { 205, function(p11) -- Line: 59
            shared.vfx.emit(p11.BallVfx.Hit);
        end },
    { 216, function(p12) -- Line: 64
            shared.vfx.emit(p12.Steps.Step5);
        end },
    { 227, function(p13) -- Line: 69
            shared.vfx.emit(p13.BallVfx.Hit);
        end },
    { 234, function(p14) -- Line: 74
            shared.vfx.emit(p14.Steps.Step6);
        end }
};