  

local function StringPathToArray(p1) -- Line: 31
    local v2 = {};

    if p1 ~= "" then
        for i in string.gmatch(p1, "[^%.]+") do
            table.insert(v2, i);
        end;
    end;

    return v2;
end;

local function CreateTableListenerPathIndex(p3, p4, p5) -- Line: 41
    local _table_listeners = p3._table_listeners;

    for i = 1, #p4 do
        local v6 = _table_listeners[1][p4[i]];

        if v6 == nil then
            v6 = { {} };
            _table_listeners[1][p4[i]] = v6;
        end;

        _table_listeners = v6;
        local _ = i;
    end;

    local v7 = _table_listeners[p5];

    if v7 == nil then
        v7 = {};
        _table_listeners[p5] = v7;
    end;

    return v7;
end;

local function CleanTableListenerTable(p8) -- Line: 62
    local v9 = p8[1];
    local v10 = p8[2];
    local v11 = { v9 };

    for i = 1, #v10 do
        v9 = v9[1][v10[i]];
        table.insert(v11, v9);
        local _ = i;
    end;

    for i = #v11, 2, -1 do
        local v12 = v11[i];

        if next(v12[1]) ~= nil then
            return;
        end;

        local v13 = i;

        for i2 = 2, 6 do
            if v12[i2] ~= nil and #v12[i2] > 0 then
                return;
            end;

            local _ = i2;
        end;

        v11[v13 - 1][1][v10[v13 - 1]] = nil;
    end;
end;

local u15 = {
    Disconnect = function(p14) -- Line: 97, Name: Disconnect
        local _listener = p14._listener;

        if _listener ~= nil then
            local _listener_table = p14._listener_table;
            local table_find_ret = table.find(_listener_table, _listener);

            if table_find_ret ~= nil then
                table.remove(_listener_table, table_find_ret);
            end;

            p14._listener = nil;
        end;

        if p14._disconnect_listener ~= nil then
            p14._disconnect_listener(p14._disconnect_param);
            p14._disconnect_listener = nil;
        end;
    end
};

local function NewArrayScriptConnection(p16, p17, p18, p19) -- Line: 113
    -- upvalues: u15 (copy)
    return {
        _listener = p17,
        _listener_table = p16,
        _disconnect_listener = p18,
        _disconnect_param = p19,
        Disconnect = u15.Disconnect
    };
end;

