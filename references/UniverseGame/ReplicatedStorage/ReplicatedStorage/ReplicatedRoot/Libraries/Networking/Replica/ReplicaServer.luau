  

 

local ReplicaShared = script.Parent.ReplicaShared;
local RateLimit = require(ReplicaShared.RateLimit);
local Remote = require(ReplicaShared.Remote);
local Signal = require(ReplicaShared.Signal);
local Maid = require(ReplicaShared.Maid);
local u1 = {};
local u2 = {};
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local u3 = RateLimit.New(120);
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = Remote.New("ReplicaRequestData");
local u10 = Remote.New("ReplicaSet");
local u11 = Remote.New("ReplicaSetValues");
local u12 = Remote.New("ReplicaTableInsert");
local u13 = Remote.New("ReplicaTableRemove");
local u14 = Remote.New("ReplicaWrite");
local u15 = Remote.New("ReplicaSignal");
local u16 = Remote.New("ReplicaParent");
local u17 = Remote.New("ReplicaCreate");
local u18 = Remote.New("ReplicaBind");
local u19 = Remote.New("ReplicaDestroy");
local u20 = Remote.New("ReplicaSignalUnreliable", true);
local u21 = 0;
local u22 = {};
local u23 = false;
local u24 = {};
local u25 = {};
local NumberValue = Instance.new("NumberValue");
NumberValue.Name = "ReplicaBind";
CollectionService:AddTag(NumberValue, "REPLICA");

local function IterateGroup(p26, p27) -- Line: 142
    -- upvalues: IterateGroup (copy)
    p27(p26);

    for i in pairs(p26.Children) do
        IterateGroup(i, p27);
    end;
end;

local function LoadWriteLib(p28) -- Line: 149
    -- upvalues: u22 (copy), ReplicatedStorage (copy)
    local v29 = u22[p28];

    if v29 ~= nil then
        return v29;
    end;

    if typeof(p28) == "Instance" and p28:IsA("ModuleScript") == true then
        if p28:IsDescendantOf(ReplicatedStorage) == false then
            error((`[{script.Name}]: "WriteLib" module must be a descendant of ReplicatedStorage`));
        end;
    else
        error((`[{script.Name}]: "WriteLib" is not a ModuleScript`));
    end;

    local v30 = require(p28);

    if type(v30) ~= "table" then
        error((`[{script.Name}]: A "WriteLib" ModuleScript must return a table`));
    end;

    local v31 = {};

    for i, v in pairs(v30) do
        if type(i) == "string" then
            if type(v) ~= "function" then
                error((`[{script.Name}]: "WriteLib" table values must be functions`));
            end;
        else
            error((`[{script.Name}]: "WriteLib" table keys must be strings`));
        end;

        table.insert(v31, { i, v });
    end;

    table.sort(v31, function(p32, p33) -- Line: 180
        return p32[1] < p33[1];
    end);
    local v34 = {};

    for i, v in ipairs(v31) do
        local v35 = {
            Id = i,
            fn = v[2]
        };
        v34[v[1]] = v35;
        v34[i] = v35;
    end;

    u22[p28] = v34;

    return v34;
end;

function GenerateCreation(p36)
    -- upvalues: IterateGroup (copy)
    local u37 = {};
    local u38 = {};
    local self_creation = p36.self_creation;
    self_creation[4] = p36.Parent == nil and 0 or p36.Parent.Id;
    u38[tostring(p36.Id)] = self_creation;
    p36.creation = u38;
    p36.replication = u37;

    local function v40(p39) -- Line: 201
        -- upvalues: u38 (copy), u37 (copy)
        local self_creation2 = p39.self_creation;
        self_creation2[4] = p39.Parent == nil and 0 or p39.Parent.Id;
        u38[tostring(p39.Id)] = self_creation2;
        p39.creation = u38;
        p39.replication = u37;
    end;

    for i in pairs(p36.Children) do
        IterateGroup(i, v40);
    end;
end;

