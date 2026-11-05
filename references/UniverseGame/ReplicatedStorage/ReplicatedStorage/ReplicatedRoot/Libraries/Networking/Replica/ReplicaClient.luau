  

 

local ReplicaShared = script.Parent.ReplicaShared;
local Remote = require(ReplicaShared.Remote);
local Signal = require(ReplicaShared.Signal);
local Maid = require(ReplicaShared.Maid);
local u1 = {};
local CollectionService = game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
game:GetService("Players");
local u2 = false;
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = Remote.New("ReplicaRequestData");
local v9 = Remote.New("ReplicaSet");
local v10 = Remote.New("ReplicaSetValues");
local v11 = Remote.New("ReplicaTableInsert");
local v12 = Remote.New("ReplicaTableRemove");
local v13 = Remote.New("ReplicaWrite");
local u14 = Remote.New("ReplicaSignal");
local v15 = Remote.New("ReplicaParent");
local v16 = Remote.New("ReplicaCreate");
local v17 = Remote.New("ReplicaBind");
local v18 = Remote.New("ReplicaDestroy");
local u19 = Remote.New("ReplicaSignalUnreliable", true);
local u20 = {};
local u21 = false;

local function LoadWriteLib(p22) -- Line: 115
    -- upvalues: u20 (copy)
    local v23 = u20[p22];

    if v23 ~= nil then
        return v23;
    end;

    local v24 = require(p22);
    local v25 = {};

    for i, v in pairs(v24) do
        table.insert(v25, { i, v });
    end;

    table.sort(v25, function(p26, p27) -- Line: 131
        return p26[1] < p27[1];
    end);
    local v28 = {};

    for i, v in ipairs(v25) do
        local v29 = {
            Name = v[1],
            Id = i,
            fn = v[2]
        };
        v28[v[1]] = v29;
        v28[i] = v29;
    end;

    u20[p22] = v28;

    return v28;
end;

local u30 = {};
u30.__index = u30;
local u31 = nil;

local function AcquireRunnerThreadAndCallEventHandler(p32, ...) -- Line: 188
    -- upvalues: u31 (ref)
    local v33 = u31;
    u31 = nil;
    p32(...);
    u31 = v33;
end;

local function RunEventHandlerInFreeThread(...) -- Line: 196
    -- upvalues: AcquireRunnerThreadAndCallEventHandler (copy)
    AcquireRunnerThreadAndCallEventHandler(...);

    while true do
        AcquireRunnerThreadAndCallEventHandler(coroutine.yield());
    end;
end;

function ConnectionNew(p34, p35)
    -- upvalues: u30 (copy)
    local v36 = setmetatable({
        t = p34,
        fn = p35
    }, u30);
    p34[v36] = true;

    return v36;
end;

function ConnectionFire(p37, ...)
    -- upvalues: u31 (ref), RunEventHandlerInFreeThread (copy)
    if not u31 then
        u31 = coroutine.create(RunEventHandlerInFreeThread);
    end;

    task.spawn(u31, p37.fn, ...);
end;

function u30.Disconnect(p38) -- Line: 223
    p38.t[p38] = nil;
end;

local u39 = {
    IsReady = false,
    OnLocalReady = Signal.New()
};
u39.__index = u39;

local function ReplicaNew(p40, p41) -- Line: 233
    -- upvalues: LoadWriteLib (copy), u5 (copy), u4 (copy), Signal (copy), Maid (copy), u1 (copy), u39 (copy)
    local v42;

    if p41[5] == nil then
        v42 = nil;
    else
        v42 = LoadWriteLib(p41[5]);
    end;

    local v43 = u5[p41[4]] or u4[p41[4]];
    local v44 = {
        BoundInstance = nil,
        Tags = p41[2],
        Data = p41[3],
        Id = p40,
        Token = p41[1],
        Parent = v43,
        Children = {},
        OnClientEvent = Signal.New(),
        Maid = Maid.New(u1),
        self_creation = p41,
        write_lib = v42,
        set_listeners = {},
        write_listeners = {},
        changed_listeners = {}
    };
    local v45 = setmetatable(v44, u39);

    if v43 ~= nil then
        v43.Children[v45] = true;
    end;

    return v45;
