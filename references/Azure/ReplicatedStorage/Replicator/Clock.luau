 

 

local u1 = require("@game/ReplicatedStorage/Network/SyncSystem");
local u2 = {
    TicksPerSecond = u1.frameRate,

    now = function() -- Line: 12, Name: now
        -- upvalues: u1 (copy)
        return u1.now();
    end,

    tick = function() -- Line: 16, Name: tick
        -- upvalues: u1 (copy)
        return u1.currentFrame;
    end
};

function u2.live() -- Line: 20
    -- upvalues: u1 (copy), u2 (copy)
    return u1.now() * u2.TicksPerSecond;
end;

function u2.time(p3: number) -- Line: 24
    -- upvalues: u2 (copy)
    return p3 / u2.TicksPerSecond;
end;

function u2.wrap(p4: number) -- Line: 28
    return p4 % 4294967296;
end;

function u2.unwrap(p5: number, p6: number) -- Line: 32
    local v7 = p5 - p6 % 4294967296;

    if v7 > 2147483648 then
        v7 = v7 - 4294967296;
    elseif v7 < -2147483648 then
        v7 = v7 + 4294967296;
    end;

    return p6 + v7;
end;

return u2;