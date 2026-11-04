  

local u1 = {};
u1.__index = u1;
local script_SignalConnection = require(script.SignalConnection);

local function DeepCopy(p2) -- Line: 34
    -- upvalues: DeepCopy (copy)
    if type(p2) ~= "table" then
        return p2;
    end;

    local v3 = {};

    for i, v in pairs(p2) do
        if type(v) == "table" then
            v3[i] = DeepCopy(v);
        else
            v3[i] = v;
        end;
    end;

    return v3;
end;

function u1.new(p4: table?) -- Line: 57
    -- upvalues: u1 (copy)
    local v5 = setmetatable({}, u1);
    v5._callbacks = {};

    if p4 then
        p4 = p4.copyArguments == false;
    end;

    v5._copyArguments = not p4;

    return v5;
end;

function u1._createConnection(u6: table, p7: boolean, p8: function) -- Line: 68
    -- upvalues: script_SignalConnection (copy)
    local u9 = {
        isOnce = p7,
        callback = p8
    };
    u9.connection = script_SignalConnection.new(function() -- Line: 74
        -- upvalues: u9 (copy), u6 (copy)
        u9.disconnected = true;
        local table_find_ret = table.find(u6._callbacks, u9);

        if table_find_ret then
            table.remove(u6._callbacks, table_find_ret);
        end;
    end);
    table.insert(u6._callbacks, u9);

    return u9.connection;
end;

function u1.Connect(p10: table, p11: function) -- Line: 90
    return p10:_createConnection(false, p11);
end;

function u1.Once(p12: table, p13: function) -- Line: 94
    return p12:_createConnection(true, p13);
end;

function u1.Wait(p14) -- Line: 102
    local coroutine_running_ret = coroutine.running();
    p14:_createConnection(true, function(...) -- Line: 105
        -- upvalues: coroutine_running_ret (copy)
        if coroutine.status(coroutine_running_ret) == "suspended" then
            task.spawn(coroutine_running_ret, ...);
        end;
    end);

    return coroutine.yield();
end;

function u1.Fire(p15, ...) -- Line: 119
    -- upvalues: DeepCopy (copy)
    local v16 = select("#", ...);
    local v17 = false;

    for _, v in table.clone(p15._callbacks) do
        if not v.disconnected then
            if v.isOnce then
                v.disconnected = true;
                v.connection.Connected = false;
                v17 = true;
            end;

            if p15._copyArguments then
                local table_create_ret = table.create(v16);

                for i = 1, v16 do
                    table_create_ret[i] = DeepCopy((select(i, ...)));
                    local _ = i;
                end;

                task.spawn(v.callback, table.unpack(table_create_ret, 1, v16));
            else
                task.spawn(v.callback, ...);
            end;
        end;
    end;

    if v17 then
        local table_create_ret = table.create(#p15._callbacks);

        for _, v in p15._callbacks do
            if not v.disconnected then
                table.insert(table_create_ret, v);
            end;
        end;

        p15._callbacks = table_create_ret;
    end;
end;

function u1.Destroy(p18) -- Line: 160
    for _, v in ipairs(p18._callbacks) do
        if v.connection then
            v.connection:Disconnect();
        end;
    end;
end;

return u1;