end;

function u39.RequestData() -- Line: 272
    -- upvalues: u2 (ref), u8 (copy), u39 (copy)
    if u2 == true then
        return;
    end;

    u2 = true;
    task.spawn(function() -- Line: 280
        -- upvalues: u8 (ref), u39 (ref)
        u8:FireServer();

        while task.wait(2) and u39.IsReady ~= true do
            u8:FireServer();
        end;
    end);
end;

function u39.OnNew(p46, p47) -- Line: 295
    -- upvalues: u7 (copy), u3 (copy)
    if type(p46) ~= "string" then
        error((`[{script.Name}]: "token" must be a string`));
    end;

    local v48 = u7[p46];

    if v48 == nil then
        v48 = {};
        u7[p46] = v48;
    end;

    local v49 = u3[p46];
    local v50 = ConnectionNew(v48, p47);

    if v49 ~= nil then
        for i in pairs(v49) do
            ConnectionFire(v50, i);
        end;
    end;

    return v50;
end;

function u39.FromId(p51) -- Line: 322
    -- upvalues: u4 (copy)
    return u4[p51];
end;

function u39.Test() -- Line: 326
    -- upvalues: u3 (copy), u4 (copy), u5 (copy), u6 (copy)
    return {
        TokenReplicas = u3,
        Replicas = u4,
        BindReplicas = u5,
        BindInstances = u6
    };
end;

function u39.OnSet(p52, p53, p54) -- Line: 335
    local v55 = table.concat(p53, ".");
    local v56 = p52.set_listeners[v55];

    if v56 == nil then
        v56 = {};
        p52.set_listeners[v55] = v56;
    end;

    return ConnectionNew(v56, p54);
end;

function u39.OnWrite(p57, p58, p59) -- Line: 346
    local v60 = p57.write_listeners[p58];

    if v60 == nil then
        v60 = {};
        p57.write_listeners[p58] = v60;
    end;

    return ConnectionNew(v60, p59);
end;

function u39.OnChange(p61, p62) -- Line: 356
    return ConnectionNew(p61.changed_listeners, p62);
end;

function u39.GetChild(p63, p64) -- Line: 360
    if type(p64) ~= "string" then
        error((`[{script.Name}]: "token" must be a string`));
    end;

    for i in pairs(p63.Children) do
        if i.Token == p64 then
            return i;
        end;
    end;

    return nil;
end;

function u39.FireServer(p65, ...) -- Line: 372
    -- upvalues: u14 (copy)
    u14:FireServer(p65.Id, ...);
end;

function u39.UFireServer(p66, ...) -- Line: 376
    -- upvalues: u19 (copy)
    u19:FireServer(p66.Id, ...);
end;

function u39.Identify(p67) -- Line: 380
    local v68 = "";
    local v69 = true;

    for i, v in pairs(p67.Tags) do
        v68 = v68 .. `{v69 == true and "" or ";"}{tostring(i)}={tostring(v)}`;
        v69 = false;
    end;

    return `[Id:{p67.Id};Token:{p67.Token};Tags:\{{v68}}]`;
end;

function u39.IsActive(p70) -- Line: 390
    return p70.Maid:IsActive();
end;

