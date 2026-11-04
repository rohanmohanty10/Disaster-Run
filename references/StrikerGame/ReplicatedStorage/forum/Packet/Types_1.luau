 
 

local Enums = Enum:GetEnums();
local u1 = {};
local v2 = {};
local u3 = {};
local v4 = {};
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local v11 = {};
local u12 = {};

for i, v in Enums do
    u1[v] = i;
end;

local function Allocate(p13: number) -- Line: 49
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v14 = u5 + p13;

    if u6 < v14 then
        while u6 < v14 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;
end;

local function ReadS8() -- Line: 60
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readi8_ret = buffer.readi8(u7, u5);
    u5 = u5 + 1;

    return buffer_readi8_ret;
end;

local function WriteS8(p15: number) -- Line: 61
    -- upvalues: u7 (ref), u5 (ref)
    buffer.writei8(u7, u5, p15);
    u5 = u5 + 1;
end;

local function ReadS16() -- Line: 62
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readi16_ret = buffer.readi16(u7, u5);
    u5 = u5 + 2;

    return buffer_readi16_ret;
end;

local function WriteS16(p16: number) -- Line: 63
    -- upvalues: u7 (ref), u5 (ref)
    buffer.writei16(u7, u5, p16);
    u5 = u5 + 2;
end;

local function ReadS24() -- Line: 64
    -- upvalues: u7 (ref), u5 (ref)
    local v17 = buffer.readbits(u7, u5 * 8, 24) - 8388608;
    u5 = u5 + 3;

    return v17;
end;

local function WriteS24(p18: number) -- Line: 65
    -- upvalues: u7 (ref), u5 (ref)
    buffer.writebits(u7, u5 * 8, 24, p18 + 8388608);
    u5 = u5 + 3;
end;

local function ReadS32() -- Line: 66
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readi32_ret = buffer.readi32(u7, u5);
    u5 = u5 + 4;

    return buffer_readi32_ret;
end;

local function WriteS32(p19: number) -- Line: 67
    -- upvalues: u7 (ref), u5 (ref)
    buffer.writei32(u7, u5, p19);
    u5 = u5 + 4;
end;

local function ReadU8() -- Line: 68
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;

    return buffer_readu8_ret;
end;

local function WriteU8(p20: number) -- Line: 69
    -- upvalues: u7 (ref), u5 (ref)
    buffer.writeu8(u7, u5, p20);
    u5 = u5 + 1;
end;

local function ReadU16() -- Line: 70
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu16_ret = buffer.readu16(u7, u5);
    u5 = u5 + 2;

    return buffer_readu16_ret;
end;

local function WriteU16(p21: number) -- Line: 71
    -- upvalues: u7 (ref), u5 (ref)
    buffer.writeu16(u7, u5, p21);
    u5 = u5 + 2;
end;

local function ReadU24() -- Line: 72
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readbits_ret = buffer.readbits(u7, u5 * 8, 24);
    u5 = u5 + 3;

    return buffer_readbits_ret;
end;

local function WriteU24(p22: number) -- Line: 73
    -- upvalues: u7 (ref), u5 (ref)
    buffer.writebits(u7, u5 * 8, 24, p22);
    u5 = u5 + 3;
end;

local function ReadU32() -- Line: 74
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu32_ret = buffer.readu32(u7, u5);
    u5 = u5 + 4;

    return buffer_readu32_ret;
end;

local function WriteU32(p23: number) -- Line: 75
    -- upvalues: u7 (ref), u5 (ref)
    buffer.writeu32(u7, u5, p23);
    u5 = u5 + 4;
end;

local function ReadF32() -- Line: 76
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return buffer_readf32_ret;
end;

local function WriteF32(p24: number) -- Line: 77
    -- upvalues: u7 (ref), u5 (ref)
    buffer.writef32(u7, u5, p24);
    u5 = u5 + 4;
end;

local function ReadF64() -- Line: 78
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readf64_ret = buffer.readf64(u7, u5);
    u5 = u5 + 8;

    return buffer_readf64_ret;
end;

local function WriteF64(p25: number) -- Line: 79
    -- upvalues: u7 (ref), u5 (ref)
    buffer.writef64(u7, u5, p25);
    u5 = u5 + 8;
end;

local function ReadString(p26: number) -- Line: 80
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readstring_ret = buffer.readstring(u7, u5, p26);
    u5 = u5 + p26;

    return buffer_readstring_ret;
end;

local function WriteString(p27: string) -- Line: 81
    -- upvalues: u7 (ref), u5 (ref)
    buffer.writestring(u7, u5, p27);
    u5 = u5 + #p27;
end;

local function ReadBuffer(p28: number) -- Line: 82
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_create_ret = buffer.create(p28);
    buffer.copy(buffer_create_ret, 0, u7, u5, p28);
    u5 = u5 + p28;

    return buffer_create_ret;
end;

local function WriteBuffer(p29: buffer) -- Line: 83
    -- upvalues: u7 (ref), u5 (ref)
    buffer.copy(u7, u5, p29);
    u5 = u5 + buffer.len(p29);
end;

local function ReadInstance() -- Line: 84
    -- upvalues: u9 (ref), u10 (ref)
    u9 = u9 + 1;

    return u10[u9];
end;

local function WriteInstance(p30) -- Line: 85
    -- upvalues: u9 (ref), u10 (ref)
    u9 = u9 + 1;
    u10[u9] = p30;
end;

local function ReadF16() -- Line: 87
    -- upvalues: u5 (ref), u7 (ref)
    local v31 = u5 * 8;
    u5 = u5 + 2;
    local buffer_readbits_ret = buffer.readbits(u7, v31 + 0, 10);
    local buffer_readbits_ret2 = buffer.readbits(u7, v31 + 10, 5);
    local buffer_readbits_ret3 = buffer.readbits(u7, v31 + 15, 1);

    if buffer_readbits_ret == 0 then
        if buffer_readbits_ret2 == 0 then
            return 0;
        end;

        if buffer_readbits_ret2 == 31 then
            return buffer_readbits_ret3 == 0 and (1 / 0) or (-1 / 0);
        end;
    elseif buffer_readbits_ret2 == 31 then
        return (0 / 0);
    end;

    if buffer_readbits_ret3 == 0 then
        return (buffer_readbits_ret / 1024 + 1) * 2 ^ (buffer_readbits_ret2 - 15);
    end;

    return -(buffer_readbits_ret / 1024 + 1) * 2 ^ (buffer_readbits_ret2 - 15);
end;

local function WriteF16(p32: number) -- Line: 103
    -- upvalues: u5 (ref), u7 (ref)
    local v33 = u5 * 8;
    u5 = u5 + 2;

    if p32 == 0 then
        buffer.writebits(u7, v33, 16, 0);

        return;
    end;

    if p32 >= 65520 then
        buffer.writebits(u7, v33, 16, 31744);

        return;
    end;

    if p32 <= -65520 then
        buffer.writebits(u7, v33, 16, 64512);

        return;
    end;

    if p32 ~= p32 then
        buffer.writebits(u7, v33, 16, 31745);

        return;
    end;

    local v34;

    if p32 < 0 then
        p32 = -p32;
        v34 = 1;
    else
        v34 = 0;
    end;

    local math_frexp_ret, v35 = math.frexp(p32);
    buffer.writebits(u7, v33 + 0, 10, math_frexp_ret * 2048 - 1023.5);
    buffer.writebits(u7, v33 + 10, 5, v35 + 14);
    buffer.writebits(u7, v33 + 15, 1, v34);
end;

