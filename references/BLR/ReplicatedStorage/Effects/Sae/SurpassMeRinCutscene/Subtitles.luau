  

local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 80, 170)) });
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);
local u1 = {
    Enabled = false,
    Intensity = 1,
    Lifetime = 0.5
};
local u2 = {
    Enabled = true,
    Intensity = 3,
    Lifetime = 3
};

return function(p3) -- Line: 19
    -- upvalues: ColorSequence_new_ret (copy), Color3_fromRGB_ret (copy), u1 (copy), u2 (copy)
    return {
        {
            Timestamp = "5:00",
            Duration = 2.95,
            Speaker = p3,
            Dialogue = {
                {
                    Text = "If you keep acting like my little brother...",
                    Bold = false,
                    Italic = false,
                    TextSize = 25,
                    TypeSpeed = 0.06,
                    Color = ColorSequence_new_ret,
                    TextStrokeColor = Color3_fromRGB_ret,
                    Shake = u1
                }
            }
        },
        {
            Timestamp = "12:30",
            Duration = 4,
            Speaker = p3,
            Dialogue = {
                {
                    Text = "...you will never surpass me.",
                    Bold = false,
                    Italic = false,
                    TextSize = 25,
                    TypeSpeed = 0.06,
                    Color = ColorSequence_new_ret,
                    TextStrokeColor = Color3_fromRGB_ret,
                    Shake = u2
                }
            }
        }
    };
end;