function u39.Set(p71, p72, p73) -- Line: 394
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "Set()" can't be called outside of WriteLibs client-side`));
    end;

    local Data = p71.Data;

    for i = 1, #p72 - 1 do
        Data = Data[p72[i]];
    end;

    local v74 = p72[#p72];
    local v75 = Data[v74];
    Data[v74] = p73;

    if next(p71.set_listeners) ~= nil then
        local v76 = p71.set_listeners[table.concat(p72, ".")];

        if v76 ~= nil then
            for i in pairs(v76) do
                ConnectionFire(i, p73, v75);
            end;
        end;
    end;

    for i in pairs(p71.changed_listeners) do
        ConnectionFire(i, "Set", p72, p73, v75);
    end;
end;

function u39.SetValues(p77, p78, p79) -- Line: 426
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "SetValues()" can't be called outside of WriteLibs client-side`));
    end;

    local Data = p77.Data;

    for _, v in ipairs(p78) do
        Data = Data[v];
    end;

    for i, v in pairs(p79) do
        Data[i] = v;
    end;

    for i in pairs(p77.changed_listeners) do
        ConnectionFire(i, "SetValues", p78, p79);
    end;
end;

function u39.TableInsert(p80, p81, p82, p83) -- Line: 450
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "TableInsert()" can't be called outside of WriteLibs client-side`));
    end;

    local Data = p80.Data;

    for _, v in ipairs(p81) do
        Data = Data[v];
    end;

    if p83 == nil then
        table.insert(Data, p82);
        p83 = #Data;
    else
        table.insert(Data, p83, p82);
    end;

    for i in pairs(p80.changed_listeners) do
        ConnectionFire(i, "TableInsert", p81, p82, p83);
    end;

    return p83;
end;

function u39.TableRemove(p84, p85, p86) -- Line: 479
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "TableRemove()" can't be called outside of WriteLibs client-side`));
    end;

    local Data = p84.Data;

    for _, v in ipairs(p85) do
        Data = Data[v];
    end;

    local v87 = table.remove(Data, p86);

    for i in pairs(p84.changed_listeners) do
        ConnectionFire(i, "TableRemove", p85, v87, p86);
    end;

    return v87;
end;

function u39.Write(p88, p89, ...) -- Line: 503
    -- upvalues: u21 (ref)
    if u21 ~= true then
        error((`[{script.Name}]: "Write()" can't be called outside of WriteLibs client-side`));
    end;

    local v90 = table.pack(p88.write_lib[p89].fn(p88, ...));
    local v91 = p88.write_listeners[p89];

    if v91 ~= nil then
        for i in pairs(v91) do
            ConnectionFire(i, ...);
        end;
    end;

    return table.unpack(v90);
end;

local function DestroyReplica(p92, p93) -- Line: 527
    -- upvalues: DestroyReplica (copy), u3 (copy), u4 (copy), u5 (copy), u1 (copy)
    for _, v in ipairs(p92.Children) do
        DestroyReplica(v, true);
    end;

    if p93 ~= true and p92.Parent ~= nil then
        p92.Parent.Children[p92] = nil;
    end;

    local Id = p92.Id;
    local v94 = u3[p92.Token];

    if v94 ~= nil then
        v94[p92] = nil;
    end;

    if u4[Id] == p92 then
        u4[Id] = nil;
    end;

    if u5[Id] == p92 then
        u5[Id] = nil;
    end;

    p92.Maid:Unlock(u1);
    p92.Maid:Cleanup();
    p92.BoundInstance = nil;
end;

local function ReplicaToBindBuffer(p95, p96) -- Line: 559
    -- upvalues: ReplicaNew (copy), u5 (copy), ReplicaToBindBuffer (copy), DestroyReplica (copy)
    local v97 = ReplicaNew(p95.Id, p95.self_creation);
    u5[p95.Id] = v97;

    for i in pairs(p95.Children) do
        ReplicaToBindBuffer(i, true);
    end;

    if p96 ~= true then
        DestroyReplica(p95);
    end;

    return v97;
end;

local function ReplicaFromBindBuffer(p98, p99) -- Line: 580
    -- upvalues: u5 (copy), u3 (copy), u4 (copy), ReplicaFromBindBuffer (copy), u7 (copy)
    local v100;

    if p99 == nil then
        p99 = {};
        v100 = true;
    else
        v100 = false;
    end;

    u5[p98.Id] = nil;
    local Token = p98.Token;
    local v101 = u3[Token];

    if v101 == nil then
        v101 = {};
        u3[Token] = v101;
    end;

    v101[p98] = true;
    u4[p98.Id] = p98;
    table.insert(p99, p98);

    for i in pairs(p98.Children) do
        ReplicaFromBindBuffer(i, p99);
    end;

    if v100 == true then
        for _, v in ipairs(p99) do
            local v102 = u7[v.Token];

            if v102 ~= nil then
                for i in pairs(v102) do
                    ConnectionFire(i, v);
                end;
            end;
        end;
    end;
end;

local function CreationScan(p103, p104, p105) -- Line: 621
    -- upvalues: CreationScan (copy)
    local v106 = p103[p105];

    if v106 ~= nil then
        table.sort(v106, function(p107, p108) -- Line: 625
            return p107.Id < p108.Id;
        end);

        for _, v in ipairs(v106) do
            p104(v.Id, v.SelfCreation);
            CreationScan(p103, p104, v.Id);
        end;
    end;
end;

local function BreadthCreationSort(p109, p110, p111) -- Line: 637
    -- upvalues: CreationScan (copy)
    local v112 = {};
    local v113 = {};
    local v114 = {};

    if type(p109[1]) == "table" then
        for _, v in ipairs(p109) do
            for i, v2 in pairs(v) do
                local v115 = {
                    Id = tonumber(i),
                    SelfCreation = v2
                };
                local v116 = v2[4];

                if v116 == 0 or v115.Id == p110 then
                    table.insert(v112, v115);
                elseif v[tostring(v116)] == nil then
                    table.insert(v114, v115);
                else
                    local v117 = v113[v116];

                    if v117 == nil then
                        v117 = {};
                        v113[v116] = v117;
                    end;

                    table.insert(v117, v115);
                end;
            end;
        end;
    else
        for i, v in pairs(p109) do
            local v118 = {
                Id = tonumber(i),
                SelfCreation = v
            };
            local v119 = v[4];

            if v119 == 0 or v118.Id == p110 then
                table.insert(v112, v118);
            elseif p109[tostring(v119)] == nil then
                table.insert(v114, v118);
            else
                local v120 = v113[v119];

                if v120 == nil then
                    v120 = {};
                    v113[v119] = v120;
                end;

                table.insert(v120, v118);
            end;
        end;
    end;

    table.sort(v112, function(p121, p122) -- Line: 688
        return p121.Id < p122.Id;
    end);
    local v123 = {};

    for _, v in ipairs(v112) do
        p111(v.Id, v.SelfCreation);
        CreationScan(v113, p111, v.Id);
    end;

    if #v114 ~= 0 then
        local v124 = `[{script.Name}]: GROUP REPLICATION ERROR - Missing parents for:\n`;

        for i = 1, math.min(#v114, 50) do
            local v125 = v114[i];
            local SelfCreation = v125.SelfCreation;
            local v126 = "";
            local v127 = true;

            for i2, v in pairs(SelfCreation[2]) do
                v126 = v126 .. `{v127 == true and "" or ";"}{tostring(i2)}={tostring(v)}`;
                v127 = false;
            end;

            v124 = v124 .. `[Id:{v125.Id};ParentId:{SelfCreation[4]};Token:{SelfCreation[1]};Tags:\{{v126}}]\n`;
        end;

        if #v114 > 50 then
            v124 = v124 .. `(hiding {50 - #v114} more)\n`;
        end;

        local v128 = v124 .. "Traceback:\n" .. debug.traceback();
        warn(v128);
    end;

    return v123;
end;

local function GetInternalReplica(p129) -- Line: 729
    -- upvalues: u4 (copy), u5 (copy)
    local v130 = u4[p129] or u5[p129];

    if v130 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p129}]`));
    end;

    return v130;
end;

u8.OnClientEvent:Connect(function() -- Line: 739
    -- upvalues: u39 (copy)
    if u39.IsReady == true then
        return;
    end;

    u39.IsReady = true;
    print((`[{script.Name}]: Initial data received`));
    u39.OnLocalReady:Fire();
end);
v9.OnClientEvent:Connect(function(p131, p132, p133) -- Line: 751
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v134 = u4[p131] or u5[p131];

    if v134 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p131}]`));
    end;

    u21 = true;
    local success, result = pcall(v134.Set, v134, p132, p133);
    u21 = false;

    if success ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v134:Identify()}\n` .. result);
    end;
end);
v10.OnClientEvent:Connect(function(p135, p136, p137) -- Line: 761
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v138 = u4[p135] or u5[p135];

    if v138 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p135}]`));
    end;

    u21 = true;
    local success, result = pcall(v138.SetValues, v138, p136, p137);
    u21 = false;

    if success ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v138:Identify()}\n` .. result);
    end;
end);
v11.OnClientEvent:Connect(function(p139, p140, p141, p142) -- Line: 771
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v143 = u4[p139] or u5[p139];

    if v143 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p139}]`));
    end;

    u21 = true;
    local success, result = pcall(v143.TableInsert, v143, p140, p141, p142);
    u21 = false;

    if success ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v143:Identify()}\n` .. result);
    end;
end);
v12.OnClientEvent:Connect(function(p144, p145, p146) -- Line: 781
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v147 = u4[p144] or u5[p144];

    if v147 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p144}]`));
    end;

    u21 = true;
    local success, result = pcall(v147.TableRemove, v147, p145, p146);
    u21 = false;

    if success ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v147:Identify()}\n` .. result);
    end;
end);
v13.OnClientEvent:Connect(function(p148, p149, ...) -- Line: 791
    -- upvalues: u4 (copy), u5 (copy), u21 (ref)
    local v150 = u4[p148] or u5[p148];

    if v150 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p148}]`));
    end;

    u21 = true;
    local success, result = pcall(v150.Write, v150, v150.write_lib[p149].Name, ...);
    u21 = false;

    if success ~= true then
        error(`[{script.Name}]: Error while updating replica:\n{v150:Identify()}\n` .. result);
    end;
