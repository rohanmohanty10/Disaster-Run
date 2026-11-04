 

 

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local v1 = {};
local Shared = script.Parent.Parent.Shared;
require(Shared.Types);
local u2 = {};
local u3 = {};
local Ticker = require(Shared.Ticker);
local InterpolationMath = require(Shared.InterpolationMath);
local Warn = require(Shared.Warn);
local ServerClock = require(script.Parent.ServerClock);
local Holder = require(Shared.Holder);
local Entity = require(Shared.Entity);
local Config = require(Shared.Config);
local ClockUnwrap = require(Shared.ClockUnwrap);
local PositionCodec = require(Shared.PositionCodec);
local SERVER = require(Shared.Stats).SERVER;
local u4 = {};
local u5 = 300;
Config._WaitForLock(function() -- Line: 30
    -- upvalues: u5 (ref), Config (copy)
    u5 = Config._GetConfig("MAX_TOTAL_BYTES_PER_FRAME_PER_PLAYER");
end);
local u6 = 0;
local Replicate = Shared.Remotes.Replicate;
local SafeReplicate = Shared.Remotes.SafeReplicate;
local u7 = {};
local os_clock_ret = os.clock();
local u8 = (-1 / 0);

local function FireMiddleMans(p9: userdata, p10: any, p11, p12: number) -- Line: 55
    -- upvalues: u3 (ref)
    if #u3 == 0 then
        return false, nil;
    end;

    debug.profilebegin("FireMiddleMans");
    local v13 = nil;

    for _, v in u3 do
        local v14 = v.func(p9, p10, v13 or p11, p12);

        if v14 == true then
            debug.profileend();

            return true, nil;
        end;

        if typeof(v14) == "CFrame" then
            v13 = v14;
        end;
    end;

    debug.profileend();

    return false, v13;
end;

local function UnmapRotation(p15: number) -- Line: 78
    return p15 / 65535 * 6.283185307179586 - 3.141592653589793;
end;

local function MapRotation(p16: number) -- Line: 82
    return math.round((p16 + 3.141592653589793) / 0.00009587526218325454);
end;

