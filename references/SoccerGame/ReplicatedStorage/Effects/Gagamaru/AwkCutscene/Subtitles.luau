  

local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);

return function(p1) -- Line: 4
    -- upvalues: Color3_new_ret (copy), Color3_fromRGB_ret (copy)
    return {
        {
            Timestamp = "2:00",
            Duration = 2,
            Text = "Darn it, I\'ll try again",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.036,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        }
    };
end;