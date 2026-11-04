  

local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(106, 0, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(106, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) });
local Color3_fromRGB_ret = Color3.fromRGB(35, 0, 78);

return function(p1) -- Line: 9
    -- upvalues: ColorSequence_new_ret (copy), Color3_fromRGB_ret (copy)
    return {
        {
            Timestamp = "1:30",
            Duration = 2,
            Text = "Blue lock\'s going to die if i don\'t do something now.",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = ColorSequence_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "4:30",
            Duration = 1.5,
            Text = "We gotta change for blue locks sake.",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = ColorSequence_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "6:45",
            Duration = 1.5,
            Text = "I\'m going to make us win.",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = ColorSequence_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        }
    };
end;