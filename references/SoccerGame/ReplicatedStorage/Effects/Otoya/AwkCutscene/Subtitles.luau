  

local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);

return function(p1) -- Line: 4
    -- upvalues: Color3_new_ret (copy), Color3_fromRGB_ret (copy)
    return {
        {
            Timestamp = "1:00",
            Duration = 2,
            Text = "Go with the flow",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "3:00",
            Duration = 2,
            Text = "To become the worlds best",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        }
    };
end;