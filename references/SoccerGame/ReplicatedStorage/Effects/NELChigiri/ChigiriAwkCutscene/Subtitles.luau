  

local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);

return function(p1, p2) -- Line: 4
    -- upvalues: Color3_new_ret (copy), Color3_fromRGB_ret (copy)
    return {
        {
            Timestamp = "3:00",
            Duration = 2,
            Text = "Hyoma Chigiri!",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p2,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "5:30",
            Duration = 1.5,
            Text = "Tell me your ideal!",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p2,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "7:30",
            Duration = 2,
            Text = "My ideal...?",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "9:00",
            Duration = 1.5,
            Text = "Make it as detailed as possible!",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p2,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "11:00",
            Duration = 4,
            Text = "Think backwards from the ideal version of yourself.",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p2,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "11:00",
            Duration = 4,
            Text = "Think backwards from the ideal version of yourself.",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p2,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "16:20",
            Duration = 2,
            Bold = true,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p2,
            Text = "What kind of soccer player does the ideal " .. p1.Name .. " want to be?",
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        }
    };
end;