return {
    inject = function(p20) -- Line: 126, Name: inject
        -- upvalues: StringPathToArray (copy), CreateTableListenerPathIndex (copy), CleanTableListenerTable (copy), u15 (copy)
        local _replica_class = p20._replica_class;
        local NewReplica = p20.NewReplica;

        function p20.NewReplica(p21) -- Line: 132
            -- upvalues: NewReplica (copy)
            local v22 = NewReplica(p21);
            v22._table_listeners = { {} };
            v22._function_listeners = {};
            v22._raw_listeners = {};

            return v22;
        end;

        local SetValue = _replica_class.SetValue;
        local SetValues = _replica_class.SetValues;
        local ArrayInsert = _replica_class.ArrayInsert;
        local ArraySet = _replica_class.ArraySet;
        local ArrayRemove = _replica_class.ArrayRemove;
        local Write = _replica_class.Write;

        function _replica_class.SetValue(p23, p24, p25) -- Line: 151
            -- upvalues: StringPathToArray (ref), SetValue (copy)
            if type(p24) == "string" then
                p24 = StringPathToArray(p24) or p24;
            end;

            local Data = p23.Data;
            local _table_listeners = p23._table_listeners;

            for i = 1, #p24 - 1 do
                Data = Data[p24[i]];
                local v26;

                if _table_listeners == nil then
                    v26 = i;
                else
                    _table_listeners = _table_listeners[1][p24[i]];
                    v26 = i;
                end;
            end;

            local v27 = p24[#p24];
            local v28 = Data[v27];
            SetValue(p23, p24, p25);

            if v28 ~= p25 and _table_listeners ~= nil then
                if v28 == nil and _table_listeners[3] ~= nil then
                    for _, v in ipairs(_table_listeners[3]) do
                        v(p25, v27);
                    end;
                end;

                local v29 = _table_listeners[1][p24[#p24]];

                if v29 ~= nil and v29[2] ~= nil then
                    for _, v in ipairs(v29[2]) do
                        v(p25, v28);
                    end;
                end;
            end;

            for _, v in ipairs(p23._raw_listeners) do
                v("SetValue", p24, p25);
            end;
        end;

        function _replica_class.SetValues(p30, p31, p32) -- Line: 191
            -- upvalues: StringPathToArray (ref), SetValues (copy)
            if type(p31) == "string" then
                p31 = StringPathToArray(p31) or p31;
            end;

            local Data = p30.Data;
            local _table_listeners = p30._table_listeners;

            for i = 1, #p31 do
                Data = Data[p31[i]];
                local v33;

                if _table_listeners == nil then
                    v33 = i;
                else
                    _table_listeners = _table_listeners[1][p31[i]];
                    v33 = i;
                end;
            end;

            for i, v in pairs(p32) do
                local v34 = Data[i];
                Data[i] = v;

                if v34 ~= v and _table_listeners ~= nil then
                    local v35, v36;

                    if v34 == nil and _table_listeners[3] ~= nil then
                        v35 = i;
                        v36 = v;

                        for _, v2 in ipairs(_table_listeners[3]) do
                            v2(v36, v35);
                        end;
                    else
                        v36 = v;
                        v35 = i;
                    end;

                    _table_listeners = _table_listeners[1][v35];

                    if _table_listeners ~= nil and _table_listeners[2] ~= nil then
                        for _, v2 in ipairs(_table_listeners[2]) do
                            v2(v36, v34);
                        end;
                    end;
                end;
            end;

            SetValues(p30, p31, p32);

            for _, v in ipairs(p30._raw_listeners) do
                v("SetValues", p31, p32);
            end;
        end;

        function _replica_class.ArrayInsert(p37, p38, p39) -- Line: 235
            -- upvalues: StringPathToArray (ref), ArrayInsert (copy)
            if type(p38) == "string" then
                p38 = StringPathToArray(p38) or p38;
            end;

            local Data = p37.Data;
            local _table_listeners = p37._table_listeners;

            for i = 1, #p38 do
                Data = Data[p38[i]];
                local v40;

                if _table_listeners == nil then
                    v40 = i;
                else
                    _table_listeners = _table_listeners[1][p38[i]];
                    v40 = i;
                end;
            end;

            ArrayInsert(p37, p38, p39);
            local v41 = #Data;

            if _table_listeners ~= nil and _table_listeners[4] ~= nil then
                for _, v in ipairs(_table_listeners[4]) do
                    v(v41, p39);
                end;
            end;

            for _, v in ipairs(p37._raw_listeners) do
                v("ArrayInsert", p38, p39);
            end;

            return v41;
        end;

        function _replica_class.ArraySet(p42, p43, p44, p45) -- Line: 265
            -- upvalues: StringPathToArray (ref), ArraySet (copy)
            if type(p43) == "string" then
                p43 = StringPathToArray(p43) or p43;
            end;

            local _table_listeners = p42._table_listeners;

            for i = 1, #p43 do
                local v46;

                if _table_listeners == nil then
                    v46 = i;
                else
                    _table_listeners = _table_listeners[1][p43[i]];
                    v46 = i;
                end;
            end;

            ArraySet(p42, p43, p44, p45);

            if _table_listeners ~= nil and _table_listeners[5] ~= nil then
                for _, v in ipairs(_table_listeners[5]) do
                    v(p44, p45);
                end;
            end;

            for _, v in ipairs(p42._raw_listeners) do
                v("ArraySet", p43, p44, p45);
            end;
        end;

        function _replica_class.ArrayRemove(p47, p48, p49) -- Line: 291
            -- upvalues: StringPathToArray (ref), ArrayRemove (copy)
            if type(p48) == "string" then
                p48 = StringPathToArray(p48) or p48;
            end;

            local _table_listeners = p47._table_listeners;

            for i = 1, #p48 do
                local v50;

                if _table_listeners == nil then
                    v50 = i;
                else
                    _table_listeners = _table_listeners[1][p48[i]];
                    v50 = i;
                end;
            end;

            local v51 = ArrayRemove(p47, p48, p49);

            if _table_listeners ~= nil and _table_listeners[6] ~= nil then
                for _, v in ipairs(_table_listeners[6]) do
                    v(p49, v51);
                end;
            end;

            for _, v in ipairs(p47._raw_listeners) do
                v("ArrayRemove", p48, p49, v51);
            end;

            return v51;
        end;

        function _replica_class.Write(p52, p53, ...) -- Line: 318
            -- upvalues: Write (copy)
            local table_pack_ret = table.pack(Write(p52, p53, ...));
            local v54 = p52._write_lib[p53];

            if v54 then
                v54 = v54[1];
            end;

            local v55 = p52._function_listeners[v54];

            if v55 ~= nil then
                for _, v in ipairs(v55) do
                    v(...);
                end;
            end;

            return table.unpack(table_pack_ret);
        end;

        function _replica_class.ListenToChange(p56, p57, p58) -- Line: 334
            -- upvalues: StringPathToArray (ref), CreateTableListenerPathIndex (ref), CleanTableListenerTable (ref), u15 (ref)
            if type(p58) ~= "function" then
                error("[ReplicaService]: Only a function can be set as listener in Replica:ListenToChange()");
            end;

            if type(p57) == "string" then
                p57 = StringPathToArray(p57) or p57;
            end;

            if #p57 < 1 then
                error("[ReplicaService]: Passed empty path - a value key must be specified");
            end;

            local v59 = CreateTableListenerPathIndex(p56, p57, 2);
            table.insert(v59, p58);

            return {
                _listener = p58,
                _listener_table = v59,
                _disconnect_listener = CleanTableListenerTable,
                _disconnect_param = { p56._table_listeners, p57 },
                Disconnect = u15.Disconnect
            };
        end;

        function _replica_class.ListenToNewKey(p60, p61, p62) -- Line: 350
            -- upvalues: StringPathToArray (ref), CreateTableListenerPathIndex (ref), u15 (ref), CleanTableListenerTable (ref)
            if type(p62) ~= "function" then
                error("[ReplicaService]: Only a function can be set as listener in Replica:ListenToNewKey()");
            end;

            if type(p61) == "string" then
                p61 = StringPathToArray(p61) or p61;
            end;

            local v63 = CreateTableListenerPathIndex(p60, p61, 3);
            table.insert(v63, p62);

            return #p61 == 0 and {
                _disconnect_listener = nil,
                _disconnect_param = nil,
                _listener = p62,
                _listener_table = v63,
                Disconnect = u15.Disconnect
            } or {
                _listener = p62,
                _listener_table = v63,
                _disconnect_listener = CleanTableListenerTable,
                _disconnect_param = { p60._table_listeners, p61 },
                Disconnect = u15.Disconnect
            };
        end;

        function _replica_class.ListenToArrayInsert(p64, p65, p66) -- Line: 367
            -- upvalues: StringPathToArray (ref), CreateTableListenerPathIndex (ref), u15 (ref), CleanTableListenerTable (ref)
            if type(p66) ~= "function" then
                error("[ReplicaService]: Only a function can be set as listener in Replica:ListenToArrayInsert()");
            end;

            if type(p65) == "string" then
                p65 = StringPathToArray(p65) or p65;
            end;

            local v67 = CreateTableListenerPathIndex(p64, p65, 4);
            table.insert(v67, p66);

            return #p65 == 0 and {
                _disconnect_listener = nil,
                _disconnect_param = nil,
                _listener = p66,
                _listener_table = v67,
                Disconnect = u15.Disconnect
            } or {
                _listener = p66,
                _listener_table = v67,
                _disconnect_listener = CleanTableListenerTable,
                _disconnect_param = { p64._table_listeners, p65 },
                Disconnect = u15.Disconnect
            };
        end;

        function _replica_class.ListenToArraySet(p68, p69, p70) -- Line: 384
            -- upvalues: StringPathToArray (ref), CreateTableListenerPathIndex (ref), u15 (ref), CleanTableListenerTable (ref)
            if type(p70) ~= "function" then
                error("[ReplicaService]: Only a function can be set as listener in Replica:ListenToArraySet()");
            end;

            if type(p69) == "string" then
                p69 = StringPathToArray(p69) or p69;
            end;

            local v71 = CreateTableListenerPathIndex(p68, p69, 5);
            table.insert(v71, p70);

            return #p69 == 0 and {
                _disconnect_listener = nil,
                _disconnect_param = nil,
                _listener = p70,
                _listener_table = v71,
                Disconnect = u15.Disconnect
            } or {
                _listener = p70,
                _listener_table = v71,
                _disconnect_listener = CleanTableListenerTable,
                _disconnect_param = { p68._table_listeners, p69 },
                Disconnect = u15.Disconnect
            };
        end;

        function _replica_class.ListenToArrayRemove(p72, p73, p74) -- Line: 401
            -- upvalues: StringPathToArray (ref), CreateTableListenerPathIndex (ref), u15 (ref), CleanTableListenerTable (ref)
            if type(p74) ~= "function" then
                error("[ReplicaService]: Only a function can be set as listener in Replica:ListenToArrayRemove()");
            end;

            if type(p73) == "string" then
                p73 = StringPathToArray(p73) or p73;
            end;

            local v75 = CreateTableListenerPathIndex(p72, p73, 6);
            table.insert(v75, p74);

            return #p73 == 0 and {
                _disconnect_listener = nil,
                _disconnect_param = nil,
                _listener = p74,
                _listener_table = v75,
                Disconnect = u15.Disconnect
            } or {
                _listener = p74,
                _listener_table = v75,
                _disconnect_listener = CleanTableListenerTable,
                _disconnect_param = { p72._table_listeners, p73 },
                Disconnect = u15.Disconnect
            };
        end;

        function _replica_class.ListenToWrite(p76, p77, p78) -- Line: 418
            -- upvalues: u15 (ref)
            if type(p78) ~= "function" then
                error("[ReplicaService]: Only a function can be set as listener in Replica:ListenToWrite()");
            end;

            if p76._write_lib == nil then
                error("[ReplicaService]: _write_lib was not declared for this replica");
            end;

            local v79 = p76._write_lib[p77];

            if v79 then
                v79 = v79[1];
            end;

            if v79 == nil then
                error("[ReplicaService]: Write function \"" .. p77 .. "\" not declared inside _write_lib of this replica");
            end;

            local v80 = p76._function_listeners[v79];

            if v80 == nil then
                v80 = {};
                p76._function_listeners[v79] = v80;
            end;

            table.insert(v80, p78);

            return {
                _disconnect_listener = nil,
                _disconnect_param = nil,
                _listener = p78,
                _listener_table = v80,
                Disconnect = u15.Disconnect
            };
        end;

        function _replica_class.ListenToRaw(p81, p82) -- Line: 443
            -- upvalues: u15 (ref)
            local _raw_listeners = p81._raw_listeners;
            table.insert(_raw_listeners, p82);

            return {
                _disconnect_listener = nil,
                _disconnect_param = nil,
                _listener = p82,
                _listener_table = _raw_listeners,
                Disconnect = u15.Disconnect
            };
        end;
    end
};