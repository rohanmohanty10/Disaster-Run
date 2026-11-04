 
 

return function() -- Line: 7, Name: spy
    local u1 = nil;
    u1 = {
        calls = 0,
        arguments = {},

        handle = function(...) -- Line: 10, Name: handle
            -- upvalues: u1 (ref)
            local v2 = u1;
            v2.calls = v2.calls + 1;
            u1.arguments[u1.calls] = { ... };
        end
    };

    return u1;
end;