local function ReadF24() -- Line: 124
    -- upvalues: u5 (ref), u7 (ref)
    local v36 = u5 * 8;
    u5 = u5 + 3;
    local buffer_readbits_ret = buffer.readbits(u7, v36 + 0, 17);
    local buffer_readbits_ret2 = buffer.readbits(u7, v36 + 17, 6);
    local buffer_readbits_ret3 = buffer.readbits(u7, v36 + 23, 1);

    if buffer_readbits_ret == 0 then
        if buffer_readbits_ret2 == 0 then
            return 0;
        end;

        if buffer_readbits_ret2 == 63 then
            return buffer_readbits_ret3 == 0 and (1 / 0) or (-1 / 0);
        end;
    elseif buffer_readbits_ret2 == 63 then
        return (0 / 0);
    end;

    if buffer_readbits_ret3 == 0 then
        return (buffer_readbits_ret / 131072 + 1) * 2 ^ (buffer_readbits_ret2 - 31);
    end;

    return -(buffer_readbits_ret / 131072 + 1) * 2 ^ (buffer_readbits_ret2 - 31);
end;

local function WriteF24(p37: number) -- Line: 140
    -- upvalues: u5 (ref), u7 (ref)
    local v38 = u5 * 8;
    u5 = u5 + 3;

    if p37 == 0 then
        buffer.writebits(u7, v38, 24, 0);

        return;
    end;

    if p37 >= 4294959104 then
        buffer.writebits(u7, v38, 24, 8257536);

        return;
    end;

    if p37 <= -4294959104 then
        buffer.writebits(u7, v38, 24, 16646144);

        return;
    end;

    if p37 ~= p37 then
        buffer.writebits(u7, v38, 24, 8257537);

        return;
    end;

    local v39;

    if p37 < 0 then
        p37 = -p37;
        v39 = 1;
    else
        v39 = 0;
    end;

    local math_frexp_ret, v40 = math.frexp(p37);
    buffer.writebits(u7, v38 + 0, 17, math_frexp_ret * 262144 - 131071.5);
    buffer.writebits(u7, v38 + 17, 6, v40 + 30);
    buffer.writebits(u7, v38 + 23, 1, v39);
end;

v11.Any = "Any";

function v2.Any() -- Line: 164
    -- upvalues: u12 (copy), u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;

    return u12[buffer_readu8_ret]();
end;

function v4.Any(p41) -- Line: 165
    -- upvalues: u3 (copy)
    u3[typeof(p41)](p41);
end;

v11.Nil = "Nil";

function v2.Nil() -- Line: 168
    return nil;
end;

function v4.Nil(p42: nil) -- Line: 169
end;

v11.NumberS8 = "NumberS8";

function v2.NumberS8() -- Line: 172
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readi8_ret = buffer.readi8(u7, u5);
    u5 = u5 + 1;

    return buffer_readi8_ret;
end;

function v4.NumberS8(p43: number) -- Line: 173
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v44 = u5 + 1;

    if u6 < v44 then
        while u6 < v44 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writei8(u7, u5, p43);
    u5 = u5 + 1;
end;

v11.NumberS16 = "NumberS16";

function v2.NumberS16() -- Line: 176
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readi16_ret = buffer.readi16(u7, u5);
    u5 = u5 + 2;

    return buffer_readi16_ret;
end;

function v4.NumberS16(p45: number) -- Line: 177
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v46 = u5 + 2;

    if u6 < v46 then
        while u6 < v46 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writei16(u7, u5, p45);
    u5 = u5 + 2;
end;

v11.NumberS24 = "NumberS24";

function v2.NumberS24() -- Line: 180
    -- upvalues: u7 (ref), u5 (ref)
    local v47 = buffer.readbits(u7, u5 * 8, 24) - 8388608;
    u5 = u5 + 3;

    return v47;
end;

function v4.NumberS24(p48: number) -- Line: 181
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v49 = u5 + 3;

    if u6 < v49 then
        while u6 < v49 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writebits(u7, u5 * 8, 24, p48 + 8388608);
    u5 = u5 + 3;
end;

v11.NumberS32 = "NumberS32";

function v2.NumberS32() -- Line: 184
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readi32_ret = buffer.readi32(u7, u5);
    u5 = u5 + 4;

    return buffer_readi32_ret;
end;

function v4.NumberS32(p50: number) -- Line: 185
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v51 = u5 + 4;

    if u6 < v51 then
        while u6 < v51 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writei32(u7, u5, p50);
    u5 = u5 + 4;
end;

v11.NumberU8 = "NumberU8";

function v2.NumberU8() -- Line: 188
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;

    return buffer_readu8_ret;
end;

function v4.NumberU8(p52: number) -- Line: 189
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v53 = u5 + 1;

    if u6 < v53 then
        while u6 < v53 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, p52);
    u5 = u5 + 1;
end;

v11.NumberU16 = "NumberU16";

function v2.NumberU16() -- Line: 192
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu16_ret = buffer.readu16(u7, u5);
    u5 = u5 + 2;

    return buffer_readu16_ret;
end;

function v4.NumberU16(p54: number) -- Line: 193
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v55 = u5 + 2;

    if u6 < v55 then
        while u6 < v55 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu16(u7, u5, p54);
    u5 = u5 + 2;
end;

v11.NumberU24 = "NumberU24";

function v2.NumberU24() -- Line: 196
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readbits_ret = buffer.readbits(u7, u5 * 8, 24);
    u5 = u5 + 3;

    return buffer_readbits_ret;
end;

function v4.NumberU24(p56: number) -- Line: 197
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v57 = u5 + 3;

    if u6 < v57 then
        while u6 < v57 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writebits(u7, u5 * 8, 24, p56);
    u5 = u5 + 3;
end;

v11.NumberU32 = "NumberU32";

function v2.NumberU32() -- Line: 200
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu32_ret = buffer.readu32(u7, u5);
    u5 = u5 + 4;

    return buffer_readu32_ret;
end;

function v4.NumberU32(p58: number) -- Line: 201
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v59 = u5 + 4;

    if u6 < v59 then
        while u6 < v59 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu32(u7, u5, p58);
    u5 = u5 + 4;
end;

v11.NumberF16 = "NumberF16";

function v2.NumberF16() -- Line: 204
    -- upvalues: ReadF16 (copy)
    return ReadF16();
end;

function v4.NumberF16(p60: number) -- Line: 205
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), WriteF16 (copy)
    local v61 = u5 + 2;

    if u6 < v61 then
        while u6 < v61 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    WriteF16(p60);
end;

v11.NumberF24 = "NumberF24";

function v2.NumberF24() -- Line: 208
    -- upvalues: ReadF24 (copy)
    return ReadF24();
end;

function v4.NumberF24(p62: number) -- Line: 209
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), WriteF24 (copy)
    local v63 = u5 + 3;

    if u6 < v63 then
        while u6 < v63 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    WriteF24(p62);
end;

v11.NumberF32 = "NumberF32";

function v2.NumberF32() -- Line: 212
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return buffer_readf32_ret;
end;

function v4.NumberF32(p64: number) -- Line: 213
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v65 = u5 + 4;

    if u6 < v65 then
        while u6 < v65 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writef32(u7, u5, p64);
    u5 = u5 + 4;
end;

v11.NumberF64 = "NumberF64";

function v2.NumberF64() -- Line: 216
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readf64_ret = buffer.readf64(u7, u5);
    u5 = u5 + 8;

    return buffer_readf64_ret;
end;

function v4.NumberF64(p66: number) -- Line: 217
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v67 = u5 + 8;

    if u6 < v67 then
        while u6 < v67 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writef64(u7, u5, p66);
    u5 = u5 + 8;
end;

v11.String = "String";

function v2.String() -- Line: 220
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local buffer_readstring_ret = buffer.readstring(u7, u5, buffer_readu8_ret);
    u5 = u5 + buffer_readu8_ret;

    return buffer_readstring_ret;
end;

function v4.String(p68: string) -- Line: 221
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v69 = #p68;
    local v70 = u5 + (v69 + 1);

    if u6 < v70 then
        while u6 < v70 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, v69);
    u5 = u5 + 1;
    buffer.writestring(u7, u5, p68);
    u5 = u5 + #p68;
end;

v11.Buffer = "Buffer";

function v2.Buffer() -- Line: 224
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local buffer_create_ret = buffer.create(buffer_readu8_ret);
    buffer.copy(buffer_create_ret, 0, u7, u5, buffer_readu8_ret);
    u5 = u5 + buffer_readu8_ret;

    return buffer_create_ret;
