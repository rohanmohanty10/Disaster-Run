  

local Color3_fromRGB_ret = Color3.fromRGB(135, 210, 255);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret2 = Color3.fromRGB(10, 10, 10);
local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3_new_ret), ColorSequenceKeypoint.new(1, Color3_fromRGB_ret) });
ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3_fromRGB_ret), ColorSequenceKeypoint.new(1, Color3_new_ret) });
local ColorSequence_new_ret2 = ColorSequence.new(Color3_new_ret);
local ColorSequence_new_ret3 = ColorSequence.new(Color3_fromRGB_ret);
local ColorSequence_new_ret4 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3_new_ret), ColorSequenceKeypoint.new(0.4, Color3_fromRGB_ret), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 235, 255)) });

return function(p1) -- Line: 21
    -- upvalues: ColorSequence_new_ret2 (copy), Color3_fromRGB_ret2 (copy), ColorSequence_new_ret (copy), ColorSequence_new_ret4 (copy), ColorSequence_new_ret3 (copy)
    return {
        {
            Timestamp = "7:00",
            Duration = 1.5,
            Speaker = p1,
            Dialogue = {
                {
                    Text = "Bring it, ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence_new_ret2,
                    TextStrokeColor = Color3_fromRGB_ret2,
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "Isagi Yoichi.",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.04,
                    Color = ColorSequence_new_ret,
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
            Timestamp = "9:00",
            Duration = 3,
            Speaker = p1,
            Dialogue = {
                {
                    Text = "I\'ll swallow up your soccer, ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.04,
                    Color = ColorSequence_new_ret2,
                    TextStrokeColor = Color3_fromRGB_ret2,
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "fire and all!",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.05,
                    Color = ColorSequence_new_ret4,
                    TextStrokeColor = Color3_fromRGB_ret2,
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1.2
                    }
                }
            }
        },
        {
            Timestamp = "14:50",
            Duration = 1.5,
            Speaker = p1,
            Dialogue = {
                {
                    Text = "You ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence_new_ret2,
                    TextStrokeColor = Color3_fromRGB_ret2,
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "can\'t beat me!",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.04,
                    Color = ColorSequence_new_ret3,
                    TextStrokeColor = Color3_fromRGB_ret2,
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 1
                    }
                }
            }
        }
    };
end;