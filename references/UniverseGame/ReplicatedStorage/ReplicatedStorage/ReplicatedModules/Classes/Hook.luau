  

 

local u1 = {};
local Stack = require(script.Stack);

function u1.new() -- Line: 5
    -- upvalues: u1 (copy)
    local v2 = {
        Stacks = {},
        StackOrder = {}
    };

    for i, v in pairs(u1) do
        v2[i] = v;
    end;

    return v2;
end;

function u1.CreateStack(p3, p4) -- Line: 17
    -- upvalues: Stack (copy)
    if p3.Stacks[p4] then
        warn(debug.traceback(p4 .. " already exists"));

        return p3.Stacks[p4];
    end;

    p3.Stacks[p4] = Stack.new();
    table.insert(p3.StackOrder, p4);
end;

function u1.GetStack(p5, p6) -- Line: 23
    return p5.Stacks[p6];
end;

function u1.Hook(p7, p8, p9, p10, p11) -- Line: 27
    local v12 = p7:GetStack(p8);

    if v12 then
        v12:Add(p9, p10, p11);

        return;
    end;

    warn(debug.traceback(p8 .. " not found"));
end;

function u1.HasHook(p13, p14, p15) -- Line: 33
    local v16 = p13:GetStack(p14);

    if v16 then
        return v16:Get(p15);
    end;
end;

function u1.Unhook(p17, p18, p19) -- Line: 39
    local v20 = p17:GetStack(p18);

    if v20 then
        v20:Remove(p19);

        return;
    end;

    warn(debug.traceback(p18 .. " not found"));
end;

function u1.Process(p21, p22, p23) -- Line: 45
    local v24 = p21:GetStack(p22);
    local _DebugMode = p21._DebugMode;
    local v25 = nil;

    for _, v in pairs(v24:GetAll()) do
        if _DebugMode then
            v25 = os.clock();
        end;

        local v26 = v.Value(p23);

        if _DebugMode then
            warn(p22, v.Name, os.clock() - v25);
        end;

        if not v26 then
            return p23;
        end;
    end;

    return p23;
end;

function u1.RunHook(p27, p28) -- Line: 64
    for i, v in ipairs(p27.StackOrder) do
        local v29 = p27:Process(v, p28);

        if v29.Terminate then
            break;
        end;

        if i == #p27.StackOrder then
            return v29;
        end;
    end;
end;

function u1.PrintStackOrder(p30) -- Line: 72
    for _, v in ipairs(p30.StackOrder) do
        p30.Stacks[v]:PrintOrder(v);
    end;
end;

function u1.SetDebugMode(p31, p32) -- Line: 78
    p31._DebugMode = p32;
end;

function u1.Destroy(p33) -- Line: 82
    table.clear(p33.Stacks);
    table.clear(p33.StackOrder);
end;

return u1;