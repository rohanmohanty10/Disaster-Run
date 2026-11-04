 

 

local u4 = {
    count = function(p1, p2) -- Line: 2, Name: count
        local v3 = {};

        for _, v in p1 do
            v3[v.id] = 0;
        end;

        for _, v in p2 do
            if v3[v] then
                v3[v] = v3[v] + 1;
            end;
        end;

        return v3;
    end
};

function u4.choose(p5, p6, p7, p8) -- Line: 7
    -- upvalues: u4 (copy)
    local v9 = u4.count(p5, p6);
    local v10 = 0;
    local v11 = {};

    for _, v in p5 do
        local v12 = v9[v.id];

        if v10 < v12 then
            v11 = { v.id };
            v10 = v12;
        elseif v12 == v10 then
            table.insert(v11, v.id);
        end;
    end;

    if v10 == 0 then
        return p7, "No votes — staying here.";
    end;

    if table.find(v11, p7) then
        if #v11 > 1 then
            return p7, "Tie — keeping the current map.";
        end;

        return p7, "Your next arena.";
    end;

    local v13 = v11[(p8 or Random.new()):NextInteger(1, #v11)];

    if #v11 > 1 then
        return v13, "Chosen from the tied maps.";
    end;

    return v13, "Your next arena.";
end;

return u4;