 

 

local u1 = {
    LONGEST = 3
};
local u2 = 0;
local u3 = nil;

local function release(p4, p5) -- Line: 39
    if p4.answered then
        return;
    end;

    p4.answered = true;
    local held = p4.held;
    p4.held = {};

    for _, v in ipairs(held) do
        task.spawn(v, p5);
    end;
end;

local function inPass() -- Line: 51
    -- upvalues: u2 (ref), u3 (ref)
    if u2 == 0 then
        return nil;
    end;

    if not u3 then
        u3 = {
            waits = 0,
            closed = false,
            answered = false,
            held = {}
        };
    end;

    return u3;
end;

function u1.pass(p6, ...) -- Line: 61
    -- upvalues: u2 (ref), u3 (ref), release (copy), u1 (copy)
    u2 = u2 + 1;
    local v7, v8 = xpcall(p6, debug.traceback, ...);
    u2 = u2 - 1;

    if u2 == 0 then
        local v9 = u3;
        u3 = nil;

        if v9 then
            v9.closed = true;

            if v9.waits == 0 then
                release(v9, false);
            else
                task.delay(u1.LONGEST, release, v9, true);
            end;
        end;
    end;

    if not v7 then
        error(v8, 0);
    end;
end;

function u1.take() -- Line: 82
    -- upvalues: inPass (copy)
    local v10 = inPass();

    if v10 then
        v10.waits = v10.waits + 1;
    end;

    return v10;
end;

function u1.give(p11, p12) -- Line: 90
    -- upvalues: release (copy)
    if not p11 then
        p12(false);

        return;
    end;

    if p11.answered then
        p12(true);

        return;
    end;

    p11.waits = p11.waits - 1;
    table.insert(p11.held, p12);

    if p11.waits == 0 and p11.closed then
        release(p11, true);
    end;
end;

function u1.hold(p13) -- Line: 106
    -- upvalues: inPass (copy)
    local v14 = inPass();

    if v14 then
        table.insert(v14.held, p13);

        return;
    end;

    p13(false);
end;

return u1;