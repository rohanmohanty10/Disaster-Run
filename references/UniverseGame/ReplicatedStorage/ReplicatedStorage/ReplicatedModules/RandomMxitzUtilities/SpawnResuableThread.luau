  

 

local u1 = {};

local function runCallback(p2, p3, ...) -- Line: 5
    -- upvalues: u1 (copy)
    p2(...);
    table.insert(u1, p3);
end;

local function yielder() -- Line: 10
    -- upvalues: runCallback (copy)
    while true do
        runCallback(coroutine.yield());
    end;
end;

return function(p4, ...) -- Line: 16
    -- upvalues: u1 (copy), yielder (copy)
    local v5;

    if #u1 > 0 then
        v5 = u1[#u1];
        u1[#u1] = nil;
    else
        v5 = coroutine.create(yielder);
        coroutine.resume(v5);
    end;

    task.spawn(v5, p4, v5, ...);
end;