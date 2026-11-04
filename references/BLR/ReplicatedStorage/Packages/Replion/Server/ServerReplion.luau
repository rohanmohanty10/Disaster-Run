  

local Players = game:GetService("Players");
local Network = require(script.Parent.Parent.Internal.Network);
local Signal = require(script.Parent.Parent.Parent.Signal);
local Utils = require(script.Parent.Parent.Internal.Utils);
local Signals = require(script.Parent.Parent.Internal.Signals);
require(script.Parent.Parent.Internal.Types);
local Freeze = require(script.Parent.Parent.Parent.Freeze);
local u1 = 0;
local u2 = {};
local u3 = {};
u3.__index = u3;

function u3.new(p4: table) -- Line: 143
    -- upvalues: u1 (ref), u2 (copy), Signal (copy), Signals (copy), u3 (copy), Network (copy)
    local v5 = type(p4.Channel) == "string";
    local v6 = `"Channel" expected string, got {type(p4.Channel)}`;
    assert(v5, v6);
    assert(p4.ReplicateTo, "ReplicateTo is required!");
    local ReplicateTo = p4.ReplicateTo;
    local v7 = nil;

    if u1 + 1 > 1114111 then
        if #u2 > 0 then
            v7 = table.remove(u2, 1);
        end;
    else
        u1 = u1 + 1;
        v7 = u1;
    end;

    assert(v7, "No available ID!");
    local v8 = `ID limit reached! You already have {1114111} ServerReplions!`;
    assert(v7 <= 1114111, v8);
    local v9 = {
        Data = p4.Data,
        Channel = p4.Channel,
        Tags = not p4.Tags and {} or p4.Tags,
        ReplicateTo = ReplicateTo,
        _id = v7,
        _packedId = utf8.char(v7),
        _beforeDestroy = Signal.new(),
        _signals = Signals.new()
    };
    local v10 = setmetatable(v9, u3);
    Network.sendTo(ReplicateTo, "Added", v10:_serialize());

    return v10;
end;

function u3.__tostring(p11) -- Line: 179
    local Channel = p11.Channel;
    local ReplicateTo = p11.ReplicateTo;

    if type(ReplicateTo) == "table" then
        local v12 = {};

        for i, v in ReplicateTo do
            v12[i] = v.Name;
        end;

        ReplicateTo = table.concat(v12, ", ");
    elseif typeof(ReplicateTo) == "Instance" then
        ReplicateTo = ReplicateTo.Name;
    end;

    return `Replion<{Channel}:{ReplicateTo}>`;
end;

function u3._serialize(p13) -- Line: 207
    return {
        p13._packedId,
        p13.Channel,
        p13.Data,
        p13.ReplicateTo,
        p13.Tags
    };
end;

function u3.BeforeDestroy(p14, p15) -- Line: 221
    return p14._beforeDestroy:Connect(p15);
end;

function u3.OnDataChange(p16, p17) -- Line: 232
    return p16._signals:Connect("onDataChange", "__root", p17);
end;

function u3.OnChange(p18, p19, p20) -- Line: 244
    return p18._signals:Connect("onChange", p19, p20);
end;

function u3.OnArrayInsert(p21, p22, p23) -- Line: 256
    return p21._signals:Connect("onArrayInsert", p22, p23);
end;

function u3.OnArrayRemove(p24, p25, p26) -- Line: 268
    return p24._signals:Connect("onArrayRemove", p25, p26);
end;

function u3.OnDescendantChange(p27, p28, p29) -- Line: 280
    return p27._signals:Connect("onDescendantChange", p28, p29);
end;