end;

function v4.Buffer(p71: buffer) -- Line: 225
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local buffer_len_ret = buffer.len(p71);
    local v72 = u5 + (1 + buffer_len_ret);

    if u6 < v72 then
        while u6 < v72 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, buffer_len_ret);
    u5 = u5 + 1;
    buffer.copy(u7, u5, p71);
    u5 = u5 + buffer.len(p71);
end;

v11.Instance = "Instance";

function v2.Instance() -- Line: 228
    -- upvalues: u9 (ref), u10 (ref)
    u9 = u9 + 1;

    return u10[u9];
end;

function v4.Instance(p73: userdata) -- Line: 229
    -- upvalues: u9 (ref), u10 (ref)
    u9 = u9 + 1;
    u10[u9] = p73;
end;

v11.Boolean8 = "Boolean8";

function v2.Boolean8() -- Line: 232
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;

    return buffer_readu8_ret == 1;
end;

function v4.Boolean8(p74: boolean) -- Line: 233
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v75 = u5 + 1;

    if u6 < v75 then
        while u6 < v75 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, p74 and 1 or 0);
    u5 = u5 + 1;
end;

v11.NumberRange = "NumberRange";

function v2.NumberRange() -- Line: 236
    -- upvalues: u7 (ref), u5 (ref)
    local NumberRange_new = NumberRange.new;
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return NumberRange_new(buffer_readf32_ret, buffer_readf32_ret2);
end;

function v4.NumberRange(p76) -- Line: 237
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v77 = u5 + 8;

    if u6 < v77 then
        while u6 < v77 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writef32(u7, u5, p76.Min);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p76.Max);
    u5 = u5 + 4;
end;

v11.BrickColor = "BrickColor";

function v2.BrickColor() -- Line: 240
    -- upvalues: u7 (ref), u5 (ref)
    local BrickColor_new = BrickColor.new;
    local buffer_readu16_ret = buffer.readu16(u7, u5);
    u5 = u5 + 2;

    return BrickColor_new(buffer_readu16_ret);
end;

function v4.BrickColor(p78: userdata) -- Line: 241
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v79 = u5 + 2;

    if u6 < v79 then
        while u6 < v79 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu16(u7, u5, p78.Number);
    u5 = u5 + 2;
end;

v11.Color3 = "Color3";

function v2.Color3() -- Line: 244
    -- upvalues: u7 (ref), u5 (ref)
    local Color3_fromRGB = Color3.fromRGB;
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local buffer_readu8_ret2 = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local buffer_readu8_ret3 = buffer.readu8(u7, u5);
    u5 = u5 + 1;

    return Color3_fromRGB(buffer_readu8_ret, buffer_readu8_ret2, buffer_readu8_ret3);
end;

function v4.Color3(p80) -- Line: 245
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v81 = u5 + 3;

    if u6 < v81 then
        while u6 < v81 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, p80.R * 255 + 0.5);
    u5 = u5 + 1;
    buffer.writeu8(u7, u5, p80.G * 255 + 0.5);
    u5 = u5 + 1;
    buffer.writeu8(u7, u5, p80.B * 255 + 0.5);
    u5 = u5 + 1;
end;

v11.UDim = "UDim";

function v2.UDim() -- Line: 248
    -- upvalues: u7 (ref), u5 (ref)
    local UDim_new = UDim.new;
    local buffer_readi16_ret = buffer.readi16(u7, u5);
    u5 = u5 + 2;
    local buffer_readi16_ret2 = buffer.readi16(u7, u5);
    u5 = u5 + 2;

    return UDim_new(buffer_readi16_ret / 1000, buffer_readi16_ret2);
end;

function v4.UDim(p82) -- Line: 249
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v83 = u5 + 4;

    if u6 < v83 then
        while u6 < v83 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writei16(u7, u5, p82.Scale * 1000 + 0.5);
    u5 = u5 + 2;
    buffer.writei16(u7, u5, p82.Offset);
    u5 = u5 + 2;
end;

v11.UDim2 = "UDim2";

function v2.UDim2() -- Line: 252
    -- upvalues: u7 (ref), u5 (ref)
    local UDim2_new = UDim2.new;
    local buffer_readi16_ret = buffer.readi16(u7, u5);
    u5 = u5 + 2;
    local buffer_readi16_ret2 = buffer.readi16(u7, u5);
    u5 = u5 + 2;
    local buffer_readi16_ret3 = buffer.readi16(u7, u5);
    u5 = u5 + 2;
    local buffer_readi16_ret4 = buffer.readi16(u7, u5);
    u5 = u5 + 2;

    return UDim2_new(buffer_readi16_ret / 1000, buffer_readi16_ret2, buffer_readi16_ret3 / 1000, buffer_readi16_ret4);
end;

function v4.UDim2(p84) -- Line: 253
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v85 = u5 + 8;

    if u6 < v85 then
        while u6 < v85 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writei16(u7, u5, p84.X.Scale * 1000 + 0.5);
    u5 = u5 + 2;
    buffer.writei16(u7, u5, p84.X.Offset);
    u5 = u5 + 2;
    buffer.writei16(u7, u5, p84.Y.Scale * 1000 + 0.5);
    u5 = u5 + 2;
    buffer.writei16(u7, u5, p84.Y.Offset);
    u5 = u5 + 2;
end;

v11.Rect = "Rect";

function v2.Rect() -- Line: 256
    -- upvalues: u7 (ref), u5 (ref)
    local Rect_new = Rect.new;
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret4 = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return Rect_new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3, buffer_readf32_ret4);
end;

function v4.Rect(p86) -- Line: 257
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v87 = u5 + 16;

    if u6 < v87 then
        while u6 < v87 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writef32(u7, u5, p86.Min.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p86.Min.Y);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p86.Max.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p86.Max.Y);
    u5 = u5 + 4;
end;

v11.Vector2S16 = "Vector2S16";

function v2.Vector2S16() -- Line: 260
    -- upvalues: u7 (ref), u5 (ref)
    local Vector2_new = Vector2.new;
    local buffer_readi16_ret = buffer.readi16(u7, u5);
    u5 = u5 + 2;
    local buffer_readi16_ret2 = buffer.readi16(u7, u5);
    u5 = u5 + 2;

    return Vector2_new(buffer_readi16_ret, buffer_readi16_ret2);
end;

function v4.Vector2S16(p88) -- Line: 261
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v89 = u5 + 4;

    if u6 < v89 then
        while u6 < v89 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writei16(u7, u5, p88.X + 0.5);
    u5 = u5 + 2;
    buffer.writei16(u7, u5, p88.Y + 0.5);
    u5 = u5 + 2;
end;

v11.Vector2F24 = "Vector2F24";

function v2.Vector2F24() -- Line: 264
    -- upvalues: ReadF24 (copy)
    return Vector2.new(ReadF24(), (ReadF24()));
end;

function v4.Vector2F24(p90) -- Line: 265
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), WriteF24 (copy)
    local v91 = u5 + 6;

    if u6 < v91 then
        while u6 < v91 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    WriteF24(p90.X);
    WriteF24(p90.Y);
end;

v11.Vector2F32 = "Vector2F32";

function v2.Vector2F32() -- Line: 268
    -- upvalues: u7 (ref), u5 (ref)
    local Vector2_new = Vector2.new;
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return Vector2_new(buffer_readf32_ret, buffer_readf32_ret2);
end;

function v4.Vector2F32(p92) -- Line: 269
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v93 = u5 + 8;

    if u6 < v93 then
        while u6 < v93 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writef32(u7, u5, p92.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p92.Y);
    u5 = u5 + 4;
end;

v11.Vector3S16 = "Vector3S16";

function v2.Vector3S16() -- Line: 272
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readi16_ret = buffer.readi16(u7, u5);
    u5 = u5 + 2;
    local buffer_readi16_ret2 = buffer.readi16(u7, u5);
    u5 = u5 + 2;
    local buffer_readi16_ret3 = buffer.readi16(u7, u5);
    u5 = u5 + 2;

    return Vector3.new(buffer_readi16_ret, buffer_readi16_ret2, buffer_readi16_ret3);
