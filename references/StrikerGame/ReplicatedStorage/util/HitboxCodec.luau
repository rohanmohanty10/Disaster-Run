 

 

local u1 = {
    maxPacketBytes = 900,
    maxHurtboxes = 28,
    shapes = {
        box = 0,
        sphere = 1,
        cylinder = 2,
        wedge = 3,
        cone = 4
    }
};

local function mapAngle(p2: number) -- Line: 45
    local math_round_ret = math.round((p2 + 3.141592653589793) / 6.283185307179586 * 65535);

    return math.clamp(math_round_ret, 0, 65535);
end;

local function unmapAngle(p3: number) -- Line: 49
    return p3 / 65535 * 6.283185307179586 - 3.141592653589793;
end;

local function writeTransform(p4: buffer, p5: number, p6, p7: vector) -- Line: 53
    local v8, v9, v10 = p6:ToOrientation();
    buffer.writef32(p4, p5, p6.X);
    buffer.writef32(p4, p5 + 4, p6.Y);
    buffer.writef32(p4, p5 + 8, p6.Z);
    buffer.writef32(p4, p5 + 12, p7.X);
    buffer.writef32(p4, p5 + 16, p7.Y);
    buffer.writef32(p4, p5 + 20, p7.Z);
    local math_round_ret = math.round((v8 + 3.141592653589793) / 6.283185307179586 * 65535);
    local math_clamp_ret = math.clamp(math_round_ret, 0, 65535);
    buffer.writeu16(p4, p5 + 24, math_clamp_ret);
    local math_round_ret2 = math.round((v9 + 3.141592653589793) / 6.283185307179586 * 65535);
    local math_clamp_ret2 = math.clamp(math_round_ret2, 0, 65535);
    buffer.writeu16(p4, p5 + 26, math_clamp_ret2);
    local math_round_ret3 = math.round((v10 + 3.141592653589793) / 6.283185307179586 * 65535);
    local math_clamp_ret3 = math.clamp(math_round_ret3, 0, 65535);
    buffer.writeu16(p4, p5 + 28, math_clamp_ret3);

    return p5 + 30;
end;

local function readTransform(p11: buffer, p12: number) -- Line: 67
    local buffer_readf32_ret = buffer.readf32(p11, p12);
    local buffer_readf32_ret2 = buffer.readf32(p11, p12 + 4);
    local buffer_readf32_ret3 = buffer.readf32(p11, p12 + 8);
    local Vector3_new_ret = Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
    local buffer_readf32_ret4 = buffer.readf32(p11, p12 + 12);
    local buffer_readf32_ret5 = buffer.readf32(p11, p12 + 16);
    local buffer_readf32_ret6 = buffer.readf32(p11, p12 + 20);
    local Vector3_new_ret2 = Vector3.new(buffer_readf32_ret4, buffer_readf32_ret5, buffer_readf32_ret6);
    local CFrame_fromOrientation_ret = CFrame.fromOrientation(buffer.readu16(p11, p12 + 24) / 65535 * 6.283185307179586 - 3.141592653589793, buffer.readu16(p11, p12 + 26) / 65535 * 6.283185307179586 - 3.141592653589793, buffer.readu16(p11, p12 + 28) / 65535 * 6.283185307179586 - 3.141592653589793);

    return CFrame.new(Vector3_new_ret) * CFrame_fromOrientation_ret, Vector3_new_ret2, p12 + 30;
end;