local function RewritePacketCFrame(p17: buffer, p18) -- Line: 86
    -- upvalues: PositionCodec (copy)
    local buffer_readu8_ret = buffer.readu8(p17, 2);
    local v19 = bit32.band(buffer_readu8_ret, 1) == 1;
    local v20 = bit32.band(buffer_readu8_ret, PositionCodec.COMPACT_FLAG) == PositionCodec.COMPACT_FLAG;
    local v21, v22, v23 = p18:ToOrientation();
    local v24 = PositionCodec.write(p17, 3, p18.Position, v20);

    if not v19 then
        local math_round_ret = math.round((v22 + 3.141592653589793) / 0.00009587526218325454);
        buffer.writeu16(p17, v24, math_round_ret);

        return;
    end;

    local math_round_ret = math.round((v21 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p17, v24, math_round_ret);
    local math_round_ret2 = math.round((v22 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p17, v24 + 2, math_round_ret2);
    local math_round_ret3 = math.round((v23 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p17, v24 + 4, math_round_ret3);
end;

local function DeserializeEntityPacket(p25: buffer, p26: number) -- Line: 101
    -- upvalues: PositionCodec (copy)
    local buffer_readu16_ret = buffer.readu16(p25, p26);
    local v27 = p26 + 2;
    local buffer_readu8_ret = buffer.readu8(p25, v27);
    local v28 = bit32.band(buffer_readu8_ret, 1) == 1;
    local v29 = bit32.band(buffer_readu8_ret, 4) == 4;
    local v30 = bit32.band(buffer_readu8_ret, PositionCodec.COMPACT_FLAG) == PositionCodec.COMPACT_FLAG;
    local v31, v32 = PositionCodec.read(p25, v27 + 1, v30);
    local v33, v34;

    if v28 then
        local v35 = buffer.readu16(p25, v32) / 65535 * 6.283185307179586 - 3.141592653589793;
        local v36 = buffer.readu16(p25, v32 + 2) / 65535 * 6.283185307179586 - 3.141592653589793;
        local v37 = buffer.readu16(p25, v32 + 4) / 65535 * 6.283185307179586 - 3.141592653589793;
        v33 = v32 + 6;
        v34 = CFrame.new(v31) * CFrame.fromOrientation(v35, v36, v37);
    else
        local v38 = buffer.readu16(p25, v32) / 65535 * 6.283185307179586 - 3.141592653589793;
        v33 = v32 + 2;
        v34 = CFrame.new(v31) * CFrame.fromOrientation(0, v38, 0);
    end;

    local v39;

    if bit32.band(buffer_readu8_ret, 16) == 16 then
        local v40 = buffer.readi16(p25, v33) / 64;
        local v41 = buffer.readi16(p25, v33 + 2) / 64;
        local v42 = buffer.readi16(p25, v33 + 4) / 64;
        v39 = Vector3.new(v40, v41, v42);
        v33 = v33 + 6;
    else
        v39 = nil;
    end;

    return buffer_readu16_ret, v34, v33, v29, v39;
end;

local function CalculateMaxThroughputForPlayer(p43: userdata) -- Line: 139
    -- upvalues: Holder (copy), u5 (ref)
    local v44 = 0;

    for _ in Holder._clientOwned[p43] or {} do
        v44 = v44 + 1;
    end;

    return u5 + v44 * 27;
end;

local function GuardNumber(p45: string, p46: number) -- Line: 147
    -- upvalues: u7 (ref)
    local v47 = u7[p45];

    if typeof(v47) == "number" then
        return v47;
    end;

    return p46;
end;

local function ServerStalledSince(p48: number) -- Line: 152
    -- upvalues: os_clock_ret (ref), u8 (ref)
    return os.clock() - os_clock_ret > 0.1 and true or p48 <= u8;
end;

local function GuardLag(p49: any, p50: number, p51: number, p52: vector, p53: any, p54: boolean) -- Line: 156
    -- upvalues: u7 (ref), os_clock_ret (ref), u8 (ref)
    local v55 = p51 - p50;
    local _lagEpochStart = p49._lagEpochStart;

    if _lagEpochStart then
        if p51 - _lagEpochStart > 1.5 then
            p49._lagEpochStart = p51;
            p49._lagMinPrevious = p49._lagMinCurrent;
            p49._lagMinCurrent = v55;
        else
            p49._lagMinCurrent = math.min(p49._lagMinCurrent, v55);
        end;
    else
        p49._lagEpochStart = p51;
        p49._lagMinCurrent = v55;
        p49._lagMinPrevious = v55;
    end;

    if u7.lagGuard == false or p54 then
        return;
    end;

    local lagGrace = u7.lagGrace;
    local v56 = typeof(lagGrace) ~= "number" and 0.35 or lagGrace;
    local v57 = v55 - math.min(p49._lagMinCurrent, p49._lagMinPrevious);
    local lagStale = u7.lagStale;

    if (typeof(lagStale) ~= "number" and 0.25 or lagStale) < v57 then
        if os.clock() - os_clock_ret <= 0.1 and p51 - 0.25 > u8 then
            p49._lagUntil = p51 + v56;
            p49._lagReason = `updates arrived {math.round(v57 * 1000)} ms late`;

            return;
        end;
    end;

    if p53 then
        local arrive = p53.arrive;

        if os.clock() - os_clock_ret <= 0.1 and arrive > u8 then
            local lagGap = u7.lagGap;
            local v58 = typeof(lagGap) ~= "number" and 0.25 or lagGap;
            local v59 = p51 - p53.arrive;
            local Magnitude = (p52 - p53.position).Magnitude;

            if v58 < v59 and p50 - p53.clock > v58 * 0.5 then
                local lagDistance = u7.lagDistance;

                if (typeof(lagDistance) ~= "number" and 8 or lagDistance) < Magnitude then
                    p49._lagUntil = p51 + v56;
                    p49._lagReason = `moved {math.round(Magnitude)} studs during a {math.round(v59 * 1000)} ms silence`;
                end;
            end;
        end;
    end;
end;

local function GuardVelocity(p60: any, p61: number, p62: number, p63: vector, p64: table, p65: vector?) -- Line: 192
    -- upvalues: u7 (ref)
    if not p65 or u7.velocityGuard == false then
        p60._velocityClampStart = nil;

        return p65;
    end;

    local v66 = p64[#p64];

    if not v66 then
        local velocityGuardBase = u7.velocityGuardBase;
        local v67 = typeof(velocityGuardBase) ~= "number" and 25 or velocityGuardBase;

        if v67 < p65.Magnitude then
            return p65.Unit * v67;
        end;

        return p65;
    end;

    local velocityGuardWindow = u7.velocityGuardWindow;
    local v68 = typeof(velocityGuardWindow) ~= "number" and 0.05 or velocityGuardWindow;

    for i = #p64, 1, -1 do
        local v69 = p64[i];

        if v68 < p61 - v69.clock then
            break;
        end;

        v66 = v69;
        local _ = i;
    end;

    local math_max_ret = math.max(p61 - v66.clock, (p62 - v66.arrive) * 0.5);

    if math_max_ret < 0.004166666666666667 then
        return p60._guardedVelocity or Vector3.new(0, 0, 0);
    end;

    local v70 = (p63 - v66.position) / math_max_ret;
    local velocityGuardBase = u7.velocityGuardBase;
    local v71 = typeof(velocityGuardBase) ~= "number" and 25 or velocityGuardBase;

    if v70.Magnitude > 600 then
        v70 = Vector3.new(0, 0, 0);
    else
        local velocityGuardRatio = u7.velocityGuardRatio;
        v71 = v71 + v70.Magnitude * (typeof(velocityGuardRatio) ~= "number" and 0.5 or velocityGuardRatio);
    end;

    local v72 = p65 - v70;

    if v72.Magnitude <= v71 then
        p60._velocityClampStart = nil;

        return p65;
    end;

    p60._velocityClampStart = p60._velocityClampStart or p62;

    return v70 + v72.Unit * v71;
end;

local function GuardPacket(p73: any, p74: number, p75: number, p76: vector, p77: boolean, p78: vector?) -- Line: 230
    -- upvalues: GuardLag (copy), GuardVelocity (copy)
    local _guardSamples = p73._guardSamples;

    if not _guardSamples or p77 then
        _guardSamples = {};
        p73._guardSamples = _guardSamples;
    end;

    local v79 = _guardSamples[#_guardSamples];
    local _teleport = p73._teleport;
    local _teleportUntil = p73._teleportUntil;

    if not p77 then
        if typeof(_teleport) == "number" and p75 - _teleport < 1 then
            p77 = true;
        elseif typeof(_teleportUntil) == "number" then
            p77 = p75 < _teleportUntil;
        else
            p77 = false;
        end;
    end;

    GuardLag(p73, p74, p75, p76, v79, p77);
    local v80 = GuardVelocity(p73, p74, p75, p76, _guardSamples, p78);
    p73._guardedVelocity = v80;
    table.insert(_guardSamples, {
        clock = p74,
        arrive = p75,
        position = p76
    });

    if #_guardSamples > 6 then
        table.remove(_guardSamples, 1);
    end;

    return v80;
end;

local function HandleEntity(p81: userdata, p82: number, p83: number, p84: number, p85, p86: buffer, p87: boolean, p88: vector?) -- Line: 252
    -- upvalues: Holder (copy), FireMiddleMans (copy), RewritePacketCFrame (copy), Config (copy), InterpolationMath (copy), Entity (copy), Ticker (copy), GuardPacket (copy)
    local EntityFromId = Holder.GetEntityFromId(p82);

    if not EntityFromId or EntityFromId.networkOwner ~= p81 then
        return;
    end;

    local Position = p85.Position;
    local v89 = Position.X + Position.Y + Position.Z;

    if v89 ~= v89 or math.abs(v89) == (1 / 0) then
        return;
    end;

    local _teleport = EntityFromId._teleport;
    local NetworkPing = p81:GetNetworkPing();
    local v90 = math.max(NetworkPing, 0) + 0.05;

    if _teleport then
        _teleport = os.clock() - _teleport < v90 + 0.5;
    end;

    if p87 then
        if _teleport then
            EntityFromId._teleport = nil;
        else
            local buffer_readu8_ret = buffer.readu8(p86, 2);
            local bit32_band_ret = bit32.band(buffer_readu8_ret, 4294967291);
            buffer.writeu8(p86, 2, bit32_band_ret);
        end;
    elseif _teleport then
        return;
    end;

    if EntityFromId.lastClientClock and p84 < EntityFromId.lastClientClock then
        return;
    end;

    debug.profilebegin("HandleEntity.FireMiddleMans");
    local v91, v92 = FireMiddleMans(p81, EntityFromId, p85, p83);
    debug.profileend();

    if v91 then
        return;
    end;

    if v92 then
        RewritePacketCFrame(p86, v92);
        p85 = v92;
    end;

    local v93 = nil;

    if Config.FLAGS.SERVER_VELOCITY_FIX and EntityFromId.snapshot then
        local Latest = EntityFromId.snapshot:GetLatest();
        local v94 = EntityFromId.lastClientClock or p84;
        local TICK_RATE = EntityFromId.entityConfig.TICK_RATE;

        if EntityFromId.isHalfTicked then
            TICK_RATE = TICK_RATE * 2;
        end;

        if Latest then
            v93 = InterpolationMath.CalculateVelocity(Latest.value.Position, v94, p85.Position, p84, TICK_RATE);
        end;
    end;

    if Entity.Push(EntityFromId, p83, p85, v93) then
        EntityFromId.arriveFrame = Ticker.GetGlobalTick();
        local v95 = GuardPacket(EntityFromId, p84, p83, p85.Position, p87, p88);

        if v92 then
            v95 = nil;
        end;

        EntityFromId.clientVelocity = v95;
        EntityFromId.clientVelocityTime = p83;
        EntityFromId.clientVelocityClock = p84;
        EntityFromId.lastClientClock = p84;
        EntityFromId.cframeBuffer = p86;

        if EntityFromId.modelReplicationMode == "NATIVE" and not EntityFromId._lockedCFReplication then
            return;
        end;

        Entity._SetPartCFrame(EntityFromId, p85);
    end;
end;

local u96 = {};

local function OnReceive(p97: userdata, p98: buffer) -- Line: 335
    -- upvalues: u96 (copy), u6 (ref), Holder (copy), u5 (ref), Warn (copy), ClockUnwrap (copy), u4 (copy), ServerClock (copy), DeserializeEntityPacket (copy), HandleEntity (copy)
    if typeof(p98) ~= "buffer" then
        return;
    end;

    u96[p97] = (u96[p97] or 0) + buffer.len(p98);
    u6 = u6 + buffer.len(p98);
    local v99 = 0;

    for _ in Holder._clientOwned[p97] or {} do
        v99 = v99 + 1;
    end;

    local v100 = u5 + v99 * 27;

    if v100 < u96[p97] then
        Warn.medium("Player", p97.Name, "exceeded max bytes per frame:", u96[p97], "max:", v100);

        return;
    end;

    debug.profilebegin("Receiver.OnReceive");
    local v101 = 0;
    local v102 = ClockUnwrap.unwrapFor(u4, p97, (buffer.readu32(p98, v101)));
    local v103 = v101 + 4;
    local os_clock_ret2 = os.clock();
    local buffer_len_ret = buffer.len(p98);
    ServerClock.Store(p97, v102);

    while v103 < buffer_len_ret do
        local v104, v105, v106, v107, v108 = DeserializeEntityPacket(p98, v103);
        local v109 = v106 - v103 - (v108 and 6 or 0);
        local buffer_create_ret = buffer.create(v109);
        buffer.copy(buffer_create_ret, 0, p98, v103, v109);

        if v108 then
            local buffer_readu8_ret = buffer.readu8(buffer_create_ret, 2);
            local bit32_band_ret = bit32.band(buffer_readu8_ret, 4294967279);
            buffer.writeu8(buffer_create_ret, 2, bit32_band_ret);
        end;

        HandleEntity(p97, v104, os_clock_ret2, v102, v105, buffer_create_ret, v107, v108);
        v103 = v106;
    end;

    debug.profileend();
end;

local function SortMiddleMans() -- Line: 369
    -- upvalues: u3 (ref), u2 (copy)
    u3 = {};

    for _, v in u2 do
        table.insert(u3, v);
    end;

    table.sort(u3, function(p110, p111) -- Line: 374
        return p110.priority > p111.priority;
    end);
end;

function v1.RegisterMiddleMan(p112: string, p113: number, p114: function) -- Line: 386
    -- upvalues: u2 (copy), SortMiddleMans (copy)
    u2[p112] = {
        priority = p113,
        func = p114
    };
    SortMiddleMans();
end;

function v1.UnregisterMiddleMan(p115: string) -- Line: 404
    -- upvalues: u2 (copy), SortMiddleMans (copy)
    u2[p115] = nil;
    SortMiddleMans();
end;

function v1.SetGuardConfig(p116: table) -- Line: 409
    -- upvalues: u7 (ref)
    u7 = p116;
end;

if RunService:IsServer() then
    local u117 = 0;
    RunService.Heartbeat:Connect(function() -- Line: 415
        -- upvalues: u96 (copy), os_clock_ret (ref), u8 (ref), u117 (ref), SERVER (copy), u6 (ref)
        table.clear(u96);
        local os_clock_ret2 = os.clock();

        if os_clock_ret2 - os_clock_ret > 0.1 then
            u8 = os_clock_ret2;
        end;

        os_clock_ret = os_clock_ret2;

        if os.clock() - u117 > 1 then
            SERVER.BYTES_RECEIVED_PER_SEC = u6;
            u6 = 0;
            u117 = os.clock();
        end;
    end);
    Replicate.OnServerEvent:Connect(OnReceive);
    SafeReplicate.OnServerEvent:Connect(OnReceive);
    Shared.Remotes.ClientHeartbeat.OnServerEvent:Connect(function(p118: userdata, p119: number) -- Line: 432
        -- upvalues: ClockUnwrap (copy), u4 (copy), ServerClock (copy)
        if type(p119) ~= "number" then
            return;
        end;

        local v120 = ClockUnwrap.seatFullFor(u4, p118, p119);
        ServerClock.Store(p118, v120);
    end);
    Players.PlayerRemoving:Connect(function(p121) -- Line: 440
        -- upvalues: u4 (copy)
        u4[p121] = nil;
    end);
end;

function v1._GetClientClockRaws() -- Line: 445
    -- upvalues: u4 (copy)
    local v122 = {};

    for i, v in u4 do
        if v.lastRaw then
            table.insert(v122, {
                player = i,
                raw = v.lastRaw,
                offset = v.offset
            });
        end;
    end;

    return v122;
end;

return v1;