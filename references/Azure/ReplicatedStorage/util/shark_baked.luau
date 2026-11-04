 

 

local EncodingService = game:GetService("EncodingService");
local u1 = {};

local function read_u8(p2: table) -- Line: 46
    if p2.position >= p2.size then
        error("shark_baked: unexpected end of data");
    end;

    local buffer_readu8_ret = buffer.readu8(p2.data, p2.position);
    p2.position = p2.position + 1;

    return buffer_readu8_ret;
end;

local function read_varint(p3: table) -- Line: 55
    local v4 = 1;
    local v5 = 0;

    for i = 1, 5 do
        if p3.position >= p3.size then
            error("shark_baked: unexpected end of data");
        end;

        local buffer_readu8_ret = buffer.readu8(p3.data, p3.position);
        p3.position = p3.position + 1;
        v5 = v5 + buffer_readu8_ret % 128 * v4;

        if buffer_readu8_ret < 128 then
            return v5;
        end;

        v4 = v4 * 128;
        local _ = i;
    end;

    error("shark_baked: malformed varint");
end;

local function read_string(p6: table) -- Line: 69
    if p6.position >= p6.size then
        error("shark_baked: unexpected end of data");
    end;

    local buffer_readu8_ret = buffer.readu8(p6.data, p6.position);
    p6.position = p6.position + 1;
    local buffer_readstring_ret = buffer.readstring(p6.data, p6.position, buffer_readu8_ret);
    p6.position = p6.position + buffer_readu8_ret;

    return buffer_readstring_ret;
end;

local function read_f32(p7: table) -- Line: 76
    local buffer_readf32_ret = buffer.readf32(p7.data, p7.position);
    p7.position = p7.position + 4;

    return buffer_readf32_ret;
end;

local u12 = {
    [1] = function(p8: table) -- Line: 83
        local buffer_readf32_ret = buffer.readf32(p8.data, p8.position);
        p8.position = p8.position + 4;

        return buffer_readf32_ret;
    end,

    [2] = function(p9: table) -- Line: 86
        if p9.position >= p9.size then
            error("shark_baked: unexpected end of data");
        end;

        local buffer_readu8_ret = buffer.readu8(p9.data, p9.position);
        p9.position = p9.position + 1;

        return buffer_readu8_ret ~= 0;
    end,

    [5] = function(p10: table) -- Line: 89
        local Color3_new = Color3.new;
        local buffer_readf32_ret = buffer.readf32(p10.data, p10.position);
        p10.position = p10.position + 4;
        local buffer_readf32_ret2 = buffer.readf32(p10.data, p10.position);
        p10.position = p10.position + 4;
        local buffer_readf32_ret3 = buffer.readf32(p10.data, p10.position);
        p10.position = p10.position + 4;

        return Color3_new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
    end,

    [13] = function(p11: table) -- Line: 92
        local buffer_readf32_ret = buffer.readf32(p11.data, p11.position);
        p11.position = p11.position + 4;
        local buffer_readf32_ret2 = buffer.readf32(p11.data, p11.position);
        p11.position = p11.position + 4;
        local buffer_readf32_ret3 = buffer.readf32(p11.data, p11.position);
        p11.position = p11.position + 4;
        local buffer_readf32_ret4 = buffer.readf32(p11.data, p11.position);
        p11.position = p11.position + 4;
        local buffer_readf32_ret5 = buffer.readf32(p11.data, p11.position);
        p11.position = p11.position + 4;
        local buffer_readf32_ret6 = buffer.readf32(p11.data, p11.position);
        p11.position = p11.position + 4;
        local buffer_readf32_ret7 = buffer.readf32(p11.data, p11.position);
        p11.position = p11.position + 4;

        return CFrame.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3, buffer_readf32_ret4, buffer_readf32_ret5, buffer_readf32_ret6, buffer_readf32_ret7);
    end
};

