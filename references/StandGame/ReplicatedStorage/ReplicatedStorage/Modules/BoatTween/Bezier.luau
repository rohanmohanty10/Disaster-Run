 

 

local function u2(p1) --[[ Line: 1 ]]
    return p1;
end;
return function(u3, u4, u5, u6) --[[ Name: Bezier, Line 5 ]]
    -- upvalues: u2 (copy)
    if not (u3 and (u4 and (u5 and u6))) then
        error("Need 4 numbers to construct a Bezier curve", 0);
    end;
    if u3 < 0 or (u3 > 1 or (u5 < 0 or u5 > 1)) then
        error("The x values must be within range [0, 1]", 0);
    end;
    if u3 == u4 and u5 == u6 then
        return u2;
    end;
    local u7 = {};
    for v8 = 0, 10 do
        local v9 = v8 / 10;
        u7[v8] = (((1 - 3 * u5 + 3 * u5) * v9 + (3 * u5 - 6 * u3)) * v9 + 3 * u3) * v9;
    end;
    return function(p10) --[[ Line: 24 ]]
        -- upvalues: u3 (copy), u4 (copy), u5 (copy), u6 (copy), u2 (ref), u7 (copy)
        if u3 == u4 and u5 == u6 then
            return u2;
        end;
        if p10 == 0 or p10 == 1 then
            return p10;
        end;
        local v11 = 1;
        local v12 = 0;
        while v11 ~= 10 and u7[v11] <= p10 do
            v12 = v12 + 0.1;
            v11 = v11 + 1;
        end;
        local v13 = v11 - 1;
        local v14 = v12 + (p10 - u7[v13]) / (u7[v13 + 1] - u7[v13]) / 10;
        local v15 = 3 * (1 - 3 * u5 + 3 * u3) * v14 * v14 + 2 * (3 * u5 - 6 * u3) * v14 + 3 * u3;
        if v15 >= 0.001 then
            for _ = 0, 3 do
                v14 = v14 - ((((1 - 3 * u5 + 3 * u3) * v14 + (3 * u5 - 6 * u3)) * v14 + 3 * u3) * v14 - p10) / (3 * (1 - 3 * u5 + 3 * u3) * v14 * v14 + 2 * (3 * u5 - 6 * u3) * v14 + 3 * u3);
            end;
        elseif v15 ~= 0 then
            local v16 = v12 + 0.1;
            local v17 = 0;
            local v18 = nil;
            v14 = nil;
            while math.abs(v17) > 1e-7 and v18 < 10 do
                v14 = v12 + (v16 - v12) / 2;
                v17 = (((1 - 3 * u5 + 3 * u3) * v14 + (3 * u5 - 6 * u3)) * v14 + 3 * u3) * v14 - p10;
                if v17 > 0 then
                    v16 = v14;
                else
                    v12 = v14;
                end;
                v18 = v18 + 1;
            end;
        end;
        return (((1 - 3 * u6 + 3 * u4) * v14 + (3 * u6 - 6 * u4)) * v14 + 3 * u4) * v14;
    end;
end;