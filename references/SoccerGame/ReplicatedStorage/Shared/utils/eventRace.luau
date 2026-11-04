  

return function(p1: table) -- Line: 1, Name: eventRace
    local coroutine_running_ret = coroutine.running();
    local v2 = {};

    for i, v in p1 do
        table.insert(v2, v:Once(function() -- Line: 5
            -- upvalues: coroutine_running_ret (copy), i (copy)
            if coroutine.status(coroutine_running_ret) == "suspended" then
                coroutine.resume(coroutine_running_ret, i);
            end;
        end));
    end;

    local coroutine_yield_ret = coroutine.yield();

    for _, v in v2 do
        v:Disconnect();
    end;

    return coroutine_yield_ret;
end;