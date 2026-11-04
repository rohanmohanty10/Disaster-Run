  

local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);

return function(p1, p2) -- Line: 4
    -- upvalues: Color3_new_ret (copy), Color3_fromRGB_ret (copy)
    return {
        {
            Timestamp = "0:00",
            Duration = 2,
            Text = "Finally the puzzles are together...",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.036,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "4:00",
            Duration = 2,
            Text = "Wait, what\'s that?",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.034,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "8:20",
            Duration = 2,
            Text = "Let\'s address the elephant in the room...",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.036,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "12:00",
            Duration = 2,
            Text = "Shoot it ISAGI",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.045,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        }
    };
end;