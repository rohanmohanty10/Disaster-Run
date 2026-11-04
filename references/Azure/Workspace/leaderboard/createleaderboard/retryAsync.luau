 

 

return function(p1: function, p2: number, p3: number?, p4: number?, p5: function?) -- Line: 13, Name: retryAsync
    local v6 = p5 or pcall;
    local v7 = 0;
    local v8 = nil;
    local v9 = nil;
    local v10 = p4 or 0;
    local v11 = p3 or 0;

    while v7 < p2 do
        v7 = v7 + 1;
        v9 = { v6(p1) };
        v8 = table.remove(v9, 1);

        if v8 then
            break;
        end;

        local v12 = v11 + v10 ^ v7;

        if v7 < p2 then
            task.wait(v12);
        end;
    end;

    if v8 then
        return v8, table.unpack(v9);
    end;

    local v13;

    if v8 then
        v13 = nil;
    else
        v13 = v9[1] or nil;
    end;

    return v8, v13;
end;