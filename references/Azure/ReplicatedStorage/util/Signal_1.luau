 
 

local u1 = {};
u1.__index = u1;
local u2 = 0;

function u1.new() -- Line: 24
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Connections = {};
    v3.Coroutines = {};

    return v3;
end;

function u1.Connect(u4: any, u5: function) -- Line: 33
    -- upvalues: u2 (ref)
    local u6 = u2 + 1;
    u2 = u2 + 1;
    local v9 = {
        Disconnect = function(p7) -- Line: 38, Name: Disconnect
            -- upvalues: u4 (copy), u6 (copy)
            if not u4.Connections then
                return;
            end;

            u4.Connections[u6] = nil;
        end,

        Fire = function(p8, ...) -- Line: 43, Name: Fire
            -- upvalues: u5 (copy)
            u5(...);
        end
    };
    u4.Connections[u6] = v9;

    return v9;
end;

function u1.Once(u10: any, u11: function) -- Line: 52
    -- upvalues: u2 (ref)
    local u12 = u2 + 1;
    u2 = u2 + 1;
    local v15 = {
        Disconnect = function(p13) -- Line: 57, Name: Disconnect
            -- upvalues: u10 (copy), u12 (copy)
            if not u10.Connections then
                return;
            end;

            u10.Connections[u12] = nil;
        end,

        Fire = function(p14, ...) -- Line: 62, Name: Fire
            -- upvalues: u10 (copy), u12 (copy), u11 (copy)
            u10.Connections[u12] = nil;
            u11(...);
        end
    };
    u10.Connections[u12] = v15;

    return v15;
end;

function u1.Wait(u16) -- Line: 72
    -- upvalues: u2 (ref)
    local v17 = u2 + 1;
    u2 = u2 + 1;
    local coroutine_running_ret = coroutine.running();
    local v18 = {};
    local u19 = {};
    table.insert(u16.Coroutines, coroutine_running_ret);

    function v18.Fire(p20, ...) -- Line: 81
        -- upvalues: u19 (ref), u16 (copy)
        u19 = { ... };

        for _, v in u16.Coroutines do
            coroutine.resume(v);
        end;

        table.clear(u16.Coroutines);
    end;

    u16.Connections[v17] = v18;
    coroutine.yield(coroutine_running_ret);
    u16.Connections[v17] = nil;

    return unpack(u19);
end;

function u1.Fire(p21, ...) -- Line: 98
    if p21 and p21.Connections then
        for _, v in table.clone(p21.Connections) do
            task.spawn(v.Fire, v, ...);
        end;

        return;
    end;

    warn("self deleted but function firing");
end;

function u1.Destroy(p22) -- Line: 105
    if not (p22 and p22.Connections) then
        return;
    end;

    if p22.Coroutines then
        for _, v in p22.Coroutines do
            coroutine.resume(v);
        end;

        table.clear(p22.Coroutines);
    end;

    table.clear(p22);
end;

return u1;