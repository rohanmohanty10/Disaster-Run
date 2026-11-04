 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

local function waitForDependency(p1: userdata, p2: string) -- Line: 28
    local v3 = p1:WaitForChild(p2, 30);
    local v4 = "[GA] Missing SDK dependency " .. p1:GetFullName() .. "." .. p2 .. " after 30s; install the complete GA package.";
    assert(v3, v4);

    return v3;
end;

local Parent = script.Parent.Parent;
local Shared = Parent:WaitForChild("Shared", 30);
local v5 = "[GA] Missing SDK dependency " .. Parent:GetFullName() .. ".Shared after 30s; install the complete GA package.";
assert(Shared, v5);
local l_require = require;
local Signal = Shared:WaitForChild("Signal", 30);
local v6 = "[GA] Missing SDK dependency " .. Shared:GetFullName() .. ".Signal after 30s; install the complete GA package.";
assert(Signal, v6);
local u7 = l_require(Signal);
local v8 = {};
local u9 = {};
local u10 = {};
local u11 = {};
local u12 = false;
local u13 = false;
local u14 = false;
local u15 = false;
local u16 = 0;
local u17 = nil;

local function getSignal(p18: string) -- Line: 47
    -- upvalues: u10 (copy), u7 (copy)
    local v19 = u10[p18];

    if not v19 then
        v19 = u7.new();
        u10[p18] = v19;
    end;

    return v19;
end;

local function finishPending() -- Line: 53
    -- upvalues: u11 (copy), u9 (copy)
    for i, v in u11 do
        u11[i] = nil;

        if i:IsConnected() then
            task.spawn(v.fn, u9[v.key], nil);
        end;
    end;
end;

local function applyDelta(p20, p21) -- Line: 60
    -- upvalues: u9 (copy), u10 (copy)
    for i, v in p20 or {} do
        local v22 = u9[i];
        u9[i] = v;

        if u10[i] then
            u10[i]:Fire(v, v22);
        end;
    end;

    for _, v in p21 or {} do
        local v23 = u9[v];
        u9[v] = nil;

        if u10[v] then
            u10[v]:Fire(nil, v23);
        end;
    end;
end;

