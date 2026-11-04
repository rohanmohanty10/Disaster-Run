  

local RunService = game:GetService("RunService");
local Utils = require(script.Parent.Internal.Utils);
local Signal = require(script.Parent.Parent.Signal);
local Network = require(script.Parent.Internal.Network);
local script_ClientReplion = require(script.ClientReplion);
require(script.Parent.Internal.Types);
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = Signal.new();
local u5 = Signal.new();

local function getWaitList(p6: string) -- Line: 48
    -- upvalues: u2 (copy)
    local v7 = u2[p6];

    if not v7 then
        v7 = {};
        u2[p6] = v7;
    end;

    return v7;
end;

local function cancelWait(p8: table, p9: thread) -- Line: 58
    -- upvalues: Utils (copy), u3 (copy)
    for i, v in p8 do
        if v.thread == p9 then
            table.remove(p8, i);

            if v.async then
                Utils.safeCancelThread(p9);
            else
                task.spawn(p9);
            end;

            u3[p9] = nil;

            return;
        end;
    end;
end;

local function createTimeout(p10: table, p11: number, p12: thread) -- Line: 79
    -- upvalues: cancelWait (copy)
    return task.delay(p11, cancelWait, p10, p12);
end;

local function createReplion(p13) -- Line: 83
    -- upvalues: u1 (copy), script_ClientReplion (copy), u4 (copy), u2 (copy)
    local v14 = p13[2];

    if u1[v14] then
        return;
    end;

    local v15 = script_ClientReplion.new(p13);
    u1[v14] = v15;
    u1[p13[1]] = v15;
    u4:Fire(v15);
    local v16 = u2[v14];

    if v16 then
        for _, v in v16 do
            task.spawn(v.thread, v15);
        end;

        u2[v14] = nil;
    end;
end;

local v42 = {
    OnReplionAdded = function(p17, p18) -- Line: 120, Name: OnReplionAdded
        -- upvalues: u4 (copy)
        return u4:Connect(p18);
    end,

    OnReplionRemoved = function(p19, p20) -- Line: 131, Name: OnReplionRemoved
        -- upvalues: u5 (copy)
        return u5:Connect(p20);
    end,

    OnReplionAddedWithTag = function(p21, u22, u23) -- Line: 143, Name: OnReplionAddedWithTag
        return p21:OnReplionAdded(function(p24) -- Line: 144
            -- upvalues: u22 (copy), u23 (copy)
            local Tags = p24.Tags;

            if Tags and table.find(Tags, u22) ~= nil then
                u23(p24);
            end;
        end);
    end,

    OnReplionRemovedWithTag = function(p25, u26, u27) -- Line: 161, Name: OnReplionRemovedWithTag
        return p25:OnReplionRemoved(function(p28) -- Line: 162
            -- upvalues: u26 (copy), u27 (copy)
            local Tags = p28.Tags;

            if Tags and table.find(Tags, u26) ~= nil then
                u27(p28);
            end;
        end);
    end,

    GetReplion = function(p29, p30) -- Line: 176, Name: GetReplion
        -- upvalues: u1 (copy)
        return u1[p30];
    end,

    WaitReplion = function(p31, p32, p33) -- Line: 188, Name: WaitReplion
        -- upvalues: u1 (copy), u2 (copy), u3 (copy), cancelWait (copy)
        local v34 = u1[p32];

        if v34 then
            return v34;
        end;

        local coroutine_running_ret = coroutine.running();
        local v35 = u2[p32];

        if not v35 then
            v35 = {};
            u2[p32] = v35;
        end;

        if p33 then
            u3[coroutine_running_ret] = task.delay(p33, cancelWait, v35, coroutine_running_ret);
        end;

        table.insert(v35, {
            thread = coroutine_running_ret
        });

        return coroutine.yield();
    end,

    AwaitReplion = function(p36, p37, p38, p39) -- Line: 216, Name: AwaitReplion
        -- upvalues: u1 (copy), u2 (copy), u3 (copy), cancelWait (copy)
        local v40 = u1[p37];

        if v40 then
            return p38(v40);
        end;

        local u41 = u2[p37];

        if not u41 then
            u41 = {};
            u2[p37] = u41;
        end;

        local coroutine_create_ret = coroutine.create(p38);

        if p39 then
            u3[coroutine_create_ret] = task.delay(p39, cancelWait, u41, coroutine_create_ret);
        end;

        table.insert(u41, {
            async = true,
            thread = coroutine_create_ret
        });

        return function() -- Line: 231
            -- upvalues: cancelWait (ref), u41 (copy), coroutine_create_ret (copy)
            cancelWait(u41, coroutine_create_ret);
        end;
    end
};

if not Utils.ShouldMock and RunService:IsClient() then
    local v43 = Network.get("Added");
    local v44 = Network.get("Removed");
    local v45 = Network.get("Update");
    local v46 = Network.get("Set");
    local v47 = Network.get("UpdateReplicateTo");
    local v48 = Network.get("ArrayUpdate");
    v43.OnClientEvent:Connect(function(p49) -- Line: 244
        -- upvalues: createReplion (copy)
        if type(p49[1]) == "table" then
            for _, v in p49 do
                createReplion(v);
            end;

            return;
        end;

        createReplion(p49);
    end);
    v44.OnClientEvent:Connect(function(p50: string) -- Line: 254
        -- upvalues: u1 (copy), u5 (copy)
        local v51 = u1[p50];

        if v51 then
            u1[p50] = nil;
            u1[v51._channel] = nil;
            u5:Fire(v51);
            v51:Destroy();
        end;
    end);
    v45.OnClientEvent:Connect(function(p52: string, p53: any, p54: any) -- Line: 266
        -- upvalues: u1 (copy)
        local v55 = u1[p52];

        if v55 then
            v55:_update(p53, p54);
        end;
    end);
    v47.OnClientEvent:Connect(function(p56: string, p57: any) -- Line: 274
        -- upvalues: u1 (copy)
        local v58 = u1[p56];

        if v58 then
            v58.ReplicateTo = p57;
        end;
    end);
    v46.OnClientEvent:Connect(function(p59: string, p60: any, p61: any) -- Line: 282
        -- upvalues: u1 (copy)
        local v62 = u1[p59];

        if v62 then
            v62:_set(p60, p61);
        end;
    end);
    v48.OnClientEvent:Connect(function(p63: string, p64: string, ...) -- Line: 290
        -- upvalues: u1 (copy)
        local v65 = u1[p63];

        if v65 then
            if p64 == "i" then
                v65:_insert(...);

                return;
            end;

            if p64 == "r" then
                v65:_remove(...);

                return;
            end;

            if p64 == "c" then
                v65:_clear(...);
            end;
        end;
    end);
end;

return table.freeze(v42);