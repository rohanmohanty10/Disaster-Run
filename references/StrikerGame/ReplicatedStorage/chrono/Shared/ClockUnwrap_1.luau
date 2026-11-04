 
 

local u6 = {
    SCALE = 10000,
    WRAP = 429496.7296,

    quantize = function(p1: number) -- Line: 15, Name: quantize
        return math.floor(p1 * 10000) % 4294967296;
    end,

    new = function() -- Line: 19, Name: new
        return {
            lastRaw = nil,
            offset = 0
        };
    end,

    unwrap = function(p2: table, p3: number) -- Line: 24, Name: unwrap
        local v4 = p3 % 4294967296;
        local lastRaw = p2.lastRaw;

        if lastRaw then
            local v5 = (v4 - lastRaw) % 4294967296;

            if v5 >= 2147483648 then
                return (lastRaw + p2.offset * 10000 - (4294967296 - v5)) / 10000;
            end;

            if v4 < lastRaw then
                p2.offset = p2.offset + 429496.7296;
            end;

            p2.lastRaw = v4;
        else
            p2.lastRaw = v4;
        end;

        return v4 / 10000 + p2.offset;
    end
};

function u6.unwrapFor(p7: table, p8: any, p9: number) -- Line: 43
    -- upvalues: u6 (copy)
    local v10 = p7[p8];

    if not v10 then
        v10 = u6.new();
        p7[p8] = v10;
    end;

    return u6.unwrap(v10, p9);
end;

function u6.seatFull(p11: table, p12: number) -- Line: 53
    local math_floor_ret = math.floor(p12 * 10000);
    local v13 = math_floor_ret % 4294967296;
    p11.lastRaw = v13;
    p11.offset = (math_floor_ret - v13) / 10000;

    return math_floor_ret / 10000;
end;

function u6.seatFullFor(p14: table, p15: any, p16: number) -- Line: 61
    -- upvalues: u6 (copy)
    local v17 = p14[p15];

    if not v17 then
        v17 = u6.new();
        p14[p15] = v17;
    end;

    return u6.seatFull(v17, p16);
end;

return u6;