end;

function v4.Vector3S16(p94: vector) -- Line: 273
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v95 = u5 + 6;

    if u6 < v95 then
        while u6 < v95 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writei16(u7, u5, p94.X + 0.5);
    u5 = u5 + 2;
    buffer.writei16(u7, u5, p94.Y + 0.5);
    u5 = u5 + 2;
    buffer.writei16(u7, u5, p94.Z + 0.5);
    u5 = u5 + 2;
end;

v11.Vector3F24 = "Vector3F24";

function v2.Vector3F24() -- Line: 276
    -- upvalues: ReadF24 (copy)
    local v96 = ReadF24();
    local v97 = ReadF24();
    local v98 = ReadF24();

    return Vector3.new(v96, v97, v98);
end;

function v4.Vector3F24(p99: vector) -- Line: 277
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), WriteF24 (copy)
    local v100 = u5 + 9;

    if u6 < v100 then
        while u6 < v100 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    WriteF24(p99.X);
    WriteF24(p99.Y);
    WriteF24(p99.Z);
end;

v11.Vector3F32 = "Vector3F32";

function v2.Vector3F32() -- Line: 280
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
end;

function v4.Vector3F32(p101: vector) -- Line: 281
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v102 = u5 + 12;

    if u6 < v102 then
        while u6 < v102 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writef32(u7, u5, p101.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p101.Y);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p101.Z);
    u5 = u5 + 4;
end;

v11.NumberU4 = "NumberU4";

function v2.NumberU4() -- Line: 284
    -- upvalues: u5 (ref), u7 (ref)
    local v103 = u5 * 8;
    u5 = u5 + 1;

    return { buffer.readbits(u7, v103 + 0, 4), buffer.readbits(u7, v103 + 4, 4) };
end;

function v4.NumberU4(p104: table) -- Line: 292
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v105 = u5 + 1;

    if u6 < v105 then
        while u6 < v105 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    local v106 = u5 * 8;
    u5 = u5 + 1;
    buffer.writebits(u7, v106 + 0, 4, p104[1]);
    buffer.writebits(u7, v106 + 4, 4, p104[2]);
end;

v11.BooleanNumber = "BooleanNumber";

function v2.BooleanNumber() -- Line: 301
    -- upvalues: u5 (ref), u7 (ref)
    local v107 = u5 * 8;
    u5 = u5 + 1;

    return {
        Boolean = buffer.readbits(u7, v107 + 0, 1) == 1,
        Number = buffer.readbits(u7, v107 + 1, 7)
    };
end;

function v4.BooleanNumber(p108: table) -- Line: 309
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v109 = u5 + 1;

    if u6 < v109 then
        while u6 < v109 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    local v110 = u5 * 8;
    u5 = u5 + 1;
    buffer.writebits(u7, v110 + 0, 1, p108.Boolean and 1 or 0);
    buffer.writebits(u7, v110 + 1, 7, p108.Number);
end;

v11.Boolean1 = "Boolean1";

function v2.Boolean1() -- Line: 318
    -- upvalues: u5 (ref), u7 (ref)
    local v111 = u5 * 8;
    u5 = u5 + 1;

    return {
        buffer.readbits(u7, v111 + 0, 1) == 1,
        buffer.readbits(u7, v111 + 1, 1) == 1,
        buffer.readbits(u7, v111 + 2, 1) == 1,
        buffer.readbits(u7, v111 + 3, 1) == 1,
        buffer.readbits(u7, v111 + 4, 1) == 1,
        buffer.readbits(u7, v111 + 5, 1) == 1,
        buffer.readbits(u7, v111 + 6, 1) == 1,
        buffer.readbits(u7, v111 + 7, 1) == 1
    };
end;

function v4.Boolean1(p112: table) -- Line: 332
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v113 = u5 + 1;

    if u6 < v113 then
        while u6 < v113 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    local v114 = u5 * 8;
    u5 = u5 + 1;
    buffer.writebits(u7, v114 + 0, 1, p112[1] and 1 or 0);
    buffer.writebits(u7, v114 + 1, 1, p112[2] and 1 or 0);
    buffer.writebits(u7, v114 + 2, 1, p112[3] and 1 or 0);
    buffer.writebits(u7, v114 + 3, 1, p112[4] and 1 or 0);
    buffer.writebits(u7, v114 + 4, 1, p112[5] and 1 or 0);
    buffer.writebits(u7, v114 + 5, 1, p112[6] and 1 or 0);
    buffer.writebits(u7, v114 + 6, 1, p112[7] and 1 or 0);
    buffer.writebits(u7, v114 + 7, 1, p112[8] and 1 or 0);
end;

v11.CFrameF24U8 = "CFrameF24U8";

function v2.CFrameF24U8() -- Line: 347
    -- upvalues: u7 (ref), u5 (ref), ReadF24 (copy)
    local CFrame_fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local buffer_readu8_ret2 = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local buffer_readu8_ret3 = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local v115 = CFrame_fromEulerAnglesXYZ(buffer_readu8_ret / 40.58451048843331, buffer_readu8_ret2 / 40.58451048843331, buffer_readu8_ret3 / 40.58451048843331);
    local v116 = ReadF24();
    local v117 = ReadF24();
    local v118 = ReadF24();

    return v115 + Vector3.new(v116, v117, v118);
end;

function v4.CFrameF24U8(p119) -- Line: 351
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), WriteF24 (copy)
    local v120, v121, v122 = p119:ToEulerAnglesXYZ();
    local v123 = u5 + 12;

    if u6 < v123 then
        while u6 < v123 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, v120 * 40.58451048843331 + 0.5);
    u5 = u5 + 1;
    buffer.writeu8(u7, u5, v121 * 40.58451048843331 + 0.5);
    u5 = u5 + 1;
    buffer.writeu8(u7, u5, v122 * 40.58451048843331 + 0.5);
    u5 = u5 + 1;
    WriteF24(p119.X);
    WriteF24(p119.Y);
    WriteF24(p119.Z);
end;

v11.CFrameF32U8 = "CFrameF32U8";

function v2.CFrameF32U8() -- Line: 359
    -- upvalues: u7 (ref), u5 (ref)
    local CFrame_fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local buffer_readu8_ret2 = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local buffer_readu8_ret3 = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local v124 = CFrame_fromEulerAnglesXYZ(buffer_readu8_ret / 40.58451048843331, buffer_readu8_ret2 / 40.58451048843331, buffer_readu8_ret3 / 40.58451048843331);
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return v124 + Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
end;

function v4.CFrameF32U8(p125) -- Line: 363
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v126, v127, v128 = p125:ToEulerAnglesXYZ();
    local v129 = u5 + 15;

    if u6 < v129 then
        while u6 < v129 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, v126 * 40.58451048843331 + 0.5);
    u5 = u5 + 1;
    buffer.writeu8(u7, u5, v127 * 40.58451048843331 + 0.5);
    u5 = u5 + 1;
    buffer.writeu8(u7, u5, v128 * 40.58451048843331 + 0.5);
    u5 = u5 + 1;
    buffer.writef32(u7, u5, p125.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p125.Y);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p125.Z);
    u5 = u5 + 4;
end;

v11.CFrameF32U16 = "CFrameF32U16";

function v2.CFrameF32U16() -- Line: 371
    -- upvalues: u7 (ref), u5 (ref)
    local CFrame_fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
    local buffer_readu16_ret = buffer.readu16(u7, u5);
    u5 = u5 + 2;
    local buffer_readu16_ret2 = buffer.readu16(u7, u5);
    u5 = u5 + 2;
    local buffer_readu16_ret3 = buffer.readu16(u7, u5);
    u5 = u5 + 2;
    local v130 = CFrame_fromEulerAnglesXYZ(buffer_readu16_ret / 10430.219195527361, buffer_readu16_ret2 / 10430.219195527361, buffer_readu16_ret3 / 10430.219195527361);
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return v130 + Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
end;