local u41 = {
    ReadyPlayers = u4,
    NewReadyPlayer = Signal.New(),
    RemovingReadyPlayer = Signal.New()
};
u41.__index = u41;
local u42 = {};
u42.__index = u42;
local u43 = {};
u43.__index = u43;

function u41.Token(p44) -- Line: 256
    -- upvalues: u24 (copy), u42 (copy), u25 (copy)
    if type(p44) ~= "string" then
        error((`[{script.Name}]: name must be a string`));
    end;

    if u24[p44] == true then
        error((`[{script.Name}]: Token "{p44}" duplicate`));
    end;

    u24[p44] = true;
    local v45 = setmetatable({
        Name = p44
    }, u42);
    u25[v45] = true;

    return v45;
end;

function u41.New(p46) -- Line: 278
    -- upvalues: u25 (copy), LoadWriteLib (copy), u21 (ref), Signal (copy), Maid (copy), u1 (copy), u41 (copy), u5 (copy)
    local Token = p46.Token;
    local v47 = p46.Tags or {};
    local v48 = p46.Data or {};
    local v49 = nil;

    if u25[Token] == nil then
        error((`[{script.Name}]: "Token" is not valid ({tostring(Token)})`));
    elseif type(v47) == "table" then
        if type(v48) == "table" then
            if v47.Bind ~= nil then
                error((`[{script.Name}]: "Tags.Bind" key is reserved`));
            end;
        else
            error((`[{script.Name}]: "Data" is not a table`));
        end;
    else
        error((`[{script.Name}]: "Tags" is not a table`));
    end;

    if p46.WriteLib ~= nil then
        v49 = LoadWriteLib(p46.WriteLib);
    end;

    u21 = u21 + 1;
    local v50 = {
        Parent = nil,
        BoundInstance = nil,
        creation = nil,
        replication = nil,
        bind_value = nil,
        Tags = v47,
        Data = v48,
        Id = u21,
        Token = Token.Name,
        Children = {},
        OnServerEvent = Signal.New(),
        Maid = Maid.New(u1),
        self_creation = {
            Token.Name,
            v47,
            v48,
            0,
            p46.WriteLib
        },
        write_lib = v49,
        write_lib_module = p46.WriteLib
    };
    local v51 = setmetatable(v50, u41);
    u5[u21] = v51;

    return v51;
end;

function u41.FromId(p52) -- Line: 328
    -- upvalues: u5 (copy)
    return u5[p52];
end;

function u41.Test() -- Line: 332
    -- upvalues: u5 (copy), u6 (copy), u7 (copy), u8 (copy)
    return {
        Replicas = u5,
        TopReplicas = u6,
        ReplicationAllReplicas = u7,
        SelectiveSubscriptions = u8
    };
end;

