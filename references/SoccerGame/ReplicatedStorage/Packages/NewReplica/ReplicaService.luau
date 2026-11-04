  

local RunService = game:GetService("RunService");

local function WaitForDescendant(p1, u2, p3) -- Line: 138
    -- upvalues: RunService (copy)
    local u4 = p1:FindFirstChild(u2, true);

    if u4 ~= nil then
        return u4;
    end;

    local os_clock_ret = os.clock();
    local v6 = p1.DescendantAdded:Connect(function(p5) -- Line: 143
        -- upvalues: u2 (copy), u4 (ref)
        if p5.Name == u2 then
            u4 = p5;
        end;
    end);

    while u4 == nil do
        if os_clock_ret ~= nil and (os.clock() - os_clock_ret > 1 and (RunService:IsServer() == true or game:IsLoaded() == true)) then
            warn("[" .. script.Name .. "]: Missing " .. p3 .. " \"" .. u2 .. "\" in " .. p1:GetFullName() .. "; Please check setup documentation");
            os_clock_ret = nil;
        end;

        task.wait();
    end;

    v6:Disconnect();

    return u4;
end;

local u7;

if RunService:IsServer() == true then
    u7 = Instance.new("Folder");
    u7.Name = "ReplicaRemoteEvents";
    u7.Parent = game:GetService("ReplicatedStorage");
else
    u7 = WaitForDescendant(game:GetService("ReplicatedStorage"), "ReplicaRemoteEvents", "folder");
end;

local u13 = {
    GetShared = function(p8, p9) -- Line: 174, Name: GetShared
        -- upvalues: WaitForDescendant (copy)
        return WaitForDescendant(game:GetService("ReplicatedStorage"), p9, "module");
    end,

    GetModule = function(p10, p11) -- Line: 178, Name: GetModule
        -- upvalues: WaitForDescendant (copy)
        return WaitForDescendant(game:GetService("ServerScriptService"), p11, "module");
    end,

    SetupRemoteEvent = function(p12) -- Line: 181, Name: SetupRemoteEvent
        -- upvalues: RunService (copy), u7 (ref), WaitForDescendant (copy)
        if RunService:IsServer() ~= true then
            return WaitForDescendant(u7, p12, "remote event");
        end;

        local RemoteEvent = Instance.new("RemoteEvent");
        RemoteEvent.Name = p12;
        RemoteEvent.Parent = u7;

        return RemoteEvent;
    end,

    Shared = {}
};
local Shared = require(u13.GetShared("Madwork", "MadworkScriptSignal"));
u13.NewScriptSignal = Shared.NewScriptSignal;
u13.NewArrayScriptConnection = Shared.NewArrayScriptConnection;
local u14 = {
    _replica_class = nil,
    ActivePlayers = {},
    NewActivePlayerSignal = u13.NewScriptSignal(),
    RemovedActivePlayerSignal = u13.NewScriptSignal(),
    PlayerRequestedData = u13.NewScriptSignal(),
    _replicas = {},
    _top_level_replicas = {}
};
local Shared2 = require(u13.GetShared("Madwork", "RateLimiter"));
local Shared3 = require(u13.GetShared("Madwork", "MadworkMaid"));
local Default = Shared2.Default;
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ActivePlayers = u14.ActivePlayers;
local _replicas = u14._replicas;
local _top_level_replicas = u14._top_level_replicas;
local u15 = u13.SetupRemoteEvent("Replica_ReplicaRequestData");
local u16 = u13.SetupRemoteEvent("Replica_ReplicaSetValue");
local u17 = u13.SetupRemoteEvent("Replica_ReplicaSetValues");
local u18 = u13.SetupRemoteEvent("Replica_ReplicaArrayInsert");
local u19 = u13.SetupRemoteEvent("Replica_ReplicaArraySet");
local u20 = u13.SetupRemoteEvent("Replica_ReplicaArrayRemove");
local u21 = u13.SetupRemoteEvent("Replica_ReplicaWrite");
local u22 = u13.SetupRemoteEvent("Replica_ReplicaSignal");
local u23 = u13.SetupRemoteEvent("Replica_ReplicaSetParent");
local u24 = u13.SetupRemoteEvent("Replica_ReplicaCreate");
local u25 = u13.SetupRemoteEvent("Replica_ReplicaDestroy");
local u26 = 0;
local u27 = {};
local u28 = false;
local u29 = {};
local u30 = {};
u30.__index = u30;