function v4.CFrameF32U16(p131) -- Line: 375
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v132, v133, v134 = p131:ToEulerAnglesXYZ();
    local v135 = u5 + 18;

    if u6 < v135 then
        while u6 < v135 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu16(u7, u5, v132 * 10430.219195527361 + 0.5);
    u5 = u5 + 2;
    buffer.writeu16(u7, u5, v133 * 10430.219195527361 + 0.5);
    u5 = u5 + 2;
    buffer.writeu16(u7, u5, v134 * 10430.219195527361 + 0.5);
    u5 = u5 + 2;
    buffer.writef32(u7, u5, p131.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p131.Y);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p131.Z);
    u5 = u5 + 4;
end;

v11.Region3 = "Region3";

function v2.Region3() -- Line: 383
    -- upvalues: u7 (ref), u5 (ref)
    local Region3_new = Region3.new;
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local Vector3_new_ret = Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
    local buffer_readf32_ret4 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret5 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret6 = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return Region3_new(Vector3_new_ret, (Vector3.new(buffer_readf32_ret4, buffer_readf32_ret5, buffer_readf32_ret6)));
end;

function v4.Region3(p136: userdata) -- Line: 389
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v137 = p136.Size / 2;
    local v138 = p136.CFrame.Position - v137;
    local v139 = p136.CFrame.Position + v137;
    local v140 = u5 + 24;

    if u6 < v140 then
        while u6 < v140 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writef32(u7, u5, v138.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, v138.Y);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, v138.Z);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, v139.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, v139.Y);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, v139.Z);
    u5 = u5 + 4;
end;

v11.NumberSequence = "NumberSequence";

function v2.NumberSequence() -- Line: 399
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local table_create_ret = table.create(buffer_readu8_ret);

    for i = 1, buffer_readu8_ret do
        local NumberSequenceKeypoint_new = NumberSequenceKeypoint.new;
        local buffer_readu8_ret2 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        local buffer_readu8_ret3 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        local buffer_readu8_ret4 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        table.insert(table_create_ret, NumberSequenceKeypoint_new(buffer_readu8_ret2 / 255, buffer_readu8_ret3 / 255, buffer_readu8_ret4 / 255));
        local _ = i;
    end;

    return NumberSequence.new(table_create_ret);
end;

function v4.NumberSequence(p141: userdata) -- Line: 407
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v142 = #p141.Keypoints;
    local v143 = u5 + (v142 * 3 + 1);

    if u6 < v143 then
        while u6 < v143 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, v142);
    u5 = u5 + 1;

    for _, v in p141.Keypoints do
        buffer.writeu8(u7, u5, v.Time * 255 + 0.5);
        u5 = u5 + 1;
        buffer.writeu8(u7, u5, v.Value * 255 + 0.5);
        u5 = u5 + 1;
        buffer.writeu8(u7, u5, v.Envelope * 255 + 0.5);
        u5 = u5 + 1;
    end;
end;

v11.ColorSequence = "ColorSequence";

function v2.ColorSequence() -- Line: 417
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local table_create_ret = table.create(buffer_readu8_ret);

    for i = 1, buffer_readu8_ret do
        local ColorSequenceKeypoint_new = ColorSequenceKeypoint.new;
        local buffer_readu8_ret2 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        local Color3_fromRGB = Color3.fromRGB;
        local buffer_readu8_ret3 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        local buffer_readu8_ret4 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        local buffer_readu8_ret5 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        table.insert(table_create_ret, ColorSequenceKeypoint_new(buffer_readu8_ret2 / 255, Color3_fromRGB(buffer_readu8_ret3, buffer_readu8_ret4, buffer_readu8_ret5)));
        local _ = i;
    end;

    return ColorSequence.new(table_create_ret);
end;

function v4.ColorSequence(p144: userdata) -- Line: 425
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v145 = #p144.Keypoints;
    local v146 = u5 + (v145 * 4 + 1);

    if u6 < v146 then
        while u6 < v146 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, v145);
    u5 = u5 + 1;

    for _, v in p144.Keypoints do
        buffer.writeu8(u7, u5, v.Time * 255 + 0.5);
        u5 = u5 + 1;
        buffer.writeu8(u7, u5, v.Value.R * 255 + 0.5);
        u5 = u5 + 1;
        buffer.writeu8(u7, u5, v.Value.G * 255 + 0.5);
        u5 = u5 + 1;
        buffer.writeu8(u7, u5, v.Value.B * 255 + 0.5);
        u5 = u5 + 1;
    end;
end;

v11.EnumItem = "EnumItem";

function v2.EnumItem() -- Line: 437
    -- upvalues: u5 (ref), Enums (copy), u7 (ref)
    local v147 = u5 * 8;
    u5 = u5 + 3;

    return Enums[buffer.readbits(u7, v147 + 0, 12)]:FromValue(buffer.readbits(u7, v147 + 12, 12));
end;

function v4.EnumItem(p148: userdata) -- Line: 442
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), u1 (copy)
    local v149 = u5 + 3;

    if u6 < v149 then
        while u6 < v149 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    local v150 = u5 * 8;
    u5 = u5 + 3;
    buffer.writebits(u7, v150 + 0, 12, u1[p148.EnumType]);
    buffer.writebits(u7, v150 + 12, 12, p148.Value);
end;

local script_Characters = require(script.Characters);
local u151 = {};

for i, v in script_Characters do
    u151[v] = i;
end;

local math_log_ret = math.log(#script_Characters + 1, 2);
local math_ceil_ret = math.ceil(math_log_ret);
local u152 = math_ceil_ret / 8;
v11.Characters = "Characters";

function v2.Characters() -- Line: 456
    -- upvalues: u7 (ref), u5 (ref), u152 (copy), script_Characters (copy), math_ceil_ret (copy)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local table_create_ret = table.create(buffer_readu8_ret);
    local v153 = u5 * 8;
    u5 = u5 + math.ceil(buffer_readu8_ret * u152);

    for i = 1, buffer_readu8_ret do
        local v154 = script_Characters[buffer.readbits(u7, v153, math_ceil_ret)];
        table.insert(table_create_ret, v154);
        v153 = v153 + math_ceil_ret;
        local _ = i;
    end;

    return table.concat(table_create_ret);
end;

function v4.Characters(p155: string) -- Line: 467
    -- upvalues: u152 (copy), u5 (ref), u6 (ref), u7 (ref), u8 (ref), math_ceil_ret (copy), u151 (copy)
    local v156 = #p155;
    local math_ceil_ret2 = math.ceil(v156 * u152);
    local v157 = u5 + (math_ceil_ret2 + 1);

    if u6 < v157 then
        while u6 < v157 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, v156);
    u5 = u5 + 1;
    local v158 = u5 * 8;

    for i = 1, v156 do
        buffer.writebits(u7, v158, math_ceil_ret, u151[p155:sub(i, i)]);
        v158 = v158 + math_ceil_ret;
        local _ = i;
    end;

    u5 = u5 + math_ceil_ret2;
end;

local script_Static1 = require(script.Static1);
local u159 = {};

for i, v in script_Static1 do
    u159[v] = i;
end;

v11.Static1 = "Static1";

function v2.Static1() -- Line: 484
    -- upvalues: script_Static1 (copy), u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;

    return script_Static1[buffer_readu8_ret];
end;

function v4.Static1(p160) -- Line: 485
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), u159 (copy)
    local v161 = u5 + 1;

    if u6 < v161 then
        while u6 < v161 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, u159[p160] or 0);
    u5 = u5 + 1;
end;

local script_Static2 = require(script.Static2);
local u162 = {};

for i, v in script_Static2 do
    u162[v] = i;
end;

v11.Static2 = "Static2";

function v2.Static2() -- Line: 491
    -- upvalues: script_Static2 (copy), u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;

    return script_Static2[buffer_readu8_ret];
end;

function v4.Static2(p163) -- Line: 492
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), u162 (copy)
    local v164 = u5 + 1;

    if u6 < v164 then
        while u6 < v164 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, u162[p163] or 0);
    u5 = u5 + 1;
