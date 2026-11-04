 
 

local Players = game:GetService("Players");
local u1 = require("./NetworkSystem");
local u43 = {
    bool = {
        aligned = false,
        write = u1.writebool,
        read = u1.readbool
    },
    varint = {
        aligned = true,
        write = u1.writevarint,
        read = u1.readvarint
    },
    float32 = {
        aligned = true,
        write = u1.writefloat,
        read = u1.readfloat
    },
    float64 = {
        aligned = true,
        write = u1.writedouble,
        read = u1.readdouble
    },
    string = {
        aligned = true,
        write = u1.writestring,
        read = u1.readstring
    },
    buffer = {
        aligned = true,
        write = u1.writebuffer,
        read = u1.readbuffer
    },
    vector = {
        aligned = true,
        write = u1.writevector,
        read = u1.readvector
    },
    direction = {
        aligned = true,
        write = u1.writedirection,
        read = u1.readdirection
    },
    rotation = {
        aligned = false,
        write = u1.writerotation,
        read = u1.readrotation
    },
    cframe = {
        aligned = false,
        write = u1.writecframe,
        read = u1.readcframe
    },
    color = {
        aligned = true,
        write = u1.writecolor,
        read = u1.readcolor
    },
    ref = {
        aligned = false,
        write = u1.writeref,
        read = u1.readref
    },
    nothing = {
        aligned = true,

        write = function() -- Line: 41, Name: write
        end,

        read = function() -- Line: 42, Name: read
            return nil;
        end
    },
    vector2 = {
        aligned = true,

        write = function(p2) -- Line: 48, Name: write
            -- upvalues: u1 (copy)
            u1.writefloat(p2.X).writefloat(p2.Y);
        end,

        read = function() -- Line: 51, Name: read
            -- upvalues: u1 (copy)
            local v3 = u1.readfloat();

            return Vector2.new(v3, u1.readfloat());
        end
    },
    instance = {
        aligned = false,
        write = u1.writeref,

        read = function() -- Line: 59, Name: read
            -- upvalues: u1 (copy)
            local v4 = u1.readref();

            if typeof(v4) == "Instance" then
                return v4;
            end;

            return nil;
        end
    },

    uint = function(u5: number) -- Line: 67, Name: uint
        -- upvalues: u1 (copy)
        return {
            write = function(p6: number) -- Line: 69, Name: write
                -- upvalues: u1 (ref), u5 (copy)
                u1.writeuint(p6, u5);
            end,

            read = function() -- Line: 72, Name: read
                -- upvalues: u1 (ref), u5 (copy)
                return u1.readuint(u5);
            end,

            aligned = u5 % 8 == 0,
            bits = u5
        };
    end,

    int = function(u7: number) -- Line: 80, Name: int
        -- upvalues: u1 (copy)
        return {
            signed = true,

            write = function(p8: number) -- Line: 82, Name: write
                -- upvalues: u1 (ref), u7 (copy)
                u1.writeint(p8, u7);
            end,

            read = function() -- Line: 85, Name: read
                -- upvalues: u1 (ref), u7 (copy)
                return u1.readint(u7);
            end,

            aligned = u7 % 8 == 0,
            bits = u7
        };
    end,

    angle = function(u9: number) -- Line: 94, Name: angle
        -- upvalues: u1 (copy)
        return {
            write = function(p10: number) -- Line: 96, Name: write
                -- upvalues: u1 (ref), u9 (copy)
                u1.writeangle(p10, u9);
            end,

            read = function() -- Line: 99, Name: read
                -- upvalues: u1 (ref), u9 (copy)
                return u1.readangle(u9);
            end,

            aligned = u9 % 8 == 0
        };
    end,

    optional = function(p11) -- Line: 106, Name: optional
        -- upvalues: u1 (copy)
        local write = p11.write;
        local read = p11.read;

        return {
            aligned = false,

            write = function(p12) -- Line: 110, Name: write
                -- upvalues: u1 (ref), write (copy)
                if p12 == nil then
                    u1.writebool(false);

                    return;
                end;

                u1.writebool(true);
                write(p12);
            end,

            read = function() -- Line: 118, Name: read
                -- upvalues: u1 (ref), read (copy)
                if u1.readbool() then
                    return read();
                end;

                return nil;
            end
        };
    end,

    array = function(p13) -- Line: 125, Name: array
        -- upvalues: u1 (copy)
        local write = p13.write;
        local read = p13.read;
        local u14 = p13.bits or 0;
        local u15 = p13.signed == true;

        return {
            write = function(p16: table) -- Line: 131, Name: write
                -- upvalues: u1 (ref), u14 (copy), write (copy)
                local v17 = #p16;
                u1.writevarint(v17);

                if u14 > 0 then
                    for i = 1, v17 do
                        u1.writeuint(p16[i], u14);
                        local _ = i;
                    end;

                    return;
                end;

                for i = 1, v17 do
                    write(p16[i]);
                    local _ = i;
                end;
            end,

            read = function() -- Line: 144, Name: read
                -- upvalues: u1 (ref), u14 (copy), u15 (copy), read (copy)
                local v18 = u1.readvarint();

                if u1.remaining() < v18 then
                    error("array is longer than its packet");
                end;

                local table_create_ret = table.create(v18);

                if u14 > 0 then
                    for i = 1, v18 do
                        local v19 = u1.readuint(u14);

                        if u15 and 2 ^ (u14 - 1) <= v19 then
                            v19 = v19 - 2 ^ u14;
                        end;

                        table_create_ret[i] = v19;
                        local _ = i;
                    end;

                    return table_create_ret;
                end;

                for i = 1, v18 do
                    table_create_ret[i] = read();
                    local _ = i;
                end;

                return table_create_ret;
            end,

            aligned = p13.aligned
        };
    end,

    map = function(p20, p21) -- Line: 166, Name: map
        -- upvalues: u1 (copy)
        local write = p20.write;
        local read = p20.read;
        local write2 = p21.write;
        local read2 = p21.read;
        local v29 = {
            write = function(p22: table) -- Line: 172, Name: write
                -- upvalues: u1 (ref), write (copy), write2 (copy)
                local v23 = 0;

                for _ in p22 do
                    v23 = v23 + 1;
                end;

                u1.writevarint(v23);

                for i, v in p22 do
                    write(i);
                    write2(v);
                end;
            end,

            read = function() -- Line: 183, Name: read
                -- upvalues: u1 (ref), read (copy), read2 (copy)
                local v24 = u1.readvarint();

                if u1.remaining() < v24 then
                    error("map is longer than its packet");
                end;

                local v25 = {};

                for i = 1, v24 do
                    local v26 = read();
                    local v27 = read2();
                    local v28;

                    if v26 == nil then
                        v28 = i;
                    else
                        v25[v26] = v27;
                        v28 = i;
                    end;
                end;

                return v25;
            end
        };
        v29.aligned = p20.aligned and p21.aligned;

        return v29;
    end,

    struct = function(u30) -- Line: 202, Name: struct
        -- upvalues: u1 (copy)
        local u31 = {};

        for i in u30 do
            table.insert(u31, i);
        end;

        table.sort(u31, function(p32: string, p33: string) -- Line: 208
            -- upvalues: u30 (copy)
            local aligned = u30[p32].aligned;

            if aligned == u30[p33].aligned then
                return p32 < p33;
            end;

            return aligned;
        end);
        local u34 = #u31;
        local table_create_ret = table.create(u34);
        local table_create_ret2 = table.create(u34);
        local table_create_ret3 = table.create(u34, 0);
        local table_create_ret4 = table.create(u34, false);
        local v35 = true;

        for i, v in u31 do
            local v36 = u30[v];
            table_create_ret[i] = v36.write;
            table_create_ret2[i] = v36.read;
            table_create_ret3[i] = v36.bits or 0;
            table_create_ret4[i] = v36.signed == true;

            if v35 then
                v35 = v36.aligned;
            end;
        end;

        return {
            write = function(p37: table) -- Line: 230, Name: write
                -- upvalues: u34 (copy), table_create_ret3 (copy), u1 (ref), u31 (copy), table_create_ret (copy)
                for i = 1, u34 do
                    local v38 = table_create_ret3[i];
                    local v39;

                    if v38 > 0 then
                        u1.writeuint(p37[u31[i]], v38);
                        v39 = i;
                    else
                        table_create_ret[i](p37[u31[i]]);
                        v39 = i;
                    end;
                end;
            end,

            read = function() -- Line: 240, Name: read
                -- upvalues: u30 (copy), u34 (copy), table_create_ret3 (copy), u1 (ref), u31 (copy), table_create_ret4 (copy), table_create_ret2 (copy)
                local table_clone_ret = table.clone(u30);

                for i = 1, u34 do
                    local v40 = table_create_ret3[i];
                    local v41;

                    if v40 > 0 then
                        local v42 = u1.readuint(v40);

                        if table_create_ret4[i] and 2 ^ (v40 - 1) <= v42 then
                            v42 = v42 - 2 ^ v40;
                        end;

                        table_clone_ret[u31[i]] = v42;
                        v41 = i;
                    else
                        table_clone_ret[u31[i]] = table_create_ret2[i]();
                        v41 = i;
                    end;
                end;

                return table_clone_ret;
            end,

            aligned = v35
        };
    end
};

