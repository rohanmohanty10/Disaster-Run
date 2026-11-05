  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(script.Parent.Parent.types);
local read = require(script.Parent.read);
local bufferWriter = require(script.Parent.bufferWriter);
local alloc = bufferWriter.alloc;
local u8 = bufferWriter.u8;
local load = bufferWriter.load;

local function onClientEvent(p1, p2) -- Line: 12
    -- upvalues: read (copy)
    read(p1, p2);
end;

local function create() -- Line: 17
    return {
        cursor = 0,
        size = 256,
        references = {},
        buff = buffer.create(256)
    };
end;

local function dump(p3) -- Line: 26
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

return {
    sendReliable = function(p7, p8, p9) -- Line: 41, Name: sendReliable
        -- upvalues: u5 (ref), load (copy), alloc (copy), u8 (copy), bufferWriter (copy)
        u5 = load(u5);
        alloc(1);
        u8(p7);
        p8(p9);
        u5 = bufferWriter.export();
    end,

    sendUnreliable = function(p10, p11, p12) -- Line: 51, Name: sendUnreliable
        -- upvalues: u6 (ref), load (copy), alloc (copy), u8 (copy), bufferWriter (copy)
        u6 = load(u6);
        alloc(1);
        u8(p10);
        p11(p12);
        u6 = bufferWriter.export();
    end,

    start = function() -- Line: 61, Name: start
        -- upvalues: ReplicatedStorage (copy), onClientEvent (copy), RunService (copy), u5 (ref), u6 (ref)
        local ByteNetReliable = ReplicatedStorage:WaitForChild("ByteNetReliable");
        ByteNetReliable.OnClientEvent:Connect(onClientEvent);
        local ByteNetUnreliable = ReplicatedStorage:WaitForChild("ByteNetUnreliable");
        ByteNetUnreliable.OnClientEvent:Connect(onClientEvent);
        RunService.Heartbeat:Connect(function() -- Line: 68
            -- upvalues: u5 (ref), ByteNetReliable (copy), u6 (ref), ByteNetUnreliable (copy)
            if u5.cursor > 0 then
                local v13 = u5;
                local cursor = v13.cursor;
                local v14 = buffer.create(cursor);
                buffer.copy(v14, 0, v13.buff, 0, cursor);
                local v15;

                if #v13.references > 0 then
                    v15 = v13.references;
                else
                    v15 = nil;
                end;

                ByteNetReliable:FireServer(v14, v15);
                u5.cursor = 0;
                table.clear(u5.references);
            end;

            if u6.cursor > 0 then
                local v16 = u6;
                local cursor = v16.cursor;
                local v17 = buffer.create(cursor);
                buffer.copy(v17, 0, v16.buff, 0, cursor);
                local v18;

                if #v16.references > 0 then
                    v18 = v16.references;
                else
                    v18 = nil;
                end;

                ByteNetUnreliable:FireServer(v17, v18);
                u6.cursor = 0;
                table.clear(u6.references);
            end;
        end);
    end
};