function u3.SetReplicateTo(p30, p31) -- Line: 287
    -- upvalues: Players (copy), Network (copy)
    local v32;

    if p31 == "All" or type(p31) == "table" then
        v32 = true;
    elseif typeof(p31) == "Instance" then
        v32 = p31:IsA("Player");
    else
        v32 = false;
    end;

    assert(v32, "ReplicateTo must be a Player, a table of Players or \"All\"");
    local ReplicateTo = p30.ReplicateTo;

    if ReplicateTo == p31 then
        return;
    end;

    local v33;

    if ReplicateTo == "All" then
        v33 = Players:GetPlayers();
    else
        v33 = type(ReplicateTo) ~= "table" and { p31 } or ReplicateTo;
    end;

    local v34;

    if p31 == "All" then
        v34 = Players:GetPlayers();
    else
        v34 = type(p31) ~= "table" and { p31 } or p31;
    end;

    for _, v in v33 do
        if not table.find(v34, v) then
            Network.sendTo(v, "Removed", p30._packedId);
        end;
    end;

    for _, v in v34 do
        if not table.find(v33, v) then
            Network.sendTo(p31, "Added", p30:_serialize());
        end;
    end;

    p30.ReplicateTo = p31;
    Network.sendTo(p31, "UpdateReplicateTo", p30._packedId, p31);
end;

function u3.Set(p35, p36, p37) -- Line: 344
    -- upvalues: Utils (copy), Freeze (copy), Network (copy)
    local PathTable = Utils.getPathTable(p36);
    local In = Freeze.Dictionary.getIn(p35.Data, PathTable);

    if In and Freeze.Dictionary.equals(In, p37) then
        return In;
    end;

    local v38 = Freeze.Dictionary.setIn(p35.Data, PathTable, p37);
    local Data = p35.Data;
    p35.Data = v38;
    p35._signals:FireEvent("onDataChange", "__root", v38, PathTable);
    p35._signals:FireChange(p36, v38, Data);
    Network.sendTo(p35.ReplicateTo, "Set", p35._packedId, p36, p37);

    return p37;
end;

function u3.Update(u39, p40, p41) -- Line: 396
    -- upvalues: Utils (copy), Freeze (copy), Network (copy)
    local u42;

    if p41 then
        u42 = Utils.getPathTable(p40);
    else
        u42 = nil;
    end;

    local v46 = Freeze.Dictionary.filter(p41 or p40, function(p43, p44) -- Line: 398
        -- upvalues: u42 (copy), Freeze (ref), u39 (copy)
        local v45;

        if u42 then
            v45 = Freeze.Dictionary.getIn(u39.Data, u42);
        else
            v45 = u39.Data[p44];
        end;

        return not Freeze.Dictionary.equals(v45, p43);
    end);

    if Freeze.isEmpty(v46) then
        return;
    end;

    local Data = u39.Data;

    if u42 then
        local v47 = Freeze.Dictionary.mergeIn(u39.Data, u42, v46);
        u39.Data = v47;
        u39._signals:FireEvent("onDataChange", "__root", v47, u42);

        for i, v in v46 do
            local v48 = Freeze.List.push(u42, i);
            local In = Freeze.Dictionary.getIn(Data, v48);
            u39._signals:FireEvent("onChange", v48, Utils.getValue(v), In);
        end;

        u39._signals:FireChange(p40, v47, Data);
    else
        local v49 = Freeze.Dictionary.merge(u39.Data, v46);
        u39.Data = v49;
        u39._signals:FireEvent("onDataChange", "__root", v49, {});

        for i, v in v46 do
            u39._signals:FireEvent("onChange", i, Utils.getValue(v), Data[i]);
        end;
    end;

    local v52 = Freeze.Dictionary.map(v46, function(p50, p51) -- Line: 436
        -- upvalues: Freeze (ref), Utils (ref)
        if p50 == Freeze.None then
            p50 = Utils.SerializedNone;
        end;

        return p50, p51;
    end);

    if u42 then
        Network.sendTo(u39.ReplicateTo, "Update", u39._packedId, p40, v52);

        return;
    end;

    Network.sendTo(u39.ReplicateTo, "Update", u39._packedId, v52);
end;

function u3.Increase(p53, p54, p55) -- Line: 457
    -- upvalues: Utils (copy)
    local v56 = type(p55) == "number";
    local v57 = `"amount" expected number, got {type(p55)}`;
    assert(v56, v57);

    return p53:Set(p54, p53:GetExpect(p54, (`"{Utils.getPathString(p54)}" is not a valid path!`)) + p55);
end;

function u3.Decrease(p58, p59, p60) -- Line: 475
    return p58:Increase(p59, -p60);
end;

