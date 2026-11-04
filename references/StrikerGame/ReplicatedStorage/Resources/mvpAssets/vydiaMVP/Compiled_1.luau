 
 

return {
    { 20, function(p1) -- Line: 5
            p1({
                {
                    Text = "You need to just let this happen.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 1
                    }
                }
            }, 2, "Orange", true);
        end },
    { 130, function(p2) -- Line: 34
            p2({
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.05,
                    Text = ("Besides even %s couldn\'t stop me"):format("Freddy"),
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 1
                    }
                }
            }, 2, "Orange", true);
        end },
    { 330, function(p3) -- Line: 63
            p3({
                {
                    Text = "What chance do you have!",
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
            }, 2, "Orange", true);
        end },
    { 550, function(p4) -- Line: 93
            p4({
                {
                    Text = "He has ME!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 1
                    }
                }
            }, 2, "Viltrum");
        end }
};