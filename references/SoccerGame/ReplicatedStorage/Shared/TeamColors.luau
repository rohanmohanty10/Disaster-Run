  

local u1 = {
    Home = {
        Color3.new(0.223529, 0.431373, 1),
        Color3.new(0.168627, 0.168627, 0.168627),
        Color3.fromRGB(164, 255, 255),
        Color3.fromRGB(140, 20, 20),
        Color3.fromRGB(30, 30, 30),
        Color3.fromRGB(239, 1, 7),
        Color3.fromRGB(254, 221, 0),
        Color3.new(1, 1, 1),
        Color3.fromRGB(255, 255, 255)
    },
    Away = {
        Color3.fromRGB(240, 240, 240),
        Color3.new(1, 0.101961, 0.101961),
        Color3.new(1, 1, 1),
        Color3.fromRGB(0, 75, 150),
        Color3.fromRGB(0, 40, 150),
        Color3.fromRGB(0, 145, 98),
        Color3.fromRGB(245, 245, 245),
        Color3.fromRGB(64, 78, 117),
        Color3.fromRGB(245, 245, 245)
    },
    Gradients = {
        Home = {
            [3] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(108, 190, 235)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            [4] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)), ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 20, 20)) }),
            [5] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30)) }),
            [6] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(239, 1, 7)) }),
            [7] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 221, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 155, 58)) }),
            [9] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 210)), ColorSequenceKeypoint.new(1, Color3.fromRGB(225, 35, 45)) })
        },
        Away = {
            [4] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 75, 150)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 0, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 205, 0)) }),
            [5] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 40, 150)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(230, 40, 55)) }),
            [6] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 117, 80)), ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 245, 245)) }),
            [7] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(245, 245, 245)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 0, 43)) }),
            [8] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 43, 78)), ColorSequenceKeypoint.new(1, Color3.fromRGB(78, 94, 137)) }),
            [9] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(245, 245, 245)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 55, 120)) }),
            [1] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 240, 240)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 40)) })
        }
    },
    Clashes = {
        {
            Home = 4,
            Away = 2,
            Reason = "Bastard Munich vs Red - same red hue"
        },
        {
            Home = 1,
            Away = 4,
            Reason = "Soccer Game Blue vs FC Barcha - blue indicators"
        },
        {
            Home = 3,
            Away = 3,
            Reason = "Manshine vs Japan U20 - light kits"
        },
        {
            Home = 5,
            Away = 3,
            Reason = "Ubers white-half vs Japan U20 white"
        },
        {
            Home = 4,
            Away = 5,
            Reason = "Bastard Munich vs PXG - red gradient overlap"
        },
        {
            Home = 6,
            Away = 2,
            Reason = "Arsenaly vs Red - same red hue"
        },
        {
            Home = 6,
            Away = 5,
            Reason = "Arsenaly vs PXG - red/white gradient overlap"
        },
        {
            Home = 1,
            Away = 5,
            Reason = "Soccer Game Blue vs PXG - blue kits and indicators"
        },
        {
            Home = 1,
            Away = 8,
            Reason = "Soccer Game Blue vs France - same blue hue family"
        },
        {
            Home = 2,
            Away = 8,
            Reason = "Black vs France - dark kits and indicators"
        },
        {
            Home = 5,
            Away = 8,
            Reason = "Ubers black vs France navy - dark indicators"
        },
        {
            Home = 3,
            Away = 9,
            Reason = "Manshine vs England - light blue/white kits"
        },
        {
            Home = 5,
            Away = 9,
            Reason = "Ubers white-half vs England white"
        },
        {
            Home = 3,
            Away = 1,
            Reason = "Manshine vs Soccer Game U20 Alternate - light kits"
        },
        {
            Home = 5,
            Away = 1,
            Reason = "Ubers vs Soccer Game U20 Alternate - white/black palettes"
        },
        {
            Home = 8,
            Away = 1,
            Reason = "Soccer Game White vs Soccer Game U20 Alternate - white kits"
        },
        {
            Home = 8,
            Away = 3,
            Reason = "Soccer Game White vs Japan U20 - white kits"
        },
        {
            Home = 8,
            Away = 9,
            Reason = "Soccer Game White vs England - white kits"
        },
        {
            Home = 9,
            Away = 1,
            Reason = "ReAl vs Soccer Game U20 Alternate - white kits"
        },
        {
            Home = 9,
            Away = 3,
            Reason = "ReAl vs Japan U20 - white kits"
        },
        {
            Home = 9,
            Away = 9,
            Reason = "ReAl vs England - white kits"
        },
        {
            Home = 9,
            Away = 2,
            Reason = "ReAl vs Red - red gradient overlap"
        },
        {
            Home = 9,
            Away = 4,
            Reason = "ReAl vs FC Barcha - blue/red gradient overlap"
        },
        {
            Home = 9,
            Away = 5,
            Reason = "ReAl vs PXG - blue/red gradient overlap"
        }
    }
};

function u1.IsClash(p2: number, p3: number) -- Line: 127
    -- upvalues: u1 (copy)
    for _, v in ipairs(u1.Clashes) do
        if v.Home == p2 and v.Away == p3 then
            return true;
        end;
    end;

    return false;
end;

return u1;