  

local Random_new_ret = Random.new(os.clock() * 1000);

return function(...) -- Line: 3
    -- upvalues: Random_new_ret (copy)
    local table_clone_ret = table.clone({ ... });
    local u1 = nil;

    if #table_clone_ret < 2 then
        return table_clone_ret[1] and table_clone_ret[1][1];
    end;

    local function Roll() -- Line: 27
        -- upvalues: u1 (ref), Random_new_ret (ref)
        u1 = Random_new_ret:NextNumber();
    end;

    local function Calc() -- Line: 31
        -- upvalues: table_clone_ret (copy), u1 (ref)
        local v2 = 0;

        for _, v in ipairs(table_clone_ret) do
            v2 = v2 + v[2];

            if u1 <= v2 then
                return v;
            end;
        end;
    end;

    (function() -- Line: 11, Name: Init
        -- upvalues: table_clone_ret (copy)
        local v3 = 0;

        for _, v in ipairs(table_clone_ret) do
            v3 = v3 + v[2];
        end;

        for _, v in ipairs(table_clone_ret) do
            local v4 = v[2];
            v[2] = v4 / v3;
            v[3] = v4;
        end;
    end)();
    u1 = Random_new_ret:NextNumber();
    local v5 = 0;
    local v6 = nil;

    for _, v in ipairs(table_clone_ret) do
        v5 = v5 + v[2];

        if u1 <= v5 then
            v6 = v;
            break;
        end;
    end;

    return v6[1], u1, v6[3];
end;