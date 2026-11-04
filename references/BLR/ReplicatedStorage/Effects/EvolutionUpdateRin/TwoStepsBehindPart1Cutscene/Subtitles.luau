  

local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);
local Color3_fromRGB_ret2 = Color3.fromRGB(96, 213, 207);

return function(p1, p2) -- Line: 5
    -- upvalues: Color3_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    return {
        {
            Timestamp = "0:750",
            Duration = 1.75,
            Text = "You\'re too predictable!",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p2,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "4:000",
            Duration = 2,
            Text = "You\'re two steps behind.",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = Color3_fromRGB_ret2,
            TextStrokeColor = Color3_fromRGB_ret
        }
    };
end;