  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local utf8_char_ret = utf8.char(0);
local utf8_char_ret2 = utf8.char(1);
local utf8_char_ret3 = utf8.char(2);
local u1 = {};
local script_ReplicatorSignal = require(script.ReplicatorSignal);
local u2 = {};
local u3 = {};
local u4 = {};

local function runningPathHash(p5: string, p6: string) -- Line: 51
    return ("%*\255%*"):format(p5, p6);
end;

local function dictIncrement(p7: table, p8: string) -- Line: 55
    p7[p8] = (p7[p8] or 0) + 1;
end;

local function dictDecrement(p9: table, p10: string) -- Line: 60
    local v11;

    if p9[p10] == 1 or p9[p10] == nil then
        v11 = nil;
    else
        v11 = p9[p10] - 1;
    end;

    p9[p10] = v11;
end;

local function deepCopy(p12) -- Line: 65
    -- upvalues: deepCopy (copy)
    if type(p12) ~= "table" then
        return p12;
    end;

    local table_clone_ret = table.clone(p12);

    for i, v in table_clone_ret do
        if type(v) == "table" then
            table_clone_ret[i] = deepCopy(v);
        end;
    end;

    return table_clone_ret;
end;

local function makeDotCallsError(u13: table) -- Line: 78
    for i, v in u13 do
        if type(v) == "function" then
            u13[i] = function(...) -- Line: 81
                -- upvalues: u13 (copy), i (copy), v (copy)
                if select(1, ...) == u13 then
                    return v(...);
                end;

                error((`called {i} with .{i}() instead of :{i}()`));
            end;
        end;
    end;
end;

local function handlePacket(p14: table) -- Line: 92
    -- upvalues: utf8_char_ret (copy), u3 (copy), u2 (copy), deepCopy (copy), utf8_char_ret2 (copy), utf8_char_ret3 (copy), u4 (copy)
    local v15 = p14[1];
    local v16 = p14[2];

    if v15 == utf8_char_ret then
        local v17 = p14[3];
        local v18 = p14[4];

        for i, v in u3 do
            if v == v17 and i ~= v16 then
                error((`client received 2 Replicators with the same Id "{v17}"`));
            end;
        end;

        u3[v16] = v17;
        local v19 = u2.get(v17);
        v19.Data = deepCopy(v18);

        for _, v in v19._observe_signals do
            v.signal:Fire(v19:TryIndex(v.path), nil);
        end;

        for _, v in v19._listen_signals do
            v.signal:Fire(v19:TryIndex(v.path));
        end;

        v19._listen_raw_signal:Fire(v19.Data, v19.Data);

        return;
    end;

    if v15 ~= utf8_char_ret2 then
        if v15 == utf8_char_ret3 then
            local v20 = u3[v16];
            local v21 = u2.get(v20);

            if v21._destroyed == true then
                error("received 2 DESTROY_CMD for the same replicator");
            end;

            v21.Destroying:Fire();

            for _, v in v21._listen_signals do
                v.signal:DisconnectAll();
            end;

            table.clear(v21._listen_signals);

            for _, v in v21._observe_signals do
                v.signal:DisconnectAll();
            end;

            table.clear(v21._observe_signals);
            table.clear(v21._signal_descendants);
            v21._destroyed = true;
            u4[v20] = nil;
        end;

        return;
    end;

    local v22 = p14[3];
    local v23 = u3[v16];

    if not v23 then
        return;
    end;

    local v24 = u2.get(v23);
    local _signal_descendants = v24._signal_descendants;
    local _listen_signals = v24._listen_signals;
    local _observe_signals = v24._observe_signals;
    local _ = v24._listen_raw_signal;
    local u25 = {};

    local function applyMut(p26: any, p27: any, p28: string?) -- Line: 135
        -- upvalues: deepCopy (ref), applyMut (copy), _signal_descendants (copy), _listen_signals (copy), u25 (copy), _observe_signals (copy)
        if p27 == nil then
            if type(p26) == "table" then
                return deepCopy(p26);
            end;

            return nil;
        end;

        if p27.o == 0 then
            if type(p27.v) == "table" then
                return deepCopy(p27.v);
            end;

            return p27.v;
        end;

        for i, v in p27 do
            local v29;

            if v.k then
                v29 = tonumber(i);
            else
                v29 = i;
            end;

            local v30;

            if p28 then
                v30 = ("%*\255%*"):format(p28, v29);
            else
                v30 = nil;
            end;

            local v31;

            if v.o == 0 then
                v31 = v.v;
            else
                local v32 = p26[v29] or {};
                local v33;

                if _signal_descendants[v30] then
                    v33 = v30;
                else
                    v33 = nil;
                end;

                v31 = applyMut(v32, v, v33);
            end;

            if v30 then
                local v34 = _listen_signals[v30];

                if v34 then
                    table.insert(u25, { v34.signal, v31, p27 });
                end;

                local v35 = _observe_signals[v30];

                if v35 then
                    local v36 = {};
                    local signal = v35.signal;
                    local v37;

                    if type(p26[v29]) == "table" then
                        v37 = deepCopy(p26[v29]);
                    else
                        v37 = p26[v29];
                    end;

                    v36[1], v36[2], v36[3] = signal, v31, v37;
                    table.insert(u25, v36);
                end;
            end;

            p26[v29] = v31;
        end;

        return p26;
    end;

    applyMut(v24.Data, v22, "\254");

    for _, v in u25 do
        v[1]:Fire(unpack(v, 2, 3));
    end;

    v24._listen_raw_signal:Fire(v24.Data, v22);