end);

local function RemoteSignalHandle(p151, ...) -- Line: 802
    -- upvalues: u4 (copy), u5 (copy)
    local v152 = u4[p151] or u5[p151];

    if v152 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p151}]`));
    end;

    v152.OnClientEvent:Fire(...);
end;

u14.OnClientEvent:Connect(RemoteSignalHandle);
u19.OnClientEvent:Connect(RemoteSignalHandle);
v15.OnClientEvent:Connect(function(p153, p154) -- Line: 810
    -- upvalues: u4 (copy), u5 (copy), ReplicaFromBindBuffer (copy), ReplicaToBindBuffer (copy)
    local v155 = u4[p153] or u5[p153];

    if v155 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p153}]`));
    end;

    local Parent = v155.Parent;
    local v156 = u4[p154] or u5[p154];

    if v156 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p154}]`));
    end;

    Parent.Children[v155] = nil;
    v156.Children[v155] = true;
    v155.Parent = v156;
    v155.self_creation[4] = p154;

    if u5[Parent.Id] == nil or u4[p154] == nil then
        if u4[Parent.Id] ~= nil and u5[p154] ~= nil then
            ReplicaToBindBuffer(v155);
        end;

        return;
    end;

    ReplicaFromBindBuffer(v155);
end);
v16.OnClientEvent:Connect(function(p157, p158) -- Line: 831
    -- upvalues: BreadthCreationSort (copy), ReplicaNew (copy), u6 (copy), u5 (copy), u3 (copy), u4 (copy), u7 (copy)
    local u159 = {};
    BreadthCreationSort(p157, p158, function(p160, p161) -- Line: 835
        -- upvalues: ReplicaNew (ref), u6 (ref), u5 (ref), u3 (ref), u4 (ref), u159 (copy)
        local v162 = p161[4];
        local v163 = ReplicaNew(p160, p161);
        local v164 = false;

        if v162 == 0 then
            if v163.Tags.Bind == true then
                local v165 = u6[p160];
                v163.BoundInstance = v165;
                v164 = v165 == nil and true or v164;
            end;
        else
            v164 = u5[v162] ~= nil and true or v164;
        end;

        if v164 == true then
            u5[p160] = v163;

            return;
        end;

        local Token = v163.Token;
        local v166 = u3[Token];

        if v166 == nil then
            v166 = {};
            u3[Token] = v166;
        end;

        v166[v163] = true;
        u4[p160] = v163;
        table.insert(u159, v163);
    end);

    for _, v in ipairs(u159) do
        local v167 = u7[v.Token];

        if v167 ~= nil then
            for i in pairs(v167) do
                ConnectionFire(i, v);
            end;
        end;
    end;
end);
v17.OnClientEvent:Connect(function(p168) -- Line: 892
    -- upvalues: u4 (copy), u5 (copy), u6 (copy), ReplicaToBindBuffer (copy)
    local v169 = u4[p168] or u5[p168];

    if v169 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p168}]`));
    end;

    v169.Tags.Bind = true;
    local v170 = u6[p168];
    v169.BoundInstance = v170;

    if v170 == nil then
        ReplicaToBindBuffer(v169);
    end;
