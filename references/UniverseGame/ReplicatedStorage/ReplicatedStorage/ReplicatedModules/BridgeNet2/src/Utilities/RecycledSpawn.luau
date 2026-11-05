  

 

local u1 = nil;

local function passer(p2, ...) -- Line: 3
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;

local function yielder() -- Line: 10
    -- upvalues: passer (copy)
    while true do
        passer(coroutine.yield());
    end;
end;

return function(p4, ...) -- Line: 16
    -- upvalues: u1 (ref), yielder (copy)
    if u1 == nil then
        u1 = coroutine.create(yielder);
        task.spawn(u1);
    end;

    task.spawn(u1, p4, ...);
end;