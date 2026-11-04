  

local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 90, 170)) });
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);
local u1 = {
    Enabled = true,
    Intensity = 5,
    Lifetime = 2
};

return function(p2) -- Line: 13
    -- upvalues: ColorSequence_new_ret (copy), Color3_fromRGB_ret (copy), u1 (copy)
    return {
        {
            Timestamp = "4:00",
            Duration = 1.5,
            Text = "I\'m taking this game to the next level.",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.028,
            Speaker = p2,
            Color = ColorSequence_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "7:00",
            Duration = 1.5,
            Text = "Only the idiots who can keep up with me.",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.028,
            Speaker = p2,
            Color = ColorSequence_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "10:00",
            Duration = 2,
            Text = "Will get to see what comes next.",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.028,
            Speaker = p2,
            Color = ColorSequence_new_ret,
            TextStrokeColor = Color3_fromRGB_ret,
            Shake = u1
        }
    };
end;