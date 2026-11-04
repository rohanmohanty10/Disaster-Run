 

 

return {
    { 55, function(p1) -- Line: 5
            p1({
                {
                    Text = "HUH?!",
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
    { 309, function(p2) -- Line: 34
            p2({
                {
                    Text = "That\'s...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 1);
        end },
    { 1200, function(p3) -- Line: 63
            p3({
                {
                    Text = "The Night Raiders!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 1);
        end }
};