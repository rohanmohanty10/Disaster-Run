  

local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 60, 170)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 60, 170)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) });
local ColorSequence_new_ret2 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 213, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 213, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) });
local ColorSequence_new_ret3 = ColorSequence.new(Color3.fromRGB(5, 0, 161));
local Color3_fromRGB_ret = Color3.fromRGB(6, 12, 38);
local Color3_fromRGB_ret2 = Color3.fromRGB(10, 10, 10);
local Color3_fromRGB_ret3 = Color3.fromRGB(35, 5, 5);
local Color3_fromRGB_ret4 = Color3.fromRGB(22, 50, 140);
local Color3_fromRGB_ret5 = Color3.fromRGB(255, 213, 0);

return function(p1, p2) -- Line: 30
    -- upvalues: Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret5 (copy), ColorSequence_new_ret2 (copy), Color3_fromRGB_ret2 (copy), ColorSequence_new_ret (copy), Color3_fromRGB_ret (copy), ColorSequence_new_ret3 (copy), Color3_fromRGB_ret3 (copy)
    p1.NameColor = Color3_fromRGB_ret4;
    p2.NameColor = Color3_fromRGB_ret5;

    return {
        {
            Timestamp = "7:00",
            Duration = 2,
            Text = "I\'ll leave it to you",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.03,
            Speaker = p2,
            Color = ColorSequence_new_ret2,
            TextStrokeColor = Color3_fromRGB_ret2
        },
        {
            Timestamp = "13:20",
            Duration = 0.7,
            Text = "I AM...",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.045,
            Speaker = p1,
            Color = ColorSequence_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "15:20",
            Duration = 2,
            Text = "A STRIKER",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.075,
            Speaker = p1,
            Color = ColorSequence_new_ret3,
            TextStrokeColor = Color3_fromRGB_ret3,
            Shake = {
                Enabled = true,
                Intensity = 10,
                Lifetime = 1.7
            }
        }
    };
end;