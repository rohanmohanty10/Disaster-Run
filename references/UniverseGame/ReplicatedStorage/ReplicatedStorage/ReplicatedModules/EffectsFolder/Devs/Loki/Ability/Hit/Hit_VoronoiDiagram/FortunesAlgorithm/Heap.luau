  

 

local u1 = {};
u1.__index = u1;

function u1._Comparator(p2, p3) -- Line: 4
    return p2 < p3;
end;

u1._Values = {};
u1._Data = {};

function u1._SiftUp(p4, p5, p6) -- Line: 8
    local _Comparator = p4._Comparator;
    local _Values = p4._Values;
    local _Data = p4._Data;
    local v7 = #_Values;
    local v8 = math.floor(v7 / 2);

    while v7 > 1 and _Comparator(_Values[v7], _Values[v8]) do
        local v9 = _Values[v7];
        _Values[v7] = _Values[v8];
        _Values[v8] = v9;
        local v10 = _Data[v7];
        _Data[v7] = _Data[v8];
        _Data[v8] = v10;
        local v11 = math.floor(v8 / 2);
        v7 = v8;
        v8 = v11;
    end;
end;

function u1._SiftDown(p12) -- Line: 25
    local _Comparator = p12._Comparator;
    local _Values = p12._Values;
    local _Data = p12._Data;
    local v13 = #_Values;
    local v14 = 1;
    local v15 = v14 * 2;
    local v16 = v14 * 2 + 1;

    while true do
        if v16 > v13 then
            if v15 <= v13 and _Comparator(_Values[v15], _Values[v14]) then
                local v17 = _Values[v15];
                _Values[v15] = _Values[v14];
                _Values[v14] = v17;
                local v18 = _Data[v15];
                _Data[v15] = _Data[v14];
                _Data[v14] = v18;

                return;
            end;

            break;
        end;

        local v19;

        if _Comparator(_Values[v15], _Values[v16]) then
            if not _Comparator(_Values[v15], _Values[v14]) then
                break;
            end;

            local v20 = _Values[v15];
            _Values[v15] = _Values[v14];
            _Values[v14] = v20;
            local v21 = _Data[v15];
            _Data[v15] = _Data[v14];
            _Data[v14] = v21;
            v19 = v15 * 2;
            v16 = v15 * 2 + 1;
        else
            if not _Comparator(_Values[v16], _Values[v14]) then
                break;
            end;

            local v22 = _Values[v16];
            _Values[v16] = _Values[v14];
            _Values[v14] = v22;
            local v23 = _Data[v16];
            _Data[v16] = _Data[v14];
            _Data[v14] = v23;
            v19 = v16 * 2;
            v15 = v16;
            v16 = v16 * 2 + 1;
        end;

        v14 = v15;
        v15 = v19;
    end;
end;

function u1.Add(p24, p25, p26) -- Line: 76
    local v27 = #p24._Values + 1;
    p24._Values[v27] = p25;
    p24._Data[v27] = p26;
    p24:_SiftUp();
end;

function u1.Peek(p28) -- Line: 83
    return p28._Values[1], p28._Data[1];
end;

function u1.Pop(p29) -- Line: 87
    local v30 = p29._Values[1];
    local v31 = p29._Data[1];
    local v32 = #p29._Values;
    local _Data = p29._Data;
    local v33 = p29._Data[v32];
    p29._Values[1] = p29._Values[v32];
    _Data[1] = v33;
    local _Data2 = p29._Data;
    p29._Values[v32] = nil;
    _Data2[v32] = nil;
    p29:_SiftDown();

    return v30, v31;
end;

function u1.new(p34) -- Line: 97
    -- upvalues: u1 (copy)
    local v35 = setmetatable({}, u1);
    v35._Comparator = p34 or function(p36, p37) -- Line: 99
        return p36 < p37;
    end;
    v35._Values = {};
    v35._Data = {};

    return v35;
end;

return u1;