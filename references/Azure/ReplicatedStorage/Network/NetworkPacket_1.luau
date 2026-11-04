 
 

local Players = game:GetService("Players");
local u1 = require("./NetworkSystem");
local u2 = nil;
local u9 = {
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

        write = function(p3) -- Line: 35, Name: write
            -- upvalues: u1 (copy)
            local writestring = u1.writestring;

            if type(p3) == "number" then
                p3 = tostring(p3);
            end;

            writestring(p3);
        end,

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

        write = function() -- Line: 49, Name: write
        end,

        read = function() -- Line: 50, Name: read
            return nil;
        end
    },
    vector2 = {
        aligned = true,

        write = function(p4) -- Line: 56, Name: write
            -- upvalues: u1 (copy)
            u1.writefloat(p4.X).writefloat(p4.Y);
        end,

        read = function() -- Line: 59, Name: read
            -- upvalues: u1 (copy)
            local v5 = u1.readfloat();

            return Vector2.new(v5, u1.readfloat());
        end
    },
    instance = {
        aligned = false,
        write = u1.writeref,

        read = function() -- Line: 67, Name: read
            -- upvalues: u1 (copy)
            local v6 = u1.readref();

            if typeof(v6) == "Instance" then
                return v6;
            end;

            return nil;
        end
    },

    _pass = function(p7: function, ...) -- Line: 75, Name: _pass
        -- upvalues: u2 (ref)
        local v8 = u2;
        u2 = nil;
        p7(...);
        u2 = v8;
    end
};

function u9._loop() -- Line: 82
    -- upvalues: u9 (copy)
    while true do
        u9._pass(coroutine.yield());
    end;
end;

function u9._run(p10: function, ...) -- Line: 88
    -- upvalues: u2 (ref), u9 (copy)
    if not u2 then
        u2 = coroutine.create(u9._loop);
        coroutine.resume(u2);
    end;

    task.spawn(u2, p10, ...);
end;

function u9._isPlayer(p11) -- Line: 96
    local v12;

    if typeof(p11) == "Instance" then
        v12 = p11:IsA("Player");
    else
        v12 = false;
    end;

    return v12;
end;

function u9.uint(u13: number) -- Line: 100
    -- upvalues: u1 (copy)
    return {
        write = function(p14: number) -- Line: 102, Name: write
            -- upvalues: u1 (ref), u13 (copy)
            u1.writeuint(p14, u13);
        end,

        read = function() -- Line: 105, Name: read
            -- upvalues: u1 (ref), u13 (copy)
            return u1.readuint(u13);
        end,

        aligned = u13 % 8 == 0,
        bits = u13
    };
end;

function u9.int(u15: number) -- Line: 113
    -- upvalues: u1 (copy)
    return {
        signed = true,

        write = function(p16: number) -- Line: 115, Name: write
            -- upvalues: u1 (ref), u15 (copy)
            u1.writeint(p16, u15);
        end,

        read = function() -- Line: 118, Name: read
            -- upvalues: u1 (ref), u15 (copy)
            return u1.readint(u15);
        end,

        aligned = u15 % 8 == 0,
        bits = u15
    };
end;

function u9.angle(u17: number) -- Line: 127
    -- upvalues: u1 (copy)
    return {
        write = function(p18: number) -- Line: 129, Name: write
            -- upvalues: u1 (ref), u17 (copy)
            u1.writeangle(p18, u17);
        end,

        read = function() -- Line: 132, Name: read
            -- upvalues: u1 (ref), u17 (copy)
            return u1.readangle(u17);
        end,

        aligned = u17 % 8 == 0
    };
end;

function u9.optional(p19) -- Line: 139
    -- upvalues: u1 (copy)
    local write = p19.write;
    local read = p19.read;

    return {
        aligned = false,

        write = function(p20) -- Line: 143, Name: write
            -- upvalues: u1 (ref), write (copy)
            if p20 == nil then
                u1.writebool(false);

                return;
            end;

            u1.writebool(true);
            write(p20);
        end,

        read = function() -- Line: 151, Name: read
            -- upvalues: u1 (ref), read (copy)
            if u1.readbool() then
                return read();
            end;

            return nil;
        end
    };
end;

