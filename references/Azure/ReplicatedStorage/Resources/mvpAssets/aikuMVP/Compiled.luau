 
 

return {
    { 0, function(p1) -- Line: 5
            shared.vfx.emit(p1.aaaaa);
            shared.vfx.emit(p1.CamVFX.d);
            shared.vfx.emit(p1.CamVFX.smth.ColorBeam1);
            shared.vfx.emit(p1.CamVFX.glow);
            shared.vfx.emit(p1.Cool2);
        end },
    { 114, function(p2, p3) -- Line: 16
            p3(1);
            p2.Room.Transparency = 0;
            shared.vfx.emit(p2.FakeheadV.Sigh);
        end },
    { 190, function(p4, p5, p6) -- Line: 25
            p4.Room.Transparency = 1;
            p5(0);
            p6({
                {
                    Text = "Nice goal!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 1
                    }
                }
            }, 1);
        end },
    { 271, function(p7) -- Line: 57
            shared.vfx.emit(p7.FakeheadV.idk);
        end },
    { 385, function(p8, p9, p10) -- Line: 64
            p10({
                {
                    Text = "We won.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 1
                    }
                }
            }, 3);
        end },
    { 475, function(p11) -- Line: 93
            shared.vfx.emit(p11.FakeheadV.Sigh);
        end },
    { 500, function(p12, p13, p14) -- Line: 100
            p14({
                {
                    Text = "Congratulations.. SOCCER GAME!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 1
                    }
                }
            }, 3);
        end },
    { 736, function(p15) -- Line: 129
            shared.vfx.emit(p15.II);
            shared.vfx.emit(p15.CamVFX.Liness);
            shared.vfx.emit(p15.AikuAura);
            shared.vfx.emit(p15.IsagiAura);
            shared.vfx.emit(p15.CamVFX.smth.ColorBeam3);
        end },
    { 805, function(p16) -- Line: 140
            shared.vfx.emit(p16.CamVFX.glow2);
            shared.vfx.emit(p16.Cool);
            shared.vfx.emit(p16.CamVFX.smth.ColorBeam2);
            shared.vfx.emit(p16.aaaaa2);
        end }
};