function u43.define(u44: string, u45: any, p46: any, u47: number?) -- Line: 257
    -- upvalues: u1 (copy), u43 (copy), Players (copy)
    local write = p46.write;
    local read = p46.read;
    local v48;

    if p46 == u43.nothing then
        v48 = nil;
    else
        v48 = write;
    end;

    local v49 = u1.sender(u44, u45, v48);
    local u50 = {};
    local u51 = {};
    local u52 = false;

    local function u58(p53: userdata) -- Line: 265
        -- upvalues: read (copy), u51 (ref), u50 (ref)
        local v54 = read();

        if #u51 > 0 then
            local v55 = u51;
            u51 = {};

            for _, v in v55 do
                task.spawn(v, v54, p53);
            end;
        end;

        local v56 = u50;
        local v57 = #v56;

        for i = 1, v57 - 1 do
            task.spawn(v56[i], v54, p53);
            local _ = i;
        end;

        if v57 > 0 then
            v56[v57](v54, p53);
        end;
    end;

    local function _() -- Line: 284
        -- upvalues: u52 (ref), u1 (ref), u44 (copy), u58 (copy), u47 (copy)
        if not u52 then
            u52 = true;
            u1.receive(u44, u58, u47);
        end;
    end;

    return {
        send = v49,
        sendTo = v49,

        sendToList = function(p59: userdata, p60: table) -- Line: 294, Name: sendToList
            -- upvalues: u1 (ref), u44 (copy), u45 (copy), write (copy)
            u1.write(u44, u45);
            write(p59);
            u1.sendTo(p60);
        end,

        sendToAll = function(p61: userdata) -- Line: 299, Name: sendToAll
            -- upvalues: u1 (ref), u44 (copy), u45 (copy), write (copy)
            u1.write(u44, u45);
            write(p61);
            u1.broadcast();
        end,

        sendToAllExcept = function(p62: userdata, p63: userdata) -- Line: 304, Name: sendToAllExcept
            -- upvalues: Players (ref), u1 (ref), u44 (copy), u45 (copy), write (copy)
            local Players2 = Players:GetPlayers();
            local table_find_ret = table.find(Players2, p63);

            if table_find_ret then
                table.remove(Players2, table_find_ret);
            end;

            u1.write(u44, u45);
            write(p62);
            u1.sendTo(Players2);
        end,

        listen = function(u64: function) -- Line: 314, Name: listen
            -- upvalues: u52 (ref), u1 (ref), u44 (copy), u58 (copy), u47 (copy), u50 (ref)
            if not u52 then
                u52 = true;
                u1.receive(u44, u58, u47);
            end;

            local table_clone_ret = table.clone(u50);
            table.insert(table_clone_ret, u64);
            u50 = table_clone_ret;

            return function() -- Line: 319
                -- upvalues: u50 (ref), u64 (copy)
                local table_find_ret = table.find(u50, u64);

                if table_find_ret then
                    local table_clone_ret2 = table.clone(u50);
                    table.remove(table_clone_ret2, table_find_ret);
                    u50 = table_clone_ret2;
                end;
            end;
        end,

        wait = function() -- Line: 328, Name: wait
            -- upvalues: u52 (ref), u1 (ref), u44 (copy), u58 (copy), u47 (copy), u51 (ref)
            if not u52 then
                u52 = true;
                u1.receive(u44, u58, u47);
            end;

            table.insert(u51, coroutine.running());

            return coroutine.yield();
        end
    };
end;

u43.uint8 = u43.uint(8);
u43.uint16 = u43.uint(16);
u43.uint32 = u43.uint(32);
u43.int8 = u43.int(8);
u43.int16 = u43.int(16);
u43.int32 = u43.int(32);

return u43;