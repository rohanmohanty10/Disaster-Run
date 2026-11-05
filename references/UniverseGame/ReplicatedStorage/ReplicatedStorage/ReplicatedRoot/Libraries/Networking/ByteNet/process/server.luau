  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(script.Parent.Parent.types);
local read = require(script.Parent.read);
local bufferWriter = require(script.Parent.bufferWriter);
local alloc = bufferWriter.alloc;
local u8 = bufferWriter.u8;
local load = bufferWriter.load;
local u1 = {};
local u2 = {};

local function create() -- Line: 20
    return {
        cursor = 0,
        size = 256,
        references = {},
        buff = buffer.create(256)
    };
end;

local function dump(p3) -- Line: 29
    local cursor = p3.cursor;
    local v4 = buffer.create(cursor);
    buffer.copy(v4, 0, p3.buff, 0, cursor);

    if #p3.references > 0 then
        return v4, p3.references;
    end;

    return v4, nil;
end;

local u5 = create();
local u6 = create();

local function onServerEvent(p7, p8, p9) -- Line: 43
    -- upvalues: read (copy)
    if typeof(p8) ~= "buffer" then
        return;
    end;

    if buffer.len(p8) > 16384 then
        return;
    end;

    read(p8, p9, p7);
end;

local function playerAdded(p10) -- Line: 56
    -- upvalues: u1 (copy), create (copy), u2 (copy)
    if not u1[p10] then
        u1[p10] = create();
    end;

    if not u2[p10] then
        u2[p10] = create();
    end;
end;

return {
    sendAllReliable = function(p11, p12, p13) -- Line: 68, Name: sendAllReliable
        -- upvalues: load (copy), u5 (ref), alloc (copy), u8 (copy), bufferWriter (copy)
        load(u5);
        alloc(1);
        u8(p11);
        p12(p13);
        u5 = bufferWriter.export();
    end,

    sendAllUnreliable = function(p14, p15, p16) -- Line: 78, Name: sendAllUnreliable
        -- upvalues: load (copy), u6 (ref), create (copy), alloc (copy), u8 (copy), bufferWriter (copy)
        load(u6 or create());
        alloc(1);
        u8(p14);
        p15(p16);
        u6 = bufferWriter.export();
    end,

    sendPlayerReliable = function(p17, p18, p19, p20) -- Line: 88, Name: sendPlayerReliable
        -- upvalues: load (copy), u1 (copy), create (copy), alloc (copy), u8 (copy), bufferWriter (copy)
        load(u1[p17] or create());
        alloc(1);
        u8(p18);
        p19(p20);
        u1[p17] = bufferWriter.export();
    end,

    sendPlayerUnreliable = function(p21, p22, p23, p24) -- Line: 103, Name: sendPlayerUnreliable
        -- upvalues: load (copy), u2 (copy), alloc (copy), u8 (copy), bufferWriter (copy)
        load(u2[p21]);
        alloc(1);
        u8(p22);
        p23(p24);
        u2[p21] = bufferWriter.export();
    end,

    start = function() -- Line: 118, Name: start
        -- upvalues: onServerEvent (copy), ReplicatedStorage (copy), Players (copy), u1 (copy), create (copy), u2 (copy), playerAdded (copy), RunService (copy), u5 (ref), u6 (ref)
        local RemoteEvent = Instance.new("RemoteEvent");
        RemoteEvent.Name = "ByteNetReliable";
        RemoteEvent.OnServerEvent:Connect(onServerEvent);
        RemoteEvent.Parent = ReplicatedStorage;
        local UnreliableRemoteEvent = Instance.new("UnreliableRemoteEvent");
        UnreliableRemoteEvent.Name = "ByteNetUnreliable";
        UnreliableRemoteEvent.OnServerEvent:Connect(onServerEvent);
        UnreliableRemoteEvent.Parent = ReplicatedStorage;

        for _, v in Players:GetPlayers() do
            if not u1[v] then
                u1[v] = create();
            end;

            if not u2[v] then
                u2[v] = create();
            end;
        end;

        Players.PlayerAdded:Connect(playerAdded);
        RunService.Heartbeat:Connect(function() -- Line: 135
            -- upvalues: u5 (ref), RemoteEvent (copy), u6 (ref), UnreliableRemoteEvent (copy), Players (ref), u1 (ref), u2 (ref)
            if u5.cursor > 0 then
                local v25 = u5;
                local cursor = v25.cursor;
                local v26 = buffer.create(cursor);
                buffer.copy(v26, 0, v25.buff, 0, cursor);
                local v27;

                if #v25.references > 0 then
                    v27 = v25.references;
                else
                    v27 = nil;
                end;

                RemoteEvent:FireAllClients(v26, v27);
                u5.cursor = 0;
                table.clear(u5.references);
            end;

            if u6.cursor > 0 then
                local v28 = u6;
                local cursor = v28.cursor;
                local v29 = buffer.create(cursor);
                buffer.copy(v29, 0, v28.buff, 0, cursor);
                local v30;

                if #v28.references > 0 then
                    v30 = v28.references;
                else
                    v30 = nil;
                end;

                UnreliableRemoteEvent:FireAllClients(v29, v30);
                u6.cursor = 0;
                table.clear(u6.references);
            end;

            for _, v in Players:GetPlayers() do
                if u1[v].cursor > 0 then
                    local v31 = u1[v];
                    local cursor = v31.cursor;
                    local v32 = buffer.create(cursor);
                    buffer.copy(v32, 0, v31.buff, 0, cursor);
                    local v33;

                    if #v31.references > 0 then
                        v33 = v31.references;
                    else
                        v33 = nil;
                    end;

                    RemoteEvent:FireClient(v, v32, v33);
                    u1[v].cursor = 0;
                    table.clear(u1[v].references);
                end;

                if u2[v].cursor > 0 then
                    local v34 = u2[v];
                    local cursor = v34.cursor;
                    local v35 = buffer.create(cursor);
                    buffer.copy(v35, 0, v34.buff, 0, cursor);
                    local v36;

                    if #v34.references > 0 then
                        v36 = v34.references;
                    else
                        v36 = nil;
                    end;

                    UnreliableRemoteEvent:FireClient(v, v35, v36);
                    u2[v].cursor = 0;
                    table.clear(u2[v].references);
                end;
            end;
        end);
    end
};