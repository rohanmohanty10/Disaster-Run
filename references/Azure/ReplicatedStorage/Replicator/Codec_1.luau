 
 

local u1 = require("@game/ReplicatedStorage/Network/NetworkSystem");
require("./Types");
local u22 = {
    FlagFull = 1,
    FlagSnap = 2,
    FlagCompact = 4,
    FlagAck = 8,

    _mapAngle = function(p2: number) -- Line: 23, Name: _mapAngle
        local math_round_ret = math.round((p2 + 3.141592653589793) / 6.283185307179586 * 65535);

        return math.clamp(math_round_ret, 0, 65535);
    end,

    _unmapAngle = function(p3: number) -- Line: 27, Name: _unmapAngle
        return p3 / 65535 * 6.283185307179586 - 3.141592653589793;
    end,

    canCompact = function(p4: vector) -- Line: 31, Name: canCompact
        local X = p4.X;
        local Y = p4.Y;
        local Z = p4.Z;
        local v5;

        if X == X and (Y == Y and (Z == Z and (X >= -8192 and (X < 8192 and (Z >= -8192 and (Z < 8192 and Y >= -2048)))))) then
            v5 = Y < 2048;
        else
            v5 = false;
        end;

        return v5;
    end,

    isFinite = function(p6: vector) -- Line: 39, Name: isFinite
        local Magnitude = p6.Magnitude;
        local v7;

        if Magnitude == Magnitude then
            v7 = Magnitude < (1 / 0);
        else
            v7 = false;
        end;

        return v7;
    end,

    hasFlag = function(p8: number, p9: number) -- Line: 44, Name: hasFlag
        return bit32.band(p8, p9) ~= 0;
    end,

    _writeCompact = function(p10: vector) -- Line: 48, Name: _writeCompact
        -- upvalues: u1 (copy)
        local math_clamp_ret = math.clamp(p10.X, -8192, 8191.99609375);
        local math_clamp_ret2 = math.clamp(p10.Y, -2048, 2047.99609375);
        local math_clamp_ret3 = math.clamp(p10.Z, -8192, 8191.99609375);
        local v11 = math_clamp_ret // 256;
        local v12 = math_clamp_ret2 // 256;
        local v13 = math_clamp_ret3 // 256;
        local math_floor_ret = math.floor((math_clamp_ret - v11 * 256) * 256);
        local math_clamp_ret4 = math.clamp(math_floor_ret, 0, 65535);
        local math_floor_ret2 = math.floor((math_clamp_ret2 - v12 * 256) * 256);
        local math_clamp_ret5 = math.clamp(math_floor_ret2, 0, 65535);
        local math_floor_ret3 = math.floor((math_clamp_ret3 - v13 * 256) * 256);
        local math_clamp_ret6 = math.clamp(math_floor_ret3, 0, 65535);
        u1.writeuint(v11 + 32 + (v12 + 8) * 64 + (v13 + 32) * 1024 + math_clamp_ret4 * 65536, 32).writeuint(math_clamp_ret5 + math_clamp_ret6 * 65536, 32);
    end,

    _readCompact = function() -- Line: 60, Name: _readCompact
        -- upvalues: u1 (copy)
        local v14 = u1.readuint(32);
        local v15 = u1.readuint(32);
        local v16 = bit32.extract(v14, 0, 6) - 32;
        local v17 = bit32.extract(v14, 6, 4) - 8;
        local v18 = bit32.extract(v14, 10, 6) - 32;
        local v19 = v16 * 256 + bit32.rshift(v14, 16) / 256;
        local v20 = v17 * 256 + bit32.band(v15, 65535) / 256;
        local v21 = v18 * 256 + bit32.rshift(v15, 16) / 256;

        return Vector3.new(v19, v20, v21);
    end
};

function u22.writeEntry(p23: number, p24: number, p25, p26: boolean, p27: number?) -- Line: 73
    -- upvalues: u22 (copy), u1 (copy)
    local Position = p25.Position;
    local v28 = u22.canCompact(Position);
    local bit32_bnot_ret = bit32.bnot(u22.FlagCompact + u22.FlagFull);
    local v29 = bit32.band(p24, bit32_bnot_ret, 15) + (not v28 and 0 or u22.FlagCompact) + (not p26 and 0 or u22.FlagFull);
    local v30 = bit32.band(p23, 255) + v29 * 256;

    if p27 then
        local math_round_ret = math.round(p27 * 8);
        local math_clamp_ret = math.clamp(math_round_ret, -2048, 2047);
        u1.writeuint(v30 + bit32.band(math_clamp_ret, 4095) * 4096, 24);
    else
        u1.writeuint(v30, 12);
    end;

    if v28 then
        u22._writeCompact(Position);
    else
        u1.writevector(Position);
    end;

    local v31, v32, v33 = p25:ToOrientation();

    if p26 then
        u1.writeuint(u22._mapAngle(v31) + u22._mapAngle(v32) * 65536, 32).writeuint(u22._mapAngle(v33), 16);

        return;
    end;

    u1.writeuint(u22._mapAngle(v32), 16);
end;

function u22.readEntry(p34: boolean) -- Line: 99
    -- upvalues: u1 (copy), u22 (copy)
    local v35 = u1.readuint(p34 and 24 or 12);
    local bit32_band_ret = bit32.band(v35, 255);
    local bit32_extract_ret = bit32.extract(v35, 8, 4);
    local v36 = not p34 and 0 or bit32.extract(v35, 12, 12);

    if v36 >= 2048 then
        v36 = v36 - 4096;
    end;

    local v37 = v36 / 8;
    local v38;

    if bit32.band(bit32_extract_ret, u22.FlagCompact) == 0 then
        v38 = u1.readvector();
    else
        v38 = u22._readCompact();
    end;

    if bit32.band(bit32_extract_ret, u22.FlagFull) == 0 then
        local v39 = u22._unmapAngle(u1.readuint(16));

        return bit32_band_ret, bit32_extract_ret, v37, CFrame.fromOrientation(0, v39, 0) + v38;
    end;

    local v40 = u1.readuint(32);
    local v41 = u22._unmapAngle((bit32.band(v40, 65535)));
    local v42 = u22._unmapAngle((bit32.rshift(v40, 16)));
    local v43 = u22._unmapAngle(u1.readuint(16));

    return bit32_band_ret, bit32_extract_ret, v37, CFrame.fromOrientation(v41, v42, v43) + v38;
end;

function u22.writeDescription(p44) -- Line: 118
    -- upvalues: u1 (copy)
    u1.writeuint(p44.id, 8).writeref(p44.model).writeref(p44.player).writeref(p44.owner).writecframe(p44.cframe).writebool(p44.full);
end;

function u22.readDescription() -- Line: 127
    -- upvalues: u1 (copy)
    local v45 = u1.readuint(8);
    local v46 = u1.readref();
    local v47 = u1.readref();
    local v48 = u1.readref();
    local v49 = u1.readcframe();
    local v50 = u1.readbool();
    local v51 = {
        id = v45
    };

    if typeof(v46) ~= "Instance" or not v46:IsA("Model") then
        v46 = nil;
    end;

    v51.model = v46;

    if typeof(v47) ~= "Instance" or not v47:IsA("Player") then
        v47 = nil;
    end;

    v51.player = v47;

    if typeof(v48) ~= "Instance" or not v48:IsA("Player") then
        v48 = nil;
    end;

    v51.owner = v48;
    v51.cframe = v49;
    v51.full = v50;

    return v51;
end;

return u22;