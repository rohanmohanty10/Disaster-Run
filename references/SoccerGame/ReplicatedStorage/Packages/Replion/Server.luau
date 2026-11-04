  

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Freeze = require(script.Parent.Parent.Freeze);
local Utils = require(script.Parent.Internal.Utils);
local Network = require(script.Parent.Internal.Network);
local script_ServerReplion = require(script.ServerReplion);
local Signal = require(script.Parent.Parent.Signal);
require(script.Parent.Internal.Types);
local u1 = Signal.new();
local u2 = Signal.new();
local u3 = {};
local u4 = {};
local u5 = {};

local function getCache(p6: any, p7: string) -- Line: 61
    local v8 = p6[p7];

    if not v8 then
        v8 = {};
        p6[p7] = v8;
    end;

    return v8;
end;

local function cancelWait(p9: table, p10: thread) -- Line: 72
    -- upvalues: Utils (copy), u5 (copy)
    for i, v in p9 do
        if v.thread == p10 then
            table.remove(p9, i);

            if v.async then
                Utils.safeCancelThread(p10);
            else
                task.spawn(p10);
            end;

            u5[p10] = nil;

            return;
        end;
    end;
end;

local function createTimeout(p11: table, p12: number, p13: thread) -- Line: 93
    -- upvalues: cancelWait (copy)
    return task.delay(p12, cancelWait, p11, p13);
end;

