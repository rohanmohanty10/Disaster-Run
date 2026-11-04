 
 

local u2 = {
    _report = function(p1: string) -- Line: 23, Name: _report
        warn((`Signal handler error: {p1}\n{debug.traceback()}`));
    end
};

function u2.new() -- Line: 27
    -- upvalues: u2 (copy)
    return {
        handlers = {},
        Connect = u2.Connect,
        Once = u2.Once,
        Fire = u2.Fire,
        Destroy = u2.Destroy
    };
end;

function u2.Connect(u3: table, p4: function) -- Line: 37
    local u5 = nil;
    local v7 = {
        connected = true,

        Disconnect = function(p6: table) -- Line: 41, Name: Disconnect
            -- upvalues: u3 (copy), u5 (ref)
            if not p6.connected then
                return;
            end;

            p6.connected = false;
            local table_find_ret = table.find(u3.handlers, u5);

            if table_find_ret then
                table.remove(u3.handlers, table_find_ret);
            end;
        end
    };
    u5 = {
        fn = p4,
        connection = v7
    };
    table.insert(u3.handlers, u5);

    return v7;
end;

function u2.Once(p8: table, u9: function) -- Line: 57
    -- upvalues: u2 (copy)
    local u10 = nil;
    u10 = u2.Connect(p8, function(...) -- Line: 59
        -- upvalues: u10 (ref), u9 (copy)
        u10:Disconnect();
        u9(...);
    end);

    return u10;
end;

function u2.Fire(p11: table, ...) -- Line: 66
    -- upvalues: u2 (copy)
    local handlers = p11.handlers;

    if #handlers == 0 then
        return;
    end;

    for _, v in table.clone(handlers) do
        if v.connection.connected then
            xpcall(v.fn, u2._report, ...);
        end;
    end;
end;

function u2.Destroy(p12: table) -- Line: 78
    for _, v in p12.handlers do
        v.connection.connected = false;
    end;

    table.clear(p12.handlers);
end;

return u2;