local function decode(p13: string) -- Line: 99
    -- upvalues: EncodingService (copy), read_varint (copy), u12 (copy)
    local v14 = EncodingService:DecompressBuffer(EncodingService:Base64Decode(buffer.fromstring(p13)), Enum.CompressionAlgorithm.Zstd);
    local v15 = {
        position = 0,
        data = v14,
        size = buffer.len(v14)
    };

    if buffer.readstring(v14, 0, 13) ~= "NomSharkEllen" then
        error("shark_baked: bad header");
    end;

    v15.position = 13;

    if v15.position >= v15.size then
        error("shark_baked: unexpected end of data");
    end;

    buffer.readu8(v15.data, v15.position);
    v15.position = v15.position + 1;

    if v15.position >= v15.size then
        error("shark_baked: unexpected end of data");
    end;

    buffer.readu8(v15.data, v15.position);
    v15.position = v15.position + 1;

    if v15.position >= v15.size then
        error("shark_baked: unexpected end of data");
    end;

    local buffer_readu8_ret = buffer.readu8(v15.data, v15.position);
    v15.position = v15.position + 1;
    local v16 = read_varint(v15);

    if v15.position >= v15.size then
        error("shark_baked: unexpected end of data");
    end;

    local buffer_readu8_ret2 = buffer.readu8(v15.data, v15.position);
    v15.position = v15.position + 1;
    local buffer_readstring_ret = buffer.readstring(v15.data, v15.position, buffer_readu8_ret2);
    v15.position = v15.position + buffer_readu8_ret2;

    if v15.position >= v15.size then
        error("shark_baked: unexpected end of data");
    end;

    local buffer_readu8_ret3 = buffer.readu8(v15.data, v15.position);
    v15.position = v15.position + 1;

    if buffer_readu8_ret3 ~= 0 then
        v15.position = v15.position + 28;
    end;

    local v17 = 0;
    local v18 = {};

    for i = 1, read_varint(v15) do
        v17 = v17 + read_varint(v15);

        if v15.position >= v15.size then
            error("shark_baked: unexpected end of data");
        end;

        buffer.readu8(v15.data, v15.position);
        v15.position = v15.position + 1;

        if v15.position >= v15.size then
            error("shark_baked: unexpected end of data");
        end;

        local buffer_readu8_ret4 = buffer.readu8(v15.data, v15.position);
        v15.position = v15.position + 1;
        local buffer_readstring_ret2 = buffer.readstring(v15.data, v15.position, buffer_readu8_ret4);
        v15.position = v15.position + buffer_readu8_ret4;

        if v15.position >= v15.size then
            error("shark_baked: unexpected end of data");
        end;

        buffer.readu8(v15.data, v15.position);
        v15.position = v15.position + 1;
        table.insert(v18, table.freeze({
            name = buffer_readstring_ret2,
            frame = v17
        }));
        local _ = i;
    end;

    local v19 = {};

    if v15.position >= v15.size then
        error("shark_baked: unexpected end of data");
    end;

    local buffer_readu8_ret4 = buffer.readu8(v15.data, v15.position);
    v15.position = v15.position + 1;

    for i = 1, buffer_readu8_ret4 do
        if v15.position >= v15.size then
            error("shark_baked: unexpected end of data");
        end;

        local buffer_readu8_ret5 = buffer.readu8(v15.data, v15.position);
        v15.position = v15.position + 1;
        local buffer_readstring_ret2 = buffer.readstring(v15.data, v15.position, buffer_readu8_ret5);
        v15.position = v15.position + buffer_readu8_ret5;

        if v15.position >= v15.size then
            error("shark_baked: unexpected end of data");
        end;

        local buffer_readu8_ret6 = buffer.readu8(v15.data, v15.position);
        v15.position = v15.position + 1;

        if buffer_readu8_ret6 == 2 then
            if v15.position >= v15.size then
                error("shark_baked: unexpected end of data");
            end;

            buffer.readu8(v15.data, v15.position);
            v15.position = v15.position + 1;
        end;

        if v15.position >= v15.size then
            error("shark_baked: unexpected end of data");
        end;

        local buffer_readu8_ret7 = buffer.readu8(v15.data, v15.position);
        v15.position = v15.position + 1;
        local _ = i;
        local v20 = {};

        for i2 = 1, buffer_readu8_ret7 do
            if v15.position >= v15.size then
                error("shark_baked: unexpected end of data");
            end;

            local buffer_readu8_ret8 = buffer.readu8(v15.data, v15.position);
            v15.position = v15.position + 1;
            local buffer_readstring_ret3 = buffer.readstring(v15.data, v15.position, buffer_readu8_ret8);
            v15.position = v15.position + buffer_readu8_ret8;
            table.insert(v20, buffer_readstring_ret3);

            if v15.position >= v15.size then
                error("shark_baked: unexpected end of data");
            end;

            local buffer_readu8_ret9 = buffer.readu8(v15.data, v15.position);
            v15.position = v15.position + 1;
            buffer.readstring(v15.data, v15.position, buffer_readu8_ret9);
            v15.position = v15.position + buffer_readu8_ret9;
            local _ = i2;
        end;

        local v21 = {};

        if v15.position >= v15.size then
            error("shark_baked: unexpected end of data");
        end;

        local buffer_readu8_ret8 = buffer.readu8(v15.data, v15.position);
        v15.position = v15.position + 1;

        for i2 = 1, buffer_readu8_ret8 do
            if v15.position >= v15.size then
                error("shark_baked: unexpected end of data");
            end;

            local buffer_readu8_ret9 = buffer.readu8(v15.data, v15.position);
            v15.position = v15.position + 1;
            local buffer_readstring_ret3 = buffer.readstring(v15.data, v15.position, buffer_readu8_ret9);
            v15.position = v15.position + buffer_readu8_ret9;

            if v15.position >= v15.size then
                error("shark_baked: unexpected end of data");
            end;

            local buffer_readu8_ret10 = buffer.readu8(v15.data, v15.position);
            v15.position = v15.position + 1;

            if v15.position >= v15.size then
                error("shark_baked: unexpected end of data");
            end;

            buffer.readu8(v15.data, v15.position);
            v15.position = v15.position + 1;
            local v22 = u12[buffer_readu8_ret10];

            if not v22 then
                error((`shark_baked: unsupported value type {buffer_readu8_ret10} on {buffer_readstring_ret3}`));
            end;

            local _ = i2;
            local v23 = {};
            local v24 = 0;

            for i3 = 1, read_varint(v15) do
                if v15.position >= v15.size then
                    error("shark_baked: unexpected end of data");
                end;

                local buffer_readu8_ret11 = buffer.readu8(v15.data, v15.position);
                v15.position = v15.position + 1;
                local v25 = read_varint(v15);
                local v26;

                if buffer_readu8_ret11 == 0 then
                    local table_freeze = table.freeze;
                    local v27 = {
                        start = v24,
                        count = v25,
                        constant = v22(v15)
                    };
                    table.insert(v23, table_freeze(v27));
                    v26 = i3;
                elseif buffer_readu8_ret11 == 1 then
                    local table_create_ret = table.create(v25);
                    v26 = i3;

                    for i4 = 1, v25 do
                        table_create_ret[i4] = v22(v15);
                        local _ = i4;
                    end;

                    local table_freeze = table.freeze;
                    local v28 = {
                        start = v24,
                        count = v25,
                        values = table.freeze(table_create_ret)
                    };
                    table.insert(v23, table_freeze(v28));
                else
                    error((`shark_baked: unsupported segment kind {buffer_readu8_ret11}`));
                    v26 = i3;
                end;

                v24 = v24 + v25;
            end;

            v21[buffer_readstring_ret3] = table.freeze({
                name = buffer_readstring_ret3,
                value_type = buffer_readu8_ret10,
                segments = table.freeze(v23)
            });
        end;

        local v29 = v20[#v20] or buffer_readstring_ret2;
        v19[v29] = table.freeze({
            class_name = buffer_readstring_ret2,
            path = table.freeze(v20),
            name = v29,
            props = table.freeze(v21)
        });
    end;

    return table.freeze({
        fps = buffer_readu8_ret,
        length = v16,
        priority = buffer_readstring_ret,
        markers = table.freeze(v18),
        items = table.freeze(v19)
    });
end;

return table.freeze({
    load = function(u30: userdata) -- Line: 187, Name: load
        -- upvalues: u1 (copy), decode (copy)
        if typeof(u30) ~= "Instance" or not u30:IsA("ModuleScript") then
            return nil;
        end;

        local v31 = u1[u30];

        if v31 ~= nil then
            return v31 or nil;
        end;

        local success, result = pcall(function() -- Line: 195
            -- upvalues: u30 (copy), decode (ref)
            local v32 = require(u30);
            local v33;

            if typeof(v32) == "table" then
                v33 = v32.ZB;
            else
                v33 = nil;
            end;

            if typeof(v33) ~= "string" then
                error("shark_baked: missing data");
            end;

            return decode(v33);
        end);

        if success then
            u1[u30] = result;

            return result;
        end;

        warn(result);
        u1[u30] = false;

        return nil;
    end,

    sample = function(p34: table?, p35: number) -- Line: 212, Name: sample
        if not p34 then
            return nil;
        end;

        local segments = p34.segments;
        local v36 = #segments;

        if v36 == 0 then
            return nil;
        end;

        local math_floor_ret = math.floor(p35);
        local math_max_ret = math.max(math_floor_ret, 0);

        for _, v in segments do
            if math_max_ret < v.start + v.count then
                local values = v.values;

                if values then
                    return values[math_max_ret - v.start + 1];
                end;

                return v.constant;
            end;
        end;

        local v37 = segments[v36];
        local values = v37.values;

        if values then
            return values[#values];
        end;

        return v37.constant;
    end
});