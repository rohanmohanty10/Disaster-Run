  

local Color3_fromRGB_ret = Color3.fromRGB(135, 210, 255);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret2 = Color3.fromRGB(10, 10, 10);
local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3_fromRGB_ret), ColorSequenceKeypoint.new(1, Color3_new_ret) });
local ColorSequence_new_ret2 = ColorSequence.new(Color3_new_ret);
local ColorSequence_new_ret3 = ColorSequence.new(Color3_fromRGB_ret);

return function(p1) -- Line: 12
    -- upvalues: ColorSequence_new_ret (copy), Color3_fromRGB_ret2 (copy), ColorSequence_new_ret2 (copy), ColorSequence_new_ret3 (copy)
    return {
        {
            Timestamp = "6:00",
            Duration = 2,
            Speaker = p1,
            Dialogue = {
                {
                    Text = "Huh? ",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.06,
                    Color = ColorSequence_new_ret,
                    TextStrokeColor = Color3_fromRGB_ret2,
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "I can totally get this ",
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
                    Text = "with no problem...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.04,
                    Color = ColorSequence_new_ret3,
                    TextStrokeColor = Color3_fromRGB_ret2,
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                }
            }
        }
    };
end;