 

 

local script_Signal = require(script.Signal);
local script_Task = require(script.Task);
local script_Types = require(script.Types);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Reads = script_Types.Reads;
local Writes = script_Types.Writes;
local Import = script_Types.Import;
local Export = script_Types.Export;
local Truncate = script_Types.Truncate;
local Ended = script_Types.Ended;
local NumberU8 = Reads.NumberU8;
local NumberU82 = Writes.NumberU8;
local NumberU16 = Reads.NumberU16;
local NumberU162 = Writes.NumberU16;
local u6 = {};
local u7 = {};
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = {
    BufferLength = 128,
    BufferOffset = 0,
    InstancesOffset = 0,
    Buffer = buffer.create(128),
    Instances = {}
};

local function Constructor(p14: any, p15: string, ...) -- Line: 51
    -- upvalues: u7 (copy), u6 (copy), RunService (copy), u12 (ref), script_Signal (copy), u11 (ref), u1 (ref)
    local v16 = u7[p15];

    if v16 then
        return v16;
    end;

    local v17 = setmetatable({}, u6);
    v17.Name = p15;

    if RunService:IsServer() then
        v17.Id = u12;
        v17.OnServerEvent = script_Signal();
        u11:SetAttribute(p15, u12);
        u7[u12] = v17;
        u12 = u12 + 1;
    else
        v17.Id = u11:GetAttribute(p15);
        v17.OnClientEvent = script_Signal();

        if v17.Id then
            u7[v17.Id] = v17;
        end;
    end;

    local v18, v19 = u1(table.pack(...));
    v17.Reads = v18;
    v17.Writes = v19;
    u7[v17.Name] = v17;

    return v17;
end;

u6.__index = u6;
u6.Type = "Packet";

function u6.Response(p20, ...) -- Line: 76
    -- upvalues: u1 (ref)
    p20.ResponseTimeout = p20.ResponseTimeout or 10;
    local v21, v22 = u1(table.pack(...));
    p20.ResponseReads = v21;
    p20.ResponseWrites = v22;

    return p20;
end;

function u6.Fire(p23, ...) -- Line: 82
    -- upvalues: Import (copy), u13 (ref), NumberU82 (copy), u10 (ref), script_Task (copy), u5 (ref), u4 (ref), Export (copy)
    Import(u13);
    NumberU82(p23.Id);

    if p23.ResponseReads then
        NumberU82(u10.Index);
        u10[u10.Index] = {
            Yielded = coroutine.running(),
            Timeout = script_Task:Delay(p23.ResponseTimeout, u5, coroutine.running(), p23.ResponseTimeoutValue)
        };
        u10.Index = (u10.Index + 1) % 128;
        u4(p23.Writes, { ... });
        u13 = Export();

        return coroutine.yield();
    end;

    u4(p23.Writes, { ... });
    u13 = Export();
end;

function u6.FireClient(p24, p25, ...) -- Line: 98
    -- upvalues: Import (copy), u8 (ref), NumberU82 (copy), u9 (ref), script_Task (copy), u5 (ref), u4 (ref), Export (copy)
    if p25.Parent == nil then
        return;
    end;

    Import(u8[p25] or {
        BufferLength = 128,
        BufferOffset = 0,
        InstancesOffset = 0,
        Buffer = buffer.create(128),
        Instances = {}
    });
    NumberU82(p24.Id);

    if p24.ResponseReads then
        local v26 = u9[p25];

        if v26 == nil then
            v26 = {
                Index = 0
            };
            u9[p25] = v26;
        end;

        NumberU82(v26.Index);
        v26[v26.Index] = {
            Yielded = coroutine.running(),
            Timeout = script_Task:Delay(p24.ResponseTimeout, u5, coroutine.running(), p24.ResponseTimeoutValue)
        };
        v26.Index = (v26.Index + 1) % 128;
        u4(p24.Writes, { ... });
        u8[p25] = Export();

        return coroutine.yield();
    end;

    u4(p24.Writes, { ... });
    u8[p25] = Export();
end;