end;

local script_Static3 = require(script.Static3);
local u165 = {};

for i, v in script_Static3 do
    u165[v] = i;
end;

v11.Static3 = "Static3";

function v2.Static3() -- Line: 498
    -- upvalues: script_Static3 (copy), u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;

    return script_Static3[buffer_readu8_ret];
end;

function v4.Static3(p166) -- Line: 499
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), u165 (copy)
    local v167 = u5 + 1;

    if u6 < v167 then
        while u6 < v167 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, u165[p166] or 0);
    u5 = u5 + 1;
end;

u12[0] = function() -- Line: 503
    return nil;
end;

u3["nil"] = function(p168: nil) -- Line: 504
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v169 = u5 + 1;

    if u6 < v169 then
        while u6 < v169 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 0);
    u5 = u5 + 1;
end;

u12[1] = function() -- Line: 506
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;

    return -buffer_readu8_ret;
end;

u12[2] = function() -- Line: 507
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu16_ret = buffer.readu16(u7, u5);
    u5 = u5 + 2;

    return -buffer_readu16_ret;
end;

u12[3] = function() -- Line: 508
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readbits_ret = buffer.readbits(u7, u5 * 8, 24);
    u5 = u5 + 3;

    return -buffer_readbits_ret;
end;

u12[4] = function() -- Line: 509
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu32_ret = buffer.readu32(u7, u5);
    u5 = u5 + 4;

    return -buffer_readu32_ret;
end;

u12[5] = function() -- Line: 510
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;

    return buffer_readu8_ret;
end;

u12[6] = function() -- Line: 511
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu16_ret = buffer.readu16(u7, u5);
    u5 = u5 + 2;

    return buffer_readu16_ret;
end;

u12[7] = function() -- Line: 512
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readbits_ret = buffer.readbits(u7, u5 * 8, 24);
    u5 = u5 + 3;

    return buffer_readbits_ret;
end;

u12[8] = function() -- Line: 513
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu32_ret = buffer.readu32(u7, u5);
    u5 = u5 + 4;

    return buffer_readu32_ret;
end;

u12[9] = function() -- Line: 514
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return buffer_readf32_ret;
end;

function u3.number(p170: number) -- Line: 515
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    if p170 % 1 ~= 0 then
        local v171 = u5 + 5;

        if u6 < v171 then
            while u6 < v171 do
                u6 = u6 * 2;
            end;

            local buffer_create_ret = buffer.create(u6);
            buffer.copy(buffer_create_ret, 0, u7, 0, u5);
            u8.Buffer = buffer_create_ret;
            u7 = buffer_create_ret;
        end;

        buffer.writeu8(u7, u5, 9);
        u5 = u5 + 1;
        buffer.writef32(u7, u5, p170);
        u5 = u5 + 4;

        return;
    end;

    if p170 < 0 then
        if p170 > -256 then
            local v172 = u5 + 2;

            if u6 < v172 then
                while u6 < v172 do
                    u6 = u6 * 2;
                end;

                local buffer_create_ret = buffer.create(u6);
                buffer.copy(buffer_create_ret, 0, u7, 0, u5);
                u8.Buffer = buffer_create_ret;
                u7 = buffer_create_ret;
            end;

            buffer.writeu8(u7, u5, 1);
            u5 = u5 + 1;
            buffer.writeu8(u7, u5, -p170);
            u5 = u5 + 1;

            return;
        end;

        if p170 > -65536 then
            local v173 = u5 + 3;

            if u6 < v173 then
                while u6 < v173 do
                    u6 = u6 * 2;
                end;

                local buffer_create_ret = buffer.create(u6);
                buffer.copy(buffer_create_ret, 0, u7, 0, u5);
                u8.Buffer = buffer_create_ret;
                u7 = buffer_create_ret;
            end;

            buffer.writeu8(u7, u5, 2);
            u5 = u5 + 1;
            buffer.writeu16(u7, u5, -p170);
            u5 = u5 + 2;

            return;
        end;

        if p170 > -16777216 then
            local v174 = u5 + 4;

            if u6 < v174 then
                while u6 < v174 do
                    u6 = u6 * 2;
                end;

                local buffer_create_ret = buffer.create(u6);
                buffer.copy(buffer_create_ret, 0, u7, 0, u5);
                u8.Buffer = buffer_create_ret;
                u7 = buffer_create_ret;
            end;

            buffer.writeu8(u7, u5, 3);
            u5 = u5 + 1;
            buffer.writebits(u7, u5 * 8, 24, -p170);
            u5 = u5 + 3;

            return;
        end;

        local v175 = u5 + 5;

        if u6 < v175 then
            while u6 < v175 do
                u6 = u6 * 2;
            end;

            local buffer_create_ret = buffer.create(u6);
            buffer.copy(buffer_create_ret, 0, u7, 0, u5);
            u8.Buffer = buffer_create_ret;
            u7 = buffer_create_ret;
        end;

        buffer.writeu8(u7, u5, 4);
        u5 = u5 + 1;
        buffer.writeu32(u7, u5, -p170);
        u5 = u5 + 4;

        return;
    end;

    if p170 < 256 then
        local v176 = u5 + 2;

        if u6 < v176 then
            while u6 < v176 do
                u6 = u6 * 2;
            end;

            local buffer_create_ret = buffer.create(u6);
            buffer.copy(buffer_create_ret, 0, u7, 0, u5);
            u8.Buffer = buffer_create_ret;
            u7 = buffer_create_ret;
        end;

        buffer.writeu8(u7, u5, 5);
        u5 = u5 + 1;
        buffer.writeu8(u7, u5, p170);
        u5 = u5 + 1;

        return;
    end;

    if p170 < 65536 then
        local v177 = u5 + 3;

        if u6 < v177 then
            while u6 < v177 do
                u6 = u6 * 2;
            end;

            local buffer_create_ret = buffer.create(u6);
            buffer.copy(buffer_create_ret, 0, u7, 0, u5);
            u8.Buffer = buffer_create_ret;
            u7 = buffer_create_ret;
        end;

        buffer.writeu8(u7, u5, 6);
        u5 = u5 + 1;
        buffer.writeu16(u7, u5, p170);
        u5 = u5 + 2;

        return;
    end;

    if p170 < 16777216 then
        local v178 = u5 + 4;

        if u6 < v178 then
            while u6 < v178 do
                u6 = u6 * 2;
            end;

            local buffer_create_ret = buffer.create(u6);
            buffer.copy(buffer_create_ret, 0, u7, 0, u5);
            u8.Buffer = buffer_create_ret;
            u7 = buffer_create_ret;
        end;

        buffer.writeu8(u7, u5, 7);
        u5 = u5 + 1;
        buffer.writebits(u7, u5 * 8, 24, p170);
        u5 = u5 + 3;

        return;
    end;

    local v179 = u5 + 5;

    if u6 < v179 then
        while u6 < v179 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 8);
    u5 = u5 + 1;
    buffer.writeu32(u7, u5, p170);
    u5 = u5 + 4;
end;

u12[10] = function() -- Line: 543
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local buffer_readstring_ret = buffer.readstring(u7, u5, buffer_readu8_ret);
    u5 = u5 + buffer_readu8_ret;

    return buffer_readstring_ret;
end;

function u3.string(p180: string) -- Line: 544
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v181 = #p180;
    local v182 = u5 + (v181 + 2);

    if u6 < v182 then
        while u6 < v182 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 10);
    u5 = u5 + 1;
    buffer.writeu8(u7, u5, v181);
    u5 = u5 + 1;
    buffer.writestring(u7, u5, p180);
    u5 = u5 + #p180;
end;

u12[11] = function() -- Line: 546
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local buffer_create_ret = buffer.create(buffer_readu8_ret);
    buffer.copy(buffer_create_ret, 0, u7, u5, buffer_readu8_ret);
    u5 = u5 + buffer_readu8_ret;

    return buffer_create_ret;
end;

