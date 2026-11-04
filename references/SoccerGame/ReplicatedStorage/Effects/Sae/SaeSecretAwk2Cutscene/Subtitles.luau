  

local ColorSequence_new_ret = ColorSequence.new(Color3.new(1, 1, 1));
local ColorSequence_new_ret2 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 170)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) });
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);
local u1 = {
    Enabled = false,
    Intensity = 1,
    Lifetime = 0.5
};
local u2 = {
    Enabled = true,
    Intensity = 5,
    Lifetime = 2.5
};

return function(p3) -- Line: 20
    -- upvalues: ColorSequence_new_ret (copy), Color3_fromRGB_ret (copy), u1 (copy), ColorSequence_new_ret2 (copy), u2 (copy)
    return {
        {
            Timestamp = "3:40",
            Duration = 2.5,
            Speaker = p3,
            Dialogue = {
                {
                    Text = "Still... ",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.06,
                    Color = ColorSequence_new_ret,
                    TextStrokeColor = Color3_fromRGB_ret,
                    Shake = u1
                },
                {
                    Text = "Half-Baked",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.06,
                    Color = ColorSequence_new_ret2,
                    TextStrokeColor = Color3_fromRGB_ret,
                    Shake = u2
                }
            }
        }
    };
end;