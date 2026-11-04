 
 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local buffer_create_ret = buffer.create(16);
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {
    id = 0,
    name = "",
    slot = 0,
    hint = 0,
    reliableCode = false,
    unreliableCode = false
};
local u6 = buffer_create_ret;
local u7 = 0;
local u8 = -1;
local u9 = nil;
local u10 = nil;
local u11 = u5;
local u12 = true;
local u13 = 0;
local u14 = 0;
local u15 = 0;
local u16 = 0;
local u17 = 0;
local u18 = 0;
local u19 = nil;
local u20 = nil;
local buffer_create_ret2 = buffer.create(0);
local u21 = 0;
local u22 = -1;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = {
    started = false,
    _entryCount = 0,
    _server = nil,
    isServer = RunService:IsServer(),
    limits = {
        maxBytesPerSecond = 16384,
        maxPacketsPerSecond = 1000,
        defaultPacketRate = 120,
        burstSeconds = 2
    },
    stats = {
        bytesIn = 0,
        bytesOut = 0,
        payloadsIn = 0,
        payloadsOut = 0,
        packetsIn = 0,
        packetsOut = 0,
        dropped = 0
    },
    _entries = u1,
    _names = {},
    _receivers = {},
    _rates = {},
    _bursts = {},
    _packet = {
        size = 2016,
        bits = 0,
        reliable = true,
        slotCount = 0,
        connection = nil,
        orphan = false,
        buf = buffer.create(256),
        entry = u5,
        refs = {},
        slots = {}
    },
    _stack = u2,
    _spares = u3,
    _connections = {},
    _threads = {},
    _warnedAt = {},
    _counters = {
        bytesIn = 0,
        bytesOut = 0,
        payloadsIn = 0,
        payloadsOut = 0,
        packetsIn = 0,
        packetsOut = 0,
        dropped = 0,
        resetAt = 0
    }
};

function u26._warn(p27: string, p28: string) -- Line: 169
    -- upvalues: u26 (copy)
    local os_clock_ret = os.clock();
    local v29 = u26._warnedAt[p27];

    if v29 and os_clock_ret - v29 < 5 then
        return;
    end;

    u26._warnedAt[p27] = os_clock_ret;
    warn((`NetworkSystem: {p28}`));
end;

function u26._hash(p30: string) -- Line: 179
    local v31 = 2166136261;

    for i = 1, #p30 do
        local bit32_bxor_ret = bit32.bxor(v31, string.byte(p30, i));
        v31 = (bit32.lshift(bit32_bxor_ret, 24) + bit32_bxor_ret * 403) % 4294967296;
        local _ = i;
    end;

    local bit32_rshift_ret = bit32.rshift(v31, 16);
    local bit32_band_ret = bit32.band(v31, 65535);

    return bit32.bxor(bit32_rshift_ret, bit32_band_ret);
end;

function u26._entryOf(p32: string) -- Line: 188
    -- upvalues: u1 (copy), u26 (copy)
    local v33 = u1[p32];

    if v33 then
        return v33;
    end;

    local v34 = u26._hash(p32);
    local v35 = u26._names[v34];

    if v35 then
        error(`packets '{p32}' and '{v35}' hash to the same id {v34}, rename one of them`, 3);
    end;

    u26._names[v34] = p32;
    local v36 = u26;
    v36._entryCount = v36._entryCount + 1;
    local v37 = {
        hint = 0,
        reliableCode = false,
        unreliableCode = false,
        id = v34,
        name = p32,
        slot = u26._entryCount
    };
    u1[p32] = v37;

    return v37;
end;

function u26._idOf(p38: string) -- Line: 205
    -- upvalues: u26 (copy)
    return u26._entryOf(p38).id;
end;

function u26.receive(p39: string, p40: function, p41: number?, p42: number?) -- Line: 209
    -- upvalues: u26 (copy)
    local id = u26._entryOf(p39).id;
    u26._receivers[id] = p40;
    u26._rates[id] = p41;
    u26._bursts[id] = p42;
end;

function u26._newPacket() -- Line: 216
    -- upvalues: u5 (copy)
    return {
        size = 2016,
        bits = 0,
        reliable = true,
        slotCount = 0,
        connection = nil,
        orphan = false,
        buf = buffer.create(256),
        entry = u5,
        refs = {},
        slots = {}
    };
end;

function u26._openPacket(p43: boolean) -- Line: 231
    -- upvalues: u2 (copy), u3 (copy), u26 (copy), u10 (ref), u6 (ref), u7 (ref), u8 (ref), u14 (ref)
    local v44;

    if p43 or #u2 > 0 then
        v44 = table.remove(u3) or u26._newPacket();
    else
        v44 = u26._packet;
    end;

    v44.connection = nil;
    v44.orphan = p43;
    u10 = v44;
    u6 = v44.buf;
    u7 = 0;
    u8 = v44.size;
    u14 = 0;
end;

function u26.write(p45: string, p46: string, p47: userdata?) -- Line: 242
    -- upvalues: u1 (copy), u26 (copy), u8 (ref), u11 (ref), u12 (ref), u19 (ref), u20 (ref), u2 (copy), u10 (ref), u6 (ref), u7 (ref), u14 (ref), u9 (ref), u13 (ref), u15 (ref)
    local v48 = u1[p45] or u26._entryOf(p45);
    local v49 = p46 == "reliable";

    if not v49 and p46 ~= "unreliable" then
        error(`unknown channel '{p46}', use "reliable" or "unreliable"`, 2);
    end;

    if p47 and not u26.isServer then
        error("only the server can write to a player, clients always write to the server", 2);
    end;

    if u8 >= 0 then
        u26._nest();
    end;

    u11 = v48;
    u12 = v49;
    local v50;

    if v49 then
        v50 = u19;
    else
        v50 = u20;
    end;

    local v51 = false;

    if p47 then
        local v52 = u26._connections[p47] or u26._connectionOf(p47);

        if not v52 then
            u26._openPacket(true);

            return u26;
        end;

        if v49 then
            v50 = v52.reliable;
        else
            v50 = v52.unreliable;
        end;

        v51 = v50.codes[v48.slot];
    elseif v50 then
        if v49 then
            v51 = v48.reliableCode;
        else
            v51 = v48.unreliableCode;
        end;
    else
        if u26.isServer then
            if #u2 > 0 then
                u26._openPacket(false);

                return u26;
            end;

            local _packet = u26._packet;
            u10 = _packet;
            u6 = _packet.buf;
            u7 = 0;
            u8 = _packet.size;
            u14 = 0;

            return u26;
        end;

        u26._serverConnection();

        if v49 then
            v50 = u19;
        else
            v50 = u20;
        end;
    end;

    local v53 = v51 or u26._code(v50.connection, v50, v48);
    local bytes = v50.bytes;
    local v54 = bytes + v53 % 8 + v48.hint;

    if v54 + 4 > v50.size then
        u26._growQueue(v50, v54 + 4);
    end;

    if v53 < 64 then
        buffer.writeu16(v50.buf, bytes + 1, v48.id);
    end;

    u9 = v50;
    u6 = v50.buf;
    u7 = v54 * 8;
    u8 = (v50.size - 4) * 8;
    u13 = bytes;
    u14 = v54;
    u15 = v53;

    return u26;
end;

