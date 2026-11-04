 
 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.Winds);
        end },
    { 13, function(p3, p4) -- Line: 8
            shared.vfx.emit(p4.smth);
        end },
    { 90, function(p5, p6) -- Line: 13
            shared.vfx.emit(p6.FakeheadV);
            shared.vfx.emit(p5.smth.ColorBeam);
        end },
    { 114, function(p7, p8) -- Line: 19
            shared.vfx.emit(p8.Step1);
        end },
    { 151, function(p9, p10) -- Line: 24
            shared.vfx.emit(p10.Step2);
        end },
    { 240, function(p11, p12) -- Line: 29
            shared.vfx.emit(p12.Grab);
        end },
    { 290, function(p13, p14) -- Line: 34
            shared.vfx.emit(p14.Header);
            shared.vfx.emit(p13:FindFirstChild("Impact612"), p13.Impact);
        end },
    { 428, function(p15, p16) -- Line: 40
            shared.vfx.emit(p16.Aura);
            shared.vfx.emit(p16.FakeheadP);
            shared.vfx.emit(p15.smth.ColorBeam2);
        end }
};