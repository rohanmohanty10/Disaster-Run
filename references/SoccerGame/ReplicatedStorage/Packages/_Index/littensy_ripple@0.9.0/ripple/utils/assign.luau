  

return function(p1, ...) -- Line: 1, Name: assign
    local v2 = type(p1) == "table";
    local v3 = `Expected a table for first argument, got ${type(p1)}`;
    assert(v2, v3);

    for i = 1, select("#", ...) do
        local _ = i;

        for i2, v in select(i, ...) do
            p1[i2] = v;
        end;
    end;

    return p1;
end;