end);
v18.OnClientEvent:Connect(function(p171) -- Line: 906
    -- upvalues: u4 (copy), u5 (copy), DestroyReplica (copy)
    local v172 = u4[p171] or u5[p171];

    if v172 == nil then
        error((`[{script.Name}]: Received update for missing replica [Id:{p171}]`));
    end;

    DestroyReplica(v172);
end);

local function OnBindInstanceAdded(p173) -- Line: 913
    -- upvalues: u6 (copy), u5 (copy), ReplicaFromBindBuffer (copy)
    local Value = p173.Value;
    local Parent = p173.Parent;
    u6[Value] = Parent;
    local v174 = u5[Value];

    if v174 ~= nil then
        v174.BoundInstance = Parent;
        ReplicaFromBindBuffer(v174);
    end;
end;

local function OnBindInstanceRemoved(p175) -- Line: 928
    -- upvalues: u6 (copy), u4 (copy), ReplicaToBindBuffer (copy)
    local Value = p175.Value;
    u6[Value] = nil;
    local v176 = u4[Value];

    if v176 ~= nil then
        ReplicaToBindBuffer(v176);
    end;
end;

CollectionService:GetInstanceAddedSignal("REPLICA"):Connect(function(p177) -- Line: 941
    -- upvalues: u6 (copy), u5 (copy), ReplicaFromBindBuffer (copy)
    if p177:IsA("NumberValue") == true then
        local Value = p177.Value;
        local Parent = p177.Parent;
        u6[Value] = Parent;
        local v178 = u5[Value];

        if v178 ~= nil then
            v178.BoundInstance = Parent;
            ReplicaFromBindBuffer(v178);
        end;
    end;
end);
CollectionService:GetInstanceRemovedSignal("REPLICA"):Connect(function(p179) -- Line: 947
    -- upvalues: u6 (copy), u4 (copy), ReplicaToBindBuffer (copy)
    if p179:IsA("NumberValue") == true then
        local Value = p179.Value;
        u6[Value] = nil;
        local v180 = u4[Value];

        if v180 ~= nil then
            ReplicaToBindBuffer(v180);
        end;
    end;
end);

for _, v in pairs(CollectionService:GetTagged("REPLICA")) do
    if v:IsA("NumberValue") == true then
        local Value = v.Value;
        local Parent = v.Parent;
        u6[Value] = Parent;
        local v181 = u5[Value];

        if v181 ~= nil then
            v181.BoundInstance = Parent;
            ReplicaFromBindBuffer(v181);
        end;
    end;
end;

return u39;