function u6.Serialize(p27, ...) -- Line: 117
    -- upvalues: Import (copy), u4 (ref), Truncate (copy)
    Import({
        BufferLength = 128,
        BufferOffset = 0,
        InstancesOffset = 0,
        Buffer = buffer.create(128),
        Instances = {}
    });
    u4(p27.Writes, { ... });

    return Truncate();
end;

function u6.Deserialize(p28, p29, p30) -- Line: 123
    -- upvalues: Import (copy), u3 (ref)
    Import({
        BufferOffset = 0,
        InstancesOffset = 0,
        Buffer = p29,
        BufferLength = buffer.len(p29),
        Instances = p30 or {}
    });

    return u3(p28.Reads);
end;

u1 = function(p31: table) -- Line: 130, Name: ParametersToFunctions
    -- upvalues: u2 (ref), Reads (copy), Writes (copy)
    local table_create_ret = table.create(#p31);
    local table_create_ret2 = table.create(#p31);

    for i, v in ipairs(p31) do
        if type(v) == "table" then
            local v32, v33 = u2(v);
            table_create_ret[i] = v32;
            table_create_ret2[i] = v33;
        else
            local v34 = Writes[v];
            table_create_ret[i] = Reads[v];
            table_create_ret2[i] = v34;
        end;
    end;

    return table_create_ret, table_create_ret2;
end;

u2 = function(p35: table) -- Line: 142, Name: TableToFunctions
    -- upvalues: u2 (ref), Reads (copy), Writes (copy), NumberU16 (copy), NumberU162 (copy)
    if #p35 == 1 then
        local v36 = p35[1];
        local u37, u38;

        if type(v36) == "table" then
            u37, u38 = u2(v36);
        else
            u37 = Reads[v36];
            u38 = Writes[v36];
        end;

        return function() -- Line: 151
            -- upvalues: NumberU16 (ref), u37 (ref)
            local v39 = NumberU16();
            local table_create_ret = table.create(v39);

            for i = 1, v39 do
                table_create_ret[i] = u37();
                local _ = i;
            end;

            return table_create_ret;
        end, function(p40: table) -- Line: 157
            -- upvalues: NumberU162 (ref), u38 (ref)
            NumberU162(#p40);

            for _, v in p40 do
                u38(v);
            end;
        end;
    end;

    local u41 = {};

    for i, _ in p35 do
        table.insert(u41, i);
    end;

    table.sort(u41);
    local table_create_ret = table.create(#u41);
    local table_create_ret2 = table.create(#u41);

    for i, v in u41 do
        local v42 = p35[v];

        if type(v42) == "table" then
            local v43, v44 = u2(v42);
            table_create_ret[i] = v43;
            table_create_ret2[i] = v44;
        else
            local v45 = Writes[v42];
            table_create_ret[i] = Reads[v42];
            table_create_ret2[i] = v45;
        end;
    end;

    return function() -- Line: 173
        -- upvalues: table_create_ret (copy), u41 (copy)
        local v46 = {};

        for i, v in table_create_ret do
            v46[u41[i]] = v();
        end;

        return v46;
    end, function(p47: table) -- Line: 178
        -- upvalues: table_create_ret2 (copy), u41 (copy)
        for i, v in table_create_ret2 do
            v(p47[u41[i]]);
        end;
    end;
end;

u3 = function(p48: table) -- Line: 185, Name: ReadParameters
    local table_create_ret = table.create(#p48);

    for i, v in p48 do
        table_create_ret[i] = v();
    end;

    return table.unpack(table_create_ret);
end;

u4 = function(p49: table, p50: table) -- Line: 191, Name: WriteParameters
    for i, v in p49 do
        v(p50[i]);
    end;
end;

u5 = function(p51: thread, p52: any) -- Line: 195, Name: Timeout
    task.defer(p51, p52);
end;

if RunService:IsServer() then
    u8 = {};
    u9 = {};
    u12 = 0;
    u11 = Instance.new("RemoteEvent", script);
    local u53 = {};
    local task_spawn_ret = task.spawn(function() -- Line: 209
        -- upvalues: u13 (ref), u11 (ref), u8 (ref), u53 (copy)
        while true do
            coroutine.yield();

            if u13.BufferOffset > 0 then
                local buffer_create_ret = buffer.create(u13.BufferOffset);
                buffer.copy(buffer_create_ret, 0, u13.Buffer, 0, u13.BufferOffset);

                if u13.InstancesOffset == 0 then
                    u11:FireAllClients(buffer_create_ret);
                else
                    u11:FireAllClients(buffer_create_ret, u13.Instances);
                    u13.InstancesOffset = 0;
                    table.clear(u13.Instances);
                end;

                u13.BufferOffset = 0;
            end;

            for i, v in u8 do
                local buffer_create_ret = buffer.create(v.BufferOffset);
                buffer.copy(buffer_create_ret, 0, v.Buffer, 0, v.BufferOffset);

                if v.InstancesOffset == 0 then
                    u11:FireClient(i, buffer_create_ret);
                else
                    u11:FireClient(i, buffer_create_ret, v.Instances);
                end;
            end;

            table.clear(u8);
            table.clear(u53);
        end;
    end);

    local function u58(p54: table, p55: userdata, p56: number, ...) -- Line: 238
        -- upvalues: RunService (copy), Import (copy), u8 (ref), NumberU82 (copy), u4 (ref), Export (copy)
        if p54.OnServerInvoke == nil then
            if RunService:IsStudio() then
                warn("OnServerInvoke not found for packet:", p54.Name, "discarding event:", ...);
            end;

            return;
        end;

        local v57 = { p54.OnServerInvoke(p55, ...) };

        if p55.Parent == nil then
            return;
        end;

        Import(u8[p55] or {
            BufferLength = 128,
            BufferOffset = 0,
            InstancesOffset = 0,
            Buffer = buffer.create(128),
            Instances = {}
        });
        NumberU82(p54.Id);
        NumberU82(p56 + 128);
        u4(p54.ResponseWrites, v57);
        u8[p55] = Export();
    end;

    local function u68(p59: userdata, p60: buffer, p61: table?) -- Line: 249
        -- upvalues: u53 (copy), RunService (copy), Import (copy), Ended (copy), u7 (copy), NumberU8 (copy), script_Task (copy), u58 (copy), u3 (ref), u9 (ref)
        local v62 = u53[p59] or 0;
        local buffer_len_ret = buffer.len(p60);
        local v63 = v62 + math.max(buffer_len_ret, 800);

        if v63 > 8000 then
            if RunService:IsStudio() then
                warn(p59.Name, "is exceeding the data/rate limit; some events may be dropped");
            end;

            return;
        end;

        u53[p59] = v63;
        Import({
            BufferOffset = 0,
            InstancesOffset = 0,
            Buffer = p60,
            BufferLength = buffer.len(p60),
            Instances = p61 or {}
        });

        while Ended() == false do
            local v64 = u7[NumberU8()];

            if not v64 then
                warn("Unknown packet ID received from", p59.Name, "discarding buffer");

                return;
            end;

            if v64.ResponseReads then
                local v65 = NumberU8();

                if v65 < 128 then
                    script_Task:Defer(u58, v64, p59, v65, u3(v64.Reads));
                else
                    local v66 = v65 - 128;
                    local v67 = u9[p59][v66];

                    if v67 then
                        task.cancel(v67.Timeout);
                        local Yielded = v67.Yielded;

                        if coroutine.status(Yielded) == "suspended" then
                            task.defer(Yielded, u3(v64.ResponseReads));
                        else
                            u3(v64.ResponseReads);
                        end;

                        u9[p59][v66] = nil;
                    elseif RunService:IsStudio() then
                        warn("Response thread not found for packet:", v64.Name, "discarding response:", u3(v64.ResponseReads));
                    else
                        u3(v64.ResponseReads);
                    end;
                end;
            else
                v64.OnServerEvent:Fire(p59, u3(v64.Reads));
            end;
        end;
    end;

    u11.OnServerEvent:Connect(function(p69: userdata, ...) -- Line: 288
        -- upvalues: u68 (copy), RunService (copy)
        local _, result = pcall(u68, p69, ...);

        if result and RunService:IsStudio() then
            warn(p69.Name, result);
        end;
    end);
    Players.PlayerRemoving:Connect(function(p70) -- Line: 293
        -- upvalues: u8 (ref), u9 (ref), u53 (copy)
        u8[p70] = nil;
        u9[p70] = nil;
        u53[p70] = nil;
    end);
    RunService.Heartbeat:Connect(function(p71) -- Line: 299
        -- upvalues: task_spawn_ret (copy)
        task.defer(task_spawn_ret);
    end);
else
    u10 = {
        Index = 0
    };
    u11 = script:WaitForChild("RemoteEvent");
    local u72 = 0;
    local task_spawn_ret = task.spawn(function() -- Line: 305
        -- upvalues: u13 (ref), u11 (ref)
        while true do
            repeat
                coroutine.yield();
            until u13.BufferOffset > 0;

            local buffer_create_ret = buffer.create(u13.BufferOffset);
            buffer.copy(buffer_create_ret, 0, u13.Buffer, 0, u13.BufferOffset);

            if u13.InstancesOffset == 0 then
                u11:FireServer(buffer_create_ret);
            else
                u11:FireServer(buffer_create_ret, u13.Instances);
                u13.InstancesOffset = 0;
                table.clear(u13.Instances);
            end;

            u13.BufferOffset = 0;
        end;
    end);

    local function u76(p73: table, p74: number, ...) -- Line: 323
        -- upvalues: Import (copy), u13 (ref), NumberU82 (copy), u4 (ref), Export (copy)
        if p73.OnClientInvoke == nil then
            warn("OnClientInvoke not found for packet:", p73.Name, "discarding event:", ...);

            return;
        end;

        local v75 = { p73.OnClientInvoke(...) };
        Import(u13);
        NumberU82(p73.Id);
        NumberU82(p74 + 128);
        u4(p73.ResponseWrites, v75);
        u13 = Export();
    end;

    u11.OnClientEvent:Connect(function(p77: buffer, p78: table?) -- Line: 333
        -- upvalues: Import (copy), Ended (copy), u7 (copy), NumberU8 (copy), script_Task (copy), u76 (copy), u3 (ref), u10 (ref)
        Import({
            BufferOffset = 0,
            InstancesOffset = 0,
            Buffer = p77,
            BufferLength = buffer.len(p77),
            Instances = p78 or {}
        });

        while Ended() == false do
            local v79 = u7[NumberU8()];

            if not v79 then
                warn("Unknown packet ID received, discarding buffer");

                return;
            end;

            if v79.ResponseReads then
                local v80 = NumberU8();

                if v80 < 128 then
                    script_Task:Defer(u76, v79, v80, u3(v79.Reads));
                else
                    local v81 = v80 - 128;
                    local v82 = u10[v81];

                    if v82 then
                        task.cancel(v82.Timeout);
                        local Yielded = v82.Yielded;

                        if coroutine.status(Yielded) == "suspended" then
                            task.defer(Yielded, u3(v79.ResponseReads));
                        end;

                        v82[v81] = nil;
                    else
                        warn("Response thread not found for packet:", v79.Name, "discarding response:", u3(v79.ResponseReads));
                    end;
                end;
            else
                v79.OnClientEvent:Fire(u3(v79.Reads));
            end;
        end;
    end);
    u11.AttributeChanged:Connect(function(p83) -- Line: 367
        -- upvalues: u7 (copy), u11 (ref)
        local v84 = u7[p83];

        if v84 then
            if v84.Id then
                u7[v84.Id] = nil;
            end;

            v84.Id = u11:GetAttribute(p83);

            if v84.Id then
                u7[v84.Id] = v84;
            end;
        end;
    end);
    RunService.Heartbeat:Connect(function(p85) -- Line: 376
        -- upvalues: u72 (ref), task_spawn_ret (copy)
        u72 = u72 + p85;

        if u72 > 0.016666666666666666 then
            u72 = u72 - 0.016666666666666666;
            task.defer(task_spawn_ret);
        end;
    end);
end;

return setmetatable(script_Types.Types, {
    __call = Constructor
});