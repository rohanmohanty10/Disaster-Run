  

local v1 = {};
local u3 = {
    Disconnect = function(p2) -- Line: 55, Name: Disconnect
        local _listener = p2._listener;

        if _listener ~= nil then
            local _listener_table = p2._listener_table;
            local table_find_ret = table.find(_listener_table, _listener);

            if table_find_ret ~= nil then
                table.remove(_listener_table, table_find_ret);
            end;

            p2._listener = nil;
        end;

        if p2._disconnect_listener ~= nil then
            p2._disconnect_listener(p2._disconnect_param);
            p2._disconnect_listener = nil;
        end;
    end
};

function v1.NewArrayScriptConnection(p4, p5, p6, p7) -- Line: 71
    -- upvalues: u3 (copy)
    return {
        _listener = p5,
        _listener_table = p4,
        _disconnect_listener = p6,
        _disconnect_param = p7,
        Disconnect = u3.Disconnect
    };
end;

local u14 = {
    Disconnect = function(p8) -- Line: 92, Name: Disconnect
        local _listener = p8._listener;

        if _listener ~= nil then
            local _script_signal = p8._script_signal;
            local _fire_pointer_stack = _script_signal._fire_pointer_stack;
            local _listeners_next = _script_signal._listeners_next;
            local _listeners_back = _script_signal._listeners_back;

            for i = 1, _script_signal._stack_count do
                local v9;

                if _fire_pointer_stack[i] == _listener then
                    _fire_pointer_stack[i] = _listeners_next[_listener];
                    v9 = i;
                else
                    v9 = i;
                end;
            end;

            if _script_signal._tail_listener == _listener then
                local v10 = _listeners_back[_listener];

                if v10 == nil then
                    _script_signal._head_listener = nil;
                else
                    _listeners_next[v10] = nil;
                    _listeners_back[_listener] = nil;
                end;

                _script_signal._tail_listener = v10;
            elseif _script_signal._head_listener == _listener then
                local v11 = _listeners_next[_listener];
                _listeners_back[v11] = nil;
                _listeners_next[_listener] = nil;
                _script_signal._head_listener = v11;
            else
                local v12 = _listeners_next[_listener];
                local v13 = _listeners_back[_listener];

                if v12 ~= nil or v13 ~= nil then
                    _listeners_next[v13] = v12;
                    _listeners_back[v12] = v13;
                    _listeners_next[_listener] = nil;
                    _listeners_back[_listener] = nil;
                end;
            end;

            p8._listener = nil;
            _script_signal._listener_count = _script_signal._listener_count - 1;
        end;

        if p8._disconnect_listener ~= nil then
            p8._disconnect_listener(p8._disconnect_param);
            p8._disconnect_listener = nil;
        end;
    end
};
local u23 = {
    Connect = function(p15, p16, p17, p18) -- Line: 154, Name: Connect
        -- upvalues: u14 (copy)
        if type(p16) ~= "function" then
            error("[MadworkScriptSignal]: Only functions can be passed to ScriptSignal:Connect()");
        end;

        local _tail_listener = p15._tail_listener;

        if _tail_listener == nil then
            p15._head_listener = p16;
            p15._tail_listener = p16;
            p15._listener_count = p15._listener_count + 1;
        elseif _tail_listener ~= p16 and p15._listeners_next[p16] == nil then
            p15._listeners_next[_tail_listener] = p16;
            p15._listeners_back[p16] = _tail_listener;
            p15._tail_listener = p16;
            p15._listener_count = p15._listener_count + 1;
        end;

        return {
            _listener = p16,
            _script_signal = p15,
            _disconnect_listener = p17,
            _disconnect_param = p18,
            Disconnect = u14.Disconnect
        };
    end,

    GetListenerCount = function(p19) -- Line: 178, Name: GetListenerCount
        return p19._listener_count;
    end,

    Fire = function(p20, ...) -- Line: 182, Name: Fire
        local _fire_pointer_stack = p20._fire_pointer_stack;
        local v21 = p20._stack_count + 1;
        p20._stack_count = v21;
        local _listeners_next = p20._listeners_next;
        _fire_pointer_stack[v21] = p20._head_listener;

        while true do
            local v22 = _fire_pointer_stack[v21];
            _fire_pointer_stack[v21] = _listeners_next[v22];

            if v22 == nil then
                break;
            end;

            v22(...);
        end;

        p20._stack_count = p20._stack_count - 1;
    end
};

function v1.NewScriptSignal() -- Line: 201
    -- upvalues: u23 (copy)
    return {
        _stack_count = 0,
        _listener_count = 0,
        _head_listener = nil,
        _tail_listener = nil,
        _fire_pointer_stack = {},
        _listeners_next = {},
        _listeners_back = {},
        Connect = u23.Connect,
        GetListenerCount = u23.GetListenerCount,
        Fire = u23.Fire
    };
end;

return v1;