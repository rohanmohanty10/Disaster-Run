  

local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(106, 0, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 251, 255)) });
local Color3_fromRGB_ret = Color3.fromRGB(85, 0, 255);

return function(p1) -- Line: 9
    -- upvalues: ColorSequence_new_ret (copy), Color3_fromRGB_ret (copy)
    return {
        {
            Timestamp = "0:01",
            Duration = 1.5,
            Text = "Wow, He\'s perfectly in view.",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.028,
            Speaker = p1,
            Color = ColorSequence_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "4:00",
            Duration = 2,
            Text = "With this throw, I can save the team!",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = ColorSequence_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        }
    };
end;