end;

function u2.get(p38: string) -- Line: 228
    -- upvalues: u4 (copy), script_ReplicatorSignal (copy), u1 (copy), dictIncrement (copy), dictDecrement (copy), makeDotCallsError (copy)
    local v39 = u4[p38];

    if v39 then
        return v39;
    end;

    local u40 = {
        Data = nil,
        Ready = false,
        _destroyed = false,
        Id = p38,
        Destroying = script_ReplicatorSignal.new(),
        _listen_signals = {},
        _listen_raw_signal = script_ReplicatorSignal.new(),
        _observe_signals = {},
        _signal_descendants = {}
    };

    local function registerListener(u41, p42, p43) -- Line: 249
        -- upvalues: u1 (ref), u40 (copy), script_ReplicatorSignal (ref), dictIncrement (ref), dictDecrement (ref)
        if #u41 == 0 and u41 ~= u1 then
            warn("path:", u41);
            error("invalid path to register listener.");
        end;

        local u44 = ("\254\255%*"):format((table.concat(u41, "\255")));
        local _signal_descendants = u40._signal_descendants;
        local u45;

        if p42 then
            u45 = u40._observe_signals;
        else
            u45 = u40._listen_signals;
        end;

        local u46 = u45[u44];

        if not u46 then
            u46 = {
                connected = 0,
                signal = script_ReplicatorSignal.new(),
                path = u41
            };
            u45[u44] = u46;
        end;

        local function writeDescendantsCount(p47) -- Line: 270
            -- upvalues: _signal_descendants (copy), u41 (copy)
            p47(_signal_descendants, "\254");
            local v48 = "\254";

            for i = 1, #u41 - 1 do
                v48 = ("%*\255%*"):format(v48, u41[i]);
                p47(_signal_descendants, v48);
                local _ = i;
            end;
        end;

        local u49 = u46.signal:Connect(p43);
        u46.connected = u46.connected + 1;
        writeDescendantsCount(dictIncrement);

        return function() -- Line: 283
            -- upvalues: u49 (copy), u46 (ref), u45 (copy), u44 (copy), writeDescendantsCount (copy), dictDecrement (ref)
            u49:Disconnect();
            local v50 = u46;
            v50.connected = v50.connected - 1;

            if u46.connected == 0 then
                u45[u44] = nil;
            end;

            writeDescendantsCount(dictDecrement);
        end;
    end;

    function u40.Listen(p51: table, p52: any, p53: any) -- Line: 296
        -- upvalues: registerListener (copy)
        if type(p52[1]) ~= "table" then
            return registerListener(p52, false, p53);
        end;

        local u54 = {};

        for _, v in p52 do
            local v55 = registerListener(v, false, p53);
            table.insert(u54, v55);
        end;

        return function() -- Line: 305
            -- upvalues: u54 (copy)
            for _, v in u54 do
                v();
            end;

            table.clear(u54);
        end;
    end;

    function u40.ListenRaw(p56: table, p57: any) -- Line: 317
        -- upvalues: u40 (copy)
        return u40._listen_raw_signal:Connect(p57);
    end;

    function u40.Observe(p58: table, p59: any, p60: any) -- Line: 321
        -- upvalues: u40 (copy), registerListener (copy)
        task.spawn(p60, u40:TryIndex(p59), nil);

        return registerListener(p59, true, p60);
    end;

    function u40.Index(p61: table, p62: any) -- Line: 326
        -- upvalues: u40 (copy)
        local Data = u40.Data;

        if type(Data) ~= "table" then
            error("Replicator:Index() failed Data is not a table.");
        end;

        local v63 = #p62;

        for i, v in p62 do
            Data = Data[v];

            if i < v63 and type(Data) ~= "table" then
                error((`Replicator:Index() failed {table.concat(p62, "/", 1, i)} is not a table.`));
            end;
        end;

        return Data;
    end;

    function u40.TryIndex(p64: table, p65: any) -- Line: 343
        -- upvalues: u40 (copy)
        local Data = u40.Data;

        if type(Data) ~= "table" then
            return nil;
        end;

        local v66 = #p65;

        for i, v in p65 do
            Data = Data[v];

            if i < v66 and type(Data) ~= "table" then
                return nil;
            end;
        end;

        return Data;
    end;

    function u40.WaitForLoaded(p67: table) -- Line: 360
        -- upvalues: u40 (copy)
        coroutine.running();

        if not u40.Data then
            u40._listen_raw_signal:Wait();
        end;
    end;

    u4[p38] = u40;
    makeDotCallsError(u40);

    return u40;
end;

function u2.init() -- Line: 374
    -- upvalues: ReplicatedStorage (copy), handlePacket (copy)
    local coroutine_running_ret = coroutine.running();
    local u68 = false;
    local RemoteEvent = ReplicatedStorage:WaitForChild("__ReplicatorInternal"):WaitForChild("RemoteEvent");
    RemoteEvent.OnClientEvent:Connect(function(p69) -- Line: 380
        -- upvalues: handlePacket (ref), u68 (ref), coroutine_running_ret (copy)
        for _, v in p69 do
            handlePacket(v);
        end;

        if u68 and coroutine.status(coroutine_running_ret) == "suspended" then
            task.spawn(coroutine_running_ret);
            u68 = false;
        end;
    end);
    RemoteEvent:FireServer();
    u68 = true;
    coroutine.yield();
end;

return u2;