function u3.buffer(p183: buffer) -- Line: 547
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local buffer_len_ret = buffer.len(p183);
    local v184 = u5 + (2 + buffer_len_ret);

    if u6 < v184 then
        while u6 < v184 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 11);
    u5 = u5 + 1;
    buffer.writeu8(u7, u5, buffer_len_ret);
    u5 = u5 + 1;
    buffer.copy(u7, u5, p183);
    u5 = u5 + buffer.len(p183);
end;

u12[12] = function() -- Line: 549
    -- upvalues: u9 (ref), u10 (ref)
    u9 = u9 + 1;

    return u10[u9];
end;

function u3.Instance(p185: userdata) -- Line: 550
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref)
    local v186 = u5 + 1;

    if u6 < v186 then
        while u6 < v186 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 12);
    u5 = u5 + 1;
    u9 = u9 + 1;
    u10[u9] = p185;
end;

u12[13] = function() -- Line: 552
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;

    return buffer_readu8_ret == 1;
end;

function u3.boolean(p187: boolean) -- Line: 553
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v188 = u5 + 2;

    if u6 < v188 then
        while u6 < v188 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 13);
    u5 = u5 + 1;
    buffer.writeu8(u7, u5, p187 and 1 or 0);
    u5 = u5 + 1;
end;

u12[14] = function() -- Line: 555
    -- upvalues: u7 (ref), u5 (ref)
    local NumberRange_new = NumberRange.new;
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return NumberRange_new(buffer_readf32_ret, buffer_readf32_ret2);
end;

function u3.NumberRange(p189) -- Line: 556
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v190 = u5 + 9;

    if u6 < v190 then
        while u6 < v190 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 14);
    u5 = u5 + 1;
    buffer.writef32(u7, u5, p189.Min);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p189.Max);
    u5 = u5 + 4;
end;

u12[15] = function() -- Line: 558
    -- upvalues: u7 (ref), u5 (ref)
    local BrickColor_new = BrickColor.new;
    local buffer_readu16_ret = buffer.readu16(u7, u5);
    u5 = u5 + 2;

    return BrickColor_new(buffer_readu16_ret);
end;

function u3.BrickColor(p191: userdata) -- Line: 559
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v192 = u5 + 3;

    if u6 < v192 then
        while u6 < v192 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 15);
    u5 = u5 + 1;
    buffer.writeu16(u7, u5, p191.Number);
    u5 = u5 + 2;
end;

u12[16] = function() -- Line: 561
    -- upvalues: u7 (ref), u5 (ref)
    local Color3_fromRGB = Color3.fromRGB;
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local buffer_readu8_ret2 = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local buffer_readu8_ret3 = buffer.readu8(u7, u5);
    u5 = u5 + 1;

    return Color3_fromRGB(buffer_readu8_ret, buffer_readu8_ret2, buffer_readu8_ret3);
end;

function u3.Color3(p193) -- Line: 562
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v194 = u5 + 4;

    if u6 < v194 then
        while u6 < v194 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 16);
    u5 = u5 + 1;
    buffer.writeu8(u7, u5, p193.R * 255 + 0.5);
    u5 = u5 + 1;
    buffer.writeu8(u7, u5, p193.G * 255 + 0.5);
    u5 = u5 + 1;
    buffer.writeu8(u7, u5, p193.B * 255 + 0.5);
    u5 = u5 + 1;
end;

u12[17] = function() -- Line: 564
    -- upvalues: u7 (ref), u5 (ref)
    local UDim_new = UDim.new;
    local buffer_readi16_ret = buffer.readi16(u7, u5);
    u5 = u5 + 2;
    local buffer_readi16_ret2 = buffer.readi16(u7, u5);
    u5 = u5 + 2;

    return UDim_new(buffer_readi16_ret / 1000, buffer_readi16_ret2);
end;

function u3.UDim(p195) -- Line: 565
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v196 = u5 + 5;

    if u6 < v196 then
        while u6 < v196 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 17);
    u5 = u5 + 1;
    buffer.writei16(u7, u5, p195.Scale * 1000 + 0.5);
    u5 = u5 + 2;
    buffer.writei16(u7, u5, p195.Offset);
    u5 = u5 + 2;
end;

u12[18] = function() -- Line: 567
    -- upvalues: u7 (ref), u5 (ref)
    local UDim2_new = UDim2.new;
    local buffer_readi16_ret = buffer.readi16(u7, u5);
    u5 = u5 + 2;
    local buffer_readi16_ret2 = buffer.readi16(u7, u5);
    u5 = u5 + 2;
    local buffer_readi16_ret3 = buffer.readi16(u7, u5);
    u5 = u5 + 2;
    local buffer_readi16_ret4 = buffer.readi16(u7, u5);
    u5 = u5 + 2;

    return UDim2_new(buffer_readi16_ret / 1000, buffer_readi16_ret2, buffer_readi16_ret3 / 1000, buffer_readi16_ret4);
end;

function u3.UDim2(p197) -- Line: 568
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v198 = u5 + 9;

    if u6 < v198 then
        while u6 < v198 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 18);
    u5 = u5 + 1;
    buffer.writei16(u7, u5, p197.X.Scale * 1000 + 0.5);
    u5 = u5 + 2;
    buffer.writei16(u7, u5, p197.X.Offset);
    u5 = u5 + 2;
    buffer.writei16(u7, u5, p197.Y.Scale * 1000 + 0.5);
    u5 = u5 + 2;
    buffer.writei16(u7, u5, p197.Y.Offset);
    u5 = u5 + 2;
end;

u12[19] = function() -- Line: 570
    -- upvalues: u7 (ref), u5 (ref)
    local Rect_new = Rect.new;
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret4 = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return Rect_new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3, buffer_readf32_ret4);
end;

function u3.Rect(p199) -- Line: 571
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v200 = u5 + 17;

    if u6 < v200 then
        while u6 < v200 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 19);
    u5 = u5 + 1;
    buffer.writef32(u7, u5, p199.Min.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p199.Min.Y);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p199.Max.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p199.Max.Y);
    u5 = u5 + 4;
end;

u12[20] = function() -- Line: 573
    -- upvalues: u7 (ref), u5 (ref)
    local Vector2_new = Vector2.new;
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return Vector2_new(buffer_readf32_ret, buffer_readf32_ret2);
end;

function u3.Vector2(p201) -- Line: 574
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v202 = u5 + 9;

    if u6 < v202 then
        while u6 < v202 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 20);
    u5 = u5 + 1;
    buffer.writef32(u7, u5, p201.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p201.Y);
    u5 = u5 + 4;
end;

u12[21] = function() -- Line: 576
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
end;

function u3.Vector3(p203: vector) -- Line: 577
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v204 = u5 + 13;

    if u6 < v204 then
        while u6 < v204 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 21);
    u5 = u5 + 1;
    buffer.writef32(u7, u5, p203.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p203.Y);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p203.Z);
    u5 = u5 + 4;
end;

u12[22] = function() -- Line: 579
    -- upvalues: u7 (ref), u5 (ref)
    local CFrame_fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
    local buffer_readu16_ret = buffer.readu16(u7, u5);
    u5 = u5 + 2;
    local buffer_readu16_ret2 = buffer.readu16(u7, u5);
    u5 = u5 + 2;
    local buffer_readu16_ret3 = buffer.readu16(u7, u5);
    u5 = u5 + 2;
    local v205 = CFrame_fromEulerAnglesXYZ(buffer_readu16_ret / 10430.219195527361, buffer_readu16_ret2 / 10430.219195527361, buffer_readu16_ret3 / 10430.219195527361);
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return v205 + Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
end;

function u3.CFrame(p206) -- Line: 583
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v207, v208, v209 = p206:ToEulerAnglesXYZ();
    local v210 = u5 + 19;

    if u6 < v210 then
        while u6 < v210 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 22);
    u5 = u5 + 1;
    buffer.writeu16(u7, u5, v207 * 10430.219195527361 + 0.5);
    u5 = u5 + 2;
    buffer.writeu16(u7, u5, v208 * 10430.219195527361 + 0.5);
    u5 = u5 + 2;
    buffer.writeu16(u7, u5, v209 * 10430.219195527361 + 0.5);
    u5 = u5 + 2;
    buffer.writef32(u7, u5, p206.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p206.Y);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, p206.Z);
    u5 = u5 + 4;
