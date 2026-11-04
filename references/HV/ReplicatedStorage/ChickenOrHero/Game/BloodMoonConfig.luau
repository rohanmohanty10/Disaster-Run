 

 

local CandyCorn = require(script.Parent.CandyCorn);
local u1 = {
    Period = 7200,
    Duration = 600,
    Offset = 0,
    CountdownSeconds = 600,
    HauntChance = 0.25,
    CandyMultiplier = 2,
    Fade = 8,
    Howl = "rbxassetid://120531810756290"
};

function u1.window(p2) -- Line: 20
    -- upvalues: u1 (copy)
    local v3 = (p2 - u1.Offset) % u1.Period;
    local v4 = p2 - v3;

    if v3 < u1.Duration then
        return true, v4, v4 + u1.Duration;
    end;

    return false, v4 + u1.Period, v4 + u1.Period + u1.Duration;
end;

function u1.season(p5) -- Line: 30
    -- upvalues: CandyCorn (copy)
    return CandyCorn.active(p5);
end;

return table.freeze(u1);