function u41.Set(p53, p54, p55) -- Line: 341
    -- upvalues: u23 (ref), u4 (copy), u10 (copy)
    local Data = p53.Data;

    for i = 1, #p54 - 1 do
        Data = Data[p54[i]];
    end;

    Data[p54[#p54]] = p55;

    if u23 == false then
        local Id = p53.Id;

        if p53.replication ~= nil then
            if p53.replication.ALL == true then
                for i in pairs(u4) do
                    u10:FireClient(i, Id, p54, p55);
                end;

                return;
            end;

            for i in pairs(p53.replication) do
                u10:FireClient(i, Id, p54, p55);
            end;
        end;
    end;
end;

function u41.SetValues(p56, p57, p58) -- Line: 370
    -- upvalues: u23 (ref), u4 (copy), u11 (copy)
    local Data = p56.Data;

    for _, v in ipairs(p57) do
        Data = Data[v];
    end;

    for i, v in pairs(p58) do
        Data[i] = v;
    end;

    if u23 == false then
        local Id = p56.Id;

        if p56.replication ~= nil then
            if p56.replication.ALL == true then
                for i in pairs(u4) do
                    u11:FireClient(i, Id, p57, p58);
                end;

                return;
            end;

            for i in pairs(p56.replication) do
                u11:FireClient(i, Id, p57, p58);
            end;
        end;
    end;
end;

function u41.TableInsert(p59, p60, p61, p62) -- Line: 401
    -- upvalues: u23 (ref), u4 (copy), u12 (copy)
    local Data = p59.Data;

    for _, v in ipairs(p60) do
        Data = Data[v];
    end;

    if p62 == nil then
        table.insert(Data, p61);
    else
        table.insert(Data, p62, p61);
    end;

    if u23 == false then
        local Id = p59.Id;

        if p59.replication ~= nil then
            if p59.replication.ALL == true then
                for i in pairs(u4) do
                    u12:FireClient(i, Id, p60, p61, p62);
                end;
            else
                for i in pairs(p59.replication) do
                    u12:FireClient(i, Id, p60, p61, p62);
                end;
            end;
        end;
    end;

    return p62 or #Data;
end;

function u41.TableRemove(p63, p64, p65) -- Line: 436
    -- upvalues: u23 (ref), u4 (copy), u13 (copy)
    local Data = p63.Data;

    for _, v in ipairs(p64) do
        Data = Data[v];
    end;

    local v66 = table.remove(Data, p65);

    if u23 == false then
        local Id = p63.Id;

        if p63.replication ~= nil then
            if p63.replication.ALL == true then
                for i in pairs(u4) do
                    u13:FireClient(i, Id, p64, p65);
                end;

                return v66;
            end;

            for i in pairs(p63.replication) do
                u13:FireClient(i, Id, p64, p65);
            end;
        end;
    end;

    return v66;
end;

function u41.Write(p67, p68, ...) -- Line: 467
    -- upvalues: u23 (ref), u4 (copy), u14 (copy)
    local v69 = p67.write_lib[p68];

    if u23 == true then
        return v69.fn(p67, ...);
    end;

    u23 = true;
    local v70 = table.pack(pcall(v69.fn, p67, ...));
    u23 = false;

    if v70[1] ~= true then
        error(`[{script.Name}]: (WriteLib) ` .. tostring(v70[2]));
    end;

    table.remove(v70, 1);
    local Id = p67.Id;
    local Id2 = v69.Id;

    if p67.replication ~= nil then
        if p67.replication.ALL == true then
            for i in pairs(u4) do
                u14:FireClient(i, Id, Id2, ...);
            end;
        else
            for i in pairs(p67.replication) do
                u14:FireClient(i, Id, Id2, ...);
            end;
        end;
    end;

    return table.unpack(v70);
end;

function u41.FireClient(p71, p72, ...) -- Line: 508
    -- upvalues: u4 (copy), u15 (copy)
    if p71.replication ~= nil and (p71.replication.ALL == true and u4[p72] == true or p71.replication[p72] ~= nil) then
        u15:FireClient(p72, p71.Id, ...);
    end;
end;

function u41.FireAllClients(p73, ...) -- Line: 516
    -- upvalues: u4 (copy), u15 (copy)
    local Id = p73.Id;

    if p73.replication ~= nil then
        if p73.replication.ALL == true then
            for i in pairs(u4) do
                u15:FireClient(i, Id, ...);
            end;

            return;
        end;

        for i in pairs(p73.replication) do
            u15:FireClient(i, Id, ...);
        end;
    end;
end;

function u41.UFireClient(p74, p75, ...) -- Line: 531
    -- upvalues: u4 (copy), u20 (copy)
    if p74.replication ~= nil and (p74.replication.ALL == true and u4[p75] == true or p74.replication[p75] ~= nil) then
        u20:FireClient(p75, p74.Id, ...);
    end;
end;

function u41.UFireAllClients(p76, ...) -- Line: 539
    -- upvalues: u4 (copy), u20 (copy)
    local Id = p76.Id;

    if p76.replication ~= nil then
        if p76.replication.ALL == true then
            for i in pairs(u4) do
                u20:FireClient(i, Id, ...);
            end;

            return;
        end;

        for i in pairs(p76.replication) do
            u20:FireClient(i, Id, ...);
        end;
    end;
end;

function u41.SetParent(p77, p78) -- Line: 554
    -- upvalues: u41 (copy), u5 (copy), u6 (copy), IterateGroup (copy), u2 (copy), u4 (copy), u19 (copy), u16 (copy), u17 (copy)
    if type(p78) == "table" and getmetatable(p78) == u41 then
        if u5[p78.Id] == nil then
            error((`[{script.Name}]: Can't set destroyed Replica as parent`));
        end;
    else
        error((`[{script.Name}]: new_parent is not a Replica ({tostring(p78)})`));
    end;

    if u6[p77] ~= nil then
        error((`[{script.Name}]: Can't change parent for top level Replica`));
    end;

    local u79;

    if p77.BoundInstance == nil then
        u79 = p78;
    else
        error((`[{script.Name}]: Can't change parent for bound Replica`));
        u79 = p78;
    end;

    while p78 ~= nil do
        p78 = p78.Parent;

        if p78 == p77 then
            error((`[{script.Name}]: Can't set descendant Replica as parent`));
        end;
    end;

    local Parent = p77.Parent;

    if Parent == u79 then
        return;
    end;

    p77.Parent = u79;

    if Parent ~= nil then
        Parent.Children[p77] = nil;
    end;

    u79.Children[p77] = true;

    local function v82(p80) -- Line: 601
        -- upvalues: Parent (copy), u79 (copy)
        local v81 = tostring(p80.Id);

        if Parent ~= nil and Parent.creation ~= nil then
            Parent.creation[v81] = nil;
        end;

        if u79.creation ~= nil then
            local self_creation = p80.self_creation;
            self_creation[4] = p80.Parent.Id;
            u79.creation[v81] = self_creation;
        end;

        p80.creation = u79.creation;
        p80.replication = u79.replication;
    end;

    local v83 = tostring(p77.Id);

    if Parent ~= nil and Parent.creation ~= nil then
        Parent.creation[v83] = nil;
    end;

    if u79.creation ~= nil then
        local self_creation = p77.self_creation;
        self_creation[4] = p77.Parent.Id;
        u79.creation[v83] = self_creation;
    end;

    p77.creation = u79.creation;
    p77.replication = u79.replication;

    for i in pairs(p77.Children) do
        IterateGroup(i, v82);
    end;

    local Id = p77.Id;
    local Id2 = u79.Id;
    local creation = u79.creation;
    local v84 = u2;

    if Parent ~= nil and Parent.replication ~= nil then
        if Parent.replication.ALL == true then
            v84 = u4;
        else
            v84 = Parent.replication;
        end;
    end;

    local v85 = u2;

    if u79 ~= nil and u79.replication ~= nil then
        if u79.replication.ALL == true then
            v85 = u4;
        else
            v85 = u79.replication;
        end;
    end;

    if Parent ~= nil and (Parent.replication ~= nil and (u79.replication ~= Parent.replication and v85 ~= u4)) then
        for i in pairs(v84) do
            if v85[i] == nil then
                u19:FireClient(i, Id);
            end;
        end;
    end;

    if u79.replication ~= nil then
        local u86 = nil;

        for i in pairs(v85) do
            if v84[i] == true then
                u16:FireClient(i, Id, Id2);
            else
                if u86 == nil then
                    u86 = {};

                    local function v89(p87) -- Line: 668
                        -- upvalues: u86 (ref), creation (copy)
                        local v88 = tostring(p87.Id);
                        u86[v88] = creation[v88];
                    end;

                    local v90 = tostring(p77.Id);
                    u86[v90] = creation[v90];

                    for i2 in pairs(p77.Children) do
                        IterateGroup(i2, v89);
                    end;
                end;

                u17:FireClient(i, u86, Id);
            end;
        end;
    end;
end;

function u41.BindToInstance(p91, p92) -- Line: 682
    -- upvalues: NumberValue (copy), u4 (copy), u18 (copy)
    if typeof(p92) ~= "Instance" then
        error((`[{script.Name}]: "instance" argument is not an Instance ({tostring(p92)})`));
    end;

    if p91.Parent ~= nil then
        error((`[{script.Name}]: Can't bind Replica parented to another Replica`));
    end;

    if p91.BoundInstance ~= nil then
        error((`[{script.Name}]: Can't change Replica bind to another Instance`));
    end;

    if p92:IsA("Model") == true and (p92.ModelStreamingMode == Enum.ModelStreamingMode.Default or p92.ModelStreamingMode == Enum.ModelStreamingMode.Nonatomic) then
        warn(`[{script.Name}]: Bound Replica to a model that has inproper "ModelStreamingMode" setup; Traceback:\n` .. debug.traceback());
    end;

    local v93 = NumberValue:Clone();
    v93.Value = p91.Id;
    p91.Tags.Bind = true;
    p91.BoundInstance = p92;
    p91.bind_value = v93;
    v93.Parent = p92;
    local Id = p91.Id;

    if p91.replication ~= nil then
        if p91.replication.ALL == true then
            for i in pairs(u4) do
                u18:FireClient(i, Id);
            end;

            return;
        end;

        for i in pairs(p91.replication) do
            u18:FireClient(i, Id);
        end;
    end;
end;

function u41.Replicate(p94) -- Line: 724
    -- upvalues: u6 (copy), u4 (copy), u17 (copy), u8 (copy), u7 (copy)
    if p94.Parent ~= nil then
        error((`[{script.Name}]: Can't selectively replicate Replica parented to another Replica`));
    end;

    if p94.creation == nil then
        GenerateCreation(p94);
        u6[p94] = true;
    elseif p94.replication.ALL == true then
        return;
    end;

    local creation = p94.creation;
    local replication = p94.replication;

    for i in pairs(u4) do
        if replication[i] == nil then
            u17:FireClient(i, creation);
        else
            u8[i][p94] = nil;
        end;
    end;

    table.clear(replication);
    replication.ALL = true;
    u7[p94] = true;
end;

function u41.DontReplicate(p95) -- Line: 755
    -- upvalues: u7 (copy), u4 (copy), u19 (copy), u8 (copy)
    if p95.Parent ~= nil then
        error((`[{script.Name}]: Can't selectively replicate Replica parented to another Replica`));
    end;

    local replication = p95.replication;

    if replication == nil or next(replication) == nil then
        return;
    end;

    u7[p95] = nil;
    local Id = p95.Id;

    if replication.ALL == true then
        for i in pairs(u4) do
            u19:FireClient(i, Id);
        end;
    else
        for i in pairs(replication) do
            u19:FireClient(i, Id);
            u8[i][p95] = nil;
        end;
    end;

    table.clear(replication);
end;

function u41.Subscribe(p96, p97) -- Line: 786
    -- upvalues: u6 (copy), u4 (copy), u8 (copy), u17 (copy)
    if p96.Parent ~= nil then
        error((`[{script.Name}]: Can't selectively replicate Replica parented to another Replica`));
    end;

    if p96.creation == nil then
        GenerateCreation(p96);
        u6[p96] = true;
    elseif p96.replication.ALL == true then
        error((`[{script.Name}]: "Subscribe()" is locked after calling "Replicate()"`));
    end;

    if u4[p97] == nil then
        warn(`[{script.Name}]: Called "Subscribe()" on a non-ready player; Traceback:\n` .. debug.traceback());

        return;
    end;

    local creation = p96.creation;
    local replication = p96.replication;

    if replication[p97] ~= nil then
        return;
    end;

    replication[p97] = true;
    u8[p97][p96] = true;
    u17:FireClient(p97, creation);
end;

function u41.Unsubscribe(p98, p99) -- Line: 817
    -- upvalues: u8 (copy), u19 (copy)
    if p98.Parent ~= nil then
        error((`[{script.Name}]: Can't selectively replicate Replica parented to another Replica`));
    end;

    local replication = p98.replication;

    if replication == nil then
        return;
    end;

    if replication.ALL == true then
        error((`[{script.Name}]: "Unsubscribe()" is locked after calling "Replicate()"`));
    end;

    if replication[p99] ~= nil then
        replication[p99] = nil;
        u8[p99][p98] = nil;
        u19:FireClient(p99, p98.Id);
    end;
end;

function u41.Identify(p100) -- Line: 841
    local v101 = "";
    local v102 = true;

    for i, v in pairs(p100.Tags) do
        v101 = v101 .. `{v102 == true and "" or ";"}{tostring(i)}={tostring(v)}`;
        v102 = false;
    end;

    return `[Id:{p100.Id};Token:{p100.Token};Tags:\{{v101}}]`;
end;

function u41.IsActive(p103) -- Line: 851
    return p103.Maid:IsActive();
end;

local function DestroyReplica(p104) -- Line: 855
    -- upvalues: DestroyReplica (copy), u5 (copy), u1 (copy), u43 (copy)
    for i in pairs(p104.Children) do
        DestroyReplica(i);
    end;

    local Id = p104.Id;
    u5[Id] = nil;
    p104.Maid:Unlock(u1);
    p104.Maid:Cleanup();

    if p104.BoundInstance ~= nil then
        p104.BoundInstance = nil;
        p104.bind_value:Destroy();
        p104.bind_value = nil;
    end;

    if p104.creation ~= nil then
        p104.creation[tostring(Id)] = nil;
    end;

    setmetatable(p104, u43);
end;

function u41.Destroy(p105) -- Line: 881
    -- upvalues: u5 (copy), u6 (copy), u4 (copy), u19 (copy), u8 (copy), u7 (copy), DestroyReplica (copy)
    local Id = p105.Id;

    if u5[Id] == nil then
        return;
    end;

    local v106 = u6[p105] == true;

    if p105.replication ~= nil then
        if p105.replication.ALL == true then
            for i in pairs(u4) do
                u19:FireClient(i, Id);
            end;
        else
            for i in pairs(p105.replication) do
                u19:FireClient(i, Id);

                if v106 == true then
                    u8[i][p105] = nil;
                end;
            end;
        end;
    end;

    u6[p105] = nil;
    u7[p105] = nil;

    if p105.Parent ~= nil then
        p105.Parent.Children[p105] = nil;
    end;

    DestroyReplica(p105);
end;

local v107 = {
    Identify = true,
    Destroy = true
};

for i, v in pairs(u41) do
    if i ~= "__index" then
        if v107[i] == true then
            u43[i] = v;
        else
            u43[i] = function(p108) -- Line: 937
                -- upvalues: i (copy)
                error((`[{script.Name}]: Tried to call method "{i}" for a destroyed replica; {p108:Identify()}`));
            end;
        end;
    end;
end;

u9.OnServerEvent:Connect(function(p109) -- Line: 948
    -- upvalues: u4 (copy), Players (copy), u7 (copy), u17 (copy), u9 (copy), u8 (copy), u41 (copy)
    if u4[p109] ~= nil and p109:IsDescendantOf(Players) == true then
        return;
    end;

    local v110 = {};

    for i in pairs(u7) do
        table.insert(v110, i.creation);
    end;

    u17:FireClient(p109, v110);
    u9:FireClient(p109);
    u4[p109] = true;
    u8[p109] = {};
    u41.NewReadyPlayer:Fire(p109);
end);

local function RemoteSignalHandle(p111, p112, ...) -- Line: 976
    -- upvalues: u4 (copy), u3 (copy), u5 (copy)
    if u4[p111] == nil or (u3:CheckRate(p111) == false or type(p112) ~= "number") then
        return;
    end;

    local v113 = u5[p112];

    if v113 ~= nil and (v113.replication ~= nil and (v113.replication.ALL == true or v113.replication[p111] ~= nil)) then
        v113.OnServerEvent:Fire(p111, ...);
    end;
end;

u15.OnServerEvent:Connect(RemoteSignalHandle);
u20.OnServerEvent:Connect(RemoteSignalHandle);
Players.PlayerRemoving:Connect(function(p114) -- Line: 999
    -- upvalues: u4 (copy), u8 (copy), u41 (copy)
    if u4[p114] == nil then
        return;
    end;

    for i in pairs(u8[p114]) do
        i.replication[p114] = nil;
    end;

    u4[p114] = nil;
    u8[p114] = nil;
    u41.RemovingReadyPlayer:Fire(p114);
end);

return u41;