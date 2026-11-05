 

 

local u4 = {
    Lerp = function(_, p1, p2, p3) --[[ Name: Lerp, Line 4 ]]
        return (1 - p3) * p1 + p3 * p2;
    end
};
function u4.Curve(_, p5, p6) --[[ Line: 10 ]]
    -- upvalues: u4 (copy)
    while #p5 > 1 do
        local v7 = {};
        p5 = v7;
        for v8 = 1, #p5 - 1 do
            local v9 = u4:Lerp(p5[v8], p5[v8 + 1], p6);
            table.insert(p5, v9);
            v7 = p5;
            p5 = v7;
        end;
    end;
    return p5[1];
end;
return u4;