local function ParseReplicaBranch(p31, p32) -- Line: 293
    -- upvalues: ParseReplicaBranch (copy)
    p32(p31);

    for _, v in ipairs(p31.Children) do
        ParseReplicaBranch(v, p32);
    end;
end;

local function GetWriteLibFunctionsRecursive(p33, p34, p35) -- Line: 300
    -- upvalues: GetWriteLibFunctionsRecursive (copy)
    for i, v in pairs(p34) do
        if type(v) == "table" then
            GetWriteLibFunctionsRecursive(p33, v, p35 .. i .. ".");
        elseif type(v) == "function" then
            table.insert(p33, { p35 .. i, v });
        else
            error("[ReplicaService]: Invalid write function value \"" .. tostring(v) .. "\" (" .. typeof(v) .. "); name_stack = \"" .. p35 .. "\"");
        end;
    end;
end;

local function LoadWriteLib(p36) -- Line: 312
    -- upvalues: u27 (copy), ReplicatedStorage (copy), u13 (ref), GetWriteLibFunctionsRecursive (copy)
    local v37 = u27[p36];

    if v37 ~= nil then
        return v37;
    end;

    if p36.ClassName ~= "ModuleScript" then
        error("[ReplicaService]: Invalid write_lib_module argument");
    end;

    if p36:IsDescendantOf(ReplicatedStorage) == false then
        local v38 = false;

        for _, v in pairs(u13.Shared) do
            if p36:IsDescendantOf(v) == true then
                v38 = true;
                break;
            end;
        end;

        if v38 == false then
            error("[ReplicaService]: Write library module must be a descendant of ReplicatedStorage or \"Shared\" directory");
        end;
    end;

    local v39 = require(p36);

    if type(v39) ~= "table" then
        error("[ReplicaService]: A write library ModuleScript must return a table");
    end;

    local v40 = {};
    GetWriteLibFunctionsRecursive(v40, v39, "");
    table.sort(v40, function(p41, p42) -- Line: 343
        return p41[1] < p42[1];
    end);
    local v43 = {};

    for i, v in ipairs(v40) do
        v43[v[1]] = { i, v[2] };
    end;

    u27[p36] = v43;

    return v43;
end;

local function StringPathToArray(p44) -- Line: 358
    local v45 = {};

    if p44 ~= "" then
        for i in string.gmatch(p44, "[^%.]+") do
            table.insert(v45, i);
        end;
    end;

    return v45;
end;

local function DestroyReplicaAndDescendantsRecursive(p46, p47) -- Line: 368
    -- upvalues: DestroyReplicaAndDescendantsRecursive (copy), _replicas (copy), _top_level_replicas (copy), u30 (copy)
    for _, v in ipairs(p46.Children) do
        DestroyReplicaAndDescendantsRecursive(v, true);
    end;

    local Id = p46.Id;
    _replicas[Id] = nil;
    p46._maid:Cleanup();
    p46._creation_data[tostring(Id)] = nil;

    if p47 ~= true then
        if p46.Parent == nil then
            _top_level_replicas[Id] = nil;
        else
            local Children = p46.Parent.Children;
            table.remove(Children, table.find(Children, p46));
        end;
    end;

    setmetatable(p46, u30);
end;

local u48 = {};
u48.__index = u48;
u14._replica_class = u48;