function u9.array(p21) -- Line: 158
    -- upvalues: u1 (copy)
    local write = p21.write;
    local read = p21.read;
    local u22 = p21.bits or 0;
    local u23 = p21.signed == true;

    return {
        write = function(p24: table) -- Line: 164, Name: write
            -- upvalues: u1 (ref), u22 (copy), write (copy)
            local v25 = #p24;
            u1.writevarint(v25);

            if u22 > 0 then
                for i = 1, v25 do
                    u1.writeuint(p24[i], u22);
                    local _ = i;
                end;

                return;
            end;

            for i = 1, v25 do
                write(p24[i]);
                local _ = i;
            end;
        end,

        read = function() -- Line: 177, Name: read
            -- upvalues: u1 (ref), u22 (copy), u23 (copy), read (copy)
            local v26 = u1.readvarint();

            if u1.remaining() < v26 then
                error("array is longer than its packet");
            end;

            local table_create_ret = table.create(v26);

            if u22 > 0 then
                for i = 1, v26 do
                    local v27 = u1.readuint(u22);

                    if u23 and 2 ^ (u22 - 1) <= v27 then
                        v27 = v27 - 2 ^ u22;
                    end;

                    table_create_ret[i] = v27;
                    local _ = i;
                end;

                return table_create_ret;
            end;

            for i = 1, v26 do
                table_create_ret[i] = read();
                local _ = i;
            end;

            return table_create_ret;
        end,

        aligned = p21.aligned
    };
end;

function u9.map(p28, p29) -- Line: 199
    -- upvalues: u1 (copy)
    local write = p28.write;
    local read = p28.read;
    local write2 = p29.write;
    local read2 = p29.read;
    local v37 = {
        write = function(p30: table) -- Line: 205, Name: write
            -- upvalues: u1 (ref), write (copy), write2 (copy)
            local v31 = 0;

            for _ in p30 do
                v31 = v31 + 1;
            end;

            u1.writevarint(v31);

            for i, v in p30 do
                write(i);
                write2(v);
            end;
        end,

        read = function() -- Line: 216, Name: read
            -- upvalues: u1 (ref), read (copy), read2 (copy)
            local v32 = u1.readvarint();

            if u1.remaining() < v32 then
                error("map is longer than its packet");
            end;

            local v33 = {};

            for i = 1, v32 do
                local v34 = read();
                local v35 = read2();
                local v36;

                if v34 == nil then
                    v36 = i;
                else
                    v33[v34] = v35;
                    v36 = i;
                end;
            end;

            return v33;
        end
    };
    v37.aligned = p28.aligned and p29.aligned;

    return v37;
end;

function u9.struct(u38) -- Line: 235
    -- upvalues: u1 (copy)
    local u39 = {};

    for i in u38 do
        table.insert(u39, i);
    end;

    table.sort(u39, function(p40: string, p41: string) -- Line: 241
        -- upvalues: u38 (copy)
        local aligned = u38[p40].aligned;

        if aligned == u38[p41].aligned then
            return p40 < p41;
        end;

        return aligned;
    end);
    local u42 = #u39;
    local table_create_ret = table.create(u42);
    local table_create_ret2 = table.create(u42);
    local table_create_ret3 = table.create(u42, 0);
    local table_create_ret4 = table.create(u42, false);
    local v43 = true;

    for i, v in u39 do
        local v44 = u38[v];
        table_create_ret[i] = v44.write;
        table_create_ret2[i] = v44.read;
        table_create_ret3[i] = v44.bits or 0;
        table_create_ret4[i] = v44.signed == true;

        if v43 then
            v43 = v44.aligned;
        end;
    end;

    return {
        write = function(p45: table) -- Line: 263, Name: write
            -- upvalues: u42 (copy), table_create_ret3 (copy), u1 (ref), u39 (copy), table_create_ret (copy)
            for i = 1, u42 do
                local v46 = table_create_ret3[i];
                local v47;

                if v46 > 0 then
                    u1.writeuint(p45[u39[i]], v46);
                    v47 = i;
                else
                    table_create_ret[i](p45[u39[i]]);
                    v47 = i;
                end;
            end;
        end,

        read = function() -- Line: 273, Name: read
            -- upvalues: u38 (copy), u42 (copy), table_create_ret3 (copy), u1 (ref), u39 (copy), table_create_ret4 (copy), table_create_ret2 (copy)
            local table_clone_ret = table.clone(u38);

            for i = 1, u42 do
                local v48 = table_create_ret3[i];
                local v49;

                if v48 > 0 then
                    local v50 = u1.readuint(v48);

                    if table_create_ret4[i] and 2 ^ (v48 - 1) <= v50 then
                        v50 = v50 - 2 ^ v48;
                    end;

                    table_clone_ret[u39[i]] = v50;
                    v49 = i;
                else
                    table_clone_ret[u39[i]] = table_create_ret2[i]();
                    v49 = i;
                end;
            end;

            return table_clone_ret;
        end,

        aligned = v43
    };
