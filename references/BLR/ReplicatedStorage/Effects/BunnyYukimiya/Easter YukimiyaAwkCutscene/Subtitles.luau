  

local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);

return function(p1) -- Line: 5
    -- upvalues: Color3_new_ret (copy), Color3_fromRGB_ret (copy)
    return {
        {
            Timestamp = "1:00",
            Duration = 5,
            Text = "Egoists, I have a new trickster you guys have never seen before.",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.05,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        },
        {
            Timestamp = "8:00",
            Duration = 1.5,
            Text = "THE EASTER BUNNY!",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_fromRGB_ret
        }
    };
end;