function u3.Insert(p61, p62, p63, p64) -- Line: 505
    -- upvalues: Utils (copy), Freeze (copy), Network (copy)
    local PathTable = Utils.getPathTable(p62);
    local In = Freeze.Dictionary.getIn(p61.Data, PathTable);
    local v65 = `"{Utils.getPathString(p62)}" is not a valid path!`;
    local v66 = assert(In, v65);
    local v67 = p64 or #v66 + 1;
    local v68 = Freeze.List.insert(v66, v67, p63);
    local Data = p61.Data;
    local v69 = Freeze.Dictionary.setIn(p61.Data, PathTable, v68);
    p61.Data = v69;
    p61._signals:FireEvent("onDataChange", "__root", v69, PathTable);
    p61._signals:FireEvent("onArrayInsert", PathTable, v67, p63);
    p61._signals:FireChange(PathTable, v69, Data);
    Network.sendTo(p61.ReplicateTo, "ArrayUpdate", p61._packedId, "i", p62, p63, p64);
end;

function u3.Remove(p70, p71, p72) -- Line: 552
    -- upvalues: Utils (copy), Freeze (copy), Network (copy)
    local PathTable = Utils.getPathTable(p71);
    local In = Freeze.Dictionary.getIn(p70.Data, PathTable);
    local v73 = `"{Utils.getPathString(p71)}" is not a valid path!`;
    local v74 = assert(In, v73);
    local v75 = p72 or #v74;
    local v76 = v74[v75];
    local v77 = Freeze.List.remove(v74, v75);
    local Data = p70.Data;
    local v78 = Freeze.Dictionary.setIn(p70.Data, PathTable, v77);
    p70.Data = v78;
    p70._signals:FireEvent("onDataChange", "__root", v78, PathTable);
    p70._signals:FireEvent("onArrayRemove", p71, v75, v76);
    p70._signals:FireChange(p71, v78, Data);
    Network.sendTo(p70.ReplicateTo, "ArrayUpdate", p70._packedId, "r", p71, p72);

    return v76;
end;

function u3.Clear(p79, p80) -- Line: 601
    -- upvalues: Utils (copy), Freeze (copy), Network (copy)
    local Expect = p79:GetExpect(p80, (`"{Utils.getPathString(p80)}" is not a valid path!`));

    if Freeze.isEmpty(Expect) then
        return;
    end;

    local PathTable = Utils.getPathTable(p80);
    local Data = p79.Data;
    local v81 = Freeze.Dictionary.setIn(p79.Data, PathTable, {});
    p79.Data = v81;
    p79._signals:FireEvent("onDataChange", "__root", v81, PathTable);
    p79._signals:FireChange(p80, v81, Data);
    Network.sendTo(p79.ReplicateTo, "ArrayUpdate", p79._packedId, "c", p80);
end;

function u3.Find(p82, p83, p84) -- Line: 645
    local v85 = p82:Get(p83);

    if not v85 then
        return;
    end;

    local table_find_ret = table.find(v85, p84);

    if table_find_ret then
        return table_find_ret, p84;
    end;
end;

function u3.Get(p86, p87) -- Line: 668
    -- upvalues: Freeze (copy), Utils (copy)
    assert(p87, "Path is required!");

    return Freeze.Dictionary.getIn(p86.Data, Utils.getPathTable(p87));
end;

function u3.GetExpect(p88, p89, p90) -- Line: 688
    -- upvalues: Utils (copy)
    assert(p89, "Path is required!");
    local v91 = p90 or `"{Utils.getPathString(p89)}" is not a valid path!`;
    local v92 = p88:Get(p89);

    if v92 == nil then
        error(v91);
    end;

    return v92;
end;

function u3.Destroy(p93) -- Line: 705
    -- upvalues: Network (copy), u2 (copy)
    if p93.Destroyed then
        return;
    end;

    p93.Destroyed = true;
    p93._beforeDestroy:Fire(p93);
    p93._beforeDestroy:DisconnectAll();
    p93._signals:Destroy();
    Network.sendTo(p93.ReplicateTo, "Removed", p93._packedId);
    table.insert(u2, p93._id);
end;

return u3;