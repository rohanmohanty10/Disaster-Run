  

local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(225, 30, 30));
local Color3_fromRGB_ret = Color3.fromRGB(35, 5, 5);

return function(p1) -- Line: 4
    -- upvalues: ColorSequence_new_ret (copy), Color3_fromRGB_ret (copy)
    return {
        {
            Timestamp = "2:00",
            Duration = 2.5,
            Text = "Jump, all the cells in my body",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.07,
            Speaker = p1,
            Color = ColorSequence_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "6:00",
            Duration = 3.5,
            Speaker = p1,
            Dialogue = {
                {
                    Text = "DRAGON",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.07,
                    Color = ColorSequence_new_ret,
                    TextStrokeColor = Color3_fromRGB_ret,
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 0.6
                    }
                },
                {
                    Text = " ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.5,
                    Color = ColorSequence_new_ret,
                    TextStrokeColor = Color3_fromRGB_ret,
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 1
                    }
                },
                {
                    Text = "DRIVE!",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.07,
                    Color = ColorSequence_new_ret,
                    TextStrokeColor = Color3_fromRGB_ret,
                    Shake = {
                        Enabled = true,
                        Intensity = 15,
                        Lifetime = 0.6
                    }
                }
            }
        }
    };
end;