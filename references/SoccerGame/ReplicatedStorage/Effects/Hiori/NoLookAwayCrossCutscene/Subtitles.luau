  

local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 211, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(125, 211, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) });
local ColorSequence_new_ret2 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 60, 170)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 60, 170)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) });
local ColorSequence_new_ret3 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(214, 214, 29)), ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 214, 29)) });
local Color3_fromRGB_ret = Color3.fromRGB(8, 24, 55);
local Color3_fromRGB_ret2 = Color3.fromRGB(6, 12, 38);

return function(p1, p2) -- Line: 22
    -- upvalues: ColorSequence_new_ret2 (copy), Color3_fromRGB_ret2 (copy), ColorSequence_new_ret (copy), Color3_fromRGB_ret (copy), ColorSequence_new_ret3 (copy)
    return {
        {
            Timestamp = "0:70",
            Duration = 0.75,
            Text = "Give me the ball.",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.028,
            Speaker = p1,
            Color = ColorSequence_new_ret2,
            TextStrokeColor = Color3_fromRGB_ret2
        },
        {
            Timestamp = "2:70",
            Duration = 1.1,
            Text = "Being relentless isnt the only type of ego",
            Bold = true,
            Italic = true,
            TypeSpeed = 0.024,
            Speaker = p2,
            Color = ColorSequence_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "4:90",
            Duration = 5,
            Speaker = p1,
            Dialogue = {
                {
                    Text = "I am...",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.06,
                    Color = ColorSequence_new_ret3,
                    TextStrokeColor = Color3_fromRGB_ret2,
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = " ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 1.1,
                    Color = ColorSequence_new_ret3,
                    TextStrokeColor = Color3_fromRGB_ret2,
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "A STRIKER",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence_new_ret3,
                    TextStrokeColor = Color3_fromRGB_ret2,
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 0.3
                    }
                },
                {
                    Text = " ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.75,
                    Color = ColorSequence_new_ret3,
                    TextStrokeColor = Color3_fromRGB_ret2,
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                }
            }
        },
        {
            Timestamp = "7:00",
            Duration = 2,
            Text = "MY DIRECT SHOT",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.07,
            Speaker = p1,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(4, 12, 33)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(4, 12, 33)), ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 60, 170)) }),
            TextStrokeColor = Color3_fromRGB_ret2,
            Shake = {
                Enabled = true,
                Intensity = 10,
                Lifetime = 0.55
            }
        }
    };
end;