local u66 = {
    new = function(p14) -- Line: 111, Name: new
        -- upvalues: u3 (copy), script_ServerReplion (copy), u2 (copy), u1 (copy), u4 (copy), u5 (copy), Utils (copy)
        local u15 = assert(p14.Channel, "Channel is required!");
        local v16 = u3;
        local u17 = v16[u15];

        if not u17 then
            u17 = {};
            v16[u15] = u17;
        end;

        local ReplicateTo = p14.ReplicateTo;

        for _, v in u17 do
            local ReplicateTo2 = v.ReplicateTo;
            local v18 = ReplicateTo2 == ReplicateTo;

            if not (v18 or (type(ReplicateTo2) ~= "table" or type(ReplicateTo) ~= "table")) then
                for _, v2 in ReplicateTo2 do
                    v18 = table.find(ReplicateTo, v2) ~= nil;

                    if v18 then
                        break;
                    end;
                end;
            end;

            if v18 then
                local v19 = nil;

                if typeof(ReplicateTo2) == "Instance" then
                    v19 = tostring(ReplicateTo2);
                elseif type(ReplicateTo2) == "string" then
                    v19 = ReplicateTo2;
                elseif type(ReplicateTo2) == "table" then
                    for _, v2 in ReplicateTo2 do
                        v19 = (not v19 and "" or v19 .. ", ") .. tostring(v2);
                    end;
                end;

                error((`Channel "{u15}" already exists! for "{v19}"`));
            end;
        end;

        local u20 = script_ServerReplion.new(p14);
        u20:BeforeDestroy(function() -- Line: 150
            -- upvalues: u17 (copy), u20 (copy), u3 (ref), u15 (copy), u2 (ref)
            local table_find_ret = table.find(u17, u20);

            if table_find_ret then
                table.remove(u17, table_find_ret);
            end;

            if #u17 == 0 then
                u3[u15] = nil;
            end;

            u2:Fire(u15, u20);
        end);
        table.insert(u17, u20);
        u1:Fire(u15, u20);
        local v21 = u4[u15];

        if not v21 then
            return u20;
        end;

        for i = #v21, 1, -1 do
            local v22 = v21[i];
            local thread = v22.thread;
            local player = v22.player;
            local ReplicateTo2 = u20.ReplicateTo;
            local v23, v24;

            if player then
                local v25 = false;

                if typeof(ReplicateTo2) == "Instance" then
                    v25 = ReplicateTo2 == player;
                elseif type(ReplicateTo2) == "table" then
                    v25 = table.find(ReplicateTo2, player) ~= nil;
                end;

                if v25 then
                    v23 = u5[thread];

                    if v23 then
                        Utils.safeCancelThread(v23);
                        u5[thread] = nil;
                    end;

                    task.spawn(thread, u20);
                    table.remove(v21, i);
                    v24 = i;
                else
                    v24 = i;
                end;
            else
                v23 = u5[thread];

                if v23 then
                    Utils.safeCancelThread(v23);
                    u5[thread] = nil;
                end;

                task.spawn(thread, u20);
                table.remove(v21, i);
                v24 = i;
            end;
        end;

        return u20;
    end,

    GetReplion = function(p26: table, p27: string) -- Line: 212, Name: GetReplion
        -- upvalues: u3 (copy)
        local v28 = u3[p27];

        if not v28 then
            return nil;
        end;

        local v29 = `There are multiple replions with the channel "{p27}". Did you mean to use GetReplionFor?`;
        assert(#v28 == 1, v29);

        return v28[1];
    end,

    GetReplionFor = function(p30, p31, p32) -- Line: 232, Name: GetReplionFor
        -- upvalues: u3 (copy)
        local v33 = u3[p32];

        if v33 then
            for _, v in v33 do
                if v.ReplicateTo == p31 and v.Channel == p32 then
                    return v;
                end;
            end;
        end;

        return nil;
    end,

    GetReplionsFor = function(p34, p35) -- Line: 250, Name: GetReplionsFor
        -- upvalues: u3 (copy)
        local v36 = {};

        for _, v in u3 do
            for _, v2 in v do
                local ReplicateTo = v2.ReplicateTo;
                local v37 = ReplicateTo == "All";

                if not v37 then
                    if type(ReplicateTo) == "table" then
                        v37 = table.find(ReplicateTo, p35) ~= nil;
                    else
                        v37 = ReplicateTo == p35 and true or v37;
                    end;
                end;

                if v37 then
                    table.insert(v36, v2);
                end;
            end;
        end;

        return v36;
    end,

    WaitReplion = function(p38, p39, p40) -- Line: 283, Name: WaitReplion
        -- upvalues: u4 (copy), u5 (copy), cancelWait (copy)
        local Replion = p38:GetReplion(p39);

        if Replion then
            return Replion;
        end;

        local coroutine_running_ret = coroutine.running();
        local v41 = u4;
        local v42 = v41[p39];

        if not v42 then
            v42 = {};
            v41[p39] = v42;
        end;

        if p40 then
            u5[coroutine_running_ret] = task.delay(p40, cancelWait, v42, coroutine_running_ret);
        end;

        table.insert(v42, {
            thread = coroutine_running_ret
        });

        return coroutine.yield();
    end,

    WaitReplionFor = function(p43, p44, p45, p46) -- Line: 310, Name: WaitReplionFor
        -- upvalues: u4 (copy), u5 (copy), cancelWait (copy)
        local ReplionFor = p43:GetReplionFor(p44, p45);

        if ReplionFor then
            return ReplionFor;
        end;

        local coroutine_running_ret = coroutine.running();
        local v47 = u4;
        local v48 = v47[p45];

        if not v48 then
            v48 = {};
            v47[p45] = v48;
        end;

        if p46 then
            u5[coroutine_running_ret] = task.delay(p46, cancelWait, v48, coroutine_running_ret);
        end;

        table.insert(v48, {
            thread = coroutine_running_ret,
            player = p44
        });

        return coroutine.yield();
    end,

    AwaitReplion = function(p49, p50, p51, p52) -- Line: 338, Name: AwaitReplion
        -- upvalues: u4 (copy), u5 (copy), cancelWait (copy)
        local Replion = p49:GetReplion(p50);

        if Replion then
            return p51(Replion);
        end;

        local v53 = u4;
        local u54 = v53[p50];

        if not u54 then
            u54 = {};
            v53[p50] = u54;
        end;

        local coroutine_create_ret = coroutine.create(p51);

        if p52 then
            u5[coroutine_create_ret] = task.delay(p52, cancelWait, u54, coroutine_create_ret);
        end;

        table.insert(u54, {
            async = true,
            thread = coroutine_create_ret
        });

        return function() -- Line: 353
            -- upvalues: cancelWait (ref), u54 (copy), coroutine_create_ret (copy)
            cancelWait(u54, coroutine_create_ret);
        end;
    end,

    AwaitReplionFor = function(p55, p56, p57, p58, p59) -- Line: 369, Name: AwaitReplionFor
        -- upvalues: u4 (copy), u5 (copy), cancelWait (copy)
        local ReplionFor = p55:GetReplionFor(p56, p57);

        if ReplionFor then
            return p58(ReplionFor);
        end;

        local v60 = u4;
        local u61 = v60[p57];

        if not u61 then
            u61 = {};
            v60[p57] = u61;
        end;

        local coroutine_create_ret = coroutine.create(p58);

        if p59 then
            u5[coroutine_create_ret] = task.delay(p59, cancelWait, u61, coroutine_create_ret);
        end;

        table.insert(u61, {
            async = true,
            thread = coroutine_create_ret,
            player = p56
        });

        return function() -- Line: 384
            -- upvalues: cancelWait (ref), u61 (copy), coroutine_create_ret (copy)
            cancelWait(u61, coroutine_create_ret);
        end;
    end,

    OnReplionAdded = function(p62, p63) -- Line: 396, Name: OnReplionAdded
        -- upvalues: u1 (copy)
        return u1:Connect(p63);
    end,

    OnReplionRemoved = function(p64, p65) -- Line: 407, Name: OnReplionRemoved
        -- upvalues: u2 (copy)
        return u2:Connect(p65);
    end
};

if not Utils.ShouldMock and RunService:IsServer() then
    Network.create({ "Added", "Removed", "Update", "UpdateReplicateTo", "Set", "ArrayUpdate" });

    local function onPlayerAdded(p67: userdata) -- Line: 422
        -- upvalues: u66 (copy), Network (copy)
        local v68 = {};

        for _, v in u66:GetReplionsFor(p67) do
            table.insert(v68, v:_serialize());
        end;

        if #v68 > 0 then
            Network.sendTo(p67, "Added", v68);
        end;
    end;

    for _, v in Players:GetPlayers() do
        task.spawn(onPlayerAdded, v);
    end;

    Players.PlayerAdded:Connect(onPlayerAdded);
    Players.PlayerRemoving:Connect(function(p69: userdata) -- Line: 441
        -- upvalues: u3 (copy), Freeze (copy), u4 (copy), Utils (copy), u5 (copy)
        for _, v in u3 do
            for _, v2 in v do
                local ReplicateTo = v2.ReplicateTo;

                if ReplicateTo ~= "All" then
                    if type(ReplicateTo) == "table" then
                        v2:SetReplicateTo((Freeze.List.removeValue(ReplicateTo, p69)));
                    elseif ReplicateTo == p69 then
                        v2:Destroy();
                    end;
                end;
            end;
        end;

        for _, v in u4 do
            local v70 = v;

            for i = #v, 1, -1 do
                local v71 = v70[i];
                local thread = v71.thread;
                local v72;

                if v71.player == p69 then
                    if v71.async then
                        Utils.safeCancelThread(thread);
                    else
                        task.spawn(thread);
                    end;

                    u5[thread] = nil;
                    table.remove(v70, i);
                    v72 = i;
                else
                    v72 = i;
                end;
            end;
        end;
    end);
end;

return u66;