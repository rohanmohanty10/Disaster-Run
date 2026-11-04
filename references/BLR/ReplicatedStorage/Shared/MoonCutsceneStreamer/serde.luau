  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local BufferSerialization = require(script.Parent.BufferSerialization);
local Squash = require(ReplicatedStorage.Packages.Squash);
local v1 = {};
local buffer_copy = buffer.copy;
local buffer_create = buffer.create;
local buffer_len = buffer.len;
local buffer_create_ret = buffer.create(4);

local function getNumberAsString(p2) -- Line: 23
    -- upvalues: buffer_create_ret (copy)
    buffer.writeu32(buffer_create_ret, 0, p2);

    return buffer.tostring(buffer_create_ret):match("(.*\0).*", 1);
end;

local function getStringAsNumber(p3) -- Line: 29
    -- upvalues: buffer_create_ret (copy)
    if type(p3) ~= "string" then
        return nil;
    end;

    buffer.fill(buffer_create_ret, 0, 0);
    buffer.writestring(buffer_create_ret, 0, p3);

    return buffer.readu32(buffer_create_ret, 0);
end;

local function deepCopy(p4) -- Line: 36
    -- upvalues: deepCopy (copy), buffer_copy (copy), buffer_create (copy), buffer_len (copy)
    if type(p4) ~= "table" then
        return p4;
    end;

    local table_clone_ret = table.clone(p4);

    for i, v in p4 do
        if type(v) == "table" then
            table_clone_ret[i] = deepCopy(v);
        elseif type(v) == "buffer" then
            table_clone_ret[i] = buffer_copy(v, 0, buffer_create(buffer_len(v)));
        end;
    end;

    return table_clone_ret;
end;

function v1.serialise(p5) -- Line: 52
    -- upvalues: HttpService (copy), deepCopy (copy), buffer_create_ret (copy)
    if typeof(p5) == "string" then
        return HttpService:JSONDecode(p5);
    end;

    local u6 = {};
    local v7 = deepCopy(p5);
    local u8 = {};

    local function registerValue(p9, p10) -- Line: 61
        -- upvalues: u8 (copy), u6 (copy), buffer_create_ret (ref)
        if u8[p9] then
            return u8[p9];
        end;

        local v11 = type(p9);

        if v11 ~= "string" and (v11 ~= "table" or not p10) then
            return p9;
        end;

        local v12 = #u6 + 1;
        u6[v12] = p9;
        buffer.writeu32(buffer_create_ret, 0, v12);
        local v13 = buffer.tostring(buffer_create_ret):match("(.*\0).*", 1);

        if v13 == "" then
            warn("what in the actual flying fk is going on", v12, p9, p10);
        end;

        u8[p9] = v13;

        return v13;
    end;

    local function explore(p14: table) -- Line: 81
        -- upvalues: registerValue (copy), explore (copy)
        for i, v in table.clone(p14) do
            local v15 = registerValue(i, true);
            local v16 = registerValue(v, false);

            if v15 ~= i then
                p14[i] = nil;
            end;

            p14[v15] = v16;

            if type(v) == "table" then
                explore(v);
            end;
        end;
    end;

    explore(v7);

    return {
        meta = u6,
        data = v7
    };
end;

function v1.deserialise(p17) -- Line: 99
    -- upvalues: BufferSerialization (copy), Squash (copy), buffer_create_ret (copy)
    if typeof(p17) == "buffer" then
        return BufferSerialization.des(Squash.frombuffer(p17));
    end;

    local meta = p17.meta;

    local function u23(p18: table) -- Line: 106
        -- upvalues: buffer_create_ret (ref), meta (copy), u23 (copy)
        for i, v in table.clone(p18) do
            local v19;

            if type(i) == "string" then
                buffer.fill(buffer_create_ret, 0, 0);
                buffer.writestring(buffer_create_ret, 0, i);
                v19 = buffer.readu32(buffer_create_ret, 0);
            else
                v19 = nil;
            end;

            local v20;

            if type(v) == "string" then
                buffer.fill(buffer_create_ret, 0, 0);
                buffer.writestring(buffer_create_ret, 0, v);
                v20 = buffer.readu32(buffer_create_ret, 0);
            else
                v20 = nil;
            end;

            local v21;

            if v19 then
                v21 = meta[v19];
            else
                v21 = i;
            end;

            local v22;

            if v20 then
                v22 = meta[v20];
            else
                v22 = v;
            end;

            if v21 ~= i then
                p18[i] = nil;
            end;

            if v19 and v21 == nil then
                local string_byte_ret = string.byte(i);
                warn("wtf", type(i), string_byte_ret, v);
                warn(v19, v20);
                warn(v21, v22);
            end;

            p18[v21] = v22;

            if type(v22) == "table" then
                u23(v22);
            end;
        end;
    end;

    u23(p17.data);

    return p17.data;
end;

return v1;