function u48.SetValue(p49, p50, p51) -- Line: 403
    -- upvalues: StringPathToArray (copy), u28 (ref), ActivePlayers (copy), u16 (copy)
    if type(p50) == "string" then
        p50 = StringPathToArray(p50) or p50;
    end;

    local Data = p49.Data;

    for i = 1, #p50 - 1 do
        Data = Data[p50[i]];
        local _ = i;
    end;

    Data[p50[#p50]] = p51;

    if u28 == false then
        local Id = p49.Id;

        if p49._replication.All == true then
            for i in pairs(ActivePlayers) do
                u16:FireClient(i, Id, p50, p51);
            end;

            return;
        end;

        for i in pairs(p49._replication) do
            u16:FireClient(i, Id, p50, p51);
        end;
    end;
end;

function u48.SetValues(p52, p53, p54) -- Line: 426
    -- upvalues: StringPathToArray (copy), u28 (ref), ActivePlayers (copy), u17 (copy)
    if type(p53) == "string" then
        p53 = StringPathToArray(p53) or p53;
    end;

    local Data = p52.Data;

    for i = 1, #p53 do
        Data = Data[p53[i]];
        local _ = i;
    end;

    for i, v in pairs(p54) do
        Data[i] = v;
    end;

    if u28 == false then
        local Id = p52.Id;

        if p52._replication.All == true then
            for i in pairs(ActivePlayers) do
                u17:FireClient(i, Id, p53, p54);
            end;

            return;
        end;

        for i in pairs(p52._replication) do
            u17:FireClient(i, Id, p53, p54);
        end;
    end;
end;

function u48.ArrayInsert(p55, p56, p57) -- Line: 452
    -- upvalues: StringPathToArray (copy), u28 (ref), ActivePlayers (copy), u18 (copy)
    if type(p56) == "string" then
        p56 = StringPathToArray(p56) or p56;
    end;

    local Data = p55.Data;

    for i = 1, #p56 do
        Data = Data[p56[i]];
        local _ = i;
    end;

    table.insert(Data, p57);

    if u28 == false then
        local Id = p55.Id;

        if p55._replication.All == true then
            for i in pairs(ActivePlayers) do
                u18:FireClient(i, Id, p56, p57);
            end;
        else
            for i in pairs(p55._replication) do
                u18:FireClient(i, Id, p56, p57);
            end;
        end;
    end;

    return #Data;
end;

function u48.ArraySet(p58, p59, p60, p61) -- Line: 476
    -- upvalues: StringPathToArray (copy), u28 (ref), ActivePlayers (copy), u19 (copy)
    if type(p59) == "string" then
        p59 = StringPathToArray(p59) or p59;
    end;

    local Data = p58.Data;

    for i = 1, #p59 do
        Data = Data[p59[i]];
        local _ = i;
    end;

    if Data[p60] == nil then
        error("[ReplicaService]: Replica:ArraySet() can only be used for existing indexes");
    else
        Data[p60] = p61;
    end;

    if u28 == false then
        local Id = p58.Id;

        if p58._replication.All == true then
            for i in pairs(ActivePlayers) do
                u19:FireClient(i, Id, p59, p60, p61);
            end;

            return;
        end;

        for i in pairs(p58._replication) do
            u19:FireClient(i, Id, p59, p60, p61);
        end;
    end;
end;

function u48.ArrayRemove(p62, p63, p64) -- Line: 503
    -- upvalues: StringPathToArray (copy), u28 (ref), ActivePlayers (copy), u20 (copy)
    if type(p63) == "string" then
        p63 = StringPathToArray(p63) or p63;
    end;

    local Data = p62.Data;

    for i = 1, #p63 do
        Data = Data[p63[i]];
        local _ = i;
    end;

    local table_remove_ret = table.remove(Data, p64);

    if u28 == false then
        local Id = p62.Id;

        if p62._replication.All == true then
            for i in pairs(ActivePlayers) do
                u20:FireClient(i, Id, p63, p64);
            end;

            return table_remove_ret;
        end;

        for i in pairs(p62._replication) do
            u20:FireClient(i, Id, p63, p64);
        end;
    end;

    return table_remove_ret;
end;

function u48.Write(p65, p66, ...) -- Line: 528
    -- upvalues: u28 (ref), ActivePlayers (copy), u21 (copy)
    if u28 == true then
        return p65._write_lib[p66][2](p65, ...);
    end;

    u28 = true;
    local table_pack_ret = table.pack(p65._write_lib[p66][2](p65, ...));
    u28 = false;
    local Id = p65.Id;
    local v67 = p65._write_lib[p66][1];

    if p65._replication.All == true then
        for i in pairs(ActivePlayers) do
            u21:FireClient(i, Id, v67, ...);
        end;
    else
        for i in pairs(p65._replication) do
            u21:FireClient(i, Id, v67, ...);
        end;
    end;

    return table.unpack(table_pack_ret);
end;

function u48.ConnectOnServerEvent(p68, p69) -- Line: 552
    -- upvalues: u13 (ref)
    if type(p69) ~= "function" then
        error("[ReplicaService]: Only functions can be passed to Replica:ConnectOnServerEvent()");
    end;

    table.insert(p68._signal_listeners, p69);

    return u13.NewArrayScriptConnection(p68._signal_listeners, p69);
end;

function u48.FireClient(p70, p71, ...) -- Line: 560
    -- upvalues: ActivePlayers (copy), u22 (copy)
    if p70._replication.All == true and ActivePlayers[p71] == true or p70._replication[p71] ~= nil then
        u22:FireClient(p71, p70.Id, ...);
    end;
end;

function u48.FireAllClients(p72, ...) -- Line: 567
    -- upvalues: ActivePlayers (copy), u22 (copy)
    local Id = p72.Id;

    if p72._replication.All == true then
        for i in pairs(ActivePlayers) do
            u22:FireClient(i, Id, ...);
        end;

        return;
    end;

    for i in pairs(p72._replication) do
        u22:FireClient(i, Id, ...);
    end;
end;

function u48.SetParent(p73, p74) -- Line: 582
    -- upvalues: ParseReplicaBranch (copy), ActivePlayers (copy), u23 (copy), u24 (copy), u25 (copy)
    local v75 = type(p74) == "table";
    assert(v75, "[ReplicaService]: Invalid parent_replica");
    assert(p74._replication ~= nil, "[ReplicaService]: Invalid parent_replica");
    local v76 = p74;

    while p74 ~= nil do
        p74 = p74.Parent;

        if p74 == p73 then
            error("[ReplicaService]: Can\'t parent replica to it\'s descendant");
        end;
    end;

    local Parent = p73.Parent;

    if Parent == nil then
        error("[ReplicaService]: Can\'t change parent for top level replicas");
    end;

    if v76 == Parent then
        return;
    end;

    local Id = p73.Id;
    p73.Parent = v76;
    table.remove(Parent.Children, table.find(Parent.Children, p73));
    table.insert(v76.Children, p73);
    local _replication = Parent._replication;
    local _replication2 = v76._replication;

    if _replication == _replication2 then
        p73._creation_data[tostring(Id)][4] = v76.Id;

        if _replication.All == true then
            for i in pairs(ActivePlayers) do
                u23:FireClient(i, Id, v76.Id);
            end;

            return;
        end;

        for i in pairs(_replication) do
            u23:FireClient(i, Id, v76.Id);
        end;
    else
        local _creation_data = Parent._creation_data;
        local _creation_data2 = v76._creation_data;
        p73._creation_data = _creation_data2;
        local u77 = {};
        local v78 = tostring(p73.Id);
        u77[v78] = _creation_data[v78];
        p73._replication = _replication2;
        p73._creation_data = _creation_data2;

        local function v81(p79) -- Line: 611
            -- upvalues: u77 (copy), _creation_data (copy), _replication2 (copy), _creation_data2 (copy)
            local v80 = tostring(p79.Id);
            u77[v80] = _creation_data[v80];
            p79._replication = _replication2;
            p79._creation_data = _creation_data2;
        end;

        for _, v in ipairs(p73.Children) do
            ParseReplicaBranch(v, v81);
        end;

        u77[tostring(Id)][4] = v76.Id;

        for i, v in pairs(u77) do
            _creation_data[i] = nil;
            _creation_data2[i] = v;
        end;

        local v82 = ActivePlayers;

        if _replication2.All == true then
            if _replication.All ~= true then
                v82 = _replication;
            end;
        else
            v82 = _replication2;
        end;

        for i in pairs(v82) do
            if (_replication[i] == true or _replication.All == true) and (_replication2[i] == true or _replication2.All == true) then
                u23:FireClient(i, Id, v76.Id);
            end;
        end;

        local v83 = {};

        if _replication.All ~= true then
            if _replication2.All == true then
                for i in pairs(ActivePlayers) do
                    if _replication[i] ~= true then
                        v83[i] = true;
                    end;
                end;
            else
                for i in pairs(_replication2) do
                    if _replication[i] ~= true then
                        v83[i] = true;
                    end;
                end;
            end;
        end;

        for i in pairs(v83) do
            u24:FireClient(i, Id, u77);
        end;

        if _replication2.All ~= true then
            if _replication.All == true then
                for i in pairs(ActivePlayers) do
                    if _replication2[i] ~= true then
                        u25:FireClient(i, Id);
                    end;
                end;

                return;
            end;

            for i in pairs(_replication) do
                if _replication2[i] ~= true then
                    u25:FireClient(i, Id);
                end;
            end;
        end;
    end;
end;

function u48.ReplicateFor(p84, p85) -- Line: 687
    -- upvalues: _replicas (copy), ActivePlayers (copy), u24 (copy)
    if p84.Parent ~= nil then
        error("[ReplicaService]: Replica:ReplicateFor() can only be used for top level replicas");
    end;

    if _replicas[p84.Id] == nil then
        error("[ReplicaService]: Can\'t change replication settings for a destroyed replica");
    end;

    local _replication = p84._replication;
    local _pending_replication = p84._pending_replication;

    if _replication.All == true then
        if p85 ~= "All" then
            error("[ReplicaService]: Don\'t selectively replicate for clients when replica is replicated to All - :DestroyFor(\"All\") first");
        end;
    else
        if p85 == "All" then
            local Id = p84.Id;

            for i in pairs(ActivePlayers) do
                if _replication[i] == nil then
                    u24:FireClient(i, Id, p84._creation_data);
                end;
            end;

            for i in pairs(_replication) do
                _replication[i] = nil;
            end;

            for i in pairs(_pending_replication) do
                _pending_replication[i] = nil;
            end;

            _replication.All = true;

            return;
        end;

        if ActivePlayers[p85] == true then
            if _replication[p85] == nil then
                _replication[p85] = true;
                u24:FireClient(p85, p84.Id, p84._creation_data);
            end;
        elseif typeof(p85) == "Instance" then
            if p85.ClassName ~= "Player" then
                error("[ReplicaService]: Invalid param argument");
            end;

            _pending_replication[p85] = true;
        end;
    end;
end;

function u48.DestroyFor(p86, p87) -- Line: 734
    -- upvalues: _replicas (copy), ActivePlayers (copy), u25 (copy)
    if p86.Parent ~= nil then
        error("[ReplicaService]: Replica:DestroyFor() can only be used for top level replicas");
    end;

    if _replicas[p86.Id] == nil then
        error("[ReplicaService]: Can\'t change replication settings for a destroyed replica");
    end;

    local _replication = p86._replication;

    if _replication[p87] ~= nil and ActivePlayers[p87] == true then
        _replication[p87] = nil;
        u25:FireClient(p87, p86.Id);

        return;
    end;

    if p87 ~= "All" then
        if _replication.All == true then
            error("[ReplicaService]: Don\'t selectively destroy for clients when replica is replicated to All");

            return;
        end;

        if typeof(p87) == "Instance" then
            if p87.ClassName ~= "Player" then
                error("[ReplicaService]: Invalid param argument");
            end;

            p86._pending_replication[p87] = nil;
        end;

        return;
    end;

    local Id = p86.Id;

    if _replication.All ~= true then
        for i in pairs(_replication) do
            _replication[i] = nil;
            u25:FireClient(i, Id);
        end;

        return;
    end;

    _replication.All = nil;

    for i in pairs(ActivePlayers) do
        u25:FireClient(i, Id);
    end;
end;

function u48.Identify(p88) -- Line: 773
    local v89 = "";

    for i, v in pairs(p88.Tags) do
        v89 = v89 .. "" .. tostring(i) .. "=" .. tostring(v);
    end;

    return "[Id:" .. tostring(p88.Id) .. ";Class:" .. p88.Class .. ";Tags:{" .. v89 .. "}]";
end;

function u48.IsActive(p90) -- Line: 784
    -- upvalues: _replicas (copy)
    return _replicas[p90.Id] ~= nil;
end;

function u48.AddCleanupTask(p91, p92) -- Line: 788
    return p91._maid:AddCleanupTask(p92);
end;

function u48.RemoveCleanupTask(p93, p94) -- Line: 792
    p93._maid:RemoveCleanupTask(p94);
end;

function u48.Destroy(p95) -- Line: 796
    -- upvalues: _replicas (copy), ActivePlayers (copy), u25 (copy), DestroyReplicaAndDescendantsRecursive (copy)
    local Id = p95.Id;

    if _replicas[Id] == nil then
        return;
    end;

    if p95._replication.All == true then
        for i in pairs(ActivePlayers) do
            u25:FireClient(i, Id);
        end;
    else
        for i in pairs(p95._replication) do
            u25:FireClient(i, Id);
        end;
    end;

    DestroyReplicaAndDescendantsRecursive(p95);
end;

function u14.NewClassToken(p96) -- Line: 817
    -- upvalues: u29 (copy)
    if type(p96) ~= "string" then
        error("[ReplicaService]: class_name must be a string");
    end;

    if u29[p96] == true then
        error("[ReplicaService]: Token for replica class \"" .. p96 .. "\" was already created");
    end;

    u29[p96] = true;

    return {
        Class = p96
    };
end;

function u14.NewReplica(p97) -- Line: 830
    -- upvalues: u26 (ref), _replicas (copy), ActivePlayers (copy), LoadWriteLib (copy), Shared3 (copy), u48 (copy), u24 (copy), _top_level_replicas (copy)
    local ClassToken = p97.ClassToken;
    local v98 = p97.Tags or {};
    local v99 = p97.Data or {};
    local Replication = p97.Replication;

    if type(ClassToken) ~= "table" or type(ClassToken.Class) ~= "string" then
        error("[ReplicaService]: missing or invalid replica_params.ClassToken argument");
    end;

    if type(v98) ~= "table" then
        error("[ReplicaService]: replica_params.Tags must be a table");
    end;

    if type(v99) ~= "table" then
        error("[ReplicaService]: replica_params.Data must be a table");
    end;

    local Class = ClassToken.Class;
    u26 = u26 + 1;
    local Parent = p97.Parent;
    local v100 = nil;
    local v101 = nil;

    if Parent ~= nil and _replicas[Parent.Id] == nil then
        error("[ReplicaService]: Passed replica_params.Parent replica is destroyed");
    end;

    if Parent == nil or Replication == nil then
        if Replication == nil then
            v100 = {};
            v101 = {};
        elseif type(Replication) == "table" then
            if Replication.All ~= nil then
                error("[ReplicaService]: To replicate replica to all, do replica_params.Replication = \"All\"");
            end;

            v101 = {};
            v100 = {};

            for i in pairs(Replication) do
                if typeof(i) ~= "Instance" or i.ClassName ~= "Player" then
                    error("[ReplicaService]: Invalid replica_params.Replication");
                end;

                if ActivePlayers[i] == true then
                    v100[i] = true;
                else
                    v101[i] = true;
                end;
            end;
        elseif Replication == "All" then
            v100 = {
                All = true
            };
            v101 = {};
        elseif typeof(Replication) == "Instance" then
            if Replication.ClassName == "Player" then
                if ActivePlayers[Replication] == true then
                    v100 = {
                        [Replication] = true
                    };
                    v101 = {};
                else
                    v100 = {};
                    v101 = {
                        [Replication] = true
                    };
                end;
            else
                error("[ReplicaService]: Invalid value for param1");
            end;
        else
            error("[ReplicaService]: Invalid value for replica_params.Replication (" .. tostring(Replication) .. ")");
        end;
    else
        error("[ReplicaService]: Can\'t set replica_params.Replication for a replica that has a parent");
    end;

    local v102;

    if p97.WriteLib == nil then
        v102 = nil;
    else
        v102 = LoadWriteLib(p97.WriteLib);
    end;

    local v103;

    if Parent == nil then
        v103 = {};
    else
        v100 = Parent._replication;
        v101 = Parent._pending_replication;
        v103 = Parent._creation_data;
    end;

    local v104 = {
        Class,
        v98,
        v99,
        Parent == nil and 0 or (Parent.Id or 0),
        p97.WriteLib
    };
    v103[tostring(u26)] = v104;
    local v105 = {
        Data = v99,
        Id = u26,
        Class = Class,
        Tags = v98,
        Parent = Parent,
        Children = {},
        _creation_data = v103,
        _replication = v100,
        _pending_replication = v101,
        _write_lib = v102,
        _signal_listeners = {},
        _maid = Shared3.NewMaid()
    };
    setmetatable(v105, u48);

    if Parent ~= nil then
        table.insert(Parent.Children, v105);
    end;

    if v100.All == true then
        for i in pairs(ActivePlayers) do
            u24:FireClient(i, u26, v104);
        end;
    else
        for i in pairs(v100) do
            u24:FireClient(i, u26, v104);
        end;
    end;

    _replicas[u26] = v105;

    if Parent == nil then
        _top_level_replicas[u26] = v105;
    end;

    return v105;
end;

function u14.CheckWriteLib(p106) -- Line: 967
    -- upvalues: LoadWriteLib (copy)
    if p106 ~= nil then
        LoadWriteLib(p106);
    end;
end;

local v107 = {
    Identify = true,
    AddCleanupTask = true,
    RemoveCleanupTask = true,
    Destroy = true,
    IsActive = true
};

for i, v in pairs(u48) do
    if i ~= "__index" then
        if v107[i] == true then
            u30[i] = v;
        else
            u30[i] = function(p108) -- Line: 989
                -- upvalues: i (copy)
                error("[ReplicaService]: Tried to call method \"" .. i .. "\" for a destroyed replica; " .. p108:Identify());
            end;
        end;
    end;
end;

u14.Temporary = u14.NewReplica({
    ClassToken = u14.NewClassToken("Temporary")
});
u15.OnServerEvent:Connect(function(p109) -- Line: 1005
    -- upvalues: ActivePlayers (copy), u14 (copy), _top_level_replicas (copy), u24 (copy), u15 (copy)
    if ActivePlayers[p109] ~= nil then
        return;
    end;

    u14.PlayerRequestedData:Fire(p109);

    for _, v in pairs(_top_level_replicas) do
        if v._pending_replication[p109] ~= nil then
            v._pending_replication[p109] = nil;
            v._replication[p109] = true;
        end;
    end;

    local v110 = {};

    for i, v in pairs(_top_level_replicas) do
        if v._replication[p109] ~= nil or v._replication.All == true then
            table.insert(v110, { i, v._creation_data });
        end;
    end;

    u24:FireClient(p109, v110);
    u15:FireClient(p109);
    ActivePlayers[p109] = true;
    u14.NewActivePlayerSignal:Fire(p109);
end);
u22.OnServerEvent:Connect(function(p111, p112, ...) -- Line: 1037
    -- upvalues: ActivePlayers (copy), Default (copy), _replicas (copy)
    if ActivePlayers[p111] == nil or (Default:CheckRate(p111) == false or type(p112) ~= "number") then
        return;
    end;

    local v113 = _replicas[p112];

    if v113 ~= nil and (v113._replication[p111] ~= nil or v113._replication.All == true) then
        local _signal_listeners = v113._signal_listeners;

        for i = 1, #_signal_listeners do
            _signal_listeners[i](p111, ...);
            local _ = i;
        end;
    end;
end);
Players.PlayerRemoving:Connect(function(p114) -- Line: 1056
    -- upvalues: _top_level_replicas (copy), ActivePlayers (copy), u14 (copy)
    for _, v in pairs(_top_level_replicas) do
        v._replication[p114] = nil;
        v._pending_replication[p114] = nil;
    end;

    ActivePlayers[p114] = nil;
    u14.RemovedActivePlayerSignal:Fire(p114);
end);

return u14;