function u26.sender(u55: string, p56: string, u57: function?) -- Line: 304
    -- upvalues: u26 (copy), u19 (ref), u20 (ref), u8 (ref), u18 (ref), u2 (copy), u11 (ref), u12 (ref), u9 (ref), u6 (ref), u7 (ref), u13 (ref), u14 (ref), u15 (ref), u17 (ref)
    local u58 = u26._entryOf(u55);
    local u59 = p56 == "reliable";

    if not u59 and p56 ~= "unreliable" then
        error(`unknown channel '{p56}', use "reliable" or "unreliable"`, 2);
    end;

    return function(p60: any, p61: userdata?) -- Line: 310
        -- upvalues: u59 (copy), u19 (ref), u20 (ref), u26 (ref), u55 (copy), u58 (copy), u8 (ref), u57 (copy), u18 (ref), u2 (ref), u11 (ref), u12 (ref), u9 (ref), u6 (ref), u7 (ref), u13 (ref), u14 (ref), u15 (ref), u17 (ref)
        local v62;

        if u59 then
            v62 = u19;
        else
            v62 = u20;
        end;

        local v63 = false;

        if p61 then
            if not u26.isServer then
                error(`'{u55}' can only be sent to a player from the server`, 2);
            end;

            local v64 = u26._connections[p61] or u26._connectionOf(p61);

            if not v64 then
                return;
            end;

            if u59 then
                v62 = v64.reliable;
            else
                v62 = v64.unreliable;
            end;

            v63 = v62.codes[u58.slot];
        elseif v62 then
            if u59 then
                v63 = u58.reliableCode;
            else
                v63 = u58.unreliableCode;
            end;
        else
            if u26.isServer then
                error(`the server has to say which player gets '{u55}'`, 2);
            end;

            u26._serverConnection();

            if u59 then
                v62 = u19;
            else
                v62 = u20;
            end;
        end;

        if u8 >= 0 then
            u26._nest();
        end;

        local v65 = v63 or u26._code(v62.connection, v62, u58);

        if not u57 then
            local v66 = v65 % 8;
            local bytes = v62.bytes;

            if not u59 and bytes + v66 > 900 then
                u26._flushQueue(v62.connection, v62, "unreliable");
                bytes = 0;
            end;

            if bytes + v66 + 4 > v62.size then
                u26._growQueue(v62, bytes + v66 + 4);
            end;

            local buf = v62.buf;
            local v67 = v65 // 8;

            if v67 < 128 then
                buffer.writeu8(buf, bytes, v67);
            else
                buffer.writeu8(buf, bytes, v67 % 128 + 128);
                buffer.writeu8(buf, bytes + 1, v67 // 128);
            end;

            if v65 < 64 then
                buffer.writeu16(buf, bytes + 1, u58.id);
            end;

            v62.bytes = bytes + v66;
            u18 = u18 + 1;

            if #u2 > 0 then
                u26._close();
            end;

            return;
        end;

        u11 = u58;
        u12 = u59;
        local bytes = v62.bytes;
        local v68 = bytes + v65 % 8 + u58.hint;

        if v68 + 4 > v62.size then
            u26._growQueue(v62, v68 + 4);
        end;

        if v65 < 64 then
            buffer.writeu16(v62.buf, bytes + 1, u58.id);
        end;

        u9 = v62;
        u6 = v62.buf;
        u7 = v68 * 8;
        u8 = (v62.size - 4) * 8;
        u13 = bytes;
        u14 = v68;
        u15 = v65;
        u57(p60);
        local v69 = (u7 + 7) // 8;
        local v70 = v69 - v68;
        local v71 = v70 < 7 and 0 or (v70 < 135 and 1 or (v70 < 16391 and 2 or 3));

        if u9 ~= v62 or (u13 ~= bytes or (v71 ~= u58.hint or (v70 == 0 or (v70 > 2097151 or not u59 and v69 > 900)))) or #u2 > 0 then
            u26.send();

            return;
        end;

        local v72 = u6;
        local v73 = v65 // 8 + (v70 >= 7 and 7 or v70);

        if v73 < 128 then
            buffer.writeu8(v72, bytes, v73);
        else
            buffer.writeu8(v72, bytes, v73 % 128 + 128);
            buffer.writeu8(v72, bytes + 1, v73 // 128);
        end;

        if v71 == 1 then
            buffer.writeu8(v72, v68 - 1, v70 - 7);
        elseif v71 > 1 then
            u26._writeVarint(v72, v68 - v71, v70 - 7);
        end;

        v62.bytes = v69;
        u18 = u18 + 1;
        u8 = -1;
        u9 = nil;
        u17 = 0;
    end;
end;

function u26._reserve(p74: number) -- Line: 414
    -- upvalues: u9 (ref), u26 (copy), u10 (ref), u8 (ref), u7 (ref), u6 (ref)
    local v75 = u9;

    if v75 then
        u26._growQueue(v75, (p74 + 7) // 8 + 4);

        return;
    end;

    local v76 = u10;

    if not v76 or u8 < 0 then
        error("no packet is open, call NetworkSystem.write first", 3);
    end;

    local buffer_len_ret = buffer.len(v76.buf);

    while buffer_len_ret < (p74 + 7) // 8 + 4 do
        buffer_len_ret = buffer_len_ret * 2;
    end;

    local buffer_create_ret3 = buffer.create(buffer_len_ret);
    buffer.copy(buffer_create_ret3, 0, v76.buf, 0, (u7 + 7) // 8);
    v76.buf = buffer_create_ret3;
    v76.size = (buffer_len_ret - 4) * 8;
    u6 = buffer_create_ret3;
    u8 = v76.size;
end;

function u26._writeField(p77: number, p78: number, p79: number) -- Line: 437
    -- upvalues: u26 (copy), u6 (ref)
    if p78 > 24 then
        u26._writeField(p77, 16, p79 % 65536);
        u26._writeField(p77 + 16, p78 - 16, p79 // 65536);

        return;
    end;

    local v80 = u6;
    local v81 = p77 // 8;
    local v82 = p77 % 8;
    local buffer_readu8_ret = buffer.readu8(v80, v81);
    local v83 = bit32.lshift(1, v82) - 1;
    local bit32_band_ret = bit32.band(buffer_readu8_ret, v83);
    local v84 = bit32.lshift(1, p78) - 1;
    local bit32_band_ret2 = bit32.band(p79, v84);
    local v85 = bit32_band_ret + bit32.lshift(bit32_band_ret2, v82);
    buffer.writeu32(v80, v81, v85);
end;

function u26._writeBytes(p86: number, p87: buffer, p88: number) -- Line: 450
    -- upvalues: u6 (ref)
    local v89 = u6;
    local v90 = p86 % 8;
    local v91 = p86 // 8;
    local buffer_readu8_ret = buffer.readu8(v89, v91);
    local v92 = bit32.lshift(1, v90) - 1;
    local bit32_band_ret = bit32.band(buffer_readu8_ret, v92);

    for i = 0, p88 - 1 do
        local buffer_readu8_ret2 = buffer.readu8(p87, i);
        local v93 = bit32.lshift(buffer_readu8_ret2, v90) + bit32_band_ret;
        local bit32_band_ret2 = bit32.band(v93, 255);
        buffer.writeu8(v89, v91, bit32_band_ret2);
        bit32_band_ret = bit32.rshift(v93, 8);
        v91 = v91 + 1;
        local _ = i;
    end;

    buffer.writeu8(v89, v91, bit32_band_ret);
end;

function u26.writeuint(p94: number, p95: number) -- Line: 464
    -- upvalues: u7 (ref), u8 (ref), u26 (copy), u6 (ref)
    local v96 = u7;
    local v97 = v96 + p95;

    if u8 < v97 then
        u26._reserve(v97);
    end;

    local v98 = v96 % 8;

    if v98 == 0 and p95 == 8 then
        buffer.writeu8(u6, v96 // 8, p94);
    elseif v98 == 0 and p95 == 16 then
        buffer.writeu16(u6, v96 // 8, p94);
    elseif v98 == 0 and p95 == 32 then
        buffer.writeu32(u6, v96 // 8, p94);
    elseif p95 <= 24 then
        local v99 = u6;
        local v100 = v96 // 8;
        local buffer_readu8_ret = buffer.readu8(v99, v100);
        local v101 = bit32.lshift(1, v98) - 1;
        local bit32_band_ret = bit32.band(buffer_readu8_ret, v101);
        local v102 = bit32.lshift(1, p95) - 1;
        local bit32_band_ret2 = bit32.band(p94, v102);
        local v103 = bit32_band_ret + bit32.lshift(bit32_band_ret2, v98);
        buffer.writeu32(v99, v100, v103);
    elseif p95 <= 32 then
        local v104 = bit32.lshift(1, p95) - 1;
        local bit32_band_ret = bit32.band(p94, v104);
        local v105 = u6;
        local v106 = v96 // 8;
        local buffer_readu8_ret = buffer.readu8(v105, v106);
        local v107 = bit32.lshift(1, v98) - 1;
        local v108 = bit32.band(buffer_readu8_ret, v107) + bit32.lshift(bit32_band_ret, v98);
        buffer.writeu32(v105, v106, v108);
        local bit32_rshift_ret = bit32.rshift(bit32_band_ret, 32 - v98);
        buffer.writeu8(v105, v106 + 4, bit32_rshift_ret);
    else
        u26._writeField(v96, p95, p94);
    end;

    u7 = v97;

    return u26;
end;

u26.writeint = u26.writeuint;

function u26.writebool(p109: boolean) -- Line: 496
    -- upvalues: u7 (ref), u8 (ref), u26 (copy), u6 (ref)
    local v110 = u7;

    if u8 <= v110 then
        u26._reserve(v110 + 1);
    end;

    local v111 = v110 // 8;
    local v112 = v110 % 8;
    local v113 = not p109 and 0 or bit32.lshift(1, v112);

    if v112 == 0 then
        buffer.writeu8(u6, v111, v113);
    else
        local buffer_readu8_ret = buffer.readu8(u6, v111);
        local v114 = bit32.lshift(1, v112) - 1;
        local v115 = bit32.band(buffer_readu8_ret, v114) + v113;
        buffer.writeu8(u6, v111, v115);
    end;

    u7 = v110 + 1;

    return u26;
end;

function u26.writevarint(p116: number) -- Line: 513
    -- upvalues: u7 (ref), u8 (ref), u26 (copy), u6 (ref)
    if p116 < 0 or p116 >= 9007199254740992 then
        error(`varints have to be between 0 and 2^53, got {p116}`, 2);
    end;

    local math_floor_ret = math.floor(p116);
    local v117 = u7;

    if math_floor_ret >= 128 or v117 % 8 ~= 0 then
        while math_floor_ret >= 128 do
            u26.writeuint(math_floor_ret % 128 + 128, 8);
            math_floor_ret = math_floor_ret // 128;
        end;

        return u26.writeuint(math_floor_ret, 8);
    end;

    local v118 = v117 + 8;

    if u8 < v118 then
        u26._reserve(v118);
    end;

    buffer.writeu8(u6, v117 // 8, math_floor_ret);
    u7 = v118;

    return u26;
end;

function u26.writefloat(p119: number) -- Line: 535
    -- upvalues: u7 (ref), u8 (ref), u26 (copy), u6 (ref), buffer_create_ret (copy)
    local v120 = u7;
    local v121 = v120 + 32;

    if u8 < v121 then
        u26._reserve(v121);
    end;

    if v120 % 8 == 0 then
        buffer.writef32(u6, v120 // 8, p119);
    else
        buffer.writef32(buffer_create_ret, 0, p119);
        local buffer_readu32_ret = buffer.readu32(buffer_create_ret, 0);
        local v122 = u6;
        local v123 = v120 // 8;
        local v124 = v120 % 8;
        local buffer_readu8_ret = buffer.readu8(v122, v123);
        local v125 = bit32.lshift(1, v124) - 1;
        local v126 = bit32.band(buffer_readu8_ret, v125) + bit32.lshift(buffer_readu32_ret, v124);
        buffer.writeu32(v122, v123, v126);
        local bit32_rshift_ret = bit32.rshift(buffer_readu32_ret, 32 - v124);
        buffer.writeu8(v122, v123 + 4, bit32_rshift_ret);
    end;

    u7 = v121;

    return u26;
end;

function u26.writedouble(p127: number) -- Line: 556
    -- upvalues: u7 (ref), u8 (ref), u26 (copy), u6 (ref), buffer_create_ret (copy)
    local v128 = u7;
    local v129 = v128 + 64;

    if u8 < v129 then
        u26._reserve(v129);
    end;

    if v128 % 8 == 0 then
        buffer.writef64(u6, v128 // 8, p127);
    else
        buffer.writef64(buffer_create_ret, 0, p127);
        local buffer_readu32_ret = buffer.readu32(buffer_create_ret, 0);
        local buffer_readu32_ret2 = buffer.readu32(buffer_create_ret, 4);
        local v130 = u6;
        local v131 = v128 // 8;
        local v132 = v128 % 8;
        local buffer_readu8_ret = buffer.readu8(v130, v131);
        local v133 = bit32.lshift(1, v132) - 1;
        local v134 = bit32.band(buffer_readu8_ret, v133) + bit32.lshift(buffer_readu32_ret, v132);
        buffer.writeu32(v130, v131, v134);
        local v135 = bit32.rshift(buffer_readu32_ret, 32 - v132) + bit32.lshift(buffer_readu32_ret2, v132);
        buffer.writeu32(v130, v131 + 4, v135);
        local bit32_rshift_ret = bit32.rshift(buffer_readu32_ret2, 32 - v132);
        buffer.writeu8(v130, v131 + 8, bit32_rshift_ret);
    end;

    u7 = v129;

    return u26;
end;

function u26.writestring(p136: string) -- Line: 579
    -- upvalues: u7 (ref), u8 (ref), u26 (copy), u6 (ref)
    local v137 = #p136;
    local v138 = u7;

    if v137 < 128 and v138 % 8 == 0 then
        local v139 = v138 + 8 + v137 * 8;

        if u8 < v139 then
            u26._reserve(v139);
        end;

        local v140 = v138 // 8;
        buffer.writeu8(u6, v140, v137);
        buffer.writestring(u6, v140 + 1, p136);
        u7 = v139;

        return u26;
    end;

    u26.writevarint(v137);
    local v141 = u7;
    local v142 = v141 + v137 * 8;

    if u8 < v142 then
        u26._reserve(v142);
    end;

    if v141 % 8 == 0 then
        buffer.writestring(u6, v141 // 8, p136);
    else
        u26._writeBytes(v141, buffer.fromstring(p136), v137);
    end;

    u7 = v142;

    return u26;
end;

function u26.writebuffer(p143: buffer) -- Line: 608
    -- upvalues: u26 (copy), u7 (ref), u8 (ref), u6 (ref)
    local buffer_len_ret = buffer.len(p143);
    u26.writevarint(buffer_len_ret);
    local v144 = u7;
    local v145 = v144 + buffer_len_ret * 8;

    if u8 < v145 then
        u26._reserve(v145);
    end;

    if v144 % 8 == 0 then
        buffer.copy(u6, v144 // 8, p143);
    else
        u26._writeBytes(v144, p143, buffer_len_ret);
    end;

    u7 = v145;

    return u26;
end;

function u26.writevector(p146: vector) -- Line: 625
    -- upvalues: u7 (ref), u8 (ref), u26 (copy), u6 (ref), buffer_create_ret (copy)
    local v147 = u7;
    local v148 = v147 + 96;

    if u8 < v148 then
        u26._reserve(v148);
    end;

    if v147 % 8 == 0 then
        local v149 = u6;
        local v150 = v147 // 8;
        buffer.writef32(v149, v150, p146.X);
        buffer.writef32(v149, v150 + 4, p146.Y);
        buffer.writef32(v149, v150 + 8, p146.Z);
    else
        buffer.writef32(buffer_create_ret, 0, p146.X);
        buffer.writef32(buffer_create_ret, 4, p146.Y);
        buffer.writef32(buffer_create_ret, 8, p146.Z);
        local buffer_readu32_ret = buffer.readu32(buffer_create_ret, 0);
        local buffer_readu32_ret2 = buffer.readu32(buffer_create_ret, 4);
        local buffer_readu32_ret3 = buffer.readu32(buffer_create_ret, 8);
        local v151 = u6;
        local v152 = v147 // 8;
        local v153 = v147 % 8;
        local v154 = 32 - v153;
        local buffer_readu8_ret = buffer.readu8(v151, v152);
        local v155 = bit32.lshift(1, v153) - 1;
        local v156 = bit32.band(buffer_readu8_ret, v155) + bit32.lshift(buffer_readu32_ret, v153);
        buffer.writeu32(v151, v152, v156);
        local v157 = bit32.rshift(buffer_readu32_ret, v154) + bit32.lshift(buffer_readu32_ret2, v153);
        buffer.writeu32(v151, v152 + 4, v157);
        local v158 = bit32.rshift(buffer_readu32_ret2, v154) + bit32.lshift(buffer_readu32_ret3, v153);
        buffer.writeu32(v151, v152 + 8, v158);
        local bit32_rshift_ret = bit32.rshift(buffer_readu32_ret3, v154);
        buffer.writeu8(v151, v152 + 12, bit32_rshift_ret);
    end;

    u7 = v148;

    return u26;
end;

function u26.writedirection(p159: vector) -- Line: 655
    -- upvalues: u26 (copy)
    local v160 = math.abs(p159.X) + math.abs(p159.Y) + math.abs(p159.Z);
    local v161, v162;

    if v160 > 0 and v160 < (1 / 0) then
        local v163 = p159.X / v160;
        v161 = p159.Y / v160;

        if p159.Z < 0 then
            v162 = (1 - math.abs(v161)) * (v163 >= 0 and 1 or -1);
            v161 = (1 - math.abs(v163)) * (v161 >= 0 and 1 or -1);
        else
            v162 = v163;
        end;
    else
        v162 = 0;
        v161 = 0;
    end;

    return u26.writeuint(math.round((v162 + 1) / 2 * 65535) + math.round((v161 + 1) / 2 * 65535) * 65536, 32);
end;

function u26.writeangle(p164: number, p165: number) -- Line: 668
    -- upvalues: u26 (copy)
    local v166 = 2 ^ p165;
    local v167 = (p164 ~= p164 or math.abs(p164) >= (1 / 0)) and 0 or p164 % 6.283185307179586 / 6.283185307179586;

    return u26.writeuint(math.round(v167 * v166) % v166, p165);
end;

function u26.writerotation(p168) -- Line: 674
    -- upvalues: u7 (ref), u8 (ref), u26 (copy), u6 (ref)
    local XVector = p168.XVector;
    local YVector = p168.YVector;
    local ZVector = p168.ZVector;
    local X = XVector.X;
    local Y = XVector.Y;
    local Z = XVector.Z;
    local X2 = YVector.X;
    local Y2 = YVector.Y;
    local Z2 = YVector.Z;
    local X3 = ZVector.X;
    local Y3 = ZVector.Y;
    local Z3 = ZVector.Z;
    local v169 = X + Y2 + Z3;
    local v170, v171, v172, v173;

    if v169 > 0 then
        local v174 = 0.5 / math.sqrt(v169 + 1);
        v170 = (Z2 - Y3) * v174;
        v171 = (X3 - Z) * v174;
        v172 = (Y - X2) * v174;
        v173 = 0.25 / v174;
    elseif Y2 < X and Z3 < X then
        local v175 = math.sqrt(1 + X - Y2 - Z3) * 2;
        v170 = v175 * 0.25;
        v171 = (X2 + Y) / v175;
        v172 = (X3 + Z) / v175;
        v173 = (Z2 - Y3) / v175;
    elseif Z3 < Y2 then
        local v176 = math.sqrt(1 + Y2 - X - Z3) * 2;
        v170 = (X2 + Y) / v176;
        v171 = v176 * 0.25;
        v172 = (Y3 + Z2) / v176;
        v173 = (X3 - Z) / v176;
    else
        local v177 = math.sqrt(1 + Z3 - X - Y2) * 2;
        v170 = (X3 + Z) / v177;
        v171 = (Y3 + Z2) / v177;
        v172 = v177 * 0.25;
        v173 = (Y - X2) / v177;
    end;

    local math_abs_ret = math.abs(v170);
    local math_abs_ret2 = math.abs(v171);
    local math_abs_ret3 = math.abs(v172);
    local math_abs_ret4 = math.abs(v173);
    local v178 = 3;

    if math_abs_ret2 <= math_abs_ret and (math_abs_ret3 <= math_abs_ret and math_abs_ret4 <= math_abs_ret) then
        local v179 = v171;
        v171 = v172;
        v172 = v170;
        v170 = v179;
        v178 = 0;
    elseif math_abs_ret3 <= math_abs_ret2 and math_abs_ret4 <= math_abs_ret2 then
        local v180 = v171;
        v171 = v172;
        v172 = v180;
        v178 = 1;
    elseif math_abs_ret4 <= math_abs_ret3 then
        v178 = 2;
    else
        local v181 = v173;
        v173 = v172;
        v172 = v181;
    end;

    local v182 = v172 < 0 and -1.4142135623730951 or 1.4142135623730951;
    local math_round_ret = math.round((v170 * v182 + 1) / 2 * 32767);
    local math_clamp_ret = math.clamp(math_round_ret, 0, 32767);
    local math_round_ret2 = math.round((v171 * v182 + 1) / 2 * 32767);
    local math_clamp_ret2 = math.clamp(math_round_ret2, 0, 32767);
    local math_round_ret3 = math.round((v173 * v182 + 1) / 2 * 32767);
    local math_clamp_ret3 = math.clamp(math_round_ret3, 0, 32767);
    local v183 = v178 + math_clamp_ret * 4 + math_clamp_ret2 * 131072;
    local v184 = u7;
    local v185 = v184 + 32 + 15;

    if u8 < v185 then
        u26._reserve(v185);
    end;

    if v184 % 8 == 0 then
        local v186 = v184 // 8;
        buffer.writeu32(u6, v186, v183);
        buffer.writeu16(u6, v186 + 4, math_clamp_ret3);
    else
        local v187 = u6;
        local v188 = v184 // 8;
        local v189 = v184 % 8;
        local buffer_readu8_ret = buffer.readu8(v187, v188);
        local v190 = bit32.lshift(1, v189) - 1;
        local v191 = bit32.band(buffer_readu8_ret, v190) + bit32.lshift(v183, v189);
        buffer.writeu32(v187, v188, v191);
        local v192 = bit32.rshift(v183, 32 - v189) + bit32.lshift(math_clamp_ret3, v189);
        buffer.writeu32(v187, v188 + 4, v192);
    end;

    u7 = v185;

    return u26;
end;

function u26.writecframe(p193) -- Line: 729
    -- upvalues: u7 (ref), u8 (ref), u26 (copy), u6 (ref)
    local v194 = u7;

    if v194 % 8 == 0 then
        local v195 = v194 + 96;

        if u8 < v195 then
            u26._reserve(v195);
        end;

        local Position = p193.Position;
        local v196 = u6;
        local v197 = v194 // 8;
        buffer.writef32(v196, v197, Position.X);
        buffer.writef32(v196, v197 + 4, Position.Y);
        buffer.writef32(v196, v197 + 8, Position.Z);
        u7 = v195;
    else
        u26.writevector(p193.Position);
    end;

    return u26.writerotation(p193);
end;

function u26.writecolor(p198) -- Line: 749
    -- upvalues: u26 (copy)
    local v199 = math.clamp(p198.R, 0, 1) * 255;
    local math_round_ret = math.round(v199);
    local v200 = math.clamp(p198.G, 0, 1) * 255;
    local math_round_ret2 = math.round(v200);
    local v201 = math.clamp(p198.B, 0, 1) * 255;
    local math_round_ret3 = math.round(v201);

    return u26.writeuint(math_round_ret + math_round_ret2 * 256 + math_round_ret3 * 65536, 24);
end;

function u26.writeref(p202) -- Line: 756
    -- upvalues: u7 (ref), u8 (ref), u26 (copy), u9 (ref), u10 (ref), u17 (ref), u16 (ref), u4 (copy), u14 (ref), u6 (ref)
    local v203 = u7;
    local v204 = v203 + 12;

    if u8 < v204 then
        u26._reserve(v204);
    end;

    local v205 = 0;

    if p202 ~= nil then
        local v206 = u9;
        local v207 = u10;
        local v208;

        if v206 then
            v208 = v206.refs;
        else
            v208 = v207.refs;
        end;

        local v209 = #v208;

        if u17 == 0 then
            u16 = v209;
        end;

        local v210 = u16;
        v205 = v210 < v209 and (table.find(v208, p202, v210 + 1) or 0) or v205;

        if v205 == 0 then
            v205 = v209 + 1;

            if v205 > 4095 then
                if not v206 or v209 - v210 >= 4095 then
                    error(`a packet can hold at most {4095} references`, 2);
                end;

                u26._relocate();

                return u26.writeref(p202);
            end;

            v208[v205] = p202;
        end;

        local v211;

        if v206 then
            v211 = u4;
        else
            v211 = v207.slots;
        end;

        u17 = u17 + 1;
        v211[u17] = v203 - u14 * 8;
    end;

    local v212 = u6;
    local v213 = v203 // 8;
    local v214 = v203 % 8;

    if v214 == 0 then
        buffer.writeu16(v212, v213, v205);
    else
        local buffer_readu8_ret = buffer.readu8(v212, v213);
        local v215 = bit32.lshift(1, v214) - 1;
        local v216 = bit32.band(buffer_readu8_ret, v215) + bit32.lshift(v205, v214);
        buffer.writeu32(v212, v213, v216);
    end;

    u7 = v204;

    return u26;
end;

function u26.send() -- Line: 802
    -- upvalues: u9 (ref), u26 (copy), u7 (ref), u14 (ref), u15 (ref), u12 (ref), u13 (ref), u6 (ref), u18 (ref), u8 (ref), u2 (copy), u17 (ref)
    local v217 = u9;

    if not v217 then
        u26._sendPacket();

        return;
    end;

    local v218 = (u7 + 7) // 8;
    local v219 = v218 - u14;
    local v220 = u15;

    if v219 == 0 and (u12 or u13 + 3 <= 900) then
        local v221 = u6;
        local v222 = u13;
        local v223 = v220 // 8;

        if v223 < 128 then
            buffer.writeu8(v221, v222, v223);
        else
            buffer.writeu8(v221, v222, v223 % 128 + 128);
            buffer.writeu8(v221, v222 + 1, v223 // 128);
        end;

        v217.bytes = v222 + v220 % 8;
        u18 = u18 + 1;
        u8 = -1;
        u9 = nil;

        if #u2 > 0 then
            u26._close();
        end;

        return;
    end;

    local v224 = v219 < 7 and 0 or (v219 < 135 and 1 or (v219 < 16391 and 2 or 3));

    if not (v224 == u14 - u13 - v220 % 8 and (v219 <= 2097151 and (v218 <= 900 or u12)) or u26._settle(v219, v224)) then
        return;
    end;

    local v225 = u6;
    local v226 = u13;
    local v227 = v220 // 8 + (v219 >= 7 and 7 or v219);

    if v227 < 128 then
        buffer.writeu8(v225, v226, v227);
    else
        buffer.writeu8(v225, v226, v227 % 128 + 128);
        buffer.writeu8(v225, v226 + 1, v227 // 128);
    end;

    if v224 == 1 then
        buffer.writeu8(v225, u14 - 1, v219 - 7);
    elseif v224 > 1 then
        u26._writeVarint(v225, u14 - v224, v219 - 7);
    end;

    v217.bytes = u14 + v219;
    u18 = u18 + 1;
    u8 = -1;
    u9 = nil;
    u17 = 0;

    if #u2 > 0 then
        u26._close();
    end;
end;

function u26._settle(p228: number, p229: number) -- Line: 860
    -- upvalues: u9 (ref), u11 (ref), u26 (copy), u14 (ref), u13 (ref), u15 (ref), u6 (ref), u7 (ref), u12 (ref)
    local v230 = u9;
    local name = u11.name;

    if p228 > 2097151 then
        u26._warn(`size:{name}`, (`packet '{name}' is {p228} bytes, so it was dropped`));
        u26._abandon();

        return false;
    end;

    local v231 = p229 - (u14 - u13 - u15 % 8);

    if v231 ~= 0 then
        local v232 = u14 + v231 + p228 + 4;

        if v230.size < v232 then
            u26._growQueue(v230, v232);
        end;

        buffer.copy(u6, u14 + v231, u6, u14, p228);
        u14 = u14 + v231;
        u7 = u7 + v231 * 8;
        u11.hint = p229;
    end;

    if not u12 then
        local v233 = u14 + p228 - u13;

        if v233 > 900 then
            u26._warn(`unreliable:{name}`, (`unreliable packet '{name}' is {v233} bytes, the limit is {900}, so it was dropped`));
            u26._abandon();

            return false;
        end;

        if u14 + p228 > 900 then
            u26._relocate();
        end;
    end;

    return true;
end;

function u26._relocate() -- Line: 893
    -- upvalues: u9 (ref), u13 (ref), u7 (ref), u17 (ref), u16 (ref), u26 (copy), u12 (ref), u14 (ref), u4 (copy)
    local v234 = u9;
    local v235 = u13;

    if v235 == 0 then
        return;
    end;

    local refs = v234.refs;
    local v236 = #refs;
    local v237;

    if u17 > 0 then
        v237 = u16;
    else
        v237 = v236;
    end;

    local table_create_ret = table.create(v236 - v237);

    for i = v237 + 1, v236 do
        table_create_ret[i - v237] = refs[i];
        local _ = i;
    end;

    for i = v236, v237 + 1, -1 do
        refs[i] = nil;
        local _ = i;
    end;

    v234.bytes = v235;
    u26._flushQueue(v234.connection, v234, u12 and "reliable" or "unreliable");
    local refs2 = v234.refs;

    for i, v in table_create_ret do
        refs2[i] = v;
    end;

    local buf = v234.buf;
    buffer.copy(buf, 0, buf, v235, (u7 + 7) // 8 - v235);
    u13 = 0;
    u14 = u14 - v235;
    u7 = u7 - v235 * 8;
    u16 = 0;
    local v238 = u14 * 8;

    for i = 1, u17 do
        local v239 = v238 + u4[i];
        local v240 = v239 // 8;
        local v241 = v239 % 8;
        local buffer_readu32_ret = buffer.readu32(buf, v240);
        local v242 = bit32.extract(buffer_readu32_ret, v241, 12) - v237;
        local bit32_replace_ret = bit32.replace(buffer_readu32_ret, v242, v241, 12);
        buffer.writeu32(buf, v240, bit32_replace_ret);
        local _ = i;
    end;
end;

function u26._detach() -- Line: 932
    -- upvalues: u9 (ref), u3 (copy), u26 (copy), u7 (ref), u14 (ref), u17 (ref), u16 (ref), u4 (copy), u10 (ref), u6 (ref), u8 (ref)
    local v243 = u9;
    local v244 = table.remove(u3) or u26._newPacket();
    local v245 = (u7 + 7) // 8 - u14;
    local buffer_len_ret = buffer.len(v244.buf);

    if buffer_len_ret < v245 + 4 then
        while buffer_len_ret < v245 + 4 do
            buffer_len_ret = buffer_len_ret * 2;
        end;

        v244.buf = buffer.create(buffer_len_ret);
        v244.size = (buffer_len_ret - 4) * 8;
    end;

    v244.connection = v243.connection;
    v244.orphan = false;
    local buf = v244.buf;
    buffer.copy(buf, 0, v243.buf, u14, v245);

    if u17 > 0 then
        local refs = v243.refs;
        local v246 = #refs;

        for i = u16 + 1, v246 do
            v244.refs[i - u16] = refs[i];
            local _ = i;
        end;

        for i = v246, u16 + 1, -1 do
            refs[i] = nil;
            local _ = i;
        end;

        for i = 1, u17 do
            local v247 = u4[i];
            v244.slots[i] = v247;
            local v248 = v247 // 8;
            local v249 = v247 % 8;
            local buffer_readu32_ret = buffer.readu32(buf, v248);
            local v250 = bit32.extract(buffer_readu32_ret, v249, 12) - u16;
            local bit32_replace_ret = bit32.replace(buffer_readu32_ret, v250, v249, 12);
            buffer.writeu32(buf, v248, bit32_replace_ret);
            local _ = i;
        end;
    end;

    u9 = nil;
    u10 = v244;
    u6 = buf;
    u7 = u7 - u14 * 8;
    u8 = v244.size;
    u14 = 0;
    u16 = 0;
end;

function u26._nest() -- Line: 975
    -- upvalues: u9 (ref), u26 (copy), u10 (ref), u7 (ref), u11 (ref), u12 (ref), u17 (ref), u2 (copy), u8 (ref)
    if u9 then
        u26._detach();
    end;

    local v251 = u10;
    v251.bits = u7;
    v251.entry = u11;
    v251.reliable = u12;
    v251.slotCount = u17;
    table.insert(u2, v251);
    u10 = nil;
    u8 = -1;
    u17 = 0;
end;

function u26._close() -- Line: 990
    -- upvalues: u8 (ref), u9 (ref), u10 (ref), u17 (ref), u26 (copy), u3 (copy), u2 (copy), u6 (ref), u7 (ref), u11 (ref), u12 (ref), u14 (ref), u16 (ref)
    u8 = -1;
    u9 = nil;
    local v252 = u10;

    if v252 then
        u10 = nil;

        if u17 > 0 then
            table.clear(v252.refs);
        end;

        if v252 ~= u26._packet then
            table.insert(u3, v252);
        end;
    end;

    u17 = 0;
    local v253 = #u2;

    if v253 > 0 then
        local v254 = u2[v253];
        u2[v253] = nil;
        u10 = v254;
        u6 = v254.buf;
        u7 = v254.bits;
        u8 = v254.size;
        u11 = v254.entry;
        u12 = v254.reliable;
        u14 = 0;
        u16 = 0;
        u17 = v254.slotCount;
    end;
end;

function u26._abandon() -- Line: 1020
    -- upvalues: u9 (ref), u17 (ref), u16 (ref), u26 (copy)
    local v255 = u9;

    if v255 and u17 > 0 then
        local refs = v255.refs;

        for i = #refs, u16 + 1, -1 do
            refs[i] = nil;
            local _ = i;
        end;
    end;

    u26._close();
end;

function u26._sendPacket() -- Line: 1031
    -- upvalues: u10 (ref), u26 (copy), u11 (ref), u12 (ref), u7 (ref)
    local v256 = u10;

    if not v256 then
        error(u26.isServer and "the server sends with sendTo or broadcast, or writes to one player with NetworkSystem.write(name, channel, player) and then send" or "no packet is open, call NetworkSystem.write first", 3);
    end;

    if v256.orphan then
        u26._close();

        return;
    end;

    local v257;

    if u26.isServer then
        v257 = v256.connection;
    else
        v257 = u26._serverConnection();
    end;

    if not v257 then
        error(
            "the server sends with sendTo or broadcast, or writes to one player with NetworkSystem.write(name, channel, player) and then send",
            3
        );
    end;

    u26._enqueue(v257, v256, u11, u12, u7);
    u26._close();
end;

function u26.sendTo(p258) -- Line: 1048
    -- upvalues: u10 (ref), u26 (copy), u12 (ref), u11 (ref), u7 (ref), u17 (ref), u18 (ref), u8 (ref)
    local v259 = u10;
    local v260;

    if type(p258) == "table" then
        if #p258 == 1 then
            v260 = p258[1];
        else
            v260 = nil;
        end;
    else
        v260 = p258;
    end;

    if v259 ~= u26._packet or not v260 then
        u26._sendToEach(p258);

        return;
    end;

    local v261 = u26._connections[v260] or u26._connectionOf(v260);

    if v261 then
        local v262 = u12;
        local v263;

        if v262 then
            v263 = v261.reliable;
        else
            v263 = v261.unreliable;
        end;

        local v264 = u11;
        local v265 = v263.codes[v264.slot];
        local v266 = (u7 + 7) // 8;
        local bytes = v263.bytes;

        if v265 and (v266 < 135 and (bytes + v266 + 5 + 4 <= v263.size and (v262 or bytes + v266 + 5 <= 900))) and (u17 == 0 or #v263.refs + u17 <= 4095) then
            local buf = v263.buf;
            local v267 = v265 // 8 + (v266 >= 7 and 7 or v266);
            local v268;

            if v267 < 128 then
                buffer.writeu8(buf, bytes, v267);
                v268 = bytes + 1;
            else
                buffer.writeu8(buf, bytes, v267 % 128 + 128);
                buffer.writeu8(buf, bytes + 1, v267 // 128);
                v268 = bytes + 2;
            end;

            if v265 < 64 then
                buffer.writeu16(buf, v268, v264.id);
                v268 = v268 + 2;
            end;

            if v266 >= 7 then
                buffer.writeu8(buf, v268, v266 - 7);
                v268 = v268 + 1;
            end;

            local buf2 = v259.buf;

            if v266 > 32 then
                buffer.copy(buf, v268, buf2, 0, v266);
            else
                for i = 0, v266 - 1, 4 do
                    local buffer_readu32_ret = buffer.readu32(buf2, i);
                    buffer.writeu32(buf, v268 + i, buffer_readu32_ret);
                    local _ = i;
                end;
            end;

            if u17 > 0 then
                local refs = v259.refs;
                local refs2 = v263.refs;
                local v269 = #refs2;

                if v269 > 0 then
                    local v270 = v268 * 8;
                    local slots = v259.slots;

                    for i = 1, u17 do
                        local v271 = v270 + slots[i];
                        local v272 = v271 // 8;
                        local v273 = v271 % 8;
                        local buffer_readu32_ret = buffer.readu32(buf, v272);
                        local v274 = bit32.extract(buffer_readu32_ret, v273, 12) + v269;
                        local bit32_replace_ret = bit32.replace(buffer_readu32_ret, v274, v273, 12);
                        buffer.writeu32(buf, v272, bit32_replace_ret);
                        local _ = i;
                    end;
                end;

                for i = 1, #refs do
                    refs2[v269 + i] = refs[i];
                    local _ = i;
                end;
            end;

            v263.bytes = v268 + v266;
            u18 = u18 + 1;
        else
            u26._enqueue(v261, v259, v264, v262, u7);
        end;
    end;

    if u17 > 0 then
        local refs = v259.refs;

        for i = #refs, 1, -1 do
            refs[i] = nil;
            local _ = i;
        end;

        u17 = 0;
    end;

    u8 = -1;
    u10 = nil;
end;

function u26._sendToEach(p275) -- Line: 1127
    -- upvalues: u26 (copy), u10 (ref), u9 (ref), u11 (ref), u12 (ref), u7 (ref), u17 (ref), u2 (copy), u8 (ref)
    if not u26.isServer then
        error("NetworkSystem.sendTo is for the server, clients use send", 3);
    end;

    local v276 = u10;

    if not v276 then
        error(u9 and "this packet was written for one player, finish it with NetworkSystem.send" or "no packet is open, call NetworkSystem.write first", 3);
    end;

    local v277 = u11;
    local v278 = u12;
    local v279 = u7;
    local _connections = u26._connections;

    if typeof(p275) == "Instance" then
        local v280 = _connections[p275] or u26._connectionOf(p275);

        if v280 then
            u26._enqueue(v280, v276, v277, v278, v279);
        end;
    else
        for _, v in p275 do
            local v281 = _connections[v] or u26._connectionOf(v);

            if v281 then
                u26._enqueue(v281, v276, v277, v278, v279);
            end;
        end;
    end;

    if u17 > 0 or (#u2 > 0 or v276 ~= u26._packet) then
        u26._close();

        return;
    end;

    u8 = -1;
    u10 = nil;
end;

function u26.broadcast() -- Line: 1160
    -- upvalues: u26 (copy), Players (copy)
    u26.sendTo(Players:GetPlayers());
end;

function u26._newQueue() -- Line: 1164
    return {
        size = 1024,
        bytes = 0,
        connection = nil,
        buf = buffer.create(1024),
        refs = {},
        codes = {}
    };
end;

function u26._newConnection(p282: userdata?) -- Line: 1168
    -- upvalues: u26 (copy)
    local limits = u26.limits;
    local v283 = u26._newQueue();
    local v284 = u26._newQueue();
    local v285 = {
        nextShort = 3,
        expected = 3,
        player = p282,
        reliable = v283,
        unreliable = v284,
        shorts = {},
        acked = {},
        ids = {},
        tokens = {},
        stamps = {},
        packetTokens = limits.maxPacketsPerSecond * limits.burstSeconds,
        byteTokens = limits.maxBytesPerSecond * limits.burstSeconds,
        stamp = os.clock()
    };
    v283.connection = v285;
    v284.connection = v285;

    return v285;
end;

function u26._serverConnection() -- Line: 1191
    -- upvalues: u26 (copy), u19 (ref), u20 (ref)
    local _server = u26._server;

    if _server then
        return _server;
    end;

    local v286 = u26._newConnection(nil);
    u26._server = v286;
    u19 = v286.reliable;
    u20 = v286.unreliable;

    return v286;
end;

function u26._isPlayer(p287) -- Line: 1203
    -- upvalues: Players (copy)
    local v288;

    if typeof(p287) == "Instance" then
        v288 = p287:IsA("Player") and p287.Parent == Players;
    else
        v288 = false;
    end;

    return v288;
end;

function u26._connectionOf(p289: userdata) -- Line: 1207
    -- upvalues: u26 (copy)
    local v290 = u26._connections[p289];

    if v290 then
        return v290;
    end;

    if not u26._isPlayer(p289) then
        return nil;
    end;

    local v291 = u26._newConnection(p289);
    u26._connections[p289] = v291;

    return v291;
end;

function u26._writeVarint(p292: buffer, p293: number, p294: number) -- Line: 1220
    while p294 >= 128 do
        buffer.writeu8(p292, p293, p294 % 128 + 128);
        p294 = p294 // 128;
        p293 = p293 + 1;
    end;

    buffer.writeu8(p292, p293, p294);

    return p293 + 1;
end;

function u26._readVarint(p295: buffer, p296: number, p297: number) -- Line: 1230
    local v298 = 1;
    local v299 = 0;

    for i = p296, math.min(p296 + 2, p297 - 1) do
        local buffer_readu8_ret = buffer.readu8(p295, i);
        v299 = v299 + buffer_readu8_ret % 128 * v298;

        if buffer_readu8_ret < 128 then
            return v299, i + 1;
        end;

        v298 = v298 * 128;
        local _ = i;
    end;

    return nil, p296;
end;

function u26._growQueue(p300: table, p301: number) -- Line: 1243
    -- upvalues: u9 (ref), u7 (ref), u6 (ref), u8 (ref)
    local size = p300.size;

    while size < p301 do
        size = size * 2;
    end;

    local buffer_create_ret3 = buffer.create(size);
    local v302 = p300 == u9;
    local v303;

    if v302 then
        v303 = (u7 + 7) // 8;
    else
        v303 = p300.bytes;
    end;

    buffer.copy(buffer_create_ret3, 0, p300.buf, 0, v303);
    p300.buf = buffer_create_ret3;
    p300.size = size;

    if v302 then
        u6 = buffer_create_ret3;
        u8 = (size - 4) * 8;
    end;
end;

function u26._code(p304: table, p305: table, p306: table) -- Line: 1259
    -- upvalues: u26 (copy), u19 (ref), u20 (ref)
    local v307 = p304.shorts[p306.id] or u26._define(p304, p306.id);

    if v307 ~= 0 and (p305 == p304.unreliable and not p304.acked[v307]) then
        return 3;
    end;

    local v308 = v307 == 0 and 3 or v307 * 64 + (v307 < 16 and 1 or 2);

    if p305 == u19 then
        p306.reliableCode = v308;

        return v308;
    end;

    if p305 == u20 then
        p306.unreliableCode = v308;

        return v308;
    end;

    local codes = p305.codes;

    for i = #codes + 1, p306.slot do
        codes[i] = false;
        local _ = i;
    end;

    codes[p306.slot] = v308;

    return v308;
end;

function u26._writeControl(p309: table, p310: number, p311: number, p312: number?) -- Line: 1279
    -- upvalues: u9 (ref), u26 (copy)
    local reliable = p309.reliable;

    if u9 == reliable then
        u26._detach();
    end;

    local v313 = (p311 < 128 and 1 or 2) + (p312 and 2 or 0);
    local bytes = reliable.bytes;

    if bytes + 1 + v313 + 4 > reliable.size then
        u26._growQueue(reliable, bytes + 1 + v313 + 4);
    end;

    buffer.writeu8(reliable.buf, bytes, p310 * 8 + v313);
    local v314 = u26._writeVarint(reliable.buf, bytes + 1, p311);

    if p312 then
        buffer.writeu16(reliable.buf, v314, p312);
    end;

    reliable.bytes = bytes + 1 + v313;
end;

function u26._define(p315: table, p316: number) -- Line: 1297
    -- upvalues: u26 (copy)
    local nextShort = p315.nextShort;

    if nextShort > 2047 then
        p315.shorts[p316] = 0;

        return 0;
    end;

    p315.nextShort = nextShort + 1;
    p315.shorts[p316] = nextShort;
    u26._writeControl(p315, 1, nextShort, p316);

    return nextShort;
end;

function u26._enqueue(p317: table, p318: table, p319: table, p320: boolean, p321: number) -- Line: 1309
    -- upvalues: u26 (copy), u19 (ref), u20 (ref), u17 (ref), u18 (ref)
    local v322 = (p321 + 7) // 8;

    if v322 > 2097151 then
        u26._warn(`size:{p319.name}`, (`packet '{p319.name}' is {v322} bytes, so it was dropped`));

        return;
    end;

    local v323;

    if p320 then
        v323 = p317.reliable;
    else
        v323 = p317.unreliable;
    end;

    local v324;

    if v323 == u19 then
        v324 = p319.reliableCode;
    elseif v323 == u20 then
        v324 = p319.unreliableCode;
    else
        v324 = v323.codes[p319.slot];
    end;

    local v325 = v324 or u26._code(p317, v323, p319);
    local v326 = v322 - 7;
    local v327 = v322 + v325 % 8 + (v326 < 0 and 0 or (v326 < 128 and 1 or (v326 < 16384 and 2 or 3)));

    if not p320 then
        if v327 > 900 then
            u26._warn(`unreliable:{p319.name}`, (`unreliable packet '{p319.name}' is {v327} bytes, the limit is {900}, so it was dropped`));

            return;
        end;

        if v323.bytes + v327 > 900 then
            u26._flushQueue(p317, v323, "unreliable");
        end;
    end;

    local refs = p318.refs;
    local v328 = #refs;

    if v328 > 0 and #v323.refs + v328 > 4095 then
        u26._flushQueue(p317, v323, p320 and "reliable" or "unreliable");
    end;

    local bytes = v323.bytes;

    if bytes + v327 + 4 > v323.size then
        u26._growQueue(v323, bytes + v327 + 4);
    end;

    local buf = v323.buf;
    local v329 = v325 // 8 + (v326 >= 0 and 7 or v322);
    local v330;

    if v329 < 128 then
        buffer.writeu8(buf, bytes, v329);
        v330 = bytes + 1;
    else
        buffer.writeu8(buf, bytes, v329 % 128 + 128);
        buffer.writeu8(buf, bytes + 1, v329 // 128);
        v330 = bytes + 2;
    end;

    if v325 < 64 then
        buffer.writeu16(buf, v330, p319.id);
        v330 = v330 + 2;
    end;

    if v326 >= 128 then
        v330 = u26._writeVarint(buf, v330, v326);
    elseif v326 >= 0 then
        buffer.writeu8(buf, v330, v326);
        v330 = v330 + 1;
    end;

    if v322 > 32 then
        buffer.copy(buf, v330, p318.buf, 0, v322);
    else
        local buf2 = p318.buf;

        for i = 0, v322 - 1, 4 do
            local buffer_readu32_ret = buffer.readu32(buf2, i);
            buffer.writeu32(buf, v330 + i, buffer_readu32_ret);
            local _ = i;
        end;
    end;

    if v328 > 0 then
        local refs2 = v323.refs;
        local v331 = #refs2;

        if v331 > 0 then
            local v332 = v330 * 8;
            local slots = p318.slots;

            for i = 1, u17 do
                local v333 = v332 + slots[i];
                local v334 = v333 // 8;
                local v335 = v333 % 8;
                local buffer_readu32_ret = buffer.readu32(buf, v334);
                local v336 = bit32.extract(buffer_readu32_ret, v335, 12) + v331;
                local bit32_replace_ret = bit32.replace(buffer_readu32_ret, v336, v335, 12);
                buffer.writeu32(buf, v334, bit32_replace_ret);
                local _ = i;
            end;
        end;

        for i = 1, v328 do
            refs2[v331 + i] = refs[i];
            local _ = i;
        end;
    end;

    v323.bytes = v330 + v322;
    u18 = u18 + 1;
end;

function u26._fire(p337: userdata?, p338: string, p339: buffer, p340: table?) -- Line: 1387
    -- upvalues: u26 (copy), u24 (ref), u25 (ref)
    local _counters = u26._counters;
    _counters.bytesOut = _counters.bytesOut + buffer.len(p339);
    local _counters2 = u26._counters;
    _counters2.payloadsOut = _counters2.payloadsOut + 1;

    if p337 then
        if p338 == "reliable" then
            u24:FireClient(p337, p339, p340);

            return;
        end;

        u25:FireClient(p337, p339, p340);

        return;
    end;

    if p338 == "reliable" then
        u24:FireServer(p339, p340);

        return;
    end;

    u25:FireServer(p339, p340);
end;

function u26._flushQueue(p341: table, p342: table, p343: string) -- Line: 1403
    -- upvalues: u26 (copy)
    local bytes = p342.bytes;

    if bytes == 0 then
        return;
    end;

    local buffer_create_ret3 = buffer.create(bytes);
    buffer.copy(buffer_create_ret3, 0, p342.buf, 0, bytes);
    local v344;

    if #p342.refs > 0 then
        v344 = p342.refs;
        p342.refs = {};
    else
        v344 = nil;
    end;

    p342.bytes = 0;
    u26._fire(p341.player, p343, buffer_create_ret3, v344);
end;

function u26._discardOpen() -- Line: 1419
    -- upvalues: u8 (ref), u11 (ref), u26 (copy)
    while u8 >= 0 do
        local name = u11.name;
        u26._warn(`open:{name}`, (`packet '{name}' was written but never sent`));
        u26._abandon();
    end;
end;

function u26._updateStats() -- Line: 1427
    -- upvalues: u26 (copy)
    local _counters = u26._counters;
    local os_clock_ret = os.clock();

    if os_clock_ret < _counters.resetAt then
        return;
    end;

    _counters.resetAt = os_clock_ret + 1;
    local stats = u26.stats;
    local bytesOut = _counters.bytesOut;
    local payloadsIn = _counters.payloadsIn;
    local payloadsOut = _counters.payloadsOut;
    stats.bytesIn = _counters.bytesIn;
    stats.bytesOut = bytesOut;
    stats.payloadsIn = payloadsIn;
    stats.payloadsOut = payloadsOut;
    local packetsOut = _counters.packetsOut;
    local dropped = _counters.dropped;
    stats.packetsIn = _counters.packetsIn;
    stats.packetsOut = packetsOut;
    stats.dropped = dropped;
    _counters.bytesIn = 0;
    _counters.bytesOut = 0;
    _counters.payloadsIn = 0;
    _counters.payloadsOut = 0;
    _counters.packetsIn = 0;
    _counters.packetsOut = 0;
    _counters.dropped = 0;
end;

function u26.flush() -- Line: 1441
    -- upvalues: u8 (ref), u26 (copy), u18 (ref)
    if u8 >= 0 then
        u26._discardOpen();
    end;

    local _counters = u26._counters;
    _counters.packetsOut = _counters.packetsOut + u18;
    u18 = 0;

    if not u26.started then
        return;
    end;

    if u26.isServer then
        for i, v in u26._connections do
            if i.Parent then
                u26._flushQueue(v, v.reliable, "reliable");
                u26._flushQueue(v, v.unreliable, "unreliable");
            else
                u26._connections[i] = nil;
            end;
        end;
    else
        local _server = u26._server;

        if _server then
            u26._flushQueue(_server, _server.reliable, "reliable");
            u26._flushQueue(_server, _server.unreliable, "unreliable");
        end;
    end;

    u26._updateStats();
end;

function u26._overrun() -- Line: 1469
    -- upvalues: u22 (ref)
    if u22 < 0 then
        error("no packet is being read, receivers have to read before they yield", 3);
    end;

    error("read past the end of the packet", 3);
end;

function u26._readBits(p345: number, p346: number) -- Line: 1476
    -- upvalues: buffer_create_ret2 (ref)
    local v347 = buffer_create_ret2;
    local buffer_create_ret3 = buffer.create(p346);
    local v348 = 0;

    while v348 + 4 <= p346 do
        local buffer_readbits_ret = buffer.readbits(v347, p345 + v348 * 8, 32);
        buffer.writeu32(buffer_create_ret3, v348, buffer_readbits_ret);
        v348 = v348 + 4;
    end;

    while v348 < p346 do
        local buffer_readbits_ret = buffer.readbits(v347, p345 + v348 * 8, 8);
        buffer.writeu8(buffer_create_ret3, v348, buffer_readbits_ret);
        v348 = v348 + 1;
    end;

    return buffer_create_ret3;
end;

function u26.remaining() -- Line: 1491
    -- upvalues: u22 (ref), u21 (ref)
    return u22 < 0 and 0 or u22 - u21;
end;

function u26.readuint(p349: number) -- Line: 1495
    -- upvalues: u21 (ref), u22 (ref), u26 (copy), buffer_create_ret2 (ref)
    local v350 = u21;
    local v351 = v350 + p349;

    if u22 < v351 then
        u26._overrun();
    end;

    u21 = v351;
    local v352 = buffer_create_ret2;
    local v353 = v350 // 8;
    local v354 = v350 % 8;

    if v354 + p349 <= 32 then
        if v353 + 4 <= buffer.len(v352) then
            local buffer_readu32_ret = buffer.readu32(v352, v353);

            return bit32.extract(buffer_readu32_ret, v354, p349);
        end;

        if v354 == 0 and p349 == 8 then
            return buffer.readu8(v352, v353);
        end;

        if v354 == 0 and p349 == 16 then
            return buffer.readu16(v352, v353);
        end;

        return buffer.readbits(v352, v350, p349);
    end;

    local buffer_readu32_ret = buffer.readu32(v352, v353);
    local bit32_rshift_ret = bit32.rshift(buffer_readu32_ret, v354);
    local buffer_readu8_ret = buffer.readu8(v352, v353 + 4);
    local v355 = bit32_rshift_ret + bit32.lshift(buffer_readu8_ret, 32 - v354);

    return bit32.extract(v355, 0, p349);
end;

function u26.readint(p356: number) -- Line: 1519
    -- upvalues: u26 (copy)
    local v357 = u26.readuint(p356);

    if 2 ^ (p356 - 1) <= v357 then
        return v357 - 2 ^ p356;
    end;

    return v357;
end;

function u26.readbool() -- Line: 1524
    -- upvalues: u21 (ref), u22 (ref), u26 (copy), buffer_create_ret2 (ref)
    local v358 = u21;

    if u22 <= v358 then
        u26._overrun();
    end;

    u21 = v358 + 1;
    local buffer_readu8_ret = buffer.readu8(buffer_create_ret2, v358 // 8);

    return bit32.extract(buffer_readu8_ret, v358 % 8, 1) == 1;
end;

function u26.readvarint() -- Line: 1533
    -- upvalues: u26 (copy)
    local v359 = 1;
    local v360 = 0;

    for i = 1, 8 do
        local v361 = u26.readuint(8);
        v360 = v360 + v361 % 128 * v359;

        if v361 < 128 then
            return v360;
        end;

        v359 = v359 * 128;
        local _ = i;
    end;

    error("malformed varint in packet", 2);
end;

function u26.readfloat() -- Line: 1546
    -- upvalues: u21 (ref), u22 (ref), u26 (copy), buffer_create_ret2 (ref), buffer_create_ret (copy)
    local v362 = u21;
    local v363 = v362 + 32;

    if u22 < v363 then
        u26._overrun();
    end;

    u21 = v363;
    local v364 = buffer_create_ret2;
    local v365 = v362 % 8;

    if v365 == 0 then
        return buffer.readf32(v364, v362 // 8);
    end;

    local v366 = v362 // 8;
    local buffer_readu32_ret = buffer.readu32(v364, v366);
    local bit32_rshift_ret = bit32.rshift(buffer_readu32_ret, v365);
    local buffer_readu8_ret = buffer.readu8(v364, v366 + 4);
    local v367 = bit32_rshift_ret + bit32.lshift(buffer_readu8_ret, 32 - v365);
    buffer.writeu32(buffer_create_ret, 0, v367);

    return buffer.readf32(buffer_create_ret, 0);
end;

function u26.readdouble() -- Line: 1563
    -- upvalues: u21 (ref), u22 (ref), u26 (copy), buffer_create_ret2 (ref), buffer_create_ret (copy)
    local v368 = u21;
    local v369 = v368 + 64;

    if u22 < v369 then
        u26._overrun();
    end;

    u21 = v369;
    local v370 = buffer_create_ret2;
    local v371 = v368 % 8;

    if v371 == 0 then
        return buffer.readf64(v370, v368 // 8);
    end;

    local v372 = v368 // 8;
    local v373 = 32 - v371;
    local buffer_readu32_ret = buffer.readu32(v370, v372 + 4);
    local buffer_readu32_ret2 = buffer.readu32(v370, v372);
    local v374 = bit32.rshift(buffer_readu32_ret2, v371) + bit32.lshift(buffer_readu32_ret, v373);
    buffer.writeu32(buffer_create_ret, 0, v374);
    local bit32_rshift_ret = bit32.rshift(buffer_readu32_ret, v371);
    local buffer_readu8_ret = buffer.readu8(v370, v372 + 8);
    local v375 = bit32_rshift_ret + bit32.lshift(buffer_readu8_ret, v373);
    buffer.writeu32(buffer_create_ret, 4, v375);

    return buffer.readf64(buffer_create_ret, 0);
end;

function u26.readstring() -- Line: 1583
    -- upvalues: u26 (copy), u21 (ref), u22 (ref), buffer_create_ret2 (ref)
    local v376 = u26.readvarint();
    local v377 = u21;
    local v378 = v377 + v376 * 8;

    if u22 < v378 then
        u26._overrun();
    end;

    u21 = v378;

    if v377 % 8 == 0 then
        return buffer.readstring(buffer_create_ret2, v377 // 8, v376);
    end;

    return buffer.tostring(u26._readBits(v377, v376));
end;

function u26.readbuffer() -- Line: 1597
    -- upvalues: u26 (copy), u21 (ref), u22 (ref), buffer_create_ret2 (ref)
    local v379 = u26.readvarint();
    local v380 = u21;
    local v381 = v380 + v379 * 8;

    if u22 < v381 then
        u26._overrun();
    end;

    u21 = v381;

    if v380 % 8 ~= 0 then
        return u26._readBits(v380, v379);
    end;

    local buffer_create_ret3 = buffer.create(v379);
    buffer.copy(buffer_create_ret3, 0, buffer_create_ret2, v380 // 8, v379);

    return buffer_create_ret3;
end;

function u26.readvector() -- Line: 1613
    -- upvalues: u21 (ref), u22 (ref), u26 (copy), buffer_create_ret2 (ref), buffer_create_ret (copy)
    local v382 = u21;
    local v383 = v382 + 96;

    if u22 < v383 then
        u26._overrun();
    end;

    u21 = v383;
    local v384 = buffer_create_ret2;

    if v382 % 8 == 0 then
        local v385 = v382 // 8;
        local buffer_readf32_ret = buffer.readf32(v384, v385);
        local buffer_readf32_ret2 = buffer.readf32(v384, v385 + 4);
        local buffer_readf32_ret3 = buffer.readf32(v384, v385 + 8);

        return Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
    end;

    local v386 = v382 // 8;
    local v387 = v382 % 8;
    local v388 = 32 - v387;
    local buffer_readu32_ret = buffer.readu32(v384, v386 + 4);
    local buffer_readu32_ret2 = buffer.readu32(v384, v386 + 8);
    local buffer_readu32_ret3 = buffer.readu32(v384, v386);
    local v389 = bit32.rshift(buffer_readu32_ret3, v387) + bit32.lshift(buffer_readu32_ret, v388);
    buffer.writeu32(buffer_create_ret, 0, v389);
    local v390 = bit32.rshift(buffer_readu32_ret, v387) + bit32.lshift(buffer_readu32_ret2, v388);
    buffer.writeu32(buffer_create_ret, 4, v390);
    local bit32_rshift_ret = bit32.rshift(buffer_readu32_ret2, v387);
    local buffer_readu8_ret = buffer.readu8(v384, v386 + 12);
    local v391 = bit32_rshift_ret + bit32.lshift(buffer_readu8_ret, v388);
    buffer.writeu32(buffer_create_ret, 8, v391);
    local buffer_readf32_ret = buffer.readf32(buffer_create_ret, 0);
    local buffer_readf32_ret2 = buffer.readf32(buffer_create_ret, 4);
    local buffer_readf32_ret3 = buffer.readf32(buffer_create_ret, 8);

    return Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
end;

function u26.readdirection() -- Line: 1636
    -- upvalues: u26 (copy)
    local v392 = u26.readuint(32);
    local v393 = v392 % 65536 / 65535 * 2 - 1;
    local v394 = v392 // 65536 / 65535 * 2 - 1;
    local v395 = 1 - math.abs(v393) - math.abs(v394);
    local v396;

    if v395 < 0 then
        v396 = (1 - math.abs(v394)) * (v393 >= 0 and 1 or -1);
    else
        v396 = v393;
    end;

    if v395 < 0 then
        v394 = (1 - math.abs(v393)) * (v394 >= 0 and 1 or -1);
    end;

    return Vector3.new(v396, v394, v395).Unit;
end;

function u26.readangle(p397: number) -- Line: 1647
    -- upvalues: u26 (copy)
    local v398 = u26.readuint(p397) / 2 ^ p397 * 6.283185307179586;

    if v398 > 3.141592653589793 then
        return v398 - 6.283185307179586;
    end;

    return v398;
end;

function u26.readrotation() -- Line: 1652
    -- upvalues: u21 (ref), u22 (ref), u26 (copy), buffer_create_ret2 (ref)
    local v399 = u21;
    local v400 = v399 + 32 + 15;

    if u22 < v400 then
        u26._overrun();
    end;

    u21 = v400;
    local v401 = buffer_create_ret2;
    local v402, v403;

    if v399 % 8 == 0 then
        local v404 = v399 // 8;
        v402 = buffer.readu32(v401, v404);
        local buffer_readu16_ret = buffer.readu16(v401, v404 + 4);
        v403 = bit32.band(buffer_readu16_ret, 32767);
    else
        local v405 = v399 // 8;
        local v406 = v399 % 8;
        local buffer_readu32_ret = buffer.readu32(v401, v405);
        local bit32_rshift_ret = bit32.rshift(buffer_readu32_ret, v406);
        local buffer_readu8_ret = buffer.readu8(v401, v405 + 4);
        v402 = bit32_rshift_ret + bit32.lshift(buffer_readu8_ret, 32 - v406);
        local buffer_readu16_ret = buffer.readu16(v401, v405 + 4);
        local v407;

        if v406 > 1 then
            local buffer_readu8_ret2 = buffer.readu8(v401, v405 + 6);
            v407 = bit32.lshift(buffer_readu8_ret2, 16);
        else
            v407 = 0;
        end;

        v403 = bit32.extract(buffer_readu16_ret + v407, v406, 15);
    end;

    local v408 = v402 % 4;
    local v409 = (v402 // 4 % 32768 / 32767 * 2 - 1) / 1.4142135623730951;
    local v410 = (v402 // 131072 / 32767 * 2 - 1) / 1.4142135623730951;
    local v411 = (v403 / 32767 * 2 - 1) / 1.4142135623730951;
    local math_max_ret = math.max(1 - v409 * v409 - v410 * v410 - v411 * v411, 0);
    local math_sqrt_ret = math.sqrt(math_max_ret);

    if v408 == 0 then
        return CFrame.new(0, 0, 0, math_sqrt_ret, v409, v410, v411);
    end;

    if v408 == 1 then
        return CFrame.new(0, 0, 0, v409, math_sqrt_ret, v410, v411);
    end;

    if v408 == 2 then
        return CFrame.new(0, 0, 0, v409, v410, math_sqrt_ret, v411);
    end;

    return CFrame.new(0, 0, 0, v409, v410, v411, math_sqrt_ret);
end;

function u26.readcframe() -- Line: 1687
    -- upvalues: u26 (copy)
    local v412 = u26.readvector();

    return u26.readrotation() + v412;
end;

function u26.readcolor() -- Line: 1692
    -- upvalues: u26 (copy)
    local v413 = u26.readuint(24);

    return Color3.fromRGB(v413 % 256, v413 // 256 % 256, v413 // 65536);
end;

function u26.readref() -- Line: 1697
    -- upvalues: u21 (ref), u22 (ref), u26 (copy), buffer_create_ret2 (ref), u23 (ref)
    local v414 = u21;
    local v415 = v414 + 12;

    if u22 < v415 then
        u26._overrun();
    end;

    u21 = v415;
    local v416 = buffer_create_ret2;
    local v417 = v414 // 8;
    local v418;

    if v417 + 4 <= buffer.len(v416) then
        local buffer_readu32_ret = buffer.readu32(v416, v417);
        v418 = bit32.extract(buffer_readu32_ret, v414 % 8, 12);
    else
        v418 = buffer.readbits(v416, v414, 12);
    end;

    local v419 = u23;

    if v418 > 0 and v419 then
        return v419[v418];
    end;

    return nil;
end;

function u26._worker() -- Line: 1711
    -- upvalues: u26 (copy)
    local coroutine_running_ret = coroutine.running();

    while true do
        local coroutine_yield_ret, v420, v421 = coroutine.yield();
        local v422, v423 = xpcall(coroutine_yield_ret, debug.traceback, v420);

        if not v422 then
            u26._warn(`error:{v421}`, (`the receiver of '{u26._names[v421] or v421}' errored: {v423}`));
        end;

        local _threads = u26._threads;
        local v424 = #_threads;

        if v424 >= 16 then
            return;
        end;

        _threads[v424 + 1] = coroutine_running_ret;
    end;
end;

function u26._newWorker() -- Line: 1728
    -- upvalues: u26 (copy)
    local coroutine_create_ret = coroutine.create(u26._worker);
    coroutine.resume(coroutine_create_ret);

    return coroutine_create_ret;
end;

function u26._dispatch(p425: function, p426: userdata, p427: number) -- Line: 1734
    -- upvalues: u26 (copy)
    local _threads = u26._threads;
    local v428 = #_threads;
    local v429;

    if v428 > 0 then
        v429 = _threads[v428];
    else
        v429 = u26._newWorker();
    end;

    if v428 > 0 then
        _threads[v428] = nil;
    end;

    coroutine.resume(v429, p425, p426, p427);
end;

function u26._admit(p430: table, p431: number, p432: number) -- Line: 1744
    -- upvalues: u26 (copy)
    local limits = u26.limits;
    local v433 = u26._rates[p431] or limits.defaultPacketRate;
    local v434 = u26._bursts[p431] or v433 * limits.burstSeconds;
    local v435 = p430.stamps[p431];

    if v435 then
        local v436 = p430.tokens[p431] + math.max(p432 - v435, 0) * v433;
        v434 = math.min(v434, v436);
    end;

    p430.stamps[p431] = p432;

    if v434 < 1 then
        p430.tokens[p431] = v434;

        return false;
    end;

    p430.tokens[p431] = v434 - 1;

    return true;
end;

function u26._refill(p437: table, p438: number) -- Line: 1759
    -- upvalues: u26 (copy)
    local limits = u26.limits;
    local math_max_ret = math.max(p438 - p437.stamp, 0);
    p437.stamp = p438;
    p437.byteTokens = math.min(limits.maxBytesPerSecond * limits.burstSeconds, p437.byteTokens + math_max_ret * limits.maxBytesPerSecond);
    p437.packetTokens = math.min(limits.maxPacketsPerSecond * limits.burstSeconds, p437.packetTokens + math_max_ret * limits.maxPacketsPerSecond);
end;

function u26._control(p439: table, p440: number, p441: buffer, p442: number, p443: number) -- Line: 1767
    -- upvalues: u26 (copy)
    local v444, v445 = u26._readVarint(p441, p442, p443);

    if not v444 then
        return false;
    end;

    if p440 ~= 1 then
        if v445 ~= p443 or (v444 < 3 or p439.nextShort <= v444) then
            return false;
        end;

        p439.acked[v444] = true;

        return true;
    end;

    if v445 + 2 ~= p443 or (v444 ~= p439.expected or v444 > 2047) then
        return false;
    end;

    p439.ids[v444] = buffer.readu16(p441, v445);
    p439.expected = v444 + 1;
    u26._writeControl(p439, 2, v444, nil);

    return true;
end;

function u26._process(p446: table, p447: buffer, p448: table?, p449: userdata, p450: boolean, p451: boolean, p452: number) -- Line: 1788
    -- upvalues: u26 (copy), buffer_create_ret2 (ref), u21 (ref), u22 (ref), u23 (ref)
    local buffer_len_ret = buffer.len(p447);
    local _counters = u26._counters;
    _counters.bytesIn = _counters.bytesIn + buffer_len_ret;
    _counters.payloadsIn = _counters.payloadsIn + 1;
    local isServer = u26.isServer;
    local _receivers = u26._receivers;
    local ids = p446.ids;
    local v453 = buffer_create_ret2;
    local v454 = u21;
    local v455 = u22;
    local v456 = u23;
    local v457 = 0;
    local v458 = true;

    while v457 < buffer_len_ret do
        local buffer_readu8_ret = buffer.readu8(p447, v457);
        local v459 = v457 + 1;

        if buffer_readu8_ret >= 128 then
            if buffer_len_ret <= v459 then
                v458 = false;
                break;
            end;

            local buffer_readu8_ret2 = buffer.readu8(p447, v459);
            v459 = v459 + 1;

            if buffer_readu8_ret2 >= 128 then
                v458 = false;
                break;
            end;

            buffer_readu8_ret = buffer_readu8_ret - 128 + buffer_readu8_ret2 * 128;
        end;

        local v460 = buffer_readu8_ret // 8;
        local v461 = buffer_readu8_ret % 8;
        local v462 = 0;

        if v460 == 0 then
            if buffer_len_ret < v459 + 2 then
                v458 = false;
                break;
            end;

            v462 = buffer.readu16(p447, v459);
            v459 = v459 + 2;
        elseif v460 >= 3 then
            v462 = ids[v460];

            if not v462 then
                v458 = false;
                break;
            end;
        end;

        if v461 == 7 then
            local v463;
            v463, v459 = u26._readVarint(p447, v459, buffer_len_ret);

            if not v463 then
                v458 = false;
                break;
            end;

            v461 = v463 + 7;
        end;

        v457 = v459 + v461;

        if buffer_len_ret < v457 then
            v458 = false;
            break;
        end;

        if v460 == 1 or v460 == 2 then
            if not (p450 and u26._control(p446, v460, p447, v459, v457)) then
                v458 = false;
                break;
            end;
        else
            _counters.packetsIn = _counters.packetsIn + 1;
            local v464 = _receivers[v462];

            if v464 then
                if isServer and (p451 or (p446.packetTokens < 1 or not u26._admit(p446, v462, p452))) then
                    _counters.dropped = _counters.dropped + 1;
                else
                    if isServer then
                        p446.packetTokens = p446.packetTokens - 1;
                    end;

                    buffer_create_ret2 = p447;
                    u21 = v459 * 8;
                    u22 = v457 * 8;
                    u23 = p448;
                    u26._dispatch(v464, p449, v462);
                end;
            else
                u26._warn("unknown", (`received packet {v462}, but nothing receives it`));
            end;
        end;
    end;

    buffer_create_ret2 = v453;
    u21 = v454;
    u22 = v455;
    u23 = v456;

    return v458;
end;

function u26._deliver(p465: userdata, p466: string, p467: buffer, p468: table?) -- Line: 1879
    -- upvalues: u26 (copy)
    local v469 = p466 == "reliable";

    if not u26.isServer then
        return u26._process(u26._serverConnection(), p467, p468, p465, v469, false, 0);
    end;

    local v470 = u26._connectionOf(p465);

    if not v470 then
        return true;
    end;

    local os_clock_ret = os.clock();
    u26._refill(v470, os_clock_ret);
    local buffer_len_ret = buffer.len(p467);
    local v471 = v470.byteTokens < buffer_len_ret;

    if v471 then
        local _counters = u26._counters;
        _counters.dropped = _counters.dropped + 1;
        u26._warn(`bytes:{p465.Name}`, (`{p465.Name} sent more than {u26.limits.maxBytesPerSecond} bytes a second, dropping packets`));

        if not v469 then
            return true;
        end;
    else
        v470.byteTokens = v470.byteTokens - buffer_len_ret;
    end;

    return u26._process(v470, p467, p468, p465, v469, v471, os_clock_ret);
end;

function u26._onServerEvent(p472: userdata, p473: any, p474: any, p475: string) -- Line: 1904
    -- upvalues: u26 (copy)
    if not p472.Parent then
        return;
    end;

    if typeof(p473) ~= "buffer" or p474 ~= nil and typeof(p474) ~= "table" then
        p472:Kick("Invalid network data");

        return;
    end;

    if p474 and #p474 > 4095 then
        p472:Kick("Invalid network data");

        return;
    end;

    if not u26._deliver(p472, p475, p473, p474) then
        p472:Kick("Invalid network data");
    end;
end;

function u26._onReliableServer(p476: userdata, p477: any, p478: any) -- Line: 1922
    -- upvalues: u26 (copy)
    u26._onServerEvent(p476, p477, p478, "reliable");
end;

function u26._onUnreliableServer(p479: userdata, p480: any, p481: any) -- Line: 1926
    -- upvalues: u26 (copy)
    u26._onServerEvent(p479, p480, p481, "unreliable");
end;

function u26._onClientEvent(p482: buffer, p483: table?, p484: string) -- Line: 1930
    -- upvalues: u26 (copy), Players (copy)
    if not u26._deliver(Players.LocalPlayer, p484, p482, p483) then
        u26._warn("malformed", "received a malformed payload from the server");
    end;
end;

function u26._onReliableClient(p485: buffer, p486: table?) -- Line: 1936
    -- upvalues: u26 (copy)
    u26._onClientEvent(p485, p486, "reliable");
end;

function u26._onUnreliableClient(p487: buffer, p488: table?) -- Line: 1940
    -- upvalues: u26 (copy)
    u26._onClientEvent(p487, p488, "unreliable");
end;

function u26._onPlayerRemoving(p489: userdata) -- Line: 1944
    -- upvalues: u26 (copy)
    u26._connections[p489] = nil;
end;

function u26._listen() -- Line: 1948
    -- upvalues: u24 (ref), u26 (copy), u25 (ref)
    u24.OnClientEvent:Connect(u26._onReliableClient);
    u25.OnClientEvent:Connect(u26._onUnreliableClient);
end;

function u26.start() -- Line: 1953
    -- upvalues: u26 (copy), u24 (ref), u25 (ref), Players (copy)
    if u26.started then
        return;
    end;

    u26.started = true;

    if not u26.isServer then
        u24 = script:WaitForChild("Reliable");
        u25 = script:WaitForChild("Unreliable");
        task.defer(u26._listen);

        return;
    end;

    u24 = Instance.new("RemoteEvent");
    u24.Name = "Reliable";
    u24.Parent = script;
    u25 = Instance.new("UnreliableRemoteEvent");
    u25.Name = "Unreliable";
    u25.Parent = script;
    u24.OnServerEvent:Connect(u26._onReliableServer);
    u25.OnServerEvent:Connect(u26._onUnreliableServer);
    Players.PlayerRemoving:Connect(u26._onPlayerRemoving);
end;

return u26;