function v8._init(p24) -- Line: 74
    -- upvalues: u13 (ref), u14 (ref), u16 (ref), ReplicatedStorage (copy), u17 (ref), u12 (ref), applyDelta (copy), u9 (copy), u15 (ref), u10 (copy), u11 (copy), finishPending (copy)
    if u13 or u14 then
        return;
    end;

    u13 = true;
    u16 = u16 + 1;
    local u25 = u16;
    task.spawn(function() -- Line: 79
        -- upvalues: u14 (ref), u16 (ref), u25 (copy), ReplicatedStorage (ref), u17 (ref), u12 (ref), applyDelta (ref), u9 (ref), u15 (ref), u10 (ref), u11 (ref), finishPending (ref), u13 (ref)
        local u26 = {};

        for i = 1, 6 do
            if u14 or u16 ~= u25 then
                return;
            end;

            local GoatConfigSync = ReplicatedStorage:FindFirstChild("GoatConfigSync");
            local GoatConfigFetch = ReplicatedStorage:FindFirstChild("GoatConfigFetch");

            if GoatConfigSync and (GoatConfigSync:IsA("RemoteEvent") and (GoatConfigFetch and GoatConfigFetch:IsA("RemoteFunction"))) then
                if not u17 then
                    u17 = GoatConfigSync.OnClientEvent:Connect(function(p27) -- Line: 87
                        -- upvalues: u14 (ref), u16 (ref), u25 (ref), u12 (ref), u26 (copy), applyDelta (ref)
                        if u14 or (u16 ~= u25 or type(p27) ~= "table") then
                            return;
                        end;

                        if not u12 and type(p27.changed) == "table" then
                            for i2 in p27.changed do
                                u26[i2] = true;
                            end;
                        end;

                        if not u12 and type(p27.removed) == "table" then
                            for _, v in p27.removed do
                                u26[v] = true;
                            end;
                        end;

                        applyDelta(p27.changed, p27.removed);
                    end);
                end;

                local success, result = pcall(GoatConfigFetch.InvokeServer, GoatConfigFetch);

                if u14 or u16 ~= u25 then
                    return;
                end;

                if success and type(result) == "table" then
                    local table_clone_ret = table.clone(u9);
                    local table_clone_ret2 = table.clone(result);

                    for i2 in u26 do
                        table_clone_ret2[i2] = u9[i2];
                    end;

                    table.clear(u9);

                    for i2, v in table_clone_ret2 do
                        u9[i2] = v;
                    end;

                    table.clear(u26);
                    u12 = true;

                    if u15 then
                        local v28 = {};

                        for i2 in table_clone_ret do
                            v28[i2] = true;
                        end;

                        for i2 in u9 do
                            v28[i2] = true;
                        end;

                        for i2 in v28 do
                            local v29 = u10[i2];

                            if v29 and table_clone_ret[i2] ~= u9[i2] then
                                local v30 = i2;

                                for _, v in table.clone(v29._connections) do
                                    if v:IsConnected() and not u11[v] then
                                        task.spawn(v._fn, u9[v30], table_clone_ret[v30]);
                                    end;
                                end;
                            end;
                        end;
                    end;

                    u15 = false;
                    finishPending();

                    return;
                end;
            end;

            local v31;

            if i < 6 then
                task.wait((math.min(2 ^ i, 10)));
                v31 = i;
            else
                v31 = i;
            end;
        end;

        if u14 or u16 ~= u25 then
            return;
        end;

        if u17 then
            u17:Disconnect();
            u17 = nil;
        end;

        u13 = false;
        u15 = true;
        finishPending();
        warn("[GA:Config] Initial config unavailable; using defaults. Call _init() to retry.");
    end);
end;

function v8.get(p32: table, p33: string, p34: any) -- Line: 142
    -- upvalues: u9 (copy)
    if u9[p33] == nil then
        return p34;
    end;

    return u9[p33];
end;

function v8.getAll(p35) -- Line: 146
    -- upvalues: u9 (copy)
    return u9;
end;

function v8.isReady(p36) -- Line: 150
    -- upvalues: u12 (ref)
    return u12;
end;

function v8.onChanged(p37: table, u38: string, p39: function, p40: boolean?) -- Line: 154
    -- upvalues: u10 (copy), u7 (copy), u11 (copy), u14 (ref), u12 (ref), u9 (copy), u13 (ref)
    local u41 = u10[u38];

    if not u41 then
        u41 = u7.new();
        u10[u38] = u41;
    end;

    local v42 = u41:Connect(p39);
    local Disconnect = v42.Disconnect;

    function v42.Disconnect(p43) -- Line: 158
        -- upvalues: u11 (ref), Disconnect (copy), u10 (ref), u38 (copy), u41 (copy)
        u11[p43] = nil;
        Disconnect(p43);

        if u10[u38] == u41 and #u41._connections == 0 then
            u10[u38] = nil;
        end;
    end;

    v42.Destroy = v42.Disconnect;

    if u14 then
        v42:Disconnect();

        return v42;
    end;

    if p40 then
        if u12 then
            task.spawn(p39, u9[u38], nil);
        else
            u11[v42] = {
                key = u38,
                fn = p39
            };
        end;
    end;

    if not u13 then
        p37:_init();
    end;

    return v42;
end;

function v8.shutdown(p44) -- Line: 173
    -- upvalues: u14 (ref), u16 (ref), u13 (ref), u12 (ref), u17 (ref), u10 (copy), u11 (copy)
    u14 = true;
    u16 = u16 + 1;
    u13 = false;
    u12 = false;

    if u17 then
        u17:Disconnect();
        u17 = nil;
    end;

    for _, v in u10 do
        v:DisconnectAll();
    end;

    table.clear(u10);
    table.clear(u11);
end;

v8:_init();

return v8;