function u1.sizeOf(p13: table) -- Line: 79
    return math.min(#p13.hurtboxes, 28) * 30 + 33;
end;

function u1.write(p14: buffer, p15: number, p16: table) -- Line: 83
    -- upvalues: writeTransform (copy)
    local math_min_ret = math.min(#p16.hurtboxes, 28);
    buffer.writeu8(p14, p15, p16.shape);
    buffer.writeu8(p14, p15 + 1, p16.hit and 1 or 0);
    local v17 = writeTransform(p14, p15 + 2, p16.cframe, p16.size);
    buffer.writeu8(p14, v17, math_min_ret);
    local v18 = v17 + 1;

    for i = 1, math_min_ret do
        local v19 = p16.hurtboxes[i];
        v18 = writeTransform(p14, v18, v19.cframe, v19.size);
        local _ = i;
    end;

    return v18;
end;

function u1.read(p20: buffer, p21: number) -- Line: 97
    -- upvalues: readTransform (copy)
    local buffer_readu8_ret = buffer.readu8(p20, p21);
    local v22 = buffer.readu8(p20, p21 + 1) == 1;
    local v23, v24, v25 = readTransform(p20, p21 + 2);
    local buffer_readu8_ret2 = buffer.readu8(p20, v25);
    local v26 = v25 + 1;
    local table_create_ret = table.create(buffer_readu8_ret2);

    for i = 1, buffer_readu8_ret2 do
        local v27, v28;
        v27, v28, v26 = readTransform(p20, v26);
        table_create_ret[i] = {
            cframe = v27,
            size = v28
        };
        local _ = i;
    end;

    return {
        shape = buffer_readu8_ret,
        hit = v22,
        cframe = v23,
        size = v24,
        hurtboxes = table_create_ret
    }, v26;
end;

function u1.encode(p29: table) -- Line: 118
    -- upvalues: u1 (copy)
    local buffer_create_ret = buffer.create(900);
    local v30 = 0;
    local v31 = {};

    for _, v in p29 do
        if v30 + u1.sizeOf(v) > 900 then
            local buffer_create_ret2 = buffer.create(v30);
            buffer.copy(buffer_create_ret2, 0, buffer_create_ret, 0, v30);
            table.insert(v31, buffer_create_ret2);
            v30 = 0;
        end;

        v30 = u1.write(buffer_create_ret, v30, v);
    end;

    if v30 > 0 then
        local buffer_create_ret2 = buffer.create(v30);
        buffer.copy(buffer_create_ret2, 0, buffer_create_ret, 0, v30);
        table.insert(v31, buffer_create_ret2);
    end;

    return v31;
end;

function u1.encodeFrames(p32: table) -- Line: 140
    -- upvalues: writeTransform (copy)
    local buffer_create_ret = buffer.create(900);
    local v33 = 0;
    local v34 = {};

    for _, v in p32 do
        local v35;

        if v.own then
            v35 = v.time;
        else
            v35 = nil;
        end;

        if v33 + (v35 and 41 or 33) > 900 then
            local buffer_create_ret2 = buffer.create(v33);
            buffer.copy(buffer_create_ret2, 0, buffer_create_ret, 0, v33);
            table.insert(v34, buffer_create_ret2);
            v33 = 0;
        end;

        local v36 = v.own and 1 or 0;

        if v35 then
            v36 = v36 + 2;
        end;

        buffer.writeu16(buffer_create_ret, v33, v.id);
        buffer.writeu8(buffer_create_ret, v33 + 2, v36);
        v33 = writeTransform(buffer_create_ret, v33 + 3, v.cframe, v.size);

        if v35 then
            buffer.writef64(buffer_create_ret, v33, v35);
            v33 = v33 + 8;
        end;
    end;

    if v33 > 0 then
        local buffer_create_ret2 = buffer.create(v33);
        buffer.copy(buffer_create_ret2, 0, buffer_create_ret, 0, v33);
        table.insert(v34, buffer_create_ret2);
    end;

    return v34;
end;

function u1.decodeFrames(p37: buffer) -- Line: 173
    -- upvalues: readTransform (copy)
    local buffer_len_ret = buffer.len(p37);
    local v38 = 0;
    local v39 = {};

    while v38 + 33 <= buffer_len_ret do
        local buffer_readu16_ret = buffer.readu16(p37, v38);
        local buffer_readu8_ret = buffer.readu8(p37, v38 + 2);
        local v40, v41;
        v40, v41, v38 = readTransform(p37, v38 + 3);
        local v42;

        if bit32.btest(buffer_readu8_ret, 2) then
            if buffer_len_ret < v38 + 8 then
                break;
            end;

            v42 = buffer.readf64(p37, v38);
            v38 = v38 + 8;
        else
            v42 = nil;
        end;

        local v43 = {
            id = buffer_readu16_ret,
            own = bit32.btest(buffer_readu8_ret, 1),
            cframe = v40,
            size = v41,
            time = v42
        };
        table.insert(v39, v43);
    end;

    return v39;
end;

function u1.decode(p44: buffer) -- Line: 201
    -- upvalues: u1 (copy)
    local buffer_len_ret = buffer.len(p44);
    local v45 = 0;
    local v46 = {};

    while v45 + 33 <= buffer_len_ret do
        local v47;
        v47, v45 = u1.read(p44, v45);
        table.insert(v46, v47);
    end;

    return v46;
end;

return u1;