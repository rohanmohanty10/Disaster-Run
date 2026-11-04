  

local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);
local ColorSequence_new_ret = ColorSequence.new(Color3_new_ret);
local ColorSequence_new_ret2 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3_new_ret), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) });

return function(p1) -- Line: 9
    -- upvalues: Color3_new_ret (copy), Color3_fromRGB_ret (copy), ColorSequence_new_ret (copy), ColorSequence_new_ret2 (copy)
    return {
        {
            Timestamp = "1:00",
            Duration = 3,
            Text = "The one who needs destroying is... me",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.055,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "6:00",
            Duration = 5.5,
            Speaker = p1,
            Dialogue = {
                {
                    Text = "Stop violating my life with your easy, ",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.045,
                    Color = ColorSequence_new_ret,
                    TextStrokeColor = Color3_fromRGB_ret,
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 2
                    }
                },
                {
                    Text = "cheap values.",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.1,
                    Color = ColorSequence_new_ret2,
                    TextStrokeColor = Color3_fromRGB_ret,
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 2
                    }
                }
            }
        },
        {
            Timestamp = "17:30",
            Duration = 2,
            Speaker = p1,
            Dialogue = {
                {
                    Text = "I am... ",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.1,
                    Color = ColorSequence_new_ret,
                    TextStrokeColor = Color3_fromRGB_ret,
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 1
                    }
                },
                {
                    Text = "ME!",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.1,
                    Color = ColorSequence_new_ret2,
                    TextStrokeColor = Color3_fromRGB_ret,
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 1
                    }
                }
            }
        },
        {
            Timestamp = "21:00",
            Duration = 2.4,
            Text = "I am an egoist,",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.08,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "23:630",
            Duration = 1,
            Text = "Itoshi Rin!",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = ColorSequence_new_ret2,
            TextStrokeColor = Color3_fromRGB_ret
        }
    };
end;