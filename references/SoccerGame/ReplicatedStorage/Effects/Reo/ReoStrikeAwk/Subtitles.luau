  

local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 0, 92)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(56, 0, 92)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) });
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);

return function(p1) -- Line: 8
    -- upvalues: ColorSequence_new_ret (copy), Color3_fromRGB_ret (copy)
    return {
        {
            Timestamp = "2:00",
            Duration = 2,
            Text = "I\'m no longer the jack of all trades...",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.04,
            Speaker = p1,
            Color = ColorSequence_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "5:00",
            Duration = 2,
            Text = "Call me the Master of All Trades!",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.04,
            Speaker = p1,
            Color = ColorSequence_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        }
    };
end;