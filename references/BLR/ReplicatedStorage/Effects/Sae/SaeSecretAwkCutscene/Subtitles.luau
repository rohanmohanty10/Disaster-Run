  

local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 182, 220)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 90, 170)) });
local ColorSequence_new_ret2 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) });
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);
local u1 = {
    Enabled = true,
    Intensity = 4,
    Lifetime = 2
};

return function(p2) -- Line: 23
    -- upvalues: ColorSequence_new_ret2 (copy), Color3_fromRGB_ret (copy), u1 (copy), ColorSequence_new_ret (copy)
    return {
        {
            Timestamp = "8:00",
            Duration = 2,
            Speaker = p2,
            Dialogue = {
                {
                    Text = "It\'s a ",
                    Bold = false,
                    Italic = false,
                    TextSize = 25,
                    TypeSpeed = 0.08,
                    Color = ColorSequence_new_ret2,
                    TextStrokeColor = Color3_fromRGB_ret,
                    Shake = u1
                },
                {
                    Text = "one-shot",
                    Bold = true,
                    Italic = false,
                    TextSize = 25,
                    TypeSpeed = 0.1,
                    Color = ColorSequence_new_ret,
                    TextStrokeColor = Color3_fromRGB_ret,
                    Shake = u1
                },
                {
                    Text = " match",
                    Bold = false,
                    Italic = false,
                    TextSize = 25,
                    TypeSpeed = 0.08,
                    Color = ColorSequence_new_ret2,
                    TextStrokeColor = Color3_fromRGB_ret,
                    Shake = u1
                }
            }
        }
    };
end;