end;

u12[23] = function() -- Line: 591
    -- upvalues: u7 (ref), u5 (ref)
    local Region3_new = Region3.new;
    local buffer_readf32_ret = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local Vector3_new_ret = Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
    local buffer_readf32_ret4 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret5 = buffer.readf32(u7, u5);
    u5 = u5 + 4;
    local buffer_readf32_ret6 = buffer.readf32(u7, u5);
    u5 = u5 + 4;

    return Region3_new(Vector3_new_ret, (Vector3.new(buffer_readf32_ret4, buffer_readf32_ret5, buffer_readf32_ret6)));
end;

function u3.Region3(p211: userdata) -- Line: 597
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v212 = p211.Size / 2;
    local v213 = p211.CFrame.Position - v212;
    local v214 = p211.CFrame.Position + v212;
    local v215 = u5 + 25;

    if u6 < v215 then
        while u6 < v215 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 23);
    u5 = u5 + 1;
    buffer.writef32(u7, u5, v213.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, v213.Y);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, v213.Z);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, v214.X);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, v214.Y);
    u5 = u5 + 4;
    buffer.writef32(u7, u5, v214.Z);
    u5 = u5 + 4;
end;

u12[24] = function() -- Line: 607
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local table_create_ret = table.create(buffer_readu8_ret);

    for i = 1, buffer_readu8_ret do
        local NumberSequenceKeypoint_new = NumberSequenceKeypoint.new;
        local buffer_readu8_ret2 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        local buffer_readu8_ret3 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        local buffer_readu8_ret4 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        table.insert(table_create_ret, NumberSequenceKeypoint_new(buffer_readu8_ret2 / 255, buffer_readu8_ret3 / 255, buffer_readu8_ret4 / 255));
        local _ = i;
    end;

    return NumberSequence.new(table_create_ret);
end;

function u3.NumberSequence(p216: userdata) -- Line: 615
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v217 = #p216.Keypoints;
    local v218 = u5 + (v217 * 3 + 2);

    if u6 < v218 then
        while u6 < v218 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 24);
    u5 = u5 + 1;
    buffer.writeu8(u7, u5, v217);
    u5 = u5 + 1;

    for _, v in p216.Keypoints do
        buffer.writeu8(u7, u5, v.Time * 255 + 0.5);
        u5 = u5 + 1;
        buffer.writeu8(u7, u5, v.Value * 255 + 0.5);
        u5 = u5 + 1;
        buffer.writeu8(u7, u5, v.Envelope * 255 + 0.5);
        u5 = u5 + 1;
    end;
end;

u12[25] = function() -- Line: 625
    -- upvalues: u7 (ref), u5 (ref)
    local buffer_readu8_ret = buffer.readu8(u7, u5);
    u5 = u5 + 1;
    local table_create_ret = table.create(buffer_readu8_ret);

    for i = 1, buffer_readu8_ret do
        local ColorSequenceKeypoint_new = ColorSequenceKeypoint.new;
        local buffer_readu8_ret2 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        local Color3_fromRGB = Color3.fromRGB;
        local buffer_readu8_ret3 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        local buffer_readu8_ret4 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        local buffer_readu8_ret5 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        table.insert(table_create_ret, ColorSequenceKeypoint_new(buffer_readu8_ret2 / 255, Color3_fromRGB(buffer_readu8_ret3, buffer_readu8_ret4, buffer_readu8_ret5)));
        local _ = i;
    end;

    return ColorSequence.new(table_create_ret);
end;

function u3.ColorSequence(p219: userdata) -- Line: 633
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref)
    local v220 = #p219.Keypoints;
    local v221 = u5 + (v220 * 4 + 2);

    if u6 < v221 then
        while u6 < v221 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 25);
    u5 = u5 + 1;
    buffer.writeu8(u7, u5, v220);
    u5 = u5 + 1;

    for _, v in p219.Keypoints do
        buffer.writeu8(u7, u5, v.Time * 255 + 0.5);
        u5 = u5 + 1;
        buffer.writeu8(u7, u5, v.Value.R * 255 + 0.5);
        u5 = u5 + 1;
        buffer.writeu8(u7, u5, v.Value.G * 255 + 0.5);
        u5 = u5 + 1;
        buffer.writeu8(u7, u5, v.Value.B * 255 + 0.5);
        u5 = u5 + 1;
    end;
end;

u12[26] = function() -- Line: 644
    -- upvalues: u5 (ref), Enums (copy), u7 (ref)
    local v222 = u5 * 8;
    u5 = u5 + 3;

    return Enums[buffer.readbits(u7, v222 + 0, 12)]:FromValue(buffer.readbits(u7, v222 + 12, 12));
end;

function u3.EnumItem(p223: userdata) -- Line: 649
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), u1 (copy)
    local v224 = u5 + 4;

    if u6 < v224 then
        while u6 < v224 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 26);
    u5 = u5 + 1;
    local v225 = u5 * 8;
    u5 = u5 + 3;
    buffer.writebits(u7, v225 + 0, 12, u1[p223.EnumType]);
    buffer.writebits(u7, v225 + 12, 12, p223.Value);
end;

u12[27] = function() -- Line: 658
    -- upvalues: u7 (ref), u5 (ref), u12 (copy)
    local v226 = {};
    local buffer_readu16_ret = buffer.readu16(u7, u5);
    u5 = u5 + 2;

    for i = 1, buffer_readu16_ret do
        local buffer_readu8_ret = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        local v227 = u12[buffer_readu8_ret]();
        local buffer_readu8_ret2 = buffer.readu8(u7, u5);
        u5 = u5 + 1;
        v226[v227] = u12[buffer_readu8_ret2]();
        local _ = i;
    end;

    return v226;
end;

function u3.table(p228: table) -- Line: 663
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), u3 (copy)
    local v229 = u5 + 3;

    if u6 < v229 then
        while u6 < v229 do
            u6 = u6 * 2;
        end;

        local buffer_create_ret = buffer.create(u6);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);
        u8.Buffer = buffer_create_ret;
        u7 = buffer_create_ret;
    end;

    buffer.writeu8(u7, u5, 27);
    u5 = u5 + 1;
    local v230 = u5;
    u5 = u5 + 2;
    local v231 = 0;

    for i, v in p228 do
        u3[typeof(i)](i);
        u3[typeof(v)](v);
        v231 = v231 + 1;
    end;

    buffer.writeu16(u7, v230, v231);
end;

return {
    Import = function(p232: table) -- Line: 679, Name: Import
        -- upvalues: u8 (ref), u7 (ref), u6 (ref), u5 (ref), u10 (ref), u9 (ref)
        u8 = p232;
        u7 = p232.Buffer;
        u6 = p232.BufferLength;
        u5 = p232.BufferOffset;
        u10 = p232.Instances;
        u9 = p232.InstancesOffset;
    end,

    Export = function() -- Line: 688, Name: Export
        -- upvalues: u8 (ref), u6 (ref), u5 (ref), u9 (ref)
        u8.BufferLength = u6;
        u8.BufferOffset = u5;
        u8.InstancesOffset = u9;

        return u8;
    end,

    Truncate = function() -- Line: 695, Name: Truncate
        -- upvalues: u5 (ref), u7 (ref), u9 (ref), u10 (ref)
        local buffer_create_ret = buffer.create(u5);
        buffer.copy(buffer_create_ret, 0, u7, 0, u5);

        if u9 == 0 then
            return buffer_create_ret;
        end;

        return buffer_create_ret, u10;
    end,

    Ended = function() -- Line: 701, Name: Ended
        -- upvalues: u5 (ref), u6 (ref)
        return u6 <= u5;
    end,

    Types = v11,
    Reads = v2,
    Writes = v4
};