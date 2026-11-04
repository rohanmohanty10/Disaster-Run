  

local Freeze = require(script.Parent.Parent.Parent.Freeze);
local Utils = require(script.Parent.Parent.Internal.Utils);
local Signal = require(script.Parent.Parent.Parent.Signal);
require(script.Parent.Parent.Internal.Types);
local Signals = require(script.Parent.Parent.Internal.Signals);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 99
    -- upvalues: Signal (copy), Signals (copy), u1 (copy)
    local v3 = {
        Data = p2[3],
        Tags = p2[5],
        ReplicateTo = p2[3],
        _channel = p2[2],
        _beforeDestroy = Signal.new(),
        _signals = Signals.new()
    };

    return setmetatable(v3, u1);
end;

function u1.__tostring(p4) -- Line: 114
    return `Replion<{p4._channel}>`;
end;

function u1.BeforeDestroy(p5, p6) -- Line: 125
    return p5._beforeDestroy:Connect(p6);
end;

function u1.OnDataChange(p7, p8) -- Line: 136
    return p7._signals:Connect("onDataChange", "__root", p8);
end;

function u1.OnChange(p9, p10, p11) -- Line: 154
    return p9._signals:Connect("onChange", p10, p11);
end;

function u1.OnDescendantChange(p12, p13, p14) -- Line: 177
    return p12._signals:Connect("onDescendantChange", p13, p14);
end;

function u1.OnArrayInsert(p15, p16, p17) -- Line: 189
    return p15._signals:Connect("onArrayInsert", p16, p17);
end;

function u1.OnArrayRemove(p18, p19, p20) -- Line: 201
    return p18._signals:Connect("onArrayRemove", p19, p20);
end;

function u1._set(p21, p22, p23) -- Line: 205
    -- upvalues: Utils (copy), Freeze (copy)
    local PathTable = Utils.getPathTable(p22);

    if Freeze.Dictionary.getIn(p21.Data, PathTable) == p23 then
        return p23;
    end;

    local v24 = Freeze.Dictionary.setIn(p21.Data, PathTable, p23);
    local Data = p21.Data;
    p21.Data = v24;
    p21._signals:FireEvent("onDataChange", "__root", v24, PathTable);
    p21._signals:FireChange(p22, v24, Data);

    return p23;
end;

function u1._update(p25, p26, p27) -- Line: 224
    -- upvalues: Freeze (copy), Utils (copy)
    local v30 = Freeze.Dictionary.map(p27 or p26, function(p28, p29) -- Line: 225
        -- upvalues: Utils (ref), Freeze (ref)
        if p28 == Utils.SerializedNone then
            p28 = Freeze.None;
        end;

        return p28, p29;
    end);
    local Data = p25.Data;

    if p27 == nil then
        local v31 = Freeze.Dictionary.merge(p25.Data, v30);
        p25.Data = v31;
        p25._signals:FireEvent("onDataChange", "__root", v31, {});

        for i, v in v30 do
            p25._signals:FireEvent("onChange", i, Utils.getValue(v), Data[i]);
        end;

        return;
    end;

    local PathTable = Utils.getPathTable(p26);
    local v32 = Freeze.Dictionary.mergeIn(p25.Data, PathTable, v30);
    p25.Data = v32;
    p25._signals:FireEvent("onDataChange", "__root", v32, PathTable);

    for i, v in v30 do
        local v33 = Freeze.List.push(PathTable, i);
        local In = Freeze.Dictionary.getIn(Data, v33);
        p25._signals:FireEvent("onChange", v33, Utils.getValue(v), In);
    end;

    p25._signals:FireChange(p26, v32, Data);
end;

function u1._increase(p34, p35, p36) -- Line: 260
    return p34:_set(p35, p34:GetExpect(p35) + p36);
end;

function u1._decrease(p37, p38, p39) -- Line: 266
    return p37:_increase(p38, -p39);
end;

function u1._insert(p40, p41, p42, p43) -- Line: 270
    -- upvalues: Utils (copy), Freeze (copy)
    local PathTable = Utils.getPathTable(p41);
    local In = Freeze.Dictionary.getIn(p40.Data, PathTable);
    local v44 = `"{Utils.getPathString(p41)}" is not a valid path!`;
    local v45 = assert(In, v44);
    local v46 = p43 or #v45 + 1;
    local v47 = Freeze.List.insert(v45, v46, p42);
    local Data = p40.Data;
    local v48 = Freeze.Dictionary.setIn(p40.Data, PathTable, v47);
    p40.Data = v48;
    p40._signals:FireEvent("onDataChange", "__root", v48, PathTable);
    p40._signals:FireEvent("onArrayInsert", PathTable, v46, p42);
    p40._signals:FireChange(PathTable, v48, Data);
end;

function u1._remove(p49, p50, p51) -- Line: 289
    -- upvalues: Utils (copy), Freeze (copy)
    local PathTable = Utils.getPathTable(p50);
    local In = Freeze.Dictionary.getIn(p49.Data, PathTable);
    local v52 = `"{Utils.getPathString(p50)}" is not a valid path!`;
    local v53 = assert(In, v52);
    local v54 = p51 or #v53;
    local v55 = v53[v54];
    local v56 = Freeze.List.remove(v53, v54);
    local Data = p49.Data;
    local v57 = Freeze.Dictionary.setIn(p49.Data, PathTable, v56);
    p49.Data = v57;
    p49._signals:FireEvent("onDataChange", "__root", v57, PathTable);
    p49._signals:FireEvent("onArrayRemove", p50, v54, v55);
    p49._signals:FireChange(p50, v57, Data);

    return v55;
end;

function u1._clear(p58, p59) -- Line: 311
    -- upvalues: Utils (copy), Freeze (copy)
    local PathTable = Utils.getPathTable(p59);
    local Data = p58.Data;
    local v60 = Freeze.Dictionary.setIn(p58.Data, PathTable, {});
    p58.Data = v60;
    p58._signals:FireEvent("onDataChange", "__root", v60, PathTable);
    p58._signals:FireChange(p59, v60, Data);
end;

function u1.Find(p61, p62, p63) -- Line: 336
    local v64 = p61:Get(p62);

    if not v64 then
        return;
    end;

    local table_find_ret = table.find(v64, p63);

    if table_find_ret then
        return table_find_ret, p63;
    end;
end;

function u1.Get(p65, p66) -- Line: 360
    -- upvalues: Freeze (copy), Utils (copy)
    return Freeze.Dictionary.getIn(p65.Data, Utils.getPathTable(p66));
end;

function u1.GetExpect(p67, p68, p69) -- Line: 378
    -- upvalues: Utils (copy)
    assert(p68, "Path is required!");
    local v70 = p69 or `"{Utils.getPathString(p68)}" is not a valid path!`;
    local v71 = p67:Get(p68);

    if v71 == nil then
        error(v70);
    end;

    return v71;
end;

function u1.Destroy(p72) -- Line: 391
    if p72.Destroyed then
        return;
    end;

    p72.Destroyed = true;
    p72._beforeDestroy:Fire(p72);
    p72._beforeDestroy:DisconnectAll();
    p72._signals:Destroy();
end;

return u1;