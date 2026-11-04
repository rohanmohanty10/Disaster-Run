  

local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local Color3_fromRGB_ret = Color3.fromRGB(119, 0, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 0, 68);
local Color3_fromRGB_ret3 = Color3.fromRGB(217, 0, 255);

return function(p1) -- Line: 7
    -- upvalues: Color3_new_ret (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    return {
        {
            Timestamp = "2:50",
            Duration = 1,
            Text = "My soccer cells",
            Bold = true,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_new_ret2
        },
        {
            Timestamp = "5:80",
            Duration = 1,
            Text = "With my goal",
            Bold = true,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_new_ret2
        },
        {
            Timestamp = "7:00",
            Duration = 1,
            Text = "With my genes",
            Bold = true,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_new_ret2
        },
        {
            Timestamp = "9:00",
            Duration = 1,
            Text = "He has now entered...",
            Bold = true,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = Color3_new_ret,
            TextStrokeColor = Color3_new_ret2
        },
        {
            Timestamp = "12:00",
            Duration = 1,
            Text = "Flow",
            Bold = true,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = Color3_fromRGB_ret,
            TextStrokeColor = Color3_new_ret2
        },
        {
            Timestamp = "14:00",
            Duration = 1,
            Text = "BIG BANG DRIVE",
            Bold = true,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = Color3_fromRGB_ret2,
            TextStrokeColor = Color3_new_ret2
        },
        {
            Timestamp = "17:00",
            Duration = 1,
            Text = "I\'LL BEAT YOU UP!!",
            Bold = true,
            TypeSpeed = 0.026,
            Speaker = p1,
            Color = Color3_fromRGB_ret3,
            TextStrokeColor = Color3_new_ret2
        }
    };
end;