end;

function u9.define(u51: string, u52: any, p53: any, p54: number?, p55: number?) -- Line: 290
    -- upvalues: u1 (copy), u9 (copy), Players (copy)
    local write = p53.write;
    local read = p53.read;
    local v56;

    if p53 == u9.nothing then
        v56 = nil;
    else
        v56 = write;
    end;

    local u57 = u1.sender(u51, u52, v56);
    local isServer = u1.isServer;
    local u58 = {};
    local u59 = {};
    u1.receive(u51, function(p60: userdata) -- Line: 298
        -- upvalues: read (copy), isServer (copy), u59 (ref), u58 (ref), u9 (ref)
        local v61 = read();

        if not isServer then
            p60 = nil;
        end;

        if #u59 > 0 then
            local v62 = u59;
            u59 = {};

            for _, v in v62 do
                task.spawn(v, v61, p60);
            end;
        end;

        for _, v in u58 do
            u9._run(v, v61, p60);
        end;
    end, p54, p55);

    return {
        send = u57,

        sendTo = function(p63: userdata, p64: userdata) -- Line: 315, Name: sendTo
            -- upvalues: isServer (copy), u51 (copy), u9 (ref), u57 (copy)
            if not isServer then
                error(`'{u51}' can only be sent to a player from the server`, 2);
            end;

            if u9._isPlayer(p64) then
                u57(p63, p64);
            end;
        end,

        sendToList = function(p65: userdata, p66: table) -- Line: 323, Name: sendToList
            -- upvalues: isServer (copy), u51 (copy), u1 (ref), u52 (copy), write (copy)
            if not isServer then
                error(`'{u51}' can only be sent to players from the server`, 2);
            end;

            if not p66 then
                return;
            end;

            u1.write(u51, u52);
            write(p65);
            u1.sendTo(p66);
        end,

        sendToAll = function(p67: userdata) -- Line: 334, Name: sendToAll
            -- upvalues: isServer (copy), u51 (copy), u1 (ref), u52 (copy), write (copy)
            if not isServer then
                error(`'{u51}' can only be sent to players from the server`, 2);
            end;

            u1.write(u51, u52);
            write(p67);
            u1.broadcast();
        end,

        sendToAllExcept = function(p68: userdata, p69: userdata) -- Line: 342, Name: sendToAllExcept
            -- upvalues: isServer (copy), u51 (copy), Players (ref), u1 (ref), u52 (copy), write (copy)
            if not isServer then
                error(`'{u51}' can only be sent to players from the server`, 2);
            end;

            local Players2 = Players:GetPlayers();
            local table_find_ret = table.find(Players2, p69);

            if table_find_ret then
                table.remove(Players2, table_find_ret);
            end;

            u1.write(u51, u52);
            write(p68);
            u1.sendTo(Players2);
        end,

        listen = function(u70: function) -- Line: 355, Name: listen
            -- upvalues: u58 (ref)
            local table_clone_ret = table.clone(u58);
            table.insert(table_clone_ret, u70);
            u58 = table_clone_ret;

            return function() -- Line: 359
                -- upvalues: u58 (ref), u70 (copy)
                local table_find_ret = table.find(u58, u70);

                if table_find_ret then
                    local table_clone_ret2 = table.clone(u58);
                    table.remove(table_clone_ret2, table_find_ret);
                    u58 = table_clone_ret2;
                end;
            end;
        end,

        wait = function() -- Line: 368, Name: wait
            -- upvalues: u59 (ref)
            table.insert(u59, coroutine.running());

            return coroutine.yield();
        end
    };
end;

u9.uint8 = u9.uint(8);
u9.uint16 = u9.uint(16);
u9.uint32 = u9.uint(32);
u9.int8 = u9.int(8);
u9.int16 = u9.int(16);
u9.int32 = u9.int(32);

return u9;