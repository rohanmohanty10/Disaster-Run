 

 

return {
    { 117, function(p1) -- Line: 5
            shared.vfx.emit(p1[1].EyeFlash);
            shared.vfx.emit(p1[3].Head.Eye);
            shared.vfx.emit(p1[2].smth.ColorBeams);
            shared.vfx.emit(p1[2].Impac, p1[2].Impact);
            shared.vfx.emit(p1[3].Head.Eyes);
        end },
    { 167, function(p2) -- Line: 16
            shared.vfx.emit(p2[3].Head.LightningCharge, p2[1].ConqHaki);
            shared.vfx.emit(p2[1].Lightings);
            shared.vfx.emit(p2[2]["A lot"].Attachment);
            shared.vfx.emit(p2[2].CamLines);
            shared.vfx.emit(p2[3].HumanoidRootPart.grounddetails);
            shared.vfx.emit(p2[2]["A lot"].CameraWind);
        end },
    { 291, function(p3) -- Line: 29
            shared.vfx.emit(p3[2].smth.ColorBeams1);
            shared.vfx.emit(p3[1].Lightings2);
        end },
    { 477, function(p4) -- Line: 37
            shared.vfx.emit(p4[3].Head.LightningVFX);
            shared.vfx.emit(p4[1].EyeLightning);
        end },
    { 567, function(p5) -- Line: 45
            shared.vfx.emit(p5[2].smth.ColorBeams2);
        end },
    { 752, function(p6) -- Line: 52
            shared.vfx.emit(p6[4].Sigh);
        end },
    { 896, function(p7, p8) -- Line: 60
            p8({
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.04,
                    Text = ("Your name\'s %s right?"):format(p7[5].Name),
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 7,
                        Lifetime = 1
                    }
                }
            }, 3);
        end },
    { 1043, function(p9, p10) -- Line: 90
            p10({
                {
                    Text = "Prepare to be ",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.07,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 7,
                        Lifetime = 1
                    }
                },
                {
                    Text = "DEVOURED!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.07,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1
                    }
                }
            }, 2);
        end }
};