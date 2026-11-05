  

 

return function(p1) -- Line: 8
    local u2 = {};
    u2.__index = u2;

    function u2.new() -- Line: 12
        -- upvalues: u2 (copy)
        return setmetatable({
            _prefix = "[petal_debug]: ",
            _cache = {}
        }, u2);
    end;

    function u2.Log(p3, p4, p5) -- Line: 22
        if p4 then
            print(p3._prefix .. p4 .. (not p5 and "" or debug.traceback()));
        end;

        return nil;
    end;

    function u2.Trace(p6, p7) -- Line: 29
        if p7 then
            p6:Log("trace: " .. debug.traceback(nil, p7));
        end;

        return nil;
    end;

    return u2;
end;